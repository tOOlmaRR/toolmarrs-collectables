USE [GeosTradingCards]
GO

/****** Object:  StoredProcedure [dbo].[Card.Insert]    Script Date: 2020-10-20 8:10:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		George U. Marr
-- Create date: May 7, 2020
-- Updates:		Oct. 20, 2020 (added Sport_Id to parameters and insert statement)
-- Description:	Inserts a new Card into the database
-- =============================================
ALTER PROCEDURE [dbo].[Card.Insert]
	@ID int OUTPUT,
	@cardNumber varchar(10),
	@title varchar(100),
	@comments varchar(1000),
	@gradingModifier decimal(5,2),
	@cardSet_ID int,
	@subset_ID int,
	@team_ID int,
	@playerPosition_ID int,
	@sport_ID int
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
		PlayerPosition_ID,
		Sport_ID
	)
	VALUES (
		@cardNumber,
		@title,
		@comments,
		@gradingModifier,
		@cardSet_ID,
		@subset_ID,
		@team_ID,
		@playerPosition_ID,
		@sport_ID
	)
	SET @ID = SCOPE_IDENTITY()
END
GO


