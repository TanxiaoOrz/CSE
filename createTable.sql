CREATE SCHEMA `cse` ;

CREATE TABLE `cse`.`profession` (
    `Pid` INT NOT NULL AUTO_INCREMENT,
    `ProfessionName` VARCHAR(45) NULL,
    `DeprecatedFlag` TINYINT NULL DEFAULT 0,
    PRIMARY KEY (`Pid`)
);

CREATE TABLE `cse`.`user` (
  `Uid` INT NOT NULL AUTO_INCREMENT,
  `UserCode` VARCHAR(45) NULL,
  `UserPass` VARCHAR(45) NULL,
  `UserName` VARCHAR(45) NULL,
  `Grade` VARCHAR(45) NULL,
  `Profession` INT NULL DEFAULT NULL,
  `Sex` VARCHAR(45) NULL,
  `UserModel` JSON NULL,
  `DeprecatedFlag` TINYINT NULL DEFAULT 0,
  INDEX `Profession_idx` (`Profession` ASC) VISIBLE,
  CONSTRAINT `Profession`
      FOREIGN KEY (`Profession`)
          REFERENCES `cse`.`profession` (`Pid`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION,
  PRIMARY KEY (`Uid`));

  CREATE TABLE `cse`.`hobby` (
  `Hid` INT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(45) NULL,
  `Name` VARCHAR(45) NULL,
  `Type` VARCHAR(45) NULL,
  `HobbyModel` JSON NULL,
  `DeprecatedFlag` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`Hid`));
  
