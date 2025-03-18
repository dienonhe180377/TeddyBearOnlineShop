<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Hệ thống quản trị</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
            --danger-color: #e74a3b;
            --warning-color: #f6c23e;
            --info-color: #36b9cc;
            --dark-color: #5a5c69;
            --light-color: #f8f9fc;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: #f8f9fc;
        }
        
        .dashboard-container {
            padding: 1.5rem;
            margin-top: 100px;
            max-width: 1400px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .dashboard-title {
            color: var(--dark-color);
            font-weight: 700;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            border-bottom: 1px solid #e3e6f0;
            padding-bottom: 0.5rem;
        }
        
        .dashboard-card {
            border: none;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            background-color: #fff;
            padding: 1rem;
            height: 100%;
            position: relative;
            overflow: hidden;
        }
        
        .dashboard-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 0.3rem 1.5rem rgba(0, 0, 0, 0.15);
        }
        
        .dashboard-card .card-title {
            font-size: 0.7rem;
            font-weight: 600;
            text-transform: uppercase;
            color: var(--dark-color);
            margin-bottom: 0.25rem;
            letter-spacing: 0.03rem;
        }
        
        .dashboard-card .card-value {
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0;
            line-height: 1.2;
        }
        
        .card-products .card-value { color: var(--primary-color); }
        .card-orders .card-value { color: var(--secondary-color); }
        .card-revenue .card-value { color: var(--info-color); }
        .card-users .card-value { color: var(--warning-color); }
        .card-blogs .card-value { color: var(--danger-color); }
        
        .dashboard-card .card-icon {
            position: absolute;
            top: 0.75rem;
            right: 0.75rem;
            opacity: 0.3;
            font-size: 1.5rem;
        }
        
        .chart-container {
            background-color: #fff;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem rgba(0, 0, 0, 0.1);
            padding: 1rem;
            margin-bottom: 1.5rem;
            height: 100%;
        }
        
        .chart-title {
            color: var(--dark-color);
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 0.75rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid #e3e6f0;
        }
        
        .chart-wrapper {
            position: relative;
            height: 250px; /* Giới hạn chiều cao cố định */
            width: 100%;
        }
    </style>
