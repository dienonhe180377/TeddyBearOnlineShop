<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý điểm danh</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <!-- Flatpickr CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

        <!-- Thêm vào phần head của trang JSP -->
        <script src="https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/file-saver@2.0.5/dist/FileSaver.min.js"></script>

        <!-- Custom CSS -->
        <style>
            :root {
                --primary-color: #4e73df;
                --secondary-color: #858796;
                --success-color: #1cc88a;
                --info-color: #36b9cc;
                --warning-color: #f6c23e;
                --danger-color: #e74a3b;
                --light-color: #f8f9fc;
                --dark-color: #5a5c69;
            }

            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f8f9fc;
                color: #5a5c69;
                margin-top: 80px;
            }

            .page-header {
                margin-bottom: 1.5rem;
                border-bottom: 1px solid #e3e6f0;
                padding-bottom: 1rem;
            }

            .page-title {
                font-size: 1.75rem;
                font-weight: 500;
                color: var(--dark-color);
                margin-bottom: 0.5rem;
            }

            .breadcrumb {
                background-color: transparent;
                padding: 0;
                margin-bottom: 0;
            }

            .breadcrumb-item + .breadcrumb-item::before {
                content: "›";
                font-size: 1.1rem;
                line-height: 1;
                color: var(--secondary-color);
            }

            .card {
                border: none;
                border-radius: 0.35rem;
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                margin-bottom: 1.5rem;
            }

            .card-header {
                background-color: #f8f9fc;
                border-bottom: 1px solid #e3e6f0;
                padding: 1rem 1.25rem;
            }

            .card-header h5 {
                font-size: 1rem;
                font-weight: 700;
                color: var(--primary-color);
                margin-bottom: 0;
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }

            .filter-form {
                padding: 1.25rem;
                background-color: #fff;
                border-radius: 0.35rem;
            }

            .form-label {
                font-weight: 500;
                color: var(--dark-color);
                margin-bottom: 0.5rem;
            }

            .form-control {
                border-radius: 0.35rem;
                border: 1px solid #d1d3e2;
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
                color: #6e707e;
            }

            .form-control:focus {
                border-color: #bac8f3;
                box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                padding: 0.5rem 1.5rem;
                font-weight: 500;
                border-radius: 0.35rem;
            }

            .btn-primary:hover {
                background-color: #3a57c9;
                border-color: #3a57c9;
            }

            .btn-icon {
                padding: 0.375rem 0.75rem;
            }

            .btn-icon i {
                margin-right: 0.25rem;
            }

            .table {
                color: #5a5c69;
            }

            .table thead th {
                background-color: #f8f9fc;
                color: #4e73df;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.85rem;
                letter-spacing: 0.05em;
                border-bottom: 2px solid #e3e6f0;
                vertical-align: middle;
            }

            .table tbody tr:hover {
                background-color: #f8f9fc;
            }

            .table td {
                vertical-align: middle;
                padding: 0.75rem;
            }

            .status-badge {
                padding: 0.25rem 0.75rem;
                border-radius: 0.35rem;
                font-size: 0.75rem;
                font-weight: 600;
                letter-spacing: 0.05em;
                text-transform: uppercase;
            }

            .status-badge-success {
                background-color: rgba(28, 200, 138, 0.1);
                color: var(--success-color);
            }

            .status-badge-danger {
                background-color: rgba(231, 74, 59, 0.1);
                color: var(--danger-color);
            }

            .pagination {
                margin-bottom: 0;
            }

            .page-link {
                color: var(--primary-color);
                border: 1px solid #e3e6f0;
                padding: 0.5rem 0.75rem;
            }

            .page-item.active .page-link {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .page-item.disabled .page-link {
                color: #858796;
            }

            .flatpickr-input {
                background-color: #fff !important;
            }

            .summary-card {
                border-left: 0.25rem solid;
                border-radius: 0.35rem;
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                margin-bottom: 1.5rem;
            }

            .summary-card-primary {
                border-left-color: var(--primary-color);
            }

            .summary-card-success {
                border-left-color: var(--success-color);
            }

            .summary-card-info {
                border-left-color: var(--info-color);
            }

            .summary-card-warning {
                border-left-color: var(--warning-color);
            }

            .summary-card .card-body {
                padding: 1.25rem;
            }

            .summary-card .text-xs {
                font-size: 0.7rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.1em;
                color: var(--secondary-color);
            }

            .summary-card .text-primary {
                color: var(--primary-color) !important;
            }

            .summary-card .text-success {
                color: var(--success-color) !important;
            }

            .summary-card .text-info {
                color: var(--info-color) !important;
            }

            .summary-card .text-warning {
                color: var(--warning-color) !important;
            }

            .summary-card .h5 {
                font-size: 1.25rem;
                font-weight: 700;
                margin-bottom: 0;
                color: var(--dark-color);
            }

            .summary-card .icon {
                font-size: 2rem;
                opacity: 0.3;
            }

            @media (max-width: 768px) {
                .card-header {
                    padding: 0.75rem 1rem;
                }

                .filter-form {
                    padding: 1rem;
                }

                .summary-cards .col-xl-3 {
                    margin-bottom: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="${contextPath}/gui/header.jsp"></jsp:include>
        <jsp:include page="../gui/sidebar.jsp"></jsp:include>

            <div class="container-fluid py-4">
                <!-- Page Header -->
                <div class="page-header d-flex justify-content-between align-items-center">
                    <div>
                        <h1 class="page-title">Quản lý điểm danh</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/manager/dashboard">Trang chủ</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Danh sách điểm danh</li>
                        </ol>
                    </nav>
                </div>
                <div>
                    <button type="button" class="btn btn-success btn-icon" id="exportExcel">
                        <i class="fas fa-file-excel"></i> Xuất Excel
                    </button>
                </div>
            </div>



            <!-- Filter Card -->
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="m-0"><i class="fas fa-filter me-2"></i>Bộ lọc</h5>
                    <button class="btn btn-sm btn-outline-primary" type="button" data-bs-toggle="collapse" data-bs-target="#filterCollapse" aria-expanded="true" aria-controls="filterCollapse">
                        <i class="fas fa-chevron-down"></i>
                    </button>
                </div>
                <div class="collapse show" id="filterCollapse">
                    <div class="filter-form">
                        <form method="get" action="${pageContext.request.contextPath}/manager/attendance" id="filterForm">
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label for="startDate" class="form-label">Từ ngày:</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
                                        <input type="text" name="startDate" id="startDate" class="form-control datepicker" value="${startDate}" placeholder="Chọn ngày bắt đầu" />
                                    </div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="endDate" class="form-label">Đến ngày:</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
                                        <input type="text" name="endDate" id="endDate" class="form-control datepicker" value="${endDate}" placeholder="Chọn ngày kết thúc" />
                                    </div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="status" class="form-label">Trạng thái:</label>
                                    <select name="status" id="status" class="form-select">
                                        <option value="" ${empty param.status ? 'selected' : ''}>Tất cả</option>
                                        <option value="true" ${param.status eq 'true' ? 'selected' : ''}>Có mặt</option>
                                        <option value="false" ${param.status eq 'false' ? 'selected' : ''}>Vắng mặt</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-8 mb-3">
                                    <label for="userName" class="form-label">Tên người dùng:</label>
                                    <input type="text" name="userName" id="userName" class="form-control" value="${param.userName}" placeholder="Nhập tên người dùng" />
                                </div>
                                <div class="col-md-4 d-flex align-items-end mb-3">
                                    <div class="d-grid gap-2 d-md-flex w-100">
                                        <button type="submit" class="btn btn-primary flex-grow-1">
                                            <i class="fas fa-search me-1"></i> Tìm kiếm
                                        </button>
                                        <button type="button" class="btn btn-secondary" id="resetFilter">
                                            <i class="fas fa-redo-alt me-1"></i> Đặt lại
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Data Table Card -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="m-0"><i class="fas fa-list me-2"></i>Danh sách điểm danh</h5>
                    <div class="badge bg-primary">${attendanceList.size()} kết quả</div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover" id="attendanceTable">
                            <thead>
                                <tr>
                                    <th style="width: 5%">ID</th>
                                    <th style="width: 10%">User ID</th>
                                    <th style="width: 25%">Tên người dùng</th>
                                    <th style="width: 15%">Trạng thái</th>
                                    <th style="width: 25%">Thời gian điểm danh</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="att" items="${attendanceList}">
                                    <tr>
                                        <td>${att.id}</td>
                                        <td>${att.userId}</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="avatar me-2 bg-light rounded-circle text-center" style="width: 32px; height: 32px; line-height: 32px;">
                                                    <i class="fas fa-user text-primary"></i>
                                                </div>
                                                <div>${att.userName}</div>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${att.status}">
                                                    <span class="status-badge status-badge-success">
                                                        <i class="fas fa-check-circle me-1"></i> Có mặt
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-badge-danger">
                                                        <i class="fas fa-times-circle me-1"></i> Vắng mặt
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${att.updateTime}" pattern="dd/MM/yyyy HH:mm:ss" var="formattedDate" />
                                            <c:choose>
                                                <c:when test="${empty formattedDate}">
                                                    ${att.updateTime}
                                                </c:when>
                                                <c:otherwise>
                                                    ${formattedDate}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty attendanceList}">
                                    <tr>
                                        <td colspan="6" class="text-center py-4">
                                            <div class="d-flex flex-column align-items-center">
                                                <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                                <h5 class="text-muted">Không tìm thấy kết quả nào</h5>
                                                <p class="text-muted">Thử thay đổi bộ lọc tìm kiếm của bạn</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=1&startDate=${startDate}&endDate=${endDate}&status=${param.status}&userName=${param.userName}" aria-label="First">
                                        <span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
                                    </a>
                                </li>
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage - 1}&startDate=${startDate}&endDate=${endDate}&status=${param.status}&userName=${param.userName}" aria-label="Previous">
                                        <span aria-hidden="true"><i class="fas fa-angle-left"></i></span>
                                    </a>
                                </li>

                                <!-- Tính toán startPage -->
                                <c:choose>
                                    <c:when test="${currentPage > 2}">
                                        <c:set var="startPage" value="${currentPage - 2}" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="startPage" value="1" />
                                    </c:otherwise>
                                </c:choose>

                                <!-- Tính toán endPage -->
                                <c:set var="endPage" value="${startPage + 4}" />
                                <c:if test="${endPage > totalPages}">
                                    <c:set var="endPage" value="${totalPages}" />
                                    <!-- Điều chỉnh lại startPage nếu cần -->
                                    <c:if test="${endPage > 5}">
                                        <c:set var="startPage" value="${endPage - 4}" />
                                    </c:if>
                                </c:if>

                                <!-- Hiển thị các số trang -->
                                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}&startDate=${startDate}&endDate=${endDate}&status=${param.status}&userName=${param.userName}">${i}</a>
                                    </li>
                                </c:forEach>

                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage + 1}&startDate=${startDate}&endDate=${endDate}&status=${param.status}&userName=${param.userName}" aria-label="Next">
                                        <span aria-hidden="true"><i class="fas fa-angle-right"></i></span>
                                    </a>
                                </li>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${totalPages}&startDate=${startDate}&endDate=${endDate}&status=${param.status}&userName=${param.userName}" aria-label="Last">
                                        <span aria-hidden="true"><i class="fas fa-angle-double-right"></i></span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>

                </div>
            </div>
        </div>



        <jsp:include page="${contextPath}/gui/footer.jsp"></jsp:include>

            <!-- Bootstrap Bundle with Popper -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <!-- jQuery -->
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <!-- Flatpickr -->
            <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
            <script src="https://npmcdn.com/flatpickr/dist/l10n/vi.js"></script>
            <!-- SheetJS -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    // Initialize Flatpickr date pickers
                    flatpickr(".datepicker", {
                        dateFormat: "Y-m-d",
                        locale: "vi",
                        allowInput: true,
                        altInput: true,
                        altFormat: "d/m/Y"
                    });

                    // Reset filter button
                    document.getElementById('resetFilter').addEventListener('click', function () {
                        document.getElementById('startDate').value = '';
                        document.getElementById('endDate').value = '';
                        document.getElementById('status').value = '';
                        document.getElementById('userName').value = '';
                        document.getElementById('filterForm').submit();
                    });

                
                });
        </script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('exportExcel').addEventListener('click', function () {
                    // Lấy dữ liệu từ bảng
                    const table = document.getElementById('attendanceTable');

                    // Tạo mảng dữ liệu cho Excel
                    let data = [];

                    // Thêm tiêu đề
                    const headers = [];
                    const headerRow = table.querySelector('thead tr');
                    const headerCells = headerRow.querySelectorAll('th');
                    headerCells.forEach(cell => {
                        // Bỏ qua cột "Thao tác" nếu có
                        if (cell.textContent.trim() !== "Thao tác") {
                            headers.push(cell.textContent.trim());
                        }
                    });
                    data.push(headers);

                    // Thêm dữ liệu từ các hàng
                    const rows = table.querySelectorAll('tbody tr');
                    rows.forEach(row => {
                        const rowData = [];
                        const cells = row.querySelectorAll('td');
                        cells.forEach(cell => {
                            // Bỏ qua cột "Thao tác" nếu có
                            if (!cell.querySelector('.action-buttons')) {
                                rowData.push(cell.textContent.trim());
                            }
                        });
                        data.push(rowData);
                    });

                    // Tạo workbook mới
                    const wb = XLSX.utils.book_new();
                    const ws = XLSX.utils.aoa_to_sheet(data);

                    // Tùy chỉnh độ rộng cột
                    const colWidths = headers.map(h => ({wch: Math.max(h.length, 10)}));
                    ws['!cols'] = colWidths;

                    // Thêm worksheet vào workbook
                    XLSX.utils.book_append_sheet(wb, ws, "Danh sách điểm danh");

                    // Tạo tên file
                    let fileName = "danh_sach_diem_danh.xlsx";

                    // Xuất file Excel
                    XLSX.writeFile(wb, fileName);
                });
            });
        </script>

    </body>
</html>
