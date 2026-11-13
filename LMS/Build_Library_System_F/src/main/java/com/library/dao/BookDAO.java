package com.library.dao;

import com.library.config.DBConnection;
import com.library.models.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    public List<Book> getAllBooks() {

        List<Book> books = new ArrayList<>();

        String sql = "SELECT BOOK_ID, TITLE, AUTHOR, ISBN, " +
                     "TOTAL_COPIES, AVAILABLE_COPIES " +
                     "FROM Books_LM ORDER BY BOOK_ID";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                books.add(mapBook(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    public List<Book> searchBooks(String keyword) {

        List<Book> books = new ArrayList<>();

        String sql = "SELECT BOOK_ID, TITLE, AUTHOR, ISBN, " +
                     "TOTAL_COPIES, AVAILABLE_COPIES " +
                     "FROM Books_LM " +
                     "WHERE LOWER(TITLE) LIKE ? " +
                     "OR LOWER(AUTHOR) LIKE ? " +
                     "OR LOWER(ISBN) LIKE ? " +
                     "ORDER BY TITLE";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String search = "%" + keyword.toLowerCase() + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    books.add(mapBook(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    public boolean addBook(Book book) {

        String sql = "INSERT INTO Books_LM " +
                     "(TITLE, AUTHOR, ISBN, TOTAL_COPIES, AVAILABLE_COPIES) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getIsbn());
            ps.setInt(4, book.getTotalCopies());
            ps.setInt(5, book.getAvailableCopies());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateBook(Book book) {

        String sql = "UPDATE Books_LM SET TITLE = ?, AUTHOR = ?, " +
                     "ISBN = ?, TOTAL_COPIES = ?, AVAILABLE_COPIES = ? " +
                     "WHERE BOOK_ID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getIsbn());
            ps.setInt(4, book.getTotalCopies());
            ps.setInt(5, book.getAvailableCopies());
            ps.setInt(6, book.getBookId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteBook(int bookId) {

        String sql = "DELETE FROM Books_LM WHERE BOOK_ID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Book getBookById(int bookId) {

        String sql = "SELECT BOOK_ID, TITLE, AUTHOR, ISBN, " +
                     "TOTAL_COPIES, AVAILABLE_COPIES " +
                     "FROM Books_LM WHERE BOOK_ID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapBook(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public int getBookCount() {

        String sql = "SELECT COUNT(*) FROM Books_LM";

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

    public int getAvailableBookCount() {

        String sql = "SELECT NVL(SUM(AVAILABLE_COPIES), 0) FROM Books_LM";

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

    private Book mapBook(ResultSet rs) throws SQLException {

        Book book = new Book();

        book.setBookId(rs.getInt("BOOK_ID"));
        book.setTitle(rs.getString("TITLE"));
        book.setAuthor(rs.getString("AUTHOR"));
        book.setIsbn(rs.getString("ISBN"));
        book.setTotalCopies(rs.getInt("TOTAL_COPIES"));
        book.setAvailableCopies(rs.getInt("AVAILABLE_COPIES"));

        return book;
    }
}