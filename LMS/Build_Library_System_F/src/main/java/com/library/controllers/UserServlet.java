package com.library.controllers;

import com.library.dao.BookDAO;
import com.library.dao.TransactionDAO;
import com.library.models.Book;
import com.library.models.Transaction;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BookDAO bookDAO;
    private TransactionDAO transactionDAO;

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        transactionDAO = new TransactionDAO();
    }

    // =========================
    // GET - LOAD USER DASHBOARD
    // =========================
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || !"USER".equalsIgnoreCase(
                        String.valueOf(session.getAttribute("role")))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        loadDashboard(request, response);
    }

    // =========================
    // POST - USER ACTIONS
    // =========================
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null
                || !"USER".equalsIgnoreCase(
                        String.valueOf(session.getAttribute("role")))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String action = request.getParameter("action");

        try {

            // =========================
            // BORROW BOOK
            // =========================
            if ("borrow".equalsIgnoreCase(action)) {

                String bookIdParam = request.getParameter("bookId");

                if (bookIdParam == null || bookIdParam.trim().isEmpty()) {

                    session.setAttribute(
                            "error",
                            "Invalid book selected."
                    );

                } else {

                    int bookId = Integer.parseInt(bookIdParam);

                    Object userIdObject =
                            session.getAttribute("userId");

                    if (userIdObject == null) {

                        session.setAttribute(
                                "error",
                                "User session expired. Please login again."
                        );

                    } else {

                        int userId =
                                Integer.parseInt(
                                        userIdObject.toString()
                                );

                        transactionDAO.borrowBook(
                                userId,
                                bookId
                        );

                        session.setAttribute(
                                "success",
                                "Book borrowed successfully."
                        );
                    }
                }

            }

            // =========================
            // RETURN BOOK
            // =========================
            else if ("return".equalsIgnoreCase(action)) {

                String transactionIdParam =
                        request.getParameter("transactionId");

                if (transactionIdParam == null
                        || transactionIdParam.trim().isEmpty()) {

                    session.setAttribute(
                            "error",
                            "Invalid transaction selected."
                    );

                } else {

                    int transactionId =
                            Integer.parseInt(transactionIdParam);

                    Object userIdObject =
                            session.getAttribute("userId");

                    if (userIdObject == null) {

                        session.setAttribute(
                                "error",
                                "User session expired. Please login again."
                        );

                    } else {

                        int userId =
                                Integer.parseInt(
                                        userIdObject.toString()
                                );

                        /*
                         * Current TransactionDAO method accepts
                         * transactionId only.
                         */
                        transactionDAO.returnBook(
                                transactionId
                        );

                        session.setAttribute(
                                "success",
                                "Book returned successfully."
                        );
                    }
                }

            }

            else {

                session.setAttribute(
                        "error",
                        "Invalid action."
                );
            }

        } catch (NumberFormatException e) {

            e.printStackTrace();

            session.setAttribute(
                    "error",
                    "Invalid book or transaction ID."
            );

        } catch (Exception e) {

            e.printStackTrace();

            String message = e.getMessage();

            if (message == null || message.trim().isEmpty()) {
                message = "Unable to complete the operation.";
            }

            session.setAttribute(
                    "error",
                    message
            );
        }

        // Always return to dashboard
        response.sendRedirect(
                request.getContextPath() + "/user"
        );
    }

    // =========================
    // LOAD DASHBOARD
    // =========================
    private void loadDashboard(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session =
                    request.getSession(false);

            int userId =
                    Integer.parseInt(
                            session.getAttribute("userId").toString()
                    );

            // Get all books
            List<Book> books =
                    bookDAO.getAllBooks();

            // Get user's transactions
            List<Transaction> transactions =
                    transactionDAO.getUserTransactions(userId);

            request.setAttribute(
                    "books",
                    books
            );

            request.setAttribute(
                    "transactions",
                    transactions
            );

            request.getRequestDispatcher(
                    "/user_dashboard.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Unable to load user dashboard."
            );

            request.getRequestDispatcher(
                    "/user_dashboard.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }
}