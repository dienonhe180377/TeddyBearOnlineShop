<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Điểm danh hàng ngày</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --success-color: #1cc88a;
            --warning-color: #f6c23e;
            --danger-color: #e74a3b;
            --secondary-color: #858796;
            --light-color: #f8f9fc;
            --dark-color: #5a5c69;
        }
        
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fc;
            color: #5a5c69;
        }
        
        .attendance-container {
            max-width: 800px;
            margin: 120px auto 30px;
            padding: 0 15px;
        }
        
        .attendance-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .attendance-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .attendance-header {
            background: linear-gradient(135deg, var(--primary-color), #3a57c9);
            color: white;
            padding: 25px;
            text-align: center;
            position: relative;
        }
        
        .attendance-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 10px;
            letter-spacing: 0.5px;
        }
        
        .attendance-subtitle {
            font-size: 16px;
            opacity: 0.9;
            margin-bottom: 0;
        }
        
        .attendance-date {
            font-size: 18px;
            font-weight: 500;
            margin-top: 10px;
        }
        
        .attendance-body {
            padding: 30px;
            text-align: center;
        }
        
        .attendance-status {
            margin-bottom: 30px;
            font-size: 18px;
        }
        
        .attendance-btn {
            padding: 12px 40px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 50px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        
        .attendance-btn-success {
            background-color: var(--success-color);
            border-color: var(--success-color);
        }
        
        .attendance-btn-success:hover {
            background-color: #19b37b;
            border-color: #19b37b;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(28, 200, 138, 0.3);
        }
        
        .attendance-btn-secondary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }
        
        .attendance-info {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eaecf4;
        }
        
        .attendance-info-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 15px;
        }
        
        .attendance-stats {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 20px;
        }
        
        .stat-item {
            text-align: center;
            padding: 15px;
            border-radius: 10px;
            background-color: #f8f9fc;
            min-width: 120px;
        }
        
        .stat-value {
            font-size: 24px;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 14px;
            color: var(--secondary-color);
        }
        
        .streak-badge {
            display: inline-block;
            padding: 5px 15px;
            background-color: #fff3cd;
            color: #856404;
            border-radius: 30px;
            font-weight: 500;
            font-size: 14px;
            margin-top: 15px;
        }
        
        .alert {
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 25px;
            border: none;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
        }
        
        .alert-info {
            background-color: rgba(78, 115, 223, 0.1);
            color: var(--primary-color);
            border-left: 4px solid var(--primary-color);
        }
        
        .alert-success {
            background-color: rgba(28, 200, 138, 0.1);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }
        
        .confetti {
            position: fixed;
            width: 10px;
            height: 10px;
            background-color: #f6c23e;
            opacity: 0;
            top: 0;
            animation: confetti 5s ease-in-out infinite;
        }
        
        @keyframes confetti {
            0% {
                transform: translateY(0) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(100vh) rotate(720deg);
                opacity: 0;
            }
        }
        
        @media (max-width: 768px) {
            .attendance-container {
                margin-top: 100px;
            }
            
            .attendance-title {
                font-size: 24px;
            }
            
            .attendance-stats {
                flex-direction: column;
                gap: 15px;
                align-items: center;
            }
            
            .stat-item {
                width: 80%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/gui/header.jsp"></jsp:include>
    <jsp:include page="/gui/sidebar.jsp"></jsp:include>
    
    <div class="attendance-container">
        <div class="attendance-card animate__animated animate__fadeIn">
            <div class="attendance-header">
                <h1 class="attendance-title">
                    <i class="fas fa-calendar-check me-2"></i>Điểm danh hàng ngày
                </h1>
                <p class="attendance-subtitle">Duy trì điểm danh đều đặn để nhận thêm ưu đãi</p>
                
                <p class="attendance-date">
                    <i class="far fa-calendar-alt me-2"></i>
                    <jsp:useBean id="now" class="java.util.Date" />
                    <fmt:formatDate value="${now}" pattern="EEEE, dd/MM/yyyy" />
                </p>
            </div>
            
            <div class="attendance-body">
                <!-- Hiển thị thông báo nếu có -->
                <c:if test="${not empty attendanceMessage}">
                    <div class="alert ${attended ? 'alert-success' : 'alert-info'} animate__animated animate__fadeIn">
                        <i class="${attended ? 'fas fa-check-circle' : 'fas fa-info-circle'} me-2"></i>
                        ${attendanceMessage}
                    </div>
                </c:if>
                
                <div class="attendance-status">
                    <c:choose>
                        <c:when test="${attended}">
                            <p class="mb-3">
                                <i class="fas fa-check-circle text-success me-2"></i>
                                Bạn đã điểm danh thành công hôm nay!
                            </p>
                            <button type="button" class="btn attendance-btn attendance-btn-secondary" disabled>
                                <i class="fas fa-clock me-2"></i>Đã điểm danh
                            </button>
                            
                            <!-- Hiển thị streak nếu có -->
                            <c:if test="${not empty currentStreak && currentStreak > 1}">
                                <div class="mt-3">
                                    <span class="streak-badge">
                                        <i class="fas fa-fire me-1"></i> Chuỗi điểm danh: ${currentStreak} ngày
                                    </span>
                                </div>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <p class="mb-3">
                                <i class="fas fa-exclamation-circle text-warning me-2"></i>
                                Bạn chưa điểm danh hôm nay
                            </p>
                            <form action="${pageContext.request.contextPath}/seller/attendance" method="post">
                                <button type="submit" class="btn attendance-btn attendance-btn-success animate__animated animate__pulse animate__infinite" id="attendanceBtn">
                                    <i class="fas fa-check-circle me-2"></i>Điểm danh ngay
                                </button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Thông tin điểm danh -->
                <div class="attendance-info">
                    <h4 class="attendance-info-title">Thống kê điểm danh của bạn</h4>
                    
                    <div class="attendance-stats">
                        <div class="stat-item">
                            <div class="stat-value">${totalAttendance}</div>
                            <div class="stat-label">Tổng điểm danh</div>
                        </div>
                        
                        <div class="stat-item">
                            <div class="stat-value">${currentStreak}</div>
                            <div class="stat-label">Chuỗi hiện tại</div>
                        </div>
                        
                        <div class="stat-item">
                            <div class="stat-value">${bestStreak}</div>
                            <div class="stat-label">Chuỗi tốt nhất</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Hiệu ứng confetti khi đã điểm danh
            const isAttended = ${attended};
            
            if (isAttended) {
                createConfetti();
            }
            
            // Nút điểm danh
            const attendanceBtn = document.getElementById('attendanceBtn');
            if (attendanceBtn) {
                attendanceBtn.addEventListener('click', function() {
                    this.disabled = true;
                    this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
                });
            }
            
            // Tự động ẩn thông báo sau 5 giây
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
                    alert.classList.add('animate__fadeOut');
                    setTimeout(function() {
                        alert.style.display = 'none';
                    }, 1000);
                });
            }, 5000);
        });
        
        // Hiệu ứng confetti
        function createConfetti() {
            const confettiCount = 100;
            const container = document.body;
            
            for (let i = 0; i < confettiCount; i++) {
                const confetti = document.createElement('div');
                confetti.className = 'confetti';
                
                // Random properties
                const colors = ['#4e73df', '#1cc88a', '#f6c23e', '#e74a3b', '#36b9cc'];
                const size = Math.random() * 10 + 5;
                
                confetti.style.left = Math.random() * 100 + 'vw';
                confetti.style.width = size + 'px';
                confetti.style.height = size + 'px';
                confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
                confetti.style.animationDelay = Math.random() * 5 + 's';
                confetti.style.animationDuration = Math.random() * 3 + 2 + 's';
                
                container.appendChild(confetti);
                
                // Remove after animation
                setTimeout(() => {
                    confetti.remove();
                }, 5000);
            }
        }
    </script>
    
    <jsp:include page="/gui/footer.jsp"></jsp:include>
</body>
</html>
