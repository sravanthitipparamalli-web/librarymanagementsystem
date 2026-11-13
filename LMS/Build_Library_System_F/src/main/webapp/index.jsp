<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Library Management System</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: "Segoe UI", Arial, sans-serif;
            color: #222;
            background: #f7f8fc;
        }

        /* =========================
           NAVBAR
        ========================= */

        .navbar {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 78px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 7%;

            z-index: 10;

            background: rgba(0, 0, 0, 0.20);
            backdrop-filter: blur(8px);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;

            color: white;
            text-decoration: none;

            font-size: 22px;
            font-weight: 700;
        }

        .logo-icon {
            width: 42px;
            height: 42px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 10px;

            background: rgba(255, 255, 255, 0.18);

            font-size: 22px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 28px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;

            font-size: 15px;
            font-weight: 500;

            transition: all 0.3s ease;
        }

        .nav-links a:hover {
            color: #dbeafe;
        }

        /* Sign Up */
        .signup-link {
            padding: 9px 18px;

            border: 1px solid rgba(255, 255, 255, 0.75);
            border-radius: 25px;
        }

        .signup-link:hover {
            background: white;
            color: #1e3c72 !important;
        }

        /* Login */
        .login-link {
            padding: 10px 21px;

            border-radius: 25px;

            background: white;

            color: #1e3c72 !important;
            font-weight: 600 !important;
        }

        .login-link:hover {
            background: #e8f0ff;
            transform: translateY(-1px);
        }

        /* =========================
           HERO SECTION
        ========================= */

        .hero {
            min-height: 680px;

            display: flex;
            align-items: center;
            justify-content: center;

            text-align: center;

            padding: 120px 20px 80px;

            color: white;

            background-image:
                linear-gradient(
                    rgba(0, 0, 0, 0.48),
                    rgba(0, 0, 0, 0.55)
                ),
                url("images/lib_bgi.jpg");

            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        .hero-content {
            max-width: 850px;
            margin: auto;
        }

        .hero-tag {
            display: inline-block;

            padding: 8px 18px;
            margin-bottom: 22px;

            border: 1px solid rgba(255, 255, 255, 0.45);
            border-radius: 30px;

            background: rgba(255, 255, 255, 0.12);

            font-size: 14px;
            letter-spacing: 1px;
        }

        .hero h1 {
            font-size: clamp(42px, 6vw, 70px);

            line-height: 1.08;

            margin-bottom: 22px;

            font-weight: 750;

            letter-spacing: -1px;
        }

        .hero h1 span {
            color: #dce9ff;
        }

        .hero p {
            max-width: 700px;

            margin: 0 auto;

            font-size: 19px;

            line-height: 1.7;

            color: rgba(255, 255, 255, 0.92);
        }

        /* =========================
           FEATURES SECTION
        ========================= */

        .features-section {
            padding: 80px 7%;

            background: #f7f8fc;
        }

        .section-title {
            text-align: center;

            max-width: 700px;

            margin: 0 auto 50px;
        }

        .section-title h2 {
            font-size: 36px;

            color: #1e293b;

            margin-bottom: 12px;
        }

        .section-title p {
            font-size: 16px;

            color: #64748b;

            line-height: 1.7;
        }

        .feature-grid {
            max-width: 1150px;

            margin: auto;

            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 22px;
        }

        .feature-card {
            background: white;

            padding: 32px 25px;

            border-radius: 18px;

            text-align: center;

            border: 1px solid #edf0f5;

            box-shadow:
                0 8px 30px
                rgba(15, 23, 42, 0.07);

            transition: all 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-7px);

            box-shadow:
                0 15px 35px
                rgba(15, 23, 42, 0.12);
        }

        .feature-icon {
            width: 65px;
            height: 65px;

            margin: 0 auto 20px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 16px;

            background: #eef4ff;

            font-size: 30px;
        }

        .feature-card h3 {
            font-size: 19px;

            margin-bottom: 10px;

            color: #1e293b;
        }

        .feature-card p {
            font-size: 14px;

            line-height: 1.7;

            color: #64748b;
        }

        /* =========================
           CTA SECTION
        ========================= */

        .cta-section {
            padding: 75px 20px;

            background:
                linear-gradient(
                    135deg,
                    #1e3c72,
                    #2a5298
                );

            text-align: center;

            color: white;
        }

        .cta-section h2 {
            font-size: 34px;

            margin-bottom: 14px;
        }

        .cta-section p {
            max-width: 650px;

            margin: 0 auto 28px;

            line-height: 1.7;

            color: rgba(255, 255, 255, 0.9);
        }

        .cta-button {
            display: inline-block;

            padding: 14px 30px;

            border-radius: 30px;

            background: white;

            color: #1e3c72;

            text-decoration: none;

            font-weight: 600;

            transition: all 0.3s ease;
        }

        .cta-button:hover {
            transform: translateY(-3px);

            box-shadow:
                0 10px 25px
                rgba(0, 0, 0, 0.2);
        }

        /* =========================
           FOOTER
        ========================= */

        footer {
            background: #111827;

            color: #cbd5e1;

            text-align: center;

            padding: 25px 20px;
        }

        footer p {
            font-size: 14px;

            line-height: 1.6;
        }

        .footer-title {
            color: white;

            font-weight: 600;

            margin-bottom: 6px;
        }

        /* =========================
           RESPONSIVE
        ========================= */

        @media (max-width: 900px) {

            .navbar {
                padding: 0 5%;
            }

            .feature-grid {
                grid-template-columns:
                    repeat(2, 1fr);
            }

            .nav-links {
                gap: 18px;
            }
        }

        @media (max-width: 650px) {

            .navbar {
                height: auto;

                padding: 18px 5%;

                flex-direction: column;

                gap: 15px;
            }

            .nav-links {
                flex-wrap: wrap;

                justify-content: center;

                gap: 12px;
            }

            .hero {
                min-height: 680px;

                padding-top: 170px;
            }

            .hero h1 {
                font-size: 42px;
            }

            .hero p {
                font-size: 16px;
            }

            .feature-grid {
                grid-template-columns: 1fr;
            }

            .features-section {
                padding: 65px 5%;
            }

            .section-title h2 {
                font-size: 30px;
            }

            .cta-section h2 {
                font-size: 28px;
            }
        }

    </style>
