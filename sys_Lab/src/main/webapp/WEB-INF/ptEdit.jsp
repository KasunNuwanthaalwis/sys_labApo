<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.logging.Level, java.util.logging.Logger"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Lab Appointment System - Edit Patient</title>
    
    <!-- Material Design CSS -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/textfield@10.0.0/dist/mdc.textfield.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/button@10.0.0/dist/mdc.button.min.css">
    
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
        }
        .edit-container {
            padding: 16px;
            max-width: 800px;
            margin: auto;
        }
        .mdc-card {
            margin-top: 20px;
        }
        /* Material Design CSS Overrides */
        .mdc-text-field {
            width: 100%;
            margin-bottom: 20px;
        }
        .mdc-button {
            margin-right: 10px;
        }
    </style>
</head>
<body>

<%@include file="nav.jsp" %>

<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/db_lab";
    String username = "root";
    String password = "";

    // Patient ID obtained from the URL parameter
    String patientIdString = request.getParameter("id");

    // JDBC variables
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        conn = DriverManager.getConnection(url, username, password);

        // SQL query to retrieve patient details based on ID
        String sql = "SELECT * FROM patientstb WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, patientIdString);

        // Execute the query
        rs = stmt.executeQuery();

        // Check if a record is found
        if (rs.next()) {
            // Retrieve values from the result set
            String firstName = rs.getString("firstName");
            String lastName = rs.getString("lastName");
            String email = rs.getString("email");
            String phoneNumber = rs.getString("phoneNumber");
            String dateOfBirth = rs.getString("dateOfBirth");
            String address = rs.getString("address");
            String medicalHistory = rs.getString("medicalHistory");
%>

<div class="mdc-container edit-container">
    <div class="mdc-card">
        <div class="mdc-card__content">
            <h2 class="mdc-typography--headline5 text-center mb-4">Edit Patient</h2>
            <input type="hidden" class="md-text-field__input" id="id" name="id" value="<%= patientIdString %>" required>
            <!-- Edit Patient Form -->
            <form action="ptEdit.jsp" method="post">
                <div class="md-3">
                    <label class="md-floating-label" for="firstName">First Name</label>
                    <input type="text" class="md-text-field__input" id="firstName" name="firstName" value="<%= firstName %>" required>
                </div>
                
                <div class="md-3">
                    <label class="md-floating-label" for="lastName">Last Name</label>
                    <input type="text" class="md-text-field__input" id="lastName" name="lastName" value="<%= lastName %>" required>
                </div>
                
                <div class="md-3">
                    <label class="md-floating-label" for="email">Email</label>
                    <input type="email" class="md-text-field__input" id="email" name="email" value="<%= email %>" required>
                </div>
                
                <div class="md-3">
                    <label class="md-floating-label" for="phoneNumber">Phone Number</label>
                    <input type="tel" class="md-text-field__input" id="phoneNumber" name="phoneNumber" value="<%= phoneNumber %>" required>
                </div>
                
                <div class="md-3">
                    <label class="md-floating-label" for="dateOfBirth">Date of Birth</label>
                    <input type="date" class="md-text-field__input" id="dateOfBirth" name="dateOfBirth" value="<%= dateOfBirth %>" required>
                </div>
                
                <div class="md-3">
                    <label class="md-floating-label" for="address">Address</label>
                    <textarea class="md-text-field__input" id="address" name="address" rows="3" required><%= address %></textarea>
                </div>
                
                <div class="md-3">
                    <label class="md-floating-label" for="medicalHistory">Medical History</label>
                    <textarea class="md-text-field__input" id="medicalHistory" name="medicalHistory" rows="3"><%= medicalHistory %></textarea>
                </div>
                
                <button type="submit" class="md-button mdc-button--raised">Save Changes</button>
                <a href="ptLst.jsp" class="md-button">Back</a>
            </form>
        </div>
    </div>
</div>

<%
        } else {
            // No record found for the given patient ID
            out.println("<div class='mdc-container mt-3'><div class='mdc-alert mdc-alert--danger' role='alert'>Patient not found. Please check the patient ID.</div></div>");
        }
    } catch (ClassNotFoundException | SQLException e) {
        // Handle exceptions
        Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Exception occurred during patient data retrieval", e);
        out.println("<div class='mdc-container mt-3'><div class='mdc-alert mdc-alert--danger' role='alert'>An error occurred. Please try again later.</div></div>");
    } finally {
        // Close JDBC resources
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!-- Material Design JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/@material/textfield@10.0.0/dist/mdc.textfield.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@material/button@10.0.0/dist/mdc.button.min.js"></script>

</body>
</html>
