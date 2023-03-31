USE JokerArchive;

ALTER TABLE `JokerArchive`.`GachaRecord` 
ADD COLUMN `triggeredType` INT NOT NULL DEFAULT '0' AFTER `uid`;
