/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.ProductTypeDAO;
import dao.SettingDAO;
import dao.UserDAO;
import entity.Category;
import entity.ProductType;
import entity.Setting;
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

            if (service.equalsIgnoreCase("allSetting")) {
                List<Setting> settings = settingDAO.getAllSetting();
                List<ProductType> productTypes = typeDAO.getAllProductTypes();
                List<Category> categoryList = categoryDAO.getAllCategory();
                List<UserRole> userRoles = userDAO.getAllUserRole();

                request.setAttribute("settings", settings);
                request.setAttribute("productTypes", productTypes);
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("userRoles", userRoles);

                request.getRequestDispatcher("jsp/settingList.jsp").forward(request, response);
            }

            if (service.equalsIgnoreCase("filterBy")) {
                String filter = request.getParameter("filter");

                if (filter.equalsIgnoreCase("roles")) {
                    List<UserRole> userRoles = userDAO.getAllUserRole();
                    request.setAttribute("userRoles", userRoles);
                }

                if (filter.equalsIgnoreCase("categorys")) {
                    List<Category> categoryList = categoryDAO.getAllCategory();
                    request.setAttribute("categoryList", categoryList);
                }

                if (filter.equalsIgnoreCase("types")) {
                    List<ProductType> productTypes = typeDAO.getAllProductTypes();
                    request.setAttribute("productTypes", productTypes);
                }

                if (filter.equalsIgnoreCase("active")) {
                    List<Setting> settings = settingDAO.getAllSetting();
                    List<ProductType> productTypes = typeDAO.getAllProductTypes();
                    List<Category> categoryList = categoryDAO.getAllCategory();
                    List<UserRole> userRoles = userDAO.getAllUserRole();
                    for (int i = 0; i < settings.size(); i++) {
                        if (!settings.get(i).isStatus()) {
                            settings.remove(i);
                        }
                    }
                    for (int i = 0; i < productTypes.size(); i++) {
                        if (!productTypes.get(i).isStatus()) {
                            productTypes.remove(i);
                        }
                    }
                    for (int i = 0; i < categoryList.size(); i++) {
                        if (!categoryList.get(i).isStatus()) {
                            categoryList.remove(i);
                        }
                    }
                    for (int i = 0; i < userRoles.size(); i++) {
                        if (!userRoles.get(i).isStatus()) {
                            userRoles.remove(i);
                        }
                    }
                    request.setAttribute("settings", settings);
                    request.setAttribute("productTypes", productTypes);
                    request.setAttribute("categoryList", categoryList);
                    request.setAttribute("userRoles", userRoles);
                }

                if (filter.equalsIgnoreCase("inactive")) {
                    List<Setting> settings = settingDAO.getAllInactiveSetting();
                    List<ProductType> productTypes = typeDAO.getAllInactiveProductTypes();
                    List<Category> categoryList = categoryDAO.getAllInactiveCategory();
                    List<UserRole> userRoles = userDAO.getAllInactiveUserRole();

                    request.setAttribute("settings", settings);
                    request.setAttribute("productTypes", productTypes);
                    request.setAttribute("categoryList", categoryList);
                    request.setAttribute("userRoles", userRoles);
                }

                if (filter.equalsIgnoreCase("khac")) {
                    List<Setting> settings = settingDAO.getAllSetting();
                    request.setAttribute("settings", settings);
                }

                request.getRequestDispatcher("jsp/settingList.jsp").forward(request, response);
            }

            if (service.equalsIgnoreCase("search")) {
                String text = request.getParameter("search");

                List<Setting> settings = settingDAO.getAllSettingByText(text);
                List<ProductType> productTypes = typeDAO.getAllProductTypesByText(text);
                List<Category> categoryList = categoryDAO.getAllCategoryByText(text);
                List<UserRole> userRoles = userDAO.getAllUserRoleByText(text);

                request.setAttribute("settings", settings);
                request.setAttribute("productTypes", productTypes);
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("userRoles", userRoles);
                
                request.getRequestDispatcher("jsp/settingList.jsp").forward(request, response);
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
