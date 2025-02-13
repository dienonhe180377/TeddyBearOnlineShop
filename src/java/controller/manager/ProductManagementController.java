package controller.manager;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.ProductTypeDAO;
import entity.Category;
import entity.Product;
import entity.ProductType;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Product Management Controller
 */
@WebServlet(name = "ProductManagementController", urlPatterns = {"/manager/product-management"})
public class ProductManagementController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final ProductTypeDAO productTypeDAO = new ProductTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters for search, filter, and pagination
        String search = request.getParameter("search");
        String categoryIdStr = request.getParameter("categoryId");
        String typeIdStr = request.getParameter("typeId");
        String priceRange = request.getParameter("priceRange");
        String pageStr = request.getParameter("page");

        Integer categoryId = categoryIdStr != null && !categoryIdStr.isEmpty() ? Integer.parseInt(categoryIdStr) : null;
        Integer typeId = typeIdStr != null && !typeIdStr.isEmpty() ? Integer.parseInt(typeIdStr) : null;
        Integer minPrice = null, maxPrice = null;

        if (priceRange != null && !priceRange.isEmpty()) {
            if (priceRange.equals("1000+")) {
                minPrice = 1000;
            } else {
                String[] priceParts = priceRange.split("-");
                minPrice = Integer.parseInt(priceParts[0]);
                maxPrice = Integer.parseInt(priceParts[1]);
            }
        }

        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 12;

        // Get filtered and paginated products
        List<Product> allProducts = productDAO.getProductsWithParam(search, categoryId, typeId, minPrice, maxPrice);
        int totalProducts = allProducts.size();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        List<Product> paginatedProducts = productDAO.Paging(allProducts, page, pageSize);

        // Get categories and product types for dropdowns
        List<Category> categories = categoryDAO.getAllCategories();
        List<ProductType> productTypes = productTypeDAO.getAllProductTypes();

        // Set attributes for JSP
        request.setAttribute("products", paginatedProducts);
        request.setAttribute("categories", categories);
        request.setAttribute("productTypes", productTypes);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Preserve filter parameters
        request.setAttribute("search", search);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("typeId", typeId);
        request.setAttribute("priceRange", priceRange);

        request.getRequestDispatcher("product-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Retrieve form parameters for adding a product
        try {

            String name = request.getParameter("name");
            String image = request.getParameter("image");
            String description = request.getParameter("description");
            String quantityStr = request.getParameter("quantity");
            String priceStr = request.getParameter("price");
            String categoryIdStr = request.getParameter("categoryId");
            String typeIdStr = request.getParameter("typeId");
            System.out.println(categoryIdStr);
            int quantity = Integer.parseInt(quantityStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            int typeId = Integer.parseInt(typeIdStr);

            System.out.println(categoryId);
            // Create new product
            Product newProduct = new Product();
            newProduct.setName(name);
            newProduct.setImage(image);
            newProduct.setDescription(description);
            newProduct.setQuantity(quantity);
            newProduct.setPrice(priceStr);
            newProduct.setCategory(categoryDAO.getById(categoryId));
            newProduct.setProductType(productTypeDAO.getById(typeId));
            System.out.println(newProduct);
            // Save product to database
            productDAO.addProduct(newProduct);
            session.setAttribute("notification", "Product added successfully!");
        } catch (Exception e) {
            session.setAttribute("notificationErr", "Error adding product: " + e.getMessage());
        }
        response.sendRedirect("product-management");

    }
}
