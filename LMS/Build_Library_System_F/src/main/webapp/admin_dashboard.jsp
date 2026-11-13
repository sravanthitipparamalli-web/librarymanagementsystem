<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.library.models.Book" %>
<%@ page import="com.library.models.User" %>
<%@ page import="com.library.models.Transaction" %>

<%
    String fullName = (String) session.getAttribute("userName");

    if (fullName == null) {
        fullName = "Administrator";
    }

    String success = (String) session.getAttribute("success");
    String error = (String) session.getAttribute("error");

    session.removeAttribute("success");
    session.removeAttribute("error");

    Integer totalUsers =
            (Integer) request.getAttribute("totalUsers");

    Integer totalBooks =
            (Integer) request.getAttribute("totalBooks");

    Integer availableCopies =
            (Integer) request.getAttribute("availableCopies");

    Integer activeBorrows =
            (Integer) request.getAttribute("activeBorrows");

    Integer returnedBooks =
            (Integer) request.getAttribute("returnedBooks");

    List<Book> books =
            (List<Book>) request.getAttribute("books");

    List<User> users =
            (List<User>) request.getAttribute("users");

    List<Transaction> transactions =
            (List<Transaction>) request.getAttribute("transactions");

    if (totalUsers == null) {
        totalUsers = 0;
    }

    if (totalBooks == null) {
        totalBooks = 0;
    }

    if (availableCopies == null) {
        availableCopies = 0;
    }

    if (activeBorrows == null) {
        activeBorrows = 0;
    }

    if (returnedBooks == null) {
        returnedBooks = 0;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard - Library Management System</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

</head>

<body class="dashboard-page">

<header class="dashboard-header">

    <div class="dashboard-brand">

        <span class="dashboard-logo">
            &#128218;
        </span>

        Library Management System

    </div>

    <div class="dashboard-user">

        <span>
            Welcome,
            <strong><%= fullName %></strong>
        </span>

        <a href="<%= request.getContextPath() %>/logout"
           class="logout-button">

            Logout

        </a>

    </div>

</header>


<main class="admin-container">


    <!-- ALERTS -->

    <% if (success != null) { %>

        <div class="dashboard-alert success-message">

            &#10003; <%= success %>

        </div>

    <% } %>


    <% if (error != null) { %>

        <div class="dashboard-alert error-message">

            &#9888; <%= error %>

        </div>

    <% } %>


    <!-- STATISTICS -->

    <section class="stats-grid">


        <div class="stat-card">

            <span class="stat-title">
                Total Users
            </span>

            <strong>
                <%= totalUsers %>
            </strong>

        </div>


        <div class="stat-card">

            <span class="stat-title">
                Total Books
            </span>

            <strong>
                <%= totalBooks %>
            </strong>

        </div>


        <div class="stat-card">

            <span class="stat-title">
                Available Copies
            </span>

            <strong>
                <%= availableCopies %>
            </strong>

        </div>


        <div class="stat-card">

            <span class="stat-title">
                Active Borrows
            </span>

            <strong>
                <%= activeBorrows %>
            </strong>

        </div>


        <div class="stat-card">

            <span class="stat-title">
                Returned Books
            </span>

            <strong>
                <%= returnedBooks %>
            </strong>

        </div>

    </section>


    <!-- ADD BOOK -->

    <section class="admin-section">

        <div class="admin-section-title">

            <span>
                &#10133;
            </span>

            Add New Book

        </div>


        <form action="<%= request.getContextPath() %>/admin"
              method="post"
              class="add-book-form">

            <input type="hidden"
                   name="action"
                   value="addBook">


            <div class="admin-form-group">

                <label>
                    Book Title
                </label>

                <input type="text"
                       name="title"
                       maxlength="200"
                       required>

            </div>


            <div class="admin-form-group">

                <label>
                    Author
                </label>

                <input type="text"
                       name="author"
                       maxlength="150"
                       required>

            </div>


            <div class="admin-form-group">

                <label>
                    ISBN
                </label>

                <input type="text"
                       name="isbn"
                       maxlength="30">

            </div>


            <div class="admin-form-group">

                <label>
                    Total Copies
                </label>

                <input type="number"
                       name="totalCopies"
                       min="1"
                       required>

            </div>


            <div class="admin-form-button">

                <button type="submit"
                        class="admin-primary-button">

                    Add Book

                </button>

            </div>

        </form>

    </section>


    <!-- MANAGE BOOKS -->

    <section class="admin-section">

        <div class="admin-section-title">

            <span>
                &#128214;
            </span>

            Manage Books

        </div>


        <div class="table-wrapper">

            <table class="admin-table">

                <thead>

                    <tr>

                        <th>ID</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>ISBN</th>
                        <th>Total</th>
                        <th>Available</th>
                        <th>Actions</th>

                    </tr>

                </thead>


                <tbody>

                <% if (books != null && !books.isEmpty()) { %>

                    <% for (Book book : books) { %>

                        <tr>

                            <td>
                                <%= book.getBookId() %>
                            </td>


                            <td>

                                <strong>
                                    <%= book.getTitle() %>
                                </strong>

                            </td>


                            <td>
                                <%= book.getAuthor() %>
                            </td>


                            <td>

                                <%= book.getIsbn() == null
                                        ? "-"
                                        : book.getIsbn() %>

                            </td>


                            <td>
                                <%= book.getTotalCopies() %>
                            </td>


                            <td>

                                <span class="available-count">
                                    <%= book.getAvailableCopies() %>
                                </span>

                            </td>


                            <td class="action-cell">


                                <!-- EDIT -->

                                <details class="edit-details">

                                    <summary class="edit-button">
                                        Edit
                                    </summary>


                                    <div class="edit-panel">

                                        <form action="<%= request.getContextPath() %>/admin"
                                              method="post">

                                            <input type="hidden"
                                                   name="action"
                                                   value="updateBook">


                                            <input type="hidden"
                                                   name="bookId"
                                                   value="<%= book.getBookId() %>">


                                            <label>
                                                Title
                                            </label>

                                            <input type="text"
                                                   name="title"
                                                   value="<%= book.getTitle() %>"
                                                   required>


                                            <label>
                                                Author
                                            </label>

                                            <input type="text"
                                                   name="author"
                                                   value="<%= book.getAuthor() %>"
                                                   required>


                                            <label>
                                                ISBN
                                            </label>

                                            <input type="text"
                                                   name="isbn"
                                                   value="<%= book.getIsbn() == null
                                                           ? ""
                                                           : book.getIsbn() %>">


                                            <label>
                                                Total Copies
                                            </label>

                                            <input type="number"
                                                   name="totalCopies"
                                                   min="1"
                                                   value="<%= book.getTotalCopies() %>"
                                                   required>


                                            <input type="hidden"
                                                   name="availableCopies"
                                                   value="<%= book.getAvailableCopies() %>">


                                            <button type="submit"
                                                    class="save-button">

                                                Save Changes

                                            </button>

                                        </form>

                                    </div>

                                </details>


                                <!-- DELETE -->

                                <form action="<%= request.getContextPath() %>/admin"
                                      method="post"
                                      class="inline-form"
                                      onsubmit="return confirmDeleteBook();">

                                    <input type="hidden"
                                           name="action"
                                           value="deleteBook">


                                    <input type="hidden"
                                           name="bookId"
                                           value="<%= book.getBookId() %>">


                                    <button type="submit"
                                            class="delete-button">

                                        Delete

                                    </button>

                                </form>


                            </td>

                        </tr>

                    <% } %>

                <% } else { %>

                    <tr>

                        <td colspan="7"
                            class="empty-table">

                            No books available.

                        </td>

                    </tr>

                <% } %>

                </tbody>

            </table>

        </div>

    </section>


    <!-- MANAGE USERS -->

    <section class="admin-section">

        <div class="admin-section-title">

            <span>
                &#128101;
            </span>

            Manage Users

        </div>


        <div class="table-wrapper">

            <table class="admin-table">

                <thead>

                    <tr>

                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Action</th>

                    </tr>

                </thead>


                <tbody>

                <% if (users != null && !users.isEmpty()) { %>

                    <% for (User user : users) { %>

                        <tr>

                            <td>
                                <%= user.getUserId() %>
                            </td>


                            <td>
                                <%= user.getFullName() %>
                            </td>


                            <td>
                                <%= user.getEmail() %>
                            </td>


                            <td>

                                <% if ("ADMIN".equalsIgnoreCase(
                                        user.getRole())) { %>

                                    <span class="role-badge admin-role">
                                        ADMIN
                                    </span>

                                <% } else { %>

                                    <span class="role-badge user-role">
                                        USER
                                    </span>

                                <% } %>

                            </td>


                            <td>

                                <% if ("ACTIVE".equalsIgnoreCase(
                                        user.getStatus())) { %>

                                    <span class="status-badge active-status">
                                        ACTIVE
                                    </span>

                                <% } else { %>

                                    <span class="status-badge blocked-status">
                                        BLOCKED
                                    </span>

                                <% } %>

                            </td>


                            <td>

                                <% if ("USER".equalsIgnoreCase(
                                        user.getRole())) { %>


                                    <% if ("ACTIVE".equalsIgnoreCase(
                                            user.getStatus())) { %>

                                        <form action="<%= request.getContextPath() %>/admin"
                                              method="post"
                                              class="inline-form">

                                            <input type="hidden"
                                                   name="action"
                                                   value="blockUser">

                                            <input type="hidden"
                                                   name="userId"
                                                   value="<%= user.getUserId() %>">

                                            <button type="submit"
                                                    class="block-button">

                                                Block

                                            </button>

                                        </form>

                                    <% } else { %>

                                        <form action="<%= request.getContextPath() %>/admin"
                                              method="post"
                                              class="inline-form">

                                            <input type="hidden"
                                                   name="action"
                                                   value="activateUser">

                                            <input type="hidden"
                                                   name="userId"
                                                   value="<%= user.getUserId() %>">

                                            <button type="submit"
                                                    class="activate-button">

                                                Activate

                                            </button>

                                        </form>

                                    <% } %>


                                <% } else { %>

                                    <span class="protected-text">
                                        Protected
                                    </span>

                                <% } %>

                            </td>

                        </tr>

                    <% } %>

                <% } else { %>

                    <tr>

                        <td colspan="6"
                            class="empty-table">

                            No users available.

                        </td>

                    </tr>

                <% } %>

                </tbody>

            </table>

        </div>

    </section>


    <!-- TRANSACTION HISTORY -->

    <section class="admin-section">

        <div class="admin-section-title">

            <span>
                &#128203;
            </span>

            Borrowing History

        </div>


        <div class="table-wrapper">

            <table class="admin-table transaction-table">

                <thead>

                    <tr>

                        <th>ID</th>
                        <th>User</th>
                        <th>Book</th>
                        <th>Borrow Date</th>
                        <th>Due Date</th>
                        <th>Return Date</th>
                        <th>Fine</th>
                        <th>Status</th>

                    </tr>

                </thead>


                <tbody>

                <% if (transactions != null && !transactions.isEmpty()) { %>

                    <% for (Transaction transaction : transactions) { %>

                        <tr>

                            <td>
                                <%= transaction.getTransactionId() %>
                            </td>


                            <td>

                                <strong>
                                    <%= transaction.getUserName() %>
                                </strong>

                            </td>


                            <td>
                                <%= transaction.getBookTitle() %>
                            </td>


                            <td>
                                <%= transaction.getBorrowDate() %>
                            </td>


                            <td>
                                <%= transaction.getDueDate() %>
                            </td>


                            <td>

                                <%= transaction.getReturnDate() == null
                                        ? "-"
                                        : transaction.getReturnDate() %>

                            </td>


                            <td>

                                ₹<%= String.format(
                                        "%.2f",
                                        transaction.getLateFee()) %>

                            </td>


                            <td>

                                <% if ("BORROWED".equalsIgnoreCase(
                                        transaction.getStatus())) { %>

                                    <span class="status-badge borrowed">
                                        BORROWED
                                    </span>

                                <% } else { %>

                                    <span class="status-badge returned">
                                        RETURNED
                                    </span>

                                <% } %>

                            </td>

                        </tr>

                    <% } %>

                <% } else { %>

                    <tr>

                        <td colspan="8"
                            class="empty-table">

                            No borrowing history available.

                        </td>

                    </tr>

                <% } %>

                </tbody>

            </table>

        </div>

    </section>


</main>


<footer class="dashboard-footer">

    © 2026 Library Management System.
    All rights reserved.

</footer>


<script src="<%= request.getContextPath() %>/js/main.js"></script>

</body>

</html>