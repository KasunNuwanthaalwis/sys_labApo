<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Lab Appointment System - Report Management</title>
    
    <!-- Material Design CSS -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@material/button@10.0.0/dist/mdc.button.min.css">
    
    <!-- Custom styles -->
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
        .content {
            margin-left: 250px;
            padding: 16px;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <a href="#" class="text-white">Dashboard</a>
    <a href="#" class="text-white">Patients</a>
    <a href="#" class="text-white">Appointments</a>
    <a href="#" class="text-white">Tests</a>
    <a href="#" class="text-white">Billing</a>
    <a href="#" class="text-white">Reports</a>
    <a href="#" class="text-white">Logout</a>
</div>

<!-- Page content -->
<div class="content">
    <h2>Report Management</h2>
    
    <!-- CRUD Operations -->
    <div class="mb-3">
        <button class="mdc-button mdc-button--raised mdc-button--primary" data-mdc-dialog-action="add">Add Report</button>
    </div>
    
    <!-- Table for Report List -->
    <table class="table">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Report Name</th>
                <th scope="col">Date Generated</th>
                <th scope="col">Actions</th>
            </tr>
        </thead>
        <tbody>
            <!-- Sample Report Data - Replace with dynamic data -->
            <tr>
                <th scope="row">1</th>
                <td>Monthly Summary</td>
                <td>2022-03-15</td>
                <td>
                    <button class="mdc-button mdc-button--raised mdc-button--success" data-mdc-dialog-action="view">View</button>
                    <button class="mdc-button mdc-button--raised mdc-button--warning" data-mdc-dialog-action="edit">Edit</button>
                    <button class="mdc-button mdc-button--raised mdc-button--danger" data-mdc-dialog-action="delete">Delete</button>
                </td>
            </tr>
            <!-- Add more rows as needed -->
        </tbody>
    </table>

    <!-- Add Report Modal -->
    <div class="mdc-dialog" id="addReportModal" role="alertdialog" aria-modal="true" aria-labelledby="addReportModalLabel">
        <!-- Modal content goes here -->
    </div>

    <!-- View Report Modal -->
    <div class="mdc-dialog" id="viewReportModal" role="alertdialog" aria-modal="true" aria-labelledby="viewReportModalLabel">
        <!-- Modal content goes here -->
    </div>

    <!-- Edit Report Modal -->
    <div class="mdc-dialog" id="editReportModal" role="alertdialog" aria-modal="true" aria-labelledby="editReportModalLabel">
        <!-- Modal content goes here -->
    </div>

    <!-- Delete Report Modal -->
    <div class="mdc-dialog" id="deleteReportModal" role="alertdialog" aria-modal="true" aria-labelledby="deleteReportModalLabel">
        <!-- Modal content goes here -->
    </div>
</div>

<!-- Material Design JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/@material/button@10.0.0/dist/mdc.button.min.js"></script>

</body>
</html>