</head>
<body>
    <jsp:include page="/gui/header.jsp"></jsp:include>
    <jsp:include page="../gui/sidebar.jsp"></jsp:include>
    
    <div class="dashboard-container">
        <h1 class="dashboard-title">
            <i class="fas fa-tachometer-alt me-2"></i>Tổng quan hệ thống
        </h1>
        
        <!-- Summary Cards -->
        <div class="row g-3 mb-4">
            <!-- Products Card -->
            <div class="col-xl-2 col-md-4 col-sm-6">
                <div class="dashboard-card card-products">
                    <i class="fas fa-box card-icon"></i>
                    <h5 class="card-title">Tổng sản phẩm</h5>
                    <p class="card-value">${totalProducts}</p>
                </div>
            </div>
            
            <!-- Orders Card -->
            <div class="col-xl-2 col-md-4 col-sm-6">
                <div class="dashboard-card card-orders">
                    <i class="fas fa-shopping-cart card-icon"></i>
                    <h5 class="card-title">Tổng đơn hàng</h5>
                    <p class="card-value">${totalOrders}</p>
                </div>
            </div>
            
            <!-- Revenue Card -->
            <div class="col-xl-2 col-md-4 col-sm-6">
                <div class="dashboard-card card-revenue">
                    <i class="fas fa-money-bill-wave card-icon"></i>
                    <h5 class="card-title">Tổng doanh thu</h5>
                    <p class="card-value"><fmt:formatNumber value="${totalRevenue}" pattern="#,###" />đ</p>
                </div>
            </div>
            
            <!-- Users Card -->
            <div class="col-xl-2 col-md-4 col-sm-6">
                <div class="dashboard-card card-users">
                    <i class="fas fa-users card-icon"></i>
                    <h5 class="card-title">Tổng người dùng</h5>
                    <p class="card-value">${totalUsers}</p>
                </div>
            </div>
            
            <!-- Blogs Card -->
            <div class="col-xl-2 col-md-4 col-sm-6">
                <div class="dashboard-card card-blogs">
                    <i class="fas fa-blog card-icon"></i>
                    <h5 class="card-title">Tổng bài viết</h5>
                    <p class="card-value">${totalBlogs}</p>
                </div>
            </div>
        </div>
        
        <!-- Charts -->
        <div class="row g-3">
            <!-- Products by Category Chart -->
            <div class="col-lg-6 col-md-12 mb-3">
                <div class="chart-container">
                    <h4 class="chart-title">
                        <i class="fas fa-chart-bar me-2"></i>Sản phẩm theo danh mục
                    </h4>
                    <div class="chart-wrapper">
                        <canvas id="productsByCategoryChart"></canvas>
                    </div>
                </div>
            </div>
            
            <!-- Revenue Trend Chart -->
            <div class="col-lg-6 col-md-12 mb-3">
                <div class="chart-container">
                    <h4 class="chart-title">
                        <i class="fas fa-chart-line me-2"></i>Xu hướng doanh thu theo tháng
                    </h4>
                    <div class="chart-wrapper">
                        <canvas id="revenueTrendChart"></canvas>
                    </div>
                </div>
            </div>
            
            <!-- User Role Distribution Chart -->
            <div class="col-lg-6 col-md-12 mb-3">
                <div class="chart-container">
                    <h4 class="chart-title">
                        <i class="fas fa-chart-pie me-2"></i>Phân bố người dùng theo vai trò
                    </h4>
                    <div class="chart-wrapper">
                        <canvas id="userRoleChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Chart Configuration
        Chart.defaults.font.size = 11;
        Chart.defaults.color = '#5a5c69';
        
        // Chart 1: Products by Category
        var categoryLabels = [
            <c:forEach var="cat" items="${categoryStats}" varStatus="status">
                '${cat.categoryName}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        var productCounts = [
            <c:forEach var="cat" items="${categoryStats}" varStatus="status">
                ${cat.productCount}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        
        var ctx1 = document.getElementById('productsByCategoryChart').getContext('2d');
        new Chart(ctx1, {
            type: 'bar',
            data: {
                labels: categoryLabels,
                datasets: [{
                    label: 'Số lượng sản phẩm',
                    data: productCounts,
                    backgroundColor: 'rgba(78, 115, 223, 0.7)',
                    borderColor: 'rgba(78, 115, 223, 1)',
                    borderWidth: 1,
                    borderRadius: 4,
                    maxBarThickness: 40
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: '#fff',
                        titleColor: '#5a5c69',
                        titleFont: {
                            weight: 'bold'
                        },
                        bodyColor: '#858796',
                        borderColor: '#e3e6f0',
                        borderWidth: 1,
                        displayColors: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        },
                        ticks: {
                            precision: 0
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });

        // Chart 2: Revenue Trend by Month
        var revenueLabels = [
            <c:forEach var="rev" items="${revenueTrend}" varStatus="status">
                '${rev.month}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        var revenueData = [
            <c:forEach var="rev" items="${revenueTrend}" varStatus="status">
                ${rev.revenue}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        
        var ctx2 = document.getElementById('revenueTrendChart').getContext('2d');
        new Chart(ctx2, {
            type: 'line',
            data: {
                labels: revenueLabels,
                datasets: [{
                    label: 'Doanh thu',
                    data: revenueData,
                    backgroundColor: 'rgba(28, 200, 138, 0.1)',
                    borderColor: 'rgba(28, 200, 138, 1)',
                    pointBackgroundColor: 'rgba(28, 200, 138, 1)',
                    pointBorderColor: '#fff',
                    pointHoverBackgroundColor: '#fff',
                    pointHoverBorderColor: 'rgba(28, 200, 138, 1)',
                    pointBorderWidth: 2,
                    pointRadius: 3,
                    pointHoverRadius: 5,
                    borderWidth: 2,
                    tension: 0.3,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    tooltip: {
                        backgroundColor: '#fff',
                        titleColor: '#5a5c69',
                        bodyColor: '#858796',
                        borderColor: '#e3e6f0',
                        borderWidth: 1,
                        displayColors: false,
                        callbacks: {
                            label: function(context) {
                                var value = context.parsed.y;
                                return new Intl.NumberFormat('vi-VN').format(value) + 'đ';
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        },
                        ticks: {
                            callback: function(value) {
                                if (value >= 1000000) {
                                    return (value / 1000000) + 'M';
                                } else if (value >= 1000) {
                                    return (value / 1000) + 'K';
                                }
                                return value;
                            }
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });

        // Chart 3: User Role Distribution
        var roleLabels = [
            <c:forEach var="role" items="${roleStats}" varStatus="status">
                '${role.roleName}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        var roleCounts = [
            <c:forEach var="role" items="${roleStats}" varStatus="status">
                ${role.userCount}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        
        var ctx3 = document.getElementById('userRoleChart').getContext('2d');
        new Chart(ctx3, {
            type: 'doughnut',
            data: {
                labels: roleLabels,
                datasets: [{
                    data: roleCounts,
                    backgroundColor: [
                        'rgba(78, 115, 223, 0.8)',
                        'rgba(28, 200, 138, 0.8)',
                        'rgba(246, 194, 62, 0.8)',
                        'rgba(231, 74, 59, 0.8)',
                        'rgba(54, 185, 204, 0.8)'
                    ],
                    borderColor: '#ffffff',
                    borderWidth: 2,
                    hoverOffset: 5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '65%',
                plugins: {
                    legend: {
                        position: 'right',
                        labels: {
                            boxWidth: 12,
                            padding: 15,
                            font: {
                                size: 11
                            }
                        }
                    },
                    tooltip: {
                        backgroundColor: '#fff',
                        titleColor: '#5a5c69',
                        bodyColor: '#858796',
                        borderColor: '#e3e6f0',
                        borderWidth: 1,
                        displayColors: false,
                        callbacks: {
                            label: function(context) {
                                var label = context.label || '';
                                var value = context.parsed || 0;
                                var total = context.dataset.data.reduce((a, b) => a + b, 0);
                                var percentage = Math.round((value / total) * 100);
                                return label + ': ' + value + ' (' + percentage + '%)';
                            }
                        }
                    }
                }
            }
        });
    </script>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
