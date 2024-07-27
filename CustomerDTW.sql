USE [master]
GO
/****** Object:  Database [CustomerDataWareHouse]    Script Date: 11/6/2023 6:17:01 PM ******/
CREATE DATABASE [CustomerDataWareHouse]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CustomerDataWareHouse', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CustomerDataWareHouse.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CustomerDataWareHouse_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CustomerDataWareHouse_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CustomerDataWareHouse] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CustomerDataWareHouse].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CustomerDataWareHouse] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET ARITHABORT OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CustomerDataWareHouse] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CustomerDataWareHouse] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CustomerDataWareHouse] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CustomerDataWareHouse] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET RECOVERY FULL 
GO
ALTER DATABASE [CustomerDataWareHouse] SET  MULTI_USER 
GO
ALTER DATABASE [CustomerDataWareHouse] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CustomerDataWareHouse] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CustomerDataWareHouse] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CustomerDataWareHouse] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CustomerDataWareHouse] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CustomerDataWareHouse', N'ON'
GO
ALTER DATABASE [CustomerDataWareHouse] SET QUERY_STORE = OFF
GO
USE [CustomerDataWareHouse]
GO
/****** Object:  Table [dbo].[DimCountry]    Script Date: 11/6/2023 6:17:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCountry](
	[CountryId] [int] NOT NULL,
	[CountryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_DimCountry] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimProduct]    Script Date: 11/6/2023 6:17:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimProduct](
	[ProductId] [int] NOT NULL,
	[ProductName] [nvarchar](50) NULL,
 CONSTRAINT [PK_DimProduct] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSalesPerson]    Script Date: 11/6/2023 6:17:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSalesPerson](
	[SalesPersonId] [int] NOT NULL,
	[SalesPersonName] [nvarchar](50) NULL,
 CONSTRAINT [PK_DimSalesPerson] PRIMARY KEY CLUSTERED 
(
	[SalesPersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimState]    Script Date: 11/6/2023 6:17:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimState](
	[StateId] [int] NOT NULL,
	[SatateName] [nvarchar](50) NULL,
 CONSTRAINT [PK_DimState] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactCustomer]    Script Date: 11/6/2023 6:17:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCustomer](
	[CustomerCode] [nvarchar](50) NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAmount] [money] NULL,
	[SalesDate] [datetime] NULL,
	[Countryid_fk] [int] NULL,
	[StatesId_fk] [int] NULL,
	[productId_fk] [int] NULL,
	[SalesPersonId_fk] [int] NULL,
 CONSTRAINT [PK_tblCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactCustomer]  WITH NOCHECK ADD  CONSTRAINT [FK_FactCustomer_DimCountry] FOREIGN KEY([Countryid_fk])
REFERENCES [dbo].[DimCountry] ([CountryId])
GO
ALTER TABLE [dbo].[FactCustomer] CHECK CONSTRAINT [FK_FactCustomer_DimCountry]
GO
ALTER TABLE [dbo].[FactCustomer]  WITH NOCHECK ADD  CONSTRAINT [FK_FactCustomer_DimProduct] FOREIGN KEY([productId_fk])
REFERENCES [dbo].[DimProduct] ([ProductId])
GO
ALTER TABLE [dbo].[FactCustomer] CHECK CONSTRAINT [FK_FactCustomer_DimProduct]
GO
ALTER TABLE [dbo].[FactCustomer]  WITH NOCHECK ADD  CONSTRAINT [FK_FactCustomer_DimSalesPerson] FOREIGN KEY([SalesPersonId_fk])
REFERENCES [dbo].[DimSalesPerson] ([SalesPersonId])
GO
ALTER TABLE [dbo].[FactCustomer] CHECK CONSTRAINT [FK_FactCustomer_DimSalesPerson]
GO
ALTER TABLE [dbo].[FactCustomer]  WITH NOCHECK ADD  CONSTRAINT [FK_FactCustomer_DimState] FOREIGN KEY([StatesId_fk])
REFERENCES [dbo].[DimState] ([StateId])
GO
ALTER TABLE [dbo].[FactCustomer] CHECK CONSTRAINT [FK_FactCustomer_DimState]
GO
USE [master]
GO
ALTER DATABASE [CustomerDataWareHouse] SET  READ_WRITE 
GO
