INSERT INTO [GeosTradingCards].[dbo].[attributes]
	(Abbreviation, FullName, Comments)
	VALUES('RC', 'Rookie Card', 'This card has been determined to be a rookie card through card appraisal sources such as Beckett')
GO

INSERT INTO [GeosTradingCards].[dbo].[sport]
	(Name)
	VALUES('Hockey')
GO

INSERT INTO [GeosTradingCards].[dbo].[league] 
	(Abbreviation, Name, Sport_ID)
	VALUES('NHL', 'National Hockey League', SCOPE_IDENTITY());
GO