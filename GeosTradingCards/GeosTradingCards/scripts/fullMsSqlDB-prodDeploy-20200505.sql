USE [master]
GO
/****** Object:  Database [tsc2020]    Script Date: 2020-05-05 10:04:52 AM ******/
ALTER DATABASE [tsc2020] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [tsc2020].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [tsc2020] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [tsc2020] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [tsc2020] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [tsc2020] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [tsc2020] SET ARITHABORT OFF 
GO
ALTER DATABASE [tsc2020] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [tsc2020] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [tsc2020] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [tsc2020] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [tsc2020] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [tsc2020] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [tsc2020] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [tsc2020] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [tsc2020] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [tsc2020] SET  DISABLE_BROKER 
GO
ALTER DATABASE [tsc2020] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [tsc2020] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [tsc2020] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [tsc2020] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [tsc2020] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [tsc2020] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [tsc2020] SET  MULTI_USER 
GO
ALTER DATABASE [tsc2020] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [tsc2020] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [tsc2020] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [tsc2020] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [tsc2020] SET QUERY_STORE = OFF
GO
USE [tsc2020]
GO
/****** Object:  Table [dbo].[attributes]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[card]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[card_has_attributes]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[cardset]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[cardvalue]    Script Date: 2020-05-05 10:04:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cardvalue](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LowValue] [money] NULL,
	[HighValue] [money] NULL,
	[LastAppraisal] [datetime] NULL,
	[LastAppraisalSource] [varchar](100) NULL,
	[Card_ID] [int] NOT NULL,
 CONSTRAINT [PK_BookValue] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Error]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[Exceptions]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[GoogleDocsPages]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[gradingclass]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[league]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[manufacturer]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[playerposition]    Script Date: 2020-05-05 10:04:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[playerposition](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Abbreviation] [varchar](5) NULL,
	[lName] [varchar](25) NULL,
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[singlecard]    Script Date: 2020-05-05 10:04:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[singlecard](
	[ID] [varchar](10) NOT NULL,
	[SellPrice] [money] NULL,
	[Cost] [money] NULL,
	[PriceSoldFor] [money] NULL,
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
/****** Object:  Table [dbo].[singlecardgrading]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[sport]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[subset]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  Table [dbo].[team]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GoogleDocs.SelectAll]    Script Date: 2020-05-05 10:04:53 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GoogleDocs.SelectRowByID]    Script Date: 2020-05-05 10:04:53 AM ******/
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
ALTER DATABASE [tsc2020] SET  READ_WRITE 
GO
