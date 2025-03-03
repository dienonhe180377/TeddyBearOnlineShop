<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Forgot Password - Teddy Bear Shop</title>
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
          <h2 class="text-center mb-4">Forgot Password</h2>

          <!-- Display notifications -->
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

          <form id="forgotPasswordForm" action="forgot-password" method="post" novalidate>
            <div class="mb-3">
              <input type="email" class="form-control" name="email" placeholder="Enter your registered email..." required />
              <div id="emailError" class="error-message text-danger"></div>
            </div>
            <button type="submit" class="btn btn-primary w-100">Reset Password</button>
          </form>
          <div class="text-center mt-3">
            <a href="login" class="text-decoration-none">Back to Login</a>
          </div>
        </div>
      </div>
    </div>
    <script>
      // Validate email format on form submission using inline error message
      document.getElementById('forgotPasswordForm').addEventListener('submit', function (e) {
        var email = document.querySelector('input[name="email"]').value;
        var emailError = document.getElementById('emailError');
        // Basic email regex pattern
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
          emailError.innerText = "Please enter a valid email address.";
          e.preventDefault();
        } else {
          emailError.innerText = "";
        }
      });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
