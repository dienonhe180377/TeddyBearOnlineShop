<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password - Teddy Bear</title>

        <!-- Import Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Import Custom CSS -->
        <link rel="stylesheet" href="../css/changePassword.css">
    </head>
    <body>

        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg bg-custom">
            <div class="container">
                <!-- Logo và Tên thương hiệu -->
                <a class="navbar-brand d-flex align-items-center" href="#">
                    <img src="logo.png" alt="Logo" class="logo">
                    <span class="ms-2 text-white fw-bold">Teddy Bear</span>
                </a>

                <!-- Nút menu khi màn hình nhỏ -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Menu -->
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav align-items-center"> <!-- Thêm align-items-center -->
                        <li class="nav-item">
                            <a href="#" class="nav-link text-white">Sign In</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="btn btn-light btn-sm">Sign Up</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Change Password Form -->
        <div class="container d-flex flex-column align-items-center justify-content-center min-vh-100">
            <h2 class="text-center mt-4">Change Password</h2>

            <!-- Form nhập mật khẩu -->
            <form action="changePasswordServlet" method="post" class="password-form w-50">
                <div class="mb-3">
                    <input type="password" class="form-control" name="oldPassword" placeholder="Old Password" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" name="newPassword" placeholder="New Password" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm Password" required>
                </div>
                <button type="submit" class="btn btn-custom w-100">Save Change</button>
            </form>
        </div>

        <!-- Import Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
