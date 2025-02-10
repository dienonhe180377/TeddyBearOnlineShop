<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html >
<head>
    <title>User Profile</title>
    <link rel="stylesheet" href="../css/userProfile.css">
</head>
<body>
    <div class="return-button">
        <button>Home Page</button>
    </div>
    
    <div class="container">
        <div style="display: flex;">
            <div class="user-image">
                <img src="../images/usericon.jpg" alt="">
            </div>
            <div class="user-info">
                <h5 class="user-name">User Name</h5>
                <div class="row">
                    <div>
                        <p>Name</p>
                    </div>
                    <div style="margin-right: 100px;">
                        <p>User 1</p>
                    </div>
                </div>
                <div class="row">
                    <div>
                        <p>Email</p>
                    </div>
                    <div style="margin-right: 100px;">
                        <p>user1@gmail.com</p>
                    </div>
                </div>
                <div class="row">
                    <div>
                        <p>Phone</p>
                    </div>
                    <div style="margin-right: 100px;">
                        <p>0334372394</p>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="button">
            <div class="change-image">
                <button class="change-image-button">Change Image</button>
            </div>
            <div class="change-info">
                <button class="change-info-button">Change Info</button>
            </div>
            
        </div>
    </div>
    
</body>
</html>