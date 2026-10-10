package com.finance.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ActiveUserServlet")
public class ActiveUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static Set<String> activeUsers = Collections.synchronizedSet(new HashSet<>());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;

        if (username != null) {
            activeUsers.add(username);
        }

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><body>");
        out.println("<h2>Currently Logged-In Users:</h2>");
        out.println("<ul>");
        synchronized (activeUsers) {
            for (String user : activeUsers) {
                out.println("<li>" + user + "</li>");
            }
        }
        out.println("</ul>");
        out.println("</body></html>");
    }
}
