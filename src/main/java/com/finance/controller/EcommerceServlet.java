package com.finance.controller;

import com.finance.model.Product;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/shop")
public class EcommerceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Database Connection Parameters
    private String dbURL = "jdbc:mysql://localhost:3307/personal_finance";
    private String dbUser = "root";
    private String dbPass = "Varsha1@"; 

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Product> productList = new ArrayList<>();
        
        try {
            // Load the MySQL Database Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM products")) {
                
                while (rs.next()) {
                    Product product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url")
                    );
                    productList.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Send the database results over to the JSP view layer
        request.setAttribute("products", productList);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String productId = request.getParameter("productId");
        
        if (productId != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
                    String sql = "INSERT INTO cart (product_id, quantity) VALUES (?, 1)";
                    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                        pstmt.setInt(1, Integer.parseInt(productId));
                        pstmt.executeUpdate();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        // Reload the shop catalog after adding an item to the database cart
        response.sendRedirect("shop");
    }
}
