package com.shop.dao;

import com.shop.model.Product;
import com.shop.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    /**
     * 获取所有商品
     */
    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM products";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setDescription(rs.getString("description"));
                productList.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return productList;
    }

    /**
     * 添加商品
     */
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (name, price, stock, description) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getStock());
            ps.setString(4, product.getDescription());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }



    /**
     * 根据 ID 删除商品
     */
    public boolean deleteProduct(int id) {
        // SQL 删除语句
        String deleteCartItemsSQL = "DELETE FROM cart_items WHERE product_id = ?";
        String deleteProductSQL = "DELETE FROM products WHERE id = ?";

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement psCart = conn.prepareStatement(deleteCartItemsSQL);
                 PreparedStatement psProduct = conn.prepareStatement(deleteProductSQL)) {


                psCart.setInt(1, id);
                int cartRows = psCart.executeUpdate();
                System.out.println("Deleted " + cartRows + " rows from cart_items for product_id=" + id);

                // delete product
                psProduct.setInt(1, id);
                int productRows = psProduct.executeUpdate();
                System.out.println("Deleted " + productRows + " rows from products for id=" + id);


                conn.commit();

                return productRows > 0;
            } catch (Exception e) {
                conn.rollback();
                System.err.println("Transaction rollback due to an error:");
                e.printStackTrace();
            }
        } catch (Exception e) {
            System.err.println("Database connection or query error:");
            e.printStackTrace();
        }
        return false;
    }




    /**
     * 根据 ID 获取商品信息
     */
    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        Product product = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setDescription(rs.getString("description"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return product;
    }

    public List<Product> getProductsByCategory(String category) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setDescription(rs.getString("description"));
                productList.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return productList;
    }


    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET name = ?, price = ?, stock = ?, description = ? WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getStock());
            ps.setString(4, product.getDescription());
            ps.setInt(5, product.getId());

            int result = ps.executeUpdate();

            if (result > 0) {
                System.out.println("Product ID " + product.getId() + " success");
                return true;
            } else {
                System.out.println("Product ID " + product.getId() + " failed");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return false;
    }
}
