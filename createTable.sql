CREATE SCHEMA `cse` ;

CREATE TABLE `cse`.`profession` (
  `Pid` INT NOT NULL AUTO_INCREMENT,
  `ProfessionName` VARCHAR(45) NULL,
  PRIMARY KEY (`Pid`));
  
ALTER TABLE `cse`.`profession` 
ADD COLUMN `DeprecatedFlag` TINYINT NULL AFTER `ProfessionName`;

CREATE TABLE `cse`.`user` (
  `Uid` INT NOT NULL AUTO_INCREMENT,
  `UserCode` VARCHAR(45) NULL,
  `UserPass` VARCHAR(45) NULL,
  `UserName` VARCHAR(45) NULL,
  `Grade` VARCHAR(45) NULL,
  `Profession` VARCHAR(45) NULL,
  `Sex` VARCHAR(45) NULL,
  `UserModel` JSON NULL,
  `DeprecatedFlag` TINYINT NULL,
  PRIMARY KEY (`Uid`));

ALTER TABLE `cse`.`user` 
CHANGE COLUMN `Profession` `Profession` INT NULL DEFAULT NULL ,
ADD INDEX `Profession_idx` (`Profession` ASC) VISIBLE;
;
ALTER TABLE `cse`.`user` 
ADD CONSTRAINT `Profession`
  FOREIGN KEY (`Profession`)
  REFERENCES `cse`.`profession` (`Pid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  CREATE TABLE `cse`.`hobby` (
  `Hid` INT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(45) NULL,
  `Name` VARCHAR(45) NULL,
  `Type` VARCHAR(45) NULL,
  `HobbyModel` JSON NULL,
  `DeprecatedFlag` TINYINT NULL,
  PRIMARY KEY (`Hid`));
  
  CREATE TABLE `cse`.`user_hobby` (
  `Uid` INT NOT NULL,
  `Hid` INT NOT NULL,
  PRIMARY KEY (`Uid`, `Hid`));
  
  ALTER TABLE `cse`.`user_hobby` 
ADD INDEX `user_hobby_hid_idx` (`Hid` ASC) VISIBLE;
;
ALTER TABLE `cse`.`user_hobby` 
ADD CONSTRAINT `user_hobby_hid`
  FOREIGN KEY (`Hid`)
  REFERENCES `cse`.`hobby` (`Hid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `cse`.`user_hobby` 
ADD CONSTRAINT `user_hobby_uid`
  FOREIGN KEY (`Uid`)
  REFERENCES `cse`.`user` (`Uid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `cse`.`message` (
  `Mid` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(45) NULL,
  `ReleaseTime` DATETIME NULL,
  `OutTime` DATETIME NULL,
  `Visual` JSON NULL,
  `message` JSON NULL,
  PRIMARY KEY (`Mid`));
  
CREATE TABLE `cse`.`surf` (
  `Time` DATETIME NOT NULL,
  `Uid` INT NOT NULL,
  `Mid` INT NOT NULL,
  PRIMARY KEY (`Time`, `Uid`, `Mid` ),
  CONSTRAINT `surf_message`
    FOREIGN KEY (`Mid`)
    REFERENCES `cse`.`message` (`Mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `surf_user`
    FOREIGN KEY (`Uid`)
    REFERENCES `cse`.`user` (`Uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

 CREATE TABLE `cse`.`keywordtype` (
  `Tid` INT NOT NULL,
  `TypeName` VARCHAR(45) NULL,
  `TypeResume` VARCHAR(100) NULL,
  PRIMARY KEY (`Tid`));

ALTER TABLE `cse`.`keywordtype` 
CHANGE COLUMN `Tid` `Tid` INT NOT NULL AUTO_INCREMENT ;

CREATE TABLE `cse`.`keyword` (
  `Kid` INT NOT NULL AUTO_INCREMENT,
  `KeyName` VARCHAR(45) NULL,
  `KeywordType` INT NULL,
  `KeyResume` VARCHAR(45) NULL,
  PRIMARY KEY (`Kid`));
  
  ALTER TABLE `cse`.`keyword` 
ADD INDEX `KeyWordType_idx` (`KeywordType` ASC) VISIBLE;
;
ALTER TABLE `cse`.`keyword` 
ADD CONSTRAINT `KeyWordType`
  FOREIGN KEY (`KeywordType`)
  REFERENCES `cse`.`keywordtype` (`Tid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `cse`.`map` (
  `Mid` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Resume` VARCHAR(100) NULL,
  `Href` VARCHAR(100) NULL,
  PRIMARY KEY (`Mid`));

CREATE TABLE `cse`.`location` (
  `Lid` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Resume` VARCHAR(45) NULL,
  `Ability` JSON NULL,
  `MapBelong` INT NULL,
  `MapOwn` INT NULL,
  PRIMARY KEY (`Lid`),
  INDEX `LocationToMap_idx` (`MapBelong` ASC) VISIBLE,
  INDEX `LocationOwnMap_idx` (`MapOwn` ASC) VISIBLE,
  CONSTRAINT `LocationToMap`
    FOREIGN KEY (`MapBelong`)
    REFERENCES `cse`.`map` (`Mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `LocationOwnMap`
    FOREIGN KEY (`MapOwn`)
    REFERENCES `cse`.`map` (`Mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `cse`.`lesson` (
  `Lid` INT NOT NULL AUTO_INCREMENT,
  `BasicMessage` INT NULL,
  `Name` VARCHAR(45) NULL,
  `Resume` JSON NULL,
  `DeprecateFlag` TINYINT NULL,
  `Location` INT NULL,
  `Profession` INT NULL,
  `Teacher` INT NULL,
  `LessonScore` INT NULL,
  PRIMARY KEY (`Lid`),
  INDEX `LessonToLessonScore_idx` ( `LessonScore` ASC) VISIBLE,
  INDEX `LessonToTeacher_idx` (`Teacher` ASC) VISIBLE,
  INDEX `LessonToProfession_idx` (`Profession` ASC) VISIBLE,
  CONSTRAINT `LessonToTeacher`
    FOREIGN KEY (`Teacher`)
    REFERENCES `cse`.`keyword` (`Kid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
   CONSTRAINT `LessonToLessonScore`
    FOREIGN KEY (`LessonScore`)
    REFERENCES `cse`.`keyword` (`Kid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `LessonToLccation`
    FOREIGN KEY (`Location`)
    REFERENCES `cse`.`location` (`Lid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `LessonToProfession`
    FOREIGN KEY (`Profession`)
    REFERENCES `cse`.`profession` (`Pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `LessonToMessage`
    FOREIGN KEY (`BasicMessage`)
    REFERENCES `cse`.`message` (`Mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `cse`.`section` (
  `Sid` INT NOT NULL AUTO_INCREMENT,
  `BasicMessage` INT NULL,
  `Name` VARCHAR(100) NULL,
  `Resume` VARCHAR(100) NULL,
  `DeprecateFlag` TINYINT NULL,
  PRIMARY KEY (`Sid`),
  `Location` INT NULL,
  `Profession` INT NULL,
  CONSTRAINT `SectionToLccation`
    FOREIGN KEY (`Location`)
    REFERENCES `cse`.`location` (`Lid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
   CONSTRAINT `SectionToProfession`
    FOREIGN KEY (`Profession`)
    REFERENCES `cse`.`profession` (`Pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION   );

CREATE TABLE `cse`.`contest` (
  `Cid` INT NOT NULL AUTO_INCREMENT,
  `BasicMessage` INT NULL,
  `Name` VARCHAR(100) NULL,
  `Resume` VARCHAR(100) NULL,
  `DeprecateFlag` TINYINT NULL,
  `profession` INT NULL,
  `level` INT NULL,
  PRIMARY KEY (`Cid`),
  INDEX `ContestToProfession_idx` (`profession` ASC) VISIBLE,
  INDEX `ContestToLevel_idx` (`level` ASC) VISIBLE,
  CONSTRAINT `ContestToProfession`
    FOREIGN KEY (`profession`)
    REFERENCES `cse`.`profession` (`Pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ContestToLevel`
    FOREIGN KEY (`level`)
    REFERENCES `cse`.`keyword` (`Kid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `cse`.`resource` (
  `Rid` INT NOT NULL AUTO_INCREMENT,
  `BasicMessage` INT NULL,
  `Name` VARCHAR(100) NULL,
  `Resume` VARCHAR(100) NULL,
  `DeprecateFlag` TINYINT NULL,
  `Count` INT NULL,
  `Popular` INT NULL,
  `Location` INT NULL,
  PRIMARY KEY (`Rid`),
  INDEX `ResourceToPopular_idx` (`Popular` ASC) VISIBLE,
  INDEX `ResourceToCount_idx` (`Count` ASC) VISIBLE,
  CONSTRAINT `ResourceToPopular`
    FOREIGN KEY (`Popular`)
    REFERENCES `cse`.`keyword` (`Kid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ResourceToCount`
    FOREIGN KEY (`Count`)
    REFERENCES `cse`.`keyword` (`Kid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ResourceToLocation`
    FOREIGN KEY (`Location`)
    REFERENCES `cse`.`location` (`Lid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `cse`.`activity` (
  `Aid` INT NOT NULL AUTO_INCREMENT,
  `BasicMessage` INT NULL,
  `Name` VARCHAR(100) NULL,
  `Resume` VARCHAR(100) NULL,
  `DeprecateFlag` TINYINT NULL,
  `Section` INT NULL,
  `Location` INT NULL,
  `Request` INT NULL,
  `ActivtiyScore` INT NULL,
  PRIMARY KEY (`Aid`),
  INDEX `ActivityToSection_idx` (`Section` ASC) VISIBLE,
  INDEX `ActivityToRequest_idx` (`Request` ASC) VISIBLE,
  INDEX `ActivityToActivityScore_idx` (`ActivtiyScore` ASC) VISIBLE,
  CONSTRAINT `ActivityToSection`
    FOREIGN KEY (`Section`)
    REFERENCES `cse`.`section` (`Sid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ActivityToLocation`
    FOREIGN KEY (`Location`)
    REFERENCES `cse`.`location` (`Lid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ActivityToRequest`
    FOREIGN KEY (`Request`)
    REFERENCES `cse`.`keyword` (`Kid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ActivityToActivityScore`
    FOREIGN KEY (`ActivtiyScore`)
    REFERENCES `cse`.`keyword` (`Kid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `cse`.`calender` (
                                  `Uid` INT NOT NULL,
                                  `Time` DATETIME NOT NULL,
                                  `Description` VARCHAR(100) NULL,
                                  `RelationFunction` JSON NULL,
                                  PRIMARY KEY (`Uid`, `Time`));

ALTER TABLE `cse`.`calender`
    ADD CONSTRAINT `CalenderToUser`
        FOREIGN KEY (`Uid`)
            REFERENCES `cse`.`user` (`Uid`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION;

CREATE TABLE `cse`.`classtable` (
                                    `Uid` INT NOT NULL,
                                    `Cid` INT NOT NULL,
                                    `Description` VARCHAR(45) NULL,
                                    `ClassTime` JSON NULL,
                                    PRIMARY KEY (`Uid`,`Cid`),
                                    CONSTRAINT `ClassTableToLesson`
                                        FOREIGN KEY (`Cid`)
                                            REFERENCES `cse`.`lesson` (`Lid`)
                                            ON DELETE NO ACTION
                                            ON UPDATE NO ACTION,
                                    CONSTRAINT `ClassTableToUser`
                                        FOREIGN KEY (`Uid`)
                                            REFERENCES `cse`.`user` (`Uid`)
                                            ON DELETE NO ACTION
                                            ON UPDATE NO ACTION);

CREATE TABLE `cse`.`resourcetable` (
                                       `Uid` INT NOT NULL,
                                       `Rid` INT NOT NULL,
                                       `Descriptiom` VARCHAR(45) NULL,
                                       `DeprecatedFlag` TINYINT NULL,
                                       PRIMARY KEY (`Uid`, `Rid`),
                                       INDEX `ResourceTableToResource_idx` (`Rid` ASC) VISIBLE,
                                       CONSTRAINT `ResourceTableToResource`
                                           FOREIGN KEY (`Rid`)
                                               REFERENCES `cse`.`resource` (`Rid`)
                                               ON DELETE NO ACTION
                                               ON UPDATE NO ACTION,
                                       CONSTRAINT `ResourceTableToUser`
                                           FOREIGN KEY (`Uid`)
                                               REFERENCES `cse`.`user` (`Uid`)
                                               ON DELETE NO ACTION
                                               ON UPDATE NO ACTION);

ALTER TABLE `cse`.`classtable`
    ADD COLUMN `DeprecatedFlag` TINYINT NULL AFTER `ClassTime`;

ALTER TABLE `cse`.`calender`
    ADD COLUMN `DescrationFlag` TINYINT NULL AFTER `RelationFunction`;
