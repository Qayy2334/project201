<%@ page import="java.util.List" %>
<%@ page import="com.shop.dao.CartDAO" %>
<%@ page import="com.shop.model.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        button {
            padding: 5px 10px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #c82333;
        }

        .pay-container {
            width: 80%;
            margin: 20px auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-price {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .pay-button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        .pay-button:hover {
            background-color: #218838;
        }
    </style>

    <script>
        //
        function removeFromCart(cartItemId) {
            fetch("CartController?action=remove", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "cartItemId=" + cartItemId
            }).then(() => {
                //
                location.reload();
            }).catch(() => {
                console.error("Deletion failed！");
            });
        }
    </script>
</head>

<body>
<h2>My Cart</h2>

<%
    if (session != null && session.getAttribute("userId") != null) {
        int userId = (Integer) session.getAttribute("userId");
        CartDAO cartDAO = new CartDAO();
        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        double totalPrice = 0; //calculate the price

        if (cartItems.isEmpty()) {
%>
<p>Your cart is empty</p>
<%
} else {
%>
<table border="1">
    <tr>
        <th>Product Name</th>
        <th>Quantity</th>
        <th>Price</th>
        <th>Subtotal</th>
        <th>Action</th>
    </tr>
    <%
        for (CartItem item : cartItems) {
            double subtotal = item.getQuantity() * item.getPrice();
            totalPrice += subtotal;
    %>
    <tr>
        <td><%= item.getProductName() %></td>
        <td><%= item.getQuantity() %></td>
        <td>¥<%= String.format("%.2f", item.getPrice()) %></td>
        <td>¥<%= String.format("%.2f", subtotal) %></td>
        <td>
            <button type="button" onclick="removeFromCart(<%= item.getId() %>)">Delete</button>
        </td>
    </tr>
    <%
        }
    %>
</table>

<div class="pay-container">
    <div class="total-price">Total Price: ¥<%= String.format("%.2f", totalPrice) %></div>
    <button class="pay-button">Pay</button>
</div>
<%
    }
} else {
%>
<p>Please <a href="login.jsp">login</a> before checking the cart</p>
<%
    }
%>

</body>
</html>
