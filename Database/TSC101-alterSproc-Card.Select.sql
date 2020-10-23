USE [GeosTradingCards]
GO

/****** Object:  StoredProcedure [dbo].[Card.Select]    Script Date: 2020-10-20 8:05:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		George U. Marr
-- Create date: May 7, 2020
-- Updates:		Oct. 20, 2020 (added Sport_Id to select clause and added cardTitle to the parameters list as part of the unique identifier for a card if ID is not available)
-- Description:	Attempts to get an existing Card based on either ID or a combination of CardNumber and CardSet_ID
-- =============================================
ALTER PROCEDURE [dbo].[Card.Select]
	@ID int,
	@cardNumber varchar(10),
	@cardTitle varchar(100),
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
				[card].[PlayerPosition_ID],
				[card].[Sport_ID]
			FROM [card] WITH (NOLOCK)
			WHERE [card].[CardNumber] = @cardNumber
			AND [card].[Title] = @cardTitle
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
				[card].[PlayerPosition_ID],
				[card].[Sport_ID]
			FROM [card] WITH (NOLOCK)
			WHERE [card].[ID] = @ID
		END
END
GO


