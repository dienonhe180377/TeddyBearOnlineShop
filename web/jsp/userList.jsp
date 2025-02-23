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
            <jsp:include page="header.jsp" />
            <div class="main" style="margin-top: 193px;">

                <%--If max page is null, redirect to servlet subjectList--%>
                <div class="row" style="margin-top: 3rem">
                    <div class="col-md-1"></div>
                    <div class="col-md-2" id="form" style="min-height: 480px">
                        <h2 class="text-center">Filter</h2>
                        <div style="margin-bottom: 20px;">
                            <%-- Start search form --%>
                            <%--By name--%>
                            <form action = "" class="navbar-form">
                                <label>By Name</label><br>
                                <div class="input-group">
                                    <input  class="form-control" type="text" id="content" placeholder="Name..." name="criteria"  style="display: inline-block">

                                    <input type="hidden" name="criteriaType" value="userName">
                                </div>
                            </form>
                            <%--By user Mail--%>
                            <form action = "" class="navbar-form">
                                <label>By Mail</label>
                                <div class="input-group">
                                    <br>
                                    <input  class="form-control" type="text" id="content" placeholder="Mail..." name="criteria"  style="display: inline-block">

                                    <input type="hidden" name="criteriaType" value="userMail">
                                </div>
                            </form>
                            <%--By User Mobile--%>
                            <form action = "" class="navbar-form">
                                <label>By Mobile</label>
                                <div class="input-group">
                                    <br>
                                    <input  class="form-control" type="text" id="content" placeholder="Mobile..." name="criteria"  style="display: inline-block">

                                    <input type="hidden" name="criteriaType" value="userMobile">
                                </div>
                            </form>

                            <form action = "" class="filterForm" method="POST">
                                <%--Role--%>
                                <div class="row input-group" class="filter-sellection">
                                    <div class="col-md-6"><label>Role</label></div>
                                    <div class="col-md-6">
                                        <select name="roleFilter">
                                            <option value="-1">Not Specify</option>
                                            <option id="" value="">Admin</option>
                                            <option id="" value="">Sale</option>
                                            <option id="" value="">Manager</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="input-group">
                                    <input type="hidden" name="service" value="filter">
                                    <input type="submit" value="Filter" class="btn btn-primary" style="margin: 20px auto;">
                                </div>
                            </form>

                        </div>
                    </div>

                    <div class="col-md-8" id="form" style="min-height: 480px; min-width: 1000px">
                        <div class="container" >
                            <%-- Table Container --%>
                            <div class="form-group" style="max-width: 98%; margin:5px">
                                <div class="form-group">
                                    <a href=""><button class="btn btn-success" style="float:right;margin: 5px">Add new User</button></a>
                                </div>
                                <%-- Table of User List--%>
                                <table id="table-id" class="table table-bordered table-striped">
                                    <thead>
                                        <%-- Headers of Table--%>
                                        <tr style="background-color: #F0D8D5;">
                                            <th>User Id</th>
                                            <th>User Name</th>
                                            <th>Email</th>
                                            <th>Mobile</th>
                                            <th>Role</th>
                                            <th>Manage</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>6</td>
                                            <td>Expert1</td>
                                            <td>Expert1@gmail.com</td>
                                            <td>0969044716</td>
                                            <td>Expert</td>
                                            <td><a href=""><div class="btn btn-success">Edit User</div></a></td>
                                        </tr>
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
            var maxRows = 7; // Cố định 7 dòng trên 1 trang
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

            // Tạo nút phân trang nếu số dòng vượt quá maxRows
            if (totalRows > maxRows) {
                var pagenum = Math.ceil(totalRows / maxRows);
                for (var i = 1; i <= pagenum; i++) {
                    $('.pagination #prev').before(
                            '<li class="btn btn-info" data-page="' + i + '">\
                        <div>' + i + '<div></div></div>\
                    </li>'
                            ).show();
                }
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
                    if (lastPage == $('.pagination li').length - 2)
                        return;
                    pageNum = ++lastPage;
                }
                lastPage = pageNum;
                var trIndex = 0;
                $('.pagination li').removeClass('active');
                $('.pagination [data-page="' + lastPage + '"]').addClass('active');
                limitPagging();

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
