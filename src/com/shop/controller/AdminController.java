package com.shop.controller;

import com.shop.dao.UserDAO;
import com.shop.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/AdminController")
public class AdminController extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "login":
                adminLogin(request, response);
                break;
            case "deleteUser":
                deleteUser(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/admin_dashboard.jsp");
        }
    }


    /**
     * ✅ 管理员登录
     */
    private void adminLogin(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.loginUser(username, password);

        if (user != null && "admin".equals(user.getRole())) {
            HttpSession session = request.getSession();
            session.setAttribute("adminId", user.getId());
            session.setAttribute("admin", user.getUsername());


            response.sendRedirect(request.getContextPath() + "/admin/admin_dashboard.jsp");
        } else {
            request.setAttribute("error", "Wrong username or password！");
            request.getRequestDispatcher("/admin/admin_login.jsp").forward(request, response);
        }
    }


    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String userIdParam = request.getParameter("id");
            if (userIdParam == null || userIdParam.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/manage_users.jsp?error=Invalid user ID!");
                return;
            }

            int userId = Integer.parseInt(userIdParam);
            boolean success = userDAO.deleteUser(userId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/manage_users.jsp?success=User successfully deleted!");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage_users.jsp?error=Failed to delete user!");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/manage_users.jsp?error=Invalid user ID format!");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/manage_users.jsp?error=An error occurred while deleting user!");
        }
    }


}
