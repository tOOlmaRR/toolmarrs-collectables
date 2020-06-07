-- which database are we connecting to?
use [GeosTradingCards]

-- select *
SELECT * FROM [dbo].[manufacturer];
SELECT * FROM [dbo].[cardset];
SELECT * FROM [dbo].[card];
SELECT * FROM [dbo].[card_has_attributes];
SELECT * FROM [dbo].[attributes];
SELECT * FROM [dbo].[playerposition];
SELECT * FROM [dbo].[team];
SELECT * FROM [dbo].[cardvalue];
SELECT * FROM [dbo].[subset];
SELECT * FROM [dbo].[singlecard];
SELECT * FROM [dbo].[singlecardgrading];
SELECT * FROM [dbo].[gradingclass];

-- delete *
delete from [dbo].[card_has_attributes] where Card_ID < 1000;
delete from [dbo].[attributes] where ID > 1;
delete from [dbo].[cardvalue] where ID >= 1;
delete from [dbo].[singlecardgrading] where ID >= 1;
delete from [dbo].[gradingclass] where ID >= 1;
delete from [dbo].[singlecard] where ID <> '';
delete from [dbo].[card] where id < 1000;
delete from [dbo].[subset] where ID >= 1;
delete from [dbo].[team] where ID >= 1;
delete from [dbo].[playerposition] where ID >= 1;
delete from [dbo].[cardset] where id < 10;
delete from [dbo].[manufacturer] where id < 10;

-- reset autoincrement indexes
DBCC CHECKIDENT([attributes], RESEED, 1)
DBCC CHECKIDENT([team], RESEED, 0)
DBCC CHECKIDENT([playerposition], RESEED, 0)
DBCC CHECKIDENT([cardvalue], RESEED, 0)
DBCC CHECKIDENT([card], RESEED, 0)
DBCC CHECKIDENT([manufacturer], RESEED, 0)
DBCC CHECKIDENT([cardset], RESEED, 0)
DBCC CHECKIDENT([subset], RESEED, 0)
DBCC CHECKIDENT([gradingclass], RESEED, 0)
DBCC CHECKIDENT([singlecardgrading], RESEED, 0)

-- card set details
select [cardset].Season, manufacturer.Name, [cardset].BaseSetName, [cardset].InsertSetName, [cardset].FullName, [cardset].Size, [cardset].Rarity,
	[cardset].GradingModifier, [cardset].Comments, [cardset].LastInventoryCheck
from [dbo].[cardset] with (nolock)
left join [dbo].[manufacturer] with (nolock)
on cardset.[Manufacturer_ID] = [manufacturer].ID
order by season

-- cards grid
select [card].CardNumber, [card].Title, Attributes.Abbreviation, [team].Name, [playerposition].Abbreviation, [cardvalue].LowValue, [cardvalue].HighValue, Subset.Name, Card.GradingModifier, 
	[cardvalue].LastAppraisal, [cardvalue].LastAppraisalSource
from [dbo].[card] with (nolock)
left join [GeosTradingCards].[dbo].[card_has_attributes] on [card_has_attributes].Card_ID = [card].ID
left join [GeosTradingCards].[dbo].[attributes] on Attributes.ID = [card_has_attributes].Attributes_ID
left join [GeosTradingCards].[dbo].[team] on Team.ID = [card].Team_ID
left join [GeosTradingCards].[dbo].[playerposition] on [playerposition].ID = [card].PlayerPosition_ID
left join [GeosTradingCards].[dbo].[cardvalue] on [cardvalue].Card_ID = [card].ID
left join [GeosTradingCards].[dbo].[subset] on Subset.ID = [card].Subset_ID
where card.CardSet_ID = 1
order by card.CardNumber

-- single cards grid
select [singlecard].ID, [singlecard].SellPrice, [singlecard].Cost, [singlecard].PriceSoldFor, [singlecard].Rarity, [singlecard].Comments, [gradingclass].Abbreviation
from [GeosTradingCards].[dbo].[singlecard]
left join [GeosTradingCards].[dbo].[singlecardgrading] on [singlecardgrading].SingleCard_ID = [singlecard].ID
left join [GeosTradingCards].[dbo].[gradingclass] on [gradingclass].ID = [singlecardgrading].GradingClass_ID
where [singlecard].Card_ID = 1
order by ID