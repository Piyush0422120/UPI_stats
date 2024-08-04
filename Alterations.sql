ALTER TABLE `upi_stats`.`stats` 
CHANGE COLUMN `ï»¿Sr. No.` `Serial_No` INT NOT NULL ,
CHANGE COLUMN `Entity Name` `Entity_name` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `Volume (AS a Sender)` `Volume_in_lakh_sent` DOUBLE NULL DEFAULT NULL ,
CHANGE COLUMN `Value (As a sender)` `Value_in_crores_sent` DOUBLE NULL DEFAULT NULL ,
CHANGE COLUMN `Volume(as a reciver)` `Volume_in_lakh_recieved` DOUBLE NULL DEFAULT NULL ,
CHANGE COLUMN `Value (as a reciver)` `Value_in_crores_recieved` DOUBLE NULL DEFAULT NULL ,
ADD PRIMARY KEY (`Serial_No`);
USE upi_stats;
DELETE FROM stats
WHERE Entity_name='Total';