CREATE SCHEMA `cse` ;

CREATE TABLE `cse`.`profession` (
    `Pid` INT NOT NULL AUTO_INCREMENT comment '唯一id',
    `ProfessionName` VARCHAR(45) NULL comment '专业名',
    `ProfessionDescription` varchar(100) null comment '专业描述',
    `DeprecatedFlag` TINYINT NULL DEFAULT 0 comment '废弃符号',
    PRIMARY KEY (`Pid`)
) comment = '专业';

CREATE TABLE `cse`.`user` (
  `Uid` INT NOT NULL AUTO_INCREMENT comment '唯一id',
  `UserCode` VARCHAR(45) NULL comment '学号',
  `UserPass` VARCHAR(45) NULL comment '密码',
  `UserName` VARCHAR(45) NULL comment '用户名',
  `Grade` VARCHAR(45) NULL comment '入学年级',
  `Profession` INT NULL DEFAULT NULL comment '专业id',
  `Sex` ENUM('男','女') NULL  comment '性别',
  `UserModel` JSON NULL  comment '基本信息生成的推荐模型',
  `DeprecatedFlag` TINYINT NULL DEFAULT 0 comment '废弃符号',
  INDEX `Profession_idx` (`Profession` ASC) VISIBLE,
  INDEX `Grade_idx` (`Grade` ASC) VISIBLE,
  CONSTRAINT `Profession`
      FOREIGN KEY (`Profession`)
          REFERENCES `cse`.`profession` (`Pid`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION,
  PRIMARY KEY (`Uid`)) comment = '用户表';

  CREATE TABLE `cse`.`hobby` (
  `Hid` INT NOT NULL AUTO_INCREMENT comment '唯一id',
  `Description` VARCHAR(45) NULL comment '爱好描述',
  `Name` VARCHAR(45) NULL  comment '爱好名',
  `Type` VARCHAR(45) NULL  comment '爱好类型',
  `Model` JSON NULL  comment '爱好的推荐模型',
  `DeprecatedFlag` TINYINT NULL DEFAULT 0  comment '废弃标识',
  PRIMARY KEY (`Hid`)) comment = '爱好';
  
CREATE TABLE `cse`.`user_hobby` (
    `Uid` INT NOT NULL comment '用户id',
    `Hid` INT NOT NULL comment '爱好id',
    `degree` ENUM('interested', 'common', 'uninterested') NULL DEFAULT 'common',
    PRIMARY KEY (`Uid` , `Hid`),
    INDEX `user_hobby_hid_idx` (`Hid` ASC) VISIBLE,
    INDEX `user_hobby_uid_idx` (`Uid` ASC) VISIBLE,
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
) comment = '用户的爱好索引表';

CREATE TABLE `cse`.`message` (
  `Mid` INT NOT NULL AUTO_INCREMENT comment '唯一id',
  `Title` VARCHAR(45) NOT NULL comment '标题',
  `ReleaseTime` DATETIME NULL comment '消息录入时间',
  `OutTime` DATETIME NULL comment '消息过时时间',
  `Time` JSON NULL comment '消息占用的时间',
  `message` JSON NULL comment '消息本体',
  `AsBasicMessage` INT null DEFAULT 0 comment '是否被选为基本信息',
  `DeprecatedFlag` TINYINT NULL DEFAULT 0 comment '废弃标志',
  PRIMARY KEY (`Mid`),
  UNIQUE INDEX `Title_UNIQUE` (`Title` ASC) VISIBLE,
  Index `ReleaseTime_idx` (`ReleaseTime`desc) visible) comment = '消息';

CREATE TABLE `cse`.`message_out` (
                                     `Mid` INT NOT NULL comment '唯一id',
                                     `Title` VARCHAR(45) NOT NULL comment '标题',
                                     `ReleaseTime` DATETIME NULL comment '消息录入时间',
                                     `OutTime` DATETIME NULL comment '消息过时时间',
                                     `message` JSON NULL comment '消息本体',
                                     `DeprecatedFlag` TINYINT NULL DEFAULT 0 comment '废弃标志',
                                     PRIMARY KEY (`Mid`),
                                     UNIQUE INDEX `Title_UNIQUE` (`Title` ASC) VISIBLE) comment = '过时消息';


CREATE TABLE `cse`.`keyword_type` (
    `Tid` INT NOT NULL AUTO_INCREMENT comment '唯一id',
    `TypeName` VARCHAR(45) NULL comment '关键词类型名',
    `TypeResume` VARCHAR(100) NULL comment '类型简介',
    PRIMARY KEY (`Tid`)
) comment = '关键词类型';

CREATE TABLE `cse`.`keyword` (
    `Kid` INT NOT NULL AUTO_INCREMENT comment '唯一id',
    `KeyName` VARCHAR(45) NULL comment '关键词名',
    `KeywordType` INT NULL comment '关键词类型id',
    `KeyResume` VARCHAR(45) NULL  comment '关键词简介',
    PRIMARY KEY (`Kid`),
    INDEX `KeyWordType_idx` (`KeywordType` ASC) VISIBLE,
    CONSTRAINT `KeyWord_Type`
      FOREIGN KEY (`KeywordType`)
      REFERENCES `cse`.`keyword_type` (`Tid`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
) comment = '关键词';


CREATE TABLE `cse`.`location` (
  `Lid` INT NOT NULL AUTO_INCREMENT comment '唯一id',
  `Name` VARCHAR(45) NOT NULL comment '地点名',
  `Resume` VARCHAR(200) NULL comment '地点简介',
  `MapBelong` VARCHAR(200) NULL comment '所在地图',
  `BasicMessage` INT NULL comment '简介消息id',
  `ImgHref` VARCHAR(200) NULL comment '介绍图片',
  `X` INT NULL comment '地图位置横轴',
  `Y` INT NULL comment '地图位置纵轴',
  `DeprecatedFlag` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`Lid`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  CONSTRAINT `LocationToBasicMessage`
      FOREIGN KEY (`BasicMessage`)
          REFERENCES `cse`.`message` (`Mid`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION) comment = '地点类';

CREATE TABLE `cse`.`information_class` (
                                           `Cid` INT NOT NULL AUTO_INCREMENT comment '唯一id',
                                           `Name` VARCHAR(45) NOT NULL comment '信息类名',
                                           `Resume` VARCHAR(100) NULL comment '简介',
                                           `BasicMessage` INT NULL comment '简介消息id',
                                           `Type` ENUM('比赛', '部门', '活动', '资源') NOT NULL comment '信息类类型',
                                           `ImgHref` VARCHAR(200) NULL comment '介绍图片',
                                           `DeprecatedFlag` VARCHAR(45) NULL,
                                           PRIMARY KEY (`Cid`),
                                           UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
                                           CONSTRAINT `InformationClassToBasicMessage`
                                               FOREIGN KEY (`BasicMessage`)
                                                   REFERENCES `cse`.`message` (`Mid`)
                                                   ON DELETE NO ACTION
                                                   ON UPDATE NO ACTION) comment '信息类';

CREATE TABLE `cse`.`information_class_location` (
                                                    `Cid` INT NOT NULL comment '信息类id',
                                                    `Lid` INT NOT NULL comment '地点类id',
                                                    PRIMARY KEY (`Cid`, `Lid`),
                                                    CONSTRAINT `informationClassToLocation`
                                                        FOREIGN KEY (`Lid`)
                                                            REFERENCES `cse`.`location` (`Lid`)
                                                            ON DELETE NO ACTION
                                                            ON UPDATE NO ACTION,
                                                    CONSTRAINT `locationToInformationClass`
                                                        FOREIGN KEY (`Cid`)
                                                            REFERENCES `cse`.`information_class` (`Cid`)
                                                            ON DELETE NO ACTION
                                                            ON UPDATE NO ACTION) comment = '地点类与信息类连接';

CREATE TABLE `cse`.`surf_location` (
                                       `id` INT NOT NULL AUTO_INCREMENT comment '唯一id',
                                       `Time` DATETIME NOT NULL default now() comment '浏览时间',
                                       `Uid` INT  NULL comment '浏览用户',
                                       `Surf` INT NOT NULL comment '浏览地点id',
                                       PRIMARY KEY (`id`),
                                       CONSTRAINT `surf_location` FOREIGN KEY (`Surf`)
                                           REFERENCES `cse`.`location` (`Lid`)
                                           ON DELETE NO ACTION ON UPDATE NO ACTION,
                                       CONSTRAINT `surfL_user` FOREIGN KEY (`Uid`)
                                           REFERENCES `cse`.`user` (`Uid`)
                                           ON DELETE NO ACTION ON UPDATE NO ACTION
) comment = '地点浏览表';

CREATE TABLE `cse`.`surf_message` (
                                      `id` INT NOT NULL AUTO_INCREMENT comment '唯一id',
                                      `Time` DATETIME NOT NULL default now() comment '浏览时间',
                                      `Uid` INT  NULL comment '浏览用户',
                                      `Surf` INT NOT NULL comment '浏览消息id',
                                      PRIMARY KEY (`id`),
                                      CONSTRAINT `surf_message` FOREIGN KEY (`Surf`)
                                          REFERENCES `cse`.`message` (`Mid`)
                                          ON DELETE NO ACTION ON UPDATE NO ACTION,
                                      CONSTRAINT `surfM_user` FOREIGN KEY (`Uid`)
                                          REFERENCES `cse`.`user` (`Uid`)
                                          ON DELETE NO ACTION ON UPDATE NO ACTION
)comment = '消息浏览表';

CREATE TABLE `cse`.`surf_information_class` (
                                                `id` INT NOT NULL AUTO_INCREMENT comment '唯一id',
                                                `Time` DATETIME NOT NULL default now() comment '浏览时间',
                                                `Uid` INT  NULL comment '浏览用户',
                                                `Surf` INT NOT NULL comment '浏览信息类id',
                                                PRIMARY KEY (`id`),
                                                CONSTRAINT `surf_information_class` FOREIGN KEY (`Surf`)
                                                    REFERENCES `cse`.`information_class` (`Cid`)
                                                    ON DELETE NO ACTION ON UPDATE NO ACTION,
                                                CONSTRAINT `surfC_user` FOREIGN KEY (`Uid`)
                                                    REFERENCES `cse`.`user` (`Uid`)
                                                    ON DELETE NO ACTION ON UPDATE NO ACTION
)comment = '信息类浏览表';

CREATE TABLE `cse`.`location_key` (
                                               `Lid` INT NOT NULL comment '地点类id',
                                               `Kid` INT NOT NULL comment '关键词id',
                                               PRIMARY KEY (`Lid`, `Kid`),
                                               INDEX `LocationToKey_idx` (`Lid` ASC) VISIBLE,
                                               CONSTRAINT `LocationToKey`
                                                   FOREIGN KEY (`Kid`)
                                                       REFERENCES `cse`.`keyword` (`Kid`)
                                                       ON DELETE NO ACTION
                                                       ON UPDATE NO ACTION,
                                               CONSTRAINT `KeyToLocation`
                                                   FOREIGN KEY (`Lid`)
                                                       REFERENCES `cse`.`location` (`Lid`)
                                                       ON DELETE NO ACTION
                                                       ON UPDATE NO ACTION) comment = '地点关键词表';

CREATE TABLE `cse`.`information_class_key` (
                                               `Cid` INT NOT NULL comment '信息类id',
                                               `Kid` INT NOT NULL comment '关键词id',
                                               PRIMARY KEY (`Cid`, `Kid`),
                                               INDEX `InformationClassToKey_idx` (`Cid` ASC) VISIBLE,
                                               CONSTRAINT `InformationClassToKey`
                                                   FOREIGN KEY (`Kid`)
                                                       REFERENCES `cse`.`keyword` (`Kid`)
                                                       ON DELETE NO ACTION
                                                       ON UPDATE NO ACTION,
                                               CONSTRAINT `KeyToInformationClass`
                                                   FOREIGN KEY (`Cid`)
                                                       REFERENCES `cse`.`information_class` (`Cid`)
                                                       ON DELETE NO ACTION
                                                       ON UPDATE NO ACTION) comment = '信息类关键词表';

CREATE TABLE `cse`.`calender` (
  `Uid` INT NOT NULL comment '用户id',
  `Time` DATETIME NOT NULL comment '事务时间',
  `Description` VARCHAR(100) NULL comment '描述',
  `DeprecatedFlag` TINYINT NULL DEFAULT 0 comment '废弃标识',
  `RelationFunction` JSON NULL comment '关联信息的反序列化存储',
  PRIMARY KEY (`Uid`, `Time`),
  CONSTRAINT `CalenderToUser`
      FOREIGN KEY (`Uid`)
      REFERENCES `cse`.`user` (`Uid`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION) comment = '用户待办日历';

CREATE TABLE `cse`.`message_information_class` (
                                          `Mid` INT NOT NULL comment '消息id',
                                          `Cid` INT NOT NULL comment '信息类id',
                                          PRIMARY KEY (`Mid` , `Cid`),
                                          CONSTRAINT `LinkInformationClassToMessage` FOREIGN KEY (`Mid`)
                                              REFERENCES `cse`.`message` (`Mid`)
                                              ON DELETE NO ACTION ON UPDATE NO ACTION,
                                          CONSTRAINT `LinkMessageToInformationClass` FOREIGN KEY (`Cid`)
                                              REFERENCES `cse`.`information_class` (`Cid`)
                                              ON DELETE NO ACTION ON UPDATE NO ACTION
) comment = '消息信息类索引表';

CREATE TABLE `cse`.`message_location` (
    `Mid` INT NOT NULL comment '消息id',
    `Lid` INT NOT NULL comment '地点id',
    PRIMARY KEY (`Mid` , `Lid`),
    CONSTRAINT `LinkLocationToMessage` FOREIGN KEY (`Mid`)
        REFERENCES `cse`.`message` (`Mid`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `LinkMessageToLocation` FOREIGN KEY (`Lid`)
        REFERENCES `cse`.`Location` (`Lid`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)comment = '消息地点类索引表';


CREATE TABLE `cse`.`favourite_location` (
    `Uid` INT NOT NULL comment '用户id',
    `like` INT  NULL comment '地点id',
    `Time` DATETIME NOT NULL DEFAULT NOW() comment '收藏时间',
    PRIMARY KEY (`Uid`, `Time`),
    INDEX `favouriteToLocation_idx` (`like` ASC) VISIBLE,
    INDEX `locationToUser_idx` (`Uid` ASC ) visible,
    CONSTRAINT `favouriteToLocation`
        FOREIGN KEY (`like`)
            REFERENCES `cse`.`location` (`Lid`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `LocationToUserF`
        FOREIGN KEY (`Uid`)
            REFERENCES `cse`.`user` (`Uid`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION) comment = '用户地点收藏';

CREATE TABLE `cse`.`favourite_message` (
   `Uid` INT NOT NULL comment '用户id',
   `like` INT NOT NULL comment '消息id',
   `Time` DATETIME NOT NULL DEFAULT NOW() comment '收藏时间',
   PRIMARY KEY (`Uid`, `Time`),
   INDEX `favouriteToSection_idx` (`like` ASC) VISIBLE,
   INDEX `MessageToUser_idx` (`Uid` ASC ) visible,
   CONSTRAINT `favouriteToMessage`
       FOREIGN KEY (`like`)
           REFERENCES `cse`.`message` (`Mid`)
           ON DELETE NO ACTION
           ON UPDATE NO ACTION,
   CONSTRAINT `MessageToUserF`
       FOREIGN KEY (`Uid`)
           REFERENCES `cse`.`user` (`Uid`)
           ON DELETE NO ACTION
           ON UPDATE NO ACTION) comment = '用户消息收藏';

CREATE TABLE `cse`.`favourite_information_class` (
                                                     `Uid` INT NOT NULL comment '用户id',
                                                     `like` INT NULL comment '信息类id',
                                                     `Time` DATETIME NOT NULL DEFAULT NOW() comment '收藏时间',
                                                     PRIMARY KEY (`Uid`, `Time`),
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
                                                             ON UPDATE NO ACTION) comment = '用户信息类收藏';

CREATE TABLE `cse`.`basic_model` (
                                     `Bid` INT NOT NULL AUTO_INCREMENT COMMENT '唯一标识id',
                                     `id` INT NULL COMMENT '推荐的对象的id',
                                     `type` VARCHAR(45) NULL COMMENT '推荐对象的类型',
                                     `score` INT NULL COMMENT '推荐分值',
                                     PRIMARY KEY (`Bid`))
    COMMENT = '存储基础信息运算出来的推荐';

CREATE TABLE `cse`.`profession_basic_model` (
                                                `Pid` INT NOT NULL COMMENT '专业的id',
                                                `Bid` INT NOT NULL COMMENT '模型的id',
                                                PRIMARY KEY (`Pid`, `Bid`))
    COMMENT = '专业与模型的关联表';

CREATE TABLE `cse`.`year_basic_model` (
                                          `Year` INT NOT NULL COMMENT '年级',
                                          `Bid` VARCHAR(45) NOT NULL COMMENT '模型id',
                                          PRIMARY KEY (`Year`, `Bid`))
    COMMENT = '年级对应的模型表';


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
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`information_class_AFTER_INSERT` AFTER INSERT ON `information_class` FOR EACH ROW
BEGIN
    if not new.BasicMessage is null then
        update message set AsBasicMessage = new.Cid * 2 where Mid = new.BasicMessage;
    end if;
END$$
DELIMITER ;
DROP TRIGGER IF EXISTS `cse`.`information_class_BEFORE_UPDATE`;

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`information_class_BEFORE_UPDATE` BEFORE UPDATE ON `information_class` FOR EACH ROW
BEGIN
    if new.BasicMessage <> old.BasicMessage then
        update message set AsBasicMessage = new.Cid*2 where Mid = new.BasicMessage;
        if old.BasicMessage <> 0 then
            update message set AsBasicMessage = 0 where Mid = old.BasicMessage;
        end if;
    end if;
END$$
DELIMITER ;
-- 更新BasicMessage时对message表进行修改

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`information_class_BEFORE_DELETE` BEFORE DELETE ON `information_class` FOR EACH ROW
BEGIN
    delete from message_information_class where Cid = old.Cid;
    delete from surf_information_class where Surf = old.Cid;
    delete from information_class_key where Cid = old.Cid;
    delete from information_class_location where Cid = old.Cid;
    update favourite_information_class set favourite_information_class.like = null where favourite_information_class.like = old.Cid;
    update message set AsBasicMessage = 0 where Mid = old.BasicMessage;
END$$
DELIMITER ;


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
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`location_AFTER_INSERT` AFTER INSERT ON `location` FOR EACH ROW
BEGIN
    if not new.BasicMessage is null then
        update message set AsBasicMessage = new.Lid * 2 + 1 where Mid = new.BasicMessage;
    end if;
END$$
DELIMITER ;
DROP TRIGGER IF EXISTS `cse`.`location_BEFORE_UPDATE`;

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`location_BEFORE_UPDATE` BEFORE UPDATE ON `location` FOR EACH ROW
BEGIN
    if new.BasicMessage <> old.BasicMessage then
        update message set AsBasicMessage = new.Lid * 2 + 1 where Mid = new.BasicMessage;
        if old.BasicMessage <> 0 then
            update message set AsBasicMessage = 0 where Mid = old.BasicMessage;
        end if;
    end if;
END$$
DELIMITER ;

DELIMITER $$
USE `cse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`location_BEFORE_DELETE` BEFORE DELETE ON `location` FOR EACH ROW
BEGIN
    delete from message_location where Lid = old.Lid;
    delete from information_class_location where Lid = old.Lid;
    delete from surf_location where Surf = old.Lid;
    update message set AsBasicMessage = 0 where Mid = old.BasicMessage;
    update favourite_location set favourite_location.like = null where favourite_location.like = old.Lid;
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
CREATE DEFINER = CURRENT_USER TRIGGER `cse`.`message_BEFORE_UPDATE` BEFORE UPDATE ON `message` FOR EACH ROW
BEGIN
    if new.AsBasicMessage <> 0 and old.AsBasicMessage <> 0 then
        signal sqlstate 'HY000' set message_text = '该消息已被地点类或信息类指定成为基本信息' ;
    end if;
END$$
DELIMITER ;
-- 保证不会出现一条消息被多个类指定为basicMessage


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

INSERT INTO `cse`.`profession` (`ProfessionName`, `ProfessionDescription`, `DeprecatedFlag`) VALUES ('计算机科学与技术', '暂无', '0');
INSERT INTO `cse`.`profession` (`ProfessionName`, `ProfessionDescription`, `DeprecatedFlag`) VALUES ('数据科学与大数据技术', '暂无', '0');
-- 专业的当前数据

INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (1,'','考研','个人发展','[{\"id\": 32, \"type\": \"keyword\", \"score\": 2}, {\"id\": 24, \"type\": \"keyword\", \"score\": 2}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (2,'','保研','个人发展','[{\"id\": 32, \"type\": \"keyword\", \"score\": 2}, {\"id\": 24, \"type\": \"keyword\", \"score\": 2}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (3,'','竞赛','个人发展','[{\"id\": 1, \"type\": \"keyword\", \"score\": 2}, {\"id\": 5, \"type\": \"keyword\", \"score\": 2}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (4,'','出国留学','个人发展','[{\"id\": 27, \"type\": \"keyword\", \"score\": 2}, {\"id\": 33, \"type\": \"keyword\", \"score\": 2}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (5,'','课外实践','个人提升','[{\"id\": 28, \"type\": \"keyword\", \"score\": 3}, {\"id\": 27, \"type\": \"keyword\", \"score\": 2}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (6,'','语言','个人提升','[{\"id\": 7, \"type\": \"keyword\", \"score\": 3}, {\"id\": 26, \"type\": \"keyword\", \"score\": 2}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (7,'','证书考取','个人提升','[{\"id\": 7, \"type\": \"keyword\", \"score\": 3}, {\"id\": 32, \"type\": \"keyword\", \"score\": 2}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (8,'','阅读','个人提升','[{\"id\": 7, \"type\": \"keyword\", \"score\": 1}, {\"id\": 33, \"type\": \"keyword\", \"score\": 1}, {\"id\": 8, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (9,NULL,'前端设计','专业爱好','[{\"id\": 24, \"type\": \"keyword\", \"score\": 1}, {\"id\": 23, \"type\": \"keyword\", \"score\": 1}, {\"id\": 1, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (10,NULL,'后端开发','专业爱好','[{\"id\": 24, \"type\": \"keyword\", \"score\": 1}, {\"id\": 23, \"type\": \"keyword\", \"score\": 1}, {\"id\": 1, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (11,NULL,'数据挖掘','专业爱好','[{\"id\": 24, \"type\": \"keyword\", \"score\": 1}, {\"id\": 23, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (12,NULL,'数据分析','专业爱好','[{\"id\": 24, \"type\": \"keyword\", \"score\": 1}, {\"id\": 23, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (13,NULL,'Python语言','专业爱好','[{\"id\": 6, \"type\": \"keyword\", \"score\": 1}, {\"id\": 23, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (14,NULL,'C语言','专业爱好','[{\"id\": 6, \"type\": \"keyword\", \"score\": 1}, {\"id\": 22, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (15,NULL,'C++语言','专业爱好','[{\"id\": 5, \"type\": \"keyword\", \"score\": 1}, {\"id\": 1, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (16,NULL,'Java语言','专业爱好','[{\"id\": 16, \"type\": \"keyword\", \"score\": 1}, {\"id\": 18, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (17,NULL,'实习就业','个人发展','[{\"id\": 24, \"type\": \"keyword\", \"score\": 1}, {\"id\": 34, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (18,NULL,'热爱实践，提高实践能力','性格偏好','[{\"id\": 28, \"type\": \"keyword\", \"score\": 1}, {\"id\": 23, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (19,NULL,'热爱看世界，想要增加知识广度','性格偏好','[{\"id\": 27, \"type\": \"keyword\", \"score\": 1}, {\"id\": 22, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (20,NULL,'寻觅志同道合的朋友，热爱社交','性格偏好','[{\"id\": 26, \"type\": \"keyword\", \"score\": 1}, {\"id\": 33, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (21,NULL,'挑战自我，钟情于高难度比赛','学业偏好','[{\"id\": 1, \"type\": \"keyword\", \"score\": 1}, {\"id\": 29, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (22,NULL,'渴望二进制世界，喜欢计算机技术','学业偏好','[{\"id\": 5, \"type\": \"keyword\", \"score\": 1}, {\"id\": 16, \"type\": \"keyword\", \"score\": 1}, {\"id\": 6, \"type\": \"keyword\", \"score\": 1}, {\"id\": 18, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (23,NULL,'重在参与，不强求回报','活动偏好','[{\"id\": 11, \"type\": \"keyword\", \"score\": 1}, {\"id\": 30, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (24,NULL,'高付出，高回报','活动偏好','[{\"id\": 29, \"type\": \"keyword\", \"score\": 1}, {\"id\": 9, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (25,NULL,'沉浸式活动体验','活动偏好','[{\"id\": 29, \"type\": \"keyword\", \"score\": 1}, {\"id\": 33, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (26,NULL,'沉浸式学习','学业偏好','[{\"id\": 32, \"type\": \"keyword\", \"score\": 1}, {\"id\": 24, \"type\": \"keyword\", \"score\": 1}, {\"id\": 29, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (27,NULL,'稳中求进，保证获得资源','资源偏好','[{\"id\": 20, \"type\": \"keyword\", \"score\": 1}, {\"id\": 15, \"type\": \"keyword\", \"score\": 1}]',0);
INSERT INTO cse.hobby (`Hid`,`Description`,`Name`,`Type`,`Model`,`DeprecatedFlag`) VALUES (28,NULL,'剑走偏锋，争取少数资源','资源偏好','[{\"id\": 12, \"type\": \"keyword\", \"score\": 2}, {\"id\": 21, \"type\": \"keyword\", \"score\": 2}]',0);

-- 当前兴趣爱好数据

INSERT INTO `cse`.`user` (`UserCode`, `UserPass`, `UserName`, `Grade`, `Profession`, `Sex`, `UserModel`) VALUES ('123456', '123456', 'testUser', '2020', '1', '男','[{"id": 24, "type": "keyword", "score": 2}, {"id": 34, "type": "keyword", "score": 2}, {"id": 16, "type": "keyword", "score": 3}]');
-- 默认用户

INSERT INTO `cse`.`keyword_type` (`TypeName`, `TypeResume`) VALUES ('比赛等级', '一个比赛的等级划分，通常有国、市、校');
INSERT INTO `cse`.`keyword_type` (`TypeName`, `TypeResume`) VALUES ('比赛需求', '该比赛需要的技术');
INSERT INTO `cse`.`keyword_type` (`TypeName`, `TypeResume`) VALUES ('活动综测分', '参与该活动能够提供综测分');
INSERT INTO `cse`.`keyword_type` (`Tid`, `TypeName`, `TypeResume`) VALUES ('4', '资源共享', '最早获得各类资源的一手消息，及时抓住机会，提升自我');
INSERT INTO `cse`.`keyword_type` (`Tid`, `TypeName`, `TypeResume`) VALUES ('5', '比赛专业倾向', '针对特定的专业，进行相关比赛的推荐');
INSERT INTO `cse`.`keyword_type` (`Tid`, `TypeName`, `TypeResume`) VALUES ('6', '资源数量等级', '根据数量等级，方便判断是否选择该资源');
INSERT INTO `cse`.`keyword_type` (`Tid`, `TypeName`, `TypeResume`) VALUES ('7', '资源适用人群', '针对不同年级，或者专业等一些人群特点进行划分推荐');
INSERT INTO `cse`.`keyword_type` (`Tid`, `TypeName`, `TypeResume`) VALUES ('8', '资源使用目的', '针对不同目的进行筛选推荐');
INSERT INTO `cse`.`keyword_type` (`Tid`, `TypeName`, `TypeResume`) VALUES ('9', '活动时长', '针对大家对于时间的规划，进行划分');
INSERT INTO `cse`.`keyword_type` (`Tid`, `TypeName`, `TypeResume`) VALUES ('10', '影响方向', '针对不同方向，进行资源信息筛选');
-- 关键词类型预填写

INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (1, '国赛', 1, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (2, '省赛', 1, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (3, '市赛', 1, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (4, '校赛', 1, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (5, 'C++语言', 2, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (6, '嵌入式开发', 2, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (7, '较强英语能力', 2, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (8, '文档编写', 2, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (9, '较高综测分', 3, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (10, '较低综测分', 3, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (11, '普通综测分', 3, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (12, '非常抢手', 4, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (13, '抢手', 4, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (14, '普通', 4, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (15, '不抢手', 4, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (16, '计算机专业', 5, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (17, '光电信息专业', 5, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (18, '大数据专业', 5, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (19, '数量充裕', 6, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (20, '数量适中', 6, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (21, '数量紧张', 6, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (22, '适用于大一', 7, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (23, '适用于大二大三', 7, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (24, '适用于大四', 7, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (25, '适用于研究生', 7, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (26, '社交', 8, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (27, '开阔视野', 8, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (28, '增加实践能力', 8, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (29, '时间较长，需要耐心', 9, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (30, '时间适中可以考虑', 9, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (31, '时间较短，性价比高', 9, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (32, '学习', 10, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (33, '生活', 10, null);
INSERT INTO cse.keyword (Kid, KeyName, KeywordType, KeyResume) VALUES (34, '实习、工作 ', 10, null);
-- 关键词填写






INSERT INTO `location` VALUES (1,'计算机中心','位于北校区湛恩图书馆左侧，承办计算机类的比赛，以及计算机类实验课程','http://43.143.78.169:8080/static/img/mapLid1.png',0,'http://43.143.78.169:8080/static/img/Lid1.jpg',3,27,0),(2,'图书馆','包含位于北校区的湛恩图书馆和334校区图书馆，预约功能完善，环境优美，体验沉浸式学习','http://43.143.78.169:8080/static/img/mapLid2.png',24,'http://43.143.78.169:8080/static/img/Lid2.jpg',3,30,0),(3,'第一教学楼','简称“一教”，位于580校区毛像附近，设施齐全，承办大型考试，也用于同学自习','http://43.143.78.169:8080/static/img/mapLid3.png',0,'http://43.143.78.169:8080/static/img/Lid3.jpg',27,39,0),(4,'公共服务中心','学校的大部分机关部门所在地，包含教务处，后勤管理处，财务处等重要部门','http://43.143.78.169:8080/static/img/mapLid4.png',0,'http://43.143.78.169:8080/static/img/Lid4.jpg',25,22,0),(5,'思餐厅','学校人工智能设施最完备，餐品质量，种类俱佳的餐厅之一。','http://43.143.78.169:8080/static/img/mapLid5.png',0,'http://43.143.78.169:8080/static/img/Lid5.jpg',54,39,0),(6,'五食堂','近期最新翻新修缮的食堂，新的五食堂环境干净整洁，特色菜品突出。','http://43.143.78.169:8080/static/img/mapLid6.png',0,'http://43.143.78.169:8080/static/img/Lid6.jpg',12,11,0),(7,'一食堂','学校较老旧的食堂之一，但内设最受大家欢迎的面包房，餐品香醇美味又营养。','http://43.143.78.169:8080/static/img/mapLid7.png',0,'http://43.143.78.169:8080/static/img/Lid7.jpg',21,17,0),(8,'综合楼','学校设施较老旧的一幢教学楼，但楼栋外观宏伟，且依然在承办各种大型考试，比如，专升本，四六级等。','http://43.143.78.169:8080/static/img/mapLid8.png',0,'http://43.143.78.169:8080/static/img/Lid8.jpg',29,65,0),(9,'卓越楼','学校最新修缮的几幢教学楼之一，设施完备，环境优美，体验感超级赞！','http://43.143.78.169:8080/static/img/mapLid9.png',0,'http://43.143.78.169:8080/static/img/Lid9.jpg',42,64,0),(10,'光电大楼','整个光电学院的老师的办公地点，也是整个光电学院研究生实验室所在地，外观宏伟大气，内里实验室严谨整洁。','http://43.143.78.169:8080/static/img/mapLid10.png',0,'http://43.143.78.169:8080/static/img/Lid10.jpg',15,28,0);-- 地点预填写

INSERT INTO `information_class` VALUES (1,'蓝桥杯','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid1.jpg\",\"resume\":[\"\"],\"link\":[{\"name\":\"视觉艺术设计赛\",\"url\":\"https://dasai.lanqiao.cn/pages/v7/dasai/competition/individual_competition.html\"},{\"name\":\"个人赛报名\",\"url\":\"https://dasai.lanqiao.cn/pages/v7/dasai/competition/visual_art_competition.html\"},{\"name\":\"数字科技创新赛\",\"url\":\" https://dasai.lanqiao.cn/match/innovation/sign-up/matchdetail\"},{\"name\":\"青少年创意编程组科技创新赛\",\"url\":\"https://www.lanqiaoqingshao.cn/\"}]}',4,'比赛','http://43.143.78.169:8080/static/img/Cid1.jpg','0'),(2,'互联网+','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid2.jpg\",\"resume\":[\"\"],\"link\":[{\"name\":\"报名参赛\",\"url\":\"https://cy.ncss.cn/userhome\"},{\"name\":\"寻找融资\",\"url\":\"https://cy.ncss.cn/searchinvestor\"},{\"name\":\"寻找项目\",\"url\":\" https://cy.ncss.cn/search/projects\"},{\"name\":\"寻找人才\",\"url\":\"https://job.ncss.cn/corp/signin.html\"}]}',7,'比赛','http://43.143.78.169:8080/static/img/Cid2.png','0'),(3,'数学建模','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid3.jpg\",\"resume\":[\"\"],\"link\":[{\"name\":\"报名参赛\",\"url\":\"http://www.nmmcm.org.cn/match\"},{\"name\":\"证书查询\",\"url\":\"http://www.nmmcm.org.cn/cert\"},{\"name\":\"校园大使\",\"url\":\"http://www.nmmcm.org.cn/ambassador\"},{\"name\":\"比赛官网\",\"url\":\"http://www.nmmcm.org.cn/\"}]}',15,'比赛','http://43.143.78.169:8080/static/img/Cid3.png','0'),(4,'计算机设计大赛','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid4.jpg\",\"resume\":[\"\"],\"link\":[{\"name\":\"比赛官网\",\"url\":\"http://jsjds.blcu.edu.cn/\"},{\"name\":\"大赛动态\",\"url\":\"http://jsjds.blcu.edu.cn/dsdt.htm\"},{\"name\":\"往届赛事\",\"url\":\"http://jsjds.blcu.edu.cn/wjss.htm\"},{\"name\":\"资料下载\",\"url\":\"http://jsjds.blcu.edu.cn/zlxz.htm\"}]}',12,'比赛','http://43.143.78.169:8080/static/img/Cid4.png','0'),(5,'走进海沈村活动','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid5.jpg\",\"resume\":[\"活动目的：劳动最光荣，奋斗最幸福。为了让学生树立劳动意识、增强劳动观念、养成劳动习惯。\",\"活动方式：通过沉浸式党课、户外采风和田间劳动等形式，深入了解了海沈村在实现乡村振兴这一过程中的变化和发展。\",\"活动时间：11月23号\",\"综测分：3.0\"],\"link\":[]}',89,'活动','http://43.143.78.169:8080/static/img/Cid5.png','0'),(6,'“秋炫沪江，我是光荣劳动者”活动','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid6.jpg\",\"resume\":[\"活动目的：为贯彻落实《关于全面加强新时代大中小学劳动教育的意见》等相关文件精神，通过劳动教育来强化马克思主义劳动观，牢固树立劳动最光荣、劳动最崇高、劳动最伟大、劳动最美丽的观念，引导学生养成勤奋劳动的良好习惯、享受劳动乐趣、弘扬工匠精神。\",\"活动对象：研究生\",\"综测分：2.0\"],\"link\":[]}',88,'活动','http://43.143.78.169:8080/static/img/Cid6.png','0'),(7,'打响医匠品牌活动','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid7.jpg\",\"resume\":[\"活动目的：探讨具有中国特色的“医械工匠”教育，在医疗器械自主创新新征程上踔厉前行，健康科学与工程学院生物医学工程党支部线上线下召开主题为“领悟二十大会议精神，努力奋斗建功新时代”主题党日活动。\",\"活动时间：12月14日\",\"综测分：1.0\"],\"link\":[]}',0,'活动','http://43.143.78.169:8080/static/img/Cid7.png','0'),(8,'理学院“实验大变身”活动','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid8.jpg\",\"resume\":[\"活动目的：将劳动教育和实验室安全教育紧密结合，使实验室旧貌换新颜。学院将进一步深化实验室劳动教育，落实实验室值日生制度和学生安全员制度，扎实做好实验室安全工作，全力保障学院教学、科研工作平稳有序，助力学院建设。\",\"活动时间：12月12号\",\"综测分：3.0\"],\"link\":[]}',86,'活动','http://43.143.78.169:8080/static/img/Cid8.png','0'),(9,'机房资源','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid9.jpg\",\"resume\":\"\",\"link\":[{\"name\":\"计算中心\",\"url\":\"http://cec.usst.edu.cn/\"},{\"name\":\"机房开放\",\"url\":\"http://cec.usst.edu.cn/syap/list.htm\"},{\"name\":\"机房预约\",\"url\":\"https://jsyy.usst.edu.cn/\"},{\"name\":\"计算机考试\",\"url\":\"http://cec.usst.edu.cn/#\"}]}',0,'资源','http://43.143.78.169:8080/static/img/Cid9.png','0'),(10,'光电学院挑战杯专题讲座','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid10.jpg\",\"resume\":[\"活动目的：为了进一步提升我校光电学院学生的创新精神、创业意识和创新能力,加快培养创新创业人才,持续激发大学生科技创新热情,光电学院团委特邀请校团委秘书长刘婷考师举办挑战杯专题讲座。\",\"活动地点：一食堂二楼创新创业基地\",\"活动时间：3.15 18:00-20:00p.m\",\"综测分：2.0\"],\"link\":[]}',0,'活动','http://43.143.78.169:8080/static/img/Cid10.jpg','0'),(11,'尚旅军团全员大会','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid11.jpg\",\"resume\":[\"参与须知：优秀代表发言以及最后会员线上合影的环节所有同学开摄像头,要求有海魂衫的同学穿海魂衫,考兵可以穿自己的夏季作训服,没有海魂形穿蓝色/黑色短袖。\",\"活动要求：2021-2022尚理军旅团全员大会,仅限团内部人员参加。\",\"活动时间:3.15 19:00-20:00p.m。\",\"综测分：1.0\"],\"link\":[]}',0,'活动','http://43.143.78.169:8080/static/img/Cid11.jpg','0'),(12,'教务处','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid12.jpg\",\"resume\":[\"\"],\"link\":[{\"name\":\"教务管理系统\",\"url\":\"http://jwgl.usst.edu.cn/sso/jziotlogin\"},{\"name\":\"教学日历\",\"url\":\"http://jwc.usst.edu.cn/jxrl/list.htm\"},{\"name\":\"培养计划\",\"url\":\"http://jwc.usst.edu.cn/pyjh/list.htm\"},{\"name\":\"课程中心\",\"url\":\"http://cc.usst.edu.cn/G2S/\"},{\"name\":\"一网畅学\",\"url\":\"https://1906home.usst.edu.cn/\"},{\"name\":\"语言文字\",\"url\":\"http://yywz.usst.edu.cn/\"}]}',84,'部门','http://43.143.78.169:8080/static/img/Cid12.png','0'),(13,'后勤管理处','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid13.jpg\",\"resume\":[\"\"],\"link\":[{\"name\":\"部门首页\",\"url\":\"https://zwc.usst.edu.cn/\"},{\"name\":\"办事程序\",\"url\":\"https://zwc.usst.edu.cn/1323/list.htm\"},{\"name\":\"后勤保障\",\"url\":\"https://zwc.usst.edu.cn/1339/list.htm\"},{\"name\":\"资料下载\",\"url\":\"http://zwc.usst.edu.cn/1334/list.htm\"}]}',0,'部门','http://43.143.78.169:8080/static/img/Cid13.png','0'),(14,'校长办公室','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid14.jpg\",\"resume\":[\"\"],\"link\":[{\"name\":\"部门首页\",\"url\":\"https://xb.usst.edu.cn/\"},{\"name\":\"学校领导\",\"url\":\"https://xb.usst.edu.cn/xxld/list.htm\"},{\"name\":\"学生校助\",\"url\":\"https://xb.usst.edu.cn/xsxz/list.htm\"},{\"name\":\"办事指南\",\"url\":\"https://xb.usst.edu.cn/bszn/list.htm\"}]}',0,'部门','http://43.143.78.169:8080/static/img/Cid14.png','0'),(15,'财务处','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid15.jpg\",\"resume\":[\"\"],\"link\":[{\"name\":\"部门首页\",\"url\":\"https://cwc.usst.edu.cn/\"},{\"name\":\"网上报销\",\"url\":\"http://cwbx.usst.edu.cn/SFP_Share/Home/Index\"},{\"name\":\"薪资查询\",\"url\":\"http://my.usst.edu.cn/login.portal\"},{\"name\":\"一卡通明细查询\",\"url\":\"http://cwbx.usst.edu.cn/SFP_Share/Home/Index\"},{\"name\":\"经费查询\",\"url\":\"http://cwbx.usst.edu.cn/SFP_Share/Home/Index\"}]}',0,'部门','http://43.143.78.169:8080/static/img/Cid15.png','0'),(16,'科学发展研究院','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid16.jpg\",\"resume\":[\"\"],\"link\":[{\"name\":\"部门首页\",\"url\":\"https://kjc.usst.edu.cn/main.htm\"},{\"name\":\"学术期刊\",\"url\":\"http://journals.usst.edu.cn/ch/index.aspx\"},{\"name\":\"科研管理系统\",\"url\":\"http://journals.usst.edu.cn/ch/index.aspx\"},{\"name\":\"技术转移中心\",\"url\":\"http://jszy.usst.edu.cn/\"},{\"name\":\"跨学科创新研究院\",\"url\":\"http://xtcx.usst.edu.cn/\"}]}',85,'部门','http://43.143.78.169:8080/static/img/Cid16.png','0'),(17,'学生工作部','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid17.jpg\",\"resume\":[\"\"],\"link\":[{\"name\":\"部门首页\",\"url\":\"https://xsc.usst.edu.cn/\"},{\"name\":\"辅导员队伍建设\",\"url\":\"https://xsc.usst.edu.cn/12867/list.htm\"},{\"name\":\"日常思政教育\",\"url\":\"https://xsc.usst.edu.cn/12868/list.htm\"},{\"name\":\"大学生职业发展\",\"url\":\"https://xsc.usst.edu.cn/12877/list.htm\"},{\"name\":\"心理健康教育与咨询\",\"url\":\"https://xsc.usst.edu.cn/12855/list.htm\"}]}',0,'部门','http://43.143.78.169:8080/static/img/Cid17.png','0'),(18,'创新创业学院','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid18.jpg\",\"resume\":[\"\"],\"link\":[{\"name\":\"部门首页\",\"url\":\"https://cxcy.usst.edu.cn/\"},{\"name\":\"学院概况\",\"url\":\"https://cxcy.usst.edu.cn/10216/list.htm\"},{\"name\":\"师资队伍\",\"url\":\"https://cxcy.usst.edu.cn/szdw/list.htm\"},{\"name\":\"校园活动\",\"url\":\"https://cxcy.usst.edu.cn/xyhd_10421/list.htm\"},{\"name\":\"文件下载\",\"url\":\"https://cxcy.usst.edu.cn/wjxz/list.htm\"},{\"name\":\"创业基金\",\"url\":\"https://www.stefg.org/AngelFund/Default.aspx\"}]}',90,'部门','http://43.143.78.169:8080/static/img/Cid18.png','0'),(19,'招聘资源','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid19.jpg\",\"resume\":[\"资源简介：招聘资源经常会在上半年的三月份，六月份，下半年的八月份进行举办，届时，会有百家企业来校招聘。\",\"资源数量：数量紧张\",\"资源抢手程度：资源非常抢手，深受毕业生的喜爱\",\"资源位置：体育馆\"],\"link\":[]}',0,'资源','http://43.143.78.169:8080/static/img/Cid19.jpg','0'),(20,'自习室资源','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid20.jpg\",\"resume\":[\"资源简介：为了方便大家在任何地方都有空间的位置去完成自己的学习任务，学校在宿舍楼，图书馆，教学楼，都为大家设计了自习室。\",\"资源数量：数量充裕\",\"资源抢手程度：资源只针对部分人群抢手，在很多公寓楼里，都配备有自习室。\",\"资源位置：寝室楼，图书馆\"],\"link\":[]}',0,'资源','http://43.143.78.169:8080/static/img/Cid20.jpg','0'),(21,'教室资源','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid21.jpg\",\"resume\":[\"资源简介：学校的大型教学楼有，第一教学楼，综合楼，卓越楼，国合楼等。但最常用的教学楼是综合楼，第一教学楼，卓越楼。\",\"资源数量：资源数量充裕\",\"资源抢手程度：资源相对抢手，大家都很喜欢在教室学习，学习氛围浓厚。\",\"资源位置：第一教学楼，综合楼，卓越楼\"],\"link\":[]}',0,'资源','http://43.143.78.169:8080/static/img/Cid21.jpg','0'),(22,'老师资源','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid22.jpg\",\"resume\":[\"资源简介：学校共有十位两院院士，2600多名教职工，每位老师来自国内外各大高校的毕业，专业素质过硬。\",\"资源数量：数量有限\",\"资源抢手程度：资源非常抢手，深受一些学有余力的同学的喜爱\",\"资源位置：光电大楼\"],\"link\":[]}',0,'资源','http://43.143.78.169:8080/static/img/Cid22.jpg','0'),(23,'食堂资源','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid23.jpg\",\"resume\":[\"资源简介：学校食堂餐品美味，种类繁多，尤其思餐厅，环境优美，开放时间较长。\",\"资源数量：根据不同时间段来看。在饭点，资源数量非常紧张，反之，则数量充裕。\",\"资源位置：一食堂，二食堂，五食堂，思餐厅\",\"资源时间：一食堂周六不开放，二食堂周日不开放，思餐厅全天开放。\"],\"link\":[]}',0,'资源','http://43.143.78.169:8080/static/img/Cid23.jpg','0'),(24,'课程资源','{\"imgHref\":\"http://43.143.78.169:8080/static/img/ResumeCid24.jpg\",\"resume\":[\"资源简介：学校有很多门课程都是市级，甚至国家级精品课程，也有很多课入选一流课程，值得大家去体验这些课程的课程内容及课程氛围。\",\"资源数量：数量充裕\",\"资源抢手程度：特色课程以及优秀课程都非常受欢迎，资源也相对抢手。\",\"资源位置：光电大楼，公共服务中心\"],\"link\":[]}',0,'资源','http://43.143.78.169:8080/static/img/Cid24.jpg','0');
/*!40000 ALTER TABLE `information_class` ENABLE KEYS */;-- 信息类预填写


INSERT INTO `message` VALUES (1,'蓝桥杯预选赛通知','2023-02-10 08:05:54','2023-05-07 23:59:59','\"2023-03-10 00:00:00\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"各高等院校：\"}, {\"value\": \"一、比赛科目\"}, {\"value\": \"二、考题说明\"}, {\"value\": \"三、第二期校内模拟赛举办时间及解析直播时间\"}], \"message\": \"<h3>各高等院校：</h3><p>为帮助高校学子进一步加深对蓝桥杯省赛试题的了解，提升学校的竞赛质量，大赛组委会特免费举办第十四届蓝桥杯大赛个人赛（电子类）第二期校内模拟赛。</p><h3>一、比赛科目</h3><p>（1）单片机设计与开发科目（2）嵌入式设计与开发科目（3）物联网设计与开发科目（4）EDA设计与开发科目</p><h3>二、考题说明</h3><p>本期模拟赛答题时间为5个小时，试题类型为程序设计与调试试题，试题难度接近蓝桥杯省赛阶段试题。模拟赛结束后，组委会将直播解析模拟赛试题，帮助选手了解解题思路。</p><h3>三、第二期校内模拟赛举办时间及解析直播时间</h3><p>模拟赛举办时间：2023年2月27日-2023年3月7日。解析直播时间：2023年3月10日</p>\", \"messages\": [{\"value\": \"为帮助高校学子进一步加深对蓝桥杯省赛试题的了解，提升学校的竞赛质量，大赛组委会特免费举办第十四届蓝桥杯大赛个人赛（电子类）第二期校内模拟赛。\"}, {\"value\": \"（1）单片机设计与开发科目（2）嵌入式设计与开发科目（3）物联网设计与开发科目（4）EDA设计与开发科目\"}, {\"value\": \"本期模拟赛答题时间为5个小时，试题类型为程序设计与调试试题，试题难度接近蓝桥杯省赛阶段试题。模拟赛结束后，组委会将直播解析模拟赛试题，帮助选手了解解题思路。\"}, {\"value\": \"模拟赛举办时间：2023年2月27日-2023年3月7日。解析直播时间：2023年3月10日\"}]}',0,0,'为帮助高校学子进一步加深对蓝桥杯省赛试题的了解，提升学校的竞赛质量，大赛组委会特免费举办第十四届蓝桥杯大赛个人赛（电子类）第二期校内模拟赛。'),(3,'蓝桥杯简介','2019-03-05 08:05:54','2032-10-23 08:05:54','\"\\\"\\\\\\\"2023-04-25 00:00:00\\\\\\\"\\\"\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http://43.143.78.169:8080/static/img/mid4-1.jpg\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>蓝桥杯全国软件和信息技术专业人才大赛是由中华人民共和国工业和信息化部人才交流中心主办，国信蓝桥教育科技（北京）股份有限公司承办的计算机类学科竞赛</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http://43.143.78.169:8080/static/img/mid4-1.jpg\'/><span></span></div><h3></h3><p>截至2023年2月，蓝桥杯全国软件和信息技术专业人才大赛已举办13届</p><h3></h3><p>2022年8月23日，被教育部拟确定2022—2025学年面向中小学生的全国性竞赛活动。</p>\", \"messages\": [{\"value\": \"蓝桥杯全国软件和信息技术专业人才大赛是由中华人民共和国工业和信息化部人才交流中心主办，国信蓝桥教育科技（北京）股份有限公司承办的计算机类学科竞赛\"}, {\"value\": \"截至2023年2月，蓝桥杯全国软件和信息技术专业人才大赛已举办13届\"}, {\"value\": \"2022年8月23日，被教育部拟确定2022—2025学年面向中小学生的全国性竞赛活动。\"}]}',0,0,'蓝桥杯简介'),(4,'关于第十四届蓝桥杯大赛备赛课程全新升级的通知','2022-11-14 08:45:54','2023-12-31 23:59:59','\"\\\"\\\\\\\"null\\\\\\\"\\\"\"','{\"file\": [{\"url\": \"https://www.lanqiao.cn/cup/group-activity/3/?channel_id=27\", \"name\": \"\"}, {\"url\": \"https://www.lanqiao.cn/courses/17167\", \"name\": \"\"}, {\"url\": \"https://www.lanqiao.cn/courses/17168\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid4-2.jpg\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"各参赛高校：\"}, {\"value\": \"   \\\"\"}, {\"value\": \" \\\"\"}], \"message\": \"<h3>各参赛高校：</h3><p>蓝桥杯全国软件和信息技术专业人才大赛作为全国性的IT类学科赛事，连续三年入选中国高等教育学会发布的“全国普通高校学科竞赛排行榜”，是高校教育教学改革和创新人才培养的重要竞赛项目。\\n</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid4-2.jpg\'/><span></span></div><h3>   \\\"</h3><p>第十四届蓝桥杯大赛于10月份报名启动，历时2个月，已有1000多所高校，十余万名选手报名。为帮助报名参赛选手积极备赛，在比赛中取得更好成绩，大赛组委会携手蓝桥云课为参赛选手提供紧贴大赛考点的特色备赛班课程和真题解析课程，以及校内模拟赛、名师直播、学长带练、真题联赛等活动，吸引众多选手参与。\\n\\n    同时，蓝桥杯官方备赛指南《程序设计竞赛专题挑战教程 》已于近日上线。本书面向蓝桥杯大赛个人赛软件类，覆盖算法竞赛考点，提供在线测评系统，从数据结构和算法的维度帮助备赛选手掌握编程方法和解题技巧，实现精准备赛、有效刷题。\\n</p><h3> \\\"</h3><p>蓝桥杯备赛课程实现全新升级，视频课程备考书籍强强联合助力备赛。</p>\", \"messages\": [{\"value\": \"蓝桥杯全国软件和信息技术专业人才大赛作为全国性的IT类学科赛事，连续三年入选中国高等教育学会发布的“全国普通高校学科竞赛排行榜”，是高校教育教学改革和创新人才培养的重要竞赛项目。\\n\"}, {\"value\": \"第十四届蓝桥杯大赛于10月份报名启动，历时2个月，已有1000多所高校，十余万名选手报名。为帮助报名参赛选手积极备赛，在比赛中取得更好成绩，大赛组委会携手蓝桥云课为参赛选手提供紧贴大赛考点的特色备赛班课程和真题解析课程，以及校内模拟赛、名师直播、学长带练、真题联赛等活动，吸引众多选手参与。\\n\\n    同时，蓝桥杯官方备赛指南《程序设计竞赛专题挑战教程 》已于近日上线。本书面向蓝桥杯大赛个人赛软件类，覆盖算法竞赛考点，提供在线测评系统，从数据结构和算法的维度帮助备赛选手掌握编程方法和解题技巧，实现精准备赛、有效刷题。\\n\"}, {\"value\": \"蓝桥杯备赛课程实现全新升级，视频课程备考书籍强强联合助力备赛。\"}]}',2,0,'关于第十四届蓝桥杯大赛备赛课程全新升级的通知'),(5,'第十四届蓝桥杯大赛个人赛省赛今日成功举行','2023-04-08 09:33:35','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid5-1.jpg\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid5-2.jpg\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid5-3.jpg\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid5-4.jpg\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>2023年4月8日，第十四届蓝桥杯全国软件和信息技术专业人才大赛个人赛省赛成功举办。来自全国1600多所高校的16.5万名选手顺利完成了C/C++程序设计、Java软件开发、Python程序设计、Web应用开发、软件测试、单片机设计与开发、嵌入式设计与开发、物联网设计与开发、EDA设计与开发共九大竞赛科目的比赛，展示出自己的专业实力。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid5-1.jpg\'/><span></span></div><h3></h3><p>在全面恢复正常校园生活秩序后的第一个春天，第十四届蓝桥杯大赛省赛共在全国高校设置软件类线下赛点724个，电子类线下赛点427个，其中多个赛点超1000人，最大赛点承接参赛选手2000余人。同时，本届蓝桥杯大赛还吸引来自哥本哈根大学，筑波大学，伊利诺伊大学厄巴纳-香槟分校大学，亚利桑那大学等多个海外高校的参赛选手在线上与国内选手同步竞技。无论线下还是线上，均通过线下监考及云监考方式保证比赛公平公正、有序进行。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid5-2.jpg\'/><span></span></div><h3></h3><p>本届大赛中，来自北京大学、清华大学、复旦大学、上海交通大学、中国科学院大学、中国人民大学、浙江大学、同济大学、南京大学、武汉大学、北京航空航天大学、西安交通大学等双一流高校的参赛选手达到了3万人，连续刷新蓝桥杯大赛高水平院校及学生的参赛记录。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid5-3.jpg\'/><span></span></div><h3></h3><p>蓝桥杯大赛连续第四年入选中国高等教育学会发布的“全国普通高校学科竞赛排行榜”，是高校教育教学改革和创新人才培养的重要竞赛项目。凭借科学完善的人才培养体系、权威公正的竞赛选拔标准、效果突出的人才选拔结果，蓝桥杯大赛受到越来越多的高校和选手的认可，吸引了无数优秀人才的目光和参与，每年一届的蓝桥杯大赛已成为国内计算机相关专业大学生的竞赛盛事。第十四届蓝桥杯全国软件和信息技术专业人才大赛全国总决赛将于2023年6月上旬举行，让我们保持热爱，一起期待。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid5-4.jpg\'/><span></span></div>\", \"messages\": [{\"value\": \"2023年4月8日，第十四届蓝桥杯全国软件和信息技术专业人才大赛个人赛省赛成功举办。来自全国1600多所高校的16.5万名选手顺利完成了C/C++程序设计、Java软件开发、Python程序设计、Web应用开发、软件测试、单片机设计与开发、嵌入式设计与开发、物联网设计与开发、EDA设计与开发共九大竞赛科目的比赛，展示出自己的专业实力。\"}, {\"value\": \"在全面恢复正常校园生活秩序后的第一个春天，第十四届蓝桥杯大赛省赛共在全国高校设置软件类线下赛点724个，电子类线下赛点427个，其中多个赛点超1000人，最大赛点承接参赛选手2000余人。同时，本届蓝桥杯大赛还吸引来自哥本哈根大学，筑波大学，伊利诺伊大学厄巴纳-香槟分校大学，亚利桑那大学等多个海外高校的参赛选手在线上与国内选手同步竞技。无论线下还是线上，均通过线下监考及云监考方式保证比赛公平公正、有序进行。\"}, {\"value\": \"本届大赛中，来自北京大学、清华大学、复旦大学、上海交通大学、中国科学院大学、中国人民大学、浙江大学、同济大学、南京大学、武汉大学、北京航空航天大学、西安交通大学等双一流高校的参赛选手达到了3万人，连续刷新蓝桥杯大赛高水平院校及学生的参赛记录。\"}, {\"value\": \"蓝桥杯大赛连续第四年入选中国高等教育学会发布的“全国普通高校学科竞赛排行榜”，是高校教育教学改革和创新人才培养的重要竞赛项目。凭借科学完善的人才培养体系、权威公正的竞赛选拔标准、效果突出的人才选拔结果，蓝桥杯大赛受到越来越多的高校和选手的认可，吸引了无数优秀人才的目光和参与，每年一届的蓝桥杯大赛已成为国内计算机相关专业大学生的竞赛盛事。第十四届蓝桥杯全国软件和信息技术专业人才大赛全国总决赛将于2023年6月上旬举行，让我们保持热爱，一起期待。\"}]}',0,0,'2023年4月8日，第十四届蓝桥杯全国软件和信息技术专业人才大赛个人赛省赛成功举办。'),(6,'蓝桥杯大赛连续第四年入选中国高等教育学会“全国普通高校大学生竞赛榜单”','2023-03-22 10:43:44','2023-12-31 23:59:59','\"\\\"\\\\\\\"null\\\\\\\"\\\"\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid6-1.jpg\", \"resume\": \"蓝桥杯大赛入选《2023全国普通高校大学生竞赛分析报告》竞赛目录\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p> 2023年3月22日，中国高等教育学会高校竞赛评估与管理体系研究专家工作组发布《2022全国普通高校大学生竞赛分析报告》。蓝桥杯全国软件和信息技术专业人才大赛（以下简称蓝桥杯大赛）连续第四年入选中国高等教育学会“全国普通高校大学生竞赛榜单”，成为高校教育教学改革和创新人才培养的重要竞赛项目。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid6-1.jpg\'/><span>蓝桥杯大赛入选《2023全国普通高校大学生竞赛分析报告》竞赛目录</span></div><h3></h3><p>第十四届蓝桥杯大赛目前蓝桥杯大赛是工业和信息化部人才交流中心主办的一项全国性IT类学科赛事，已经连续举办十四届，全国参赛院校1600余所，参赛选手超过80万人。蓝桥杯大赛以“立足行业，突出实践，广泛参与，促进就业”为宗旨，围绕当前社会发展急需的信息技术专业重点领域开展人才选拔工作，开设软件、电子、视觉艺术设计、数字科技创新等竞赛类别，对于培养大学生实践和创新能力、提升高校人才培养质量、加深高校实践教学模式具有促进作用。报名参赛人数已超过16万人，个人赛（软件类/电子类）省赛将于4月8日在全国各院校赛点开赛，视觉艺术设计赛及数字科技创新赛正在火热报名中（报名官网 dasai.lanqiao.cn）。</p><h3></h3><p>第十四届蓝桥杯大赛目前报名参赛人数已超过16万人，个人赛（软件类/电子类）省赛将于4月8日在全国各院校赛点开赛，视觉艺术设计赛及数字科技创新赛正在火热报名中（报名官网 dasai.lanqiao.cn）。</p>\", \"messages\": [{\"value\": \" 2023年3月22日，中国高等教育学会高校竞赛评估与管理体系研究专家工作组发布《2022全国普通高校大学生竞赛分析报告》。蓝桥杯全国软件和信息技术专业人才大赛（以下简称蓝桥杯大赛）连续第四年入选中国高等教育学会“全国普通高校大学生竞赛榜单”，成为高校教育教学改革和创新人才培养的重要竞赛项目。\"}, {\"value\": \"第十四届蓝桥杯大赛目前蓝桥杯大赛是工业和信息化部人才交流中心主办的一项全国性IT类学科赛事，已经连续举办十四届，全国参赛院校1600余所，参赛选手超过80万人。蓝桥杯大赛以“立足行业，突出实践，广泛参与，促进就业”为宗旨，围绕当前社会发展急需的信息技术专业重点领域开展人才选拔工作，开设软件、电子、视觉艺术设计、数字科技创新等竞赛类别，对于培养大学生实践和创新能力、提升高校人才培养质量、加深高校实践教学模式具有促进作用。报名参赛人数已超过16万人，个人赛（软件类/电子类）省赛将于4月8日在全国各院校赛点开赛，视觉艺术设计赛及数字科技创新赛正在火热报名中（报名官网 dasai.lanqiao.cn）。\"}, {\"value\": \"第十四届蓝桥杯大赛目前报名参赛人数已超过16万人，个人赛（软件类/电子类）省赛将于4月8日在全国各院校赛点开赛，视觉艺术设计赛及数字科技创新赛正在火热报名中（报名官网 dasai.lanqiao.cn）。\"}]}',0,0,' 2023年3月22日，中国高等教育学会高校竞赛评估与管理体系研究专家工作组发布《2022全国普通高校大学生竞赛分析报告》'),(7,'互联网+简介','2016-02-23 10:43:44','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"大赛背景\"}, {\"value\": \"创办时间：\"}, {\"value\": \"竞赛意义：\"}, {\"value\": \"竞赛目的：\"}], \"message\": \"<h3>大赛背景</h3><p>中国“互联网+”大学生创新创业大赛自2015年创办以来，累计有225万大学生、55万个团队参赛，涌现出了一大批科技含量高、市场潜力大、社会效益好的高质量项目，展现了当代青年大学生奋发有为、昂扬向上的风采，已经成为我国覆盖面最大、影响最广的大学生创新创业盛会，也开始成为国际高等教育的一道亮丽风景线。</p><h3>创办时间：</h3><p>2015年</p><h3>竞赛意义：</h3><p>中国“互联网+”大学生创新创业大赛，由教育部与政府、各高校共同主办的一项技能大赛。大赛旨在深化高等教育综合改革，激发大学生的创造力，培养造就“大众创业、万众创新”的主力军；推动赛事成果转化，促进“互联网+”新业态形成，服务经济提质增效升级；以创新引领创业、创业带动就业，推动高校毕业生更高质量创业就业。</p><h3>竞赛目的：</h3><p>以赛促教，探索人才培养新途径。全面推进高校课程思政建 设，深入推进新工科、新医科、新农科、新文科建设，不断深化创新 创业教育改革，引领各类学校人才培养范式深刻变革，形成新的人 才培养质量观和质量标准，切实提高学生的创新精神、创业意识和 创新创业能力。</p>\", \"messages\": [{\"value\": \"中国“互联网+”大学生创新创业大赛自2015年创办以来，累计有225万大学生、55万个团队参赛，涌现出了一大批科技含量高、市场潜力大、社会效益好的高质量项目，展现了当代青年大学生奋发有为、昂扬向上的风采，已经成为我国覆盖面最大、影响最广的大学生创新创业盛会，也开始成为国际高等教育的一道亮丽风景线。\"}, {\"value\": \"2015年\"}, {\"value\": \"中国“互联网+”大学生创新创业大赛，由教育部与政府、各高校共同主办的一项技能大赛。大赛旨在深化高等教育综合改革，激发大学生的创造力，培养造就“大众创业、万众创新”的主力军；推动赛事成果转化，促进“互联网+”新业态形成，服务经济提质增效升级；以创新引领创业、创业带动就业，推动高校毕业生更高质量创业就业。\"}, {\"value\": \"以赛促教，探索人才培养新途径。全面推进高校课程思政建 设，深入推进新工科、新医科、新农科、新文科建设，不断深化创新 创业教育改革，引领各类学校人才培养范式深刻变革，形成新的人 才培养质量观和质量标准，切实提高学生的创新精神、创业意识和 创新创业能力。\"}]}',4,0,'互联网+简介'),(8,'上海理工在“互联网+”全国总决赛中取得历史最好成绩','2022-12-06 11:23:24','2023-12-31 23:59:59','\"\\\"null\\\"\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid8-1.jpg\", \"resume\": \"吉尼斯世界纪录保持者“小丘”——全球首款可产业化的乒乓球机器人项目赛前根据人机对战实验结果调试机械臂\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid8-2.jpg\", \"resume\": \"中华粮安-让家乡盐碱地变为大粮仓项目团队讨论如何改进相关内容\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"‘\"}, {\"value\": \"’\"}, {\"value\": \"‘\"}], \"message\": \"<h3>‘</h3><p>2022年11月10-13日，由教育部等12家单位共同主办，重庆大学承办的第八届中国国际“互联网+”创新创业大赛总决赛在重庆举行，总决赛采用线上路演答辩的方式进行。经过激烈的网络评审、会评、金奖争夺赛等环节，我校进入全国总决赛的3个团队在高教主赛道和“青年红色筑梦之旅”赛道中斩获金奖1项、银奖2项，取得我校参赛以来最好成绩。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid8-1.jpg\'/><span>吉尼斯世界纪录保持者“小丘”——全球首款可产业化的乒乓球机器人项目赛前根据人机对战实验结果调试机械臂</span></div><h3>’</h3><p>本届大赛共有来自108个国家和地区、4554所院校的340万个项目、1450万余人次报名参赛，参赛人数首次突破千万。2022年是特殊一年，面对疫情，破难而上，我校高度重视、精心组织、广泛发动，师生参与热情高涨，全校组织1093个项目报名参加上海市赛，经过校级、市级和全国网评比赛。备赛期间，学校克服疫情影响，邀请校内外创新创业导师、创业校友、投资人等专家通过线上线下形式多次开展项目辅导、模拟演练、打磨优化，不断提升参赛项目质量，提炼项目亮点，发掘项目特色，力求精益求精。最终由季云峰、毛越、王刚等老师指导，王泰淇、葛依慧，林家靖，张邦森等同学的项目“吉尼斯世界纪录保持者‘小丘’——全球首款可产业化的乒乓球机器人”夺得高教主赛道本科生创意组金奖；李臣学、苗玉、董祥美等老师指导，郭骥、李仔艳、陈飞燕、周国庆等同学的项目“中华粮安-让家乡盐碱地变为大粮仓”；李飞鹏、刘婷、陶红等教师指导，过子怡、刘伟、李佳欣、易彩云等同学的项目“‘秸’后新生——农林固废发电底渣资源化协同利用方案”双双夺得“青年红色筑梦之旅”赛道银奖。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid8-2.jpg\'/><span>中华粮安-让家乡盐碱地变为大粮仓项目团队讨论如何改进相关内容</span></div><h3>‘</h3><p>本届大赛得到了学校主要领导、分管校领导的高度重视，并多次对参赛项目调研指导，深入比赛现场，鼓励参赛队员精心准备，敢闯敢创。</p>\", \"messages\": [{\"value\": \"2022年11月10-13日，由教育部等12家单位共同主办，重庆大学承办的第八届中国国际“互联网+”创新创业大赛总决赛在重庆举行，总决赛采用线上路演答辩的方式进行。经过激烈的网络评审、会评、金奖争夺赛等环节，我校进入全国总决赛的3个团队在高教主赛道和“青年红色筑梦之旅”赛道中斩获金奖1项、银奖2项，取得我校参赛以来最好成绩。\"}, {\"value\": \"本届大赛共有来自108个国家和地区、4554所院校的340万个项目、1450万余人次报名参赛，参赛人数首次突破千万。2022年是特殊一年，面对疫情，破难而上，我校高度重视、精心组织、广泛发动，师生参与热情高涨，全校组织1093个项目报名参加上海市赛，经过校级、市级和全国网评比赛。备赛期间，学校克服疫情影响，邀请校内外创新创业导师、创业校友、投资人等专家通过线上线下形式多次开展项目辅导、模拟演练、打磨优化，不断提升参赛项目质量，提炼项目亮点，发掘项目特色，力求精益求精。最终由季云峰、毛越、王刚等老师指导，王泰淇、葛依慧，林家靖，张邦森等同学的项目“吉尼斯世界纪录保持者‘小丘’——全球首款可产业化的乒乓球机器人”夺得高教主赛道本科生创意组金奖；李臣学、苗玉、董祥美等老师指导，郭骥、李仔艳、陈飞燕、周国庆等同学的项目“中华粮安-让家乡盐碱地变为大粮仓”；李飞鹏、刘婷、陶红等教师指导，过子怡、刘伟、李佳欣、易彩云等同学的项目“‘秸’后新生——农林固废发电底渣资源化协同利用方案”双双夺得“青年红色筑梦之旅”赛道银奖。\"}, {\"value\": \"本届大赛得到了学校主要领导、分管校领导的高度重视，并多次对参赛项目调研指导，深入比赛现场，鼓励参赛队员精心准备，敢闯敢创。\"}]}',0,0,'中华粮安-让家乡盐碱地变为大粮仓项目团队讨论如何改进相关内容'),(9,'“上理科技园杯​”第八届中国国际“互联网+”大学生创新创业大赛上海理工大学选拔赛通知','2022-04-08 08:43:24','2023-12-31 23:59:59','{\"value\": \"2022-06-10 00:00:00\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"参赛项目要求\"}, {\"value\": \"2\"}, {\"value\": \"3\"}, {\"value\": \"赛程安排\"}], \"message\": \"<h3>参赛项目要求</h3><p>1、参赛项目能够紧密结合经济社会各领域现实需求，充分体现学校在新工科、新医科、新农科、新文科建设方面取得的成果，培育新产品、新服务、新业态、新模式，促进制造业、农业、卫生、能源、环保、战略性新兴产业等产业转型升级，促进数字技术与教育、医疗、交通、金融、消费生活、文化传播等深度融合（各赛道参赛项目类型详见附件）。</p><h3>2</h3><p>参赛项目须弘扬正能量，践行社会主义核心价值观，真实、健康、合法。不得含有任何违反《中华人民共和国宪法》及其他法律法规的内容。所涉及的发明创造、专利技术、资源等必须拥有清晰合法的知识产权或物权。如有抄袭盗用他人成果、提供虚假材料等违反相关法律法规和违背大赛精神的行为，一经发现即刻丧失参赛资格、所获奖项等相关权利，并自负一切法律责任。</p><h3>3</h3><p>参赛项目只能选择一个相符的赛道报名参赛，根据参赛团队负责人的学籍或学历确定参赛团队所代表的参赛学校，且代表的参赛学校具有唯一性。参赛团队须在报名系统中将项目所涉及的材料按时如实填写提交。已获本大赛往届总决赛各赛道金奖和银奖的项目，不可报名参加本届大赛。</p><h3>赛程安排</h3><p>校内“选拔赛”（6月05日-16日）。6月06日学校对参赛项目进行网上初选，6月12日公布入围校内选拔赛复赛名单；6月15日举行校内“选拔赛”复赛项目答辩路演，地点待定，根据答辩结果公布进入下一轮名单和创业训练营名单。</p>\", \"messages\": [{\"value\": \"1、参赛项目能够紧密结合经济社会各领域现实需求，充分体现学校在新工科、新医科、新农科、新文科建设方面取得的成果，培育新产品、新服务、新业态、新模式，促进制造业、农业、卫生、能源、环保、战略性新兴产业等产业转型升级，促进数字技术与教育、医疗、交通、金融、消费生活、文化传播等深度融合（各赛道参赛项目类型详见附件）。\"}, {\"value\": \"参赛项目须弘扬正能量，践行社会主义核心价值观，真实、健康、合法。不得含有任何违反《中华人民共和国宪法》及其他法律法规的内容。所涉及的发明创造、专利技术、资源等必须拥有清晰合法的知识产权或物权。如有抄袭盗用他人成果、提供虚假材料等违反相关法律法规和违背大赛精神的行为，一经发现即刻丧失参赛资格、所获奖项等相关权利，并自负一切法律责任。\"}, {\"value\": \"参赛项目只能选择一个相符的赛道报名参赛，根据参赛团队负责人的学籍或学历确定参赛团队所代表的参赛学校，且代表的参赛学校具有唯一性。参赛团队须在报名系统中将项目所涉及的材料按时如实填写提交。已获本大赛往届总决赛各赛道金奖和银奖的项目，不可报名参加本届大赛。\"}, {\"value\": \"校内“选拔赛”（6月05日-16日）。6月06日学校对参赛项目进行网上初选，6月12日公布入围校内选拔赛复赛名单；6月15日举行校内“选拔赛”复赛项目答辩路演，地点待定，根据答辩结果公布进入下一轮名单和创业训练营名单。\"}]}',0,0,'选拔赛通知'),(10,'学校召开第八届中国国际“互联网+” 大学生创新创业大赛校赛启动动员会','2022-03-23 09:45:14','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid9-1.jpg\", \"resume\": \"张华讲话\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid9-2.jpg\", \"resume\": \"会议现场\"}], \"title\": [{\"value\": \"·\"}, {\"value\": \"·\"}], \"message\": \"<h3>·</h3><p>学校召开第八届中国国际“互联网+” 大学生创新创业大赛校赛启动动员会</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid9-1.jpg\'/><span>张华讲话</span></div><h3>·</h3><p>会议伊始，张华副校长对大赛做了动员，他结合国家形势和有关政策，分析了大赛举办的时代背景和重要意义，对学校创新创业教育工作进行了概括总结和肯定。并对大赛提了三点要求：一是各学院要压实工作责任，部门之间的配合协调要通畅，责任分工要具体；要严格遵守防疫政策，大赛培训辅导等要线上线下结合同步进行。二是要做好项目挖掘、筛选与推荐工作，鼓励教师将科技成果产业化，带领学生创新创业。三是参赛学生要关注国家和社会的创新发展，将自身发展融入时代发展的脉络，要利用好校内校外资源，敢于在创赛中实习实践。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid9-2.jpg\'/><span>会议现场</span></div>\", \"messages\": [{\"value\": \"学校召开第八届中国国际“互联网+” 大学生创新创业大赛校赛启动动员会\"}, {\"value\": \"会议伊始，张华副校长对大赛做了动员，他结合国家形势和有关政策，分析了大赛举办的时代背景和重要意义，对学校创新创业教育工作进行了概括总结和肯定。并对大赛提了三点要求：一是各学院要压实工作责任，部门之间的配合协调要通畅，责任分工要具体；要严格遵守防疫政策，大赛培训辅导等要线上线下结合同步进行。二是要做好项目挖掘、筛选与推荐工作，鼓励教师将科技成果产业化，带领学生创新创业。三是参赛学生要关注国家和社会的创新发展，将自身发展融入时代发展的脉络，要利用好校内校外资源，敢于在创赛中实习实践。\"}]}',0,0,'互联网+校赛启动动员会'),(11,'第八届互联网+预参赛手册','2021-11-20 11:35:43','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"https://cxcy.usst.edu.cn/_upload/article/files/53/01/f90205994ec4b58240677f6752db/c2a010a9-8bd3-4079-92c7-be6285f3b69f.pdf\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid10-1.jpg\", \"resume\": \"参赛位置\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>参赛手册及地址如下</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid10-1.jpg\'/><span>参赛位置</span></div>\", \"messages\": [{\"value\": \"参赛手册及地址如下\"}]}',0,0,'第八届互联网+预参赛手册下载链接'),(12,'计算机设计大赛简介','2019-12-07 09:45:44','2032-10-07 08:05:54','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>中国大学生计算机设计大赛是由教育部高等学校计算机类专业教学指导委员会、教育部高等\\n学校软件工程专业教学指导委员会、教育部高等学校大学计算机课程教学指导委员会、教育部高等\\n学校文科计算机基础教学指导分委员会、中国教育电视台联合主办。\\n</p>\", \"messages\": [{\"value\": \"中国大学生计算机设计大赛是由教育部高等学校计算机类专业教学指导委员会、教育部高等\\n学校软件工程专业教学指导委员会、教育部高等学校大学计算机课程教学指导委员会、教育部高等\\n学校文科计算机基础教学指导分委员会、中国教育电视台联合主办。\\n\"}]}',8,0,'计算机设计大赛简介'),(13,'关于举办“2023年（第16届）中国大学生计算机设计大赛”的通知','2022-11-08 08:35:04','2023-12-31 23:59:59','\"\\\"\\\\\\\"null\\\\\\\"\\\"\"','{\"file\": [{\"url\": \"http://jsjds.blcu.edu.cn/system/_content/download.jsp?urltype=news.DownloadAttachUrl&owner=1825439128&wbfileid=11773146\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/第9页-14.png\", \"resume\": \"\"}], \"title\": [{\"value\": \"各相关院校、省（直辖市、自治区）赛区、省级联赛区：\"}, {\"value\": \"·\"}, {\"value\": \"\"}], \"message\": \"<h3>各相关院校、省（直辖市、自治区）赛区、省级联赛区：</h3><p>中国大学生计算机设计大赛是我国高校面向本科生最早的赛事之一，是全国普通高校大学生竞赛排行榜榜单赛事之一。自2008年开赛至2019年，一直由教育部高校与计算机相关教指委等或独立或联合主办。大赛的目的是以赛促学、以赛促教、以赛促创，为国家培养德智体美劳全面发展的创新型、复合型、应用型人才服务。</p><h3>·</h3><p>2023年（第16届）中国大学生计算机设计大赛是由北京语言大学、中国人民大学、华东师范大学、东南大学、厦门大学、山东大学、东北大学等高校，以及清华大学、北京大学等高校的教师组成的中国大学生计算机设计大赛组织委员会主办，参赛对象为中国境内高校2023年在籍的所有本科生（含港、澳、台学生及留学生）。大赛以三级竞赛形式开展，校级赛——省级赛——国家级赛（简称“国赛”）。国赛只接受省级赛上推的本科生的参赛作品。\\n\\n</p><h3></h3><p>2023年大赛分设11个大类，分别是：（1）软件应用与开发；（2）微课与教学辅助；（3）物联网应用；（4）大数据应用；（5）人工智能应用；（6）信息可视化设计；（7）数媒静态设计；（8）数媒动漫与短片；（9）数媒游戏与交互设计；（10）计算机音乐创作；（11）国际生“学汉语，写汉字”。详见附件1～附件3。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/第9页-14.png\'/><span></span></div>\", \"messages\": [{\"value\": \"中国大学生计算机设计大赛是我国高校面向本科生最早的赛事之一，是全国普通高校大学生竞赛排行榜榜单赛事之一。自2008年开赛至2019年，一直由教育部高校与计算机相关教指委等或独立或联合主办。大赛的目的是以赛促学、以赛促教、以赛促创，为国家培养德智体美劳全面发展的创新型、复合型、应用型人才服务。\"}, {\"value\": \"2023年（第16届）中国大学生计算机设计大赛是由北京语言大学、中国人民大学、华东师范大学、东南大学、厦门大学、山东大学、东北大学等高校，以及清华大学、北京大学等高校的教师组成的中国大学生计算机设计大赛组织委员会主办，参赛对象为中国境内高校2023年在籍的所有本科生（含港、澳、台学生及留学生）。大赛以三级竞赛形式开展，校级赛——省级赛——国家级赛（简称“国赛”）。国赛只接受省级赛上推的本科生的参赛作品。\\n\\n\"}, {\"value\": \"2023年大赛分设11个大类，分别是：（1）软件应用与开发；（2）微课与教学辅助；（3）物联网应用；（4）大数据应用；（5）人工智能应用；（6）信息可视化设计；（7）数媒静态设计；（8）数媒动漫与短片；（9）数媒游戏与交互设计；（10）计算机音乐创作；（11）国际生“学汉语，写汉字”。详见附件1～附件3。\"}]}',0,0,'开赛通知'),(14,'我校在第十五届中国大学生计算机设计大赛中获佳绩','2022-09-21 11:05:14','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid14-1.jpg\", \"resume\": \"杭州赛区获奖名单（部分）\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid14-1.jpg\", \"resume\": \"厦门赛区获奖名单（部分）\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"`\"}, {\"value\": \"`\"}, {\"value\": \"`\"}, {\"value\": \"`\"}], \"message\": \"<h3>`</h3><p>9月9日，2022年(第15届)中国大学生计算机设计大赛组委会公布比赛结果，我校参赛学生朱子豪等近30位同学，在杨桂松、孔祥勇、袁健、曹春萍、周春樵等老师的指导下，从众多高水平参赛队伍中脱颖而出，最终获全国二等奖7项、三等奖3项，取得新突破。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid14-1.jpg\'/><span>杭州赛区获奖名单（部分）</span></div><h3>`</h3><p>大赛吸引了全国近 850 所院校2475支队伍报名参赛，从3万多件作品中选出4506件获奖作品。770 余人次评审专家从作品选题的新颖性、创新性、实用意义，作品设计的合理性、作品制作及功能实现等方面进行综合评价，评出最终奖项。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid14-1.jpg\'/><span>厦门赛区获奖名单（部分）</span></div><h3>`</h3><p>2022年春季学期，上海疫情严重影响到比赛作品的制作和调试进度，备赛过程艰难，在光电学院大赛工作组的统一部署下，在创新创业学院（实验中心）鼓励和支持下，参赛队员通过线上线下（资料和素材由快递完成发送）接收装备，利用有限的时间，积极备战，攻坚克难。</p><h3>`</h3><p>2022年春季学期，上海疫情严重影响到比赛作品的制作和调试进度，备赛过程艰难，在光电学院大赛工作组的统一部署下，在创新创业学院（实验中心）鼓励和支持下，参赛队员通过线上线下（资料和素材由快递完成发送）接收装备，利用有限的时间，积极备战，攻坚克难。</p>\", \"messages\": [{\"value\": \"9月9日，2022年(第15届)中国大学生计算机设计大赛组委会公布比赛结果，我校参赛学生朱子豪等近30位同学，在杨桂松、孔祥勇、袁健、曹春萍、周春樵等老师的指导下，从众多高水平参赛队伍中脱颖而出，最终获全国二等奖7项、三等奖3项，取得新突破。\"}, {\"value\": \"大赛吸引了全国近 850 所院校2475支队伍报名参赛，从3万多件作品中选出4506件获奖作品。770 余人次评审专家从作品选题的新颖性、创新性、实用意义，作品设计的合理性、作品制作及功能实现等方面进行综合评价，评出最终奖项。\"}, {\"value\": \"2022年春季学期，上海疫情严重影响到比赛作品的制作和调试进度，备赛过程艰难，在光电学院大赛工作组的统一部署下，在创新创业学院（实验中心）鼓励和支持下，参赛队员通过线上线下（资料和素材由快递完成发送）接收装备，利用有限的时间，积极备战，攻坚克难。\"}, {\"value\": \"2022年春季学期，上海疫情严重影响到比赛作品的制作和调试进度，备赛过程艰难，在光电学院大赛工作组的统一部署下，在创新创业学院（实验中心）鼓励和支持下，参赛队员通过线上线下（资料和素材由快递完成发送）接收装备，利用有限的时间，积极备战，攻坚克难。\"}]}',0,0,'第十五届计算机设计大赛获佳绩'),(15,'数学建模比赛简介','2015-10-07 08:05:54','2032-10-07 08:05:54','\"\\\"null\\\"\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"`\"}, {\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3>`</h3><p>1、全称“高教社杯”全国大学生数学建模竞赛（每年9月中上旬） 无论从参赛队伍数量还是质量来看\\n都是最大型的数学建模竞赛，近些年每年大约4-5万个队伍参加，覆盖绝大多数本专科学校。同时\\n也是含金量最高的数模竞赛，在大学生竞赛排名榜上排名前五，仅次于互联网+、挑战杯和ACM，\\n绝大部分学校都非常认可，无论是保研还是综合测评都能加分，甚至小部分学校获得国奖可以直接\\n拿到保研资格。</p><h3></h3><p>、美赛，Mathematical Contest In Modeling/Interdisciplinary Contest In Modeling，简称\\nMCM/ICM。其中MCM为数学建模，ICM为交叉学科建模。（每年2月份）美赛相较国赛来说含金\\n量稍微低了一点，但也是除国赛外参与人数最多、认可度最高的比赛了。美赛更看重论文的创新型\\n和美观度，因此准备的时候要注意模型的创新型以及数据和结果的可视化。另外由于美赛是全英写\\n作，故一定要留出足够的时间进行论文的写作与翻译。认可度方面，大部分学校H奖以上保研可以\\n加分，少数学校O/F可以直接获得保研资格。</p><h3></h3><p>3、MathorCup高校数学建模竞赛（每年4月），该比赛主办单位是“中国优选法统筹法与经济数学\\n研究会”，为国家一级学会，级别非常高。同时，举办届数超过10届，参赛队伍也较多。</p><h3></h3><p>.</p>\", \"messages\": [{\"value\": \"1、全称“高教社杯”全国大学生数学建模竞赛（每年9月中上旬） 无论从参赛队伍数量还是质量来看\\n都是最大型的数学建模竞赛，近些年每年大约4-5万个队伍参加，覆盖绝大多数本专科学校。同时\\n也是含金量最高的数模竞赛，在大学生竞赛排名榜上排名前五，仅次于互联网+、挑战杯和ACM，\\n绝大部分学校都非常认可，无论是保研还是综合测评都能加分，甚至小部分学校获得国奖可以直接\\n拿到保研资格。\"}, {\"value\": \"、美赛，Mathematical Contest In Modeling/Interdisciplinary Contest In Modeling，简称\\nMCM/ICM。其中MCM为数学建模，ICM为交叉学科建模。（每年2月份）美赛相较国赛来说含金\\n量稍微低了一点，但也是除国赛外参与人数最多、认可度最高的比赛了。美赛更看重论文的创新型\\n和美观度，因此准备的时候要注意模型的创新型以及数据和结果的可视化。另外由于美赛是全英写\\n作，故一定要留出足够的时间进行论文的写作与翻译。认可度方面，大部分学校H奖以上保研可以\\n加分，少数学校O/F可以直接获得保研资格。\"}, {\"value\": \"3、MathorCup高校数学建模竞赛（每年4月），该比赛主办单位是“中国优选法统筹法与经济数学\\n研究会”，为国家一级学会，级别非常高。同时，举办届数超过10届，参赛队伍也较多。\"}, {\"value\": \".\"}]}',6,0,'数学建模比赛简介'),(16,'数学建模竞赛证书领取','2022-09-22 15:35:24','2023-12-31 23:59:59','\"\\\"\\\\\\\"null\\\\\\\"\\\"\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/第11页-17.png\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>关于2021亚太杯数学建模、2021MathorCup大数据赛、2022MathorCup数学建模、2022华数杯\\n数学建模竞赛证书领取通知</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/第11页-17.png\'/><span></span></div>\", \"messages\": [{\"value\": \"关于2021亚太杯数学建模、2021MathorCup大数据赛、2022MathorCup数学建模、2022华数杯\\n数学建模竞赛证书领取通知\"}]}',0,0,'数学建模竞赛证书领取'),(17,'2022年上海理工大学数学建模校内选拔赛全国赛报名通知','2022-04-26 13:25:04','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/第13页-20.png\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>2022年上海理工大学数学建模校内选拔赛（华东杯） 获奖名单暨全国赛报名通知</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/第13页-20.png\'/><span></span></div>\", \"messages\": [{\"value\": \"2022年上海理工大学数学建模校内选拔赛（华东杯） 获奖名单暨全国赛报名通知\"}]}',0,0,'获奖名单与报名通知'),(18,'我校学子获2021年美国大学生数学建模竞赛一等奖','2021-04-27 18:45:32','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid18-1.jpg\", \"resume\": \"一等奖奖状\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid18-2.jpg\", \"resume\": \"一等奖奖状\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>我校学子获2021年美国大学生数学建模竞赛一等奖</p><h3></h3><p>美国大学生数学建模竞赛是数学建模领域内的国际性权威赛事，由美国自然基金协会和美国数学应用协会共同主办，享有数学建模“奥林匹克”之称，旨在鼓励大学生对范围不固定的各种实际问题予以阐明、分析并提出解法。2021年度赛事吸引了来自全球22个国家，1641所学校，26112个队伍参赛，参赛人数超7.8万人。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid18-1.jpg\'/><span>一等奖奖状</span></div><h3></h3><p>面对全世界著名高校优秀学生参与的奖项角逐，我校学生取得优异成绩，再一次展示了我校大学生的创新能力，见证了近年来的学校教学改革成效。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid18-2.jpg\'/><span>一等奖奖状</span></div>\", \"messages\": [{\"value\": \"我校学子获2021年美国大学生数学建模竞赛一等奖\"}, {\"value\": \"美国大学生数学建模竞赛是数学建模领域内的国际性权威赛事，由美国自然基金协会和美国数学应用协会共同主办，享有数学建模“奥林匹克”之称，旨在鼓励大学生对范围不固定的各种实际问题予以阐明、分析并提出解法。2021年度赛事吸引了来自全球22个国家，1641所学校，26112个队伍参赛，参赛人数超7.8万人。\"}, {\"value\": \"面对全世界著名高校优秀学生参与的奖项角逐，我校学生取得优异成绩，再一次展示了我校大学生的创新能力，见证了近年来的学校教学改革成效。\"}]}',0,0,'荣获美赛一等奖'),(19,'校内比价GB22012--第一教学楼6楼数学建模及数学创新实验室装修','2022-09-01 14:15:44','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"一、项目概况\"}, {\"value\": \"二、合格的供应商必须符合以下条件：\"}], \"message\": \"<h3>一、项目概况</h3><p>1、项目名称：第一教学楼6楼数学建模及数学创新实验室装修2、校内比价单号：GB22012\\n\\n3、项目基本概况介绍：\\n\\n为满足学院对于相关科研及教学任务的推进要求，计划对第一教学楼6楼教室进行翻新装修，主要内容包括拆除原有房间装修，新做板隔墙，顶棚喷漆，新做吊顶，新做相关水电线路等。4、采购金额：本项目采购限价为9.56万元，超过采购限价的报价不予接受 。5、工期要求：15天。</p><h3>二、合格的供应商必须符合以下条件：</h3><p>1、供应商资质条件：须为“上海理工大学2021~2023年度修缮工程和弱电工程（限额以下）（包件一：上海理工大学2021~2023年度修缮工程）（招投标单号：GD21013）”的中标单位；\\n\\n2、项目负责人资格：拟派项目负责人具备建筑工程专业二级（含以上级）注册建造师执业资格和有效的安全生产考核合格证书；且与入围“上海理工大学2021~2023年度修缮工程和弱电工程（限额以下）（包件一：上海理工大学2021~2023年度修缮工程）（招投标单号：GD21013）”时拟派的项目负责人一致。</p>\", \"messages\": [{\"value\": \"1、项目名称：第一教学楼6楼数学建模及数学创新实验室装修2、校内比价单号：GB22012\\n\\n3、项目基本概况介绍：\\n\\n为满足学院对于相关科研及教学任务的推进要求，计划对第一教学楼6楼教室进行翻新装修，主要内容包括拆除原有房间装修，新做板隔墙，顶棚喷漆，新做吊顶，新做相关水电线路等。4、采购金额：本项目采购限价为9.56万元，超过采购限价的报价不予接受 。5、工期要求：15天。\"}, {\"value\": \"1、供应商资质条件：须为“上海理工大学2021~2023年度修缮工程和弱电工程（限额以下）（包件一：上海理工大学2021~2023年度修缮工程）（招投标单号：GD21013）”的中标单位；\\n\\n2、项目负责人资格：拟派项目负责人具备建筑工程专业二级（含以上级）注册建造师执业资格和有效的安全生产考核合格证书；且与入围“上海理工大学2021~2023年度修缮工程和弱电工程（限额以下）（包件一：上海理工大学2021~2023年度修缮工程）（招投标单号：GD21013）”时拟派的项目负责人一致。\"}]}',0,0,'第一教学楼校内比价'),(20,'关于3月27日至31日第一教学楼、综合楼临时封闭的公告','2022-03-27 13:25:04','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid20-1.jpg\", \"resume\": \"\"}], \"title\": [{\"value\": \"尊敬的各位老师、同学们：\"}], \"message\": \"<h3>尊敬的各位老师、同学们：</h3><p>我校下周举行2022年硕士研究生招生考试复试，第一教学楼及综合楼将进行封闭管理，封闭期为3月27日至3月31日。根据当前疫情防控形势的需要，经学校研究决定，拟将复试区域与校园完全隔离，以保证校内师生的安全。有自习需要的同学可以前往图书馆、国合楼或卓越楼。校区的临时穿行通道设在第一教学楼西侧入口附近，详见附图。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid20-1.jpg\'/><span></span></div>\", \"messages\": [{\"value\": \"我校下周举行2022年硕士研究生招生考试复试，第一教学楼及综合楼将进行封闭管理，封闭期为3月27日至3月31日。根据当前疫情防控形势的需要，经学校研究决定，拟将复试区域与校园完全隔离，以保证校内师生的安全。有自习需要的同学可以前往图书馆、国合楼或卓越楼。校区的临时穿行通道设在第一教学楼西侧入口附近，详见附图。\"}]}',0,0,'第一教学楼临时封闭通知'),(21,'第一教学楼停电通知','2021-01-02 09:00:00','2023-12-31 23:59:59','\"\\\"null\\\"\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"全校师生：\"}], \"message\": \"<h3>全校师生：</h3><p>为配合新建体育健身中心桩基工程施工，定于2021年1月2日上午9：00-12:00接驳临时施工用电。届时，第一教学楼西侧半栋楼宇将会停电</p>\", \"messages\": [{\"value\": \"为配合新建体育健身中心桩基工程施工，定于2021年1月2日上午9：00-12:00接驳临时施工用电。届时，第一教学楼西侧半栋楼宇将会停电\"}]}',0,0,'关于第一教学楼停电的通知'),(22,'关于第一教学楼自习教室延长开放的通知','2020-08-17 00:00:00','2023-12-31 23:59:59','\"\\\"null\\\"\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"全校学生：\"}], \"message\": \"<h3>全校学生：</h3><p>近期天气炎热，为了给广大学生提供舒适凉爽的自习环境，营造良好的学习环境，后勤管理处特将第一教学楼133、137、144、146自习教室的开放时间延长至晚12点，8月17日（周一）起执行，其余教室开放时间不变。</p>\", \"messages\": [{\"value\": \"近期天气炎热，为了给广大学生提供舒适凉爽的自习环境，营造良好的学习环境，后勤管理处特将第一教学楼133、137、144、146自习教室的开放时间延长至晚12点，8月17日（周一）起执行，其余教室开放时间不变。\"}]}',0,0,'第一教学楼自习室延长开放通知'),(23,'上海理工大学第一教学楼维修工程施工项目中标公告','2019-05-31 13:55:42','2023-12-31 23:59:59','\"\\\"null\\\"\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"一、项目名称：\"}, {\"value\": \"二、中标信息：\"}, {\"value\": \"三、评标日期：\"}, {\"value\": \"四、评标地点：\"}, {\"value\": \"五、评审专家：\"}], \"message\": \"<h3></h3><p>上海理工大学第一教学楼维修工程施工项目中标公告</p><h3>一、项目名称：</h3><p>第一教学楼维修工程施工项目</p><h3>二、中标信息：</h3><p>中标单位：上海市地江建设工程有限公司\\n\\n中标金额：27626010元</p><h3>三、评标日期：</h3><p>李昀、郭绍华、张浚元、归莉珺、吴文忠、唐洁耀、苏海华</p><h3>四、评标地点：</h3><p>李昀、郭绍华、张浚元、归莉珺、吴文忠、唐洁耀、苏海华</p><h3>五、评审专家：</h3><p>李昀、郭绍华、张浚元、归莉珺、吴文忠、唐洁耀、苏海华</p>\", \"messages\": [{\"value\": \"上海理工大学第一教学楼维修工程施工项目中标公告\"}, {\"value\": \"第一教学楼维修工程施工项目\"}, {\"value\": \"中标单位：上海市地江建设工程有限公司\\n\\n中标金额：27626010元\"}, {\"value\": \"李昀、郭绍华、张浚元、归莉珺、吴文忠、唐洁耀、苏海华\"}, {\"value\": \"李昀、郭绍华、张浚元、归莉珺、吴文忠、唐洁耀、苏海华\"}, {\"value\": \"李昀、郭绍华、张浚元、归莉珺、吴文忠、唐洁耀、苏海华\"}]}',0,0,'第一教学楼维修中标公告'),(24,'图书馆简介','2022-07-26 13:15:04','2032-10-07 08:05:54','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid24-1.jpg\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid24-2.jpg\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>1928年2月25日，沪江大学首任华人校长刘湛恩博士就职典礼后，举行图书馆破土礼。同年9月竣工，耗资4万美元。1948年图书馆向东扩建，次年启用。命名为“湛恩纪念图书馆”，纪念为国殉难的刘湛恩校长。</p><h3></h3><p>1928年2月25日，沪江大学首任华人校长刘湛恩博士就职典礼后，举行图书馆破土礼。同年9月竣工，耗资4万美元。1948年图书馆向东扩建，次年启用。命名为“湛恩纪念图书馆”，纪念为国殉难的刘湛恩校长。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid24-1.jpg\'/><span></span></div><h3></h3><p>整座建筑有两层，支架为全钢骨建筑，非常牢固。馆内设施先进，两层间用升降机传递图书，方便快捷。软木地板上铺有油地毡，墙壁四周装了暖气片。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid24-2.jpg\'/><span></span></div>\", \"messages\": [{\"value\": \"1928年2月25日，沪江大学首任华人校长刘湛恩博士就职典礼后，举行图书馆破土礼。同年9月竣工，耗资4万美元。1948年图书馆向东扩建，次年启用。命名为“湛恩纪念图书馆”，纪念为国殉难的刘湛恩校长。\"}, {\"value\": \"1928年2月25日，沪江大学首任华人校长刘湛恩博士就职典礼后，举行图书馆破土礼。同年9月竣工，耗资4万美元。1948年图书馆向东扩建，次年启用。命名为“湛恩纪念图书馆”，纪念为国殉难的刘湛恩校长。\"}, {\"value\": \"整座建筑有两层，支架为全钢骨建筑，非常牢固。馆内设施先进，两层间用升降机传递图书，方便快捷。软木地板上铺有油地毡，墙壁四周装了暖气片。\"}]}',5,0,'图书馆官方介绍'),(25,'图书馆寒假服务安排表','2023-01-06 11:53:03','2023-12-31 23:59:59','\"\\\"\\\\\\\"null\\\\\\\"\\\"\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid25-1.jpg\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>本学期末1月6日各部室开放时间为8:00～16:45，双休日1月7、8日不开放。 下学期初2月9～2月10日各部室开放时间为8:00～16:45；双休日2月11、12日不开放。2月13日(周一)起正常开放。</p><h3></h3><p>表中各部门有*号为寒假期间（1月9日～2月8日）开放日，工作时间9:30～15:30。</p><h3></h3><p>表中各部门有*号为寒假期间（1月9日～2月8日）开放日，工作时间9:30～15:30。</p><h3></h3><p>自修室开放日服务时间：8:00～23:00。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid25-1.jpg\'/><span></span></div>\", \"messages\": [{\"value\": \"本学期末1月6日各部室开放时间为8:00～16:45，双休日1月7、8日不开放。 下学期初2月9～2月10日各部室开放时间为8:00～16:45；双休日2月11、12日不开放。2月13日(周一)起正常开放。\"}, {\"value\": \"表中各部门有*号为寒假期间（1月9日～2月8日）开放日，工作时间9:30～15:30。\"}, {\"value\": \"表中各部门有*号为寒假期间（1月9日～2月8日）开放日，工作时间9:30～15:30。\"}, {\"value\": \"自修室开放日服务时间：8:00～23:00。\"}]}',0,0,'图书馆2023年寒假期间服务安排表'),(26,'图书馆X2！回来了！','2022-12-24 09:31:24','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid26-4.jpg\", \"resume\": \"湛恩纪念图书馆一楼自助选座机\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid26-2.jpg\", \"resume\": \"\"}], \"title\": [{\"value\": \"湛恩纪念图书馆\"}, {\"value\": \"南区图书馆\"}], \"message\": \"<h3>湛恩纪念图书馆</h3><p>还在担心人太多找不到余座?\\n\\n智能化选座系统助力图书馆升级。Welink二维码扫扫，便知座位情况。提前预订座位，科学又便捷。每座一码，不留死角。安心落座，畅心学习</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid26-4.jpg\'/><span>湛恩纪念图书馆一楼自助选座机</span></div><h3>南区图书馆</h3><p>新装修的自习空间，位于军工路校区南区，经管大楼北楼，1至5层，考虑到南区研究生较多的情况，图书馆为研究生同学们量身打造了，私密性极佳的，研修学习空间</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid26-2.jpg\'/><span></span></div>\", \"messages\": [{\"value\": \"还在担心人太多找不到余座?\\n\\n智能化选座系统助力图书馆升级。Welink二维码扫扫，便知座位情况。提前预订座位，科学又便捷。每座一码，不留死角。安心落座，畅心学习\"}, {\"value\": \"新装修的自习空间，位于军工路校区南区，经管大楼北楼，1至5层，考虑到南区研究生较多的情况，图书馆为研究生同学们量身打造了，私密性极佳的，研修学习空间\"}]}',0,0,'湛恩纪念图书馆，南区图书馆开放通知'),(27,'图书馆获中国大学生在线“悦读青春”展示活动“最美图书馆”称号','2022-09-14 08:18:49','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid27-1\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>日前，我校图书馆荣获教育部中国大学生在线主办的2022年“悦读青春”全国百场百所百名读书特色推选展示活动“最美图书馆”称号。该活动共收到213所高校提交的1757件作品，覆盖了29个省（自治区、直辖市）和新疆生产建设兵团。经专家遴选、结果公示等程序，最终评选出“最美图书馆奖”82名。</p><h3></h3><p>活动中，我校图书馆充分展现其在大学中的读书育人作用和举办的丰富多彩的特色活动。通过“视频+图文”形式，以“图书馆——文化传播的阵地”为主题，介绍了图书馆的文化基因与历史传承，通过丰富的阅读推广、人文教育活动、文化空间育人案例，全面立体地展现了图书馆发展新气象，凸显人文底蕴浓厚、文化特色鲜明的特点。</p><h3></h3><p>为用好刘湛恩烈士故居红色文化资源，讲好大学图书馆奋进追梦的精彩故事，图书馆人始终践行“读者第一 、服务育人”的理念，勇于承担“滋养民族心灵、培育文化自信”的使命，脚踏实地，奋发有为，力求把图书馆建设成为学校“文化传播”和“三全育人”的重要阵地，为加快推进学校建设一流理工科大学的目标贡献图书馆的力量。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid27-1\'/><span></span></div>\", \"messages\": [{\"value\": \"日前，我校图书馆荣获教育部中国大学生在线主办的2022年“悦读青春”全国百场百所百名读书特色推选展示活动“最美图书馆”称号。该活动共收到213所高校提交的1757件作品，覆盖了29个省（自治区、直辖市）和新疆生产建设兵团。经专家遴选、结果公示等程序，最终评选出“最美图书馆奖”82名。\"}, {\"value\": \"活动中，我校图书馆充分展现其在大学中的读书育人作用和举办的丰富多彩的特色活动。通过“视频+图文”形式，以“图书馆——文化传播的阵地”为主题，介绍了图书馆的文化基因与历史传承，通过丰富的阅读推广、人文教育活动、文化空间育人案例，全面立体地展现了图书馆发展新气象，凸显人文底蕴浓厚、文化特色鲜明的特点。\"}, {\"value\": \"为用好刘湛恩烈士故居红色文化资源，讲好大学图书馆奋进追梦的精彩故事，图书馆人始终践行“读者第一 、服务育人”的理念，勇于承担“滋养民族心灵、培育文化自信”的使命，脚踏实地，奋发有为，力求把图书馆建设成为学校“文化传播”和“三全育人”的重要阵地，为加快推进学校建设一流理工科大学的目标贡献图书馆的力量。\"}]}',0,0,'图书馆获得“最美图书馆”称号'),(28,'【我在“疫”线】校园战疫工作中的图书馆力量','2022-05-19 11:34:16','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid28-1.jpg\", \"resume\": \"孙萍、王龑、方明、毛晓燕、李婧、李鲍嘉、韩楚齐、朱舒华、徐秀丽、徐红芳等分拣“尚理送”订单、搬运蔬菜菜、转运防疫物资\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid28-2.jpg\", \"resume\": \"孙萍、陈世平、宗良带队转运学生，吕玉龙、方明、毛晓燕、任上等进驻学生宿舍楼\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid28-3.jpg\", \"resume\": \"王龑在分发晚餐，卢小虎参与环境消杀，张佳、包颉参与1100号校区学生核酸检测服务\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>4月6日以来，学校的防疫形势升级，图书馆临时闭馆。在学校的号召下，图书馆人逆流而上，攻坚克难，舍小家为大家，驻守校园或外地隔离点，与学校共进退。学校绝大部分疫情防控工作，都有图书馆人的参与。</p><h3></h3><p>留校或应召返校的图书馆职工，有的带队转运学生至外地隔离点，有的在校内隔离点负责学生转运及管理工作，有的进驻学生宿舍楼参与楼栋管理工作，有的参加学生核酸检测扫码等服务，有的参与流调工作，有的负责食堂的分餐和综合协调，有的参与学生秩序维持工作，有的参与学校抗疫物资分发，有的参与环境消杀和学生临时转移工作，有的参与物资搬运、“尚理送”订单分拣工作……“防疫是每个人都要做的事情，抗疫是一群人努力做的任务。”这是核酸检测现场、学生转运、食堂分餐、驻楼管理、隔离站点管理、流调、物资分发等学校抗疫战场上图书馆人的共同心声。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid28-1.jpg\'/><span>孙萍、王龑、方明、毛晓燕、李婧、李鲍嘉、韩楚齐、朱舒华、徐秀丽、徐红芳等分拣“尚理送”订单、搬运蔬菜菜、转运防疫物资</span></div><h3></h3><p>留校或应召返校的图书馆职工，有的带队转运学生至外地隔离点，有的在校内隔离点负责学生转运及管理工作，有的进驻学生宿舍楼参与楼栋管理工作，有的参加学生核酸检测扫码等服务，有的参与流调工作，有的负责食堂的分餐和综合协调，有的参与学生秩序维持工作，有的参与学校抗疫物资分发，有的参与环境消杀和学生临时转移工作，有的参与物资搬运、“尚理送”订单分拣工作……“防疫是每个人都要做的事情，抗疫是一群人努力做的任务。”这是核酸检测现场、学生转运、食堂分餐、驻楼管理、隔离站点管理、流调、物资分发等学校抗疫战场上图书馆人的共同心声。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid28-2.jpg\'/><span>孙萍、陈世平、宗良带队转运学生，吕玉龙、方明、毛晓燕、任上等进驻学生宿舍楼</span></div><h3></h3><p></p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid28-3.jpg\'/><span>王龑在分发晚餐，卢小虎参与环境消杀，张佳、包颉参与1100号校区学生核酸检测服务</span></div>\", \"messages\": [{\"value\": \"4月6日以来，学校的防疫形势升级，图书馆临时闭馆。在学校的号召下，图书馆人逆流而上，攻坚克难，舍小家为大家，驻守校园或外地隔离点，与学校共进退。学校绝大部分疫情防控工作，都有图书馆人的参与。\"}, {\"value\": \"留校或应召返校的图书馆职工，有的带队转运学生至外地隔离点，有的在校内隔离点负责学生转运及管理工作，有的进驻学生宿舍楼参与楼栋管理工作，有的参加学生核酸检测扫码等服务，有的参与流调工作，有的负责食堂的分餐和综合协调，有的参与学生秩序维持工作，有的参与学校抗疫物资分发，有的参与环境消杀和学生临时转移工作，有的参与物资搬运、“尚理送”订单分拣工作……“防疫是每个人都要做的事情，抗疫是一群人努力做的任务。”这是核酸检测现场、学生转运、食堂分餐、驻楼管理、隔离站点管理、流调、物资分发等学校抗疫战场上图书馆人的共同心声。\"}, {\"value\": \"留校或应召返校的图书馆职工，有的带队转运学生至外地隔离点，有的在校内隔离点负责学生转运及管理工作，有的进驻学生宿舍楼参与楼栋管理工作，有的参加学生核酸检测扫码等服务，有的参与流调工作，有的负责食堂的分餐和综合协调，有的参与学生秩序维持工作，有的参与学校抗疫物资分发，有的参与环境消杀和学生临时转移工作，有的参与物资搬运、“尚理送”订单分拣工作……“防疫是每个人都要做的事情，抗疫是一群人努力做的任务。”这是核酸检测现场、学生转运、食堂分餐、驻楼管理、隔离站点管理、流调、物资分发等学校抗疫战场上图书馆人的共同心声。\"}, {\"value\": \"\"}]}',0,0,' 校园战疫工作中的图书馆力量'),(29,'校园主机房停电通知','2021-08-17 07:00:00','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"校园主机房停电通知\"}], \"message\": \"<h3>校园主机房停电通知</h3><p>接学校相关部门停电通知，图书馆变电站将于8月17日（周二）部分时间段（7:00-7:30，13:00-13:30，19:00-19:30）停电，校园网机房将受到影响，停电期间Welink等应用服务有可能会发生中断或异常。请广大师生提前做好相关准备。电力恢复后，如发现网络或系统异常，请拨打校园网报修电话55270595进行报修，给广大用户带来的不便敬请谅解。</p>\", \"messages\": [{\"value\": \"接学校相关部门停电通知，图书馆变电站将于8月17日（周二）部分时间段（7:00-7:30，13:00-13:30，19:00-19:30）停电，校园网机房将受到影响，停电期间Welink等应用服务有可能会发生中断或异常。请广大师生提前做好相关准备。电力恢复后，如发现网络或系统异常，请拨打校园网报修电话55270595进行报修，给广大用户带来的不便敬请谅解。\"}]}',0,0,'校园主机房停电通知'),(30,'智慧校园机房停电通知','2020-10-24 08:00:00','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"智慧校园机房停电通知\"}], \"message\": \"<h3>智慧校园机房停电通知</h3><p>智慧校园机房停电通知</p>\", \"messages\": [{\"value\": \"智慧校园机房停电通知\"}]}',0,0,'智慧校园机房停电通知'),(31,'校园网主机房停电通知','2023-03-06 20:00:00','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"校园网主机房停电通知\"}], \"message\": \"<h3>校园网主机房停电通知</h3><p>为配合图书馆配电房变压器更换，校园网机房于3月6日（星期六）20:00—3月7日8：00停电，由于校园网主机房UPS无法提供长时间供电，校园网网络和应用服务在此期间会发生中断。请各校园网用户提前做好相关准备。\\n\\n电力恢复后，如发现网络或系统异常，请拨打校园网报修电话55270595进行报修，给广大用户带来的不便敬请谅解。</p>\", \"messages\": [{\"value\": \"为配合图书馆配电房变压器更换，校园网机房于3月6日（星期六）20:00—3月7日8：00停电，由于校园网主机房UPS无法提供长时间供电，校园网网络和应用服务在此期间会发生中断。请各校园网用户提前做好相关准备。\\n\\n电力恢复后，如发现网络或系统异常，请拨打校园网报修电话55270595进行报修，给广大用户带来的不便敬请谅解。\"}]}',0,0,'校园网主机房停电通知'),(32,'校园网主机房通知','2020-08-15 10:00:00','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"校园网主机房通知\"}], \"message\": \"<h3>校园网主机房通知</h3><p>为配合智慧校园一期网络升级改造建设，校园网机房于8月15日（星期六）10:00-16：00停电，由于目前校园网主机房UPS不能提供长时间供电，校园网网络和应用服务可能会发生中断。请各校园网用户提前做好相关准备。</p>\", \"messages\": [{\"value\": \"为配合智慧校园一期网络升级改造建设，校园网机房于8月15日（星期六）10:00-16：00停电，由于目前校园网主机房UPS不能提供长时间供电，校园网网络和应用服务可能会发生中断。请各校园网用户提前做好相关准备。\"}]}',0,0,'校园网主机房通知'),(33,'蓝桥杯机房占用','2023-04-13 00:00:00','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>由于蓝桥杯比赛，四楼机房在2023.4.13将不对外开放。</p>\", \"messages\": [{\"value\": \"由于蓝桥杯比赛，四楼机房在2023.4.13将不对外开放。\"}]}',0,0,'四楼机房在2023.4.13将不对外开放。'),(34,'天梯赛机房占用','2023-04-23 16:45:04','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>由于天梯赛竞赛，五楼机房在2023.4.23将不对外开放。</p><h3></h3><p>由于天梯赛竞赛，五楼机房在2023.4.23将不对外开放。</p>\", \"messages\": [{\"value\": \"由于天梯赛竞赛，五楼机房在2023.4.23将不对外开放。\"}]}',0,0,'五楼机房在2023.4.23将不对外开放'),(35,'走进海沈村：我校举办研究生第三期“劳动进田野”主题实践教育活动','2022-11-24 11:42:21','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid35-1.jpg\", \"resume\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>劳动最光荣，奋斗最幸福。为了让学生树立劳动意识、增强劳动观念、养成劳动习惯，11月23日，党委研工部部长彭宗祥、版艺学院党委书记张华带领30余名师生前往上海市浦东新区惠南镇海沈村——奥运冠军、二十大代表钟天使的家乡，通过沉浸式党课、户外采风和田间劳动等形式，深入了解了海沈村在实现乡村振兴这一过程中的变化和发展。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid35-1.jpg\'/><span>http:\\\\\\\\43.143.78.169:8080/static/img/mid</span></div><h3></h3><p>劳动最光荣，奋斗最幸福。为了让学生树立劳动意识、增强劳动观念、养成劳动习惯，11月23日，党委研工部部长彭宗祥、版艺学院党委书记张华带领30余名师生前往上海市浦东新区惠南镇海沈村——奥运冠军、二十大代表钟天使的家乡，通过沉浸式党课、户外采风和田间劳动等形式，深入了解了海沈村在实现乡村振兴这一过程中的变化和发展。</p>\", \"messages\": [{\"value\": \"劳动最光荣，奋斗最幸福。为了让学生树立劳动意识、增强劳动观念、养成劳动习惯，11月23日，党委研工部部长彭宗祥、版艺学院党委书记张华带领30余名师生前往上海市浦东新区惠南镇海沈村——奥运冠军、二十大代表钟天使的家乡，通过沉浸式党课、户外采风和田间劳动等形式，深入了解了海沈村在实现乡村振兴这一过程中的变化和发展。\"}, {\"value\": \"劳动最光荣，奋斗最幸福。为了让学生树立劳动意识、增强劳动观念、养成劳动习惯，11月23日，党委研工部部长彭宗祥、版艺学院党委书记张华带领30余名师生前往上海市浦东新区惠南镇海沈村——奥运冠军、二十大代表钟天使的家乡，通过沉浸式党课、户外采风和田间劳动等形式，深入了解了海沈村在实现乡村振兴这一过程中的变化和发展。\"}]}',0,0,'走进海沈村活动'),(36,'关于开展“秋炫沪江·我是光荣劳动者”主题实践教育活动的通知','2022-11-25 09:00:00','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid36-1.jpg\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"时间地点时间：\"}], \"message\": \"<h3></h3><p>“劳动教育是中国特色社会主义教育制度的重要内容，直接决定社会主义建设者和接班人的劳动精神面貌、劳动价值取向和劳动技能水平。”为贯彻落实中共中央（国务院）、教育部、上海市委（市政府）发布的  《关于全面加强新时代大中小学劳动教育的意见》等相关文件精神，通过劳动教育来强化马克思主义劳动观，牢固树立劳动最光荣、劳动最崇高、劳动最伟大、劳动最美丽的观念，引导学生养成勤奋劳动的良好习惯、享受劳动乐趣、弘扬工匠精神，学校将在研究生中继续 开展“我是光荣劳动者”主题实践教育活动，把实践实训作为劳动育人的主要途径，通过劳动教育来树德、增智、强体、育美，促进学生的德智体美劳全面发展。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid36-1.jpg\'/><span></span></div><h3>时间地点时间：</h3><p>地点：上海理工大学军工路334号和516号校区\\n2022年11月25日至12月20日（研究生劳动月）</p>\", \"messages\": [{\"value\": \"“劳动教育是中国特色社会主义教育制度的重要内容，直接决定社会主义建设者和接班人的劳动精神面貌、劳动价值取向和劳动技能水平。”为贯彻落实中共中央（国务院）、教育部、上海市委（市政府）发布的  《关于全面加强新时代大中小学劳动教育的意见》等相关文件精神，通过劳动教育来强化马克思主义劳动观，牢固树立劳动最光荣、劳动最崇高、劳动最伟大、劳动最美丽的观念，引导学生养成勤奋劳动的良好习惯、享受劳动乐趣、弘扬工匠精神，学校将在研究生中继续 开展“我是光荣劳动者”主题实践教育活动，把实践实训作为劳动育人的主要途径，通过劳动教育来树德、增智、强体、育美，促进学生的德智体美劳全面发展。\"}, {\"value\": \"地点：上海理工大学军工路334号和516号校区\\n2022年11月25日至12月20日（研究生劳动月）\"}]}',0,0,'“秋炫沪江，我是光荣劳动者”活动开展通知'),(37,'打响“医械工匠”品牌：健康学院生物医学工程党支部举办主题党日活动','2022-12-16 13:22:51','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid37-1.jpg\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>探讨具有中国特色的“医械工匠”教育，在医疗器械自主创新新征程上踔厉前行，12月14日，健康科学与工程学院生物医学工程党支部线上线下召开主题为“领悟二十大会议精神  努力奋斗建功新时代”主题党日活动，校党委副书记孙跃东、学院党委书记姚秀雯出席。会议由党支部书记王成主持。</p><h3></h3><p>党的二十大报告中指出，加快建设教育强国、科技强国、人才强国，坚持为党育人、为国育才，全面提高人才自主培养质量，着力造就拔尖创新人才，聚天下英才而用之。王成结合支部工作实践，对照“五个牢牢把握”带领大家深刻理解和贯彻党的二十大精神。随后，学院副院长程云章、副院长崔海坡，研究所所长谷雪莲、副所长严荣国等党员同志围绕如何把二十大精神与本职工作更好地结合进行发言，从工作中来，又回到工作中去，深刻领会党的二十大精神内涵。王成从支部建设、上海抗疫、课程思政建设和专业发展等方面总结了生物医学工程党支部2022年的主要工作，并对“攀登”计划样板党支部建设做了具体规划。</p><h3></h3><p>党的二十大报告中指出，加快建设教育强国、科技强国、人才强国，坚持为党育人、为国育才，全面提高人才自主培养质量，着力造就拔尖创新人才，聚天下英才而用之。王成结合支部工作实践，对照“五个牢牢把握”带领大家深刻理解和贯彻党的二十大精神。随后，学院副院长程云章、副院长崔海坡，研究所所长谷雪莲、副所长严荣国等党员同志围绕如何把二十大精神与本职工作更好地结合进行发言，从工作中来，又回到工作中去，深刻领会党的二十大精神内涵。王成从支部建设、上海抗疫、课程思政建设和专业发展等方面总结了生物医学工程党支部2022年的主要工作，并对“攀登”计划样板党支部建设做了具体规划。</p><h3></h3><p>党的二十大报告中指出，加快建设教育强国、科技强国、人才强国，坚持为党育人、为国育才，全面提高人才自主培养质量，着力造就拔尖创新人才，聚天下英才而用之。王成结合支部工作实践，对照“五个牢牢把握”带领大家深刻理解和贯彻党的二十大精神。随后，学院副院长程云章、副院长崔海坡，研究所所长谷雪莲、副所长严荣国等党员同志围绕如何把二十大精神与本职工作更好地结合进行发言，从工作中来，又回到工作中去，深刻领会党的二十大精神内涵。王成从支部建设、上海抗疫、课程思政建设和专业发展等方面总结了生物医学工程党支部2022年的主要工作，并对“攀登”计划样板党支部建设做了具体规划。</p><h3></h3><p>党的二十大报告中指出，加快建设教育强国、科技强国、人才强国，坚持为党育人、为国育才，全面提高人才自主培养质量，着力造就拔尖创新人才，聚天下英才而用之。王成结合支部工作实践，对照“五个牢牢把握”带领大家深刻理解和贯彻党的二十大精神。随后，学院副院长程云章、副院长崔海坡，研究所所长谷雪莲、副所长严荣国等党员同志围绕如何把二十大精神与本职工作更好地结合进行发言，从工作中来，又回到工作中去，深刻领会党的二十大精神内涵。王成从支部建设、上海抗疫、课程思政建设和专业发展等方面总结了生物医学工程党支部2022年的主要工作，并对“攀登”计划样板党支部建设做了具体规划。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid37-1.jpg\'/><span></span></div>\", \"messages\": [{\"value\": \"探讨具有中国特色的“医械工匠”教育，在医疗器械自主创新新征程上踔厉前行，12月14日，健康科学与工程学院生物医学工程党支部线上线下召开主题为“领悟二十大会议精神  努力奋斗建功新时代”主题党日活动，校党委副书记孙跃东、学院党委书记姚秀雯出席。会议由党支部书记王成主持。\"}, {\"value\": \"党的二十大报告中指出，加快建设教育强国、科技强国、人才强国，坚持为党育人、为国育才，全面提高人才自主培养质量，着力造就拔尖创新人才，聚天下英才而用之。王成结合支部工作实践，对照“五个牢牢把握”带领大家深刻理解和贯彻党的二十大精神。随后，学院副院长程云章、副院长崔海坡，研究所所长谷雪莲、副所长严荣国等党员同志围绕如何把二十大精神与本职工作更好地结合进行发言，从工作中来，又回到工作中去，深刻领会党的二十大精神内涵。王成从支部建设、上海抗疫、课程思政建设和专业发展等方面总结了生物医学工程党支部2022年的主要工作，并对“攀登”计划样板党支部建设做了具体规划。\"}, {\"value\": \"党的二十大报告中指出，加快建设教育强国、科技强国、人才强国，坚持为党育人、为国育才，全面提高人才自主培养质量，着力造就拔尖创新人才，聚天下英才而用之。王成结合支部工作实践，对照“五个牢牢把握”带领大家深刻理解和贯彻党的二十大精神。随后，学院副院长程云章、副院长崔海坡，研究所所长谷雪莲、副所长严荣国等党员同志围绕如何把二十大精神与本职工作更好地结合进行发言，从工作中来，又回到工作中去，深刻领会党的二十大精神内涵。王成从支部建设、上海抗疫、课程思政建设和专业发展等方面总结了生物医学工程党支部2022年的主要工作，并对“攀登”计划样板党支部建设做了具体规划。\"}, {\"value\": \"党的二十大报告中指出，加快建设教育强国、科技强国、人才强国，坚持为党育人、为国育才，全面提高人才自主培养质量，着力造就拔尖创新人才，聚天下英才而用之。王成结合支部工作实践，对照“五个牢牢把握”带领大家深刻理解和贯彻党的二十大精神。随后，学院副院长程云章、副院长崔海坡，研究所所长谷雪莲、副所长严荣国等党员同志围绕如何把二十大精神与本职工作更好地结合进行发言，从工作中来，又回到工作中去，深刻领会党的二十大精神内涵。王成从支部建设、上海抗疫、课程思政建设和专业发展等方面总结了生物医学工程党支部2022年的主要工作，并对“攀登”计划样板党支部建设做了具体规划。\"}, {\"value\": \"党的二十大报告中指出，加快建设教育强国、科技强国、人才强国，坚持为党育人、为国育才，全面提高人才自主培养质量，着力造就拔尖创新人才，聚天下英才而用之。王成结合支部工作实践，对照“五个牢牢把握”带领大家深刻理解和贯彻党的二十大精神。随后，学院副院长程云章、副院长崔海坡，研究所所长谷雪莲、副所长严荣国等党员同志围绕如何把二十大精神与本职工作更好地结合进行发言，从工作中来，又回到工作中去，深刻领会党的二十大精神内涵。王成从支部建设、上海抗疫、课程思政建设和专业发展等方面总结了生物医学工程党支部2022年的主要工作，并对“攀登”计划样板党支部建设做了具体规划。\"}]}',0,0,'打响医匠品牌活动'),(38,'理学院“实验大变身”活动','2022-12-12 08:00:00','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid38-1.jpg\", \"resume\": \"活动现场\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>深化劳动教育 理学院开展“实验室大变身”活动</p><h3></h3><p>全体在校研究生通过一个下午的集体劳动，实验室卫生华丽变身，窗明几净，井然有序。同时，学院最新修订的实验室安全管理制度正式实施，实验室负责人于海涛、魏连鑫老师现场对同学们进行了制度宣讲。在打扫卫生的同时，同学们将制度上墙，形成实验室使用公约。</p><h3></h3><p>学院将进一步深化实验室劳动教育，落实实验室值日生制度和学生安全员制度，扎实做好实验室安全工作，全力保障学院教学、科研工作平稳有序，助力学院建设。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid38-1.jpg\'/><span>活动现场</span></div>\", \"messages\": [{\"value\": \"深化劳动教育 理学院开展“实验室大变身”活动\"}, {\"value\": \"全体在校研究生通过一个下午的集体劳动，实验室卫生华丽变身，窗明几净，井然有序。同时，学院最新修订的实验室安全管理制度正式实施，实验室负责人于海涛、魏连鑫老师现场对同学们进行了制度宣讲。在打扫卫生的同时，同学们将制度上墙，形成实验室使用公约。\"}, {\"value\": \"学院将进一步深化实验室劳动教育，落实实验室值日生制度和学生安全员制度，扎实做好实验室安全工作，全力保障学院教学、科研工作平稳有序，助力学院建设。\"}]}',0,0,'深化劳动教育 理学院开展“实验室大变身”活动'),(39,'2022年“会聘上海”校园行活动在我校举办','2022-11-29 09:00:00','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid39-1.jpg\", \"resume\": \"市总工会领导现场了解毕业生求职情况\"}, {\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid39-2.jpg\", \"resume\": \"招聘会现场\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>为贯彻落实中央及市委、市政府“六稳”“六保”有关精神，切实做好本市高校毕业生尤其是困难职工家庭大学生子女的就业服务工作，11月29日，由上海市总工会职工服务中心、上海市学生事务中心、上海理工大学等单位联合举办的2022年“会聘上海”校园行活动上海理工大学专场线下招聘会举办。上海市总工会职工服务中心主任陈鲁，我校学生处处长何炉进、就业指导中心负责人、毕业班辅导员等到招聘会现场了解企业用人需求及毕业生求职情况。</p><h3></h3><p>为贯彻落实中央及市委、市政府“六稳”“六保”有关精神，切实做好本市高校毕业生尤其是困难职工家庭大学生子女的就业服务工作，11月29日，由上海市总工会职工服务中心、上海市学生事务中心、上海理工大学等单位联合举办的2022年“会聘上海”校园行活动上海理工大学专场线下招聘会举办。上海市总工会职工服务中心主任陈鲁，我校学生处处长何炉进、就业指导中心负责人、毕业班辅导员等到招聘会现场了解企业用人需求及毕业生求职情况。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid39-1.jpg\'/><span>市总工会领导现场了解毕业生求职情况</span></div><h3></h3><p>学校近期将按照教育部相关工作部署，高质量开展校园招聘服务月系列活动，多举措为用人单位和毕业生搭建平台，联动政企部门继续举办综合场、行业专场等校园招聘活动。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid39-2.jpg\'/><span>招聘会现场</span></div>\", \"messages\": [{\"value\": \"为贯彻落实中央及市委、市政府“六稳”“六保”有关精神，切实做好本市高校毕业生尤其是困难职工家庭大学生子女的就业服务工作，11月29日，由上海市总工会职工服务中心、上海市学生事务中心、上海理工大学等单位联合举办的2022年“会聘上海”校园行活动上海理工大学专场线下招聘会举办。上海市总工会职工服务中心主任陈鲁，我校学生处处长何炉进、就业指导中心负责人、毕业班辅导员等到招聘会现场了解企业用人需求及毕业生求职情况。\"}, {\"value\": \"为贯彻落实中央及市委、市政府“六稳”“六保”有关精神，切实做好本市高校毕业生尤其是困难职工家庭大学生子女的就业服务工作，11月29日，由上海市总工会职工服务中心、上海市学生事务中心、上海理工大学等单位联合举办的2022年“会聘上海”校园行活动上海理工大学专场线下招聘会举办。上海市总工会职工服务中心主任陈鲁，我校学生处处长何炉进、就业指导中心负责人、毕业班辅导员等到招聘会现场了解企业用人需求及毕业生求职情况。\"}, {\"value\": \"学校近期将按照教育部相关工作部署，高质量开展校园招聘服务月系列活动，多举措为用人单位和毕业生搭建平台，联动政企部门继续举办综合场、行业专场等校园招聘活动。\"}]}',0,0,'2022年“会聘上海”校园行活动在我校举办'),(40,'光电学院挑战杯专题讲座','2023-03-15 20:00:00','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>. 光电学院挑战杯专题讲座，活动级别：校级，报名时间：2023.03.12 19:15-2023.03.15 19:15，活\\n动时间：2023.03.15 20:00-2023.03.16 16:00</p>\", \"messages\": [{\"value\": \". 光电学院挑战杯专题讲座，活动级别：校级，报名时间：2023.03.12 19:15-2023.03.15 19:15，活\\n动时间：2023.03.15 20:00-2023.03.16 16:00\"}]}',0,0,' 光电学院挑战杯专题讲座，'),(41,'尚旅军团全员大会','2023-03-15 00:00:00','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>. 尚理军旅团2023第二学期全员大会，活动级别：校级，报名时间：2023.03.13 20:10-2023.03.14\\n23:59，活动时间：2023.03.15 00:00-2023.03.15 23:59</p>\", \"messages\": [{\"value\": \". 尚理军旅团2023第二学期全员大会，活动级别：校级，报名时间：2023.03.13 20:10-2023.03.14\\n23:59，活动时间：2023.03.15 00:00-2023.03.15 23:59\"}]}',0,0,'尚旅军团全员大会'),(42,'2022年研究生考试教学楼暂停开放通知','2022-12-24 00:00:00','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"告各位师生：\"}], \"message\": \"<h3>告各位师生：</h3><p>因研究生考试.2022年12月24-25日国家硕士研究生招生考试期间教学楼暂停开放的</p><h3>告各位师生：</h3><p>因研究生考试.2022年12月24-25日国家硕士研究生招生考试期间教学楼暂停开放的</p>\", \"messages\": [{\"value\": \"因研究生考试.2022年12月24-25日国家硕士研究生招生考试期间教学楼暂停开放的\"}]}',0,0,'2022年研究生考试教学楼暂停开放通知'),(43,'宿舍洗衣机项目成交公告','2022-12-30 13:52:09','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"由上海日杰投资咨询有限公司组织的上海理工大学学生宿舍洗衣机投放服务项目（招投标单号：QD22034）的竞争性磋商方式的采购\"}, {\"value\": \"一、项目名称：上海理工大学学生宿舍洗衣机投放服务项目\"}, {\"value\": \"三、评审日期：2022年12月30日13:30\"}], \"message\": \"<h3>由上海日杰投资咨询有限公司组织的上海理工大学学生宿舍洗衣机投放服务项目（招投标单号：QD22034）的竞争性磋商方式的采购</h3><p>经评审委员会评审，并经采购人确认，本次成交结果公布如下：</p><h3>一、项目名称：上海理工大学学生宿舍洗衣机投放服务项目</h3><p>1、成交供应商：包件一：上海众家联设备租赁有限公司。包件二：上海爱喜衣清洁技术有限公司。包件三：上海仓浩信息科技有限公司</p><h3>三、评审日期：2022年12月30日13:30</h3><p>四、评审地点：虹口区溧阳路1111号永融企业中心6D1室</p><h3>由上海日杰投资咨询有限公司组织的上海理工大学学生宿舍洗衣机投放服务项目（招投标单号：QD22034）的竞争性磋商方式的采购</h3><p>经评审委员会评审，并经采购人确认，本次成交结果公布如下：</p><h3>一、项目名称：上海理工大学学生宿舍洗衣机投放服务项目</h3><p>1、成交供应商：包件一：上海众家联设备租赁有限公司。包件二：上海爱喜衣清洁技术有限公司。包件三：上海仓浩信息科技有限公司</p><h3>三、评审日期：2022年12月30日13:30</h3><p>四、评审地点：虹口区溧阳路1111号永融企业中心6D1室</p>\", \"messages\": [{\"value\": \"经评审委员会评审，并经采购人确认，本次成交结果公布如下：\"}, {\"value\": \"1、成交供应商：包件一：上海众家联设备租赁有限公司。包件二：上海爱喜衣清洁技术有限公司。包件三：上海仓浩信息科技有限公司\"}, {\"value\": \"四、评审地点：虹口区溧阳路1111号永融企业中心6D1室\"}]}',0,0,'上海理工大学学生宿舍洗衣机投放服务项目成交公告'),(45,'部分餐厅托管服务公开招标','2022-12-05 13:32:21','2023-12-31 23:59:59','\"\\\"null\\\"\"','{\"file\": [{\"url\": \"https://bulletin.cebpubservice.com/biddingBulletin/2022-12-05/8797591.html#\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"根据《中华人民共和国招标投标法》及相关法律、法规之规定，上海公欣招标代理有限公司受委托，对上海理工大学军工路516号校区第五食堂、轩斋苑餐厅、少数民族餐厅及复兴路校区食堂托管服务项目进行公开招标采购，特邀请合格的供应商前来投标。\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>根据《中华人民共和国招标投标法》及相关法律、法规之规定，上海公欣招标代理有限公司受委托，对上海理工大学军工路516号校区第五食堂、轩斋苑餐厅、少数民族餐厅及复兴路校区食堂托管服务项目进行公开招标采购，特邀请合格的供应商前来投标。</p><h3>根据《中华人民共和国招标投标法》及相关法律、法规之规定，上海公欣招标代理有限公司受委托，对上海理工大学军工路516号校区第五食堂、轩斋苑餐厅、少数民族餐厅及复兴路校区食堂托管服务项目进行公开招标采购，特邀请合格的供应商前来投标。</h3><p>1、项目名称：上海理工大学军工路516号校区第五食堂、轩斋苑餐厅、少数民族餐厅及复兴路校区食堂托管服务</p><h3></h3><p>2、招投标单号：QD22032（代理机构内部编号：GXZ2212175A84）</p><h3></h3><p>3、项目主要内容、数量及简要规格描述或项目基本概况介绍：</p>\", \"messages\": [{\"value\": \"根据《中华人民共和国招标投标法》及相关法律、法规之规定，上海公欣招标代理有限公司受委托，对上海理工大学军工路516号校区第五食堂、轩斋苑餐厅、少数民族餐厅及复兴路校区食堂托管服务项目进行公开招标采购，特邀请合格的供应商前来投标。\"}, {\"value\": \"1、项目名称：上海理工大学军工路516号校区第五食堂、轩斋苑餐厅、少数民族餐厅及复兴路校区食堂托管服务\"}, {\"value\": \"2、招投标单号：QD22032（代理机构内部编号：GXZ2212175A84）\"}, {\"value\": \"3、项目主要内容、数量及简要规格描述或项目基本概况介绍：\"}]}',0,0,'上海理工大学军工路516号校区第五食堂、轩斋苑餐厅、少数民族餐厅及复兴路校区食堂托管服务公开招标公告'),(46,'宿舍装修改造项目招标公告','2022-11-25 09:22:44','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"一、项目概况\"}, {\"value\": \"\"}, {\"value\": \"\"}, {\"value\": \"\"}], \"message\": \"<h3></h3><p>根据《中华人民共和国招标投标法》、《中华人民共和国招标投标法实施条例》及相关法律、法规之规定，上海祥浦建设工程监理咨询有限责任公司受委托，对上海理工大学学生宿舍装修改造项目设计进行国内公开招投标采购，特邀请合格的供应商前来投标。</p><h3>一、项目概况</h3><p>1、项目名称：上海理工大学学生宿舍装修改造项目</p><h3></h3><p>2、招投标单号：GD22057</p><h3></h3><p>3、项目主要内容、数量及简要规格描述或项目基本概况介绍：</p><h3></h3><p>本项目本次招标将通过对投标人及设计项目组人员的构成、业绩经历、设计费报价和设计构思等的评审，确定设计中标人。中标人将承担本工程包括但不限于：总图、建筑、结构(含加固)、给排水、暖通、强电、弱电（含智能化）、动力、泛光照明、外立面、消防、节能、电（扶）梯、导示标识、交通标识、绿化、景观、室内装修及其他各专业设计等，并承担包括但不限于本项目所有专业及对应的所有专项设计、二次深化设计、配套设计等的全过程协调管理工作，协助设计各阶段的报批报建、成本采招、工程施工、项目验收等相关服务配合工作。具体设计服务内容及专项设计内容详见本招标文件中设计技术要求之相关内容。</p>\", \"messages\": [{\"value\": \"根据《中华人民共和国招标投标法》、《中华人民共和国招标投标法实施条例》及相关法律、法规之规定，上海祥浦建设工程监理咨询有限责任公司受委托，对上海理工大学学生宿舍装修改造项目设计进行国内公开招投标采购，特邀请合格的供应商前来投标。\"}, {\"value\": \"1、项目名称：上海理工大学学生宿舍装修改造项目\"}, {\"value\": \"2、招投标单号：GD22057\"}, {\"value\": \"3、项目主要内容、数量及简要规格描述或项目基本概况介绍：\"}, {\"value\": \"本项目本次招标将通过对投标人及设计项目组人员的构成、业绩经历、设计费报价和设计构思等的评审，确定设计中标人。中标人将承担本工程包括但不限于：总图、建筑、结构(含加固)、给排水、暖通、强电、弱电（含智能化）、动力、泛光照明、外立面、消防、节能、电（扶）梯、导示标识、交通标识、绿化、景观、室内装修及其他各专业设计等，并承担包括但不限于本项目所有专业及对应的所有专项设计、二次深化设计、配套设计等的全过程协调管理工作，协助设计各阶段的报批报建、成本采招、工程施工、项目验收等相关服务配合工作。具体设计服务内容及专项设计内容详见本招标文件中设计技术要求之相关内容。\"}]}',0,0,'上海理工大学学生宿舍装修改造项目设计单位招标公告'),(49,' 关于国家自然科学基金优秀青年科学基金项目（海外）项目的通知','2023-01-04 12:12:31','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"各学院（部）：\"}, {\"value\": \"一、项目定位\"}], \"message\": \"<h3>各学院（部）：</h3><p>为进一步完善科学基金人才资助体系，充分发挥科学基金引进和培养人才的功能，吸引海外优秀青年人才回国（来华）工作，国家自然科学基金委员会（以下简称自然科学基金委）2023年继续实施国家自然科学基金优秀青年科学基金项目（海外）。</p><h3>一、项目定位</h3><p>优秀青年科学基金项目（海外）旨在吸引和鼓励在自然科学、工程技术等方面已取得较好成绩的海外优秀青年学者（含非华裔外籍人才）回国（来华）工作，自主选择研究方向开展创新性研究，促进青年科学技术人才的快速成长，培养一批有望进入世界科技前沿的优秀学术骨干，为科技强国建设贡献力量。</p><h3>各学院（部）：</h3><p>为进一步完善科学基金人才资助体系，充分发挥科学基金引进和培养人才的功能，吸引海外优秀青年人才回国（来华）工作，国家自然科学基金委员会（以下简称自然科学基金委）2023年继续实施国家自然科学基金优秀青年科学基金项目（海外）。</p><h3>一、项目定位</h3><p>优秀青年科学基金项目（海外）旨在吸引和鼓励在自然科学、工程技术等方面已取得较好成绩的海外优秀青年学者（含非华裔外籍人才）回国（来华）工作，自主选择研究方向开展创新性研究，促进青年科学技术人才的快速成长，培养一批有望进入世界科技前沿的优秀学术骨干，为科技强国建设贡献力量。</p>\", \"messages\": [{\"value\": \"为进一步完善科学基金人才资助体系，充分发挥科学基金引进和培养人才的功能，吸引海外优秀青年人才回国（来华）工作，国家自然科学基金委员会（以下简称自然科学基金委）2023年继续实施国家自然科学基金优秀青年科学基金项目（海外）。\"}, {\"value\": \"优秀青年科学基金项目（海外）旨在吸引和鼓励在自然科学、工程技术等方面已取得较好成绩的海外优秀青年学者（含非华裔外籍人才）回国（来华）工作，自主选择研究方向开展创新性研究，促进青年科学技术人才的快速成长，培养一批有望进入世界科技前沿的优秀学术骨干，为科技强国建设贡献力量。\"}]}',0,0,' 关于国家自然科学基金优秀青年科学基金项目（海外）项目的通知'),(50,'关于上海市2023年度“科技创新行动计划”“一带一路”国际合作项目申报的通知','2022-12-19 13:22:51','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"https://www.usst.edu.cn/_upload/article/files/c2/8d/43f1b82545a1b5e5f55e4c7ae918/8552a401-f5fc-4be9-8d6b-669ea0726174.pdf\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"各学院（部）：\"}], \"message\": \"<h3>各学院（部）：</h3><p>为深入实施创新驱动发展战略，加快建设具有全球影响力的科技创新中心，根据《上海市建设具有全球影响力的科技创新中心“十四五”规划》，上海市科学技术委员会特发布2023年度“科技创新行动计划”“一带一路”国际合作项目申报指南。</p><h3>各学院（部）：</h3><p>为深入实施创新驱动发展战略，加快建设具有全球影响力的科技创新中心，根据《上海市建设具有全球影响力的科技创新中心“十四五”规划》，上海市科学技术委员会特发布2023年度“科技创新行动计划”“一带一路”国际合作项目申报指南。</p>\", \"messages\": [{\"value\": \"为深入实施创新驱动发展战略，加快建设具有全球影响力的科技创新中心，根据《上海市建设具有全球影响力的科技创新中心“十四五”规划》，上海市科学技术委员会特发布2023年度“科技创新行动计划”“一带一路”国际合作项目申报指南。\"}]}',0,0,'关于上海市2023年度“科技创新行动计划”“一带一路”国际合作项目申报的通知'),(51,'关于发布上海市2023年度“科技创新行动计划”软科学研究项目申报指南的通知','2022-12-14 15:32:23','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"各学院（部）：\"}], \"message\": \"<h3>各学院（部）：</h3><p>为深入实施创新驱动发展战略，全面贯彻落实党的二十大精神，加快建设具有全球影响力的科技创新中心，现根据《上海市建设具有全球影响力的科技创新中心“十四五”规划》总体布局，发布上海市2023年度“科技创新行动计划”软科学研究项目申报指南。</p>\", \"messages\": [{\"value\": \"为深入实施创新驱动发展战略，全面贯彻落实党的二十大精神，加快建设具有全球影响力的科技创新中心，现根据《上海市建设具有全球影响力的科技创新中心“十四五”规划》总体布局，发布上海市2023年度“科技创新行动计划”软科学研究项目申报指南。\"}]}',0,0,'关于发布上海市2023年度“科技创新行动计划”软科学研究项目申报指南的通知'),(52,' 关于发布上海市2023年度“科技创新行动计划”技术标准项目申报指南的通知','2022-12-11 16:22:51','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \" 关于发布上海市2023年度“科技创新行动计划”技术标准项目申报指南的通知\"}], \"message\": \"<h3> 关于发布上海市2023年度“科技创新行动计划”技术标准项目申报指南的通知</h3><p>为深入实施创新驱动发展战略，加快建设具有全球影响力的科技创新中心，根据《上海市建设具有全球影响力的科技创新中心“十四五”规划》，上海市科学技术委员会特发布2023年度“科技创新行动计划”技术标准项目申报指南。</p>\", \"messages\": [{\"value\": \"为深入实施创新驱动发展战略，加快建设具有全球影响力的科技创新中心，根据《上海市建设具有全球影响力的科技创新中心“十四五”规划》，上海市科学技术委员会特发布2023年度“科技创新行动计划”技术标准项目申报指南。\"}]}',0,0,' 关于发布上海市2023年度“科技创新行动计划”技术标准项目申报指南的通知'),(53,' 关于发布上海市2023年度“科技创新行动计划”自然科学基金项目申报指南的通知','2022-11-25 08:25:57','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"各学院（部）：\"}], \"message\": \"<h3>各学院（部）：</h3><p>各学院（部）：</p><h3>各学院（部）：</h3><p>为深入实施创新驱动发展战略，加快建设具有全球影响力的科技创新中心，依据《上海市自然科学基金管理办法》（沪科规〔2022〕7号），上海市科学技术委员会特发布2023年度“科技创新行动计划”自然科学基金项目申报指南。</p>\", \"messages\": [{\"value\": \"为深入实施创新驱动发展战略，加快建设具有全球影响力的科技创新中心，依据《上海市自然科学基金管理办法》（沪科规〔2022〕7号），上海市科学技术委员会特发布2023年度“科技创新行动计划”自然科学基金项目申报指南。\"}]}',0,0,' 关于发布上海市2023年度“科技创新行动计划”自然科学基金项目申报指南的通知'),(54,' 上海理工大学学生宿舍装修改造项目设计单位招标公告','2022-11-25 15:52:31','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"https://bulletin.cebpubservice.com/biddingBulletin/2022-11-25/8725486.html\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"根据《中华人民共和国招标投标法》、《中华人民共和国招标投标法实施条例》及相关法律、法规之规定，上海祥浦建设工程监理咨询有限责任公司受委托，对上海理工大学学生宿舍装修改造项目设计进行国内公开招投标采购，特邀请合格的供应商前来投标。\"}], \"message\": \"<h3>根据《中华人民共和国招标投标法》、《中华人民共和国招标投标法实施条例》及相关法律、法规之规定，上海祥浦建设工程监理咨询有限责任公司受委托，对上海理工大学学生宿舍装修改造项目设计进行国内公开招投标采购，特邀请合格的供应商前来投标。</h3><p>一、项目概况\\n\\n1、项目名称：上海理工大学学生宿舍装修改造项目。2、招投标单号：GD22057。3、项目主要内容、数量及简要规格描述或项目基本概况介绍：\\n本项目本次招标将通过对投标人及设计项目组人员的构成、业绩经历、设计费报价和设计构思等的评审，确定设计中标人。中标人将承担本工程包括但不限于：总图、建筑、结构(含加固)、给排水、暖通、强电、弱电（含智能化）、动力、泛光照明、外立面、消防、节能、电（扶）梯、导示标识、交通标识、绿化、景观、室内装修及其他各专业设计等，并承担包括但不限于本项目所有专业及对应的所有专项设计、二次深化设计、配套设计等的全过程协调管理工作，协助设计各阶段的报批报建、成本采招、工程施工、项目验收等相关服务配合工作。具体设计服务内容及专项设计内容详见本招标文件中设计技术要求之相关内容。4、设计费最高投标限价：65.55万元</p>\", \"messages\": [{\"value\": \"一、项目概况\\n\\n1、项目名称：上海理工大学学生宿舍装修改造项目。2、招投标单号：GD22057。3、项目主要内容、数量及简要规格描述或项目基本概况介绍：\\n本项目本次招标将通过对投标人及设计项目组人员的构成、业绩经历、设计费报价和设计构思等的评审，确定设计中标人。中标人将承担本工程包括但不限于：总图、建筑、结构(含加固)、给排水、暖通、强电、弱电（含智能化）、动力、泛光照明、外立面、消防、节能、电（扶）梯、导示标识、交通标识、绿化、景观、室内装修及其他各专业设计等，并承担包括但不限于本项目所有专业及对应的所有专项设计、二次深化设计、配套设计等的全过程协调管理工作，协助设计各阶段的报批报建、成本采招、工程施工、项目验收等相关服务配合工作。具体设计服务内容及专项设计内容详见本招标文件中设计技术要求之相关内容。4、设计费最高投标限价：65.55万元\"}]}',0,0,' 上海理工大学学生宿舍装修改造项目设计单位招标公告'),(55,' 关于2023年寒假各项服务工作安排汇总','2023-01-05 16:42:27','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"关于2023年寒假期间本科教学服务工作安排的通知——本科生院（教务处）\"}, {\"value\": \"关于2023年寒假期间信息化办公室对外服务安排的通知——信息化办公室\"}, {\"value\": \"图书馆2023年寒假期间服务安排表——图书馆\"}, {\"value\": \"关于2023年寒假期间后勤服务工作安排的通知——后勤管理处\"}], \"message\": \"<h3>关于2023年寒假期间本科教学服务工作安排的通知——本科生院（教务处）</h3><p>http://www.usst.edu.cn/2023/0105/c912a51934/page.htm</p><h3>关于2023年寒假期间信息化办公室对外服务安排的通知——信息化办公室</h3><p>http://www.usst.edu.cn/2023/0106/c912a51938/page.htm</p><h3>图书馆2023年寒假期间服务安排表——图书馆</h3><p>http://www.usst.edu.cn/2023/0106/c912a51947/page.htm</p><h3>关于2023年寒假期间后勤服务工作安排的通知——后勤管理处</h3><p>http://www.usst.edu.cn/2023/0106/c912a51959/page.htm</p>\", \"messages\": [{\"value\": \"http://www.usst.edu.cn/2023/0105/c912a51934/page.htm\"}, {\"value\": \"http://www.usst.edu.cn/2023/0106/c912a51938/page.htm\"}, {\"value\": \"http://www.usst.edu.cn/2023/0106/c912a51947/page.htm\"}, {\"value\": \"http://www.usst.edu.cn/2023/0106/c912a51959/page.htm\"}]}',0,0,' 关于2023年寒假各项服务工作安排汇总'),(56,' 关于2022年大学生征兵工作先进个人、先进集体评选结果的公示','2022-12-16 09:56:48','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"一、征兵工作先进个人名单：\"}, {\"value\": \"二、征兵工作先进集体名单：\"}], \"message\": \"<h3></h3><p>根据“关于评选2022年大学生征兵工作先进个人、先进集体的通知”要求，经相关部门、学院及个人申请，评审领导工作组审核与评议。现将2022年大学生征兵工作先进个人、先进集体的名单进行公示。</p><h3>一、征兵工作先进个人名单：</h3><p>能源与动力工程学院：陈红梅\\n\\n光电信息与计算机工程学院：汪芯瑜\\n\\n管理学院：周 强\\n\\n机械工程学院：李 丰\\n\\n外语学院：金小东 何伟琴\\n\\n环境与建筑学院：曹桂馥 黄 莹\\n\\n出版印刷与艺术设计学院：张玉璞\\n\\n理学院：李 凡\\n\\n材料与化学学院：林志威 宋一婷\\n\\n中英国际学院：王 婷\\n\\n中德国际学院：柴文一\\n\\n基础学院：林发龙</p><h3>二、征兵工作先进集体名单：</h3><p>机械工程学院\\n\\n外语学院\\n\\n环境与建筑学院\\n\\n材料与化学学院</p>\", \"messages\": [{\"value\": \"根据“关于评选2022年大学生征兵工作先进个人、先进集体的通知”要求，经相关部门、学院及个人申请，评审领导工作组审核与评议。现将2022年大学生征兵工作先进个人、先进集体的名单进行公示。\"}, {\"value\": \"能源与动力工程学院：陈红梅\\n\\n光电信息与计算机工程学院：汪芯瑜\\n\\n管理学院：周 强\\n\\n机械工程学院：李 丰\\n\\n外语学院：金小东 何伟琴\\n\\n环境与建筑学院：曹桂馥 黄 莹\\n\\n出版印刷与艺术设计学院：张玉璞\\n\\n理学院：李 凡\\n\\n材料与化学学院：林志威 宋一婷\\n\\n中英国际学院：王 婷\\n\\n中德国际学院：柴文一\\n\\n基础学院：林发龙\"}, {\"value\": \"机械工程学院\\n\\n外语学院\\n\\n环境与建筑学院\\n\\n材料与化学学院\"}]}',0,0,' 关于2022年大学生征兵工作先进个人、先进集体评选结果的公示'),(57,' 2021-2022学年资助育人先进个人和集体名单公示','2022-12-15 13:52:18','2023-12-31 23:59:59','\"\\\"null\\\"\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}, {\"value\": \"  2021-2022学年资助育人工作优秀教师（10个）：\"}, {\"value\": \" 2021-2022学年资助育人工作先进集体（5个）：\"}], \"message\": \"<h3></h3><p>为充分调动学生资助工作各条线的积极性，促进我校学生资助工作规范、高效开展，切实做好家庭经济困难学生的资助和育人工作。经个人（集体）申请、部门推荐、由学生思想政治工作与学生管理委员会组织专项评议小组进行集体评审，现将2021-2022学年资助育人先进个人（集体）评审结果进行公示：</p><h3>  2021-2022学年资助育人工作优秀教师（10个）：</h3><p>何伟琴、徐丽丽、闫小磊、陈颖(能动)、崔晚词、庄园、杜轶楠、冯丹阳、闫五一、林志威</p><h3> 2021-2022学年资助育人工作先进集体（5个）：</h3><p>光电信息与计算机工程学院\\n\\n管理学院\\n\\n健康科学与工程学院\\n\\n理学院\\n\\n材料与化学学院</p>\", \"messages\": [{\"value\": \"为充分调动学生资助工作各条线的积极性，促进我校学生资助工作规范、高效开展，切实做好家庭经济困难学生的资助和育人工作。经个人（集体）申请、部门推荐、由学生思想政治工作与学生管理委员会组织专项评议小组进行集体评审，现将2021-2022学年资助育人先进个人（集体）评审结果进行公示：\"}, {\"value\": \"何伟琴、徐丽丽、闫小磊、陈颖(能动)、崔晚词、庄园、杜轶楠、冯丹阳、闫五一、林志威\"}, {\"value\": \"光电信息与计算机工程学院\\n\\n管理学院\\n\\n健康科学与工程学院\\n\\n理学院\\n\\n材料与化学学院\"}]}',0,0,' 2021-2022学年资助育人先进个人和集体名单公示'),(58,' 2022年上海理工大学优秀劳动教育实践项目名单公示','2022-12-16 13:22:51','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"http:\\\\\\\\43.143.78.169:8080/static/img/mid58-1.jpg\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>为贯彻落实《关于全面加强新时代大中小学劳动教育的意见》，鼓励学院贯通校内校外、盘活共享资源，结合学科专业特色、对接国家发展需求，开展内涵多元和形式多样的劳动教育，阶段性总结较为成熟的工作经验和有效做法，努力形成德智体美劳“五育”并举的育人格局，助力学校构建具有上理特色的创造性劳动教育体系，学校开展了2022年优秀劳动教育实践项目评选工作。经过自主申报、组织推荐、学校评审，最终选出以下优秀劳动教育实践项目。</p><div class=\'imgStyle\'><img class=\'img-style\' src=\'http:\\\\\\\\43.143.78.169:8080/static/img/mid58-1.jpg\'/><span></span></div>\", \"messages\": [{\"value\": \"为贯彻落实《关于全面加强新时代大中小学劳动教育的意见》，鼓励学院贯通校内校外、盘活共享资源，结合学科专业特色、对接国家发展需求，开展内涵多元和形式多样的劳动教育，阶段性总结较为成熟的工作经验和有效做法，努力形成德智体美劳“五育”并举的育人格局，助力学校构建具有上理特色的创造性劳动教育体系，学校开展了2022年优秀劳动教育实践项目评选工作。经过自主申报、组织推荐、学校评审，最终选出以下优秀劳动教育实践项目。\"}]}',0,0,' 2022年上海理工大学优秀劳动教育实践项目名单公示'),(59,' 关于2022年度上海市重点工程实事立功竞赛 优秀团队的公示','2022-12-08 09:29:19','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"根据沪竞[2022]8号文件《关于开展2022年度上海市重点工程实事立功竞赛先进评选工作的通知》，经基建处申请，学校同意，拟上报“上海理工大学基建处”为2022年上海市重点工程实事立功竞赛优秀团队，特此公示。\"}], \"message\": \"<h3>根据沪竞[2022]8号文件《关于开展2022年度上海市重点工程实事立功竞赛先进评选工作的通知》，经基建处申请，学校同意，拟上报“上海理工大学基建处”为2022年上海市重点工程实事立功竞赛优秀团队，特此公示。</h3><p>对以上公示对象如有异议，请在2022年12月14日之前向学校反映，联系电话：55272504，联系地址：思晏堂105室，联系人：安老师。</p>\", \"messages\": [{\"value\": \"对以上公示对象如有异议，请在2022年12月14日之前向学校反映，联系电话：55272504，联系地址：思晏堂105室，联系人：安老师。\"}]}',0,0,'关于2022年度上海市重点工程实事立功竞赛 优秀团队的公示'),(60,' 关于2023年全国巾帼文明岗和全国巾帼建功标兵拟推荐集体（个人）的公示','2022-11-30 14:16:39','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"根据沪教妇文件《关于上海市教育系统推荐2023年全国城乡妇女岗位建功先进集体（个人）的通知》，校妇工委在学校组织开展全国巾帼文明岗和全国巾帼建功标兵的推荐活动。经学院、部门组织申报，妇工委集体评选等程序，现将拟推荐名单公示如下：\"}, {\"value\": \"\"}], \"message\": \"<h3>根据沪教妇文件《关于上海市教育系统推荐2023年全国城乡妇女岗位建功先进集体（个人）的通知》，校妇工委在学校组织开展全国巾帼文明岗和全国巾帼建功标兵的推荐活动。经学院、部门组织申报，妇工委集体评选等程序，现将拟推荐名单公示如下：</h3><p>1.全国巾帼文明岗：上海理工大学光电信息与计算机工程学院医用光学影像团队</p><h3></h3><p>2.全国巾帼建功标兵：上海理工大学光电信息与计算机工程学院 彭滟</p>\", \"messages\": [{\"value\": \"1.全国巾帼文明岗：上海理工大学光电信息与计算机工程学院医用光学影像团队\"}, {\"value\": \"2.全国巾帼建功标兵：上海理工大学光电信息与计算机工程学院 彭滟\"}]}',0,0,' 关于2023年全国巾帼文明岗和全国巾帼建功标兵拟推荐集体（个人）的公示'),(61,' 关于组织教师参加2023年寒假教师研修的通知','2023-01-06 17:28:37','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"各部门、各学院（部、中心）：\"}], \"message\": \"<h3>各部门、各学院（部、中心）：</h3><p>为深入学习贯彻党的二十大精神，落实习近平总书记关于教育的重要论述，推进实施教育数字化战略行动，促进优质教育资源共享，服务教师教书育人工作和教育教学能力提升，并逐步推进教师寒假、暑假研修的常态化和相关培训的衔接，根据上海市教师专业发展工程领导小组办公室《关于做好参加2023年寒假教师研修的通知》和《教育部办公厅关于开展 2023 年寒假教师研修的通知》（教师厅函〔2022〕29号）的要求，现组织我校教师参加2023年寒假研修，请各部门、各学院做好组织工作。</p>\", \"messages\": [{\"value\": \"为深入学习贯彻党的二十大精神，落实习近平总书记关于教育的重要论述，推进实施教育数字化战略行动，促进优质教育资源共享，服务教师教书育人工作和教育教学能力提升，并逐步推进教师寒假、暑假研修的常态化和相关培训的衔接，根据上海市教师专业发展工程领导小组办公室《关于做好参加2023年寒假教师研修的通知》和《教育部办公厅关于开展 2023 年寒假教师研修的通知》（教师厅函〔2022〕29号）的要求，现组织我校教师参加2023年寒假研修，请各部门、各学院做好组织工作。\"}]}',0,0,' 关于组织教师参加2023年寒假教师研修的通知'),(64,' 2022年12月全国大学英语四、六级考试笔试考前须知及防疫安全提示','2022-11-25 14:02:09','2023-12-31 23:59:59','\"null\"','{\"file\": [{\"url\": \"http://jwc.usst.edu.cn/_upload/article/files/77/50/3313223141aaba8e3b4316c87b19/a14316ba-4bd2-4f77-9c0f-cf68c20b343b.pdf\", \"name\": \"\"}, {\"url\": \"http://jwc.usst.edu.cn/_upload/article/files/77/50/3313223141aaba8e3b4316c87b19/2c54512b-d1ca-4c18-aa85-1fa081c22313.pdf\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}, {\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"各相关同学：\"}, {\"value\": \"一、打印准考证\"}, {\"value\": \"二、准备相关证件\"}], \"message\": \"<h3>各相关同学：</h3><p>2022年下半年全国大学英语四、六级笔试将于12月10日举行，根据上海市教委、上海市教育考试院及学校有关工作要求，为切实保障广大考生的生命安全和身体健康，确保考生顺利参加考试，提醒各位考生注意以下事项：</p><h3>一、打印准考证</h3><p>12月1日9:00起，请考生自行下载打印准考证（http://cet-bm.neea.edu.cn/），仔细阅读准考证上的各项要求并遵照执行，提前确认考场位置。 </p><h3>二、准备相关证件</h3><p>（1）纸质版准考证\\n\\n（2）有效身份证件原件（含：含居民身份证、港澳台居民居住证、军人或武警人员证件、户口本、公安户籍部门开具的贴有近期免冠照片的身份证号码证明、护照）\\n\\n（3）学生证原件</p><h3>各相关同学：</h3><p>2022年下半年全国大学英语四、六级笔试将于12月10日举行，根据上海市教委、上海市教育考试院及学校有关工作要求，为切实保障广大考生的生命安全和身体健康，确保考生顺利参加考试，提醒各位考生注意以下事项：</p><h3>一、打印准考证</h3><p>12月1日9:00起，请考生自行下载打印准考证（http://cet-bm.neea.edu.cn/），仔细阅读准考证上的各项要求并遵照执行，提前确认考场位置。 </p><h3>二、准备相关证件</h3><p>（1）纸质版准考证\\n\\n（2）有效身份证件原件（含：含居民身份证、港澳台居民居住证、军人或武警人员证件、户口本、公安户籍部门开具的贴有近期免冠照片的身份证号码证明、护照）\\n\\n（3）学生证原件</p>\", \"messages\": [{\"value\": \"2022年下半年全国大学英语四、六级笔试将于12月10日举行，根据上海市教委、上海市教育考试院及学校有关工作要求，为切实保障广大考生的生命安全和身体健康，确保考生顺利参加考试，提醒各位考生注意以下事项：\"}, {\"value\": \"12月1日9:00起，请考生自行下载打印准考证（http://cet-bm.neea.edu.cn/），仔细阅读准考证上的各项要求并遵照执行，提前确认考场位置。 \"}, {\"value\": \"（1）纸质版准考证\\n\\n（2）有效身份证件原件（含：含居民身份证、港澳台居民居住证、军人或武警人员证件、户口本、公安户籍部门开具的贴有近期免冠照片的身份证号码证明、护照）\\n\\n（3）学生证原件\"}]}',0,0,' 2022年12月全国大学英语四、六级考试笔试考前须知及防疫安全提示'),(80,'禹德朝','2022-04-27 00:00:00','2024-04-30 00:00:00','{\"value\": \"\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"一、个人简介：\"}, {\"value\": \"二、主要学习与工作经历\"}, {\"value\": \"三、主要科研工作与成绩\"}, {\"value\": \"四、主要社会学术团体兼职\"}, {\"value\": \"五、主要研究方向\"}, {\"value\": \"六、联系方式\"}], \"message\": \"<h3>一、个人简介：</h3><p>归属学科专业：光学工程\\n\\n禹德朝，男，1984年出生，特聘教授，是否博导：否，是否硕导：是</p><h3>二、主要学习与工作经历</h3><p>2014年在华南理工大学发光材料与器件国家重点实验室获得工学博士学位（硕博连读），随后分别在美国罗格斯大学材料系和荷兰乌得勒支大学德拜纳米材料科学所从事博士后和研究员工作，2021年至今任职于上海理工大学光电信息与计算机工程学院。</p><h3>三、主要科研工作与成绩</h3><p>一直从事稀土/过渡金属离子掺杂高性能无机发光材料（荧光粉、纳米晶、玻璃与微晶玻璃等）的设计、制备、荧光光谱学及其在新型太阳能电池、荧光测温与传感等新型光电器件和生物医学领域的应用基础研究。以第一/通讯作者在Light, Adv. Opt. Mater., Phys. Rev. B, Phys. Rev. Appl., Appl. Phys. Lett.等国际学术期刊上发表研究性论文21篇，被引用1300余次。受邀在Adv. Opt. Mater.和《中国科学：化学》发表综述各1篇，受邀为知名书籍Phosphor Handbook第三版撰写专著章节1篇，获得2020年度上海市*******引进项目，获得2020年广东省自然科学“一等”奖（排名4/5）。</p><h3>四、主要社会学术团体兼职</h3><p>《发光学报》青年编委，国际学术期刊Crystals和Frontiers in Chemistry 的客座主编（Guest Editor）</p><h3>五、主要研究方向</h3><p>高效多功能微纳米晶多光子发光材料及其杂化体系的设计、制备与发光光谱学研究，实施并推进相关高性能发光体系在新型光电子器件、监测与传感和生物医学领域的应用与产品开发。</p><h3>六、联系方式</h3><p>光电楼926室，电子邮箱：d.yu@usst.edu.cn</p>\", \"messages\": [{\"value\": \"归属学科专业：光学工程\\n\\n禹德朝，男，1984年出生，特聘教授，是否博导：否，是否硕导：是\"}, {\"value\": \"2014年在华南理工大学发光材料与器件国家重点实验室获得工学博士学位（硕博连读），随后分别在美国罗格斯大学材料系和荷兰乌得勒支大学德拜纳米材料科学所从事博士后和研究员工作，2021年至今任职于上海理工大学光电信息与计算机工程学院。\"}, {\"value\": \"一直从事稀土/过渡金属离子掺杂高性能无机发光材料（荧光粉、纳米晶、玻璃与微晶玻璃等）的设计、制备、荧光光谱学及其在新型太阳能电池、荧光测温与传感等新型光电器件和生物医学领域的应用基础研究。以第一/通讯作者在Light, Adv. Opt. Mater., Phys. Rev. B, Phys. Rev. Appl., Appl. Phys. Lett.等国际学术期刊上发表研究性论文21篇，被引用1300余次。受邀在Adv. Opt. Mater.和《中国科学：化学》发表综述各1篇，受邀为知名书籍Phosphor Handbook第三版撰写专著章节1篇，获得2020年度上海市*******引进项目，获得2020年广东省自然科学“一等”奖（排名4/5）。\"}, {\"value\": \"《发光学报》青年编委，国际学术期刊Crystals和Frontiers in Chemistry 的客座主编（Guest Editor）\"}, {\"value\": \"高效多功能微纳米晶多光子发光材料及其杂化体系的设计、制备与发光光谱学研究，实施并推进相关高性能发光体系在新型光电子器件、监测与传感和生物医学领域的应用与产品开发。\"}, {\"value\": \"光电楼926室，电子邮箱：d.yu@usst.edu.cn\"}]}',0,0,'归属学科专业：光学工程  禹德朝，男，1984年出生，特聘教授，是否博导：否，是否硕导：是'),(81,'王宁','2023-03-06 00:00:00','2024-04-02 00:00:00','{\"value\": \"\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"一、个人介绍\"}, {\"value\": \"二、主要工作学习经历\"}, {\"value\": \"三、主要科研工作与成绩\"}, {\"value\": \"四、主要研究方向\"}, {\"value\": \"五、联系方式\"}], \"message\": \"<h3>一、个人介绍</h3><p>王宁，男，  汉族， 1984.12出生， 副教授，是否硕导：是（1、光学工程，2信息与通信工程），是否博导：否，  校、院内任职：无\\n</p><h3>二、主要工作学习经历</h3><p>2007.8-2012.12   西安电子科技大学硕博\\n\\n2013.1-2013.8     中国兵器工业第214研究所(苏州) 集成电路设计工程师\\n\\n2013.9-2015.10  上海交通大学电子科学与技术流动站  博士后\\n\\n2015.11-2018.7  上海理工大学光电学院光电信息工程系   讲师\\n\\n2018.8 -今          上海理工大学光电学院光电信息工程系  副教授\\n\\n2021.11-2022.8  美国弗吉尼亚理工大学              访问学者\\n\\n2022.8-2022.12  美国密歇根大学安娜堡分校         访问学者</p><h3>三、主要科研工作与成绩</h3><p>1. 主持项目\\n\\n主持国家自然科学基金青年基金、上海市自然科学基金面上项目、中国兵器工业集团项目、上海交大主任基金、上交-西电联合基金、西安电子科技大学、陕西科技大学课题等。                                             \\n\\n2. 代表性论文：(第一/通信SCI 35篇，其中：一区5篇，IEEE Trans. 15篇)\\n\\n1)     Energy Convers. Manage. 272. 116377 (2022)\\n\\n2)     J Power Sources. 562. 232785 (2023)\\n\\n3)     IEEE Trans. Ind. Electron. Early Access (2022)\\n\\n4)     IEEE Trans. Ind. Electron.69(10) (2022)\\n\\n5)     IEEE Trans. Ind. Electron.69(5) (2022)\\n\\n6)     IEEE Trans. Electron Devices. 66(11) (2019)\\n\\n7)     IEEE Trans. Electron Devices. 69(11) (2022)\\n\\n8)     IEEE Trans. Electron Devices. 68(4) (2021)\\n\\n9)     IEEE Trans. Electron Devices. 65(3) (2018)\\n\\n10)IEEE Trans. Electron Devices. 62(8) (2015)\\n\\n11)IEEE Trans. Instrum. Meas. 71. 9500809 (2022)\\n\\n12)IEEE Trans. Instrum. Meas. 71. 4007011 (2022)\\n\\n13)IEEE Trans. Compon. Packag. Manufact. Tech. 11(6) (2021)\\n\\n14)IEEE Trans. Compon. Packag. Manufact. Tech. 10(9) (2020)\\n\\n15)IEEE Trans. Compon. Packag. Manufact. Tech. 12(7) (2022)</p><h3>四、主要研究方向</h3><p>研究组致力于能量收集管理芯片设计、多源能量收集技术融合、半导体热电技术的研究\\n\\n1. 能量收集智能芯片\\n\\n2. 自供能热管理芯片设计\\n\\n3. 能量获取及功率管理\\n\\n4. 电子封装热管理\\n\\n5. 热电能量收集与能量转换</p><h3>五、联系方式</h3><p>地址：上海市杨浦区军工路580号上海理工大学新光电大楼916\\n\\n邮箱：nwang@usst.edu.cn\\n\\n个人网站：www.wangning985.com</p>\", \"messages\": [{\"value\": \"王宁，男，  汉族， 1984.12出生， 副教授，是否硕导：是（1、光学工程，2信息与通信工程），是否博导：否，  校、院内任职：无\\n\"}, {\"value\": \"2007.8-2012.12   西安电子科技大学硕博\\n\\n2013.1-2013.8     中国兵器工业第214研究所(苏州) 集成电路设计工程师\\n\\n2013.9-2015.10  上海交通大学电子科学与技术流动站  博士后\\n\\n2015.11-2018.7  上海理工大学光电学院光电信息工程系   讲师\\n\\n2018.8 -今          上海理工大学光电学院光电信息工程系  副教授\\n\\n2021.11-2022.8  美国弗吉尼亚理工大学              访问学者\\n\\n2022.8-2022.12  美国密歇根大学安娜堡分校         访问学者\"}, {\"value\": \"1. 主持项目\\n\\n主持国家自然科学基金青年基金、上海市自然科学基金面上项目、中国兵器工业集团项目、上海交大主任基金、上交-西电联合基金、西安电子科技大学、陕西科技大学课题等。                                             \\n\\n2. 代表性论文：(第一/通信SCI 35篇，其中：一区5篇，IEEE Trans. 15篇)\\n\\n1)     Energy Convers. Manage. 272. 116377 (2022)\\n\\n2)     J Power Sources. 562. 232785 (2023)\\n\\n3)     IEEE Trans. Ind. Electron. Early Access (2022)\\n\\n4)     IEEE Trans. Ind. Electron.69(10) (2022)\\n\\n5)     IEEE Trans. Ind. Electron.69(5) (2022)\\n\\n6)     IEEE Trans. Electron Devices. 66(11) (2019)\\n\\n7)     IEEE Trans. Electron Devices. 69(11) (2022)\\n\\n8)     IEEE Trans. Electron Devices. 68(4) (2021)\\n\\n9)     IEEE Trans. Electron Devices. 65(3) (2018)\\n\\n10)IEEE Trans. Electron Devices. 62(8) (2015)\\n\\n11)IEEE Trans. Instrum. Meas. 71. 9500809 (2022)\\n\\n12)IEEE Trans. Instrum. Meas. 71. 4007011 (2022)\\n\\n13)IEEE Trans. Compon. Packag. Manufact. Tech. 11(6) (2021)\\n\\n14)IEEE Trans. Compon. Packag. Manufact. Tech. 10(9) (2020)\\n\\n15)IEEE Trans. Compon. Packag. Manufact. Tech. 12(7) (2022)\"}, {\"value\": \"研究组致力于能量收集管理芯片设计、多源能量收集技术融合、半导体热电技术的研究\\n\\n1. 能量收集智能芯片\\n\\n2. 自供能热管理芯片设计\\n\\n3. 能量获取及功率管理\\n\\n4. 电子封装热管理\\n\\n5. 热电能量收集与能量转换\"}, {\"value\": \"地址：上海市杨浦区军工路580号上海理工大学新光电大楼916\\n\\n邮箱：nwang@usst.edu.cn\\n\\n个人网站：www.wangning985.com\"}]}',0,0,'王宁，男，  汉族， 1984.12出生， 副教授，是否硕导：是（1、光学工程，2信息与通信工程），是否博导：否，  校、院内任职：无'),(82,'李娜','2023-04-11 00:00:00','2027-04-22 00:00:00','{\"value\": \"\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"一、个人简介\"}, {\"value\": \"二、主要学习工作经历\"}, {\"value\": \"三、主要研究与成绩\"}, {\"value\": \"四、主要研究方向\"}, {\"value\": \"五、联系方式\"}], \"message\": \"<h3>一、个人简介</h3><p>归属学科专业：计算机科学与技术、软件工程\\n\\n李娜，女，汉族，1991年 4月出生，是否博导：否，是否硕导：是，校、院内任职：无</p><h3>二、主要学习工作经历</h3><p>2021年毕业于南京大学计算机科学与技术系，获工学博士学位。2022年 1月入职上海理工大学计算机科学与工程系任教。</p><h3>三、主要研究与成绩</h3><p>科研项目：\\n\\n主持教育部产学合作协同育人项目、上海市大数据管理系统工程研究中心开放基\\n\\n金、上海高校青年教师培养资助计划等项目。\\n\\n学术成果：\\n\\n以 第 一 作 者 身 份 在 国 际 顶 级 会 议 International Joint Conference on  \\n\\nArtificial Intelligence（IJCAI）、International Conference on Research  \\n\\non Development in Information Retrieval（SIGIR）、IEEE International  \\n\\nSemantic Web Conference（ISWC），国际国内重要期刊 Computers & Geosciences、\\n\\n《软件学报》发表学术研究论文数篇，论文列表详见\\n\\nhttps://scholar.google.com/citations?user=JZUxMuwAAAAJ&hl=zh-CN\\n</p><h3>四、主要研究方向</h3><p>[1]自然语言处理\\n\\n[2]深度学习及其在文本、图像领域的应用</p><h3>五、联系方式</h3><p>电子邮箱：li_na@usst.edu.cn</p>\", \"messages\": [{\"value\": \"归属学科专业：计算机科学与技术、软件工程\\n\\n李娜，女，汉族，1991年 4月出生，是否博导：否，是否硕导：是，校、院内任职：无\"}, {\"value\": \"2021年毕业于南京大学计算机科学与技术系，获工学博士学位。2022年 1月入职上海理工大学计算机科学与工程系任教。\"}, {\"value\": \"科研项目：\\n\\n主持教育部产学合作协同育人项目、上海市大数据管理系统工程研究中心开放基\\n\\n金、上海高校青年教师培养资助计划等项目。\\n\\n学术成果：\\n\\n以 第 一 作 者 身 份 在 国 际 顶 级 会 议 International Joint Conference on  \\n\\nArtificial Intelligence（IJCAI）、International Conference on Research  \\n\\non Development in Information Retrieval（SIGIR）、IEEE International  \\n\\nSemantic Web Conference（ISWC），国际国内重要期刊 Computers & Geosciences、\\n\\n《软件学报》发表学术研究论文数篇，论文列表详见\\n\\nhttps://scholar.google.com/citations?user=JZUxMuwAAAAJ&hl=zh-CN\\n\"}, {\"value\": \"[1]自然语言处理\\n\\n[2]深度学习及其在文本、图像领域的应用\"}, {\"value\": \"电子邮箱：li_na@usst.edu.cn\"}]}',0,0,'归属学科专业：计算机科学与技术、软件工程  李娜，女，汉族，1991年 4月出生，是否博导：否，是否硕导：是，校、院内任职：无'),(83,'艾均','2023-04-11 00:00:00','2027-04-22 00:00:00','{\"value\": \"\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"一、个人简介\"}, {\"value\": \"二、主要学习工作经历\"}, {\"value\": \"三、主要研究与成绩\"}, {\"value\": \"四、主要研究方向\"}, {\"value\": \"五、联系方式\"}], \"message\": \"<h3>一、个人简介</h3><p>归属学科专业：计算机科学与技术、软件工程\\n\\n李娜，女，汉族，1991年 4月出生，是否博导：否，是否硕导：是，校、院内任职：无</p><h3>二、主要学习工作经历</h3><p>2021年毕业于南京大学计算机科学与技术系，获工学博士学位。2022年 1月入职上海理工大学计算机科学与工程系任教。</p><h3>三、主要研究与成绩</h3><p>科研项目：\\n\\n主持教育部产学合作协同育人项目、上海市大数据管理系统工程研究中心开放基\\n\\n金、上海高校青年教师培养资助计划等项目。\\n\\n学术成果：\\n\\n以 第 一 作 者 身 份 在 国 际 顶 级 会 议 International Joint Conference on  \\n\\nArtificial Intelligence（IJCAI）、International Conference on Research  \\n\\non Development in Information Retrieval（SIGIR）、IEEE International  \\n\\nSemantic Web Conference（ISWC），国际国内重要期刊 Computers & Geosciences、\\n\\n《软件学报》发表学术研究论文数篇，论文列表详见\\n\\nhttps://scholar.google.com/citations?user=JZUxMuwAAAAJ&hl=zh-CN\\n</p><h3>四、主要研究方向</h3><p>[1]自然语言处理\\n\\n[2]深度学习及其在文本、图像领域的应用</p><h3>五、联系方式</h3><p>电子邮箱：li_na@usst.edu.cn</p><h3>一、个人简介</h3><p>归属学科专业：计算机科学与技术\\n艾均， 男，汉族，中共党员 ， 是否博导：否， 是否硕导：是</p><h3>二、主要学习工作经历</h3><p>2000年9月进入沈阳工业大学电气工程学院自动化系，2004年获学士学位。2006年进入东北大学信息科学与工程学院，攻读计算机应用技术专业硕士学位，2008年获得硕士学位。同年，师从东北大学赵海教授攻读计算机应用技术专业博士学位。2010年9月获得国家公派联合培养博士研究生资格，赴美国卡内基梅隆大学计算机学院，在Carley教授指导下学习社交网络分析。2011年10月返回东北大学，2013年7月获得博士学位。2013年9月加入上海理工大学光学信息与计算机工程学院任教至今。</p><h3>三、主要研究与成绩</h3><p>参加国家自然科学基金等纵向科研项目3项。第一或通讯作者发表论文6篇，其中SCI检索论文3篇，EI检索论文3篇。其他合作论文14篇，其中SCI检索论文2篇，EI检索论文10篇。被聘为IEEE Trans Syst Man Cybern A等期刊审稿人。论文列表参见：http://scholar.google.com.hk/citations?user=I9SWloYAAAAJ&hl=en</p><h3>四、主要研究方向</h3><p>复杂网络、社交网络</p><h3>五、联系方式</h3><p>计算机系610， 电子邮箱：aijun@outlook.com</p>\", \"messages\": [{\"value\": \"归属学科专业：计算机科学与技术\\n艾均， 男，汉族，中共党员 ， 是否博导：否， 是否硕导：是\"}, {\"value\": \"2000年9月进入沈阳工业大学电气工程学院自动化系，2004年获学士学位。2006年进入东北大学信息科学与工程学院，攻读计算机应用技术专业硕士学位，2008年获得硕士学位。同年，师从东北大学赵海教授攻读计算机应用技术专业博士学位。2010年9月获得国家公派联合培养博士研究生资格，赴美国卡内基梅隆大学计算机学院，在Carley教授指导下学习社交网络分析。2011年10月返回东北大学，2013年7月获得博士学位。2013年9月加入上海理工大学光学信息与计算机工程学院任教至今。\"}, {\"value\": \"参加国家自然科学基金等纵向科研项目3项。第一或通讯作者发表论文6篇，其中SCI检索论文3篇，EI检索论文3篇。其他合作论文14篇，其中SCI检索论文2篇，EI检索论文10篇。被聘为IEEE Trans Syst Man Cybern A等期刊审稿人。论文列表参见：http://scholar.google.com.hk/citations?user=I9SWloYAAAAJ&hl=en\"}, {\"value\": \"复杂网络、社交网络\"}, {\"value\": \"计算机系610， 电子邮箱：aijun@outlook.com\"}]}',0,0,'归属学科专业：计算机科学与技术 艾均， 男，汉族，中共党员 ， 是否博导：否， 是否硕导：是'),(84,'教务处简介','2023-03-20 00:00:00','2028-04-15 00:00:00','\"{\\\"value\\\": \\\"\\\"}\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"一、简介\"}], \"message\": \"<h3>一、简介</h3><p>  上海理工大学教务处，位于516校区，公告服务中心大楼，主要负责发布教务信息。经常联合创新创业学院举办竞赛。网页共有六个模块，分别是，综合信息，教学研究及质量监控，教学运行管理，实践教学，重要公告，办事指南。包含八个教学相关按钮链接，分别是，教务管理系统，教学日历，培养计划，课程中心，考试报名，跨校辅修，一网畅学，语言文字，为师生提供了极大的便利。</p>\", \"messages\": [{\"value\": \"  上海理工大学教务处，位于516校区，公告服务中心大楼，主要负责发布教务信息。经常联合创新创业学院举办竞赛。网页共有六个模块，分别是，综合信息，教学研究及质量监控，教学运行管理，实践教学，重要公告，办事指南。包含八个教学相关按钮链接，分别是，教务管理系统，教学日历，培养计划，课程中心，考试报名，跨校辅修，一网畅学，语言文字，为师生提供了极大的便利。\"}]}',24,0,'上海理工大学教务处，位于516校区，公告服务中心大楼，主要负责发布教务信息，包含教务功能窗口链接。'),(85,'科学发展研究院简介','2023-03-20 00:00:00','2028-04-15 00:00:00','{\"value\": \"\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"一、简介\"}], \"message\": \"<h3>一、简介</h3><p>  上海理工大学教务处，位于516校区，公告服务中心大楼，主要负责发布教务信息。信息栏有六个模块，分别是，综合信息，教学研究及质量监控，教学运行管理，实践教学，重要公告，办事指南。包含八个教学相关按钮链接，分别是，教务管理系统，教学日历，培养计划，课程中心，考试报名，跨校辅修，一网畅学，语言文字，为师生提供了极大的便利。</p><h3>一、简介</h3><p>上海理工大学科学发展研究院，位于学校580校区，主要负责展示学校科研信息与成绩。主要也分为六大模块，分别是，通知公告，主要发布一些活动开展，项目申报信息；科技动态，主要发布一些学校科技相关信息；公示栏，主要发布我校的提名信息；高水平大学学科建设简报，负责发布每一年的工作简报；专利信息栏目，主要发布每一年专利已经软件著作权的信息情况；科技简报，发布我校期刊信息。</p>\", \"messages\": [{\"value\": \"上海理工大学科学发展研究院，位于学校580校区，主要负责展示学校科研信息与成绩。主要也分为六大模块，分别是，通知公告，主要发布一些活动开展，项目申报信息；科技动态，主要发布一些学校科技相关信息；公示栏，主要发布我校的提名信息；高水平大学学科建设简报，负责发布每一年的工作简报；专利信息栏目，主要发布每一年专利已经软件著作权的信息情况；科技简报，发布我校期刊信息。\"}]}',32,0,'上海理工大学科学发展研究院，位于学校580校区，主要负责展示学校科研信息与成绩。'),(86,'实验大变身活动简介','2022-07-30 00:00:00','2024-04-01 00:00:00','\"{\\\"value\\\": \\\"\\\"}\"','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"一、简介\"}], \"message\": \"<h3>一、简介</h3><p>12月12号，理学院即将开展“实验室大变身”主题活动，将劳动教育和实验室安全教育紧密结合，使实验室旧貌换新颜。学院将进一步深化实验室劳动教育，落实实验室值日生制度和学生安全员制度，扎实做好实验室安全工作，全力保障学院教学、科研工作平稳有序，助力学院建设。</p>\", \"messages\": [{\"value\": \"12月12号，理学院即将开展“实验室大变身”主题活动，将劳动教育和实验室安全教育紧密结合，使实验室旧貌换新颜。学院将进一步深化实验室劳动教育，落实实验室值日生制度和学生安全员制度，扎实做好实验室安全工作，全力保障学院教学、科研工作平稳有序，助力学院建设。\"}]}',16,0,'12月12号，理学院开展“实验室大变身”主题活动，将劳动教育和实验室安全教育紧密结合，使实验室旧貌换新颜。'),(88,'秋炫沪江活动简介','2022-07-16 00:00:00','2024-04-01 00:00:00','{\"value\": \"2022-11-24 00:00:00\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"一、简介\"}], \"message\": \"<h3>一、简介</h3><p>  上海理工大学教务处，位于516校区，公告服务中心大楼，主要负责发布教务信息。信息栏有六个模块，分别是，综合信息，教学研究及质量监控，教学运行管理，实践教学，重要公告，办事指南。包含八个教学相关按钮链接，分别是，教务管理系统，教学日历，培养计划，课程中心，考试报名，跨校辅修，一网畅学，语言文字，为师生提供了极大的便利。</p><h3>一、简介</h3><p>上海理工大学科学发展研究院，位于学校580校区，主要负责展示学校科研信息与成绩。主要也分为六大模块，分别是，通知公告，主要发布一些活动开展，项目申报信息；科技动态，主要发布一些学校科技相关信息；公示栏，主要发布我校的提名信息；高水平大学学科建设简报，负责发布每一年的工作简报；专利信息栏目，主要发布每一年专利已经软件著作权的信息情况；科技简报，发布我校期刊信息。</p><h3>一、简介</h3><p>12月12号，理学院即将开展“实验室大变身”主题活动，将劳动教育和实验室安全教育紧密结合，使实验室旧貌换新颜。学院将进一步深化实验室劳动教育，落实实验室值日生制度和学生安全员制度，扎实做好实验室安全工作，全力保障学院教学、科研工作平稳有序，助力学院建设。</p><h3>一、简介</h3><p>“劳动教育是中国特色社会主义教育制度的重要内容，直接决定社会主义建设者和接班人的劳动精神面貌、劳动价值取向和劳动技能水平。”为贯彻落实中共中央（国务院）、教育部、上海市委（市政府）发布的  《关于全面加强新时代大中小学劳动教育的意见》等相关文件精神，通过劳动教育来强化马克思主义劳动观，牢固树立劳动最光荣、劳动最崇高、劳动最伟大、劳动最美丽的观念，引导学生养成勤奋劳动的良好习惯、享受劳动乐趣、弘扬工匠精神，学校将在研究生中继续 开展“我是光荣劳动者”主题实践教育活动，把实践实训作为劳动育人的主要途径，通过劳动教育来树德、增智、强体、育美，促进学生的德智体美劳全面发展。</p><h3>一、简介</h3><p>“劳动教育是中国特色社会主义教育制度的重要内容，直接决定社会主义建设者和接班人的劳动精神面貌、劳动价值取向和劳动技能水平。”为贯彻落实中共中央（国务院）、教育部、上海市委（市政府）发布的  《关于全面加强新时代大中小学劳动教育的意见》等相关文件精神，通过劳动教育来强化马克思主义劳动观，牢固树立劳动最光荣、劳动最崇高、劳动最伟大、劳动最美丽的观念，引导学生养成勤奋劳动的良好习惯、享受劳动乐趣、弘扬工匠精神，学校将在研究生中继续 开展“我是光荣劳动者”主题实践教育活动，把实践实训作为劳动育人的主要途径，通过劳动教育来树德、增智、强体、育美，促进学生的德智体美劳全面发展。</p>\", \"messages\": [{\"value\": \"“劳动教育是中国特色社会主义教育制度的重要内容，直接决定社会主义建设者和接班人的劳动精神面貌、劳动价值取向和劳动技能水平。”为贯彻落实中共中央（国务院）、教育部、上海市委（市政府）发布的  《关于全面加强新时代大中小学劳动教育的意见》等相关文件精神，通过劳动教育来强化马克思主义劳动观，牢固树立劳动最光荣、劳动最崇高、劳动最伟大、劳动最美丽的观念，引导学生养成勤奋劳动的良好习惯、享受劳动乐趣、弘扬工匠精神，学校将在研究生中继续 开展“我是光荣劳动者”主题实践教育活动，把实践实训作为劳动育人的主要途径，通过劳动教育来树德、增智、强体、育美，促进学生的德智体美劳全面发展。\"}]}',12,0,'劳动教育是中国特色社会主义教育制度的重要内容，直接决定社会主义建设者和接班人的劳动精神面貌、劳动价值取向和劳动技能水平'),(89,'走进海沈村活动简介','2022-07-22 00:00:00','2024-04-01 00:00:00','{\"value\": \"2022-11-24 00:00:00\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"一、简介\"}], \"message\": \"<h3>一、简介</h3><p>  上海理工大学教务处，位于516校区，公告服务中心大楼，主要负责发布教务信息。信息栏有六个模块，分别是，综合信息，教学研究及质量监控，教学运行管理，实践教学，重要公告，办事指南。包含八个教学相关按钮链接，分别是，教务管理系统，教学日历，培养计划，课程中心，考试报名，跨校辅修，一网畅学，语言文字，为师生提供了极大的便利。</p><h3>一、简介</h3><p>上海理工大学科学发展研究院，位于学校580校区，主要负责展示学校科研信息与成绩。主要也分为六大模块，分别是，通知公告，主要发布一些活动开展，项目申报信息；科技动态，主要发布一些学校科技相关信息；公示栏，主要发布我校的提名信息；高水平大学学科建设简报，负责发布每一年的工作简报；专利信息栏目，主要发布每一年专利已经软件著作权的信息情况；科技简报，发布我校期刊信息。</p><h3>一、简介</h3><p>12月12号，理学院即将开展“实验室大变身”主题活动，将劳动教育和实验室安全教育紧密结合，使实验室旧貌换新颜。学院将进一步深化实验室劳动教育，落实实验室值日生制度和学生安全员制度，扎实做好实验室安全工作，全力保障学院教学、科研工作平稳有序，助力学院建设。</p><h3>一、简介</h3><p>“劳动教育是中国特色社会主义教育制度的重要内容，直接决定社会主义建设者和接班人的劳动精神面貌、劳动价值取向和劳动技能水平。”为贯彻落实中共中央（国务院）、教育部、上海市委（市政府）发布的  《关于全面加强新时代大中小学劳动教育的意见》等相关文件精神，通过劳动教育来强化马克思主义劳动观，牢固树立劳动最光荣、劳动最崇高、劳动最伟大、劳动最美丽的观念，引导学生养成勤奋劳动的良好习惯、享受劳动乐趣、弘扬工匠精神，学校将在研究生中继续 开展“我是光荣劳动者”主题实践教育活动，把实践实训作为劳动育人的主要途径，通过劳动教育来树德、增智、强体、育美，促进学生的德智体美劳全面发展。</p><h3>一、简介</h3><p>“劳动教育是中国特色社会主义教育制度的重要内容，直接决定社会主义建设者和接班人的劳动精神面貌、劳动价值取向和劳动技能水平。”为贯彻落实中共中央（国务院）、教育部、上海市委（市政府）发布的  《关于全面加强新时代大中小学劳动教育的意见》等相关文件精神，通过劳动教育来强化马克思主义劳动观，牢固树立劳动最光荣、劳动最崇高、劳动最伟大、劳动最美丽的观念，引导学生养成勤奋劳动的良好习惯、享受劳动乐趣、弘扬工匠精神，学校将在研究生中继续 开展“我是光荣劳动者”主题实践教育活动，把实践实训作为劳动育人的主要途径，通过劳动教育来树德、增智、强体、育美，促进学生的德智体美劳全面发展。</p><h3>一、简介</h3><p>劳动最光荣，奋斗最幸福。为了让学生树立劳动意识、增强劳动观念、养成劳动习惯，11月23日，党委研工部部长彭宗祥、版艺学院党委书记张华带领30余名师生前往上海市浦东新区惠南镇海沈村——奥运冠军、二十大代表钟天使的家乡，通过沉浸式党课、户外采风和田间劳动等形式，深入了解了海沈村在实现乡村振兴这一过程中的变化和发展。\\n加强劳动教育，是培养担当民族复兴大任时代新人的内在需要。在海沈村党群服务中心，彭宗祥、张华和海沈村村支部书记庄平共同揭牌上海理工大学劳动教育实践基地，海沈村成为我校又一劳动教育实践基地。</p>\", \"messages\": [{\"value\": \"劳动最光荣，奋斗最幸福。为了让学生树立劳动意识、增强劳动观念、养成劳动习惯，11月23日，党委研工部部长彭宗祥、版艺学院党委书记张华带领30余名师生前往上海市浦东新区惠南镇海沈村——奥运冠军、二十大代表钟天使的家乡，通过沉浸式党课、户外采风和田间劳动等形式，深入了解了海沈村在实现乡村振兴这一过程中的变化和发展。\\n加强劳动教育，是培养担当民族复兴大任时代新人的内在需要。在海沈村党群服务中心，彭宗祥、张华和海沈村村支部书记庄平共同揭牌上海理工大学劳动教育实践基地，海沈村成为我校又一劳动教育实践基地。\"}]}',10,0,'劳动最光荣，奋斗最幸福。'),(90,'创新创业学院简介','2022-07-22 00:00:00','2028-04-01 00:00:00','{\"value\": \"2022-11-24 00:00:00\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"一、简介\"}], \"message\": \"<h3>一、简介</h3><p>  上海理工大学教务处，位于516校区，公告服务中心大楼，主要负责发布教务信息。信息栏有六个模块，分别是，综合信息，教学研究及质量监控，教学运行管理，实践教学，重要公告，办事指南。包含八个教学相关按钮链接，分别是，教务管理系统，教学日历，培养计划，课程中心，考试报名，跨校辅修，一网畅学，语言文字，为师生提供了极大的便利。</p><h3>一、简介</h3><p>上海理工大学科学发展研究院，位于学校580校区，主要负责展示学校科研信息与成绩。主要也分为六大模块，分别是，通知公告，主要发布一些活动开展，项目申报信息；科技动态，主要发布一些学校科技相关信息；公示栏，主要发布我校的提名信息；高水平大学学科建设简报，负责发布每一年的工作简报；专利信息栏目，主要发布每一年专利已经软件著作权的信息情况；科技简报，发布我校期刊信息。</p><h3>一、简介</h3><p>12月12号，理学院即将开展“实验室大变身”主题活动，将劳动教育和实验室安全教育紧密结合，使实验室旧貌换新颜。学院将进一步深化实验室劳动教育，落实实验室值日生制度和学生安全员制度，扎实做好实验室安全工作，全力保障学院教学、科研工作平稳有序，助力学院建设。</p><h3>一、简介</h3><p>“劳动教育是中国特色社会主义教育制度的重要内容，直接决定社会主义建设者和接班人的劳动精神面貌、劳动价值取向和劳动技能水平。”为贯彻落实中共中央（国务院）、教育部、上海市委（市政府）发布的  《关于全面加强新时代大中小学劳动教育的意见》等相关文件精神，通过劳动教育来强化马克思主义劳动观，牢固树立劳动最光荣、劳动最崇高、劳动最伟大、劳动最美丽的观念，引导学生养成勤奋劳动的良好习惯、享受劳动乐趣、弘扬工匠精神，学校将在研究生中继续 开展“我是光荣劳动者”主题实践教育活动，把实践实训作为劳动育人的主要途径，通过劳动教育来树德、增智、强体、育美，促进学生的德智体美劳全面发展。</p><h3>一、简介</h3><p>“劳动教育是中国特色社会主义教育制度的重要内容，直接决定社会主义建设者和接班人的劳动精神面貌、劳动价值取向和劳动技能水平。”为贯彻落实中共中央（国务院）、教育部、上海市委（市政府）发布的  《关于全面加强新时代大中小学劳动教育的意见》等相关文件精神，通过劳动教育来强化马克思主义劳动观，牢固树立劳动最光荣、劳动最崇高、劳动最伟大、劳动最美丽的观念，引导学生养成勤奋劳动的良好习惯、享受劳动乐趣、弘扬工匠精神，学校将在研究生中继续 开展“我是光荣劳动者”主题实践教育活动，把实践实训作为劳动育人的主要途径，通过劳动教育来树德、增智、强体、育美，促进学生的德智体美劳全面发展。</p><h3>一、简介</h3><p>劳动最光荣，奋斗最幸福。为了让学生树立劳动意识、增强劳动观念、养成劳动习惯，11月23日，党委研工部部长彭宗祥、版艺学院党委书记张华带领30余名师生前往上海市浦东新区惠南镇海沈村——奥运冠军、二十大代表钟天使的家乡，通过沉浸式党课、户外采风和田间劳动等形式，深入了解了海沈村在实现乡村振兴这一过程中的变化和发展。\\n加强劳动教育，是培养担当民族复兴大任时代新人的内在需要。在海沈村党群服务中心，彭宗祥、张华和海沈村村支部书记庄平共同揭牌上海理工大学劳动教育实践基地，海沈村成为我校又一劳动教育实践基地。</p><h3>一、简介</h3><p>创新创业学院，是我校师生创新创业能力的体现之地，师生共同协作，不仅让学生自己提高了能力，也为学校赢得了荣誉。经常承办一些科创竞赛，让学生以赛带学，提高综合素质。</p>\", \"messages\": [{\"value\": \"创新创业学院，是我校师生创新创业能力的体现之地，师生共同协作，不仅让学生自己提高了能力，也为学校赢得了荣誉。经常承办一些科创竞赛，让学生以赛带学，提高综合素质。\"}]}',36,0,'创新创业学院位于上海理工大学580校区，主要负责发布各类创新创业以及各类竞赛信息。'),(91,'计算机网络','2023-04-01 00:00:00','2026-04-25 00:00:00','{\"value\": \"\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>计算机网络是计算机科学与技术专业的核心课程。该课程比较全面系统地介绍了计算机网络的发展和原理体系结构、物理层、数据链路层、网络层、运输层、应用层、网络安全、因特网上的音频/视频服务、无线网络和下一代因特网等内容。通过本课程的学习，使学生能够对计算机网络原理与技术有一个系统的、全面的了解；掌握计算机网络的概念、组成和体系结构，初步掌握数据通信、各层网络协议和网络互连等方面的基本问题和主要算法，使学生有较为全面、系统、扎实的知识基础，为学习其他课程以及从事计算机网络的研究、开发、管理和应用打下坚实的基础。</p>\", \"messages\": [{\"value\": \"计算机网络是计算机科学与技术专业的核心课程。该课程比较全面系统地介绍了计算机网络的发展和原理体系结构、物理层、数据链路层、网络层、运输层、应用层、网络安全、因特网上的音频/视频服务、无线网络和下一代因特网等内容。通过本课程的学习，使学生能够对计算机网络原理与技术有一个系统的、全面的了解；掌握计算机网络的概念、组成和体系结构，初步掌握数据通信、各层网络协议和网络互连等方面的基本问题和主要算法，使学生有较为全面、系统、扎实的知识基础，为学习其他课程以及从事计算机网络的研究、开发、管理和应用打下坚实的基础。\"}]}',0,0,'本科精品课程'),(92,'传热学','2023-04-01 00:00:00','2026-04-25 00:00:00','{\"value\": \"\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>计算机网络是计算机科学与技术专业的核心课程。该课程比较全面系统地介绍了计算机网络的发展和原理体系结构、物理层、数据链路层、网络层、运输层、应用层、网络安全、因特网上的音频/视频服务、无线网络和下一代因特网等内容。通过本课程的学习，使学生能够对计算机网络原理与技术有一个系统的、全面的了解；掌握计算机网络的概念、组成和体系结构，初步掌握数据通信、各层网络协议和网络互连等方面的基本问题和主要算法，使学生有较为全面、系统、扎实的知识基础，为学习其他课程以及从事计算机网络的研究、开发、管理和应用打下坚实的基础。</p><h3></h3><p>传热学是研究热量传递规律的科学，是热能与动力工程专业的主干技术基础课。它不仅为学生学习有关的专业课程提供基础理论知识，也为从事热能利用、热工设备设计的工程技术人员打下必要的基础。\\n教学体系、教学理念以及教学手段先进，适应现代人才培养的需要。教学内容新颖，联系科研、生产、生活实际，将最新的科研成果引进了教学中，注重学生能力的培养和思维能力的训练。教学手段完备，教学方法和教学艺术科学有效，网络化教学资料丰富，实现了资源共享。</p>\", \"messages\": [{\"value\": \"传热学是研究热量传递规律的科学，是热能与动力工程专业的主干技术基础课。它不仅为学生学习有关的专业课程提供基础理论知识，也为从事热能利用、热工设备设计的工程技术人员打下必要的基础。\\n教学体系、教学理念以及教学手段先进，适应现代人才培养的需要。教学内容新颖，联系科研、生产、生活实际，将最新的科研成果引进了教学中，注重学生能力的培养和思维能力的训练。教学手段完备，教学方法和教学艺术科学有效，网络化教学资料丰富，实现了资源共享。\"}]}',0,0,'本科精品课程'),(93,'数控技术','2023-04-01 00:00:00','2026-04-25 00:00:00','{\"value\": \"\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>计算机网络是计算机科学与技术专业的核心课程。该课程比较全面系统地介绍了计算机网络的发展和原理体系结构、物理层、数据链路层、网络层、运输层、应用层、网络安全、因特网上的音频/视频服务、无线网络和下一代因特网等内容。通过本课程的学习，使学生能够对计算机网络原理与技术有一个系统的、全面的了解；掌握计算机网络的概念、组成和体系结构，初步掌握数据通信、各层网络协议和网络互连等方面的基本问题和主要算法，使学生有较为全面、系统、扎实的知识基础，为学习其他课程以及从事计算机网络的研究、开发、管理和应用打下坚实的基础。</p><h3></h3><p>传热学是研究热量传递规律的科学，是热能与动力工程专业的主干技术基础课。它不仅为学生学习有关的专业课程提供基础理论知识，也为从事热能利用、热工设备设计的工程技术人员打下必要的基础。\\n教学体系、教学理念以及教学手段先进，适应现代人才培养的需要。教学内容新颖，联系科研、生产、生活实际，将最新的科研成果引进了教学中，注重学生能力的培养和思维能力的训练。教学手段完备，教学方法和教学艺术科学有效，网络化教学资料丰富，实现了资源共享。</p><h3></h3><p>数控技术，简称“数控”。英文：Numerical Control（NC）。是指用数字、文字和符号组成的数字指令来实现一台或多台机械设备动作控制的技术。它所控制的通常是位置、角度、速度等机械量和与机械能量流向有关的开关量。 我校数控技术教学始于1990中期，当时的华东工业大学机械工程系开设了机床数控技术课程，开始了数控技术的教学和研究工作，是上海市最早开设数控技术与数控加工课程的高等院校之一。</p>\", \"messages\": [{\"value\": \"数控技术，简称“数控”。英文：Numerical Control（NC）。是指用数字、文字和符号组成的数字指令来实现一台或多台机械设备动作控制的技术。它所控制的通常是位置、角度、速度等机械量和与机械能量流向有关的开关量。 我校数控技术教学始于1990中期，当时的华东工业大学机械工程系开设了机床数控技术课程，开始了数控技术的教学和研究工作，是上海市最早开设数控技术与数控加工课程的高等院校之一。\"}]}',0,0,'本科精品课程'),(94,'郑七振','2023-04-01 00:00:00','2026-04-25 00:00:00','{\"value\": \"\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>计算机网络是计算机科学与技术专业的核心课程。该课程比较全面系统地介绍了计算机网络的发展和原理体系结构、物理层、数据链路层、网络层、运输层、应用层、网络安全、因特网上的音频/视频服务、无线网络和下一代因特网等内容。通过本课程的学习，使学生能够对计算机网络原理与技术有一个系统的、全面的了解；掌握计算机网络的概念、组成和体系结构，初步掌握数据通信、各层网络协议和网络互连等方面的基本问题和主要算法，使学生有较为全面、系统、扎实的知识基础，为学习其他课程以及从事计算机网络的研究、开发、管理和应用打下坚实的基础。</p><h3></h3><p>传热学是研究热量传递规律的科学，是热能与动力工程专业的主干技术基础课。它不仅为学生学习有关的专业课程提供基础理论知识，也为从事热能利用、热工设备设计的工程技术人员打下必要的基础。\\n教学体系、教学理念以及教学手段先进，适应现代人才培养的需要。教学内容新颖，联系科研、生产、生活实际，将最新的科研成果引进了教学中，注重学生能力的培养和思维能力的训练。教学手段完备，教学方法和教学艺术科学有效，网络化教学资料丰富，实现了资源共享。</p><h3></h3><p>数控技术，简称“数控”。英文：Numerical Control（NC）。是指用数字、文字和符号组成的数字指令来实现一台或多台机械设备动作控制的技术。它所控制的通常是位置、角度、速度等机械量和与机械能量流向有关的开关量。 我校数控技术教学始于1990中期，当时的华东工业大学机械工程系开设了机床数控技术课程，开始了数控技术的教学和研究工作，是上海市最早开设数控技术与数控加工课程的高等院校之一。</p><h3></h3><p>主要负责课程信息http://cc.usst.edu.cn/G2S/ShowSystem/TeacherDetail.aspx?r=2&RefID=79910</p>\", \"messages\": [{\"value\": \"主要负责课程信息http://cc.usst.edu.cn/G2S/ShowSystem/TeacherDetail.aspx?r=2&RefID=79910\"}]}',0,0,'教学名师'),(95,'张卫国','2023-04-01 00:00:00','2026-04-25 00:00:00','{\"value\": \"\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>计算机网络是计算机科学与技术专业的核心课程。该课程比较全面系统地介绍了计算机网络的发展和原理体系结构、物理层、数据链路层、网络层、运输层、应用层、网络安全、因特网上的音频/视频服务、无线网络和下一代因特网等内容。通过本课程的学习，使学生能够对计算机网络原理与技术有一个系统的、全面的了解；掌握计算机网络的概念、组成和体系结构，初步掌握数据通信、各层网络协议和网络互连等方面的基本问题和主要算法，使学生有较为全面、系统、扎实的知识基础，为学习其他课程以及从事计算机网络的研究、开发、管理和应用打下坚实的基础。</p><h3></h3><p>传热学是研究热量传递规律的科学，是热能与动力工程专业的主干技术基础课。它不仅为学生学习有关的专业课程提供基础理论知识，也为从事热能利用、热工设备设计的工程技术人员打下必要的基础。\\n教学体系、教学理念以及教学手段先进，适应现代人才培养的需要。教学内容新颖，联系科研、生产、生活实际，将最新的科研成果引进了教学中，注重学生能力的培养和思维能力的训练。教学手段完备，教学方法和教学艺术科学有效，网络化教学资料丰富，实现了资源共享。</p><h3></h3><p>数控技术，简称“数控”。英文：Numerical Control（NC）。是指用数字、文字和符号组成的数字指令来实现一台或多台机械设备动作控制的技术。它所控制的通常是位置、角度、速度等机械量和与机械能量流向有关的开关量。 我校数控技术教学始于1990中期，当时的华东工业大学机械工程系开设了机床数控技术课程，开始了数控技术的教学和研究工作，是上海市最早开设数控技术与数控加工课程的高等院校之一。</p><h3></h3><p>主要负责课程信息http://cc.usst.edu.cn/G2S/ShowSystem/TeacherDetail.aspx?r=2&RefID=79910</p><h3></h3><p>主要负责课程信息http://cc.usst.edu.cn/G2S/ShowSystem/TeacherDetail.aspx?r=2&RefID=79526</p>\", \"messages\": [{\"value\": \"主要负责课程信息http://cc.usst.edu.cn/G2S/ShowSystem/TeacherDetail.aspx?r=2&RefID=79526\"}]}',0,0,'教学名师'),(96,'华泽钊','2023-04-01 00:00:00','2026-04-25 00:00:00','{\"value\": \"\"}','{\"file\": [{\"url\": \"\", \"name\": \"\"}], \"image\": [{\"name\": \"\", \"resume\": \"\"}], \"title\": [{\"value\": \"\"}], \"message\": \"<h3></h3><p>计算机网络是计算机科学与技术专业的核心课程。该课程比较全面系统地介绍了计算机网络的发展和原理体系结构、物理层、数据链路层、网络层、运输层、应用层、网络安全、因特网上的音频/视频服务、无线网络和下一代因特网等内容。通过本课程的学习，使学生能够对计算机网络原理与技术有一个系统的、全面的了解；掌握计算机网络的概念、组成和体系结构，初步掌握数据通信、各层网络协议和网络互连等方面的基本问题和主要算法，使学生有较为全面、系统、扎实的知识基础，为学习其他课程以及从事计算机网络的研究、开发、管理和应用打下坚实的基础。</p><h3></h3><p>传热学是研究热量传递规律的科学，是热能与动力工程专业的主干技术基础课。它不仅为学生学习有关的专业课程提供基础理论知识，也为从事热能利用、热工设备设计的工程技术人员打下必要的基础。\\n教学体系、教学理念以及教学手段先进，适应现代人才培养的需要。教学内容新颖，联系科研、生产、生活实际，将最新的科研成果引进了教学中，注重学生能力的培养和思维能力的训练。教学手段完备，教学方法和教学艺术科学有效，网络化教学资料丰富，实现了资源共享。</p><h3></h3><p>数控技术，简称“数控”。英文：Numerical Control（NC）。是指用数字、文字和符号组成的数字指令来实现一台或多台机械设备动作控制的技术。它所控制的通常是位置、角度、速度等机械量和与机械能量流向有关的开关量。 我校数控技术教学始于1990中期，当时的华东工业大学机械工程系开设了机床数控技术课程，开始了数控技术的教学和研究工作，是上海市最早开设数控技术与数控加工课程的高等院校之一。</p><h3></h3><p>主要负责课程信息http://cc.usst.edu.cn/G2S/ShowSystem/TeacherDetail.aspx?r=2&RefID=79910</p><h3></h3><p>主要负责课程信息http://cc.usst.edu.cn/G2S/ShowSystem/TeacherDetail.aspx?r=2&RefID=79526</p><h3></h3><p>主要负责课程信息http://cc.usst.edu.cn/G2S/ShowSystem/TeacherDetail.aspx?r=2&RefID=79724</p>\", \"messages\": [{\"value\": \"主要负责课程信息http://cc.usst.edu.cn/G2S/ShowSystem/TeacherDetail.aspx?r=2&RefID=79724\"}]}',0,0,'教学名师');-- 消息预填写


INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('1', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('2', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('3', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('4', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('5', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('6', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('7', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('8', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('9', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('10', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('11', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('12', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('13', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('14', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('15', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('16', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('17', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('18', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('19', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('20', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('21', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('22', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('23', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('24', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('25', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('26', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('27', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('28', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('29', '1');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('30', '1');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('31', '1');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('32', '1');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('33', '1');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('34', '1');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('24', '2');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('25', '2');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('26', '2');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('27', '2');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('28', '2');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('19', '3');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('20', '3');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('21', '3');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('22', '3');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('23', '3');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('42', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('43', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('45', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('46', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('47', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('48', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('49', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('50', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('51', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('52', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('53', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('54', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('55', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('56', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('57', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('58', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('59', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('60', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('61', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('62', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('64', '4');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('65', '4');

INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('1', '1');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('2', '1');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('3', '1');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('4', '1');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('5', '1');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('6', '1');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('7', '2');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('8', '2');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('9', '2');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('10', '2');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('11', '2');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('12', '4');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('13', '4');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('14', '4');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('15', '3');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('16', '3');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('17', '3');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('18', '3');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('19', '12');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('20', '12');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('21', '12');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('22', '12');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('23', '12');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('28', '13');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('29', '14');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('30', '15');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('31', '16');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('32', '17');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('33', '18');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('34', '13');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('35', '5');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('36', '6');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('37', '7');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('38', '8');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('39', '9');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('40', '10');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('41', '11');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('34', '9');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('42', '21');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('43', '13');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('47', '21');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('48', '20');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('49', '16');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('50', '16');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('51', '16');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('52', '16');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('53', '16');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('56', '17');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('57', '17');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('58', '17');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('62', '14');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('65', '12');
INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('64', '12');


INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (1,1);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (2,1);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (3,1);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (1,5);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (2,8);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (3,8);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (1,12);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (22,12);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (23,12);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (2,13);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (3,13);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (4,13);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (7,13);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (10,13);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (23,13);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (6,14);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (8,14);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (11,14);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (24,14);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (5,15);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (1,16);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (4,16);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (1,18);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (4,18);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (19,19);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (20,19);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (21,19);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (23,19);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (19,20);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (22,20);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (24,20);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (19,21);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (22,21);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (23,21);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (24,21);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (1,22);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (5,22);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (6,22);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (7,22);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (8,22);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (10,22);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (17,22);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (19,22);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (20,22);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (1,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (2,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (3,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (4,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (5,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (6,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (7,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (8,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (9,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (10,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (17,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (18,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (19,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (20,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (22,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (24,23);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (9,24);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (14,24);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (15,24);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (16,24);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (17,24);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (18,24);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (20,24);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (23,24);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (2,25);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (14,25);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (15,25);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (16,25);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (21,25);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (2,27);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (5,27);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (6,27);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (7,27);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (8,27);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (10,27);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (11,27);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (4,28);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (1,29);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (2,29);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (3,30);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (5,31);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (6,31);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (7,31);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (8,31);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (10,31);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (11,31);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (1,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (2,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (3,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (4,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (9,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (12,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (13,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (14,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (15,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (16,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (17,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (18,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (19,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (20,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (21,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (22,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (24,32);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (5,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (6,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (7,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (8,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (10,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (11,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (12,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (13,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (14,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (15,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (16,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (17,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (18,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (23,33);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (12,34);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (13,34);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (14,34);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (15,34);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (16,34);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (17,34);
INSERT INTO cse.information_class_key (`Cid`,`Kid`) VALUES (18,34);

INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (1,1);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (4,1);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (6,1);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (8,1);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (20,1);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (5,2);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (9,2);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (11,2);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (2,3);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (12,4);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (13,4);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (14,4);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (15,4);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (16,4);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (17,4);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (18,4);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (19,4);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (20,4);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (21,4);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (23,5);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (23,6);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (23,7);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (3,8);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (7,8);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (19,8);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (24,8);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (10,9);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (21,9);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (24,9);
INSERT INTO cse.information_class_location (`Cid`,`Lid`) VALUES (22,10);


INSERT INTO cse.basic_model (Bid, id, type, score) VALUES (1, 16, 'keyword', 2);
INSERT INTO cse.basic_model (Bid, id, type, score) VALUES (2, 18, 'keyword', 2);
INSERT INTO cse.basic_model (Bid, id, type, score) VALUES (3, 22, 'keyword', 2);
INSERT INTO cse.basic_model (Bid, id, type, score) VALUES (4, 23, 'keyword', 2);
INSERT INTO cse.basic_model (Bid, id, type, score) VALUES (5, 24, 'keyword', 2);
INSERT INTO cse.basic_model (Bid, id, type, score) VALUES (6, 34, 'keyword', 2);

INSERT INTO cse.year_basic_model (Year, Bid) VALUES (1, '3');
INSERT INTO cse.year_basic_model (Year, Bid) VALUES (2, '4');
INSERT INTO cse.year_basic_model (Year, Bid) VALUES (3, '4');
INSERT INTO cse.year_basic_model (Year, Bid) VALUES (3, '6');
INSERT INTO cse.year_basic_model (Year, Bid) VALUES (4, '5');
INSERT INTO cse.year_basic_model (Year, Bid) VALUES (4, '6');

INSERT INTO cse.profession_basic_model (Pid, Bid) VALUES (1, 1);
INSERT INTO cse.profession_basic_model (Pid, Bid) VALUES (2, 2);

-- 添加实验用户关联信息
INSERT INTO `cse`.`favourite_location` (`Uid`, `like`,`Time`) VALUES ('1', '1','2023-04-08 22:19:21');
INSERT INTO `cse`.`favourite_location` (`Uid`, `like`,`Time`) VALUES ('1', '4','2023-04-08 22:19:10');
INSERT INTO `cse`.`favourite_location` (`Uid`, `like`,`Time`) VALUES ('1', '9','2023-04-08 22:19:13');

INSERT INTO `cse`.`favourite_information_class` (`Uid`, `like`, `Time`) VALUES ('1', '12', '2023-04-08 22:19:21');
INSERT INTO `cse`.`favourite_information_class` (`Uid`, `like`, `Time`) VALUES ('1', '1', '2023-04-08 22:19:24');
INSERT INTO `cse`.`favourite_information_class` (`Uid`, `like`, `Time`) VALUES ('1', '16', '2023-04-08 22:19:23');
INSERT INTO `cse`.`favourite_information_class` (`Uid`, `like`, `Time`) VALUES ('1', '17', '2023-04-08 22:19:22');

INSERT INTO `cse`.`favourite_message` (`Uid`, `like`, `Time`) VALUES ('1', '3', '2023-04-08 22:19:21');
INSERT INTO `cse`.`favourite_message` (`Uid`, `like`, `Time`) VALUES ('1', '5', '2023-04-08 22:19:22');
INSERT INTO `cse`.`favourite_message` (`Uid`, `like`, `Time`) VALUES ('1', '21', '2023-04-08 22:19:23');
INSERT INTO `cse`.`favourite_message` (`Uid`, `like`, `Time`) VALUES ('1', '22', '2023-04-08 22:19:24');
INSERT INTO `cse`.`favourite_message` (`Uid`, `like`, `Time`) VALUES ('1', '52', '2023-04-08 22:19:25');
INSERT INTO `cse`.`favourite_message` (`Uid`, `like`, `Time`) VALUES ('1', '53', '2023-04-08 22:19:26');
INSERT INTO `cse`.`favourite_message` (`Uid`, `like`, `Time`) VALUES ('1', '32', '2023-04-08 22:19:27');
INSERT INTO `cse`.`favourite_message` (`Uid`, `like`, `Time`) VALUES ('1', '56', '2023-04-08 22:19:28');


UPDATE `cse`.`user_hobby` SET `degree` = 'interested' WHERE (`Uid` = '1') and (`Hid` = '1');
UPDATE `cse`.`user_hobby` SET `degree` = 'interested' WHERE (`Uid` = '1') and (`Hid` = '10');
UPDATE `cse`.`user_hobby` SET `degree` = 'interested' WHERE (`Uid` = '1') and (`Hid` = '17');
UPDATE `cse`.`user_hobby` SET `degree` = 'uninterested' WHERE (`Uid` = '1') and (`Hid` = '19');
UPDATE `cse`.`user_hobby` SET `degree` = 'uninterested' WHERE (`Uid` = '1') and (`Hid` = '24');
UPDATE `cse`.`user_hobby` SET `degree` = 'uninterested' WHERE (`Uid` = '1') and (`Hid` = '27');
UPDATE `cse`.`user_hobby` SET `degree` = 'uninterested' WHERE (`Uid` = '1') and (`Hid` = '4');



CREATE TABLE `cse`.`information_class_echarts` (
    `Cid` Int not null comment '对应信息类的唯一id',
    `Lists` JSON not null comment 'echarts图标数据的json格式化',
    `StartYear` int null comment '比赛类的开始年份',
    PRIMARY Key(`Cid`),
    CONSTRAINT `EchartsToInformationClass`
        FOREIGN Key(`Cid`)
            REFERENCES `cse`.`information_class` (`Cid`)
            ON DELETE No ACTION
            ON UPDATE No ACTION) comment = '信息类的echarts可视化存储表';