</head>

<body>


<!-- =====================================================
     NAVIGATION BAR
===================================================== -->

<nav class="navbar">

    <a href="index.jsp" class="logo">

        <span class="logo-icon">
            📚
        </span>

        <span>
            Library System
        </span>

    </a>


    <div class="nav-links">

        <a href="index.jsp">
            Home
        </a>

        <a href="about.jsp">
            About
        </a>

        <a href="books.jsp">
            Books
        </a>

        <a href="register.jsp" class="signup-link">
            Sign Up
        </a>

        <a href="login.jsp" class="login-link">
            Login
        </a>

    </div>

</nav>


<!-- =====================================================
     HERO SECTION
===================================================== -->

<section class="hero">

    <div class="hero-content">

        <div class="hero-tag">
            Knowledge • Learning • Growth
        </div>


        <h1>
            Welcome to
            <span>
                Library Management System
            </span>
        </h1>


        <p>
            A simple, secure and efficient platform to explore
            books, manage borrowing activities and make your
            learning experience easier and more organized.
        </p>

    </div>

</section>


<!-- =====================================================
     FEATURES SECTION
===================================================== -->

<section class="features-section" id="features">


    <div class="section-title">

        <h2>
            Everything You Need
        </h2>

        <p>
            Our library management system provides a convenient
            way to discover books, manage borrowing and keep
            track of your library activities.
        </p>

    </div>


    <div class="feature-grid">


        <!-- FEATURE 1 -->

        <div class="feature-card">

            <div class="feature-icon">
                📚
            </div>

            <h3>
                Wide Collection
            </h3>

            <p>
                Explore a well-organized collection of books
                covering different subjects and areas of interest.
            </p>

        </div>


        <!-- FEATURE 2 -->

        <div class="feature-card">

            <div class="feature-icon">
                📖
            </div>

            <h3>
                Easy Borrowing
            </h3>

            <p>
                Borrow available books easily and keep track
                of your current and previous transactions.
            </p>

        </div>


        <!-- FEATURE 3 -->

        <div class="feature-card">

            <div class="feature-icon">
                🔒
            </div>

            <h3>
                Secure & Reliable
            </h3>

            <p>
                User accounts and library activities are
                managed through a secure role-based system.
            </p>

        </div>


        <!-- FEATURE 4 -->

        <div class="feature-card">

            <div class="feature-icon">
                💻
            </div>

            <h3>
                24/7 Access
            </h3>

            <p>
                Access the library system whenever you need
                to manage your books and account activities.
            </p>

        </div>

    </div>

</section>


<!-- =====================================================
     CALL TO ACTION
===================================================== -->

<section class="cta-section">

    <h2>
        Start Your Learning Journey
    </h2>

    <p>
        Join our library system and make book management
        simple, organized and convenient.
    </p>

    <a href="register.jsp" class="cta-button">
        Create Your Account
    </a>

</section>


<!-- =====================================================
     FOOTER
===================================================== -->

<footer>

    <p class="footer-title">
        Library Management System
    </p>

    <p>
        Knowledge • Learning • Growth
    </p>

    <p>
        © 2026 Library Management System.
        All Rights Reserved.
    </p>

</footer>


</body>
</html>