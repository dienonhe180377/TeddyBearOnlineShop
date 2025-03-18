package controller;

import dao.ProductDAO;
import entity.CartItem;
import entity.Product;
import entity.Size;
import entity.User;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("notificationErr", "Please login first!");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.getRequestDispatcher("jsp/cart.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        try {
            if (null == action) {
                // Nếu không có action, hiển thị trang giỏ hàng
                request.getRequestDispatcher("cart").forward(request, response);
            } else {
                switch (action) {
                    case "add" -> {
                        // Lấy thông tin sản phẩm, kích cỡ và số lượng từ request
                        int productId = Integer.parseInt(request.getParameter("productId"));
                        String sizeName = request.getParameter("size");
                        int quantity = Integer.parseInt(request.getParameter("quantity"));
                        // Lấy thông tin sản phẩm từ DAO
                        ProductDAO productDAO = new ProductDAO();
                        Product product = productDAO.getProductById(productId);
                        // Tìm đối tượng Size tương ứng với sizeName đã chọn
                        Size selectedSize = null;
                        for (Size s : product.getSizes()) {
                            if (s.getName().equals(sizeName)) {
                                selectedSize = s;
                                break;
                            }
                        }
                        if (selectedSize != null) {
                            boolean found = false;
                            // Nếu sản phẩm đã có trong giỏ với cùng kích cỡ thì tăng số lượng
                            for (CartItem item : cart) {
                                if (item.getProduct().getId() == productId
                                        && item.getSize().getName().equals(sizeName)) {
                                    item.setQuantity(item.getQuantity() + quantity);
                                    found = true;
                                    break;
                                }
                            }
                            // Nếu chưa có thì thêm mới
                            if (!found) {
                                cart.add(new CartItem(product, selectedSize, quantity));
                            }
                        }

                        int cartCount = (cart != null) ? cart.size() : 0;
                        session.setAttribute("cart", cart);
                        session.setAttribute("cartCount", cartCount);
                        response.sendRedirect("cart"); // chuyển hướng về trang giỏ hàng
                    }
                    case "update" -> {
                        // Cập nhật số lượng cho mục giỏ hàng
                        int index = Integer.parseInt(request.getParameter("index"));
                        int quantity = Integer.parseInt(request.getParameter("quantity"));
                        if (index >= 0 && index < cart.size()) {
                            if (quantity <= 0) {
                                // Nếu số lượng <= 0, xóa mục khỏi giỏ
                                cart.remove(index);
                            } else {
                                cart.get(index).setQuantity(quantity);
                            }
                        }

                        session.setAttribute("cart", cart);
                        int cartCount = (cart != null) ? cart.size() : 0;
                        session.setAttribute("cartCount", cartCount);
                        response.sendRedirect("cart");
                    }
                    case "remove" -> {
                        // Xóa mục khỏi giỏ hàng
                        int index = Integer.parseInt(request.getParameter("index"));
                        if (index >= 0 && index < cart.size()) {
                            cart.remove(index);
                        }
                        session.setAttribute("cart", cart);
                        int cartCount = (cart != null) ? cart.size() : 0;
                        session.setAttribute("cartCount", cartCount);
                        response.sendRedirect("cart");
                    }
                    default -> // Nếu không có action, hiển thị trang giỏ hàng
                        request.getRequestDispatcher("jsp/cart.jsp").forward(request, response);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
