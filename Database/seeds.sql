INSERT INTO `tsc2020-dev`.`attributes`(`Abbreviation`,`FullName`,`Comments`)
VALUES('RC','Rookie Card','This card has been determined to be a rookie card through card appraisal sources such as Beckett');

INSERT INTO `tsc2020-dev`.`sport`(`Name`)
VALUES('Hockey');

INSERT INTO `tsc2020-dev`.`league`(`Abbreviation`, `Name`, `Sport_ID`)
VALUES('NHL', 'National Hockey League', LAST_INSERT_ID());