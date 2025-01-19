package com.shop.controller;

import com.shop.dao.CartDAO;
import com.shop.model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/CartController")
public class CartController extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addToCart(request, response);
        } else if ("remove".equals(action)) {
            removeFromCart(request, response);
        }
    }

    /**
     * 添加商品到购物车
     */
    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        int productId = Integer.parseInt(request.getParameter("productId"));

        CartItem item = new CartItem();
        item.setUserId(userId);
        item.setProductId(productId);
        item.setQuantity(1);

        cartDAO.addToCart(item);

    }



    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String cartItemIdStr = request.getParameter("cartItemId");

        if (cartItemIdStr == null || cartItemIdStr.isEmpty()) {
            return;
        }

        int cartItemId = Integer.parseInt(cartItemIdStr);

        cartDAO.removeFromCart(cartItemId);
    }
}
