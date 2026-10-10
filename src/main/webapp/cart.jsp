<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Shopping Cart</title>
    <style>
        .cart-container { width: 70%; margin: auto; padding: 20px; font-family: Arial, sans-serif; color: white;}
        .cart-table { width: 100%; border-collapse: collapse; margin-top: 20px; background: white; color: #333; border-radius: 8px; overflow: hidden; }
        .cart-table th, .cart-table td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        .cart-table th { background-color: #2c3e50; color: white; }
        .total-price { font-size: 20px; font-weight: bold; text-align: right; margin-top: 20px; }
        .btn-checkout { background-color: #e67e22; color: white; border: none; padding: 12px 20px; border-radius: 5px; cursor: pointer; float: right; font-size: 16px; margin-top: 10px; }
    </style>
</head>
<body style="background-color: blue;">

    <div class="cart-container">
        <h2>Your Shopping Cart</h2>
        <a href="shop" style="color: skyblue; font-weight: bold;">← Back to Store</a>

        <table class="cart-table">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <%
                    double grandTotal = 0;
                    String dbURL = "jdbc:mysql://localhost:3306/personal_finance";
                    String dbUser = "root";
                    String dbPass = "root"; // Using your database password

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery(
                                 "SELECT p.name, p.price, c.quantity FROM cart c JOIN products p ON c.product_id = p.id")) {
                            
                            while (rs.next()) {
                                String name = rs.getString("name");
                                double price = rs.getDouble("price");
                                int quantity = rs.getInt("quantity");
                                double subtotal = price * quantity;
                                grandTotal += subtotal;
                %>
                <tr>
                    <td><%= name %></td>
                    <td>$<%= String.format("%.2f", price) %></td>
                    <td><%= quantity %></td>
                    <td>$<%= String.format("%.2f", subtotal) %></td>
                </tr>
                <%
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>

        <div class="total-price">
            Total Amount: $<%= String.format("%.2f", grandTotal) %>
        </div>
        
        <!-- Form to process checkout action and clear data rows -->
        <form action="checkout" method="POST">
            <button type="submit" class="btn-checkout">
                Confirm  Checkout
            </button>
        </form>

        <!-- Dynamic checkout alert notification panel -->
        <%
            String message = (String) session.getAttribute("message");
            if(message != null) {
        %>
            <div style="clear: both; color: #2ecc71; font-weight: bold; padding-top: 15px; text-align: right; font-size: 18px;">
                <%= message %>
            </div>
        <% 
                session.removeAttribute("message");
            }
        %>
    </div>

</body>
</html>
