USE [GeosTradingCards]
GO

/****** Object:  StoredProcedure [dbo].[CardSet.Insert]    Script Date: 2020-10-20 8:24:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		George U. Marr
-- Create date: May 7, 2020
-- Updates:		Oct. 20, 2020 (added Sport_Id to parameters and insert statement)
-- Description:	Inserts a new CardSet into the database
-- =============================================
ALTER PROCEDURE [dbo].[CardSet.Insert]
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
	@manufacturer_ID int,
	@sport_ID int
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
		Manufacturer_ID,
		Sport_ID
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
		@manufacturer_ID,
		@sport_ID
	)
	SET @ID = SCOPE_IDENTITY()
END
GO


