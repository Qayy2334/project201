<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shop.dao.ProductDAO" %>
<%@ page import="com.shop.model.Product" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>E-commerce Mall - Home</title>


    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }


        .header {
            background-color: #343a40;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .header a {
            color: white;
            margin: 0 15px;
            text-decoration: none;
            font-weight: bold;
        }

        .header a:hover {
            text-decoration: underline;
        }


        .product-container {
            width: 90%;
            margin: 40px auto;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }


        .product-card {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }

        .product-card:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .product-card h3 {
            margin-bottom: 10px;
            font-size: 20px;
            color: #333;
        }

        .product-card p {
            color: #666;
            margin: 8px 0;
        }


        .product-card button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .product-card button:hover {
            background-color: #218838;
        }

    </style>

    <!--  JavaScript -->
    <script>
        //  add to cart
        function addToCart(productId) {
            fetch("CartController?action=add", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "productId=" + productId
            })
                .then(response => response.text())
                .then(data => {
                    alert("The product has been added to the shopping cart!");
                })
                .catch(error => {
                    console.error("Failed to add to cart", error);
                });
        }

        // ✅ Not logged in user: Jump to the login page
        function redirectToLogin() {
            alert("Please login before adding to cart!");
            window.location.href = "login.jsp";
        }
    </script>
</head>

<body>

<!-- Top Navigation Bar -->
<div class="header">
    <div>
        <a href="index.jsp">🏠 Home</a>
        <a href="cart.jsp">🛒 Cart</a>
        <a href="${pageContext.request.contextPath}/admin/admin_login.jsp">🔒 Admin Login</a>
    </div>
    <div>
        <% if (session != null && session.getAttribute("user") != null) { %>
        <span>Welcome, <strong><%= session.getAttribute("user") %></strong>!</span>
        <a href="logout.jsp">🚪 Logout</a>
        <% } else { %>
        <a href="login.jsp">🔑 Login</a> |
        <a href="register.jsp">📝 Register</a>
        <% } %>
    </div>
</div>

<!-- Product display title -->
<h2 style="text-align: center; margin-top: 30px;">🛍️ Product Display</h2>

<!-- Product display area -->
<div class="product-container">
    <%
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAllProducts();

        for (Product product : productList) {
    %>
    <div class="product-card">
        <h3><%= product.getName() %></h3>
        <p>💲 Price: ¥<%= product.getPrice() %></p>
        <p>📦 Stock: <%= product.getStock() %> units</p>

        <!-- cart buttion -->
        <%
            if (session.getAttribute("userId") != null) {
        %>
        <button onclick="addToCart(<%= product.getId() %>)">Add to Cart</button>
        <%
        } else {
        %>
        <button onclick="redirectToLogin()">Add to Cart</button>
        <%
            }
        %>
    </div>
    <%
        }
    %>
</div>

</body>
</html>
