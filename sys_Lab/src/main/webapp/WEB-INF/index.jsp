<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lab Appointment System - Login</title>
    
    <!-- Materialize CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Google Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
    <!-- Custom styles -->
    <style>
        body {
            background-size: cover;
        }
        .overlay {
            background-color: rgba(248, 249, 250, 0.8); /* Adjust the alpha value for the overlay */
            height: 100%;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: -1;
        }
        .login-container {
            max-width: 400px;
            margin: auto;
            margin-top: 100px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #eee;
        }
        .login-container h2 {
            color: #007bff;
        }
        .content {
            margin-left: 250px;
            padding: 16px;
        }
    </style>
</head>
<body>

<div class="overlay"></div>

<%
    Class.forName("com.mysql.jdbc.Driver");
    if (request.getMethod().equalsIgnoreCase("post")) {
        String userType = request.getParameter("userType");
        
        if (userType != null && !userType.isEmpty()) {
            
            String tableName = "";
            if (userType.equals("admin")) {
                tableName = "adminTb"; // Replace with your actual admin table name
            } else if (userType.equals("patient")) {
                tableName = "patientstb"; // Replace with your actual patient table name
            }
            

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            try {
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_lab", "root", "");
                out.println(userType);
                out.println(password);
                Statement stmt = conn.createStatement();
                String query = "SELECT * FROM " + tableName + " WHERE username = '" + username + "' AND password = '" + password + "'";
                ResultSet rs = stmt.executeQuery(query);
                

                if (rs.next()) {
                    // User is valid, perform redirection or other actions
                    HttpSession sessionObj = request.getSession(true);

                    // Store user information in the session
                    sessionObj.setAttribute("userType", userType);
                    sessionObj.setAttribute("username", username);
                    
                    if(userType.equals("admin")){
                         response.sendRedirect("dash.jsp");
                    }
                    else{
                        response.sendRedirect("ReportList.jsp");
                    }
                        
                } else {
                    // User is not valid, display an error message or take appropriate action
                    out.println("<p style='color: red;'>Invalid username or password</p>");
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                out.println(e);
                e.printStackTrace();
            }
        }
    }
%>

<div class="container login-container">
    <h2 class="center-align">ABC Lab Appointment System</h2>
    
    <!-- Login Form -->
    <form action="index.jsp" method="post">
        <!-- Add a hidden field to pass the userType to the server -->
        
        <div class="input-field">
            <input type="text" id="username" name="username" class="validate" required>
            <label for="username">Username</label>
        </div>
        
        <div class="input-field">
            <input type="password" id="password" name="password" class="validate" required>
            <label for="password">Password</label>
        </div>
        
        <div class="input-field">
            <select id="userType" name="userType" required>
                <option value="" disabled selected>Select User Type</option>
                <option value="admin">Admin</option>
                <option value="patient">Patient</option>
            </select>
            <label for="userType">User Type</label>
        </div>
        
        <p class="center-align">
            <label>
                <input type="checkbox" id="rememberMe" />
                <span>Remember me</span>
            </label>
        </p>
        
        <div class="center-align">
            <button type="submit" class="btn waves-effect waves-light">Login<i class="material-icons right">send</i></button>
        </div>
    </form>

    <!-- Forgot Password Link -->
    <div class="center-align mt-3">
        <a href="#" style="color: #007bff;">Forgot Password?</a>
    </div>
</div>

<!-- Materialize JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var elems = document.querySelectorAll('select');
        var instances = M.FormSelect.init(elems);
    });
</script>

</body>
</html>
