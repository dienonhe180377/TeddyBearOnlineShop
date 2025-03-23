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

                <%--If max page is null, redirect to servlet subjectList--%>
                <div class="row" style="margin-top: 3rem">
                    <div class="col-md-1"></div>
                    <div class="col-md-2" id="form" style="min-height: 480px">
                        <h2 class="text-center" style="margin-top: 23px;">Filter</h2>
                        <div style="margin-bottom: 20px;">
                            <%-- Start search form --%>

                            <form action="${contextPath}/UserController" class="navbar-form" method="get">

                                <%--By name--%>
                                <label>By Name</label><br>
                                <div class="input-group">
                                    <input  class="form-control" type="text" id="content" placeholder="Name..." name="nameFilter"  style="display: inline-block">
                                </div>

                                <%--By user Mail--%>

                                <label>By Mail</label>
                                <div class="input-group">
                                    <br>
                                    <input  class="form-control" type="text" id="content" placeholder="Mail..." name="emailFilter"  style="display: inline-block">
                                </div>

                                <%--By User Mobile--%>
                                <label>By Mobile</label>
                                <div class="input-group">
                                    <br>
                                    <input  class="form-control" type="text" id="content" placeholder="Mobile..." name="phoneFilter"  style="display: inline-block">
                                </div>

                                <div class="input-group" style="margin-top: 23px;">
                                    <input type="hidden" name="service" value="filter">
                                    <input type="submit" value="Filter" class="btn btn-primary" style="margin: 20px auto;">
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="col-md-8" id="form" style="min-height: 480px; min-width: 1000px">
                        <div class="container" style="margin-top: 50px;">
                            <%-- Table Container --%>
                            <div class="form-group" style="max-width: 98%; margin:5px">
                                
                                <%-- Table of User List--%>
                                <table id="table-id" class="table table-bordered table-striped">
                                    <thead>
                                        <%-- Headers of Table--%>
                                        <tr style="background-color: #F0D8D5;">
                                            <th>User Id</th>
                                            <th>User Name</th>
                                            <th>Email</th>
                                            <th>Mobile</th>
                                            <th>Created Date</th>
                                            <th>Manage</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="users" items="${userList}">
                                            <tr>
                                                <td>${users.id}</td>
                                                <td>${users.userName}</td>
                                                <td>${users.email}</td>
                                                <td>${users.phoneNumber}</td>
                                                <td>${users.createdDate}</td>
                                                <td><a href=""><div class="btn btn-success">Detail</div></a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class='pagination-container'>
                                    <nav>
                                        <ul class="pagination" style="justify-content: center">
                                            <li data-page="prev" >
                                                <span>  <button class="btn btn-info">Prev</button></span>
                                            </li>
                                            <%--Here the JS Function Will Add the Rows --%>
                                            <li data-page="next" id="prev">
                                                <span> <button class="btn btn-info">Next</button><span class=""></span></span>
                                            </li>
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
                    <jsp:include page="footer.jsp" />
                </footer>
            </div>
        </div>
    </body>
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


</html>

