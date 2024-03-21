<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.util.logging.Logger" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Lab Appointment System - Patient Registration</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <style>
        body {
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        .content {
            margin-left: 250px;
            padding: 16px;
        }
        .bill-card {
            margin-top: 20px;
            background-color: #f8f9fa; /* Material Design surface color */
            padding: 20px;
            color: #000000; /* Material Design on surface color */
        }
        .label {
            display: block;
        }
    </style>
</head>
<body>

<%@include file="nav.jsp" %>

<%
    // Connection parameters for MySQL database
    String url = "jdbc:mysql://localhost:3306/db_lab?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    String username = "root";
    String password = "";
    
    // Form data
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phoneNumber = request.getParameter("phoneNumber");
    String dateOfBirth = request.getParameter("dateOfBirth");
    String address = request.getParameter("address");
    String medicalHistory = request.getParameter("medicalHistory");

    // JDBC variables
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        conn = DriverManager.getConnection(url, username, password);

        // SQL query to insert data into the 'patients' table
        String sql = "INSERT INTO patientstb (firstName, lastName, email, phoneNumber, dateOfBirth, address, medicalHistory) VALUES (?, ?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);

        // Set parameters for the SQL query
        stmt.setString(1, firstName);
        stmt.setString(2, lastName);
        stmt.setString(3, email);
        stmt.setString(4, phoneNumber);
        stmt.setString(5, dateOfBirth);
        stmt.setString(6, address);
        stmt.setString(7, medicalHistory);

        // Execute the query
        int rowsAffected = stmt.executeUpdate();

        // Display success message if data is inserted
        if (rowsAffected > 0) {
            out.println("Registration Sucessfull");
        } else {
            out.println("Registration Fail");
        }
    } catch (ClassNotFoundException | SQLException e) {
        // Handle exceptions
        Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Exception occurred during patient registration", e);
        out.println("Error Occure");
    } finally {
        // Close JDBC resources
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<div class="content">
    <div class="container">
        <div class="card bill-card">
            <div class="card-body">
                <h2 class="card-title">Patient Registration</h2>
                <form method="post">
                    <div class="row mb-3">
                        <div class="col">
                            <label class="form-label" for="firstName">First Name</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" required>
                        </div>
                        <div class="col">
                            <label class="form-label" for="lastName">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <label class="form-label" for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="col">
                            <label class="form-label" for="phoneNumber">Phone Number</label>
                            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <label class="form-label" for="dateOfBirth">Date of Birth</label>
                            <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" required>
                        </div>
                        <div class="col">
                            <label class="form-label" for="address">Address</label>
                            <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <label class="form-label" for="medicalHistory">Medical History</label>
                            <textarea class="form-control" id="medicalHistory" name="medicalHistory" rows="3"></textarea>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Register Patient</button>
                    <a href="ptLst.jsp" class="btn btn-secondary">Back</a>
                </form>
            </div>
       

        </div>
    </div>
</div>

<!-- Material Design JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/@material/textfield@10.0.0/dist/mdc.textfield.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@material/button@10.0.0/dist/mdc.button.min.js"></script>

</body>
</html>
