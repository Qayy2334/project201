<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>管理员登录</title>
    <style>
        /* 页面整体样式 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin            : 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* 登录容器样式 */
        .login-container {
            background-color: #ffffff;
            padding: 40px 60px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 400px;
        }

        /* 标题样式 */
        .login-container h2 {
            margin-bottom: 20px;
            font-size: 28px;
            color: #333;
        }

        /* 输入框样式 */
        .login-container input {
            width: 100%;
            padding: 12px 15px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        /* 按钮样式 */
        .login-container button {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .login-container button:hover {
            background-color: #28a745;
        }

        /* 错误提示样式 */
        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>

<body>

<!-- ✅ 登录页面内容 -->
<div class="login-container">
    <h2>Admin Login</h2>

    <form method="post" action="${pageContext.request.contextPath}/admin/AdminController?action=login">
        <input type="text" id="username" name="username" placeholder="Admin Account" required>
        <input type="password" id="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>

    <!-- ✅ 错误提示信息 -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <p class="error-message"><%= error %></p>
    <%
        }
    %>
</div>

</body>
</html>

