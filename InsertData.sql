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

INSERT INTO `cse`.`hobby` (`Hid`, `Name`, `Type`, `DeprecatedFlag`) VALUES ('9', '前端设计', '专业爱好', '0');
INSERT INTO `cse`.`hobby` (`Hid`, `Name`, `Type`, `DeprecatedFlag`) VALUES ('10', '后端开发', '专业爱好', '0');
INSERT INTO `cse`.`hobby` (`Hid`, `Name`, `Type`, `DeprecatedFlag`) VALUES ('11', '数据挖掘', '专业爱好', '0');
INSERT INTO `cse`.`hobby` (`Hid`, `Name`, `Type`, `DeprecatedFlag`) VALUES ('12', '数据分析', '专业爱好', '0');
INSERT INTO `cse`.`hobby` (`Hid`, `Name`, `Type`) VALUES ('13', 'Python语言', '专业爱好');
INSERT INTO `cse`.`hobby` (`Hid`, `Name`, `Type`, `DeprecatedFlag`) VALUES ('14', 'C语言', '专业爱好', '0');
INSERT INTO `cse`.`hobby` (`Hid`, `Name`, `Type`, `DeprecatedFlag`) VALUES ('15', 'C++语言', '专业爱好', '0');
INSERT INTO `cse`.`hobby` (`Hid`, `Name`, `Type`, `DeprecatedFlag`) VALUES ('16', 'Java语言', '专业爱好', '0');
INSERT INTO `cse`.`hobby` (`Hid`, `Name`, `Type`, `DeprecatedFlag`) VALUES ('17', '实习就业', '个人发展', '0');
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
INSERT INTO `cse`.`keyword_type` (`Tid`, `TypeName`, `TypeResume`) VALUES ('4', '资源共享', '最早获得各类资源的一手消息，及时抓住机会，提升自我');
-- 关键词类型预填写

INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('国赛', '1');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('省赛', '1');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('市赛', '1');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('校赛', '1');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('前端', '2');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('Android', '2');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('后端', '2');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('嵌入式', '2');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('主题教育活动', '3');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('公益活动', '3');
INSERT INTO `cse`.`keyword` (`KeyName`, `KeywordType`) VALUES ('党课教育', '3');
INSERT INTO `cse`.`keyword` (`Kid`, `KeyName`, `KeywordType`) VALUES ('12', '禁止开放', '4');
INSERT INTO `cse`.`keyword` (`Kid`, `KeyName`, `KeywordType`) VALUES ('13', '空间占用', '4');
INSERT INTO `cse`.`keyword` (`Kid`, `KeyName`, `KeywordType`) VALUES ('14', '维修', '4');
INSERT INTO `cse`.`keyword` (`Kid`, `KeyName`, `KeywordType`) VALUES ('15', '承办', '4');
-- 关键词填写


