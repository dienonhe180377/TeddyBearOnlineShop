<%-- 
    Document   : userDetail
    Created on : Feb 15, 2025, 10:29:30 PM
    Author     : OS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Edit User</title>
    <!-- Font (tuỳ chọn) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link 
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" 
        rel="stylesheet"
        >
    <link rel="stylesheet" href="${contextPath}/css/editProfile.css" />
    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
            padding-top: 60px;
            transition: opacity 0.3s ease-in-out;
        }


        .modal-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 20px;
            border-radius: 10px;
            width: 50%;
            max-width: 600px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }

        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            position: absolute;
            top: 10px;
            right: 20px;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .modal-content h2 {
            font-size: 24px;
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }


        #avatarForm {
            display: flex;
            flex-direction: column;
            align-items: center;
        }


        #newAvatar {
            margin-bottom: 20px;
            padding: 10px;
            border: 2px solid #ccc;
            border-radius: 5px;
            width: 80%;
            font-size: 16px;
        }

        #newAvatar:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 5px rgba(76, 175, 80, 0.5);
        }

        .btn {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #45a049;
        }

        #avatarPreviewContainer {
            text-align: center;
            margin-bottom: 20px;
        }


        .avatar-preview {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            border: 2px solid #ccc;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }

        .avatar-preview:hover {
            transform: scale(1.1);
        }


        #newAvatar {
            margin-bottom: 20px;
            padding: 10px;
            border: 2px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            width: 80%;
        }

        #newAvatar:focus {
            outline: none;
            border-color: #4CAF50;
        }

        .modal.show {
            display: block;
            opacity: 1;
        }

    </style>

</head>
<body>
    <c:choose>
        <c:when test="${user.getRole().getUserRole() == 'Customer'}">
            <jsp:include page="header.jsp"/>
        </c:when>
        <c:otherwise>
            <jsp:include page="../gui/header.jsp"/>
            <jsp:include page="../gui/sidebar.jsp"/>
        </c:otherwise>
    </c:choose>

    <section class="edit-profile-container">
        <form class="profile-form" action="${contextPath}/UserController" method="post">
            <div class="form-group">
                <label for="name">Name</label>
                <c:choose>
                    <c:when test="${not empty userInfo}">
                        <input type="text" id="name" name="name" placeholder="${userInfo.userName}"/>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${user != null}">
                            <input type="text" id="name" name="name" placeholder="${user.userName}"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <c:if test="${not empty nameError}">
                    <p style="color: red">${nameError}</p>
                </c:if>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <c:choose>
                    <c:when test="${not empty userInfo}">
                        <input type="email" id="email" name="email" placeholder="${userInfo.email}"/>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${user != null}">
                            <input type="email" id="email" name="email" placeholder="${user.email}"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <c:if test="${not empty emailError}">
                    <p style="color: red">${emailError}</p>
                </c:if>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <c:choose>
                    <c:when test="${not empty userInfo}">
                        <input type="tel" id="phone" name="phone" placeholder="${userInfo.phoneNumber}"/>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${user != null}">
                            <input type="tel" id="phone" name="phone" placeholder="${user.phoneNumber}"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>

                <c:if test="${not empty phoneError}">
                    <p style="color: red">${phoneError}</p>
                </c:if>
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <c:choose>
                    <c:when test="${not empty userInfo}">
                        <input type="text" id="location" name="location" placeholder="${userInfo.location}"/>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${user != null}">
                            <input type="text" id="location" name="location" placeholder="${user.location}"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>

            </div>

            <div class="form-actions">
                <c:choose>
                    <c:when test="${not empty userInfo}">
                        <input type="hidden" name="choosenUser" value="${userInfo.id}"/>
                        <a href="${contextPath}/UserController?service=getAllUser"><button type="button" class="cancel-btn">Cancel</button></a>
                        <button type="submit" name="service" value="editUser" class="save-btn">Save</button>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${user != null}">
                            <p  onclick="openAvatarModal()" name="service" value="changeImage" class="change-image-btn">Change Image</p>
                            <a href="${contextPath}/jsp/userProfile.jsp"><button type="button" class="cancel-btn">Cancel</button></a>
                            <button type="submit" name="service" value="userInfo" class="save-btn">Save</button>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </form>
        <div id="avatarModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeAvatarModal()">&times;</span>
                <h2>Chọn ảnh đại diện mới</h2>

                <div id="avatarPreviewContainer">
                    <img id="avatarPreview" src="${contextPath}/${user.profilePic}" alt="Preview Image" class="avatar-preview" />
                </div>

                <form id="avatarForm" enctype="multipart/form-data">
                    <input type="file" name="avatar" id="newAvatar" required onchange="previewImage(event)" />
                    <button type="submit" class="btn">Cập nhật ảnh đại diện</button>
                </form>
            </div>
        </div>
    </section>

    <footer>
        <jsp:include page="footer.jsp"/>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
                        function previewImage(event) {
                            var reader = new FileReader();
                            reader.onload = function () {
                                var previewImage = document.getElementById("avatarPreview");
                                previewImage.src = reader.result;
                            }
                            reader.readAsDataURL(event.target.files[0]);
                        }
                        function openAvatarModal() {
                            document.getElementById("avatarModal").style.display = "block";
                        }

                        function closeAvatarModal() {
                            document.getElementById("avatarModal").style.display = "none";
                        }

                        window.onclick = function (event) {
                            var modal = document.getElementById("avatarModal");
                            if (event.target == modal) {
                                closeAvatarModal();
                            }
                        }
                        document.getElementById("avatarForm").addEventListener("submit", function (event) {
                            event.preventDefault();

                            var formData = new FormData(this);
                            var xhr = new XMLHttpRequest();
                            xhr.open("POST", "${pageContext.request.contextPath}/updateAvatar", true);

                            xhr.onload = function () {
                                if (xhr.status === 200) {
                                    var response = JSON.parse(xhr.responseText);
                                    if (response.status === "success") {
                                        Swal.fire({
                                            icon: 'success',
                                            title: 'Cập nhật ảnh đại diện thành công!',
                                            showConfirmButton: false,
                                            timer: 1500
                                        });
                                        closeAvatarModal();
                                        document.querySelector(".profile-card img.avatar").src = response.avatarPath;
                                    } else {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Có lỗi xảy ra!',
                                            text: response.message,
                                        });
                                    }
                                } else {
                                    // Nếu có lỗi từ server
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Có lỗi xảy ra!',
                                        text: 'Không thể cập nhật ảnh đại diện.',
                                    });
                                }
                            };

                            xhr.send(formData);
                        });

    </script>
</body>

