<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<footer class="site-footer">

    <div class="footer-container">

        <div class="footer-brand">

            <div class="footer-logo">
                &#128218; Library Management
            </div>

            <p>
                Knowledge &bull; Learning &bull; Growth
            </p>

        </div>


        <div class="footer-links">

            <a href="<%= request.getContextPath() %>/index.jsp">
                Home
            </a>

            <a href="<%= request.getContextPath() %>/about.jsp">
                About Us
            </a>

            <a href="<%= request.getContextPath() %>/books.jsp">
                Books
            </a>

            <a href="<%= request.getContextPath() %>/login.jsp">
                Login
            </a>

        </div>

    </div>


    <div class="footer-bottom">

        <p>
            &copy; 2026 Library Management System.
            All Rights Reserved.
        </p>

    </div>

</footer>