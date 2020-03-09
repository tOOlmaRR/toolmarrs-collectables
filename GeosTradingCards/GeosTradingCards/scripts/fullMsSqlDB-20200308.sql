USE [master]
GO
/****** Object:  Database [GeosTradingCards]    Script Date: 2020-03-08 4:08:30 PM ******/
CREATE DATABASE [GeosTradingCards]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CardCollection', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.GMARRMSSQL1\MSSQL\DATA\CardCollection.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CardCollection_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.GMARRMSSQL1\MSSQL\DATA\CardCollection_log.ldf' , SIZE = 3840KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO
ALTER DATABASE [GeosTradingCards] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GeosTradingCards].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [GeosTradingCards] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GeosTradingCards] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GeosTradingCards] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GeosTradingCards] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GeosTradingCards] SET ARITHABORT OFF 
GO
ALTER DATABASE [GeosTradingCards] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [GeosTradingCards] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GeosTradingCards] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GeosTradingCards] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GeosTradingCards] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GeosTradingCards] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GeosTradingCards] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GeosTradingCards] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GeosTradingCards] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GeosTradingCards] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GeosTradingCards] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GeosTradingCards] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GeosTradingCards] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GeosTradingCards] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GeosTradingCards] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GeosTradingCards] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GeosTradingCards] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GeosTradingCards] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GeosTradingCards] SET  MULTI_USER 
GO
ALTER DATABASE [GeosTradingCards] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GeosTradingCards] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GeosTradingCards] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GeosTradingCards] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [GeosTradingCards] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GeosTradingCards] SET QUERY_STORE = OFF
GO
USE [GeosTradingCards]
GO
/****** Object:  User [Urgele1]    Script Date: 2020-03-08 4:08:31 PM ******/
CREATE USER [Urgele1] FOR LOGIN [Urgele1] WITH DEFAULT_SCHEMA=[db_accessadmin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [Urgele1]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [Urgele1]
GO
/****** Object:  Table [dbo].[BookValue]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookValue](
	[BookValueID] [int] IDENTITY(1,1) NOT NULL,
	[HighValue] [money] NULL,
	[LowValue] [money] NULL,
	[Source] [nvarchar](128) NULL,
	[LastUpdate] [datetime] NULL,
 CONSTRAINT [PK_BookValue] PRIMARY KEY CLUSTERED 
(
	[BookValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Card]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Card](
	[CardID] [int] IDENTITY(1,1) NOT NULL,
	[CardNumber] [nvarchar](16) NULL,
	[Title] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](256) NULL,
	[Comments] [nvarchar](256) NULL,
	[RookieCard] [bit] NOT NULL,
	[GradingModifier] [decimal](5, 2) NOT NULL,
	[Rarity] [nvarchar](64) NULL,
	[InsertSetID] [int] NULL,
	[CardSetID] [int] NOT NULL,
	[SubsetID] [int] NULL,
	[BookValueID] [int] NULL,
	[ErrorID] [int] NULL,
	[TeamID] [smallint] NULL,
	[MetaKeywords] [nvarchar](128) NULL,
	[MetaDescription] [nvarchar](512) NULL,
 CONSTRAINT [PK_Card] PRIMARY KEY CLUSTERED 
(
	[CardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Card_Players]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Card_Players](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CardID] [int] NOT NULL,
	[PlayerID] [int] NOT NULL,
	[TeamID] [smallint] NULL,
 CONSTRAINT [PK_Card_Players] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CardCollectionSingles]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CardCollectionSingles](
	[CardCollectionSingleID] [int] IDENTITY(1,1) NOT NULL,
	[SingleCardID] [nvarchar](7) NOT NULL,
	[CollectionID] [int] NOT NULL,
 CONSTRAINT [PK_CardCollectionSingles] PRIMARY KEY CLUSTERED 
(
	[CardCollectionSingleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CardSet]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CardSet](
	[CardSetID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Comments] [nvarchar](256) NULL,
	[GradingModifier] [decimal](5, 2) NOT NULL,
	[ReleaseYear] [char](4) NOT NULL,
	[LastInventoryCheck] [datetime] NULL,
	[LastBeckettUpdate] [datetime] NULL,
	[Manufacturer] [nvarchar](128) NOT NULL,
	[Season] [nvarchar](7) NOT NULL,
	[MetaKeywords] [nvarchar](128) NULL,
	[MetaDescription] [nvarchar](512) NULL,
	[CardsetCategoryID] [int] NOT NULL,
 CONSTRAINT [PK_CardSet] PRIMARY KEY CLUSTERED 
(
	[CardSetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CardSetCategory]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CardSetCategory](
	[CardSetCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_CardSetCategory] PRIMARY KEY CLUSTERED 
(
	[CardSetCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Collection]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Collection](
	[CollectionID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Owner] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Collection] PRIMARY KEY CLUSTERED 
(
	[CollectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Error]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Error](
	[ErrorID] [int] IDENTITY(1,1) NOT NULL,
	[Version] [nvarchar](32) NOT NULL,
	[Description] [nvarchar](256) NULL,
 CONSTRAINT [PK_Error] PRIMARY KEY CLUSTERED 
(
	[ErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exceptions]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exceptions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](256) NOT NULL,
	[StackTrace] [nvarchar](1024) NOT NULL,
	[InnerException] [nvarchar](256) NULL,
	[CustomMessage] [nvarchar](1024) NULL,
	[Source] [nvarchar](256) NULL,
	[Timestamp] [datetime] NULL,
 CONSTRAINT [PK_Exceptions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GoogleDocsPages]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GoogleDocsPages](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Season] [char](7) NOT NULL,
	[Set] [nvarchar](128) NOT NULL,
	[GoogleDocsUrl] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_GoogleDocsPages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grading]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grading](
	[GradingID] [int] IDENTITY(1,1) NOT NULL,
	[Edges] [decimal](5, 2) NULL,
	[Surfaces] [decimal](5, 2) NULL,
	[Corners] [decimal](5, 2) NULL,
	[Alignment] [decimal](5, 2) NULL,
	[OverallGrade] [decimal](5, 2) NULL,
	[ValueModifier] [decimal](7, 3) NULL,
	[ClassID] [tinyint] NOT NULL,
	[BCG_SerialNumber] [nvarchar](64) NULL,
	[BCG_Grade] [tinyint] NULL,
 CONSTRAINT [PK_Grading] PRIMARY KEY CLUSTERED 
(
	[GradingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GradingClasses]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GradingClasses](
	[GradingClassID] [tinyint] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](16) NOT NULL,
	[AbbreviatedName] [nvarchar](7) NOT NULL,
	[Description] [nvarchar](1024) NULL,
 CONSTRAINT [PK_GradingClasses] PRIMARY KEY CLUSTERED 
(
	[GradingClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InsertSet]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InsertSet](
	[InsertSetID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Rarity] [nvarchar](64) NULL,
	[Comments] [nvarchar](256) NULL,
	[Description] [nvarchar](256) NULL,
	[GradingModifier] [float] NOT NULL,
	[LastInventoryCheck] [datetime] NULL,
	[LastBeckettUpdate] [datetime] NULL,
	[CardSetID] [int] NOT NULL,
	[IsParallelSet] [bit] NOT NULL,
 CONSTRAINT [PK_InsertSet] PRIMARY KEY CLUSTERED 
(
	[InsertSetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[League]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[League](
	[LeagueID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NULL,
	[NameAbbrev] [nvarchar](8) NOT NULL,
	[Sport] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_League] PRIMARY KEY CLUSTERED 
(
	[LeagueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[PlayerID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](32) NOT NULL,
	[LastName] [nvarchar](32) NOT NULL,
	[Birthdate] [datetime] NULL,
 CONSTRAINT [PK_Player] PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerAlias]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerAlias](
	[PlayerAliasID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [int] NOT NULL,
 CONSTRAINT [PK_PlayerAlias] PRIMARY KEY CLUSTERED 
(
	[PlayerAliasID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Players_Position]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Players_Position](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PositionID] [int] NOT NULL,
	[PlayerID] [int] NOT NULL,
 CONSTRAINT [PK_Players_Position] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Position]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Position](
	[PositionID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](32) NOT NULL,
	[Abbreviation] [char](2) NOT NULL,
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SingleCard]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SingleCard](
	[SingleCardID] [nvarchar](7) NOT NULL,
	[SellPrice] [money] NULL,
	[Cost] [money] NULL,
	[SoldPrice] [money] NULL,
	[Comments] [nvarchar](256) NULL,
	[Rarity] [nvarchar](11) NULL,
	[IsGradedCard] [bit] NOT NULL,
	[CardID] [int] NOT NULL,
	[StatusID] [int] NULL,
	[GradingID] [int] NULL,
 CONSTRAINT [PK_SingleCard] PRIMARY KEY CLUSTERED 
(
	[SingleCardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SingleCardStatus]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SingleCardStatus](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusTitle] [nvarchar](64) NOT NULL,
	[StatusDescription] [nvarchar](512) NULL,
 CONSTRAINT [PK_SingleCardStatus] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subset]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subset](
	[SubsetID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](256) NULL,
	[Comments] [nvarchar](256) NULL,
	[Rarity] [nvarchar](64) NULL,
	[GradingModifier] [decimal](5, 2) NOT NULL,
	[CardSetID] [int] NOT NULL,
 CONSTRAINT [PK_Subset] PRIMARY KEY CLUSTERED 
(
	[SubsetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[TeamID] [smallint] IDENTITY(1,1) NOT NULL,
	[Location] [nvarchar](32) NULL,
	[Name] [nvarchar](32) NULL,
	[LeagueID] [int] NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CardSet] ADD  CONSTRAINT [DF_CardSet_CardsetCategoryId]  DEFAULT ((1)) FOR [CardsetCategoryID]
GO
ALTER TABLE [dbo].[InsertSet] ADD  CONSTRAINT [DF_InsertSet_GradingModifier]  DEFAULT ((1.0)) FOR [GradingModifier]
GO
ALTER TABLE [dbo].[Card]  WITH CHECK ADD  CONSTRAINT [FK_Card_BookValue] FOREIGN KEY([BookValueID])
REFERENCES [dbo].[BookValue] ([BookValueID])
GO
ALTER TABLE [dbo].[Card] CHECK CONSTRAINT [FK_Card_BookValue]
GO
ALTER TABLE [dbo].[Card]  WITH CHECK ADD  CONSTRAINT [FK_Card_CardSet] FOREIGN KEY([CardSetID])
REFERENCES [dbo].[CardSet] ([CardSetID])
GO
ALTER TABLE [dbo].[Card] CHECK CONSTRAINT [FK_Card_CardSet]
GO
ALTER TABLE [dbo].[Card]  WITH CHECK ADD  CONSTRAINT [FK_Card_Error] FOREIGN KEY([ErrorID])
REFERENCES [dbo].[Error] ([ErrorID])
GO
ALTER TABLE [dbo].[Card] CHECK CONSTRAINT [FK_Card_Error]
GO
ALTER TABLE [dbo].[Card]  WITH CHECK ADD  CONSTRAINT [FK_Card_InsertSet] FOREIGN KEY([InsertSetID])
REFERENCES [dbo].[InsertSet] ([InsertSetID])
GO
ALTER TABLE [dbo].[Card] CHECK CONSTRAINT [FK_Card_InsertSet]
GO
ALTER TABLE [dbo].[Card]  WITH CHECK ADD  CONSTRAINT [FK_Card_Subset] FOREIGN KEY([SubsetID])
REFERENCES [dbo].[Subset] ([SubsetID])
GO
ALTER TABLE [dbo].[Card] CHECK CONSTRAINT [FK_Card_Subset]
GO
ALTER TABLE [dbo].[Card]  WITH CHECK ADD  CONSTRAINT [FK_Card_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO
ALTER TABLE [dbo].[Card] CHECK CONSTRAINT [FK_Card_Team]
GO
ALTER TABLE [dbo].[Card_Players]  WITH CHECK ADD  CONSTRAINT [FK_Card_Players_Card] FOREIGN KEY([CardID])
REFERENCES [dbo].[Card] ([CardID])
GO
ALTER TABLE [dbo].[Card_Players] CHECK CONSTRAINT [FK_Card_Players_Card]
GO
ALTER TABLE [dbo].[Card_Players]  WITH CHECK ADD  CONSTRAINT [FK_Card_Players_Player] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([PlayerID])
GO
ALTER TABLE [dbo].[Card_Players] CHECK CONSTRAINT [FK_Card_Players_Player]
GO
ALTER TABLE [dbo].[Card_Players]  WITH CHECK ADD  CONSTRAINT [FK_Card_Players_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO
ALTER TABLE [dbo].[Card_Players] CHECK CONSTRAINT [FK_Card_Players_Team]
GO
ALTER TABLE [dbo].[CardCollectionSingles]  WITH CHECK ADD  CONSTRAINT [FK_CardCollectionSingles_Collection] FOREIGN KEY([CollectionID])
REFERENCES [dbo].[Collection] ([CollectionID])
GO
ALTER TABLE [dbo].[CardCollectionSingles] CHECK CONSTRAINT [FK_CardCollectionSingles_Collection]
GO
ALTER TABLE [dbo].[CardCollectionSingles]  WITH CHECK ADD  CONSTRAINT [FK_CardCollectionSingles_SingleCard] FOREIGN KEY([SingleCardID])
REFERENCES [dbo].[SingleCard] ([SingleCardID])
GO
ALTER TABLE [dbo].[CardCollectionSingles] CHECK CONSTRAINT [FK_CardCollectionSingles_SingleCard]
GO
ALTER TABLE [dbo].[CardSet]  WITH CHECK ADD  CONSTRAINT [FK_CardSet_CardSetCategory] FOREIGN KEY([CardsetCategoryID])
REFERENCES [dbo].[CardSetCategory] ([CardSetCategoryID])
GO
ALTER TABLE [dbo].[CardSet] CHECK CONSTRAINT [FK_CardSet_CardSetCategory]
GO
ALTER TABLE [dbo].[Grading]  WITH CHECK ADD  CONSTRAINT [FK_Grading_GradingClasses] FOREIGN KEY([ClassID])
REFERENCES [dbo].[GradingClasses] ([GradingClassID])
GO
ALTER TABLE [dbo].[Grading] CHECK CONSTRAINT [FK_Grading_GradingClasses]
GO
ALTER TABLE [dbo].[InsertSet]  WITH CHECK ADD  CONSTRAINT [FK_InsertSet_CardSet] FOREIGN KEY([CardSetID])
REFERENCES [dbo].[CardSet] ([CardSetID])
GO
ALTER TABLE [dbo].[InsertSet] CHECK CONSTRAINT [FK_InsertSet_CardSet]
GO
ALTER TABLE [dbo].[PlayerAlias]  WITH CHECK ADD  CONSTRAINT [FK_PlayerAlias_Player] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([PlayerID])
GO
ALTER TABLE [dbo].[PlayerAlias] CHECK CONSTRAINT [FK_PlayerAlias_Player]
GO
ALTER TABLE [dbo].[Players_Position]  WITH CHECK ADD  CONSTRAINT [FK_Players_Position_Player] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([PlayerID])
GO
ALTER TABLE [dbo].[Players_Position] CHECK CONSTRAINT [FK_Players_Position_Player]
GO
ALTER TABLE [dbo].[Players_Position]  WITH CHECK ADD  CONSTRAINT [FK_Players_Position_Position] FOREIGN KEY([PositionID])
REFERENCES [dbo].[Position] ([PositionID])
GO
ALTER TABLE [dbo].[Players_Position] CHECK CONSTRAINT [FK_Players_Position_Position]
GO
ALTER TABLE [dbo].[SingleCard]  WITH CHECK ADD  CONSTRAINT [FK_SingleCard_Card] FOREIGN KEY([CardID])
REFERENCES [dbo].[Card] ([CardID])
GO
ALTER TABLE [dbo].[SingleCard] CHECK CONSTRAINT [FK_SingleCard_Card]
GO
ALTER TABLE [dbo].[SingleCard]  WITH CHECK ADD  CONSTRAINT [FK_SingleCard_Grading] FOREIGN KEY([GradingID])
REFERENCES [dbo].[Grading] ([GradingID])
GO
ALTER TABLE [dbo].[SingleCard] CHECK CONSTRAINT [FK_SingleCard_Grading]
GO
ALTER TABLE [dbo].[SingleCard]  WITH CHECK ADD  CONSTRAINT [FK_SingleCard_SingleCardStatus] FOREIGN KEY([StatusID])
REFERENCES [dbo].[SingleCardStatus] ([StatusID])
GO
ALTER TABLE [dbo].[SingleCard] CHECK CONSTRAINT [FK_SingleCard_SingleCardStatus]
GO
ALTER TABLE [dbo].[Subset]  WITH CHECK ADD  CONSTRAINT [FK_Subset_CardSet] FOREIGN KEY([CardSetID])
REFERENCES [dbo].[CardSet] ([CardSetID])
GO
ALTER TABLE [dbo].[Subset] CHECK CONSTRAINT [FK_Subset_CardSet]
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_League] FOREIGN KEY([LeagueID])
REFERENCES [dbo].[League] ([LeagueID])
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_Team_League]
GO
/****** Object:  StoredProcedure [dbo].[GoogleDocs.SelectAll]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George U. Marr
-- Create date: Sept. 15, 2009
-- Description:	Get all data from the Google Docs table
-- =============================================
CREATE PROCEDURE [dbo].[GoogleDocs.SelectAll]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [GoogleDocsPages].[ID],
		[GoogleDocsPages].[Season],
		[GoogleDocsPages].[Set],
		[GoogleDocsPages].[GoogleDocsUrl]
	FROM GoogleDocsPages
END
GO
/****** Object:  StoredProcedure [dbo].[GoogleDocs.SelectRowByID]    Script Date: 2020-03-08 4:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George U. Marr
-- Create date: Sept. 15, 2009
-- Description:	Given an ID, gets a specific row from the Google Docs table
-- =============================================
CREATE PROCEDURE [dbo].[GoogleDocs.SelectRowByID]
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [GoogleDocsPages].[ID],
		[GoogleDocsPages].[Season],
		[GoogleDocsPages].[Set],
		[GoogleDocsPages].[GoogleDocsUrl]
	FROM GoogleDocsPages
	WHERE [GoogleDocsPages].[ID] = @ID
END
GO
USE [master]
GO
ALTER DATABASE [GeosTradingCards] SET  READ_WRITE 
GO
