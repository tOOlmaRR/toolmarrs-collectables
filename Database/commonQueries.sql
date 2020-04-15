-- select *
SELECT * FROM `tsc2020-dev`.manufacturer;
SELECT * FROM `tsc2020-dev`.cardset;
SELECT * FROM `tsc2020-dev`.card;
SELECT * FROM `tsc2020-dev`.card_has_attributes;
SELECT * FROM `tsc2020-dev`.attributes;
SELECT * FROM `tsc2020-dev`.team;

-- delete *
delete from `tsc2020-dev`.card_has_attributes where Card_ID < 1000;
delete from `tsc2020-dev`.attributes where ID > 1;
delete from `tsc2020-dev`.team where ID > 1;
delete from `tsc2020-dev`.card where id < 1000;
delete from `tsc2020-dev`.cardset where id < 10;
delete from `tsc2020-dev`.manufacturer where id < 10;


-- reset autoincrement index
alter table `tsc2020-dev`.attributes AUTO_INCREMENT = 2;
alter table `tsc2020-dev`.team AUTO_INCREMENT = 1;
alter table `tsc2020-dev`.card AUTO_INCREMENT = 1;
alter table `tsc2020-dev`.manufacturer AUTO_INCREMENT = 1;
alter table `tsc2020-dev`.cardset AUTO_INCREMENT = 1;

-- card set details
select set.Season, manufacturer.Name as `Manufacturer`, set.BaseSetName, set.InsertSetName, set.FullName, set.Size, set.Rarity, set.GradingModifier, set.Comments, set.LastInventoryCheck
from `tsc2020-dev`.`cardset` as `set`
left join `tsc2020-dev`.`manufacturer` as `manufacturer` on `set`.`Manufacturer_ID` = `manufacturer`.ID
order by season;

-- cards grid
select CAST(card.CardNumber AS UNSIGNED) as cardNumber, card.Title, attributes.Abbreviation as Attributes, team.Name, position.Abbreviation as position, 
	value.LowValue, value.HighValue, subset.Name as Subset, card.GradingModifier, value.LastAppraisal, value.LastAppraisalSource
from `tsc2020-dev`.`card` as card
left join `tsc2020-dev`.`card_has_attributes` as `cardAttributes` on cardAttributes.Card_ID = card.ID
left join `tsc2020-dev`.`attributes` as attributes on attributes.ID = cardAttributes.Attributes_ID
left join `tsc2020-dev`.`team` as team on team.ID = card.Team_ID
left join `tsc2020-dev`.`playerposition` as position on position.ID = card.PlayerPosition_ID
left join `tsc2020-dev`.`cardvalue` as `value` on value.Card_ID = card.ID
left join `tsc2020-dev`.`subset` as subset on subset.ID = card.Subset_ID
where card.CardSet_ID = 1
order by card.CardNumber;

-- single cards grid
select single.ID, single.SellPrice, single.Cost, single.PriceSoldFor, single.Rarity, single.Comments, condition.Abbreviation
from `tsc2020-dev`.`singlecard` as single
left join `tsc2020-dev`.`singlecardgrading` as grading on grading.SingleCard_ID = single.ID
left join `tsc2020-dev`.`gradingclass` as `condition` on condition.ID = grading.GradingClass_ID
where single.Card_ID = 1
order by ID;

