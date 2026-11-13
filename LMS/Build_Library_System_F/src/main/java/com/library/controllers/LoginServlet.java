
package com.library.controllers;

import com.library.dao.UserDAO;
import com.library.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

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
                request.getContextPath() + "/login.jsp"
        );
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp?error=Please enter your email and password."
            );
            return;
        }

        email = email.trim().toLowerCase();

        try {

            User user = userDAO.login(email, password);

            if (user == null) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/login.jsp?error=Invalid email or password."
                );
                return;
            }

            HttpSession oldSession = request.getSession(false);

            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session = request.getSession(true);

            // Get the actual user's full name
            String fullName = user.getFullName();

            if (fullName == null || fullName.trim().isEmpty()) {
                fullName = email.substring(0, email.indexOf("@"));
            }

            // Store user information in the session
            session.setAttribute("loggedUser", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", fullName.trim());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("role", user.getRole());
            session.setAttribute("status", user.getStatus());

            // Redirect according to user role
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {

                response.sendRedirect(
                        request.getContextPath() + "/admin"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath() + "/user"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp?error=Unable to login. Please try again."
            );
        }
    }
}
