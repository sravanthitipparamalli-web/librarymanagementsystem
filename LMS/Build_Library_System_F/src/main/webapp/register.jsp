<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String error = request.getParameter("error");
    String message = request.getParameter("message");

    String sessionError =
            (String) session.getAttribute("error");

    String sessionSuccess =
            (String) session.getAttribute("success");

    session.removeAttribute("error");
    session.removeAttribute("success");


    if (error == null) {
        error = sessionError;
    }

    if (message == null) {
        message = sessionSuccess;
    }
%>


<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Create Account | Library Management System
    </title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

</head>


<body class="auth-page">


    <nav class="auth-navbar">


        <a href="<%= request.getContextPath() %>/index.jsp"
           class="brand-logo">

            <span class="brand-icon">
                &#128218;
            </span>

            Library Management System

        </a>


        <a href="<%= request.getContextPath() %>/login.jsp"
           class="back-home">

            &larr; Back to Login

        </a>


    </nav>


    <div class="auth-wrapper">


        <div class="auth-card">


            <div class="auth-icon">
                &#128100;
            </div>


            <h1>
                Create Your Account
            </h1>


            <p class="auth-subtitle">
                Join our library community
            </p>


            <% if (error != null && !error.trim().isEmpty()) { %>

                <div class="alert alert-danger">
                    <%= error %>
                </div>

            <% } %>


            <% if (message != null && !message.trim().isEmpty()) { %>

                <div class="alert alert-success">
                    <%= message %>
                </div>

            <% } %>


            <form action="<%= request.getContextPath() %>/register"
                  method="post"
                  onsubmit="return validateRegistration();">


                <div class="form-group-custom">

                    <label for="fullName">
                        Full Name
                    </label>

                    <input type="text"
                           id="fullName"
                           name="fullName"
                           class="form-control"
                           placeholder="Enter your full name"
                           maxlength="100"
                           autocomplete="name"
                           required>

                </div>


                <div class="form-group-custom">

                    <label for="email">
                        Email Address
                    </label>

                    <input type="email"
                           id="email"
                           name="email"
                           class="form-control"
                           placeholder="Enter your email"
                           maxlength="150"
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
                           placeholder="Minimum 6 characters"
                           minlength="6"
                           autocomplete="new-password"
                           required>

                </div>


                <div class="form-group-custom">

                    <label for="confirmPassword">
                        Confirm Password
                    </label>

                    <input type="password"
                           id="confirmPassword"
                           name="confirmPassword"
                           class="form-control"
                           placeholder="Re-enter your password"
                           minlength="6"
                           autocomplete="new-password"
                           required>

                </div>


                <button type="submit"
                        class="auth-submit">

                    Create Account

                </button>


            </form>


            <div class="auth-divider">
                Already have an account?
            </div>


            <a href="<%= request.getContextPath() %>/login.jsp"
               class="register-link">

                Login to Your Account

            </a>


            <div class="admin-login-link">

                <a href="<%= request.getContextPath() %>/index.jsp">

                    &larr; Return to Home

                </a>

            </div>


        </div>

    </div>


    <footer class="simple-footer">

        &copy; 2026 Library Management System

    </footer>


    <script src="<%= request.getContextPath() %>/js/main.js"></script>

</body>

</html>