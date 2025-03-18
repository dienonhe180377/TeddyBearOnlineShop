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
                request.setAttribute("text", "test");
                request.getRequestDispatcher("jsp/addSetting.jsp").forward(request, response);
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
