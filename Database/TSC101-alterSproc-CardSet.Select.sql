USE [GeosTradingCards]
GO

/****** Object:  StoredProcedure [dbo].[CardSet.Select]    Script Date: 2020-10-20 8:16:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		George U. Marr
-- Create date: May 7, 2020
-- Updates:		Oct. 20, 2020 (added Sport_Id to select and where clauses)
-- Description:	Attempts to get an existing CardSet based on either ID or a combination of BaseSetName, InsertSetName, Season, and Sport ID
-- =============================================
ALTER PROCEDURE [dbo].[CardSet.Select]
	@ID int,
	@baseSetName varchar(100),
	@insertSetName varchar(100),
	@season char(7),
	@sport_ID int
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
				[cardset].[Manufacturer_ID],
				[cardset].[Sport_ID]
			FROM [cardset] WITH (NOLOCK)
			WHERE [cardset].[BaseSetName] = @baseSetName
			AND [cardset].[InsertSetName] = @insertSetName
			AND [cardset].[Season] = @season
			AND [cardset].[Sport_ID] = @sport_ID
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
				[cardset].[Manufacturer_ID],
				[cardset].[Sport_ID]
			FROM [cardset] WITH (NOLOCK)
			WHERE [cardset].[ID] = @ID
		END
END
GO


