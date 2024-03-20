<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Lab Appointment System - Dashboard</title>

    <!-- Materialize CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Custom styles -->
    <style>
        body {
            background-color: #f8f9fa;
        }

        .content {
            max-width: 800px;
            margin: auto;
            margin-top: 50px;
            padding: 16px;
        }

        .card-panel {
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
        }

        .card-panel-title {
            font-size: 20px;
            margin-bottom: 10px;
        }

        .card-panel-count {
            font-size: 24px;
            font-weight: bold;
        }
    </style>
</head>

<body>

    <!-- Sidebar -->
    <%@include file="nav.jsp" %>

    <!-- Page content -->
    <div class="content">
        <h2 class="center-align">Dashboard</h2>

        <div class="row">
            <!-- Appointments Card -->
            <div class="col s12 m6 l3">
                <div class="card-panel blue lighten-2">
                    <div class="white-text">
                        <div class="card-panel-title">Appointments</div>
                        <div class="card-panel-count">
                            <%
                                try {
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_lab", "root", "");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS appointmentCount FROM appointments");
                                    if (rs.next()) {
                                        out.println(rs.getInt("appointmentCount"));
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            %>
                        </div>
                    </div>
                    <a href="AppointmentList.jsp" class="white-text">View Details</a>
                </div>
            </div>

            <!-- Bills Card -->
            <div class="col s12 m6 l3">
                <div class="card-panel green lighten-2">
                    <div class="white-text">
                        <div class="card-panel-title">Bills</div>
                        <div class="card-panel-count">
                            <%
                                try {
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_lab", "root", "");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS billCount FROM bills");
                                    if (rs.next()) {
                                        out.println(rs.getInt("billCount"));
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            %>
                        </div>
                    </div>
                    <a href="BillList.jsp" class="white-text">View Details</a>
                </div>
            </div>

            <!-- Tests Card -->
            <div class="col s12 m6 l3">
                <div class="card-panel teal lighten-2">
                    <div class="white-text">
                        <div class="card-panel-title">Tests</div>
                        <div class="card-panel-count">
                            <%
                                try {
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_lab", "root", "");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS testCount FROM tests");
                                    if (rs.next()) {
                                        out.println(rs.getInt("testCount"));
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            %>
                        </div>
                    </div>
                    <a href="TestList.jsp" class="white-text">View Details</a>
                </div>
            </div>

            <!-- Patients Card -->
            <div class="col s12 m6 l3">
                <div class="card-panel orange lighten-2">
                    <div class="white-text">
                        <div class="card-panel-title">Patients</div>
                        <div class="card-panel-count">
                            <%
                                try {
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_lab", "root", "");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS patientCount FROM patientstb");
                                    if (rs.next()) {
                                        out.println(rs.getInt("patientCount"));
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            %>
                        </div>
                    </div>
                    <a href="PatientList.jsp" class="white-text">View Details</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Materialize JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            M.AutoInit();
        });
    </script>

</body>

</html>
