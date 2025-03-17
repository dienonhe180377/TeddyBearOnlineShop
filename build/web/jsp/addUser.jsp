

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add User</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </head>

    <body>

        <%-- Include header page --%>
        <jsp:include page="../gui/header.jsp"/>
        <jsp:include page="../gui/sidebar.jsp"/>


        <div class="main" style="margin-top: 108px;">
            <%-- Login form --%>
            <div class="container" style="align-self: center; min-height: 50vh">
                <%-- Start form --%>
                <div class="row">
                    <%-- Bootstrap to center form --%>
                    <div class="col-md-3"></div>
                    <div class="col-md-6" style="border: solid lightblue;padding: 55px; border-radius: 36px;">
                        <h1 style="margin-bottom: 50px;">Add User</h1>
                        <form action="${contextPath}/UserController" method="POST">
                            <input type="hidden" name="service" value="addUser">
                            
                            <label class="label control-label">User Role</label>
                            <div class="form-group">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>
                                <select class="form-control" name="role">
                                    <c:forEach var="roles" items="${roleList}">
                                        <option value="${roles.id}">${roles.userRole}</option>
                                    </c:forEach>
                                </select>
                            </div>


                            <label class="label control-label">Username</label>
                            <div class="form-group">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>
                                <input class="form-control" type="text" name="name" placeholder="Enter name..." <c:if test="${not empty nameInputted}"> value="${nameInputted}" </c:if> >
                                <c:if test="${not empty nameError}">
                                    <p style="color: red">${nameError}</p>
                                </c:if>
                            </div>


                            <label class="label control-label">Email</label>
                            <div class="form-group">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>
                                <input class="form-control" type="text" name="email" placeholder="Enter email..." <c:if test="${not empty emailInputted}"> value="${emailInputted}" </c:if>>
                                <c:if test="${not empty emailError}">
                                    <p style="color: red">${emailError}</p>
                                </c:if>
                            </div>

                            <label class="label control-label">Password</label>
                            <div class="form-group">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>
                                <input class="form-control" type="text" name="password" placeholder="Enter password..." <c:if test="${not empty passwordInputted}"> value="${passwordInputted}" </c:if>>
                                <c:if test="${not empty passwordError}">
                                    <p style="color: red">${passwordError}</p>
                                </c:if>
                            </div>

                            <label class="label control-label">Phone Number</label>
                            <div class="form-group">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>
                                <input class="form-control" type="text" name="phone" placeholder="Enter phonenumber..." <c:if test="${not empty phoneInputted}"> value="${phoneInputted}" </c:if>>
                                <c:if test="${not empty phoneError}">
                                    <p style="color: red">${phoneError}</p>
                                </c:if>
                            </div>

                            <label class="label control-label">Location</label>
                            <div class="form-group">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>
                                <input class="form-control" type="text" name="location" placeholder="Enter location..." <c:if test="${not empty locationInputted}"> value="${locationInputted}" </c:if>>
                                <c:if test="${not empty locationError}">
                                    <p style="color: red">${locationError}</p>
                                </c:if>
                            </div>

                            <div class="input-group" >
                                <button style="margin-left: auto; margin-right: auto; " type="submit" id="submit" class="btn btn-success">Submit</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </div>
        </div>

        <%-- Include footer page --%>
        <footer style="margin-top: 135px;">
            <jsp:include page="footer.jsp"/>
        </footer>

    </body>
</html>