<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.util.logging.Logger" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Lab Appointment System - Delete Appointment</title>
    
    <!-- Material Design Lite CSS -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
    
    <!-- Material Design Lite JS -->
    <script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
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

        // Check if the appointment ID is provided in the query parameter
        String appointmentIdParam = request.getParameter("id");
        if (appointmentIdParam == null || appointmentIdParam.isEmpty()) {
            out.println("<div class='container mt-3'><div class='alert alert-danger' role='alert'>Invalid appointment ID. Please provide a valid ID.</div></div>");
        } else {
            int appointmentId = Integer.parseInt(appointmentIdParam);

            // Check if the form is submitted
            if (request.getMethod().equals("POST")) {
                // SQL query to delete the appointment
                String deleteSql = "DELETE FROM appoindatatb WHERE id=?";
                stmt = conn.prepareStatement(deleteSql);
                stmt.setInt(1, appointmentId);

                // Execute the delete
                int rowsDeleted = stmt.executeUpdate();

                // Check if the delete was successful
                if (rowsDeleted > 0) {
                    out.println("<div class='container mt-3'><div class='alert alert-success' role='alert'>Appointment deleted successfully.</div></div>");
                    response.sendRedirect("AppoinmentList.jsp");
                } else {
                    out.println("<div class='container mt-3'><div class='alert alert-danger' role='alert'>Failed to delete appointment. Please try again.</div></div>");
                }
            }

            // Fetch the appointment details for display
            String sql = "SELECT * FROM appoindatatb WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, appointmentId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Display appointment details
                String patientId = rs.getString("patient_id");
                String appointmentDate = rs.getString("appointment_date");
                String appointmentTime = rs.getString("appointment_time");
                String doctorName = rs.getString("doctor_name");
                String appointmentPurpose = rs.getString("appointment_purpose");

                %>
                <div class="container">
                    <div class="mdl-card mdl-shadow--2dp mt-3">
                        <div class="mdl-card__title">
                            <h2 class="mdl-card__title-text">Delete Appointment</h2>
                        </div>
                        <div class="mdl-card__supporting-text">
                            <p><strong>Patient ID:</strong> <%= patientId %></p>
                            <p><strong>Appointment Date:</strong> <%= appointmentDate %></p>
                            <p><strong>Appointment Time:</strong> <%= appointmentTime %></p>
                            <p><strong>Doctor Name:</strong> <%= doctorName %></p>
                            <p><strong>Appointment Purpose:</strong> <%= appointmentPurpose %></p>

                            <!-- Delete Appointment Form -->
                            <form method="post" class="mt-3">
                                <input type="hidden" name="id" value="<%= appointmentId %>">
                                <button type="submit" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored">Delete Appointment</button>
                                <a href="AppoinmentList.jsp" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored">Back</a>
                            </form>
                        </div>
                    </div>
                </div>
                <%
            } else {
                out.println("<div class='container mt-3'><div class='alert alert-danger' role='alert'>Appointment not found. Please provide a valid ID.</div></div>");
            }
        }
    } catch (ClassNotFoundException | SQLException | NumberFormatException e) {
        // Handle exceptions
        Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Exception occurred during appointment deletion", e);
        out.println("<div class='container mt-3'><div class='alert alert-danger' role='alert'>An error occurred during appointment deletion. Please try again later. Error: " + e.getMessage() + "</div></div>");
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

</body>
</html>
