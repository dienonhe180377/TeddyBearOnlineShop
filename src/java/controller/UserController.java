/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import entity.User;
import entity.UserRole;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author OS
 */
public class UserController extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            String service = request.getParameter("service");
            HttpSession session = request.getSession();
            UserDAO userDao = new UserDAO();

            if (service.equalsIgnoreCase("changeImage")) {

            }

            if (service.equalsIgnoreCase("editUser")) {
                String userID = request.getParameter("choosenUser");
                int userId = Integer.parseInt(userID);
                User user = userDao.getUserById(userId);
                String nameError = "", emailError = "", phoneError = "";
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String location = request.getParameter("location");
                ArrayList<User> users = userDao.getAllUser();
                String currentUsername = user.getUserName();

                if (name == "") {
                    name = user.getUserName();
                } else if (name.equals(user.getUserName())) {
                    name = user.getUserName();
                } else {
                    if (isValidName(name) == false) {
                        nameError = "Name Not Valid Or Already Used!!";
                    }
                    for (int i = 0; i < users.size(); i++) {
                        if (users.get(i).getUserName().equals(name)) {
                            nameError = "Name Not Valid Or Already Used!!";
                            request.setAttribute("nameError", nameError);
                        }
                    }
                }

                if (email == "") {
                    email = user.getEmail();
                } else if (email.equals(user.getEmail())) {
                    email = user.getEmail();
                } else {
                    if (isValidEmail(email) == false) {
                        emailError = "Email Not Valid Or Already Used!!";
                    }
                    for (int i = 0; i < users.size(); i++) {
                        if (users.get(i).getEmail().equals(email)) {
                            emailError = "Email Not Valid Or Already Used!";
                            request.setAttribute("emailError", emailError);
                        }
                    }
                }

                if (phone == "") {
                    phone = user.getPhoneNumber();
                } else if (phone.equals(user.getPhoneNumber())) {
                    phone = user.getPhoneNumber();
                } else {
                    if (isValidPhone(phone) == false) {
                        phoneError = "Phone Not Valid Or Already Used!!";
                    }
                    for (int i = 0; i < users.size(); i++) {
                        if (users.get(i).getPhoneNumber().equals(phone)) {
                            phoneError = "Phone Not Valid Or Already Used!";
                            request.setAttribute("phoneError", phoneError);
                        }
                    }
                }

                if (location == "") {
                    location = user.getLocation();
                }

                if (nameError != "" || emailError != "" || phoneError != "") {
                    User choosenUser = userDao.getUserById(userId);
                    request.setAttribute("userInfo", choosenUser);
                    request.getRequestDispatcher("jsp/userDetail.jsp").forward(request, response);
                } else {
                    userDao.changeUserInformation(currentUsername, name, email, phone, location);
                    User choosenUser = userDao.getUserById(userId);
                    User currUser = (User) session.getAttribute("user");
                    if (currUser.getId() == choosenUser.getId()) {
                        currUser.setUserName(name);
                        currUser.setEmail(email);
                        currUser.setPhoneNumber(phone);
                        currUser.setLocation(location);
                        session.setAttribute("user", currUser);
                    }
                    request.setAttribute("userInfo", choosenUser);
                    request.getRequestDispatcher("jsp/userDetail.jsp").forward(request, response);
                }
            }

            if (service.equalsIgnoreCase("userInfo")) {
                User user;
                user = (User) session.getAttribute("user");

                String nameError = "", emailError = "", phoneError = "";
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String location = request.getParameter("location");
                String currentUsername = user.getUserName();
                int currentUserId = user.getId();
                if (name == "") {
                    name = user.getUserName();
                } else {
                    if (!name.equals(user.getUserName())) {
                        if (isValidName(name) == false || userDao.isUsernameExist(name) == true) {
                            nameError = "Name Not Valid Or Already Used!!";
                            request.setAttribute("nameError", nameError);
                        }
                    }
                }

                if (email == "") {
                    email = user.getEmail();
                } else {
                    if (!email.equals(user.getEmail())) {
                        if (isValidEmail(email) == false || userDao.isEmailExist(email) == true) {
                            emailError = "Email Not Valid Or Already Used!";
                            request.setAttribute("emailError", emailError);
                        }
                    }
                }

                if (phone == "") {
                    phone = user.getPhoneNumber();
                } else {
                    if (!phone.equals(user.getPhoneNumber())) {
                        if (isValidPhone(phone) == false || userDao.isPhoneNumberExist(phone) == true) {
                            phoneError = "Phone Not Valid Or Already Used!";
                            request.setAttribute("phoneError", phoneError);
                        }
                    }
                }
                if (location == "") {
                    location = user.getLocation();
                }

                if (nameError != "" || emailError != "" || phoneError != "") {
                    request.getRequestDispatcher("jsp/userDetail.jsp").forward(request, response);
                } else {
                    userDao.changeUserInformation(currentUsername, name, email, phone, location);
                    user.setUserName(name);
                    user.setEmail(email);
                    user.setPhoneNumber(phone);
                    user.setLocation(location);
                    session.setAttribute("user", user);
                    request.getRequestDispatcher("jsp/userProfile.jsp").forward(request, response);

                }
            }

            if (service.equalsIgnoreCase("getAllUser")) {
                ArrayList<User> users = userDao.getAllUser();
                ArrayList<UserRole> roles = userDao.getAllUserRole();
                request.setAttribute("roleList", roles);
                request.setAttribute("userList", users);
                request.getRequestDispatcher("jsp/userList.jsp").forward(request, response);
            }

            if (service.equalsIgnoreCase("filter")) {
                String username = request.getParameter("nameFilter");
                String email = request.getParameter("emailFilter");
                String phone = request.getParameter("phoneFilter");
                String roleId = request.getParameter("roleFilter");
                ArrayList<User> users = userDao.getUserByFilter(roleId, username, email, phone);
                ArrayList<UserRole> roles = userDao.getAllUserRole();
                request.setAttribute("roleList", roles);
                request.setAttribute("userList", users);
                request.getRequestDispatcher("jsp/userList.jsp").forward(request, response);
            }

            if (service.equalsIgnoreCase("editUserRedirect")) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                User choosenUser = userDao.getUserById(userId);
                request.setAttribute("userInfo", choosenUser);
                request.getRequestDispatcher("jsp/userDetail.jsp").forward(request, response);
            }

            if (service.equalsIgnoreCase("getAddUserFiller")) {
                ArrayList<UserRole> roles = userDao.getAllActiveUserRole();
                for (int i = 0; i < roles.size(); i++) {
                    if(roles.get(i).getUserRole().equals("Customer")){
                        roles.remove(i);
                    }
                }
                request.setAttribute("roleList", roles);
                request.getRequestDispatcher("jsp/addUser.jsp").forward(request, response);
            }

            if (service.equalsIgnoreCase("addUser")) {

                String nameError = "", emailError = "", phoneError = "", locationError = "", passwordError = "";
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String phone = request.getParameter("phone");
                String location = request.getParameter("location");
                int role = Integer.parseInt(request.getParameter("role"));

                if (isValidName(name) == false || userDao.isUsernameExist(name) == true || name == "") {
                    nameError = "Name Not Valid Or Already Used!!";
                    request.setAttribute("nameError", nameError);
                }

                if (isValidEmail(email) == false || userDao.isEmailExist(email) == true || email == "") {
                    emailError = "Email Not Valid Or Already Used!";
                    request.setAttribute("emailError", emailError);
                }

                if (phone == "" || isValidPhone(phone) == false || userDao.isPhoneNumberExist(phone) == true) {
                    phoneError = "Phone Not Valid Or Already Used!";
                    request.setAttribute("phoneError", phoneError);
                }

                if (location == "") {
                    locationError = "Location Not Valid!";
                    request.setAttribute("locationError", locationError);
                }

                if (password == "") {
                    passwordError = "Password Not Valid!";
                    request.setAttribute("passwordError", passwordError);
                }

                if (nameError != "" || emailError != "" || phoneError != "" || locationError != "" || passwordError != "") {
                    if (nameError == "") {
                        request.setAttribute("nameInputted", name);
                    }
                    if (emailError == "") {
                        request.setAttribute("emailInputted", email);
                    }
                    if (phoneError == "") {
                        request.setAttribute("phoneInputted", phone);
                    }
                    if (passwordError == "") {
                        request.setAttribute("passwordInputted", password);
                    }
                    if (locationError == "") {
                        request.setAttribute("locationInputted", location);
                    }
                    ArrayList<UserRole> roles = userDao.getAllUserRole();
                    request.setAttribute("roleList", roles);
                    request.getRequestDispatcher("jsp/addUser.jsp").forward(request, response);
                } else {
                    userDao.addUser(name, email, password, phone, location, role);
                    request.getRequestDispatcher("/UserController?service=getAllUser").forward(request, response);
                }
            }

        } catch (Exception ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private boolean isValidName(String name) {
        if (name.length() > 12) {
            return false;
        }
        return true;
    }

    private boolean isValidEmail(String email) {
        // Sử dụng regex để kiểm tra email hợp lệ
        return email.matches("^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@"
                + "(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$");
    }

    private boolean isValidPhone(String phone) {
        // Sử dụng regex để kiểm tra phone hợp lệ
        return phone.matches("^0\\d{9}$");
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
