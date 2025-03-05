﻿


select * from UserRole
--UserRole insert
insert into UserRole values('Customer')
insert into UserRole values('Seller')
insert into UserRole values('Marketing')
insert into UserRole values('Manager')
insert into UserRole values('Admin')

select * from ProductType
--ProductType insert
insert into ProductType values(N'Gấu Bông')
insert into ProductType values(N'Móc Khóa')
insert into ProductType values(N'Gối Ôm')


select * from Category
--Category insert
insert into Category values(N'Gấu Bông May Mắn')
insert into Category values(N'Gấu bông Ghi Âm')
insert into Category values(N'Pikachu')
insert into Category values(N'Stitch')
insert into Category values(N'Cinnamaroll')
insert into Category values(N'Thú Bông Cảm Xúc')
insert into Category values(N'Gối Ôm Dài')
insert into Category values(N'Gối Ôm Béo')


select * from Product
--Product insert
insert into Product values(N'Stitch Ngồi',4,1)
insert into Product values(N'Stitch Ôm Tim',4,1)
insert into Product values(N'Stitch Bông Tím',4,1)
insert into Product values(N'Gối Cổ Kèm Mũ Stitch',4,3)
insert into Product values(N'Móc Khóa Stitch Bông',4,2)
insert into Product values(N'Cinnamoroll Đeo Túi',5,1)
insert into Product values(N'Kuromi Đeo Túi',5,1)
insert into Product values(N'Kuromi Cupid',5,1)
insert into Product values(N'Chó Vàng Purin',5,1)
insert into Product values(N'Kuromi Galaxy',5,1)
insert into Product values(N'Gấu Bông Teddy',2,1)
insert into Product values(N'Capybara Hồng',2,1)
insert into Product values(N'Babyboo Ghi Âm',2,1)
insert into Product values(N'Head Tales Ghi Âm',2,1)
insert into Product values(N'Hug Me Teddy',2,1)
insert into Product values(N'Capybara Thần Tài',1,1)
insert into Product values(N'Rồng Vàng',1,1)
insert into Product values(N'Rồng Búp Bê Baby',1,1)
insert into Product values(N'Rồng Xanh Ôm Cá',1,1)
insert into Product values(N'Bộ 4 Rồng Happy',1,1)
insert into Product values(N'Hải Cẩu Sushi',8,3)
insert into Product values(N'Hải Cẩu Mũm Mĩm',8,3)
insert into Product values(N'Chó Bông Corgi',8,3)
insert into Product values(N'Heo Lulu Ong',8,3)
insert into Product values(N'Hải Cẩu Bông',8,3)
insert into Product values(N'Gối Ôm Hải Cẩu',7,3)
insert into Product values(N'Husky Má Tim',7,3)
insert into Product values(N'Shiba Giơ Tay',7,3)
insert into Product values(N'Lotso Mặt Hoa',7,3)
insert into Product values(N'Cà Rốt Lông',7,3)
insert into Product values(N'Pikachu Tai Đen',3,1)
insert into Product values(N'Purin Hồng',3,1)
insert into Product values(N'Kabigon',3,1)
insert into Product values(N'Eve Tai Dài',3,1)
insert into Product values(N'Pikachu Bông Mềm',3,1)
insert into Product values(N'Mihi Cảm Xúc',6,1)
insert into Product values(N'Bạch Tuộc Khổng Lồ',6,1)
insert into Product values(N'Móc Khóa Bạch Tuộc',6,2)
insert into Product values(N'Bạch Tuộc Siêu To',6,1)

