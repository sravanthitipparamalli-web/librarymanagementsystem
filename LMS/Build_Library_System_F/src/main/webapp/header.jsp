
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String contextPath = request.getContextPath();

    Object loggedUserObject = session.getAttribute("loggedUser");
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("role");

    boolean loggedIn = loggedUserObject != null;

    if (userName == null || userName.trim().isEmpty()) {
        userName = "User";
    }

    if (userRole == null || userRole.trim().isEmpty()) {
        userRole = "USER";
    }
%>

<header class="main-header">
    <div class="header-container">

        <a href="<%= contextPath %>/index.jsp" class="site-logo">
            <span class="logo-icon">&#128218;</span>

            <span class="logo-text">
                <strong>Library Management</strong>
                <small>KNOWLEDGE &bull; LEARNING &bull; GROWTH</small>
            </span>
        </a>

        <nav class="main-nav">
            <a href="<%= contextPath %>/index.jsp" class="nav-box">HOME</a>
            <a href="<%= contextPath %>/about.jsp" class="nav-box">ABOUT US</a>
            <a href="<%= contextPath %>/books.jsp" class="nav-box">BOOKS</a>
        </nav>

        <div class="header-actions">

            <% if (!loggedIn) { %>

                <a href="<%= contextPath %>/login.jsp"
                   class="nav-box login-nav">LOGIN</a>

                <a href="<%= contextPath %>/register.jsp"
                   class="nav-box signup-nav">SIGN UP</a>

            <% } else { %>

                <div class="profile-menu">

                    <button type="button"
                            class="profile-button"
                            aria-haspopup="true"
                            aria-expanded="false">

                        <span class="profile-icon">&#128100;</span>
                        <span class="profile-label">ACCOUNT</span>
                        <span class="profile-arrow">&#9662;</span>
                    </button>

                    <div class="profile-dropdown">

                        <div class="dropdown-heading">MY ACCOUNT</div>

                        <div class="dropdown-user">
                            <div class="dropdown-avatar">&#128100;</div>

                            <div>
                                <strong><%= userName %></strong>
                                <small><%= userRole %></small>
                            </div>
                        </div>

                        <div class="dropdown-divider"></div>

                        <% if ("ADMIN".equalsIgnoreCase(userRole)) { %>
                            <a href="<%= contextPath %>/admin">
                                Dashboard
                            </a>
                        <% } else { %>
                            <a href="<%= contextPath %>/user">
                                My Dashboard
                            </a>
                        <% } %>

                        <a href="<%= contextPath %>/profile.jsp">
                            My Profile
                        </a>

                        <div class="dropdown-divider"></div>

                        <a href="<%= contextPath %>/logout"
                           class="logout-link">
                            Logout
                        </a>

                    </div>
                </div>

            <% } %>

        </div>
    </div>
</header>
