<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.util.logging.Logger" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Lab Appointment System - Add Bill</title>
    
    <!-- Material Design CSS -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/form-field@4.0.0/dist/mdc.form-field.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/select@4.0.0/dist/mdc.select.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/textfield@4.0.0/dist/mdc.textfield.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/button@4.0.0/dist/mdc.button.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/card@4.0.0/dist/mdc.card.min.css">
    
    <!-- Custom styles -->
    <style>
        body {
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        .sidebar {
            height: 100%;
            width: 250px;
            position: fixed;
            z-index: 1;
            top: 0;
            left: 0;
            background-color: #1976D2; /* Material Design primary color */
            padding-top: 20px;
            padding-right: 10px;
            color: white;
        }
        .sidebar a {
            padding: 10px 16px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
            margin-bottom: 10px;
        }
        .sidebar a:hover {
            background-color: #1565C0; /* Darken the color on hover */
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
    
    // JDBC variables
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        conn = DriverManager.getConnection(url, username, password);

        // Check if the form is submitted
        if (request.getMethod().equalsIgnoreCase("POST")) {
            // Form data
            String patientId = request.getParameter("patientId");
            String testName = request.getParameter("testName");
            String appointmentDate = request.getParameter("appointmentDate");
            String appointmentTime = request.getParameter("appointmentTime");
            String doctorName = request.getParameter("doctorName");
            String billAmount = request.getParameter("billAmount");
            String paymentStatus = request.getParameter("paymentStatus");

            // SQL query to insert data into the 'bills' table
            String sql = "INSERT INTO billtb (patient_id, test_name, appointment_date, appointment_time, doctor_name, bill_amount, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);

            // Set parameters for the SQL query
            stmt.setString(1, patientId);
            stmt.setString(2, testName);
            stmt.setString(3, appointmentDate);
            stmt.setString(4, appointmentTime);
            stmt.setString(5, doctorName);
            stmt.setString(6, billAmount);
            stmt.setString(7, paymentStatus);

            // Execute the query
            int rowsAffected = stmt.executeUpdate();

            // Display success message if data is inserted
            if (rowsAffected > 0) {
                out.println("<div class='container mt-3'><div class='alert alert-success' role='alert'>Bill added successfully!</div></div>");
            } else {
                out.println("<div class='container mt-3'><div class='alert alert-danger' role='alert'>Failed to add bill. Please try again.</div></div>");
            }
        }
        
        // Fetch patient names and IDs for the dropdown
        String patientQuery = "SELECT id, CONCAT(firstName, ' ', lastName) AS fullName FROM patientstb";
        stmt = conn.prepareStatement(patientQuery);
        rs = stmt.executeQuery();
    %>
    <div class="content">
        <div class="container">
            <div class="mdc-card bill-card">
                <div class="mdc-card__content">
                    <h2 class="mdc-typography--headline5">Add Bill</h2>
                    <!-- Bill Addition Form -->
                    <form method="post">
                         <div class="mb-3">
                    <label for="patientId" class="form-label">Patient Name</label>
                    <select class="form-control" id="patientId" name="patientId" required>
                        <%
                            // Populate dropdown with patient names and IDs
                            while (rs.next()) {
                                String patientId = rs.getString("id");
                                String fullName = rs.getString("fullName");
                        %>
                                <option value="<%= patientId %>"><%= fullName %></option>
                        <%
                            }
                        %>
                    </select>
                </div>

                        <div class="md-3">
                            <label for="testName" class="label">Test Name</label>
                            <input type="text" class="mdc-text-field" id="testName" name="testName" required>
                        </div>
                        
                        <div class="md-3">
                            <label for="appointmentDate" class="label">Appointment Date</label>
                            <input type="date" class="mdc-text-field" id="appointmentDate" name="appointmentDate" required>
                        </div>
                        
                        <div class="md-3">
                            <label for="appointmentTime" class="label">Appointment Time</label>
                            <input type="time" class="mdc-text-field" id="appointmentTime" name="appointmentTime" required>
                        </div>
                        
                        <div class="md-3">
                            <label for="doctorName" class="label">Doctor Name</label>
                            <input type="text" class="mdc-text-field" id="doctorName" name="doctorName" required>
                        </div>
                        
                        <div class="md-3">
                            <label for="billAmount" class="label">Bill Amount</label>
                            <input type="text" class="mdc-text-field" id="billAmount" name="billAmount" required>
                        </div>
                        
                        <div class="md-3">
                            <label for="paymentStatus" class="label">Payment Status</label>
                            <select class="mdc-select" id="paymentStatus" name="paymentStatus" required>
                                <option value="Paid">Paid</option>
                                <option value="Unpaid">Unpaid</option>
                            </select>
                        </div>
                        
                        <div class="md-3">
                            <button type="submit" class="mdc-button mdc-button--raised mdc-button--primary">Add Bill</button>
                            <a href="blst.jsp" class="mdc-button mdc-button--outlined">Back</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <% } catch (ClassNotFoundException | SQLException e) {
        // Handle exceptions
        Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Exception occurred during bill addition", e);
        out.println("<div class='container mt-3'><div class='alert alert-danger' role='alert'>An error occurred during bill addition. Please try again later. Error: " + e.getMessage() + "</div></div>");
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

<!-- Material Design JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/material-components-web/5.2.1/material-components-web.min.js"></script>
<script>
    // Initialize Material Design components
    mdc.autoInit();
</script>

</body>
</html>
