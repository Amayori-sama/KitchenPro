USE [master]
GO
/****** Object:  Database [kitchen]    Script Date: 04.04.2023 20:23:24 ******/
CREATE DATABASE [kitchen]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'kitchen', FILENAME = N'D:\MSSQL\kitchen.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'kitchen_log', FILENAME = N'D:\MSSQL\kitchen_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [kitchen] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [kitchen].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [kitchen] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [kitchen] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [kitchen] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [kitchen] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [kitchen] SET ARITHABORT OFF 
GO
ALTER DATABASE [kitchen] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [kitchen] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [kitchen] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [kitchen] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [kitchen] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [kitchen] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [kitchen] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [kitchen] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [kitchen] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [kitchen] SET  DISABLE_BROKER 
GO
ALTER DATABASE [kitchen] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [kitchen] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [kitchen] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [kitchen] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [kitchen] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [kitchen] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [kitchen] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [kitchen] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [kitchen] SET  MULTI_USER 
GO
ALTER DATABASE [kitchen] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [kitchen] SET DB_CHAINING OFF 
GO
ALTER DATABASE [kitchen] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [kitchen] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [kitchen] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [kitchen] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [kitchen] SET QUERY_STORE = OFF
GO
USE [kitchen]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 04.04.2023 20:23:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderStatus] [nvarchar](max) NOT NULL,
	[OrderDeliveryDate] [datetime] NOT NULL,
	[OrderPickupPoint] [int] NOT NULL,
 CONSTRAINT [PK__Order__C3905BAF8C4D4519] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 04.04.2023 20:23:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProduct](
	[OrderID] [int] NOT NULL,
	[ProductArticleNumber] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductArticleNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Points]    Script Date: 04.04.2023 20:23:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Points](
	[OrderPickupPoint] [int] IDENTITY(1,1) NOT NULL,
	[Address] [nvarchar](max) NULL,
 CONSTRAINT [PK_Points] PRIMARY KEY CLUSTERED 
(
	[OrderPickupPoint] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 04.04.2023 20:23:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductArticleNumber] [nvarchar](100) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[ProductDescription] [nvarchar](max) NOT NULL,
	[ProductCategory] [nvarchar](max) NOT NULL,
	[ProductPhoto] [image] NULL,
	[ProductManufacturer] [nvarchar](max) NOT NULL,
	[ProductCost] [decimal](19, 4) NOT NULL,
	[ProductDiscountAmount] [tinyint] NULL,
	[ProductQuantityInStock] [int] NOT NULL,
	[ProductStatus] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK__Product__2EA7DCD591451E26] PRIMARY KEY CLUSTERED 
(
	[ProductArticleNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 04.04.2023 20:23:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 04.04.2023 20:23:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserSurname] [nvarchar](100) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[UserPatronymic] [nvarchar](100) NOT NULL,
	[UserLogin] [nvarchar](max) NOT NULL,
	[UserPassword] [nvarchar](max) NOT NULL,
	[UserRole] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint]) VALUES (1, N'Завершен', CAST(N'2022-05-22T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint]) VALUES (2, N'Новый ', CAST(N'2022-05-22T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint]) VALUES (3, N'Новый ', CAST(N'2022-05-23T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint]) VALUES (4, N'Новый ', CAST(N'2022-05-23T00:00:00.000' AS DateTime), 22)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint]) VALUES (5, N'Новый ', CAST(N'2022-05-25T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint]) VALUES (6, N'Новый ', CAST(N'2022-05-26T00:00:00.000' AS DateTime), 28)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint]) VALUES (7, N'Новый ', CAST(N'2022-05-28T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint]) VALUES (8, N'Новый ', CAST(N'2022-05-28T00:00:00.000' AS DateTime), 32)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint]) VALUES (9, N'Новый ', CAST(N'2022-05-30T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint]) VALUES (10, N'Новый ', CAST(N'2022-05-30T00:00:00.000' AS DateTime), 36)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (1, N'T793T4')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (1, N'А112Т4')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (2, N'F573T5')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (2, N'G387Y6')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (3, N'B736H6')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (3, N'D735T5')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (4, N'H384H3')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (4, N'K437E6')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (5, N'E732R7')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (5, N'R836H6')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (6, N'F839R6')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (6, N'G304H6')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (7, N'C430T4')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (7, N'C946Y6')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (8, N'B963H5')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (8, N'V403G6')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (9, N'V026J4')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (9, N'V727Y6')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (10, N'C635Y6')
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber]) VALUES (10, N'W405G6')
GO
SET IDENTITY_INSERT [dbo].[Points] ON 

INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (1, N'344288, г. Талнах, ул. Чехова, 1')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (2, N'614164, г.Талнах,  ул. Степная, 30')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (3, N'394242, г. Талнах, ул. Коммунистическая, 43')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (4, N'660540, г. Талнах, ул. Солнечная, 25')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (5, N'125837, г. Талнах, ул. Шоссейная, 40')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (6, N'125703, г. Талнах, ул. Партизанская, 49')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (7, N'625283, г. Талнах, ул. Победы, 46')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (8, N'614611, г. Талнах, ул. Молодежная, 50')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (9, N'454311, г.Талнах, ул. Новая, 19')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (10, N'660007, г.Талнах, ул. Октябрьская, 19')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (11, N'603036, г. Талнах, ул. Садовая, 4')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (12, N'450983, г.Талнах, ул. Комсомольская, 26')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (13, N'394782, г. Талнах, ул. Чехова, 3')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (14, N'603002, г. Талнах, ул. Дзержинского, 28')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (15, N'450558, г. Талнах, ул. Набережная, 30')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (16, N'394060, г.Талнах, ул. Фрунзе, 43')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (17, N'410661, г. Талнах, ул. Школьная, 50')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (18, N'625590, г. Талнах, ул. Коммунистическая, 20')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (19, N'625683, г. Талнах, ул. 8 Марта')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (20, N'400562, г. Талнах, ул. Зеленая, 32')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (21, N'614510, г. Талнах, ул. Маяковского, 47')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (22, N'410542, г. Талнах, ул. Светлая, 46')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (23, N'620839, г. Талнах, ул. Цветочная, 8')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (24, N'443890, г. Талнах, ул. Коммунистическая, 1')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (25, N'603379, г. Талнах, ул. Спортивная, 46')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (26, N'603721, г. Талнах, ул. Гоголя, 41')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (27, N'410172, г. Талнах, ул. Северная, 13')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (28, N'420151, г. Талнах, ул. Вишневая, 32')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (29, N'125061, г. Талнах, ул. Подгорная, 8')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (30, N'630370, г. Талнах, ул. Шоссейная, 24')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (31, N'614753, г. Талнах, ул. Полевая, 35')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (32, N'426030, г. Талнах, ул. Маяковского, 44')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (33, N'450375, г. Талнах ул. Клубная, 44')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (34, N'625560, г. Талнах, ул. Некрасова, 12')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (35, N'630201, г. Талнах, ул. Комсомольская, 17')
INSERT [dbo].[Points] ([OrderPickupPoint], [Address]) VALUES (36, N'190949, г. Талнах, ул. Мичурина, 26')
SET IDENTITY_INSERT [dbo].[Points] OFF
GO
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'B736H6', N'Вилка столовая', N'Вилка столовая 21,2 см «Аляска бэйсик» сталь KunstWerk', N'Вилки', NULL, N'Alaska', CAST(220.0000 AS Decimal(19, 4)), 3, 4, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'B963H5', N'Ложка', N'Ложка 21 мм металлическая (медная) (Упаковка 10 шт)', N'Ложки', NULL, N'Smart Home', CAST(800.0000 AS Decimal(19, 4)), 3, 8, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'C430T4', N'Набор на одну персону', N'Набор на одну персону (4 предмета) серия "Bistro", нерж. сталь, Was, Германия.', N'наборы', NULL, N'Attribute', CAST(1600.0000 AS Decimal(19, 4)), 3, 6, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'C635Y6', N'Детский столовый набор', N'Детский столовый набор Fissman «Зебра» ', N'наборы', NULL, N'Apollo', CAST(1000.0000 AS Decimal(19, 4)), 4, 25, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'C730R7', N'Ложка детская', N'Ложка детская столовая', N'Ложки', NULL, N'Smart Home', CAST(300.0000 AS Decimal(19, 4)), 3, 17, N'')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'C943G5', N'Набор чайных ложек', N'Attribute Набор чайных ложек Baguette 3 предмета серебристый', N'наборы', NULL, N'Attribute', CAST(200.0000 AS Decimal(19, 4)), 4, 12, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'C946Y6', N'Вилка столовая', N'Вилка детская столовая', N'Вилки', NULL, N'Apollo', CAST(300.0000 AS Decimal(19, 4)), 2, 16, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'D735T5', N'Ложка чайная', N'Ложка чайная ALASKA Eternum', N'Ложки', NULL, N'Alaska', CAST(220.0000 AS Decimal(19, 4)), 2, 13, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'E732R7', N'Набор столовых приборов', N'Набор столовых приборов Smart Home20 Black в подарочной коробке, 4 шт', N'наборы', NULL, N'Smart Home', CAST(990.0000 AS Decimal(19, 4)), 5, 6, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'F392G6', N'Набор столовых приборов', N'Apollo Набор столовых приборов Chicago 4 предмета серебристый', N'наборы', NULL, N'Apollo', CAST(490.0000 AS Decimal(19, 4)), 4, 9, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'F573T5', N'Вилки столовые', N'Вилки столовые на блистере / 6 шт.', N'вилки', NULL, N'Davinci', CAST(650.0000 AS Decimal(19, 4)), 3, 4, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'F745K4', N'Столовые приборы для салата', N'Столовые приборы для салата Orskov Lava, 2шт', N'наборы', NULL, N'Mayer & Boch', CAST(2000.0000 AS Decimal(19, 4)), 3, 2, N'')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'F839R6', N'Ложка чайная', N'Ложка чайная DORIA Eternum', N'Ложки', NULL, N'Doria', CAST(400.0000 AS Decimal(19, 4)), 2, 6, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'G304H6', N'Набор ложек', N'Набор ложек столовых APOLLO "Bohemica" 3 пр.', N'Ложки', NULL, N'Apollo', CAST(500.0000 AS Decimal(19, 4)), 4, 12, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'G387Y6', N'Ложка столовая', N'Ложка столовая DORIA L=195/60 мм Eternum', N'Ложки', NULL, N'Doria', CAST(441.0000 AS Decimal(19, 4)), 4, 23, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'H384H3', N'Набор столовых приборов', N'Набор столовых приборов для торта Palette 7 предметов серебристый', N'наборы', NULL, N'Apollo', CAST(600.0000 AS Decimal(19, 4)), 2, 9, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'H495H6', N'Набор стейковых ножей', N'Набор стейковых ножей 4 пр. в деревянной коробке', N'ножи', NULL, N'Mayer & Boch', CAST(7000.0000 AS Decimal(19, 4)), 2, 15, N'')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'K437E6', N'Набор вилок', N'Набор вилок столовых APOLLO "Aurora" 3шт.', N'наборы', NULL, N'Apollo', CAST(530.0000 AS Decimal(19, 4)), 3, 16, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'L593H5', N'набор ножей', N'Набор ножей Mayer & Boch, 4 шт', N'наборы', NULL, N'Mayer & Boch', CAST(1300.0000 AS Decimal(19, 4)), 5, 14, N'')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'N493G6', N'Набор для серверовки', N'Набор для сервировки сыра Select', N'наборы', NULL, N'Smart Home', CAST(2550.0000 AS Decimal(19, 4)), 4, 6, N'')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'R836H6', N'Набор  столовых ножей', N'Attribute Набор столовых ножей Baguette 2 предмета серебристый', N'ножи', NULL, N'Attribute', CAST(250.0000 AS Decimal(19, 4)), 3, 16, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'S394J5', N'Набор чайных ложек', N'Attribute Набор чайных ложек Chaplet 3 предмета серебристый', N'наборы', NULL, N'Attribute', CAST(170.0000 AS Decimal(19, 4)), 3, 4, N'')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'S395B5', N'Нож для стейка', N'Нож для стейка 11,5 см серебристый/черный', N'ножи', NULL, N'Apollo', CAST(600.0000 AS Decimal(19, 4)), 4, 15, N'')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'T793T4', N'Набор ложек', N'Набор столовых ложек Baguette 3 предмета серебристый', N'Ложки', NULL, N'Attribute', CAST(250.0000 AS Decimal(19, 4)), 3, 16, N'Завершен')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'V026J4', N'набор ножей', N'абор ножей для стейка и пиццы Swiss classic 2 шт. желтый', N'наборы', NULL, N'Apollo', CAST(700.0000 AS Decimal(19, 4)), 3, 9, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'V403G6', N'Ложка чайная', N'Ложка чайная DORIA Eternum', N'Ложки', NULL, N'Doria', CAST(600.0000 AS Decimal(19, 4)), 5, 24, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'V727Y6', N'Набор десертных ложек', N'Набор десертных ложек на подставке Размер: 7*7*15 см', N'Ложки', NULL, N'Mayer & Boch', CAST(3000.0000 AS Decimal(19, 4)), 4, 8, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'W295Y5', N'Сервировочный набор для торта', N'Набор сервировочный для торта "Розанна"', N'наборы', NULL, N'Attribute', CAST(1100.0000 AS Decimal(19, 4)), 2, 16, N'')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'W405G6', N'Набор столовых приборов', N'Набор сервировочных столовых вилок Цветы', N'наборы', NULL, N'Attribute', CAST(1300.0000 AS Decimal(19, 4)), 3, 4, N'Новый')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'А112Т4', N'Набор вилок', N'Набор столовых вилок Davinci, 20 см 6 шт.', N'Вилки', NULL, N'Davinci', CAST(1600.0000 AS Decimal(19, 4)), 2, 6, N'Завершен')
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Администратор')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Менеджер')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (3, N'Клиент')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (1, N'Савицкая', N'Арина', N'Саввична', N'1y3lj8w0viop@outlook.com', N'2L6KZG', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (2, N'Мартынов', N'Максим', N'Михайлович', N'3o698uk5c0rw@tutanota.com', N'uzWC67', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (3, N'Зубов', N'Александр', N'Дамирович', N'lx24fvrt1aip@yahoo.com', N'8ntwUp', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (4, N'Попов', N'Даниил', N'Олегович', N's8z076vku95j@gmail.com', N'YOyhfR', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (5, N'Семенов', N'Михаил', N'Никитич', N'n3bxm7f2q5i4@outlook.com', N'RSbvHv', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (6, N'Дмитриева', N'Надежда', N'Вячеславовна', N'r7dztn8a5ihq@mail.com', N'rwVDh9', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (7, N'Воронцова', N'Виктория', N'Саввична', N'vofgck2m39hq@gmail.com', N'LdNyos', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (8, N'Софронов', N'Ярослав', N'Игоревич', N's6q9tevybado@yahoo.com', N'gynQMT', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (9, N'Егоров', N'Артём', N'Евгеньевич', N'p7wuls3dtq9v@yahoo.com', N'AtnDjr', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (10, N'Ситникова', N'Эмилия', N'Степановна', N'rdn04s1u2ckb@mail.com', N'JlFRCZ', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (11, N'Пример', N'Пример', N'Примеров', N'primer', N'primer', 3)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Points] FOREIGN KEY([OrderPickupPoint])
REFERENCES [dbo].[Points] ([OrderPickupPoint])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Points]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK__OrderProd__Order__2D27B809] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK__OrderProd__Order__2D27B809]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK__OrderProd__Produ__2E1BDC42] FOREIGN KEY([ProductArticleNumber])
REFERENCES [dbo].[Product] ([ProductArticleNumber])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK__OrderProd__Produ__2E1BDC42]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([UserRole])
REFERENCES [dbo].[Role] ([RoleID])
GO
USE [master]
GO
ALTER DATABASE [kitchen] SET  READ_WRITE 
GO
