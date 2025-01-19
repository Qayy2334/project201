package com.shop.controller;

import com.shop.dao.ProductDAO;
import com.shop.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/ProductController")
public class ProductController extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
        }
    }

    /**
     * 添加商品
     */
    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {

            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            String description = request.getParameter("description");


            Product product = new Product();
            product.setName(name);
            product.setPrice(price);
            product.setStock(stock);
            product.setDescription(description);


            boolean success = productDAO.addProduct(product);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/manage_products.jsp?success=Product successfully added!");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage_products.jsp?error=Failed to add product!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/manage_products.jsp?error=An error occurred while adding the product!");
        }
    }




    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String productIdParam = request.getParameter("id");
            if (productIdParam == null || productIdParam.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/manage_products.jsp?error=Invalid product ID!");
                return;
            }

            int productId = Integer.parseInt(productIdParam);
            boolean success = productDAO.deleteProduct(productId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/manage_products.jsp?success=Product successfully deleted!");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage_products.jsp?error=Failed to delete product!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/manage_products.jsp?error=An error occurred while deleting the product!");
        }
    }


}
