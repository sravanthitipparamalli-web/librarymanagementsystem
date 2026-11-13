package com.library.dao;

import com.library.config.DBConnection;
import com.library.models.Transaction;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {

    public boolean borrowBook(int userId, int bookId) {

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // Check available copies
            String bookSql =
                    "SELECT AVAILABLE_COPIES FROM Books_LM " +
                    "WHERE BOOK_ID = ? FOR UPDATE";

            int available;

            try (PreparedStatement ps = con.prepareStatement(bookSql)) {

                ps.setInt(1, bookId);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        con.rollback();
                        return false;
                    }

                    available = rs.getInt("AVAILABLE_COPIES");
                }
            }

            if (available <= 0) {
                con.rollback();
                return false;
            }

            // Borrow for 14 days
            String transactionSql =
                    "INSERT INTO Transactions_LM " +
                    "(USER_ID, BOOK_ID, BORROW_DATE, DUE_DATE, STATUS) " +
                    "VALUES (?, ?, SYSDATE, SYSDATE + 14, 'BORROWED')";

            try (PreparedStatement ps =
                         con.prepareStatement(transactionSql)) {

                ps.setInt(1, userId);
                ps.setInt(2, bookId);
                ps.executeUpdate();
            }

            // Reduce available copies
            String updateBook =
                    "UPDATE Books_LM " +
                    "SET AVAILABLE_COPIES = AVAILABLE_COPIES - 1 " +
                    "WHERE BOOK_ID = ?";

            try (PreparedStatement ps = con.prepareStatement(updateBook)) {

                ps.setInt(1, bookId);
                ps.executeUpdate();
            }

            con.commit();
            return true;

        } catch (SQLException e) {

            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ignored) {
                }
            }

            e.printStackTrace();
            return false;

        } finally {

            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException ignored) {
                }
            }
        }
    }

    public boolean returnBook(int transactionId) {

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            int bookId;

            String selectSql =
                    "SELECT BOOK_ID FROM Transactions_LM " +
                    "WHERE TRANSACTION_ID = ? AND STATUS = 'BORROWED' " +
                    "FOR UPDATE";

            try (PreparedStatement ps = con.prepareStatement(selectSql)) {

                ps.setInt(1, transactionId);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        con.rollback();
                        return false;
                    }

                    bookId = rs.getInt("BOOK_ID");
                }
            }

            String returnSql =
                    "UPDATE Transactions_LM " +
                    "SET RETURN_DATE = SYSDATE, STATUS = 'RETURNED' " +
                    "WHERE TRANSACTION_ID = ?";

            try (PreparedStatement ps = con.prepareStatement(returnSql)) {

                ps.setInt(1, transactionId);
                ps.executeUpdate();
            }

            String bookSql =
                    "UPDATE Books_LM " +
                    "SET AVAILABLE_COPIES = AVAILABLE_COPIES + 1 " +
                    "WHERE BOOK_ID = ?";

            try (PreparedStatement ps = con.prepareStatement(bookSql)) {

                ps.setInt(1, bookId);
                ps.executeUpdate();
            }

            con.commit();
            return true;

        } catch (SQLException e) {

            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ignored) {
                }
            }

            e.printStackTrace();
            return false;

        } finally {

            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException ignored) {
                }
            }
        }
    }

    public List<Transaction> getUserTransactions(int userId) {

        List<Transaction> list = new ArrayList<>();

        String sql =
                "SELECT t.TRANSACTION_ID, t.USER_ID, t.BOOK_ID, " +
                "b.TITLE AS BOOK_TITLE, " +
                "t.BORROW_DATE, t.DUE_DATE, t.RETURN_DATE, t.STATUS, " +
                "CASE " +
                "WHEN t.STATUS = 'BORROWED' AND SYSDATE > t.DUE_DATE " +
                "THEN TRUNC(SYSDATE - t.DUE_DATE) " +
                "WHEN t.STATUS = 'RETURNED' AND t.RETURN_DATE > t.DUE_DATE " +
                "THEN TRUNC(t.RETURN_DATE - t.DUE_DATE) " +
                "ELSE 0 END AS LATE_DAYS " +
                "FROM Transactions_LM t " +
                "JOIN Books_LM b ON t.BOOK_ID = b.BOOK_ID " +
                "WHERE t.USER_ID = ? " +
                "ORDER BY t.TRANSACTION_ID DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Transaction t = mapTransaction(rs);

                    long lateDays = rs.getLong("LATE_DAYS");
                    t.setLateFee(lateDays * 1.0);

                    list.add(t);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Transaction> getAllTransactions() {

        List<Transaction> list = new ArrayList<>();

        String sql =
                "SELECT t.TRANSACTION_ID, t.USER_ID, t.BOOK_ID, " +
                "u.FULL_NAME AS USER_NAME, " +
                "b.TITLE AS BOOK_TITLE, " +
                "t.BORROW_DATE, t.DUE_DATE, t.RETURN_DATE, t.STATUS, " +
                "CASE " +
                "WHEN t.STATUS = 'BORROWED' AND SYSDATE > t.DUE_DATE " +
                "THEN TRUNC(SYSDATE - t.DUE_DATE) " +
                "WHEN t.STATUS = 'RETURNED' AND t.RETURN_DATE > t.DUE_DATE " +
                "THEN TRUNC(t.RETURN_DATE - t.DUE_DATE) " +
                "ELSE 0 END AS LATE_DAYS " +
                "FROM Transactions_LM t " +
                "JOIN Users_LM u ON t.USER_ID = u.USER_ID " +
                "JOIN Books_LM b ON t.BOOK_ID = b.BOOK_ID " +
                "ORDER BY t.TRANSACTION_ID DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Transaction t = mapTransaction(rs);

                long lateDays = rs.getLong("LATE_DAYS");
                t.setLateFee(lateDays * 1.0);

                list.add(t);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int getActiveBorrowCount() {

        String sql =
                "SELECT COUNT(*) FROM Transactions_LM " +
                "WHERE STATUS = 'BORROWED'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    private Transaction mapTransaction(ResultSet rs)
            throws SQLException {

        Transaction t = new Transaction();

        t.setTransactionId(rs.getInt("TRANSACTION_ID"));
        t.setUserId(rs.getInt("USER_ID"));
        t.setBookId(rs.getInt("BOOK_ID"));

        try {
            t.setUserName(rs.getString("USER_NAME"));
        } catch (SQLException ignored) {
        }

        t.setBookTitle(rs.getString("BOOK_TITLE"));
        t.setBorrowDate(rs.getDate("BORROW_DATE"));
        t.setDueDate(rs.getDate("DUE_DATE"));
        t.setReturnDate(rs.getDate("RETURN_DATE"));
        t.setStatus(rs.getString("STATUS"));

        return t;
    }
}