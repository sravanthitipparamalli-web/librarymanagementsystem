
<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.library.models.Book" %>
<%@ page import="com.library.models.Transaction" %>

<%
    // Retrieve the logged-in user's actual name
    String fullName = (String) session.getAttribute("userName");

    if (fullName == null || fullName.trim().isEmpty()) {
        fullName = "User";
    }

    String success = (String) session.getAttribute("success");
    String error = (String) session.getAttribute("error");

    session.removeAttribute("success");
    session.removeAttribute("error");

    List<Book> books =
        (List<Book>) request.getAttribute("books");

    List<Transaction> transactions =
        (List<Transaction>) request.getAttribute("transactions");

    String search =
        (String) request.getAttribute("search");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>User Dashboard - Library Management System</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">
</head>

<body class="dashboard-page">

<header class="dashboard-header">

    <div class="dashboard-brand">
        <span class="dashboard-logo">📚</span>
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


<main class="dashboard-container">


    <!-- SUCCESS MESSAGE -->

    <% if (success != null) { %>

        <div class="dashboard-alert success-message">
            ✓ <%= success %>
        </div>

    <% } %>


    <!-- ERROR MESSAGE -->

    <% if (error != null) { %>

        <div class="dashboard-alert error-message">
            ⚠ <%= error %>
        </div>

    <% } %>


    <!-- WELCOME SECTION -->

    <section class="welcome-panel">

        <div>

            <h1>Welcome to the Library</h1>

            <p>
                Browse books, borrow them and manage your returns.
            </p>

        </div>

    </section>


    <!-- SEARCH SECTION -->

    <section class="search-panel">

        <form action="<%= request.getContextPath() %>/user"
              method="get"
              class="search-form">

            <input type="text"
                   name="search"
                   value="<%= search == null ? "" : search %>"
                   placeholder="Search by title, author or ISBN...">

            <button type="submit">
                Search
            </button>


            <% if (search != null && !search.trim().isEmpty()) { %>

                <a href="<%= request.getContextPath() %>/user"
                   class="clear-search">

                    Clear

                </a>

            <% } %>

        </form>

    </section>


    <!-- AVAILABLE BOOKS -->

    <section class="dashboard-section">

        <div class="section-title">

            <span>📖</span>

            Available Books

        </div>


        <div class="book-grid">


            <% if (books != null && !books.isEmpty()) { %>


                <% for (Book book : books) { %>


                    <div class="book-card">


                        <div class="book-icon">
                            📖
                        </div>


                        <h2>
                            <%= book.getTitle() %>
                        </h2>


                        <p>

                            Author:

                            <strong>
                                <%= book.getAuthor() %>
                            </strong>

                        </p>


                        <p>

                            ISBN:

                            <%= book.getIsbn() == null
                                ? "N/A"
                                : book.getIsbn() %>

                        </p>


                        <div class="availability-badge">

                            <%= book.getAvailableCopies() %>
                            available

                        </div>


                        <div class="book-card-footer">


                            <% if (book.getAvailableCopies() > 0) { %>


                                <form action="<%= request.getContextPath() %>/user"
                                      method="post">


                                    <input type="hidden"
                                           name="action"
                                           value="borrow">


                                    <input type="hidden"
                                           name="bookId"
                                           value="<%= book.getBookId() %>">


                                    <button type="submit"
                                            class="borrow-button">

                                        Borrow Book

                                    </button>


                                </form>


                            <% } else { %>


                                <button class="disabled-button"
                                        disabled>

                                    Currently Unavailable

                                </button>


                            <% } %>


                        </div>

                    </div>


                <% } %>


            <% } else { %>


                <div class="empty-state">


                    <div class="empty-icon">
                        📚
                    </div>


                    <h3>
                        No books found
                    </h3>


                    <p>
                        Try another search term.
                    </p>


                </div>


            <% } %>


        </div>

    </section>


    <!-- BORROWING HISTORY -->

    <section class="dashboard-section">


        <div class="section-title">

            <span>📋</span>

            My Borrowing History

        </div>


        <% if (transactions != null && !transactions.isEmpty()) { %>


            <div class="table-wrapper">


                <table class="data-table">


                    <thead>

                        <tr>

                            <th>
                                Book
                            </th>

                            <th>
                                Borrowed
                            </th>

                            <th>
                                Due Date
                            </th>

                            <th>
                                Returned
                            </th>

                            <th>
                                Fine
                            </th>

                            <th>
                                Status
                            </th>

                            <th>
                                Action
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                    <% for (Transaction transaction : transactions) { %>


                        <tr>


                            <td>

                                <strong>
                                    <%= transaction.getBookTitle() %>
                                </strong>

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
                                    transaction.getLateFee()
                                ) %>

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


                            <td>


                                <% if ("BORROWED".equalsIgnoreCase(
                                        transaction.getStatus())) { %>


                                    <form action="<%= request.getContextPath() %>/user"
                                          method="post"
                                          onsubmit="return confirmReturn();">


                                        <input type="hidden"
                                               name="action"
                                               value="return">


                                        <input type="hidden"
                                               name="transactionId"
                                               value="<%= transaction.getTransactionId() %>">


                                        <button type="submit"
                                                class="return-button">

                                            Return

                                        </button>


                                    </form>


                                <% } else { %>


                                    <span class="completed-text">

                                        Completed

                                    </span>


                                <% } %>


                            </td>


                        </tr>


                    <% } %>


                    </tbody>


                </table>


            </div>


        <% } else { %>


            <div class="empty-history">


                <div class="empty-icon">
                    📋
                </div>


                <h3>
                    No borrowing history
                </h3>


                <p>
                    Books you borrow will appear here.
                </p>


            </div>


        <% } %>


    </section>


    <!-- LIBRARY GUIDELINES -->

    <section class="guidelines-section">


        <div class="section-title">

            <span>📚</span>

            Library Guidelines

        </div>


        <div class="guideline-grid">


            <div class="guideline-card">

                <span class="guideline-number">
                    01
                </span>

                <h3>
                    Borrow Available Books
                </h3>

                <p>
                    You can borrow books whenever copies are
                    available in the library collection.
                </p>

            </div>


            <div class="guideline-card">

                <span class="guideline-number">
                    02
                </span>

                <h3>
                    14-Day Period
                </h3>

                <p>
                    Every borrowed book must be returned
                    within fourteen days.
                </p>

            </div>


            <div class="guideline-card">

                <span class="guideline-number">
                    03
                </span>

                <h3>
                    Late Return Fine
                </h3>

                <p>
                    A fine of ₹1 per day is applied
                    when a book is returned late.
                </p>

            </div>


            <div class="guideline-card">

                <span class="guideline-number">
                    04
                </span>

                <h3>
                    Return Books
                </h3>

                <p>
                    Return borrowed books on time so
                    other users can access them.
                </p>

            </div>


        </div>

    </section>


</main>


<!-- FOOTER -->

<footer class="dashboard-footer">

    © 2026 Library Management System.
    All rights reserved.

</footer>


<script src="<%= request.getContextPath() %>/js/main.js"></script>


</body>

</html>
