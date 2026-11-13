BUILD LIBRARY SYSTEM F - OFFLINE SETUP
=====================================

Technology
----------
Java 11, JSP, Servlets 4, JDBC, Oracle XE, Apache Tomcat 9, Maven.
Runtime does not require internet access.

1. Import into Eclipse
----------------------
- File -> Import -> Existing Maven Projects
- Select this project folder: Build_Library_System_F
- Finish.
- Right-click project -> Maven -> Update Project -> Force Update -> OK.
- Project -> Clean.

2. Configure Oracle connection
------------------------------
Open:
src/main/java/com/library/config/DBConnection.java

Set USERNAME and PASSWORD to the Oracle schema account that contains
Users_LM, Books_LM and Transactions_LM. Do NOT use the web login
credentials unless they are also your Oracle database credentials.

Default JDBC URL:
jdbc:oracle:thin:@localhost:1521:XE

3. Database
-----------
The project includes database/schema.sql as a reference. Execute the
SQL in Oracle Run SQL Command Line (SQL*Plus) using the Oracle schema
account configured above. The application expects:
Users_LM, Books_LM, Transactions_LM
and their sequences/triggers.

Seed web-login accounts:
Admin: admin@library.com / admin123
User:  user@library.com  / user123

4. Run
------
- Add Apache Tomcat 9 to Eclipse Servers.
- Add Build_Library_System_F to the server.
- Start Tomcat.
- Open:
  http://localhost:8009/Build_Library_System_F/index.jsp
  (Use your configured Tomcat port if different.)

5. Important
------------
- The project uses com.library.controllers and com.library.models.
- No 3-book borrowing limit is enforced.
- Do not manually copy old target/classes files back into the project.
- If Eclipse shows stale red errors: stop Tomcat -> Project Clean -> Maven
  Update Project -> restart Tomcat.
