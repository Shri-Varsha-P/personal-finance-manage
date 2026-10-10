package com.finance.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CookieDeleteServlet")
public class CookieDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] cookieNames = {"name", "email", "password", "regNumber", "visitCount"};
        
        if (request.getCookies() != null) {
            for (String cookieName : cookieNames) {
                Cookie cookie = new Cookie(cookieName, "");
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
            }
        }
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<script>");
        out.println("localStorage.clear();");
        out.println("alert('All cookies and local storage cleared.');");
        out.println("window.location.href='index.html';");
        out.println("<script>");
        out.println("</body></html>");
    }
}
