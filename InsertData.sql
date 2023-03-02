INSERT INTO `cse`.`profession` (`ProfessionName`, `ProfessionDescription`, `DeprecatedFlag`) VALUES ('计算机科学与技术', '暂无', '0');
INSERT INTO `cse`.`profession` (`ProfessionName`, `ProfessionDescription`, `DeprecatedFlag`) VALUES ('数据科学与大数据技术', '暂无', '0');
-- 专业的当前数据

INSERT INTO `cse`.`hobby` (`Description`, `Name`, `Type`) VALUES ('', '考研', '个人发展');
INSERT INTO `cse`.`hobby` (`Description`, `Name`, `Type`) VALUES ('', '保研', '个人发展');
INSERT INTO `cse`.`hobby` (`Description`, `Name`, `Type`) VALUES ('', '竞赛', '个人发展');
INSERT INTO `cse`.`hobby` (`Description`, `Name`, `Type`) VALUES ('', '出国留学', '个人发展');
INSERT INTO `cse`.`hobby` (`Description`, `Name`, `Type`) VALUES ('', '课外实践', '个人提升');
INSERT INTO `cse`.`hobby` (`Description`, `Name`, `Type`) VALUES ('', '语言', '个人提升');
INSERT INTO `cse`.`hobby` (`Description`, `Name`, `Type`) VALUES ('', '证书考取', '个人提升');
INSERT INTO `cse`.`hobby` (`Description`, `Name`, `Type`) VALUES ('', '阅读', '个人提升');
-- 当前兴趣爱好数据

INSERT INTO `cse`.`user` (`UserCode`, `UserPass`, `UserName`, `Grade`, `Profession`, `Sex`) VALUES ('123456', '123456', 'testUser', '2020', '1', '男');
-- 默认用户

INSERT INTO `cse`.`message` (`Title`, `message`) VALUES ('蓝桥杯预选赛通知', '{"message":"蓝桥杯比赛消息通知","image":[],"file":[]}');
INSERT INTO `cse`.`message` (`Title`, `message`) VALUES ('其他信息', '{"message":"其他信息","image":[],"file":[]}');
INSERT INTO `cse`.`message` (`Title`, `message`) VALUES ('蓝桥杯简介', '{"message":"蓝桥杯比赛简介","image":[],"file":[]}');
-- 消息预填写

INSERT INTO `cse`.`keyword_type` (`TypeName`, `TypeResume`) VALUES ('比赛等级', '一个比赛的等级划分，通常有国、市、校');
INSERT INTO `cse`.`keyword_type` (`TypeName`, `TypeResume`) VALUES ('比赛需求', '该比赛需要的技术');
INSERT INTO `cse`.`keyword_type` (`TypeName`, `TypeResume`) VALUES ('活动综测分', '参与该活动能够提供综测分');
-- 关键词类型预填写

INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('国赛', '1');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('省赛', '1');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('市赛', '1');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('校赛', '1');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('前端', '2');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('Android', '2');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('后端', '2');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('嵌入式', '2');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('1', '3');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('2', '3');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('3', '3');
-- 关键词填写

Insert into `cse`.`information_class` (`Name`,`BasicMessage`,`Type`) values ('蓝桥杯','3','比赛');
-- 具体类预填信息

INSERT INTO `cse`.`information_class_key` (`Cid`, `Kid`) VALUES ('1', '1');
-- 增加关键字关联

INSERT INTO `cse`.`message_information_class` (`Mid`, `Cid`) VALUES ('1', '1');
-- 增加信息与类关联

Insert Into cse.favourite_message (Uid, `like`) VALUES (1,1);
insert into cse.favourite_information_class (Uid, `like`) VALUES (1,1);

UPDATE `cse`.`hobby` SET `HobbyModel` = '[{\"id\": 1, \"type\": \"keyword\",\"score\":1},{\"id\": 2, \"type\": \"keyword\",\"score\":2}]' WHERE (`Hid` = '2');
-- 添加示例模型

INSERT INTO `cse`.`map` (`Name`, `Resume`) VALUES ('校园', '校园');
INSERT INTO `cse`.`location` (`Name`, `Resume`, `MapBelong`, `BasicMessage`) VALUES ('实验地点1', '实验', '1', '1');

INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('1', '1');
INSERT INTO `cse`.`message_location` (`Mid`, `Lid`) VALUES ('2', '1');

UPDATE `cse`.`information_class` SET `Location` = '1' WHERE (`Cid` = '1');