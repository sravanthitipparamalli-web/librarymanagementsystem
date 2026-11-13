package com.library.controllers;

import com.library.dao.UserDAO;
import com.library.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(
                request.getContextPath() + "/register.jsp"
        );
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (fullName == null || fullName.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/register.jsp?error=Please fill in all fields."
            );
            return;
        }

        fullName = fullName.trim();
        email = email.trim().toLowerCase();

        // Basic password validation
        if (password.length() < 6) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/register.jsp?error=Password must contain at least 6 characters."
            );
            return;
        }

        try {

            // Check whether email already exists
            if (userDAO.emailExists(email)) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/register.jsp?error=An account with this email already exists."
                );
                return;
            }

            // Create new user
            User user = new User();

            user.setFullName(fullName);
            user.setEmail(email);
            user.setPassword(password);

            // UserDAO.register() will store the account
            // with USER role and ACTIVE status.
            userDAO.register(user);

            // Registration successful
            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp?message=Registration successful. Please login."
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/register.jsp?error=Unable to create account. Please try again."
            );
        }
    }
}
