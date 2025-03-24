<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User List</title>
        <link rel="stylesheet" href="${contextPath}/css/userList.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </head>
    <body>
        <%-- Check If user is logged in or not, if not redirect to error page --%>

        <div class="wrap">
            <%-- Include header page --%>
            <jsp:include page="../gui/header.jsp" />
            <jsp:include page="../gui/sidebar.jsp"/>

            <div class="main" style="margin-top: 126px;">
                <c:if test="${not empty sessionScope.notification}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
                        ${sessionScope.notification}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <%
                        session.removeAttribute("notification");
                    %>
                </c:if>
                <c:if test="${not empty sessionScope.notificationErr}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert" style="text-align: center">
                        ${sessionScope.notificationErr}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <%
                        session.removeAttribute("notificationErr");
                    %>
                </c:if>
                <%--If max page is null, redirect to servlet subjectList--%>
                <div class="row" style="margin-top: 3rem">
                    <div class="col-md-1"></div>
                    <div class="col-md-2" id="form" style="min-height: 480px">
                        <h2 class="text-center" style="margin-top: 23px;">Filter</h2>
                        <div style="margin-bottom: 20px;">
                            <%-- Start search form --%>

                            <form action="${contextPath}/manager/user-management" class="navbar-form" method="get">

                                <%--By name--%>
                                <label>By Name, Email or Phone</label><br>
                                <div class="input-group">
                                    <input  class="form-control" type="text" id="content" placeholder="Enter Name, Email or Phone..." name="search" value="${param.search}" style="display: inline-block">
                                </div>

                                <label>By Role</label>
                                <div class="input-group">
                                    <br>
                                    <select id="content" class="form-control" name="role" style="display: inline-block">
                                        <option value="" ${param.role == "" ? "selected" : ""}>Not Specify</option>
                                        <option value="2" ${param.role == "2" ? "selected" : ""}>Seller</option>
                                        <option value="3" ${param.role == "3" ? "selected" : ""}>Marketing</option>
                                    </select>
                                </div>
                                <div class="input-group" style="margin-top: 23px;">
                                    <input type="submit" value="Filter" class="btn btn-primary" style="margin: 20px auto;">
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="col-md-8" id="form" style="min-height: 480px; min-width: 1000px">
                        <div class="container" >
                            <%-- Table Container --%>
                            <div class="form-group" style="max-width: 98%; margin:5px">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">
                                    Add User
                                </button>
                                <%-- Table of User List--%>
                                <table id="table-id" class="table table-bordered table-striped">
                                    <thead>
                                        <%-- Headers of Table--%>
                                        <tr style="background-color: #F0D8D5;">
                                            <th>User Id</th>
                                            <th>User Name</th>
                                            <th>Email</th>
                                            <th>Mobile</th>
                                            <th>Role</th>
                                            <th>Created Date</th>
                                            <th>Manage</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="users" items="${users}">
                                            <tr>
                                                <td>${users.id}</td>
                                                <td>${users.userName}</td>
                                                <td>${users.email}</td>
                                                <td>${users.phoneNumber}</td>
                                                <td>${users.role.userRole}</td>
                                                <td>${users.createdDate}</td>
                                                <!-- In your table row, change the Edit column to include a button that calls openEditModal() -->
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-warning" 
                                                            onclick="openEditModal('${users.id}', '${users.userName}', '${users.email}', '${users.phoneNumber}', '${users.location}', '${users.role.id}')">
                                                        Edit
                                                    </button>
                                                </td>

                                                <!-- Edit User Modal -->
                                        <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="editUserModalLabel" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                                <!-- The form submits to your UserManagementController -->
                                                <form id="editUserForm" action="${contextPath}/manager/user-management" method="post">
                                                    <!-- Hidden fields to specify the action type and the user ID -->
                                                    <input type="hidden" name="action" value="edit">
                                                    <input type="hidden" id="userId" name="userId">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <!-- User Name Field -->
                                                            <div class="form-group">
                                                                <label for="editUserName">User Name</label>
                                                                <input type="text" class="form-control" id="editUserName" name="userName" required>
                                                                <span class="text-danger" id="editUserNameError"></span>
                                                            </div>
                                                            <!-- Email Field -->
                                                            <div class="form-group">
                                                                <label for="editEmail">Email</label>
                                                                <input type="email" class="form-control" id="editEmail" name="email" required>
                                                                <span class="text-danger" id="editEmailError"></span>
                                                            </div>
                                                            <!-- Phone Field -->
                                                            <div class="form-group">
                                                                <label for="editPhone">Phone</label>
                                                                <input type="text" class="form-control" id="editPhone" name="phone" required>
                                                                <span class="text-danger" id="editPhoneError"></span>
                                                            </div>
                                                            <!-- Location Field -->
                                                            <div class="form-group">
                                                                <label for="editLocation">Location</label>
                                                                <input type="text" class="form-control" id="editLocation" name="location">
                                                            </div>
                                                            <!-- Role Selection -->
                                                            <div class="form-group">
                                                                <label for="editRole">Role</label>
                                                                <select class="form-control" id="editRole" name="role">
                                                                    <option value="2">Seller</option>
                                                                    <option value="3">Marketing</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                            <button type="submit" class="btn btn-primary">Save Changes</button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                        <!-- JavaScript to open the edit modal and pre-populate form fields -->
                                        <script>
                                            function openEditModal(userId, userName, email, phone, location, role) {
                                                $('#userId').val(userId);
                                                $('#editUserName').val(userName);
                                                $('#editEmail').val(email);
                                                $('#editPhone').val(phone);
                                                $('#editLocation').val(location);
                                                $('#editRole').val(role);
                                                $('#editUserModal').modal('show');
                                            }

                                            $(document).ready(function () {
                                                $('#editUserForm').on('submit', function (e) {
                                                    var valid = true;
                                                    // Clear previous error messages
                                                    $('#editUserNameError, #editEmailError, #editPhoneError').text('');

                                                    // Validate email using regex
                                                    var email = $('#editEmail').val().trim();
                                                    var emailPattern = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
                                                    if (!emailPattern.test(email)) {
                                                        $('#editEmailError').text('Invalid email format.');
                                                        valid = false;
                                                    }

                                                    // Validate phone number: must be 10 digits starting with 0
                                                    var phone = $('#editPhone').val().trim();
                                                    var phonePattern = /^0\d{9}$/;
                                                    if (!phonePattern.test(phone)) {
                                                        $('#editPhoneError').text('Phone number must be 10 digits and start with 0.');
                                                        valid = false;
                                                    }

                                                    if (!valid) {
                                                        e.preventDefault();
                                                    }
                                                });
                                            });
                                        </script>

                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <div class='pagination-container'>
                                    <nav class="mt-3" aria-label="Page navigation example">
                                        <ul class="pagination justify-content-center">
                                            <c:if test="${currentPage > 1}">
                                                <li class="page-item">
                                                    <a class="btn btn-primary" href="?search=${param.search}&role=${param.status}&page=${currentPage - 1}">Previous</a>
                                                </li>
                                            </c:if>
                                            <c:forEach var="pageNum" begin="1" end="${totalPages}">
                                                <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                                    <a class="btn btn-primary" href="?search=${param.search}&role=${param.status}&page=${pageNum}">${pageNum}</a>
                                                </li>
                                            </c:forEach>
                                            <c:if test="${currentPage < totalPages}">
                                                <li class="page-item">
                                                    <a class="btn btn-primary" href="?search=${param.search}&role=${param.status}&page=${currentPage + 1}">Next</a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-1"></div>

                    </div>
                </div>
                <%-- Include footer page --%>
                <footer style="margin-top: 143px;">
                    <jsp:include page="../gui/footer.jsp" />
                </footer>
            </div>
        </div>
        <!-- Add User Modal -->
        <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="addUserModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <!-- The form submits to your UserManagementController -->
                <form id="addUserForm" action="${contextPath}/manager/user-management" method="post">
                    <!-- Hidden field to specify the action type -->
                    <input type="hidden" name="action" value="add">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <!-- User Name Field -->
                            <div class="form-group">
                                <label for="userName">User Name</label>
                                <input type="text" class="form-control" id="userName" name="userName" required>
                                <span class="text-danger" id="userNameError"></span>
                            </div>
                            <!-- Email Field -->
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                                <span class="text-danger" id="emailError"></span>
                            </div>
                            <!-- Phone Field -->
                            <div class="form-group">
                                <label for="phone">Phone</label>
                                <input type="text" class="form-control" id="phone" name="phone" required>
                                <span class="text-danger" id="phoneError"></span>
                            </div>
                            <!-- Password Field -->
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                                <span class="text-danger" id="passwordError"></span>
                            </div>
                            <!-- Location Field -->
                            <div class="form-group">
                                <label for="location">Location</label>
                                <input type="text" class="form-control" id="location" name="location">
                            </div>
                            <!-- Role Selection -->
                            <div class="form-group">
                                <label for="role">Role</label>
                                <select class="form-control" id="role" name="role">
                                    <option value="2">Seller</option>
                                    <option value="3">Marketing</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Add User</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- jQuery Validation Script -->
        <script>
            $(document).ready(function () {
                $('#addUserForm').on('submit', function (e) {
                    var valid = true;
                    // Clear previous error messages
                    $('#userNameError, #emailError, #phoneError, #passwordError').text('');

                    // Validate email using regex
                    var email = $('#email').val().trim();
                    var emailPattern = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
                    if (!emailPattern.test(email)) {
                        $('#emailError').text('Invalid email format.');
                        valid = false;
                    }

                    // Validate phone number: must be 10 digits starting with 0
                    var phone = $('#phone').val().trim();
                    var phonePattern = /^0\d{9}$/;
                    if (!phonePattern.test(phone)) {
                        $('#phoneError').text('Phone number must be 10 digits and start with 0.');
                        valid = false;
                    }

                    // Validate password: at least 6 characters, one uppercase letter, one special character
                    var password = $('#password').val();
                    var passwordPattern = /^(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{6,}$/;
                    if (!passwordPattern.test(password)) {
                        $('#passwordError').text('Password must be at least 6 characters long, contain an uppercase letter and a special character.');
                        valid = false;
                    }

                    // If any validation fails, prevent form submission
                    if (!valid) {
                        e.preventDefault();
                    }
                });
            });
        </script>

    </body>
</html>
