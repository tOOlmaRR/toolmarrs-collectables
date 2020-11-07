-- which database are we connecting to?
use [GeosTradingCards-DEV]
--use [GeosTradingCards]
--use [tsc2020]

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
SELECT * FROM [dbo].[league];
SELECT * FROM [dbo].[sport];

-- delete *
--delete from [dbo].[card_has_attributes] where Card_ID < 1000;
--delete from [dbo].[attributes] where ID < 10;
--delete from [dbo].[cardvalue] where ID >= 1;
--delete from [dbo].[singlecardgrading] where ID >= 1;
--delete from [dbo].[gradingclass] where ID >= 1;
--delete from [dbo].[singlecard] where ID <> '';
--delete from [dbo].[card] where id < 1000;
--delete from [dbo].[subset] where ID >= 1;
--delete from [dbo].[team] where ID >= 1;
--delete from [dbo].[playerposition] where ID >= 1;
--delete from [dbo].[cardset] where id < 1000;
--delete from [dbo].[manufacturer] where id < 1000;

-- delete an empty card
--delete from [dbo].[cardvalue] where Card_ID = 16
--delete from [dbo].[singlecard] where singlecard.Card_ID = 16 and singlecard.ID = ''
--delete from [dbo].[card] where card.ID = 16

-- use transactions!
--begin transaction t1
--commit transaction t1
--rollback transaction t1

-- reset autoincrement indexes
--DBCC CHECKIDENT([attributes], RESEED, 1)
--DBCC CHECKIDENT([team], RESEED, 0)
--DBCC CHECKIDENT([playerposition], RESEED, 0)
--DBCC CHECKIDENT([cardvalue], RESEED, 0)
--DBCC CHECKIDENT([card], RESEED, 0)
--DBCC CHECKIDENT([manufacturer], RESEED, 0)
--DBCC CHECKIDENT([cardset], RESEED, 0)
--DBCC CHECKIDENT([subset], RESEED, 0)
--DBCC CHECKIDENT([gradingclass], RESEED, 0)
--DBCC CHECKIDENT([singlecardgrading], RESEED, 0)

-- temporarily stop checking contraints while exporting data
--EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT all'
--EXEC sp_msforeachtable 'ALTER TABLE ? CHECK CONSTRAINT all'

-- card set details
select [cardset].id, [cardset].Season, manufacturer.Name, [cardset].BaseSetName, [cardset].InsertSetName, [cardset].FullName, [cardset].Size, [cardset].Rarity,
	[cardset].GradingModifier, [cardset].Comments, [cardset].LastInventoryCheck
from [dbo].[cardset] with (nolock)
left join [dbo].[manufacturer] with (nolock)
on cardset.[Manufacturer_ID] = [manufacturer].ID
--where cardset.ID > 169
order by id desc
--order by season desc

-- cards grid
select [card].id, [card].CardNumber, [card].Title, Attributes.Abbreviation, [team].Name, [playerposition].Abbreviation, [cardvalue].LowValue, [cardvalue].HighValue, Subset.Name, Card.GradingModifier, 
	[cardvalue].LastAppraisal, [cardvalue].LastAppraisalSource
from [dbo].[card] with (nolock)
left join [card_has_attributes] on [card_has_attributes].Card_ID = [card].ID
left join [attributes] on Attributes.ID = [card_has_attributes].Attributes_ID
left join [team] on Team.ID = [card].Team_ID
left join [playerposition] on [playerposition].ID = [card].PlayerPosition_ID
left join [cardvalue] on [cardvalue].Card_ID = [card].ID
left join [subset] on Subset.ID = [card].Subset_ID
--where card.CardSet_ID > 169
order by card.id

-- single cards grid
select [singlecard].ID, [singlecard].SellPrice, [singlecard].Cost, [singlecard].PriceSoldFor, [singlecard].Rarity, [singlecard].Comments, [gradingclass].Abbreviation
from [singlecard]
left join [singlecardgrading] on [singlecardgrading].SingleCard_ID = [singlecard].ID
left join [gradingclass] on [gradingclass].ID = [singlecardgrading].GradingClass_ID
--where [singlecard].Card_ID = 1196
order by ID

-- all cards in Trade 8
select cs.ID as CardSetID, cs.FullName, s.ID, c.CardNumber, c.Title, a.Abbreviation, t.Name, v.HighValue, s.SellPrice, g.Name, ss.Name, cs.Rarity, s.Cost from [singlecard] s
left join [dbo].[card] c on s.Card_ID = c.ID
left join [cardset] cs on c.CardSet_ID = cs.ID
left join [card_has_attributes] cha on cha.Card_ID = c.ID
left join [attributes] a on a.ID = cha.Attributes_ID
left join [team] t on t.ID = c.Team_ID
left join [playerposition] p on p.ID = c.PlayerPosition_ID
left join [cardvalue] v on v.Card_ID = c.ID
left join [subset] ss on ss.ID = c.Subset_ID
left join singlecardgrading scg on scg.SingleCard_ID = s.ID
left join gradingclass g on g.ID = scg.GradingClass_ID
where s.Status = 'Traded - Trade #8'
order by cs.FullName, c.CardNumber

-- Single Card Lookup
select cs.ID as CardSetID, cs.FullName, s.ID, c.CardNumber, c.Title, a.Abbreviation, t.Name, v.HighValue, s.SellPrice, g.Name, ss.Name, cs.Rarity, s.Cost from [singlecard] s
left join [dbo].[card] c on s.Card_ID = c.ID
left join [cardset] cs on c.CardSet_ID = cs.ID
left join [card_has_attributes] cha on cha.Card_ID = c.ID
left join [attributes] a on a.ID = cha.Attributes_ID
left join [team] t on t.ID = c.Team_ID
left join [playerposition] p on p.ID = c.PlayerPosition_ID
left join [cardvalue] v on v.Card_ID = c.ID
left join [subset] ss on ss.ID = c.Subset_ID
left join singlecardgrading scg on scg.SingleCard_ID = s.ID
left join gradingclass g on g.ID = scg.GradingClass_ID
where s.ID > '0004254'

-- update a singleID
select * from singlecard where ID = '0004265'
select * from singlecardgrading where SingleCard_ID = '0004265'
ALTER TABLE singlecardgrading NOCHECK CONSTRAINT FK_singlecardgrading_singlecard
update singlecardgrading set SingleCard_ID = '0004265' where SingleCard_ID = '4265'
update singlecard set ID = '0004265' where id = '4265'
ALTER TABLE singlecardgrading WITH CHECK CHECK CONSTRAINT FK_singlecardgrading_singlecard

SELECT DISTINCT cs.Season 
FROM cardset cs WITH (NOLOCK) 
INNER JOIN sport s WITH (NOLOCK) 
	ON cs.Sport_ID = s.ID 
	AND s.Name = 'hockey' 
ORDER BY cs.Season ASC