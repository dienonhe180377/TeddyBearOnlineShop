/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDAO;
import entity.Size;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

@WebServlet("/api/product-sizes")
public class ProductSizesApiServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");
        response.setContentType("application/json");

        try {
            int productId = Integer.parseInt(productIdStr);
            ArrayList<Size> sizes = productDAO.getProductSizes(productId);

            // Convert to JSON using your preferred method
            // Example with simple manual JSON:
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < sizes.size(); i++) {
                Size size = sizes.get(i);
                json.append("{\"id\":").append(size.getId())
                        .append(",\"name\":\"").append(size.getName()).append("\"")
                        .append(",\"quantity\":").append(size.getQuantity())
                        .append(",\"price\":\"").append(size.getPrice()).append("\"")
                        .append("}");

                if (i < sizes.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");

            response.getWriter().write(json.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}
