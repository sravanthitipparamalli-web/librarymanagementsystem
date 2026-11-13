package com.library.controllers;

import com.library.dao.BookDAO;
import com.library.dao.TransactionDAO;
import com.library.dao.UserDAO;
import com.library.models.Book;
import com.library.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;
    private BookDAO bookDAO;
    private TransactionDAO transactionDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        bookDAO = new BookDAO();
        transactionDAO = new TransactionDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || !"ADMIN".equalsIgnoreCase(
                        (String) session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        loadDashboard(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null
                || !"ADMIN".equalsIgnoreCase(
                        (String) session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String action = request.getParameter("action");

        try {

            if ("addBook".equals(action)) {

                addBook(request, session);

            } else if ("updateBook".equals(action)) {

                updateBook(request, session);

            } else if ("deleteBook".equals(action)) {

                deleteBook(request, session);

            } else if ("blockUser".equals(action)) {

                updateUserStatus(request, session, "INACTIVE");

            } else if ("activateUser".equals(action)) {

                updateUserStatus(request, session, "ACTIVE");

            } else {

                session.setAttribute(
                        "error",
                        "Invalid admin action."
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            session.setAttribute(
                    "error",
                    "Operation failed: " + e.getMessage()
            );
        }

        response.sendRedirect(
                request.getContextPath() + "/admin"
        );
    }


    private void addBook(
            HttpServletRequest request,
            HttpSession session)
            throws Exception {

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");

        int totalCopies = Integer.parseInt(
                request.getParameter("totalCopies")
        );

        if (title == null || title.trim().isEmpty()
                || author == null || author.trim().isEmpty()
                || totalCopies <= 0) {

            session.setAttribute(
                    "error",
                    "Please enter valid book details."
            );

            return;
        }

        Book book = new Book();

        book.setTitle(title.trim());
        book.setAuthor(author.trim());

        if (isbn != null && !isbn.trim().isEmpty()) {
            book.setIsbn(isbn.trim());
        }

        book.setTotalCopies(totalCopies);
        book.setAvailableCopies(totalCopies);

        bookDAO.addBook(book);

        session.setAttribute(
                "success",
                "Book added successfully."
        );
    }


    private void updateBook(
            HttpServletRequest request,
            HttpSession session)
            throws Exception {

        int bookId = Integer.parseInt(
                request.getParameter("bookId")
        );

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");

        int totalCopies = Integer.parseInt(
                request.getParameter("totalCopies")
        );

        int availableCopies = Integer.parseInt(
                request.getParameter("availableCopies")
        );

        if (totalCopies < 1) {

            session.setAttribute(
                    "error",
                    "Total copies must be at least 1."
            );

            return;
        }

        if (availableCopies > totalCopies) {
            availableCopies = totalCopies;
        }

        Book book = new Book();

        book.setBookId(bookId);
        book.setTitle(title.trim());
        book.setAuthor(author.trim());

        if (isbn != null) {
            book.setIsbn(isbn.trim());
        }

        book.setTotalCopies(totalCopies);
        book.setAvailableCopies(availableCopies);

        bookDAO.updateBook(book);

        session.setAttribute(
                "success",
                "Book updated successfully."
        );
    }


    private void deleteBook(
            HttpServletRequest request,
            HttpSession session)
            throws Exception {

        int bookId = Integer.parseInt(
                request.getParameter("bookId")
        );

        bookDAO.deleteBook(bookId);

        session.setAttribute(
                "success",
                "Book deleted successfully."
        );
    }


    private void updateUserStatus(
            HttpServletRequest request,
            HttpSession session,
            String status)
            throws Exception {

        int userId = Integer.parseInt(
                request.getParameter("userId")
        );

        userDAO.updateStatus(userId, status);

        if ("ACTIVE".equals(status)) {

            session.setAttribute(
                    "success",
                    "User activated successfully."
            );

        } else {

            session.setAttribute(
                    "success",
                    "User blocked successfully."
            );
        }
    }


    private void loadDashboard(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int totalUsers = userDAO.getUserCount();

            int totalBooks = bookDAO.getBookCount();

            int availableCopies =
                    bookDAO.getAvailableBookCount();

            int activeBorrows =
                    transactionDAO.getActiveBorrowCount();

            List<Book> books =
                    bookDAO.getAllBooks();

            List<User> users =
                    userDAO.getAllUsers();

            List<com.library.models.Transaction> transactions =
                    transactionDAO.getAllTransactions();

            int returnedBooks = 0;

            for (com.library.models.Transaction transaction
                    : transactions) {

                if ("RETURNED".equalsIgnoreCase(
                        transaction.getStatus())) {

                    returnedBooks++;
                }
            }

            request.setAttribute(
                    "totalUsers",
                    totalUsers
            );

            request.setAttribute(
                    "totalBooks",
                    totalBooks
            );

            request.setAttribute(
                    "availableCopies",
                    availableCopies
            );

            request.setAttribute(
                    "activeBorrows",
                    activeBorrows
            );

            request.setAttribute(
                    "returnedBooks",
                    returnedBooks
            );

            request.setAttribute(
                    "books",
                    books
            );

            request.setAttribute(
                    "users",
                    users
            );

            request.setAttribute(
                    "transactions",
                    transactions
            );

            request.getRequestDispatcher(
                    "/admin_dashboard.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Unable to load admin dashboard."
            );

            request.getRequestDispatcher(
                    "/admin_dashboard.jsp"
            ).forward(request, response);
        }
    }
}