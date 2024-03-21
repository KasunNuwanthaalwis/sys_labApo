<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Lab Appointment System - Delete Patient</title>
    
    <!-- Material Design CSS -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/button@10.0.0/dist/mdc.button.min.css">
    
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Roboto', sans-serif;
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
        .delete-container {
            margin: 20px auto;
            padding: 16px;
            max-width: 80%;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .card-title {
            text-align: center;
            margin-bottom: 20px;
        }
        .alert {
            padding: 1rem;
            margin-bottom: 1rem;
            border: 1px solid transparent;
            border-radius: .25rem;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        .btn-action {
            margin-right: 5px;
        }
    </style>
</head>
<body>

<%@include file="nav.jsp" %>

<%
    // Retrieve patient ID from the URL parameter
    String patientIdString = request.getParameter("id");

    if (patientIdString != null && !patientIdString.isEmpty()) {
        try {
            int patientId = Integer.parseInt(patientIdString);

            // Delete patient from the database
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_lab", "root", "");
            String deleteQuery = "DELETE FROM patientstb WHERE id = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
            deleteStmt.setInt(1, patientId);

            int rowsAffected = deleteStmt.executeUpdate();

            // Check if the deletion was successful
            if (rowsAffected > 0) {
%>
                <div class="delete-container">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title text-center mb-4">Delete Patient</h2>
                            <div class="alert alert-success" role="alert">Patient deleted successfully!</div>
                            <a href="paitentMg.jsp" class="mdc-button">Back</a>
                        </div>
                    </div>
                </div>
<%
            } else {
%>
                <div class="delete-container">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title text-center mb-4">Delete Patient</h2>
                            <div class="alert alert-danger" role="alert">Failed to delete patient. Please try again.</div>
                            <a href="paitentMg.jsp" class="mdc-button">Back</a>
                        </div>
                    </div>
                </div>
<%
            }

            deleteStmt.close();
            conn.close();
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
%>
            <div class="delete-container">
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title text-center mb-4">Delete Patient</h2>
                        <div class="alert alert-danger" role="alert">An error occurred. Please try again later.</div>
                        <a href="paitentMg.jsp" class="mdc-button">Back</a>
                    </div>
                </div>
            </div>
<%
        }
    } else {
%>
        <div class="delete-container">
            <div class="card">
                <div class="card-body">
                    <h2 class="card-title text-center mb-4">Delete Patient</h2>
                    <div class="alert alert-danger" role="alert">Invalid patient ID. Please provide a valid ID.</div>
                    <a href="paitentMg.jsp" class="mdc-button">Back</a>
                </div>
            </div>
        </div>
<%
    }
%>

<!-- Material Design JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/@material/button@10.0.0/dist/mdc.button.min.js"></script>

</body>
</html>
