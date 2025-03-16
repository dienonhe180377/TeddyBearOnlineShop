/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.CategoryDAO;
import dao.ProductCRUDDAO;
import dao.ProductDAO;
import dao.ProductTypeDAO;
import entity.Product;
import entity.ProductCRUD;
import entity.ProductImageCRUD;
import entity.SizeCRUD;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HP
 */
@WebServlet("/product-manage/*")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ProductManageController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductCRUDDAO productDAO;
    private String uploadPath;

    public void init() {
        productDAO = new ProductCRUDDAO();

        uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "/list";
        }
        action = "/" + action;

        switch (action) {
            case "/list": {
                try {
                    listProducts(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(ProductManageController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            case "/view": {
                try {
                    viewProduct(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(ProductManageController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            case "/new": {
                try {
                    showNewForm(request, response);
                } catch (Exception ex) {
                    System.out.println("Error: " + ex);
                }
            }
            break;

            case "/edit": {
                try {
                    showEditForm(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(ProductManageController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            case "/delete": {
                try {
                    deleteProduct(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(ProductManageController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            default: {
                try {
                    listProducts(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(ProductManageController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "/list";
        }
        action = "/" + action;
        switch (action) {
            case "/create": {
                try {
                    createProduct(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(ProductManageController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            case "/update": {
                try {
                    updateProduct(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(ProductManageController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            default: {
                try {
                    listProducts(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(ProductManageController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        List<ProductCRUD> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("./admin/product/list.jsp");
        dispatcher.forward(request, response);
    }

    private void viewProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        ProductCRUD product = productDAO.getProductById(id);
        request.setAttribute("product", product);
        RequestDispatcher dispatcher = request.getRequestDispatcher("./admin/product/view.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        request.setAttribute("categories", productDAO.getAllCategories());
        request.setAttribute("productTypes", productDAO.getAllProductTypes());
        RequestDispatcher dispatcher = request.getRequestDispatcher("./admin/product/form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        ProductCRUD product = productDAO.getProductById(id);
        request.setAttribute("product", product);
        request.setAttribute("categories", productDAO.getAllCategories());
        request.setAttribute("productTypes", productDAO.getAllProductTypes());
        RequestDispatcher dispatcher = request.getRequestDispatcher("./admin/product/form.jsp");
        dispatcher.forward(request, response);
    }

    private void createProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        // Get product details from form
        String name = request.getParameter("name");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int typeId = Integer.parseInt(request.getParameter("typeId"));
        String description = request.getParameter("description");
        String purchaseGuide = request.getParameter("purchaseGuide");
        String warrantyInfo = request.getParameter("warrantyInfo");

        // Create product object
        ProductCRUD product = new ProductCRUD();
        product.setName(name);
        product.setCategoryId(categoryId);
        product.setTypeId(typeId);
        product.setDescription(description);
        product.setPurchaseGuide(purchaseGuide);
        product.setWarrantyInfo(warrantyInfo);

        // Handle image uploads
        List<ProductImageCRUD> images = new ArrayList<>();
        for (Part part : request.getParts()) {
            if (part.getName().equals("productImage") && part.getSize() > 0) {
                String fileName = getFileName(part);
                String savedFileName = System.currentTimeMillis() + "_" + fileName;
                part.write(uploadPath + File.separator + savedFileName);

                ProductImageCRUD image = new ProductImageCRUD();
                image.setSource("uploads/" + savedFileName);
                images.add(image);
            }
        }
        product.setImages(images);

        // Handle sizes
        String[] sizeNames = request.getParameterValues("sizeName");
        String[] quantities = request.getParameterValues("quantity");
        String[] prices = request.getParameterValues("price");

        List<SizeCRUD> sizes = new ArrayList<>();
        if (sizeNames != null) {
            for (int i = 0; i < sizeNames.length; i++) {
                SizeCRUD size = new SizeCRUD();
                size.setName(sizeNames[i]);
                size.setQuantity(Integer.parseInt(quantities[i]));
                size.setPrice(Integer.parseInt(prices[i]));
                sizes.add(size);
            }
        }
        product.setSizes(sizes);

        // Save product
        productDAO.insertProduct(product);
        response.sendRedirect(request.getContextPath() + "/product-manage?action=list");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));

        // Get product details from form
        String name = request.getParameter("name");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int typeId = Integer.parseInt(request.getParameter("typeId"));
        String description = request.getParameter("description");
        String purchaseGuide = request.getParameter("purchaseGuide");
        String warrantyInfo = request.getParameter("warrantyInfo");

        // Get existing product
        ProductCRUD product = productDAO.getProductById(id);

        // Update product details
        product.setName(name);
        product.setCategoryId(categoryId);
        product.setTypeId(typeId);
        product.setDescription(description);
        product.setPurchaseGuide(purchaseGuide);
        product.setWarrantyInfo(warrantyInfo);

        // Handle image uploads
        List<ProductImageCRUD> images = new ArrayList<>();
        for (Part part : request.getParts()) {
            if (part.getName().equals("productImage") && part.getSize() > 0) {
                String fileName = getFileName(part);
                String savedFileName = System.currentTimeMillis() + "_" + fileName;
                part.write(uploadPath + File.separator + savedFileName);

                ProductImageCRUD image = new ProductImageCRUD();
                image.setSource("uploads/" + savedFileName);
                images.add(image);
            }
        }

        // Keep existing images if no new ones are uploaded
        if (images.isEmpty()) {
            images = product.getImages();
        }
        product.setImages(images);

        // Handle sizes
        String[] sizeIds = request.getParameterValues("sizeId");
        String[] sizeNames = request.getParameterValues("sizeName");
        String[] quantities = request.getParameterValues("quantity");
        String[] prices = request.getParameterValues("price");

        List<SizeCRUD> sizes = new ArrayList<>();
        if (sizeNames != null) {
            for (int i = 0; i < sizeNames.length; i++) {
                SizeCRUD size = new SizeCRUD();
                if (sizeIds != null && i < sizeIds.length) {
                    size.setId(Integer.parseInt(sizeIds[i]));
                }
                size.setName(sizeNames[i]);
                size.setQuantity(Integer.parseInt(quantities[i]));
                size.setPrice(Integer.parseInt(prices[i]));
                sizes.add(size);
            }
        }
        product.setSizes(sizes);

        // Update product
        productDAO.updateProduct(product);
        response.sendRedirect(request.getContextPath() + "/product-manage?action=list");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.deleteProduct(id);
        response.sendRedirect(request.getContextPath() + "/product-manage?action=list");
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}
