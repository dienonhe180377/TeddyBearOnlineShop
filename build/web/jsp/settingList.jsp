
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh Sách Settings</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" ></script>
        <link rel="stylesheet" href="${contextPath}/css/settingList.css">
    </head>
    <body>
        <div class="wrap">
            <%-- Include header page --%>
            <jsp:include page="../gui/header.jsp" />
            <jsp:include page="../gui/sidebar.jsp"/>

            <%-- Check If subjectQuizList,testTypeQuizListis avaiable not, if not redirect to load information --%>

            <div class="row" style="margin-top: 7rem">
                <div class="col-md-1"></div>
                <div class="col-md-10" id="form" style="min-height: 600px; ">
                    <div class="container" >
                        <h2 class="text-center">Setting List</h2>
                        <%-- Table Container --%>
                        <div class="form-group" style="width: 50%;float: left">
                            <h5>Tìm kiếm</h5>
                            <%-- Select number of Rows show on table --%>
                            <form action="SettingController" method="get">
                                <input type="hidden" name="service" value="search"/>
                                <input type="hidden" name="searchType" value="${settingType}"/>
                                <input type="text" class="form-control" name="search" style="width: 150px;" <c:if test="${not empty inputted}"> value="${inputted}"</c:if>>
                            </form>
                        </div>
                        <div class="dropdown" style="width: 50%;float: left">
                            <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" style="float: right; margin-top: auto;margin-bottom: auto">
                                <c:choose>
                                    <c:when test="${choosenValue == 'all'}">
                                        Tất Cả
                                    </c:when>
                                    <c:when test="${choosenValue == 'active'}">
                                        Active
                                    </c:when>
                                    <c:when test="${choosenValue == 'inactive'}">
                                        Inactive
                                    </c:when>
                                    <c:otherwise>
                                        Lọc theo
                                    </c:otherwise>
                                </c:choose>
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="${contextPath}/SettingController?service=allSetting&type=${settingType}">Tất cả</a>
                                <a class="dropdown-item" href="${contextPath}/SettingController?service=filterBy&filter=active&type=${settingType}&valueChoosen=active">Trạng Thái Active</a>
                                <a class="dropdown-item" href="${contextPath}/SettingController?service=filterBy&filter=inactive&type=${settingType}&valueChoosen=inactive">Trạng Thái Inactive</a>
                            </div>

                            <a href="${contextPath}/SettingController?service=addSettingRedirect&type=${settingType}"><button type="button" class="btn btn-primary" style="float: right; margin-top: auto;margin-bottom: auto;margin-right: 10px;">
                                    Thêm mới
                                </button></a>
                        </div>
                    </div>

                    <%-- Table of QuestionList--%>
                    <table id="table-id" class="table table-bordered table-striped tab1">
                        <%-- Headers of Table--%>
                        <thead>
                            <tr style="background-color: #F0D8D5;">
                                <th>Loại Setting</th>
                                <th>Nội Dung</th>
                                <th>Trạng thái</th>
                                <th>Sửa/Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- setting list --%>

                            <c:choose>
                                <c:when test="${settingType == 'setting'}">
                                    <c:forEach var="settings" items="${settings}">
                                        <tr>
                                            <td>${settings.name}</td>
                                            <td>${settings.content}</td>
                                            <c:if test="${settings.status}">
                                                <td>Active</td>
                                            </c:if>
                                            <c:if test="${!settings.status}">
                                                <td>Inactive</td>
                                            </c:if>
                                            <td><a href=""><button class="btn btn-success">Edit</button></a></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:when test="${settingType == 'productType'}">
                                    <%-- productType list --%>
                                    <c:forEach var="productType" items="${productTypes}">
                                        <tr>
                                            <td>Product Type</td>
                                            <td>${productType.name}</td>
                                            <c:if test="${productType.status}">
                                                <td>Active</td>
                                            </c:if>
                                            <c:if test="${!productType.status}">
                                                <td>Inactive</td>
                                            </c:if>
                                            <td><a href=""><button class="btn btn-success">Edit</button></a></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:when test="${settingType == 'category'}">
                                    <%-- category list --%>
                                    <c:forEach var="category" items="${categoryList}">
                                        <tr>
                                            <td>Category</td>
                                            <td>${category.name}</td>
                                            <c:if test="${category.status}">
                                                <td>Active</td>
                                            </c:if>
                                            <c:if test="${!category.status}">
                                                <td>Inactive</td>
                                            </c:if>
                                            <td><a href=""><button class="btn btn-success">Edit</button></a></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <%-- role list --%>
                                    <c:forEach var="role" items="${userRoles}">
                                        <tr>
                                            <td>User Role</td>
                                            <td>${role.userRole}</td>
                                            <c:if test="${role.status}">
                                                <td>Active</td>
                                            </c:if>
                                            <c:if test="${!role.status}">
                                                <td>Inactive</td>
                                            </c:if>
                                            <td><a href=""><button class="btn btn-success">Edit</button></a></td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>

                        </tbody>
                    </table>
                    <%--Start Pagination --%>
                    <div class='pagination-container'>
                        <nav>
                            <ul class="pagination" style="justify-content: center">
                                <li data-page="prev" >
                                    <span> <button class="btn btn-light" style="border: solid 1px">Prev</button></span>
                                </li>
                                <%--Here the JS Function Will Add the Rows --%>
                                <li data-page="next" id="prev">
                                    <span> <button class="btn btn-light" style="border: solid 1px">Next</button><span class=""></span></span>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            <div class="col-md-1"></div>
        </div>
        <div class="space" style="min-height: 50vh;"></div>

        <jsp:include page="footer.jsp"/>

    </div>
    <script>
        // Gọi hàm phân trang cho bảng có id "table-id"
        getPagination('#table-id');

        function getPagination(table) {
            var maxRows = 5; // Cố định 7 dòng trên 1 trang
            var lastPage = 1;

            // Xóa các nút phân trang cũ (giữ nút Prev và Next)
            $('.pagination').find('li').slice(1, -1).remove();

            var totalRows = $(table + ' tbody tr').length; // Tổng số dòng trong tbody
            var trnum = 0;
            // Hiển thị hoặc ẩn các dòng theo maxRows
            $(table + ' tr:gt(0)').each(function () {
                trnum++;
                if (trnum > maxRows) {
                    $(this).hide();
                } else {
                    $(this).show();
                }
            });

            // Nếu tổng số dòng vượt quá maxRows, tạo nút phân trang
            if (totalRows > maxRows) {
                var pagenum = Math.ceil(totalRows / maxRows);
                for (var i = 1; i <= pagenum; i++) {
                    // Chèn nút trang trước nút Next để giữ thứ tự đúng giữa Prev và Next
                    $('<li class="btn btn-info" data-page="' + i + '"><div>' + i + '</div></li>')
                            .insertBefore($('.pagination [data-page="next"]'));
                }
            } else {
                // Nếu số dòng không vượt quá maxRows, đảm bảo nút trang 1 có ở giữa
                if ($('.pagination [data-page="1"]').length === 0) {
                    $('<li class="btn btn-info active" data-page="1"><div>1</div></li>')
                            .insertBefore($('.pagination [data-page="next"]'));
                }
                // Vô hiệu hóa nút Prev và Next
                $('.pagination [data-page="prev"], .pagination [data-page="next"]')
                        .css('pointer-events', 'none')
                        .addClass('disabled');
                return;
            }

            // Đánh dấu trang đầu tiên là active
            $('.pagination [data-page="1"]').addClass('active');

            // Xử lý sự kiện click cho các nút phân trang
            $('.pagination li').on('click', function (evt) {
                evt.stopImmediatePropagation();
                evt.preventDefault();
                var pageNum = $(this).attr('data-page');

                if (pageNum === 'prev') {
                    if (lastPage == 1)
                        return;
                    pageNum = --lastPage;
                }
                if (pageNum === 'next') {
                    // Số trang bằng tổng số nút trang (không tính Prev và Next)
                    var totalPages = $('.pagination li').length - 2;
                    if (lastPage == totalPages)
                        return;
                    pageNum = ++lastPage;
                }
                lastPage = pageNum;
                $('.pagination li').removeClass('active');
                $('.pagination [data-page="' + lastPage + '"]').addClass('active');
                limitPagging();

                var trIndex = 0;
                $(table + ' tr:gt(0)').each(function () {
                    trIndex++;
                    if (trIndex > maxRows * pageNum || trIndex <= maxRows * pageNum - maxRows) {
                        $(this).hide();
                    } else {
                        $(this).show();
                    }
                });
            });
            limitPagging();
        }

        // Hàm giới hạn số nút phân trang hiển thị
        function limitPagging() {
            if ($('.pagination li').length > 7) {
                if ($('.pagination li.active').attr('data-page') <= 3) {
                    $('.pagination li:gt(5)').hide();
                    $('.pagination li:lt(5)').show();
                    $('.pagination [data-page="next"]').show();
                }
                if ($('.pagination li.active').attr('data-page') > 3) {
                    $('.pagination li:gt(0)').hide();
                    $('.pagination [data-page="next"]').show();
                    for (let i = (parseInt($('.pagination li.active').attr('data-page')) - 2);
                            i <= (parseInt($('.pagination li.active').attr('data-page')) + 2);
                            i++) {
                        $('.pagination [data-page="' + i + '"]').show();
                    }
                }
            }
        }
    </script>
</body>
</html>