select * from ProductImage
--Product Images insert
insert into ProductImage values('images/stitchNgoiDoiMuOmKem.jpg',1)
insert into ProductImage values('images/stitch-ngoi-doi-mu-om-kem-6.jpg',1)
insert into ProductImage values('images/stitch-ngoi-doi-mu-om-kem-5.jpg',1)
insert into ProductImage values('images/stitch-ngoi-doi-mu-om-kem-7.jpg',1)
insert into ProductImage values('images/Gau-Bong-Stitch-Om-Tim-5-500x500.jpg',2)
insert into ProductImage values('images/Gau-Bong-Stitch-Om-Tim-7.jpg',2)
insert into ProductImage values('images/Gau-Bong-Stitch-Om-Tim-8.jpg',2)
insert into ProductImage values('images/Gau-Bong-Stitch-Om-Tim-9.jpg',2)
insert into ProductImage values('images/Stitch-tim-nho-5-500x500.jpg',3)
insert into ProductImage values('images/Stitch-tim-nho-1.jpg',3)
insert into ProductImage values('images/Stitch-tim-nho-12.jpg',3)
insert into ProductImage values('images/Stitch-mu-4-500x500.jpg',4)
insert into ProductImage values('images/goi-co-mu-stitch-4.jpg',4)
insert into ProductImage values('images/goi-co-mu-stitch-5.jpg',4)
insert into ProductImage values('images/moc-khoa-stitch-tai-dai-2-500x500.jpg',5)
insert into ProductImage values('images/stitch-tai-dai.jpg',5)
insert into ProductImage values('images/moc-khoa-stitch-tai-dai-1.jpg',5)
insert into ProductImage values('images/Az4628962022474_38ced04d3aecc838fbe9ca96c04a1b9b-jpg.webp',6)
insert into ProductImage values('images/Az4626448838208_9a32f3f15c4de0a8b2157b37fd8e49d5-jpg.webp',6)
insert into ProductImage values('images/Az4626448966985_044c7987fd95f2b2d76552b9d12757ca-jpg.webp',6)
insert into ProductImage values('images/Az4626450573660_c1db553568115e837f3bfda80721e1fc-500x500.webp',7)
insert into ProductImage values('images/Az4626450656119_a510a7c3037aebf5a7c772a88da818a2-jpg.webp',7)
insert into ProductImage values('images/Az4626450770633_2937451d388cc7fd53658e53a2ad593d-jpg.webp',7)
insert into ProductImage values('images/kuromi-kupid-2-jpg-500x500.webp',8)
insert into ProductImage values('images/kuromi-kupid-9-jpg.webp',8)
insert into ProductImage values('images/kuromi-kupid-7-jpg.webp',8)
insert into ProductImage values('images/Az4628962050328_0dfd2fa3689719a3e29049867259deca-500x500.webp',9)
insert into ProductImage values('images/Az4623341273462_1aac1d87b072f12e61097356900742a7-jpg.webp',9)
insert into ProductImage values('images/Az4623341240740_70cc567f29be4a7e7bcd26b87d95e200-jpg.webp',9)
insert into ProductImage values('images/kuromi-galaxy-6-500x500.webp',10)
insert into ProductImage values('images/kuromi-galaxy-8-jpg.webp',10)
insert into ProductImage values('images/kuromi-galaxy-7-jpg.webp',10)
insert into ProductImage values('images/gau-ghi-am-17-1.jpg',11)
insert into ProductImage values('images/gau-ghi-am-13.jpg',11)
insert into ProductImage values('images/gau-ghi-am-5-1.jpg',11)
insert into ProductImage values('images/Capybara-hong-deo-bong-nhay-hat-1-500x500.jpg',12)
insert into ProductImage values('images/Capybara-hong-deo-bong-nhay-hat-6.jpg',12)
insert into ProductImage values('images/Gau-Bong-BabyBoo-Ghi-Am-1-500x500.jpg',13)
insert into ProductImage values('images/gau-ghi-am-17-1-500x500.jpg',14)
insert into ProductImage values('images/gau-ghi-am-17-500x500.jpg',15)
insert into ProductImage values('images/Chuot-capybara-than-tai-1-500x500.jpg',16)
insert into ProductImage values('images/Az4995136766781_ee8bba271ecfedffd684b7738c71504f-jpg-500x500.webp',17)
insert into ProductImage values('images/Az4926699272776_687fc371d5557fcecb50b21167d8c45d-jpg-500x500.webp',18)
insert into ProductImage values('images/rong-xanh-om-ca-5-jpg-500x500.webp',19)
insert into ProductImage values('images/Az4986240969507_a00ee2db46fbf0d54d649394385beed0-jpg-500x500.webp',20)
insert into ProductImage values('images/Hai-Cau-Sushi-7-500x500.jpg',21)
insert into ProductImage values('images/Hai-Cau-Mum-Mim-11-500x500.jpg',22)
insert into ProductImage values('images/cho-corgi-beo-500x500.webp',23)
insert into ProductImage values('images/heo-lulu-ong-nam-9-500x500.webp',24)
insert into ProductImage values('images/hai-cau-bien-500x500.webp',25)
insert into ProductImage values('images/goi-om-hai-cau-2-500x500.jpg',26)
insert into ProductImage values('images/goi-om-hussky-ma-tim-xam-nam-1-500x500.webp',27)
insert into ProductImage values('images/goi-om-cho-nam-gio-tay-500x500.webp',28)
insert into ProductImage values('images/Goi-om-Lotso-mat-hoa-1-500x500.jpg',29)
insert into ProductImage values('images/ca-rot-long-1-500x500.jpg',30)
insert into ProductImage values('images/pokemon-tai-den-4.jpg',31)
insert into ProductImage values('images/Purin-Hong-Pokemon-1.jpg',32)
insert into ProductImage values('images/Kabigon-Pokemon-12.jpg',33)
insert into ProductImage values('images/Eve-Tai-Dai-Pokemon-11-500x500.jpg',34)
insert into ProductImage values('images/pikachu-bong-mem-3-500x500.jpg',35)
insert into ProductImage values('images/mihi-cam-xuc.jpg',36)
insert into ProductImage values('images/bach-tuoc-cam-xuc-khong-lo.jpg',37)
insert into ProductImage values('images/moc-khoa-bach-tuoc-cam-xuc-19-500x500.jpg',38)
insert into ProductImage values('images/bach-tuoc-cam-xuc-khong-lo-500x500.jpg',39)

