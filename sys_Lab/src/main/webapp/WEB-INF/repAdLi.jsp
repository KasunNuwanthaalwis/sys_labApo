<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Lab Appointment System - Report List</title>
    
    <!-- Material Design CSS -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/button@10.0.0/dist/mdc.button.min.css">
    
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Roboto', sans-serif;
        }
        .bill-container {
            max-width: 800px;
            margin: auto;
            margin-top: 50px;
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
        .content {
            margin-left: 250px;
            padding: 16px;
        }
    </style>
</head>
<body>
<%@include file="nav.jsp" %>
<div class="container text-center">
    <h2>Report List</h2>

    <!-- Material Design Buttons to Link to Different Reports -->
    <div class="mt-4">
        <a href="ReportSells.jsp" class="mdc-button mdc-button--raised mdc-button--primary mdc-button--dense">Sales Reports</a>
    </div>
</div>

<!-- Material Design JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/@material/button@10.0.0/dist/mdc.button.min.js"></script>

</body>
</html>
