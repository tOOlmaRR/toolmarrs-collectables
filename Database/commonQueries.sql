-- select *
SELECT * FROM `tsc2020-dev`.manufacturer;
SELECT * FROM `tsc2020-dev`.cardset;
SELECT * FROM `tsc2020-dev`.card;
SELECT * FROM `tsc2020-dev`.card_has_attributes;
SELECT * FROM `tsc2020-dev`.attributes;
SELECT * FROM `tsc2020-dev`.playerposition;
SELECT * FROM `tsc2020-dev`.team;
SELECT * FROM `tsc2020-dev`.cardvalue;
SELECT * FROM `tsc2020-dev`.subset;
SELECT * FROM `tsc2020-dev`.singlecard;
SELECT * FROM `tsc2020-dev`.singlecardgrading;
SELECT * FROM `tsc2020-dev`.gradingclass;

-- delete *
delete from `tsc2020-dev`.card_has_attributes where Card_ID < 1000;
delete from `tsc2020-dev`.attributes where ID > 1;
delete from `tsc2020-dev`.team where ID >= 1;
delete from `tsc2020-dev`.playerposition where ID >= 1;
delete from `tsc2020-dev`.cardvalue where ID >= 1;
delete from `tsc2020-dev`.subset where ID >= 1;
delete from `tsc2020-dev`.singlecardgrading where ID >= 1;
delete from `tsc2020-dev`.gradingclass where ID >= 1;
delete from `tsc2020-dev`.singlecard where ID <> '';
delete from `tsc2020-dev`.card where id < 1000;
delete from `tsc2020-dev`.cardset where id < 10;
delete from `tsc2020-dev`.manufacturer where id < 10;


-- reset autoincrement index
alter table `tsc2020-dev`.attributes AUTO_INCREMENT = 2;
alter table `tsc2020-dev`.team AUTO_INCREMENT = 1;
alter table `tsc2020-dev`.playerposition AUTO_INCREMENT = 1;
alter table `tsc2020-dev`.cardvalue AUTO_INCREMENT = 1;
alter table `tsc2020-dev`.card AUTO_INCREMENT = 1;
alter table `tsc2020-dev`.manufacturer AUTO_INCREMENT = 1;
alter table `tsc2020-dev`.cardset AUTO_INCREMENT = 1;
alter table `tsc2020-dev`.subset AUTO_INCREMENT = 1;
alter table `tsc2020-dev`.gradingclass AUTO_INCREMENT = 1;
alter table `tsc2020-dev`.singlecardgrading AUTO_INCREMENT = 1;

-- card set details
select set.Season, manufacturer.Name as `Manufacturer`, set.BaseSetName, set.InsertSetName, set.FullName, set.Size, set.Rarity, set.GradingModifier, set.Comments, set.LastInventoryCheck
from `tsc2020-dev`.`cardset` as `set`
left join `tsc2020-dev`.`manufacturer` as `manufacturer` on `set`.`Manufacturer_ID` = `manufacturer`.ID
order by season;

-- cards grid
select CAST(Card.CardNumber AS UNSIGNED) as `CardNumber`, Card.Title, Attributes.Abbreviation as `Attributes`, Team.Name, Position.Abbreviation as `Position`, 
	Value.LowValue, Value.HighValue, Subset.Name as `Subset`, Card.GradingModifier, Value.LastAppraisal, Value.LastAppraisalSource
from `tsc2020-dev`.`card` as `Card`
left join `tsc2020-dev`.`card_has_attributes` as `CardAttributes` on CardAttributes.Card_ID = card.ID
left join `tsc2020-dev`.`attributes` as `Attributes` on Attributes.ID = cardAttributes.Attributes_ID
left join `tsc2020-dev`.`team` as `Team` on Team.ID = card.Team_ID
left join `tsc2020-dev`.`playerposition` as `Position` on Position.ID = card.PlayerPosition_ID
left join `tsc2020-dev`.`cardvalue` as `Value` on Value.Card_ID = card.ID
left join `tsc2020-dev`.`subset` as `Subset` on Subset.ID = card.Subset_ID
where card.CardSet_ID = 1
order by card.CardNumber;

-- single cards grid
select Single.ID, Single.SellPrice, Single.Cost, Single.PriceSoldFor, Single.Rarity, Single.Comments, Condition.Abbreviation
from `tsc2020-dev`.`singlecard` as `Single`
left join `tsc2020-dev`.`singlecardgrading` as `Grading` on Grading.SingleCard_ID = single.ID
left join `tsc2020-dev`.`gradingclass` as `Condition` on Condition.ID = grading.GradingClass_ID
where single.Card_ID = 1
order by ID;

