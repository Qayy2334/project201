<%@ page import="java.util.List" %>
<%@ page import="com.shop.dao.ProductDAO" %>
<%@ page import="com.shop.model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>商品管理</title>
    <style>
        /* 页面整体样式 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 20px;
        }

        /* 返回首页按钮样式 */
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

        /* 表单样式 */
        .form-container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .form-container label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .form-container input,
        .form-container textarea,
        .form-container button {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-container button {
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }


        .form-container button:hover {
            background-color: #218838;
        }

        /* 商品列表样式 */
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


        /* 错误提示样式 */
        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
    <script>
        function deleteProduct(productId) {
            if (confirm('Are you sure you want to delete this product?')) {
                fetch('${pageContext.request.contextPath}/admin/ProductController', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: `action=delete&id=${productId}`
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.status === 'success') {
                            alert(data.message);
                            location.reload(); // 刷新页面
                        } else {
                            alert(data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('An unexpected error occurred!');
                    });
            }
        }
    </script>
    <script>
        function addProduct(event) {
            event.preventDefault(); // 阻止表单默认提交

            const formData = new FormData(document.getElementById('addProductForm'));

            fetch('${pageContext.request.contextPath}/admin/ProductController', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
                .then(response => response.json())
                .then(data => {
                    if (data.status === 'success') {
                        alert(data.message); // 显示成功提示
                        location.reload();   // 刷新页面
                    } else {
                        alert(data.message); // 显示错误提示
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An unexpected error occurred!');
                });
        }
    </script>
</head>

<body>

<!-- ✅ 返回首页按钮 -->
<a href="${pageContext.request.contextPath}/index.jsp" class="nav-button">🏠 Back to Homepage</a>

<h2 style="text-align: center;">📦 Product Management</h2>

<!-- ✅ 商品添加表单 -->
<div class="form-container">
    <h3>➕ Add new product</h3>
    <!-- 添加商品表单 -->
    <form id="addProductForm" method="post" action="${pageContext.request.contextPath}/admin/ProductController?action=add">
        <label for="name">Product Name:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="price">Price:</label>
        <input type="number" id="price" name="price" step="0.01" required><br><br>

        <label for="stock">Stock:</label>
        <input type="number" id="stock" name="stock" required><br><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" cols="50"></textarea><br><br>

        <button type="submit">Add Product</button>
    </form>


    <!-- ✅ 显示错误提示 -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <p class="error-message"><%= error %></p>
    <%
        }
    %>
</div>

<!-- ✅ 商品列表展示 -->
<h3 style="text-align: center;">📋 Product List</h3>
<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Price</th>
        <th>Actions</th>
    </tr>
    <%
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAllProducts();
        for (Product product : productList) {
    %>
    <tr>
        <td><%= product.getId() %></td>
        <td><%= product.getName() %></td>
        <td><%= product.getPrice() %></td>
        <td>
            <!-- 删除按钮部分 -->
            <form method="post" action="${pageContext.request.contextPath}/admin/ProductController?action=delete">
                <input type="hidden" name="id" value="<%= product.getId() %>">
                <button type="submit" onclick="return confirm('Are you sure you want to delete this product?');">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    %>
</table>

</body>
</html>
