create database TeddyBearOnlineShop

create table UserRole(
	id int primary key identity(1,1),
	roleName nvarchar(30) unique not null
)

create table [User](
	id int primary key identity(1,1),
	userName nvarchar(255) not null,
	profilePic nvarchar(255),
	email nvarchar(255) unique not null,
	[password] nvarchar(255) not null,
	phoneNumber nvarchar(12) unique not null,
	location nvarchar(255),
	createdDate datetime default GETDATE(),
	roleId int foreign key references UserRole(id)
)

create table Setting(
	id int primary key identity(1,1),
	name nvarchar(25) unique not null,
	status bit not null,
	createDate datetime default getdate(),
	[description] nvarchar(max)
)

create table ViewCount(
	[date] datetime not null primary key,
	viewCount int 
)

create table Category(
	id int primary key identity(1,1),
	name nvarchar(255) not null unique
)

create table ProductType(
	id int primary key identity(1,1),
	name nvarchar(25) not null unique
)

create table Comment(
	id int primary key identity(1,1),
	content nvarchar(max)
)

create table [Product](
	id int primary key identity(1,1),
	name nvarchar(25),
	[image] nvarchar(255) not null,
	quantity int,
	price int not null,
	categoryId int foreign key references Category(id),
	typeId int foreign key references ProductType(id),
)

create table Assessories(
	id int primary key identity(1,1),
	name nvarchar(50),
	quantity int not null,
	image nvarchar(255) not null,
	productId int foreign key references [Product](id)
)

create table Size(
	id int primary key identity(1,1),
	name nvarchar(25) not null,
	productId int foreign key references [Product](id)
)

create table Rating(
	id int primary key identity(1,1),
	rating int not null,
	createDate datetime default GETDATE(),
	userId int foreign key references [User](id),
	commentId int foreign key references [Comment](id),
	productId int foreign key references [Product](id)
)

create table [Order](
	id int primary key identity(1,1),
	userId int foreign key references [User](id),
	orderDate datetime default GETDATE(),
	totalCost int not null,
	orderStatus nvarchar(10) not null default 'Shipping',
	paymentMethod nvarchar(20),
	arrivedAt datetime,
)

create table [PurchaseHistory](
	id int primary key identity(1,1),
	userId int foreign key references [User](id),
	orderId int foreign key references [Order](id)
)

create table Cart(
	id int primary key identity(1,1),
	userId int foreign key references [User](id),
	productId int foreign key references [Product](id)
)

create table Attendance(
	id int primary key identity(1,1),
	[status] bit not null,
	userId int foreign key references [User](id),
	createDate datetime default GETDATE()
)

create table Salary(
	id int primary key identity(1,1),
	salary int not null,
	userId int foreign key references [User](id),
	updateTime datetime
)

create table Campaign(
	id int primary key identity(1,1),
	[name] nvarchar(25) not null unique,
	[description] nvarchar(max),
	startDate datetime default GETDATE(),
	endDate datetime
)

create table BlogType(
	id int primary key identity(1,1),
	[name] nvarchar(25) not null unique,
)

create table Blog(
	id int primary key identity(1,1),
	title nvarchar(255) not null,
	content nvarchar(max) not null,
	userId int foreign key references [User](id),
	createDate datetime default GETDATE(),
	updateDate datetime,
	[status] bit not null,
	thumbnail nvarchar(255) not null,
	blogTypeId int foreign key references BlogType(id),
	campaignId int foreign key references Campaign(id)
)

create table Voucher(
	id int primary key identity(1,1),
	[name] nvarchar(25) not null unique,
	discount int not null,
	startDate datetime default GETDATE(),
	endDate datetime,
	campaignId int foreign key references Campaign(id),
	productId int foreign key references [Product](id)
)