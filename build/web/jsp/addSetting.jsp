

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
                <c:if test="${empty valueCheck && empty settingCheck}"><input type="hidden" name="service" value="addSetting"/></c:if>
                <c:if test="${not empty valueCheck}"><input type="hidden" name="service" value="editSetting"/></c:if>
                <c:if test="${not empty valueCheck}"><input type="hidden" name="id" value="${valueCheck.id}"/></c:if>
                <c:if test="${not empty settingCheck}"><input type="hidden" name="service" value="editSetting"/></c:if>
                <c:if test="${not empty settingCheck}"><input type="hidden" name="id" value="${settingCheck.id}"/></c:if>
                    <!-- Drop-down cho Tên Cài Đặt -->
                    <div class="form-group">
                        <label for="settingNameSelect">Loại Cài Đặt</label>
                        <select id="settingNameSelect" name="settingName" <c:if test="${type == 'setting' || not empty valueCheck}">disabled</c:if>>
                        <option value="category" <c:if test="${type == 'category'}">selected</c:if>>Category</option>
                        <option value="productType" <c:if test="${type == 'productType'}">selected</c:if>>ProductType</option>
                        <option value="role" <c:if test="${type == 'role'}">selected</c:if>>UserRole</option>
                            <!-- Set option "Khác" là mặc định được chọn -->
                        <c:if test="${type == 'setting'}">
                            <option value="setting" selected>Khác</option>
                        </c:if>
                    </select>
                    <c:if test="${type == 'setting' || not empty valueCheck}"><input type="hidden" name="type" value="${type}"/></c:if>
                    </div>
                    <!-- Trường nhập tên cài đặt mới khi chọn "Khác" -->
                    <div class="form-group hidden" id="customSettingNameGroup">
                        <label for="customSettingName">Tên Cài Đặt</label>
                        <input type="text" id="customSettingName" name="newSettingName" placeholder="Nhập tên cài đặt mới..." disabled>
                    </div>
                    <!-- Trường Giá Trị -->
                    <div class="form-group">
                        <label for="settingValue">Nội dung</label>
                        <input type="text" id="settingValue" name="settingValue" 
                        <c:if test="${not empty inputtedValue}">value="${inputtedValue}"</c:if>
                        <c:if test="${not empty valueCheck}">value="${valueCheck.name}"</c:if>
                        <c:if test="${not empty settingCheck}">value="${settingCheck.content}"</c:if>
                            placeholder="Nhập giá trị cài đặt..." required>
                    </div>
                    <!-- Drop-down cho Status -->
                    <div class="form-group">
                        <label for="settingStatus">Trạng thái</label>
                        <select id="settingStatus" name="settingStatus">
                            <option value="active" <c:if test="${valueCheck.status == true}">selected</c:if><c:if test="${settingCheck.status == true}">selected</c:if>>Active</option>
                        <option value="inactive" <c:if test="${valueCheck.status == false}">selected</c:if><c:if test="${settingCheck.status == false}">selected</c:if>>Inactive</option>
                        </select>
                    </div>
                    <!-- Trường Mô Tả -->
                    <div class="form-group">
                        <label for="settingDescription">Mô Tả</label>
                            <textarea id="settingDescription" name="settingDescription" rows="4" placeholder="Nhập mô tả..."><c:if test="${not empty settingCheck}">${settingCheck.description}</c:if></textarea>
                    </div>
                    <button type="submit" class="save-btn">Lưu Cài Đặt</button>
                    <a class="cancel-btn" href="${contextPath}/SettingController?service=allSetting&type=${type}">Hủy</a>
                <a class="cancel-btn" href="${contextPath}/SettingController?service=delete&type=${type}&id=${valueCheck.id}" <c:if test="${type == 'setting' || empty valueCheck && empty settingCheck}">hidden</c:if> >Xóa</a>
                <c:if test="${not empty duplicateMessage}">
                    <P style="color: red; float: right;">${duplicateMessage}</P>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                    <P style="color: greenyellow; float: right;">${successMessage}</P>
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
                if (settingNameSelect.value === 'setting') {
                    customSettingNameGroup.classList.remove('hidden');
                    customSettingName.value = "${settingCheck.name}";
                }
            });
        </script>
    </body>
</html>

