USE [master]
GO
/****** Object:  Database [PBAP]    Script Date: 04/01/2017 2:16:54 PM ******/
CREATE DATABASE [PBAP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PBAP', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLWIN102014\MSSQL\DATA\PBAP.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PBAP_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLWIN102014\MSSQL\DATA\PBAP_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PBAP] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PBAP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PBAP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PBAP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PBAP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PBAP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PBAP] SET ARITHABORT OFF 
GO
ALTER DATABASE [PBAP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PBAP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PBAP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PBAP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PBAP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PBAP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PBAP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PBAP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PBAP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PBAP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PBAP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PBAP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PBAP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PBAP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PBAP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PBAP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PBAP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PBAP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PBAP] SET  MULTI_USER 
GO
ALTER DATABASE [PBAP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PBAP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PBAP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PBAP] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [PBAP] SET DELAYED_DURABILITY = DISABLED 
GO
USE [PBAP]
GO
/****** Object:  Table [dbo].[Auths]    Script Date: 04/01/2017 2:16:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auths](
	[AuthID] [int] IDENTITY(1,1) NOT NULL,
	[AuthType] [nvarchar](20) NULL,
	[AuthKey] [nvarchar](150) NULL,
	[UserID] [int] NULL,
 CONSTRAINT [PK_Auth] PRIMARY KEY CLUSTERED 
(
	[AuthID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Logs]    Script Date: 04/01/2017 2:16:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[LogTitle] [nvarchar](20) NULL,
	[LogContent] [nvarchar](250) NULL,
	[LogType] [nvarchar](20) NULL,
	[UserID] [int] NULL,
	[LogDate] [datetime] NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payments]    Script Date: 04/01/2017 2:16:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[SubscriptionID] [int] NULL,
	[PaymentAmount] [decimal](18, 2) NULL,
	[PaymentDate] [nchar](10) NULL,
	[PaymentStatus] [nvarchar](20) NULL,
	[PaymentType] [nvarchar](20) NULL,
 CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 04/01/2017 2:16:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[ReservationID] [int] IDENTITY(1,1) NOT NULL,
	[SeminarID] [int] NULL,
	[UserID] [int] NULL,
	[PaymentID] [int] NULL,
	[VoucherID] [int] NULL,
	[ReservationStatus] [nvarchar](50) NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SeminarDetails]    Script Date: 04/01/2017 2:16:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeminarDetails](
	[SeminarDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[SeminarTranscript] [nvarchar](50) NULL,
	[SeminarID] [int] NULL,
 CONSTRAINT [PK_SeminarDetails] PRIMARY KEY CLUSTERED 
(
	[SeminarDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Seminars]    Script Date: 04/01/2017 2:16:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seminars](
	[SeminarID] [int] IDENTITY(1,1) NOT NULL,
	[SemninarCode] [nvarchar](50) NULL,
	[SeminarTitle] [nvarchar](50) NULL,
	[SeminarArea] [nvarchar](50) NULL,
	[SeminarUnits] [nvarchar](10) NULL,
	[SeminarDescription] [nvarchar](max) NULL,
	[SeminarFee] [decimal](18, 2) NULL,
	[SeminarLocation] [nvarchar](150) NULL,
	[SeminarDate] [datetime] NULL,
	[SeminarSpeaker] [int] NULL,
 CONSTRAINT [PK_Seminars] PRIMARY KEY CLUSTERED 
(
	[SeminarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SeminarSpeakers]    Script Date: 04/01/2017 2:16:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeminarSpeakers](
	[SeminarSpeakerID] [int] IDENTITY(1,1) NOT NULL,
	[SeminarSpeakerTitle] [nvarchar](20) NULL,
	[SeminarSpeakerFN] [nvarchar](20) NULL,
	[SeminarSpeakerLN] [nvarchar](20) NULL,
	[SeminarSpeakerTel] [nvarchar](20) NULL,
	[SeminarSpeakerEmail] [nvarchar](50) NULL,
 CONSTRAINT [PK_SeminarSpeaker] PRIMARY KEY CLUSTERED 
(
	[SeminarSpeakerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Subscriptions]    Script Date: 04/01/2017 2:16:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subscriptions](
	[SubscriptionID] [int] IDENTITY(1,1) NOT NULL,
	[SubscriptionType] [nvarchar](20) NULL,
	[SubscriptionStatus] [nvarchar](20) NULL,
	[SubscriptionStartDate] [datetime] NULL,
	[SubscriptionEndDate] [datetime] NULL,
	[SubscriptionTotalAmnt] [decimal](18, 2) NULL,
	[SubscriptionRunningBal] [nchar](10) NULL,
	[VoucherID] [int] NULL,
 CONSTRAINT [PK_Subscriptions] PRIMARY KEY CLUSTERED 
(
	[SubscriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 04/01/2017 2:16:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserFirstName] [nvarchar](100) NULL,
	[UserMidName] [nvarchar](100) NULL,
	[UserLastName] [nvarchar](100) NULL,
	[UserBday] [datetime] NULL,
	[UserCompany] [nvarchar](100) NULL,
	[UserPosition] [nvarchar](100) NULL,
	[UserEmail] [nvarchar](100) NULL,
	[UserFaxNo] [nvarchar](20) NULL,
	[UserTelNo] [nvarchar](20) NULL,
	[UserMobileNo] [nvarchar](20) NULL,
	[UserAddress] [nvarchar](250) NULL,
	[UserPassword] [nvarchar](max) NULL,
	[UserStatus] [nvarchar](10) NULL,
	[UserIP] [nvarchar](50) NULL,
	[UserType] [nvarchar](50) NULL,
	[SubscriptionID] [int] NULL,
	[UserAuthID] [int] NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vouchers]    Script Date: 04/01/2017 2:16:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vouchers](
	[VoucherID] [int] IDENTITY(1,1) NOT NULL,
	[VoucherCode] [nvarchar](100) NULL,
	[VoucherExpiry] [datetime] NULL,
	[VoucherDisc] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Vouchers] PRIMARY KEY CLUSTERED 
(
	[VoucherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Seminars] ON 

INSERT [dbo].[Seminars] ([SeminarID], [SemninarCode], [SeminarTitle], [SeminarArea], [SeminarUnits], [SeminarDescription], [SeminarFee], [SeminarLocation], [SeminarDate], [SeminarSpeaker]) VALUES (1, NULL, N'Bookeeping 101', N'Bookeeping', N'3.0', N'Bookkeeping is the recording of financial transactions, and is part of the process of accounting in business. Transactions include purchases, sales, receipts, and payments by an individual person or an organization/corporation. There are several standard methods of bookkeeping, such as the single-entry bookkeeping system and the double-entry bookkeeping system, but, while they may be thought of as "real" bookkeeping, any process that involves the recording of financial transactions is a bookkeeping process.', CAST(1000.00 AS Decimal(18, 2)), N'Makati City', CAST(N'2016-12-26 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seminars] ([SeminarID], [SemninarCode], [SeminarTitle], [SeminarArea], [SeminarUnits], [SeminarDescription], [SeminarFee], [SeminarLocation], [SeminarDate], [SeminarSpeaker]) VALUES (2, NULL, N'Accounting 101', N'Accounting', N'2.0', N'ccounting is the systematic and comprehensive recording of financial transactions pertaining to a business, and it also refers to the process of summarizing, analyzing and reporting these transactions to oversight agencies and tax collection entities.', CAST(2500.00 AS Decimal(18, 2)), N'Manila', CAST(N'2016-12-28 00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Seminars] ([SeminarID], [SemninarCode], [SeminarTitle], [SeminarArea], [SeminarUnits], [SeminarDescription], [SeminarFee], [SeminarLocation], [SeminarDate], [SeminarSpeaker]) VALUES (3, NULL, N'Math 101', N'Math', N'5.0', N'Mathematics (from Greek μάθημα máthēma, “knowledge, study, learning”) is the study of topics such as quantity (numbers), structure,[3] space,[2] and change. There is a range of views among mathematicians and philosophers as to the exact scope and definition of mathematics.', CAST(2000.00 AS Decimal(18, 2)), N'Pasig Ciy', CAST(N'2016-12-30 00:00:00.000' AS DateTime), 3)
INSERT [dbo].[Seminars] ([SeminarID], [SemninarCode], [SeminarTitle], [SeminarArea], [SeminarUnits], [SeminarDescription], [SeminarFee], [SeminarLocation], [SeminarDate], [SeminarSpeaker]) VALUES (4, NULL, N'Science 101', N'Science', N'2.0', N'Science', CAST(1000.00 AS Decimal(18, 2)), N'Makati City', CAST(N'2016-12-27 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seminars] ([SeminarID], [SemninarCode], [SeminarTitle], [SeminarArea], [SeminarUnits], [SeminarDescription], [SeminarFee], [SeminarLocation], [SeminarDate], [SeminarSpeaker]) VALUES (5, NULL, N'Computer 101', N'IT', N'4.0', N'Computer', CAST(1500.00 AS Decimal(18, 2)), N'Pasig City', CAST(N'2016-12-29 00:00:00.000' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[Seminars] OFF
SET IDENTITY_INSERT [dbo].[SeminarSpeakers] ON 

INSERT [dbo].[SeminarSpeakers] ([SeminarSpeakerID], [SeminarSpeakerTitle], [SeminarSpeakerFN], [SeminarSpeakerLN], [SeminarSpeakerTel], [SeminarSpeakerEmail]) VALUES (1, N'Dr.', N'Steven', N'Tomas', N'12345', N'steven.tomas@live.com')
INSERT [dbo].[SeminarSpeakers] ([SeminarSpeakerID], [SeminarSpeakerTitle], [SeminarSpeakerFN], [SeminarSpeakerLN], [SeminarSpeakerTel], [SeminarSpeakerEmail]) VALUES (2, N'Mr.', N'James', N'Bond', N'41231', N'jamesbond@live.com')
INSERT [dbo].[SeminarSpeakers] ([SeminarSpeakerID], [SeminarSpeakerTitle], [SeminarSpeakerFN], [SeminarSpeakerLN], [SeminarSpeakerTel], [SeminarSpeakerEmail]) VALUES (3, N'Ms.', N'Jenny', N'Bond', N'41232', N'jbond@live.com')
SET IDENTITY_INSERT [dbo].[SeminarSpeakers] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [UserFirstName], [UserMidName], [UserLastName], [UserBday], [UserCompany], [UserPosition], [UserEmail], [UserFaxNo], [UserTelNo], [UserMobileNo], [UserAddress], [UserPassword], [UserStatus], [UserIP], [UserType], [SubscriptionID], [UserAuthID], [DateAdded]) VALUES (1, N'Robert Steven', N'Tomas', N'Pascua', CAST(N'1900-01-01 00:00:00.000' AS DateTime), N'MS', N'SE', N'steven.tomas@live.com', NULL, NULL, N'09083262024', N'Makati City', N'1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==', N'Active', N'127.0.0.1', N'User', NULL, NULL, CAST(N'2016-12-27 00:48:17.613' AS DateTime))
INSERT [dbo].[Users] ([UserID], [UserFirstName], [UserMidName], [UserLastName], [UserBday], [UserCompany], [UserPosition], [UserEmail], [UserFaxNo], [UserTelNo], [UserMobileNo], [UserAddress], [UserPassword], [UserStatus], [UserIP], [UserType], [SubscriptionID], [UserAuthID], [DateAdded]) VALUES (3, N'Juan ', N'Dela Cruz', N'', NULL, N'IBM', N'Accountant', N'steven@live.com', NULL, NULL, N'09232321232', N'Pasig City', N'1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==', N'Active', N'127.0.0.1', N'User', NULL, NULL, CAST(N'2016-12-27 02:35:43.007' AS DateTime))
INSERT [dbo].[Users] ([UserID], [UserFirstName], [UserMidName], [UserLastName], [UserBday], [UserCompany], [UserPosition], [UserEmail], [UserFaxNo], [UserTelNo], [UserMobileNo], [UserAddress], [UserPassword], [UserStatus], [UserIP], [UserType], [SubscriptionID], [UserAuthID], [DateAdded]) VALUES (4, N'Juan ', N'Dela Cruz', N'', NULL, N'IBM', N'Accountant', N'steven1@email.com', NULL, NULL, N'09232321232', N'Pasig City', N'1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==', N'Active', N'127.0.0.1', N'User', NULL, NULL, CAST(N'2016-12-27 02:39:18.457' AS DateTime))
INSERT [dbo].[Users] ([UserID], [UserFirstName], [UserMidName], [UserLastName], [UserBday], [UserCompany], [UserPosition], [UserEmail], [UserFaxNo], [UserTelNo], [UserMobileNo], [UserAddress], [UserPassword], [UserStatus], [UserIP], [UserType], [SubscriptionID], [UserAuthID], [DateAdded]) VALUES (9, N'Jennifer', N'Lawrence', N'R', NULL, N'Google Inc.,', N'Sales Agen', N'jlaw@gmail.com', NULL, NULL, N'09842323212', N'Makati City', N'1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==', N'Active', N'127.0.0.1', N'User', NULL, NULL, CAST(N'2016-12-27 03:01:36.040' AS DateTime))
INSERT [dbo].[Users] ([UserID], [UserFirstName], [UserMidName], [UserLastName], [UserBday], [UserCompany], [UserPosition], [UserEmail], [UserFaxNo], [UserTelNo], [UserMobileNo], [UserAddress], [UserPassword], [UserStatus], [UserIP], [UserType], [SubscriptionID], [UserAuthID], [DateAdded]) VALUES (10, N'Michael', N'Bay', N'A', NULL, N'HP', N'IT Engineer', N'mbay1212@yahoo.com', NULL, NULL, N'09231232324', N'Caloocan City', N'1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==', N'Active', N'127.0.0.1', N'User', NULL, NULL, CAST(N'2016-12-27 03:02:33.093' AS DateTime))
INSERT [dbo].[Users] ([UserID], [UserFirstName], [UserMidName], [UserLastName], [UserBday], [UserCompany], [UserPosition], [UserEmail], [UserFaxNo], [UserTelNo], [UserMobileNo], [UserAddress], [UserPassword], [UserStatus], [UserIP], [UserType], [SubscriptionID], [UserAuthID], [DateAdded]) VALUES (11, N'Michael', N'Bay', N'A', NULL, N'HP', N'IT Engineer', N'mbay12@yahoo.com', NULL, NULL, N'09231232324', N'Caloocan City', N'1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==', N'Active', N'127.0.0.1', N'User', NULL, NULL, CAST(N'2016-12-27 03:04:28.060' AS DateTime))
INSERT [dbo].[Users] ([UserID], [UserFirstName], [UserMidName], [UserLastName], [UserBday], [UserCompany], [UserPosition], [UserEmail], [UserFaxNo], [UserTelNo], [UserMobileNo], [UserAddress], [UserPassword], [UserStatus], [UserIP], [UserType], [SubscriptionID], [UserAuthID], [DateAdded]) VALUES (1002, N'Jams', N'Corden', N'C', NULL, N'HP', N'SE', N'jc@email.com', NULL, NULL, N'09212321254', N'Valenzuela City', N'z4PhNX7vuL3xVChQ1m2AB9Yg5AULVxXcg/SpIdNs6c5H0NE8XYXysP+DGNKHfuwvY7kxvUdBeoGlODJ6+SfaPg==', N'Active', N'127.0.0.1', N'User', NULL, NULL, CAST(N'2016-12-30 22:11:03.637' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
USE [master]
GO
ALTER DATABASE [PBAP] SET  READ_WRITE 
GO