select * from Size
--Size insert
insert into Size values ('55cm',300,65000,1)
insert into Size values ('70cm',300,85000,1)
insert into Size values ('90cm',300,115000,1)
insert into Size values ('55cm',300,65000,2)
insert into Size values ('70cm',300,85000,2)
insert into Size values ('90cm',300,115000,2)
insert into Size values ('55cm',300,75000,3)
insert into Size values ('70cm',300,95000,3)
insert into Size values ('90cm',300,125000,3)
insert into Size values ('35cm',300,35000,4)
insert into Size values ('60cm',300,65000,4)
insert into Size values ('80cm',300,95000,4)
insert into Size values ('18cm',300,35000,5)
insert into Size values ('55cm',300,65000,6)
insert into Size values ('70cm',300,85000,6)
insert into Size values ('90cm',300,115000,6)
insert into Size values ('55cm',300,65000,7)
insert into Size values ('70cm',300,85000,7)
insert into Size values ('90cm',300,115000,7)
insert into Size values ('55cm',300,65000,8)
insert into Size values ('70cm',300,85000,8)
insert into Size values ('90cm',300,115000,8)
insert into Size values ('55cm',300,65000,9)
insert into Size values ('70cm',300,85000,9)
insert into Size values ('90cm',300,115000,9)
insert into Size values ('55cm',300,65000,10)
insert into Size values ('70cm',300,85000,10)
insert into Size values ('90cm',300,115000,10)
insert into Size values ('55cm',300,65000,11)
insert into Size values ('70cm',300,85000,11)
insert into Size values ('90cm',300,115000,11)
insert into Size values ('55cm',300,65000,12)
insert into Size values ('70cm',300,85000,12)
insert into Size values ('90cm',300,115000,12)
insert into Size values ('55cm',300,65000,13)
insert into Size values ('70cm',300,85000,13)
insert into Size values ('90cm',300,115000,13)
insert into Size values ('55cm',300,65000,14)
insert into Size values ('70cm',300,85000,14)
insert into Size values ('90cm',300,115000,14)
insert into Size values ('55cm',300,65000,15)
insert into Size values ('70cm',300,85000,15)
insert into Size values ('90cm',300,115000,15)
insert into Size values ('55cm',300,65000,16)
insert into Size values ('70cm',300,85000,16)
insert into Size values ('90cm',300,115000,16)
insert into Size values ('55cm',300,65000,17)
insert into Size values ('70cm',300,85000,17)
insert into Size values ('90cm',300,115000,17)
insert into Size values ('55cm',300,65000,18)
insert into Size values ('70cm',300,85000,18)
insert into Size values ('90cm',300,115000,18)
insert into Size values ('55cm',300,65000,19)
insert into Size values ('70cm',300,85000,19)
insert into Size values ('90cm',300,115000,19)
insert into Size values ('55cm',300,65000,20)
insert into Size values ('70cm',300,85000,20)
insert into Size values ('90cm',300,115000,20)
insert into Size values ('115cm',300,95000,21)
insert into Size values ('135cm',300,115000,21)
insert into Size values ('175cm',300,215000,21)
insert into Size values ('115cm',300,95000,22)
insert into Size values ('135cm',300,115000,22)
insert into Size values ('175cm',300,215000,22)
insert into Size values ('115cm',300,95000,23)
insert into Size values ('135cm',300,115000,23)
insert into Size values ('175cm',300,215000,23)
insert into Size values ('115cm',300,95000,24)
insert into Size values ('135cm',300,115000,24)
insert into Size values ('175cm',300,215000,24)
insert into Size values ('115cm',300,95000,25)
insert into Size values ('135cm',300,115000,25)
insert into Size values ('175cm',300,215000,25)
insert into Size values ('115cm',300,95000,26)
insert into Size values ('135cm',300,115000,26)
insert into Size values ('175cm',300,215000,26)
insert into Size values ('115cm',300,95000,27)
insert into Size values ('135cm',300,115000,27)
insert into Size values ('175cm',300,215000,27)
insert into Size values ('115cm',300,95000,28)
insert into Size values ('135cm',300,115000,28)
insert into Size values ('175cm',300,215000,28)
insert into Size values ('115cm',300,95000,29)
insert into Size values ('135cm',300,115000,29)
insert into Size values ('175cm',300,215000,29)
insert into Size values ('115cm',300,95000,30)
insert into Size values ('135cm',300,115000,30)
insert into Size values ('175cm',300,215000,30)
insert into Size values ('55cm',300,65000,31)
insert into Size values ('70cm',300,85000,31)
insert into Size values ('90cm',300,115000,31)
insert into Size values ('55cm',300,65000,32)
insert into Size values ('70cm',300,85000,32)
insert into Size values ('90cm',300,115000,32)
insert into Size values ('55cm',300,65000,33)
insert into Size values ('70cm',300,85000,33)
insert into Size values ('90cm',300,115000,33)
insert into Size values ('55cm',300,65000,34)
insert into Size values ('70cm',300,85000,34)
insert into Size values ('90cm',300,115000,34)
insert into Size values ('55cm',300,65000,35)
insert into Size values ('70cm',300,85000,35)
insert into Size values ('90cm',300,115000,35)
insert into Size values ('55cm',300,65000,36)
insert into Size values ('70cm',300,85000,36)
insert into Size values ('90cm',300,115000,36)
insert into Size values ('55cm',300,65000,37)
insert into Size values ('70cm',300,85000,37)
insert into Size values ('90cm',300,115000,37)
insert into Size values ('15cm',300,15000,38)
insert into Size values ('55cm',300,65000,39)
insert into Size values ('70cm',300,85000,39)
insert into Size values ('90cm',300,115000,39)

