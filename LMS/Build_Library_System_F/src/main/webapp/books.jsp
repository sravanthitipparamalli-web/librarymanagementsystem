
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.library.dao.BookDAO" %>
<%@ page import="com.library.models.Book" %>

<%
    String search = request.getParameter("search");
    List<Book> books;

    BookDAO bookDAO = new BookDAO();

    try {
        if (search != null && !search.trim().isEmpty()) {
            books = bookDAO.searchBooks(search.trim());
        } else {
            books = bookDAO.getAllBooks();
        }
    } catch (Exception e) {
        books = new java.util.ArrayList<Book>();
        application.log("Error loading books", e);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Books | Library Management</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

<jsp:include page="header.jsp" />

<main class="books-page">

    <!-- BOOKS HERO -->
    <section class="books-hero">
        <div class="books-hero-content">
            <span class="section-label">OUR COLLECTION</span>

            <h1>Discover Your Next Great Book</h1>

            <p>
                Explore our collection of books and find something new
                to learn, read and enjoy.
            </p>
        </div>
    </section>

    <!-- INTRODUCTION -->
    <section class="books-intro">
        <div class="books-intro-content">

            <span class="section-label">WHY CHOOSE OUR LIBRARY?</span>

            <h2>More Than Just A Collection of Books</h2>

            <p>
                Whether you want to strengthen your programming skills,
                understand databases or simply explore a new subject,
                our collection helps you keep learning.
            </p>

        </div>

        <div class="books-benefits">

            <div class="book-benefit">
                <span class="benefit-icon">&#128218;</span>
                <h3>Learning Focused</h3>
                <p>
                    Find books that support your academic and technical learning.
                </p>
            </div>

            <div class="book-benefit">
                <span class="benefit-icon">&#128161;</span>
                <h3>Build Your Skills</h3>
                <p>
                    Explore programming, databases and other technology-related resources.
                </p>
            </div>

            <div class="book-benefit">
                <span class="benefit-icon">&#127793;</span>
                <h3>Keep Growing</h3>
                <p>
                    Reading regularly helps you develop knowledge and discover new ideas.
                </p>
            </div>

        </div>
    </section>

    <!-- BOOK COLLECTION -->
    <section class="book-library-section">

        <div class="library-section-heading">
            <div>
                <span class="section-label">LIBRARY COLLECTION</span>
                <h2>Available Books</h2>
                <p>Find a book that matches your interests.</p>
            </div>
        </div>

        <!-- SEARCH -->
        <form action="<%= request.getContextPath() %>/books.jsp"
              method="get"
              class="books-search-form">

            <input type="text"
                   name="search"
                   placeholder="Search by title, author or ISBN..."
                   value="<%= search == null ? "" : search %>">

            <button type="submit">Search</button>

            <% if (search != null && !search.trim().isEmpty()) { %>
                <a href="<%= request.getContextPath() %>/books.jsp"
                   class="clear-search">Clear</a>
            <% } %>

        </form>

        <div class="books-results">
            <% if (books == null || books.isEmpty()) { %>

                <div class="no-books-message">
                    <span>&#128269;</span>
                    <h3>No Books Found</h3>
                    <p>
                        We couldn't find any books matching your search.
                        Try another title, author or ISBN.
                    </p>
                </div>

            <% } else { %>

                <div class="books-grid">

                    <% for (Book book : books) { %>

                        <article class="collection-book-card">

                            <div class="book-cover">
                                <span class="book-cover-icon">&#128214;</span>
                                <span class="book-cover-caption">
                                    LIBRARY BOOK
                                </span>
                            </div>

                            <div class="book-card-content">

                                <h3><%= book.getTitle() %></h3>

                                <p class="book-author">
                                    By <%= book.getAuthor() %>
                                </p>

                                <div class="book-isbn">
                                    <span>ISBN:</span>
                                    <%= book.getIsbn() %>
                                </div>

                                <div class="book-availability">
                                    <% if (book.getAvailableCopies() > 0) { %>
                                        <span class="availability-available">
                                            &#10003; Available
                                        </span>
                                    <% } else { %>
                                        <span class="availability-unavailable">
                                            Currently Unavailable
                                        </span>
                                    <% } %>
                                </div>

                                <div class="book-copy-count">
                                    Available copies:
                                    <strong><%= book.getAvailableCopies() %></strong>
                                </div>

                            </div>

                        </article>

                    <% } %>

                </div>

            <% } %>
        </div>

    </section>

    <!-- BOTTOM MESSAGE -->
    <section class="books-cta">
        <h2>Every Book Opens a New Possibility</h2>
        <p>
            Keep exploring, keep learning and make every reading
            experience meaningful.
        </p>
    </section>

</main>

<jsp:include page="footer.jsp" />

<script src="<%= request.getContextPath() %>/js/main.js"></script>

</body>
</html>
