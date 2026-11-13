<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String error = (String) session.getAttribute("error");
    String success = (String) session.getAttribute("success");

    session.removeAttribute("error");
    session.removeAttribute("success");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login | Library Management System</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

</head>

<body class="auth-page">

<nav class="auth-navbar">

    <a href="<%= request.getContextPath() %>/index.jsp"
       class="brand-logo">

        <span class="brand-icon">
            📖
        </span>

        Library Management System

    </a>


    <a href="<%= request.getContextPath() %>/index.jsp"
       class="back-home">

        ← Back to Home

    </a>

</nav>


<div class="auth-wrapper">

    <div class="auth-card">

        <div class="auth-icon">
            📖
        </div>


        <h1>
            Welcome Back
        </h1>

        <p class="auth-subtitle">
            Login to your library account
        </p>


        <% if (error != null) { %>

            <div class="alert alert-danger">
                <%= error %>
            </div>

        <% } %>


        <% if (success != null) { %>

            <div class="alert alert-success">
                <%= success %>
            </div>

        <% } %>


        <form action="<%= request.getContextPath() %>/login"
              method="post">

            <div class="form-group-custom">

                <label for="email">
                    Email Address
                </label>

                <input type="email"
                       id="email"
                       name="email"
                       class="form-control"
                       placeholder="Enter your email"
                       autocomplete="email"
                       required>

            </div>


            <div class="form-group-custom">

                <label for="password">
                    Password
                </label>

                <input type="password"
                       id="password"
                       name="password"
                       class="form-control"
                       placeholder="Enter your password"
                       autocomplete="current-password"
                       required>

            </div>


            <button type="submit"
                    class="auth-submit">

                Login

            </button>

        </form>


        <div class="auth-divider">
            New to our library?
        </div>


        <a href="<%= request.getContextPath() %>/register.jsp"
           class="register-link">

            Create an Account

        </a>


        <div class="admin-login-link">

            <a href="<%= request.getContextPath() %>/admin-setup">

                Administrator Setup

            </a>

        </div>

    </div>

</div>


<footer class="simple-footer">

    © 2026 Library Management System

</footer>

</body>

</html>