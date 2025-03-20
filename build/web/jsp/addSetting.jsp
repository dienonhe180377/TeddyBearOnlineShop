

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Cài Đặt Mới</title>
        <link rel="stylesheet" href="${contextPath}/css/settingDetail.css"/>
    </head>
    <body>

        <jsp:include page="../gui/header.jsp"/>
        <jsp:include page="../gui/sidebar.jsp"/>

        <div class="container" style="margin-top: 118px">
            <h2 style="margin-bottom: 33px">Thêm Cài Đặt Mới</h2>
            <form id="addSettingForm" action="SettingController" method="post">
                <input type="hidden" name="service" value="addSetting"/>
                <!-- Drop-down cho Tên Cài Đặt -->
                <div class="form-group">
                    <label for="settingNameSelect">Loại Cài Đặt</label>
                    <select id="settingNameSelect" name="settingName">
                        <option value="category" <c:if test="${type == 'category'}">selected</c:if>>Category</option>
                        <option value="productType" <c:if test="${type == 'productType'}">selected</c:if>>ProductType</option>
                        <option value="userRole" <c:if test="${type == 'role'}">selected</c:if>>UserRole</option>
                            <!-- Set option "Khác" là mặc định được chọn -->
                        <c:if test="${not empty changeInfo}">
                            <option value="setting">Khác</option>
                        </c:if>
                    </select>
                </div>
                <!-- Trường nhập tên cài đặt mới khi chọn "Khác" -->
                <div class="form-group hidden" id="customSettingNameGroup">
                    <label for="customSettingName">Nhập Tên Cài Đặt Mới</label>
                    <input type="text" id="customSettingName" name="newSettingName" placeholder="Nhập tên cài đặt mới...">
                </div>
                <!-- Trường Giá Trị -->
                <div class="form-group">
                    <label for="settingValue">Nội dung</label>
                    <input type="text" id="settingValue" name="settingValue" <c:if test="${not empty inputtedValue}">value="${inputtedValue}"</c:if> placeholder="Nhập giá trị cài đặt..." required>
                </div>
                <!-- Drop-down cho Status -->
                <div class="form-group">
                    <label for="settingStatus">Trạng thái</label>
                    <select id="settingStatus" name="settingStatus">
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                    </select>
                </div>
                <!-- Trường Mô Tả -->
                <div class="form-group">
                    <label for="settingDescription">Mô Tả</label>
                    <textarea id="settingDescription" name="settingDescription" rows="4" placeholder="Nhập mô tả..."></textarea>
                </div>
                <button type="submit" class="save-btn">Lưu Cài Đặt</button>
                <button type="submit" class="cancel-btn">Hủy</button>
                <c:if test="${not empty duplicateMessage}">
                    <P style="color: red; float: right;">${duplicateMessage}</P>
                    </c:if>
            </form>
        </div>
        <script>
            const settingNameSelect = document.getElementById('settingNameSelect');
            const customSettingNameGroup = document.getElementById('customSettingNameGroup');
            const customSettingName = document.getElementById('customSettingName');

            // Khi chọn drop-down "Tên Cài Đặt"
            settingNameSelect.addEventListener('change', function () {
                if (this.value === 'setting') {
                    customSettingNameGroup.classList.remove('hidden');
                } else {
                    customSettingNameGroup.classList.add('hidden');
                }
            });

            // Khi tải trang, nếu lựa chọn là "Khác" thì hiển thị field và gán giá trị mặc định
            document.addEventListener("DOMContentLoaded", function () {
                if (settingNameSelect.value === 'Khác') {
                    customSettingNameGroup.classList.remove('hidden');
                    customSettingName.value = "a";
                }
            });
        </script>
    </body>
</html>

