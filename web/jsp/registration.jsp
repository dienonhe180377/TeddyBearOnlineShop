<%-- 
    Document   : registration
    Created on : Feb 4, 2025, 8:05:02 PM
    Author     : Dell
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Teddy Bear Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/registration.css">
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="row w-75">
            <div class="col-md-6 d-flex align-items-center justify-content-center">
                <img src="../images/registerimg.jpg" alt="Teddy Bear" class="img-fluid teddy-img">
            </div>
            <div class="col-md-6 login-box p-5 rounded shadow">
                <h2 class="text-center mb-4">Join Us Cutie !</h2>
                <form action="registerServlet" method="post">
                    <div class="mb-3">
                        <input type="text" class="form-control" name="fullname" placeholder="Enter your full name..." required>
                    </div>
                    <div class="mb-3">
                        <input type="email" class="form-control" name="email" placeholder="Enter your email..." required>
                    </div>
                    <div class="mb-3">
                        <input type="text" class="form-control" name="username" placeholder="Choose a username..." required>
                    </div>
                    <div class="mb-3">
                        <input type="password" class="form-control" name="password" placeholder="Create a password" required>
                    </div>
                    <div class="mb-3">
                        <input type="password" class="form-control" name="confirm_password" placeholder="Confirm your password" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Register</button>
                    <button class="btn btn-danger w-100 mt-2"> <i class="fab fa-google"></i> Sign up with Google</button>
                </form>
                <div class="text-center mt-3">
                    <a href="login.jsp" class="text-decoration-none">Already have an account? Login</a>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
