<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*" %>
<%
    session = request.getSession(false);
    String name = (session != null && session.getAttribute("name") != null) ? (String) session.getAttribute("name") : "N/A";
    String email = (session != null && session.getAttribute("email") != null) ? (String) session.getAttribute("email") : "N/A";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirmation</title>
</head>
<body>
    <h2>Registration Details</h2>
    <p><strong>Name:</strong> <%= name %></p>
    <p><strong>Email:</strong> <%= email %></p>
    
    <br><hr><br>
    <a href="CookieDeleteServlet">Clear Registration Data (Delete Cookies)</a>
    <br><br>
    <a href="index.html">Back to Home</a>
</body>
</html>
