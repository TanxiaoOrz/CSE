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
  `resume` varchar(100) null  comment '消息简介',
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
  `BasicMessage` INT default 0 comment '简介消息id',
  `ImgHref` VARCHAR(200) NULL comment '介绍图片',
  `X` INT NULL comment '地图位置横轴',
  `Y` INT NULL comment '地图位置纵轴',
  `DeprecatedFlag` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`Lid`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE) comment = '地点类';

CREATE TABLE `cse`.`information_class` (
                                           `Cid` INT NOT NULL AUTO_INCREMENT comment '唯一id',
                                           `Name` VARCHAR(45) NOT NULL comment '信息类名',
                                           `Resume` VARCHAR(100) NULL comment '简介',
                                           `BasicMessage` INT default  0 comment '简介消息id',
                                           `Type` ENUM('比赛', '部门', '活动', '资源') NOT NULL comment '信息类类型',
                                           `ImgHref` VARCHAR(200) NULL comment '介绍图片',
                                           `DeprecatedFlag` VARCHAR(45) NULL,
                                           PRIMARY KEY (`Cid`),
                                           UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE) comment '信息类';

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

CREATE TABLE `cse`.`information_class_echarts` (
    `Cid` Int not null comment `对应信息类的唯一id`,
    `Lists` JSON not null comment `echarts图标数据的json格式化`,
    `StartYear` int null comment `比赛类的开始年份`,
    PRIMARY Key(`Cid`),
    CONSTRAINT `EchartsToInformationClass`
        FOREIGN Key(`Cid`)
            REFERENCES `cse`.`information_class` (`Cid`)
            ON DELETE No ACTION
            ON UPDATE No ACTION) comment = '信息类的echarts可视化存储表';
)


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

