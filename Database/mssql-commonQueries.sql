-- select *
SELECT * FROM [GeosTradingCards].[dbo].[manufacturer];
SELECT * FROM [GeosTradingCards].[dbo].[cardset];
SELECT * FROM [GeosTradingCards].[dbo].[card];
SELECT * FROM [GeosTradingCards].[dbo].[card_has_attributes];
SELECT * FROM [GeosTradingCards].[dbo].[attributes];
SELECT * FROM [GeosTradingCards].[dbo].[playerposition];
SELECT * FROM [GeosTradingCards].[dbo].[team];
SELECT * FROM [GeosTradingCards].[dbo].[cardvalue];
SELECT * FROM [GeosTradingCards].[dbo].[subset];
SELECT * FROM [GeosTradingCards].[dbo].[singlecard];
SELECT * FROM [GeosTradingCards].[dbo].[singlecardgrading];
SELECT * FROM [GeosTradingCards].[dbo].[gradingclass];

-- delete *
delete from [GeosTradingCards].[dbo].[card_has_attributes] where Card_ID < 1000;
delete from [GeosTradingCards].[dbo].[attributes] where ID > 1;
delete from [GeosTradingCards].[dbo].[cardvalue] where ID >= 1;
delete from [GeosTradingCards].[dbo].[singlecardgrading] where ID >= 1;
delete from [GeosTradingCards].[dbo].[gradingclass] where ID >= 1;
delete from [GeosTradingCards].[dbo].[singlecard] where ID <> '';
delete from [GeosTradingCards].[dbo].[card] where id < 1000;
delete from [GeosTradingCards].[dbo].[subset] where ID >= 1;
delete from [GeosTradingCards].[dbo].[team] where ID >= 1;
delete from [GeosTradingCards].[dbo].[playerposition] where ID >= 1;
delete from [GeosTradingCards].[dbo].[cardset] where id < 10;
delete from [GeosTradingCards].[dbo].[manufacturer] where id < 10;

-- reset autoincrement indexes
DBCC CHECKIDENT([attributes], RESEED, 2)
DBCC CHECKIDENT([team], RESEED, 1)
DBCC CHECKIDENT([playerposition], RESEED, 1)
DBCC CHECKIDENT([cardvalue], RESEED, 1)
DBCC CHECKIDENT([card], RESEED, 1)
DBCC CHECKIDENT([manufacturer], RESEED, 1)
DBCC CHECKIDENT([cardset], RESEED, 1)
DBCC CHECKIDENT([subset], RESEED, 1)
DBCC CHECKIDENT([gradingclass], RESEED, 1)
DBCC CHECKIDENT([singlecardgrading], RESEED, 1)

-- card set details
select [cardset].Season, manufacturer.Name, [cardset].BaseSetName, [cardset].InsertSetName, [cardset].FullName, [cardset].Size, [cardset].Rarity,
	[cardset].GradingModifier, [cardset].Comments, [cardset].LastInventoryCheck
from [GeosTradingCards].[dbo].[cardset] with (nolock)
left join [GeosTradingCards].[dbo].[manufacturer] with (nolock)
on cardset.[Manufacturer_ID] = [manufacturer].ID
order by season

-- cards grid STOPPED HERE
select [card].CardNumber, [card].Title, Attributes.Abbreviation, [team].Name, [playerposition].Abbreviation, [cardvalue].LowValue, [cardvalue].HighValue, Subset.Name, Card.GradingModifier, 
	[cardvalue].LastAppraisal, [cardvalue].LastAppraisalSource
from [GeosTradingCards].[dbo].[card] with (nolock)
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

