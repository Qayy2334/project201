<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>Admin Backend</title>
  <style>
    /* 页面整体样式 */
    body {
      font-family: Arial, sans-serif;
      background-color: #f0f2f5;
      margin: 0;
      padding: 0;
    }

    /* 顶部导航栏 */
    .navbar {
      background-color: #343a40;
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      color: white;
    }

    .navbar a {
      color: white;
      text-decoration: none;
      margin: 0 15px;
      font-weight: bold;
    }

    .navbar a:hover {
      text-decoration: underline;
    }

    /* 页面主体内容 */
    .container {
      text-align: center;
      margin-top: 100px;
    }

    .container h2 {
      font-size: 32px;
      color: #333;
      margin-bottom: 30px;
    }

    /* 功能按钮 */
    .menu {
      display: flex;
      justify-content: center;
      gap: 30px;
    }

    .menu a {
      display: inline-block;
      padding: 20px 40px;
      background-color: #007bff;
      color: white;
      text-decoration: none;
      border-radius: 8px;
      font-size: 18px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .menu a:hover {
      background-color: #0056b3;
      transform: translateY(-5px);
    }

    /* 登出按钮 */
    .logout-btn {
      background-color: #dc3545;
    }

    .logout-btn:hover {
      background-color: #c82333;
    }
  </style>
</head>

<body>

<!-- ✅ 顶部导航栏 -->
<div class="navbar">
  <div>🛠️ Admin Backend</div>
  <div>
    <a href="${pageContext.request.contextPath}/index.jsp">Back homepage</a>
    <a href="${pageContext.request.contextPath}/logout.jsp" class="logout-btn">Logout</a>
  </div>
</div>

<!-- ✅ 页面主体内容 -->
<div class="container">
  <h2>Welcome, Administrator！</h2>

  <!-- ✅ 功能菜单 -->
  <div class="menu">
    <a href="${pageContext.request.contextPath}/admin/manage_products.jsp">📦 Product Management</a>
    <a href="${pageContext.request.contextPath}/admin/manage_users.jsp">👥 User Management</a>
  </div>
</div>

</body>
</html>
