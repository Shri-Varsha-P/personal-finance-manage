<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.finance.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>E-Commerce - Finance Store</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
        .shop-container { width: 85%; margin: auto; padding: 20px; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px; margin-top: 20px; }
        .product-card { border: 1px solid #ddd; border-radius: 8px; padding: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1); background-color: #fff; }
        .product-card h3 { color: #333; margin: 10px 0; }
        .product-card p { color: #666; font-size: 14px; min-height: 40px; }
        .price { font-size: 18px; font-weight: bold; color: #2c3e50; margin: 10px 0; }
        .btn-add-cart { background-color: #27ae60; color: white; border: none; padding: 10px 15px; border-radius: 5px; cursor: pointer; font-size: 14px; width: 100%; transition: 0.2s; }
        .btn-add-cart:hover { background-color: #219150; }
        .nav-links { margin-bottom: 20px; display: flex; gap: 15px; }
    </style>
</head>
<body>

    <div class="shop-container">
        <header>
            <h1 style="color:skyBlue;">Financial Tools  Books Store</h1>
            <div class="nav-links">
                <a href="index.html">← Back to Dash board</a>
            </div>
        </header>

        <main>
            <div class="product-grid">
                <% 

                    List<Product> products = (List<Product>) request.getAttribute("products");
                    if (products != null && !products.isEmpty()) {
                        for (Product p : products) {
                %>
                    <div class="product-card">
                        <h3><%= p.getName() %></h3>
                        <p><%= p.getDescription() %></p>
                        <div class="price">$<%= String.format("%.2f", p.getPrice()) %></div>
                        
                        <!-- Form submits to the doPost method of EcommerceServlet -->
                        <form action="shop" method="POST">
                            <input type="hidden" name="productId" value="<%= p.getId() %>">
                            <button type="submit" class="btn-add-cart">Add to Cart</button>
                        </form>
                    </div>
                <% 
                        }
                    } else { 
                %>
                    <div style="grid-column: 1/-1; text-align: center; padding: 40px;">
                        <p style="color: red; font-size: 18px;">No products found in the catalog view.</p>
                        <p>To load items from the database, make sure you access this page using the URL mapping: 
                           <strong style="color: #2980b9;">http://localhost:8085/Personal-Finance-Manager/shop</strong>
                        </p>
                    </div>
                <% } %>
            </div>
        </main>
    </div>

</body>
</html>
