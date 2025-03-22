/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.ProductTypeDAO;
import dao.SettingDAO;
import dao.UserDAO;
import entity.Category;
import entity.Product;
import entity.ProductType;
import entity.Setting;
import entity.User;
import entity.UserRole;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class SettingController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String service = request.getParameter("service");
            SettingDAO settingDAO = new SettingDAO();
            ProductTypeDAO typeDAO = new ProductTypeDAO();
            CategoryDAO categoryDAO = new CategoryDAO();
            UserDAO userDAO = new UserDAO();
            ProductDAO productDAO = new ProductDAO();

            //Lấy tất cả setting
            if (service.equalsIgnoreCase("allSetting")) {

                String settingType = request.getParameter("type");

                if (settingType.equals("setting")) {
                    List<Setting> settings = settingDAO.getAllSetting();
                    request.setAttribute("settings", settings);
                }

                if (settingType.equals("productType")) {
                    List<ProductType> productTypes = typeDAO.getAllProductTypes();
                    request.setAttribute("productTypes", productTypes);
                }

                if (settingType.equals("category")) {
                    List<Category> categoryList = categoryDAO.getAllCategory();
                    request.setAttribute("categoryList", categoryList);
                }

                if (settingType.equals("role")) {
                    List<UserRole> userRoles = userDAO.getAllUserRole();
                    request.setAttribute("userRoles", userRoles);
                }

                request.setAttribute("settingType", settingType);
                request.getRequestDispatcher("jsp/settingList.jsp").forward(request, response);
            }

            //Trường filter cho setting list
            if (service.equalsIgnoreCase("filterBy")) {
                String filter = request.getParameter("filter");
                String type = request.getParameter("type");
                String valueChoosen = request.getParameter("valueChoosen");

                if (valueChoosen.equals("all")) {
                    request.setAttribute("choosenValue", "all");
                } else if (valueChoosen.equals("active")) {
                    request.setAttribute("choosenValue", "active");
                } else {
                    request.setAttribute("choosenValue", "inactive");
                }

                if (filter.equalsIgnoreCase("active")) {

                    if (type.equals("setting")) {
                        List<Setting> settings = settingDAO.getAllSetting();
                        for (int i = 0; i < settings.size(); i++) {
                            if (!settings.get(i).isStatus()) {
                                settings.remove(i);
                            }
                        }
                        request.setAttribute("settingType", "setting");
                        request.setAttribute("settings", settings);
                    }
                    if (type.equals("productType")) {
                        List<ProductType> productTypes = typeDAO.getAllActiveProductTypes();
                        request.setAttribute("settingType", "productType");
                        request.setAttribute("productTypes", productTypes);
                    }
                    if (type.equals("category")) {
                        List<Category> categoryList = categoryDAO.getAllActiveCategory();
                        request.setAttribute("settingType", "category");
                        request.setAttribute("categoryList", categoryList);
                    }
                    if (type.equals("role")) {
                        List<UserRole> userRoles = userDAO.getAllActiveUserRole();
                        request.setAttribute("settingType", "role");
                        request.setAttribute("userRoles", userRoles);
                    }

                }

                if (filter.equalsIgnoreCase("inactive")) {
                    if (type.equals("setting")) {
                        List<Setting> settings = settingDAO.getAllInactiveSetting();
                        request.setAttribute("settingType", "setting");
                        request.setAttribute("settings", settings);
                    }
                    if (type.equals("productType")) {
                        List<ProductType> productTypes = typeDAO.getAllInactiveProductTypes();
                        request.setAttribute("settingType", "productType");
                        request.setAttribute("productTypes", productTypes);
                    }
                    if (type.equals("category")) {
                        List<Category> categoryList = categoryDAO.getAllInactiveCategory();
                        request.setAttribute("settingType", "category");
                        request.setAttribute("categoryList", categoryList);
                    }
                    if (type.equals("role")) {
                        List<UserRole> userRoles = userDAO.getAllInactiveUserRole();
                        request.setAttribute("settingType", "role");
                        request.setAttribute("userRoles", userRoles);
                    }

                }

                request.getRequestDispatcher("jsp/settingList.jsp").forward(request, response);
            }

            //Tìm kiếm setting theo text
            if (service.equalsIgnoreCase("search")) {
                String text = request.getParameter("search");
                String settingType = request.getParameter("searchType");

                if (text.equalsIgnoreCase("Gấu")) {
                    text = "Gau";
                } else if (text.equalsIgnoreCase("Chó")) {
                    text = "Cho";
                } else if (text.equalsIgnoreCase("Mèo")) {
                    text = "Meo";
                }

                if (settingType.equals("setting")) {
                    List<Setting> settings = settingDAO.getAllSettingByText(text);
                    request.setAttribute("settings", settings);
                }

                if (settingType.equals("productType")) {
                    List<ProductType> productTypes = typeDAO.getAllProductTypesByText(text);
                    request.setAttribute("productTypes", productTypes);
                }

                if (settingType.equals("category")) {
                    List<Category> categoryList = categoryDAO.getAllCategoryByText(text);
                    request.setAttribute("categoryList", categoryList);
                }

                if (settingType.equals("role")) {
                    List<UserRole> userRoles = userDAO.getAllUserRoleByText(text);
                    request.setAttribute("userRoles", userRoles);
                }

                request.setAttribute("inputted", text);
                request.setAttribute("settingType", settingType);
                request.getRequestDispatcher("jsp/settingList.jsp").forward(request, response);
            }

            //Chuyển hướng đến Add Setting
            if (service.equalsIgnoreCase("addSettingRedirect")) {
                String settingType = request.getParameter("type");

                if (settingType.equals("productType")) {
                    request.setAttribute("type", "productType");
                }

                if (settingType.equals("category")) {
                    request.setAttribute("type", "category");
                }

                if (settingType.equals("role")) {
                    request.setAttribute("type", "role");
                }

                request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
            }

            //Thêm setting mới
            if (service.equalsIgnoreCase("addSetting")) {

                String settingName = request.getParameter("settingName");
                String content = request.getParameter("settingValue");
                String status = request.getParameter("settingStatus");
                String destription = request.getParameter("settingDescription");

                if (settingName.equals("category")) {
                    if (status.equals("active")) {
                        boolean duplicateCheck = categoryDAO.checkCategoryExisted(content);
                        if (duplicateCheck) {
                            request.setAttribute("inputtedValue", content);
                            request.setAttribute("type", "category");
                            request.setAttribute("duplicateMessage", "Category Duplicated!!");
                            request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                        } else {
                            categoryDAO.addCategory(content, true);
                            Category newCategory = categoryDAO.getAllCategoryByText(content).get(0);
                            request.setAttribute("successMessage", "Category Add Successfully!");
                            request.setAttribute("type", settingName);
                            request.setAttribute("valueCheck", newCategory);
                            request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                        }
                    } else {
                        boolean duplicateCheck = categoryDAO.checkCategoryExisted(content);
                        if (duplicateCheck) {
                            request.setAttribute("inputtedValue", content);
                            request.setAttribute("type", "category");
                            request.setAttribute("duplicateMessage", "Category Duplicated!!");
                            request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                        } else {
                            categoryDAO.addCategory(content, false);
                            Category newCategory = categoryDAO.getAllCategoryByText(content).get(0);
                            request.setAttribute("successMessage", "Category Add Successfully!");
                            request.setAttribute("type", settingName);
                            request.setAttribute("valueCheck", newCategory);
                            request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                        }
                    }
                } else if (settingName.equals("productType")) {
                    if (status.equals("active")) {
                        boolean duplicateCheck = typeDAO.checkProductTypeExisted(content);
                        if (duplicateCheck) {
                            request.setAttribute("inputtedValue", content);
                            request.setAttribute("type", "productType");
                            request.setAttribute("duplicateMessage", "Type Duplicated!!");
                            request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                        } else {
                            typeDAO.addProductType(content, true);
                            ProductType newType = typeDAO.getAllProductTypesByText(content).get(0);
                            request.setAttribute("successMessage", "Product Type Add Successfully!");
                            request.setAttribute("type", settingName);
                            request.setAttribute("valueCheck", newType);
                            request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                        }
                    } else {
                        boolean duplicateCheck = typeDAO.checkProductTypeExisted(content);
                        if (duplicateCheck) {
                            request.setAttribute("inputtedValue", content);
                            request.setAttribute("type", "productType");
                            request.setAttribute("duplicateMessage", "Type Duplicated!!");
                            request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                        } else {
                            typeDAO.addProductType(content, false);
                            ProductType newType = typeDAO.getAllProductTypesByText(content).get(0);
                            request.setAttribute("successMessage", "Product Type Add Successfully!");
                            request.setAttribute("type", settingName);
                            request.setAttribute("valueCheck", newType);
                            request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                        }
                    }
                } else {
                    if (status.equals("active")) {
                        boolean duplicateCheck = userDAO.checkRoleExisted(content);
                        if (duplicateCheck) {
                            request.setAttribute("inputtedValue", content);
                            request.setAttribute("type", "role");
                            request.setAttribute("duplicateMessage", "Role Duplicated!!");
                            request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                        } else {
                            userDAO.addUserRole(content, true);
                            UserRole newRole = userDAO.getAllUserRoleByText(content).get(0);
                            request.setAttribute("successMessage", "Role Add Successfully!");
                            request.setAttribute("type", settingName);
                            request.setAttribute("valueCheck", newRole);
                            request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                        }
                    } else {
                        boolean duplicateCheck = userDAO.checkRoleExisted(content);
                        if (duplicateCheck) {
                            request.setAttribute("inputtedValue", content);
                            request.setAttribute("type", "role");
                            request.setAttribute("duplicateMessage", "Role Duplicated!!");
                            request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                        } else {
                            userDAO.addUserRole(content, false);
                            UserRole newRole = userDAO.getAllUserRoleByText(content).get(0);
                            request.setAttribute("successMessage", "Role Add Successfully!");
                            request.setAttribute("type", settingName);
                            request.setAttribute("valueCheck", newRole);
                            request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                        }
                    }
                }
            }

            //Edit setting Redirect
            if (service.equalsIgnoreCase("editSettingRedirect")) {
                String type = request.getParameter("type");
                int id = Integer.parseInt(request.getParameter("id"));

                if (type.equalsIgnoreCase("setting")) {
                    Setting setting = settingDAO.getSettingById(id);
                    request.setAttribute("type", type);
                    request.setAttribute("settingCheck", setting);
                } else if (type.equalsIgnoreCase("category")) {
                    Category category = categoryDAO.getCategoryById(id);
                    request.setAttribute("type", type);
                    request.setAttribute("valueCheck", category);
                } else if (type.equalsIgnoreCase("productType")) {
                    ProductType productType = typeDAO.getProductTypeById(id);
                    request.setAttribute("type", type);
                    request.setAttribute("valueCheck", productType);
                } else {
                    UserRole role = userDAO.getRoleById(id);
                    request.setAttribute("type", type);
                    request.setAttribute("valueCheck", role);
                }
                request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
            }

            //Edit a setting
            if (service.equalsIgnoreCase("editSetting")) {
                String type = request.getParameter("type");
                int id = Integer.parseInt(request.getParameter("id"));
                String content = request.getParameter("settingValue");
                String settingStatus = request.getParameter("settingStatus");
                String description = request.getParameter("settingDescription");

                boolean status;
                if (settingStatus.equals("active")) {
                    status = true;
                } else {
                    status = false;
                }

                if (type.equalsIgnoreCase("setting")) {
                    Setting settingCheck = settingDAO.getSettingById(id);
                    boolean checkDup = settingDAO.checkSettingExisted(content);

                    if (settingCheck.getContent().equalsIgnoreCase(content)) {
                        checkDup = false;
                    }

                    if (checkDup) {
                        Setting setting = settingDAO.getSettingById(id);
                        request.setAttribute("type", type);
                        request.setAttribute("settingCheck", setting);
                        request.setAttribute("duplicateMessage", "Setting Duplicated!!");
                    } else {
                        int checkSuccess = settingDAO.editSetting(id, content, status, description);
                        Setting setting = settingDAO.getSettingById(id);
                        request.setAttribute("type", type);
                        request.setAttribute("settingCheck", setting);
                        if (checkSuccess >= 1) {
                            request.setAttribute("successMessage", "Setting Edited Successfully!");
                        } else {
                            request.setAttribute("duplicateMessage", "Setting Edited Failed!");
                        }
                    }
                }

                if (type.equalsIgnoreCase("productType")) {
                    ProductType typeCheck = typeDAO.getProductTypeById(id);
                    boolean checkDup = typeDAO.checkProductTypeExisted(content);

                    if (typeCheck.getName().equalsIgnoreCase(content)) {
                        checkDup = false;
                    }

                    if (checkDup) {
                        ProductType productType = typeDAO.getProductTypeById(id);
                        request.setAttribute("type", type);
                        request.setAttribute("valueCheck", productType);
                        request.setAttribute("duplicateMessage", "Type Duplicated!!");
                    } else {
                        int checkSuccess = typeDAO.editType(id, content, status);
                        ProductType productType = typeDAO.getProductTypeById(id);
                        request.setAttribute("type", type);
                        request.setAttribute("valueCheck", productType);
                        if (checkSuccess >= 1) {
                            request.setAttribute("successMessage", "Type Edited Successfully!");
                        } else {
                            request.setAttribute("duplicateMessage", "Type Edited Failed!");
                        }
                    }
                }

                if (type.equalsIgnoreCase("category")) {
                    Category categoryCheck = categoryDAO.getCategoryById(id);
                    boolean checkDup = categoryDAO.checkCategoryExisted(content);

                    if (categoryCheck.getName().equalsIgnoreCase(content)) {
                        checkDup = false;
                    }

                    if (checkDup) {
                        Category category = categoryDAO.getCategoryById(id);
                        request.setAttribute("type", type);
                        request.setAttribute("valueCheck", category);
                        request.setAttribute("duplicateMessage", "Category Duplicated!!");
                    } else {
                        int checkSuccess = categoryDAO.editCategory(id, content, status);
                        Category category = categoryDAO.getCategoryById(id);
                        request.setAttribute("type", type);
                        request.setAttribute("valueCheck", category);
                        if (checkSuccess >= 1) {
                            request.setAttribute("successMessage", "Category Edited Successfully!");
                        } else {
                            request.setAttribute("duplicateMessage", "Category Edited Failed!");
                        }
                    }
                }

                if (type.equalsIgnoreCase("role")) {
                    UserRole roleCheck = userDAO.getRoleById(id);
                    boolean checkDup = userDAO.checkRoleExisted(content);

                    if (roleCheck.getName().equalsIgnoreCase(content)) {
                        checkDup = false;
                    }

                    if (checkDup) {
                        UserRole role = userDAO.getRoleById(id);
                        request.setAttribute("type", type);
                        request.setAttribute("valueCheck", role);
                        request.setAttribute("duplicateMessage", "Role Duplicated!!");
                    } else {
                        int checkSuccess = userDAO.editUserRole(id, content, status);
                        UserRole role = userDAO.getRoleById(id);
                        request.setAttribute("type", type);
                        request.setAttribute("valueCheck", role);
                        if (checkSuccess >= 1) {
                            request.setAttribute("successMessage", "Role Edited Successfully!");
                        } else {
                            request.setAttribute("duplicateMessage", "Role Edited Failed!");
                        }
                    }
                }

                request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
            }

            if (service.equalsIgnoreCase("delete")) {
                String type = request.getParameter("type");
                int id = Integer.parseInt(request.getParameter("id"));
                if (type.equalsIgnoreCase("category")) {
                    List<Product> products = productDAO.getProductByCategory(id);
                    if (products.size() == 0) {
                        categoryDAO.deleteCategory(id);
                        List<Category> categoryList = categoryDAO.getAllCategory();
                        request.setAttribute("categoryList", categoryList);
                        request.setAttribute("settingType", type);
                        request.getRequestDispatcher("jsp/settingList.jsp").forward(request, response);
                    } else {
                        Category category = categoryDAO.getCategoryById(id);
                        request.setAttribute("type", type);
                        request.setAttribute("valueCheck", category);
                        request.setAttribute("duplicateMessage", "This category have a product!!");
                        request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                    }
                } else if (type.equalsIgnoreCase("productType")) {
                    List<Product> products = productDAO.getProductByType(id);
                    if (products.size() == 0) {
                        typeDAO.deleteType(id);
                        List<ProductType> productTypes = typeDAO.getAllProductTypes();
                        request.setAttribute("productTypes", productTypes);
                        request.setAttribute("settingType", type);
                        request.getRequestDispatcher("jsp/settingList.jsp").forward(request, response);
                    } else {
                        ProductType productType = typeDAO.getProductTypeById(id);
                        request.setAttribute("type", type);
                        request.setAttribute("valueCheck", productType);
                        request.setAttribute("duplicateMessage", "This type have a product!!");
                        request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                    }
                } else {
                    List<User> users = userDAO.getUsersByRole(id);
                    if (users.size() == 0) {
                        userDAO.deleteUserRole(id);
                        List<UserRole> userRoles = userDAO.getAllUserRole();
                        request.setAttribute("userRoles", userRoles);
                        request.setAttribute("settingType", type);
                        request.getRequestDispatcher("jsp/settingList.jsp").forward(request, response);
                    } else {
                        UserRole role = userDAO.getRoleById(id);
                        request.setAttribute("type", type);
                        request.setAttribute("valueCheck", role);
                        request.setAttribute("duplicateMessage", "This role have an user!!");
                        request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
                    }
                }
            }

        } catch (Exception ex) {
            Logger.getLogger(SettingController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
