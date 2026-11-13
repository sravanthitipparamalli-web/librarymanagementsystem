
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>About Us | Library Management</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

<jsp:include page="header.jsp" />

<main class="about-page">

    <!-- ABOUT HERO -->
    <section class="about-hero">

        <div class="about-hero-content">

            <span class="section-label">GET TO KNOW US</span>

            <h1>
                Bringing knowledge<br>
                closer to everyone.
            </h1>

            <p>
                A simple and organized digital library experience that
                connects readers with knowledge and makes everyday
                library activities easier.
            </p>

            <a href="#our-story" class="about-hero-link">
                Discover Our Story &#8595;
            </a>

        </div>

        <div class="about-hero-visual">

            <div class="about-visual-card">
                <span class="about-visual-icon">&#128218;</span>

                <h3>Knowledge &bull; Learning &bull; Growth</h3>

                <p>A DIGITAL SPACE FOR READERS</p>

                <div class="about-visual-line"></div>

                <strong>Read more. Discover more.</strong>

                <small>Every page is an opportunity to learn.</small>
            </div>

        </div>

    </section>

    <!-- WHO WE ARE -->
    <section class="about-story" id="our-story">

        <div class="about-story-heading">
            <span class="section-label">WHO WE ARE</span>

            <h2>A smarter way to manage a library.</h2>
        </div>

        <div class="about-story-content">

            <p>
                The Library Management System is a web-based application
                developed to simplify the management of books, users
                and library transactions.
            </p>

            <p>
                It provides administrators with a centralized way to
                manage the book collection and registered users, while
                allowing readers to browse books and manage their
                borrowing and return activities.
            </p>

            <p>
                By bringing these activities together in one application,
                the system helps make library operations more organized
                and convenient.
            </p>

        </div>

    </section>

    <!-- PURPOSE, MISSION AND VISION -->
    <section class="about-purpose">

        <div class="about-section-heading">
            <span class="section-label">WHAT DRIVES US</span>
            <h2>Our Purpose</h2>

            <p>
                Making library management easier while encouraging
                a culture of reading and continuous learning.
            </p>
        </div>

        <div class="about-purpose-grid">

            <article class="purpose-card">
                <span class="purpose-number">01</span>
                <span class="purpose-icon">&#127919;</span>

                <h3>Our Mission</h3>

                <p>
                    To provide an organized digital platform for managing
                    books, users and borrowing activities efficiently.
                </p>
            </article>

            <article class="purpose-card">
                <span class="purpose-number">02</span>
                <span class="purpose-icon">&#128065;</span>

                <h3>Our Vision</h3>

                <p>
                    To make library resources easier to access and create
                    a convenient reading and learning experience.
                </p>
            </article>

            <article class="purpose-card">
                <span class="purpose-number">03</span>
                <span class="purpose-icon">&#128161;</span>

                <h3>Our Values</h3>

                <p>
                    Simplicity, organization, accessibility and continuous
                    learning guide the experience we aim to provide.
                </p>
            </article>

        </div>

    </section>

    <!-- HOW IT WORKS -->
    <section class="about-process">

        <div class="about-section-heading">
            <span class="section-label">SIMPLE AND ORGANIZED</span>

            <h2>How Our Library Works</h2>

            <p>
                A straightforward process that connects readers
                with the library collection.
            </p>
        </div>

        <div class="process-grid">

            <article class="process-card">
                <span class="process-icon">&#128100;</span>
                <span class="process-step">STEP 01</span>

                <h3>Create an Account</h3>

                <p>
                    Register and access your personal library account.
                </p>
            </article>

            <article class="process-card">
                <span class="process-icon">&#128269;</span>
                <span class="process-step">STEP 02</span>

                <h3>Explore Books</h3>

                <p>
                    Browse the available collection and search for books.
                </p>
            </article>

            <article class="process-card">
                <span class="process-icon">&#128213;</span>
                <span class="process-step">STEP 03</span>

                <h3>Borrow Books</h3>

                <p>
                    Borrow available books and keep track of your transactions.
                </p>
            </article>

            <article class="process-card">
                <span class="process-icon">&#128260;</span>
                <span class="process-step">STEP 04</span>

                <h3>Return Books</h3>

                <p>
                    Return borrowed books and keep your borrowing history organized.
                </p>
            </article>

        </div>

    </section>

    <!-- TECHNOLOGY -->
    <section class="about-technology">

        <div class="about-technology-content">

            <span class="section-label">POWERED BY TECHNOLOGY</span>

            <h2>Technology Behind the System</h2>

            <p>
                Our Library Management System brings together web
                technologies and database connectivity to provide
                an organized library experience.
            </p>

        </div>

        <div class="technology-list">

            <span>HTML</span>
            <span>CSS</span>
            <span>JavaScript</span>
            <span>Java</span>
            <span>JDBC</span>
            <span>Servlets</span>
            <span>JSP</span>
            <span>Oracle Database</span>

        </div>

    </section>

    <!-- FINAL CTA -->
    <section class="about-bottom-cta">

        <h2>Discover the joy of learning.</h2>

        <p>
            Explore our library collection and find your next book.
        </p>

        <a href="<%= request.getContextPath() %>/books.jsp"
           class="about-cta-button">
            Explore Books
        </a>

    </section>

</main>

<jsp:include page="footer.jsp" />

<script src="<%= request.getContextPath() %>/js/main.js"></script>

</body>
</html>
