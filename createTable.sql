CREATE SCHEMA `cse` ;

CREATE TABLE `cse`.`profession` (
    `Pid` INT NOT NULL AUTO_INCREMENT,
    `ProfessionName` VARCHAR(45) NULL,
    `ProfessionDescription` varchar(100) null,
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
  `Sex` ENUM('男','女') NULL,
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
  `Model` JSON NULL,
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
  `Title` VARCHAR(45) NOT NULL,
  `ReleaseTime` DATETIME NULL,
  `OutTime` DATETIME NULL,
  `Time` JSON NULL,
  `message` JSON NULL,
  `AsBasicMessage` INT null DEFAULT 0,
  `DeprecatedFlag` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`Mid`),
  UNIQUE INDEX `Title_UNIQUE` (`Title` ASC) VISIBLE);

CREATE TABLE `cse`.`message_out` (
                                     `Mid` INT NOT NULL ,
                                     `Title` VARCHAR(45) NOT NULL,
                                     `ReleaseTime` DATETIME NULL,
                                     `OutTime` DATETIME NULL,
                                     `message` JSON NULL,
                                     `DeprecatedFlag` TINYINT NULL DEFAULT 0,
                                     PRIMARY KEY (`Mid`),
                                     UNIQUE INDEX `Title_UNIQUE` (`Title` ASC) VISIBLE);


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
  `Name` VARCHAR(45) NOT NULL,
  `Resume` VARCHAR(45) NULL,
  `Ability` JSON NULL,
  `MapBelong` INT NULL,
  `BasicMessage` INT NULL,
  `MapOwn` INT NULL,
  `ImgHref` VARCHAR(200) NULL,
  `X` INT NULL,
  `Y` INT NULL,
  `DeprecatedFlag` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`Lid`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  INDEX `LocationToMap_idx` (`MapBelong` ASC) VISIBLE,
  INDEX `LocationOwnMap_idx` (`MapOwn` ASC) VISIBLE,
  CONSTRAINT `LocationToMap`
    FOREIGN KEY (`MapBelong`)
    REFERENCES `cse`.`map` (`Mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `LocationToBasicMessage`
      FOREIGN KEY (`BasicMessage`)
          REFERENCES `cse`.`message` (`Mid`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION,
  CONSTRAINT `LocationOwnMap`
    FOREIGN KEY (`MapOwn`)
    REFERENCES `cse`.`map` (`Mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `cse`.`information_class` (
                                           `Cid` INT NOT NULL AUTO_INCREMENT,
                                           `Name` VARCHAR(45) NOT NULL,
                                           `Resume` VARCHAR(100) NULL,
                                           `BasicMessage` INT NULL,
                                           `Type` ENUM('比赛', '部门', '活动', '资源') NOT NULL,
                                           `ImgHref` VARCHAR(200) NULL,
                                           `DeprecatedFlag` VARCHAR(45) NULL,
                                           `Location` INT NULL,
                                           PRIMARY KEY (`Cid`),
                                           UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
                                           CONSTRAINT `InformationClassToBasicMessage`
                                               FOREIGN KEY (`BasicMessage`)
                                                   REFERENCES `cse`.`message` (`Mid`)
                                                   ON DELETE NO ACTION
                                                   ON UPDATE NO ACTION,
                                           CONSTRAINT `InformationClassToLocation`
                                               FOREIGN KEY (`Location`)
                                                   REFERENCES `cse`.`location` (`Lid`)
                                                   ON DELETE NO ACTION
                                                   ON UPDATE NO ACTION);
CREATE TABLE `cse`.`surf_location` (
                                       `Time` DATETIME NOT NULL default now(),
                                       `Uid` INT NOT NULL,
                                       `Surf` INT NOT NULL,
                                       PRIMARY KEY (`Time` , `Uid` , `Surf`),
                                       CONSTRAINT `surf_location` FOREIGN KEY (`Surf`)
                                           REFERENCES `cse`.`location` (`Lid`)
                                           ON DELETE NO ACTION ON UPDATE NO ACTION,
                                       CONSTRAINT `surfL_user` FOREIGN KEY (`Uid`)
                                           REFERENCES `cse`.`user` (`Uid`)
                                           ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `cse`.`surf_message` (
                                      `Time` DATETIME NOT NULL default now(),
                                      `Uid` INT NOT NULL,
                                      `Surf` INT NOT NULL,
                                      PRIMARY KEY (`Time` , `Uid` , `Surf`),
                                      CONSTRAINT `surf_message` FOREIGN KEY (`Surf`)
                                          REFERENCES `cse`.`message` (`Mid`)
                                          ON DELETE NO ACTION ON UPDATE NO ACTION,
                                      CONSTRAINT `surfM_user` FOREIGN KEY (`Uid`)
                                          REFERENCES `cse`.`user` (`Uid`)
                                          ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `cse`.`surf_information_class` (
                                                `Time` DATETIME NOT NULL default now(),
                                                `Uid` INT NOT NULL,
                                                `Surf` INT NOT NULL,
                                                PRIMARY KEY (`Time` , `Uid` , `Surf`),
                                                CONSTRAINT `surf_information_class` FOREIGN KEY (`Surf`)
                                                    REFERENCES `cse`.`information_class` (`Cid`)
                                                    ON DELETE NO ACTION ON UPDATE NO ACTION,
                                                CONSTRAINT `surfC_user` FOREIGN KEY (`Uid`)
                                                    REFERENCES `cse`.`user` (`Uid`)
                                                    ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `cse`.`information_class_key` (
                                               `Cid` INT NOT NULL,
                                               `Kid` INT NOT NULL,
                                               PRIMARY KEY (`Cid`, `Kid`),
                                               INDEX `InformationClassToKey_idx` (`Kid` ASC) VISIBLE,
                                               CONSTRAINT `InformationClassToKey`
                                                   FOREIGN KEY (`Kid`)
                                                       REFERENCES `cse`.`keyword` (`Kid`)
                                                       ON DELETE NO ACTION
                                                       ON UPDATE NO ACTION,
                                               CONSTRAINT `KeyToInformationClass`
                                                   FOREIGN KEY (`Cid`)
                                                       REFERENCES `cse`.`information_class` (`Cid`)
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

CREATE TABLE `cse`.`message_information_class` (
                                          `Mid` INT NOT NULL,
                                          `Cid` INT NOT NULL,
                                          PRIMARY KEY (`Mid` , `Cid`),
                                          CONSTRAINT `LinkInformationClassToMessage` FOREIGN KEY (`Mid`)
                                              REFERENCES `cse`.`message` (`Mid`)
                                              ON DELETE NO ACTION ON UPDATE NO ACTION,
                                          CONSTRAINT `LinkMessageToInformationClass` FOREIGN KEY (`Cid`)
                                              REFERENCES `cse`.`information_class` (`Cid`)
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


CREATE TABLE `cse`.`favourite_location` (
    `Uid` INT NOT NULL,
    `like` INT NOT NULL,
    `Time` DATETIME NOT NULL DEFAULT NOW(),
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

CREATE TABLE `cse`.`favourite_message` (
   `Uid` INT NOT NULL,
   `like` INT NOT NULL,
   `Time` DATETIME NOT NULL DEFAULT NOW(),
   PRIMARY KEY (`Uid`, `Time`),
   INDEX `favouriteToSection_idx` (`like` ASC) VISIBLE,
   CONSTRAINT `favouriteToMessage`
       FOREIGN KEY (`like`)
           REFERENCES `cse`.`message` (`Mid`)
           ON DELETE NO ACTION
           ON UPDATE NO ACTION,
   CONSTRAINT `MessageToUserF`
       FOREIGN KEY (`Uid`)
           REFERENCES `cse`.`user` (`Uid`)
           ON DELETE NO ACTION
           ON UPDATE NO ACTION);

CREATE TABLE `cse`.`favourite_information_class` (
                                                     `Uid` INT NOT NULL,
                                                     `like` INT NOT NULL,
                                                     `Time` DATETIME NOT NULL DEFAULT NOW(),
                                                     PRIMARY KEY (`Uid`, `like`),
                                                     INDEX `favouriteToLocation_idx` (`like` ASC) VISIBLE,
                                                     CONSTRAINT `favouriteToInformationClass`
                                                         FOREIGN KEY (`like`)
                                                             REFERENCES `cse`.`information_class` (`Cid`)
                                                             ON DELETE NO ACTION
                                                             ON UPDATE NO ACTION,
                                                     CONSTRAINT `InformationClassToUserF`
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
-- 废弃标志符

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`hobby_AFTER_INSERT` AFTER INSERT ON `hobby` FOR EACH ROW
BEGIN
    insert into user_hobby (`Uid`,`Hid`,`degree`) (select `Uid`, new.Hid, 'common' from user);
END$$
DELIMITER ;
-- 对所有用户增加爱好关系表

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`calender_BEFORE_INSERT` BEFORE INSERT ON `calender` FOR EACH ROW
BEGIN
    set new.DeprecatedFlag = 0 ;
END$$
DELIMITER ;
-- 废弃标志富

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`information_class_BEFORE_INSERT` BEFORE INSERT ON `information_class` FOR EACH ROW
BEGIN
    set new.DeprecatedFlag = 0;
    if new.Resume is null then
        set new.Resume = '简介';
    end if;
END$$
DELIMITER ;
-- 废弃标志符与默认值设定

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`location_BEFORE_INSERT` BEFORE INSERT ON `location` FOR EACH ROW
BEGIN
    set new.DeprecatedFlag = 0;
    if new.Resume is null then
        set new.Resume = '简介';
    end if;
END$$
DELIMITER ;

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`message_BEFORE_INSERT` BEFORE INSERT ON `message` FOR EACH ROW
BEGIN
    set new.DeprecatedFlag = 0;
    set new.AsBasicMessage = 0;
    if new.ReleaseTime IS NULL
    then set new.ReleaseTime = now();
    end if;
    if new.OutTime IS NULL
    then set new.OutTIme = date_add(now() ,interval '1' year );
    end if;
END$$
DELIMITER ;
-- message规范输入

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`message_BEFORE_DELETE` BEFORE DELETE ON `message` FOR EACH ROW
BEGIN
    if not old.AsBasicMessage = 0 then
        set @choose = old.AsBasicMessage mod 2;
        if @choose = 0 then
            update information_class set BasicMessage = null where Cid = (old.AsBasicMessage)/2;
        end if;
        if @choose = 1 then
            update location set BasicMessage = null where Lid = (old.AsBasicMessage - 1)/2;
        end if;
    end if;

    delete from message_information_class where Mid = old.Mid;
    delete from message_location where Mid = old.Mid;
    delete from surf_message where Surf = old.Mid;
    update favourite_message set favourite_message.like = null where favourite_message.like = old.Mid;
END$$
DELIMITER ;
-- 级联删除

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`message_AFTER_DELETE` AFTER DELETE ON `message` FOR EACH ROW
BEGIN
    insert into message_out (Mid,Title, ReleaseTime, OutTime, message) values (old.Mid,old.Title, old.ReleaseTime, old.OutTime, old.message);
END$$
DELIMITER ;
-- 进入过时表

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`favourite_information_class_BEFORE_INSERT` BEFORE INSERT ON `favourite_information_class` FOR EACH ROW
BEGIN
    if new.Time is null
    then set new.Time = now();
    end if;

END$$
DELIMITER ;

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`favourite_location_BEFORE_INSERT` BEFORE INSERT ON `favourite_location` FOR EACH ROW
BEGIN
    if new.Time is null
    then set new.Time = now();
    end if;
END$$
DELIMITER ;

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`favourite_message_BEFORE_INSERT` BEFORE INSERT ON `favourite_message` FOR EACH ROW
BEGIN
    if new.Time is null
    then set new.Time = now();
    end if;
END$$
DELIMITER ;
-- 时间标签

-- 新建视图

CREATE
    VIEW `surf_count_message` AS
SELECT
    `surf_message`.`Surf` AS `surf`,
    COUNT(`surf_message`.`Surf`) AS `counts`
FROM
    `surf_message` where time > date_sub(now(),interval 1 week)
GROUP BY `surf_message`.`Surf`;

CREATE
    VIEW `surf_count_information_class` AS
SELECT
    `surf_information_class`.`Surf` AS `surf`,
    COUNT(`surf_information_class`.`Surf`) AS `counts`
FROM
    `surf_information_class` where time > date_sub(now(),interval 1 week)
GROUP BY `surf_information_class`.`Surf`;

CREATE
    VIEW `surf_count_location` AS
SELECT
    `surf_location`.`Surf` AS `surf`,
    COUNT(`surf_location`.`Surf`) AS `counts`
FROM
    `surf_location` where time > date_sub(now(),interval 1 week)
GROUP BY `surf_location`.`Surf`;

