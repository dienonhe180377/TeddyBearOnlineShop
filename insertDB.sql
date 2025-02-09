
drop database TeddyBearOnlineShop

ALTER TABLE Product
DROP COLUMN description;

select * from ProductType
--ProductType insert
insert into ProductType values(N'Gấu Bông')
insert into ProductType values(N'Phụ Kiện Gấu Bông')
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

select * from Size
--Size insert

select * from Product
--Product insert
insert into Product values(N'Stitch Ngồi','images/stitchNgoiDoiMuOmKem.jpg',300,200000,4,1)
insert into Product values(N'Stitch Ôm Tim','images/Gau-Bong-Stitch-Om-Tim-5-500x500.jpg',300,230000,4,1)
insert into Product values(N'Stitch Bông Tím','images/Stitch-tim-nho-5-500x500.jpg',300,193000,4,1)
insert into Product values(N'Gối Cổ Kèm Mũ Stitch','images/Stitch-mu-4-500x500.jpg',300,265000,4,4)
insert into Product values(N'Móc Khóa Stitch Bông','images/moc-khoa-stitch-tai-dai-2-500x500.jpg',300,65000,4,3)