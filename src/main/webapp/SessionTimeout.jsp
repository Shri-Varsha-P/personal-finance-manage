<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FinSmart - Session Tracking</title>
    <link rel="stylesheet" href="style.css">
    <script>
        let timeout;

        function resetTimer() {
            clearTimeout(timeout);
            timeout = setTimeout(showTimeoutMessage, 120000); 
        }

        function showTimeoutMessage() {
            alert("Session Timeout: You have been inactive for over 2 minutes! Redirecting...");
            window.location.href = "index.html"; 
        }

        window.onload = resetTimer;
        window.onmousemove = resetTimer;
        window.onmousedown = resetTimer; 
        window.onclick = resetTimer;     
        window.onkeypress = resetTimer;  
    </script>
</head>
<body>
    <header>
        <h1>Session Monitor Panel</h1>
    </header>
    <main>
        <div class="content-box">
            <h2 style="color: skyblue;">Inactivity Tracker Active</h2>
            <p>Your session will automatically expire if you remain completely idle on this page for 2 minutes.</p>
            <p style="color: lightgray; font-size: 0.9em;">Move your mouse or type to keep the session alive.</p>
            <br>
            <a href="index.html" class="btn">Return Home</a>
        </div>
    </main>
</body>
</html>
