<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!-- Materialize CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

<!-- Custom styles -->
<style>
    body {
        margin: 0;
        padding: 0;
    }

    .sidebar {
        height: 100%;
        width: 250px;
        position: fixed;
        z-index: 1;
        top: 0;
        left: 0;
        background-color: #37474f; /* Materialize's teal darken-3 color */
        padding-top: 20px;
    }

    .sidebar a {
        padding: 16px;
        text-decoration: none;
        font-size: 18px;
        color: #ffffff; /* Materialize's white-text color */
        display: block;
    }

    .sidebar a:hover {
        background-color: #546e7a; /* Materialize's teal darken-2 color */
    }
</style>

<!-- Sidebar -->
<div class="sidebar">
    <a href="dash.jsp">Dashboard</a>
    <a href="ptLst.jsp">Patients</a>
    <a href="AppoinmentList.jsp">Appointments</a>
    <a href="tlst.jsp">Tests</a>
    <a href="blst.jsp">Billing</a>
    <a href="repAdLi.jsp">Reports</a>
    <a href="index.jsp">Logout</a>
</div>

<!-- Materialize JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
