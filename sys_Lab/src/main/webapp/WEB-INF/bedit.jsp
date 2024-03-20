<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.util.logging.Logger" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Lab Appointment System - Edit Bill</title>
    
    <!-- Material Design CSS -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/button@4.0.0/dist/mdc.button.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/textfield@4.0.0/dist/mdc.textfield.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/select@4.0.0/dist/mdc.select.min.css">
    
    <!-- Custom styles -->
    <style>
        body {
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        .bill-container {
            max-width: 800px;
            margin: auto;
            margin-top: 50px;
            padding: 16px;
        }
        .sidebar {
            height: 100%;
            width: 250px;
            position: fixed;
            z-index: 1;
            top: 0;
            left: 0;
            background-color: #343a40;
            padding-top: 20px;
            padding-right: 10px;
        }
        .sidebar a {
            padding: 10px 16px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
        }
        .sidebar a:hover {
            background-color: #212529;
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

        // Check if the bill ID is provided in the query parameter
        String billIdParam = request.getParameter("id");
        if (billIdParam == null || billIdParam.isEmpty()) {
            out.println("<div class='container mt-3'><div class='alert alert-danger' role='alert'>Invalid bill ID. Please provide a valid ID.</div></div>");
        } else {
            int billId = Integer.parseInt(billIdParam);

            // Check if the form is submitted
            if (request.getMethod().equals("POST")) {
                // Retrieve form data
                String updatedTestName = request.getParameter("testName");
                String updatedAppointmentDate = request.getParameter("appointmentDate");
                String updatedAppointmentTime = request.getParameter("appointmentTime");
                String updatedDoctorName = request.getParameter("doctorName");
                String updatedBillAmount = request.getParameter("billAmount");
                String updatedPaymentStatus = request.getParameter("paymentStatus");

                // SQL query to update bill details
                String updateSql = "UPDATE billtb SET test_name=?, appointment_date=?, appointment_time=?, doctor_name=?, bill_amount=?, payment_status=? WHERE id=?";
                stmt = conn.prepareStatement(updateSql);
                stmt.setString(1, updatedTestName);
                stmt.setString(2, updatedAppointmentDate);
                stmt.setString(3, updatedAppointmentTime);
                stmt.setString(4, updatedDoctorName);
                stmt.setString(5, updatedBillAmount);
                stmt.setString(6, updatedPaymentStatus);
                stmt.setInt(7, billId);

                // Execute the update
                int rowsUpdated = stmt.executeUpdate();

                // Check if the update was successful
                if (rowsUpdated > 0) {
                    out.println("<div class='container mt-3'><div class='alert alert-success' role='alert'>Bill details updated successfully.</div></div>");
                } else {
                    out.println("<div class='container mt-3'><div class='alert alert-danger' role='alert'>Failed to update bill details. Please try again.</div></div>");
                }
            }

            // Fetch the updated bill details
            String sql = "SELECT * FROM billtb WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, billId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Bill data
                String patientId = rs.getString("patient_id");
                String testName = rs.getString("test_name");
                String appointmentDate = rs.getString("appointment_date");
                String appointmentTime = rs.getString("appointment_time");
                String doctorName = rs.getString("doctor_name");
                String billAmount = rs.getString("bill_amount");
                String paymentStatus = rs.getString("payment_status");

                %>
                <div class="container bill-container">
                    <h2 class="text-center mb-4">Edit Bill</h2>
                    
                    <!-- Edit Bill Form -->
                    <form method="post">
                        <div class="mdc-text-field mdc-text-field--outlined">
                            <input type="text" class="mdc-text-field__input" id="patientId" name="patientId" value="<%= patientId %>" readonly>
                            <div class="mdc-notched-outline">
                                <div class="mdc-notched-outline__leading"></div>
                                <div class="mdc-notched-outline__notch">
                                    <label for="patientId" class="mdc-floating-label">Patient ID</label>
                                </div>
                                <div class="mdc-notched-outline__trailing"></div>
                            </div>
                        </div>

                        <div class="mdc-text-field mdc-text-field--outlined">
                            <input type="text" class="mdc-text-field__input" id="testName" name="testName" value="<%= testName %>" required>
                            <div class="mdc-notched-outline">
                                <div class="mdc-notched-outline__leading"></div>
                                <div class="mdc-notched-outline__notch">
                                    <label for="testName" class="mdc-floating-label">Test Name</label>
                                </div>
                                <div class="mdc-notched-outline__trailing"></div>
                            </div>
                        </div>
                        
                        <!-- Add similar components for other form fields -->
                        
                        <button type="submit" class="mdc-button mdc-button--raised mdc-button--primary">Save Changes</button>
                        <a href="BillList.jsp" class="mdc-button mdc-button--outlined">Back</a>
                    </form>
                </div>
                <%
            } else {
                out.println("<div class='container mt-3'><div class='alert alert-danger' role='alert'>Bill not found. Please provide a valid ID.</div></div>");
            }
        }
    } catch (ClassNotFoundException | SQLException | NumberFormatException e) {
        // Handle exceptions
        Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Exception occurred during bill editing", e);
        out.println("<div class='container mt-3'><div class='alert alert-danger' role='alert'>An error occurred during bill editing. Please try again later. Error: " + e.getMessage() + "</div></div>");
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
<script src="https://cdn.jsdelivr.net/npm/@material/textfield@4.0.0/dist/mdc.textfield.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@material/button@4.0.0/dist/mdc.button.min.js"></script>

</body>
</html>
