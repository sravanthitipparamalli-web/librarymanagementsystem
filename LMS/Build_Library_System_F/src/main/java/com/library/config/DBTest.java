package com.library.config;

import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) {

        try {

            Connection connection = DBConnection.getConnection();

            if (connection != null && !connection.isClosed()) {

                System.out.println("=================================");
                System.out.println("Database connection successful!");
                System.out.println("Oracle Database: XE");
                System.out.println("=================================");

                connection.close();

            }

        } catch (Exception e) {

            System.out.println("=================================");
            System.out.println("Database connection FAILED!");
            System.out.println("=================================");

            e.printStackTrace();
        }
    }
}