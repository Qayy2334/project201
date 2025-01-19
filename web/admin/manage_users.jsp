<%@ page import="java.util.List" %>
<%@ page import="com.shop.dao.UserDAO" %>
<%@ page import="com.shop.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <style>
        /* Page layout */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 20px;
        }

        /* Navigation button */
        .nav-button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin-bottom: 20px;
        }

        .nav-button:hover {
            background-color: #0056b3;
        }

        /* Table styling */
        table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        /* Delete button */
        .delete-button {
            padding: 8px 16px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .delete-button:hover {
            background-color: #c82333;
        }

        /* Success and error messages */
        .success-message {
            color: green;
            text-align: center;
            margin-top: 10px;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>

<body>

<!-- ✅ Navigation button -->
<a href="${pageContext.request.contextPath}/index.jsp" class="nav-button">🏠 Back to Homepage</a>

<h2 style="text-align: center;">👥 User Management</h2>

<!-- ✅ Success or error message -->
<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");

    if (success != null) {
%>
<p class="success-message"><%= success %></p>
<%
    }

    if (error != null) {
%>
<p class="error-message"><%= error %></p>
<%
    }
%>

<!-- ✅ User table -->
<table>
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Role</th>
        <th>Actions</th>
    </tr>

    <%
        UserDAO userDAO = new UserDAO();
        List<User> userList = userDAO.getAllUsers();

        for (User user : userList) {
    %>
    <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getUsername() %></td>
        <td><%= user.getRole() %></td>
        <td>
            <!-- ✅ Delete user button -->
            <form method="post" action="${pageContext.request.contextPath}/admin/AdminController?action=deleteUser">
                <input type="hidden" name="id" value="<%= user.getId() %>">
                <button type="submit" onclick="return confirm('Are you sure you want to delete this user?');">🗑️ Delete</button>
            </form>

        </td>
    </tr>
    <%
        }
    %>
</table>

</body>
</html>
