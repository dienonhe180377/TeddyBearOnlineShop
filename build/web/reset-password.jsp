<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Reset Password - Teddy Bear Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="./css/login.css" />
    <style>
      .error-message {
        font-size: 0.9rem;
      }
    </style>
  </head>
  <body>
    <div class="container d-flex justify-content-center align-items-center min-vh-100">
      <div class="row w-75">
        <div class="col-md-6 d-flex align-items-center justify-content-center">
          <img src="./images/loginimg.jpg" alt="Teddy Bear" class="img-fluid teddy-img" />
        </div>
        <div class="col-md-6 login-box p-5 rounded shadow">
          <h2 class="text-center mb-4">Reset Password</h2>

          <!-- Display notifications if any -->
          <c:if test="${not empty sessionScope.notification}">
            <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
              ${sessionScope.notification}
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("notification"); %>
          </c:if>
          <c:if test="${not empty sessionScope.notificationErr}">
            <div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
              ${sessionScope.notificationErr}
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("notificationErr"); %>
          </c:if>

          <form id="resetPasswordForm" action="reset-password" method="post" novalidate>
            <!-- Pass the token from the URL -->
            <input type="hidden" name="token" value="${param.token}" />
            <div class="mb-3">
              <input type="password" class="form-control" name="newPassword" placeholder="Enter new password..." required />
              <div id="newPasswordError" class="error-message text-danger"></div>
            </div>
            <div class="mb-3">
              <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm new password..." required />
              <div id="confirmPasswordError" class="error-message text-danger"></div>
            </div>
            <button type="submit" class="btn btn-primary w-100">Change Password</button>
          </form>
          <div class="text-center mt-3">
            <a href="login" class="text-decoration-none">Back to Login</a>
          </div>
        </div>
      </div>
    </div>
    <script>
      // Validate new password and confirmation on form submission using inline error messages
      document.getElementById('resetPasswordForm').addEventListener('submit', function (e) {
        var newPassword = document.querySelector('input[name="newPassword"]').value;
        var confirmPassword = document.querySelector('input[name="confirmPassword"]').value;
        var newPasswordError = document.getElementById('newPasswordError');
        var confirmPasswordError = document.getElementById('confirmPasswordError');
        var valid = true;

        // Password regex: at least one uppercase, one special character, one digit, and length between 8 and 50
        var passwordRegex = /^(?=.*[A-Z])(?=.*[!@#$%^&*()\-_=+{};:,<.>])(?=.*\d).{8,50}$/;
        
        // Reset error messages
        newPasswordError.innerText = "";
        confirmPasswordError.innerText = "";

        if (!passwordRegex.test(newPassword)) {
          newPasswordError.innerText = "Password must be 8-50 characters long, include at least one uppercase letter, one number, and one special character.";
          valid = false;
        }
        
        if (newPassword !== confirmPassword) {
          confirmPasswordError.innerText = "Passwords do not match.";
          valid = false;
        }

        if (!valid) {
          e.preventDefault();
        }
      });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
