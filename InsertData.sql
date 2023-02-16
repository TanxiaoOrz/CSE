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