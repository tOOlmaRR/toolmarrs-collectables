USE [GeosTradingCards-DEV]
GO

-- Add FK column and constraint to link up Card table to the Sport table (0-to-many)
ALTER TABLE card
	ADD Sport_ID INT NULL
GO
ALTER TABLE [dbo].[card]  WITH CHECK ADD  CONSTRAINT [FK_card_sport] FOREIGN KEY([Sport_ID])
REFERENCES [dbo].[sport] ([ID])
GO

-- update all cards currently in the DB to be "Hockey"
UPDATE card SET Sport_Id = 1
GO

-- Add FK column and constraint to link up Cardset table to the Sport table (0-to-many)
ALTER TABLE cardset
	ADD Sport_ID INT NULL
GO
ALTER TABLE [dbo].[cardset]  WITH CHECK ADD  CONSTRAINT [FK_cardset_sport] FOREIGN KEY([Sport_ID])
REFERENCES [dbo].[sport] ([ID])
GO

-- update all cardsets currently in the DB to be "Hockey"
UPDATE cardset SET Sport_Id = 1
GO

-- now update both FK columns to be NOT NULL now that all records have a value
ALTER TABLE card
	ALTER COLUMN Sport_ID INT NOT NULL
GO
ALTER TABLE cardset
	ALTER COLUMN Sport_ID INT NOT NULL
GO