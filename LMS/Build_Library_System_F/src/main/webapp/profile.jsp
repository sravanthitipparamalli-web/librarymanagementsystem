<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.library.models.User" %>

<%
    User loggedUser =
            (User) session.getAttribute("loggedUser");

    if (loggedUser == null) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );

        return;
    }
%>


<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        My Profile | Library Management
    </title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

</head>


<body class="profile-page">


    <jsp:include page="header.jsp" />


    <main class="profile-container">


        <div class="profile-page-heading">

            <span class="section-label">
                MY ACCOUNT
            </span>

            <h1>
                My Profile
            </h1>

            <p>
                View your Library Management System account details.
            </p>

        </div>


        <section class="profile-card">


            <div class="profile-card-top">


                <div class="large-profile-icon">
                    &#128100;
                </div>


                <div>

                    <h2>
                        <%= loggedUser.getFullName() %>
                    </h2>

                    <p>
                        <%= loggedUser.getEmail() %>
                    </p>

                </div>

            </div>


            <div class="profile-details">


                <div class="profile-detail">

                    <span>
                        FULL NAME
                    </span>

                    <strong>
                        <%= loggedUser.getFullName() %>
                    </strong>

                </div>


                <div class="profile-detail">

                    <span>
                        EMAIL ADDRESS
                    </span>

                    <strong>
                        <%= loggedUser.getEmail() %>
                    </strong>

                </div>


                <div class="profile-detail">

                    <span>
                        ACCOUNT TYPE
                    </span>

                    <strong>
                        <%= loggedUser.getRole() %>
                    </strong>

                </div>


                <div class="profile-detail">

                    <span>
                        ACCOUNT STATUS
                    </span>

                    <strong>
                        <%= loggedUser.getStatus() %>
                    </strong>

                </div>


            </div>


            <div class="profile-actions">


                <% if ("ADMIN".equalsIgnoreCase(loggedUser.getRole())) { %>

                    <a href="<%= request.getContextPath() %>/admin"
                       class="btn btn-primary">

                        ADMIN DASHBOARD

                    </a>

                <% } else { %>

                    <a href="<%= request.getContextPath() %>/user"
                       class="btn btn-primary">

                        MY DASHBOARD

                    </a>

                <% } %>


                <a href="<%= request.getContextPath() %>/logout"
                   class="btn btn-danger">

                    LOGOUT

                </a>


            </div>


        </section>


    </main>


    <jsp:include page="footer.jsp" />


    <script src="<%= request.getContextPath() %>/js/main.js"></script>

</body>

</html>