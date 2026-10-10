<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    Cookie[] cookies = request.getCookies();
    int visitCount = 0;
    Cookie countCookie = null;

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("visitCount")) {
                visitCount = Integer.parseInt(cookie.getValue());
                break;
            }
        }
    }

    visitCount++;
    Cookie newCookie = new Cookie("visitCount", String.valueOf(visitCount));
    newCookie.setMaxAge(60 * 60 * 24 * 365);
    response.addCookie(newCookie);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Visit Counter</title>
</head>
<body>
<h2>You have visited this page <%= visitCount %> times.</h2>
<a href="visitCounter.jsp">Refresh</a>
</body>
</html>
