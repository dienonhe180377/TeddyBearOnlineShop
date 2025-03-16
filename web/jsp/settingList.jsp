<%-- 
    Copyright(C) 2021, Group Tree - SWP391, SE1509, FA21
    Created on : Oct 24, 2021, 9:01:53 PM
    Quiz practicing system

    Record of change:
    Date        Version     Author          Description
    24/10/21    1.0         DuongNHHE150328 First Deploy
    24/10/21    1.1         DuongNHHE150328 Complete style
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Question List</title>
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
                            <h5>Search Setting</h5>
                            <%-- Select number of Rows show on table --%>
                            <input type="text" class="form-control" name="search" style="width: 150px;">
                        </div>
                        <div class="dropdown" style="width: 50%;float: left">
                            <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" style="float: right; margin-top: auto;margin-bottom: auto">
                                Filter by
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="">All</a>
                                <a class="dropdown-item" href="">User Role</a>
                                <a class="dropdown-item" href="">Post Category</a>
                                <a class="dropdown-item" href="">Subject Category</a>
                                <a class="dropdown-item" href="">Test Type</a>
                                <a class="dropdown-item" href="">Quiz Level</a>
                                <a class="dropdown-item" href="">Lesson Type</a>
                                <a class="dropdown-item" href="">Dimension Type</a>
                            </div>

                            <a href=""><button type="button" class="btn btn-primary" style="float: right; margin-top: auto;margin-bottom: auto;margin-right: 10px;">
                                    Add setting
                                </button></a>
                        </div>
                    </div>

                    <%-- Table of QuestionList--%>
                    <table id="table-id" class="table table-bordered table-striped tab1">
                        <%-- Headers of Table--%>
                        <thead>
                            <tr style="background-color: #F0D8D5;">
                                <th>Loại Setting</th>
                                <th>Tên Setting</th>
                                <th>Trạng thái</th>
                                <th>Sửa/Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- user role list --%>
                            <tr>
                                <td>User Roles</td>
                                <td>Manager</td>
                                <td>Active</td>
                                <td><a href=""><button class="btn btn-success">Edit</button></a></td>
                            </tr>
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