INSERT INTO `cse`.`message` (`Title`, `message`,`ReleaseTime`,OutTime) VALUES ('蓝桥杯预选赛通知', '{"message":"蓝桥杯比赛消息通知","image":[],"file":[]}','2022-10-07 08:05:54','2023-05-07 23:59:59');
INSERT INTO `cse`.`message` (`Title`, `message`,`ReleaseTime`,OutTime) VALUES ('其他信息', '{"message":"其他信息","image":[],"file":[]}','2022-09-05 08:05:54','2023-05-07 23:59:59');
INSERT INTO `cse`.`message` (`Title`, `message`,`ReleaseTime`,OutTime) VALUES ('蓝桥杯简介', '{"message":"蓝桥杯比赛简介","image":[],"file":[]}','2019-03-18 08:05:54','2032-10-07 08:05:54');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('4', '蓝桥杯预选赛成功举办', '2022-11-14 08:45:54', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"蓝桥杯预选赛成功举办\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('5', '总决赛荣获嘉奖', '2022-07-04 09:33:35', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"总决赛荣获嘉奖\"}', '0');
-- 消息预填写

INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('6', '蓝桥杯市赛获奖', '2022-05-29 10:43:44', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"蓝桥杯市赛获奖\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('7', '互联网+简介', '2016-02-23 10:43:44', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"互联网+简介\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('8', '总决赛取得最好成绩', '2022-12-06 11:23:24', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"总决赛取得最好成绩\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('9', '互联网+校内选拔赛获奖名单公示', '2022-08-20 08:43:24', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"互联网+校内选拔赛获奖名单公示\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('10', '互联网+校赛启动动员会', '2022-03-23 09:45:14', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"互联网+校赛启动动员会\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('11', '第八届互联网+预参赛手册', '2021-11-20 11:35:43', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"第八届互联网+预参赛手册\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('12', '计算机设计大赛简介', '2019-12-07 09:45:44', '2032-10-07 08:05:54', '{\"file\": [], \"image\": [], \"message\": \"计算机设计大赛简介\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('13', '第十六届中国大学生计算机设计大赛预通知', '2022-11-08 08:35:04', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"第十六届中国大学生计算机设计大赛预通知\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('14', '第十五届计算机设计大赛获佳绩', '2022-09-21 11:05:14', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"第十五届计算机设计大赛获佳绩\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('15', '数学建模比赛简介', '2015-10-07 08:05:54', '2032-10-07 08:05:54', '{\"file\": [], \"image\": [], \"message\": \"数学建模比赛简介\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('16', '数学建模竞赛证书领取', '2022-09-22 15:35:24', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"数学建模竞赛证书领取\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('17', '数学建模校内选拔赛', '2022-04-26 13:25:04', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"数学建模校内选拔赛\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('18', '荣获美赛一等奖', '2021-04-27 18:45:32', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"荣获美赛一等奖\"}', '0');


INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('19', '第一教学楼校内比价', '2022-09-01 14:15:44', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/0901/c54a50048/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('20', '第一教学楼临时封闭通知', '2022-03-25 13:25:04', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/0325/c479a45747/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('21', '第一教学楼停电通知', '2020-12-31 11:05:34', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2020/1231/c479a40435/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('22', '第一教学楼自习室延长开放通知', '2020-08-17 15:05:54', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2020/0817/c479a38691/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('23', '第一教学楼维修中标公告', '2019-05-31 13:55:42', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2019/0531/c54a33225/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('24', '图书馆官方介绍', '2022-07-26 13:15:04', '2032-10-07 08:05:54', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/0726/c999a46750/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('25', '图书馆寒假服务安排表', '2023-01-06 11:53:03', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2023/0106/c912a51947/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('26', '图书馆X2！回来了！', '2022-12-24 09:31:24', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://mp.weixin.qq.com/s/_4TkyPesSO0y7mRQ_RGwaQ\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('27', '图书馆获得“最美图书馆”称号', '2022-09-14 08:18:49', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/0914/c934a50216/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('28', '校园战疫工作中的图书馆力量', '2022-05-19 11:34:16', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/0519/c163a46117/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('29', '校园主机房停电通知', '2021-08-16 10:25:04', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2021/0816/c479a43138/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('30', '智慧校园机房停电通知', '2020-10-23 10:23:45', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2020/1023/c479a39339/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('31', '校园网主机房停电通知', '2021-03-04 09:52:34', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2021/0304/c479a40918/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('32', '校园网主机房通知', '2020-08-14 13:25:04', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2020/0814/c479a38686/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('33', '蓝桥杯机房占用', '2023-03-26 11:25:33', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"蓝桥杯机房占用\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('34', '天梯赛机房占用', '2023-03-16 16:45:04', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"天梯赛机房占用\"}', '0');



INSERT INTO `cse`.`location` (`Lid`, `Name`, `Resume`) VALUES ('1', '计算机中心', '计算机中心位于上海理工大学北校区湛恩图书馆左侧，常常承办一些计算机类的比赛，同');
INSERT INTO `cse`.`location` (`Lid`, `Name`, `Resume`) VALUES ('2', '图书馆', '：学校580校区，共有两个大型图书馆，分别是位于北校区的湛恩图书馆，和334校区图书');
INSERT INTO `cse`.`location` (`Lid`, `Name`, `Resume`) VALUES ('3', '第一教学楼', '第一教学楼，简称“一教”，位于上海理工大学580校区，靠近516号校门，设施齐全，同学们');



INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`) VALUES ('35', '走进海沈村活动', '2022-11-24 11:42:21', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1124/c934a51502/page.htm\"}');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`) VALUES ('36', '“秋炫沪江，我是光荣劳动者”活动', '2022-11-24 09:11:32', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1124/c1017a51487/page.htm\"}');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`) VALUES ('37', '打响医匠品牌活动', '2022-12-16 13:22:51', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1219/c1612a51818/page.htm\"}');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`) VALUES ('38', '理学院“实验大变身”活动', '2022-12-14 12:12:21', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1214/c934a51767/page.htm\"}');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`) VALUES ('39', '会聘上海', '2022-11-30 16:12:41', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1130/c934a51579/page.htm\"}');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`) VALUES ('40', '光电学院挑战杯专题讲座', '2023-03-15 20:00:00', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"光电学院挑战杯专题讲座\"}');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`) VALUES ('41', '尚旅军团全员大会', '2023-03-15 00:00:00', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"尚旅军团全员大会\"}');





INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('1', '蓝桥杯', '比赛');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('2', '互联网+', '比赛');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('3', '数学建模', '比赛');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('4', '计算机设计大赛', '比赛');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('5', '走进海沈村活动', '活动');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('6', '“秋炫沪江，我是光荣劳动者”活动', '活动');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('7', '打响医匠品牌活动', '活动');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('8', '理学院“实验大变身”活动', '活动');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('9', '会聘上海', '资源');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('10', '光电学院挑战杯专题讲座', '活动');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('11', '尚旅军团全员大会', '活动');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Resume`, `Type`) VALUES ('12', '教务处', '发布学校的教学通知', '部门');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('13', '后勤管理处', '部门');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('14', '校长办公室', '部门');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('15', '财务处', '部门');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('16', '科学发展研究院', '部门');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('17', '学生工作部', '部门');
INSERT INTO `cse`.`information_class` (`Cid`, `Name`, `Type`) VALUES ('18', '创新创业学院', '部门');



INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('42', '2022年研究生考试教学楼暂停开放通知', '2022-12-21 14:42:11', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://yjs.usst.edu.cn/2022/1221/c7111a285015/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('43', '宿舍洗衣机项目成交公告', '2022-12-30 13:52:09', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2023/0103/c1017a51908/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('44', '暂停教职工班车服务通知', '2022-12-23 11:12:23', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://ids6.usst.edu.cn/authserver/login?service=http%3A%2F%2Fwww.usst.edu.cn%2F2022%2F1223%2Fc1017a51870%2Fpage.psp\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('45', '部分餐厅托管服务公开招标', '2022-12-05 13:32:21', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1206/c1017a51662/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('46', '宿舍装修改造项目招标公告', '2022-11-25 09:22:44', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1125/c1017a51524/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('47', '一教自习教室延长开放通知', '2020-08-17 08:12:31', '2021-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2020/0817/c479a38691/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('48', '图书馆暑假安排表', '2023-01-06 17:12:56', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2023/0106/c912a51947/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('49', ' 关于国家自然科学基金优秀青年科学基金项目（海外）项目的通知', '2023-01-04 12:12:31', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2023/0105/c1017a51931/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('50', '关于上海市2023年度“科技创新行动计划”“一带一路”国际合作项目申报的通知', '2022-12-19 13:22:51', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1219/c1017a51820/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('51', '关于发布上海市2023年度“科技创新行动计划”软科学研究项目申报指南的通知', '2022-12-14 15:32:23', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1214/c1017a51765/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('52', ' 关于发布上海市2023年度“科技创新行动计划”技术标准项目申报指南的通知', '2022-12-11 16:22:51', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1211/c1017a51743/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('53', ' 关于发布上海市2023年度“科技创新行动计划”自然科学基金项目申报指南的通知', '2022-11-25 08:25:57', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1211/c1017a51740/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('54', ' 上海理工大学学生宿舍装修改造项目设计单位招标公告', '2022-11-25 15:52:31', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1125/c1017a51524/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('55', ' 关于2023年寒假各项服务工作安排汇总', '2023-01-05 16:42:27', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2023/0105/c1017a51930/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('56', ' 关于2022年大学生征兵工作先进个人、先进集体评选结果的公示', '2022-12-16 09:56:48', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1216/c1017a51806/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('57', ' 2021-2022学年资助育人先进个人和集体名单公示', '2022-12-15 13:52:18', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1215/c1017a51777/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('58', ' 2022年上海理工大学优秀劳动教育实践项目名单公示', '2022-12-16 13:22:51', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1209/c1017a51723/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('59', ' 关于2022年度上海市重点工程实事立功竞赛 优秀团队的公示', '2022-12-08 09:29:19', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1208/c1017a51696/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('60', ' 关于2023年全国巾帼文明岗和全国巾帼建功标兵拟推荐集体（个人）的公示', '2022-11-30 14:16:39', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2022/1130/c1017a51571/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('61', ' 关于组织教师参加2023年寒假教师研修的通知', '2023-01-06 17:28:37', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://www.usst.edu.cn/2023/0106/c954a51948/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('62', '关于2023年寒假安排的通知', '2023-01-04 14:27:21', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://ids6.usst.edu.cn/authserver/login?service=http%3A%2F%2Fwww.usst.edu.cn%2F2023%2F0104%2Fc954a51912%2Fpage.psp\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('64', ' 2022年12月全国大学英语四、六级考试笔试考前须知及防疫安全提示', '2022-11-25 14:02:09', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"http://jwc.usst.edu.cn/2022/1125/c10239a283627/page.htm\"}', '0');
INSERT INTO `cse`.`message` (`Mid`, `Title`, `ReleaseTime`, `OutTime`, `message`, `AsBasicMessage`) VALUES ('65', ' 关于2022年下半年全国大学英语四、六级等级考试报名的通知', '2022-10-24 09:08:07', '2023-12-31 23:59:59', '{\"file\": [], \"image\": [], \"message\": \"https://jwc.usst.edu.cn/2022/1020/c10239a281385/page.psp\"}', '0');
