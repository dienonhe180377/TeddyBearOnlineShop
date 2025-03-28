

USE [TeddyBearOnlineShop]
GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[status] [bit] NOT NULL,
	[userId] [int] NULL,
	[updateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[updateDate] [datetime] NULL,
	[status] [bit] NULL,
	[thumbnail] [nvarchar](255) NOT NULL,
	[blogType] [nvarchar](25) NULL,
	[campaignId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Campaign]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campaign](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](25) NOT NULL,
	[description] [nvarchar](max) NULL,
	[status] [bit] NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartDetail]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cartId] [int] NULL,
	[productId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[content] [nvarchar](max) NULL,
	[product_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[status] [varchar](20) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[totalCost] [int] NOT NULL,
	[status] [bit] NULL,
	[userId] [int] NULL,
	[orderDate] [datetime] NULL,
	[arrivedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orderId] [int] NULL,
	[productId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](25) NULL,
	[categoryId] [int] NULL,
	[typeId] [int] NULL,
	[description] [nvarchar](max) NULL,
	[purchase_guide] [nvarchar](max) NULL,
	[warranty_info] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImage]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[source] [nvarchar](255) NOT NULL,
	[productId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductType]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](25) NOT NULL,
	[status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rating] [int] NOT NULL,
	[createDate] [datetime] NULL,
	[userId] [int] NULL,
	[commentId] [int] NULL,
	[productId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salary]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salary](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[salary] [int] NOT NULL,
	[userId] [int] NULL,
	[updateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Setting]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Setting](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](25) NOT NULL,
	[status] [bit] NOT NULL,
	[content] [nvarchar](255) NULL,
	[createDate] [datetime] NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Size]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Size](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](25) NOT NULL,
	[quantity] [int] NULL,
	[price] [int] NULL,
	[productId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userName] [nvarchar](255) NOT NULL,
	[profilePic] [nvarchar](255) NULL,
	[email] [nvarchar](255) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[phoneNumber] [nvarchar](12) NOT NULL,
	[location] [nvarchar](255) NULL,
	[createdDate] [datetime] NULL,
	[roleId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[roleName] [nvarchar](30) NOT NULL,
	[status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserVoucher]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserVoucher](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[voucherId] [int] NULL,
	[userId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ViewCount]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ViewCount](
	[date] [datetime] NOT NULL,
	[viewCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Voucher]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Voucher](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](25) NOT NULL,
	[discount] [int] NOT NULL,
	[status] [bit] NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[campaignId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VoucherProduct]    Script Date: 3/9/2025 3:40:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VoucherProduct](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[voucherId] [int] NULL,
	[productId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Setting] ON 

INSERT [dbo].[Setting] ([name], [status], [content], [description])
VALUES (N'Số điện thoại', 1, N'0334372394', N'Số điện thoại của trang web');
INSERT [dbo].[Setting] ([name], [status], [content], [description])
VALUES (N'Tên trang web', 1, N'TESHO', N'Tên của trang web');
INSERT [dbo].[Setting] ([name], [status], [content], [description])
VALUES (N'Email', 0, N'TESHO@gmail.com', N'Email của trang web');
SET IDENTITY_INSERT [dbo].[Setting] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([id], [name], [status]) VALUES (5, N'Cinnamaroll',1)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (2, N'Gấu bông Ghi Âm',1)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (1, N'Gấu Bông May Mắn',1)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (8, N'Gối Ôm Béo',1)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (7, N'Gối Ôm Dài',1)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (3, N'Pikachu',1)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (4, N'Stitch',1)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (6, N'Thú Bông Cảm Xúc',1)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([id], [content], [product_id], [user_id], [status], [created_at]) VALUES (1, N'Sản phẩm tốt', 6, 1, N'pending', CAST(N'2025-03-09T03:03:26.813' AS DateTime))
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (1, N'Stitch Ngồi', 4, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (2, N'Stitch Ôm Tim', 4, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (3, N'Stitch Bông Tím', 4, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (4, N'Gối Cổ Kèm Mũ Stitch', 4, 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (5, N'Móc Khóa Stitch Bông', 4, 2, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (6, N'Cinnamoroll Đeo Túi', 5, 1, N'– Mã SP: TNB BearHug 25cm – Thỏ Bunny & Daisy – GB40151

Gấu Bông Cặp Đôi BearHug – Thỏ Bunny & Daisy
– Kích Thước:

+ Size 1: 25cm – 285.000đ.

– Sản phẩm gồm: 1 đôi gấu bông ôm nhau có thể tháo rời.

– Chất vải: Vải lông thú

– Chất liệu bông: 100% Bông polyester trắng đàn hồi loại 1.

– Hướng dẫn sử dụng: Dùng làm gấu ôm, đồ trang trí hoặc làm quà tặng.

– Lưu ý: Nên vệ sinh bằng dịch vụ giặt khô hoặc mang tới Gấu Bông Online để được phục vụ dịch vụ giặt gấu bông chuyên nghiệp.', N' GIAO HÀNG TẬN NHÀ – TẶNG QUÀ TẬN TAY
Hướng Dẫn Mua Hàng tại Gấu Bông Online
Hướng Dẫn Mua Hàng tại Gấu Bông Online
TÀI KHOẢN KHÂN HÀNG

STK ngân hàng shop Gaubongonline.vn
STK ngân hàng shop Gaubongonline.vn
Vậy là dù bạn ở bất cứ nơi đâu cũng đều có thể đặt hàng online Gấu Bông một cách dễ dàng rồi nè, nhân viên bán hàng sẽ tư vấn đầy đủ từ lúc chọn gấu, đến cách thức mua hàng, giao hàng, thời gian giao, địa điểm và còn viết thiệp nữa đó. 

Hãy đến ngay với Gấu Bông Online để chọn những món quà Gấu bông dễ thương cho những người thân yêu của mình nhé!', N'1. TÍCH ĐIỂM HOÀN TIỀN


Tích điểm hoàn tiền
 

2. CHÍNH SÁCH BẢO HÀNH

Điều kiện áp dụng:

– Khách hàng vui lòng xuất trình hóa đơn mua hàng (ảnh chụp lại hóa đơn). Hoặc có tin nhắn/ inbox chứng minh mua sản phẩm tại shop

– Sản phẩm được bảo hành miễn phí trong suốt thời gian sử dụng trong các trường hợp sau:

Gấu bục rách, đứt chỉ trong quá trình sử dụng.
Các chi tiết trang trí, phụ kiện (nơ,hoa đính ) bị rơi hoặc lỏng.
Không  bảo hành sản phẩm đối với các trường hợp:  Phụ kiện mắt mũi , nơ mất hẳn.
BẢO HÀNH 3 THÁNG VỀ CHẤT LƯỢNG BÔNG: nếu bị xẹp cửa hàng sẽ hỗ trợ đánh tơi bông hoặc nhồi thêm bông.

3. QUY ĐỊNH ĐỔI TRẢ SẢN PHẨM

Đổi sản phẩm trong vòng 2 ngày kể từ ngày mua và chỉ đổi 01 lần duy nhất với giá trị bằng hoặc cao hơn, nếu thấp hơn khách hàng sẽ bị trừ 20% số tiền chênh lệch.
Sản phẩm đổi phải còn hóa đơn hoặc tin nhắn xác nhận mua hàng
(Khách hàng gọi điện ngay thông báo đến cửa hàng  không quá 5h kể từ khi nhận sản phẩm )
Trả lại sản phẩm: khách hàng được trả trong vòng 2 ngày kể từ ngày mua và trừ 20% giá trị ban đầu.
Chỉ áp dụng với các sản phẩm phải còn nguyên vẹn, gấu: mắt, mũi, áo, phụ kiện…
CỬA HÀNG CÓ HỖ TRỢ :

– Giặt Gấu và kiểm tra chất lượng Gấu:

Nhận cả gấu khách mua bên ngoài, gấu ko mua tại cửa hàng.
Kiểm tra Bông bên trong gấu trước khi giặt. ( Đa số sản phẩm mua vỉa hè đều là độn MÚT BẨN hoặc VẢI VỤN BẨN).
Nếu bông gấu là vải vụn hoặc bẩn thì khách có thể thay bằng toàn bộ  bông trắng xoắn 3 chiều của shop (giá bông tính theo kg)
– Nhận lấy Gấu tận nhà: 

Quý khách chỉ cần gọi điện, shop sẽ cho người đến tận nhà: LẤY GẤU – GIẶT SẠCH – TRẢ GẤU TẬN NHÀ
Giá giặt sẽ rẻ hơn ngoài tiệm giặt, và sẽ được giặt gấu theo đúng quy trình và tiêu chuẩn riêng dành cho gấu bông  (giá  giặt theo kích thước mỗi loại-  Giá ship sẽ đc tính theo từng khu vực).')
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (7, N'Kuromi Đeo Túi', 5, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (8, N'Kuromi Cupid', 5, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (9, N'Chó Vàng Purin', 5, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (10, N'Kuromi Galaxy', 5, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (11, N'Gấu Bông Teddy', 2, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (12, N'Capybara Hồng', 2, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (13, N'Babyboo Ghi Âm', 2, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (14, N'Head Tales Ghi Âm', 2, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (15, N'Hug Me Teddy', 2, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (16, N'Capybara Thần Tài', 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (17, N'Rồng Vàng', 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (18, N'Rồng Búp Bê Baby', 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (19, N'Rồng Xanh Ôm Cá', 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (20, N'Bộ 4 Rồng Happy', 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (21, N'Hải Cẩu Sushi', 8, 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (22, N'Hải Cẩu Mũm Mĩm', 8, 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (23, N'Chó Bông Corgi', 8, 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (24, N'Heo Lulu Ong', 8, 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (25, N'Hải Cẩu Bông', 8, 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (26, N'Gối Ôm Hải Cẩu', 7, 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (27, N'Husky Má Tim', 7, 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (28, N'Shiba Giơ Tay', 7, 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (29, N'Lotso Mặt Hoa', 7, 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (30, N'Cà Rốt Lông', 7, 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (31, N'Pikachu Tai Đen', 3, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (32, N'Purin Hồng', 3, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (33, N'Kabigon', 3, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (34, N'Eve Tai Dài', 3, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (35, N'Pikachu Bông Mềm', 3, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (36, N'Mihi Cảm Xúc', 6, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (37, N'Bạch Tuộc Khổng Lồ', 6, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (38, N'Móc Khóa Bạch Tuộc', 6, 2, NULL, NULL, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [description], [purchase_guide], [warranty_info]) VALUES (39, N'Bạch Tuộc Siêu To', 6, 1, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImage] ON 

INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (1, N'images/stitchNgoiDoiMuOmKem.jpg', 1)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (2, N'images/stitch-ngoi-doi-mu-om-kem-6.jpg', 1)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (3, N'images/stitch-ngoi-doi-mu-om-kem-5.jpg', 1)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (4, N'images/stitch-ngoi-doi-mu-om-kem-7.jpg', 1)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (5, N'images/Gau-Bong-Stitch-Om-Tim-5-500x500.jpg', 2)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (6, N'images/Gau-Bong-Stitch-Om-Tim-7.jpg', 2)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (7, N'images/Gau-Bong-Stitch-Om-Tim-8.jpg', 2)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (8, N'images/Gau-Bong-Stitch-Om-Tim-9.jpg', 2)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (9, N'images/Stitch-tim-nho-5-500x500.jpg', 3)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (10, N'images/Stitch-tim-nho-1.jpg', 3)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (11, N'images/Stitch-tim-nho-12.jpg', 3)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (12, N'images/Stitch-mu-4-500x500.jpg', 4)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (13, N'images/goi-co-mu-stitch-4.jpg', 4)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (14, N'images/goi-co-mu-stitch-5.jpg', 4)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (15, N'images/moc-khoa-stitch-tai-dai-2-500x500.jpg', 5)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (16, N'images/stitch-tai-dai.jpg', 5)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (17, N'images/moc-khoa-stitch-tai-dai-1.jpg', 5)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (18, N'images/Az4628962022474_38ced04d3aecc838fbe9ca96c04a1b9b-jpg.webp', 6)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (19, N'images/Az4626448838208_9a32f3f15c4de0a8b2157b37fd8e49d5-jpg.webp', 6)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (20, N'images/Az4626448966985_044c7987fd95f2b2d76552b9d12757ca-jpg.webp', 6)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (21, N'images/Az4626450573660_c1db553568115e837f3bfda80721e1fc-500x500.webp', 7)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (22, N'images/Az4626450656119_a510a7c3037aebf5a7c772a88da818a2-jpg.webp', 7)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (23, N'images/Az4626450770633_2937451d388cc7fd53658e53a2ad593d-jpg.webp', 7)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (24, N'images/kuromi-kupid-2-jpg-500x500.webp', 8)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (25, N'images/kuromi-kupid-9-jpg.webp', 8)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (26, N'images/kuromi-kupid-7-jpg.webp', 8)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (27, N'images/Az4628962050328_0dfd2fa3689719a3e29049867259deca-500x500.webp', 9)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (28, N'images/Az4623341273462_1aac1d87b072f12e61097356900742a7-jpg.webp', 9)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (29, N'images/Az4623341240740_70cc567f29be4a7e7bcd26b87d95e200-jpg.webp', 9)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (30, N'images/kuromi-galaxy-6-500x500.webp', 10)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (31, N'images/kuromi-galaxy-8-jpg.webp', 10)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (32, N'images/kuromi-galaxy-7-jpg.webp', 10)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (33, N'images/gau-ghi-am-17-1.jpg', 11)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (34, N'images/gau-ghi-am-13.jpg', 11)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (35, N'images/gau-ghi-am-5-1.jpg', 11)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (36, N'images/Capybara-hong-deo-bong-nhay-hat-1-500x500.jpg', 12)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (37, N'images/Capybara-hong-deo-bong-nhay-hat-6.jpg', 12)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (38, N'images/Gau-Bong-BabyBoo-Ghi-Am-1-500x500.jpg', 13)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (39, N'images/gau-ghi-am-17-1-500x500.jpg', 14)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (40, N'images/gau-ghi-am-17-500x500.jpg', 15)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (41, N'images/Chuot-capybara-than-tai-1-500x500.jpg', 16)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (42, N'images/Az4995136766781_ee8bba271ecfedffd684b7738c71504f-jpg-500x500.webp', 17)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (43, N'images/Az4926699272776_687fc371d5557fcecb50b21167d8c45d-jpg-500x500.webp', 18)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (44, N'images/rong-xanh-om-ca-5-jpg-500x500.webp', 19)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (45, N'images/Az4986240969507_a00ee2db46fbf0d54d649394385beed0-jpg-500x500.webp', 20)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (46, N'images/Hai-Cau-Sushi-7-500x500.jpg', 21)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (47, N'images/Hai-Cau-Mum-Mim-11-500x500.jpg', 22)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (48, N'images/cho-corgi-beo-500x500.webp', 23)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (49, N'images/heo-lulu-ong-nam-9-500x500.webp', 24)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (50, N'images/hai-cau-bien-500x500.webp', 25)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (51, N'images/goi-om-hai-cau-2-500x500.jpg', 26)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (52, N'images/goi-om-hussky-ma-tim-xam-nam-1-500x500.webp', 27)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (53, N'images/goi-om-cho-nam-gio-tay-500x500.webp', 28)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (54, N'images/Goi-om-Lotso-mat-hoa-1-500x500.jpg', 29)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (55, N'images/ca-rot-long-1-500x500.jpg', 30)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (56, N'images/pokemon-tai-den-4.jpg', 31)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (57, N'images/Purin-Hong-Pokemon-1.jpg', 32)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (58, N'images/Kabigon-Pokemon-12.jpg', 33)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (59, N'images/Eve-Tai-Dai-Pokemon-11-500x500.jpg', 34)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (60, N'images/pikachu-bong-mem-3-500x500.jpg', 35)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (61, N'images/mihi-cam-xuc.jpg', 36)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (62, N'images/bach-tuoc-cam-xuc-khong-lo.jpg', 37)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (63, N'images/moc-khoa-bach-tuoc-cam-xuc-19-500x500.jpg', 38)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (64, N'images/bach-tuoc-cam-xuc-khong-lo-500x500.jpg', 39)
SET IDENTITY_INSERT [dbo].[ProductImage] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductType] ON 

INSERT [dbo].[ProductType] ([id], [name], [status]) VALUES (1, N'Gấu Bông',1)
INSERT [dbo].[ProductType] ([id], [name], [status]) VALUES (3, N'Gối Ôm',1)
INSERT [dbo].[ProductType] ([id], [name], [status]) VALUES (2, N'Móc Khóa',1)
SET IDENTITY_INSERT [dbo].[ProductType] OFF
GO
SET IDENTITY_INSERT [dbo].[Size] ON 

INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (1, N'55cm', 300, 65000, 1)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (2, N'70cm', 300, 85000, 1)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (3, N'90cm', 300, 115000, 1)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (4, N'55cm', 300, 65000, 2)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (5, N'70cm', 300, 85000, 2)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (6, N'90cm', 300, 115000, 2)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (7, N'55cm', 300, 75000, 3)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (8, N'70cm', 300, 95000, 3)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (9, N'90cm', 300, 125000, 3)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (10, N'35cm', 300, 35000, 4)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (11, N'60cm', 300, 65000, 4)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (12, N'80cm', 300, 95000, 4)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (13, N'18cm', 300, 35000, 5)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (14, N'55cm', 300, 65000, 6)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (15, N'70cm', 300, 85000, 6)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (16, N'90cm', 300, 115000, 6)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (17, N'55cm', 300, 65000, 7)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (18, N'70cm', 300, 85000, 7)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (19, N'90cm', 300, 115000, 7)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (20, N'55cm', 300, 65000, 8)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (21, N'70cm', 300, 85000, 8)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (22, N'90cm', 300, 115000, 8)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (23, N'55cm', 300, 65000, 9)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (24, N'70cm', 300, 85000, 9)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (25, N'90cm', 300, 115000, 9)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (26, N'55cm', 300, 65000, 10)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (27, N'70cm', 300, 85000, 10)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (28, N'90cm', 300, 115000, 10)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (29, N'55cm', 300, 65000, 11)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (30, N'70cm', 300, 85000, 11)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (31, N'90cm', 300, 115000, 11)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (32, N'55cm', 300, 65000, 12)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (33, N'70cm', 300, 85000, 12)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (34, N'90cm', 300, 115000, 12)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (35, N'55cm', 300, 65000, 13)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (36, N'70cm', 300, 85000, 13)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (37, N'90cm', 300, 115000, 13)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (38, N'55cm', 300, 65000, 14)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (39, N'70cm', 300, 85000, 14)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (40, N'90cm', 300, 115000, 14)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (41, N'55cm', 300, 65000, 15)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (42, N'70cm', 300, 85000, 15)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (43, N'90cm', 300, 115000, 15)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (44, N'55cm', 300, 65000, 16)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (45, N'70cm', 300, 85000, 16)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (46, N'90cm', 300, 115000, 16)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (47, N'55cm', 300, 65000, 17)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (48, N'70cm', 300, 85000, 17)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (49, N'90cm', 300, 115000, 17)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (50, N'55cm', 300, 65000, 18)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (51, N'70cm', 300, 85000, 18)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (52, N'90cm', 300, 115000, 18)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (53, N'55cm', 300, 65000, 19)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (54, N'70cm', 300, 85000, 19)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (55, N'90cm', 300, 115000, 19)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (56, N'55cm', 300, 65000, 20)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (57, N'70cm', 300, 85000, 20)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (58, N'90cm', 300, 115000, 20)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (59, N'115cm', 300, 95000, 21)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (60, N'135cm', 300, 115000, 21)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (61, N'175cm', 300, 215000, 21)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (62, N'115cm', 300, 95000, 22)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (63, N'135cm', 300, 115000, 22)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (64, N'175cm', 300, 215000, 22)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (65, N'115cm', 300, 95000, 23)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (66, N'135cm', 300, 115000, 23)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (67, N'175cm', 300, 215000, 23)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (68, N'115cm', 300, 95000, 24)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (69, N'135cm', 300, 115000, 24)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (70, N'175cm', 300, 215000, 24)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (71, N'115cm', 300, 95000, 25)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (72, N'135cm', 300, 115000, 25)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (73, N'175cm', 300, 215000, 25)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (74, N'115cm', 300, 95000, 26)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (75, N'135cm', 300, 115000, 26)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (76, N'175cm', 300, 215000, 26)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (77, N'115cm', 300, 95000, 27)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (78, N'135cm', 300, 115000, 27)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (79, N'175cm', 300, 215000, 27)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (80, N'115cm', 300, 95000, 28)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (81, N'135cm', 300, 115000, 28)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (82, N'175cm', 300, 215000, 28)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (83, N'115cm', 300, 95000, 29)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (84, N'135cm', 300, 115000, 29)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (85, N'175cm', 300, 215000, 29)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (86, N'115cm', 300, 95000, 30)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (87, N'135cm', 300, 115000, 30)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (88, N'175cm', 300, 215000, 30)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (89, N'55cm', 300, 65000, 31)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (90, N'70cm', 300, 85000, 31)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (91, N'90cm', 300, 115000, 31)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (92, N'55cm', 300, 65000, 32)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (93, N'70cm', 300, 85000, 32)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (94, N'90cm', 300, 115000, 32)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (95, N'55cm', 300, 65000, 33)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (96, N'70cm', 300, 85000, 33)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (97, N'90cm', 300, 115000, 33)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (98, N'55cm', 300, 65000, 34)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (99, N'70cm', 300, 85000, 34)
GO
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (100, N'90cm', 300, 115000, 34)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (101, N'55cm', 300, 65000, 35)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (102, N'70cm', 300, 85000, 35)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (103, N'90cm', 300, 115000, 35)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (104, N'55cm', 300, 65000, 36)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (105, N'70cm', 300, 85000, 36)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (106, N'90cm', 300, 115000, 36)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (107, N'55cm', 300, 65000, 37)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (108, N'70cm', 300, 85000, 37)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (109, N'90cm', 300, 115000, 37)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (110, N'15cm', 300, 15000, 38)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (111, N'55cm', 300, 65000, 39)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (112, N'70cm', 300, 85000, 39)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (113, N'90cm', 300, 115000, 39)
SET IDENTITY_INSERT [dbo].[Size] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId]) VALUES (1, N'User1', N'images/Logo.png', N'User1@gmail.com', N'Minh553311@', N'0334372394', N'To Huu', CAST(N'2025-03-04T01:39:34.293' AS DateTime), 1)
INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId]) VALUES (2, N'User2', N'images/usericon.jpg', N'User2@gmail.com', N'Minh553311@', N'0334123794', N'To Huu', CAST(N'2025-03-04T01:39:34.293' AS DateTime), 1)
INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId]) VALUES (3, N'User3', N'images/usericon.jpg', N'User3@gmail.com', N'Minh553311@', N'0330213222', N'To Huu', CAST(N'2025-03-04T01:39:34.293' AS DateTime), 1)
INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId]) VALUES (4, N'Seller1', N'images/usericon.jpg', N'Seller1@gmail.com', N'Minh553311@', N'0334372354', N'To Huu', CAST(N'2025-03-04T01:39:34.293' AS DateTime), 2)
INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId]) VALUES (5, N'Seller2', N'images/usericon.jpg', N'Seller2@gmail.com', N'Minh553311@', N'0226444354', N'To Huu', CAST(N'2025-03-04T01:39:34.297' AS DateTime), 2)
INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId]) VALUES (6, N'Marketing1', N'images/usericon.jpg', N'Marketing1@gmail.com', N'Minh553311@', N'0334372321', N'To Huu', CAST(N'2025-03-04T01:39:34.297' AS DateTime), 3)
INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId]) VALUES (7, N'Manager1', N'images/usericon.jpg', N'Manager1@gmail.com', N'Minh553311@', N'0334372621', N'To Huu', CAST(N'2025-03-04T01:39:34.297' AS DateTime), 4)
INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId]) VALUES (8, N'Admin1', N'images/usericon.jpg', N'Admin1@gmail.com', N'Minh553311@', N'0334310121', N'To Huu', CAST(N'2025-03-04T01:39:34.297' AS DateTime), 5)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRole] ON 

INSERT [dbo].[UserRole] ([id], [roleName], [status]) VALUES (5, N'Admin',1)
INSERT [dbo].[UserRole] ([id], [roleName], [status]) VALUES (1, N'Customer',1)
INSERT [dbo].[UserRole] ([id], [roleName], [status]) VALUES (4, N'Manager',1)
INSERT [dbo].[UserRole] ([id], [roleName], [status]) VALUES (3, N'Marketing',1)
INSERT [dbo].[UserRole] ([id], [roleName], [status]) VALUES (2, N'Seller',1)
SET IDENTITY_INSERT [dbo].[UserRole] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Campaign__72E12F1B22D37005]    Script Date: 3/9/2025 3:40:46 AM ******/
ALTER TABLE [dbo].[Campaign] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Category__72E12F1B5111E7C4]    Script Date: 3/9/2025 3:40:46 AM ******/
ALTER TABLE [dbo].[Category] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ProductI__0CEA54422F734537]    Script Date: 3/9/2025 3:40:46 AM ******/
ALTER TABLE [dbo].[ProductImage] ADD UNIQUE NONCLUSTERED 
(
	[source] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ProductT__72E12F1B6292E810]    Script Date: 3/9/2025 3:40:46 AM ******/
ALTER TABLE [dbo].[ProductType] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Setting__72E12F1BBCD3E0B7]    Script Date: 3/9/2025 3:40:46 AM ******/
ALTER TABLE [dbo].[Setting] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__4849DA0148FF1F0B]    Script Date: 3/9/2025 3:40:46 AM ******/
ALTER TABLE [dbo].[User] ADD UNIQUE NONCLUSTERED 
(
	[phoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__AB6E61644408AF6C]    Script Date: 3/9/2025 3:40:46 AM ******/
ALTER TABLE [dbo].[User] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__UserRole__B19478614C580EE2]    Script Date: 3/9/2025 3:40:46 AM ******/
ALTER TABLE [dbo].[UserRole] ADD UNIQUE NONCLUSTERED 
(
	[roleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Voucher__72E12F1B8B0EE8F4]    Script Date: 3/9/2025 3:40:46 AM ******/
ALTER TABLE [dbo].[Voucher] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Attendance] ADD  DEFAULT (getdate()) FOR [updateTime]
GO
ALTER TABLE [dbo].[Blog] ADD  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[Campaign] ADD  DEFAULT (getdate()) FOR [startDate]
GO
ALTER TABLE [dbo].[Comment] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[Comment] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (getdate()) FOR [orderDate]
GO
ALTER TABLE [dbo].[Rating] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[Setting] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ('images/usericon.jpg') FOR [profilePic]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[Voucher] ADD  DEFAULT (getdate()) FOR [startDate]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD FOREIGN KEY([campaignId])
REFERENCES [dbo].[Campaign] ([id])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[CartDetail]  WITH CHECK ADD FOREIGN KEY([cartId])
REFERENCES [dbo].[Cart] ([id])
GO
ALTER TABLE [dbo].[CartDetail]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([orderId])
REFERENCES [dbo].[Order] ([id])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([typeId])
REFERENCES [dbo].[ProductType] ([id])
GO
ALTER TABLE [dbo].[ProductImage]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD FOREIGN KEY([commentId])
REFERENCES [dbo].[Comment] ([id])
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Salary]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Size]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([roleId])
REFERENCES [dbo].[UserRole] ([id])
GO
ALTER TABLE [dbo].[UserVoucher]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[UserVoucher]  WITH CHECK ADD FOREIGN KEY([voucherId])
REFERENCES [dbo].[Voucher] ([id])
GO
ALTER TABLE [dbo].[Voucher]  WITH CHECK ADD FOREIGN KEY([campaignId])
REFERENCES [dbo].[Campaign] ([id])
GO
ALTER TABLE [dbo].[VoucherProduct]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[VoucherProduct]  WITH CHECK ADD FOREIGN KEY([voucherId])
REFERENCES [dbo].[Voucher] ([id])
GO
ALTER TABLE CartDetail ADD quantity INT DEFAULT 1;
ALTER TABLE OrderDetail ADD quantity INT DEFAULT 1;