CREATE TABLE `cse`.`user_hobby` (
    `Uid` INT NOT NULL,
    `Hid` INT NOT NULL,
    `degree` ENUM('interested', 'common', 'uninterested') NULL DEFAULT 'common',
    PRIMARY KEY (`Uid` , `Hid`),
    INDEX `user_hobby_hid_idx` (`Hid` ASC) VISIBLE,
    CONSTRAINT `user_hobby_hid`
      FOREIGN KEY (`Hid`)
      REFERENCES `cse`.`hobby` (`Hid`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
      CONSTRAINT `user_hobby_uid`
          FOREIGN KEY (`Uid`)
          REFERENCES `cse`.`user` (`Uid`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION
);

CREATE TABLE `cse`.`message` (
  `Mid` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(45) NULL,
  `ReleaseTime` DATETIME NULL,
  `OutTime` DATETIME NULL,
  `Visual` JSON NULL,
  `message` JSON NULL,
  `DeprecatedFlag` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`Mid`));
  
CREATE TABLE `cse`.`surf` (
    `Time` DATETIME NOT NULL,
    `Uid` INT NOT NULL,
    `Mid` INT NOT NULL,
    PRIMARY KEY (`Time` , `Uid` , `Mid`),
    CONSTRAINT `surf_message` FOREIGN KEY (`Mid`)
        REFERENCES `cse`.`message` (`Mid`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `surf_user` FOREIGN KEY (`Uid`)
        REFERENCES `cse`.`user` (`Uid`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `cse`.`keyword_type` (
    `Tid` INT NOT NULL AUTO_INCREMENT,
    `TypeName` VARCHAR(45) NULL,
    `TypeResume` VARCHAR(100) NULL,
    PRIMARY KEY (`Tid`)
);

CREATE TABLE `cse`.`keyword` (
    `Kid` INT NOT NULL AUTO_INCREMENT,
    `KeyName` VARCHAR(45) NULL,
    `KeywordType` INT NULL,
    `KeyResume` VARCHAR(45) NULL,
    PRIMARY KEY (`Kid`),
    INDEX `KeyWordType_idx` (`KeywordType` ASC) VISIBLE,
    CONSTRAINT `KeyWord_Type`
      FOREIGN KEY (`KeywordType`)
      REFERENCES `cse`.`keyword_type` (`Tid`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE `cse`.`map` (
    `Mid` INT NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(45) NULL,
    `Resume` VARCHAR(100) NULL,
    `Href` VARCHAR(100) NULL,
    `DeprecatedFlag` TINYINT NULL DEFAULT 0,
    PRIMARY KEY (`Mid`)
);

CREATE TABLE `cse`.`location` (
  `Lid` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Resume` VARCHAR(45) NULL,
  `Ability` JSON NULL,
  `MapBelong` INT NULL,
  `MapOwn` INT NULL,
  `DeprecatedFlag` TINYINT NULL DEFAULT 0,
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


CREATE TABLE `cse`.`section` (
    `Sid` INT NOT NULL AUTO_INCREMENT,
    `BasicMessage` INT NULL,
    `Name` VARCHAR(100) NULL,
    `Resume` VARCHAR(100) NULL,
    `DeprecatedFlag` TINYINT NULL DEFAULT 0,
    PRIMARY KEY (`Sid`),
    `Location` INT NULL,
    `Profession` INT NULL,
    CONSTRAINT `SectionToLocation` FOREIGN KEY (`Location`)
        REFERENCES `cse`.`location` (`Lid`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `SectionToProfession` FOREIGN KEY (`Profession`)
        REFERENCES `cse`.`profession` (`Pid`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `cse`.`contest` (
  `Cid` INT NOT NULL AUTO_INCREMENT,
  `BasicMessage` INT NULL,
  `Name` VARCHAR(100) NULL,
  `Resume` VARCHAR(100) NULL,
  `DeprecatedFlag` TINYINT NULL DEFAULT 0,
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
  `DeprecatedFlag` TINYINT NULL DEFAULT 0,
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
  `DeprecatedFlag` TINYINT NULL DEFAULT 0,
  `Section` INT NULL,
  `Location` INT NULL,
  `Request` INT NULL,
  `ActivityScore` INT NULL,
  PRIMARY KEY (`Aid`),
  INDEX `ActivityToSection_idx` (`Section` ASC) VISIBLE,
  INDEX `ActivityToRequest_idx` (`Request` ASC) VISIBLE,
  INDEX `ActivityToActivityScore_idx` (ActivityScore ASC) VISIBLE,
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
    FOREIGN KEY (ActivityScore)
    REFERENCES `cse`.`keyword` (`Kid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `cse`.`calender` (
  `Uid` INT NOT NULL,
  `Time` DATETIME NOT NULL,
  `Description` VARCHAR(100) NULL,
  `DeprecatedFlag` TINYINT NULL DEFAULT 0,
  `RelationFunction` JSON NULL,
  PRIMARY KEY (`Uid`, `Time`),
  CONSTRAINT `CalenderToUser`
      FOREIGN KEY (`Uid`)
      REFERENCES `cse`.`user` (`Uid`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);


CREATE TABLE `cse`.`resource_table` (
    `Uid` INT NOT NULL,
    `Rid` INT NOT NULL,
    `Description` VARCHAR(45) NULL,
    `DeprecatedFlag` TINYINT NULL DEFAULT 0,
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

CREATE TABLE `cse`.`message_resource` (
      `Mid` INT NOT NULL,
      `Rid` INT NOT NULL,
      PRIMARY KEY (`Mid`, `Rid`),
      INDEX `LinkMessageToResource_idx` (`Rid` ASC) VISIBLE,
      CONSTRAINT `LinkResourceToMessage`
          FOREIGN KEY (`Mid`)
              REFERENCES `cse`.`message` (`Mid`)
              ON DELETE NO ACTION
              ON UPDATE NO ACTION,
      CONSTRAINT `LinkMessageToResource`
          FOREIGN KEY (`Rid`)
              REFERENCES `cse`.`resource` (`Rid`)
              ON DELETE NO ACTION
              ON UPDATE NO ACTION);

CREATE TABLE `cse`.`message_activity` (
    `Mid` INT NOT NULL,
    `Aid` INT NOT NULL,
    PRIMARY KEY (`Mid`, `Aid`),
    INDEX `LinkMessageToActivity_idx` (`Aid` ASC) VISIBLE,
    CONSTRAINT `LinkActivityToMessage`
      FOREIGN KEY (`Mid`)
          REFERENCES `cse`.`message` (`Mid`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION,
    CONSTRAINT `LinkMessageToActivity`
      FOREIGN KEY (`Aid`)
          REFERENCES `cse`.`activity` (`Aid`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION);


CREATE TABLE `cse`.`message_contest` (
    `Mid` INT NOT NULL,
    `Cid` INT NOT NULL,
    PRIMARY KEY (`Mid` , `Cid`),
    CONSTRAINT `LinkContestToMessage` FOREIGN KEY (`Mid`)
        REFERENCES `cse`.`message` (`Mid`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `LinkMessageToContest` FOREIGN KEY (`Cid`)
        REFERENCES `cse`.`contest` (`Cid`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


CREATE TABLE `cse`.`message_section` (
    `Mid` INT NOT NULL,
    `Sid` INT NOT NULL,
    PRIMARY KEY (`Mid` , `Sid`),
    CONSTRAINT `LinkSectionToMessage` FOREIGN KEY (`Mid`)
        REFERENCES `cse`.`message` (`Mid`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `LinkMessageToSection` FOREIGN KEY (`Sid`)
        REFERENCES `cse`.`section` (`Sid`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `cse`.`message_location` (
    `Mid` INT NOT NULL,
    `Lid` INT NOT NULL,
    PRIMARY KEY (`Mid` , `Lid`),
    CONSTRAINT `LinkLocationToMessage` FOREIGN KEY (`Mid`)
        REFERENCES `cse`.`message` (`Mid`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `LinkMessageToLocation` FOREIGN KEY (`Lid`)
        REFERENCES `cse`.`Location` (`Lid`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `cse`.`favourite_activity` (
    `Uid` INT NOT NULL,
    `like` INT NOT NULL,
    PRIMARY KEY (`Uid`, `like`),
    INDEX `favouriteToActivity_idx` (`like` ASC) VISIBLE,
    CONSTRAINT `favouriteToActivity`
        FOREIGN KEY (`like`)
            REFERENCES `cse`.`activity` (`Aid`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `ActivityToUserF`
        FOREIGN KEY (`Uid`)
            REFERENCES `cse`.`user` (`Uid`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION);

CREATE TABLE `cse`.`favourite_contest` (
   `Uid` INT NOT NULL,
   `like` INT NOT NULL,
   PRIMARY KEY (`Uid`, `like`),
   INDEX `favouriteToContest_idx` (`like` ASC) VISIBLE,
   CONSTRAINT `favouriteToContest`
       FOREIGN KEY (`like`)
           REFERENCES `cse`.`contest` (`Cid`)
           ON DELETE NO ACTION
           ON UPDATE NO ACTION,
   CONSTRAINT `ContestToUserF`
       FOREIGN KEY (`Uid`)
           REFERENCES `cse`.`user` (`Uid`)
           ON DELETE NO ACTION
           ON UPDATE NO ACTION);

CREATE TABLE `cse`.`favourite_location` (
    `Uid` INT NOT NULL,
    `like` INT NOT NULL,
    PRIMARY KEY (`Uid`, `like`),
    INDEX `favouriteToLocation_idx` (`like` ASC) VISIBLE,
    CONSTRAINT `favouriteToLocation`
        FOREIGN KEY (`like`)
            REFERENCES `cse`.`location` (`Lid`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `LocationToUserF`
        FOREIGN KEY (`Uid`)
            REFERENCES `cse`.`user` (`Uid`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION);

CREATE TABLE `cse`.`favourite_resource` (
    `Uid` INT NOT NULL,
    `like` INT NOT NULL,
    PRIMARY KEY (`Uid`, `like`),
    INDEX `favouriteToResource_idx` (`like` ASC) VISIBLE,
    CONSTRAINT `favouriteToResource`
        FOREIGN KEY (`like`)
            REFERENCES `cse`.`resource` (`Rid`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `ResourceToUserF`
        FOREIGN KEY (`Uid`)
            REFERENCES `cse`.`user` (`Uid`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION);

CREATE TABLE `cse`.`favourite_section` (
   `Uid` INT NOT NULL,
   `like` INT NOT NULL,
   PRIMARY KEY (`Uid`, `like`),
   INDEX `favouriteToSection_idx` (`like` ASC) VISIBLE,
   CONSTRAINT `favouriteToSection`
       FOREIGN KEY (`like`)
           REFERENCES `cse`.`section` (`Sid`)
           ON DELETE NO ACTION
           ON UPDATE NO ACTION,
   CONSTRAINT `SectionToUserF`
       FOREIGN KEY (`Uid`)
           REFERENCES `cse`.`user` (`Uid`)
           ON DELETE NO ACTION
           ON UPDATE NO ACTION);

-- 触发器创建
DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`user_BEFORE_INSERT` BEFORE INSERT ON `user` FOR EACH ROW
BEGIN
    set new.DeprecatedFlag = 0 ;
END$$
DELIMITER ;
-- 废弃标识符置0

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`user_AFTER_INSERT` AFTER INSERT ON `user` FOR EACH ROW
BEGIN
    insert into user_hobby (`Uid`,`Hid`,`degree`) (select new.Uid, `Hid`, 'common' from hobby);
END$$
DELIMITER ;
-- 将所有的爱好置为common

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`profession_BEFORE_INSERT` BEFORE INSERT ON `profession` FOR EACH ROW
BEGIN
    set new.DeprecatedFlag = 0 ;
END$$
DELIMITER ;
-- 废弃标识符置0

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`hobby_BEFORE_INSERT` BEFORE INSERT ON `hobby` FOR EACH ROW
BEGIN
    set new.DeprecatedFlag = 0 ;
END$$
DELIMITER ;
DROP TRIGGER IF EXISTS `cse`.`hobby_AFTER_INSERT`;
-- 废弃标志符

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`hobby_AFTER_INSERT` AFTER INSERT ON `hobby` FOR EACH ROW
BEGIN
    insert into user_hobby (`Uid`,`Hid`,`degree`) (select `Uid`, new.Hid, 'common' from user);
END$$
DELIMITER ;
-- 对所有用户增加爱好关系表