select * from [User]
--User insert
insert into [User](userName,email,phoneNumber,location,roleId,password)
values('User1','User1@gmail.com','0334372394','To Huu',1,'Minh553311@')
insert into [User](userName,email,phoneNumber,location,roleId,password)
values('User2','User2@gmail.com','0334123794','To Huu',1,'Minh553311@')
insert into [User](userName,email,phoneNumber,location,roleId,password)
values('User3','User3@gmail.com','0330213222','To Huu',1,'Minh553311@')
insert into [User](userName,email,phoneNumber,location,roleId,password)
values('Seller1','Seller1@gmail.com','0334372354','To Huu',2,'Minh553311@')
insert into [User](userName,email,phoneNumber,location,roleId,password)
values('Seller12','Seller2@gmail.com','0226444354','To Huu',2,'Minh553311@')
insert into [User](userName,email,phoneNumber,location,roleId,password)
values('Marketing1','Marketing1@gmail.com','0334372321','To Huu',3,'Minh553311@')
insert into [User](userName,email,phoneNumber,location,roleId,password)
values('Manager1','Manager1@gmail.com','0334372621','To Huu',4,'Minh553311@')
insert into [User](userName,email,phoneNumber,location,roleId,password)
values('Admin1','Admin1@gmail.com','0334310121','To Huu',5,'Minh553311@')


select * from Voucher
--Voucher insert