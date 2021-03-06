USE [master]
GO
/****** Object:  Database [GeosTradingCards-DEV]    Script Date: 2020-05-27 4:41:49 PM ******/
CREATE DATABASE [GeosTradingCards-DEV]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CardCollection-DEV', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.GMARRMSSQL1\MSSQL\DATA\CardCollection-DEV.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CardCollection-DEV_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.GMARRMSSQL1\MSSQL\DATA\CardCollection-DEV_log.ldf' , SIZE = 3840KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO
ALTER DATABASE [GeosTradingCards-DEV] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GeosTradingCards-DEV].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [GeosTradingCards-DEV] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET ARITHABORT OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET  MULTI_USER 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GeosTradingCards-DEV] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GeosTradingCards-DEV] SET QUERY_STORE = OFF
GO
USE [GeosTradingCards-DEV]
GO
/****** Object:  User [Urgele1]    Script Date: 2020-05-27 4:41:50 PM ******/
CREATE USER [Urgele1] FOR LOGIN [Urgele1] WITH DEFAULT_SCHEMA=[db_accessadmin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [Urgele1]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [Urgele1]
GO
/****** Object:  Table [dbo].[attributes]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[attributes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Abbreviation] [varchar](10) NULL,
	[FullName] [varchar](50) NULL,
	[Comments] [varchar](250) NULL,
 CONSTRAINT [PK_attributes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[card]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[card](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CardNumber] [varchar](10) NULL,
	[Title] [varchar](100) NULL,
	[Comments] [varchar](1000) NULL,
	[GradingModifier] [decimal](5, 2) NULL,
	[CardSet_ID] [int] NOT NULL,
	[Subset_ID] [int] NULL,
	[Team_ID] [int] NULL,
	[PlayerPosition_ID] [int] NULL,
 CONSTRAINT [PK_Card] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[card_has_attributes]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[card_has_attributes](
	[Card_ID] [int] NOT NULL,
	[Attributes_ID] [int] NOT NULL,
 CONSTRAINT [PK_card_has_attributes] PRIMARY KEY CLUSTERED 
(
	[Card_ID] ASC,
	[Attributes_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cardset]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cardset](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BaseSetName] [varchar](100) NULL,
	[InsertSetName] [varchar](100) NULL,
	[FullName] [varchar](200) NULL,
	[Season] [char](7) NULL,
	[Size] [smallint] NULL,
	[Rarity] [varchar](100) NULL,
	[GradingModifier] [decimal](5, 2) NULL,
	[Comments] [varchar](1000) NULL,
	[LastBeckettUpdate] [datetime] NULL,
	[LastInventoryCheck] [datetime] NULL,
	[Manufacturer_ID] [int] NOT NULL,
 CONSTRAINT [PK_CardSet] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cardvalue]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cardvalue](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LowValue] [decimal](8, 2) NULL,
	[HighValue] [decimal](8, 2) NULL,
	[LastAppraisal] [datetime] NULL,
	[LastAppraisalSource] [varchar](100) NULL,
	[Card_ID] [int] NOT NULL,
 CONSTRAINT [PK_BookValue] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Error]    Script Date: 2020-05-27 4:41:50 PM ******/
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
/****** Object:  Table [dbo].[Exceptions]    Script Date: 2020-05-27 4:41:50 PM ******/
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
/****** Object:  Table [dbo].[GoogleDocsPages]    Script Date: 2020-05-27 4:41:50 PM ******/
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
/****** Object:  Table [dbo].[gradingclass]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gradingclass](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Abbreviation] [varchar](10) NULL,
	[Name] [varchar](25) NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK_GradingClasses] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[league]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[league](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Abbreviation] [varchar](10) NULL,
	[Name] [varchar](100) NULL,
	[Sport_ID] [int] NOT NULL,
 CONSTRAINT [PK_League] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[manufacturer]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[manufacturer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_manufacturer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[playerposition]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[playerposition](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Abbreviation] [varchar](5) NULL,
	[Name] [varchar](25) NULL,
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[singlecard]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[singlecard](
	[ID] [varchar](10) NOT NULL,
	[SellPrice] [decimal](8, 2) NULL,
	[Cost] [decimal](8, 2) NULL,
	[PriceSoldFor] [decimal](8, 2) NULL,
	[Rarity] [varchar](100) NULL,
	[Status] [varchar](100) NULL,
	[Comments] [nvarchar](1000) NULL,
	[Card_ID] [int] NOT NULL,
 CONSTRAINT [PK_SingleCard] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[singlecardgrading]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[singlecardgrading](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Edges] [tinyint] NULL,
	[Surfaces] [tinyint] NULL,
	[Corners] [tinyint] NULL,
	[Alignment] [tinyint] NULL,
	[OverallGrade] [decimal](4, 2) NULL,
	[BCG_SerialNumber] [varchar](75) NULL,
	[BCG_Grade] [decimal](4, 2) NULL,
	[GradingClass_ID] [int] NULL,
	[SingleCard_ID] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Grading] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sport]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sport](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](25) NULL,
 CONSTRAINT [PK_sport] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subset]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subset](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Size] [smallint] NULL,
	[GradingModifier] [decimal](5, 2) NULL,
	[CardSet_ID] [int] NOT NULL,
 CONSTRAINT [PK_Subset] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[team]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[team](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Location] [varchar](25) NULL,
	[Name] [varchar](25) NULL,
	[League_ID] [int] NOT NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[card]  WITH CHECK ADD  CONSTRAINT [FK_card_cardset] FOREIGN KEY([CardSet_ID])
REFERENCES [dbo].[cardset] ([ID])
GO
ALTER TABLE [dbo].[card] CHECK CONSTRAINT [FK_card_cardset]
GO
ALTER TABLE [dbo].[card]  WITH CHECK ADD  CONSTRAINT [FK_card_playerposition] FOREIGN KEY([PlayerPosition_ID])
REFERENCES [dbo].[playerposition] ([ID])
GO
ALTER TABLE [dbo].[card] CHECK CONSTRAINT [FK_card_playerposition]
GO
ALTER TABLE [dbo].[card]  WITH CHECK ADD  CONSTRAINT [FK_card_subset] FOREIGN KEY([Subset_ID])
REFERENCES [dbo].[subset] ([ID])
GO
ALTER TABLE [dbo].[card] CHECK CONSTRAINT [FK_card_subset]
GO
ALTER TABLE [dbo].[card]  WITH CHECK ADD  CONSTRAINT [FK_card_team] FOREIGN KEY([Team_ID])
REFERENCES [dbo].[team] ([ID])
GO
ALTER TABLE [dbo].[card] CHECK CONSTRAINT [FK_card_team]
GO
ALTER TABLE [dbo].[card_has_attributes]  WITH CHECK ADD  CONSTRAINT [FK_card_has_attributes_attributes] FOREIGN KEY([Attributes_ID])
REFERENCES [dbo].[attributes] ([ID])
GO
ALTER TABLE [dbo].[card_has_attributes] CHECK CONSTRAINT [FK_card_has_attributes_attributes]
GO
ALTER TABLE [dbo].[card_has_attributes]  WITH CHECK ADD  CONSTRAINT [FK_card_has_attributes_card1] FOREIGN KEY([Card_ID])
REFERENCES [dbo].[card] ([ID])
GO
ALTER TABLE [dbo].[card_has_attributes] CHECK CONSTRAINT [FK_card_has_attributes_card1]
GO
ALTER TABLE [dbo].[cardset]  WITH CHECK ADD  CONSTRAINT [FK_cardset_manufacturer] FOREIGN KEY([Manufacturer_ID])
REFERENCES [dbo].[manufacturer] ([ID])
GO
ALTER TABLE [dbo].[cardset] CHECK CONSTRAINT [FK_cardset_manufacturer]
GO
ALTER TABLE [dbo].[cardvalue]  WITH CHECK ADD  CONSTRAINT [FK_cardvalue_card] FOREIGN KEY([Card_ID])
REFERENCES [dbo].[card] ([ID])
GO
ALTER TABLE [dbo].[cardvalue] CHECK CONSTRAINT [FK_cardvalue_card]
GO
ALTER TABLE [dbo].[league]  WITH CHECK ADD  CONSTRAINT [FK_league_sport] FOREIGN KEY([Sport_ID])
REFERENCES [dbo].[sport] ([ID])
GO
ALTER TABLE [dbo].[league] CHECK CONSTRAINT [FK_league_sport]
GO
ALTER TABLE [dbo].[singlecard]  WITH CHECK ADD  CONSTRAINT [FK_singlecard_card] FOREIGN KEY([Card_ID])
REFERENCES [dbo].[card] ([ID])
GO
ALTER TABLE [dbo].[singlecard] CHECK CONSTRAINT [FK_singlecard_card]
GO
ALTER TABLE [dbo].[singlecardgrading]  WITH CHECK ADD  CONSTRAINT [FK_singlecardgrading_gradingclass] FOREIGN KEY([GradingClass_ID])
REFERENCES [dbo].[gradingclass] ([ID])
GO
ALTER TABLE [dbo].[singlecardgrading] CHECK CONSTRAINT [FK_singlecardgrading_gradingclass]
GO
ALTER TABLE [dbo].[singlecardgrading]  WITH CHECK ADD  CONSTRAINT [FK_singlecardgrading_singlecard] FOREIGN KEY([SingleCard_ID])
REFERENCES [dbo].[singlecard] ([ID])
GO
ALTER TABLE [dbo].[singlecardgrading] CHECK CONSTRAINT [FK_singlecardgrading_singlecard]
GO
ALTER TABLE [dbo].[subset]  WITH CHECK ADD  CONSTRAINT [FK_subset_cardset] FOREIGN KEY([CardSet_ID])
REFERENCES [dbo].[cardset] ([ID])
GO
ALTER TABLE [dbo].[subset] CHECK CONSTRAINT [FK_subset_cardset]
GO
ALTER TABLE [dbo].[team]  WITH CHECK ADD  CONSTRAINT [FK_team_league] FOREIGN KEY([League_ID])
REFERENCES [dbo].[league] ([ID])
GO
ALTER TABLE [dbo].[team] CHECK CONSTRAINT [FK_team_league]
GO
/****** Object:  StoredProcedure [dbo].[Attributes.Insert]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		George U. Marr
-- Create date: May 10, 2020
-- Description:	Inserts a new Attribute into the database
-- =============================================
CREATE PROCEDURE [dbo].[Attributes.Insert]
	@ID int OUTPUT,
	@abbreviation varchar(10),
	@fullName varchar(50),
	@comments varchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [attributes] (
		Abbreviation,
		FullName,
		Comments
	)
	VALUES (
		@abbreviation,
		@fullName,
		@comments
	)
	SET @ID = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[Attributes.Select]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		George U. Marr
-- Create date: May 10, 2020
-- Description:	Attempts to get an existing Attribute based on Abbreviation
-- =============================================
CREATE PROCEDURE [dbo].[Attributes.Select]
	@ID int,
	@abbreviation varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @ID IS NULL
		BEGIN
			SELECT
				[attributes].[ID],
				[attributes].[Abbreviation],
				[attributes].[FullName],
				[attributes].[Comments]
			FROM [attributes] WITH (NOLOCK)
			WHERE [attributes].[Abbreviation] = @abbreviation
		END
	ELSE
		BEGIN
			SELECT
				[attributes].[ID],
				[attributes].[Abbreviation],
				[attributes].[FullName],
				[attributes].[Comments]
			FROM [attributes] WITH (NOLOCK)
			WHERE [attributes].[ID] = @ID
		END
END
GO
/****** Object:  StoredProcedure [dbo].[Card.Insert]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 7, 2020
-- Description:	Inserts a new Card into the database
-- =============================================
CREATE PROCEDURE [dbo].[Card.Insert]
	@ID int OUTPUT,
	@cardNumber varchar(10),
	@title varchar(100),
	@comments varchar(1000),
	@gradingModifier decimal(5,2),
	@cardSet_ID int,
	@subset_ID int,
	@team_ID int,
	@playerPosition_ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [card] (
		CardNumber,
		Title,
		Comments,
		GradingModifier,
		CardSet_ID,
		Subset_ID,
		Team_ID,
		PlayerPosition_ID
	)
	VALUES (
		@cardNumber,
		@title,
		@comments,
		@gradingModifier,
		@cardSet_ID,
		@subset_ID,
		@team_ID,
		@playerPosition_ID
	)
	SET @ID = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[Card.Select]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 7, 2020
-- Description:	Attempts to get an existing Card based on either ID or a combination of CardNumber and CardSet_ID
-- =============================================
CREATE PROCEDURE [dbo].[Card.Select]
	@ID int,
	@cardNumber varchar(10),
	@cardSet_ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @ID IS NULL
		BEGIN
			SELECT
				[card].[ID],
				[card].[CardNumber],
				[card].[Title],
				[card].[Comments],
				[card].[GradingModifier],
				[card].[CardSet_ID],
				[card].[Subset_ID],
				[card].[Team_ID],
				[card].[PlayerPosition_ID]
			FROM [card] WITH (NOLOCK)
			WHERE [card].[CardNumber] = @cardNumber
			AND [card].[CardSet_ID] = @cardSet_ID
		END
	ELSE
		BEGIN
			SELECT
				[card].[ID],
				[card].[CardNumber],
				[card].[Title],
				[card].[Comments],
				[card].[GradingModifier],
				[card].[CardSet_ID],
				[card].[Subset_ID],
				[card].[Team_ID],
				[card].[PlayerPosition_ID]
			FROM [card] WITH (NOLOCK)
			WHERE [card].[ID] = @ID
		END
END
GO
/****** Object:  StoredProcedure [dbo].[Card_Has_Attributes.Insert]    Script Date: 2020-05-27 4:41:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		George U. Marr
-- Create date: May 10, 2020
-- Description:	Inserts a new Card_Has_Attributes mapping into the database
-- =============================================
CREATE PROCEDURE [dbo].[Card_Has_Attributes.Insert]
	@Card_ID int,
	@Attributes_ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [card_has_attributes] (
		Card_ID,
		Attributes_ID
	)
	VALUES (
		@Card_ID,
		@Attributes_ID
	)
END
GO
/****** Object:  StoredProcedure [dbo].[CardSet.Insert]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 7, 2020
-- Description:	Inserts a new CardSet into the database
-- =============================================
CREATE PROCEDURE [dbo].[CardSet.Insert]
	@ID int OUTPUT,
	@baseSetName varchar(100),
	@insertSetName varchar(100),
	@fullName varchar(200),
	@season char(7),
	@size smallint,
	@rarity varchar(100),
	@gradingModifier decimal(5,2),
	@comments varchar(1000),
	@lastBeckettUpdate datetime,
	@lastInventoryCheck datetime,
	@manufacturer_ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [cardset] (
		BaseSetName,
		InsertSetName,
		FullName,
		Season,
		Size,
		Rarity,
		GradingModifier,
		Comments,
		LastBeckettUpdate,
		LastInventoryCheck,
		Manufacturer_ID
	)
	VALUES (
		@baseSetName,
		@insertSetName,
		@fullName,
		@season,
		@size,
		@rarity,
		@gradingModifier,
		@comments,
		@lastBeckettUpdate,
		@lastInventoryCheck,
		@manufacturer_ID
	)
	SET @ID = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[CardSet.Select]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 7, 2020
-- Description:	Attempts to get an existing CardSet based on either ID or a combination of BaseSetName, InsertSetName and Season
-- =============================================
CREATE PROCEDURE [dbo].[CardSet.Select]
	@ID int,
	@baseSetName varchar(100),
	@insertSetName varchar(100),
	@season char(7)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @ID IS NULL
		BEGIN
			SELECT
				[cardset].[ID],
				[cardset].[BaseSetName],
				[cardset].[InsertSetName],
				[cardset].[FullName],
				[cardset].[Season],
				[cardset].[Size],
				[cardset].[Rarity],
				[cardset].[GradingModifier],
				[cardset].[Comments],
				[cardset].[LastBeckettUpdate],
				[cardset].[LastInventoryCheck],
				[cardset].[Manufacturer_ID]
			FROM [cardset] WITH (NOLOCK)
			WHERE [cardset].[BaseSetName] = @baseSetName
			AND [cardset].[InsertSetName] = @insertSetName
			AND [cardset].[Season] = @season
		END
	ELSE
		BEGIN
			SELECT
				[cardset].[ID],
				[cardset].[BaseSetName],
				[cardset].[InsertSetName],
				[cardset].[FullName],
				[cardset].[Season],
				[cardset].[Size],
				[cardset].[Rarity],
				[cardset].[GradingModifier],
				[cardset].[Comments],
				[cardset].[LastBeckettUpdate],
				[cardset].[LastInventoryCheck],
				[cardset].[Manufacturer_ID]
			FROM [cardset] WITH (NOLOCK)
			WHERE [cardset].[ID] = @ID
		END
END
GO
/****** Object:  StoredProcedure [dbo].[CardValue.Insert]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		George U. Marr
-- Create date: May 10, 2020
-- Description:	Inserts a new CardValue into the database
-- =============================================
CREATE PROCEDURE [dbo].[CardValue.Insert]
	@ID int OUTPUT,
	@lowValue decimal(8,2),
	@highValue decimal(8,2),
	@lastAppraisal datetime,
	@lastAppraisalSource varchar(100),
	@card_ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [cardvalue] (
		LowValue,
		HighValue,
		LastAppraisal,
		LastAppraisalSource,
		Card_ID
	)
	VALUES (
		@lowValue,
		@highValue,
		@lastAppraisal,
		@lastAppraisalSource,
		@card_ID
	)
	SET @ID = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[GoogleDocs.SelectAll]    Script Date: 2020-05-27 4:41:51 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GoogleDocs.SelectRowByID]    Script Date: 2020-05-27 4:41:51 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GradingClass.Insert]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 15, 2020
-- Description:	Inserts a new GradingClass into the database
-- =============================================
CREATE PROCEDURE [dbo].[GradingClass.Insert]
	@ID int OUTPUT,
	@abbreviation varchar(10),
	@name varchar(25),
	@description varchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [GradingClass] (
		Abbreviation,
		Name,
		Description
	)
	VALUES (
		@abbreviation,
		@name,
		@description
	)
	SET @ID = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[GradingClass.Select]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		George U. Marr
-- Create date: May 15, 2020
-- Description:	Attempts to get an existing GradingClass based on either ID or Abbreviation
-- =============================================
CREATE PROCEDURE [dbo].[GradingClass.Select]
	@ID int,
	@abbreviation varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @ID IS NULL
		BEGIN
			SELECT
				[GradingClass].[ID],
				[GradingClass].[Abbreviation],
				[GradingClass].[Name],
				[GradingClass].[Description]
			FROM [GradingClass] WITH (NOLOCK)
			WHERE [GradingClass].[Abbreviation] = @abbreviation
		END
	ELSE
		BEGIN
			SELECT
				[GradingClass].[ID],
				[GradingClass].[Abbreviation],
				[GradingClass].[Name],
				[GradingClass].[Description]
			FROM [GradingClass] WITH (NOLOCK)
			WHERE [GradingClass].[ID] = @ID
		END
END
GO
/****** Object:  StoredProcedure [dbo].[Manufacturer.Insert]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 7, 2020
-- Description:	Inserts a new Manufacturer into the database
-- =============================================
CREATE PROCEDURE [dbo].[Manufacturer.Insert]
	@ID int OUTPUT,
	@name varchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [manufacturer] (Name)
	VALUES (@name)
	SET @ID = SCOPE_IDENTITY()

END
GO
/****** Object:  StoredProcedure [dbo].[Manufacturer.Select]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 7, 2020
-- Description:	Attempts to get an existing Manufacturer based on either ID or Name
-- =============================================
CREATE PROCEDURE [dbo].[Manufacturer.Select]
	@ID int,
	@name varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @ID IS NULL
		BEGIN
		SELECT [manufacturer].[ID],
			[manufacturer].[Name]
		FROM [manufacturer] WITH (NOLOCK)
		WHERE [manufacturer].[Name] = @Name
		END
	ELSE
		BEGIN
		SELECT [manufacturer].[ID],
			[manufacturer].[Name]
		FROM [manufacturer] WITH (NOLOCK)
		WHERE [manufacturer].[ID] = @ID
		END
END
GO
/****** Object:  StoredProcedure [dbo].[PlayerPosition.Insert]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 8, 2020
-- Description:	Inserts a new PlayerPosition into the database
-- =============================================
CREATE PROCEDURE [dbo].[PlayerPosition.Insert]
	@ID int OUTPUT,
	@abbreviation varchar(5),
	@name varchar(25)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [playerposition] (
		Abbreviation,
		Name
	)
	VALUES (
		@abbreviation,
		@name
	)
	SET @ID = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[PlayerPosition.Select]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 8, 2020
-- Description:	Attempts to get an existing PlayerPosition based on either ID or by Abbreviation
-- Note: Retrieving by Abbreviation alone may not be reliable after expanding to other sports, so we may need to take that into factor down the road
-- =============================================
CREATE PROCEDURE [dbo].[PlayerPosition.Select]
	@ID int,
	@abbreviation varchar(5)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @ID IS NULL
		BEGIN
			SELECT
				[playerposition].[ID],
				[playerposition].[Abbreviation],
				[playerposition].[Name]
			FROM [playerposition] WITH (NOLOCK)
			WHERE [playerposition].[Abbreviation] = @abbreviation
		END
	ELSE
		BEGIN
			SELECT
				[playerposition].[ID],
				[playerposition].[Abbreviation],
				[playerposition].[Name]
			FROM [playerposition] WITH (NOLOCK)
			WHERE [playerposition].[ID] = @ID
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SingleCard.Insert]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		George U. Marr
-- Create date: May 15, 2020
-- Description:	Inserts a new SingleCard into the database
-- =============================================
CREATE PROCEDURE [dbo].[SingleCard.Insert]
	@ID varchar(10),
	@sellPrice decimal(8,2),
	@cost decimal(8,2),
	@priceSoldFor decimal(8,2),
	@rarity varchar(100),
	@status varchar(100),
	@comments varchar(1000),
	@card_ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [SingleCard] (
		ID,
		SellPrice,
		Cost,
		PriceSoldFor,
		Rarity,
		Status,
		Comments,
		Card_ID
	)
	VALUES (
		@ID,
		@sellPrice,
		@cost,
		@priceSoldFor,
		@rarity,
		@status,
		@comments,
		@card_ID
	)
	SET @ID = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[SingleCardGrading.Insert]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 15, 2020
-- Description:	Inserts a new SingleCardGrading into the database
-- =============================================
CREATE PROCEDURE [dbo].[SingleCardGrading.Insert]
	@ID int OUTPUT,
	@edges tinyint,
	@surfaces tinyint,
	@corners tinyint,
	@alignment tinyint,
	@overallGrade decimal(4,2),
	@BCG_SerialNumber varchar(75),
	@BCG_Grade decimal(4,2),
	@gradingClass_ID int,
	@singleCard_ID varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [SingleCardGrading] (
		Edges,
		Surfaces,
		Corners,
		Alignment,
		OverallGrade,
		BCG_SerialNumber,
		BCG_Grade,
		GradingClass_ID,
		SingleCard_ID
	)
	VALUES (
		@edges,
		@surfaces,
		@corners,
		@alignment,
		@overallGrade,
		@BCG_SerialNumber,
		@BCG_Grade,
		@gradingClass_ID,
		@singleCard_ID
	)
	SET @ID = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[Subset.Insert]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 8, 2020
-- Description:	Inserts a new Subset into the database
-- =============================================
CREATE PROCEDURE [dbo].[Subset.Insert]
	@ID int OUTPUT,
	@name varchar(50),
	@size smallint,
	@gradingModifier decimal(5,2),
	@cardSet_ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [subset] (
		Name,
		Size,
		GradingModifier,
		CardSet_ID
	)
	VALUES (
		@name,
		@size,
		@gradingModifier,
		@cardSet_ID
	)
	SET @ID = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[Subset.Select]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 8, 2020
-- Description:	Attempts to get an existing Subset based on either ID or by Name and CardSet_ID
-- =============================================
CREATE PROCEDURE [dbo].[Subset.Select]
	@ID int,
	@name varchar(50),
	@cardSet_ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @ID IS NULL
		BEGIN
			SELECT
				[subset].[ID],
				[subset].[Name],
				[subset].[Size],
				[subset].[GradingModifier],
				[subset].[CardSet_ID]
			FROM [subset] WITH (NOLOCK)
			WHERE [subset].[Name] = @name
			AND [subset].[CardSet_ID] = @cardSet_ID
		END
	ELSE
		BEGIN
			SELECT
				[subset].[ID],
				[subset].[Name],
				[subset].[Size],
				[subset].[GradingModifier],
				[subset].[CardSet_ID]
			FROM [subset] WITH (NOLOCK)
			WHERE [subset].[ID] = @ID
		END
END
GO
/****** Object:  StoredProcedure [dbo].[Team.Insert]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 7, 2020
-- Description:	Inserts a new Team into the database
-- =============================================
CREATE PROCEDURE [dbo].[Team.Insert]
	@ID int OUTPUT,
	@location varchar(25),
	@name varchar(25),
	@leagueID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [team] (
		Location,
		Name,
		League_ID
	)
	VALUES (
		@location,
		@name,
		@leagueID
	)
	SET @ID = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[Team.Select]    Script Date: 2020-05-27 4:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George U. Marr
-- Create date: May 7, 2020
-- Description:	Attempts to get an existing Team based on either ID or by Name
-- Note: Retrieving by Name alone is not reliable and should take League into consideration down the road
-- =============================================
CREATE PROCEDURE [dbo].[Team.Select]
	@ID int,
	@name varchar(25)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @ID IS NULL
		BEGIN
			SELECT
				[team].[ID],
				[team].[Location],
				[team].[Name],
				[team].[League_ID]
			FROM [team] WITH (NOLOCK)
			WHERE [team].[Name] = @name
		END
	ELSE
		BEGIN
			SELECT
				[team].[ID],
				[team].[Location],
				[team].[Name],
				[team].[League_ID]
			FROM [team] WITH (NOLOCK)
			WHERE [team].[ID] = @ID
		END
END
GO
USE [master]
GO
ALTER DATABASE [GeosTradingCards-DEV] SET  READ_WRITE 
GO
