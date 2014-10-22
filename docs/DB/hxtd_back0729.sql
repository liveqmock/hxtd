/*
Navicat MySQL Data Transfer

Source Server         : 192.168.111.141
Source Server Version : 50517
Source Host           : 192.168.111.141:3306
Source Database       : hxtd_back0729

Target Server Type    : MYSQL
Target Server Version : 50517
File Encoding         : 65001

Date: 2014-10-22 11:08:23
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `attachment`
-- ----------------------------
DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `MODULE_ID` int(4) NOT NULL DEFAULT '0' COMMENT '关联模块ID',
  `RECORD_ID` int(4) NOT NULL DEFAULT '0' COMMENT '关联模块内记录的ID',
  `TYPE_DICT` int(4) NOT NULL DEFAULT '0' COMMENT '附件类型',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '附件原名',
  `ADDRESS` varchar(512) NOT NULL DEFAULT '' COMMENT '存储地址',
  `IS_DELETED` smallint(6) NOT NULL DEFAULT '0',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改人ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE,
  KEY `INDEX_DICTIONARY_ID` (`RECORD_ID`) USING BTREE,
  KEY `INDEX_TYPE` (`TYPE_DICT`) USING BTREE,
  KEY `INDEX_CREATE_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE,
  KEY `INDEX_MODULE` (`MODULE_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of attachment
-- ----------------------------
INSERT INTO attachment VALUES ('1', '322', '4', '304', 'dt.jpg', '/home/resin/webapps/hxtd/res/20140829173456353.jpg', '0', '1', '2014-08-29 17:34:56', '1', '2014-08-29 17:34:56');
INSERT INTO attachment VALUES ('2', '324', '11', '304', '已完成项目.xls', 'E:\\project\\company\\hxtd\\target\\hxtd\\res\\20140924145201500.xls', '1', '1', '2014-09-24 14:52:01', '1', '2014-09-24 14:52:10');

-- ----------------------------
-- Table structure for `contact`
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户ID',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '联系人姓名',
  `OWNER` int(11) DEFAULT NULL COMMENT '联系人所有者',
  `ACCOUNT_ID` int(11) DEFAULT NULL COMMENT '联系人类型',
  `SUPPLIER_ID` int(11) DEFAULT NULL COMMENT '供应商ID/客户ID',
  `SOURCE_DIC` int(11) DEFAULT NULL COMMENT '线索来源',
  `DEPARTMENT` varchar(32) DEFAULT '' COMMENT '部门',
  `POSITION` varchar(32) DEFAULT '' COMMENT '职位',
  `PHONE` varchar(32) DEFAULT '' COMMENT '电话',
  `MOBILE` varchar(23) DEFAULT '' COMMENT '手机',
  `EMAIL` varchar(32) DEFAULT '' COMMENT '邮箱',
  `FAX` varchar(32) DEFAULT '' COMMENT '传真',
  `POST_CODE` varchar(32) DEFAULT '' COMMENT '邮编',
  `PROVINCE` int(11) DEFAULT NULL COMMENT '所在地（省）',
  `CITY` int(11) DEFAULT NULL COMMENT '所在地（市）',
  `COUNTY` int(11) DEFAULT NULL COMMENT '所在地（县）',
  `ADDRESS` varchar(512) DEFAULT '' COMMENT '详细地址',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '删除标记',
  `REMARK` text COMMENT '备注',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_TYPE` (`ACCOUNT_ID`) USING BTREE,
  KEY `INDEX_OWNER` (`OWNER`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_MOBILE` (`MOBILE`) USING BTREE,
  KEY `INDEX_PHONE` (`PHONE`) USING BTREE,
  KEY `INDEX_SUPPLIER_ID` (`SUPPLIER_ID`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='联系人';

-- ----------------------------
-- Records of contact
-- ----------------------------
INSERT INTO contact VALUES ('1', '联系人001', '1', '1', null, null, '', '', '18613891430', '', '', '', '', null, null, null, '', '0', null, '1', '2014-08-18 15:51:38', '1', '2014-08-19 15:44:21');
INSERT INTO contact VALUES ('2', '线索001', '6', '2', null, null, '', '', '', '', '', '', '', null, null, null, '', '0', '', '1', '2014-08-18 15:52:44', '1', '2014-08-19 15:44:21');
INSERT INTO contact VALUES ('3', 'xiaoaa（测试）', '11', null, '3', '92', null, null, '15911140672', '15911140677', null, null, null, '110000', '110100', '110109', '北京门头沟', '0', null, '1', '2014-08-19 10:29:51', '1', '2014-08-19 15:44:21');
INSERT INTO contact VALUES ('4', 'xiaoaa', '7', null, '3', '92', null, null, '15911140672', null, null, null, null, null, null, null, null, '0', null, '1', '2014-08-19 14:14:25', '1', '2014-08-19 15:44:21');
INSERT INTO contact VALUES ('5', 'xiaoaa', '14', '5', null, null, '', '', '0817-5603365', '', '', '', '', null, null, null, '', '0', null, '14', '2014-08-19 16:29:51', '14', '2014-08-19 16:30:23');

-- ----------------------------
-- Table structure for `contract`
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '合同ID',
  `NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '合同名称',
  `CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '合同编号',
  `TYPE_DIC` int(11) DEFAULT '0' COMMENT '合同类型',
  `CONTENT` text NOT NULL COMMENT '合同内容',
  `PURCHASE_MONEY` decimal(10,2) NOT NULL COMMENT '合同金额',
  `ORDER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `ACCOUNT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `REDEEM_TYPE_DIC` int(11) NOT NULL DEFAULT '0' COMMENT '赎回方式',
  `SIGN_TIME` datetime NOT NULL COMMENT '签订时间',
  `EFFECT_TIME` datetime NOT NULL COMMENT '生效时间',
  `BEREFT_TIME` datetime NOT NULL COMMENT '失效时间',
  `REMARK` varchar(512) DEFAULT '' COMMENT '备注',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '标记删除',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`),
  KEY `INDEX_ORDER_ID` (`ORDER_ID`) USING BTREE,
  KEY `INDEX_ACCOUNT_ID` (`ACCOUNT_ID`) USING BTREE,
  KEY `INDEX_TYPE` (`TYPE_DIC`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='合同表';

-- ----------------------------
-- Records of contract
-- ----------------------------
INSERT INTO contract VALUES ('1', '合同001', '024568', null, 'hg', '232.00', '1', '1', '30', '2014-08-31 00:00:00', '2014-08-18 00:00:00', '2014-08-31 00:00:00', 'dfg', '0', '1', '2014-08-18 15:35:43', '1', '2014-08-18 15:35:43');

-- ----------------------------
-- Table structure for `customer`
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户ID',
  `OWNER` int(11) NOT NULL DEFAULT '0' COMMENT '客户所有者',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '客户姓名',
  `TYPE_DIC` int(11) DEFAULT NULL COMMENT '客户类型',
  `SOURCE_DIC` int(11) NOT NULL DEFAULT '0' COMMENT '客户来源',
  `RISK_GRADE_DIC` int(11) DEFAULT NULL COMMENT '风险等级',
  `CARD_TYPE_DIC` int(11) DEFAULT NULL COMMENT '证件类型',
  `CARD_NUM` varchar(64) DEFAULT '' COMMENT '证件号码',
  `PHONE` varchar(32) NOT NULL DEFAULT '' COMMENT '电话',
  `MOBILE` varchar(32) NOT NULL DEFAULT '' COMMENT '手机',
  `DEPT` varchar(255) DEFAULT NULL COMMENT '所在部门',
  `JOB` varchar(255) DEFAULT NULL COMMENT '职务名称',
  `EMAIL` varchar(255) NOT NULL DEFAULT '' COMMENT '邮箱',
  `FAX` varchar(16) DEFAULT '' COMMENT '传真',
  `POST_CODE` varchar(16) DEFAULT '' COMMENT '邮编',
  `COMPANY` varchar(64) NOT NULL DEFAULT '' COMMENT '公司',
  `INDUSTRY_DIC` int(64) NOT NULL DEFAULT '0' COMMENT '行业',
  `OWNERSHIP_DIC` int(64) DEFAULT NULL COMMENT '所有权',
  `OPEN_BANK_DIC` int(11) DEFAULT NULL COMMENT '开户行',
  `BANK_NAME` varchar(64) DEFAULT '' COMMENT '银行户名',
  `BANK_ACCOUNT` varchar(64) DEFAULT '' COMMENT '账号',
  `PROVINCE` int(64) DEFAULT '0' COMMENT '所在地（省）',
  `CITY` int(64) DEFAULT '0' COMMENT '所在地（市）',
  `COUNTY` int(64) DEFAULT '0' COMMENT '所在地（县）',
  `FAMILY_ADDR` varchar(255) DEFAULT NULL COMMENT '家庭地址',
  `ADDRESS` varchar(255) DEFAULT '' COMMENT '详细地址',
  `CONTRIBUTION_TYPE` varchar(255) DEFAULT NULL COMMENT '出资方式',
  `CONTRIBUTION_SCALE` varchar(255) DEFAULT NULL COMMENT '出资规模',
  `APPOINTMENT` int(255) DEFAULT '0' COMMENT '邀约人',
  `FINANCIAL_ADVISOR` int(255) DEFAULT '0' COMMENT '理财顾问',
  `FINANCIAL_MANAGER` int(255) DEFAULT '0' COMMENT '理财经理',
  `FINANCIAL_DIRECTOR` int(255) DEFAULT '0' COMMENT '理财总监',
  `REMARK` varchar(512) DEFAULT '' COMMENT '备注',
  `IS_DELETED` tinyint(6) NOT NULL DEFAULT '0' COMMENT '是否被删除',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ACCOUNT_OWNER` (`OWNER`) USING BTREE,
  KEY `INDEX_PHONE` (`PHONE`) USING BTREE,
  KEY `INDEX_MOBILE` (`MOBILE`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE,
  KEY `INDEX_TYPE` (`TYPE_DIC`) USING BTREE,
  KEY `INDEX_PROVINCE` (`PROVINCE`) USING BTREE,
  KEY `INDEX_CITY` (`CITY`) USING BTREE,
  KEY `INDEX_COUNTY` (`COUNTY`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='客户表';

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO customer VALUES ('1', '2', '客户01', '114', '126', null, '233', '123222221212121212', '18613891430', '18613891430', '', '', '', '', '', '爱仕达', '146', null, '206', '银行户01', '1111122222222', '210000', null, null, '', '', '', '', null, '3', '6', '5', '', '0', '1', '2014-08-18 15:29:59', '1', '2014-08-19 15:44:20');
INSERT INTO customer VALUES ('2', '6', '线索001', null, '129', null, '234', '186138914301213', '18620623071', '18613891430', '', '', '', '', '', '爱仕达', '144', null, '204', '123', '77789533553', null, null, null, '', '', '', '', null, '3', '6', '5', '', '0', '1', '2014-08-18 15:52:44', '1', '2014-08-19 15:44:20');
INSERT INTO customer VALUES ('3', '11', 'xiaoaa（测试）', null, '129', null, '222', '', '15911140672', '15911140677', null, null, '', '', '', '', '146', null, null, null, null, '110000', '110100', '110109', null, '北京门头沟', null, null, null, null, null, null, '', '0', '1', '2014-08-19 10:29:51', '1', '2014-08-19 15:44:20');
INSERT INTO customer VALUES ('4', '11', '客户1——测试', '113', '123', null, '232', '511321198608158686', '15911140672', '15911140677', '', '', '', '', '', '456', '147', '182', '203', '留啦——测试', '6222202000003444', null, null, null, '', '', '', '', null, '3', '13', '5', '', '0', '1', '2014-08-19 14:02:08', '1', '2014-08-19 15:44:20');
INSERT INTO customer VALUES ('5', '14', 'xiaoaa', '113', '122', null, '232', '511321198607158688', '15911140672', '15911140677', '', '', '', '', '', '想、', '142', null, '202', '筽名', '622202020006564', null, null, null, '', '', '', '', '15', '16', '13', '17', '', '0', '14', '2014-08-19 16:29:41', '14', '2014-08-19 16:29:41');
INSERT INTO customer VALUES ('6', '20', '阿黄', '113', '124', null, '234', '908765', '15911140672', '15911140672', '', '', '', '', '', '莫莫莫', '149', null, '203', '琉璃', '6222020005678', null, null, null, '', '', '', '', null, '16', '15', '5', '', '0', '20', '2014-08-19 16:53:15', '20', '2014-08-19 16:53:15');
INSERT INTO customer VALUES ('7', '21', '1234', null, '122', null, '233', '123456', '1591140674', '15911140670', '', '', '', '', '', '某某', '146', null, '203', '篮子', '62222020005678', null, null, null, '', '', '', '', '21', '16', '15', '17', '', '0', '21', '2014-08-19 17:34:35', '21', '2014-08-19 17:34:35');
INSERT INTO customer VALUES ('8', '15', '张三', '113', '123', null, '234', '12345', '15911140672', '15911140673', '', '', '', '', '', '某某公司', '143', null, '203', '李丽', '51132119860715', null, null, null, '', '', '', '', null, '16', '15', '17', '', '0', '15', '2014-08-21 09:45:34', '15', '2014-08-21 09:45:34');
INSERT INTO customer VALUES ('9', '15', '张三', '113', '123', null, '234', '12345', '15911140672', '15911140673', '', '', '', '', '', '某某公司', '143', null, '203', '李丽', '51132119860715', null, null, null, '', '', '', '', null, '16', '15', '17', '', '0', '15', '2014-08-21 09:45:39', '15', '2014-08-21 09:45:39');
INSERT INTO customer VALUES ('10', '1', '大时代', null, '123', null, '234', '123455784575235257', '03166123701', '13832648456', '', '', '', '', '', '发的发', '144', null, '205', '任溶溶', '123313223213213', null, null, null, '', '', '', '', null, '16', '13', '5', '', '0', '1', '2014-08-26 19:30:26', '1', '2014-08-26 19:30:26');

-- ----------------------------
-- Table structure for `import_log`
-- ----------------------------
DROP TABLE IF EXISTS `import_log`;
CREATE TABLE `import_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '导入日志表ID',
  `START_TIME` datetime NOT NULL COMMENT '导入数据开始时间',
  `END_TIME` datetime NOT NULL COMMENT '导入数据结束时间',
  `STATUS` int(2) NOT NULL DEFAULT '0' COMMENT '导入状态：0 正在导入 1 导入结束 默认为0',
  `DESCRIPTION` varchar(512) DEFAULT NULL COMMENT '描述',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_IMPORT_LOG_ID` (`ID`) USING BTREE,
  KEY `INDEX_STATUS` (`STATUS`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='导入日志';

-- ----------------------------
-- Records of import_log
-- ----------------------------

-- ----------------------------
-- Table structure for `lead`
-- ----------------------------
DROP TABLE IF EXISTS `lead`;
CREATE TABLE `lead` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '线索ID ',
  `OWNER` int(11) NOT NULL DEFAULT '0' COMMENT '线索所有者',
  `COMPANY` varchar(64) NOT NULL DEFAULT '' COMMENT '公司名称',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '线索名称',
  `DEPARTMENT` varchar(64) NOT NULL DEFAULT '' COMMENT '部门',
  `POSITION` varchar(64) NOT NULL DEFAULT '' COMMENT '职位',
  `EMAIL` varchar(64) NOT NULL DEFAULT '' COMMENT '邮箱',
  `PHONE` varchar(32) NOT NULL DEFAULT '' COMMENT '电话',
  `FAX` varchar(32) NOT NULL DEFAULT '' COMMENT '传真',
  `MOBILE` varchar(32) NOT NULL DEFAULT '' COMMENT '手机',
  `SOURCE` int(11) NOT NULL DEFAULT '0' COMMENT '线索来源',
  `STATUS` int(11) NOT NULL DEFAULT '0' COMMENT '线索状态',
  `MARKET_ACTIVITY_ID` int(4) DEFAULT NULL COMMENT '关联市场活动',
  `CARD_TYPE` int(11) NOT NULL DEFAULT '0' COMMENT '证件类型',
  `CARD_NUM` varchar(64) NOT NULL DEFAULT '' COMMENT '证件号码',
  `INDUSTRY` int(11) NOT NULL DEFAULT '0' COMMENT '行业',
  `POST_CODE` varchar(16) NOT NULL DEFAULT '' COMMENT '邮编',
  `PROVINCE` int(11) DEFAULT '0' COMMENT '省份',
  `CITY` int(11) DEFAULT '0' COMMENT '城市',
  `COUNTY` int(11) DEFAULT '0' COMMENT '区/县',
  `ADDRESS` varchar(256) NOT NULL DEFAULT '' COMMENT '详细地址',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `IS_DELETED` int(11) DEFAULT '0',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_OWNER` (`OWNER`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_PHONE` (`PHONE`) USING BTREE,
  KEY `INDEX_MOBILE` (`MOBILE`) USING BTREE,
  KEY `INDEX_STATUS` (`STATUS`) USING BTREE,
  KEY `INDEX_CREATER_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='线索';

-- ----------------------------
-- Records of lead
-- ----------------------------
INSERT INTO lead VALUES ('2', '3', '', '线索002', '', '', '', '', '', '', '93', '103', null, '224', '', '144', '', null, null, null, '', '', '0', '1', '2014-08-18 15:53:13', '1', '2014-08-19 15:44:21');
INSERT INTO lead VALUES ('3', '2', '', '1', '', '', '', '', '', '', '93', '102', null, '222', '', '143', '', null, null, null, '', '', '0', '1', '2014-08-19 09:50:37', '1', '2014-08-19 15:44:21');
INSERT INTO lead VALUES ('5', '1', '百会8', '罗晓丽6', '研发中心8', '', '362350061@qq.com', '18600884611', '18600884611', '18600884611', '92', '102', null, '224', '1011400250354140', '142', '100001', '110000', '110100', '110108', '花园北路14号环星大厦D座二楼1', '无2', '0', '1', '2014-08-19 10:41:27', '1', '2014-08-19 15:44:21');
INSERT INTO lead VALUES ('6', '1', '百会7', '罗晓丽4', '研发中心9', '', '362350061@qq.com', '18600884611', '18600884611', '18600884613', '92', '102', null, '224', '1011400250354140', '142', '100001', '110000', '110100', '110108', '花园北路14号环星大厦D座二楼1', '无2', '0', '1', '2014-08-19 10:41:27', '1', '2014-08-19 15:44:21');
INSERT INTO lead VALUES ('7', '10', '', 'luoxiaoli—测试', '', '', '', '', '', '', '95', '103', null, '224', '', '147', '', null, null, null, '', '', '0', '1', '2014-08-19 11:56:40', '1', '2014-08-19 11:56:40');
INSERT INTO lead VALUES ('8', '11', '', '线索009（测试）', '1234', '', 'admin@qiangdawei.com', '15911140672', '', '', '94', '103', null, '224', '', '146', '', '110000', '110100', '110103', '北京东城', '', '0', '1', '2014-08-19 13:41:50', '1', '2014-08-19 15:44:21');
INSERT INTO lead VALUES ('9', '14', '', '测试111', '', '', '', '', '', '', '92', '102', null, '222', '', '142', '', null, null, null, '', '', '0', '14', '2014-08-19 16:26:56', '14', '2014-08-19 16:26:56');
INSERT INTO lead VALUES ('10', '20', '', 'maliya（123）', '', '', '', '', '', '', '93', '102', null, '222', '', '142', '', '110000', null, null, '', '', '0', '20', '2014-08-19 16:51:12', '20', '2014-08-19 16:51:12');
INSERT INTO lead VALUES ('11', '4', '', 'xiaoc（测试）', '', '', '', '', '', '', '95', '103', null, '222', '', '144', '', null, null, null, '', '', '0', '21', '2014-08-19 17:32:08', '21', '2014-08-21 22:12:32');
INSERT INTO lead VALUES ('12', '1', '', '委屈', '', '', '', '', '', '', '93', '104', null, '224', '', '144', '', null, null, null, '', '', '0', '1', '2014-08-26 19:30:50', '1', '2014-08-26 19:30:50');

-- ----------------------------
-- Table structure for `market_activity`
-- ----------------------------
DROP TABLE IF EXISTS `market_activity`;
CREATE TABLE `market_activity` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '活动名称',
  `TYPE_DIC` int(4) DEFAULT NULL COMMENT '活动类型',
  `STATUS_DIC` int(4) DEFAULT NULL COMMENT '活动状态',
  `BEGIN_DATE` datetime NOT NULL COMMENT '开始日期',
  `END_DATE` datetime DEFAULT NULL COMMENT '结束日期',
  `PREDICT_COST` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '预计成本',
  `REALITY_COST` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '实际成本',
  `TIMES` int(4) NOT NULL DEFAULT '0' COMMENT '活动次数',
  `EXPECT_EFFECT` varchar(50) DEFAULT '' COMMENT '预期效果',
  `EXPECT_SUCCESS_RATE` float(6,2) DEFAULT '0.00' COMMENT '期望成功率',
  `SPONSOR` int(11) NOT NULL DEFAULT '0' COMMENT '发起者',
  `BOSSHEAD` int(11) NOT NULL DEFAULT '0' COMMENT '负责人',
  `REMARK` varchar(512) DEFAULT '' COMMENT '备注',
  `IS_SEND` int(1) NOT NULL DEFAULT '0' COMMENT '是否已发提醒信息',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '删除标记',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `FLOW_NODE_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `INDEX_ACTIVITY_STATUS` (`STATUS_DIC`) USING BTREE,
  KEY `INDEX-CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE,
  KEY `INDEX-MODIFIER_ID` (`MODIFIER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='市场活动';

-- ----------------------------
-- Records of market_activity
-- ----------------------------
INSERT INTO market_activity VALUES ('1', '招商活动', null, null, '2014-08-18 00:00:00', '2014-08-31 00:00:00', '0.00', '0.00', '1', '', '0.00', '1', '1', '', '0', '1', '1', '2014-08-18 16:15:10', '1', '2014-08-29 15:34:59', '16');
INSERT INTO market_activity VALUES ('2', '基金中国（测试）', '76', '82', '2014-08-19 00:00:00', '2014-08-31 00:00:00', '5000.00', '5000.00', '1', '提高20%的销售额', '90.00', '1', '12', '', '0', '0', '1', '2014-08-19 10:04:51', '1', '2014-08-19 10:05:24', '9');
INSERT INTO market_activity VALUES ('3', '基金中国（测试1）', '75', '82', '2014-08-19 00:00:00', '2014-08-19 00:00:00', '100000.00', '12333.00', '1', '饭量', '100.00', '1', '1', '', '0', '0', '1', '2014-08-19 10:11:42', '1', '2014-08-19 10:12:14', '9');
INSERT INTO market_activity VALUES ('4', '侧身睡（测试）', '72', '82', '2014-08-19 00:00:00', '2014-08-31 00:00:00', '10000.00', '1000.00', '1', '稳定整张', '100.00', '1', '1', '', '0', '0', '1', '2014-08-19 10:14:01', '1', '2014-08-19 10:14:33', '9');
INSERT INTO market_activity VALUES ('5', '测试数据', null, null, '2014-08-19 00:00:00', '2014-08-31 00:00:00', '500000.00', '500000.00', '1', '100', '100.00', '1', '1', '', '0', '0', '1', '2014-08-19 10:16:01', '1', '2014-08-19 10:16:34', '9');
INSERT INTO market_activity VALUES ('6', '资金安全', '72', '82', '2014-08-19 00:00:00', '2014-08-19 00:00:00', '1000.00', '1000.00', '1', '12', '100.00', '14', '14', '', '0', '0', '14', '2014-08-19 16:18:22', '14', '2014-08-19 16:18:54', '9');
INSERT INTO market_activity VALUES ('7', '轻慢香江', '72', '82', '2014-08-19 00:00:00', '2014-08-31 00:00:00', '100.00', '10.00', '1', '1', '100.00', '20', '20', '', '0', '0', '20', '2014-08-19 16:48:59', '20', '2014-08-19 16:49:31', '9');
INSERT INTO market_activity VALUES ('8', '123', '72', '83', '2014-08-19 00:00:00', '2014-08-19 00:00:00', '12340.00', '5678.00', '1', '', '0.00', '21', '21', '', '0', '0', '21', '2014-08-19 17:30:42', '21', '2014-08-19 17:31:14', '9');
INSERT INTO market_activity VALUES ('9', '本地测试', '74', '82', '2014-08-20 00:00:00', '2014-08-20 00:00:00', '12345679.99', '0.00', '1', null, '0.89', '1', '1', '测试数据（lihua）', '0', '0', '1', '2014-08-20 09:43:11', '1', '2014-08-29 15:47:03', '9');
INSERT INTO market_activity VALUES ('10', '全面理财（测试）\'', null, null, '2014-08-21 00:00:00', '2014-08-21 00:00:00', '5000.00', '6000.00', '1', '注册人数增加20w，营业额增加10w', '100.00', '15', '15', null, '0', '0', '15', '2014-08-21 09:40:21', '5', '2014-08-26 19:55:57', '9');
INSERT INTO market_activity VALUES ('11', '\'', null, null, '2014-08-26 00:00:00', '2014-08-26 00:00:00', '0.00', '0.00', '1', null, '0.00', '5', '5', null, '0', '1', '5', '2014-08-26 19:57:30', '5', '2014-08-29 15:34:49', '14');

-- ----------------------------
-- Table structure for `memoir`
-- ----------------------------
DROP TABLE IF EXISTS `memoir`;
CREATE TABLE `memoir` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '纪要ID',
  `MODULE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '关联模块ID',
  `RECORD_ID` int(11) NOT NULL DEFAULT '0' COMMENT '关联模块内记录的ID',
  `ORG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '组织ID',
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `SUMMARY` varchar(1024) DEFAULT '' COMMENT '纪要内容',
  `NEXTCONTACTTIME` datetime DEFAULT NULL COMMENT '下次联系时间',
  `NEXTCONTACTPOINTS` varchar(1024) DEFAULT NULL COMMENT '下次联系要点',
  `REMARK` varchar(512) DEFAULT '' COMMENT '备注',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '标记删除',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ID` (`ID`) USING BTREE,
  KEY `INDEX_TYPE` (`MODULE_ID`) USING BTREE,
  KEY `INDEX_MODULE_ID` (`RECORD_ID`) USING BTREE,
  KEY `INDEX_EMPLOYEE_ID` (`USER_ID`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='沟通纪要';

-- ----------------------------
-- Records of memoir
-- ----------------------------
INSERT INTO memoir VALUES ('1', '323', '1', '1', '1', '丝袜的', '2014-08-29 00:00:00', '闻气味', '地方', '0', '1', '2014-08-18 15:29:44', '1', '2014-08-18 15:29:44');

-- ----------------------------
-- Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `ID` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `TITLE` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `CONTENT` text NOT NULL COMMENT '内容',
  `SENT_TIME` datetime NOT NULL COMMENT '发送时间',
  `DEAD_TIME` datetime NOT NULL COMMENT '过期时间',
  `IS_DELETED` tinyint(6) NOT NULL DEFAULT '0' COMMENT '是否被删除',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统公告表';

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO notice VALUES ('0001', 'dd公告', '公告公告公告\n方士大夫\n士大夫', '2014-08-18 07:36:00', '2014-09-14 00:00:00', '0', '1', '2014-08-18 15:39:34', '1', '2014-08-21 10:54:58');

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `PRODUCT_ID` int(4) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `CUSTOMER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `CODE` varchar(32) NOT NULL COMMENT '订单编号',
  `STATUS` int(11) DEFAULT NULL,
  `INVESTMENT_WAY` int(4) NOT NULL DEFAULT '0' COMMENT '投资方式',
  `PURCHASE_MONEY` decimal(10,2) NOT NULL COMMENT '购买金额',
  `EARNING_RATE` float(10,0) NOT NULL COMMENT '收益率',
  `ADVANCE_REDEEM_RATE` float(10,0) NOT NULL COMMENT '提前赎回率',
  `REDEEM_FORMULA` varchar(128) NOT NULL COMMENT '赎回公式',
  `OWNER` int(4) NOT NULL DEFAULT '0' COMMENT '销售人员',
  `SALES_MANAGER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '销售经理',
  `SALES_MAJORDOMO_ID` int(4) NOT NULL DEFAULT '0' COMMENT '销售总监',
  `ORDER_END_TIME` datetime NOT NULL COMMENT '订单结束时间',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `IS_DELETED` int(4) DEFAULT '0' COMMENT '删除标识',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `PAY_MONEY` decimal(10,0) DEFAULT '0' COMMENT '支付金额',
  `PAY_STATUS` int(4) DEFAULT '0' COMMENT '付款状态',
  `ORDER_STATUS` int(4) DEFAULT NULL COMMENT '订单状态',
  `EFFECTIVE_TIME` date DEFAULT NULL COMMENT '生效时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`) USING BTREE,
  KEY `INDEX_PRODUCT_ID` (`PRODUCT_ID`) USING BTREE,
  KEY `INDEX_ACCOUNT_ID` (`CUSTOMER_ID`) USING BTREE,
  KEY `INDEX_SALES_PERSON_ID` (`OWNER`) USING BTREE,
  KEY `INDEX_SALES_MANAGER_ID` (`SALES_MANAGER_ID`) USING BTREE,
  KEY `INDEX_SALES_MAJORDOMO_ID` (`SALES_MAJORDOMO_ID`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO order VALUES ('1', '1', '1', '024568', '2', '265', '232.00', '2', '3', 'x*33', '1', '3', '5', '2014-08-31 00:00:00', '', '0', '1', '2014-08-18 15:34:35', '1', '2014-08-18 15:34:35', '0', '26', '33', '2014-08-18');
INSERT INTO order VALUES ('2', '2', '3', '123456', '2', '263', '100.00', '10', '4', '3+5-1', '1', '3', '5', '2014-08-29 00:00:00', '', '0', '1', '2014-08-19 15:47:40', '1', '2014-08-19 15:47:40', '0', '26', '33', '2014-08-19');
INSERT INTO order VALUES ('3', '2', '5', 'lanlan', '1', '263', '100.00', '10', '2', '3+5-1', '14', '16', '5', '2014-09-03 00:00:00', '', '0', '14', '2014-08-19 16:34:45', '14', '2014-08-19 16:34:45', '0', '27', '32', '2014-08-20');
INSERT INTO order VALUES ('4', '1', '8', '098', '1', '263', '232.00', '2', '5', 'x*33', '15', '16', '17', '2014-09-11 00:00:00', '', '0', '15', '2014-08-21 09:49:39', '15', '2014-08-21 09:49:39', '0', '27', '32', '2014-08-22');
INSERT INTO order VALUES ('5', '3', '8', '0099', '1', '262', '15.00', '5', '1', '3+2-1', '15', '16', '17', '2014-09-26 00:00:00', '', '0', '15', '2014-08-22 09:20:20', '15', '2014-08-22 09:20:20', '0', '26', '32', '2014-08-22');

-- ----------------------------
-- Table structure for `payments`
-- ----------------------------
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(255) NOT NULL COMMENT '账款名称',
  `CUSTOMER_ID` int(11) NOT NULL COMMENT '客户',
  `ORDER_ID` int(11) NOT NULL COMMENT '订单',
  `FUND` decimal(10,2) NOT NULL COMMENT '账款',
  `STATUS` int(11) NOT NULL COMMENT '收款状态',
  `ACTUAL` decimal(10,2) DEFAULT NULL COMMENT '实际付款',
  `OPERATE_TIME` datetime NOT NULL COMMENT '操作时间',
  `OWNER_ID` int(11) NOT NULL COMMENT '操作者',
  `OPEN_BANK_DIC` int(11) DEFAULT NULL COMMENT '开户行',
  `BANK_NAME` varchar(255) DEFAULT NULL COMMENT '银行户名',
  `BANK_ACCOUNT` varchar(255) DEFAULT NULL,
  `PAY_TYPE_DIC` int(11) DEFAULT NULL COMMENT '支付方式',
  `CREATOR_ID` int(11) NOT NULL COMMENT '创建者',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL COMMENT ' 修改者',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `IS_DELETED` int(11) NOT NULL COMMENT '删除标识',
  `REMARK` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='付款表';

-- ----------------------------
-- Records of payments
-- ----------------------------
INSERT INTO payments VALUES ('1', '024568', '1', '1', '232.00', '1', '232.00', '2014-08-18 15:38:05', '1', '206', '银行户01', '1111122222222', null, '1', '2014-08-18 15:38:05', '1', '2014-08-18 15:38:05', '0', '');

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '产品名称',
  `CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '产品编号',
  `PROJECT_ID` int(4) NOT NULL DEFAULT '0' COMMENT '项目ID',
  `TYPE_DIC` int(4) DEFAULT '0' COMMENT '类型',
  `START_SELL_MONEY` decimal(10,2) DEFAULT '0.00' COMMENT '出售金额',
  `ERNING_RATE` decimal(10,2) DEFAULT '0.00' COMMENT '利率',
  `EXPECT_PROFIT` decimal(10,2) DEFAULT '0.00' COMMENT '预期收益',
  `SALE_LIMIT` int(4) DEFAULT '0' COMMENT '销售期限',
  `SALE_UNIT_DIC` int(4) DEFAULT '0' COMMENT '销售单位',
  `SALE_BEGIN_TIME` datetime DEFAULT NULL COMMENT '销售开始日期',
  `SALE_END_TIME` datetime DEFAULT NULL COMMENT '销售结束日期',
  `ADVANCE_REDEEM_RATE` decimal(10,2) DEFAULT NULL COMMENT '提前赎回率',
  `ADVANCE_REDEEM_FORMULA` varchar(216) DEFAULT '' COMMENT '提前赎回公式',
  `IS_EFFECT` char(1) DEFAULT '1' COMMENT '是否有效',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '标记删除',
  `REMARK` varchar(512) DEFAULT '' COMMENT '备注',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`) USING BTREE,
  KEY `INDEX_PROJECT_ID` (`PROJECT_ID`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO product VALUES ('1', ' 产品001', '201408181532303230', '1', null, '232.00', '2.00', null, null, '64', '2014-08-18 00:00:00', '2014-08-30 00:00:00', '2.00', 'x*33', '', '0', null, '1', '2014-08-18 15:33:22', '1', '2014-08-29 16:06:26');
INSERT INTO product VALUES ('2', '余额宝（测试）', '201408191539523952', '4', '342', '100.00', '10.00', '110.00', null, '64', '2014-08-20 00:00:00', '2014-08-21 00:00:00', '10.00', '3+5-1', '', '0', null, '1', '2014-08-19 15:41:40', '1', '2014-08-19 15:44:07');
INSERT INTO product VALUES ('3', '基金一期', '20140821094608468', '1', '342', '15.00', '5.00', '20.00', null, '64', '2014-08-22 00:00:00', '2014-08-30 00:00:00', '10.00', '3+2-1', '', '0', null, '15', '2014-08-21 09:47:43', '15', '2014-08-21 09:48:11');

-- ----------------------------
-- Table structure for `project`
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `SUPPLIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '供应商ID',
  `CODE` varchar(64) NOT NULL DEFAULT '' COMMENT '项目编号',
  `NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '项目名称',
  `FINANCE_LIMIT` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '融资额度',
  `BEGIN_TIME` datetime NOT NULL COMMENT '开始时间',
  `BEFORE_FINANCE_CYCLE` int(4) NOT NULL DEFAULT '0' COMMENT '融资前周期(天)',
  `FINANCE_CYCLE` int(4) NOT NULL DEFAULT '0' COMMENT '融资周期',
  `OPEN_TIME` datetime NOT NULL COMMENT '开放期',
  `DENDLINE_TIME` datetime NOT NULL COMMENT '截止时间',
  `EARNING_RATE` float(10,0) NOT NULL DEFAULT '0' COMMENT '收益率',
  `ADVANCE_REDEEM_RATE` float(10,0) NOT NULL DEFAULT '0' COMMENT '提前赎回率',
  `PAY_TYPE` int(11) NOT NULL DEFAULT '0' COMMENT '支付方式',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `IS_DELETED` int(11) DEFAULT '0',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最终修改时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`) USING BTREE,
  KEY `INDEX_SUPPLIER_ID` (`SUPPLIER_ID`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='项目表';

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO project VALUES ('1', '1', '024568', '中国人民银行丰台分行融资项目', '1000.00', '2014-08-20 00:00:00', '10', '11', '2014-08-18 00:00:00', '2014-08-31 00:00:00', '1', '12', '243', '', '0', '1', '2014-08-18 15:59:04', '1', '2014-08-18 15:59:04');
INSERT INTO project VALUES ('2', '3', '098', '虹桥（测试）', '10.00', '2014-08-30 00:00:00', '10', '10', '2014-08-23 00:00:00', '2014-08-31 00:00:00', '10', '5', '242', '', '0', '1', '2014-08-19 15:01:11', '1', '2014-08-19 15:01:11');
INSERT INTO project VALUES ('3', '2', '0980', 'admin', '40.00', '2014-08-20 00:00:00', '60', '1', '2014-08-21 00:00:00', '2014-08-31 00:00:00', '10', '20', '242', '', '0', '1', '2014-08-19 15:11:13', '1', '2014-08-19 15:11:13');
INSERT INTO project VALUES ('4', '4', '0987', '项目', '100.00', '2014-08-21 00:00:00', '1000', '100', '2014-08-30 00:00:00', '2014-08-30 00:00:00', '10', '7', '243', '', '0', '1', '2014-08-19 15:39:55', '1', '2014-08-19 15:39:55');

-- ----------------------------
-- Table structure for `pro_city_area`
-- ----------------------------
DROP TABLE IF EXISTS `pro_city_area`;
CREATE TABLE `pro_city_area` (
  `ID` int(4) NOT NULL COMMENT '主键ID',
  `NAME` varchar(32) NOT NULL COMMENT '名称',
  `PID` int(4) DEFAULT NULL COMMENT '父级ID',
  PRIMARY KEY (`ID`),
  KEY `INDEX_PID` (`PID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='省市县三级联动表';

-- ----------------------------
-- Records of pro_city_area
-- ----------------------------
INSERT INTO pro_city_area VALUES ('0', ' 未知', null);
INSERT INTO pro_city_area VALUES ('110000', '北京市', '0');
INSERT INTO pro_city_area VALUES ('110100', '北京市', '110000');
INSERT INTO pro_city_area VALUES ('110101', '东城区', '110100');
INSERT INTO pro_city_area VALUES ('110102', '西城区', '110100');
INSERT INTO pro_city_area VALUES ('110103', '崇文区', '110100');
INSERT INTO pro_city_area VALUES ('110104', '宣武区', '110100');
INSERT INTO pro_city_area VALUES ('110105', '朝阳区', '110100');
INSERT INTO pro_city_area VALUES ('110106', '丰台区', '110100');
INSERT INTO pro_city_area VALUES ('110107', '石景山区', '110100');
INSERT INTO pro_city_area VALUES ('110108', '海淀区', '110100');
INSERT INTO pro_city_area VALUES ('110109', '门头沟区', '110100');
INSERT INTO pro_city_area VALUES ('110111', '房山区', '110100');
INSERT INTO pro_city_area VALUES ('110112', '通州区', '110100');
INSERT INTO pro_city_area VALUES ('110113', '顺义区', '110100');
INSERT INTO pro_city_area VALUES ('110114', '昌平区', '110100');
INSERT INTO pro_city_area VALUES ('110115', '大兴区', '110100');
INSERT INTO pro_city_area VALUES ('110116', '怀柔区', '110100');
INSERT INTO pro_city_area VALUES ('110117', '平谷区', '110100');
INSERT INTO pro_city_area VALUES ('110228', '密云县', '110200');
INSERT INTO pro_city_area VALUES ('110229', '延庆县', '110200');
INSERT INTO pro_city_area VALUES ('120000', '天津市', '0');
INSERT INTO pro_city_area VALUES ('120100', '天津市', '120000');
INSERT INTO pro_city_area VALUES ('120101', '和平区', '120100');
INSERT INTO pro_city_area VALUES ('120102', '河东区', '120100');
INSERT INTO pro_city_area VALUES ('120103', '河西区', '120100');
INSERT INTO pro_city_area VALUES ('120104', '南开区', '120100');
INSERT INTO pro_city_area VALUES ('120105', '河北区', '120100');
INSERT INTO pro_city_area VALUES ('120106', '红桥区', '120100');
INSERT INTO pro_city_area VALUES ('120107', '塘沽区', '120100');
INSERT INTO pro_city_area VALUES ('120108', '汉沽区', '120100');
INSERT INTO pro_city_area VALUES ('120109', '大港区', '120100');
INSERT INTO pro_city_area VALUES ('120110', '东丽区', '120100');
INSERT INTO pro_city_area VALUES ('120111', '西青区', '120100');
INSERT INTO pro_city_area VALUES ('120112', '津南区', '120100');
INSERT INTO pro_city_area VALUES ('120113', '北辰区', '120100');
INSERT INTO pro_city_area VALUES ('120114', '武清区', '120100');
INSERT INTO pro_city_area VALUES ('120115', '宝坻区', '120100');
INSERT INTO pro_city_area VALUES ('120221', '宁河县', '120200');
INSERT INTO pro_city_area VALUES ('120223', '静海县', '120200');
INSERT INTO pro_city_area VALUES ('120225', '蓟　县', '120200');
INSERT INTO pro_city_area VALUES ('130000', '河北省', '0');
INSERT INTO pro_city_area VALUES ('130100', '石家庄市', '130000');
INSERT INTO pro_city_area VALUES ('130101', '市辖区', '130100');
INSERT INTO pro_city_area VALUES ('130102', '长安区', '130100');
INSERT INTO pro_city_area VALUES ('130103', '桥东区', '130100');
INSERT INTO pro_city_area VALUES ('130104', '桥西区', '130100');
INSERT INTO pro_city_area VALUES ('130105', '新华区', '130100');
INSERT INTO pro_city_area VALUES ('130107', '井陉矿区', '130100');
INSERT INTO pro_city_area VALUES ('130108', '裕华区', '130100');
INSERT INTO pro_city_area VALUES ('130121', '井陉县', '130100');
INSERT INTO pro_city_area VALUES ('130123', '正定县', '130100');
INSERT INTO pro_city_area VALUES ('130124', '栾城县', '130100');
INSERT INTO pro_city_area VALUES ('130125', '行唐县', '130100');
INSERT INTO pro_city_area VALUES ('130126', '灵寿县', '130100');
INSERT INTO pro_city_area VALUES ('130127', '高邑县', '130100');
INSERT INTO pro_city_area VALUES ('130128', '深泽县', '130100');
INSERT INTO pro_city_area VALUES ('130129', '赞皇县', '130100');
INSERT INTO pro_city_area VALUES ('130130', '无极县', '130100');
INSERT INTO pro_city_area VALUES ('130131', '平山县', '130100');
INSERT INTO pro_city_area VALUES ('130132', '元氏县', '130100');
INSERT INTO pro_city_area VALUES ('130133', '赵　县', '130100');
INSERT INTO pro_city_area VALUES ('130181', '辛集市', '130100');
INSERT INTO pro_city_area VALUES ('130182', '藁城市', '130100');
INSERT INTO pro_city_area VALUES ('130183', '晋州市', '130100');
INSERT INTO pro_city_area VALUES ('130184', '新乐市', '130100');
INSERT INTO pro_city_area VALUES ('130185', '鹿泉市', '130100');
INSERT INTO pro_city_area VALUES ('130200', '唐山市', '130000');
INSERT INTO pro_city_area VALUES ('130201', '市辖区', '130200');
INSERT INTO pro_city_area VALUES ('130202', '路南区', '130200');
INSERT INTO pro_city_area VALUES ('130203', '路北区', '130200');
INSERT INTO pro_city_area VALUES ('130204', '古冶区', '130200');
INSERT INTO pro_city_area VALUES ('130205', '开平区', '130200');
INSERT INTO pro_city_area VALUES ('130207', '丰南区', '130200');
INSERT INTO pro_city_area VALUES ('130208', '丰润区', '130200');
INSERT INTO pro_city_area VALUES ('130223', '滦　县', '130200');
INSERT INTO pro_city_area VALUES ('130224', '滦南县', '130200');
INSERT INTO pro_city_area VALUES ('130225', '乐亭县', '130200');
INSERT INTO pro_city_area VALUES ('130227', '迁西县', '130200');
INSERT INTO pro_city_area VALUES ('130229', '玉田县', '130200');
INSERT INTO pro_city_area VALUES ('130230', '唐海县', '130200');
INSERT INTO pro_city_area VALUES ('130281', '遵化市', '130200');
INSERT INTO pro_city_area VALUES ('130283', '迁安市', '130200');
INSERT INTO pro_city_area VALUES ('130300', '秦皇岛市', '130000');
INSERT INTO pro_city_area VALUES ('130301', '市辖区', '130300');
INSERT INTO pro_city_area VALUES ('130302', '海港区', '130300');
INSERT INTO pro_city_area VALUES ('130303', '山海关区', '130300');
INSERT INTO pro_city_area VALUES ('130304', '北戴河区', '130300');
INSERT INTO pro_city_area VALUES ('130321', '青龙满族自治县', '130300');
INSERT INTO pro_city_area VALUES ('130322', '昌黎县', '130300');
INSERT INTO pro_city_area VALUES ('130323', '抚宁县', '130300');
INSERT INTO pro_city_area VALUES ('130324', '卢龙县', '130300');
INSERT INTO pro_city_area VALUES ('130400', '邯郸市', '130000');
INSERT INTO pro_city_area VALUES ('130401', '市辖区', '130400');
INSERT INTO pro_city_area VALUES ('130402', '邯山区', '130400');
INSERT INTO pro_city_area VALUES ('130403', '丛台区', '130400');
INSERT INTO pro_city_area VALUES ('130404', '复兴区', '130400');
INSERT INTO pro_city_area VALUES ('130406', '峰峰矿区', '130400');
INSERT INTO pro_city_area VALUES ('130421', '邯郸县', '130400');
INSERT INTO pro_city_area VALUES ('130423', '临漳县', '130400');
INSERT INTO pro_city_area VALUES ('130424', '成安县', '130400');
INSERT INTO pro_city_area VALUES ('130425', '大名县', '130400');
INSERT INTO pro_city_area VALUES ('130426', '涉　县', '130400');
INSERT INTO pro_city_area VALUES ('130427', '磁　县', '130400');
INSERT INTO pro_city_area VALUES ('130428', '肥乡县', '130400');
INSERT INTO pro_city_area VALUES ('130429', '永年县', '130400');
INSERT INTO pro_city_area VALUES ('130430', '邱　县', '130400');
INSERT INTO pro_city_area VALUES ('130431', '鸡泽县', '130400');
INSERT INTO pro_city_area VALUES ('130432', '广平县', '130400');
INSERT INTO pro_city_area VALUES ('130433', '馆陶县', '130400');
INSERT INTO pro_city_area VALUES ('130434', '魏　县', '130400');
INSERT INTO pro_city_area VALUES ('130435', '曲周县', '130400');
INSERT INTO pro_city_area VALUES ('130481', '武安市', '130400');
INSERT INTO pro_city_area VALUES ('130500', '邢台市', '130000');
INSERT INTO pro_city_area VALUES ('130501', '市辖区', '130500');
INSERT INTO pro_city_area VALUES ('130502', '桥东区', '130500');
INSERT INTO pro_city_area VALUES ('130503', '桥西区', '130500');
INSERT INTO pro_city_area VALUES ('130521', '邢台县', '130500');
INSERT INTO pro_city_area VALUES ('130522', '临城县', '130500');
INSERT INTO pro_city_area VALUES ('130523', '内丘县', '130500');
INSERT INTO pro_city_area VALUES ('130524', '柏乡县', '130500');
INSERT INTO pro_city_area VALUES ('130525', '隆尧县', '130500');
INSERT INTO pro_city_area VALUES ('130526', '任　县', '130500');
INSERT INTO pro_city_area VALUES ('130527', '南和县', '130500');
INSERT INTO pro_city_area VALUES ('130528', '宁晋县', '130500');
INSERT INTO pro_city_area VALUES ('130529', '巨鹿县', '130500');
INSERT INTO pro_city_area VALUES ('130530', '新河县', '130500');
INSERT INTO pro_city_area VALUES ('130531', '广宗县', '130500');
INSERT INTO pro_city_area VALUES ('130532', '平乡县', '130500');
INSERT INTO pro_city_area VALUES ('130533', '威　县', '130500');
INSERT INTO pro_city_area VALUES ('130534', '清河县', '130500');
INSERT INTO pro_city_area VALUES ('130535', '临西县', '130500');
INSERT INTO pro_city_area VALUES ('130581', '南宫市', '130500');
INSERT INTO pro_city_area VALUES ('130582', '沙河市', '130500');
INSERT INTO pro_city_area VALUES ('130600', '保定市', '130000');
INSERT INTO pro_city_area VALUES ('130601', '市辖区', '130600');
INSERT INTO pro_city_area VALUES ('130602', '新市区', '130600');
INSERT INTO pro_city_area VALUES ('130603', '北市区', '130600');
INSERT INTO pro_city_area VALUES ('130604', '南市区', '130600');
INSERT INTO pro_city_area VALUES ('130621', '满城县', '130600');
INSERT INTO pro_city_area VALUES ('130622', '清苑县', '130600');
INSERT INTO pro_city_area VALUES ('130623', '涞水县', '130600');
INSERT INTO pro_city_area VALUES ('130624', '阜平县', '130600');
INSERT INTO pro_city_area VALUES ('130625', '徐水县', '130600');
INSERT INTO pro_city_area VALUES ('130626', '定兴县', '130600');
INSERT INTO pro_city_area VALUES ('130627', '唐　县', '130600');
INSERT INTO pro_city_area VALUES ('130628', '高阳县', '130600');
INSERT INTO pro_city_area VALUES ('130629', '容城县', '130600');
INSERT INTO pro_city_area VALUES ('130630', '涞源县', '130600');
INSERT INTO pro_city_area VALUES ('130631', '望都县', '130600');
INSERT INTO pro_city_area VALUES ('130632', '安新县', '130600');
INSERT INTO pro_city_area VALUES ('130633', '易　县', '130600');
INSERT INTO pro_city_area VALUES ('130634', '曲阳县', '130600');
INSERT INTO pro_city_area VALUES ('130635', '蠡　县', '130600');
INSERT INTO pro_city_area VALUES ('130636', '顺平县', '130600');
INSERT INTO pro_city_area VALUES ('130637', '博野县', '130600');
INSERT INTO pro_city_area VALUES ('130638', '雄　县', '130600');
INSERT INTO pro_city_area VALUES ('130681', '涿州市', '130600');
INSERT INTO pro_city_area VALUES ('130682', '定州市', '130600');
INSERT INTO pro_city_area VALUES ('130683', '安国市', '130600');
INSERT INTO pro_city_area VALUES ('130684', '高碑店市', '130600');
INSERT INTO pro_city_area VALUES ('130700', '张家口市', '130000');
INSERT INTO pro_city_area VALUES ('130701', '市辖区', '130700');
INSERT INTO pro_city_area VALUES ('130702', '桥东区', '130700');
INSERT INTO pro_city_area VALUES ('130703', '桥西区', '130700');
INSERT INTO pro_city_area VALUES ('130705', '宣化区', '130700');
INSERT INTO pro_city_area VALUES ('130706', '下花园区', '130700');
INSERT INTO pro_city_area VALUES ('130721', '宣化县', '130700');
INSERT INTO pro_city_area VALUES ('130722', '张北县', '130700');
INSERT INTO pro_city_area VALUES ('130723', '康保县', '130700');
INSERT INTO pro_city_area VALUES ('130724', '沽源县', '130700');
INSERT INTO pro_city_area VALUES ('130725', '尚义县', '130700');
INSERT INTO pro_city_area VALUES ('130726', '蔚　县', '130700');
INSERT INTO pro_city_area VALUES ('130727', '阳原县', '130700');
INSERT INTO pro_city_area VALUES ('130728', '怀安县', '130700');
INSERT INTO pro_city_area VALUES ('130729', '万全县', '130700');
INSERT INTO pro_city_area VALUES ('130730', '怀来县', '130700');
INSERT INTO pro_city_area VALUES ('130731', '涿鹿县', '130700');
INSERT INTO pro_city_area VALUES ('130732', '赤城县', '130700');
INSERT INTO pro_city_area VALUES ('130733', '崇礼县', '130700');
INSERT INTO pro_city_area VALUES ('130800', '承德市', '130000');
INSERT INTO pro_city_area VALUES ('130801', '市辖区', '130800');
INSERT INTO pro_city_area VALUES ('130802', '双桥区', '130800');
INSERT INTO pro_city_area VALUES ('130803', '双滦区', '130800');
INSERT INTO pro_city_area VALUES ('130804', '鹰手营子矿区', '130800');
INSERT INTO pro_city_area VALUES ('130821', '承德县', '130800');
INSERT INTO pro_city_area VALUES ('130822', '兴隆县', '130800');
INSERT INTO pro_city_area VALUES ('130823', '平泉县', '130800');
INSERT INTO pro_city_area VALUES ('130824', '滦平县', '130800');
INSERT INTO pro_city_area VALUES ('130825', '隆化县', '130800');
INSERT INTO pro_city_area VALUES ('130826', '丰宁满族自治县', '130800');
INSERT INTO pro_city_area VALUES ('130827', '宽城满族自治县', '130800');
INSERT INTO pro_city_area VALUES ('130828', '围场满族蒙古族自治县', '130800');
INSERT INTO pro_city_area VALUES ('130900', '沧州市', '130000');
INSERT INTO pro_city_area VALUES ('130901', '市辖区', '130900');
INSERT INTO pro_city_area VALUES ('130902', '新华区', '130900');
INSERT INTO pro_city_area VALUES ('130903', '运河区', '130900');
INSERT INTO pro_city_area VALUES ('130921', '沧　县', '130900');
INSERT INTO pro_city_area VALUES ('130922', '青　县', '130900');
INSERT INTO pro_city_area VALUES ('130923', '东光县', '130900');
INSERT INTO pro_city_area VALUES ('130924', '海兴县', '130900');
INSERT INTO pro_city_area VALUES ('130925', '盐山县', '130900');
INSERT INTO pro_city_area VALUES ('130926', '肃宁县', '130900');
INSERT INTO pro_city_area VALUES ('130927', '南皮县', '130900');
INSERT INTO pro_city_area VALUES ('130928', '吴桥县', '130900');
INSERT INTO pro_city_area VALUES ('130929', '献　县', '130900');
INSERT INTO pro_city_area VALUES ('130930', '孟村回族自治县', '130900');
INSERT INTO pro_city_area VALUES ('130981', '泊头市', '130900');
INSERT INTO pro_city_area VALUES ('130982', '任丘市', '130900');
INSERT INTO pro_city_area VALUES ('130983', '黄骅市', '130900');
INSERT INTO pro_city_area VALUES ('130984', '河间市', '130900');
INSERT INTO pro_city_area VALUES ('131000', '廊坊市', '130000');
INSERT INTO pro_city_area VALUES ('131001', '市辖区', '131000');
INSERT INTO pro_city_area VALUES ('131002', '安次区', '131000');
INSERT INTO pro_city_area VALUES ('131003', '广阳区', '131000');
INSERT INTO pro_city_area VALUES ('131022', '固安县', '131000');
INSERT INTO pro_city_area VALUES ('131023', '永清县', '131000');
INSERT INTO pro_city_area VALUES ('131024', '香河县', '131000');
INSERT INTO pro_city_area VALUES ('131025', '大城县', '131000');
INSERT INTO pro_city_area VALUES ('131026', '文安县', '131000');
INSERT INTO pro_city_area VALUES ('131028', '大厂回族自治县', '131000');
INSERT INTO pro_city_area VALUES ('131081', '霸州市', '131000');
INSERT INTO pro_city_area VALUES ('131082', '三河市', '131000');
INSERT INTO pro_city_area VALUES ('131100', '衡水市', '130000');
INSERT INTO pro_city_area VALUES ('131101', '市辖区', '131100');
INSERT INTO pro_city_area VALUES ('131102', '桃城区', '131100');
INSERT INTO pro_city_area VALUES ('131121', '枣强县', '131100');
INSERT INTO pro_city_area VALUES ('131122', '武邑县', '131100');
INSERT INTO pro_city_area VALUES ('131123', '武强县', '131100');
INSERT INTO pro_city_area VALUES ('131124', '饶阳县', '131100');
INSERT INTO pro_city_area VALUES ('131125', '安平县', '131100');
INSERT INTO pro_city_area VALUES ('131126', '故城县', '131100');
INSERT INTO pro_city_area VALUES ('131127', '景　县', '131100');
INSERT INTO pro_city_area VALUES ('131128', '阜城县', '131100');
INSERT INTO pro_city_area VALUES ('131181', '冀州市', '131100');
INSERT INTO pro_city_area VALUES ('131182', '深州市', '131100');
INSERT INTO pro_city_area VALUES ('140000', '山西省', '0');
INSERT INTO pro_city_area VALUES ('140100', '太原市', '140000');
INSERT INTO pro_city_area VALUES ('140101', '市辖区', '140100');
INSERT INTO pro_city_area VALUES ('140105', '小店区', '140100');
INSERT INTO pro_city_area VALUES ('140106', '迎泽区', '140100');
INSERT INTO pro_city_area VALUES ('140107', '杏花岭区', '140100');
INSERT INTO pro_city_area VALUES ('140108', '尖草坪区', '140100');
INSERT INTO pro_city_area VALUES ('140109', '万柏林区', '140100');
INSERT INTO pro_city_area VALUES ('140110', '晋源区', '140100');
INSERT INTO pro_city_area VALUES ('140121', '清徐县', '140100');
INSERT INTO pro_city_area VALUES ('140122', '阳曲县', '140100');
INSERT INTO pro_city_area VALUES ('140123', '娄烦县', '140100');
INSERT INTO pro_city_area VALUES ('140181', '古交市', '140100');
INSERT INTO pro_city_area VALUES ('140200', '大同市', '140000');
INSERT INTO pro_city_area VALUES ('140201', '市辖区', '140200');
INSERT INTO pro_city_area VALUES ('140202', '城　区', '140200');
INSERT INTO pro_city_area VALUES ('140203', '矿　区', '140200');
INSERT INTO pro_city_area VALUES ('140211', '南郊区', '140200');
INSERT INTO pro_city_area VALUES ('140212', '新荣区', '140200');
INSERT INTO pro_city_area VALUES ('140221', '阳高县', '140200');
INSERT INTO pro_city_area VALUES ('140222', '天镇县', '140200');
INSERT INTO pro_city_area VALUES ('140223', '广灵县', '140200');
INSERT INTO pro_city_area VALUES ('140224', '灵丘县', '140200');
INSERT INTO pro_city_area VALUES ('140225', '浑源县', '140200');
INSERT INTO pro_city_area VALUES ('140226', '左云县', '140200');
INSERT INTO pro_city_area VALUES ('140227', '大同县', '140200');
INSERT INTO pro_city_area VALUES ('140300', '阳泉市', '140000');
INSERT INTO pro_city_area VALUES ('140301', '市辖区', '140300');
INSERT INTO pro_city_area VALUES ('140302', '城　区', '140300');
INSERT INTO pro_city_area VALUES ('140303', '矿　区', '140300');
INSERT INTO pro_city_area VALUES ('140311', '郊　区', '140300');
INSERT INTO pro_city_area VALUES ('140321', '平定县', '140300');
INSERT INTO pro_city_area VALUES ('140322', '盂　县', '140300');
INSERT INTO pro_city_area VALUES ('140400', '长治市', '140000');
INSERT INTO pro_city_area VALUES ('140401', '市辖区', '140400');
INSERT INTO pro_city_area VALUES ('140402', '城　区', '140400');
INSERT INTO pro_city_area VALUES ('140411', '郊　区', '140400');
INSERT INTO pro_city_area VALUES ('140421', '长治县', '140400');
INSERT INTO pro_city_area VALUES ('140423', '襄垣县', '140400');
INSERT INTO pro_city_area VALUES ('140424', '屯留县', '140400');
INSERT INTO pro_city_area VALUES ('140425', '平顺县', '140400');
INSERT INTO pro_city_area VALUES ('140426', '黎城县', '140400');
INSERT INTO pro_city_area VALUES ('140427', '壶关县', '140400');
INSERT INTO pro_city_area VALUES ('140428', '长子县', '140400');
INSERT INTO pro_city_area VALUES ('140429', '武乡县', '140400');
INSERT INTO pro_city_area VALUES ('140430', '沁　县', '140400');
INSERT INTO pro_city_area VALUES ('140431', '沁源县', '140400');
INSERT INTO pro_city_area VALUES ('140481', '潞城市', '140400');
INSERT INTO pro_city_area VALUES ('140500', '晋城市', '140000');
INSERT INTO pro_city_area VALUES ('140501', '市辖区', '140500');
INSERT INTO pro_city_area VALUES ('140502', '城　区', '140500');
INSERT INTO pro_city_area VALUES ('140521', '沁水县', '140500');
INSERT INTO pro_city_area VALUES ('140522', '阳城县', '140500');
INSERT INTO pro_city_area VALUES ('140524', '陵川县', '140500');
INSERT INTO pro_city_area VALUES ('140525', '泽州县', '140500');
INSERT INTO pro_city_area VALUES ('140581', '高平市', '140500');
INSERT INTO pro_city_area VALUES ('140600', '朔州市', '140000');
INSERT INTO pro_city_area VALUES ('140601', '市辖区', '140600');
INSERT INTO pro_city_area VALUES ('140602', '朔城区', '140600');
INSERT INTO pro_city_area VALUES ('140603', '平鲁区', '140600');
INSERT INTO pro_city_area VALUES ('140621', '山阴县', '140600');
INSERT INTO pro_city_area VALUES ('140622', '应　县', '140600');
INSERT INTO pro_city_area VALUES ('140623', '右玉县', '140600');
INSERT INTO pro_city_area VALUES ('140624', '怀仁县', '140600');
INSERT INTO pro_city_area VALUES ('140700', '晋中市', '140000');
INSERT INTO pro_city_area VALUES ('140701', '市辖区', '140700');
INSERT INTO pro_city_area VALUES ('140702', '榆次区', '140700');
INSERT INTO pro_city_area VALUES ('140721', '榆社县', '140700');
INSERT INTO pro_city_area VALUES ('140722', '左权县', '140700');
INSERT INTO pro_city_area VALUES ('140723', '和顺县', '140700');
INSERT INTO pro_city_area VALUES ('140724', '昔阳县', '140700');
INSERT INTO pro_city_area VALUES ('140725', '寿阳县', '140700');
INSERT INTO pro_city_area VALUES ('140726', '太谷县', '140700');
INSERT INTO pro_city_area VALUES ('140727', '祁　县', '140700');
INSERT INTO pro_city_area VALUES ('140728', '平遥县', '140700');
INSERT INTO pro_city_area VALUES ('140729', '灵石县', '140700');
INSERT INTO pro_city_area VALUES ('140781', '介休市', '140700');
INSERT INTO pro_city_area VALUES ('140800', '运城市', '140000');
INSERT INTO pro_city_area VALUES ('140801', '市辖区', '140800');
INSERT INTO pro_city_area VALUES ('140802', '盐湖区', '140800');
INSERT INTO pro_city_area VALUES ('140821', '临猗县', '140800');
INSERT INTO pro_city_area VALUES ('140822', '万荣县', '140800');
INSERT INTO pro_city_area VALUES ('140823', '闻喜县', '140800');
INSERT INTO pro_city_area VALUES ('140824', '稷山县', '140800');
INSERT INTO pro_city_area VALUES ('140825', '新绛县', '140800');
INSERT INTO pro_city_area VALUES ('140826', '绛　县', '140800');
INSERT INTO pro_city_area VALUES ('140827', '垣曲县', '140800');
INSERT INTO pro_city_area VALUES ('140828', '夏　县', '140800');
INSERT INTO pro_city_area VALUES ('140829', '平陆县', '140800');
INSERT INTO pro_city_area VALUES ('140830', '芮城县', '140800');
INSERT INTO pro_city_area VALUES ('140881', '永济市', '140800');
INSERT INTO pro_city_area VALUES ('140882', '河津市', '140800');
INSERT INTO pro_city_area VALUES ('140900', '忻州市', '140000');
INSERT INTO pro_city_area VALUES ('140901', '市辖区', '140900');
INSERT INTO pro_city_area VALUES ('140902', '忻府区', '140900');
INSERT INTO pro_city_area VALUES ('140921', '定襄县', '140900');
INSERT INTO pro_city_area VALUES ('140922', '五台县', '140900');
INSERT INTO pro_city_area VALUES ('140923', '代　县', '140900');
INSERT INTO pro_city_area VALUES ('140924', '繁峙县', '140900');
INSERT INTO pro_city_area VALUES ('140925', '宁武县', '140900');
INSERT INTO pro_city_area VALUES ('140926', '静乐县', '140900');
INSERT INTO pro_city_area VALUES ('140927', '神池县', '140900');
INSERT INTO pro_city_area VALUES ('140928', '五寨县', '140900');
INSERT INTO pro_city_area VALUES ('140929', '岢岚县', '140900');
INSERT INTO pro_city_area VALUES ('140930', '河曲县', '140900');
INSERT INTO pro_city_area VALUES ('140931', '保德县', '140900');
INSERT INTO pro_city_area VALUES ('140932', '偏关县', '140900');
INSERT INTO pro_city_area VALUES ('140981', '原平市', '140900');
INSERT INTO pro_city_area VALUES ('141000', '临汾市', '140000');
INSERT INTO pro_city_area VALUES ('141001', '市辖区', '141000');
INSERT INTO pro_city_area VALUES ('141002', '尧都区', '141000');
INSERT INTO pro_city_area VALUES ('141021', '曲沃县', '141000');
INSERT INTO pro_city_area VALUES ('141022', '翼城县', '141000');
INSERT INTO pro_city_area VALUES ('141023', '襄汾县', '141000');
INSERT INTO pro_city_area VALUES ('141024', '洪洞县', '141000');
INSERT INTO pro_city_area VALUES ('141025', '古　县', '141000');
INSERT INTO pro_city_area VALUES ('141026', '安泽县', '141000');
INSERT INTO pro_city_area VALUES ('141027', '浮山县', '141000');
INSERT INTO pro_city_area VALUES ('141028', '吉　县', '141000');
INSERT INTO pro_city_area VALUES ('141029', '乡宁县', '141000');
INSERT INTO pro_city_area VALUES ('141030', '大宁县', '141000');
INSERT INTO pro_city_area VALUES ('141031', '隰　县', '141000');
INSERT INTO pro_city_area VALUES ('141032', '永和县', '141000');
INSERT INTO pro_city_area VALUES ('141033', '蒲　县', '141000');
INSERT INTO pro_city_area VALUES ('141034', '汾西县', '141000');
INSERT INTO pro_city_area VALUES ('141081', '侯马市', '141000');
INSERT INTO pro_city_area VALUES ('141082', '霍州市', '141000');
INSERT INTO pro_city_area VALUES ('141100', '吕梁市', '140000');
INSERT INTO pro_city_area VALUES ('141101', '市辖区', '141100');
INSERT INTO pro_city_area VALUES ('141102', '离石区', '141100');
INSERT INTO pro_city_area VALUES ('141121', '文水县', '141100');
INSERT INTO pro_city_area VALUES ('141122', '交城县', '141100');
INSERT INTO pro_city_area VALUES ('141123', '兴　县', '141100');
INSERT INTO pro_city_area VALUES ('141124', '临　县', '141100');
INSERT INTO pro_city_area VALUES ('141125', '柳林县', '141100');
INSERT INTO pro_city_area VALUES ('141126', '石楼县', '141100');
INSERT INTO pro_city_area VALUES ('141127', '岚　县', '141100');
INSERT INTO pro_city_area VALUES ('141128', '方山县', '141100');
INSERT INTO pro_city_area VALUES ('141129', '中阳县', '141100');
INSERT INTO pro_city_area VALUES ('141130', '交口县', '141100');
INSERT INTO pro_city_area VALUES ('141181', '孝义市', '141100');
INSERT INTO pro_city_area VALUES ('141182', '汾阳市', '141100');
INSERT INTO pro_city_area VALUES ('150000', '内蒙古', '0');
INSERT INTO pro_city_area VALUES ('150100', '呼和浩特市', '150000');
INSERT INTO pro_city_area VALUES ('150101', '市辖区', '150100');
INSERT INTO pro_city_area VALUES ('150102', '新城区', '150100');
INSERT INTO pro_city_area VALUES ('150103', '回民区', '150100');
INSERT INTO pro_city_area VALUES ('150104', '玉泉区', '150100');
INSERT INTO pro_city_area VALUES ('150105', '赛罕区', '150100');
INSERT INTO pro_city_area VALUES ('150121', '土默特左旗', '150100');
INSERT INTO pro_city_area VALUES ('150122', '托克托县', '150100');
INSERT INTO pro_city_area VALUES ('150123', '和林格尔县', '150100');
INSERT INTO pro_city_area VALUES ('150124', '清水河县', '150100');
INSERT INTO pro_city_area VALUES ('150125', '武川县', '150100');
INSERT INTO pro_city_area VALUES ('150200', '包头市', '150000');
INSERT INTO pro_city_area VALUES ('150201', '市辖区', '150200');
INSERT INTO pro_city_area VALUES ('150202', '东河区', '150200');
INSERT INTO pro_city_area VALUES ('150203', '昆都仑区', '150200');
INSERT INTO pro_city_area VALUES ('150204', '青山区', '150200');
INSERT INTO pro_city_area VALUES ('150205', '石拐区', '150200');
INSERT INTO pro_city_area VALUES ('150206', '白云矿区', '150200');
INSERT INTO pro_city_area VALUES ('150207', '九原区', '150200');
INSERT INTO pro_city_area VALUES ('150221', '土默特右旗', '150200');
INSERT INTO pro_city_area VALUES ('150222', '固阳县', '150200');
INSERT INTO pro_city_area VALUES ('150223', '达尔罕茂明安联合旗', '150200');
INSERT INTO pro_city_area VALUES ('150300', '乌海市', '150000');
INSERT INTO pro_city_area VALUES ('150301', '市辖区', '150300');
INSERT INTO pro_city_area VALUES ('150302', '海勃湾区', '150300');
INSERT INTO pro_city_area VALUES ('150303', '海南区', '150300');
INSERT INTO pro_city_area VALUES ('150304', '乌达区', '150300');
INSERT INTO pro_city_area VALUES ('150400', '赤峰市', '150000');
INSERT INTO pro_city_area VALUES ('150401', '市辖区', '150400');
INSERT INTO pro_city_area VALUES ('150402', '红山区', '150400');
INSERT INTO pro_city_area VALUES ('150403', '元宝山区', '150400');
INSERT INTO pro_city_area VALUES ('150404', '松山区', '150400');
INSERT INTO pro_city_area VALUES ('150421', '阿鲁科尔沁旗', '150400');
INSERT INTO pro_city_area VALUES ('150422', '巴林左旗', '150400');
INSERT INTO pro_city_area VALUES ('150423', '巴林右旗', '150400');
INSERT INTO pro_city_area VALUES ('150424', '林西县', '150400');
INSERT INTO pro_city_area VALUES ('150425', '克什克腾旗', '150400');
INSERT INTO pro_city_area VALUES ('150426', '翁牛特旗', '150400');
INSERT INTO pro_city_area VALUES ('150428', '喀喇沁旗', '150400');
INSERT INTO pro_city_area VALUES ('150429', '宁城县', '150400');
INSERT INTO pro_city_area VALUES ('150430', '敖汉旗', '150400');
INSERT INTO pro_city_area VALUES ('150500', '通辽市', '150000');
INSERT INTO pro_city_area VALUES ('150501', '市辖区', '150500');
INSERT INTO pro_city_area VALUES ('150502', '科尔沁区', '150500');
INSERT INTO pro_city_area VALUES ('150521', '科尔沁左翼中旗', '150500');
INSERT INTO pro_city_area VALUES ('150522', '科尔沁左翼后旗', '150500');
INSERT INTO pro_city_area VALUES ('150523', '开鲁县', '150500');
INSERT INTO pro_city_area VALUES ('150524', '库伦旗', '150500');
INSERT INTO pro_city_area VALUES ('150525', '奈曼旗', '150500');
INSERT INTO pro_city_area VALUES ('150526', '扎鲁特旗', '150500');
INSERT INTO pro_city_area VALUES ('150581', '霍林郭勒市', '150500');
INSERT INTO pro_city_area VALUES ('150600', '鄂尔多斯市', '150000');
INSERT INTO pro_city_area VALUES ('150602', '东胜区', '150600');
INSERT INTO pro_city_area VALUES ('150621', '达拉特旗', '150600');
INSERT INTO pro_city_area VALUES ('150622', '准格尔旗', '150600');
INSERT INTO pro_city_area VALUES ('150623', '鄂托克前旗', '150600');
INSERT INTO pro_city_area VALUES ('150624', '鄂托克旗', '150600');
INSERT INTO pro_city_area VALUES ('150625', '杭锦旗', '150600');
INSERT INTO pro_city_area VALUES ('150626', '乌审旗', '150600');
INSERT INTO pro_city_area VALUES ('150627', '伊金霍洛旗', '150600');
INSERT INTO pro_city_area VALUES ('150700', '呼伦贝尔市', '150000');
INSERT INTO pro_city_area VALUES ('150701', '市辖区', '150700');
INSERT INTO pro_city_area VALUES ('150702', '海拉尔区', '150700');
INSERT INTO pro_city_area VALUES ('150721', '阿荣旗', '150700');
INSERT INTO pro_city_area VALUES ('150722', '莫力达瓦达斡尔族自治旗', '150700');
INSERT INTO pro_city_area VALUES ('150723', '鄂伦春自治旗', '150700');
INSERT INTO pro_city_area VALUES ('150724', '鄂温克族自治旗', '150700');
INSERT INTO pro_city_area VALUES ('150725', '陈巴尔虎旗', '150700');
INSERT INTO pro_city_area VALUES ('150726', '新巴尔虎左旗', '150700');
INSERT INTO pro_city_area VALUES ('150727', '新巴尔虎右旗', '150700');
INSERT INTO pro_city_area VALUES ('150781', '满洲里市', '150700');
INSERT INTO pro_city_area VALUES ('150782', '牙克石市', '150700');
INSERT INTO pro_city_area VALUES ('150783', '扎兰屯市', '150700');
INSERT INTO pro_city_area VALUES ('150784', '额尔古纳市', '150700');
INSERT INTO pro_city_area VALUES ('150785', '根河市', '150700');
INSERT INTO pro_city_area VALUES ('150800', '巴彦淖尔市', '150000');
INSERT INTO pro_city_area VALUES ('150801', '市辖区', '150800');
INSERT INTO pro_city_area VALUES ('150802', '临河区', '150800');
INSERT INTO pro_city_area VALUES ('150821', '五原县', '150800');
INSERT INTO pro_city_area VALUES ('150822', '磴口县', '150800');
INSERT INTO pro_city_area VALUES ('150823', '乌拉特前旗', '150800');
INSERT INTO pro_city_area VALUES ('150824', '乌拉特中旗', '150800');
INSERT INTO pro_city_area VALUES ('150825', '乌拉特后旗', '150800');
INSERT INTO pro_city_area VALUES ('150826', '杭锦后旗', '150800');
INSERT INTO pro_city_area VALUES ('150900', '乌兰察布市', '150000');
INSERT INTO pro_city_area VALUES ('150901', '市辖区', '150900');
INSERT INTO pro_city_area VALUES ('150902', '集宁区', '150900');
INSERT INTO pro_city_area VALUES ('150921', '卓资县', '150900');
INSERT INTO pro_city_area VALUES ('150922', '化德县', '150900');
INSERT INTO pro_city_area VALUES ('150923', '商都县', '150900');
INSERT INTO pro_city_area VALUES ('150924', '兴和县', '150900');
INSERT INTO pro_city_area VALUES ('150925', '凉城县', '150900');
INSERT INTO pro_city_area VALUES ('150926', '察哈尔右翼前旗', '150900');
INSERT INTO pro_city_area VALUES ('150927', '察哈尔右翼中旗', '150900');
INSERT INTO pro_city_area VALUES ('150928', '察哈尔右翼后旗', '150900');
INSERT INTO pro_city_area VALUES ('150929', '四子王旗', '150900');
INSERT INTO pro_city_area VALUES ('150981', '丰镇市', '150900');
INSERT INTO pro_city_area VALUES ('152200', '兴安盟', '150000');
INSERT INTO pro_city_area VALUES ('152201', '乌兰浩特市', '152200');
INSERT INTO pro_city_area VALUES ('152202', '阿尔山市', '152200');
INSERT INTO pro_city_area VALUES ('152221', '科尔沁右翼前旗', '152200');
INSERT INTO pro_city_area VALUES ('152222', '科尔沁右翼中旗', '152200');
INSERT INTO pro_city_area VALUES ('152223', '扎赉特旗', '152200');
INSERT INTO pro_city_area VALUES ('152224', '突泉县', '152200');
INSERT INTO pro_city_area VALUES ('152500', '锡林郭勒盟', '150000');
INSERT INTO pro_city_area VALUES ('152501', '二连浩特市', '152500');
INSERT INTO pro_city_area VALUES ('152502', '锡林浩特市', '152500');
INSERT INTO pro_city_area VALUES ('152522', '阿巴嘎旗', '152500');
INSERT INTO pro_city_area VALUES ('152523', '苏尼特左旗', '152500');
INSERT INTO pro_city_area VALUES ('152524', '苏尼特右旗', '152500');
INSERT INTO pro_city_area VALUES ('152525', '东乌珠穆沁旗', '152500');
INSERT INTO pro_city_area VALUES ('152526', '西乌珠穆沁旗', '152500');
INSERT INTO pro_city_area VALUES ('152527', '太仆寺旗', '152500');
INSERT INTO pro_city_area VALUES ('152528', '镶黄旗', '152500');
INSERT INTO pro_city_area VALUES ('152529', '正镶白旗', '152500');
INSERT INTO pro_city_area VALUES ('152530', '正蓝旗', '152500');
INSERT INTO pro_city_area VALUES ('152531', '多伦县', '152500');
INSERT INTO pro_city_area VALUES ('152900', '阿拉善盟', '150000');
INSERT INTO pro_city_area VALUES ('152921', '阿拉善左旗', '152900');
INSERT INTO pro_city_area VALUES ('152922', '阿拉善右旗', '152900');
INSERT INTO pro_city_area VALUES ('152923', '额济纳旗', '152900');
INSERT INTO pro_city_area VALUES ('210000', '辽宁省', '0');
INSERT INTO pro_city_area VALUES ('210100', '沈阳市', '210000');
INSERT INTO pro_city_area VALUES ('210101', '市辖区', '210100');
INSERT INTO pro_city_area VALUES ('210102', '和平区', '210100');
INSERT INTO pro_city_area VALUES ('210103', '沈河区', '210100');
INSERT INTO pro_city_area VALUES ('210104', '大东区', '210100');
INSERT INTO pro_city_area VALUES ('210105', '皇姑区', '210100');
INSERT INTO pro_city_area VALUES ('210106', '铁西区', '210100');
INSERT INTO pro_city_area VALUES ('210111', '苏家屯区', '210100');
INSERT INTO pro_city_area VALUES ('210112', '东陵区', '210100');
INSERT INTO pro_city_area VALUES ('210113', '新城子区', '210100');
INSERT INTO pro_city_area VALUES ('210114', '于洪区', '210100');
INSERT INTO pro_city_area VALUES ('210122', '辽中县', '210100');
INSERT INTO pro_city_area VALUES ('210123', '康平县', '210100');
INSERT INTO pro_city_area VALUES ('210124', '法库县', '210100');
INSERT INTO pro_city_area VALUES ('210181', '新民市', '210100');
INSERT INTO pro_city_area VALUES ('210200', '大连市', '210000');
INSERT INTO pro_city_area VALUES ('210201', '市辖区', '210200');
INSERT INTO pro_city_area VALUES ('210202', '中山区', '210200');
INSERT INTO pro_city_area VALUES ('210203', '西岗区', '210200');
INSERT INTO pro_city_area VALUES ('210204', '沙河口区', '210200');
INSERT INTO pro_city_area VALUES ('210211', '甘井子区', '210200');
INSERT INTO pro_city_area VALUES ('210212', '旅顺口区', '210200');
INSERT INTO pro_city_area VALUES ('210213', '金州区', '210200');
INSERT INTO pro_city_area VALUES ('210224', '长海县', '210200');
INSERT INTO pro_city_area VALUES ('210281', '瓦房店市', '210200');
INSERT INTO pro_city_area VALUES ('210282', '普兰店市', '210200');
INSERT INTO pro_city_area VALUES ('210283', '庄河市', '210200');
INSERT INTO pro_city_area VALUES ('210300', '鞍山市', '210000');
INSERT INTO pro_city_area VALUES ('210301', '市辖区', '210300');
INSERT INTO pro_city_area VALUES ('210302', '铁东区', '210300');
INSERT INTO pro_city_area VALUES ('210303', '铁西区', '210300');
INSERT INTO pro_city_area VALUES ('210304', '立山区', '210300');
INSERT INTO pro_city_area VALUES ('210311', '千山区', '210300');
INSERT INTO pro_city_area VALUES ('210321', '台安县', '210300');
INSERT INTO pro_city_area VALUES ('210323', '岫岩满族自治县', '210300');
INSERT INTO pro_city_area VALUES ('210381', '海城市', '210300');
INSERT INTO pro_city_area VALUES ('210400', '抚顺市', '210000');
INSERT INTO pro_city_area VALUES ('210401', '市辖区', '210400');
INSERT INTO pro_city_area VALUES ('210402', '新抚区', '210400');
INSERT INTO pro_city_area VALUES ('210403', '东洲区', '210400');
INSERT INTO pro_city_area VALUES ('210404', '望花区', '210400');
INSERT INTO pro_city_area VALUES ('210411', '顺城区', '210400');
INSERT INTO pro_city_area VALUES ('210421', '抚顺县', '210400');
INSERT INTO pro_city_area VALUES ('210422', '新宾满族自治县', '210400');
INSERT INTO pro_city_area VALUES ('210423', '清原满族自治县', '210400');
INSERT INTO pro_city_area VALUES ('210500', '本溪市', '210000');
INSERT INTO pro_city_area VALUES ('210501', '市辖区', '210500');
INSERT INTO pro_city_area VALUES ('210502', '平山区', '210500');
INSERT INTO pro_city_area VALUES ('210503', '溪湖区', '210500');
INSERT INTO pro_city_area VALUES ('210504', '明山区', '210500');
INSERT INTO pro_city_area VALUES ('210505', '南芬区', '210500');
INSERT INTO pro_city_area VALUES ('210521', '本溪满族自治县', '210500');
INSERT INTO pro_city_area VALUES ('210522', '桓仁满族自治县', '210500');
INSERT INTO pro_city_area VALUES ('210600', '丹东市', '210000');
INSERT INTO pro_city_area VALUES ('210601', '市辖区', '210600');
INSERT INTO pro_city_area VALUES ('210602', '元宝区', '210600');
INSERT INTO pro_city_area VALUES ('210603', '振兴区', '210600');
INSERT INTO pro_city_area VALUES ('210604', '振安区', '210600');
INSERT INTO pro_city_area VALUES ('210624', '宽甸满族自治县', '210600');
INSERT INTO pro_city_area VALUES ('210681', '东港市', '210600');
INSERT INTO pro_city_area VALUES ('210682', '凤城市', '210600');
INSERT INTO pro_city_area VALUES ('210700', '锦州市', '210000');
INSERT INTO pro_city_area VALUES ('210701', '市辖区', '210700');
INSERT INTO pro_city_area VALUES ('210702', '古塔区', '210700');
INSERT INTO pro_city_area VALUES ('210703', '凌河区', '210700');
INSERT INTO pro_city_area VALUES ('210711', '太和区', '210700');
INSERT INTO pro_city_area VALUES ('210726', '黑山县', '210700');
INSERT INTO pro_city_area VALUES ('210727', '义　县', '210700');
INSERT INTO pro_city_area VALUES ('210781', '凌海市', '210700');
INSERT INTO pro_city_area VALUES ('210782', '北宁市', '210700');
INSERT INTO pro_city_area VALUES ('210800', '营口市', '210000');
INSERT INTO pro_city_area VALUES ('210801', '市辖区', '210800');
INSERT INTO pro_city_area VALUES ('210802', '站前区', '210800');
INSERT INTO pro_city_area VALUES ('210803', '西市区', '210800');
INSERT INTO pro_city_area VALUES ('210804', '鲅鱼圈区', '210800');
INSERT INTO pro_city_area VALUES ('210811', '老边区', '210800');
INSERT INTO pro_city_area VALUES ('210881', '盖州市', '210800');
INSERT INTO pro_city_area VALUES ('210882', '大石桥市', '210800');
INSERT INTO pro_city_area VALUES ('210900', '阜新市', '210000');
INSERT INTO pro_city_area VALUES ('210901', '市辖区', '210900');
INSERT INTO pro_city_area VALUES ('210902', '海州区', '210900');
INSERT INTO pro_city_area VALUES ('210903', '新邱区', '210900');
INSERT INTO pro_city_area VALUES ('210904', '太平区', '210900');
INSERT INTO pro_city_area VALUES ('210905', '清河门区', '210900');
INSERT INTO pro_city_area VALUES ('210911', '细河区', '210900');
INSERT INTO pro_city_area VALUES ('210921', '阜新蒙古族自治县', '210900');
INSERT INTO pro_city_area VALUES ('210922', '彰武县', '210900');
INSERT INTO pro_city_area VALUES ('211000', '辽阳市', '210000');
INSERT INTO pro_city_area VALUES ('211001', '市辖区', '211000');
INSERT INTO pro_city_area VALUES ('211002', '白塔区', '211000');
INSERT INTO pro_city_area VALUES ('211003', '文圣区', '211000');
INSERT INTO pro_city_area VALUES ('211004', '宏伟区', '211000');
INSERT INTO pro_city_area VALUES ('211005', '弓长岭区', '211000');
INSERT INTO pro_city_area VALUES ('211011', '太子河区', '211000');
INSERT INTO pro_city_area VALUES ('211021', '辽阳县', '211000');
INSERT INTO pro_city_area VALUES ('211081', '灯塔市', '211000');
INSERT INTO pro_city_area VALUES ('211100', '盘锦市', '210000');
INSERT INTO pro_city_area VALUES ('211101', '市辖区', '211100');
INSERT INTO pro_city_area VALUES ('211102', '双台子区', '211100');
INSERT INTO pro_city_area VALUES ('211103', '兴隆台区', '211100');
INSERT INTO pro_city_area VALUES ('211121', '大洼县', '211100');
INSERT INTO pro_city_area VALUES ('211122', '盘山县', '211100');
INSERT INTO pro_city_area VALUES ('211200', '铁岭市', '210000');
INSERT INTO pro_city_area VALUES ('211201', '市辖区', '211200');
INSERT INTO pro_city_area VALUES ('211202', '银州区', '211200');
INSERT INTO pro_city_area VALUES ('211204', '清河区', '211200');
INSERT INTO pro_city_area VALUES ('211221', '铁岭县', '211200');
INSERT INTO pro_city_area VALUES ('211223', '西丰县', '211200');
INSERT INTO pro_city_area VALUES ('211224', '昌图县', '211200');
INSERT INTO pro_city_area VALUES ('211281', '调兵山市', '211200');
INSERT INTO pro_city_area VALUES ('211282', '开原市', '211200');
INSERT INTO pro_city_area VALUES ('211300', '朝阳市', '210000');
INSERT INTO pro_city_area VALUES ('211301', '市辖区', '211300');
INSERT INTO pro_city_area VALUES ('211302', '双塔区', '211300');
INSERT INTO pro_city_area VALUES ('211303', '龙城区', '211300');
INSERT INTO pro_city_area VALUES ('211321', '朝阳县', '211300');
INSERT INTO pro_city_area VALUES ('211322', '建平县', '211300');
INSERT INTO pro_city_area VALUES ('211324', '喀喇沁左翼蒙古族自治县', '211300');
INSERT INTO pro_city_area VALUES ('211381', '北票市', '211300');
INSERT INTO pro_city_area VALUES ('211382', '凌源市', '211300');
INSERT INTO pro_city_area VALUES ('211400', '葫芦岛市', '210000');
INSERT INTO pro_city_area VALUES ('211401', '市辖区', '211400');
INSERT INTO pro_city_area VALUES ('211402', '连山区', '211400');
INSERT INTO pro_city_area VALUES ('211403', '龙港区', '211400');
INSERT INTO pro_city_area VALUES ('211404', '南票区', '211400');
INSERT INTO pro_city_area VALUES ('211421', '绥中县', '211400');
INSERT INTO pro_city_area VALUES ('211422', '建昌县', '211400');
INSERT INTO pro_city_area VALUES ('211481', '兴城市', '211400');
INSERT INTO pro_city_area VALUES ('220000', '吉林省', '0');
INSERT INTO pro_city_area VALUES ('220100', '长春市', '220000');
INSERT INTO pro_city_area VALUES ('220101', '市辖区', '220100');
INSERT INTO pro_city_area VALUES ('220102', '南关区', '220100');
INSERT INTO pro_city_area VALUES ('220103', '宽城区', '220100');
INSERT INTO pro_city_area VALUES ('220104', '朝阳区', '220100');
INSERT INTO pro_city_area VALUES ('220105', '二道区', '220100');
INSERT INTO pro_city_area VALUES ('220106', '绿园区', '220100');
INSERT INTO pro_city_area VALUES ('220112', '双阳区', '220100');
INSERT INTO pro_city_area VALUES ('220122', '农安县', '220100');
INSERT INTO pro_city_area VALUES ('220181', '九台市', '220100');
INSERT INTO pro_city_area VALUES ('220182', '榆树市', '220100');
INSERT INTO pro_city_area VALUES ('220183', '德惠市', '220100');
INSERT INTO pro_city_area VALUES ('220200', '吉林市', '220000');
INSERT INTO pro_city_area VALUES ('220201', '市辖区', '220200');
INSERT INTO pro_city_area VALUES ('220202', '昌邑区', '220200');
INSERT INTO pro_city_area VALUES ('220203', '龙潭区', '220200');
INSERT INTO pro_city_area VALUES ('220204', '船营区', '220200');
INSERT INTO pro_city_area VALUES ('220211', '丰满区', '220200');
INSERT INTO pro_city_area VALUES ('220221', '永吉县', '220200');
INSERT INTO pro_city_area VALUES ('220281', '蛟河市', '220200');
INSERT INTO pro_city_area VALUES ('220282', '桦甸市', '220200');
INSERT INTO pro_city_area VALUES ('220283', '舒兰市', '220200');
INSERT INTO pro_city_area VALUES ('220284', '磐石市', '220200');
INSERT INTO pro_city_area VALUES ('220300', '四平市', '220000');
INSERT INTO pro_city_area VALUES ('220301', '市辖区', '220300');
INSERT INTO pro_city_area VALUES ('220302', '铁西区', '220300');
INSERT INTO pro_city_area VALUES ('220303', '铁东区', '220300');
INSERT INTO pro_city_area VALUES ('220322', '梨树县', '220300');
INSERT INTO pro_city_area VALUES ('220323', '伊通满族自治县', '220300');
INSERT INTO pro_city_area VALUES ('220381', '公主岭市', '220300');
INSERT INTO pro_city_area VALUES ('220382', '双辽市', '220300');
INSERT INTO pro_city_area VALUES ('220400', '辽源市', '220000');
INSERT INTO pro_city_area VALUES ('220401', '市辖区', '220400');
INSERT INTO pro_city_area VALUES ('220402', '龙山区', '220400');
INSERT INTO pro_city_area VALUES ('220403', '西安区', '220400');
INSERT INTO pro_city_area VALUES ('220421', '东丰县', '220400');
INSERT INTO pro_city_area VALUES ('220422', '东辽县', '220400');
INSERT INTO pro_city_area VALUES ('220500', '通化市', '220000');
INSERT INTO pro_city_area VALUES ('220501', '市辖区', '220500');
INSERT INTO pro_city_area VALUES ('220502', '东昌区', '220500');
INSERT INTO pro_city_area VALUES ('220503', '二道江区', '220500');
INSERT INTO pro_city_area VALUES ('220521', '通化县', '220500');
INSERT INTO pro_city_area VALUES ('220523', '辉南县', '220500');
INSERT INTO pro_city_area VALUES ('220524', '柳河县', '220500');
INSERT INTO pro_city_area VALUES ('220581', '梅河口市', '220500');
INSERT INTO pro_city_area VALUES ('220582', '集安市', '220500');
INSERT INTO pro_city_area VALUES ('220600', '白山市', '220000');
INSERT INTO pro_city_area VALUES ('220601', '市辖区', '220600');
INSERT INTO pro_city_area VALUES ('220602', '八道江区', '220600');
INSERT INTO pro_city_area VALUES ('220621', '抚松县', '220600');
INSERT INTO pro_city_area VALUES ('220622', '靖宇县', '220600');
INSERT INTO pro_city_area VALUES ('220623', '长白朝鲜族自治县', '220600');
INSERT INTO pro_city_area VALUES ('220625', '江源县', '220600');
INSERT INTO pro_city_area VALUES ('220681', '临江市', '220600');
INSERT INTO pro_city_area VALUES ('220700', '松原市', '220000');
INSERT INTO pro_city_area VALUES ('220701', '市辖区', '220700');
INSERT INTO pro_city_area VALUES ('220702', '宁江区', '220700');
INSERT INTO pro_city_area VALUES ('220721', '前郭尔罗斯蒙古族自治县', '220700');
INSERT INTO pro_city_area VALUES ('220722', '长岭县', '220700');
INSERT INTO pro_city_area VALUES ('220723', '乾安县', '220700');
INSERT INTO pro_city_area VALUES ('220724', '扶余县', '220700');
INSERT INTO pro_city_area VALUES ('220800', '白城市', '220000');
INSERT INTO pro_city_area VALUES ('220801', '市辖区', '220800');
INSERT INTO pro_city_area VALUES ('220802', '洮北区', '220800');
INSERT INTO pro_city_area VALUES ('220821', '镇赉县', '220800');
INSERT INTO pro_city_area VALUES ('220822', '通榆县', '220800');
INSERT INTO pro_city_area VALUES ('220881', '洮南市', '220800');
INSERT INTO pro_city_area VALUES ('220882', '大安市', '220800');
INSERT INTO pro_city_area VALUES ('222400', '延边朝鲜族自治州', '220000');
INSERT INTO pro_city_area VALUES ('222401', '延吉市', '222400');
INSERT INTO pro_city_area VALUES ('222402', '图们市', '222400');
INSERT INTO pro_city_area VALUES ('222403', '敦化市', '222400');
INSERT INTO pro_city_area VALUES ('222404', '珲春市', '222400');
INSERT INTO pro_city_area VALUES ('222405', '龙井市', '222400');
INSERT INTO pro_city_area VALUES ('222406', '和龙市', '222400');
INSERT INTO pro_city_area VALUES ('222424', '汪清县', '222400');
INSERT INTO pro_city_area VALUES ('222426', '安图县', '222400');
INSERT INTO pro_city_area VALUES ('230000', '黑龙江', '0');
INSERT INTO pro_city_area VALUES ('230100', '哈尔滨市', '230000');
INSERT INTO pro_city_area VALUES ('230101', '市辖区', '230100');
INSERT INTO pro_city_area VALUES ('230102', '道里区', '230100');
INSERT INTO pro_city_area VALUES ('230103', '南岗区', '230100');
INSERT INTO pro_city_area VALUES ('230104', '道外区', '230100');
INSERT INTO pro_city_area VALUES ('230106', '香坊区', '230100');
INSERT INTO pro_city_area VALUES ('230107', '动力区', '230100');
INSERT INTO pro_city_area VALUES ('230108', '平房区', '230100');
INSERT INTO pro_city_area VALUES ('230109', '松北区', '230100');
INSERT INTO pro_city_area VALUES ('230111', '呼兰区', '230100');
INSERT INTO pro_city_area VALUES ('230123', '依兰县', '230100');
INSERT INTO pro_city_area VALUES ('230124', '方正县', '230100');
INSERT INTO pro_city_area VALUES ('230125', '宾　县', '230100');
INSERT INTO pro_city_area VALUES ('230126', '巴彦县', '230100');
INSERT INTO pro_city_area VALUES ('230127', '木兰县', '230100');
INSERT INTO pro_city_area VALUES ('230128', '通河县', '230100');
INSERT INTO pro_city_area VALUES ('230129', '延寿县', '230100');
INSERT INTO pro_city_area VALUES ('230181', '阿城市', '230100');
INSERT INTO pro_city_area VALUES ('230182', '双城市', '230100');
INSERT INTO pro_city_area VALUES ('230183', '尚志市', '230100');
INSERT INTO pro_city_area VALUES ('230184', '五常市', '230100');
INSERT INTO pro_city_area VALUES ('230200', '齐齐哈尔市', '230000');
INSERT INTO pro_city_area VALUES ('230201', '市辖区', '230200');
INSERT INTO pro_city_area VALUES ('230202', '龙沙区', '230200');
INSERT INTO pro_city_area VALUES ('230203', '建华区', '230200');
INSERT INTO pro_city_area VALUES ('230204', '铁锋区', '230200');
INSERT INTO pro_city_area VALUES ('230205', '昂昂溪区', '230200');
INSERT INTO pro_city_area VALUES ('230206', '富拉尔基区', '230200');
INSERT INTO pro_city_area VALUES ('230207', '碾子山区', '230200');
INSERT INTO pro_city_area VALUES ('230208', '梅里斯达斡尔族区', '230200');
INSERT INTO pro_city_area VALUES ('230221', '龙江县', '230200');
INSERT INTO pro_city_area VALUES ('230223', '依安县', '230200');
INSERT INTO pro_city_area VALUES ('230224', '泰来县', '230200');
INSERT INTO pro_city_area VALUES ('230225', '甘南县', '230200');
INSERT INTO pro_city_area VALUES ('230227', '富裕县', '230200');
INSERT INTO pro_city_area VALUES ('230229', '克山县', '230200');
INSERT INTO pro_city_area VALUES ('230230', '克东县', '230200');
INSERT INTO pro_city_area VALUES ('230231', '拜泉县', '230200');
INSERT INTO pro_city_area VALUES ('230281', '讷河市', '230200');
INSERT INTO pro_city_area VALUES ('230300', '鸡西市', '230000');
INSERT INTO pro_city_area VALUES ('230301', '市辖区', '230300');
INSERT INTO pro_city_area VALUES ('230302', '鸡冠区', '230300');
INSERT INTO pro_city_area VALUES ('230303', '恒山区', '230300');
INSERT INTO pro_city_area VALUES ('230304', '滴道区', '230300');
INSERT INTO pro_city_area VALUES ('230305', '梨树区', '230300');
INSERT INTO pro_city_area VALUES ('230306', '城子河区', '230300');
INSERT INTO pro_city_area VALUES ('230307', '麻山区', '230300');
INSERT INTO pro_city_area VALUES ('230321', '鸡东县', '230300');
INSERT INTO pro_city_area VALUES ('230381', '虎林市', '230300');
INSERT INTO pro_city_area VALUES ('230382', '密山市', '230300');
INSERT INTO pro_city_area VALUES ('230400', '鹤岗市', '230000');
INSERT INTO pro_city_area VALUES ('230401', '市辖区', '230400');
INSERT INTO pro_city_area VALUES ('230402', '向阳区', '230400');
INSERT INTO pro_city_area VALUES ('230403', '工农区', '230400');
INSERT INTO pro_city_area VALUES ('230404', '南山区', '230400');
INSERT INTO pro_city_area VALUES ('230405', '兴安区', '230400');
INSERT INTO pro_city_area VALUES ('230406', '东山区', '230400');
INSERT INTO pro_city_area VALUES ('230407', '兴山区', '230400');
INSERT INTO pro_city_area VALUES ('230421', '萝北县', '230400');
INSERT INTO pro_city_area VALUES ('230422', '绥滨县', '230400');
INSERT INTO pro_city_area VALUES ('230500', '双鸭山市', '230000');
INSERT INTO pro_city_area VALUES ('230501', '市辖区', '230500');
INSERT INTO pro_city_area VALUES ('230502', '尖山区', '230500');
INSERT INTO pro_city_area VALUES ('230503', '岭东区', '230500');
INSERT INTO pro_city_area VALUES ('230505', '四方台区', '230500');
INSERT INTO pro_city_area VALUES ('230506', '宝山区', '230500');
INSERT INTO pro_city_area VALUES ('230521', '集贤县', '230500');
INSERT INTO pro_city_area VALUES ('230522', '友谊县', '230500');
INSERT INTO pro_city_area VALUES ('230523', '宝清县', '230500');
INSERT INTO pro_city_area VALUES ('230524', '饶河县', '230500');
INSERT INTO pro_city_area VALUES ('230600', '大庆市', '230000');
INSERT INTO pro_city_area VALUES ('230601', '市辖区', '230600');
INSERT INTO pro_city_area VALUES ('230602', '萨尔图区', '230600');
INSERT INTO pro_city_area VALUES ('230603', '龙凤区', '230600');
INSERT INTO pro_city_area VALUES ('230604', '让胡路区', '230600');
INSERT INTO pro_city_area VALUES ('230605', '红岗区', '230600');
INSERT INTO pro_city_area VALUES ('230606', '大同区', '230600');
INSERT INTO pro_city_area VALUES ('230621', '肇州县', '230600');
INSERT INTO pro_city_area VALUES ('230622', '肇源县', '230600');
INSERT INTO pro_city_area VALUES ('230623', '林甸县', '230600');
INSERT INTO pro_city_area VALUES ('230624', '杜尔伯特蒙古族自治县', '230600');
INSERT INTO pro_city_area VALUES ('230700', '伊春市', '230000');
INSERT INTO pro_city_area VALUES ('230701', '市辖区', '230700');
INSERT INTO pro_city_area VALUES ('230702', '伊春区', '230700');
INSERT INTO pro_city_area VALUES ('230703', '南岔区', '230700');
INSERT INTO pro_city_area VALUES ('230704', '友好区', '230700');
INSERT INTO pro_city_area VALUES ('230705', '西林区', '230700');
INSERT INTO pro_city_area VALUES ('230706', '翠峦区', '230700');
INSERT INTO pro_city_area VALUES ('230707', '新青区', '230700');
INSERT INTO pro_city_area VALUES ('230708', '美溪区', '230700');
INSERT INTO pro_city_area VALUES ('230709', '金山屯区', '230700');
INSERT INTO pro_city_area VALUES ('230710', '五营区', '230700');
INSERT INTO pro_city_area VALUES ('230711', '乌马河区', '230700');
INSERT INTO pro_city_area VALUES ('230712', '汤旺河区', '230700');
INSERT INTO pro_city_area VALUES ('230713', '带岭区', '230700');
INSERT INTO pro_city_area VALUES ('230714', '乌伊岭区', '230700');
INSERT INTO pro_city_area VALUES ('230715', '红星区', '230700');
INSERT INTO pro_city_area VALUES ('230716', '上甘岭区', '230700');
INSERT INTO pro_city_area VALUES ('230722', '嘉荫县', '230700');
INSERT INTO pro_city_area VALUES ('230781', '铁力市', '230700');
INSERT INTO pro_city_area VALUES ('230800', '佳木斯市', '230000');
INSERT INTO pro_city_area VALUES ('230801', '市辖区', '230800');
INSERT INTO pro_city_area VALUES ('230802', '永红区', '230800');
INSERT INTO pro_city_area VALUES ('230803', '向阳区', '230800');
INSERT INTO pro_city_area VALUES ('230804', '前进区', '230800');
INSERT INTO pro_city_area VALUES ('230805', '东风区', '230800');
INSERT INTO pro_city_area VALUES ('230811', '郊　区', '230800');
INSERT INTO pro_city_area VALUES ('230822', '桦南县', '230800');
INSERT INTO pro_city_area VALUES ('230826', '桦川县', '230800');
INSERT INTO pro_city_area VALUES ('230828', '汤原县', '230800');
INSERT INTO pro_city_area VALUES ('230833', '抚远县', '230800');
INSERT INTO pro_city_area VALUES ('230881', '同江市', '230800');
INSERT INTO pro_city_area VALUES ('230882', '富锦市', '230800');
INSERT INTO pro_city_area VALUES ('230900', '七台河市', '230000');
INSERT INTO pro_city_area VALUES ('230901', '市辖区', '230900');
INSERT INTO pro_city_area VALUES ('230902', '新兴区', '230900');
INSERT INTO pro_city_area VALUES ('230903', '桃山区', '230900');
INSERT INTO pro_city_area VALUES ('230904', '茄子河区', '230900');
INSERT INTO pro_city_area VALUES ('230921', '勃利县', '230900');
INSERT INTO pro_city_area VALUES ('231000', '牡丹江市', '230000');
INSERT INTO pro_city_area VALUES ('231001', '市辖区', '231000');
INSERT INTO pro_city_area VALUES ('231002', '东安区', '231000');
INSERT INTO pro_city_area VALUES ('231003', '阳明区', '231000');
INSERT INTO pro_city_area VALUES ('231004', '爱民区', '231000');
INSERT INTO pro_city_area VALUES ('231005', '西安区', '231000');
INSERT INTO pro_city_area VALUES ('231024', '东宁县', '231000');
INSERT INTO pro_city_area VALUES ('231025', '林口县', '231000');
INSERT INTO pro_city_area VALUES ('231081', '绥芬河市', '231000');
INSERT INTO pro_city_area VALUES ('231083', '海林市', '231000');
INSERT INTO pro_city_area VALUES ('231084', '宁安市', '231000');
INSERT INTO pro_city_area VALUES ('231085', '穆棱市', '231000');
INSERT INTO pro_city_area VALUES ('231100', '黑河市', '230000');
INSERT INTO pro_city_area VALUES ('231101', '市辖区', '231100');
INSERT INTO pro_city_area VALUES ('231102', '爱辉区', '231100');
INSERT INTO pro_city_area VALUES ('231121', '嫩江县', '231100');
INSERT INTO pro_city_area VALUES ('231123', '逊克县', '231100');
INSERT INTO pro_city_area VALUES ('231124', '孙吴县', '231100');
INSERT INTO pro_city_area VALUES ('231181', '北安市', '231100');
INSERT INTO pro_city_area VALUES ('231182', '五大连池市', '231100');
INSERT INTO pro_city_area VALUES ('231200', '绥化市', '230000');
INSERT INTO pro_city_area VALUES ('231201', '市辖区', '231200');
INSERT INTO pro_city_area VALUES ('231202', '北林区', '231200');
INSERT INTO pro_city_area VALUES ('231221', '望奎县', '231200');
INSERT INTO pro_city_area VALUES ('231222', '兰西县', '231200');
INSERT INTO pro_city_area VALUES ('231223', '青冈县', '231200');
INSERT INTO pro_city_area VALUES ('231224', '庆安县', '231200');
INSERT INTO pro_city_area VALUES ('231225', '明水县', '231200');
INSERT INTO pro_city_area VALUES ('231226', '绥棱县', '231200');
INSERT INTO pro_city_area VALUES ('231281', '安达市', '231200');
INSERT INTO pro_city_area VALUES ('231282', '肇东市', '231200');
INSERT INTO pro_city_area VALUES ('231283', '海伦市', '231200');
INSERT INTO pro_city_area VALUES ('232700', '大兴安岭地区', '230000');
INSERT INTO pro_city_area VALUES ('232721', '呼玛县', '232700');
INSERT INTO pro_city_area VALUES ('232722', '塔河县', '232700');
INSERT INTO pro_city_area VALUES ('232723', '漠河县', '232700');
INSERT INTO pro_city_area VALUES ('310000', '上海市', '0');
INSERT INTO pro_city_area VALUES ('310100', '市辖区', '310000');
INSERT INTO pro_city_area VALUES ('310101', '黄浦区', '310100');
INSERT INTO pro_city_area VALUES ('310103', '卢湾区', '310100');
INSERT INTO pro_city_area VALUES ('310104', '徐汇区', '310100');
INSERT INTO pro_city_area VALUES ('310105', '长宁区', '310100');
INSERT INTO pro_city_area VALUES ('310106', '静安区', '310100');
INSERT INTO pro_city_area VALUES ('310107', '普陀区', '310100');
INSERT INTO pro_city_area VALUES ('310108', '闸北区', '310100');
INSERT INTO pro_city_area VALUES ('310109', '虹口区', '310100');
INSERT INTO pro_city_area VALUES ('310110', '杨浦区', '310100');
INSERT INTO pro_city_area VALUES ('310112', '闵行区', '310100');
INSERT INTO pro_city_area VALUES ('310113', '宝山区', '310100');
INSERT INTO pro_city_area VALUES ('310114', '嘉定区', '310100');
INSERT INTO pro_city_area VALUES ('310115', '浦东新区', '310100');
INSERT INTO pro_city_area VALUES ('310116', '金山区', '310100');
INSERT INTO pro_city_area VALUES ('310117', '松江区', '310100');
INSERT INTO pro_city_area VALUES ('310118', '青浦区', '310100');
INSERT INTO pro_city_area VALUES ('310119', '南汇区', '310100');
INSERT INTO pro_city_area VALUES ('310120', '奉贤区', '310100');
INSERT INTO pro_city_area VALUES ('310200', '县', '310000');
INSERT INTO pro_city_area VALUES ('310230', '崇明县', '310200');
INSERT INTO pro_city_area VALUES ('320000', '江苏省', '0');
INSERT INTO pro_city_area VALUES ('320100', '南京市', '320000');
INSERT INTO pro_city_area VALUES ('320101', '市辖区', '320100');
INSERT INTO pro_city_area VALUES ('320102', '玄武区', '320100');
INSERT INTO pro_city_area VALUES ('320103', '白下区', '320100');
INSERT INTO pro_city_area VALUES ('320104', '秦淮区', '320100');
INSERT INTO pro_city_area VALUES ('320105', '建邺区', '320100');
INSERT INTO pro_city_area VALUES ('320106', '鼓楼区', '320100');
INSERT INTO pro_city_area VALUES ('320107', '下关区', '320100');
INSERT INTO pro_city_area VALUES ('320111', '浦口区', '320100');
INSERT INTO pro_city_area VALUES ('320113', '栖霞区', '320100');
INSERT INTO pro_city_area VALUES ('320114', '雨花台区', '320100');
INSERT INTO pro_city_area VALUES ('320115', '江宁区', '320100');
INSERT INTO pro_city_area VALUES ('320116', '六合区', '320100');
INSERT INTO pro_city_area VALUES ('320124', '溧水县', '320100');
INSERT INTO pro_city_area VALUES ('320125', '高淳县', '320100');
INSERT INTO pro_city_area VALUES ('320200', '无锡市', '320000');
INSERT INTO pro_city_area VALUES ('320201', '市辖区', '320200');
INSERT INTO pro_city_area VALUES ('320202', '崇安区', '320200');
INSERT INTO pro_city_area VALUES ('320203', '南长区', '320200');
INSERT INTO pro_city_area VALUES ('320204', '北塘区', '320200');
INSERT INTO pro_city_area VALUES ('320205', '锡山区', '320200');
INSERT INTO pro_city_area VALUES ('320206', '惠山区', '320200');
INSERT INTO pro_city_area VALUES ('320211', '滨湖区', '320200');
INSERT INTO pro_city_area VALUES ('320281', '江阴市', '320200');
INSERT INTO pro_city_area VALUES ('320282', '宜兴市', '320200');
INSERT INTO pro_city_area VALUES ('320300', '徐州市', '320000');
INSERT INTO pro_city_area VALUES ('320301', '市辖区', '320300');
INSERT INTO pro_city_area VALUES ('320302', '鼓楼区', '320300');
INSERT INTO pro_city_area VALUES ('320303', '云龙区', '320300');
INSERT INTO pro_city_area VALUES ('320304', '九里区', '320300');
INSERT INTO pro_city_area VALUES ('320305', '贾汪区', '320300');
INSERT INTO pro_city_area VALUES ('320311', '泉山区', '320300');
INSERT INTO pro_city_area VALUES ('320321', '丰　县', '320300');
INSERT INTO pro_city_area VALUES ('320322', '沛　县', '320300');
INSERT INTO pro_city_area VALUES ('320323', '铜山县', '320300');
INSERT INTO pro_city_area VALUES ('320324', '睢宁县', '320300');
INSERT INTO pro_city_area VALUES ('320381', '新沂市', '320300');
INSERT INTO pro_city_area VALUES ('320382', '邳州市', '320300');
INSERT INTO pro_city_area VALUES ('320400', '常州市', '320000');
INSERT INTO pro_city_area VALUES ('320401', '市辖区', '320400');
INSERT INTO pro_city_area VALUES ('320402', '天宁区', '320400');
INSERT INTO pro_city_area VALUES ('320404', '钟楼区', '320400');
INSERT INTO pro_city_area VALUES ('320405', '戚墅堰区', '320400');
INSERT INTO pro_city_area VALUES ('320411', '新北区', '320400');
INSERT INTO pro_city_area VALUES ('320412', '武进区', '320400');
INSERT INTO pro_city_area VALUES ('320481', '溧阳市', '320400');
INSERT INTO pro_city_area VALUES ('320482', '金坛市', '320400');
INSERT INTO pro_city_area VALUES ('320500', '苏州市', '320000');
INSERT INTO pro_city_area VALUES ('320501', '市辖区', '320500');
INSERT INTO pro_city_area VALUES ('320502', '沧浪区', '320500');
INSERT INTO pro_city_area VALUES ('320503', '平江区', '320500');
INSERT INTO pro_city_area VALUES ('320504', '金阊区', '320500');
INSERT INTO pro_city_area VALUES ('320505', '虎丘区', '320500');
INSERT INTO pro_city_area VALUES ('320506', '吴中区', '320500');
INSERT INTO pro_city_area VALUES ('320507', '相城区', '320500');
INSERT INTO pro_city_area VALUES ('320581', '常熟市', '320500');
INSERT INTO pro_city_area VALUES ('320582', '张家港市', '320500');
INSERT INTO pro_city_area VALUES ('320583', '昆山市', '320500');
INSERT INTO pro_city_area VALUES ('320584', '吴江市', '320500');
INSERT INTO pro_city_area VALUES ('320585', '太仓市', '320500');
INSERT INTO pro_city_area VALUES ('320600', '南通市', '320000');
INSERT INTO pro_city_area VALUES ('320601', '市辖区', '320600');
INSERT INTO pro_city_area VALUES ('320602', '崇川区', '320600');
INSERT INTO pro_city_area VALUES ('320611', '港闸区', '320600');
INSERT INTO pro_city_area VALUES ('320621', '海安县', '320600');
INSERT INTO pro_city_area VALUES ('320623', '如东县', '320600');
INSERT INTO pro_city_area VALUES ('320681', '启东市', '320600');
INSERT INTO pro_city_area VALUES ('320682', '如皋市', '320600');
INSERT INTO pro_city_area VALUES ('320683', '通州市', '320600');
INSERT INTO pro_city_area VALUES ('320684', '海门市', '320600');
INSERT INTO pro_city_area VALUES ('320700', '连云港市', '320000');
INSERT INTO pro_city_area VALUES ('320701', '市辖区', '320700');
INSERT INTO pro_city_area VALUES ('320703', '连云区', '320700');
INSERT INTO pro_city_area VALUES ('320705', '新浦区', '320700');
INSERT INTO pro_city_area VALUES ('320706', '海州区', '320700');
INSERT INTO pro_city_area VALUES ('320721', '赣榆县', '320700');
INSERT INTO pro_city_area VALUES ('320722', '东海县', '320700');
INSERT INTO pro_city_area VALUES ('320723', '灌云县', '320700');
INSERT INTO pro_city_area VALUES ('320724', '灌南县', '320700');
INSERT INTO pro_city_area VALUES ('320800', '淮安市', '320000');
INSERT INTO pro_city_area VALUES ('320801', '市辖区', '320800');
INSERT INTO pro_city_area VALUES ('320802', '清河区', '320800');
INSERT INTO pro_city_area VALUES ('320803', '楚州区', '320800');
INSERT INTO pro_city_area VALUES ('320804', '淮阴区', '320800');
INSERT INTO pro_city_area VALUES ('320811', '清浦区', '320800');
INSERT INTO pro_city_area VALUES ('320826', '涟水县', '320800');
INSERT INTO pro_city_area VALUES ('320829', '洪泽县', '320800');
INSERT INTO pro_city_area VALUES ('320830', '盱眙县', '320800');
INSERT INTO pro_city_area VALUES ('320831', '金湖县', '320800');
INSERT INTO pro_city_area VALUES ('320900', '盐城市', '320000');
INSERT INTO pro_city_area VALUES ('320901', '市辖区', '320900');
INSERT INTO pro_city_area VALUES ('320902', '亭湖区', '320900');
INSERT INTO pro_city_area VALUES ('320903', '盐都区', '320900');
INSERT INTO pro_city_area VALUES ('320921', '响水县', '320900');
INSERT INTO pro_city_area VALUES ('320922', '滨海县', '320900');
INSERT INTO pro_city_area VALUES ('320923', '阜宁县', '320900');
INSERT INTO pro_city_area VALUES ('320924', '射阳县', '320900');
INSERT INTO pro_city_area VALUES ('320925', '建湖县', '320900');
INSERT INTO pro_city_area VALUES ('320981', '东台市', '320900');
INSERT INTO pro_city_area VALUES ('320982', '大丰市', '320900');
INSERT INTO pro_city_area VALUES ('321000', '扬州市', '320000');
INSERT INTO pro_city_area VALUES ('321001', '市辖区', '321000');
INSERT INTO pro_city_area VALUES ('321002', '广陵区', '321000');
INSERT INTO pro_city_area VALUES ('321003', '邗江区', '321000');
INSERT INTO pro_city_area VALUES ('321011', '郊　区', '321000');
INSERT INTO pro_city_area VALUES ('321023', '宝应县', '321000');
INSERT INTO pro_city_area VALUES ('321081', '仪征市', '321000');
INSERT INTO pro_city_area VALUES ('321084', '高邮市', '321000');
INSERT INTO pro_city_area VALUES ('321088', '江都市', '321000');
INSERT INTO pro_city_area VALUES ('321100', '镇江市', '320000');
INSERT INTO pro_city_area VALUES ('321101', '市辖区', '321100');
INSERT INTO pro_city_area VALUES ('321102', '京口区', '321100');
INSERT INTO pro_city_area VALUES ('321111', '润州区', '321100');
INSERT INTO pro_city_area VALUES ('321112', '丹徒区', '321100');
INSERT INTO pro_city_area VALUES ('321181', '丹阳市', '321100');
INSERT INTO pro_city_area VALUES ('321182', '扬中市', '321100');
INSERT INTO pro_city_area VALUES ('321183', '句容市', '321100');
INSERT INTO pro_city_area VALUES ('321200', '泰州市', '320000');
INSERT INTO pro_city_area VALUES ('321201', '市辖区', '321200');
INSERT INTO pro_city_area VALUES ('321202', '海陵区', '321200');
INSERT INTO pro_city_area VALUES ('321203', '高港区', '321200');
INSERT INTO pro_city_area VALUES ('321281', '兴化市', '321200');
INSERT INTO pro_city_area VALUES ('321282', '靖江市', '321200');
INSERT INTO pro_city_area VALUES ('321283', '泰兴市', '321200');
INSERT INTO pro_city_area VALUES ('321284', '姜堰市', '321200');
INSERT INTO pro_city_area VALUES ('321300', '宿迁市', '320000');
INSERT INTO pro_city_area VALUES ('321301', '市辖区', '321300');
INSERT INTO pro_city_area VALUES ('321302', '宿城区', '321300');
INSERT INTO pro_city_area VALUES ('321311', '宿豫区', '321300');
INSERT INTO pro_city_area VALUES ('321322', '沭阳县', '321300');
INSERT INTO pro_city_area VALUES ('321323', '泗阳县', '321300');
INSERT INTO pro_city_area VALUES ('321324', '泗洪县', '321300');
INSERT INTO pro_city_area VALUES ('330000', '浙江省', '0');
INSERT INTO pro_city_area VALUES ('330100', '杭州市', '330000');
INSERT INTO pro_city_area VALUES ('330101', '市辖区', '330100');
INSERT INTO pro_city_area VALUES ('330102', '上城区', '330100');
INSERT INTO pro_city_area VALUES ('330103', '下城区', '330100');
INSERT INTO pro_city_area VALUES ('330104', '江干区', '330100');
INSERT INTO pro_city_area VALUES ('330105', '拱墅区', '330100');
INSERT INTO pro_city_area VALUES ('330106', '西湖区', '330100');
INSERT INTO pro_city_area VALUES ('330108', '滨江区', '330100');
INSERT INTO pro_city_area VALUES ('330109', '萧山区', '330100');
INSERT INTO pro_city_area VALUES ('330110', '余杭区', '330100');
INSERT INTO pro_city_area VALUES ('330122', '桐庐县', '330100');
INSERT INTO pro_city_area VALUES ('330127', '淳安县', '330100');
INSERT INTO pro_city_area VALUES ('330182', '建德市', '330100');
INSERT INTO pro_city_area VALUES ('330183', '富阳市', '330100');
INSERT INTO pro_city_area VALUES ('330185', '临安市', '330100');
INSERT INTO pro_city_area VALUES ('330200', '宁波市', '330000');
INSERT INTO pro_city_area VALUES ('330201', '市辖区', '330200');
INSERT INTO pro_city_area VALUES ('330203', '海曙区', '330200');
INSERT INTO pro_city_area VALUES ('330204', '江东区', '330200');
INSERT INTO pro_city_area VALUES ('330205', '江北区', '330200');
INSERT INTO pro_city_area VALUES ('330206', '北仑区', '330200');
INSERT INTO pro_city_area VALUES ('330211', '镇海区', '330200');
INSERT INTO pro_city_area VALUES ('330212', '鄞州区', '330200');
INSERT INTO pro_city_area VALUES ('330225', '象山县', '330200');
INSERT INTO pro_city_area VALUES ('330226', '宁海县', '330200');
INSERT INTO pro_city_area VALUES ('330281', '余姚市', '330200');
INSERT INTO pro_city_area VALUES ('330282', '慈溪市', '330200');
INSERT INTO pro_city_area VALUES ('330283', '奉化市', '330200');
INSERT INTO pro_city_area VALUES ('330300', '温州市', '330000');
INSERT INTO pro_city_area VALUES ('330301', '市辖区', '330300');
INSERT INTO pro_city_area VALUES ('330302', '鹿城区', '330300');
INSERT INTO pro_city_area VALUES ('330303', '龙湾区', '330300');
INSERT INTO pro_city_area VALUES ('330304', '瓯海区', '330300');
INSERT INTO pro_city_area VALUES ('330322', '洞头县', '330300');
INSERT INTO pro_city_area VALUES ('330324', '永嘉县', '330300');
INSERT INTO pro_city_area VALUES ('330326', '平阳县', '330300');
INSERT INTO pro_city_area VALUES ('330327', '苍南县', '330300');
INSERT INTO pro_city_area VALUES ('330328', '文成县', '330300');
INSERT INTO pro_city_area VALUES ('330329', '泰顺县', '330300');
INSERT INTO pro_city_area VALUES ('330381', '瑞安市', '330300');
INSERT INTO pro_city_area VALUES ('330382', '乐清市', '330300');
INSERT INTO pro_city_area VALUES ('330400', '嘉兴市', '330000');
INSERT INTO pro_city_area VALUES ('330401', '市辖区', '330400');
INSERT INTO pro_city_area VALUES ('330402', '秀城区', '330400');
INSERT INTO pro_city_area VALUES ('330411', '秀洲区', '330400');
INSERT INTO pro_city_area VALUES ('330421', '嘉善县', '330400');
INSERT INTO pro_city_area VALUES ('330424', '海盐县', '330400');
INSERT INTO pro_city_area VALUES ('330481', '海宁市', '330400');
INSERT INTO pro_city_area VALUES ('330482', '平湖市', '330400');
INSERT INTO pro_city_area VALUES ('330483', '桐乡市', '330400');
INSERT INTO pro_city_area VALUES ('330500', '湖州市', '330000');
INSERT INTO pro_city_area VALUES ('330501', '市辖区', '330500');
INSERT INTO pro_city_area VALUES ('330502', '吴兴区', '330500');
INSERT INTO pro_city_area VALUES ('330503', '南浔区', '330500');
INSERT INTO pro_city_area VALUES ('330521', '德清县', '330500');
INSERT INTO pro_city_area VALUES ('330522', '长兴县', '330500');
INSERT INTO pro_city_area VALUES ('330523', '安吉县', '330500');
INSERT INTO pro_city_area VALUES ('330600', '绍兴市', '330000');
INSERT INTO pro_city_area VALUES ('330601', '市辖区', '330600');
INSERT INTO pro_city_area VALUES ('330602', '越城区', '330600');
INSERT INTO pro_city_area VALUES ('330621', '绍兴县', '330600');
INSERT INTO pro_city_area VALUES ('330624', '新昌县', '330600');
INSERT INTO pro_city_area VALUES ('330681', '诸暨市', '330600');
INSERT INTO pro_city_area VALUES ('330682', '上虞市', '330600');
INSERT INTO pro_city_area VALUES ('330683', '嵊州市', '330600');
INSERT INTO pro_city_area VALUES ('330700', '金华市', '330000');
INSERT INTO pro_city_area VALUES ('330701', '市辖区', '330700');
INSERT INTO pro_city_area VALUES ('330702', '婺城区', '330700');
INSERT INTO pro_city_area VALUES ('330703', '金东区', '330700');
INSERT INTO pro_city_area VALUES ('330723', '武义县', '330700');
INSERT INTO pro_city_area VALUES ('330726', '浦江县', '330700');
INSERT INTO pro_city_area VALUES ('330727', '磐安县', '330700');
INSERT INTO pro_city_area VALUES ('330781', '兰溪市', '330700');
INSERT INTO pro_city_area VALUES ('330782', '义乌市', '330700');
INSERT INTO pro_city_area VALUES ('330783', '东阳市', '330700');
INSERT INTO pro_city_area VALUES ('330784', '永康市', '330700');
INSERT INTO pro_city_area VALUES ('330800', '衢州市', '330000');
INSERT INTO pro_city_area VALUES ('330801', '市辖区', '330800');
INSERT INTO pro_city_area VALUES ('330802', '柯城区', '330800');
INSERT INTO pro_city_area VALUES ('330803', '衢江区', '330800');
INSERT INTO pro_city_area VALUES ('330822', '常山县', '330800');
INSERT INTO pro_city_area VALUES ('330824', '开化县', '330800');
INSERT INTO pro_city_area VALUES ('330825', '龙游县', '330800');
INSERT INTO pro_city_area VALUES ('330881', '江山市', '330800');
INSERT INTO pro_city_area VALUES ('330900', '舟山市', '330000');
INSERT INTO pro_city_area VALUES ('330901', '市辖区', '330900');
INSERT INTO pro_city_area VALUES ('330902', '定海区', '330900');
INSERT INTO pro_city_area VALUES ('330903', '普陀区', '330900');
INSERT INTO pro_city_area VALUES ('330921', '岱山县', '330900');
INSERT INTO pro_city_area VALUES ('330922', '嵊泗县', '330900');
INSERT INTO pro_city_area VALUES ('331000', '台州市', '330000');
INSERT INTO pro_city_area VALUES ('331001', '市辖区', '331000');
INSERT INTO pro_city_area VALUES ('331002', '椒江区', '331000');
INSERT INTO pro_city_area VALUES ('331003', '黄岩区', '331000');
INSERT INTO pro_city_area VALUES ('331004', '路桥区', '331000');
INSERT INTO pro_city_area VALUES ('331021', '玉环县', '331000');
INSERT INTO pro_city_area VALUES ('331022', '三门县', '331000');
INSERT INTO pro_city_area VALUES ('331023', '天台县', '331000');
INSERT INTO pro_city_area VALUES ('331024', '仙居县', '331000');
INSERT INTO pro_city_area VALUES ('331081', '温岭市', '331000');
INSERT INTO pro_city_area VALUES ('331082', '临海市', '331000');
INSERT INTO pro_city_area VALUES ('331100', '丽水市', '330000');
INSERT INTO pro_city_area VALUES ('331101', '市辖区', '331100');
INSERT INTO pro_city_area VALUES ('331102', '莲都区', '331100');
INSERT INTO pro_city_area VALUES ('331121', '青田县', '331100');
INSERT INTO pro_city_area VALUES ('331122', '缙云县', '331100');
INSERT INTO pro_city_area VALUES ('331123', '遂昌县', '331100');
INSERT INTO pro_city_area VALUES ('331124', '松阳县', '331100');
INSERT INTO pro_city_area VALUES ('331125', '云和县', '331100');
INSERT INTO pro_city_area VALUES ('331126', '庆元县', '331100');
INSERT INTO pro_city_area VALUES ('331127', '景宁畲族自治县', '331100');
INSERT INTO pro_city_area VALUES ('331181', '龙泉市', '331100');
INSERT INTO pro_city_area VALUES ('340000', '安徽省', '0');
INSERT INTO pro_city_area VALUES ('340100', '合肥市', '340000');
INSERT INTO pro_city_area VALUES ('340101', '市辖区', '340100');
INSERT INTO pro_city_area VALUES ('340102', '瑶海区', '340100');
INSERT INTO pro_city_area VALUES ('340103', '庐阳区', '340100');
INSERT INTO pro_city_area VALUES ('340104', '蜀山区', '340100');
INSERT INTO pro_city_area VALUES ('340111', '包河区', '340100');
INSERT INTO pro_city_area VALUES ('340121', '长丰县', '340100');
INSERT INTO pro_city_area VALUES ('340122', '肥东县', '340100');
INSERT INTO pro_city_area VALUES ('340123', '肥西县', '340100');
INSERT INTO pro_city_area VALUES ('340200', '芜湖市', '340000');
INSERT INTO pro_city_area VALUES ('340201', '市辖区', '340200');
INSERT INTO pro_city_area VALUES ('340202', '镜湖区', '340200');
INSERT INTO pro_city_area VALUES ('340203', '马塘区', '340200');
INSERT INTO pro_city_area VALUES ('340204', '新芜区', '340200');
INSERT INTO pro_city_area VALUES ('340207', '鸠江区', '340200');
INSERT INTO pro_city_area VALUES ('340221', '芜湖县', '340200');
INSERT INTO pro_city_area VALUES ('340222', '繁昌县', '340200');
INSERT INTO pro_city_area VALUES ('340223', '南陵县', '340200');
INSERT INTO pro_city_area VALUES ('340300', '蚌埠市', '340000');
INSERT INTO pro_city_area VALUES ('340301', '市辖区', '340300');
INSERT INTO pro_city_area VALUES ('340302', '龙子湖区', '340300');
INSERT INTO pro_city_area VALUES ('340303', '蚌山区', '340300');
INSERT INTO pro_city_area VALUES ('340304', '禹会区', '340300');
INSERT INTO pro_city_area VALUES ('340311', '淮上区', '340300');
INSERT INTO pro_city_area VALUES ('340321', '怀远县', '340300');
INSERT INTO pro_city_area VALUES ('340322', '五河县', '340300');
INSERT INTO pro_city_area VALUES ('340323', '固镇县', '340300');
INSERT INTO pro_city_area VALUES ('340400', '淮南市', '340000');
INSERT INTO pro_city_area VALUES ('340401', '市辖区', '340400');
INSERT INTO pro_city_area VALUES ('340402', '大通区', '340400');
INSERT INTO pro_city_area VALUES ('340403', '田家庵区', '340400');
INSERT INTO pro_city_area VALUES ('340404', '谢家集区', '340400');
INSERT INTO pro_city_area VALUES ('340405', '八公山区', '340400');
INSERT INTO pro_city_area VALUES ('340406', '潘集区', '340400');
INSERT INTO pro_city_area VALUES ('340421', '凤台县', '340400');
INSERT INTO pro_city_area VALUES ('340500', '马鞍山市', '340000');
INSERT INTO pro_city_area VALUES ('340501', '市辖区', '340500');
INSERT INTO pro_city_area VALUES ('340502', '金家庄区', '340500');
INSERT INTO pro_city_area VALUES ('340503', '花山区', '340500');
INSERT INTO pro_city_area VALUES ('340504', '雨山区', '340500');
INSERT INTO pro_city_area VALUES ('340521', '当涂县', '340500');
INSERT INTO pro_city_area VALUES ('340600', '淮北市', '340000');
INSERT INTO pro_city_area VALUES ('340601', '市辖区', '340600');
INSERT INTO pro_city_area VALUES ('340602', '杜集区', '340600');
INSERT INTO pro_city_area VALUES ('340603', '相山区', '340600');
INSERT INTO pro_city_area VALUES ('340604', '烈山区', '340600');
INSERT INTO pro_city_area VALUES ('340621', '濉溪县', '340600');
INSERT INTO pro_city_area VALUES ('340700', '铜陵市', '340000');
INSERT INTO pro_city_area VALUES ('340701', '市辖区', '340700');
INSERT INTO pro_city_area VALUES ('340702', '铜官山区', '340700');
INSERT INTO pro_city_area VALUES ('340703', '狮子山区', '340700');
INSERT INTO pro_city_area VALUES ('340711', '郊　区', '340700');
INSERT INTO pro_city_area VALUES ('340721', '铜陵县', '340700');
INSERT INTO pro_city_area VALUES ('340800', '安庆市', '340000');
INSERT INTO pro_city_area VALUES ('340801', '市辖区', '340800');
INSERT INTO pro_city_area VALUES ('340802', '迎江区', '340800');
INSERT INTO pro_city_area VALUES ('340803', '大观区', '340800');
INSERT INTO pro_city_area VALUES ('340811', '郊　区', '340800');
INSERT INTO pro_city_area VALUES ('340822', '怀宁县', '340800');
INSERT INTO pro_city_area VALUES ('340823', '枞阳县', '340800');
INSERT INTO pro_city_area VALUES ('340824', '潜山县', '340800');
INSERT INTO pro_city_area VALUES ('340825', '太湖县', '340800');
INSERT INTO pro_city_area VALUES ('340826', '宿松县', '340800');
INSERT INTO pro_city_area VALUES ('340827', '望江县', '340800');
INSERT INTO pro_city_area VALUES ('340828', '岳西县', '340800');
INSERT INTO pro_city_area VALUES ('340881', '桐城市', '340800');
INSERT INTO pro_city_area VALUES ('341000', '黄山市', '340000');
INSERT INTO pro_city_area VALUES ('341001', '市辖区', '341000');
INSERT INTO pro_city_area VALUES ('341002', '屯溪区', '341000');
INSERT INTO pro_city_area VALUES ('341003', '黄山区', '341000');
INSERT INTO pro_city_area VALUES ('341004', '徽州区', '341000');
INSERT INTO pro_city_area VALUES ('341021', '歙　县', '341000');
INSERT INTO pro_city_area VALUES ('341022', '休宁县', '341000');
INSERT INTO pro_city_area VALUES ('341023', '黟　县', '341000');
INSERT INTO pro_city_area VALUES ('341024', '祁门县', '341000');
INSERT INTO pro_city_area VALUES ('341100', '滁州市', '340000');
INSERT INTO pro_city_area VALUES ('341101', '市辖区', '341100');
INSERT INTO pro_city_area VALUES ('341102', '琅琊区', '341100');
INSERT INTO pro_city_area VALUES ('341103', '南谯区', '341100');
INSERT INTO pro_city_area VALUES ('341122', '来安县', '341100');
INSERT INTO pro_city_area VALUES ('341124', '全椒县', '341100');
INSERT INTO pro_city_area VALUES ('341125', '定远县', '341100');
INSERT INTO pro_city_area VALUES ('341126', '凤阳县', '341100');
INSERT INTO pro_city_area VALUES ('341181', '天长市', '341100');
INSERT INTO pro_city_area VALUES ('341182', '明光市', '341100');
INSERT INTO pro_city_area VALUES ('341200', '阜阳市', '340000');
INSERT INTO pro_city_area VALUES ('341201', '市辖区', '341200');
INSERT INTO pro_city_area VALUES ('341202', '颍州区', '341200');
INSERT INTO pro_city_area VALUES ('341203', '颍东区', '341200');
INSERT INTO pro_city_area VALUES ('341204', '颍泉区', '341200');
INSERT INTO pro_city_area VALUES ('341221', '临泉县', '341200');
INSERT INTO pro_city_area VALUES ('341222', '太和县', '341200');
INSERT INTO pro_city_area VALUES ('341225', '阜南县', '341200');
INSERT INTO pro_city_area VALUES ('341226', '颍上县', '341200');
INSERT INTO pro_city_area VALUES ('341282', '界首市', '341200');
INSERT INTO pro_city_area VALUES ('341300', '宿州市', '340000');
INSERT INTO pro_city_area VALUES ('341301', '市辖区', '341300');
INSERT INTO pro_city_area VALUES ('341302', '墉桥区', '341300');
INSERT INTO pro_city_area VALUES ('341321', '砀山县', '341300');
INSERT INTO pro_city_area VALUES ('341322', '萧　县', '341300');
INSERT INTO pro_city_area VALUES ('341323', '灵璧县', '341300');
INSERT INTO pro_city_area VALUES ('341324', '泗　县', '341300');
INSERT INTO pro_city_area VALUES ('341400', '巢湖市', '340000');
INSERT INTO pro_city_area VALUES ('341401', '市辖区', '341400');
INSERT INTO pro_city_area VALUES ('341402', '居巢区', '341400');
INSERT INTO pro_city_area VALUES ('341421', '庐江县', '341400');
INSERT INTO pro_city_area VALUES ('341422', '无为县', '341400');
INSERT INTO pro_city_area VALUES ('341423', '含山县', '341400');
INSERT INTO pro_city_area VALUES ('341424', '和　县', '341400');
INSERT INTO pro_city_area VALUES ('341500', '六安市', '340000');
INSERT INTO pro_city_area VALUES ('341501', '市辖区', '341500');
INSERT INTO pro_city_area VALUES ('341502', '金安区', '341500');
INSERT INTO pro_city_area VALUES ('341503', '裕安区', '341500');
INSERT INTO pro_city_area VALUES ('341521', '寿　县', '341500');
INSERT INTO pro_city_area VALUES ('341522', '霍邱县', '341500');
INSERT INTO pro_city_area VALUES ('341523', '舒城县', '341500');
INSERT INTO pro_city_area VALUES ('341524', '金寨县', '341500');
INSERT INTO pro_city_area VALUES ('341525', '霍山县', '341500');
INSERT INTO pro_city_area VALUES ('341600', '亳州市', '340000');
INSERT INTO pro_city_area VALUES ('341601', '市辖区', '341600');
INSERT INTO pro_city_area VALUES ('341602', '谯城区', '341600');
INSERT INTO pro_city_area VALUES ('341621', '涡阳县', '341600');
INSERT INTO pro_city_area VALUES ('341622', '蒙城县', '341600');
INSERT INTO pro_city_area VALUES ('341623', '利辛县', '341600');
INSERT INTO pro_city_area VALUES ('341700', '池州市', '340000');
INSERT INTO pro_city_area VALUES ('341701', '市辖区', '341700');
INSERT INTO pro_city_area VALUES ('341702', '贵池区', '341700');
INSERT INTO pro_city_area VALUES ('341721', '东至县', '341700');
INSERT INTO pro_city_area VALUES ('341722', '石台县', '341700');
INSERT INTO pro_city_area VALUES ('341723', '青阳县', '341700');
INSERT INTO pro_city_area VALUES ('341800', '宣城市', '340000');
INSERT INTO pro_city_area VALUES ('341801', '市辖区', '341800');
INSERT INTO pro_city_area VALUES ('341802', '宣州区', '341800');
INSERT INTO pro_city_area VALUES ('341821', '郎溪县', '341800');
INSERT INTO pro_city_area VALUES ('341822', '广德县', '341800');
INSERT INTO pro_city_area VALUES ('341823', '泾　县', '341800');
INSERT INTO pro_city_area VALUES ('341824', '绩溪县', '341800');
INSERT INTO pro_city_area VALUES ('341825', '旌德县', '341800');
INSERT INTO pro_city_area VALUES ('341881', '宁国市', '341800');
INSERT INTO pro_city_area VALUES ('350000', '福建省', '0');
INSERT INTO pro_city_area VALUES ('350100', '福州市', '350000');
INSERT INTO pro_city_area VALUES ('350101', '市辖区', '350100');
INSERT INTO pro_city_area VALUES ('350102', '鼓楼区', '350100');
INSERT INTO pro_city_area VALUES ('350103', '台江区', '350100');
INSERT INTO pro_city_area VALUES ('350104', '仓山区', '350100');
INSERT INTO pro_city_area VALUES ('350105', '马尾区', '350100');
INSERT INTO pro_city_area VALUES ('350111', '晋安区', '350100');
INSERT INTO pro_city_area VALUES ('350121', '闽侯县', '350100');
INSERT INTO pro_city_area VALUES ('350122', '连江县', '350100');
INSERT INTO pro_city_area VALUES ('350123', '罗源县', '350100');
INSERT INTO pro_city_area VALUES ('350124', '闽清县', '350100');
INSERT INTO pro_city_area VALUES ('350125', '永泰县', '350100');
INSERT INTO pro_city_area VALUES ('350128', '平潭县', '350100');
INSERT INTO pro_city_area VALUES ('350181', '福清市', '350100');
INSERT INTO pro_city_area VALUES ('350182', '长乐市', '350100');
INSERT INTO pro_city_area VALUES ('350200', '厦门市', '350000');
INSERT INTO pro_city_area VALUES ('350201', '市辖区', '350200');
INSERT INTO pro_city_area VALUES ('350203', '思明区', '350200');
INSERT INTO pro_city_area VALUES ('350205', '海沧区', '350200');
INSERT INTO pro_city_area VALUES ('350206', '湖里区', '350200');
INSERT INTO pro_city_area VALUES ('350211', '集美区', '350200');
INSERT INTO pro_city_area VALUES ('350212', '同安区', '350200');
INSERT INTO pro_city_area VALUES ('350213', '翔安区', '350200');
INSERT INTO pro_city_area VALUES ('350300', '莆田市', '350000');
INSERT INTO pro_city_area VALUES ('350301', '市辖区', '350300');
INSERT INTO pro_city_area VALUES ('350302', '城厢区', '350300');
INSERT INTO pro_city_area VALUES ('350303', '涵江区', '350300');
INSERT INTO pro_city_area VALUES ('350304', '荔城区', '350300');
INSERT INTO pro_city_area VALUES ('350305', '秀屿区', '350300');
INSERT INTO pro_city_area VALUES ('350322', '仙游县', '350300');
INSERT INTO pro_city_area VALUES ('350400', '三明市', '350000');
INSERT INTO pro_city_area VALUES ('350401', '市辖区', '350400');
INSERT INTO pro_city_area VALUES ('350402', '梅列区', '350400');
INSERT INTO pro_city_area VALUES ('350403', '三元区', '350400');
INSERT INTO pro_city_area VALUES ('350421', '明溪县', '350400');
INSERT INTO pro_city_area VALUES ('350423', '清流县', '350400');
INSERT INTO pro_city_area VALUES ('350424', '宁化县', '350400');
INSERT INTO pro_city_area VALUES ('350425', '大田县', '350400');
INSERT INTO pro_city_area VALUES ('350426', '尤溪县', '350400');
INSERT INTO pro_city_area VALUES ('350427', '沙　县', '350400');
INSERT INTO pro_city_area VALUES ('350428', '将乐县', '350400');
INSERT INTO pro_city_area VALUES ('350429', '泰宁县', '350400');
INSERT INTO pro_city_area VALUES ('350430', '建宁县', '350400');
INSERT INTO pro_city_area VALUES ('350481', '永安市', '350400');
INSERT INTO pro_city_area VALUES ('350500', '泉州市', '350000');
INSERT INTO pro_city_area VALUES ('350501', '市辖区', '350500');
INSERT INTO pro_city_area VALUES ('350502', '鲤城区', '350500');
INSERT INTO pro_city_area VALUES ('350503', '丰泽区', '350500');
INSERT INTO pro_city_area VALUES ('350504', '洛江区', '350500');
INSERT INTO pro_city_area VALUES ('350505', '泉港区', '350500');
INSERT INTO pro_city_area VALUES ('350521', '惠安县', '350500');
INSERT INTO pro_city_area VALUES ('350524', '安溪县', '350500');
INSERT INTO pro_city_area VALUES ('350525', '永春县', '350500');
INSERT INTO pro_city_area VALUES ('350526', '德化县', '350500');
INSERT INTO pro_city_area VALUES ('350527', '金门县', '350500');
INSERT INTO pro_city_area VALUES ('350581', '石狮市', '350500');
INSERT INTO pro_city_area VALUES ('350582', '晋江市', '350500');
INSERT INTO pro_city_area VALUES ('350583', '南安市', '350500');
INSERT INTO pro_city_area VALUES ('350600', '漳州市', '350000');
INSERT INTO pro_city_area VALUES ('350601', '市辖区', '350600');
INSERT INTO pro_city_area VALUES ('350602', '芗城区', '350600');
INSERT INTO pro_city_area VALUES ('350603', '龙文区', '350600');
INSERT INTO pro_city_area VALUES ('350622', '云霄县', '350600');
INSERT INTO pro_city_area VALUES ('350623', '漳浦县', '350600');
INSERT INTO pro_city_area VALUES ('350624', '诏安县', '350600');
INSERT INTO pro_city_area VALUES ('350625', '长泰县', '350600');
INSERT INTO pro_city_area VALUES ('350626', '东山县', '350600');
INSERT INTO pro_city_area VALUES ('350627', '南靖县', '350600');
INSERT INTO pro_city_area VALUES ('350628', '平和县', '350600');
INSERT INTO pro_city_area VALUES ('350629', '华安县', '350600');
INSERT INTO pro_city_area VALUES ('350681', '龙海市', '350600');
INSERT INTO pro_city_area VALUES ('350700', '南平市', '350000');
INSERT INTO pro_city_area VALUES ('350701', '市辖区', '350700');
INSERT INTO pro_city_area VALUES ('350702', '延平区', '350700');
INSERT INTO pro_city_area VALUES ('350721', '顺昌县', '350700');
INSERT INTO pro_city_area VALUES ('350722', '浦城县', '350700');
INSERT INTO pro_city_area VALUES ('350723', '光泽县', '350700');
INSERT INTO pro_city_area VALUES ('350724', '松溪县', '350700');
INSERT INTO pro_city_area VALUES ('350725', '政和县', '350700');
INSERT INTO pro_city_area VALUES ('350781', '邵武市', '350700');
INSERT INTO pro_city_area VALUES ('350782', '武夷山市', '350700');
INSERT INTO pro_city_area VALUES ('350783', '建瓯市', '350700');
INSERT INTO pro_city_area VALUES ('350784', '建阳市', '350700');
INSERT INTO pro_city_area VALUES ('350800', '龙岩市', '350000');
INSERT INTO pro_city_area VALUES ('350801', '市辖区', '350800');
INSERT INTO pro_city_area VALUES ('350802', '新罗区', '350800');
INSERT INTO pro_city_area VALUES ('350821', '长汀县', '350800');
INSERT INTO pro_city_area VALUES ('350822', '永定县', '350800');
INSERT INTO pro_city_area VALUES ('350823', '上杭县', '350800');
INSERT INTO pro_city_area VALUES ('350824', '武平县', '350800');
INSERT INTO pro_city_area VALUES ('350825', '连城县', '350800');
INSERT INTO pro_city_area VALUES ('350881', '漳平市', '350800');
INSERT INTO pro_city_area VALUES ('350900', '宁德市', '350000');
INSERT INTO pro_city_area VALUES ('350901', '市辖区', '350900');
INSERT INTO pro_city_area VALUES ('350902', '蕉城区', '350900');
INSERT INTO pro_city_area VALUES ('350921', '霞浦县', '350900');
INSERT INTO pro_city_area VALUES ('350922', '古田县', '350900');
INSERT INTO pro_city_area VALUES ('350923', '屏南县', '350900');
INSERT INTO pro_city_area VALUES ('350924', '寿宁县', '350900');
INSERT INTO pro_city_area VALUES ('350925', '周宁县', '350900');
INSERT INTO pro_city_area VALUES ('350926', '柘荣县', '350900');
INSERT INTO pro_city_area VALUES ('350981', '福安市', '350900');
INSERT INTO pro_city_area VALUES ('350982', '福鼎市', '350900');
INSERT INTO pro_city_area VALUES ('360000', '江西省', '0');
INSERT INTO pro_city_area VALUES ('360100', '南昌市', '360000');
INSERT INTO pro_city_area VALUES ('360101', '市辖区', '360100');
INSERT INTO pro_city_area VALUES ('360102', '东湖区', '360100');
INSERT INTO pro_city_area VALUES ('360103', '西湖区', '360100');
INSERT INTO pro_city_area VALUES ('360104', '青云谱区', '360100');
INSERT INTO pro_city_area VALUES ('360105', '湾里区', '360100');
INSERT INTO pro_city_area VALUES ('360111', '青山湖区', '360100');
INSERT INTO pro_city_area VALUES ('360121', '南昌县', '360100');
INSERT INTO pro_city_area VALUES ('360122', '新建县', '360100');
INSERT INTO pro_city_area VALUES ('360123', '安义县', '360100');
INSERT INTO pro_city_area VALUES ('360124', '进贤县', '360100');
INSERT INTO pro_city_area VALUES ('360200', '景德镇市', '360000');
INSERT INTO pro_city_area VALUES ('360201', '市辖区', '360200');
INSERT INTO pro_city_area VALUES ('360202', '昌江区', '360200');
INSERT INTO pro_city_area VALUES ('360203', '珠山区', '360200');
INSERT INTO pro_city_area VALUES ('360222', '浮梁县', '360200');
INSERT INTO pro_city_area VALUES ('360281', '乐平市', '360200');
INSERT INTO pro_city_area VALUES ('360300', '萍乡市', '360000');
INSERT INTO pro_city_area VALUES ('360301', '市辖区', '360300');
INSERT INTO pro_city_area VALUES ('360302', '安源区', '360300');
INSERT INTO pro_city_area VALUES ('360313', '湘东区', '360300');
INSERT INTO pro_city_area VALUES ('360321', '莲花县', '360300');
INSERT INTO pro_city_area VALUES ('360322', '上栗县', '360300');
INSERT INTO pro_city_area VALUES ('360323', '芦溪县', '360300');
INSERT INTO pro_city_area VALUES ('360400', '九江市', '360000');
INSERT INTO pro_city_area VALUES ('360401', '市辖区', '360400');
INSERT INTO pro_city_area VALUES ('360402', '庐山区', '360400');
INSERT INTO pro_city_area VALUES ('360403', '浔阳区', '360400');
INSERT INTO pro_city_area VALUES ('360421', '九江县', '360400');
INSERT INTO pro_city_area VALUES ('360423', '武宁县', '360400');
INSERT INTO pro_city_area VALUES ('360424', '修水县', '360400');
INSERT INTO pro_city_area VALUES ('360425', '永修县', '360400');
INSERT INTO pro_city_area VALUES ('360426', '德安县', '360400');
INSERT INTO pro_city_area VALUES ('360427', '星子县', '360400');
INSERT INTO pro_city_area VALUES ('360428', '都昌县', '360400');
INSERT INTO pro_city_area VALUES ('360429', '湖口县', '360400');
INSERT INTO pro_city_area VALUES ('360430', '彭泽县', '360400');
INSERT INTO pro_city_area VALUES ('360481', '瑞昌市', '360400');
INSERT INTO pro_city_area VALUES ('360500', '新余市', '360000');
INSERT INTO pro_city_area VALUES ('360501', '市辖区', '360500');
INSERT INTO pro_city_area VALUES ('360502', '渝水区', '360500');
INSERT INTO pro_city_area VALUES ('360521', '分宜县', '360500');
INSERT INTO pro_city_area VALUES ('360600', '鹰潭市', '360000');
INSERT INTO pro_city_area VALUES ('360601', '市辖区', '360600');
INSERT INTO pro_city_area VALUES ('360602', '月湖区', '360600');
INSERT INTO pro_city_area VALUES ('360622', '余江县', '360600');
INSERT INTO pro_city_area VALUES ('360681', '贵溪市', '360600');
INSERT INTO pro_city_area VALUES ('360700', '赣州市', '360000');
INSERT INTO pro_city_area VALUES ('360701', '市辖区', '360700');
INSERT INTO pro_city_area VALUES ('360702', '章贡区', '360700');
INSERT INTO pro_city_area VALUES ('360721', '赣　县', '360700');
INSERT INTO pro_city_area VALUES ('360722', '信丰县', '360700');
INSERT INTO pro_city_area VALUES ('360723', '大余县', '360700');
INSERT INTO pro_city_area VALUES ('360724', '上犹县', '360700');
INSERT INTO pro_city_area VALUES ('360725', '崇义县', '360700');
INSERT INTO pro_city_area VALUES ('360726', '安远县', '360700');
INSERT INTO pro_city_area VALUES ('360727', '龙南县', '360700');
INSERT INTO pro_city_area VALUES ('360728', '定南县', '360700');
INSERT INTO pro_city_area VALUES ('360729', '全南县', '360700');
INSERT INTO pro_city_area VALUES ('360730', '宁都县', '360700');
INSERT INTO pro_city_area VALUES ('360731', '于都县', '360700');
INSERT INTO pro_city_area VALUES ('360732', '兴国县', '360700');
INSERT INTO pro_city_area VALUES ('360733', '会昌县', '360700');
INSERT INTO pro_city_area VALUES ('360734', '寻乌县', '360700');
INSERT INTO pro_city_area VALUES ('360735', '石城县', '360700');
INSERT INTO pro_city_area VALUES ('360781', '瑞金市', '360700');
INSERT INTO pro_city_area VALUES ('360782', '南康市', '360700');
INSERT INTO pro_city_area VALUES ('360800', '吉安市', '360000');
INSERT INTO pro_city_area VALUES ('360801', '市辖区', '360800');
INSERT INTO pro_city_area VALUES ('360802', '吉州区', '360800');
INSERT INTO pro_city_area VALUES ('360803', '青原区', '360800');
INSERT INTO pro_city_area VALUES ('360821', '吉安县', '360800');
INSERT INTO pro_city_area VALUES ('360822', '吉水县', '360800');
INSERT INTO pro_city_area VALUES ('360823', '峡江县', '360800');
INSERT INTO pro_city_area VALUES ('360824', '新干县', '360800');
INSERT INTO pro_city_area VALUES ('360825', '永丰县', '360800');
INSERT INTO pro_city_area VALUES ('360826', '泰和县', '360800');
INSERT INTO pro_city_area VALUES ('360827', '遂川县', '360800');
INSERT INTO pro_city_area VALUES ('360828', '万安县', '360800');
INSERT INTO pro_city_area VALUES ('360829', '安福县', '360800');
INSERT INTO pro_city_area VALUES ('360830', '永新县', '360800');
INSERT INTO pro_city_area VALUES ('360881', '井冈山市', '360800');
INSERT INTO pro_city_area VALUES ('360900', '宜春市', '360000');
INSERT INTO pro_city_area VALUES ('360901', '市辖区', '360900');
INSERT INTO pro_city_area VALUES ('360902', '袁州区', '360900');
INSERT INTO pro_city_area VALUES ('360921', '奉新县', '360900');
INSERT INTO pro_city_area VALUES ('360922', '万载县', '360900');
INSERT INTO pro_city_area VALUES ('360923', '上高县', '360900');
INSERT INTO pro_city_area VALUES ('360924', '宜丰县', '360900');
INSERT INTO pro_city_area VALUES ('360925', '靖安县', '360900');
INSERT INTO pro_city_area VALUES ('360926', '铜鼓县', '360900');
INSERT INTO pro_city_area VALUES ('360981', '丰城市', '360900');
INSERT INTO pro_city_area VALUES ('360982', '樟树市', '360900');
INSERT INTO pro_city_area VALUES ('360983', '高安市', '360900');
INSERT INTO pro_city_area VALUES ('361000', '抚州市', '360000');
INSERT INTO pro_city_area VALUES ('361001', '市辖区', '361000');
INSERT INTO pro_city_area VALUES ('361002', '临川区', '361000');
INSERT INTO pro_city_area VALUES ('361021', '南城县', '361000');
INSERT INTO pro_city_area VALUES ('361022', '黎川县', '361000');
INSERT INTO pro_city_area VALUES ('361023', '南丰县', '361000');
INSERT INTO pro_city_area VALUES ('361024', '崇仁县', '361000');
INSERT INTO pro_city_area VALUES ('361025', '乐安县', '361000');
INSERT INTO pro_city_area VALUES ('361026', '宜黄县', '361000');
INSERT INTO pro_city_area VALUES ('361027', '金溪县', '361000');
INSERT INTO pro_city_area VALUES ('361028', '资溪县', '361000');
INSERT INTO pro_city_area VALUES ('361029', '东乡县', '361000');
INSERT INTO pro_city_area VALUES ('361030', '广昌县', '361000');
INSERT INTO pro_city_area VALUES ('361100', '上饶市', '360000');
INSERT INTO pro_city_area VALUES ('361101', '市辖区', '361100');
INSERT INTO pro_city_area VALUES ('361102', '信州区', '361100');
INSERT INTO pro_city_area VALUES ('361121', '上饶县', '361100');
INSERT INTO pro_city_area VALUES ('361122', '广丰县', '361100');
INSERT INTO pro_city_area VALUES ('361123', '玉山县', '361100');
INSERT INTO pro_city_area VALUES ('361124', '铅山县', '361100');
INSERT INTO pro_city_area VALUES ('361125', '横峰县', '361100');
INSERT INTO pro_city_area VALUES ('361126', '弋阳县', '361100');
INSERT INTO pro_city_area VALUES ('361127', '余干县', '361100');
INSERT INTO pro_city_area VALUES ('361128', '鄱阳县', '361100');
INSERT INTO pro_city_area VALUES ('361129', '万年县', '361100');
INSERT INTO pro_city_area VALUES ('361130', '婺源县', '361100');
INSERT INTO pro_city_area VALUES ('361181', '德兴市', '361100');
INSERT INTO pro_city_area VALUES ('370000', '山东省', '0');
INSERT INTO pro_city_area VALUES ('370100', '济南市', '370000');
INSERT INTO pro_city_area VALUES ('370101', '市辖区', '370100');
INSERT INTO pro_city_area VALUES ('370102', '历下区', '370100');
INSERT INTO pro_city_area VALUES ('370103', '市中区', '370100');
INSERT INTO pro_city_area VALUES ('370104', '槐荫区', '370100');
INSERT INTO pro_city_area VALUES ('370105', '天桥区', '370100');
INSERT INTO pro_city_area VALUES ('370112', '历城区', '370100');
INSERT INTO pro_city_area VALUES ('370113', '长清区', '370100');
INSERT INTO pro_city_area VALUES ('370124', '平阴县', '370100');
INSERT INTO pro_city_area VALUES ('370125', '济阳县', '370100');
INSERT INTO pro_city_area VALUES ('370126', '商河县', '370100');
INSERT INTO pro_city_area VALUES ('370181', '章丘市', '370100');
INSERT INTO pro_city_area VALUES ('370200', '青岛市', '370000');
INSERT INTO pro_city_area VALUES ('370201', '市辖区', '370200');
INSERT INTO pro_city_area VALUES ('370202', '市南区', '370200');
INSERT INTO pro_city_area VALUES ('370203', '市北区', '370200');
INSERT INTO pro_city_area VALUES ('370205', '四方区', '370200');
INSERT INTO pro_city_area VALUES ('370211', '黄岛区', '370200');
INSERT INTO pro_city_area VALUES ('370212', '崂山区', '370200');
INSERT INTO pro_city_area VALUES ('370213', '李沧区', '370200');
INSERT INTO pro_city_area VALUES ('370214', '城阳区', '370200');
INSERT INTO pro_city_area VALUES ('370281', '胶州市', '370200');
INSERT INTO pro_city_area VALUES ('370282', '即墨市', '370200');
INSERT INTO pro_city_area VALUES ('370283', '平度市', '370200');
INSERT INTO pro_city_area VALUES ('370284', '胶南市', '370200');
INSERT INTO pro_city_area VALUES ('370285', '莱西市', '370200');
INSERT INTO pro_city_area VALUES ('370300', '淄博市', '370000');
INSERT INTO pro_city_area VALUES ('370301', '市辖区', '370300');
INSERT INTO pro_city_area VALUES ('370302', '淄川区', '370300');
INSERT INTO pro_city_area VALUES ('370303', '张店区', '370300');
INSERT INTO pro_city_area VALUES ('370304', '博山区', '370300');
INSERT INTO pro_city_area VALUES ('370305', '临淄区', '370300');
INSERT INTO pro_city_area VALUES ('370306', '周村区', '370300');
INSERT INTO pro_city_area VALUES ('370321', '桓台县', '370300');
INSERT INTO pro_city_area VALUES ('370322', '高青县', '370300');
INSERT INTO pro_city_area VALUES ('370323', '沂源县', '370300');
INSERT INTO pro_city_area VALUES ('370400', '枣庄市', '370000');
INSERT INTO pro_city_area VALUES ('370401', '市辖区', '370400');
INSERT INTO pro_city_area VALUES ('370402', '市中区', '370400');
INSERT INTO pro_city_area VALUES ('370403', '薛城区', '370400');
INSERT INTO pro_city_area VALUES ('370404', '峄城区', '370400');
INSERT INTO pro_city_area VALUES ('370405', '台儿庄区', '370400');
INSERT INTO pro_city_area VALUES ('370406', '山亭区', '370400');
INSERT INTO pro_city_area VALUES ('370481', '滕州市', '370400');
INSERT INTO pro_city_area VALUES ('370500', '东营市', '370000');
INSERT INTO pro_city_area VALUES ('370501', '市辖区', '370500');
INSERT INTO pro_city_area VALUES ('370502', '东营区', '370500');
INSERT INTO pro_city_area VALUES ('370503', '河口区', '370500');
INSERT INTO pro_city_area VALUES ('370521', '垦利县', '370500');
INSERT INTO pro_city_area VALUES ('370522', '利津县', '370500');
INSERT INTO pro_city_area VALUES ('370523', '广饶县', '370500');
INSERT INTO pro_city_area VALUES ('370600', '烟台市', '370000');
INSERT INTO pro_city_area VALUES ('370601', '市辖区', '370600');
INSERT INTO pro_city_area VALUES ('370602', '芝罘区', '370600');
INSERT INTO pro_city_area VALUES ('370611', '福山区', '370600');
INSERT INTO pro_city_area VALUES ('370612', '牟平区', '370600');
INSERT INTO pro_city_area VALUES ('370613', '莱山区', '370600');
INSERT INTO pro_city_area VALUES ('370634', '长岛县', '370600');
INSERT INTO pro_city_area VALUES ('370681', '龙口市', '370600');
INSERT INTO pro_city_area VALUES ('370682', '莱阳市', '370600');
INSERT INTO pro_city_area VALUES ('370683', '莱州市', '370600');
INSERT INTO pro_city_area VALUES ('370684', '蓬莱市', '370600');
INSERT INTO pro_city_area VALUES ('370685', '招远市', '370600');
INSERT INTO pro_city_area VALUES ('370686', '栖霞市', '370600');
INSERT INTO pro_city_area VALUES ('370687', '海阳市', '370600');
INSERT INTO pro_city_area VALUES ('370700', '潍坊市', '370000');
INSERT INTO pro_city_area VALUES ('370701', '市辖区', '370700');
INSERT INTO pro_city_area VALUES ('370702', '潍城区', '370700');
INSERT INTO pro_city_area VALUES ('370703', '寒亭区', '370700');
INSERT INTO pro_city_area VALUES ('370704', '坊子区', '370700');
INSERT INTO pro_city_area VALUES ('370705', '奎文区', '370700');
INSERT INTO pro_city_area VALUES ('370724', '临朐县', '370700');
INSERT INTO pro_city_area VALUES ('370725', '昌乐县', '370700');
INSERT INTO pro_city_area VALUES ('370781', '青州市', '370700');
INSERT INTO pro_city_area VALUES ('370782', '诸城市', '370700');
INSERT INTO pro_city_area VALUES ('370783', '寿光市', '370700');
INSERT INTO pro_city_area VALUES ('370784', '安丘市', '370700');
INSERT INTO pro_city_area VALUES ('370785', '高密市', '370700');
INSERT INTO pro_city_area VALUES ('370786', '昌邑市', '370700');
INSERT INTO pro_city_area VALUES ('370800', '济宁市', '370000');
INSERT INTO pro_city_area VALUES ('370801', '市辖区', '370800');
INSERT INTO pro_city_area VALUES ('370802', '市中区', '370800');
INSERT INTO pro_city_area VALUES ('370811', '任城区', '370800');
INSERT INTO pro_city_area VALUES ('370826', '微山县', '370800');
INSERT INTO pro_city_area VALUES ('370827', '鱼台县', '370800');
INSERT INTO pro_city_area VALUES ('370828', '金乡县', '370800');
INSERT INTO pro_city_area VALUES ('370829', '嘉祥县', '370800');
INSERT INTO pro_city_area VALUES ('370830', '汶上县', '370800');
INSERT INTO pro_city_area VALUES ('370831', '泗水县', '370800');
INSERT INTO pro_city_area VALUES ('370832', '梁山县', '370800');
INSERT INTO pro_city_area VALUES ('370881', '曲阜市', '370800');
INSERT INTO pro_city_area VALUES ('370882', '兖州市', '370800');
INSERT INTO pro_city_area VALUES ('370883', '邹城市', '370800');
INSERT INTO pro_city_area VALUES ('370900', '泰安市', '370000');
INSERT INTO pro_city_area VALUES ('370901', '市辖区', '370900');
INSERT INTO pro_city_area VALUES ('370902', '泰山区', '370900');
INSERT INTO pro_city_area VALUES ('370903', '岱岳区', '370900');
INSERT INTO pro_city_area VALUES ('370921', '宁阳县', '370900');
INSERT INTO pro_city_area VALUES ('370923', '东平县', '370900');
INSERT INTO pro_city_area VALUES ('370982', '新泰市', '370900');
INSERT INTO pro_city_area VALUES ('370983', '肥城市', '370900');
INSERT INTO pro_city_area VALUES ('371000', '威海市', '370000');
INSERT INTO pro_city_area VALUES ('371001', '市辖区', '371000');
INSERT INTO pro_city_area VALUES ('371002', '环翠区', '371000');
INSERT INTO pro_city_area VALUES ('371081', '文登市', '371000');
INSERT INTO pro_city_area VALUES ('371082', '荣成市', '371000');
INSERT INTO pro_city_area VALUES ('371083', '乳山市', '371000');
INSERT INTO pro_city_area VALUES ('371100', '日照市', '370000');
INSERT INTO pro_city_area VALUES ('371101', '市辖区', '371100');
INSERT INTO pro_city_area VALUES ('371102', '东港区', '371100');
INSERT INTO pro_city_area VALUES ('371103', '岚山区', '371100');
INSERT INTO pro_city_area VALUES ('371121', '五莲县', '371100');
INSERT INTO pro_city_area VALUES ('371122', '莒　县', '371100');
INSERT INTO pro_city_area VALUES ('371200', '莱芜市', '370000');
INSERT INTO pro_city_area VALUES ('371201', '市辖区', '371200');
INSERT INTO pro_city_area VALUES ('371202', '莱城区', '371200');
INSERT INTO pro_city_area VALUES ('371203', '钢城区', '371200');
INSERT INTO pro_city_area VALUES ('371300', '临沂市', '370000');
INSERT INTO pro_city_area VALUES ('371301', '市辖区', '371300');
INSERT INTO pro_city_area VALUES ('371302', '兰山区', '371300');
INSERT INTO pro_city_area VALUES ('371311', '罗庄区', '371300');
INSERT INTO pro_city_area VALUES ('371312', '河东区', '371300');
INSERT INTO pro_city_area VALUES ('371321', '沂南县', '371300');
INSERT INTO pro_city_area VALUES ('371322', '郯城县', '371300');
INSERT INTO pro_city_area VALUES ('371323', '沂水县', '371300');
INSERT INTO pro_city_area VALUES ('371324', '苍山县', '371300');
INSERT INTO pro_city_area VALUES ('371325', '费　县', '371300');
INSERT INTO pro_city_area VALUES ('371326', '平邑县', '371300');
INSERT INTO pro_city_area VALUES ('371327', '莒南县', '371300');
INSERT INTO pro_city_area VALUES ('371328', '蒙阴县', '371300');
INSERT INTO pro_city_area VALUES ('371329', '临沭县', '371300');
INSERT INTO pro_city_area VALUES ('371400', '德州市', '370000');
INSERT INTO pro_city_area VALUES ('371401', '市辖区', '371400');
INSERT INTO pro_city_area VALUES ('371402', '德城区', '371400');
INSERT INTO pro_city_area VALUES ('371421', '陵　县', '371400');
INSERT INTO pro_city_area VALUES ('371422', '宁津县', '371400');
INSERT INTO pro_city_area VALUES ('371423', '庆云县', '371400');
INSERT INTO pro_city_area VALUES ('371424', '临邑县', '371400');
INSERT INTO pro_city_area VALUES ('371425', '齐河县', '371400');
INSERT INTO pro_city_area VALUES ('371426', '平原县', '371400');
INSERT INTO pro_city_area VALUES ('371427', '夏津县', '371400');
INSERT INTO pro_city_area VALUES ('371428', '武城县', '371400');
INSERT INTO pro_city_area VALUES ('371481', '乐陵市', '371400');
INSERT INTO pro_city_area VALUES ('371482', '禹城市', '371400');
INSERT INTO pro_city_area VALUES ('371500', '聊城市', '370000');
INSERT INTO pro_city_area VALUES ('371501', '市辖区', '371500');
INSERT INTO pro_city_area VALUES ('371502', '东昌府区', '371500');
INSERT INTO pro_city_area VALUES ('371521', '阳谷县', '371500');
INSERT INTO pro_city_area VALUES ('371522', '莘　县', '371500');
INSERT INTO pro_city_area VALUES ('371523', '茌平县', '371500');
INSERT INTO pro_city_area VALUES ('371524', '东阿县', '371500');
INSERT INTO pro_city_area VALUES ('371525', '冠　县', '371500');
INSERT INTO pro_city_area VALUES ('371526', '高唐县', '371500');
INSERT INTO pro_city_area VALUES ('371581', '临清市', '371500');
INSERT INTO pro_city_area VALUES ('371600', '滨州市', '370000');
INSERT INTO pro_city_area VALUES ('371601', '市辖区', '371600');
INSERT INTO pro_city_area VALUES ('371602', '滨城区', '371600');
INSERT INTO pro_city_area VALUES ('371621', '惠民县', '371600');
INSERT INTO pro_city_area VALUES ('371622', '阳信县', '371600');
INSERT INTO pro_city_area VALUES ('371623', '无棣县', '371600');
INSERT INTO pro_city_area VALUES ('371624', '沾化县', '371600');
INSERT INTO pro_city_area VALUES ('371625', '博兴县', '371600');
INSERT INTO pro_city_area VALUES ('371626', '邹平县', '371600');
INSERT INTO pro_city_area VALUES ('371700', '荷泽市', '370000');
INSERT INTO pro_city_area VALUES ('371701', '市辖区', '371700');
INSERT INTO pro_city_area VALUES ('371702', '牡丹区', '371700');
INSERT INTO pro_city_area VALUES ('371721', '曹　县', '371700');
INSERT INTO pro_city_area VALUES ('371722', '单　县', '371700');
INSERT INTO pro_city_area VALUES ('371723', '成武县', '371700');
INSERT INTO pro_city_area VALUES ('371724', '巨野县', '371700');
INSERT INTO pro_city_area VALUES ('371725', '郓城县', '371700');
INSERT INTO pro_city_area VALUES ('371726', '鄄城县', '371700');
INSERT INTO pro_city_area VALUES ('371727', '定陶县', '371700');
INSERT INTO pro_city_area VALUES ('371728', '东明县', '371700');
INSERT INTO pro_city_area VALUES ('410000', '河南省', '0');
INSERT INTO pro_city_area VALUES ('410100', '郑州市', '410000');
INSERT INTO pro_city_area VALUES ('410101', '市辖区', '410100');
INSERT INTO pro_city_area VALUES ('410102', '中原区', '410100');
INSERT INTO pro_city_area VALUES ('410103', '二七区', '410100');
INSERT INTO pro_city_area VALUES ('410104', '管城回族区', '410100');
INSERT INTO pro_city_area VALUES ('410105', '金水区', '410100');
INSERT INTO pro_city_area VALUES ('410106', '上街区', '410100');
INSERT INTO pro_city_area VALUES ('410108', '邙山区', '410100');
INSERT INTO pro_city_area VALUES ('410122', '中牟县', '410100');
INSERT INTO pro_city_area VALUES ('410181', '巩义市', '410100');
INSERT INTO pro_city_area VALUES ('410182', '荥阳市', '410100');
INSERT INTO pro_city_area VALUES ('410183', '新密市', '410100');
INSERT INTO pro_city_area VALUES ('410184', '新郑市', '410100');
INSERT INTO pro_city_area VALUES ('410185', '登封市', '410100');
INSERT INTO pro_city_area VALUES ('410200', '开封市', '410000');
INSERT INTO pro_city_area VALUES ('410201', '市辖区', '410200');
INSERT INTO pro_city_area VALUES ('410202', '龙亭区', '410200');
INSERT INTO pro_city_area VALUES ('410203', '顺河回族区', '410200');
INSERT INTO pro_city_area VALUES ('410204', '鼓楼区', '410200');
INSERT INTO pro_city_area VALUES ('410205', '南关区', '410200');
INSERT INTO pro_city_area VALUES ('410211', '郊　区', '410200');
INSERT INTO pro_city_area VALUES ('410221', '杞　县', '410200');
INSERT INTO pro_city_area VALUES ('410222', '通许县', '410200');
INSERT INTO pro_city_area VALUES ('410223', '尉氏县', '410200');
INSERT INTO pro_city_area VALUES ('410224', '开封县', '410200');
INSERT INTO pro_city_area VALUES ('410225', '兰考县', '410200');
INSERT INTO pro_city_area VALUES ('410300', '洛阳市', '410000');
INSERT INTO pro_city_area VALUES ('410301', '市辖区', '410300');
INSERT INTO pro_city_area VALUES ('410302', '老城区', '410300');
INSERT INTO pro_city_area VALUES ('410303', '西工区', '410300');
INSERT INTO pro_city_area VALUES ('410304', '廛河回族区', '410300');
INSERT INTO pro_city_area VALUES ('410305', '涧西区', '410300');
INSERT INTO pro_city_area VALUES ('410306', '吉利区', '410300');
INSERT INTO pro_city_area VALUES ('410307', '洛龙区', '410300');
INSERT INTO pro_city_area VALUES ('410322', '孟津县', '410300');
INSERT INTO pro_city_area VALUES ('410323', '新安县', '410300');
INSERT INTO pro_city_area VALUES ('410324', '栾川县', '410300');
INSERT INTO pro_city_area VALUES ('410325', '嵩　县', '410300');
INSERT INTO pro_city_area VALUES ('410326', '汝阳县', '410300');
INSERT INTO pro_city_area VALUES ('410327', '宜阳县', '410300');
INSERT INTO pro_city_area VALUES ('410328', '洛宁县', '410300');
INSERT INTO pro_city_area VALUES ('410329', '伊川县', '410300');
INSERT INTO pro_city_area VALUES ('410381', '偃师市', '410300');
INSERT INTO pro_city_area VALUES ('410400', '平顶山市', '410000');
INSERT INTO pro_city_area VALUES ('410401', '市辖区', '410400');
INSERT INTO pro_city_area VALUES ('410402', '新华区', '410400');
INSERT INTO pro_city_area VALUES ('410403', '卫东区', '410400');
INSERT INTO pro_city_area VALUES ('410404', '石龙区', '410400');
INSERT INTO pro_city_area VALUES ('410411', '湛河区', '410400');
INSERT INTO pro_city_area VALUES ('410421', '宝丰县', '410400');
INSERT INTO pro_city_area VALUES ('410422', '叶　县', '410400');
INSERT INTO pro_city_area VALUES ('410423', '鲁山县', '410400');
INSERT INTO pro_city_area VALUES ('410425', '郏　县', '410400');
INSERT INTO pro_city_area VALUES ('410481', '舞钢市', '410400');
INSERT INTO pro_city_area VALUES ('410482', '汝州市', '410400');
INSERT INTO pro_city_area VALUES ('410500', '安阳市', '410000');
INSERT INTO pro_city_area VALUES ('410501', '市辖区', '410500');
INSERT INTO pro_city_area VALUES ('410502', '文峰区', '410500');
INSERT INTO pro_city_area VALUES ('410503', '北关区', '410500');
INSERT INTO pro_city_area VALUES ('410505', '殷都区', '410500');
INSERT INTO pro_city_area VALUES ('410506', '龙安区', '410500');
INSERT INTO pro_city_area VALUES ('410522', '安阳县', '410500');
INSERT INTO pro_city_area VALUES ('410523', '汤阴县', '410500');
INSERT INTO pro_city_area VALUES ('410526', '滑　县', '410500');
INSERT INTO pro_city_area VALUES ('410527', '内黄县', '410500');
INSERT INTO pro_city_area VALUES ('410581', '林州市', '410500');
INSERT INTO pro_city_area VALUES ('410600', '鹤壁市', '410000');
INSERT INTO pro_city_area VALUES ('410601', '市辖区', '410600');
INSERT INTO pro_city_area VALUES ('410602', '鹤山区', '410600');
INSERT INTO pro_city_area VALUES ('410603', '山城区', '410600');
INSERT INTO pro_city_area VALUES ('410611', '淇滨区', '410600');
INSERT INTO pro_city_area VALUES ('410621', '浚　县', '410600');
INSERT INTO pro_city_area VALUES ('410622', '淇　县', '410600');
INSERT INTO pro_city_area VALUES ('410700', '新乡市', '410000');
INSERT INTO pro_city_area VALUES ('410701', '市辖区', '410700');
INSERT INTO pro_city_area VALUES ('410702', '红旗区', '410700');
INSERT INTO pro_city_area VALUES ('410703', '卫滨区', '410700');
INSERT INTO pro_city_area VALUES ('410704', '凤泉区', '410700');
INSERT INTO pro_city_area VALUES ('410711', '牧野区', '410700');
INSERT INTO pro_city_area VALUES ('410721', '新乡县', '410700');
INSERT INTO pro_city_area VALUES ('410724', '获嘉县', '410700');
INSERT INTO pro_city_area VALUES ('410725', '原阳县', '410700');
INSERT INTO pro_city_area VALUES ('410726', '延津县', '410700');
INSERT INTO pro_city_area VALUES ('410727', '封丘县', '410700');
INSERT INTO pro_city_area VALUES ('410728', '长垣县', '410700');
INSERT INTO pro_city_area VALUES ('410781', '卫辉市', '410700');
INSERT INTO pro_city_area VALUES ('410782', '辉县市', '410700');
INSERT INTO pro_city_area VALUES ('410800', '焦作市', '410000');
INSERT INTO pro_city_area VALUES ('410801', '市辖区', '410800');
INSERT INTO pro_city_area VALUES ('410802', '解放区', '410800');
INSERT INTO pro_city_area VALUES ('410803', '中站区', '410800');
INSERT INTO pro_city_area VALUES ('410804', '马村区', '410800');
INSERT INTO pro_city_area VALUES ('410811', '山阳区', '410800');
INSERT INTO pro_city_area VALUES ('410821', '修武县', '410800');
INSERT INTO pro_city_area VALUES ('410822', '博爱县', '410800');
INSERT INTO pro_city_area VALUES ('410823', '武陟县', '410800');
INSERT INTO pro_city_area VALUES ('410825', '温　县', '410800');
INSERT INTO pro_city_area VALUES ('410881', '济源市', '410800');
INSERT INTO pro_city_area VALUES ('410882', '沁阳市', '410800');
INSERT INTO pro_city_area VALUES ('410883', '孟州市', '410800');
INSERT INTO pro_city_area VALUES ('410900', '濮阳市', '410000');
INSERT INTO pro_city_area VALUES ('410901', '市辖区', '410900');
INSERT INTO pro_city_area VALUES ('410902', '华龙区', '410900');
INSERT INTO pro_city_area VALUES ('410922', '清丰县', '410900');
INSERT INTO pro_city_area VALUES ('410923', '南乐县', '410900');
INSERT INTO pro_city_area VALUES ('410926', '范　县', '410900');
INSERT INTO pro_city_area VALUES ('410927', '台前县', '410900');
INSERT INTO pro_city_area VALUES ('410928', '濮阳县', '410900');
INSERT INTO pro_city_area VALUES ('411000', '许昌市', '410000');
INSERT INTO pro_city_area VALUES ('411001', '市辖区', '411000');
INSERT INTO pro_city_area VALUES ('411002', '魏都区', '411000');
INSERT INTO pro_city_area VALUES ('411023', '许昌县', '411000');
INSERT INTO pro_city_area VALUES ('411024', '鄢陵县', '411000');
INSERT INTO pro_city_area VALUES ('411025', '襄城县', '411000');
INSERT INTO pro_city_area VALUES ('411081', '禹州市', '411000');
INSERT INTO pro_city_area VALUES ('411082', '长葛市', '411000');
INSERT INTO pro_city_area VALUES ('411100', '漯河市', '410000');
INSERT INTO pro_city_area VALUES ('411101', '市辖区', '411100');
INSERT INTO pro_city_area VALUES ('411102', '源汇区', '411100');
INSERT INTO pro_city_area VALUES ('411103', '郾城区', '411100');
INSERT INTO pro_city_area VALUES ('411104', '召陵区', '411100');
INSERT INTO pro_city_area VALUES ('411121', '舞阳县', '411100');
INSERT INTO pro_city_area VALUES ('411122', '临颍县', '411100');
INSERT INTO pro_city_area VALUES ('411200', '三门峡市', '410000');
INSERT INTO pro_city_area VALUES ('411201', '市辖区', '411200');
INSERT INTO pro_city_area VALUES ('411202', '湖滨区', '411200');
INSERT INTO pro_city_area VALUES ('411221', '渑池县', '411200');
INSERT INTO pro_city_area VALUES ('411222', '陕　县', '411200');
INSERT INTO pro_city_area VALUES ('411224', '卢氏县', '411200');
INSERT INTO pro_city_area VALUES ('411281', '义马市', '411200');
INSERT INTO pro_city_area VALUES ('411282', '灵宝市', '411200');
INSERT INTO pro_city_area VALUES ('411300', '南阳市', '410000');
INSERT INTO pro_city_area VALUES ('411301', '市辖区', '411300');
INSERT INTO pro_city_area VALUES ('411302', '宛城区', '411300');
INSERT INTO pro_city_area VALUES ('411303', '卧龙区', '411300');
INSERT INTO pro_city_area VALUES ('411321', '南召县', '411300');
INSERT INTO pro_city_area VALUES ('411322', '方城县', '411300');
INSERT INTO pro_city_area VALUES ('411323', '西峡县', '411300');
INSERT INTO pro_city_area VALUES ('411324', '镇平县', '411300');
INSERT INTO pro_city_area VALUES ('411325', '内乡县', '411300');
INSERT INTO pro_city_area VALUES ('411326', '淅川县', '411300');
INSERT INTO pro_city_area VALUES ('411327', '社旗县', '411300');
INSERT INTO pro_city_area VALUES ('411328', '唐河县', '411300');
INSERT INTO pro_city_area VALUES ('411329', '新野县', '411300');
INSERT INTO pro_city_area VALUES ('411330', '桐柏县', '411300');
INSERT INTO pro_city_area VALUES ('411381', '邓州市', '411300');
INSERT INTO pro_city_area VALUES ('411400', '商丘市', '410000');
INSERT INTO pro_city_area VALUES ('411401', '市辖区', '411400');
INSERT INTO pro_city_area VALUES ('411402', '梁园区', '411400');
INSERT INTO pro_city_area VALUES ('411403', '睢阳区', '411400');
INSERT INTO pro_city_area VALUES ('411421', '民权县', '411400');
INSERT INTO pro_city_area VALUES ('411422', '睢　县', '411400');
INSERT INTO pro_city_area VALUES ('411423', '宁陵县', '411400');
INSERT INTO pro_city_area VALUES ('411424', '柘城县', '411400');
INSERT INTO pro_city_area VALUES ('411425', '虞城县', '411400');
INSERT INTO pro_city_area VALUES ('411426', '夏邑县', '411400');
INSERT INTO pro_city_area VALUES ('411481', '永城市', '411400');
INSERT INTO pro_city_area VALUES ('411500', '信阳市', '410000');
INSERT INTO pro_city_area VALUES ('411501', '市辖区', '411500');
INSERT INTO pro_city_area VALUES ('411502', '师河区', '411500');
INSERT INTO pro_city_area VALUES ('411503', '平桥区', '411500');
INSERT INTO pro_city_area VALUES ('411521', '罗山县', '411500');
INSERT INTO pro_city_area VALUES ('411522', '光山县', '411500');
INSERT INTO pro_city_area VALUES ('411523', '新　县', '411500');
INSERT INTO pro_city_area VALUES ('411524', '商城县', '411500');
INSERT INTO pro_city_area VALUES ('411525', '固始县', '411500');
INSERT INTO pro_city_area VALUES ('411526', '潢川县', '411500');
INSERT INTO pro_city_area VALUES ('411527', '淮滨县', '411500');
INSERT INTO pro_city_area VALUES ('411528', '息　县', '411500');
INSERT INTO pro_city_area VALUES ('411600', '周口市', '410000');
INSERT INTO pro_city_area VALUES ('411601', '市辖区', '411600');
INSERT INTO pro_city_area VALUES ('411602', '川汇区', '411600');
INSERT INTO pro_city_area VALUES ('411621', '扶沟县', '411600');
INSERT INTO pro_city_area VALUES ('411622', '西华县', '411600');
INSERT INTO pro_city_area VALUES ('411623', '商水县', '411600');
INSERT INTO pro_city_area VALUES ('411624', '沈丘县', '411600');
INSERT INTO pro_city_area VALUES ('411625', '郸城县', '411600');
INSERT INTO pro_city_area VALUES ('411626', '淮阳县', '411600');
INSERT INTO pro_city_area VALUES ('411627', '太康县', '411600');
INSERT INTO pro_city_area VALUES ('411628', '鹿邑县', '411600');
INSERT INTO pro_city_area VALUES ('411681', '项城市', '411600');
INSERT INTO pro_city_area VALUES ('411700', '驻马店市', '410000');
INSERT INTO pro_city_area VALUES ('411701', '市辖区', '411700');
INSERT INTO pro_city_area VALUES ('411702', '驿城区', '411700');
INSERT INTO pro_city_area VALUES ('411721', '西平县', '411700');
INSERT INTO pro_city_area VALUES ('411722', '上蔡县', '411700');
INSERT INTO pro_city_area VALUES ('411723', '平舆县', '411700');
INSERT INTO pro_city_area VALUES ('411724', '正阳县', '411700');
INSERT INTO pro_city_area VALUES ('411725', '确山县', '411700');
INSERT INTO pro_city_area VALUES ('411726', '泌阳县', '411700');
INSERT INTO pro_city_area VALUES ('411727', '汝南县', '411700');
INSERT INTO pro_city_area VALUES ('411728', '遂平县', '411700');
INSERT INTO pro_city_area VALUES ('411729', '新蔡县', '411700');
INSERT INTO pro_city_area VALUES ('420000', '湖北省', '0');
INSERT INTO pro_city_area VALUES ('420100', '武汉市', '420000');
INSERT INTO pro_city_area VALUES ('420101', '市辖区', '420100');
INSERT INTO pro_city_area VALUES ('420102', '江岸区', '420100');
INSERT INTO pro_city_area VALUES ('420103', '江汉区', '420100');
INSERT INTO pro_city_area VALUES ('420104', '乔口区', '420100');
INSERT INTO pro_city_area VALUES ('420105', '汉阳区', '420100');
INSERT INTO pro_city_area VALUES ('420106', '武昌区', '420100');
INSERT INTO pro_city_area VALUES ('420107', '青山区', '420100');
INSERT INTO pro_city_area VALUES ('420111', '洪山区', '420100');
INSERT INTO pro_city_area VALUES ('420112', '东西湖区', '420100');
INSERT INTO pro_city_area VALUES ('420113', '汉南区', '420100');
INSERT INTO pro_city_area VALUES ('420114', '蔡甸区', '420100');
INSERT INTO pro_city_area VALUES ('420115', '江夏区', '420100');
INSERT INTO pro_city_area VALUES ('420116', '黄陂区', '420100');
INSERT INTO pro_city_area VALUES ('420117', '新洲区', '420100');
INSERT INTO pro_city_area VALUES ('420200', '黄石市', '420000');
INSERT INTO pro_city_area VALUES ('420201', '市辖区', '420200');
INSERT INTO pro_city_area VALUES ('420202', '黄石港区', '420200');
INSERT INTO pro_city_area VALUES ('420203', '西塞山区', '420200');
INSERT INTO pro_city_area VALUES ('420204', '下陆区', '420200');
INSERT INTO pro_city_area VALUES ('420205', '铁山区', '420200');
INSERT INTO pro_city_area VALUES ('420222', '阳新县', '420200');
INSERT INTO pro_city_area VALUES ('420281', '大冶市', '420200');
INSERT INTO pro_city_area VALUES ('420300', '十堰市', '420000');
INSERT INTO pro_city_area VALUES ('420301', '市辖区', '420300');
INSERT INTO pro_city_area VALUES ('420302', '茅箭区', '420300');
INSERT INTO pro_city_area VALUES ('420303', '张湾区', '420300');
INSERT INTO pro_city_area VALUES ('420321', '郧　县', '420300');
INSERT INTO pro_city_area VALUES ('420322', '郧西县', '420300');
INSERT INTO pro_city_area VALUES ('420323', '竹山县', '420300');
INSERT INTO pro_city_area VALUES ('420324', '竹溪县', '420300');
INSERT INTO pro_city_area VALUES ('420325', '房　县', '420300');
INSERT INTO pro_city_area VALUES ('420381', '丹江口市', '420300');
INSERT INTO pro_city_area VALUES ('420500', '宜昌市', '420000');
INSERT INTO pro_city_area VALUES ('420501', '市辖区', '420500');
INSERT INTO pro_city_area VALUES ('420502', '西陵区', '420500');
INSERT INTO pro_city_area VALUES ('420503', '伍家岗区', '420500');
INSERT INTO pro_city_area VALUES ('420504', '点军区', '420500');
INSERT INTO pro_city_area VALUES ('420505', '猇亭区', '420500');
INSERT INTO pro_city_area VALUES ('420506', '夷陵区', '420500');
INSERT INTO pro_city_area VALUES ('420525', '远安县', '420500');
INSERT INTO pro_city_area VALUES ('420526', '兴山县', '420500');
INSERT INTO pro_city_area VALUES ('420527', '秭归县', '420500');
INSERT INTO pro_city_area VALUES ('420528', '长阳土家族自治县', '420500');
INSERT INTO pro_city_area VALUES ('420529', '五峰土家族自治县', '420500');
INSERT INTO pro_city_area VALUES ('420581', '宜都市', '420500');
INSERT INTO pro_city_area VALUES ('420582', '当阳市', '420500');
INSERT INTO pro_city_area VALUES ('420583', '枝江市', '420500');
INSERT INTO pro_city_area VALUES ('420600', '襄樊市', '420000');
INSERT INTO pro_city_area VALUES ('420601', '市辖区', '420600');
INSERT INTO pro_city_area VALUES ('420602', '襄城区', '420600');
INSERT INTO pro_city_area VALUES ('420606', '樊城区', '420600');
INSERT INTO pro_city_area VALUES ('420607', '襄阳区', '420600');
INSERT INTO pro_city_area VALUES ('420624', '南漳县', '420600');
INSERT INTO pro_city_area VALUES ('420625', '谷城县', '420600');
INSERT INTO pro_city_area VALUES ('420626', '保康县', '420600');
INSERT INTO pro_city_area VALUES ('420682', '老河口市', '420600');
INSERT INTO pro_city_area VALUES ('420683', '枣阳市', '420600');
INSERT INTO pro_city_area VALUES ('420684', '宜城市', '420600');
INSERT INTO pro_city_area VALUES ('420700', '鄂州市', '420000');
INSERT INTO pro_city_area VALUES ('420701', '市辖区', '420700');
INSERT INTO pro_city_area VALUES ('420702', '梁子湖区', '420700');
INSERT INTO pro_city_area VALUES ('420703', '华容区', '420700');
INSERT INTO pro_city_area VALUES ('420704', '鄂城区', '420700');
INSERT INTO pro_city_area VALUES ('420800', '荆门市', '420000');
INSERT INTO pro_city_area VALUES ('420801', '市辖区', '420800');
INSERT INTO pro_city_area VALUES ('420802', '东宝区', '420800');
INSERT INTO pro_city_area VALUES ('420804', '掇刀区', '420800');
INSERT INTO pro_city_area VALUES ('420821', '京山县', '420800');
INSERT INTO pro_city_area VALUES ('420822', '沙洋县', '420800');
INSERT INTO pro_city_area VALUES ('420881', '钟祥市', '420800');
INSERT INTO pro_city_area VALUES ('420900', '孝感市', '420000');
INSERT INTO pro_city_area VALUES ('420901', '市辖区', '420900');
INSERT INTO pro_city_area VALUES ('420902', '孝南区', '420900');
INSERT INTO pro_city_area VALUES ('420921', '孝昌县', '420900');
INSERT INTO pro_city_area VALUES ('420922', '大悟县', '420900');
INSERT INTO pro_city_area VALUES ('420923', '云梦县', '420900');
INSERT INTO pro_city_area VALUES ('420981', '应城市', '420900');
INSERT INTO pro_city_area VALUES ('420982', '安陆市', '420900');
INSERT INTO pro_city_area VALUES ('420984', '汉川市', '420900');
INSERT INTO pro_city_area VALUES ('421000', '荆州市', '420000');
INSERT INTO pro_city_area VALUES ('421001', '市辖区', '421000');
INSERT INTO pro_city_area VALUES ('421002', '沙市区', '421000');
INSERT INTO pro_city_area VALUES ('421003', '荆州区', '421000');
INSERT INTO pro_city_area VALUES ('421022', '公安县', '421000');
INSERT INTO pro_city_area VALUES ('421023', '监利县', '421000');
INSERT INTO pro_city_area VALUES ('421024', '江陵县', '421000');
INSERT INTO pro_city_area VALUES ('421081', '石首市', '421000');
INSERT INTO pro_city_area VALUES ('421083', '洪湖市', '421000');
INSERT INTO pro_city_area VALUES ('421087', '松滋市', '421000');
INSERT INTO pro_city_area VALUES ('421100', '黄冈市', '420000');
INSERT INTO pro_city_area VALUES ('421101', '市辖区', '421100');
INSERT INTO pro_city_area VALUES ('421102', '黄州区', '421100');
INSERT INTO pro_city_area VALUES ('421121', '团风县', '421100');
INSERT INTO pro_city_area VALUES ('421122', '红安县', '421100');
INSERT INTO pro_city_area VALUES ('421123', '罗田县', '421100');
INSERT INTO pro_city_area VALUES ('421124', '英山县', '421100');
INSERT INTO pro_city_area VALUES ('421125', '浠水县', '421100');
INSERT INTO pro_city_area VALUES ('421126', '蕲春县', '421100');
INSERT INTO pro_city_area VALUES ('421127', '黄梅县', '421100');
INSERT INTO pro_city_area VALUES ('421181', '麻城市', '421100');
INSERT INTO pro_city_area VALUES ('421182', '武穴市', '421100');
INSERT INTO pro_city_area VALUES ('421200', '咸宁市', '420000');
INSERT INTO pro_city_area VALUES ('421201', '市辖区', '421200');
INSERT INTO pro_city_area VALUES ('421202', '咸安区', '421200');
INSERT INTO pro_city_area VALUES ('421221', '嘉鱼县', '421200');
INSERT INTO pro_city_area VALUES ('421222', '通城县', '421200');
INSERT INTO pro_city_area VALUES ('421223', '崇阳县', '421200');
INSERT INTO pro_city_area VALUES ('421224', '通山县', '421200');
INSERT INTO pro_city_area VALUES ('421281', '赤壁市', '421200');
INSERT INTO pro_city_area VALUES ('421300', '随州市', '420000');
INSERT INTO pro_city_area VALUES ('421301', '市辖区', '421300');
INSERT INTO pro_city_area VALUES ('421302', '曾都区', '421300');
INSERT INTO pro_city_area VALUES ('421381', '广水市', '421300');
INSERT INTO pro_city_area VALUES ('422800', '恩施土家族苗族自治州', '420000');
INSERT INTO pro_city_area VALUES ('422801', '恩施市', '422800');
INSERT INTO pro_city_area VALUES ('422802', '利川市', '422800');
INSERT INTO pro_city_area VALUES ('422822', '建始县', '422800');
INSERT INTO pro_city_area VALUES ('422823', '巴东县', '422800');
INSERT INTO pro_city_area VALUES ('422825', '宣恩县', '422800');
INSERT INTO pro_city_area VALUES ('422826', '咸丰县', '422800');
INSERT INTO pro_city_area VALUES ('422827', '来凤县', '422800');
INSERT INTO pro_city_area VALUES ('422828', '鹤峰县', '422800');
INSERT INTO pro_city_area VALUES ('429000', '省直辖行政单位', '420000');
INSERT INTO pro_city_area VALUES ('429004', '仙桃市', '429000');
INSERT INTO pro_city_area VALUES ('429005', '潜江市', '429000');
INSERT INTO pro_city_area VALUES ('429006', '天门市', '429000');
INSERT INTO pro_city_area VALUES ('429021', '神农架林区', '429000');
INSERT INTO pro_city_area VALUES ('430000', '湖南省', '0');
INSERT INTO pro_city_area VALUES ('430100', '长沙市', '430000');
INSERT INTO pro_city_area VALUES ('430101', '市辖区', '430100');
INSERT INTO pro_city_area VALUES ('430102', '芙蓉区', '430100');
INSERT INTO pro_city_area VALUES ('430103', '天心区', '430100');
INSERT INTO pro_city_area VALUES ('430104', '岳麓区', '430100');
INSERT INTO pro_city_area VALUES ('430105', '开福区', '430100');
INSERT INTO pro_city_area VALUES ('430111', '雨花区', '430100');
INSERT INTO pro_city_area VALUES ('430121', '长沙县', '430100');
INSERT INTO pro_city_area VALUES ('430122', '望城县', '430100');
INSERT INTO pro_city_area VALUES ('430124', '宁乡县', '430100');
INSERT INTO pro_city_area VALUES ('430181', '浏阳市', '430100');
INSERT INTO pro_city_area VALUES ('430200', '株洲市', '430000');
INSERT INTO pro_city_area VALUES ('430201', '市辖区', '430200');
INSERT INTO pro_city_area VALUES ('430202', '荷塘区', '430200');
INSERT INTO pro_city_area VALUES ('430203', '芦淞区', '430200');
INSERT INTO pro_city_area VALUES ('430204', '石峰区', '430200');
INSERT INTO pro_city_area VALUES ('430211', '天元区', '430200');
INSERT INTO pro_city_area VALUES ('430221', '株洲县', '430200');
INSERT INTO pro_city_area VALUES ('430223', '攸　县', '430200');
INSERT INTO pro_city_area VALUES ('430224', '茶陵县', '430200');
INSERT INTO pro_city_area VALUES ('430225', '炎陵县', '430200');
INSERT INTO pro_city_area VALUES ('430281', '醴陵市', '430200');
INSERT INTO pro_city_area VALUES ('430300', '湘潭市', '430000');
INSERT INTO pro_city_area VALUES ('430301', '市辖区', '430300');
INSERT INTO pro_city_area VALUES ('430302', '雨湖区', '430300');
INSERT INTO pro_city_area VALUES ('430304', '岳塘区', '430300');
INSERT INTO pro_city_area VALUES ('430321', '湘潭县', '430300');
INSERT INTO pro_city_area VALUES ('430381', '湘乡市', '430300');
INSERT INTO pro_city_area VALUES ('430382', '韶山市', '430300');
INSERT INTO pro_city_area VALUES ('430400', '衡阳市', '430000');
INSERT INTO pro_city_area VALUES ('430401', '市辖区', '430400');
INSERT INTO pro_city_area VALUES ('430405', '珠晖区', '430400');
INSERT INTO pro_city_area VALUES ('430406', '雁峰区', '430400');
INSERT INTO pro_city_area VALUES ('430407', '石鼓区', '430400');
INSERT INTO pro_city_area VALUES ('430408', '蒸湘区', '430400');
INSERT INTO pro_city_area VALUES ('430412', '南岳区', '430400');
INSERT INTO pro_city_area VALUES ('430421', '衡阳县', '430400');
INSERT INTO pro_city_area VALUES ('430422', '衡南县', '430400');
INSERT INTO pro_city_area VALUES ('430423', '衡山县', '430400');
INSERT INTO pro_city_area VALUES ('430424', '衡东县', '430400');
INSERT INTO pro_city_area VALUES ('430426', '祁东县', '430400');
INSERT INTO pro_city_area VALUES ('430481', '耒阳市', '430400');
INSERT INTO pro_city_area VALUES ('430482', '常宁市', '430400');
INSERT INTO pro_city_area VALUES ('430500', '邵阳市', '430000');
INSERT INTO pro_city_area VALUES ('430501', '市辖区', '430500');
INSERT INTO pro_city_area VALUES ('430502', '双清区', '430500');
INSERT INTO pro_city_area VALUES ('430503', '大祥区', '430500');
INSERT INTO pro_city_area VALUES ('430511', '北塔区', '430500');
INSERT INTO pro_city_area VALUES ('430521', '邵东县', '430500');
INSERT INTO pro_city_area VALUES ('430522', '新邵县', '430500');
INSERT INTO pro_city_area VALUES ('430523', '邵阳县', '430500');
INSERT INTO pro_city_area VALUES ('430524', '隆回县', '430500');
INSERT INTO pro_city_area VALUES ('430525', '洞口县', '430500');
INSERT INTO pro_city_area VALUES ('430527', '绥宁县', '430500');
INSERT INTO pro_city_area VALUES ('430528', '新宁县', '430500');
INSERT INTO pro_city_area VALUES ('430529', '城步苗族自治县', '430500');
INSERT INTO pro_city_area VALUES ('430581', '武冈市', '430500');
INSERT INTO pro_city_area VALUES ('430600', '岳阳市', '430000');
INSERT INTO pro_city_area VALUES ('430601', '市辖区', '430600');
INSERT INTO pro_city_area VALUES ('430602', '岳阳楼区', '430600');
INSERT INTO pro_city_area VALUES ('430603', '云溪区', '430600');
INSERT INTO pro_city_area VALUES ('430611', '君山区', '430600');
INSERT INTO pro_city_area VALUES ('430621', '岳阳县', '430600');
INSERT INTO pro_city_area VALUES ('430623', '华容县', '430600');
INSERT INTO pro_city_area VALUES ('430624', '湘阴县', '430600');
INSERT INTO pro_city_area VALUES ('430626', '平江县', '430600');
INSERT INTO pro_city_area VALUES ('430681', '汨罗市', '430600');
INSERT INTO pro_city_area VALUES ('430682', '临湘市', '430600');
INSERT INTO pro_city_area VALUES ('430700', '常德市', '430000');
INSERT INTO pro_city_area VALUES ('430701', '市辖区', '430700');
INSERT INTO pro_city_area VALUES ('430702', '武陵区', '430700');
INSERT INTO pro_city_area VALUES ('430703', '鼎城区', '430700');
INSERT INTO pro_city_area VALUES ('430721', '安乡县', '430700');
INSERT INTO pro_city_area VALUES ('430722', '汉寿县', '430700');
INSERT INTO pro_city_area VALUES ('430723', '澧　县', '430700');
INSERT INTO pro_city_area VALUES ('430724', '临澧县', '430700');
INSERT INTO pro_city_area VALUES ('430725', '桃源县', '430700');
INSERT INTO pro_city_area VALUES ('430726', '石门县', '430700');
INSERT INTO pro_city_area VALUES ('430781', '津市市', '430700');
INSERT INTO pro_city_area VALUES ('430800', '张家界市', '430000');
INSERT INTO pro_city_area VALUES ('430801', '市辖区', '430800');
INSERT INTO pro_city_area VALUES ('430802', '永定区', '430800');
INSERT INTO pro_city_area VALUES ('430811', '武陵源区', '430800');
INSERT INTO pro_city_area VALUES ('430821', '慈利县', '430800');
INSERT INTO pro_city_area VALUES ('430822', '桑植县', '430800');
INSERT INTO pro_city_area VALUES ('430900', '益阳市', '430000');
INSERT INTO pro_city_area VALUES ('430901', '市辖区', '430900');
INSERT INTO pro_city_area VALUES ('430902', '资阳区', '430900');
INSERT INTO pro_city_area VALUES ('430903', '赫山区', '430900');
INSERT INTO pro_city_area VALUES ('430921', '南　县', '430900');
INSERT INTO pro_city_area VALUES ('430922', '桃江县', '430900');
INSERT INTO pro_city_area VALUES ('430923', '安化县', '430900');
INSERT INTO pro_city_area VALUES ('430981', '沅江市', '430900');
INSERT INTO pro_city_area VALUES ('431000', '郴州市', '430000');
INSERT INTO pro_city_area VALUES ('431001', '市辖区', '431000');
INSERT INTO pro_city_area VALUES ('431002', '北湖区', '431000');
INSERT INTO pro_city_area VALUES ('431003', '苏仙区', '431000');
INSERT INTO pro_city_area VALUES ('431021', '桂阳县', '431000');
INSERT INTO pro_city_area VALUES ('431022', '宜章县', '431000');
INSERT INTO pro_city_area VALUES ('431023', '永兴县', '431000');
INSERT INTO pro_city_area VALUES ('431024', '嘉禾县', '431000');
INSERT INTO pro_city_area VALUES ('431025', '临武县', '431000');
INSERT INTO pro_city_area VALUES ('431026', '汝城县', '431000');
INSERT INTO pro_city_area VALUES ('431027', '桂东县', '431000');
INSERT INTO pro_city_area VALUES ('431028', '安仁县', '431000');
INSERT INTO pro_city_area VALUES ('431081', '资兴市', '431000');
INSERT INTO pro_city_area VALUES ('431100', '永州市', '430000');
INSERT INTO pro_city_area VALUES ('431101', '市辖区', '431100');
INSERT INTO pro_city_area VALUES ('431102', '芝山区', '431100');
INSERT INTO pro_city_area VALUES ('431103', '冷水滩区', '431100');
INSERT INTO pro_city_area VALUES ('431121', '祁阳县', '431100');
INSERT INTO pro_city_area VALUES ('431122', '东安县', '431100');
INSERT INTO pro_city_area VALUES ('431123', '双牌县', '431100');
INSERT INTO pro_city_area VALUES ('431124', '道　县', '431100');
INSERT INTO pro_city_area VALUES ('431125', '江永县', '431100');
INSERT INTO pro_city_area VALUES ('431126', '宁远县', '431100');
INSERT INTO pro_city_area VALUES ('431127', '蓝山县', '431100');
INSERT INTO pro_city_area VALUES ('431128', '新田县', '431100');
INSERT INTO pro_city_area VALUES ('431129', '江华瑶族自治县', '431100');
INSERT INTO pro_city_area VALUES ('431200', '怀化市', '430000');
INSERT INTO pro_city_area VALUES ('431201', '市辖区', '431200');
INSERT INTO pro_city_area VALUES ('431202', '鹤城区', '431200');
INSERT INTO pro_city_area VALUES ('431221', '中方县', '431200');
INSERT INTO pro_city_area VALUES ('431222', '沅陵县', '431200');
INSERT INTO pro_city_area VALUES ('431223', '辰溪县', '431200');
INSERT INTO pro_city_area VALUES ('431224', '溆浦县', '431200');
INSERT INTO pro_city_area VALUES ('431225', '会同县', '431200');
INSERT INTO pro_city_area VALUES ('431226', '麻阳苗族自治县', '431200');
INSERT INTO pro_city_area VALUES ('431227', '新晃侗族自治县', '431200');
INSERT INTO pro_city_area VALUES ('431228', '芷江侗族自治县', '431200');
INSERT INTO pro_city_area VALUES ('431229', '靖州苗族侗族自治县', '431200');
INSERT INTO pro_city_area VALUES ('431230', '通道侗族自治县', '431200');
INSERT INTO pro_city_area VALUES ('431281', '洪江市', '431200');
INSERT INTO pro_city_area VALUES ('431300', '娄底市', '430000');
INSERT INTO pro_city_area VALUES ('431301', '市辖区', '431300');
INSERT INTO pro_city_area VALUES ('431302', '娄星区', '431300');
INSERT INTO pro_city_area VALUES ('431321', '双峰县', '431300');
INSERT INTO pro_city_area VALUES ('431322', '新化县', '431300');
INSERT INTO pro_city_area VALUES ('431381', '冷水江市', '431300');
INSERT INTO pro_city_area VALUES ('431382', '涟源市', '431300');
INSERT INTO pro_city_area VALUES ('433100', '湘西土家族苗族自治州', '430000');
INSERT INTO pro_city_area VALUES ('433101', '吉首市', '433100');
INSERT INTO pro_city_area VALUES ('433122', '泸溪县', '433100');
INSERT INTO pro_city_area VALUES ('433123', '凤凰县', '433100');
INSERT INTO pro_city_area VALUES ('433124', '花垣县', '433100');
INSERT INTO pro_city_area VALUES ('433125', '保靖县', '433100');
INSERT INTO pro_city_area VALUES ('433126', '古丈县', '433100');
INSERT INTO pro_city_area VALUES ('433127', '永顺县', '433100');
INSERT INTO pro_city_area VALUES ('433130', '龙山县', '433100');
INSERT INTO pro_city_area VALUES ('440000', '广东省', '0');
INSERT INTO pro_city_area VALUES ('440100', '广州市', '440000');
INSERT INTO pro_city_area VALUES ('440101', '市辖区', '440100');
INSERT INTO pro_city_area VALUES ('440102', '东山区', '440100');
INSERT INTO pro_city_area VALUES ('440103', '荔湾区', '440100');
INSERT INTO pro_city_area VALUES ('440104', '越秀区', '440100');
INSERT INTO pro_city_area VALUES ('440105', '海珠区', '440100');
INSERT INTO pro_city_area VALUES ('440106', '天河区', '440100');
INSERT INTO pro_city_area VALUES ('440107', '芳村区', '440100');
INSERT INTO pro_city_area VALUES ('440111', '白云区', '440100');
INSERT INTO pro_city_area VALUES ('440112', '黄埔区', '440100');
INSERT INTO pro_city_area VALUES ('440113', '番禺区', '440100');
INSERT INTO pro_city_area VALUES ('440114', '花都区', '440100');
INSERT INTO pro_city_area VALUES ('440183', '增城市', '440100');
INSERT INTO pro_city_area VALUES ('440184', '从化市', '440100');
INSERT INTO pro_city_area VALUES ('440200', '韶关市', '440000');
INSERT INTO pro_city_area VALUES ('440201', '市辖区', '440200');
INSERT INTO pro_city_area VALUES ('440203', '武江区', '440200');
INSERT INTO pro_city_area VALUES ('440204', '浈江区', '440200');
INSERT INTO pro_city_area VALUES ('440205', '曲江区', '440200');
INSERT INTO pro_city_area VALUES ('440222', '始兴县', '440200');
INSERT INTO pro_city_area VALUES ('440224', '仁化县', '440200');
INSERT INTO pro_city_area VALUES ('440229', '翁源县', '440200');
INSERT INTO pro_city_area VALUES ('440232', '乳源瑶族自治县', '440200');
INSERT INTO pro_city_area VALUES ('440233', '新丰县', '440200');
INSERT INTO pro_city_area VALUES ('440281', '乐昌市', '440200');
INSERT INTO pro_city_area VALUES ('440282', '南雄市', '440200');
INSERT INTO pro_city_area VALUES ('440300', '深圳市', '440000');
INSERT INTO pro_city_area VALUES ('440301', '市辖区', '440300');
INSERT INTO pro_city_area VALUES ('440303', '罗湖区', '440300');
INSERT INTO pro_city_area VALUES ('440304', '福田区', '440300');
INSERT INTO pro_city_area VALUES ('440305', '南山区', '440300');
INSERT INTO pro_city_area VALUES ('440306', '宝安区', '440300');
INSERT INTO pro_city_area VALUES ('440307', '龙岗区', '440300');
INSERT INTO pro_city_area VALUES ('440308', '盐田区', '440300');
INSERT INTO pro_city_area VALUES ('440400', '珠海市', '440000');
INSERT INTO pro_city_area VALUES ('440401', '市辖区', '440400');
INSERT INTO pro_city_area VALUES ('440402', '香洲区', '440400');
INSERT INTO pro_city_area VALUES ('440403', '斗门区', '440400');
INSERT INTO pro_city_area VALUES ('440404', '金湾区', '440400');
INSERT INTO pro_city_area VALUES ('440500', '汕头市', '440000');
INSERT INTO pro_city_area VALUES ('440501', '市辖区', '440500');
INSERT INTO pro_city_area VALUES ('440507', '龙湖区', '440500');
INSERT INTO pro_city_area VALUES ('440511', '金平区', '440500');
INSERT INTO pro_city_area VALUES ('440512', '濠江区', '440500');
INSERT INTO pro_city_area VALUES ('440513', '潮阳区', '440500');
INSERT INTO pro_city_area VALUES ('440514', '潮南区', '440500');
INSERT INTO pro_city_area VALUES ('440515', '澄海区', '440500');
INSERT INTO pro_city_area VALUES ('440523', '南澳县', '440500');
INSERT INTO pro_city_area VALUES ('440600', '佛山市', '440000');
INSERT INTO pro_city_area VALUES ('440601', '市辖区', '440600');
INSERT INTO pro_city_area VALUES ('440604', '禅城区', '440600');
INSERT INTO pro_city_area VALUES ('440605', '南海区', '440600');
INSERT INTO pro_city_area VALUES ('440606', '顺德区', '440600');
INSERT INTO pro_city_area VALUES ('440607', '三水区', '440600');
INSERT INTO pro_city_area VALUES ('440608', '高明区', '440600');
INSERT INTO pro_city_area VALUES ('440700', '江门市', '440000');
INSERT INTO pro_city_area VALUES ('440701', '市辖区', '440700');
INSERT INTO pro_city_area VALUES ('440703', '蓬江区', '440700');
INSERT INTO pro_city_area VALUES ('440704', '江海区', '440700');
INSERT INTO pro_city_area VALUES ('440705', '新会区', '440700');
INSERT INTO pro_city_area VALUES ('440781', '台山市', '440700');
INSERT INTO pro_city_area VALUES ('440783', '开平市', '440700');
INSERT INTO pro_city_area VALUES ('440784', '鹤山市', '440700');
INSERT INTO pro_city_area VALUES ('440785', '恩平市', '440700');
INSERT INTO pro_city_area VALUES ('440800', '湛江市', '440000');
INSERT INTO pro_city_area VALUES ('440801', '市辖区', '440800');
INSERT INTO pro_city_area VALUES ('440802', '赤坎区', '440800');
INSERT INTO pro_city_area VALUES ('440803', '霞山区', '440800');
INSERT INTO pro_city_area VALUES ('440804', '坡头区', '440800');
INSERT INTO pro_city_area VALUES ('440811', '麻章区', '440800');
INSERT INTO pro_city_area VALUES ('440823', '遂溪县', '440800');
INSERT INTO pro_city_area VALUES ('440825', '徐闻县', '440800');
INSERT INTO pro_city_area VALUES ('440881', '廉江市', '440800');
INSERT INTO pro_city_area VALUES ('440882', '雷州市', '440800');
INSERT INTO pro_city_area VALUES ('440883', '吴川市', '440800');
INSERT INTO pro_city_area VALUES ('440900', '茂名市', '440000');
INSERT INTO pro_city_area VALUES ('440901', '市辖区', '440900');
INSERT INTO pro_city_area VALUES ('440902', '茂南区', '440900');
INSERT INTO pro_city_area VALUES ('440903', '茂港区', '440900');
INSERT INTO pro_city_area VALUES ('440923', '电白县', '440900');
INSERT INTO pro_city_area VALUES ('440981', '高州市', '440900');
INSERT INTO pro_city_area VALUES ('440982', '化州市', '440900');
INSERT INTO pro_city_area VALUES ('440983', '信宜市', '440900');
INSERT INTO pro_city_area VALUES ('441200', '肇庆市', '440000');
INSERT INTO pro_city_area VALUES ('441201', '市辖区', '441200');
INSERT INTO pro_city_area VALUES ('441202', '端州区', '441200');
INSERT INTO pro_city_area VALUES ('441203', '鼎湖区', '441200');
INSERT INTO pro_city_area VALUES ('441223', '广宁县', '441200');
INSERT INTO pro_city_area VALUES ('441224', '怀集县', '441200');
INSERT INTO pro_city_area VALUES ('441225', '封开县', '441200');
INSERT INTO pro_city_area VALUES ('441226', '德庆县', '441200');
INSERT INTO pro_city_area VALUES ('441283', '高要市', '441200');
INSERT INTO pro_city_area VALUES ('441284', '四会市', '441200');
INSERT INTO pro_city_area VALUES ('441300', '惠州市', '440000');
INSERT INTO pro_city_area VALUES ('441301', '市辖区', '441300');
INSERT INTO pro_city_area VALUES ('441302', '惠城区', '441300');
INSERT INTO pro_city_area VALUES ('441303', '惠阳区', '441300');
INSERT INTO pro_city_area VALUES ('441322', '博罗县', '441300');
INSERT INTO pro_city_area VALUES ('441323', '惠东县', '441300');
INSERT INTO pro_city_area VALUES ('441324', '龙门县', '441300');
INSERT INTO pro_city_area VALUES ('441400', '梅州市', '440000');
INSERT INTO pro_city_area VALUES ('441401', '市辖区', '441400');
INSERT INTO pro_city_area VALUES ('441402', '梅江区', '441400');
INSERT INTO pro_city_area VALUES ('441421', '梅　县', '441400');
INSERT INTO pro_city_area VALUES ('441422', '大埔县', '441400');
INSERT INTO pro_city_area VALUES ('441423', '丰顺县', '441400');
INSERT INTO pro_city_area VALUES ('441424', '五华县', '441400');
INSERT INTO pro_city_area VALUES ('441426', '平远县', '441400');
INSERT INTO pro_city_area VALUES ('441427', '蕉岭县', '441400');
INSERT INTO pro_city_area VALUES ('441481', '兴宁市', '441400');
INSERT INTO pro_city_area VALUES ('441500', '汕尾市', '440000');
INSERT INTO pro_city_area VALUES ('441501', '市辖区', '441500');
INSERT INTO pro_city_area VALUES ('441502', '城　区', '441500');
INSERT INTO pro_city_area VALUES ('441521', '海丰县', '441500');
INSERT INTO pro_city_area VALUES ('441523', '陆河县', '441500');
INSERT INTO pro_city_area VALUES ('441581', '陆丰市', '441500');
INSERT INTO pro_city_area VALUES ('441600', '河源市', '440000');
INSERT INTO pro_city_area VALUES ('441601', '市辖区', '441600');
INSERT INTO pro_city_area VALUES ('441602', '源城区', '441600');
INSERT INTO pro_city_area VALUES ('441621', '紫金县', '441600');
INSERT INTO pro_city_area VALUES ('441622', '龙川县', '441600');
INSERT INTO pro_city_area VALUES ('441623', '连平县', '441600');
INSERT INTO pro_city_area VALUES ('441624', '和平县', '441600');
INSERT INTO pro_city_area VALUES ('441625', '东源县', '441600');
INSERT INTO pro_city_area VALUES ('441700', '阳江市', '440000');
INSERT INTO pro_city_area VALUES ('441701', '市辖区', '441700');
INSERT INTO pro_city_area VALUES ('441702', '江城区', '441700');
INSERT INTO pro_city_area VALUES ('441721', '阳西县', '441700');
INSERT INTO pro_city_area VALUES ('441723', '阳东县', '441700');
INSERT INTO pro_city_area VALUES ('441781', '阳春市', '441700');
INSERT INTO pro_city_area VALUES ('441800', '清远市', '440000');
INSERT INTO pro_city_area VALUES ('441801', '市辖区', '441800');
INSERT INTO pro_city_area VALUES ('441802', '清城区', '441800');
INSERT INTO pro_city_area VALUES ('441821', '佛冈县', '441800');
INSERT INTO pro_city_area VALUES ('441823', '阳山县', '441800');
INSERT INTO pro_city_area VALUES ('441825', '连山壮族瑶族自治县', '441800');
INSERT INTO pro_city_area VALUES ('441826', '连南瑶族自治县', '441800');
INSERT INTO pro_city_area VALUES ('441827', '清新县', '441800');
INSERT INTO pro_city_area VALUES ('441881', '英德市', '441800');
INSERT INTO pro_city_area VALUES ('441882', '连州市', '441800');
INSERT INTO pro_city_area VALUES ('441900', '东莞市', '440000');
INSERT INTO pro_city_area VALUES ('442000', '中山市', '440000');
INSERT INTO pro_city_area VALUES ('445100', '潮州市', '440000');
INSERT INTO pro_city_area VALUES ('445101', '市辖区', '445100');
INSERT INTO pro_city_area VALUES ('445102', '湘桥区', '445100');
INSERT INTO pro_city_area VALUES ('445121', '潮安县', '445100');
INSERT INTO pro_city_area VALUES ('445122', '饶平县', '445100');
INSERT INTO pro_city_area VALUES ('445200', '揭阳市', '440000');
INSERT INTO pro_city_area VALUES ('445201', '市辖区', '445200');
INSERT INTO pro_city_area VALUES ('445202', '榕城区', '445200');
INSERT INTO pro_city_area VALUES ('445221', '揭东县', '445200');
INSERT INTO pro_city_area VALUES ('445222', '揭西县', '445200');
INSERT INTO pro_city_area VALUES ('445224', '惠来县', '445200');
INSERT INTO pro_city_area VALUES ('445281', '普宁市', '445200');
INSERT INTO pro_city_area VALUES ('445300', '云浮市', '440000');
INSERT INTO pro_city_area VALUES ('445301', '市辖区', '445300');
INSERT INTO pro_city_area VALUES ('445302', '云城区', '445300');
INSERT INTO pro_city_area VALUES ('445321', '新兴县', '445300');
INSERT INTO pro_city_area VALUES ('445322', '郁南县', '445300');
INSERT INTO pro_city_area VALUES ('445323', '云安县', '445300');
INSERT INTO pro_city_area VALUES ('445381', '罗定市', '445300');
INSERT INTO pro_city_area VALUES ('450000', '广  西', '0');
INSERT INTO pro_city_area VALUES ('450100', '南宁市', '450000');
INSERT INTO pro_city_area VALUES ('450101', '市辖区', '450100');
INSERT INTO pro_city_area VALUES ('450102', '兴宁区', '450100');
INSERT INTO pro_city_area VALUES ('450103', '青秀区', '450100');
INSERT INTO pro_city_area VALUES ('450105', '江南区', '450100');
INSERT INTO pro_city_area VALUES ('450107', '西乡塘区', '450100');
INSERT INTO pro_city_area VALUES ('450108', '良庆区', '450100');
INSERT INTO pro_city_area VALUES ('450109', '邕宁区', '450100');
INSERT INTO pro_city_area VALUES ('450122', '武鸣县', '450100');
INSERT INTO pro_city_area VALUES ('450123', '隆安县', '450100');
INSERT INTO pro_city_area VALUES ('450124', '马山县', '450100');
INSERT INTO pro_city_area VALUES ('450125', '上林县', '450100');
INSERT INTO pro_city_area VALUES ('450126', '宾阳县', '450100');
INSERT INTO pro_city_area VALUES ('450127', '横　县', '450100');
INSERT INTO pro_city_area VALUES ('450200', '柳州市', '450000');
INSERT INTO pro_city_area VALUES ('450201', '市辖区', '450200');
INSERT INTO pro_city_area VALUES ('450202', '城中区', '450200');
INSERT INTO pro_city_area VALUES ('450203', '鱼峰区', '450200');
INSERT INTO pro_city_area VALUES ('450204', '柳南区', '450200');
INSERT INTO pro_city_area VALUES ('450205', '柳北区', '450200');
INSERT INTO pro_city_area VALUES ('450221', '柳江县', '450200');
INSERT INTO pro_city_area VALUES ('450222', '柳城县', '450200');
INSERT INTO pro_city_area VALUES ('450223', '鹿寨县', '450200');
INSERT INTO pro_city_area VALUES ('450224', '融安县', '450200');
INSERT INTO pro_city_area VALUES ('450225', '融水苗族自治县', '450200');
INSERT INTO pro_city_area VALUES ('450226', '三江侗族自治县', '450200');
INSERT INTO pro_city_area VALUES ('450300', '桂林市', '450000');
INSERT INTO pro_city_area VALUES ('450301', '市辖区', '450300');
INSERT INTO pro_city_area VALUES ('450302', '秀峰区', '450300');
INSERT INTO pro_city_area VALUES ('450303', '叠彩区', '450300');
INSERT INTO pro_city_area VALUES ('450304', '象山区', '450300');
INSERT INTO pro_city_area VALUES ('450305', '七星区', '450300');
INSERT INTO pro_city_area VALUES ('450311', '雁山区', '450300');
INSERT INTO pro_city_area VALUES ('450321', '阳朔县', '450300');
INSERT INTO pro_city_area VALUES ('450322', '临桂县', '450300');
INSERT INTO pro_city_area VALUES ('450323', '灵川县', '450300');
INSERT INTO pro_city_area VALUES ('450324', '全州县', '450300');
INSERT INTO pro_city_area VALUES ('450325', '兴安县', '450300');
INSERT INTO pro_city_area VALUES ('450326', '永福县', '450300');
INSERT INTO pro_city_area VALUES ('450327', '灌阳县', '450300');
INSERT INTO pro_city_area VALUES ('450328', '龙胜各族自治县', '450300');
INSERT INTO pro_city_area VALUES ('450329', '资源县', '450300');
INSERT INTO pro_city_area VALUES ('450330', '平乐县', '450300');
INSERT INTO pro_city_area VALUES ('450331', '荔蒲县', '450300');
INSERT INTO pro_city_area VALUES ('450332', '恭城瑶族自治县', '450300');
INSERT INTO pro_city_area VALUES ('450400', '梧州市', '450000');
INSERT INTO pro_city_area VALUES ('450401', '市辖区', '450400');
INSERT INTO pro_city_area VALUES ('450403', '万秀区', '450400');
INSERT INTO pro_city_area VALUES ('450404', '蝶山区', '450400');
INSERT INTO pro_city_area VALUES ('450405', '长洲区', '450400');
INSERT INTO pro_city_area VALUES ('450421', '苍梧县', '450400');
INSERT INTO pro_city_area VALUES ('450422', '藤　县', '450400');
INSERT INTO pro_city_area VALUES ('450423', '蒙山县', '450400');
INSERT INTO pro_city_area VALUES ('450481', '岑溪市', '450400');
INSERT INTO pro_city_area VALUES ('450500', '北海市', '450000');
INSERT INTO pro_city_area VALUES ('450501', '市辖区', '450500');
INSERT INTO pro_city_area VALUES ('450502', '海城区', '450500');
INSERT INTO pro_city_area VALUES ('450503', '银海区', '450500');
INSERT INTO pro_city_area VALUES ('450512', '铁山港区', '450500');
INSERT INTO pro_city_area VALUES ('450521', '合浦县', '450500');
INSERT INTO pro_city_area VALUES ('450600', '防城港市', '450000');
INSERT INTO pro_city_area VALUES ('450601', '市辖区', '450600');
INSERT INTO pro_city_area VALUES ('450602', '港口区', '450600');
INSERT INTO pro_city_area VALUES ('450603', '防城区', '450600');
INSERT INTO pro_city_area VALUES ('450621', '上思县', '450600');
INSERT INTO pro_city_area VALUES ('450681', '东兴市', '450600');
INSERT INTO pro_city_area VALUES ('450700', '钦州市', '450000');
INSERT INTO pro_city_area VALUES ('450701', '市辖区', '450700');
INSERT INTO pro_city_area VALUES ('450702', '钦南区', '450700');
INSERT INTO pro_city_area VALUES ('450703', '钦北区', '450700');
INSERT INTO pro_city_area VALUES ('450721', '灵山县', '450700');
INSERT INTO pro_city_area VALUES ('450722', '浦北县', '450700');
INSERT INTO pro_city_area VALUES ('450800', '贵港市', '450000');
INSERT INTO pro_city_area VALUES ('450801', '市辖区', '450800');
INSERT INTO pro_city_area VALUES ('450802', '港北区', '450800');
INSERT INTO pro_city_area VALUES ('450803', '港南区', '450800');
INSERT INTO pro_city_area VALUES ('450804', '覃塘区', '450800');
INSERT INTO pro_city_area VALUES ('450821', '平南县', '450800');
INSERT INTO pro_city_area VALUES ('450881', '桂平市', '450800');
INSERT INTO pro_city_area VALUES ('450900', '玉林市', '450000');
INSERT INTO pro_city_area VALUES ('450901', '市辖区', '450900');
INSERT INTO pro_city_area VALUES ('450902', '玉州区', '450900');
INSERT INTO pro_city_area VALUES ('450921', '容　县', '450900');
INSERT INTO pro_city_area VALUES ('450922', '陆川县', '450900');
INSERT INTO pro_city_area VALUES ('450923', '博白县', '450900');
INSERT INTO pro_city_area VALUES ('450924', '兴业县', '450900');
INSERT INTO pro_city_area VALUES ('450981', '北流市', '450900');
INSERT INTO pro_city_area VALUES ('451000', '百色市', '450000');
INSERT INTO pro_city_area VALUES ('451001', '市辖区', '451000');
INSERT INTO pro_city_area VALUES ('451002', '右江区', '451000');
INSERT INTO pro_city_area VALUES ('451021', '田阳县', '451000');
INSERT INTO pro_city_area VALUES ('451022', '田东县', '451000');
INSERT INTO pro_city_area VALUES ('451023', '平果县', '451000');
INSERT INTO pro_city_area VALUES ('451024', '德保县', '451000');
INSERT INTO pro_city_area VALUES ('451025', '靖西县', '451000');
INSERT INTO pro_city_area VALUES ('451026', '那坡县', '451000');
INSERT INTO pro_city_area VALUES ('451027', '凌云县', '451000');
INSERT INTO pro_city_area VALUES ('451028', '乐业县', '451000');
INSERT INTO pro_city_area VALUES ('451029', '田林县', '451000');
INSERT INTO pro_city_area VALUES ('451030', '西林县', '451000');
INSERT INTO pro_city_area VALUES ('451031', '隆林各族自治县', '451000');
INSERT INTO pro_city_area VALUES ('451100', '贺州市', '450000');
INSERT INTO pro_city_area VALUES ('451101', '市辖区', '451100');
INSERT INTO pro_city_area VALUES ('451102', '八步区', '451100');
INSERT INTO pro_city_area VALUES ('451121', '昭平县', '451100');
INSERT INTO pro_city_area VALUES ('451122', '钟山县', '451100');
INSERT INTO pro_city_area VALUES ('451123', '富川瑶族自治县', '451100');
INSERT INTO pro_city_area VALUES ('451200', '河池市', '450000');
INSERT INTO pro_city_area VALUES ('451201', '市辖区', '451200');
INSERT INTO pro_city_area VALUES ('451202', '金城江区', '451200');
INSERT INTO pro_city_area VALUES ('451221', '南丹县', '451200');
INSERT INTO pro_city_area VALUES ('451222', '天峨县', '451200');
INSERT INTO pro_city_area VALUES ('451223', '凤山县', '451200');
INSERT INTO pro_city_area VALUES ('451224', '东兰县', '451200');
INSERT INTO pro_city_area VALUES ('451225', '罗城仫佬族自治县', '451200');
INSERT INTO pro_city_area VALUES ('451226', '环江毛南族自治县', '451200');
INSERT INTO pro_city_area VALUES ('451227', '巴马瑶族自治县', '451200');
INSERT INTO pro_city_area VALUES ('451228', '都安瑶族自治县', '451200');
INSERT INTO pro_city_area VALUES ('451229', '大化瑶族自治县', '451200');
INSERT INTO pro_city_area VALUES ('451281', '宜州市', '451200');
INSERT INTO pro_city_area VALUES ('451300', '来宾市', '450000');
INSERT INTO pro_city_area VALUES ('451301', '市辖区', '451300');
INSERT INTO pro_city_area VALUES ('451302', '兴宾区', '451300');
INSERT INTO pro_city_area VALUES ('451321', '忻城县', '451300');
INSERT INTO pro_city_area VALUES ('451322', '象州县', '451300');
INSERT INTO pro_city_area VALUES ('451323', '武宣县', '451300');
INSERT INTO pro_city_area VALUES ('451324', '金秀瑶族自治县', '451300');
INSERT INTO pro_city_area VALUES ('451381', '合山市', '451300');
INSERT INTO pro_city_area VALUES ('451400', '崇左市', '450000');
INSERT INTO pro_city_area VALUES ('451401', '市辖区', '451400');
INSERT INTO pro_city_area VALUES ('451402', '江洲区', '451400');
INSERT INTO pro_city_area VALUES ('451421', '扶绥县', '451400');
INSERT INTO pro_city_area VALUES ('451422', '宁明县', '451400');
INSERT INTO pro_city_area VALUES ('451423', '龙州县', '451400');
INSERT INTO pro_city_area VALUES ('451424', '大新县', '451400');
INSERT INTO pro_city_area VALUES ('451425', '天等县', '451400');
INSERT INTO pro_city_area VALUES ('451481', '凭祥市', '451400');
INSERT INTO pro_city_area VALUES ('460000', '海南省', '0');
INSERT INTO pro_city_area VALUES ('460100', '海口市', '460000');
INSERT INTO pro_city_area VALUES ('460101', '市辖区', '460100');
INSERT INTO pro_city_area VALUES ('460105', '秀英区', '460100');
INSERT INTO pro_city_area VALUES ('460106', '龙华区', '460100');
INSERT INTO pro_city_area VALUES ('460107', '琼山区', '460100');
INSERT INTO pro_city_area VALUES ('460108', '美兰区', '460100');
INSERT INTO pro_city_area VALUES ('460200', '三亚市', '460000');
INSERT INTO pro_city_area VALUES ('460201', '市辖区', '460200');
INSERT INTO pro_city_area VALUES ('469000', '省直辖县级行政单位', '460000');
INSERT INTO pro_city_area VALUES ('469001', '五指山市', '469000');
INSERT INTO pro_city_area VALUES ('469002', '琼海市', '469000');
INSERT INTO pro_city_area VALUES ('469003', '儋州市', '469000');
INSERT INTO pro_city_area VALUES ('469005', '文昌市', '469000');
INSERT INTO pro_city_area VALUES ('469006', '万宁市', '469000');
INSERT INTO pro_city_area VALUES ('469007', '东方市', '469000');
INSERT INTO pro_city_area VALUES ('469025', '定安县', '469000');
INSERT INTO pro_city_area VALUES ('469026', '屯昌县', '469000');
INSERT INTO pro_city_area VALUES ('469027', '澄迈县', '469000');
INSERT INTO pro_city_area VALUES ('469028', '临高县', '469000');
INSERT INTO pro_city_area VALUES ('469030', '白沙黎族自治县', '469000');
INSERT INTO pro_city_area VALUES ('469031', '昌江黎族自治县', '469000');
INSERT INTO pro_city_area VALUES ('469033', '乐东黎族自治县', '469000');
INSERT INTO pro_city_area VALUES ('469034', '陵水黎族自治县', '469000');
INSERT INTO pro_city_area VALUES ('469035', '保亭黎族苗族自治县', '469000');
INSERT INTO pro_city_area VALUES ('469036', '琼中黎族苗族自治县', '469000');
INSERT INTO pro_city_area VALUES ('469037', '西沙群岛', '469000');
INSERT INTO pro_city_area VALUES ('469038', '南沙群岛', '469000');
INSERT INTO pro_city_area VALUES ('469039', '中沙群岛的岛礁及其海域', '469000');
INSERT INTO pro_city_area VALUES ('500000', '重庆市', '0');
INSERT INTO pro_city_area VALUES ('500100', '市辖区', '500000');
INSERT INTO pro_city_area VALUES ('500101', '万州区', '500100');
INSERT INTO pro_city_area VALUES ('500102', '涪陵区', '500100');
INSERT INTO pro_city_area VALUES ('500103', '渝中区', '500100');
INSERT INTO pro_city_area VALUES ('500104', '大渡口区', '500100');
INSERT INTO pro_city_area VALUES ('500105', '江北区', '500100');
INSERT INTO pro_city_area VALUES ('500106', '沙坪坝区', '500100');
INSERT INTO pro_city_area VALUES ('500107', '九龙坡区', '500100');
INSERT INTO pro_city_area VALUES ('500108', '南岸区', '500100');
INSERT INTO pro_city_area VALUES ('500109', '北碚区', '500100');
INSERT INTO pro_city_area VALUES ('500110', '万盛区', '500100');
INSERT INTO pro_city_area VALUES ('500111', '双桥区', '500100');
INSERT INTO pro_city_area VALUES ('500112', '渝北区', '500100');
INSERT INTO pro_city_area VALUES ('500113', '巴南区', '500100');
INSERT INTO pro_city_area VALUES ('500114', '黔江区', '500100');
INSERT INTO pro_city_area VALUES ('500115', '长寿区', '500100');
INSERT INTO pro_city_area VALUES ('500200', '县', '500000');
INSERT INTO pro_city_area VALUES ('500222', '綦江县', '500200');
INSERT INTO pro_city_area VALUES ('500223', '潼南县', '500200');
INSERT INTO pro_city_area VALUES ('500224', '铜梁县', '500200');
INSERT INTO pro_city_area VALUES ('500225', '大足县', '500200');
INSERT INTO pro_city_area VALUES ('500226', '荣昌县', '500200');
INSERT INTO pro_city_area VALUES ('500227', '璧山县', '500200');
INSERT INTO pro_city_area VALUES ('500228', '梁平县', '500200');
INSERT INTO pro_city_area VALUES ('500229', '城口县', '500200');
INSERT INTO pro_city_area VALUES ('500230', '丰都县', '500200');
INSERT INTO pro_city_area VALUES ('500231', '垫江县', '500200');
INSERT INTO pro_city_area VALUES ('500232', '武隆县', '500200');
INSERT INTO pro_city_area VALUES ('500233', '忠　县', '500200');
INSERT INTO pro_city_area VALUES ('500234', '开　县', '500200');
INSERT INTO pro_city_area VALUES ('500235', '云阳县', '500200');
INSERT INTO pro_city_area VALUES ('500236', '奉节县', '500200');
INSERT INTO pro_city_area VALUES ('500237', '巫山县', '500200');
INSERT INTO pro_city_area VALUES ('500238', '巫溪县', '500200');
INSERT INTO pro_city_area VALUES ('500240', '石柱土家族自治县', '500200');
INSERT INTO pro_city_area VALUES ('500241', '秀山土家族苗族自治县', '500200');
INSERT INTO pro_city_area VALUES ('500242', '酉阳土家族苗族自治县', '500200');
INSERT INTO pro_city_area VALUES ('500243', '彭水苗族土家族自治县', '500200');
INSERT INTO pro_city_area VALUES ('500300', '市', '500000');
INSERT INTO pro_city_area VALUES ('500381', '江津市', '500300');
INSERT INTO pro_city_area VALUES ('500382', '合川市', '500300');
INSERT INTO pro_city_area VALUES ('500383', '永川市', '500300');
INSERT INTO pro_city_area VALUES ('500384', '南川市', '500300');
INSERT INTO pro_city_area VALUES ('510000', '四川省', '0');
INSERT INTO pro_city_area VALUES ('510100', '成都市', '510000');
INSERT INTO pro_city_area VALUES ('510101', '市辖区', '510100');
INSERT INTO pro_city_area VALUES ('510104', '锦江区', '510100');
INSERT INTO pro_city_area VALUES ('510105', '青羊区', '510100');
INSERT INTO pro_city_area VALUES ('510106', '金牛区', '510100');
INSERT INTO pro_city_area VALUES ('510107', '武侯区', '510100');
INSERT INTO pro_city_area VALUES ('510108', '成华区', '510100');
INSERT INTO pro_city_area VALUES ('510112', '龙泉驿区', '510100');
INSERT INTO pro_city_area VALUES ('510113', '青白江区', '510100');
INSERT INTO pro_city_area VALUES ('510114', '新都区', '510100');
INSERT INTO pro_city_area VALUES ('510115', '温江区', '510100');
INSERT INTO pro_city_area VALUES ('510121', '金堂县', '510100');
INSERT INTO pro_city_area VALUES ('510122', '双流县', '510100');
INSERT INTO pro_city_area VALUES ('510124', '郫　县', '510100');
INSERT INTO pro_city_area VALUES ('510129', '大邑县', '510100');
INSERT INTO pro_city_area VALUES ('510131', '蒲江县', '510100');
INSERT INTO pro_city_area VALUES ('510132', '新津县', '510100');
INSERT INTO pro_city_area VALUES ('510181', '都江堰市', '510100');
INSERT INTO pro_city_area VALUES ('510182', '彭州市', '510100');
INSERT INTO pro_city_area VALUES ('510183', '邛崃市', '510100');
INSERT INTO pro_city_area VALUES ('510184', '崇州市', '510100');
INSERT INTO pro_city_area VALUES ('510300', '自贡市', '510000');
INSERT INTO pro_city_area VALUES ('510301', '市辖区', '510300');
INSERT INTO pro_city_area VALUES ('510302', '自流井区', '510300');
INSERT INTO pro_city_area VALUES ('510303', '贡井区', '510300');
INSERT INTO pro_city_area VALUES ('510304', '大安区', '510300');
INSERT INTO pro_city_area VALUES ('510311', '沿滩区', '510300');
INSERT INTO pro_city_area VALUES ('510321', '荣　县', '510300');
INSERT INTO pro_city_area VALUES ('510322', '富顺县', '510300');
INSERT INTO pro_city_area VALUES ('510400', '攀枝花市', '510000');
INSERT INTO pro_city_area VALUES ('510401', '市辖区', '510400');
INSERT INTO pro_city_area VALUES ('510402', '东　区', '510400');
INSERT INTO pro_city_area VALUES ('510403', '西　区', '510400');
INSERT INTO pro_city_area VALUES ('510411', '仁和区', '510400');
INSERT INTO pro_city_area VALUES ('510421', '米易县', '510400');
INSERT INTO pro_city_area VALUES ('510422', '盐边县', '510400');
INSERT INTO pro_city_area VALUES ('510500', '泸州市', '510000');
INSERT INTO pro_city_area VALUES ('510501', '市辖区', '510500');
INSERT INTO pro_city_area VALUES ('510502', '江阳区', '510500');
INSERT INTO pro_city_area VALUES ('510503', '纳溪区', '510500');
INSERT INTO pro_city_area VALUES ('510504', '龙马潭区', '510500');
INSERT INTO pro_city_area VALUES ('510521', '泸　县', '510500');
INSERT INTO pro_city_area VALUES ('510522', '合江县', '510500');
INSERT INTO pro_city_area VALUES ('510524', '叙永县', '510500');
INSERT INTO pro_city_area VALUES ('510525', '古蔺县', '510500');
INSERT INTO pro_city_area VALUES ('510600', '德阳市', '510000');
INSERT INTO pro_city_area VALUES ('510601', '市辖区', '510600');
INSERT INTO pro_city_area VALUES ('510603', '旌阳区', '510600');
INSERT INTO pro_city_area VALUES ('510623', '中江县', '510600');
INSERT INTO pro_city_area VALUES ('510626', '罗江县', '510600');
INSERT INTO pro_city_area VALUES ('510681', '广汉市', '510600');
INSERT INTO pro_city_area VALUES ('510682', '什邡市', '510600');
INSERT INTO pro_city_area VALUES ('510683', '绵竹市', '510600');
INSERT INTO pro_city_area VALUES ('510700', '绵阳市', '510000');
INSERT INTO pro_city_area VALUES ('510701', '市辖区', '510700');
INSERT INTO pro_city_area VALUES ('510703', '涪城区', '510700');
INSERT INTO pro_city_area VALUES ('510704', '游仙区', '510700');
INSERT INTO pro_city_area VALUES ('510722', '三台县', '510700');
INSERT INTO pro_city_area VALUES ('510723', '盐亭县', '510700');
INSERT INTO pro_city_area VALUES ('510724', '安　县', '510700');
INSERT INTO pro_city_area VALUES ('510725', '梓潼县', '510700');
INSERT INTO pro_city_area VALUES ('510726', '北川羌族自治县', '510700');
INSERT INTO pro_city_area VALUES ('510727', '平武县', '510700');
INSERT INTO pro_city_area VALUES ('510781', '江油市', '510700');
INSERT INTO pro_city_area VALUES ('510800', '广元市', '510000');
INSERT INTO pro_city_area VALUES ('510801', '市辖区', '510800');
INSERT INTO pro_city_area VALUES ('510802', '市中区', '510800');
INSERT INTO pro_city_area VALUES ('510811', '元坝区', '510800');
INSERT INTO pro_city_area VALUES ('510812', '朝天区', '510800');
INSERT INTO pro_city_area VALUES ('510821', '旺苍县', '510800');
INSERT INTO pro_city_area VALUES ('510822', '青川县', '510800');
INSERT INTO pro_city_area VALUES ('510823', '剑阁县', '510800');
INSERT INTO pro_city_area VALUES ('510824', '苍溪县', '510800');
INSERT INTO pro_city_area VALUES ('510900', '遂宁市', '510000');
INSERT INTO pro_city_area VALUES ('510901', '市辖区', '510900');
INSERT INTO pro_city_area VALUES ('510903', '船山区', '510900');
INSERT INTO pro_city_area VALUES ('510904', '安居区', '510900');
INSERT INTO pro_city_area VALUES ('510921', '蓬溪县', '510900');
INSERT INTO pro_city_area VALUES ('510922', '射洪县', '510900');
INSERT INTO pro_city_area VALUES ('510923', '大英县', '510900');
INSERT INTO pro_city_area VALUES ('511000', '内江市', '510000');
INSERT INTO pro_city_area VALUES ('511001', '市辖区', '511000');
INSERT INTO pro_city_area VALUES ('511002', '市中区', '511000');
INSERT INTO pro_city_area VALUES ('511011', '东兴区', '511000');
INSERT INTO pro_city_area VALUES ('511024', '威远县', '511000');
INSERT INTO pro_city_area VALUES ('511025', '资中县', '511000');
INSERT INTO pro_city_area VALUES ('511028', '隆昌县', '511000');
INSERT INTO pro_city_area VALUES ('511100', '乐山市', '510000');
INSERT INTO pro_city_area VALUES ('511101', '市辖区', '511100');
INSERT INTO pro_city_area VALUES ('511102', '市中区', '511100');
INSERT INTO pro_city_area VALUES ('511111', '沙湾区', '511100');
INSERT INTO pro_city_area VALUES ('511112', '五通桥区', '511100');
INSERT INTO pro_city_area VALUES ('511113', '金口河区', '511100');
INSERT INTO pro_city_area VALUES ('511123', '犍为县', '511100');
INSERT INTO pro_city_area VALUES ('511124', '井研县', '511100');
INSERT INTO pro_city_area VALUES ('511126', '夹江县', '511100');
INSERT INTO pro_city_area VALUES ('511129', '沐川县', '511100');
INSERT INTO pro_city_area VALUES ('511132', '峨边彝族自治县', '511100');
INSERT INTO pro_city_area VALUES ('511133', '马边彝族自治县', '511100');
INSERT INTO pro_city_area VALUES ('511181', '峨眉山市', '511100');
INSERT INTO pro_city_area VALUES ('511300', '南充市', '510000');
INSERT INTO pro_city_area VALUES ('511301', '市辖区', '511300');
INSERT INTO pro_city_area VALUES ('511302', '顺庆区', '511300');
INSERT INTO pro_city_area VALUES ('511303', '高坪区', '511300');
INSERT INTO pro_city_area VALUES ('511304', '嘉陵区', '511300');
INSERT INTO pro_city_area VALUES ('511321', '南部县', '511300');
INSERT INTO pro_city_area VALUES ('511322', '营山县', '511300');
INSERT INTO pro_city_area VALUES ('511323', '蓬安县', '511300');
INSERT INTO pro_city_area VALUES ('511324', '仪陇县', '511300');
INSERT INTO pro_city_area VALUES ('511325', '西充县', '511300');
INSERT INTO pro_city_area VALUES ('511381', '阆中市', '511300');
INSERT INTO pro_city_area VALUES ('511400', '眉山市', '510000');
INSERT INTO pro_city_area VALUES ('511401', '市辖区', '511400');
INSERT INTO pro_city_area VALUES ('511402', '东坡区', '511400');
INSERT INTO pro_city_area VALUES ('511421', '仁寿县', '511400');
INSERT INTO pro_city_area VALUES ('511422', '彭山县', '511400');
INSERT INTO pro_city_area VALUES ('511423', '洪雅县', '511400');
INSERT INTO pro_city_area VALUES ('511424', '丹棱县', '511400');
INSERT INTO pro_city_area VALUES ('511425', '青神县', '511400');
INSERT INTO pro_city_area VALUES ('511500', '宜宾市', '510000');
INSERT INTO pro_city_area VALUES ('511501', '市辖区', '511500');
INSERT INTO pro_city_area VALUES ('511502', '翠屏区', '511500');
INSERT INTO pro_city_area VALUES ('511521', '宜宾县', '511500');
INSERT INTO pro_city_area VALUES ('511522', '南溪县', '511500');
INSERT INTO pro_city_area VALUES ('511523', '江安县', '511500');
INSERT INTO pro_city_area VALUES ('511524', '长宁县', '511500');
INSERT INTO pro_city_area VALUES ('511525', '高　县', '511500');
INSERT INTO pro_city_area VALUES ('511526', '珙　县', '511500');
INSERT INTO pro_city_area VALUES ('511527', '筠连县', '511500');
INSERT INTO pro_city_area VALUES ('511528', '兴文县', '511500');
INSERT INTO pro_city_area VALUES ('511529', '屏山县', '511500');
INSERT INTO pro_city_area VALUES ('511600', '广安市', '510000');
INSERT INTO pro_city_area VALUES ('511601', '市辖区', '511600');
INSERT INTO pro_city_area VALUES ('511602', '广安区', '511600');
INSERT INTO pro_city_area VALUES ('511621', '岳池县', '511600');
INSERT INTO pro_city_area VALUES ('511622', '武胜县', '511600');
INSERT INTO pro_city_area VALUES ('511623', '邻水县', '511600');
INSERT INTO pro_city_area VALUES ('511681', '华莹市', '511600');
INSERT INTO pro_city_area VALUES ('511700', '达州市', '510000');
INSERT INTO pro_city_area VALUES ('511701', '市辖区', '511700');
INSERT INTO pro_city_area VALUES ('511702', '通川区', '511700');
INSERT INTO pro_city_area VALUES ('511721', '达　县', '511700');
INSERT INTO pro_city_area VALUES ('511722', '宣汉县', '511700');
INSERT INTO pro_city_area VALUES ('511723', '开江县', '511700');
INSERT INTO pro_city_area VALUES ('511724', '大竹县', '511700');
INSERT INTO pro_city_area VALUES ('511725', '渠　县', '511700');
INSERT INTO pro_city_area VALUES ('511781', '万源市', '511700');
INSERT INTO pro_city_area VALUES ('511800', '雅安市', '510000');
INSERT INTO pro_city_area VALUES ('511801', '市辖区', '511800');
INSERT INTO pro_city_area VALUES ('511802', '雨城区', '511800');
INSERT INTO pro_city_area VALUES ('511821', '名山县', '511800');
INSERT INTO pro_city_area VALUES ('511822', '荥经县', '511800');
INSERT INTO pro_city_area VALUES ('511823', '汉源县', '511800');
INSERT INTO pro_city_area VALUES ('511824', '石棉县', '511800');
INSERT INTO pro_city_area VALUES ('511825', '天全县', '511800');
INSERT INTO pro_city_area VALUES ('511826', '芦山县', '511800');
INSERT INTO pro_city_area VALUES ('511827', '宝兴县', '511800');
INSERT INTO pro_city_area VALUES ('511900', '巴中市', '510000');
INSERT INTO pro_city_area VALUES ('511901', '市辖区', '511900');
INSERT INTO pro_city_area VALUES ('511902', '巴州区', '511900');
INSERT INTO pro_city_area VALUES ('511921', '通江县', '511900');
INSERT INTO pro_city_area VALUES ('511922', '南江县', '511900');
INSERT INTO pro_city_area VALUES ('511923', '平昌县', '511900');
INSERT INTO pro_city_area VALUES ('512000', '资阳市', '510000');
INSERT INTO pro_city_area VALUES ('512001', '市辖区', '512000');
INSERT INTO pro_city_area VALUES ('512002', '雁江区', '512000');
INSERT INTO pro_city_area VALUES ('512021', '安岳县', '512000');
INSERT INTO pro_city_area VALUES ('512022', '乐至县', '512000');
INSERT INTO pro_city_area VALUES ('512081', '简阳市', '512000');
INSERT INTO pro_city_area VALUES ('513200', '阿坝藏族羌族自治州', '510000');
INSERT INTO pro_city_area VALUES ('513221', '汶川县', '513200');
INSERT INTO pro_city_area VALUES ('513222', '理　县', '513200');
INSERT INTO pro_city_area VALUES ('513223', '茂　县', '513200');
INSERT INTO pro_city_area VALUES ('513224', '松潘县', '513200');
INSERT INTO pro_city_area VALUES ('513225', '九寨沟县', '513200');
INSERT INTO pro_city_area VALUES ('513226', '金川县', '513200');
INSERT INTO pro_city_area VALUES ('513227', '小金县', '513200');
INSERT INTO pro_city_area VALUES ('513228', '黑水县', '513200');
INSERT INTO pro_city_area VALUES ('513229', '马尔康县', '513200');
INSERT INTO pro_city_area VALUES ('513230', '壤塘县', '513200');
INSERT INTO pro_city_area VALUES ('513231', '阿坝县', '513200');
INSERT INTO pro_city_area VALUES ('513232', '若尔盖县', '513200');
INSERT INTO pro_city_area VALUES ('513233', '红原县', '513200');
INSERT INTO pro_city_area VALUES ('513300', '甘孜藏族自治州', '510000');
INSERT INTO pro_city_area VALUES ('513321', '康定县', '513300');
INSERT INTO pro_city_area VALUES ('513322', '泸定县', '513300');
INSERT INTO pro_city_area VALUES ('513323', '丹巴县', '513300');
INSERT INTO pro_city_area VALUES ('513324', '九龙县', '513300');
INSERT INTO pro_city_area VALUES ('513325', '雅江县', '513300');
INSERT INTO pro_city_area VALUES ('513326', '道孚县', '513300');
INSERT INTO pro_city_area VALUES ('513327', '炉霍县', '513300');
INSERT INTO pro_city_area VALUES ('513328', '甘孜县', '513300');
INSERT INTO pro_city_area VALUES ('513329', '新龙县', '513300');
INSERT INTO pro_city_area VALUES ('513330', '德格县', '513300');
INSERT INTO pro_city_area VALUES ('513331', '白玉县', '513300');
INSERT INTO pro_city_area VALUES ('513332', '石渠县', '513300');
INSERT INTO pro_city_area VALUES ('513333', '色达县', '513300');
INSERT INTO pro_city_area VALUES ('513334', '理塘县', '513300');
INSERT INTO pro_city_area VALUES ('513335', '巴塘县', '513300');
INSERT INTO pro_city_area VALUES ('513336', '乡城县', '513300');
INSERT INTO pro_city_area VALUES ('513337', '稻城县', '513300');
INSERT INTO pro_city_area VALUES ('513338', '得荣县', '513300');
INSERT INTO pro_city_area VALUES ('513400', '凉山彝族自治州', '510000');
INSERT INTO pro_city_area VALUES ('513401', '西昌市', '513400');
INSERT INTO pro_city_area VALUES ('513422', '木里藏族自治县', '513400');
INSERT INTO pro_city_area VALUES ('513423', '盐源县', '513400');
INSERT INTO pro_city_area VALUES ('513424', '德昌县', '513400');
INSERT INTO pro_city_area VALUES ('513425', '会理县', '513400');
INSERT INTO pro_city_area VALUES ('513426', '会东县', '513400');
INSERT INTO pro_city_area VALUES ('513427', '宁南县', '513400');
INSERT INTO pro_city_area VALUES ('513428', '普格县', '513400');
INSERT INTO pro_city_area VALUES ('513429', '布拖县', '513400');
INSERT INTO pro_city_area VALUES ('513430', '金阳县', '513400');
INSERT INTO pro_city_area VALUES ('513431', '昭觉县', '513400');
INSERT INTO pro_city_area VALUES ('513432', '喜德县', '513400');
INSERT INTO pro_city_area VALUES ('513433', '冕宁县', '513400');
INSERT INTO pro_city_area VALUES ('513434', '越西县', '513400');
INSERT INTO pro_city_area VALUES ('513435', '甘洛县', '513400');
INSERT INTO pro_city_area VALUES ('513436', '美姑县', '513400');
INSERT INTO pro_city_area VALUES ('513437', '雷波县', '513400');
INSERT INTO pro_city_area VALUES ('520000', '贵州省', '0');
INSERT INTO pro_city_area VALUES ('520100', '贵阳市', '520000');
INSERT INTO pro_city_area VALUES ('520101', '市辖区', '520100');
INSERT INTO pro_city_area VALUES ('520102', '南明区', '520100');
INSERT INTO pro_city_area VALUES ('520103', '云岩区', '520100');
INSERT INTO pro_city_area VALUES ('520111', '花溪区', '520100');
INSERT INTO pro_city_area VALUES ('520112', '乌当区', '520100');
INSERT INTO pro_city_area VALUES ('520113', '白云区', '520100');
INSERT INTO pro_city_area VALUES ('520114', '小河区', '520100');
INSERT INTO pro_city_area VALUES ('520121', '开阳县', '520100');
INSERT INTO pro_city_area VALUES ('520122', '息烽县', '520100');
INSERT INTO pro_city_area VALUES ('520123', '修文县', '520100');
INSERT INTO pro_city_area VALUES ('520181', '清镇市', '520100');
INSERT INTO pro_city_area VALUES ('520200', '六盘水市', '520000');
INSERT INTO pro_city_area VALUES ('520201', '钟山区', '520200');
INSERT INTO pro_city_area VALUES ('520203', '六枝特区', '520200');
INSERT INTO pro_city_area VALUES ('520221', '水城县', '520200');
INSERT INTO pro_city_area VALUES ('520222', '盘　县', '520200');
INSERT INTO pro_city_area VALUES ('520300', '遵义市', '520000');
INSERT INTO pro_city_area VALUES ('520301', '市辖区', '520300');
INSERT INTO pro_city_area VALUES ('520302', '红花岗区', '520300');
INSERT INTO pro_city_area VALUES ('520303', '汇川区', '520300');
INSERT INTO pro_city_area VALUES ('520321', '遵义县', '520300');
INSERT INTO pro_city_area VALUES ('520322', '桐梓县', '520300');
INSERT INTO pro_city_area VALUES ('520323', '绥阳县', '520300');
INSERT INTO pro_city_area VALUES ('520324', '正安县', '520300');
INSERT INTO pro_city_area VALUES ('520325', '道真仡佬族苗族自治县', '520300');
INSERT INTO pro_city_area VALUES ('520326', '务川仡佬族苗族自治县', '520300');
INSERT INTO pro_city_area VALUES ('520327', '凤冈县', '520300');
INSERT INTO pro_city_area VALUES ('520328', '湄潭县', '520300');
INSERT INTO pro_city_area VALUES ('520329', '余庆县', '520300');
INSERT INTO pro_city_area VALUES ('520330', '习水县', '520300');
INSERT INTO pro_city_area VALUES ('520381', '赤水市', '520300');
INSERT INTO pro_city_area VALUES ('520382', '仁怀市', '520300');
INSERT INTO pro_city_area VALUES ('520400', '安顺市', '520000');
INSERT INTO pro_city_area VALUES ('520401', '市辖区', '520400');
INSERT INTO pro_city_area VALUES ('520402', '西秀区', '520400');
INSERT INTO pro_city_area VALUES ('520421', '平坝县', '520400');
INSERT INTO pro_city_area VALUES ('520422', '普定县', '520400');
INSERT INTO pro_city_area VALUES ('520423', '镇宁布依族苗族自治县', '520400');
INSERT INTO pro_city_area VALUES ('520424', '关岭布依族苗族自治县', '520400');
INSERT INTO pro_city_area VALUES ('520425', '紫云苗族布依族自治县', '520400');
INSERT INTO pro_city_area VALUES ('522200', '铜仁地区', '520000');
INSERT INTO pro_city_area VALUES ('522201', '铜仁市', '522200');
INSERT INTO pro_city_area VALUES ('522222', '江口县', '522200');
INSERT INTO pro_city_area VALUES ('522223', '玉屏侗族自治县', '522200');
INSERT INTO pro_city_area VALUES ('522224', '石阡县', '522200');
INSERT INTO pro_city_area VALUES ('522225', '思南县', '522200');
INSERT INTO pro_city_area VALUES ('522226', '印江土家族苗族自治县', '522200');
INSERT INTO pro_city_area VALUES ('522227', '德江县', '522200');
INSERT INTO pro_city_area VALUES ('522228', '沿河土家族自治县', '522200');
INSERT INTO pro_city_area VALUES ('522229', '松桃苗族自治县', '522200');
INSERT INTO pro_city_area VALUES ('522230', '万山特区', '522200');
INSERT INTO pro_city_area VALUES ('522300', '黔西南布依族苗族自治州', '520000');
INSERT INTO pro_city_area VALUES ('522301', '兴义市', '522300');
INSERT INTO pro_city_area VALUES ('522322', '兴仁县', '522300');
INSERT INTO pro_city_area VALUES ('522323', '普安县', '522300');
INSERT INTO pro_city_area VALUES ('522324', '晴隆县', '522300');
INSERT INTO pro_city_area VALUES ('522325', '贞丰县', '522300');
INSERT INTO pro_city_area VALUES ('522326', '望谟县', '522300');
INSERT INTO pro_city_area VALUES ('522327', '册亨县', '522300');
INSERT INTO pro_city_area VALUES ('522328', '安龙县', '522300');
INSERT INTO pro_city_area VALUES ('522400', '毕节地区', '520000');
INSERT INTO pro_city_area VALUES ('522401', '毕节市', '522400');
INSERT INTO pro_city_area VALUES ('522422', '大方县', '522400');
INSERT INTO pro_city_area VALUES ('522423', '黔西县', '522400');
INSERT INTO pro_city_area VALUES ('522424', '金沙县', '522400');
INSERT INTO pro_city_area VALUES ('522425', '织金县', '522400');
INSERT INTO pro_city_area VALUES ('522426', '纳雍县', '522400');
INSERT INTO pro_city_area VALUES ('522427', '威宁彝族回族苗族自治县', '522400');
INSERT INTO pro_city_area VALUES ('522428', '赫章县', '522400');
INSERT INTO pro_city_area VALUES ('522600', '黔东南苗族侗族自治州', '520000');
INSERT INTO pro_city_area VALUES ('522601', '凯里市', '522600');
INSERT INTO pro_city_area VALUES ('522622', '黄平县', '522600');
INSERT INTO pro_city_area VALUES ('522623', '施秉县', '522600');
INSERT INTO pro_city_area VALUES ('522624', '三穗县', '522600');
INSERT INTO pro_city_area VALUES ('522625', '镇远县', '522600');
INSERT INTO pro_city_area VALUES ('522626', '岑巩县', '522600');
INSERT INTO pro_city_area VALUES ('522627', '天柱县', '522600');
INSERT INTO pro_city_area VALUES ('522628', '锦屏县', '522600');
INSERT INTO pro_city_area VALUES ('522629', '剑河县', '522600');
INSERT INTO pro_city_area VALUES ('522630', '台江县', '522600');
INSERT INTO pro_city_area VALUES ('522631', '黎平县', '522600');
INSERT INTO pro_city_area VALUES ('522632', '榕江县', '522600');
INSERT INTO pro_city_area VALUES ('522633', '从江县', '522600');
INSERT INTO pro_city_area VALUES ('522634', '雷山县', '522600');
INSERT INTO pro_city_area VALUES ('522635', '麻江县', '522600');
INSERT INTO pro_city_area VALUES ('522636', '丹寨县', '522600');
INSERT INTO pro_city_area VALUES ('522700', '黔南布依族苗族自治州', '520000');
INSERT INTO pro_city_area VALUES ('522701', '都匀市', '522700');
INSERT INTO pro_city_area VALUES ('522702', '福泉市', '522700');
INSERT INTO pro_city_area VALUES ('522722', '荔波县', '522700');
INSERT INTO pro_city_area VALUES ('522723', '贵定县', '522700');
INSERT INTO pro_city_area VALUES ('522725', '瓮安县', '522700');
INSERT INTO pro_city_area VALUES ('522726', '独山县', '522700');
INSERT INTO pro_city_area VALUES ('522727', '平塘县', '522700');
INSERT INTO pro_city_area VALUES ('522728', '罗甸县', '522700');
INSERT INTO pro_city_area VALUES ('522729', '长顺县', '522700');
INSERT INTO pro_city_area VALUES ('522730', '龙里县', '522700');
INSERT INTO pro_city_area VALUES ('522731', '惠水县', '522700');
INSERT INTO pro_city_area VALUES ('522732', '三都水族自治县', '522700');
INSERT INTO pro_city_area VALUES ('530000', '云南省', '0');
INSERT INTO pro_city_area VALUES ('530100', '昆明市', '530000');
INSERT INTO pro_city_area VALUES ('530101', '市辖区', '530100');
INSERT INTO pro_city_area VALUES ('530102', '五华区', '530100');
INSERT INTO pro_city_area VALUES ('530103', '盘龙区', '530100');
INSERT INTO pro_city_area VALUES ('530111', '官渡区', '530100');
INSERT INTO pro_city_area VALUES ('530112', '西山区', '530100');
INSERT INTO pro_city_area VALUES ('530113', '东川区', '530100');
INSERT INTO pro_city_area VALUES ('530121', '呈贡县', '530100');
INSERT INTO pro_city_area VALUES ('530122', '晋宁县', '530100');
INSERT INTO pro_city_area VALUES ('530124', '富民县', '530100');
INSERT INTO pro_city_area VALUES ('530125', '宜良县', '530100');
INSERT INTO pro_city_area VALUES ('530126', '石林彝族自治县', '530100');
INSERT INTO pro_city_area VALUES ('530127', '嵩明县', '530100');
INSERT INTO pro_city_area VALUES ('530128', '禄劝彝族苗族自治县', '530100');
INSERT INTO pro_city_area VALUES ('530129', '寻甸回族彝族自治县', '530100');
INSERT INTO pro_city_area VALUES ('530181', '安宁市', '530100');
INSERT INTO pro_city_area VALUES ('530300', '曲靖市', '530000');
INSERT INTO pro_city_area VALUES ('530301', '市辖区', '530300');
INSERT INTO pro_city_area VALUES ('530302', '麒麟区', '530300');
INSERT INTO pro_city_area VALUES ('530321', '马龙县', '530300');
INSERT INTO pro_city_area VALUES ('530322', '陆良县', '530300');
INSERT INTO pro_city_area VALUES ('530323', '师宗县', '530300');
INSERT INTO pro_city_area VALUES ('530324', '罗平县', '530300');
INSERT INTO pro_city_area VALUES ('530325', '富源县', '530300');
INSERT INTO pro_city_area VALUES ('530326', '会泽县', '530300');
INSERT INTO pro_city_area VALUES ('530328', '沾益县', '530300');
INSERT INTO pro_city_area VALUES ('530381', '宣威市', '530300');
INSERT INTO pro_city_area VALUES ('530400', '玉溪市', '530000');
INSERT INTO pro_city_area VALUES ('530401', '市辖区', '530400');
INSERT INTO pro_city_area VALUES ('530402', '红塔区', '530400');
INSERT INTO pro_city_area VALUES ('530421', '江川县', '530400');
INSERT INTO pro_city_area VALUES ('530422', '澄江县', '530400');
INSERT INTO pro_city_area VALUES ('530423', '通海县', '530400');
INSERT INTO pro_city_area VALUES ('530424', '华宁县', '530400');
INSERT INTO pro_city_area VALUES ('530425', '易门县', '530400');
INSERT INTO pro_city_area VALUES ('530426', '峨山彝族自治县', '530400');
INSERT INTO pro_city_area VALUES ('530427', '新平彝族傣族自治县', '530400');
INSERT INTO pro_city_area VALUES ('530428', '元江哈尼族彝族傣族自治县', '530400');
INSERT INTO pro_city_area VALUES ('530500', '保山市', '530000');
INSERT INTO pro_city_area VALUES ('530501', '市辖区', '530500');
INSERT INTO pro_city_area VALUES ('530502', '隆阳区', '530500');
INSERT INTO pro_city_area VALUES ('530521', '施甸县', '530500');
INSERT INTO pro_city_area VALUES ('530522', '腾冲县', '530500');
INSERT INTO pro_city_area VALUES ('530523', '龙陵县', '530500');
INSERT INTO pro_city_area VALUES ('530524', '昌宁县', '530500');
INSERT INTO pro_city_area VALUES ('530600', '昭通市', '530000');
INSERT INTO pro_city_area VALUES ('530601', '市辖区', '530600');
INSERT INTO pro_city_area VALUES ('530602', '昭阳区', '530600');
INSERT INTO pro_city_area VALUES ('530621', '鲁甸县', '530600');
INSERT INTO pro_city_area VALUES ('530622', '巧家县', '530600');
INSERT INTO pro_city_area VALUES ('530623', '盐津县', '530600');
INSERT INTO pro_city_area VALUES ('530624', '大关县', '530600');
INSERT INTO pro_city_area VALUES ('530625', '永善县', '530600');
INSERT INTO pro_city_area VALUES ('530626', '绥江县', '530600');
INSERT INTO pro_city_area VALUES ('530627', '镇雄县', '530600');
INSERT INTO pro_city_area VALUES ('530628', '彝良县', '530600');
INSERT INTO pro_city_area VALUES ('530629', '威信县', '530600');
INSERT INTO pro_city_area VALUES ('530630', '水富县', '530600');
INSERT INTO pro_city_area VALUES ('530700', '丽江市', '530000');
INSERT INTO pro_city_area VALUES ('530701', '市辖区', '530700');
INSERT INTO pro_city_area VALUES ('530702', '古城区', '530700');
INSERT INTO pro_city_area VALUES ('530721', '玉龙纳西族自治县', '530700');
INSERT INTO pro_city_area VALUES ('530722', '永胜县', '530700');
INSERT INTO pro_city_area VALUES ('530723', '华坪县', '530700');
INSERT INTO pro_city_area VALUES ('530724', '宁蒗彝族自治县', '530700');
INSERT INTO pro_city_area VALUES ('530800', '思茅市', '530000');
INSERT INTO pro_city_area VALUES ('530801', '市辖区', '530800');
INSERT INTO pro_city_area VALUES ('530802', '翠云区', '530800');
INSERT INTO pro_city_area VALUES ('530821', '普洱哈尼族彝族自治县', '530800');
INSERT INTO pro_city_area VALUES ('530822', '墨江哈尼族自治县', '530800');
INSERT INTO pro_city_area VALUES ('530823', '景东彝族自治县', '530800');
INSERT INTO pro_city_area VALUES ('530824', '景谷傣族彝族自治县', '530800');
INSERT INTO pro_city_area VALUES ('530825', '镇沅彝族哈尼族拉祜族自治县', '530800');
INSERT INTO pro_city_area VALUES ('530826', '江城哈尼族彝族自治县', '530800');
INSERT INTO pro_city_area VALUES ('530827', '孟连傣族拉祜族佤族自治县', '530800');
INSERT INTO pro_city_area VALUES ('530828', '澜沧拉祜族自治县', '530800');
INSERT INTO pro_city_area VALUES ('530829', '西盟佤族自治县', '530800');
INSERT INTO pro_city_area VALUES ('530900', '临沧市', '530000');
INSERT INTO pro_city_area VALUES ('530901', '市辖区', '530900');
INSERT INTO pro_city_area VALUES ('530902', '临翔区', '530900');
INSERT INTO pro_city_area VALUES ('530921', '凤庆县', '530900');
INSERT INTO pro_city_area VALUES ('530922', '云　县', '530900');
INSERT INTO pro_city_area VALUES ('530923', '永德县', '530900');
INSERT INTO pro_city_area VALUES ('530924', '镇康县', '530900');
INSERT INTO pro_city_area VALUES ('530925', '双江拉祜族佤族布朗族傣族自治县', '530900');
INSERT INTO pro_city_area VALUES ('530926', '耿马傣族佤族自治县', '530900');
INSERT INTO pro_city_area VALUES ('530927', '沧源佤族自治县', '530900');
INSERT INTO pro_city_area VALUES ('532300', '楚雄彝族自治州', '530000');
INSERT INTO pro_city_area VALUES ('532301', '楚雄市', '532300');
INSERT INTO pro_city_area VALUES ('532322', '双柏县', '532300');
INSERT INTO pro_city_area VALUES ('532323', '牟定县', '532300');
INSERT INTO pro_city_area VALUES ('532324', '南华县', '532300');
INSERT INTO pro_city_area VALUES ('532325', '姚安县', '532300');
INSERT INTO pro_city_area VALUES ('532326', '大姚县', '532300');
INSERT INTO pro_city_area VALUES ('532327', '永仁县', '532300');
INSERT INTO pro_city_area VALUES ('532328', '元谋县', '532300');
INSERT INTO pro_city_area VALUES ('532329', '武定县', '532300');
INSERT INTO pro_city_area VALUES ('532331', '禄丰县', '532300');
INSERT INTO pro_city_area VALUES ('532500', '红河哈尼族彝族自治州', '530000');
INSERT INTO pro_city_area VALUES ('532501', '个旧市', '532500');
INSERT INTO pro_city_area VALUES ('532502', '开远市', '532500');
INSERT INTO pro_city_area VALUES ('532522', '蒙自县', '532500');
INSERT INTO pro_city_area VALUES ('532523', '屏边苗族自治县', '532500');
INSERT INTO pro_city_area VALUES ('532524', '建水县', '532500');
INSERT INTO pro_city_area VALUES ('532525', '石屏县', '532500');
INSERT INTO pro_city_area VALUES ('532526', '弥勒县', '532500');
INSERT INTO pro_city_area VALUES ('532527', '泸西县', '532500');
INSERT INTO pro_city_area VALUES ('532528', '元阳县', '532500');
INSERT INTO pro_city_area VALUES ('532529', '红河县', '532500');
INSERT INTO pro_city_area VALUES ('532530', '金平苗族瑶族傣族自治县', '532500');
INSERT INTO pro_city_area VALUES ('532531', '绿春县', '532500');
INSERT INTO pro_city_area VALUES ('532532', '河口瑶族自治县', '532500');
INSERT INTO pro_city_area VALUES ('532600', '文山壮族苗族自治州', '530000');
INSERT INTO pro_city_area VALUES ('532621', '文山县', '532600');
INSERT INTO pro_city_area VALUES ('532622', '砚山县', '532600');
INSERT INTO pro_city_area VALUES ('532623', '西畴县', '532600');
INSERT INTO pro_city_area VALUES ('532624', '麻栗坡县', '532600');
INSERT INTO pro_city_area VALUES ('532625', '马关县', '532600');
INSERT INTO pro_city_area VALUES ('532626', '丘北县', '532600');
INSERT INTO pro_city_area VALUES ('532627', '广南县', '532600');
INSERT INTO pro_city_area VALUES ('532628', '富宁县', '532600');
INSERT INTO pro_city_area VALUES ('532800', '西双版纳傣族自治州', '530000');
INSERT INTO pro_city_area VALUES ('532801', '景洪市', '532800');
INSERT INTO pro_city_area VALUES ('532822', '勐海县', '532800');
INSERT INTO pro_city_area VALUES ('532823', '勐腊县', '532800');
INSERT INTO pro_city_area VALUES ('532900', '大理白族自治州', '530000');
INSERT INTO pro_city_area VALUES ('532901', '大理市', '532900');
INSERT INTO pro_city_area VALUES ('532922', '漾濞彝族自治县', '532900');
INSERT INTO pro_city_area VALUES ('532923', '祥云县', '532900');
INSERT INTO pro_city_area VALUES ('532924', '宾川县', '532900');
INSERT INTO pro_city_area VALUES ('532925', '弥渡县', '532900');
INSERT INTO pro_city_area VALUES ('532926', '南涧彝族自治县', '532900');
INSERT INTO pro_city_area VALUES ('532927', '巍山彝族回族自治县', '532900');
INSERT INTO pro_city_area VALUES ('532928', '永平县', '532900');
INSERT INTO pro_city_area VALUES ('532929', '云龙县', '532900');
INSERT INTO pro_city_area VALUES ('532930', '洱源县', '532900');
INSERT INTO pro_city_area VALUES ('532931', '剑川县', '532900');
INSERT INTO pro_city_area VALUES ('532932', '鹤庆县', '532900');
INSERT INTO pro_city_area VALUES ('533100', '德宏傣族景颇族自治州', '530000');
INSERT INTO pro_city_area VALUES ('533102', '瑞丽市', '533100');
INSERT INTO pro_city_area VALUES ('533103', '潞西市', '533100');
INSERT INTO pro_city_area VALUES ('533122', '梁河县', '533100');
INSERT INTO pro_city_area VALUES ('533123', '盈江县', '533100');
INSERT INTO pro_city_area VALUES ('533124', '陇川县', '533100');
INSERT INTO pro_city_area VALUES ('533300', '怒江傈僳族自治州', '530000');
INSERT INTO pro_city_area VALUES ('533321', '泸水县', '533300');
INSERT INTO pro_city_area VALUES ('533323', '福贡县', '533300');
INSERT INTO pro_city_area VALUES ('533324', '贡山独龙族怒族自治县', '533300');
INSERT INTO pro_city_area VALUES ('533325', '兰坪白族普米族自治县', '533300');
INSERT INTO pro_city_area VALUES ('533400', '迪庆藏族自治州', '530000');
INSERT INTO pro_city_area VALUES ('533421', '香格里拉县', '533400');
INSERT INTO pro_city_area VALUES ('533422', '德钦县', '533400');
INSERT INTO pro_city_area VALUES ('533423', '维西傈僳族自治县', '533400');
INSERT INTO pro_city_area VALUES ('540000', '西  藏', '0');
INSERT INTO pro_city_area VALUES ('540100', '拉萨市', '540000');
INSERT INTO pro_city_area VALUES ('540101', '市辖区', '540100');
INSERT INTO pro_city_area VALUES ('540102', '城关区', '540100');
INSERT INTO pro_city_area VALUES ('540121', '林周县', '540100');
INSERT INTO pro_city_area VALUES ('540122', '当雄县', '540100');
INSERT INTO pro_city_area VALUES ('540123', '尼木县', '540100');
INSERT INTO pro_city_area VALUES ('540124', '曲水县', '540100');
INSERT INTO pro_city_area VALUES ('540125', '堆龙德庆县', '540100');
INSERT INTO pro_city_area VALUES ('540126', '达孜县', '540100');
INSERT INTO pro_city_area VALUES ('540127', '墨竹工卡县', '540100');
INSERT INTO pro_city_area VALUES ('542100', '昌都地区', '540000');
INSERT INTO pro_city_area VALUES ('542121', '昌都县', '542100');
INSERT INTO pro_city_area VALUES ('542122', '江达县', '542100');
INSERT INTO pro_city_area VALUES ('542123', '贡觉县', '542100');
INSERT INTO pro_city_area VALUES ('542124', '类乌齐县', '542100');
INSERT INTO pro_city_area VALUES ('542125', '丁青县', '542100');
INSERT INTO pro_city_area VALUES ('542126', '察雅县', '542100');
INSERT INTO pro_city_area VALUES ('542127', '八宿县', '542100');
INSERT INTO pro_city_area VALUES ('542128', '左贡县', '542100');
INSERT INTO pro_city_area VALUES ('542129', '芒康县', '542100');
INSERT INTO pro_city_area VALUES ('542132', '洛隆县', '542100');
INSERT INTO pro_city_area VALUES ('542133', '边坝县', '542100');
INSERT INTO pro_city_area VALUES ('542200', '山南地区', '540000');
INSERT INTO pro_city_area VALUES ('542221', '乃东县', '542200');
INSERT INTO pro_city_area VALUES ('542222', '扎囊县', '542200');
INSERT INTO pro_city_area VALUES ('542223', '贡嘎县', '542200');
INSERT INTO pro_city_area VALUES ('542224', '桑日县', '542200');
INSERT INTO pro_city_area VALUES ('542225', '琼结县', '542200');
INSERT INTO pro_city_area VALUES ('542226', '曲松县', '542200');
INSERT INTO pro_city_area VALUES ('542227', '措美县', '542200');
INSERT INTO pro_city_area VALUES ('542228', '洛扎县', '542200');
INSERT INTO pro_city_area VALUES ('542229', '加查县', '542200');
INSERT INTO pro_city_area VALUES ('542231', '隆子县', '542200');
INSERT INTO pro_city_area VALUES ('542232', '错那县', '542200');
INSERT INTO pro_city_area VALUES ('542233', '浪卡子县', '542200');
INSERT INTO pro_city_area VALUES ('542300', '日喀则地区', '540000');
INSERT INTO pro_city_area VALUES ('542301', '日喀则市', '542300');
INSERT INTO pro_city_area VALUES ('542322', '南木林县', '542300');
INSERT INTO pro_city_area VALUES ('542323', '江孜县', '542300');
INSERT INTO pro_city_area VALUES ('542324', '定日县', '542300');
INSERT INTO pro_city_area VALUES ('542325', '萨迦县', '542300');
INSERT INTO pro_city_area VALUES ('542326', '拉孜县', '542300');
INSERT INTO pro_city_area VALUES ('542327', '昂仁县', '542300');
INSERT INTO pro_city_area VALUES ('542328', '谢通门县', '542300');
INSERT INTO pro_city_area VALUES ('542329', '白朗县', '542300');
INSERT INTO pro_city_area VALUES ('542330', '仁布县', '542300');
INSERT INTO pro_city_area VALUES ('542331', '康马县', '542300');
INSERT INTO pro_city_area VALUES ('542332', '定结县', '542300');
INSERT INTO pro_city_area VALUES ('542333', '仲巴县', '542300');
INSERT INTO pro_city_area VALUES ('542334', '亚东县', '542300');
INSERT INTO pro_city_area VALUES ('542335', '吉隆县', '542300');
INSERT INTO pro_city_area VALUES ('542336', '聂拉木县', '542300');
INSERT INTO pro_city_area VALUES ('542337', '萨嘎县', '542300');
INSERT INTO pro_city_area VALUES ('542338', '岗巴县', '542300');
INSERT INTO pro_city_area VALUES ('542400', '那曲地区', '540000');
INSERT INTO pro_city_area VALUES ('542421', '那曲县', '542400');
INSERT INTO pro_city_area VALUES ('542422', '嘉黎县', '542400');
INSERT INTO pro_city_area VALUES ('542423', '比如县', '542400');
INSERT INTO pro_city_area VALUES ('542424', '聂荣县', '542400');
INSERT INTO pro_city_area VALUES ('542425', '安多县', '542400');
INSERT INTO pro_city_area VALUES ('542426', '申扎县', '542400');
INSERT INTO pro_city_area VALUES ('542427', '索　县', '542400');
INSERT INTO pro_city_area VALUES ('542428', '班戈县', '542400');
INSERT INTO pro_city_area VALUES ('542429', '巴青县', '542400');
INSERT INTO pro_city_area VALUES ('542430', '尼玛县', '542400');
INSERT INTO pro_city_area VALUES ('542500', '阿里地区', '540000');
INSERT INTO pro_city_area VALUES ('542521', '普兰县', '542500');
INSERT INTO pro_city_area VALUES ('542522', '札达县', '542500');
INSERT INTO pro_city_area VALUES ('542523', '噶尔县', '542500');
INSERT INTO pro_city_area VALUES ('542524', '日土县', '542500');
INSERT INTO pro_city_area VALUES ('542525', '革吉县', '542500');
INSERT INTO pro_city_area VALUES ('542526', '改则县', '542500');
INSERT INTO pro_city_area VALUES ('542527', '措勤县', '542500');
INSERT INTO pro_city_area VALUES ('542600', '林芝地区', '540000');
INSERT INTO pro_city_area VALUES ('542621', '林芝县', '542600');
INSERT INTO pro_city_area VALUES ('542622', '工布江达县', '542600');
INSERT INTO pro_city_area VALUES ('542623', '米林县', '542600');
INSERT INTO pro_city_area VALUES ('542624', '墨脱县', '542600');
INSERT INTO pro_city_area VALUES ('542625', '波密县', '542600');
INSERT INTO pro_city_area VALUES ('542626', '察隅县', '542600');
INSERT INTO pro_city_area VALUES ('542627', '朗　县', '542600');
INSERT INTO pro_city_area VALUES ('610000', '陕西省', '0');
INSERT INTO pro_city_area VALUES ('610100', '西安市', '610000');
INSERT INTO pro_city_area VALUES ('610101', '市辖区', '610100');
INSERT INTO pro_city_area VALUES ('610102', '新城区', '610100');
INSERT INTO pro_city_area VALUES ('610103', '碑林区', '610100');
INSERT INTO pro_city_area VALUES ('610104', '莲湖区', '610100');
INSERT INTO pro_city_area VALUES ('610111', '灞桥区', '610100');
INSERT INTO pro_city_area VALUES ('610112', '未央区', '610100');
INSERT INTO pro_city_area VALUES ('610113', '雁塔区', '610100');
INSERT INTO pro_city_area VALUES ('610114', '阎良区', '610100');
INSERT INTO pro_city_area VALUES ('610115', '临潼区', '610100');
INSERT INTO pro_city_area VALUES ('610116', '长安区', '610100');
INSERT INTO pro_city_area VALUES ('610122', '蓝田县', '610100');
INSERT INTO pro_city_area VALUES ('610124', '周至县', '610100');
INSERT INTO pro_city_area VALUES ('610125', '户　县', '610100');
INSERT INTO pro_city_area VALUES ('610126', '高陵县', '610100');
INSERT INTO pro_city_area VALUES ('610200', '铜川市', '610000');
INSERT INTO pro_city_area VALUES ('610201', '市辖区', '610200');
INSERT INTO pro_city_area VALUES ('610202', '王益区', '610200');
INSERT INTO pro_city_area VALUES ('610203', '印台区', '610200');
INSERT INTO pro_city_area VALUES ('610204', '耀州区', '610200');
INSERT INTO pro_city_area VALUES ('610222', '宜君县', '610200');
INSERT INTO pro_city_area VALUES ('610300', '宝鸡市', '610000');
INSERT INTO pro_city_area VALUES ('610301', '市辖区', '610300');
INSERT INTO pro_city_area VALUES ('610302', '渭滨区', '610300');
INSERT INTO pro_city_area VALUES ('610303', '金台区', '610300');
INSERT INTO pro_city_area VALUES ('610304', '陈仓区', '610300');
INSERT INTO pro_city_area VALUES ('610322', '凤翔县', '610300');
INSERT INTO pro_city_area VALUES ('610323', '岐山县', '610300');
INSERT INTO pro_city_area VALUES ('610324', '扶风县', '610300');
INSERT INTO pro_city_area VALUES ('610326', '眉　县', '610300');
INSERT INTO pro_city_area VALUES ('610327', '陇　县', '610300');
INSERT INTO pro_city_area VALUES ('610328', '千阳县', '610300');
INSERT INTO pro_city_area VALUES ('610329', '麟游县', '610300');
INSERT INTO pro_city_area VALUES ('610330', '凤　县', '610300');
INSERT INTO pro_city_area VALUES ('610331', '太白县', '610300');
INSERT INTO pro_city_area VALUES ('610400', '咸阳市', '610000');
INSERT INTO pro_city_area VALUES ('610401', '市辖区', '610400');
INSERT INTO pro_city_area VALUES ('610402', '秦都区', '610400');
INSERT INTO pro_city_area VALUES ('610403', '杨凌区', '610400');
INSERT INTO pro_city_area VALUES ('610404', '渭城区', '610400');
INSERT INTO pro_city_area VALUES ('610422', '三原县', '610400');
INSERT INTO pro_city_area VALUES ('610423', '泾阳县', '610400');
INSERT INTO pro_city_area VALUES ('610424', '乾　县', '610400');
INSERT INTO pro_city_area VALUES ('610425', '礼泉县', '610400');
INSERT INTO pro_city_area VALUES ('610426', '永寿县', '610400');
INSERT INTO pro_city_area VALUES ('610427', '彬　县', '610400');
INSERT INTO pro_city_area VALUES ('610428', '长武县', '610400');
INSERT INTO pro_city_area VALUES ('610429', '旬邑县', '610400');
INSERT INTO pro_city_area VALUES ('610430', '淳化县', '610400');
INSERT INTO pro_city_area VALUES ('610431', '武功县', '610400');
INSERT INTO pro_city_area VALUES ('610481', '兴平市', '610400');
INSERT INTO pro_city_area VALUES ('610500', '渭南市', '610000');
INSERT INTO pro_city_area VALUES ('610501', '市辖区', '610500');
INSERT INTO pro_city_area VALUES ('610502', '临渭区', '610500');
INSERT INTO pro_city_area VALUES ('610521', '华　县', '610500');
INSERT INTO pro_city_area VALUES ('610522', '潼关县', '610500');
INSERT INTO pro_city_area VALUES ('610523', '大荔县', '610500');
INSERT INTO pro_city_area VALUES ('610524', '合阳县', '610500');
INSERT INTO pro_city_area VALUES ('610525', '澄城县', '610500');
INSERT INTO pro_city_area VALUES ('610526', '蒲城县', '610500');
INSERT INTO pro_city_area VALUES ('610527', '白水县', '610500');
INSERT INTO pro_city_area VALUES ('610528', '富平县', '610500');
INSERT INTO pro_city_area VALUES ('610581', '韩城市', '610500');
INSERT INTO pro_city_area VALUES ('610582', '华阴市', '610500');
INSERT INTO pro_city_area VALUES ('610600', '延安市', '610000');
INSERT INTO pro_city_area VALUES ('610601', '市辖区', '610600');
INSERT INTO pro_city_area VALUES ('610602', '宝塔区', '610600');
INSERT INTO pro_city_area VALUES ('610621', '延长县', '610600');
INSERT INTO pro_city_area VALUES ('610622', '延川县', '610600');
INSERT INTO pro_city_area VALUES ('610623', '子长县', '610600');
INSERT INTO pro_city_area VALUES ('610624', '安塞县', '610600');
INSERT INTO pro_city_area VALUES ('610625', '志丹县', '610600');
INSERT INTO pro_city_area VALUES ('610626', '吴旗县', '610600');
INSERT INTO pro_city_area VALUES ('610627', '甘泉县', '610600');
INSERT INTO pro_city_area VALUES ('610628', '富　县', '610600');
INSERT INTO pro_city_area VALUES ('610629', '洛川县', '610600');
INSERT INTO pro_city_area VALUES ('610630', '宜川县', '610600');
INSERT INTO pro_city_area VALUES ('610631', '黄龙县', '610600');
INSERT INTO pro_city_area VALUES ('610632', '黄陵县', '610600');
INSERT INTO pro_city_area VALUES ('610700', '汉中市', '610000');
INSERT INTO pro_city_area VALUES ('610701', '市辖区', '610700');
INSERT INTO pro_city_area VALUES ('610702', '汉台区', '610700');
INSERT INTO pro_city_area VALUES ('610721', '南郑县', '610700');
INSERT INTO pro_city_area VALUES ('610722', '城固县', '610700');
INSERT INTO pro_city_area VALUES ('610723', '洋　县', '610700');
INSERT INTO pro_city_area VALUES ('610724', '西乡县', '610700');
INSERT INTO pro_city_area VALUES ('610725', '勉　县', '610700');
INSERT INTO pro_city_area VALUES ('610726', '宁强县', '610700');
INSERT INTO pro_city_area VALUES ('610727', '略阳县', '610700');
INSERT INTO pro_city_area VALUES ('610728', '镇巴县', '610700');
INSERT INTO pro_city_area VALUES ('610729', '留坝县', '610700');
INSERT INTO pro_city_area VALUES ('610730', '佛坪县', '610700');
INSERT INTO pro_city_area VALUES ('610800', '榆林市', '610000');
INSERT INTO pro_city_area VALUES ('610801', '市辖区', '610800');
INSERT INTO pro_city_area VALUES ('610802', '榆阳区', '610800');
INSERT INTO pro_city_area VALUES ('610821', '神木县', '610800');
INSERT INTO pro_city_area VALUES ('610822', '府谷县', '610800');
INSERT INTO pro_city_area VALUES ('610823', '横山县', '610800');
INSERT INTO pro_city_area VALUES ('610824', '靖边县', '610800');
INSERT INTO pro_city_area VALUES ('610825', '定边县', '610800');
INSERT INTO pro_city_area VALUES ('610826', '绥德县', '610800');
INSERT INTO pro_city_area VALUES ('610827', '米脂县', '610800');
INSERT INTO pro_city_area VALUES ('610828', '佳　县', '610800');
INSERT INTO pro_city_area VALUES ('610829', '吴堡县', '610800');
INSERT INTO pro_city_area VALUES ('610830', '清涧县', '610800');
INSERT INTO pro_city_area VALUES ('610831', '子洲县', '610800');
INSERT INTO pro_city_area VALUES ('610900', '安康市', '610000');
INSERT INTO pro_city_area VALUES ('610901', '市辖区', '610900');
INSERT INTO pro_city_area VALUES ('610902', '汉滨区', '610900');
INSERT INTO pro_city_area VALUES ('610921', '汉阴县', '610900');
INSERT INTO pro_city_area VALUES ('610922', '石泉县', '610900');
INSERT INTO pro_city_area VALUES ('610923', '宁陕县', '610900');
INSERT INTO pro_city_area VALUES ('610924', '紫阳县', '610900');
INSERT INTO pro_city_area VALUES ('610925', '岚皋县', '610900');
INSERT INTO pro_city_area VALUES ('610926', '平利县', '610900');
INSERT INTO pro_city_area VALUES ('610927', '镇坪县', '610900');
INSERT INTO pro_city_area VALUES ('610928', '旬阳县', '610900');
INSERT INTO pro_city_area VALUES ('610929', '白河县', '610900');
INSERT INTO pro_city_area VALUES ('611000', '商洛市', '610000');
INSERT INTO pro_city_area VALUES ('611001', '市辖区', '611000');
INSERT INTO pro_city_area VALUES ('611002', '商州区', '611000');
INSERT INTO pro_city_area VALUES ('611021', '洛南县', '611000');
INSERT INTO pro_city_area VALUES ('611022', '丹凤县', '611000');
INSERT INTO pro_city_area VALUES ('611023', '商南县', '611000');
INSERT INTO pro_city_area VALUES ('611024', '山阳县', '611000');
INSERT INTO pro_city_area VALUES ('611025', '镇安县', '611000');
INSERT INTO pro_city_area VALUES ('611026', '柞水县', '611000');
INSERT INTO pro_city_area VALUES ('620000', '甘肃省', '0');
INSERT INTO pro_city_area VALUES ('620100', '兰州市', '620000');
INSERT INTO pro_city_area VALUES ('620101', '市辖区', '620100');
INSERT INTO pro_city_area VALUES ('620102', '城关区', '620100');
INSERT INTO pro_city_area VALUES ('620103', '七里河区', '620100');
INSERT INTO pro_city_area VALUES ('620104', '西固区', '620100');
INSERT INTO pro_city_area VALUES ('620105', '安宁区', '620100');
INSERT INTO pro_city_area VALUES ('620111', '红古区', '620100');
INSERT INTO pro_city_area VALUES ('620121', '永登县', '620100');
INSERT INTO pro_city_area VALUES ('620122', '皋兰县', '620100');
INSERT INTO pro_city_area VALUES ('620123', '榆中县', '620100');
INSERT INTO pro_city_area VALUES ('620200', '嘉峪关市', '620000');
INSERT INTO pro_city_area VALUES ('620201', '市辖区', '620200');
INSERT INTO pro_city_area VALUES ('620300', '金昌市', '620000');
INSERT INTO pro_city_area VALUES ('620301', '市辖区', '620300');
INSERT INTO pro_city_area VALUES ('620302', '金川区', '620300');
INSERT INTO pro_city_area VALUES ('620321', '永昌县', '620300');
INSERT INTO pro_city_area VALUES ('620400', '白银市', '620000');
INSERT INTO pro_city_area VALUES ('620401', '市辖区', '620400');
INSERT INTO pro_city_area VALUES ('620402', '白银区', '620400');
INSERT INTO pro_city_area VALUES ('620403', '平川区', '620400');
INSERT INTO pro_city_area VALUES ('620421', '靖远县', '620400');
INSERT INTO pro_city_area VALUES ('620422', '会宁县', '620400');
INSERT INTO pro_city_area VALUES ('620423', '景泰县', '620400');
INSERT INTO pro_city_area VALUES ('620500', '天水市', '620000');
INSERT INTO pro_city_area VALUES ('620501', '市辖区', '620500');
INSERT INTO pro_city_area VALUES ('620502', '秦城区', '620500');
INSERT INTO pro_city_area VALUES ('620503', '北道区', '620500');
INSERT INTO pro_city_area VALUES ('620521', '清水县', '620500');
INSERT INTO pro_city_area VALUES ('620522', '秦安县', '620500');
INSERT INTO pro_city_area VALUES ('620523', '甘谷县', '620500');
INSERT INTO pro_city_area VALUES ('620524', '武山县', '620500');
INSERT INTO pro_city_area VALUES ('620525', '张家川回族自治县', '620500');
INSERT INTO pro_city_area VALUES ('620600', '武威市', '620000');
INSERT INTO pro_city_area VALUES ('620601', '市辖区', '620600');
INSERT INTO pro_city_area VALUES ('620602', '凉州区', '620600');
INSERT INTO pro_city_area VALUES ('620621', '民勤县', '620600');
INSERT INTO pro_city_area VALUES ('620622', '古浪县', '620600');
INSERT INTO pro_city_area VALUES ('620623', '天祝藏族自治县', '620600');
INSERT INTO pro_city_area VALUES ('620700', '张掖市', '620000');
INSERT INTO pro_city_area VALUES ('620701', '市辖区', '620700');
INSERT INTO pro_city_area VALUES ('620702', '甘州区', '620700');
INSERT INTO pro_city_area VALUES ('620721', '肃南裕固族自治县', '620700');
INSERT INTO pro_city_area VALUES ('620722', '民乐县', '620700');
INSERT INTO pro_city_area VALUES ('620723', '临泽县', '620700');
INSERT INTO pro_city_area VALUES ('620724', '高台县', '620700');
INSERT INTO pro_city_area VALUES ('620725', '山丹县', '620700');
INSERT INTO pro_city_area VALUES ('620800', '平凉市', '620000');
INSERT INTO pro_city_area VALUES ('620801', '市辖区', '620800');
INSERT INTO pro_city_area VALUES ('620802', '崆峒区', '620800');
INSERT INTO pro_city_area VALUES ('620821', '泾川县', '620800');
INSERT INTO pro_city_area VALUES ('620822', '灵台县', '620800');
INSERT INTO pro_city_area VALUES ('620823', '崇信县', '620800');
INSERT INTO pro_city_area VALUES ('620824', '华亭县', '620800');
INSERT INTO pro_city_area VALUES ('620825', '庄浪县', '620800');
INSERT INTO pro_city_area VALUES ('620826', '静宁县', '620800');
INSERT INTO pro_city_area VALUES ('620900', '酒泉市', '620000');
INSERT INTO pro_city_area VALUES ('620901', '市辖区', '620900');
INSERT INTO pro_city_area VALUES ('620902', '肃州区', '620900');
INSERT INTO pro_city_area VALUES ('620921', '金塔县', '620900');
INSERT INTO pro_city_area VALUES ('620922', '安西县', '620900');
INSERT INTO pro_city_area VALUES ('620923', '肃北蒙古族自治县', '620900');
INSERT INTO pro_city_area VALUES ('620924', '阿克塞哈萨克族自治县', '620900');
INSERT INTO pro_city_area VALUES ('620981', '玉门市', '620900');
INSERT INTO pro_city_area VALUES ('620982', '敦煌市', '620900');
INSERT INTO pro_city_area VALUES ('621000', '庆阳市', '620000');
INSERT INTO pro_city_area VALUES ('621001', '市辖区', '621000');
INSERT INTO pro_city_area VALUES ('621002', '西峰区', '621000');
INSERT INTO pro_city_area VALUES ('621021', '庆城县', '621000');
INSERT INTO pro_city_area VALUES ('621022', '环　县', '621000');
INSERT INTO pro_city_area VALUES ('621023', '华池县', '621000');
INSERT INTO pro_city_area VALUES ('621024', '合水县', '621000');
INSERT INTO pro_city_area VALUES ('621025', '正宁县', '621000');
INSERT INTO pro_city_area VALUES ('621026', '宁　县', '621000');
INSERT INTO pro_city_area VALUES ('621027', '镇原县', '621000');
INSERT INTO pro_city_area VALUES ('621100', '定西市', '620000');
INSERT INTO pro_city_area VALUES ('621101', '市辖区', '621100');
INSERT INTO pro_city_area VALUES ('621102', '安定区', '621100');
INSERT INTO pro_city_area VALUES ('621121', '通渭县', '621100');
INSERT INTO pro_city_area VALUES ('621122', '陇西县', '621100');
INSERT INTO pro_city_area VALUES ('621123', '渭源县', '621100');
INSERT INTO pro_city_area VALUES ('621124', '临洮县', '621100');
INSERT INTO pro_city_area VALUES ('621125', '漳　县', '621100');
INSERT INTO pro_city_area VALUES ('621126', '岷　县', '621100');
INSERT INTO pro_city_area VALUES ('621200', '陇南市', '620000');
INSERT INTO pro_city_area VALUES ('621201', '市辖区', '621200');
INSERT INTO pro_city_area VALUES ('621202', '武都区', '621200');
INSERT INTO pro_city_area VALUES ('621221', '成　县', '621200');
INSERT INTO pro_city_area VALUES ('621222', '文　县', '621200');
INSERT INTO pro_city_area VALUES ('621223', '宕昌县', '621200');
INSERT INTO pro_city_area VALUES ('621224', '康　县', '621200');
INSERT INTO pro_city_area VALUES ('621225', '西和县', '621200');
INSERT INTO pro_city_area VALUES ('621226', '礼　县', '621200');
INSERT INTO pro_city_area VALUES ('621227', '徽　县', '621200');
INSERT INTO pro_city_area VALUES ('621228', '两当县', '621200');
INSERT INTO pro_city_area VALUES ('622900', '临夏回族自治州', '620000');
INSERT INTO pro_city_area VALUES ('622901', '临夏市', '622900');
INSERT INTO pro_city_area VALUES ('622921', '临夏县', '622900');
INSERT INTO pro_city_area VALUES ('622922', '康乐县', '622900');
INSERT INTO pro_city_area VALUES ('622923', '永靖县', '622900');
INSERT INTO pro_city_area VALUES ('622924', '广河县', '622900');
INSERT INTO pro_city_area VALUES ('622925', '和政县', '622900');
INSERT INTO pro_city_area VALUES ('622926', '东乡族自治县', '622900');
INSERT INTO pro_city_area VALUES ('622927', '积石山保安族东乡族撒拉族自治县', '622900');
INSERT INTO pro_city_area VALUES ('623000', '甘南藏族自治州', '620000');
INSERT INTO pro_city_area VALUES ('623001', '合作市', '623000');
INSERT INTO pro_city_area VALUES ('623021', '临潭县', '623000');
INSERT INTO pro_city_area VALUES ('623022', '卓尼县', '623000');
INSERT INTO pro_city_area VALUES ('623023', '舟曲县', '623000');
INSERT INTO pro_city_area VALUES ('623024', '迭部县', '623000');
INSERT INTO pro_city_area VALUES ('623025', '玛曲县', '623000');
INSERT INTO pro_city_area VALUES ('623026', '碌曲县', '623000');
INSERT INTO pro_city_area VALUES ('623027', '夏河县', '623000');
INSERT INTO pro_city_area VALUES ('630000', '青海省', '0');
INSERT INTO pro_city_area VALUES ('630100', '西宁市', '630000');
INSERT INTO pro_city_area VALUES ('630101', '市辖区', '630100');
INSERT INTO pro_city_area VALUES ('630102', '城东区', '630100');
INSERT INTO pro_city_area VALUES ('630103', '城中区', '630100');
INSERT INTO pro_city_area VALUES ('630104', '城西区', '630100');
INSERT INTO pro_city_area VALUES ('630105', '城北区', '630100');
INSERT INTO pro_city_area VALUES ('630121', '大通回族土族自治县', '630100');
INSERT INTO pro_city_area VALUES ('630122', '湟中县', '630100');
INSERT INTO pro_city_area VALUES ('630123', '湟源县', '630100');
INSERT INTO pro_city_area VALUES ('632100', '海东地区', '630000');
INSERT INTO pro_city_area VALUES ('632121', '平安县', '632100');
INSERT INTO pro_city_area VALUES ('632122', '民和回族土族自治县', '632100');
INSERT INTO pro_city_area VALUES ('632123', '乐都县', '632100');
INSERT INTO pro_city_area VALUES ('632126', '互助土族自治县', '632100');
INSERT INTO pro_city_area VALUES ('632127', '化隆回族自治县', '632100');
INSERT INTO pro_city_area VALUES ('632128', '循化撒拉族自治县', '632100');
INSERT INTO pro_city_area VALUES ('632200', '海北藏族自治州', '630000');
INSERT INTO pro_city_area VALUES ('632221', '门源回族自治县', '632200');
INSERT INTO pro_city_area VALUES ('632222', '祁连县', '632200');
INSERT INTO pro_city_area VALUES ('632223', '海晏县', '632200');
INSERT INTO pro_city_area VALUES ('632224', '刚察县', '632200');
INSERT INTO pro_city_area VALUES ('632300', '黄南藏族自治州', '630000');
INSERT INTO pro_city_area VALUES ('632321', '同仁县', '632300');
INSERT INTO pro_city_area VALUES ('632322', '尖扎县', '632300');
INSERT INTO pro_city_area VALUES ('632323', '泽库县', '632300');
INSERT INTO pro_city_area VALUES ('632324', '河南蒙古族自治县', '632300');
INSERT INTO pro_city_area VALUES ('632500', '海南藏族自治州', '630000');
INSERT INTO pro_city_area VALUES ('632521', '共和县', '632500');
INSERT INTO pro_city_area VALUES ('632522', '同德县', '632500');
INSERT INTO pro_city_area VALUES ('632523', '贵德县', '632500');
INSERT INTO pro_city_area VALUES ('632524', '兴海县', '632500');
INSERT INTO pro_city_area VALUES ('632525', '贵南县', '632500');
INSERT INTO pro_city_area VALUES ('632600', '果洛藏族自治州', '630000');
INSERT INTO pro_city_area VALUES ('632621', '玛沁县', '632600');
INSERT INTO pro_city_area VALUES ('632622', '班玛县', '632600');
INSERT INTO pro_city_area VALUES ('632623', '甘德县', '632600');
INSERT INTO pro_city_area VALUES ('632624', '达日县', '632600');
INSERT INTO pro_city_area VALUES ('632625', '久治县', '632600');
INSERT INTO pro_city_area VALUES ('632626', '玛多县', '632600');
INSERT INTO pro_city_area VALUES ('632700', '玉树藏族自治州', '630000');
INSERT INTO pro_city_area VALUES ('632721', '玉树县', '632700');
INSERT INTO pro_city_area VALUES ('632722', '杂多县', '632700');
INSERT INTO pro_city_area VALUES ('632723', '称多县', '632700');
INSERT INTO pro_city_area VALUES ('632724', '治多县', '632700');
INSERT INTO pro_city_area VALUES ('632725', '囊谦县', '632700');
INSERT INTO pro_city_area VALUES ('632726', '曲麻莱县', '632700');
INSERT INTO pro_city_area VALUES ('632800', '海西蒙古族藏族自治州', '630000');
INSERT INTO pro_city_area VALUES ('632801', '格尔木市', '632800');
INSERT INTO pro_city_area VALUES ('632802', '德令哈市', '632800');
INSERT INTO pro_city_area VALUES ('632821', '乌兰县', '632800');
INSERT INTO pro_city_area VALUES ('632822', '都兰县', '632800');
INSERT INTO pro_city_area VALUES ('632823', '天峻县', '632800');
INSERT INTO pro_city_area VALUES ('640000', '宁  夏', '0');
INSERT INTO pro_city_area VALUES ('640100', '银川市', '640000');
INSERT INTO pro_city_area VALUES ('640101', '市辖区', '640100');
INSERT INTO pro_city_area VALUES ('640104', '兴庆区', '640100');
INSERT INTO pro_city_area VALUES ('640105', '西夏区', '640100');
INSERT INTO pro_city_area VALUES ('640106', '金凤区', '640100');
INSERT INTO pro_city_area VALUES ('640121', '永宁县', '640100');
INSERT INTO pro_city_area VALUES ('640122', '贺兰县', '640100');
INSERT INTO pro_city_area VALUES ('640181', '灵武市', '640100');
INSERT INTO pro_city_area VALUES ('640200', '石嘴山市', '640000');
INSERT INTO pro_city_area VALUES ('640201', '市辖区', '640200');
INSERT INTO pro_city_area VALUES ('640202', '大武口区', '640200');
INSERT INTO pro_city_area VALUES ('640205', '惠农区', '640200');
INSERT INTO pro_city_area VALUES ('640221', '平罗县', '640200');
INSERT INTO pro_city_area VALUES ('640300', '吴忠市', '640000');
INSERT INTO pro_city_area VALUES ('640301', '市辖区', '640300');
INSERT INTO pro_city_area VALUES ('640302', '利通区', '640300');
INSERT INTO pro_city_area VALUES ('640323', '盐池县', '640300');
INSERT INTO pro_city_area VALUES ('640324', '同心县', '640300');
INSERT INTO pro_city_area VALUES ('640381', '青铜峡市', '640300');
INSERT INTO pro_city_area VALUES ('640400', '固原市', '640000');
INSERT INTO pro_city_area VALUES ('640401', '市辖区', '640400');
INSERT INTO pro_city_area VALUES ('640402', '原州区', '640400');
INSERT INTO pro_city_area VALUES ('640422', '西吉县', '640400');
INSERT INTO pro_city_area VALUES ('640423', '隆德县', '640400');
INSERT INTO pro_city_area VALUES ('640424', '泾源县', '640400');
INSERT INTO pro_city_area VALUES ('640425', '彭阳县', '640400');
INSERT INTO pro_city_area VALUES ('640500', '中卫市', '640000');
INSERT INTO pro_city_area VALUES ('640501', '市辖区', '640500');
INSERT INTO pro_city_area VALUES ('640502', '沙坡头区', '640500');
INSERT INTO pro_city_area VALUES ('640521', '中宁县', '640500');
INSERT INTO pro_city_area VALUES ('640522', '海原县', '640500');
INSERT INTO pro_city_area VALUES ('650000', '新  疆', '0');
INSERT INTO pro_city_area VALUES ('650100', '乌鲁木齐市', '650000');
INSERT INTO pro_city_area VALUES ('650101', '市辖区', '650100');
INSERT INTO pro_city_area VALUES ('650102', '天山区', '650100');
INSERT INTO pro_city_area VALUES ('650103', '沙依巴克区', '650100');
INSERT INTO pro_city_area VALUES ('650104', '新市区', '650100');
INSERT INTO pro_city_area VALUES ('650105', '水磨沟区', '650100');
INSERT INTO pro_city_area VALUES ('650106', '头屯河区', '650100');
INSERT INTO pro_city_area VALUES ('650107', '达坂城区', '650100');
INSERT INTO pro_city_area VALUES ('650108', '东山区', '650100');
INSERT INTO pro_city_area VALUES ('650121', '乌鲁木齐县', '650100');
INSERT INTO pro_city_area VALUES ('650200', '克拉玛依市', '650000');
INSERT INTO pro_city_area VALUES ('650201', '市辖区', '650200');
INSERT INTO pro_city_area VALUES ('650202', '独山子区', '650200');
INSERT INTO pro_city_area VALUES ('650203', '克拉玛依区', '650200');
INSERT INTO pro_city_area VALUES ('650204', '白碱滩区', '650200');
INSERT INTO pro_city_area VALUES ('650205', '乌尔禾区', '650200');
INSERT INTO pro_city_area VALUES ('652100', '吐鲁番地区', '650000');
INSERT INTO pro_city_area VALUES ('652101', '吐鲁番市', '652100');
INSERT INTO pro_city_area VALUES ('652122', '鄯善县', '652100');
INSERT INTO pro_city_area VALUES ('652123', '托克逊县', '652100');
INSERT INTO pro_city_area VALUES ('652200', '哈密地区', '650000');
INSERT INTO pro_city_area VALUES ('652201', '哈密市', '652200');
INSERT INTO pro_city_area VALUES ('652222', '巴里坤哈萨克自治县', '652200');
INSERT INTO pro_city_area VALUES ('652223', '伊吾县', '652200');
INSERT INTO pro_city_area VALUES ('652300', '昌吉回族自治州', '650000');
INSERT INTO pro_city_area VALUES ('652301', '昌吉市', '652300');
INSERT INTO pro_city_area VALUES ('652302', '阜康市', '652300');
INSERT INTO pro_city_area VALUES ('652303', '米泉市', '652300');
INSERT INTO pro_city_area VALUES ('652323', '呼图壁县', '652300');
INSERT INTO pro_city_area VALUES ('652324', '玛纳斯县', '652300');
INSERT INTO pro_city_area VALUES ('652325', '奇台县', '652300');
INSERT INTO pro_city_area VALUES ('652327', '吉木萨尔县', '652300');
INSERT INTO pro_city_area VALUES ('652328', '木垒哈萨克自治县', '652300');
INSERT INTO pro_city_area VALUES ('652700', '博尔塔拉蒙古自治州', '650000');
INSERT INTO pro_city_area VALUES ('652701', '博乐市', '652700');
INSERT INTO pro_city_area VALUES ('652722', '精河县', '652700');
INSERT INTO pro_city_area VALUES ('652723', '温泉县', '652700');
INSERT INTO pro_city_area VALUES ('652800', '巴音郭楞蒙古自治州', '650000');
INSERT INTO pro_city_area VALUES ('652801', '库尔勒市', '652800');
INSERT INTO pro_city_area VALUES ('652822', '轮台县', '652800');
INSERT INTO pro_city_area VALUES ('652823', '尉犁县', '652800');
INSERT INTO pro_city_area VALUES ('652824', '若羌县', '652800');
INSERT INTO pro_city_area VALUES ('652825', '且末县', '652800');
INSERT INTO pro_city_area VALUES ('652826', '焉耆回族自治县', '652800');
INSERT INTO pro_city_area VALUES ('652827', '和静县', '652800');
INSERT INTO pro_city_area VALUES ('652828', '和硕县', '652800');
INSERT INTO pro_city_area VALUES ('652829', '博湖县', '652800');
INSERT INTO pro_city_area VALUES ('652900', '阿克苏地区', '650000');
INSERT INTO pro_city_area VALUES ('652901', '阿克苏市', '652900');
INSERT INTO pro_city_area VALUES ('652922', '温宿县', '652900');
INSERT INTO pro_city_area VALUES ('652923', '库车县', '652900');
INSERT INTO pro_city_area VALUES ('652924', '沙雅县', '652900');
INSERT INTO pro_city_area VALUES ('652925', '新和县', '652900');
INSERT INTO pro_city_area VALUES ('652926', '拜城县', '652900');
INSERT INTO pro_city_area VALUES ('652927', '乌什县', '652900');
INSERT INTO pro_city_area VALUES ('652928', '阿瓦提县', '652900');
INSERT INTO pro_city_area VALUES ('652929', '柯坪县', '652900');
INSERT INTO pro_city_area VALUES ('653000', '克孜勒苏柯尔克孜自治州', '650000');
INSERT INTO pro_city_area VALUES ('653001', '阿图什市', '653000');
INSERT INTO pro_city_area VALUES ('653022', '阿克陶县', '653000');
INSERT INTO pro_city_area VALUES ('653023', '阿合奇县', '653000');
INSERT INTO pro_city_area VALUES ('653024', '乌恰县', '653000');
INSERT INTO pro_city_area VALUES ('653100', '喀什地区', '650000');
INSERT INTO pro_city_area VALUES ('653101', '喀什市', '653100');
INSERT INTO pro_city_area VALUES ('653121', '疏附县', '653100');
INSERT INTO pro_city_area VALUES ('653122', '疏勒县', '653100');
INSERT INTO pro_city_area VALUES ('653123', '英吉沙县', '653100');
INSERT INTO pro_city_area VALUES ('653124', '泽普县', '653100');
INSERT INTO pro_city_area VALUES ('653125', '莎车县', '653100');
INSERT INTO pro_city_area VALUES ('653126', '叶城县', '653100');
INSERT INTO pro_city_area VALUES ('653127', '麦盖提县', '653100');
INSERT INTO pro_city_area VALUES ('653128', '岳普湖县', '653100');
INSERT INTO pro_city_area VALUES ('653129', '伽师县', '653100');
INSERT INTO pro_city_area VALUES ('653130', '巴楚县', '653100');
INSERT INTO pro_city_area VALUES ('653131', '塔什库尔干塔吉克自治县', '653100');
INSERT INTO pro_city_area VALUES ('653200', '和田地区', '650000');
INSERT INTO pro_city_area VALUES ('653201', '和田市', '653200');
INSERT INTO pro_city_area VALUES ('653221', '和田县', '653200');
INSERT INTO pro_city_area VALUES ('653222', '墨玉县', '653200');
INSERT INTO pro_city_area VALUES ('653223', '皮山县', '653200');
INSERT INTO pro_city_area VALUES ('653224', '洛浦县', '653200');
INSERT INTO pro_city_area VALUES ('653225', '策勒县', '653200');
INSERT INTO pro_city_area VALUES ('653226', '于田县', '653200');
INSERT INTO pro_city_area VALUES ('653227', '民丰县', '653200');
INSERT INTO pro_city_area VALUES ('654000', '伊犁哈萨克自治州', '650000');
INSERT INTO pro_city_area VALUES ('654002', '伊宁市', '654000');
INSERT INTO pro_city_area VALUES ('654003', '奎屯市', '654000');
INSERT INTO pro_city_area VALUES ('654021', '伊宁县', '654000');
INSERT INTO pro_city_area VALUES ('654022', '察布查尔锡伯自治县', '654000');
INSERT INTO pro_city_area VALUES ('654023', '霍城县', '654000');
INSERT INTO pro_city_area VALUES ('654024', '巩留县', '654000');
INSERT INTO pro_city_area VALUES ('654025', '新源县', '654000');
INSERT INTO pro_city_area VALUES ('654026', '昭苏县', '654000');
INSERT INTO pro_city_area VALUES ('654027', '特克斯县', '654000');
INSERT INTO pro_city_area VALUES ('654028', '尼勒克县', '654000');
INSERT INTO pro_city_area VALUES ('654200', '塔城地区', '650000');
INSERT INTO pro_city_area VALUES ('654201', '塔城市', '654200');
INSERT INTO pro_city_area VALUES ('654202', '乌苏市', '654200');
INSERT INTO pro_city_area VALUES ('654221', '额敏县', '654200');
INSERT INTO pro_city_area VALUES ('654223', '沙湾县', '654200');
INSERT INTO pro_city_area VALUES ('654224', '托里县', '654200');
INSERT INTO pro_city_area VALUES ('654225', '裕民县', '654200');
INSERT INTO pro_city_area VALUES ('654226', '和布克赛尔蒙古自治县', '654200');
INSERT INTO pro_city_area VALUES ('654300', '阿勒泰地区', '650000');
INSERT INTO pro_city_area VALUES ('654301', '阿勒泰市', '654300');
INSERT INTO pro_city_area VALUES ('654321', '布尔津县', '654300');
INSERT INTO pro_city_area VALUES ('654322', '富蕴县', '654300');
INSERT INTO pro_city_area VALUES ('654323', '福海县', '654300');
INSERT INTO pro_city_area VALUES ('654324', '哈巴河县', '654300');
INSERT INTO pro_city_area VALUES ('654325', '青河县', '654300');
INSERT INTO pro_city_area VALUES ('654326', '吉木乃县', '654300');
INSERT INTO pro_city_area VALUES ('659000', '省直辖行政单位', '650000');
INSERT INTO pro_city_area VALUES ('659001', '石河子市', '659000');
INSERT INTO pro_city_area VALUES ('659002', '阿拉尔市', '659000');
INSERT INTO pro_city_area VALUES ('659003', '图木舒克市', '659000');
INSERT INTO pro_city_area VALUES ('659004', '五家渠市', '659000');
INSERT INTO pro_city_area VALUES ('710000', '台湾省', '0');
INSERT INTO pro_city_area VALUES ('810000', '香  港', '0');
INSERT INTO pro_city_area VALUES ('820000', '澳  门', '0');

-- ----------------------------
-- Table structure for `qrtz_blob_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_calendars`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_cron_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO qrtz_cron_triggers VALUES ('cleanRecycleBinJobTrigger', 'DEFAULT', '0 0 1 15 * ?', 'Asia/Shanghai');
INSERT INTO qrtz_cron_triggers VALUES ('reminderOrderJobTrigger', 'DEFAULT', '1 5 1 * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for `qrtz_fired_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_STATEFUL` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_job_details`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `IS_STATEFUL` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO qrtz_job_details VALUES ('cleanRecycleBinJob', 'DEFAULT', null, 'com.baihui.hxtd.soa.job.CleanRecycleBinJob', '0', '0', '0', '1', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787000737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C770800000010000000007800);
INSERT INTO qrtz_job_details VALUES ('reminderOrderJob', 'DEFAULT', null, 'com.baihui.hxtd.soa.job.ReminderOrderJob', '0', '0', '0', '1', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787000737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C770800000010000000007800);

-- ----------------------------
-- Table structure for `qrtz_job_listeners`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_listeners`;
CREATE TABLE `qrtz_job_listeners` (
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `JOB_LISTENER` varchar(200) NOT NULL,
  PRIMARY KEY (`JOB_NAME`,`JOB_GROUP`,`JOB_LISTENER`),
  CONSTRAINT `qrtz_job_listeners_ibfk_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_listeners
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_locks`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO qrtz_locks VALUES ('CALENDAR_ACCESS');
INSERT INTO qrtz_locks VALUES ('JOB_ACCESS');
INSERT INTO qrtz_locks VALUES ('MISFIRE_ACCESS');
INSERT INTO qrtz_locks VALUES ('STATE_ACCESS');
INSERT INTO qrtz_locks VALUES ('TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for `qrtz_paused_trigger_grps`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_scheduler_state`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO qrtz_scheduler_state VALUES ('xiayouxue-PC1413946718686', '1413947267825', '60000');

-- ----------------------------
-- Table structure for `qrtz_simple_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `JOB_NAME` (`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO qrtz_triggers VALUES ('cleanRecycleBinJobTrigger', 'DEFAULT', 'cleanRecycleBinJob', 'DEFAULT', '0', null, '1415984400000', '1413794949644', '5', 'WAITING', 'CRON', '1409293726000', '0', null, '0', '');
INSERT INTO qrtz_triggers VALUES ('reminderOrderJobTrigger', 'DEFAULT', 'reminderOrderJob', 'DEFAULT', '0', null, '1413997501000', '1413943748348', '5', 'WAITING', 'CRON', '1409293726000', '0', null, '0', '');

-- ----------------------------
-- Table structure for `qrtz_trigger_listeners`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_trigger_listeners`;
CREATE TABLE `qrtz_trigger_listeners` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `TRIGGER_LISTENER` varchar(200) NOT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_LISTENER`),
  CONSTRAINT `qrtz_trigger_listeners_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_trigger_listeners
-- ----------------------------

-- ----------------------------
-- Table structure for `receivables`
-- ----------------------------
DROP TABLE IF EXISTS `receivables`;
CREATE TABLE `receivables` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(255) NOT NULL COMMENT '账款名称',
  `CUSTOMER_ID` int(11) NOT NULL COMMENT '客户',
  `ORDER_ID` int(11) NOT NULL COMMENT '订单',
  `FUND` decimal(10,2) NOT NULL COMMENT '账款',
  `STATUS` int(11) NOT NULL COMMENT '收款状态',
  `ACTUAL` decimal(10,2) DEFAULT NULL COMMENT '实际付款',
  `OPERATE_TIME` datetime NOT NULL COMMENT '操作时间',
  `OWNER_ID` int(11) NOT NULL COMMENT '收款者',
  `CREATOR_ID` int(11) NOT NULL COMMENT '创建者',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL COMMENT ' 修改者',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `IS_DELETED` int(11) NOT NULL COMMENT '删除标识',
  `REMARK` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='账款表';

-- ----------------------------
-- Records of receivables
-- ----------------------------
INSERT INTO receivables VALUES ('1', '024568', '1', '1', '232.00', '1', '332.00', '2014-08-18 15:37:24', '1', '1', '2014-08-18 15:37:24', '1', '2014-08-18 15:37:24', '0', '');

-- ----------------------------
-- Table structure for `report`
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `CODE` varchar(32) NOT NULL COMMENT '代码值',
  `NAME` varchar(62) NOT NULL COMMENT '报表名',
  `MODULE_ID` int(11) NOT NULL COMMENT '所属模块主键编号',
  `X_FIELD_NAME` varchar(32) NOT NULL COMMENT 'X轴字段名',
  `X_TYPE_ID` int(11) NOT NULL COMMENT 'X轴分组类型',
  `Y_FIELD_NAME` varchar(32) NOT NULL COMMENT 'Y轴字段名',
  `Y_TYPE_ID` int(11) NOT NULL COMMENT 'Y轴分组类型',
  `Z_FIELD_NAME` varchar(32) DEFAULT NULL COMMENT 'Z轴字段名',
  `Z_TYPE_ID` int(11) DEFAULT NULL COMMENT 'Z轴分组类型',
  `CHART_ID` int(11) NOT NULL COMMENT '图表类型',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '备注',
  `CREATOR_ID` int(11) NOT NULL COMMENT '创建者主键编号',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL COMMENT '修改者主键编号',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `IS_DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '否是被删除',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '否是初始化数据',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='报表表';

-- ----------------------------
-- Records of report
-- ----------------------------
INSERT INTO report VALUES ('1', '02013548', '报表001', '2', 'owner', '48', 'name', '52', null, null, '57', null, '1', '2014-08-18 15:38:21', '1', '2014-09-24 14:25:54', '0', '0');
INSERT INTO report VALUES ('2', '刘啦啦啦', '0009', '1', 'id', '48', 'id', '50', null, null, '56', null, '1', '2014-08-18 18:01:27', '1', '2014-08-18 18:02:01', '0', '0');
INSERT INTO report VALUES ('3', '0001', '不同性别注册量', '9', 'id', '48', 'sex', '51', null, null, '56', null, '1', '2014-09-24 14:23:30', '1', '2014-09-24 14:23:30', '0', '0');
INSERT INTO report VALUES ('4', '0002', '不同月份注册量', '9', 'createdTime', '42', 'id', '50', 'sex', '48', '57', null, '1', '2014-09-24 14:25:09', '1', '2014-09-24 14:32:45', '0', '0');

-- ----------------------------
-- Table structure for `sales_target`
-- ----------------------------
DROP TABLE IF EXISTS `sales_target`;
CREATE TABLE `sales_target` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `OWNER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '目标制定人',
  `BARGAIN_MONEY` decimal(10,4) DEFAULT NULL COMMENT '目标成交金额',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '备注',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `BEGIN_TIME` datetime DEFAULT NULL COMMENT '开始时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',
  `IS_DELETED` int(4) DEFAULT NULL COMMENT '删除标志',
  `TIME_STR` varchar(255) DEFAULT NULL COMMENT '用于储存时间段展现模式',
  `TITLE` varchar(128) DEFAULT NULL COMMENT '标题',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ORG_ID` (`OWNER_ID`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='销售目标表';

-- ----------------------------
-- Records of sales_target
-- ----------------------------
INSERT INTO sales_target VALUES ('1', '6', '233.0000', 'er', '1', '2014-08-18 15:36:53', '1', '2014-08-18 15:36:53', '2014-01-01 00:00:00', '2014-09-30 23:59:59', '0', '2014年 1-9月', '销售目标001');

-- ----------------------------
-- Table structure for `sm_audit_log`
-- ----------------------------
DROP TABLE IF EXISTS `sm_audit_log`;
CREATE TABLE `sm_audit_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `MODULE_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '模块名称',
  `RECORD_ID` int(11) DEFAULT '0' COMMENT '记录ID',
  `RECORD_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '记录名称',
  `TYPE` int(11) NOT NULL DEFAULT '0' COMMENT '操作类型',
  `REMARK` varchar(64) DEFAULT NULL COMMENT '备注',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '操作者ID',
  `CREATED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_USER_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODULE_NAME` (`MODULE_NAME`) USING BTREE,
  KEY `INDEX_TYPE` (`TYPE`) USING BTREE,
  KEY `INDEX_CREATED_TIME` (`CREATED_TIME`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=435 DEFAULT CHARSET=utf8 COMMENT='审计日志表';

-- ----------------------------
-- Records of sm_audit_log
-- ----------------------------
INSERT INTO sm_audit_log VALUES ('1', 'role', '1', '系统管理员', '7', '角色授权', '1', '2014-08-18 14:43:13');
INSERT INTO sm_audit_log VALUES ('2', 'role', '1', '系统管理员', '7', '角色授权', '1', '2014-08-18 14:43:21');
INSERT INTO sm_audit_log VALUES ('3', 'role', '1', '系统管理员', '7', '角色授权', '1', '2014-08-18 14:43:35');
INSERT INTO sm_audit_log VALUES ('4', 'user', '2', 'huizi', '1', '增加用户', '1', '2014-08-18 14:59:11');
INSERT INTO sm_audit_log VALUES ('5', 'role', '2', '系统数据管理员', '7', '角色授权', '1', '2014-08-18 15:05:04');
INSERT INTO sm_audit_log VALUES ('6', 'user', '3', 'lihua投资经理', '1', '增加用户', '1', '2014-08-18 15:06:38');
INSERT INTO sm_audit_log VALUES ('7', 'user', '3', 'lihua投资经理', '2', '修改用户', '1', '2014-08-18 15:06:53');
INSERT INTO sm_audit_log VALUES ('8', 'user', '2', 'huizi', '7', '用户授权', '1', '2014-08-18 15:07:40');
INSERT INTO sm_audit_log VALUES ('9', 'user', '3', '李华（投资经理）', '2', '修改用户', '1', '2014-08-18 15:08:23');
INSERT INTO sm_audit_log VALUES ('10', 'user', '2', '惠子敬-系统管理员', '2', '修改用户', '1', '2014-08-18 15:08:31');
INSERT INTO sm_audit_log VALUES ('11', 'user', '2', '惠子敬（总裁）', '2', '修改用户', '1', '2014-08-18 15:08:57');
INSERT INTO sm_audit_log VALUES ('12', 'user', '4', '罗晓丽（订单审批）', '1', '增加用户', '1', '2014-08-18 15:18:50');
INSERT INTO sm_audit_log VALUES ('13', 'user', '4', '罗晓丽（订单审批）', '2', '修改用户', '1', '2014-08-18 15:19:26');
INSERT INTO sm_audit_log VALUES ('14', 'user', '5', '马敬亮（投资经理）', '1', '增加用户', '1', '2014-08-18 15:21:41');
INSERT INTO sm_audit_log VALUES ('15', 'user', '5', '马敬亮（投资经理）', '2', '修改用户', '1', '2014-08-18 15:21:57');
INSERT INTO sm_audit_log VALUES ('16', 'user', '5', '马敬亮（投资总监）', '2', '修改用户', '1', '2014-08-18 15:22:38');
INSERT INTO sm_audit_log VALUES ('17', 'user', '6', '夏幼学（投资经理）', '1', '增加用户', '1', '2014-08-18 15:23:39');
INSERT INTO sm_audit_log VALUES ('18', 'user', '6', '夏幼学（理财经理）', '2', '修改用户', '1', '2014-08-18 15:24:09');
INSERT INTO sm_audit_log VALUES ('19', 'role', '12', '订单审批流程测试角色', '7', '角色授权', '1', '2014-08-18 15:26:06');
INSERT INTO sm_audit_log VALUES ('20', 'user', '6', '夏幼学（理财经理）', '7', '用户授权', '1', '2014-08-18 15:27:03');
INSERT INTO sm_audit_log VALUES ('21', 'user', '5', '马敬亮（投资总监）', '7', '用户授权', '1', '2014-08-18 15:27:23');
INSERT INTO sm_audit_log VALUES ('22', 'user', '4', '罗晓丽（订单审批）', '7', '用户授权', '1', '2014-08-18 15:27:48');
INSERT INTO sm_audit_log VALUES ('23', 'user', '7', '张雪梅（财务专员）', '1', '增加用户', '1', '2014-08-18 15:27:51');
INSERT INTO sm_audit_log VALUES ('24', 'user', '7', '张雪梅（财务专员）', '2', '修改用户', '1', '2014-08-18 15:28:04');
INSERT INTO sm_audit_log VALUES ('25', 'user', '3', '李华（投资经理）', '7', '用户授权', '1', '2014-08-18 15:28:07');
INSERT INTO sm_audit_log VALUES ('26', 'user', '7', '张雪梅（财务专员）', '7', '用户授权', '1', '2014-08-18 15:28:35');
INSERT INTO sm_audit_log VALUES ('27', 'customer', '1', '客户01', '1', '增加客户', '1', '2014-08-18 15:29:59');
INSERT INTO sm_audit_log VALUES ('28', 'memoir', '1', '丝袜的', '1', '增加联系人纪要', '1', '2014-08-18 15:30:18');
INSERT INTO sm_audit_log VALUES ('29', 'supplier', '1', '供应商001', '1', '增加供应商', '1', '2014-08-18 15:31:52');
INSERT INTO sm_audit_log VALUES ('30', 'project', '1', '项目001', '1', '增加项目', '1', '2014-08-18 15:32:47');
INSERT INTO sm_audit_log VALUES ('31', 'user', '4', '罗晓丽（财务专员）', '2', '修改用户', '1', '2014-08-18 15:33:23');
INSERT INTO sm_audit_log VALUES ('32', 'product', '1', ' 产品001', '1', '增加产品', '1', '2014-08-18 15:33:56');
INSERT INTO sm_audit_log VALUES ('33', 'user', '4', '罗晓丽（财务专员）', '2', '修改用户', '1', '2014-08-18 15:34:29');
INSERT INTO sm_audit_log VALUES ('34', 'order', '1', '024568', '1', '增加订单', '1', '2014-08-18 15:34:35');
INSERT INTO sm_audit_log VALUES ('35', 'user', '2', '惠子敬（总裁）', '2', '修改用户', '1', '2014-08-18 15:35:27');
INSERT INTO sm_audit_log VALUES ('36', 'contract', '1', '024568', '1', '增加合同', '1', '2014-08-18 15:35:43');
INSERT INTO sm_audit_log VALUES ('37', 'user', '2', '惠子敬（总裁）', '2', '修改用户', '1', '2014-08-18 15:35:53');
INSERT INTO sm_audit_log VALUES ('38', 'salesTarget', '1', '销售目标001', '1', '增加销售目标', '1', '2014-08-18 15:36:53');
INSERT INTO sm_audit_log VALUES ('39', 'receivables', '1', '024568', '1', '增加应收账款', '1', '2014-08-18 15:37:24');
INSERT INTO sm_audit_log VALUES ('40', 'payments', '1', '024568', '1', '增加应付账款', '1', '2014-08-18 15:38:05');
INSERT INTO sm_audit_log VALUES ('41', 'user', '4', '罗晓丽（财务专员）', '7', '用户授权', '1', '2014-08-18 15:38:17');
INSERT INTO sm_audit_log VALUES ('42', 'report', '1', '报表001', '1', '增加报表', '1', '2014-08-18 15:38:55');
INSERT INTO sm_audit_log VALUES ('43', 'user', '4', '罗晓丽（财务专员）', '2', '修改用户', '1', '2014-08-18 15:39:22');
INSERT INTO sm_audit_log VALUES ('44', 'notice', '1', 'dd公告', '1', '增加系统公告', '1', '2014-08-18 15:39:34');
INSERT INTO sm_audit_log VALUES ('45', 'userMessage', '2', '系统消息', '1', '增加系统消息', '1', '2014-08-18 15:40:12');
INSERT INTO sm_audit_log VALUES ('46', 'userMessage', '4', '系统消息', '1', '增加系统消息', '1', '2014-08-18 15:40:13');
INSERT INTO sm_audit_log VALUES ('47', 'userMessage', '6', 'fd', '1', '增加系统消息', '1', '2014-08-18 15:41:54');
INSERT INTO sm_audit_log VALUES ('48', 'userMessage', '8', 'fd', '1', '增加系统消息', '1', '2014-08-18 15:41:56');
INSERT INTO sm_audit_log VALUES ('49', 'userMessage', '10', 'fd', '1', '增加系统消息', '1', '2014-08-18 15:41:58');
INSERT INTO sm_audit_log VALUES ('50', 'userMessage', '12', 'fd', '1', '增加系统消息', '1', '2014-08-18 15:42:01');
INSERT INTO sm_audit_log VALUES ('51', 'userMessage', '14', 'fd', '1', '增加系统消息', '1', '2014-08-18 15:42:03');
INSERT INTO sm_audit_log VALUES ('52', 'userMessage', '16', 'fd', '1', '增加系统消息', '1', '2014-08-18 15:42:03');
INSERT INTO sm_audit_log VALUES ('53', 'user', '8', '李晓（理财经理）', '1', '增加用户', '1', '2014-08-18 15:42:45');
INSERT INTO sm_audit_log VALUES ('54', 'user', '8', '李晓（理财经理）', '2', '修改用户', '1', '2014-08-18 15:43:05');
INSERT INTO sm_audit_log VALUES ('55', 'user', '3', '李华（投资经理）', '7', '用户授权', '1', '2014-08-18 15:45:39');
INSERT INTO sm_audit_log VALUES ('56', 'userMessage', '18', 'adsa', '1', '增加系统消息', '3', '2014-08-18 15:46:23');
INSERT INTO sm_audit_log VALUES ('57', 'user', '9', '张毅（投资总监）', '1', '增加用户', '1', '2014-08-18 15:47:35');
INSERT INTO sm_audit_log VALUES ('58', 'user', '10', '张三（投资总监）', '1', '增加用户', '1', '2014-08-18 15:48:40');
INSERT INTO sm_audit_log VALUES ('59', 'contact', '1', '联系人001', '1', '增加联系人', '1', '2014-08-18 15:51:14');
INSERT INTO sm_audit_log VALUES ('60', 'user', '11', '肥仔（昌平-理财经理）', '1', '增加用户', '1', '2014-08-18 15:52:35');
INSERT INTO sm_audit_log VALUES ('61', 'lead', '1', '线索001', '1', '增加线索', '1', '2014-08-18 15:52:44');
INSERT INTO sm_audit_log VALUES ('62', 'lead', '1', '线索001', '14', '线索转换客户，联系人', '1', '2014-08-18 15:52:52');
INSERT INTO sm_audit_log VALUES ('63', 'lead', '2', '线索002', '1', '增加线索', '1', '2014-08-18 15:53:13');
INSERT INTO sm_audit_log VALUES ('64', 'customer', '2', '线索001', '2', '修改客户', '1', '2014-08-18 15:54:13');
INSERT INTO sm_audit_log VALUES ('65', 'user', '12', '华龙（海淀-投资经理）', '1', '增加用户', '1', '2014-08-18 15:54:16');
INSERT INTO sm_audit_log VALUES ('66', 'supplier', '1', '中国人民银行丰台分行', '2', '修改供应商', '1', '2014-08-18 15:56:16');
INSERT INTO sm_audit_log VALUES ('67', 'supplier', '1', '中国人民银行丰台分行', '2', '修改供应商', '1', '2014-08-18 15:57:03');
INSERT INTO sm_audit_log VALUES ('68', 'supplier', '1', '中国人民银行丰台分行', '2', '修改供应商', '1', '2014-08-18 15:57:40');
INSERT INTO sm_audit_log VALUES ('69', 'supplier', '1', '中国人民银行丰台分行', '2', '修改供应商', '1', '2014-08-18 15:58:09');
INSERT INTO sm_audit_log VALUES ('70', 'project', '1', '中国人民银行丰台分行融资项目', '2', '修改项目', '1', '2014-08-18 15:59:04');
INSERT INTO sm_audit_log VALUES ('71', 'user', '13', '唐飞', '1', '增加用户', '1', '2014-08-18 16:03:01');
INSERT INTO sm_audit_log VALUES ('72', 'user', '13', '唐飞（理财经理）', '2', '修改用户', '1', '2014-08-18 16:03:22');
INSERT INTO sm_audit_log VALUES ('73', 'user', '13', '唐飞（理财经理）', '7', '用户授权', '1', '2014-08-18 16:03:48');
INSERT INTO sm_audit_log VALUES ('74', 'role', '1', '系统管理员', '7', '角色授权', '1', '2014-08-18 16:12:12');
INSERT INTO sm_audit_log VALUES ('75', 'organization', '1', '华兴控股', '7', '组织授权', '1', '2014-08-18 16:13:15');
INSERT INTO sm_audit_log VALUES ('76', 'marketActivity', '1', '招商活动', '1', '增加市场活动', '1', '2014-08-18 16:14:47');
INSERT INTO sm_audit_log VALUES ('77', 'dictionary', '347', 'ceshi(liu)', '1', '字典增加', '1', '2014-08-18 17:59:28');
INSERT INTO sm_audit_log VALUES ('78', 'dictionary', '347', 'ceshi(liu)', '4', '字典删除', '1', '2014-08-18 17:59:53');
INSERT INTO sm_audit_log VALUES ('79', 'report', '2', '0009', '1', '增加报表', '1', '2014-08-18 18:02:01');
INSERT INTO sm_audit_log VALUES ('80', 'lead', '3', '1', '1', '增加线索', '1', '2014-08-19 09:50:37');
INSERT INTO sm_audit_log VALUES ('81', 'marketActivity', '2', '基金中国（测试）', '1', '增加市场活动', '1', '2014-08-19 10:05:24');
INSERT INTO sm_audit_log VALUES ('82', 'marketActivity', '3', '基金中国（测试1）', '1', '增加市场活动', '1', '2014-08-19 10:12:14');
INSERT INTO sm_audit_log VALUES ('83', 'marketActivity', '4', '侧身睡（测试）', '1', '增加市场活动', '1', '2014-08-19 10:14:33');
INSERT INTO sm_audit_log VALUES ('84', 'user', '10', '张三（投资总监）', '10', '禁用用户', '1', '2014-08-19 10:16:24');
INSERT INTO sm_audit_log VALUES ('85', 'marketActivity', '5', '测试数据', '1', '增加市场活动', '1', '2014-08-19 10:16:34');
INSERT INTO sm_audit_log VALUES ('86', 'lead', '4', 'xiaoaa（测试）', '1', '增加线索', '1', '2014-08-19 10:29:51');
INSERT INTO sm_audit_log VALUES ('87', 'lead', '4', 'xiaoaa（测试）', '14', '线索转换客户，联系人', '1', '2014-08-19 10:30:19');
INSERT INTO sm_audit_log VALUES ('88', 'lead', null, '导入数据2条', '5', '共导入[2]条数据,成功导入 [ 0 ]条数据,失败导入[ 0 ]条数据', '1', '2014-08-19 10:41:27');
INSERT INTO sm_audit_log VALUES ('89', 'lead', '5', '罗晓丽6', '4', '删除线索', '1', '2014-08-19 10:49:12');
INSERT INTO sm_audit_log VALUES ('90', 'lead', '6', '罗晓丽4', '4', '删除线索', '1', '2014-08-19 10:49:12');
INSERT INTO sm_audit_log VALUES ('91', 'lead', '7', 'luoxiaoli—测试', '1', '增加线索', '1', '2014-08-19 11:56:40');
INSERT INTO sm_audit_log VALUES ('92', 'lead', '8', '线索009（测试）', '1', '增加线索', '1', '2014-08-19 13:40:02');
INSERT INTO sm_audit_log VALUES ('93', 'lead', '8', '线索009（测试）', '2', '修改线索', '1', '2014-08-19 13:40:30');
INSERT INTO sm_audit_log VALUES ('94', 'lead', '8', '线索009（测试）', '2', '批量更改所有者', '1', '2014-08-19 13:41:18');
INSERT INTO sm_audit_log VALUES ('95', 'lead', '8', '线索009（测试）', '2', '修改线索', '1', '2014-08-19 13:41:50');
INSERT INTO sm_audit_log VALUES ('96', 'lead', '8', '线索009（测试）', '4', '删除线索', '1', '2014-08-19 13:42:08');
INSERT INTO sm_audit_log VALUES ('97', 'dictionary', '348', '测试数据', '1', '字典增加', '1', '2014-08-19 13:46:12');
INSERT INTO sm_audit_log VALUES ('98', 'dictionary', '348', '测试数据88', '2', '字典修改', '1', '2014-08-19 13:47:07');
INSERT INTO sm_audit_log VALUES ('99', 'dictionary', '348', '测试数据88', '4', '字典删除', '1', '2014-08-19 13:47:28');
INSERT INTO sm_audit_log VALUES ('100', 'customer', null, '导出列表选中的数据', '6', '共导出2条数据', '1', '2014-08-19 13:53:56');
INSERT INTO sm_audit_log VALUES ('101', 'customer', null, '导出列表选中的数据', '6', '共导出3条数据', '1', '2014-08-19 13:55:06');
INSERT INTO sm_audit_log VALUES ('102', 'customer', '3', 'xiaoaa（测试）', '4', '删除客户', '1', '2014-08-19 13:55:45');
INSERT INTO sm_audit_log VALUES ('103', 'customer', '2', '线索001', '4', '删除客户', '1', '2014-08-19 13:55:45');
INSERT INTO sm_audit_log VALUES ('104', 'customer', '1', '客户01', '4', '删除客户', '1', '2014-08-19 13:55:45');
INSERT INTO sm_audit_log VALUES ('105', 'customer', '3', 'xiaoaa（测试）', '4', '删除客户', '1', '2014-08-19 13:59:39');
INSERT INTO sm_audit_log VALUES ('106', 'customer', '4', '客户1——测试', '1', '增加客户', '1', '2014-08-19 14:02:09');
INSERT INTO sm_audit_log VALUES ('107', 'customer', '4', '客户1——测试', '2', '修改客户', '1', '2014-08-19 14:10:30');
INSERT INTO sm_audit_log VALUES ('108', 'contact', '4', 'xiaoaa', '1', '增加联系人', '1', '2014-08-19 14:14:57');
INSERT INTO sm_audit_log VALUES ('109', 'supplier', '2', 'luoxiaoli（测试数据）', '1', '增加供应商', '1', '2014-08-19 14:17:02');
INSERT INTO sm_audit_log VALUES ('110', 'supplier', '2', 'luoxiaoli（测试数据）', '2', '修改供应商', '1', '2014-08-19 14:18:32');
INSERT INTO sm_audit_log VALUES ('111', 'supplier', '3', 'awu(测试数据）', '1', '增加供应商', '1', '2014-08-19 14:22:27');
INSERT INTO sm_audit_log VALUES ('112', 'contact', '4', 'xiaoaa', '2', '修改联系人', '1', '2014-08-19 14:24:10');
INSERT INTO sm_audit_log VALUES ('113', 'contact', '4', 'xiaoaa', '4', '删除联系人', '1', '2014-08-19 14:24:30');
INSERT INTO sm_audit_log VALUES ('114', 'contact', '3', 'xiaoaa（测试）', '2', '修改联系人', '1', '2014-08-19 14:25:01');
INSERT INTO sm_audit_log VALUES ('115', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-19 14:25:15');
INSERT INTO sm_audit_log VALUES ('116', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-19 14:25:24');
INSERT INTO sm_audit_log VALUES ('117', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-19 14:25:39');
INSERT INTO sm_audit_log VALUES ('118', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-19 14:28:43');
INSERT INTO sm_audit_log VALUES ('119', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-19 14:29:05');
INSERT INTO sm_audit_log VALUES ('120', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-19 14:29:11');
INSERT INTO sm_audit_log VALUES ('121', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-19 14:29:17');
INSERT INTO sm_audit_log VALUES ('122', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-19 14:29:23');
INSERT INTO sm_audit_log VALUES ('123', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-19 14:29:30');
INSERT INTO sm_audit_log VALUES ('124', 'supplier', '4', '供应商（测试）', '1', '增加供应商', '1', '2014-08-19 14:59:52');
INSERT INTO sm_audit_log VALUES ('125', 'project', '2', '虹桥（测试）', '1', '增加项目', '1', '2014-08-19 15:01:11');
INSERT INTO sm_audit_log VALUES ('126', 'project', '3', 'admin', '1', '增加项目', '1', '2014-08-19 15:11:13');
INSERT INTO sm_audit_log VALUES ('127', 'project', '4', '项目', '1', '增加项目', '1', '2014-08-19 15:39:55');
INSERT INTO sm_audit_log VALUES ('128', 'product', '2', '余额宝', '1', '增加产品', '1', '2014-08-19 15:42:11');
INSERT INTO sm_audit_log VALUES ('129', 'product', '2', '余额宝（测试）', '2', '修改产品', '1', '2014-08-19 15:42:30');
INSERT INTO sm_audit_log VALUES ('130', 'product', '2', '余额宝（测试）', '4', '删除产品', '1', '2014-08-19 15:44:02');
INSERT INTO sm_audit_log VALUES ('131', 'product', '1', ' 产品001', '4', '删除产品', '1', '2014-08-19 15:44:08');
INSERT INTO sm_audit_log VALUES ('132', 'recyclebin', '12', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:35');
INSERT INTO sm_audit_log VALUES ('133', 'recyclebin', '13', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:35');
INSERT INTO sm_audit_log VALUES ('134', 'recyclebin', '14', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:35');
INSERT INTO sm_audit_log VALUES ('135', 'recyclebin', '15', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:35');
INSERT INTO sm_audit_log VALUES ('136', 'recyclebin', '16', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:35');
INSERT INTO sm_audit_log VALUES ('137', 'recyclebin', '17', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:35');
INSERT INTO sm_audit_log VALUES ('138', 'recyclebin', '18', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:35');
INSERT INTO sm_audit_log VALUES ('139', 'recyclebin', '19', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:35');
INSERT INTO sm_audit_log VALUES ('140', 'recyclebin', '20', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:35');
INSERT INTO sm_audit_log VALUES ('141', 'recyclebin', '21', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:35');
INSERT INTO sm_audit_log VALUES ('142', 'recyclebin', '12', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('143', 'recyclebin', '13', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('144', 'recyclebin', '14', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('145', 'recyclebin', '15', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('146', 'recyclebin', '16', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('147', 'recyclebin', '17', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('148', 'recyclebin', '18', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('149', 'recyclebin', '19', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('150', 'recyclebin', '20', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('151', 'recyclebin', '21', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('152', 'recyclebin', '12', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('153', 'recyclebin', '13', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('154', 'recyclebin', '14', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('155', 'recyclebin', '15', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('156', 'recyclebin', '16', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('157', 'recyclebin', '17', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('158', 'recyclebin', '18', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('159', 'recyclebin', '19', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('160', 'recyclebin', '20', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('161', 'recyclebin', '21', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:36');
INSERT INTO sm_audit_log VALUES ('162', 'recyclebin', '12', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('163', 'recyclebin', '13', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('164', 'recyclebin', '14', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('165', 'recyclebin', '15', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('166', 'recyclebin', '16', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('167', 'recyclebin', '17', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('168', 'recyclebin', '18', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('169', 'recyclebin', '19', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('170', 'recyclebin', '20', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('171', 'recyclebin', '21', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('172', 'recyclebin', '12', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('173', 'recyclebin', '13', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('174', 'recyclebin', '14', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('175', 'recyclebin', '15', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('176', 'recyclebin', '16', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('177', 'recyclebin', '17', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('178', 'recyclebin', '18', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('179', 'recyclebin', '19', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('180', 'recyclebin', '20', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('181', 'recyclebin', '21', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('182', 'recyclebin', '12', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('183', 'recyclebin', '13', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('184', 'recyclebin', '14', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('185', 'recyclebin', '15', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('186', 'recyclebin', '16', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('187', 'recyclebin', '17', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('188', 'recyclebin', '18', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('189', 'recyclebin', '19', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('190', 'recyclebin', '20', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:37');
INSERT INTO sm_audit_log VALUES ('191', 'recyclebin', '21', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('192', 'recyclebin', '12', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('193', 'recyclebin', '13', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('194', 'recyclebin', '14', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('195', 'recyclebin', '15', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('196', 'recyclebin', '16', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('197', 'recyclebin', '17', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('198', 'recyclebin', '18', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('199', 'recyclebin', '19', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('200', 'recyclebin', '20', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('201', 'recyclebin', '21', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('202', 'recyclebin', '12', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('203', 'recyclebin', '13', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('204', 'recyclebin', '14', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('205', 'recyclebin', '15', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('206', 'recyclebin', '16', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('207', 'recyclebin', '17', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('208', 'recyclebin', '18', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('209', 'recyclebin', '19', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('210', 'recyclebin', '20', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('211', 'recyclebin', '21', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('212', 'recyclebin', '12', '余额宝（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('213', 'recyclebin', '13', '余额宝（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('214', 'recyclebin', '14', '余额宝（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('215', 'recyclebin', '15', '余额宝（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('216', 'recyclebin', '16', '余额宝（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('217', 'recyclebin', '17', '余额宝（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('218', 'recyclebin', '18', '余额宝（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('219', 'recyclebin', '19', '余额宝（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('220', 'recyclebin', '20', '余额宝（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('221', 'recyclebin', '21', '余额宝（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:38');
INSERT INTO sm_audit_log VALUES ('222', 'recyclebin', '12', ' 产品001', '13', '还原删除数据', '1', '2014-08-19 15:44:39');
INSERT INTO sm_audit_log VALUES ('223', 'recyclebin', '13', ' 产品001', '13', '还原删除数据', '1', '2014-08-19 15:44:39');
INSERT INTO sm_audit_log VALUES ('224', 'recyclebin', '14', ' 产品001', '13', '还原删除数据', '1', '2014-08-19 15:44:39');
INSERT INTO sm_audit_log VALUES ('225', 'recyclebin', '15', ' 产品001', '13', '还原删除数据', '1', '2014-08-19 15:44:39');
INSERT INTO sm_audit_log VALUES ('226', 'recyclebin', '16', ' 产品001', '13', '还原删除数据', '1', '2014-08-19 15:44:39');
INSERT INTO sm_audit_log VALUES ('227', 'recyclebin', '17', ' 产品001', '13', '还原删除数据', '1', '2014-08-19 15:44:39');
INSERT INTO sm_audit_log VALUES ('228', 'recyclebin', '18', ' 产品001', '13', '还原删除数据', '1', '2014-08-19 15:44:39');
INSERT INTO sm_audit_log VALUES ('229', 'recyclebin', '19', ' 产品001', '13', '还原删除数据', '1', '2014-08-19 15:44:39');
INSERT INTO sm_audit_log VALUES ('230', 'recyclebin', '20', ' 产品001', '13', '还原删除数据', '1', '2014-08-19 15:44:39');
INSERT INTO sm_audit_log VALUES ('231', 'recyclebin', '21', ' 产品001', '13', '还原删除数据', '1', '2014-08-19 15:44:39');
INSERT INTO sm_audit_log VALUES ('232', 'recyclebin', '2', '罗晓丽6', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('233', 'recyclebin', '3', '罗晓丽6', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('234', 'recyclebin', '4', '罗晓丽6', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('235', 'recyclebin', '5', '罗晓丽6', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('236', 'recyclebin', '6', '罗晓丽6', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('237', 'recyclebin', '7', '罗晓丽6', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('238', 'recyclebin', '8', '罗晓丽6', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('239', 'recyclebin', '9', '罗晓丽6', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('240', 'recyclebin', '10', '罗晓丽6', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('241', 'recyclebin', '11', '罗晓丽6', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('242', 'recyclebin', '2', '罗晓丽4', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('243', 'recyclebin', '3', '罗晓丽4', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('244', 'recyclebin', '4', '罗晓丽4', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('245', 'recyclebin', '5', '罗晓丽4', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('246', 'recyclebin', '6', '罗晓丽4', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('247', 'recyclebin', '7', '罗晓丽4', '13', '还原删除数据', '1', '2014-08-19 15:44:49');
INSERT INTO sm_audit_log VALUES ('248', 'recyclebin', '8', '罗晓丽4', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('249', 'recyclebin', '9', '罗晓丽4', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('250', 'recyclebin', '10', '罗晓丽4', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('251', 'recyclebin', '11', '罗晓丽4', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('252', 'recyclebin', '2', '线索009（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('253', 'recyclebin', '3', '线索009（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('254', 'recyclebin', '4', '线索009（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('255', 'recyclebin', '5', '线索009（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('256', 'recyclebin', '6', '线索009（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('257', 'recyclebin', '7', '线索009（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('258', 'recyclebin', '8', '线索009（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('259', 'recyclebin', '9', '线索009（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('260', 'recyclebin', '10', '线索009（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('261', 'recyclebin', '11', '线索009（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('262', 'recyclebin', '2', '测试数据88', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('263', 'recyclebin', '3', '测试数据88', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('264', 'recyclebin', '4', '测试数据88', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('265', 'recyclebin', '5', '测试数据88', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('266', 'recyclebin', '6', '测试数据88', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('267', 'recyclebin', '7', '测试数据88', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('268', 'recyclebin', '8', '测试数据88', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('269', 'recyclebin', '9', '测试数据88', '13', '还原删除数据', '1', '2014-08-19 15:44:50');
INSERT INTO sm_audit_log VALUES ('270', 'recyclebin', '10', '测试数据88', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('271', 'recyclebin', '11', '测试数据88', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('272', 'recyclebin', '2', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('273', 'recyclebin', '3', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('274', 'recyclebin', '4', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('275', 'recyclebin', '5', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('276', 'recyclebin', '6', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('277', 'recyclebin', '7', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('278', 'recyclebin', '8', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('279', 'recyclebin', '9', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('280', 'recyclebin', '10', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('281', 'recyclebin', '11', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('282', 'recyclebin', '2', '线索001', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('283', 'recyclebin', '3', '线索001', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('284', 'recyclebin', '4', '线索001', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('285', 'recyclebin', '5', '线索001', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('286', 'recyclebin', '6', '线索001', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('287', 'recyclebin', '7', '线索001', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('288', 'recyclebin', '8', '线索001', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('289', 'recyclebin', '9', '线索001', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('290', 'recyclebin', '10', '线索001', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('291', 'recyclebin', '11', '线索001', '13', '还原删除数据', '1', '2014-08-19 15:44:51');
INSERT INTO sm_audit_log VALUES ('292', 'recyclebin', '2', '客户01', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('293', 'recyclebin', '3', '客户01', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('294', 'recyclebin', '4', '客户01', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('295', 'recyclebin', '5', '客户01', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('296', 'recyclebin', '6', '客户01', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('297', 'recyclebin', '7', '客户01', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('298', 'recyclebin', '8', '客户01', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('299', 'recyclebin', '9', '客户01', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('300', 'recyclebin', '10', '客户01', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('301', 'recyclebin', '11', '客户01', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('302', 'recyclebin', '2', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('303', 'recyclebin', '3', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('304', 'recyclebin', '4', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('305', 'recyclebin', '5', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('306', 'recyclebin', '6', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('307', 'recyclebin', '7', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('308', 'recyclebin', '8', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('309', 'recyclebin', '9', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('310', 'recyclebin', '10', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('311', 'recyclebin', '11', 'xiaoaa（测试）', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('312', 'recyclebin', '2', 'xiaoaa', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('313', 'recyclebin', '3', 'xiaoaa', '13', '还原删除数据', '1', '2014-08-19 15:44:52');
INSERT INTO sm_audit_log VALUES ('314', 'recyclebin', '4', 'xiaoaa', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('315', 'recyclebin', '5', 'xiaoaa', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('316', 'recyclebin', '6', 'xiaoaa', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('317', 'recyclebin', '7', 'xiaoaa', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('318', 'recyclebin', '8', 'xiaoaa', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('319', 'recyclebin', '9', 'xiaoaa', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('320', 'recyclebin', '10', 'xiaoaa', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('321', 'recyclebin', '11', 'xiaoaa', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('322', 'recyclebin', '2', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('323', 'recyclebin', '3', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('324', 'recyclebin', '4', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('325', 'recyclebin', '5', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('326', 'recyclebin', '6', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('327', 'recyclebin', '7', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('328', 'recyclebin', '8', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('329', 'recyclebin', '9', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('330', 'recyclebin', '10', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('331', 'recyclebin', '11', 'awu(测试数据）', '13', '还原删除数据', '1', '2014-08-19 15:44:53');
INSERT INTO sm_audit_log VALUES ('332', 'order', '2', '123456', '1', '增加订单', '1', '2014-08-19 15:47:40');
INSERT INTO sm_audit_log VALUES ('333', 'user', '14', '小兰（测试-理财专员）', '1', '增加用户', '1', '2014-08-19 15:51:30');
INSERT INTO sm_audit_log VALUES ('334', 'user', '15', '小兰1（理财经理）', '1', '增加用户', '1', '2014-08-19 15:53:32');
INSERT INTO sm_audit_log VALUES ('335', 'user', '16', '小兰2（投资经理）', '1', '增加用户', '1', '2014-08-19 15:55:25');
INSERT INTO sm_audit_log VALUES ('336', 'user', '17', '小兰3（投资总监）', '1', '增加用户', '1', '2014-08-19 15:57:13');
INSERT INTO sm_audit_log VALUES ('337', 'user', '18', '小兰4（副总裁）', '1', '增加用户', '1', '2014-08-19 15:59:33');
INSERT INTO sm_audit_log VALUES ('338', 'user', '19', '小兰5（总裁审核）', '1', '增加用户', '1', '2014-08-19 16:01:34');
INSERT INTO sm_audit_log VALUES ('339', 'user', '14', '小兰（测试-理财专员）', '7', '用户授权', '1', '2014-08-19 16:02:59');
INSERT INTO sm_audit_log VALUES ('340', 'user', '14', '小兰（测试-理财专员）', '7', '用户授权', '1', '2014-08-19 16:03:16');
INSERT INTO sm_audit_log VALUES ('341', 'user', '15', '小兰1（理财经理）', '7', '用户授权', '1', '2014-08-19 16:05:09');
INSERT INTO sm_audit_log VALUES ('342', 'user', '16', '小兰2（投资经理）', '7', '用户授权', '1', '2014-08-19 16:07:10');
INSERT INTO sm_audit_log VALUES ('343', 'user', '17', '小兰3（投资总监）', '7', '用户授权', '1', '2014-08-19 16:07:44');
INSERT INTO sm_audit_log VALUES ('344', 'user', '18', '小兰4（副总裁）', '7', '用户授权', '1', '2014-08-19 16:09:00');
INSERT INTO sm_audit_log VALUES ('345', 'user', '19', '小兰5（总裁审核）', '7', '用户授权', '1', '2014-08-19 16:09:34');
INSERT INTO sm_audit_log VALUES ('346', 'user', '18', '小兰4（副总裁）', '7', '用户授权', '1', '2014-08-19 16:09:53');
INSERT INTO sm_audit_log VALUES ('347', 'role', '6', '总裁', '7', '角色授权', '1', '2014-08-19 16:10:41');
INSERT INTO sm_audit_log VALUES ('348', 'role', '6', '总裁', '7', '角色授权', '1', '2014-08-19 16:11:12');
INSERT INTO sm_audit_log VALUES ('349', 'role', '8', '财务', '7', '角色授权', '1', '2014-08-19 16:12:10');
INSERT INTO sm_audit_log VALUES ('350', 'role', '11', '理财经理', '7', '角色授权', '1', '2014-08-19 16:13:34');
INSERT INTO sm_audit_log VALUES ('351', 'user', '19', '小兰5（总裁审核）', '2', '修改用户', '1', '2014-08-19 16:15:35');
INSERT INTO sm_audit_log VALUES ('352', 'marketActivity', '6', '资金安全', '1', '增加市场活动', '14', '2014-08-19 16:18:54');
INSERT INTO sm_audit_log VALUES ('353', 'lead', '9', '测试111', '1', '增加线索', '14', '2014-08-19 16:26:56');
INSERT INTO sm_audit_log VALUES ('354', 'customer', '5', 'xiaoaa', '1', '增加客户', '14', '2014-08-19 16:29:41');
INSERT INTO sm_audit_log VALUES ('355', 'contact', '5', 'xiaoaa', '1', '增加联系人', '14', '2014-08-19 16:30:23');
INSERT INTO sm_audit_log VALUES ('356', 'supplier', '5', 'luoxiaoli', '1', '增加供应商', '14', '2014-08-19 16:32:28');
INSERT INTO sm_audit_log VALUES ('357', 'order', '3', 'lanlan', '1', '增加订单', '14', '2014-08-19 16:34:46');
INSERT INTO sm_audit_log VALUES ('358', 'user', '20', '小c', '1', '增加用户', '1', '2014-08-19 16:45:56');
INSERT INTO sm_audit_log VALUES ('359', 'user', '20', '小c（理财专员）', '2', '修改用户', '1', '2014-08-19 16:46:22');
INSERT INTO sm_audit_log VALUES ('360', 'user', '20', '小c（理财专员）', '7', '用户授权', '1', '2014-08-19 16:47:53');
INSERT INTO sm_audit_log VALUES ('361', 'marketActivity', '7', '轻慢香江', '1', '增加市场活动', '20', '2014-08-19 16:49:31');
INSERT INTO sm_audit_log VALUES ('362', 'lead', '10', 'maliya（123）', '1', '增加线索', '20', '2014-08-19 16:51:12');
INSERT INTO sm_audit_log VALUES ('363', 'customer', '6', '阿黄', '1', '增加客户', '20', '2014-08-19 16:53:15');
INSERT INTO sm_audit_log VALUES ('364', 'user', '16', '小兰2（投资经理）', '7', '用户授权', '1', '2014-08-19 17:07:36');
INSERT INTO sm_audit_log VALUES ('365', 'role', '10', '投资经理', '7', '角色授权', '1', '2014-08-19 17:11:08');
INSERT INTO sm_audit_log VALUES ('366', 'role', '7', '副总裁', '7', '角色授权', '1', '2014-08-19 17:13:22');
INSERT INTO sm_audit_log VALUES ('367', 'user', '17', '小兰3（投资总监）', '7', '用户授权', '1', '2014-08-19 17:22:59');
INSERT INTO sm_audit_log VALUES ('368', 'role', '9', '投资总监', '7', '角色授权', '1', '2014-08-19 17:23:44');
INSERT INTO sm_audit_log VALUES ('369', 'user', '17', '小兰3（投资总监）', '7', '用户授权', '1', '2014-08-19 17:25:32');
INSERT INTO sm_audit_log VALUES ('370', 'user', '21', 'xiaov（理财专员）', '1', '增加用户', '1', '2014-08-19 17:29:20');
INSERT INTO sm_audit_log VALUES ('371', 'user', '21', 'xiaov（理财专员）', '7', '用户授权', '1', '2014-08-19 17:30:16');
INSERT INTO sm_audit_log VALUES ('372', 'marketActivity', '8', '123', '1', '增加市场活动', '21', '2014-08-19 17:31:14');
INSERT INTO sm_audit_log VALUES ('373', 'lead', '11', 'xiaoc（测试）', '1', '增加线索', '21', '2014-08-19 17:32:08');
INSERT INTO sm_audit_log VALUES ('374', 'customer', '7', '1234', '1', '增加客户', '21', '2014-08-19 17:34:35');
INSERT INTO sm_audit_log VALUES ('375', 'user', '22', 'xxx', '1', '增加用户', '1', '2014-08-20 09:03:58');
INSERT INTO sm_audit_log VALUES ('376', 'user', '13', '唐飞（理财经理）', '7', '用户授权', '1', '2014-08-20 09:42:31');
INSERT INTO sm_audit_log VALUES ('377', 'marketActivity', '9', '本地测试', '1', '增加市场活动', '1', '2014-08-20 09:44:15');
INSERT INTO sm_audit_log VALUES ('378', 'user', '2', '惠子敬（总裁）', '2', '修改用户', '1', '2014-08-20 10:10:47');
INSERT INTO sm_audit_log VALUES ('379', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-20 10:19:40');
INSERT INTO sm_audit_log VALUES ('380', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-20 10:19:46');
INSERT INTO sm_audit_log VALUES ('381', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-20 10:27:35');
INSERT INTO sm_audit_log VALUES ('382', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-20 10:38:57');
INSERT INTO sm_audit_log VALUES ('383', 'lead', '3', 'awu(测试数据）', '4', '删除线索', '1', '2014-08-20 10:39:03');
INSERT INTO sm_audit_log VALUES ('384', 'marketActivity', '10', '全面理财（测试）', '1', '增加市场活动', '15', '2014-08-21 09:40:49');
INSERT INTO sm_audit_log VALUES ('385', 'customer', '8', '张三', '1', '增加客户', '15', '2014-08-21 09:45:34');
INSERT INTO sm_audit_log VALUES ('386', 'customer', '9', '张三', '1', '增加客户', '15', '2014-08-21 09:45:39');
INSERT INTO sm_audit_log VALUES ('387', 'product', '3', '基金一期', '1', '增加产品', '15', '2014-08-21 09:48:11');
INSERT INTO sm_audit_log VALUES ('388', 'order', '4', '098', '1', '增加订单', '15', '2014-08-21 09:49:40');
INSERT INTO sm_audit_log VALUES ('389', 'lead', '5', 'luoxiaoli', '4', '删除线索', '1', '2014-08-21 09:52:38');
INSERT INTO sm_audit_log VALUES ('390', 'lead', '1', '中国人民银行丰台分行', '4', '删除线索', '1', '2014-08-21 09:52:52');
INSERT INTO sm_audit_log VALUES ('391', 'notice', '1', 'dd公告', '2', '修改系统公告', '1', '2014-08-21 10:54:57');
INSERT INTO sm_audit_log VALUES ('392', 'userMessage', '23', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:44');
INSERT INTO sm_audit_log VALUES ('393', 'userMessage', '25', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:44');
INSERT INTO sm_audit_log VALUES ('394', 'userMessage', '27', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:45');
INSERT INTO sm_audit_log VALUES ('395', 'userMessage', '29', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:45');
INSERT INTO sm_audit_log VALUES ('396', 'userMessage', '31', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:46');
INSERT INTO sm_audit_log VALUES ('397', 'userMessage', '33', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:47');
INSERT INTO sm_audit_log VALUES ('398', 'userMessage', '35', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:47');
INSERT INTO sm_audit_log VALUES ('399', 'userMessage', '37', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:48');
INSERT INTO sm_audit_log VALUES ('400', 'userMessage', '39', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:48');
INSERT INTO sm_audit_log VALUES ('401', 'userMessage', '41', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:49');
INSERT INTO sm_audit_log VALUES ('402', 'userMessage', '43', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:50');
INSERT INTO sm_audit_log VALUES ('403', 'userMessage', '45', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:50');
INSERT INTO sm_audit_log VALUES ('404', 'userMessage', '47', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:51');
INSERT INTO sm_audit_log VALUES ('405', 'userMessage', '49', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:51');
INSERT INTO sm_audit_log VALUES ('406', 'userMessage', '51', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:52');
INSERT INTO sm_audit_log VALUES ('407', 'userMessage', '53', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:53');
INSERT INTO sm_audit_log VALUES ('408', 'userMessage', '55', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:54');
INSERT INTO sm_audit_log VALUES ('409', 'userMessage', '57', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:54');
INSERT INTO sm_audit_log VALUES ('410', 'userMessage', '59', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:54');
INSERT INTO sm_audit_log VALUES ('411', 'userMessage', '61', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:55');
INSERT INTO sm_audit_log VALUES ('412', 'userMessage', '63', '撒旦', '1', '增加系统消息', '1', '2014-08-21 10:55:55');
INSERT INTO sm_audit_log VALUES ('413', 'notice', '1', 'dd公告', '2', '修改系统公告', '1', '2014-08-21 18:59:24');
INSERT INTO sm_audit_log VALUES ('414', 'lead', '11', 'xiaoc（测试）', '2', '批量更改所有者', '1', '2014-08-21 22:12:32');
INSERT INTO sm_audit_log VALUES ('415', 'order', '5', '0099', '1', '增加订单', '15', '2014-08-22 09:20:21');
INSERT INTO sm_audit_log VALUES ('416', 'customer', '10', '大时代', '1', '增加客户', '1', '2014-08-26 19:30:26');
INSERT INTO sm_audit_log VALUES ('417', 'lead', '12', '委屈', '1', '增加线索', '1', '2014-08-26 19:30:50');
INSERT INTO sm_audit_log VALUES ('418', 'marketActivity', '10', '全面理财（测试）\'\"\'\"\'\"\"\'\'', '2', '修改市场活动', '5', '2014-08-26 19:55:36');
INSERT INTO sm_audit_log VALUES ('419', 'marketActivity', '10', '全面理财（测试）\'', '2', '修改市场活动', '5', '2014-08-26 19:55:57');
INSERT INTO sm_audit_log VALUES ('420', 'marketActivity', '11', '\'\"\'\"\'\";\"\'', '1', '增加市场活动', '5', '2014-08-26 19:58:35');
INSERT INTO sm_audit_log VALUES ('421', 'marketActivity', '11', '\'', '2', '修改市场活动', '5', '2014-08-26 19:59:20');
INSERT INTO sm_audit_log VALUES ('422', 'userMessage', '65', 'ds', '1', '增加系统消息', '1', '2014-08-27 10:38:19');
INSERT INTO sm_audit_log VALUES ('423', 'marketActivity', '11', '\'', '4', '删除市场活动', '1', '2014-08-29 15:34:49');
INSERT INTO sm_audit_log VALUES ('424', 'marketActivity', '1', '招商活动', '4', '删除市场活动', '1', '2014-08-29 15:34:59');
INSERT INTO sm_audit_log VALUES ('425', 'lead', null, '导出列表选中的数据', '6', '共导出10条数据', '1', '2014-08-29 15:35:57');
INSERT INTO sm_audit_log VALUES ('426', 'marketActivity', '9', '本地测试', '2', '修改市场活动', '1', '2014-08-29 15:47:03');
INSERT INTO sm_audit_log VALUES ('427', 'supplier', '4', '供应商（测试）', '2', '修改供应商', '1', '2014-08-29 17:30:00');
INSERT INTO sm_audit_log VALUES ('428', 'attachment', null, 'dt.jpg', '1', '增加附件', '1', '2014-08-29 17:34:56');
INSERT INTO sm_audit_log VALUES ('429', 'report', '3', '不同性别注册量', '1', '增加报表', '1', '2014-09-24 14:23:30');
INSERT INTO sm_audit_log VALUES ('430', 'report', '4', '不同月份注册量', '1', '增加报表', '1', '2014-09-24 14:25:10');
INSERT INTO sm_audit_log VALUES ('431', 'report', '1', '报表001', '2', '修改报表', '1', '2014-09-24 14:25:54');
INSERT INTO sm_audit_log VALUES ('432', 'report', '4', '不同月份注册量', '2', '修改报表', '1', '2014-09-24 14:32:45');
INSERT INTO sm_audit_log VALUES ('433', 'attachment', null, '已完成项目.xls', '1', '增加附件', '1', '2014-09-24 14:52:01');
INSERT INTO sm_audit_log VALUES ('434', 'attachment', '2', '已完成项目.xls', '4', '删除附件', '1', '2014-09-24 14:52:10');

-- ----------------------------
-- Table structure for `sm_component`
-- ----------------------------
DROP TABLE IF EXISTS `sm_component`;
CREATE TABLE `sm_component` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '组件编号',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '组件名称',
  `URL` varchar(64) NOT NULL DEFAULT '' COMMENT '组件调用入口',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `PRIVILEGE_LEVEL_ID` int(11) NOT NULL COMMENT '权限级别',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '删除标志',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否初始化数据',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_URL` (`URL`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='组件表';

-- ----------------------------
-- Records of sm_component
-- ----------------------------
INSERT INTO sm_component VALUES ('1', '001', '省市区三级联动', '/common/pcas/getChildren.docomp', '省市区三级联动', '17', '0', '1', '1', '2014-06-17 00:00:00', '1', '2014-08-15 10:56:37');
INSERT INTO sm_component VALUES ('6', '006', '省市区三级联动获取根', '/common/pcas/getRoot.docomp', '', '17', '0', '1', '1', '2014-06-04 00:00:00', '1', '2014-07-27 19:20:25');
INSERT INTO sm_component VALUES ('7', '000101', '唯一性验证', '/common/common/unique.docomp', '', '17', '0', '1', '1', '2014-01-01 00:00:00', '1', '2014-07-27 19:20:25');
INSERT INTO sm_component VALUES ('8', '090001', '查找分组类型', '/common/report/findGroupType.docomp', '查找分组类型通过模块名称和字段名称', '18', '0', '1', '1', '2014-01-01 00:00:00', '1', '2014-07-27 19:20:25');
INSERT INTO sm_component VALUES ('9', '007', '项目列表组件', '/project/project/toQueryPage.comp', '项目列表组件', '17', '0', '1', '1', '2014-06-10 00:00:00', '1', '2014-07-27 19:20:25');
INSERT INTO sm_component VALUES ('10', '0200', '线索名称', '/workbanch/toViewPage.do', '', '17', '0', '1', '1', '2014-06-19 00:00:00', '1', '2014-08-15 10:57:41');
INSERT INTO sm_component VALUES ('12', '009', '工作台位置记忆', '/workbanch/modifyOrder.do', '', '17', '0', '1', '1', '2014-07-09 00:00:00', '1', '2014-07-27 19:20:25');
INSERT INTO sm_component VALUES ('13', '010', '工作台删除', '/workbanch/delete.do', '', '17', '0', '1', '1', '2014-07-09 00:00:00', '1', '2014-07-27 19:20:25');
INSERT INTO sm_component VALUES ('14', '990110', '查找模块字段', '/common/module/findModuleFields.docomp', '查找模块字段通过模块主键编号', '18', '0', '1', '1', '2014-01-01 00:00:00', '1', '2014-07-27 19:20:25');
INSERT INTO sm_component VALUES ('15', '15001', '产品金额限定', '/common/common/limitMoney.docomp', '同一项目下的所有产品金额总和不能超过该项目的总金额', '17', '0', '0', '1', '2014-08-06 11:49:21', '1', '2014-08-06 11:49:21');
INSERT INTO sm_component VALUES ('16', '00016', '搜索用户', '/system/user/searchUser.docomp', '查询用户组件', '17', '0', '1', '1', '2014-08-14 17:53:31', '1', '2014-08-14 19:38:28');
INSERT INTO sm_component VALUES ('17', '00017', '搜索客户', '/customer/customer/searchCustomer.docomp', '查询客户组件', '17', '0', '1', '1', '2014-08-14 18:19:24', '1', '2014-08-14 19:30:11');
INSERT INTO sm_component VALUES ('18', '00018', '搜索供应商', '/project/supplier/searchSupplier.docomp', '查询供应商组件', '17', '0', '1', '1', '2014-08-14 18:21:33', '1', '2014-08-14 19:30:13');
INSERT INTO sm_component VALUES ('19', '00019', '搜索项目', '/project/project/searchProject.docomp', '查询项目组件', '17', '0', '1', '1', '2014-08-14 18:23:25', '1', '2014-08-14 19:30:15');
INSERT INTO sm_component VALUES ('20', '00020', '搜索产品', '/project/product/searchProduct.docomp', '查询产品组件', '17', '0', '1', '1', '2014-08-14 18:24:46', '1', '2014-08-14 19:54:54');
INSERT INTO sm_component VALUES ('21', '00021', '搜索订单', '/order/order/searchOrder.docomp', '查询订单组件', '17', '0', '1', '1', '2014-08-14 18:25:49', '1', '2014-08-14 19:30:19');
INSERT INTO sm_component VALUES ('22', '00022', '搜索市场活动', '/market/marketactivity/searchMarketActivity.docomp', '查询市场活组件', '17', '0', '1', '1', '2014-08-14 18:39:42', '1', '2014-08-14 19:30:24');

-- ----------------------------
-- Table structure for `sm_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `sm_dictionary`;
CREATE TABLE `sm_dictionary` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `KEY` varchar(64) NOT NULL DEFAULT '' COMMENT '显示值',
  `VALUE` varchar(64) NOT NULL DEFAULT '' COMMENT '字典值',
  `PARENT_ID` int(11) DEFAULT '0' COMMENT '父id',
  `LEVEL` int(11) DEFAULT NULL COMMENT '深度',
  `ORDER` int(11) DEFAULT NULL COMMENT '顺序',
  `TYPE` varchar(64) DEFAULT NULL COMMENT '字典类型',
  `IS_ACTIVE` int(11) DEFAULT '1' COMMENT '是否启用',
  `REMARK` varchar(512) DEFAULT '' COMMENT '备注',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '标记删除',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否初始化数据',
  `CREATOR_ID` int(10) unsigned DEFAULT '0' COMMENT '创建者',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) DEFAULT '0' COMMENT '修改者',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=349 DEFAULT CHARSET=utf8 COMMENT='数据字典表';

-- ----------------------------
-- Records of sm_dictionary
-- ----------------------------
INSERT INTO sm_dictionary VALUES ('1', '性别', '0001', null, '0', '0', null, '1', '', '0', '1', '1', '2014-06-10 10:52:46', '1', '2014-08-19 15:44:18');
INSERT INTO sm_dictionary VALUES ('2', '男', '000101', '1', '0', '0', '性别', '1', '男', '0', '1', '1', '2014-06-10 10:53:12', '1', '2014-08-19 15:44:18');
INSERT INTO sm_dictionary VALUES ('3', '女', '000102', '1', '0', '0', '性别', '1', '女', '0', '1', '1', '2014-06-10 11:00:36', '1', '2014-08-19 15:44:18');
INSERT INTO sm_dictionary VALUES ('4', '组织类型', '010301', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-08-19 15:44:18');
INSERT INTO sm_dictionary VALUES ('5', '公司', '01030101', '4', '0', '0', '组织类型', '1', '公司', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-08-19 15:44:18');
INSERT INTO sm_dictionary VALUES ('6', '部门', '01030102', '4', '0', '0', '组织类型', '1', '部门', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-08-19 15:44:18');
INSERT INTO sm_dictionary VALUES ('7', '组', '01030103', '4', '0', '0', '组织类型', '1', '组', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02');
INSERT INTO sm_dictionary VALUES ('8', '工作状态', '010403', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-08-19 15:44:18');
INSERT INTO sm_dictionary VALUES ('9', '在岗', '01040301', '8', '0', '0', '在岗状态', '1', '在岗', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO sm_dictionary VALUES ('10', '离岗', '01040302', '8', '0', '0', '在岗状态', '1', '离岗', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO sm_dictionary VALUES ('11', '数据存储状态', '010404', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO sm_dictionary VALUES ('12', '最新的', '01040401', '11', '0', '0', '数据存储状态', '1', '最新的', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO sm_dictionary VALUES ('13', '延迟的', '01040402', '11', '0', '0', '数据存储状态', '1', '延迟的', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO sm_dictionary VALUES ('14', '角色类型', '010501', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO sm_dictionary VALUES ('15', '常规的', '01050101', '14', '0', '0', '角色类型', '1', '常规的', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO sm_dictionary VALUES ('16', '权限级别', '010601', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-06-04 10:59:39');
INSERT INTO sm_dictionary VALUES ('17', '公共', '01060101', '16', '0', '0', '权限级别', '1', '公共', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO sm_dictionary VALUES ('18', '身份认证', '01060102', '16', '0', '0', '权限级别', '1', '身份认证', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO sm_dictionary VALUES ('19', '权限认证', '01060103', '16', '0', '0', '权限级别', '1', '权限认证', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO sm_dictionary VALUES ('20', '审批状态', '060102', null, '0', '0', '审批状态', '1', '', '0', '1', '1', '2014-07-01 10:55:02', '1', '2014-07-01 10:55:01');
INSERT INTO sm_dictionary VALUES ('21', '未审核', '06010201', '20', '0', '0', '审批状态', '1', '未审核', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO sm_dictionary VALUES ('22', '待主管审核', '06010202', '20', '0', '0', '审批状态', '1', '待主管审核', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO sm_dictionary VALUES ('23', '待总监审核', '06010203', '20', '0', '0', '审批状态', '1', '待总监审核', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO sm_dictionary VALUES ('24', '审核通过', '06010204', '20', '0', '0', '审批状态', '1', '审核通过', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO sm_dictionary VALUES ('25', '财务状态', '060103', null, '0', '0', null, '1', '', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO sm_dictionary VALUES ('26', '未收款', '06010301', '25', '0', '0', '财务状态', '1', '未收款', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO sm_dictionary VALUES ('27', '已收款', '06010302', '25', '0', '0', '财务状态', '1', '已收款', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO sm_dictionary VALUES ('28', '赎回方式', '070101', null, '0', '0', null, '1', '', '0', '1', '1', '2014-07-14 19:20:02', '1', '2014-07-14 19:20:08');
INSERT INTO sm_dictionary VALUES ('29', '提前赎回', '08010101', '28', '0', '0', '赎回方式', '1', '提前赎回', '0', '1', '1', '2014-07-26 18:42:08', '1', '2014-07-26 18:41:47');
INSERT INTO sm_dictionary VALUES ('30', '到期赎回', '080101002', '28', '0', '0', '赎回方式', '1', '到期赎回', '0', '1', '1', '2014-07-26 18:42:51', '1', '2014-07-26 18:42:30');
INSERT INTO sm_dictionary VALUES ('31', '订单状态', '070101', null, '0', '0', null, '1', '', '0', '1', '1', '2014-07-14 19:20:02', '1', '2014-07-14 19:20:08');
INSERT INTO sm_dictionary VALUES ('32', '待审核', '07010101', '31', '0', '0', '订单状态', '1', '待审核', '0', '1', '1', '2014-07-14 19:21:23', '1', '2014-07-14 19:21:28');
INSERT INTO sm_dictionary VALUES ('33', '审核中', '07010102', '31', '0', '0', '订单状态', '1', '审核中', '0', '1', '1', '2014-07-26 18:40:55', '1', '2014-07-26 18:40:34');
INSERT INTO sm_dictionary VALUES ('34', '审核通过', '07010103', '31', '0', '0', '订单状态', '1', '审核通过', '0', '1', '1', '2014-07-27 20:59:36', '1', '2014-07-27 21:00:05');
INSERT INTO sm_dictionary VALUES ('35', '客户作废', '07010104', '31', '0', '0', '订单状态', '1', '客户作废', '0', '1', '1', '2014-07-26 19:16:53', '1', '2014-07-26 19:16:31');
INSERT INTO sm_dictionary VALUES ('36', '公司作废', '07010105', '31', '0', '0', '订单状态', '1', '公司作废', '0', '1', '1', '2014-07-26 19:17:44', '1', '2014-07-26 19:17:23');
INSERT INTO sm_dictionary VALUES ('37', '提前赎回', '07010106', '31', '0', '0', '订单状态', '1', '提前赎回', '0', '1', '1', '2014-07-27 17:04:21', '1', '2014-07-27 17:04:53');
INSERT INTO sm_dictionary VALUES ('38', '到期赎回', '07010107', '31', '0', '0', '订单状态', '1', '到期赎回', '0', '1', '1', '2014-07-27 17:05:22', '1', '2014-07-27 17:05:52');
INSERT INTO sm_dictionary VALUES ('39', '报表分组类型', '090001', null, '0', '0', 'report_group', '1', '报表分组类型', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('40', '日期', '09000101', '39', '0', '0', 'report_group_time', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('41', '年', '0900010101', '40', '1', '0', 'report_group_time', '1', '年', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('42', '月', '0900010102', '40', '1', '0', 'report_group_time', '1', '月', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('43', '日', '0900010103', '40', '1', '0', 'report_group_time', '1', '日', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('44', '时', '0900010104', '40', '1', '0', 'report_group_time', '1', '时', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('45', '分', '0900010105', '40', '1', '0', 'report_group_time', '1', '分', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('46', '秒', '0900010106', '40', '1', '0', 'report_group_time', '1', '日期', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('47', '其他', '09000199', null, '0', '0', 'report_group_else', '1', '秒', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('48', '最细化', '0900019901', '47', '1', '0', 'report_group_else', '1', '最细化', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('49', '报表聚合类型', '090002', null, '0', '0', 'report_aggregate', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('50', '总计', '09000201', '49', '0', '0', 'report_aggregate', '1', '总计', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('51', '求和', '09000202', '49', '0', '0', 'report_aggregate', '1', '求和', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('52', '平均', '09000203', '49', '0', '0', 'report_aggregate', '1', '平均', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('53', '最大', '09000204', '49', '0', '0', 'report_aggregate', '1', '最大', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('54', '最小', '09000205', '49', '0', '0', 'report_aggregate', '1', '最小', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('55', '报表图表类型', '090003', null, '0', '0', 'report_chart', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('56', '饼状图', '09000301', '55', '0', '0', 'report_chart', '1', '饼状图', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('57', '柱状图', '09000302', '55', '0', '0', 'report_chart', '1', '柱状图', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('58', '折线图', '09000303', '55', '0', '0', 'report_chart', '1', '折线图', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('59', '流程类型', '990201', null, '0', '0', 'flow_type', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('60', '订单审批', '99020101', '59', '0', '0', 'flow_type', '1', '订单审批', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('61', '市场活动（金额）', '99020102', '59', '0', '0', 'flow_type', '1', '市场活动（金额）', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('62', '市场活动（非金额）', '99020103', '59', '0', '0', 'flow_type', '1', '市场活动（非金额）', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('63', '期限单位', '07', null, '0', '0', null, '1', '', '0', '1', '1', '2014-06-09 16:45:47', '1', '2014-06-09 17:17:41');
INSERT INTO sm_dictionary VALUES ('64', '年', 'year', '63', '0', '0', '期限单位', '1', '年', '0', '1', '1', '2014-06-09 16:51:09', '1', '2014-06-09 17:16:21');
INSERT INTO sm_dictionary VALUES ('65', '月', 'month', '63', '0', '0', '期限单位', '1', '月', '0', '1', '1', '2014-06-09 17:17:16', '1', '2014-06-09 17:16:49');
INSERT INTO sm_dictionary VALUES ('66', '日', 'day', '63', '0', '0', '期限单位', '1', '日', '0', '1', '1', '2014-06-09 17:17:32', '1', '2014-06-09 17:17:06');
INSERT INTO sm_dictionary VALUES ('71', '活动类型', '030101', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-27 10:50:08', '1', '2014-05-27 10:50:08');
INSERT INTO sm_dictionary VALUES ('72', '交易会', '03010101', '71', '0', '0', '活动类型', '1', '交易会', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO sm_dictionary VALUES ('73', 'Web研讨', '03010102', '71', '0', '0', '活动类型', '1', 'Web研讨', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO sm_dictionary VALUES ('74', '公开媒体', '03010103', '71', '0', '0', '活动类型', '1', '公开媒体', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO sm_dictionary VALUES ('75', '合作伙伴', '03010104', '71', '0', '0', '活动类型', '1', '合作伙伴', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO sm_dictionary VALUES ('76', '广告', '03010105', '71', '0', '0', '活动类型', '1', '广告', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO sm_dictionary VALUES ('77', '电子市场', '03010106', '71', '0', '0', '活动类型', '1', '电子市场', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO sm_dictionary VALUES ('78', '邮箱', '03010107', '71', '0', '0', '活动类型', '1', '邮箱', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO sm_dictionary VALUES ('79', '其它', '03010108', '71', '0', '0', '活动类型', '1', '其它', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO sm_dictionary VALUES ('81', '活动状态', '030102', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52');
INSERT INTO sm_dictionary VALUES ('82', '计划中', '03010201', '81', '0', '0', '活动状态', '1', '计划中', '0', '1', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52');
INSERT INTO sm_dictionary VALUES ('83', '激活', '03010202', '81', '0', '0', '活动状态', '1', '激活', '0', '1', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52');
INSERT INTO sm_dictionary VALUES ('84', '休眠', '03010203', '81', '0', '0', '活动状态', '1', '休眠', '0', '1', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52');
INSERT INTO sm_dictionary VALUES ('85', '完成', '03010204', '81', '0', '0', '活动状态', '1', '完成', '0', '1', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52');
INSERT INTO sm_dictionary VALUES ('91', '线索来源', '040101', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-29 10:10:48', '1', '2014-05-29 10:10:38');
INSERT INTO sm_dictionary VALUES ('92', '交易线索', '04010101', '91', '0', '0', '线索来源', '1', '交易线索', '0', '1', '1', '2014-05-29 10:11:36', '1', '2014-05-29 10:15:46');
INSERT INTO sm_dictionary VALUES ('93', '投资线索', '04010102', '91', '0', '0', '线索来源', '1', '投资线索', '0', '1', '1', '2014-05-29 10:11:36', '1', '2014-05-29 10:15:46');
INSERT INTO sm_dictionary VALUES ('94', '保险投资', '04010103', '91', '0', '0', '线索来源', '1', '保险投资', '0', '1', '1', '2014-05-29 10:11:36', '1', '2014-05-29 10:15:46');
INSERT INTO sm_dictionary VALUES ('95', '信托投资', '04010104', '91', '0', '0', '线索来源', '1', '信托投资', '0', '1', '1', '2014-05-29 10:11:36', '1', '2014-05-29 10:15:46');
INSERT INTO sm_dictionary VALUES ('96', '信用合作', '04010105', '91', '0', '0', '线索来源', '1', '信用合作', '0', '1', '1', '2014-05-29 10:11:36', '1', '2014-05-29 10:15:46');
INSERT INTO sm_dictionary VALUES ('97', '证券交易', '04010106', '91', '0', '0', '线索来源', '1', '证券交易', '0', '1', '1', '2014-05-29 10:11:36', '1', '2014-05-29 10:15:46');
INSERT INTO sm_dictionary VALUES ('98', '市场活动', '04010107', '91', '0', '0', '线索来源', '1', '市场活动', '0', '1', '1', '2014-05-29 10:11:36', '1', '2014-05-29 10:15:46');
INSERT INTO sm_dictionary VALUES ('101', '线索状态', '040102', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-29 10:12:27', '1', '2014-05-29 10:12:16');
INSERT INTO sm_dictionary VALUES ('102', '待跟进', '04010201', '101', '0', '0', '线索状态', '1', '待跟进', '0', '1', '1', '2014-05-29 10:12:54', '1', '2014-05-29 10:15:49');
INSERT INTO sm_dictionary VALUES ('103', '跟进中', '04010202', '101', '0', '0', '线索状态', '1', '跟进中', '0', '1', '1', '2014-05-29 10:12:54', '1', '2014-05-29 10:15:49');
INSERT INTO sm_dictionary VALUES ('104', '初期沟通', '04010203', '101', '0', '0', '线索状态', '1', '初期沟通', '0', '1', '1', '2014-05-29 10:12:54', '1', '2014-05-29 10:15:49');
INSERT INTO sm_dictionary VALUES ('105', '商务谈判', '04010204', '101', '0', '0', '线索状态', '1', '商务谈判', '0', '1', '1', '2014-05-29 10:12:54', '1', '2014-05-29 10:15:49');
INSERT INTO sm_dictionary VALUES ('106', '已注销', '04010205', '101', '0', '0', '线索状态', '1', '已注销', '0', '1', '1', '2014-05-29 10:12:54', '1', '2014-05-29 10:15:49');
INSERT INTO sm_dictionary VALUES ('111', '客户类型', '040301', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-27 15:20:19', '1', '2014-05-28 12:36:53');
INSERT INTO sm_dictionary VALUES ('112', '新客户', '04030101', '111', '0', '0', '客户类型', '1', '新客户', '0', '1', '1', '2014-05-27 15:21:24', '1', '2014-05-27 15:21:24');
INSERT INTO sm_dictionary VALUES ('113', '老客户', '04030102', '111', '0', '0', '客户类型', '1', '老客户', '0', '1', '1', '2014-05-27 15:22:02', '1', '2014-05-27 15:22:01');
INSERT INTO sm_dictionary VALUES ('114', '其它', '04030103', '111', '0', '0', '客户类型', '1', '其它', '0', '1', '1', '2014-05-27 15:21:24', '1', '2014-05-27 15:21:24');
INSERT INTO sm_dictionary VALUES ('121', '客户来源', '040302', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-27 17:16:45', '1', '2014-05-27 17:34:23');
INSERT INTO sm_dictionary VALUES ('122', '老客户', '04030101', '121', '0', '0', '客户来源', '1', '老客户', '0', '1', '1', '2014-05-27 15:22:02', '1', '2014-05-27 15:22:01');
INSERT INTO sm_dictionary VALUES ('123', '客户介绍', '04030202', '121', '0', '0', '客户来源', '1', '客户介绍', '0', '1', '1', '2014-05-27 17:18:10', '1', '2014-05-28 14:04:26');
INSERT INTO sm_dictionary VALUES ('124', '独立开发', '04030203', '121', '0', '0', '客户来源', '1', '独立开发', '0', '1', '1', '2014-05-27 17:19:28', '1', '2014-05-28 14:04:29');
INSERT INTO sm_dictionary VALUES ('125', '媒体宣传', '04030204', '121', '0', '0', '客户来源', '1', '媒体宣传', '0', '1', '1', '2014-05-27 17:20:22', '1', '2014-05-29 17:01:06');
INSERT INTO sm_dictionary VALUES ('126', '合作伙伴', '04030205', '121', '0', '0', '客户来源', '1', '合作伙伴', '0', '1', '1', '2014-05-27 17:21:27', '1', '2014-05-29 17:01:07');
INSERT INTO sm_dictionary VALUES ('127', '公开招标', '04030106', '121', '0', '0', '客户来源', '1', '公开招标', '0', '1', '1', '2014-05-27 15:22:02', '1', '2014-05-27 15:22:01');
INSERT INTO sm_dictionary VALUES ('128', '内部推荐', '04030207', '121', '0', '0', '客户来源', '1', '内部推荐', '0', '1', '1', '2014-05-27 17:20:22', '1', '2014-05-29 17:01:06');
INSERT INTO sm_dictionary VALUES ('129', '线索转换', '04030208', '121', '0', '0', '客户来源', '1', '线索转换', '0', '1', '1', '2014-07-24 14:37:05', '1', '2014-07-24 14:37:10');
INSERT INTO sm_dictionary VALUES ('130', '其它', '04030209', '121', '0', '0', '客户来源', '1', '其它', '0', '1', '1', '2014-05-27 17:18:10', '1', '2014-05-28 14:04:26');
INSERT INTO sm_dictionary VALUES ('131', '风险等级', '040304', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-27 17:48:08', '1', '2014-05-27 17:48:20');
INSERT INTO sm_dictionary VALUES ('132', '一级', '04030401', '131', '0', '0', '风险等级', '1', '一级', '0', '1', '1', '2014-05-27 17:49:01', '1', '2014-05-28 14:05:17');
INSERT INTO sm_dictionary VALUES ('133', '二级', '04030402', '131', '0', '0', '风险等级', '1', '二级', '0', '1', '2', '2014-05-27 17:49:32', '1', '2014-05-28 14:05:31');
INSERT INTO sm_dictionary VALUES ('134', '三级', '04030403', '131', '0', '0', '风险等级', '1', '三级', '0', '1', '1', '2014-05-27 17:49:01', '1', '2014-05-28 14:05:17');
INSERT INTO sm_dictionary VALUES ('135', '四级', '04030404', '131', '0', '0', '风险等级', '1', '四级', '0', '1', '2', '2014-05-27 17:49:32', '1', '2014-05-28 14:05:31');
INSERT INTO sm_dictionary VALUES ('141', '行业', '040305', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-29 10:14:48', '1', '2014-05-29 10:16:08');
INSERT INTO sm_dictionary VALUES ('142', '金融', '04030501', '141', '0', '0', '行业', '1', '金融', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('143', '化工', '04030502', '141', '0', '0', '行业', '1', '化工', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('144', '冶金矿产', '04030503', '141', '0', '0', '行业', '1', '冶金矿产', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('145', '能源', '04030504', '141', '0', '0', '行业', '1', '能源', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('146', '建筑、建材', '04030505', '141', '0', '0', '行业', '1', '建筑、建材', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('147', '医药、保养', '04030506', '141', '0', '0', '行业', '1', '医药、保养', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('148', '礼品、工艺品、饰品', '04030507', '141', '0', '0', '行业', '1', '礼品、工艺品、饰品', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('149', '印刷', '04030508', '141', '0', '0', '行业', '1', '印刷', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('150', '服饰、服装', '04030508', '141', '0', '0', '行业', '1', '服饰、服装', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('151', '传媒', '04030510', '141', '0', '0', '行业', '1', '传媒', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('152', '电工电器', '04030511', '141', '0', '0', '行业', '1', '电工电器', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('153', '电子元器件', '04030512', '141', '0', '0', '行业', '1', '电子元器件', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('154', '五金工具', '04030513', '141', '0', '0', '行业', '1', '五金工具', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('155', '仪表、仪器', '04030514', '141', '0', '0', '行业', '1', '仪表、仪器', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('156', '其它', '04030515', '141', '0', '0', '行业', '1', '其它', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO sm_dictionary VALUES ('181', '公司性质', '040306', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-27 18:05:37', '1', '2014-05-27 18:05:43');
INSERT INTO sm_dictionary VALUES ('182', '国有企业', '04030601', '181', '0', '0', '公司性质', '1', '国有企业', '0', '1', '1', '2014-05-27 18:06:39', '1', '2014-05-28 14:05:23');
INSERT INTO sm_dictionary VALUES ('183', '外资企业', '04030602', '181', '0', '0', '公司性质', '1', '外资企业', '0', '1', '1', '2014-05-29 14:01:39', '1', '2014-05-29 14:01:47');
INSERT INTO sm_dictionary VALUES ('184', '民营企业', '04030603', '181', '0', '0', '公司性质', '1', '民营企业', '0', '1', '1', '2014-05-27 18:06:39', '1', '2014-05-28 14:05:23');
INSERT INTO sm_dictionary VALUES ('185', '集体企业', '04030604', '181', '0', '0', '公司性质', '1', '集体企业', '0', '1', '1', '2014-05-29 14:01:39', '1', '2014-05-29 14:01:47');
INSERT INTO sm_dictionary VALUES ('186', '股份制企业', '04030605', '181', '0', '0', '公司性质', '1', '国有', '0', '1', '1', '2014-05-27 18:06:39', '1', '2014-05-28 14:05:23');
INSERT INTO sm_dictionary VALUES ('187', '合资企业', '04030606', '181', '0', '0', '公司性质', '1', '股份制企业', '0', '1', '1', '2014-05-29 14:01:39', '1', '2014-05-29 14:01:47');
INSERT INTO sm_dictionary VALUES ('188', '独资企业', '04030607', '181', '0', '0', '公司性质', '1', '独资企业', '0', '1', '1', '2014-05-27 18:06:39', '1', '2014-05-28 14:05:23');
INSERT INTO sm_dictionary VALUES ('189', '其它', '04030608', '181', '0', '0', '公司性质', '1', '其它', '0', '1', '1', '2014-05-29 14:01:39', '1', '2014-05-29 14:01:47');
INSERT INTO sm_dictionary VALUES ('201', '开户行', '040307', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-27 18:29:45', '1', '2014-05-27 18:29:50');
INSERT INTO sm_dictionary VALUES ('202', '农行银行', '04030701', '201', '0', '0', '开户行', '1', '农行银行', '0', '1', '1', '2014-05-27 18:30:35', '1', '2014-05-28 14:05:20');
INSERT INTO sm_dictionary VALUES ('203', '交通银行', '04030702', '201', '0', '0', '开户行', '1', '交通银行', '0', '1', '1', '2014-05-27 18:30:35', '1', '2014-05-28 14:05:20');
INSERT INTO sm_dictionary VALUES ('204', '建设银行', '04030703', '201', '0', '0', '开户行', '1', '建设银行', '0', '1', '1', '2014-05-27 18:30:35', '1', '2014-05-28 14:05:20');
INSERT INTO sm_dictionary VALUES ('205', '人民银行', '04030704', '201', '0', '0', '开户行', '1', '人民银行', '0', '1', '1', '2014-05-27 18:30:35', '1', '2014-05-28 14:05:20');
INSERT INTO sm_dictionary VALUES ('206', '邮政银行', '04030705', '201', '0', '0', '开户行', '1', '邮政银行', '0', '1', '1', '2014-05-27 18:30:35', '1', '2014-05-28 14:05:20');
INSERT INTO sm_dictionary VALUES ('207', '其它', '04030706', '201', '0', '0', '开户行', '1', '其它', '0', '1', '1', '2014-05-27 18:30:35', '1', '2014-05-28 14:05:20');
INSERT INTO sm_dictionary VALUES ('221', '银行卡类型', '040103', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-29 10:13:42', '1', '2014-06-05 16:38:25');
INSERT INTO sm_dictionary VALUES ('222', '信用卡', '04010301', '221', '0', '0', '银行卡类型', '1', '信用卡', '0', '1', '1', '2014-05-29 10:14:10', '1', '2014-05-29 11:17:02');
INSERT INTO sm_dictionary VALUES ('224', '借记卡', '04010302', '221', '0', '0', '银行卡类型', '1', '借记卡', '0', '1', '1', '2014-05-29 10:14:10', '1', '2014-05-29 11:17:02');
INSERT INTO sm_dictionary VALUES ('231', '证件类型', '040303', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-27 17:39:55', '1', '2014-05-27 17:40:02');
INSERT INTO sm_dictionary VALUES ('232', '居民身份证', '04030301', '231', '0', '0', '证件类型', '1', '居民身份证', '0', '1', '1', '2014-05-27 17:41:26', '1', '2014-05-28 14:05:00');
INSERT INTO sm_dictionary VALUES ('233', '士官证', '04030302', '231', '0', '0', '证件类型', '1', '士官证', '0', '1', '1', '2014-05-27 17:42:26', '1', '2014-05-28 14:05:04');
INSERT INTO sm_dictionary VALUES ('234', '工作证', '04030303', '231', '0', '0', '证件类型', '1', '工作证', '0', '1', '1', '2014-05-27 17:41:26', '1', '2014-05-28 14:05:00');
INSERT INTO sm_dictionary VALUES ('235', '护照', '04030304', '231', '0', '0', '证件类型', '1', '护照', '0', '1', '1', '2014-05-27 17:42:26', '1', '2014-05-28 14:05:04');
INSERT INTO sm_dictionary VALUES ('236', '其它', '04030305', '231', '0', '0', '证件类型', '1', '其他', '0', '1', '1', '2014-05-27 17:43:09', '1', '2014-05-28 14:05:08');
INSERT INTO sm_dictionary VALUES ('241', '支付方式', '040201', null, '0', '0', null, '1', '', '0', '1', '1', '2014-06-26 16:10:17', '1', '2014-06-26 16:10:10');
INSERT INTO sm_dictionary VALUES ('242', '现金支付', '04020101', null, '0', '0', '支付方式', '1', '现金支付', '0', '1', '1', '2014-06-26 16:11:08', '1', '2014-06-26 16:10:56');
INSERT INTO sm_dictionary VALUES ('243', '信用卡支付', '04020102', null, '0', '0', '支付方式', '1', '信用卡支付', '0', '1', '1', '2014-06-26 16:11:52', '1', '2014-06-26 16:11:40');
INSERT INTO sm_dictionary VALUES ('244', '网银支付', '04020103', null, '0', '0', '支付方式', '1', '网银支付', '0', '1', '1', '2014-06-26 16:11:08', '1', '2014-06-26 16:10:56');
INSERT INTO sm_dictionary VALUES ('245', '银联支付', '04020104', null, '0', '0', '支付方式', '1', '银联支付', '0', '1', '1', '2014-06-26 16:11:52', '1', '2014-06-26 16:11:40');
INSERT INTO sm_dictionary VALUES ('246', '支票支付', '04020105', null, '0', '0', '支付方式', '1', '支票支付', '0', '1', '1', '2014-06-26 16:11:08', '1', '2014-06-26 16:10:56');
INSERT INTO sm_dictionary VALUES ('247', '其它', '04020106', null, '0', '0', '支付方式', '1', '其它', '0', '1', '1', '2014-06-26 16:11:52', '1', '2014-06-26 16:11:40');
INSERT INTO sm_dictionary VALUES ('251', '供应商类型', '050101', null, '0', '0', null, '1', '供应商类型', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-29 10:10:02');
INSERT INTO sm_dictionary VALUES ('252', '银行', '05010101', '251', '0', '0', '供应商类型', '1', '银行', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO sm_dictionary VALUES ('253', '企业', '05010102', '251', '0', '0', '供应商类型', '1', '企业', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-27 14:20:17');
INSERT INTO sm_dictionary VALUES ('261', '投资方式', '060101', null, '0', '0', null, '1', '投资方式', '0', '1', '1', '2014-07-01 10:51:17', '1', '2014-07-01 10:51:17');
INSERT INTO sm_dictionary VALUES ('262', '基金定投', '06010101', '261', '0', '0', '投资方式', '1', '基金定投', '0', '1', '1', '2014-07-01 10:52:09', '1', '2014-07-01 10:52:09');
INSERT INTO sm_dictionary VALUES ('263', '成长型投资', '06010102', '261', '0', '0', '投资方式', '1', '成长型投资', '0', '1', '1', '2014-07-01 10:52:46', '1', '2014-07-01 10:52:46');
INSERT INTO sm_dictionary VALUES ('264', '收入型投资', '06010103', '261', '0', '0', '投资方式', '1', '收入型投资', '0', '1', '1', '2014-07-01 10:52:46', '1', '2014-07-01 10:52:46');
INSERT INTO sm_dictionary VALUES ('265', '平衡型投资', '06010104', '261', '0', '0', '投资方式', '1', '平衡型投资', '0', '1', '1', '2014-07-01 10:52:46', '1', '2014-07-01 10:52:46');
INSERT INTO sm_dictionary VALUES ('266', '公司型投资', '06010105', '261', '0', '0', '投资方式', '1', '公司型投资', '0', '1', '1', '2014-07-01 10:52:46', '1', '2014-07-01 10:52:46');
INSERT INTO sm_dictionary VALUES ('267', '契约型投资', '06010106', '261', '0', '0', '投资方式', '1', '契约型投资', '0', '1', '1', '2014-07-01 10:52:46', '1', '2014-07-01 10:52:46');
INSERT INTO sm_dictionary VALUES ('268', '其它', '06010107', '261', '0', '0', '投资方式', '1', '其它', '0', '1', '1', '2014-07-01 10:52:46', '1', '2014-07-01 10:52:46');
INSERT INTO sm_dictionary VALUES ('271', '操作类型', '100401', null, '0', '0', null, '1', '操作类型', '0', '1', '1', '2014-06-23 18:36:54', '1', '2014-06-23 18:37:07');
INSERT INTO sm_dictionary VALUES ('272', '新增', '10040101', '271', '0', '0', '操作类型', '1', '新增', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO sm_dictionary VALUES ('273', '修改', '10040102', '271', '0', '0', '操作类型', '1', '修改', '0', '1', '1', '2014-06-23 18:39:20', '1', '2014-06-23 18:39:31');
INSERT INTO sm_dictionary VALUES ('274', '删除', '10040103', '271', '0', '0', '操作类型', '1', '删除', '0', '1', '1', '2014-06-23 18:39:59', '1', '2014-06-23 18:40:08');
INSERT INTO sm_dictionary VALUES ('275', '线索转换', '10040104', '271', '0', '0', '操作类型', '1', '线索转换', '0', '1', '1', '2014-07-02 16:55:17', '1', '2014-07-02 16:55:18');
INSERT INTO sm_dictionary VALUES ('301', '附件类型', '110102', null, '0', '0', null, '1', '附件类型', '0', '1', '1', '2014-05-27 10:29:53', '1', '2014-05-27 10:29:50');
INSERT INTO sm_dictionary VALUES ('302', '合同协议书', '11010201', '301', '0', '0', '附件类型', '1', '合同协议书', '0', '1', '1', '2014-07-25 14:15:22', '1', '2014-07-25 14:15:28');
INSERT INTO sm_dictionary VALUES ('303', '企业证照', '11010202', '301', '0', '0', '附件类型', '1', '企业证照', '0', '1', '1', '2014-05-27 10:31:38', '1', '2014-05-27 10:32:31');
INSERT INTO sm_dictionary VALUES ('304', '资产证明材料', '11010203', '301', '0', '0', '附件类型', '1', '资产证明材料', '0', '1', '1', '2014-05-27 10:31:38', '1', '2014-05-27 10:32:31');
INSERT INTO sm_dictionary VALUES ('305', '企业财务报表', '11010204', '301', '0', '0', '附件类型', '1', '企业财务报表', '0', '1', '1', '2014-05-27 10:31:38', '1', '2014-05-27 10:32:31');
INSERT INTO sm_dictionary VALUES ('306', '企业信息', '11010205', '301', '0', '0', '附件类型', '1', '企业信息', '0', '1', '1', '2014-05-27 10:31:38', '1', '2014-05-27 10:32:31');
INSERT INTO sm_dictionary VALUES ('307', '身份证复印件', '11010206', '301', '0', '0', '附件类型', '1', '身份证复印件', '0', '1', '1', '2014-05-27 10:32:26', '1', '2014-05-27 10:32:24');
INSERT INTO sm_dictionary VALUES ('308', '财务报表', '11010207', '301', '0', '0', '附件类型', '1', '财务报表', '0', '1', '1', '2014-07-25 14:15:22', '1', '2014-07-25 14:15:28');
INSERT INTO sm_dictionary VALUES ('309', '营销方案', '11010208', '301', '0', '0', '附件类型', '1', '营销方案', '0', '1', '1', '2014-07-25 14:15:22', '1', '2014-07-25 14:15:28');
INSERT INTO sm_dictionary VALUES ('310', '培训方案', '11010209', '301', '0', '0', '附件类型', '1', '培训方案', '0', '1', '1', '2014-07-25 14:15:22', '1', '2014-07-25 14:15:28');
INSERT INTO sm_dictionary VALUES ('311', '项目说明', '11010210', '301', '0', '0', '附件类型', '1', '项目说明', '0', '1', '1', '2014-07-25 14:15:22', '1', '2014-07-25 14:15:28');
INSERT INTO sm_dictionary VALUES ('312', '募集说明', '11010211', '301', '0', '0', '附件类型', '1', '募集说明', '0', '1', '1', '2014-07-25 14:15:22', '1', '2014-07-25 14:15:28');
INSERT INTO sm_dictionary VALUES ('313', '其它', '11010212', '301', '0', '0', '附件类型', '1', '其它', '0', '1', '1', '2014-07-25 14:15:22', '1', '2014-07-25 14:15:28');
INSERT INTO sm_dictionary VALUES ('321', '关联模块', '110101', null, '0', '0', null, '1', '附件关联模块', '0', '1', '1', '2014-05-27 10:29:14', '1', '2014-05-27 10:29:21');
INSERT INTO sm_dictionary VALUES ('322', '供应商', '11010101', '321', '0', '0', '模块类型', '1', '供应商模块', '0', '1', '1', '2014-05-27 10:30:55', '1', '2014-05-27 10:30:52');
INSERT INTO sm_dictionary VALUES ('323', '客户', '11010102', '321', '0', '0', '模块类型', '1', '客户模块', '0', '1', '1', '2014-05-28 13:21:01', '1', '2014-05-28 13:20:54');
INSERT INTO sm_dictionary VALUES ('324', '线索', '11010103', '321', '0', '0', '模块类型', '1', '线索模块', '0', '1', '1', '2014-05-28 13:21:37', '1', '2014-05-28 13:21:30');
INSERT INTO sm_dictionary VALUES ('325', '联系人', '11010104', '321', '0', '0', '模块类型', '1', '联系人模块', '0', '1', '1', '2014-05-28 13:22:06', '1', '2014-05-28 13:21:59');
INSERT INTO sm_dictionary VALUES ('326', '项目', '11010105', '321', '0', '0', '模块类型', '1', '项目模块', '0', '1', '1', '2014-07-25 21:17:07', '1', '2014-07-25 21:16:52');
INSERT INTO sm_dictionary VALUES ('327', '合同', '11010106', '321', '0', '0', '模块类型', '1', '合同模块', '0', '1', '1', '2014-07-25 21:18:28', '1', '2014-07-25 21:18:12');
INSERT INTO sm_dictionary VALUES ('328', '产品', '11010107', '321', '0', '0', '模块类型', '1', '产品模块', '0', '1', '1', '2014-08-14 14:57:03', '1', '2014-08-14 14:57:10');
INSERT INTO sm_dictionary VALUES ('331', '模块类型', '990101', null, '0', '0', 'module_type', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('332', '报表', '99010101', '331', '0', '0', 'module_type', '1', '报表', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO sm_dictionary VALUES ('341', '产品类型', '050301', null, '0', '0', null, '1', '', '0', '1', '1', '2014-06-09 16:24:46', '1', '2014-06-09 17:17:31');
INSERT INTO sm_dictionary VALUES ('342', '投资产品', '05030101', '341', '0', '0', '产品类型', '1', '投资产品', '0', '1', '1', '2014-06-09 17:19:51', '1', '2014-06-09 17:19:25');
INSERT INTO sm_dictionary VALUES ('343', '理财产品', '05030102', '341', '0', '0', '产品类型', '1', '理财产品', '0', '1', '1', '2014-06-09 17:19:51', '1', '2014-06-09 17:19:25');
INSERT INTO sm_dictionary VALUES ('344', '部分收款', '06010303', '25', '0', '0', '财务状态', '1', '部分收款', '0', '1', '1', '2014-07-27 22:19:29', '1', '2014-07-27 22:19:57');
INSERT INTO sm_dictionary VALUES ('345', '未付款', '06010304', '25', '0', '0', '财务状态', '1', '未付款', '0', '1', '1', '2014-07-27 22:20:12', '1', '2014-07-27 22:20:40');
INSERT INTO sm_dictionary VALUES ('346', '已付款', '06010305', '25', '0', '0', '财务状态', '1', '已付款', '0', '1', '1', '2014-07-27 22:20:58', '1', '2014-07-27 22:21:26');
INSERT INTO sm_dictionary VALUES ('347', 'ceshi(liu)', '005', '1', null, '1', '性别', null, null, '1', '0', '1', '2014-08-18 17:58:55', '1', '2014-08-18 17:59:20');
INSERT INTO sm_dictionary VALUES ('348', '测试数据88', '0701011', '8', null, '1', '工作状态', null, null, '0', '0', '1', '2014-08-19 13:45:40', '1', '2014-08-19 15:44:18');

-- ----------------------------
-- Table structure for `sm_function`
-- ----------------------------
DROP TABLE IF EXISTS `sm_function`;
CREATE TABLE `sm_function` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `MENU_ID` int(11) DEFAULT NULL COMMENT '关联菜单',
  `CODE` varchar(32) DEFAULT NULL COMMENT '功能编号',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '功能名称',
  `URL` varchar(64) DEFAULT NULL COMMENT '调用入口',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '删除标志',
  `PRIVILEGE_LEVEL_ID` int(11) DEFAULT '0' COMMENT ' 权限级别',
  `PARENT_ID` int(11) DEFAULT NULL COMMENT '父功能',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否初始化数据',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_URL` (`URL`) USING BTREE,
  KEY `INDEX_MENU_ID` (`MENU_ID`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE,
  KEY `INDEX_CODE` (`CODE`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=utf8 COMMENT='功能表';

-- ----------------------------
-- Records of sm_function
-- ----------------------------
INSERT INTO sm_function VALUES ('1', null, '000001', '查询', '/query.do', '', '0', '17', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('2', null, '000002', '新增', '/add.do', '', '0', '17', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('3', null, '000003', '详情', '/view.do', '', '0', '17', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('4', null, '000004', '编辑', '/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('5', null, '000005', '删除', '/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('6', null, '000006', '导出', '/export.do', '', '0', '19', '6', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('7', '17', '040208', '联系纪要查询', '/contact/memoir/query.do', '', '0', '19', null, '1', '1', '2014-05-29 15:03:40', '1', '2014-08-15 12:19:15');
INSERT INTO sm_function VALUES ('8', '17', '040209', '联系纪要新增', '/contact/memoir/add.do', '', '0', '19', null, '1', '1', '2014-05-30 10:02:38', '1', '2014-08-15 12:19:10');
INSERT INTO sm_function VALUES ('9', '17', '040210', '联系纪要编辑', '/contact/memoir/modify.do', '', '0', '19', null, '1', '1', '2014-05-30 16:07:58', '1', '2014-08-15 12:19:08');
INSERT INTO sm_function VALUES ('10', '17', '040211', '联系纪要删除', '/contact/memoir/delete.do', '', '0', '19', null, '1', '1', '2014-05-30 16:08:47', '1', '2014-08-15 12:19:04');
INSERT INTO sm_function VALUES ('11', '17', '040212', '联系纪要查看', '/contact/memoir/view.do', '', '0', '19', null, '1', '1', '2014-06-25 19:53:40', '1', '2014-08-15 12:19:01');
INSERT INTO sm_function VALUES ('13', '17', '040213', '附件列表', '/contact/attachment/query.do', '', '0', '19', null, '1', '1', '2014-06-12 15:46:21', '1', '2014-08-15 11:54:12');
INSERT INTO sm_function VALUES ('14', '17', '040214', '附件预览', '/contact/attachment/view.do', '', '0', '19', null, '1', '1', '2014-06-12 15:46:21', '1', '2014-08-15 11:54:14');
INSERT INTO sm_function VALUES ('15', '17', '040215', '附件上传', '/contact/attachment/upload.do', '', '0', '19', null, '1', '1', '2014-06-24 15:31:05', '1', '2014-08-15 11:54:16');
INSERT INTO sm_function VALUES ('16', '17', '040216', '附件下载', '/contact/attachment/download.do', '', '0', '19', null, '1', '1', '2014-06-24 15:32:06', '1', '2014-08-15 11:54:18');
INSERT INTO sm_function VALUES ('17', '17', '040217', '附件删除', '/contact/attachment/delete.do', '', '0', '19', null, '1', '1', '2014-08-15 11:54:34', '1', '2014-08-15 11:54:39');
INSERT INTO sm_function VALUES ('18', '1', '020001', '详情', '/workbanch/view.do', '', '0', '17', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('19', '29', '020002', '列表', '/workbanch/query.do', '', '0', '19', null, '1', '1', '2014-07-09 15:17:07', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('20', '15', '030101', '查询', '/market/marketactivity/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('21', '15', '030102', '新增', '/market/marketactivity/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('22', '15', '030103', '详情', '/market/marketactivity/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('23', '15', '030104', '编辑', '/market/marketactivity/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('24', '15', '030105', '删除', '/market/marketactivity/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('26', '16', '040101', '查询', '/customer/lead/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('27', '16', '040102', '新增', '/customer/lead/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('28', '16', '040103', '详情', '/customer/lead/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('29', '16', '040104', '编辑', '/customer/lead/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('30', '16', '040105', '删除', '/customer/lead/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('31', '16', '040106', '修改所有者', '/customer/lead/modifyOwner.do', '', '0', '19', null, '1', '1', '2014-06-04 10:01:11', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('32', '16', '040107', '线索导出', '/customer/lead/export.do', '', '0', '19', '6', '1', '1', '2014-06-18 20:31:35', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('33', '16', '040108', '附件列表', '/lead/attachment/query.do', '', '0', '19', null, '1', '1', '2014-06-22 16:34:33', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('34', '16', '040109', '附件上传', '/lead/attachment/upload.do', '', '0', '19', null, '1', '1', '2014-06-22 16:35:39', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('35', '16', '040110', '附件预览', '/lead/attachment/view.comp', '', '0', '19', null, '1', '1', '2014-06-22 16:37:16', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('36', '16', '040111', '附件下载', '/lead/attachment/download.do', '', '0', '19', null, '1', '1', '2014-06-22 16:38:30', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('37', '16', '040112', '附件删除', '/lead/attachment/delete.do', '', '0', '19', null, '1', '1', '2014-06-26 18:40:37', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('38', '16', '040113', '线索转换', '/customer/lead/leadConverter.do', '', '0', '19', null, '1', '1', '2014-06-25 17:23:50', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('39', '17', '040201', '查询', '/customer/contact/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('40', '17', '040202', '新增', '/customer/contact/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('41', '17', '040203', '详情', '/customer/contact/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('42', '17', '040204', '编辑', '/customer/contact/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('43', '17', '040205', '删除', '/customer/contact/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('44', '17', '040206', '联系人导出', '/customer/contact/export.do', '', '0', '19', '6', '1', '1', '2014-06-25 15:41:18', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('45', '18', '040301', '查询', '/customer/customer/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('46', '18', '040302', '新增', '/customer/customer/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('47', '18', '040303', '详情', '/customer/customer/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('48', '18', '040304', '编辑', '/customer/customer/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('49', '18', '040305', '删除', '/customer/customer/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('50', '18', '040306', '客户导出', '/customer/customer/export.do', '', '0', '19', '6', '1', '1', '2014-06-18 20:54:48', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('52', '18', '040307', '附件上传', '/customer/attachment/query.do', '', '0', '19', null, '1', '1', '2014-06-22 16:34:33', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('53', '18', '040308', '附件上传', '/customer/attachment/upload.do', '', '0', '19', null, '1', '1', '2014-06-22 16:35:39', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('54', '18', '040309', '附件预览', '/customer/attachment/view.comp', '', '0', '19', null, '1', '1', '2014-06-22 16:37:16', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('55', '18', '040310', '附件下载', '/customer/attachment/download.do', '', '0', '19', null, '1', '1', '2014-06-22 16:38:30', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('56', '18', '040311', '附件删除', '/customer/attachment/delete.do', '', '0', '19', null, '1', '1', '2014-06-27 09:39:53', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('57', '19', '050101', '查询', '/project/supplier/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('58', '19', '050102', '新增', '/project/supplier/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('59', '19', '050103', '详情', '/project/supplier/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('60', '19', '050104', '编辑', '/project/supplier/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('61', '19', '050105', '删除', '/project/supplier/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('62', '19', '050106', '附件查询', '/supplier/attachment/query.do', '', '0', '19', null, '1', '1', '2014-05-27 10:14:03', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('63', '19', '050107', '附件上传', '/supplier/attachment/upload.do', '', '0', '19', null, '1', '1', '2014-05-27 14:06:48', '1', '2014-08-14 14:26:49');
INSERT INTO sm_function VALUES ('64', '19', '050108', '附件预览', '/supplier/attachment/view.comp', '', '0', '19', null, '1', '1', '2014-05-27 10:16:13', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('65', '19', '050109', '附件下载', '/supplier/attachment/download.do', '', '0', '19', null, '1', '1', '2014-05-27 10:17:17', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('66', '19', '050110', '供应商导出', '/project/supplier/export.do', '', '0', '19', '6', '1', '1', '2014-06-19 14:48:13', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('67', '19', '050111', '附件删除', '/supplier/attachment/delete.do', '', '0', '19', null, '1', '1', '2014-06-26 19:14:18', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('68', '20', '050201', '查询', '/project/project/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('69', '20', '050202', '新增', '/project/project/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('70', '20', '050203', '详情', '/project/project/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('71', '20', '050204', '编辑', '/project/project/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('72', '20', '050205', '删除', '/project/project/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('73', '20', '050206', '项目导出', '/project/project/export.do', '', '0', '19', '6', '1', '1', '2014-06-26 16:37:17', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('74', '21', '050301', '查询', '/project/product/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('75', '21', '050302', '新增', '/project/product/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('85', '21', '050303', '详情', '/project/product/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('86', '21', '050304', '编辑', '/project/product/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('87', '21', '050305', '删除', '/project/product/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('88', '21', '050306', '产品导出', '/project/product/export.do', '', '0', '19', '6', '1', '1', '2014-06-25 15:42:30', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('89', '22', '060101', '查询', '/order/order/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('90', '22', '060102', '新增', '/order/order/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('91', '22', '060103', '详情', '/order/order/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('92', '22', '060104', '编辑', '/order/order/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('93', '22', '060105', '删除', '/order/order/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('94', '22', '060106', '导出', '/order/order/export.do', '', '0', '19', null, '1', '1', '2014-07-01 16:59:44', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('95', '23', '060201', '查询', '/order/contract/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('97', '23', '060202', '新增', '/order/contract/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('98', '23', '060203', '详情', '/order/contract/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('99', '23', '060204', '编辑', '/order/contract/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('100', '23', '060205', '删除', '/order/contract/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('106', '26', '070101', '查询', '/sales/salesTarget/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('107', '26', '070102', '新增', '/sales/salesTarget/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('108', '26', '070103', '详情', '/sales/salesTarget/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('109', '26', '070104', '编辑', '/sales/salesTarget/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('110', '26', '070105', '删除', '/sales/salesTarget/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('111', '48', '090101', '查询', '/common/report/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-08-07 15:18:16');
INSERT INTO sm_function VALUES ('112', '48', '090102', '新增', '/common/report/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-08-07 15:18:24');
INSERT INTO sm_function VALUES ('113', '48', '090103', '查看', '/common/report/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-08-07 15:18:27');
INSERT INTO sm_function VALUES ('114', '48', '090104', '修改', '/common/report/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-08-07 15:18:29');
INSERT INTO sm_function VALUES ('115', '48', '090105', '删除', '/common/report/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-08-07 15:18:34');
INSERT INTO sm_function VALUES ('116', '48', '090106', '生成报表', '/common/report/generate.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-08-07 15:18:40');
INSERT INTO sm_function VALUES ('117', '27', '100101', '详情', '/system/user/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-08-17 16:25:02');
INSERT INTO sm_function VALUES ('118', '28', '100201', '修改密码', '/system/user/modifyPassword.do', '', '0', '17', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-08-17 14:27:25');
INSERT INTO sm_function VALUES ('120', '30', '100501', '查询', '/system/message/query.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('121', '30', '100502', '新增', '/system/message/add.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('122', '30', '100503', '详情', '/system/message/view.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('123', '30', '100504', '编辑', '/system/message/modify.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('124', '30', '100505', '删除', '/system/message/delete.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('126', '31', '100601', '查询', '/system/notice/query.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('127', '31', '100602', '新增', '/system/notice/add.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('128', '31', '100603', '详情', '/system/notice/view.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('129', '31', '100604', '编辑', '/system/notice/modify.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('130', '31', '100605', '删除', '/system/notice/delete.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('131', '31', '100606', '导入', '/system/imports1/import.do', '', '0', '19', null, '1', '1', '2014-06-18 19:47:57', '1', '2014-07-31 17:49:18');
INSERT INTO sm_function VALUES ('133', '44', '100701', '详情', '/system/help/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('134', '32', '110101', '查询', '/system/user/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('135', '32', '110102', '新增', '/system/user/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('136', '32', '110103', '编辑', '/system/user/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('137', '32', '110104', '删除', '/system/user/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('138', '32', '110105', '授权', '/system/user/authorization.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('139', '32', '110106', '重置密码', '/system/user/resetPassword.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('140', '32', '110107', '启用', '/system/user/enable.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('141', '32', '110108', '禁用', '/system/user/disable.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('142', '32', '110109', '导入', '/system/user/import.do', '', '0', '19', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('143', '9', '10410', '登录', '/login.doself', '', '0', '17', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('144', '9', '10411', '注销', '/logout.doself', '', '0', '17', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('145', '32', '110112', '用户导出', '/system/user/export.do', '', '0', '19', '6', '1', '1', '2014-05-31 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('146', '33', '110201', '查询', '/system/role/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('147', '33', '110202', '新增', '/system/role/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('148', '33', '110203', '详情', '/system/role/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('149', '33', '110204', '编辑', '/system/role/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('150', '33', '110205', '删除', '/system/role/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('151', '33', '110206', '授权', '/system/role/authorization.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('152', '34', '110301', '查询', '/system/menu/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('153', '34', '110302', '新增', '/system/menu/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('154', '34', '110303', '详情', '/system/menu/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('155', '34', '110304', '编辑', '/system/menu/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('156', '34', '110305', '删除', '/system/menu/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('157', '34', '110306', '移动', '/system/menu/move.doself', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('158', '35', '110401', '查询', '/system/function/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('159', '35', '110402', '新增', '/system/function/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('160', '35', '110403', '详情', '/system/function/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('161', '35', '110404', '编辑', '/system/function/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('162', '35', '110405', '删除', '/system/function/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('163', '35', '110406', '首页', '/system/function/index.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('164', '36', '110501', '查询', '/system/component/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('165', '36', '110502', '新增', '/system/component/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('166', '36', '110503', '详情', '/system/component/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('167', '36', '110504', '编辑', '/system/component/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('168', '36', '110505', '删除', '/system/component/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('169', '37', '110601', '权限设置', '/system/authorization.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-08-10 14:34:36');
INSERT INTO sm_function VALUES ('170', '38', '120101', '查询', '/system/organization/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('171', '38', '120102', '新增', '/system/organization/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('172', '38', '120103', '详情', '/system/organization/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('173', '38', '120104', '编辑', '/system/organization/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('174', '38', '120105', '删除', '/system/organization/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('175', '38', '120106', '授权', '/system/organization/authorization.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('176', '38', '120107', '移动', '/system/organization/move.doself', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('177', '39', '130101', '查询', '/system/dictionary/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('178', '39', '130102', '新增', '/system/dictionary/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('179', '39', '130103', '详情', '/system/dictionary/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('180', '39', '130104', '编辑', '/system/dictionary/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('181', '39', '130105', '删除', '/system/dictionary/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('182', '40', '130201', '详情', '/system/data/export.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('183', '41', '130301', '查询', '/system/recyclebin/query.do', '', '0', '19', null, '1', '1', '2014-06-26 11:09:36', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('184', '41', '130302', '删除', '/system/recyclebin/delete.do', '', '0', '19', null, '1', '1', '2014-06-26 11:10:30', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('185', '41', '130303', '恢复', '/system/recyclebin/recovery.do', '', '0', '19', null, '1', '1', '2014-06-26 11:11:14', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('186', '42', '130401', '查询', '/system/auditlog/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('187', '42', '130402', '新增', '/system/auditlog/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('188', '42', '130403', '详情', '/system/auditlog/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('189', '42', '130404', '编辑', '/system/auditlog/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('190', '42', '130405', '删除', '/system/auditlog/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('191', '43', '140101', '详情', '/system/developer/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('194', '16', '040114', '导入', '/lead/imports/import.do', '', '0', '19', null, '1', '1', '2014-07-14 10:05:18', '1', '2014-08-14 12:42:53');
INSERT INTO sm_function VALUES ('195', '23', '060206', '合同导出', '/order/contract/export.do', '', '0', '19', null, '1', '1', '2014-07-15 14:47:05', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('196', '23', '060207', '附件查询', '/contract/attachment/query.do', '', '0', '19', null, '1', '1', '2014-06-22 16:34:33', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('197', '23', '060208', '附件上传', '/contract/attachment/upload.do', '', '0', '19', null, '1', '1', '2014-06-22 16:35:39', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('198', '23', '060209', '附件预览', '/contract/attachment/view.comp', '', '0', '19', null, '1', '1', '2014-06-22 16:37:16', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('199', '23', '060210', '附件下载', '/contract/attachment/download.do', '', '0', '19', null, '1', '1', '2014-06-22 16:38:30', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('200', '23', '060211', '附件删除', '/contract/attachment/delete.do', '', '0', '19', null, '1', '1', '2014-06-27 09:39:53', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('202', '22', '060108', '启动审批', '/order/order/startApprove.do', '', '0', '18', null, '1', '1', '2014-07-17 15:33:54', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('203', '22', '060109', '执行审批', '/order/order/executeApprove.do', '', '0', '18', null, '1', '1', '2014-07-17 15:33:54', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('204', '22', '060110', '赎回订单', '/order/order/redemption.do', '', '0', '19', null, '1', '1', '2014-07-26 11:10:23', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('205', '1', '020003', '添加工作台', '/workbanch/add.do', '', '0', '17', null, '1', '1', '2014-07-23 22:00:37', '1', '2014-08-01 16:18:55');
INSERT INTO sm_function VALUES ('206', '18', '040312', '客户导入', '/customer/imports/import.do', '', '0', '19', null, '1', '1', '2014-07-23 20:10:13', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('207', '17', '040207', '联系人导入', '/contact/imports/import.do', '', '0', '19', null, '1', '1', '2014-07-23 20:11:15', '0', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('208', '19', '050112', '供应商导入', '/supplier/imports/import.do', '', '0', '19', null, '1', '1', '2014-07-23 20:15:59', '0', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('209', '20', '050207', '附件列表', '/project/attachment/query.do', '', '0', '19', null, '1', '1', '2014-06-22 16:34:33', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('210', '20', '050208', '附件上传', '/project/attachment/upload.do', '', '0', '19', null, '1', '1', '2014-06-22 16:35:39', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('211', '20', '050209', '附件预览', '/project/attachment/view.comp', '', '0', '19', null, '1', '1', '2014-06-22 16:37:16', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('212', '20', '050210', '附件下载', '/project/attachment/download.do', '', '0', '19', null, '1', '1', '2014-06-22 16:38:30', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('213', '20', '050211', '附件删除', '/project/attachment/delete.do', '', '0', '19', null, '1', '1', '2014-06-22 16:38:30', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('214', '45', '130501', '查询', '/system/imports/import.do', '', '0', '19', null, '1', '1', '2014-07-24 15:44:57', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('215', '46', '080301', '查询', '/financial/payments/query.do', '', '0', '19', null, '1', '1', '2014-07-25 20:57:18', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('216', '46', '080303', '详情', '/financial/payments/view.do', '', '0', '19', null, '1', '1', '2014-07-25 20:57:18', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('217', '47', '47001', '查询', '/financial/receiveorder/query.do', '', '0', '19', null, '1', '1', '2014-07-25 21:16:32', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('218', '47', '47002', '新增', '/financial/receiveorder/add.do', '', '0', '19', null, '1', '1', '2014-07-25 21:16:33', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('219', '47', '47003', '详情', '/financial/receiveorder/view.do', '', '0', '19', null, '1', '1', '2014-07-25 21:16:33', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('220', '47', '47004', '编辑', '/financial/receiveorder/modifyFinish.do', '', '0', '19', null, '1', '1', '2014-07-25 21:16:33', '1', '2014-08-01 17:59:12');
INSERT INTO sm_function VALUES ('221', '47', '47005', '删除', '/financial/receiveorder/delete.do', '', '0', '19', null, '1', '1', '2014-07-25 21:16:33', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('222', '24', '080101', '查询', '/financial/approve/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('223', '24', '080102', '新增', '/financial/approve/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('224', '24', '080103', '详情', '/financial/approve/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('225', '24', '080104', '编辑', '/financial/approve/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('226', '24', '080105', '删除', '/financial/approve/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('227', '24', '080106', '进行审批', '/financial/approve/approve.do', '', '0', '18', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('228', '25', '080201', '查询', '/financial/receivables/query.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('229', '25', '080202', '新增', '/financial/receivables/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('230', '25', '080203', '详情', '/financial/receivables/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('231', '25', '080204', '编辑', '/financial/receivables/modifyFinish.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-08-01 18:11:34');
INSERT INTO sm_function VALUES ('232', '25', '080205', '删除', '/financial/receivables/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('234', '46', '080302', '新增', '/financial/payments/add.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('236', '46', '080304', '编辑', '/financial/payments/modify.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('237', '46', '080305', '删除', '/financial/payments/delete.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('238', '15', '030107', '启动审批', '/market/marketactivity/startApprove.do', '', '0', '18', null, '1', '1', '2014-07-17 15:33:54', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('239', '15', '030108', '执行审批', '/market/marketactivity/executeApprove.do', '', '0', '18', null, '1', '1', '2014-07-17 15:33:54', '1', '2014-07-27 19:18:45');
INSERT INTO sm_function VALUES ('305', '41', '130304', '回收站导出', '/system/recyclebin/export.do', '', '0', '19', null, '1', '1', '2014-07-29 11:19:49', '1', '2014-08-08 10:27:18');
INSERT INTO sm_function VALUES ('306', '41', '130305', '导入', '/system/recyclebin/import.do', '', '0', '19', null, '1', '1', '2014-07-29 11:22:26', '1', '2014-07-29 13:22:00');
INSERT INTO sm_function VALUES ('307', '41', '130306', '增加', '/system/recyclebin/add.do', '', '0', '19', null, '1', '1', '2014-07-29 13:48:41', '1', '2014-07-29 13:49:07');
INSERT INTO sm_function VALUES ('309', '22', '060111', '到期赎回', '/order/order/normalRedemption.do', '', '0', '19', null, '0', '1', '2014-07-30 17:16:22', '1', '2014-07-30 17:17:58');
INSERT INTO sm_function VALUES ('310', '25', '080206', '应收款导出', '/financial/receivables/export.do', '', '0', '19', '6', '1', '1', '2014-08-07 14:56:01', '1', '2014-08-08 10:10:02');
INSERT INTO sm_function VALUES ('311', '46', '080306', '应付款导出', '/financial/payments/export.do', '', '0', '19', '6', '1', '1', '2014-08-07 15:00:00', '1', '2014-08-08 10:09:43');
INSERT INTO sm_function VALUES ('312', '21', '050307', '附件查询', '/product/attachment/query.do', '', '0', '19', null, '1', '1', '2014-05-27 10:14:03', '1', '2014-08-14 14:50:47');
INSERT INTO sm_function VALUES ('313', '21', '050308', '附件上传', '/product/attachment/upload.do', '', '0', '19', null, '1', '1', '2014-05-27 14:06:48', '1', '2014-08-14 14:50:51');
INSERT INTO sm_function VALUES ('314', '21', '050309', '附件预览', '/product/attachment/view.comp', '', '0', '19', null, '1', '1', '2014-05-27 10:16:13', '1', '2014-08-14 14:50:54');
INSERT INTO sm_function VALUES ('315', '21', '050310', '附件下载', '/product/attachment/download.do', '', '0', '19', null, '1', '1', '2014-05-27 10:17:17', '1', '2014-08-14 14:50:57');
INSERT INTO sm_function VALUES ('316', '21', '050311', '附件删除', '/product/attachment/delete.do', '', '0', '19', null, '1', '1', '2014-06-26 19:14:18', '1', '2014-08-14 14:50:59');
INSERT INTO sm_function VALUES ('318', '49', '090203', '查看', '/common/warning/view.do', '', '0', '19', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-08-07 15:18:27');
INSERT INTO sm_function VALUES ('319', '16', '040115', '联系纪要查询', '/lead/memoir/query.do', '', '0', '19', null, '1', '1', '2014-05-29 15:03:40', '1', '2014-08-15 11:50:37');
INSERT INTO sm_function VALUES ('320', '16', '040116', '联系纪要新增', '/lead/memoir/add.do', '', '0', '19', null, '1', '1', '2014-05-30 10:02:38', '1', '2014-08-15 11:50:39');
INSERT INTO sm_function VALUES ('321', '16', '040117', '联系纪要编辑', '/lead/memoir/modify.do', '', '0', '19', null, '1', '1', '2014-05-30 16:07:58', '1', '2014-08-15 11:50:45');
INSERT INTO sm_function VALUES ('322', '16', '040118', '联系纪要删除', '/lead/memoir/delete.do', '', '0', '19', null, '1', '1', '2014-05-30 16:08:47', '1', '2014-08-15 11:50:49');
INSERT INTO sm_function VALUES ('323', '16', '040119', '联系纪要查看', '/lead/memoir/view.do', '', '0', '19', null, '1', '1', '2014-06-25 19:53:40', '1', '2014-08-15 11:50:52');
INSERT INTO sm_function VALUES ('324', '18', '040313', '联系纪要查询', '/customer/memoir/query.do', '', '0', '19', null, '1', '1', '2014-05-29 15:03:40', '1', '2014-08-15 11:50:37');
INSERT INTO sm_function VALUES ('325', '18', '040314', '联系纪要新增', '/customer/memoir/add.do', '', '0', '19', null, '1', '1', '2014-05-30 10:02:38', '1', '2014-08-15 11:50:39');
INSERT INTO sm_function VALUES ('326', '18', '040315', '联系纪要编辑', '/customer/memoir/modify.do', '', '0', '19', null, '1', '1', '2014-05-30 16:07:58', '1', '2014-08-15 11:50:45');
INSERT INTO sm_function VALUES ('327', '18', '040316', '联系纪要删除', '/customer/memoir/delete.do', '', '0', '19', null, '1', '1', '2014-05-30 16:08:47', '1', '2014-08-15 11:50:49');
INSERT INTO sm_function VALUES ('328', '18', '040317', '联系纪要查看', '/customer/memoir/view.do', '', '0', '19', null, '1', '1', '2014-06-25 19:53:40', '1', '2014-08-15 11:50:52');
INSERT INTO sm_function VALUES ('329', '22', '060112', '订单作废', '/order/order/toInvalid.do', '', '0', '19', null, '1', '1', '2014-08-15 15:52:26', '1', '2014-08-15 17:04:30');

-- ----------------------------
-- Table structure for `sm_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sm_menu`;
CREATE TABLE `sm_menu` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键号编',
  `NAME` varchar(32) NOT NULL COMMENT '菜单名称',
  `URL` varchar(64) DEFAULT NULL COMMENT '链接地址',
  `SHOW_LOCATION_TYPE` int(11) DEFAULT NULL COMMENT '显示位置',
  `DEFAULT_SHOW` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认显示',
  `TRIGGER_ID` int(11) DEFAULT NULL COMMENT '触发功能',
  `IS_ACTIVE` tinyint(1) NOT NULL COMMENT '是否激活的',
  `LEVEL` int(11) NOT NULL COMMENT '级别',
  `IS_LEAF` tinyint(1) NOT NULL COMMENT '叶子节点',
  `PARENT_MENU_ID` int(11) DEFAULT NULL COMMENT '上级菜单',
  `ORDER` int(11) NOT NULL COMMENT '序号',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '备注',
  `IS_DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '否是被删除',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否初始化数据',
  `CREATOR_ID` int(11) NOT NULL COMMENT '建创者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_CREAOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE,
  KEY `INDEX_ORDER` (`ORDER`) USING BTREE,
  KEY `INDEX_URL` (`URL`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of sm_menu
-- ----------------------------
INSERT INTO sm_menu VALUES ('1', '工作台', '/workbanch/toViewPage.do', '1', '1', '18', '1', '1', '1', null, '20000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:43:18');
INSERT INTO sm_menu VALUES ('2', '市场营销', '', '1', '0', null, '1', '1', '0', null, '30000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-25 14:48:44');
INSERT INTO sm_menu VALUES ('3', '客户管理', '', '1', '0', null, '1', '1', '0', null, '40000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-25 14:48:45');
INSERT INTO sm_menu VALUES ('4', '项目管理', '', '1', '0', null, '1', '1', '0', null, '50000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-25 14:48:45');
INSERT INTO sm_menu VALUES ('5', '订单管理', '', '1', '0', null, '1', '1', '0', null, '60000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-25 14:48:46');
INSERT INTO sm_menu VALUES ('6', '财务管理', '', '1', '0', null, '1', '1', '0', null, '70000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-25 21:17:04');
INSERT INTO sm_menu VALUES ('7', '销售管理', '', '1', '0', null, '1', '1', '0', null, '80000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-25 14:48:48');
INSERT INTO sm_menu VALUES ('8', '报表管理', null, '1', '0', null, '1', '1', '0', null, '90000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-08-07 16:18:21');
INSERT INTO sm_menu VALUES ('9', '个人设置', '', '2', '0', null, '1', '1', '0', null, '100000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-24 17:26:55');
INSERT INTO sm_menu VALUES ('10', '用户及权限', '', '2', '0', null, '1', '1', '0', null, '110000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-25 14:48:50');
INSERT INTO sm_menu VALUES ('11', '机构设置', '', '2', '0', null, '1', '1', '0', null, '120000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-25 14:48:51');
INSERT INTO sm_menu VALUES ('12', '数据管理', '', '2', '0', null, '1', '1', '0', null, '130000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-24 17:26:55');
INSERT INTO sm_menu VALUES ('13', '开发者空间', '', '2', '0', null, '1', '1', '0', null, '140000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-24 17:26:55');
INSERT INTO sm_menu VALUES ('14', '帮助', '', '2', '0', null, '1', '1', '0', null, '150000', '', '0', '1', '1', '2014-07-01 17:39:20', '1', '2014-07-24 17:26:55');
INSERT INTO sm_menu VALUES ('15', '市场活动', '/market/marketactivity/toQueryPage.do', '1', '0', '20', '1', '2', '1', '2', '30100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:47:59');
INSERT INTO sm_menu VALUES ('16', '线索', '/customer/lead/toQueryPage.do', '1', '0', '26', '1', '2', '1', '3', '40100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-08-11 11:46:55');
INSERT INTO sm_menu VALUES ('17', '联系人', '/customer/contact/toQueryPage.do', '1', '0', '39', '1', '2', '1', '3', '40300', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-08-14 16:28:36');
INSERT INTO sm_menu VALUES ('18', '客户', '/customer/customer/toQueryPage.do', '1', '0', '45', '1', '2', '1', '3', '40200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-08-14 16:28:41');
INSERT INTO sm_menu VALUES ('19', '供应商', '/project/supplier/toQueryPage.do', '1', '0', '57', '1', '2', '1', '4', '50100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:48:37');
INSERT INTO sm_menu VALUES ('20', '项目', '/project/project/toQueryPage.do', '1', '0', '68', '1', '2', '1', '4', '50200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:48:47');
INSERT INTO sm_menu VALUES ('21', '产品', '/project/product/toQueryPage.do', '1', '0', '74', '1', '2', '1', '4', '50300', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:48:56');
INSERT INTO sm_menu VALUES ('22', '订单', '/order/order/toQueryPage.do', '1', '0', '89', '1', '2', '1', '5', '60100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:49:07');
INSERT INTO sm_menu VALUES ('23', '合同', '/order/contract/toQueryPage.do', '1', '0', '95', '1', '2', '1', '5', '60200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:49:17');
INSERT INTO sm_menu VALUES ('24', '财务审批', '/financial/approve/query.do', '1', '0', '222', '1', '2', '1', '6', '70100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:49:28');
INSERT INTO sm_menu VALUES ('25', '收款管理', '/financial/receivables/toQueryPage.do', '1', '0', '228', '1', '2', '1', '6', '70200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:49:35');
INSERT INTO sm_menu VALUES ('26', '销售目标', '/sales/salesTarget/toQueryPage.do', '1', '0', '106', '1', '2', '1', '7', '80100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:49:45');
INSERT INTO sm_menu VALUES ('27', '账号信息', '/system/user/toViewPage.do', '2', '0', '117', '1', '2', '1', '9', '100100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:49:59');
INSERT INTO sm_menu VALUES ('28', '更改密码', '/system/user/toModifyPasswordPage.do', '2', '0', '118', '1', '2', '1', '9', '100200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:50:15');
INSERT INTO sm_menu VALUES ('29', '自定义工作台', '/workbanch/toQueryPage.do', '2', '0', '19', '1', '2', '1', '9', '100300', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-08-01 16:21:59');
INSERT INTO sm_menu VALUES ('30', '系统消息', '/system/message/toQueryPage.do', '2', '0', '120', '1', '2', '1', '9', '100500', '', '0', '1', '1', '2014-06-26 11:35:41', '0', '2014-07-27 19:50:27');
INSERT INTO sm_menu VALUES ('31', '系统公告', '/system/notice/toQueryPage.do', '2', '0', '126', '1', '2', '1', '9', '100500', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-08-07 10:28:02');
INSERT INTO sm_menu VALUES ('32', '用户', '/system/user/toQueryPage.do', '2', '0', '134', '1', '2', '1', '10', '110100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:50:49');
INSERT INTO sm_menu VALUES ('33', '角色', '/system/role/toQueryPage.do', '2', '0', '146', '1', '2', '1', '10', '110200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:51:02');
INSERT INTO sm_menu VALUES ('34', '菜单', '/system/menu/toQueryPage.do', '2', '0', '152', '1', '2', '1', '10', '110300', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:51:13');
INSERT INTO sm_menu VALUES ('35', '功能', '/system/function/toQueryPage.do', '2', '0', '158', '1', '2', '1', '10', '110400', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:51:22');
INSERT INTO sm_menu VALUES ('36', '组件', '/system/component/toQueryPage.do', '2', '0', '164', '1', '2', '1', '10', '110500', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:51:29');
INSERT INTO sm_menu VALUES ('37', '权限设置', '/system/user/toAuthorizationPage.do', '2', '0', '169', '1', '2', '1', '10', '110600', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:51:45');
INSERT INTO sm_menu VALUES ('38', '组织机构', '/system/organization/toQueryPage.do', '2', '0', '170', '1', '2', '1', '11', '120100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:51:52');
INSERT INTO sm_menu VALUES ('39', '字典维护', '/system/dictionary/toQueryPage.do', '2', '0', '177', '1', '2', '1', '12', '130100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:52:01');
INSERT INTO sm_menu VALUES ('40', '导出数据', '/system/data/toExportPage.do', '2', '0', '182', '1', '2', '1', '12', '130300', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:52:12');
INSERT INTO sm_menu VALUES ('41', '回收站', '/system/recyclebin/toQueryPage.do', '2', '0', '183', '1', '2', '1', '12', '130500', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:52:18');
INSERT INTO sm_menu VALUES ('42', '审计日志', '/system/auditlog/toQueryPage.do', '2', '0', '186', '1', '2', '1', '12', '130400', '', '0', '1', '1', '2014-06-22 16:41:41', '1', '2014-07-27 19:52:30');
INSERT INTO sm_menu VALUES ('43', 'CRM API', '/system/developer/toViewPage.do', '2', '0', '191', '1', '2', '1', '13', '140100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:52:37');
INSERT INTO sm_menu VALUES ('44', '系统操作手册', '/system/help/toViewPage.do', '2', '0', '0', '1', '2', '1', '14', '150100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-24 17:26:55');
INSERT INTO sm_menu VALUES ('45', '导入数据', '/system/imports/toImportPage.do', '2', '0', '214', '1', '2', '1', '12', '130200', null, '0', '1', '1', '2014-07-24 15:38:14', '1', '2014-07-31 17:50:02');
INSERT INTO sm_menu VALUES ('46', '付款管理', '/financial/payments/toQueryPage.do', '1', '0', '215', '1', '2', '1', '6', '70300', null, '0', '0', '1', '2014-07-25 20:57:50', '1', '2014-07-27 19:53:23');
INSERT INTO sm_menu VALUES ('47', '收款单', '/financial/receiveorder/toQueryPage.do', '1', '0', '218', '1', '2', '1', '6', '70400', null, '1', '0', '1', '2014-07-25 21:17:04', '1', '2014-07-28 13:38:28');
INSERT INTO sm_menu VALUES ('48', '自定义报表', '/common/report/toQueryPage.do', '1', '0', '111', '1', '2', '1', '8', '90100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-08-07 15:18:04');
INSERT INTO sm_menu VALUES ('49', '预警管理', '/common/warning/toViewPage.do', '1', '0', '318', '1', '2', '1', '8', '90200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-08-07 16:02:50');

-- ----------------------------
-- Table structure for `sm_message`
-- ----------------------------
DROP TABLE IF EXISTS `sm_message`;
CREATE TABLE `sm_message` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `TITLE` varchar(128) DEFAULT NULL,
  `CONTENT` text NOT NULL COMMENT '内容',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `IS_DELETED` tinyint(6) NOT NULL DEFAULT '0' COMMENT '是否被删除',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='系统消息';

-- ----------------------------
-- Records of sm_message
-- ----------------------------
INSERT INTO sm_message VALUES ('1', '系统消息', '系统消息内容\n系统消息内容\n系统消息内容系统消息内容', '1', '2014-08-18 15:39:38', '0', '1', '2014-08-18 15:40:12');
INSERT INTO sm_message VALUES ('2', 'fd', 'fd', '1', '2014-08-18 15:42:05', '0', '1', '2014-08-18 15:41:41');
INSERT INTO sm_message VALUES ('3', 'adsa', 'dasd', '3', '2014-08-18 15:46:47', '0', '3', '2014-08-18 15:46:23');
INSERT INTO sm_message VALUES ('4', '订单审批-理财经理审核(订单编号：123456)', '管理员于2014-08-20 09:41启动订单审批-理财经理审核(订单编号：123456)，特发此系统消息提醒您及时进行审批！<a href=\'../../order/order/toStartApprovePage.do?id=2\'>审批链接</a>', '1', '2014-08-20 09:41:32', '0', '1', '2014-08-20 09:41:01');
INSERT INTO sm_message VALUES ('5', '市场活动（非金额）-理财经理审核(市场活动名称：招商活动)', '管理员于2014-08-20 09:44启动市场活动（非金额）-理财经理审核(市场活动名称：招商活动)，特发此系统消息提醒您及时进行审批！<a href=\"../../market/marketactivity/toStartApprovePage.do?id=1\">审批链接</a>', '1', '2014-08-20 09:44:13', '0', '1', '2014-08-26 19:49:30');
INSERT INTO sm_message VALUES ('6', '订单审批-理财经理审核(订单编号：024568)', '管理员于2014-08-20 14:24启动订单审批-理财经理审核(订单编号：024568)，特发此系统消息提醒您及时进行审批！<a href=\'../../order/order/toStartApprovePage.do?id=1\'>审批链接</a>', '1', '2014-08-20 14:24:42', '0', '1', '2014-08-20 14:24:11');
INSERT INTO sm_message VALUES ('7', '撒旦', '大非师范\n发生点发', '1', '2014-08-21 10:55:15', '0', '1', '2014-08-21 10:55:43');
INSERT INTO sm_message VALUES ('8', 'ds', '打算打算的', '1', '2014-08-27 10:37:15', '0', '1', '2014-08-27 10:38:19');

-- ----------------------------
-- Table structure for `sm_module`
-- ----------------------------
DROP TABLE IF EXISTS `sm_module`;
CREATE TABLE `sm_module` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(32) NOT NULL COMMENT '名称',
  `DESC` varchar(32) NOT NULL COMMENT '述描',
  `ENTITY_CLASS` varchar(256) NOT NULL COMMENT '关联实体类',
  `URL` varchar(64) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_URL` (`URL`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='模块表';

-- ----------------------------
-- Records of sm_module
-- ----------------------------
INSERT INTO sm_module VALUES ('1', 'marketActivity', '市场活动', 'com.baihui.hxtd.soa.market.entity.MarketActivity', '/market/marketactivity');
INSERT INTO sm_module VALUES ('2', 'lead', '线索', 'com.baihui.hxtd.soa.customer.entity.Lead', '/customer/lead');
INSERT INTO sm_module VALUES ('3', 'contact', '联系人', 'com.baihui.hxtd.soa.customer.entity.Contact', '/customer/contact');
INSERT INTO sm_module VALUES ('4', 'customer', '客户', 'com.baihui.hxtd.soa.customer.entity.Customer', '/customer/customer');
INSERT INTO sm_module VALUES ('5', 'supplier', '供应商', 'com.baihui.hxtd.soa.project.entity.Supplier', '/project/supplier');
INSERT INTO sm_module VALUES ('6', 'project', '项目', 'com.baihui.hxtd.soa.project.entity.Project', '/project/project');
INSERT INTO sm_module VALUES ('7', 'product', '产品', 'com.baihui.hxtd.soa.project.entity.Product', '/project/product');
INSERT INTO sm_module VALUES ('8', 'order', '订单', 'com.baihui.hxtd.soa.order.entity.Order', '/order/order');
INSERT INTO sm_module VALUES ('9', 'user', '用户', 'com.baihui.hxtd.soa.system.entity.User', '/system/user');
INSERT INTO sm_module VALUES ('10', 'role', '角色', 'com.baihui.hxtd.soa.system.entity.Role', '/system/role');
INSERT INTO sm_module VALUES ('11', 'menu', '菜单', 'com.baihui.hxtd.soa.system.entity.Menu', '/system/menu');
INSERT INTO sm_module VALUES ('12', 'function', '功能', 'com.baihui.hxtd.soa.system.entity.Function', '/system/function');
INSERT INTO sm_module VALUES ('13', 'component', '组件', 'com.baihui.hxtd.soa.system.entity.Component', '/system/component');
INSERT INTO sm_module VALUES ('14', 'organization', '组织', 'com.baihui.hxtd.soa.system.entity.Organization', '/system/organization');
INSERT INTO sm_module VALUES ('15', 'userMessage', '系统消息', 'com.baihui.hxtd.soa.system.entity.UserMessage', '/system/userMessage');
INSERT INTO sm_module VALUES ('16', 'notice', '系统公告', 'com.baihui.hxtd.soa.system.entity.Notice', '/system/notice');
INSERT INTO sm_module VALUES ('17', 'dictionary', '字典', 'com.baihui.hxtd.soa.system.entity.Dictionary', '/system/dictionary');
INSERT INTO sm_module VALUES ('18', 'auditLog', '审计日志', 'com.baihui.hxtd.soa.system.entity.AuditLog', '/system/auditLog');
INSERT INTO sm_module VALUES ('19', 'recycleBin', '回收站', 'com.baihui.hxtd.soa.system.entity.RecycleBin', '/system/recycleBin');
INSERT INTO sm_module VALUES ('20', 'attachment', '附件', 'com.baihui.hxtd.soa.common.entity.Attachment', '/common/attachment');
INSERT INTO sm_module VALUES ('21', 'memoir', '联系人纪要', 'com.baihui.hxtd.soa.common.entity.Memoir', '/common/memoir');

-- ----------------------------
-- Table structure for `sm_module_type`
-- ----------------------------
DROP TABLE IF EXISTS `sm_module_type`;
CREATE TABLE `sm_module_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键编号',
  `TYPE_ID` int(11) NOT NULL COMMENT '类型编号',
  `MODULE_ID` int(11) NOT NULL COMMENT '模块编号',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_TYPE_ID_MODULE_ID` (`TYPE_ID`,`MODULE_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='模块类型表\r\n注意：类型编号和模块编号为联合的唯一列\r\n';

-- ----------------------------
-- Records of sm_module_type
-- ----------------------------
INSERT INTO sm_module_type VALUES ('2', '332', '1');
INSERT INTO sm_module_type VALUES ('3', '332', '2');
INSERT INTO sm_module_type VALUES ('4', '332', '3');
INSERT INTO sm_module_type VALUES ('5', '332', '4');
INSERT INTO sm_module_type VALUES ('6', '332', '5');
INSERT INTO sm_module_type VALUES ('7', '332', '6');
INSERT INTO sm_module_type VALUES ('8', '332', '7');
INSERT INTO sm_module_type VALUES ('9', '332', '8');
INSERT INTO sm_module_type VALUES ('10', '332', '9');
INSERT INTO sm_module_type VALUES ('11', '332', '10');
INSERT INTO sm_module_type VALUES ('12', '332', '11');
INSERT INTO sm_module_type VALUES ('13', '332', '12');
INSERT INTO sm_module_type VALUES ('14', '332', '13');
INSERT INTO sm_module_type VALUES ('15', '332', '14');
INSERT INTO sm_module_type VALUES ('16', '332', '15');
INSERT INTO sm_module_type VALUES ('17', '332', '16');
INSERT INTO sm_module_type VALUES ('18', '332', '17');
INSERT INTO sm_module_type VALUES ('19', '332', '18');
INSERT INTO sm_module_type VALUES ('20', '332', '19');
INSERT INTO sm_module_type VALUES ('21', '332', '20');
INSERT INTO sm_module_type VALUES ('22', '332', '21');

-- ----------------------------
-- Table structure for `sm_org`
-- ----------------------------
DROP TABLE IF EXISTS `sm_org`;
CREATE TABLE `sm_org` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '键主编号',
  `SHORT_NAME` varchar(64) NOT NULL COMMENT '机构简称',
  `FULL_NAME` varchar(128) NOT NULL COMMENT '构机全称',
  `TYPE` int(11) NOT NULL COMMENT '类型 1公司 2部门 3组',
  `PHONE` varchar(32) DEFAULT NULL COMMENT '手机号码',
  `EMAIL` varchar(32) DEFAULT NULL COMMENT '邮箱',
  `ADDRESS` varchar(512) DEFAULT NULL COMMENT '地址',
  `ZIP_CODE` varchar(32) DEFAULT NULL COMMENT '邮政编码',
  `WEB_SITE` varchar(64) DEFAULT NULL COMMENT '站点',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '备注',
  `LEVEL` int(11) NOT NULL COMMENT '别级',
  `IS_LEAF` tinyint(1) NOT NULL COMMENT '叶子节点',
  `PARENT_ORG_ID` int(11) DEFAULT NULL COMMENT '上级组织主键编号',
  `ORDER` int(11) NOT NULL COMMENT '序号',
  `IS_DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被删除',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '否是初始化数据',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8 COMMENT='机构表';

-- ----------------------------
-- Records of sm_org
-- ----------------------------
INSERT INTO sm_org VALUES ('1', '华兴控股', '华兴控股', '5', '18620088324', '1429457@163.com', '北京市海淀区', '100000', 'http://hxtd.crm.com', null, '1', '0', null, '100000000', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('2', '董事会', '董事会', '7', '', '', '', '', '', null, '2', '1', '1', '101000000', '0', '1', '1', '2014-07-10 15:17:25', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('3', '监视会', '监视会', '7', '18620088324', '1429457@163.com', '北京市海淀区', '100000', 'http://hxtd.crm.com', null, '2', '1', '1', '102000000', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('35', '总办', '总办', '7', '18500723906', null, '北京市海淀区', null, null, null, '2', '0', '1', '127000000', '0', '1', '1', '2014-07-16 11:41:51', '1', '2014-08-13 09:51:42');
INSERT INTO sm_org VALUES ('36', '投资基金管理', '投资基金管理', '7', '18500230212', null, null, null, null, null, '2', '0', '1', '128000000', '0', '1', '1', '2014-07-16 11:42:14', '1', '2014-08-13 13:15:17');
INSERT INTO sm_org VALUES ('37', '资产管理', '资产管理', '6', null, null, null, null, null, null, '2', '0', '1', '129000000', '0', '1', '1', '2014-07-16 11:42:28', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('38', '行政部', '行政部', '6', null, null, null, null, null, null, '3', '1', '35', '127010000', '0', '1', '1', '2014-07-16 11:42:54', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('39', '人力资源部', '人力资源部', '6', null, null, null, null, null, null, '3', '1', '35', '127020000', '0', '1', '1', '2014-07-16 11:43:09', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('40', '财务部', '财务部', '6', null, null, null, null, null, null, '3', '1', '35', '127030000', '0', '1', '1', '2014-07-16 11:43:23', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('41', '秘书处', '秘书处', '6', null, null, null, null, null, null, '3', '1', '35', '127040000', '0', '1', '1', '2014-07-16 11:43:38', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('42', '法务部', '法务部', '6', null, null, null, null, null, null, '3', '1', '35', '127050000', '0', '1', '1', '2014-07-16 11:43:52', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('43', '项目部', '重大项目部', '6', null, null, null, null, null, null, '3', '1', '37', '129020000', '0', '1', '1', '2014-07-16 11:44:08', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('44', '风控部', '风控部', '6', null, null, null, null, null, null, '3', '1', '37', '129030000', '0', '1', '1', '2014-07-16 11:44:21', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('45', '投资部', '投资部', '6', null, null, null, null, null, null, '3', '1', '36', '128050000', '0', '1', '1', '2014-07-16 11:44:35', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('46', '理财部', '理财部', '6', null, null, null, null, null, null, '3', '1', '36', '128030000', '0', '1', '1', '2014-07-16 11:45:33', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('47', '渠道合作部', '渠道合作部', '6', null, null, null, null, null, null, '3', '1', '36', '128040000', '0', '1', '1', '2014-07-16 11:47:02', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('48', '企划部', '企划部', '6', null, null, null, null, null, null, '3', '1', '35', '127060000', '0', '1', '1', '2014-07-16 11:49:12', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('49', '品牌媒介部', '品牌媒介部', '6', null, null, null, null, null, null, '3', '1', '35', '127070000', '0', '1', '1', '2014-07-16 11:49:32', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('50', '技术部', '技术部', '6', null, null, null, null, null, null, '3', '1', '35', '127080000', '0', '1', '1', '2014-07-16 11:49:50', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('51', '海淀区分部', '海淀区分部', '5', null, null, null, null, null, '海淀区销售', '3', '0', '36', '128060000', '0', '1', '1', '2014-07-16 11:52:36', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('52', '昌平区分部', '昌平区分部', '5', null, null, null, null, null, '昌平区销售', '3', '0', '36', '128070000', '0', '1', '1', '2014-07-16 11:53:00', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('55', '华兴泰达(北京)', '北京华兴泰达投资基金管理有限公司', '5', null, null, null, null, null, null, '3', '0', '36', '128080000', '0', '1', '1', '2014-07-16 12:07:10', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('56', '运营部', '运营部', '6', null, null, null, null, null, null, '4', '1', '55', '128080100', '0', '1', '1', '2014-07-16 12:08:36', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('57', '市场策划部', '市场策划部', '6', null, null, null, null, null, null, '3', '1', '35', '127090000', '0', '1', '1', '2014-07-16 12:19:34', '1', '2014-08-11 17:57:04');
INSERT INTO sm_org VALUES ('58', '总裁办公室', '总裁办公室', '6', null, null, null, null, null, null, '3', '1', '35', '127100000', '0', '1', '1', '2014-07-16 12:23:17', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('59', '朝阳区分部', '朝阳区分部', '5', null, null, null, null, null, '朝阳区销售', '3', '0', '36', '128090000', '0', '1', '1', '2014-07-16 13:08:43', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('60', '房山区分部', '房山区分部', '5', null, null, null, null, null, '房山区销售', '3', '0', '36', '128100000', '0', '1', '1', '2014-07-16 13:09:00', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('61', '华兴瑞泰(北京)', '北京华兴瑞泰资产管理中心', '5', null, null, null, null, null, null, '3', '1', '37', '129040000', '0', '1', '1', '2014-07-16 14:25:37', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('62', '银行渠道部', '银行渠道部', '6', null, null, null, null, null, null, '4', '0', '51', '128060100', '0', '1', '1', '2014-07-16 15:56:47', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('64', '渠道部', '渠道部', '6', null, null, null, null, null, null, '4', '0', '52', '128070100', '0', '1', '1', '2014-07-16 16:09:37', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('65', '渠道部', '渠道部', '6', null, null, null, null, null, null, '4', '0', '60', '128100100', '0', '1', '1', '2014-07-16 16:10:29', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('66', '投资理财部', '投资理财部', '6', null, null, null, null, null, null, '4', '0', '59', '128090100', '0', '1', '1', '2014-07-16 16:10:53', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('67', '投资理财部', '投资理财部', '6', null, null, null, null, null, null, '4', '0', '51', '128060200', '0', '1', '1', '2014-07-16 16:22:02', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('68', '渠道1组', '渠道1组', '7', null, null, null, null, null, null, '5', '1', '62', '128060101', '0', '1', '1', '2014-07-16 16:23:18', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('69', '渠道2组', '渠道2组', '7', null, '', null, null, null, null, '5', '1', '62', '128060102', '0', '1', '1', '2014-07-16 16:25:53', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('70', '渠道3组', '渠道3组', '7', null, null, null, null, null, null, '5', '1', '62', '128060103', '0', '1', '1', '2014-07-16 16:29:33', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('71', '理财1组', '理财1组', '7', null, null, null, null, null, null, '5', '1', '67', '128060201', '0', '1', '1', '2014-07-16 16:33:29', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('72', '理财2组', '理财2组', '7', null, null, null, null, null, null, '5', '1', '67', '128060202', '0', '1', '1', '2014-07-16 16:34:16', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('73', '理财3组', '理财3组', '7', null, null, null, null, null, null, '5', '1', '67', '128060203', '0', '1', '1', '2014-07-16 16:37:03', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('74', '理财部', '理财部', '6', null, null, null, null, null, null, '4', '0', '52', '128070200', '0', '1', '1', '2014-07-16 16:38:17', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('75', '渠道1组', '渠道1组', '6', null, null, null, null, null, null, '5', '1', '64', '128070101', '0', '1', '1', '2014-07-16 16:39:52', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('76', '渠道2组', '渠道2组', '7', null, null, null, null, null, null, '5', '1', '64', '128070102', '0', '1', '1', '2014-07-16 16:41:34', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('77', '渠道3组', '渠道3组', '7', null, null, null, null, null, null, '5', '1', '64', '128070103', '0', '1', '1', '2014-07-16 16:42:14', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('78', '理财1组', '理财1组', '7', null, null, null, null, null, null, '5', '1', '74', '128070201', '0', '1', '1', '2014-07-16 16:43:29', '1', '2014-08-11 18:14:17');
INSERT INTO sm_org VALUES ('79', '理财2组', '理财2组', '7', null, null, null, null, null, null, '5', '1', '74', '128070202', '0', '1', '1', '2014-07-16 16:44:32', '1', '2014-08-11 18:14:14');
INSERT INTO sm_org VALUES ('80', '理财1组', '理财1组', '7', null, null, null, null, null, null, '5', '1', '66', '128090101', '0', '1', '1', '2014-07-16 16:45:10', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('81', '理财3组', '理财3组', '7', null, null, null, null, null, null, '5', '1', '74', '128070203', '0', '1', '1', '2014-07-16 16:45:30', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('82', '理财2组', '理财2组', '7', null, null, null, null, null, null, '5', '1', '66', '128090102', '0', '1', '1', '2014-07-16 16:46:40', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('83', '理财3组', '理财3组', '7', null, null, null, null, null, null, '5', '1', '66', '128090103', '0', '1', '1', '2014-07-16 16:47:33', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('84', '理财部', '理财部', '6', null, null, null, null, null, null, '4', '0', '60', '128100200', '0', '1', '1', '2014-07-16 16:49:19', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('85', '渠道1组', '渠道1组', '6', null, null, null, null, null, null, '5', '1', '65', '128100101', '0', '1', '1', '2014-07-16 16:50:08', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('86', '渠道2组', '渠道2组', '7', null, null, null, null, null, null, '5', '1', '65', '128100102', '0', '1', '1', '2014-07-16 16:51:21', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('87', '渠道3组', '渠道3组', '7', null, null, null, null, null, null, '5', '1', '65', '128100103', '0', '1', '1', '2014-07-16 16:52:38', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('88', '理财1组', '理财1组', '7', null, null, null, null, null, null, '5', '1', '84', '128100201', '0', '1', '1', '2014-07-16 16:53:31', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('89', '理财2组', '理财2组', '7', null, null, null, null, null, null, '5', '1', '84', '128100202', '0', '1', '1', '2014-07-16 16:55:17', '1', '2014-07-27 19:29:01');
INSERT INTO sm_org VALUES ('90', '理财3组', '理财3组', '7', null, null, null, null, null, null, '5', '1', '84', '128100203', '0', '1', '1', '2014-07-16 16:55:58', '1', '2014-07-27 19:29:01');

-- ----------------------------
-- Table structure for `sm_org_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_org_role`;
CREATE TABLE `sm_org_role` (
  `ORG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '组织ID',
  `ROLE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  PRIMARY KEY (`ORG_ID`,`ROLE_ID`),
  KEY `INDEX_ORG_ID` (`ORG_ID`) USING BTREE,
  KEY `INDEX_ROLE_ID` (`ROLE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='织组角色关联表';

-- ----------------------------
-- Records of sm_org_role
-- ----------------------------
INSERT INTO sm_org_role VALUES ('1', '1');

-- ----------------------------
-- Table structure for `sm_position`
-- ----------------------------
DROP TABLE IF EXISTS `sm_position`;
CREATE TABLE `sm_position` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '岗位编号',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '岗位名称',
  `PARENT_POS_ID` int(11) NOT NULL DEFAULT '0' COMMENT '上级岗位ID',
  `PARTY_ID` int(11) NOT NULL DEFAULT '0' COMMENT '隶属组织ID',
  `SORT_NO` int(11) NOT NULL DEFAULT '0' COMMENT '排列顺序',
  `STATUS` int(11) NOT NULL DEFAULT '0' COMMENT '岗位状态',
  `REMARK` varchar(215) NOT NULL DEFAULT '' COMMENT '备注',
  `CREATEOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '修改时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '最后修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_NO` (`CODE`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_CREATEOR_ID` (`CREATEOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='岗位表';

-- ----------------------------
-- Records of sm_position
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_recyclebin`
-- ----------------------------
DROP TABLE IF EXISTS `sm_recyclebin`;
CREATE TABLE `sm_recyclebin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `MODULE_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '模块名称',
  `RECORD_ID` int(11) NOT NULL DEFAULT '0' COMMENT '记录ID',
  `RECORD_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '记录名',
  `REMARK` varchar(64) DEFAULT NULL COMMENT '备注',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '操作者',
  `CREATED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_USER_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODULE_NAME` (`MODULE_NAME`) USING BTREE,
  KEY `INDEX_CREATED_TIME` (`CREATED_TIME`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='回收站表';

-- ----------------------------
-- Records of sm_recyclebin
-- ----------------------------
INSERT INTO sm_recyclebin VALUES ('1', 'dictionary', '347', 'ceshi(liu)', '字典删除', '1', '2014-08-18 17:59:53');
INSERT INTO sm_recyclebin VALUES ('22', 'lead', '3', 'awu(测试数据）', '删除线索', '1', '2014-08-20 10:19:40');
INSERT INTO sm_recyclebin VALUES ('23', 'lead', '3', 'awu(测试数据）', '删除线索', '1', '2014-08-20 10:19:46');
INSERT INTO sm_recyclebin VALUES ('24', 'lead', '3', 'awu(测试数据）', '删除线索', '1', '2014-08-20 10:27:35');
INSERT INTO sm_recyclebin VALUES ('25', 'lead', '3', 'awu(测试数据）', '删除线索', '1', '2014-08-20 10:38:57');
INSERT INTO sm_recyclebin VALUES ('26', 'lead', '3', 'awu(测试数据）', '删除线索', '1', '2014-08-20 10:39:03');
INSERT INTO sm_recyclebin VALUES ('27', 'lead', '5', 'luoxiaoli', '删除线索', '1', '2014-08-21 09:52:38');
INSERT INTO sm_recyclebin VALUES ('28', 'lead', '1', '中国人民银行丰台分行', '删除线索', '1', '2014-08-21 09:52:52');
INSERT INTO sm_recyclebin VALUES ('29', 'marketActivity', '11', '\'', '删除市场活动', '1', '2014-08-29 15:34:49');
INSERT INTO sm_recyclebin VALUES ('30', 'marketActivity', '1', '招商活动', '删除市场活动', '1', '2014-08-29 15:34:59');
INSERT INTO sm_recyclebin VALUES ('31', 'attachment', '2', '已完成项目.xls', '删除附件', '1', '2014-09-24 14:52:10');

-- ----------------------------
-- Table structure for `sm_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role`;
CREATE TABLE `sm_role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `CODE` varchar(32) DEFAULT NULL COMMENT '角色代码',
  `NAME` varchar(16) DEFAULT NULL COMMENT '角色名',
  `TYPE` int(11) NOT NULL DEFAULT '0' COMMENT '角色类型',
  `REMARK` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `IS_DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被删除',
  `IS_INITIALIZED` int(11) NOT NULL DEFAULT '0' COMMENT '是否是初始化数据',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL COMMENT '修改者',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_NAME` (`NAME`) USING BTREE,
  UNIQUE KEY `INDEX_CODE` (`CODE`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of sm_role
-- ----------------------------
INSERT INTO sm_role VALUES ('1', '1', '系统管理员', '1050101', '可进行系统所有操作', '0', '1', '1', '2014-06-19 13:49:31', '1', '2014-06-19 13:49:31');
INSERT INTO sm_role VALUES ('2', '2', '系统数据管理员', '1050101', '可查看系统所有数据', '0', '1', '1', '2014-06-19 13:49:31', '1', '2014-06-19 13:49:31');
INSERT INTO sm_role VALUES ('3', '3', '主管数据管理员', '1050101', '可查看所属组织及下级内数据', '0', '1', '1', '2014-06-19 13:49:31', '1', '2014-06-19 13:49:31');
INSERT INTO sm_role VALUES ('6', 'ORG_00001', '总裁', '1050101', '总裁', '0', '1', '1', '2014-07-16 17:26:02', '1', '2014-07-22 14:27:47');
INSERT INTO sm_role VALUES ('7', 'ORG_00002', '副总裁', '1050101', '副总裁', '0', '1', '1', '2014-07-16 17:26:10', '1', '2014-07-22 14:27:50');
INSERT INTO sm_role VALUES ('8', 'ORG_00003', '财务', '1050101', '财务', '0', '1', '1', '2014-07-16 17:26:10', '1', '2014-07-22 14:27:52');
INSERT INTO sm_role VALUES ('9', 'ORG_00004', '投资总监', '1050101', '投资总监', '0', '1', '1', '2014-07-16 17:27:07', '1', '2014-07-22 14:27:53');
INSERT INTO sm_role VALUES ('10', 'ORG_00005', '投资经理', '1050101', '投资经理', '0', '1', '1', '2014-07-16 17:28:34', '1', '2014-07-22 14:27:55');
INSERT INTO sm_role VALUES ('11', 'ORG_00006', '理财经理', '1050101', '理财经理', '0', '1', '1', '2014-07-16 17:28:40', '1', '2014-07-22 14:27:57');
INSERT INTO sm_role VALUES ('12', 'test', '订单审批流程测试角色', '1050101', '订单审批流程测试角色', '0', '1', '1', '2014-07-18 16:46:09', '1', '2014-07-18 16:46:09');

-- ----------------------------
-- Table structure for `sm_role_com`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role_com`;
CREATE TABLE `sm_role_com` (
  `ROLE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `COM_ID` int(11) NOT NULL DEFAULT '0' COMMENT '组件ID',
  PRIMARY KEY (`ROLE_ID`,`COM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色组件表';

-- ----------------------------
-- Records of sm_role_com
-- ----------------------------
INSERT INTO sm_role_com VALUES ('1', '8');
INSERT INTO sm_role_com VALUES ('1', '14');
INSERT INTO sm_role_com VALUES ('2', '8');
INSERT INTO sm_role_com VALUES ('2', '14');

-- ----------------------------
-- Table structure for `sm_role_func`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role_func`;
CREATE TABLE `sm_role_func` (
  `ROLE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `FUNC_ID` int(11) NOT NULL DEFAULT '0' COMMENT '功能ID',
  PRIMARY KEY (`ROLE_ID`,`FUNC_ID`),
  KEY `INDEX_ROLE_ID` (`ROLE_ID`) USING BTREE,
  KEY `INDEX_FUNC_ID` (`FUNC_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色功能表';

-- ----------------------------
-- Records of sm_role_func
-- ----------------------------
INSERT INTO sm_role_func VALUES ('1', '7');
INSERT INTO sm_role_func VALUES ('1', '8');
INSERT INTO sm_role_func VALUES ('1', '9');
INSERT INTO sm_role_func VALUES ('1', '10');
INSERT INTO sm_role_func VALUES ('1', '11');
INSERT INTO sm_role_func VALUES ('1', '13');
INSERT INTO sm_role_func VALUES ('1', '14');
INSERT INTO sm_role_func VALUES ('1', '15');
INSERT INTO sm_role_func VALUES ('1', '16');
INSERT INTO sm_role_func VALUES ('1', '17');
INSERT INTO sm_role_func VALUES ('1', '19');
INSERT INTO sm_role_func VALUES ('1', '20');
INSERT INTO sm_role_func VALUES ('1', '21');
INSERT INTO sm_role_func VALUES ('1', '22');
INSERT INTO sm_role_func VALUES ('1', '23');
INSERT INTO sm_role_func VALUES ('1', '24');
INSERT INTO sm_role_func VALUES ('1', '26');
INSERT INTO sm_role_func VALUES ('1', '27');
INSERT INTO sm_role_func VALUES ('1', '28');
INSERT INTO sm_role_func VALUES ('1', '29');
INSERT INTO sm_role_func VALUES ('1', '30');
INSERT INTO sm_role_func VALUES ('1', '31');
INSERT INTO sm_role_func VALUES ('1', '32');
INSERT INTO sm_role_func VALUES ('1', '33');
INSERT INTO sm_role_func VALUES ('1', '34');
INSERT INTO sm_role_func VALUES ('1', '35');
INSERT INTO sm_role_func VALUES ('1', '36');
INSERT INTO sm_role_func VALUES ('1', '37');
INSERT INTO sm_role_func VALUES ('1', '38');
INSERT INTO sm_role_func VALUES ('1', '39');
INSERT INTO sm_role_func VALUES ('1', '40');
INSERT INTO sm_role_func VALUES ('1', '41');
INSERT INTO sm_role_func VALUES ('1', '42');
INSERT INTO sm_role_func VALUES ('1', '43');
INSERT INTO sm_role_func VALUES ('1', '44');
INSERT INTO sm_role_func VALUES ('1', '45');
INSERT INTO sm_role_func VALUES ('1', '46');
INSERT INTO sm_role_func VALUES ('1', '47');
INSERT INTO sm_role_func VALUES ('1', '48');
INSERT INTO sm_role_func VALUES ('1', '49');
INSERT INTO sm_role_func VALUES ('1', '50');
INSERT INTO sm_role_func VALUES ('1', '52');
INSERT INTO sm_role_func VALUES ('1', '53');
INSERT INTO sm_role_func VALUES ('1', '54');
INSERT INTO sm_role_func VALUES ('1', '55');
INSERT INTO sm_role_func VALUES ('1', '56');
INSERT INTO sm_role_func VALUES ('1', '57');
INSERT INTO sm_role_func VALUES ('1', '58');
INSERT INTO sm_role_func VALUES ('1', '59');
INSERT INTO sm_role_func VALUES ('1', '60');
INSERT INTO sm_role_func VALUES ('1', '61');
INSERT INTO sm_role_func VALUES ('1', '62');
INSERT INTO sm_role_func VALUES ('1', '63');
INSERT INTO sm_role_func VALUES ('1', '64');
INSERT INTO sm_role_func VALUES ('1', '65');
INSERT INTO sm_role_func VALUES ('1', '66');
INSERT INTO sm_role_func VALUES ('1', '67');
INSERT INTO sm_role_func VALUES ('1', '68');
INSERT INTO sm_role_func VALUES ('1', '69');
INSERT INTO sm_role_func VALUES ('1', '70');
INSERT INTO sm_role_func VALUES ('1', '71');
INSERT INTO sm_role_func VALUES ('1', '72');
INSERT INTO sm_role_func VALUES ('1', '73');
INSERT INTO sm_role_func VALUES ('1', '74');
INSERT INTO sm_role_func VALUES ('1', '75');
INSERT INTO sm_role_func VALUES ('1', '85');
INSERT INTO sm_role_func VALUES ('1', '86');
INSERT INTO sm_role_func VALUES ('1', '87');
INSERT INTO sm_role_func VALUES ('1', '88');
INSERT INTO sm_role_func VALUES ('1', '89');
INSERT INTO sm_role_func VALUES ('1', '90');
INSERT INTO sm_role_func VALUES ('1', '91');
INSERT INTO sm_role_func VALUES ('1', '92');
INSERT INTO sm_role_func VALUES ('1', '93');
INSERT INTO sm_role_func VALUES ('1', '94');
INSERT INTO sm_role_func VALUES ('1', '95');
INSERT INTO sm_role_func VALUES ('1', '97');
INSERT INTO sm_role_func VALUES ('1', '98');
INSERT INTO sm_role_func VALUES ('1', '99');
INSERT INTO sm_role_func VALUES ('1', '100');
INSERT INTO sm_role_func VALUES ('1', '106');
INSERT INTO sm_role_func VALUES ('1', '107');
INSERT INTO sm_role_func VALUES ('1', '108');
INSERT INTO sm_role_func VALUES ('1', '109');
INSERT INTO sm_role_func VALUES ('1', '110');
INSERT INTO sm_role_func VALUES ('1', '111');
INSERT INTO sm_role_func VALUES ('1', '112');
INSERT INTO sm_role_func VALUES ('1', '113');
INSERT INTO sm_role_func VALUES ('1', '114');
INSERT INTO sm_role_func VALUES ('1', '115');
INSERT INTO sm_role_func VALUES ('1', '116');
INSERT INTO sm_role_func VALUES ('1', '117');
INSERT INTO sm_role_func VALUES ('1', '120');
INSERT INTO sm_role_func VALUES ('1', '121');
INSERT INTO sm_role_func VALUES ('1', '122');
INSERT INTO sm_role_func VALUES ('1', '123');
INSERT INTO sm_role_func VALUES ('1', '124');
INSERT INTO sm_role_func VALUES ('1', '126');
INSERT INTO sm_role_func VALUES ('1', '127');
INSERT INTO sm_role_func VALUES ('1', '128');
INSERT INTO sm_role_func VALUES ('1', '129');
INSERT INTO sm_role_func VALUES ('1', '130');
INSERT INTO sm_role_func VALUES ('1', '131');
INSERT INTO sm_role_func VALUES ('1', '134');
INSERT INTO sm_role_func VALUES ('1', '135');
INSERT INTO sm_role_func VALUES ('1', '136');
INSERT INTO sm_role_func VALUES ('1', '137');
INSERT INTO sm_role_func VALUES ('1', '138');
INSERT INTO sm_role_func VALUES ('1', '139');
INSERT INTO sm_role_func VALUES ('1', '140');
INSERT INTO sm_role_func VALUES ('1', '141');
INSERT INTO sm_role_func VALUES ('1', '142');
INSERT INTO sm_role_func VALUES ('1', '145');
INSERT INTO sm_role_func VALUES ('1', '146');
INSERT INTO sm_role_func VALUES ('1', '147');
INSERT INTO sm_role_func VALUES ('1', '148');
INSERT INTO sm_role_func VALUES ('1', '149');
INSERT INTO sm_role_func VALUES ('1', '150');
INSERT INTO sm_role_func VALUES ('1', '151');
INSERT INTO sm_role_func VALUES ('1', '152');
INSERT INTO sm_role_func VALUES ('1', '153');
INSERT INTO sm_role_func VALUES ('1', '154');
INSERT INTO sm_role_func VALUES ('1', '155');
INSERT INTO sm_role_func VALUES ('1', '156');
INSERT INTO sm_role_func VALUES ('1', '157');
INSERT INTO sm_role_func VALUES ('1', '158');
INSERT INTO sm_role_func VALUES ('1', '159');
INSERT INTO sm_role_func VALUES ('1', '160');
INSERT INTO sm_role_func VALUES ('1', '161');
INSERT INTO sm_role_func VALUES ('1', '162');
INSERT INTO sm_role_func VALUES ('1', '163');
INSERT INTO sm_role_func VALUES ('1', '164');
INSERT INTO sm_role_func VALUES ('1', '165');
INSERT INTO sm_role_func VALUES ('1', '166');
INSERT INTO sm_role_func VALUES ('1', '167');
INSERT INTO sm_role_func VALUES ('1', '168');
INSERT INTO sm_role_func VALUES ('1', '169');
INSERT INTO sm_role_func VALUES ('1', '170');
INSERT INTO sm_role_func VALUES ('1', '171');
INSERT INTO sm_role_func VALUES ('1', '172');
INSERT INTO sm_role_func VALUES ('1', '173');
INSERT INTO sm_role_func VALUES ('1', '174');
INSERT INTO sm_role_func VALUES ('1', '175');
INSERT INTO sm_role_func VALUES ('1', '176');
INSERT INTO sm_role_func VALUES ('1', '177');
INSERT INTO sm_role_func VALUES ('1', '178');
INSERT INTO sm_role_func VALUES ('1', '179');
INSERT INTO sm_role_func VALUES ('1', '180');
INSERT INTO sm_role_func VALUES ('1', '181');
INSERT INTO sm_role_func VALUES ('1', '182');
INSERT INTO sm_role_func VALUES ('1', '183');
INSERT INTO sm_role_func VALUES ('1', '184');
INSERT INTO sm_role_func VALUES ('1', '185');
INSERT INTO sm_role_func VALUES ('1', '186');
INSERT INTO sm_role_func VALUES ('1', '187');
INSERT INTO sm_role_func VALUES ('1', '188');
INSERT INTO sm_role_func VALUES ('1', '189');
INSERT INTO sm_role_func VALUES ('1', '190');
INSERT INTO sm_role_func VALUES ('1', '191');
INSERT INTO sm_role_func VALUES ('1', '194');
INSERT INTO sm_role_func VALUES ('1', '195');
INSERT INTO sm_role_func VALUES ('1', '196');
INSERT INTO sm_role_func VALUES ('1', '197');
INSERT INTO sm_role_func VALUES ('1', '198');
INSERT INTO sm_role_func VALUES ('1', '199');
INSERT INTO sm_role_func VALUES ('1', '200');
INSERT INTO sm_role_func VALUES ('1', '202');
INSERT INTO sm_role_func VALUES ('1', '203');
INSERT INTO sm_role_func VALUES ('1', '204');
INSERT INTO sm_role_func VALUES ('1', '206');
INSERT INTO sm_role_func VALUES ('1', '207');
INSERT INTO sm_role_func VALUES ('1', '208');
INSERT INTO sm_role_func VALUES ('1', '209');
INSERT INTO sm_role_func VALUES ('1', '210');
INSERT INTO sm_role_func VALUES ('1', '211');
INSERT INTO sm_role_func VALUES ('1', '212');
INSERT INTO sm_role_func VALUES ('1', '213');
INSERT INTO sm_role_func VALUES ('1', '214');
INSERT INTO sm_role_func VALUES ('1', '215');
INSERT INTO sm_role_func VALUES ('1', '216');
INSERT INTO sm_role_func VALUES ('1', '222');
INSERT INTO sm_role_func VALUES ('1', '223');
INSERT INTO sm_role_func VALUES ('1', '224');
INSERT INTO sm_role_func VALUES ('1', '225');
INSERT INTO sm_role_func VALUES ('1', '226');
INSERT INTO sm_role_func VALUES ('1', '227');
INSERT INTO sm_role_func VALUES ('1', '228');
INSERT INTO sm_role_func VALUES ('1', '229');
INSERT INTO sm_role_func VALUES ('1', '230');
INSERT INTO sm_role_func VALUES ('1', '231');
INSERT INTO sm_role_func VALUES ('1', '232');
INSERT INTO sm_role_func VALUES ('1', '234');
INSERT INTO sm_role_func VALUES ('1', '236');
INSERT INTO sm_role_func VALUES ('1', '237');
INSERT INTO sm_role_func VALUES ('1', '238');
INSERT INTO sm_role_func VALUES ('1', '239');
INSERT INTO sm_role_func VALUES ('1', '305');
INSERT INTO sm_role_func VALUES ('1', '306');
INSERT INTO sm_role_func VALUES ('1', '307');
INSERT INTO sm_role_func VALUES ('1', '309');
INSERT INTO sm_role_func VALUES ('1', '310');
INSERT INTO sm_role_func VALUES ('1', '311');
INSERT INTO sm_role_func VALUES ('1', '312');
INSERT INTO sm_role_func VALUES ('1', '313');
INSERT INTO sm_role_func VALUES ('1', '314');
INSERT INTO sm_role_func VALUES ('1', '315');
INSERT INTO sm_role_func VALUES ('1', '316');
INSERT INTO sm_role_func VALUES ('1', '318');
INSERT INTO sm_role_func VALUES ('1', '319');
INSERT INTO sm_role_func VALUES ('1', '320');
INSERT INTO sm_role_func VALUES ('1', '321');
INSERT INTO sm_role_func VALUES ('1', '322');
INSERT INTO sm_role_func VALUES ('1', '323');
INSERT INTO sm_role_func VALUES ('1', '324');
INSERT INTO sm_role_func VALUES ('1', '325');
INSERT INTO sm_role_func VALUES ('1', '326');
INSERT INTO sm_role_func VALUES ('1', '327');
INSERT INTO sm_role_func VALUES ('1', '328');
INSERT INTO sm_role_func VALUES ('1', '329');
INSERT INTO sm_role_func VALUES ('2', '7');
INSERT INTO sm_role_func VALUES ('2', '19');
INSERT INTO sm_role_func VALUES ('2', '20');
INSERT INTO sm_role_func VALUES ('2', '26');
INSERT INTO sm_role_func VALUES ('2', '35');
INSERT INTO sm_role_func VALUES ('2', '39');
INSERT INTO sm_role_func VALUES ('2', '45');
INSERT INTO sm_role_func VALUES ('2', '57');
INSERT INTO sm_role_func VALUES ('2', '59');
INSERT INTO sm_role_func VALUES ('2', '68');
INSERT INTO sm_role_func VALUES ('2', '70');
INSERT INTO sm_role_func VALUES ('2', '74');
INSERT INTO sm_role_func VALUES ('2', '89');
INSERT INTO sm_role_func VALUES ('2', '91');
INSERT INTO sm_role_func VALUES ('2', '95');
INSERT INTO sm_role_func VALUES ('2', '98');
INSERT INTO sm_role_func VALUES ('2', '106');
INSERT INTO sm_role_func VALUES ('2', '108');
INSERT INTO sm_role_func VALUES ('2', '111');
INSERT INTO sm_role_func VALUES ('2', '113');
INSERT INTO sm_role_func VALUES ('2', '117');
INSERT INTO sm_role_func VALUES ('2', '120');
INSERT INTO sm_role_func VALUES ('2', '122');
INSERT INTO sm_role_func VALUES ('2', '126');
INSERT INTO sm_role_func VALUES ('2', '128');
INSERT INTO sm_role_func VALUES ('2', '134');
INSERT INTO sm_role_func VALUES ('2', '135');
INSERT INTO sm_role_func VALUES ('2', '136');
INSERT INTO sm_role_func VALUES ('2', '137');
INSERT INTO sm_role_func VALUES ('2', '138');
INSERT INTO sm_role_func VALUES ('2', '139');
INSERT INTO sm_role_func VALUES ('2', '140');
INSERT INTO sm_role_func VALUES ('2', '141');
INSERT INTO sm_role_func VALUES ('2', '142');
INSERT INTO sm_role_func VALUES ('2', '145');
INSERT INTO sm_role_func VALUES ('2', '146');
INSERT INTO sm_role_func VALUES ('2', '147');
INSERT INTO sm_role_func VALUES ('2', '148');
INSERT INTO sm_role_func VALUES ('2', '149');
INSERT INTO sm_role_func VALUES ('2', '150');
INSERT INTO sm_role_func VALUES ('2', '151');
INSERT INTO sm_role_func VALUES ('2', '152');
INSERT INTO sm_role_func VALUES ('2', '153');
INSERT INTO sm_role_func VALUES ('2', '154');
INSERT INTO sm_role_func VALUES ('2', '155');
INSERT INTO sm_role_func VALUES ('2', '156');
INSERT INTO sm_role_func VALUES ('2', '157');
INSERT INTO sm_role_func VALUES ('2', '158');
INSERT INTO sm_role_func VALUES ('2', '159');
INSERT INTO sm_role_func VALUES ('2', '160');
INSERT INTO sm_role_func VALUES ('2', '161');
INSERT INTO sm_role_func VALUES ('2', '162');
INSERT INTO sm_role_func VALUES ('2', '163');
INSERT INTO sm_role_func VALUES ('2', '164');
INSERT INTO sm_role_func VALUES ('2', '165');
INSERT INTO sm_role_func VALUES ('2', '166');
INSERT INTO sm_role_func VALUES ('2', '167');
INSERT INTO sm_role_func VALUES ('2', '168');
INSERT INTO sm_role_func VALUES ('2', '169');
INSERT INTO sm_role_func VALUES ('2', '170');
INSERT INTO sm_role_func VALUES ('2', '171');
INSERT INTO sm_role_func VALUES ('2', '172');
INSERT INTO sm_role_func VALUES ('2', '173');
INSERT INTO sm_role_func VALUES ('2', '174');
INSERT INTO sm_role_func VALUES ('2', '175');
INSERT INTO sm_role_func VALUES ('2', '176');
INSERT INTO sm_role_func VALUES ('2', '177');
INSERT INTO sm_role_func VALUES ('2', '179');
INSERT INTO sm_role_func VALUES ('2', '182');
INSERT INTO sm_role_func VALUES ('2', '183');
INSERT INTO sm_role_func VALUES ('2', '186');
INSERT INTO sm_role_func VALUES ('2', '188');
INSERT INTO sm_role_func VALUES ('2', '191');
INSERT INTO sm_role_func VALUES ('2', '196');
INSERT INTO sm_role_func VALUES ('2', '214');
INSERT INTO sm_role_func VALUES ('2', '215');
INSERT INTO sm_role_func VALUES ('2', '222');
INSERT INTO sm_role_func VALUES ('2', '224');
INSERT INTO sm_role_func VALUES ('2', '228');
INSERT INTO sm_role_func VALUES ('2', '230');
INSERT INTO sm_role_func VALUES ('2', '234');
INSERT INTO sm_role_func VALUES ('2', '318');
INSERT INTO sm_role_func VALUES ('2', '323');
INSERT INTO sm_role_func VALUES ('6', '7');
INSERT INTO sm_role_func VALUES ('6', '8');
INSERT INTO sm_role_func VALUES ('6', '9');
INSERT INTO sm_role_func VALUES ('6', '10');
INSERT INTO sm_role_func VALUES ('6', '11');
INSERT INTO sm_role_func VALUES ('6', '13');
INSERT INTO sm_role_func VALUES ('6', '14');
INSERT INTO sm_role_func VALUES ('6', '15');
INSERT INTO sm_role_func VALUES ('6', '16');
INSERT INTO sm_role_func VALUES ('6', '17');
INSERT INTO sm_role_func VALUES ('6', '19');
INSERT INTO sm_role_func VALUES ('6', '20');
INSERT INTO sm_role_func VALUES ('6', '21');
INSERT INTO sm_role_func VALUES ('6', '22');
INSERT INTO sm_role_func VALUES ('6', '23');
INSERT INTO sm_role_func VALUES ('6', '24');
INSERT INTO sm_role_func VALUES ('6', '26');
INSERT INTO sm_role_func VALUES ('6', '27');
INSERT INTO sm_role_func VALUES ('6', '28');
INSERT INTO sm_role_func VALUES ('6', '29');
INSERT INTO sm_role_func VALUES ('6', '30');
INSERT INTO sm_role_func VALUES ('6', '31');
INSERT INTO sm_role_func VALUES ('6', '32');
INSERT INTO sm_role_func VALUES ('6', '33');
INSERT INTO sm_role_func VALUES ('6', '34');
INSERT INTO sm_role_func VALUES ('6', '35');
INSERT INTO sm_role_func VALUES ('6', '36');
INSERT INTO sm_role_func VALUES ('6', '37');
INSERT INTO sm_role_func VALUES ('6', '38');
INSERT INTO sm_role_func VALUES ('6', '39');
INSERT INTO sm_role_func VALUES ('6', '40');
INSERT INTO sm_role_func VALUES ('6', '41');
INSERT INTO sm_role_func VALUES ('6', '42');
INSERT INTO sm_role_func VALUES ('6', '43');
INSERT INTO sm_role_func VALUES ('6', '44');
INSERT INTO sm_role_func VALUES ('6', '45');
INSERT INTO sm_role_func VALUES ('6', '46');
INSERT INTO sm_role_func VALUES ('6', '47');
INSERT INTO sm_role_func VALUES ('6', '48');
INSERT INTO sm_role_func VALUES ('6', '49');
INSERT INTO sm_role_func VALUES ('6', '50');
INSERT INTO sm_role_func VALUES ('6', '52');
INSERT INTO sm_role_func VALUES ('6', '53');
INSERT INTO sm_role_func VALUES ('6', '54');
INSERT INTO sm_role_func VALUES ('6', '55');
INSERT INTO sm_role_func VALUES ('6', '56');
INSERT INTO sm_role_func VALUES ('6', '57');
INSERT INTO sm_role_func VALUES ('6', '58');
INSERT INTO sm_role_func VALUES ('6', '59');
INSERT INTO sm_role_func VALUES ('6', '60');
INSERT INTO sm_role_func VALUES ('6', '61');
INSERT INTO sm_role_func VALUES ('6', '62');
INSERT INTO sm_role_func VALUES ('6', '63');
INSERT INTO sm_role_func VALUES ('6', '64');
INSERT INTO sm_role_func VALUES ('6', '65');
INSERT INTO sm_role_func VALUES ('6', '66');
INSERT INTO sm_role_func VALUES ('6', '67');
INSERT INTO sm_role_func VALUES ('6', '68');
INSERT INTO sm_role_func VALUES ('6', '69');
INSERT INTO sm_role_func VALUES ('6', '70');
INSERT INTO sm_role_func VALUES ('6', '71');
INSERT INTO sm_role_func VALUES ('6', '72');
INSERT INTO sm_role_func VALUES ('6', '73');
INSERT INTO sm_role_func VALUES ('6', '74');
INSERT INTO sm_role_func VALUES ('6', '75');
INSERT INTO sm_role_func VALUES ('6', '85');
INSERT INTO sm_role_func VALUES ('6', '86');
INSERT INTO sm_role_func VALUES ('6', '87');
INSERT INTO sm_role_func VALUES ('6', '88');
INSERT INTO sm_role_func VALUES ('6', '89');
INSERT INTO sm_role_func VALUES ('6', '90');
INSERT INTO sm_role_func VALUES ('6', '91');
INSERT INTO sm_role_func VALUES ('6', '92');
INSERT INTO sm_role_func VALUES ('6', '93');
INSERT INTO sm_role_func VALUES ('6', '94');
INSERT INTO sm_role_func VALUES ('6', '95');
INSERT INTO sm_role_func VALUES ('6', '97');
INSERT INTO sm_role_func VALUES ('6', '98');
INSERT INTO sm_role_func VALUES ('6', '99');
INSERT INTO sm_role_func VALUES ('6', '100');
INSERT INTO sm_role_func VALUES ('6', '106');
INSERT INTO sm_role_func VALUES ('6', '107');
INSERT INTO sm_role_func VALUES ('6', '108');
INSERT INTO sm_role_func VALUES ('6', '109');
INSERT INTO sm_role_func VALUES ('6', '110');
INSERT INTO sm_role_func VALUES ('6', '111');
INSERT INTO sm_role_func VALUES ('6', '112');
INSERT INTO sm_role_func VALUES ('6', '113');
INSERT INTO sm_role_func VALUES ('6', '114');
INSERT INTO sm_role_func VALUES ('6', '115');
INSERT INTO sm_role_func VALUES ('6', '116');
INSERT INTO sm_role_func VALUES ('6', '117');
INSERT INTO sm_role_func VALUES ('6', '120');
INSERT INTO sm_role_func VALUES ('6', '121');
INSERT INTO sm_role_func VALUES ('6', '122');
INSERT INTO sm_role_func VALUES ('6', '123');
INSERT INTO sm_role_func VALUES ('6', '124');
INSERT INTO sm_role_func VALUES ('6', '126');
INSERT INTO sm_role_func VALUES ('6', '127');
INSERT INTO sm_role_func VALUES ('6', '128');
INSERT INTO sm_role_func VALUES ('6', '129');
INSERT INTO sm_role_func VALUES ('6', '130');
INSERT INTO sm_role_func VALUES ('6', '131');
INSERT INTO sm_role_func VALUES ('6', '134');
INSERT INTO sm_role_func VALUES ('6', '135');
INSERT INTO sm_role_func VALUES ('6', '136');
INSERT INTO sm_role_func VALUES ('6', '137');
INSERT INTO sm_role_func VALUES ('6', '138');
INSERT INTO sm_role_func VALUES ('6', '139');
INSERT INTO sm_role_func VALUES ('6', '140');
INSERT INTO sm_role_func VALUES ('6', '141');
INSERT INTO sm_role_func VALUES ('6', '142');
INSERT INTO sm_role_func VALUES ('6', '145');
INSERT INTO sm_role_func VALUES ('6', '146');
INSERT INTO sm_role_func VALUES ('6', '147');
INSERT INTO sm_role_func VALUES ('6', '148');
INSERT INTO sm_role_func VALUES ('6', '149');
INSERT INTO sm_role_func VALUES ('6', '150');
INSERT INTO sm_role_func VALUES ('6', '151');
INSERT INTO sm_role_func VALUES ('6', '152');
INSERT INTO sm_role_func VALUES ('6', '153');
INSERT INTO sm_role_func VALUES ('6', '154');
INSERT INTO sm_role_func VALUES ('6', '155');
INSERT INTO sm_role_func VALUES ('6', '156');
INSERT INTO sm_role_func VALUES ('6', '157');
INSERT INTO sm_role_func VALUES ('6', '158');
INSERT INTO sm_role_func VALUES ('6', '159');
INSERT INTO sm_role_func VALUES ('6', '160');
INSERT INTO sm_role_func VALUES ('6', '161');
INSERT INTO sm_role_func VALUES ('6', '162');
INSERT INTO sm_role_func VALUES ('6', '163');
INSERT INTO sm_role_func VALUES ('6', '164');
INSERT INTO sm_role_func VALUES ('6', '165');
INSERT INTO sm_role_func VALUES ('6', '166');
INSERT INTO sm_role_func VALUES ('6', '167');
INSERT INTO sm_role_func VALUES ('6', '168');
INSERT INTO sm_role_func VALUES ('6', '169');
INSERT INTO sm_role_func VALUES ('6', '170');
INSERT INTO sm_role_func VALUES ('6', '171');
INSERT INTO sm_role_func VALUES ('6', '172');
INSERT INTO sm_role_func VALUES ('6', '173');
INSERT INTO sm_role_func VALUES ('6', '174');
INSERT INTO sm_role_func VALUES ('6', '175');
INSERT INTO sm_role_func VALUES ('6', '176');
INSERT INTO sm_role_func VALUES ('6', '177');
INSERT INTO sm_role_func VALUES ('6', '178');
INSERT INTO sm_role_func VALUES ('6', '179');
INSERT INTO sm_role_func VALUES ('6', '180');
INSERT INTO sm_role_func VALUES ('6', '181');
INSERT INTO sm_role_func VALUES ('6', '182');
INSERT INTO sm_role_func VALUES ('6', '183');
INSERT INTO sm_role_func VALUES ('6', '184');
INSERT INTO sm_role_func VALUES ('6', '185');
INSERT INTO sm_role_func VALUES ('6', '186');
INSERT INTO sm_role_func VALUES ('6', '187');
INSERT INTO sm_role_func VALUES ('6', '188');
INSERT INTO sm_role_func VALUES ('6', '189');
INSERT INTO sm_role_func VALUES ('6', '190');
INSERT INTO sm_role_func VALUES ('6', '191');
INSERT INTO sm_role_func VALUES ('6', '194');
INSERT INTO sm_role_func VALUES ('6', '195');
INSERT INTO sm_role_func VALUES ('6', '196');
INSERT INTO sm_role_func VALUES ('6', '197');
INSERT INTO sm_role_func VALUES ('6', '198');
INSERT INTO sm_role_func VALUES ('6', '199');
INSERT INTO sm_role_func VALUES ('6', '200');
INSERT INTO sm_role_func VALUES ('6', '202');
INSERT INTO sm_role_func VALUES ('6', '203');
INSERT INTO sm_role_func VALUES ('6', '204');
INSERT INTO sm_role_func VALUES ('6', '206');
INSERT INTO sm_role_func VALUES ('6', '207');
INSERT INTO sm_role_func VALUES ('6', '208');
INSERT INTO sm_role_func VALUES ('6', '209');
INSERT INTO sm_role_func VALUES ('6', '210');
INSERT INTO sm_role_func VALUES ('6', '211');
INSERT INTO sm_role_func VALUES ('6', '212');
INSERT INTO sm_role_func VALUES ('6', '213');
INSERT INTO sm_role_func VALUES ('6', '214');
INSERT INTO sm_role_func VALUES ('6', '238');
INSERT INTO sm_role_func VALUES ('6', '239');
INSERT INTO sm_role_func VALUES ('6', '305');
INSERT INTO sm_role_func VALUES ('6', '306');
INSERT INTO sm_role_func VALUES ('6', '307');
INSERT INTO sm_role_func VALUES ('6', '309');
INSERT INTO sm_role_func VALUES ('6', '312');
INSERT INTO sm_role_func VALUES ('6', '313');
INSERT INTO sm_role_func VALUES ('6', '314');
INSERT INTO sm_role_func VALUES ('6', '315');
INSERT INTO sm_role_func VALUES ('6', '316');
INSERT INTO sm_role_func VALUES ('6', '318');
INSERT INTO sm_role_func VALUES ('6', '319');
INSERT INTO sm_role_func VALUES ('6', '320');
INSERT INTO sm_role_func VALUES ('6', '321');
INSERT INTO sm_role_func VALUES ('6', '322');
INSERT INTO sm_role_func VALUES ('6', '323');
INSERT INTO sm_role_func VALUES ('6', '324');
INSERT INTO sm_role_func VALUES ('6', '325');
INSERT INTO sm_role_func VALUES ('6', '326');
INSERT INTO sm_role_func VALUES ('6', '327');
INSERT INTO sm_role_func VALUES ('6', '328');
INSERT INTO sm_role_func VALUES ('6', '329');
INSERT INTO sm_role_func VALUES ('7', '7');
INSERT INTO sm_role_func VALUES ('7', '8');
INSERT INTO sm_role_func VALUES ('7', '9');
INSERT INTO sm_role_func VALUES ('7', '10');
INSERT INTO sm_role_func VALUES ('7', '11');
INSERT INTO sm_role_func VALUES ('7', '13');
INSERT INTO sm_role_func VALUES ('7', '14');
INSERT INTO sm_role_func VALUES ('7', '15');
INSERT INTO sm_role_func VALUES ('7', '16');
INSERT INTO sm_role_func VALUES ('7', '17');
INSERT INTO sm_role_func VALUES ('7', '19');
INSERT INTO sm_role_func VALUES ('7', '20');
INSERT INTO sm_role_func VALUES ('7', '21');
INSERT INTO sm_role_func VALUES ('7', '22');
INSERT INTO sm_role_func VALUES ('7', '23');
INSERT INTO sm_role_func VALUES ('7', '24');
INSERT INTO sm_role_func VALUES ('7', '26');
INSERT INTO sm_role_func VALUES ('7', '27');
INSERT INTO sm_role_func VALUES ('7', '28');
INSERT INTO sm_role_func VALUES ('7', '29');
INSERT INTO sm_role_func VALUES ('7', '30');
INSERT INTO sm_role_func VALUES ('7', '31');
INSERT INTO sm_role_func VALUES ('7', '32');
INSERT INTO sm_role_func VALUES ('7', '33');
INSERT INTO sm_role_func VALUES ('7', '34');
INSERT INTO sm_role_func VALUES ('7', '35');
INSERT INTO sm_role_func VALUES ('7', '36');
INSERT INTO sm_role_func VALUES ('7', '37');
INSERT INTO sm_role_func VALUES ('7', '38');
INSERT INTO sm_role_func VALUES ('7', '39');
INSERT INTO sm_role_func VALUES ('7', '40');
INSERT INTO sm_role_func VALUES ('7', '41');
INSERT INTO sm_role_func VALUES ('7', '42');
INSERT INTO sm_role_func VALUES ('7', '43');
INSERT INTO sm_role_func VALUES ('7', '44');
INSERT INTO sm_role_func VALUES ('7', '45');
INSERT INTO sm_role_func VALUES ('7', '46');
INSERT INTO sm_role_func VALUES ('7', '47');
INSERT INTO sm_role_func VALUES ('7', '48');
INSERT INTO sm_role_func VALUES ('7', '49');
INSERT INTO sm_role_func VALUES ('7', '50');
INSERT INTO sm_role_func VALUES ('7', '52');
INSERT INTO sm_role_func VALUES ('7', '53');
INSERT INTO sm_role_func VALUES ('7', '54');
INSERT INTO sm_role_func VALUES ('7', '55');
INSERT INTO sm_role_func VALUES ('7', '56');
INSERT INTO sm_role_func VALUES ('7', '57');
INSERT INTO sm_role_func VALUES ('7', '58');
INSERT INTO sm_role_func VALUES ('7', '59');
INSERT INTO sm_role_func VALUES ('7', '60');
INSERT INTO sm_role_func VALUES ('7', '61');
INSERT INTO sm_role_func VALUES ('7', '62');
INSERT INTO sm_role_func VALUES ('7', '63');
INSERT INTO sm_role_func VALUES ('7', '64');
INSERT INTO sm_role_func VALUES ('7', '65');
INSERT INTO sm_role_func VALUES ('7', '66');
INSERT INTO sm_role_func VALUES ('7', '67');
INSERT INTO sm_role_func VALUES ('7', '68');
INSERT INTO sm_role_func VALUES ('7', '69');
INSERT INTO sm_role_func VALUES ('7', '70');
INSERT INTO sm_role_func VALUES ('7', '71');
INSERT INTO sm_role_func VALUES ('7', '72');
INSERT INTO sm_role_func VALUES ('7', '73');
INSERT INTO sm_role_func VALUES ('7', '74');
INSERT INTO sm_role_func VALUES ('7', '75');
INSERT INTO sm_role_func VALUES ('7', '85');
INSERT INTO sm_role_func VALUES ('7', '86');
INSERT INTO sm_role_func VALUES ('7', '87');
INSERT INTO sm_role_func VALUES ('7', '88');
INSERT INTO sm_role_func VALUES ('7', '89');
INSERT INTO sm_role_func VALUES ('7', '90');
INSERT INTO sm_role_func VALUES ('7', '91');
INSERT INTO sm_role_func VALUES ('7', '92');
INSERT INTO sm_role_func VALUES ('7', '93');
INSERT INTO sm_role_func VALUES ('7', '94');
INSERT INTO sm_role_func VALUES ('7', '95');
INSERT INTO sm_role_func VALUES ('7', '97');
INSERT INTO sm_role_func VALUES ('7', '98');
INSERT INTO sm_role_func VALUES ('7', '99');
INSERT INTO sm_role_func VALUES ('7', '100');
INSERT INTO sm_role_func VALUES ('7', '106');
INSERT INTO sm_role_func VALUES ('7', '107');
INSERT INTO sm_role_func VALUES ('7', '108');
INSERT INTO sm_role_func VALUES ('7', '109');
INSERT INTO sm_role_func VALUES ('7', '110');
INSERT INTO sm_role_func VALUES ('7', '111');
INSERT INTO sm_role_func VALUES ('7', '112');
INSERT INTO sm_role_func VALUES ('7', '113');
INSERT INTO sm_role_func VALUES ('7', '114');
INSERT INTO sm_role_func VALUES ('7', '115');
INSERT INTO sm_role_func VALUES ('7', '116');
INSERT INTO sm_role_func VALUES ('7', '117');
INSERT INTO sm_role_func VALUES ('7', '120');
INSERT INTO sm_role_func VALUES ('7', '121');
INSERT INTO sm_role_func VALUES ('7', '122');
INSERT INTO sm_role_func VALUES ('7', '123');
INSERT INTO sm_role_func VALUES ('7', '124');
INSERT INTO sm_role_func VALUES ('7', '126');
INSERT INTO sm_role_func VALUES ('7', '127');
INSERT INTO sm_role_func VALUES ('7', '128');
INSERT INTO sm_role_func VALUES ('7', '129');
INSERT INTO sm_role_func VALUES ('7', '130');
INSERT INTO sm_role_func VALUES ('7', '131');
INSERT INTO sm_role_func VALUES ('7', '134');
INSERT INTO sm_role_func VALUES ('7', '135');
INSERT INTO sm_role_func VALUES ('7', '136');
INSERT INTO sm_role_func VALUES ('7', '137');
INSERT INTO sm_role_func VALUES ('7', '138');
INSERT INTO sm_role_func VALUES ('7', '139');
INSERT INTO sm_role_func VALUES ('7', '140');
INSERT INTO sm_role_func VALUES ('7', '141');
INSERT INTO sm_role_func VALUES ('7', '142');
INSERT INTO sm_role_func VALUES ('7', '145');
INSERT INTO sm_role_func VALUES ('7', '146');
INSERT INTO sm_role_func VALUES ('7', '147');
INSERT INTO sm_role_func VALUES ('7', '148');
INSERT INTO sm_role_func VALUES ('7', '149');
INSERT INTO sm_role_func VALUES ('7', '150');
INSERT INTO sm_role_func VALUES ('7', '151');
INSERT INTO sm_role_func VALUES ('7', '152');
INSERT INTO sm_role_func VALUES ('7', '153');
INSERT INTO sm_role_func VALUES ('7', '154');
INSERT INTO sm_role_func VALUES ('7', '155');
INSERT INTO sm_role_func VALUES ('7', '156');
INSERT INTO sm_role_func VALUES ('7', '157');
INSERT INTO sm_role_func VALUES ('7', '158');
INSERT INTO sm_role_func VALUES ('7', '159');
INSERT INTO sm_role_func VALUES ('7', '160');
INSERT INTO sm_role_func VALUES ('7', '161');
INSERT INTO sm_role_func VALUES ('7', '162');
INSERT INTO sm_role_func VALUES ('7', '163');
INSERT INTO sm_role_func VALUES ('7', '164');
INSERT INTO sm_role_func VALUES ('7', '165');
INSERT INTO sm_role_func VALUES ('7', '166');
INSERT INTO sm_role_func VALUES ('7', '167');
INSERT INTO sm_role_func VALUES ('7', '168');
INSERT INTO sm_role_func VALUES ('7', '169');
INSERT INTO sm_role_func VALUES ('7', '170');
INSERT INTO sm_role_func VALUES ('7', '171');
INSERT INTO sm_role_func VALUES ('7', '172');
INSERT INTO sm_role_func VALUES ('7', '173');
INSERT INTO sm_role_func VALUES ('7', '174');
INSERT INTO sm_role_func VALUES ('7', '175');
INSERT INTO sm_role_func VALUES ('7', '176');
INSERT INTO sm_role_func VALUES ('7', '177');
INSERT INTO sm_role_func VALUES ('7', '178');
INSERT INTO sm_role_func VALUES ('7', '179');
INSERT INTO sm_role_func VALUES ('7', '180');
INSERT INTO sm_role_func VALUES ('7', '181');
INSERT INTO sm_role_func VALUES ('7', '182');
INSERT INTO sm_role_func VALUES ('7', '183');
INSERT INTO sm_role_func VALUES ('7', '184');
INSERT INTO sm_role_func VALUES ('7', '185');
INSERT INTO sm_role_func VALUES ('7', '186');
INSERT INTO sm_role_func VALUES ('7', '187');
INSERT INTO sm_role_func VALUES ('7', '188');
INSERT INTO sm_role_func VALUES ('7', '189');
INSERT INTO sm_role_func VALUES ('7', '190');
INSERT INTO sm_role_func VALUES ('7', '194');
INSERT INTO sm_role_func VALUES ('7', '195');
INSERT INTO sm_role_func VALUES ('7', '196');
INSERT INTO sm_role_func VALUES ('7', '197');
INSERT INTO sm_role_func VALUES ('7', '198');
INSERT INTO sm_role_func VALUES ('7', '199');
INSERT INTO sm_role_func VALUES ('7', '200');
INSERT INTO sm_role_func VALUES ('7', '202');
INSERT INTO sm_role_func VALUES ('7', '203');
INSERT INTO sm_role_func VALUES ('7', '204');
INSERT INTO sm_role_func VALUES ('7', '206');
INSERT INTO sm_role_func VALUES ('7', '207');
INSERT INTO sm_role_func VALUES ('7', '208');
INSERT INTO sm_role_func VALUES ('7', '209');
INSERT INTO sm_role_func VALUES ('7', '210');
INSERT INTO sm_role_func VALUES ('7', '211');
INSERT INTO sm_role_func VALUES ('7', '212');
INSERT INTO sm_role_func VALUES ('7', '213');
INSERT INTO sm_role_func VALUES ('7', '214');
INSERT INTO sm_role_func VALUES ('7', '215');
INSERT INTO sm_role_func VALUES ('7', '216');
INSERT INTO sm_role_func VALUES ('7', '222');
INSERT INTO sm_role_func VALUES ('7', '223');
INSERT INTO sm_role_func VALUES ('7', '224');
INSERT INTO sm_role_func VALUES ('7', '225');
INSERT INTO sm_role_func VALUES ('7', '226');
INSERT INTO sm_role_func VALUES ('7', '227');
INSERT INTO sm_role_func VALUES ('7', '228');
INSERT INTO sm_role_func VALUES ('7', '229');
INSERT INTO sm_role_func VALUES ('7', '230');
INSERT INTO sm_role_func VALUES ('7', '231');
INSERT INTO sm_role_func VALUES ('7', '232');
INSERT INTO sm_role_func VALUES ('7', '234');
INSERT INTO sm_role_func VALUES ('7', '236');
INSERT INTO sm_role_func VALUES ('7', '237');
INSERT INTO sm_role_func VALUES ('7', '238');
INSERT INTO sm_role_func VALUES ('7', '239');
INSERT INTO sm_role_func VALUES ('7', '305');
INSERT INTO sm_role_func VALUES ('7', '306');
INSERT INTO sm_role_func VALUES ('7', '307');
INSERT INTO sm_role_func VALUES ('7', '309');
INSERT INTO sm_role_func VALUES ('7', '310');
INSERT INTO sm_role_func VALUES ('7', '311');
INSERT INTO sm_role_func VALUES ('7', '312');
INSERT INTO sm_role_func VALUES ('7', '313');
INSERT INTO sm_role_func VALUES ('7', '314');
INSERT INTO sm_role_func VALUES ('7', '315');
INSERT INTO sm_role_func VALUES ('7', '316');
INSERT INTO sm_role_func VALUES ('7', '318');
INSERT INTO sm_role_func VALUES ('7', '319');
INSERT INTO sm_role_func VALUES ('7', '320');
INSERT INTO sm_role_func VALUES ('7', '321');
INSERT INTO sm_role_func VALUES ('7', '322');
INSERT INTO sm_role_func VALUES ('7', '323');
INSERT INTO sm_role_func VALUES ('7', '324');
INSERT INTO sm_role_func VALUES ('7', '325');
INSERT INTO sm_role_func VALUES ('7', '326');
INSERT INTO sm_role_func VALUES ('7', '327');
INSERT INTO sm_role_func VALUES ('7', '328');
INSERT INTO sm_role_func VALUES ('7', '329');
INSERT INTO sm_role_func VALUES ('8', '7');
INSERT INTO sm_role_func VALUES ('8', '8');
INSERT INTO sm_role_func VALUES ('8', '9');
INSERT INTO sm_role_func VALUES ('8', '10');
INSERT INTO sm_role_func VALUES ('8', '11');
INSERT INTO sm_role_func VALUES ('8', '13');
INSERT INTO sm_role_func VALUES ('8', '14');
INSERT INTO sm_role_func VALUES ('8', '15');
INSERT INTO sm_role_func VALUES ('8', '16');
INSERT INTO sm_role_func VALUES ('8', '17');
INSERT INTO sm_role_func VALUES ('8', '19');
INSERT INTO sm_role_func VALUES ('8', '20');
INSERT INTO sm_role_func VALUES ('8', '21');
INSERT INTO sm_role_func VALUES ('8', '22');
INSERT INTO sm_role_func VALUES ('8', '23');
INSERT INTO sm_role_func VALUES ('8', '24');
INSERT INTO sm_role_func VALUES ('8', '26');
INSERT INTO sm_role_func VALUES ('8', '27');
INSERT INTO sm_role_func VALUES ('8', '28');
INSERT INTO sm_role_func VALUES ('8', '29');
INSERT INTO sm_role_func VALUES ('8', '30');
INSERT INTO sm_role_func VALUES ('8', '31');
INSERT INTO sm_role_func VALUES ('8', '32');
INSERT INTO sm_role_func VALUES ('8', '33');
INSERT INTO sm_role_func VALUES ('8', '34');
INSERT INTO sm_role_func VALUES ('8', '35');
INSERT INTO sm_role_func VALUES ('8', '36');
INSERT INTO sm_role_func VALUES ('8', '37');
INSERT INTO sm_role_func VALUES ('8', '38');
INSERT INTO sm_role_func VALUES ('8', '39');
INSERT INTO sm_role_func VALUES ('8', '40');
INSERT INTO sm_role_func VALUES ('8', '41');
INSERT INTO sm_role_func VALUES ('8', '42');
INSERT INTO sm_role_func VALUES ('8', '43');
INSERT INTO sm_role_func VALUES ('8', '44');
INSERT INTO sm_role_func VALUES ('8', '45');
INSERT INTO sm_role_func VALUES ('8', '46');
INSERT INTO sm_role_func VALUES ('8', '47');
INSERT INTO sm_role_func VALUES ('8', '48');
INSERT INTO sm_role_func VALUES ('8', '49');
INSERT INTO sm_role_func VALUES ('8', '50');
INSERT INTO sm_role_func VALUES ('8', '52');
INSERT INTO sm_role_func VALUES ('8', '53');
INSERT INTO sm_role_func VALUES ('8', '54');
INSERT INTO sm_role_func VALUES ('8', '55');
INSERT INTO sm_role_func VALUES ('8', '56');
INSERT INTO sm_role_func VALUES ('8', '57');
INSERT INTO sm_role_func VALUES ('8', '58');
INSERT INTO sm_role_func VALUES ('8', '59');
INSERT INTO sm_role_func VALUES ('8', '60');
INSERT INTO sm_role_func VALUES ('8', '61');
INSERT INTO sm_role_func VALUES ('8', '62');
INSERT INTO sm_role_func VALUES ('8', '63');
INSERT INTO sm_role_func VALUES ('8', '64');
INSERT INTO sm_role_func VALUES ('8', '65');
INSERT INTO sm_role_func VALUES ('8', '66');
INSERT INTO sm_role_func VALUES ('8', '67');
INSERT INTO sm_role_func VALUES ('8', '68');
INSERT INTO sm_role_func VALUES ('8', '69');
INSERT INTO sm_role_func VALUES ('8', '70');
INSERT INTO sm_role_func VALUES ('8', '71');
INSERT INTO sm_role_func VALUES ('8', '72');
INSERT INTO sm_role_func VALUES ('8', '73');
INSERT INTO sm_role_func VALUES ('8', '74');
INSERT INTO sm_role_func VALUES ('8', '75');
INSERT INTO sm_role_func VALUES ('8', '85');
INSERT INTO sm_role_func VALUES ('8', '86');
INSERT INTO sm_role_func VALUES ('8', '87');
INSERT INTO sm_role_func VALUES ('8', '88');
INSERT INTO sm_role_func VALUES ('8', '117');
INSERT INTO sm_role_func VALUES ('8', '120');
INSERT INTO sm_role_func VALUES ('8', '121');
INSERT INTO sm_role_func VALUES ('8', '122');
INSERT INTO sm_role_func VALUES ('8', '123');
INSERT INTO sm_role_func VALUES ('8', '124');
INSERT INTO sm_role_func VALUES ('8', '126');
INSERT INTO sm_role_func VALUES ('8', '127');
INSERT INTO sm_role_func VALUES ('8', '128');
INSERT INTO sm_role_func VALUES ('8', '129');
INSERT INTO sm_role_func VALUES ('8', '130');
INSERT INTO sm_role_func VALUES ('8', '131');
INSERT INTO sm_role_func VALUES ('8', '134');
INSERT INTO sm_role_func VALUES ('8', '135');
INSERT INTO sm_role_func VALUES ('8', '136');
INSERT INTO sm_role_func VALUES ('8', '137');
INSERT INTO sm_role_func VALUES ('8', '138');
INSERT INTO sm_role_func VALUES ('8', '139');
INSERT INTO sm_role_func VALUES ('8', '140');
INSERT INTO sm_role_func VALUES ('8', '141');
INSERT INTO sm_role_func VALUES ('8', '142');
INSERT INTO sm_role_func VALUES ('8', '145');
INSERT INTO sm_role_func VALUES ('8', '146');
INSERT INTO sm_role_func VALUES ('8', '147');
INSERT INTO sm_role_func VALUES ('8', '148');
INSERT INTO sm_role_func VALUES ('8', '149');
INSERT INTO sm_role_func VALUES ('8', '150');
INSERT INTO sm_role_func VALUES ('8', '151');
INSERT INTO sm_role_func VALUES ('8', '152');
INSERT INTO sm_role_func VALUES ('8', '153');
INSERT INTO sm_role_func VALUES ('8', '154');
INSERT INTO sm_role_func VALUES ('8', '155');
INSERT INTO sm_role_func VALUES ('8', '156');
INSERT INTO sm_role_func VALUES ('8', '157');
INSERT INTO sm_role_func VALUES ('8', '158');
INSERT INTO sm_role_func VALUES ('8', '159');
INSERT INTO sm_role_func VALUES ('8', '160');
INSERT INTO sm_role_func VALUES ('8', '161');
INSERT INTO sm_role_func VALUES ('8', '162');
INSERT INTO sm_role_func VALUES ('8', '163');
INSERT INTO sm_role_func VALUES ('8', '164');
INSERT INTO sm_role_func VALUES ('8', '165');
INSERT INTO sm_role_func VALUES ('8', '166');
INSERT INTO sm_role_func VALUES ('8', '167');
INSERT INTO sm_role_func VALUES ('8', '168');
INSERT INTO sm_role_func VALUES ('8', '169');
INSERT INTO sm_role_func VALUES ('8', '177');
INSERT INTO sm_role_func VALUES ('8', '178');
INSERT INTO sm_role_func VALUES ('8', '179');
INSERT INTO sm_role_func VALUES ('8', '180');
INSERT INTO sm_role_func VALUES ('8', '181');
INSERT INTO sm_role_func VALUES ('8', '182');
INSERT INTO sm_role_func VALUES ('8', '183');
INSERT INTO sm_role_func VALUES ('8', '184');
INSERT INTO sm_role_func VALUES ('8', '185');
INSERT INTO sm_role_func VALUES ('8', '186');
INSERT INTO sm_role_func VALUES ('8', '187');
INSERT INTO sm_role_func VALUES ('8', '188');
INSERT INTO sm_role_func VALUES ('8', '189');
INSERT INTO sm_role_func VALUES ('8', '190');
INSERT INTO sm_role_func VALUES ('8', '191');
INSERT INTO sm_role_func VALUES ('8', '194');
INSERT INTO sm_role_func VALUES ('8', '206');
INSERT INTO sm_role_func VALUES ('8', '207');
INSERT INTO sm_role_func VALUES ('8', '208');
INSERT INTO sm_role_func VALUES ('8', '209');
INSERT INTO sm_role_func VALUES ('8', '210');
INSERT INTO sm_role_func VALUES ('8', '211');
INSERT INTO sm_role_func VALUES ('8', '212');
INSERT INTO sm_role_func VALUES ('8', '213');
INSERT INTO sm_role_func VALUES ('8', '214');
INSERT INTO sm_role_func VALUES ('8', '238');
INSERT INTO sm_role_func VALUES ('8', '239');
INSERT INTO sm_role_func VALUES ('8', '305');
INSERT INTO sm_role_func VALUES ('8', '306');
INSERT INTO sm_role_func VALUES ('8', '307');
INSERT INTO sm_role_func VALUES ('8', '312');
INSERT INTO sm_role_func VALUES ('8', '313');
INSERT INTO sm_role_func VALUES ('8', '314');
INSERT INTO sm_role_func VALUES ('8', '315');
INSERT INTO sm_role_func VALUES ('8', '316');
INSERT INTO sm_role_func VALUES ('8', '319');
INSERT INTO sm_role_func VALUES ('8', '320');
INSERT INTO sm_role_func VALUES ('8', '321');
INSERT INTO sm_role_func VALUES ('8', '322');
INSERT INTO sm_role_func VALUES ('8', '323');
INSERT INTO sm_role_func VALUES ('8', '324');
INSERT INTO sm_role_func VALUES ('8', '325');
INSERT INTO sm_role_func VALUES ('8', '326');
INSERT INTO sm_role_func VALUES ('8', '327');
INSERT INTO sm_role_func VALUES ('8', '328');
INSERT INTO sm_role_func VALUES ('9', '7');
INSERT INTO sm_role_func VALUES ('9', '8');
INSERT INTO sm_role_func VALUES ('9', '9');
INSERT INTO sm_role_func VALUES ('9', '10');
INSERT INTO sm_role_func VALUES ('9', '11');
INSERT INTO sm_role_func VALUES ('9', '13');
INSERT INTO sm_role_func VALUES ('9', '14');
INSERT INTO sm_role_func VALUES ('9', '15');
INSERT INTO sm_role_func VALUES ('9', '16');
INSERT INTO sm_role_func VALUES ('9', '17');
INSERT INTO sm_role_func VALUES ('9', '19');
INSERT INTO sm_role_func VALUES ('9', '20');
INSERT INTO sm_role_func VALUES ('9', '21');
INSERT INTO sm_role_func VALUES ('9', '22');
INSERT INTO sm_role_func VALUES ('9', '23');
INSERT INTO sm_role_func VALUES ('9', '24');
INSERT INTO sm_role_func VALUES ('9', '26');
INSERT INTO sm_role_func VALUES ('9', '27');
INSERT INTO sm_role_func VALUES ('9', '28');
INSERT INTO sm_role_func VALUES ('9', '29');
INSERT INTO sm_role_func VALUES ('9', '30');
INSERT INTO sm_role_func VALUES ('9', '31');
INSERT INTO sm_role_func VALUES ('9', '32');
INSERT INTO sm_role_func VALUES ('9', '33');
INSERT INTO sm_role_func VALUES ('9', '34');
INSERT INTO sm_role_func VALUES ('9', '35');
INSERT INTO sm_role_func VALUES ('9', '36');
INSERT INTO sm_role_func VALUES ('9', '37');
INSERT INTO sm_role_func VALUES ('9', '38');
INSERT INTO sm_role_func VALUES ('9', '39');
INSERT INTO sm_role_func VALUES ('9', '40');
INSERT INTO sm_role_func VALUES ('9', '41');
INSERT INTO sm_role_func VALUES ('9', '42');
INSERT INTO sm_role_func VALUES ('9', '43');
INSERT INTO sm_role_func VALUES ('9', '44');
INSERT INTO sm_role_func VALUES ('9', '45');
INSERT INTO sm_role_func VALUES ('9', '46');
INSERT INTO sm_role_func VALUES ('9', '47');
INSERT INTO sm_role_func VALUES ('9', '48');
INSERT INTO sm_role_func VALUES ('9', '49');
INSERT INTO sm_role_func VALUES ('9', '50');
INSERT INTO sm_role_func VALUES ('9', '52');
INSERT INTO sm_role_func VALUES ('9', '53');
INSERT INTO sm_role_func VALUES ('9', '54');
INSERT INTO sm_role_func VALUES ('9', '55');
INSERT INTO sm_role_func VALUES ('9', '56');
INSERT INTO sm_role_func VALUES ('9', '57');
INSERT INTO sm_role_func VALUES ('9', '58');
INSERT INTO sm_role_func VALUES ('9', '59');
INSERT INTO sm_role_func VALUES ('9', '60');
INSERT INTO sm_role_func VALUES ('9', '61');
INSERT INTO sm_role_func VALUES ('9', '62');
INSERT INTO sm_role_func VALUES ('9', '63');
INSERT INTO sm_role_func VALUES ('9', '64');
INSERT INTO sm_role_func VALUES ('9', '65');
INSERT INTO sm_role_func VALUES ('9', '66');
INSERT INTO sm_role_func VALUES ('9', '67');
INSERT INTO sm_role_func VALUES ('9', '68');
INSERT INTO sm_role_func VALUES ('9', '69');
INSERT INTO sm_role_func VALUES ('9', '70');
INSERT INTO sm_role_func VALUES ('9', '71');
INSERT INTO sm_role_func VALUES ('9', '72');
INSERT INTO sm_role_func VALUES ('9', '73');
INSERT INTO sm_role_func VALUES ('9', '74');
INSERT INTO sm_role_func VALUES ('9', '75');
INSERT INTO sm_role_func VALUES ('9', '85');
INSERT INTO sm_role_func VALUES ('9', '86');
INSERT INTO sm_role_func VALUES ('9', '87');
INSERT INTO sm_role_func VALUES ('9', '88');
INSERT INTO sm_role_func VALUES ('9', '89');
INSERT INTO sm_role_func VALUES ('9', '90');
INSERT INTO sm_role_func VALUES ('9', '91');
INSERT INTO sm_role_func VALUES ('9', '92');
INSERT INTO sm_role_func VALUES ('9', '93');
INSERT INTO sm_role_func VALUES ('9', '94');
INSERT INTO sm_role_func VALUES ('9', '95');
INSERT INTO sm_role_func VALUES ('9', '97');
INSERT INTO sm_role_func VALUES ('9', '98');
INSERT INTO sm_role_func VALUES ('9', '99');
INSERT INTO sm_role_func VALUES ('9', '100');
INSERT INTO sm_role_func VALUES ('9', '106');
INSERT INTO sm_role_func VALUES ('9', '107');
INSERT INTO sm_role_func VALUES ('9', '108');
INSERT INTO sm_role_func VALUES ('9', '109');
INSERT INTO sm_role_func VALUES ('9', '110');
INSERT INTO sm_role_func VALUES ('9', '117');
INSERT INTO sm_role_func VALUES ('9', '120');
INSERT INTO sm_role_func VALUES ('9', '121');
INSERT INTO sm_role_func VALUES ('9', '122');
INSERT INTO sm_role_func VALUES ('9', '123');
INSERT INTO sm_role_func VALUES ('9', '124');
INSERT INTO sm_role_func VALUES ('9', '126');
INSERT INTO sm_role_func VALUES ('9', '127');
INSERT INTO sm_role_func VALUES ('9', '128');
INSERT INTO sm_role_func VALUES ('9', '129');
INSERT INTO sm_role_func VALUES ('9', '130');
INSERT INTO sm_role_func VALUES ('9', '131');
INSERT INTO sm_role_func VALUES ('9', '170');
INSERT INTO sm_role_func VALUES ('9', '171');
INSERT INTO sm_role_func VALUES ('9', '172');
INSERT INTO sm_role_func VALUES ('9', '173');
INSERT INTO sm_role_func VALUES ('9', '174');
INSERT INTO sm_role_func VALUES ('9', '175');
INSERT INTO sm_role_func VALUES ('9', '176');
INSERT INTO sm_role_func VALUES ('9', '177');
INSERT INTO sm_role_func VALUES ('9', '178');
INSERT INTO sm_role_func VALUES ('9', '179');
INSERT INTO sm_role_func VALUES ('9', '180');
INSERT INTO sm_role_func VALUES ('9', '181');
INSERT INTO sm_role_func VALUES ('9', '182');
INSERT INTO sm_role_func VALUES ('9', '183');
INSERT INTO sm_role_func VALUES ('9', '184');
INSERT INTO sm_role_func VALUES ('9', '185');
INSERT INTO sm_role_func VALUES ('9', '186');
INSERT INTO sm_role_func VALUES ('9', '187');
INSERT INTO sm_role_func VALUES ('9', '188');
INSERT INTO sm_role_func VALUES ('9', '189');
INSERT INTO sm_role_func VALUES ('9', '190');
INSERT INTO sm_role_func VALUES ('9', '191');
INSERT INTO sm_role_func VALUES ('9', '194');
INSERT INTO sm_role_func VALUES ('9', '195');
INSERT INTO sm_role_func VALUES ('9', '196');
INSERT INTO sm_role_func VALUES ('9', '197');
INSERT INTO sm_role_func VALUES ('9', '198');
INSERT INTO sm_role_func VALUES ('9', '199');
INSERT INTO sm_role_func VALUES ('9', '200');
INSERT INTO sm_role_func VALUES ('9', '202');
INSERT INTO sm_role_func VALUES ('9', '203');
INSERT INTO sm_role_func VALUES ('9', '204');
INSERT INTO sm_role_func VALUES ('9', '206');
INSERT INTO sm_role_func VALUES ('9', '207');
INSERT INTO sm_role_func VALUES ('9', '208');
INSERT INTO sm_role_func VALUES ('9', '209');
INSERT INTO sm_role_func VALUES ('9', '210');
INSERT INTO sm_role_func VALUES ('9', '211');
INSERT INTO sm_role_func VALUES ('9', '212');
INSERT INTO sm_role_func VALUES ('9', '213');
INSERT INTO sm_role_func VALUES ('9', '214');
INSERT INTO sm_role_func VALUES ('9', '215');
INSERT INTO sm_role_func VALUES ('9', '216');
INSERT INTO sm_role_func VALUES ('9', '222');
INSERT INTO sm_role_func VALUES ('9', '223');
INSERT INTO sm_role_func VALUES ('9', '224');
INSERT INTO sm_role_func VALUES ('9', '225');
INSERT INTO sm_role_func VALUES ('9', '226');
INSERT INTO sm_role_func VALUES ('9', '227');
INSERT INTO sm_role_func VALUES ('9', '228');
INSERT INTO sm_role_func VALUES ('9', '229');
INSERT INTO sm_role_func VALUES ('9', '230');
INSERT INTO sm_role_func VALUES ('9', '231');
INSERT INTO sm_role_func VALUES ('9', '232');
INSERT INTO sm_role_func VALUES ('9', '234');
INSERT INTO sm_role_func VALUES ('9', '236');
INSERT INTO sm_role_func VALUES ('9', '237');
INSERT INTO sm_role_func VALUES ('9', '238');
INSERT INTO sm_role_func VALUES ('9', '239');
INSERT INTO sm_role_func VALUES ('9', '305');
INSERT INTO sm_role_func VALUES ('9', '306');
INSERT INTO sm_role_func VALUES ('9', '307');
INSERT INTO sm_role_func VALUES ('9', '309');
INSERT INTO sm_role_func VALUES ('9', '310');
INSERT INTO sm_role_func VALUES ('9', '311');
INSERT INTO sm_role_func VALUES ('9', '312');
INSERT INTO sm_role_func VALUES ('9', '313');
INSERT INTO sm_role_func VALUES ('9', '314');
INSERT INTO sm_role_func VALUES ('9', '315');
INSERT INTO sm_role_func VALUES ('9', '316');
INSERT INTO sm_role_func VALUES ('9', '319');
INSERT INTO sm_role_func VALUES ('9', '320');
INSERT INTO sm_role_func VALUES ('9', '321');
INSERT INTO sm_role_func VALUES ('9', '322');
INSERT INTO sm_role_func VALUES ('9', '323');
INSERT INTO sm_role_func VALUES ('9', '324');
INSERT INTO sm_role_func VALUES ('9', '325');
INSERT INTO sm_role_func VALUES ('9', '326');
INSERT INTO sm_role_func VALUES ('9', '327');
INSERT INTO sm_role_func VALUES ('9', '328');
INSERT INTO sm_role_func VALUES ('9', '329');
INSERT INTO sm_role_func VALUES ('10', '7');
INSERT INTO sm_role_func VALUES ('10', '8');
INSERT INTO sm_role_func VALUES ('10', '9');
INSERT INTO sm_role_func VALUES ('10', '10');
INSERT INTO sm_role_func VALUES ('10', '11');
INSERT INTO sm_role_func VALUES ('10', '13');
INSERT INTO sm_role_func VALUES ('10', '14');
INSERT INTO sm_role_func VALUES ('10', '15');
INSERT INTO sm_role_func VALUES ('10', '16');
INSERT INTO sm_role_func VALUES ('10', '17');
INSERT INTO sm_role_func VALUES ('10', '19');
INSERT INTO sm_role_func VALUES ('10', '20');
INSERT INTO sm_role_func VALUES ('10', '21');
INSERT INTO sm_role_func VALUES ('10', '22');
INSERT INTO sm_role_func VALUES ('10', '23');
INSERT INTO sm_role_func VALUES ('10', '24');
INSERT INTO sm_role_func VALUES ('10', '26');
INSERT INTO sm_role_func VALUES ('10', '27');
INSERT INTO sm_role_func VALUES ('10', '28');
INSERT INTO sm_role_func VALUES ('10', '29');
INSERT INTO sm_role_func VALUES ('10', '30');
INSERT INTO sm_role_func VALUES ('10', '31');
INSERT INTO sm_role_func VALUES ('10', '32');
INSERT INTO sm_role_func VALUES ('10', '33');
INSERT INTO sm_role_func VALUES ('10', '34');
INSERT INTO sm_role_func VALUES ('10', '35');
INSERT INTO sm_role_func VALUES ('10', '36');
INSERT INTO sm_role_func VALUES ('10', '37');
INSERT INTO sm_role_func VALUES ('10', '38');
INSERT INTO sm_role_func VALUES ('10', '39');
INSERT INTO sm_role_func VALUES ('10', '40');
INSERT INTO sm_role_func VALUES ('10', '41');
INSERT INTO sm_role_func VALUES ('10', '42');
INSERT INTO sm_role_func VALUES ('10', '43');
INSERT INTO sm_role_func VALUES ('10', '44');
INSERT INTO sm_role_func VALUES ('10', '45');
INSERT INTO sm_role_func VALUES ('10', '46');
INSERT INTO sm_role_func VALUES ('10', '47');
INSERT INTO sm_role_func VALUES ('10', '48');
INSERT INTO sm_role_func VALUES ('10', '49');
INSERT INTO sm_role_func VALUES ('10', '50');
INSERT INTO sm_role_func VALUES ('10', '52');
INSERT INTO sm_role_func VALUES ('10', '53');
INSERT INTO sm_role_func VALUES ('10', '54');
INSERT INTO sm_role_func VALUES ('10', '55');
INSERT INTO sm_role_func VALUES ('10', '56');
INSERT INTO sm_role_func VALUES ('10', '57');
INSERT INTO sm_role_func VALUES ('10', '58');
INSERT INTO sm_role_func VALUES ('10', '59');
INSERT INTO sm_role_func VALUES ('10', '60');
INSERT INTO sm_role_func VALUES ('10', '61');
INSERT INTO sm_role_func VALUES ('10', '62');
INSERT INTO sm_role_func VALUES ('10', '63');
INSERT INTO sm_role_func VALUES ('10', '64');
INSERT INTO sm_role_func VALUES ('10', '65');
INSERT INTO sm_role_func VALUES ('10', '66');
INSERT INTO sm_role_func VALUES ('10', '67');
INSERT INTO sm_role_func VALUES ('10', '68');
INSERT INTO sm_role_func VALUES ('10', '69');
INSERT INTO sm_role_func VALUES ('10', '70');
INSERT INTO sm_role_func VALUES ('10', '71');
INSERT INTO sm_role_func VALUES ('10', '72');
INSERT INTO sm_role_func VALUES ('10', '73');
INSERT INTO sm_role_func VALUES ('10', '74');
INSERT INTO sm_role_func VALUES ('10', '75');
INSERT INTO sm_role_func VALUES ('10', '85');
INSERT INTO sm_role_func VALUES ('10', '86');
INSERT INTO sm_role_func VALUES ('10', '87');
INSERT INTO sm_role_func VALUES ('10', '88');
INSERT INTO sm_role_func VALUES ('10', '89');
INSERT INTO sm_role_func VALUES ('10', '90');
INSERT INTO sm_role_func VALUES ('10', '91');
INSERT INTO sm_role_func VALUES ('10', '92');
INSERT INTO sm_role_func VALUES ('10', '93');
INSERT INTO sm_role_func VALUES ('10', '94');
INSERT INTO sm_role_func VALUES ('10', '95');
INSERT INTO sm_role_func VALUES ('10', '97');
INSERT INTO sm_role_func VALUES ('10', '98');
INSERT INTO sm_role_func VALUES ('10', '99');
INSERT INTO sm_role_func VALUES ('10', '100');
INSERT INTO sm_role_func VALUES ('10', '106');
INSERT INTO sm_role_func VALUES ('10', '107');
INSERT INTO sm_role_func VALUES ('10', '108');
INSERT INTO sm_role_func VALUES ('10', '109');
INSERT INTO sm_role_func VALUES ('10', '110');
INSERT INTO sm_role_func VALUES ('10', '117');
INSERT INTO sm_role_func VALUES ('10', '120');
INSERT INTO sm_role_func VALUES ('10', '121');
INSERT INTO sm_role_func VALUES ('10', '122');
INSERT INTO sm_role_func VALUES ('10', '123');
INSERT INTO sm_role_func VALUES ('10', '124');
INSERT INTO sm_role_func VALUES ('10', '126');
INSERT INTO sm_role_func VALUES ('10', '127');
INSERT INTO sm_role_func VALUES ('10', '128');
INSERT INTO sm_role_func VALUES ('10', '129');
INSERT INTO sm_role_func VALUES ('10', '130');
INSERT INTO sm_role_func VALUES ('10', '131');
INSERT INTO sm_role_func VALUES ('10', '134');
INSERT INTO sm_role_func VALUES ('10', '135');
INSERT INTO sm_role_func VALUES ('10', '136');
INSERT INTO sm_role_func VALUES ('10', '137');
INSERT INTO sm_role_func VALUES ('10', '138');
INSERT INTO sm_role_func VALUES ('10', '139');
INSERT INTO sm_role_func VALUES ('10', '140');
INSERT INTO sm_role_func VALUES ('10', '141');
INSERT INTO sm_role_func VALUES ('10', '142');
INSERT INTO sm_role_func VALUES ('10', '145');
INSERT INTO sm_role_func VALUES ('10', '146');
INSERT INTO sm_role_func VALUES ('10', '147');
INSERT INTO sm_role_func VALUES ('10', '148');
INSERT INTO sm_role_func VALUES ('10', '149');
INSERT INTO sm_role_func VALUES ('10', '150');
INSERT INTO sm_role_func VALUES ('10', '151');
INSERT INTO sm_role_func VALUES ('10', '152');
INSERT INTO sm_role_func VALUES ('10', '153');
INSERT INTO sm_role_func VALUES ('10', '154');
INSERT INTO sm_role_func VALUES ('10', '155');
INSERT INTO sm_role_func VALUES ('10', '156');
INSERT INTO sm_role_func VALUES ('10', '157');
INSERT INTO sm_role_func VALUES ('10', '158');
INSERT INTO sm_role_func VALUES ('10', '159');
INSERT INTO sm_role_func VALUES ('10', '160');
INSERT INTO sm_role_func VALUES ('10', '161');
INSERT INTO sm_role_func VALUES ('10', '162');
INSERT INTO sm_role_func VALUES ('10', '163');
INSERT INTO sm_role_func VALUES ('10', '164');
INSERT INTO sm_role_func VALUES ('10', '165');
INSERT INTO sm_role_func VALUES ('10', '166');
INSERT INTO sm_role_func VALUES ('10', '167');
INSERT INTO sm_role_func VALUES ('10', '168');
INSERT INTO sm_role_func VALUES ('10', '169');
INSERT INTO sm_role_func VALUES ('10', '170');
INSERT INTO sm_role_func VALUES ('10', '171');
INSERT INTO sm_role_func VALUES ('10', '172');
INSERT INTO sm_role_func VALUES ('10', '173');
INSERT INTO sm_role_func VALUES ('10', '174');
INSERT INTO sm_role_func VALUES ('10', '175');
INSERT INTO sm_role_func VALUES ('10', '176');
INSERT INTO sm_role_func VALUES ('10', '194');
INSERT INTO sm_role_func VALUES ('10', '195');
INSERT INTO sm_role_func VALUES ('10', '196');
INSERT INTO sm_role_func VALUES ('10', '197');
INSERT INTO sm_role_func VALUES ('10', '198');
INSERT INTO sm_role_func VALUES ('10', '199');
INSERT INTO sm_role_func VALUES ('10', '200');
INSERT INTO sm_role_func VALUES ('10', '202');
INSERT INTO sm_role_func VALUES ('10', '203');
INSERT INTO sm_role_func VALUES ('10', '204');
INSERT INTO sm_role_func VALUES ('10', '206');
INSERT INTO sm_role_func VALUES ('10', '207');
INSERT INTO sm_role_func VALUES ('10', '208');
INSERT INTO sm_role_func VALUES ('10', '209');
INSERT INTO sm_role_func VALUES ('10', '210');
INSERT INTO sm_role_func VALUES ('10', '211');
INSERT INTO sm_role_func VALUES ('10', '212');
INSERT INTO sm_role_func VALUES ('10', '213');
INSERT INTO sm_role_func VALUES ('10', '215');
INSERT INTO sm_role_func VALUES ('10', '216');
INSERT INTO sm_role_func VALUES ('10', '222');
INSERT INTO sm_role_func VALUES ('10', '223');
INSERT INTO sm_role_func VALUES ('10', '224');
INSERT INTO sm_role_func VALUES ('10', '225');
INSERT INTO sm_role_func VALUES ('10', '226');
INSERT INTO sm_role_func VALUES ('10', '227');
INSERT INTO sm_role_func VALUES ('10', '228');
INSERT INTO sm_role_func VALUES ('10', '229');
INSERT INTO sm_role_func VALUES ('10', '230');
INSERT INTO sm_role_func VALUES ('10', '231');
INSERT INTO sm_role_func VALUES ('10', '232');
INSERT INTO sm_role_func VALUES ('10', '234');
INSERT INTO sm_role_func VALUES ('10', '236');
INSERT INTO sm_role_func VALUES ('10', '237');
INSERT INTO sm_role_func VALUES ('10', '238');
INSERT INTO sm_role_func VALUES ('10', '239');
INSERT INTO sm_role_func VALUES ('10', '309');
INSERT INTO sm_role_func VALUES ('10', '310');
INSERT INTO sm_role_func VALUES ('10', '311');
INSERT INTO sm_role_func VALUES ('10', '312');
INSERT INTO sm_role_func VALUES ('10', '313');
INSERT INTO sm_role_func VALUES ('10', '314');
INSERT INTO sm_role_func VALUES ('10', '315');
INSERT INTO sm_role_func VALUES ('10', '316');
INSERT INTO sm_role_func VALUES ('10', '319');
INSERT INTO sm_role_func VALUES ('10', '320');
INSERT INTO sm_role_func VALUES ('10', '321');
INSERT INTO sm_role_func VALUES ('10', '322');
INSERT INTO sm_role_func VALUES ('10', '323');
INSERT INTO sm_role_func VALUES ('10', '324');
INSERT INTO sm_role_func VALUES ('10', '325');
INSERT INTO sm_role_func VALUES ('10', '326');
INSERT INTO sm_role_func VALUES ('10', '327');
INSERT INTO sm_role_func VALUES ('10', '328');
INSERT INTO sm_role_func VALUES ('10', '329');
INSERT INTO sm_role_func VALUES ('11', '7');
INSERT INTO sm_role_func VALUES ('11', '8');
INSERT INTO sm_role_func VALUES ('11', '9');
INSERT INTO sm_role_func VALUES ('11', '10');
INSERT INTO sm_role_func VALUES ('11', '11');
INSERT INTO sm_role_func VALUES ('11', '13');
INSERT INTO sm_role_func VALUES ('11', '14');
INSERT INTO sm_role_func VALUES ('11', '15');
INSERT INTO sm_role_func VALUES ('11', '16');
INSERT INTO sm_role_func VALUES ('11', '17');
INSERT INTO sm_role_func VALUES ('11', '19');
INSERT INTO sm_role_func VALUES ('11', '20');
INSERT INTO sm_role_func VALUES ('11', '21');
INSERT INTO sm_role_func VALUES ('11', '22');
INSERT INTO sm_role_func VALUES ('11', '23');
INSERT INTO sm_role_func VALUES ('11', '24');
INSERT INTO sm_role_func VALUES ('11', '26');
INSERT INTO sm_role_func VALUES ('11', '27');
INSERT INTO sm_role_func VALUES ('11', '28');
INSERT INTO sm_role_func VALUES ('11', '29');
INSERT INTO sm_role_func VALUES ('11', '30');
INSERT INTO sm_role_func VALUES ('11', '31');
INSERT INTO sm_role_func VALUES ('11', '32');
INSERT INTO sm_role_func VALUES ('11', '33');
INSERT INTO sm_role_func VALUES ('11', '34');
INSERT INTO sm_role_func VALUES ('11', '35');
INSERT INTO sm_role_func VALUES ('11', '36');
INSERT INTO sm_role_func VALUES ('11', '37');
INSERT INTO sm_role_func VALUES ('11', '38');
INSERT INTO sm_role_func VALUES ('11', '39');
INSERT INTO sm_role_func VALUES ('11', '40');
INSERT INTO sm_role_func VALUES ('11', '41');
INSERT INTO sm_role_func VALUES ('11', '42');
INSERT INTO sm_role_func VALUES ('11', '43');
INSERT INTO sm_role_func VALUES ('11', '44');
INSERT INTO sm_role_func VALUES ('11', '45');
INSERT INTO sm_role_func VALUES ('11', '46');
INSERT INTO sm_role_func VALUES ('11', '47');
INSERT INTO sm_role_func VALUES ('11', '48');
INSERT INTO sm_role_func VALUES ('11', '49');
INSERT INTO sm_role_func VALUES ('11', '50');
INSERT INTO sm_role_func VALUES ('11', '52');
INSERT INTO sm_role_func VALUES ('11', '53');
INSERT INTO sm_role_func VALUES ('11', '54');
INSERT INTO sm_role_func VALUES ('11', '55');
INSERT INTO sm_role_func VALUES ('11', '56');
INSERT INTO sm_role_func VALUES ('11', '57');
INSERT INTO sm_role_func VALUES ('11', '58');
INSERT INTO sm_role_func VALUES ('11', '59');
INSERT INTO sm_role_func VALUES ('11', '60');
INSERT INTO sm_role_func VALUES ('11', '61');
INSERT INTO sm_role_func VALUES ('11', '62');
INSERT INTO sm_role_func VALUES ('11', '63');
INSERT INTO sm_role_func VALUES ('11', '64');
INSERT INTO sm_role_func VALUES ('11', '65');
INSERT INTO sm_role_func VALUES ('11', '66');
INSERT INTO sm_role_func VALUES ('11', '67');
INSERT INTO sm_role_func VALUES ('11', '68');
INSERT INTO sm_role_func VALUES ('11', '69');
INSERT INTO sm_role_func VALUES ('11', '70');
INSERT INTO sm_role_func VALUES ('11', '71');
INSERT INTO sm_role_func VALUES ('11', '72');
INSERT INTO sm_role_func VALUES ('11', '73');
INSERT INTO sm_role_func VALUES ('11', '74');
INSERT INTO sm_role_func VALUES ('11', '75');
INSERT INTO sm_role_func VALUES ('11', '85');
INSERT INTO sm_role_func VALUES ('11', '86');
INSERT INTO sm_role_func VALUES ('11', '87');
INSERT INTO sm_role_func VALUES ('11', '88');
INSERT INTO sm_role_func VALUES ('11', '89');
INSERT INTO sm_role_func VALUES ('11', '90');
INSERT INTO sm_role_func VALUES ('11', '91');
INSERT INTO sm_role_func VALUES ('11', '92');
INSERT INTO sm_role_func VALUES ('11', '93');
INSERT INTO sm_role_func VALUES ('11', '94');
INSERT INTO sm_role_func VALUES ('11', '95');
INSERT INTO sm_role_func VALUES ('11', '97');
INSERT INTO sm_role_func VALUES ('11', '98');
INSERT INTO sm_role_func VALUES ('11', '99');
INSERT INTO sm_role_func VALUES ('11', '100');
INSERT INTO sm_role_func VALUES ('11', '106');
INSERT INTO sm_role_func VALUES ('11', '107');
INSERT INTO sm_role_func VALUES ('11', '108');
INSERT INTO sm_role_func VALUES ('11', '109');
INSERT INTO sm_role_func VALUES ('11', '110');
INSERT INTO sm_role_func VALUES ('11', '117');
INSERT INTO sm_role_func VALUES ('11', '120');
INSERT INTO sm_role_func VALUES ('11', '121');
INSERT INTO sm_role_func VALUES ('11', '122');
INSERT INTO sm_role_func VALUES ('11', '123');
INSERT INTO sm_role_func VALUES ('11', '124');
INSERT INTO sm_role_func VALUES ('11', '126');
INSERT INTO sm_role_func VALUES ('11', '127');
INSERT INTO sm_role_func VALUES ('11', '128');
INSERT INTO sm_role_func VALUES ('11', '129');
INSERT INTO sm_role_func VALUES ('11', '130');
INSERT INTO sm_role_func VALUES ('11', '131');
INSERT INTO sm_role_func VALUES ('11', '134');
INSERT INTO sm_role_func VALUES ('11', '135');
INSERT INTO sm_role_func VALUES ('11', '136');
INSERT INTO sm_role_func VALUES ('11', '137');
INSERT INTO sm_role_func VALUES ('11', '138');
INSERT INTO sm_role_func VALUES ('11', '139');
INSERT INTO sm_role_func VALUES ('11', '140');
INSERT INTO sm_role_func VALUES ('11', '141');
INSERT INTO sm_role_func VALUES ('11', '142');
INSERT INTO sm_role_func VALUES ('11', '145');
INSERT INTO sm_role_func VALUES ('11', '146');
INSERT INTO sm_role_func VALUES ('11', '147');
INSERT INTO sm_role_func VALUES ('11', '148');
INSERT INTO sm_role_func VALUES ('11', '149');
INSERT INTO sm_role_func VALUES ('11', '150');
INSERT INTO sm_role_func VALUES ('11', '151');
INSERT INTO sm_role_func VALUES ('11', '152');
INSERT INTO sm_role_func VALUES ('11', '153');
INSERT INTO sm_role_func VALUES ('11', '154');
INSERT INTO sm_role_func VALUES ('11', '155');
INSERT INTO sm_role_func VALUES ('11', '156');
INSERT INTO sm_role_func VALUES ('11', '157');
INSERT INTO sm_role_func VALUES ('11', '158');
INSERT INTO sm_role_func VALUES ('11', '159');
INSERT INTO sm_role_func VALUES ('11', '160');
INSERT INTO sm_role_func VALUES ('11', '161');
INSERT INTO sm_role_func VALUES ('11', '162');
INSERT INTO sm_role_func VALUES ('11', '163');
INSERT INTO sm_role_func VALUES ('11', '164');
INSERT INTO sm_role_func VALUES ('11', '165');
INSERT INTO sm_role_func VALUES ('11', '166');
INSERT INTO sm_role_func VALUES ('11', '167');
INSERT INTO sm_role_func VALUES ('11', '168');
INSERT INTO sm_role_func VALUES ('11', '169');
INSERT INTO sm_role_func VALUES ('11', '170');
INSERT INTO sm_role_func VALUES ('11', '171');
INSERT INTO sm_role_func VALUES ('11', '172');
INSERT INTO sm_role_func VALUES ('11', '173');
INSERT INTO sm_role_func VALUES ('11', '174');
INSERT INTO sm_role_func VALUES ('11', '175');
INSERT INTO sm_role_func VALUES ('11', '176');
INSERT INTO sm_role_func VALUES ('11', '177');
INSERT INTO sm_role_func VALUES ('11', '178');
INSERT INTO sm_role_func VALUES ('11', '179');
INSERT INTO sm_role_func VALUES ('11', '180');
INSERT INTO sm_role_func VALUES ('11', '181');
INSERT INTO sm_role_func VALUES ('11', '182');
INSERT INTO sm_role_func VALUES ('11', '183');
INSERT INTO sm_role_func VALUES ('11', '184');
INSERT INTO sm_role_func VALUES ('11', '185');
INSERT INTO sm_role_func VALUES ('11', '186');
INSERT INTO sm_role_func VALUES ('11', '187');
INSERT INTO sm_role_func VALUES ('11', '188');
INSERT INTO sm_role_func VALUES ('11', '189');
INSERT INTO sm_role_func VALUES ('11', '190');
INSERT INTO sm_role_func VALUES ('11', '194');
INSERT INTO sm_role_func VALUES ('11', '195');
INSERT INTO sm_role_func VALUES ('11', '196');
INSERT INTO sm_role_func VALUES ('11', '197');
INSERT INTO sm_role_func VALUES ('11', '198');
INSERT INTO sm_role_func VALUES ('11', '199');
INSERT INTO sm_role_func VALUES ('11', '200');
INSERT INTO sm_role_func VALUES ('11', '202');
INSERT INTO sm_role_func VALUES ('11', '203');
INSERT INTO sm_role_func VALUES ('11', '204');
INSERT INTO sm_role_func VALUES ('11', '206');
INSERT INTO sm_role_func VALUES ('11', '207');
INSERT INTO sm_role_func VALUES ('11', '208');
INSERT INTO sm_role_func VALUES ('11', '209');
INSERT INTO sm_role_func VALUES ('11', '210');
INSERT INTO sm_role_func VALUES ('11', '211');
INSERT INTO sm_role_func VALUES ('11', '212');
INSERT INTO sm_role_func VALUES ('11', '213');
INSERT INTO sm_role_func VALUES ('11', '214');
INSERT INTO sm_role_func VALUES ('11', '238');
INSERT INTO sm_role_func VALUES ('11', '239');
INSERT INTO sm_role_func VALUES ('11', '305');
INSERT INTO sm_role_func VALUES ('11', '306');
INSERT INTO sm_role_func VALUES ('11', '307');
INSERT INTO sm_role_func VALUES ('11', '309');
INSERT INTO sm_role_func VALUES ('11', '312');
INSERT INTO sm_role_func VALUES ('11', '313');
INSERT INTO sm_role_func VALUES ('11', '314');
INSERT INTO sm_role_func VALUES ('11', '315');
INSERT INTO sm_role_func VALUES ('11', '316');
INSERT INTO sm_role_func VALUES ('11', '319');
INSERT INTO sm_role_func VALUES ('11', '320');
INSERT INTO sm_role_func VALUES ('11', '321');
INSERT INTO sm_role_func VALUES ('11', '322');
INSERT INTO sm_role_func VALUES ('11', '323');
INSERT INTO sm_role_func VALUES ('11', '324');
INSERT INTO sm_role_func VALUES ('11', '325');
INSERT INTO sm_role_func VALUES ('11', '326');
INSERT INTO sm_role_func VALUES ('11', '327');
INSERT INTO sm_role_func VALUES ('11', '328');
INSERT INTO sm_role_func VALUES ('11', '329');
INSERT INTO sm_role_func VALUES ('12', '19');
INSERT INTO sm_role_func VALUES ('12', '20');
INSERT INTO sm_role_func VALUES ('12', '21');
INSERT INTO sm_role_func VALUES ('12', '22');
INSERT INTO sm_role_func VALUES ('12', '23');
INSERT INTO sm_role_func VALUES ('12', '24');
INSERT INTO sm_role_func VALUES ('12', '89');
INSERT INTO sm_role_func VALUES ('12', '90');
INSERT INTO sm_role_func VALUES ('12', '91');
INSERT INTO sm_role_func VALUES ('12', '92');
INSERT INTO sm_role_func VALUES ('12', '93');
INSERT INTO sm_role_func VALUES ('12', '94');
INSERT INTO sm_role_func VALUES ('12', '95');
INSERT INTO sm_role_func VALUES ('12', '97');
INSERT INTO sm_role_func VALUES ('12', '98');
INSERT INTO sm_role_func VALUES ('12', '99');
INSERT INTO sm_role_func VALUES ('12', '100');
INSERT INTO sm_role_func VALUES ('12', '117');
INSERT INTO sm_role_func VALUES ('12', '120');
INSERT INTO sm_role_func VALUES ('12', '121');
INSERT INTO sm_role_func VALUES ('12', '122');
INSERT INTO sm_role_func VALUES ('12', '123');
INSERT INTO sm_role_func VALUES ('12', '124');
INSERT INTO sm_role_func VALUES ('12', '126');
INSERT INTO sm_role_func VALUES ('12', '127');
INSERT INTO sm_role_func VALUES ('12', '128');
INSERT INTO sm_role_func VALUES ('12', '129');
INSERT INTO sm_role_func VALUES ('12', '130');
INSERT INTO sm_role_func VALUES ('12', '131');
INSERT INTO sm_role_func VALUES ('12', '134');
INSERT INTO sm_role_func VALUES ('12', '135');
INSERT INTO sm_role_func VALUES ('12', '136');
INSERT INTO sm_role_func VALUES ('12', '137');
INSERT INTO sm_role_func VALUES ('12', '138');
INSERT INTO sm_role_func VALUES ('12', '139');
INSERT INTO sm_role_func VALUES ('12', '140');
INSERT INTO sm_role_func VALUES ('12', '141');
INSERT INTO sm_role_func VALUES ('12', '142');
INSERT INTO sm_role_func VALUES ('12', '145');
INSERT INTO sm_role_func VALUES ('12', '146');
INSERT INTO sm_role_func VALUES ('12', '147');
INSERT INTO sm_role_func VALUES ('12', '148');
INSERT INTO sm_role_func VALUES ('12', '149');
INSERT INTO sm_role_func VALUES ('12', '150');
INSERT INTO sm_role_func VALUES ('12', '151');
INSERT INTO sm_role_func VALUES ('12', '152');
INSERT INTO sm_role_func VALUES ('12', '153');
INSERT INTO sm_role_func VALUES ('12', '154');
INSERT INTO sm_role_func VALUES ('12', '155');
INSERT INTO sm_role_func VALUES ('12', '156');
INSERT INTO sm_role_func VALUES ('12', '157');
INSERT INTO sm_role_func VALUES ('12', '158');
INSERT INTO sm_role_func VALUES ('12', '159');
INSERT INTO sm_role_func VALUES ('12', '160');
INSERT INTO sm_role_func VALUES ('12', '161');
INSERT INTO sm_role_func VALUES ('12', '162');
INSERT INTO sm_role_func VALUES ('12', '163');
INSERT INTO sm_role_func VALUES ('12', '164');
INSERT INTO sm_role_func VALUES ('12', '165');
INSERT INTO sm_role_func VALUES ('12', '166');
INSERT INTO sm_role_func VALUES ('12', '167');
INSERT INTO sm_role_func VALUES ('12', '168');
INSERT INTO sm_role_func VALUES ('12', '169');
INSERT INTO sm_role_func VALUES ('12', '195');
INSERT INTO sm_role_func VALUES ('12', '196');
INSERT INTO sm_role_func VALUES ('12', '197');
INSERT INTO sm_role_func VALUES ('12', '198');
INSERT INTO sm_role_func VALUES ('12', '199');
INSERT INTO sm_role_func VALUES ('12', '200');
INSERT INTO sm_role_func VALUES ('12', '202');
INSERT INTO sm_role_func VALUES ('12', '203');
INSERT INTO sm_role_func VALUES ('12', '204');
INSERT INTO sm_role_func VALUES ('12', '222');
INSERT INTO sm_role_func VALUES ('12', '223');
INSERT INTO sm_role_func VALUES ('12', '224');
INSERT INTO sm_role_func VALUES ('12', '225');
INSERT INTO sm_role_func VALUES ('12', '226');
INSERT INTO sm_role_func VALUES ('12', '227');
INSERT INTO sm_role_func VALUES ('12', '238');
INSERT INTO sm_role_func VALUES ('12', '239');
INSERT INTO sm_role_func VALUES ('12', '309');
INSERT INTO sm_role_func VALUES ('12', '329');

-- ----------------------------
-- Table structure for `sm_user`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user`;
CREATE TABLE `sm_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键编号',
  `LOGIN_NAME` varchar(32) NOT NULL COMMENT '登录名',
  `PASSWORD` varchar(64) NOT NULL COMMENT '密码',
  `USER_NAME` varchar(32) NOT NULL COMMENT '真实姓名',
  `SEX_ID` int(11) NOT NULL COMMENT '性别',
  `PHONE` varchar(32) DEFAULT NULL COMMENT '电话号码',
  `MOBILE` varchar(32) DEFAULT NULL COMMENT '手机号码',
  `EMAIL` varchar(32) DEFAULT NULL COMMENT '邮箱',
  `QQ` varchar(16) DEFAULT NULL COMMENT 'QQ',
  `JOB_NAME` varchar(64) DEFAULT NULL COMMENT '职位',
  `JOB_SITUATION_ID` int(11) NOT NULL COMMENT '职位状态',
  `IS_MANAGER` int(11) NOT NULL COMMENT '否是管理员',
  `IS_ACTIVE` char(1) NOT NULL DEFAULT '1' COMMENT '是否启用 1启用 0禁用',
  `ORGANIZATION_ID` int(11) NOT NULL COMMENT '属所组织',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '备注',
  `STORE_STATUS_ID` int(11) NOT NULL COMMENT '数据存储状态',
  `IS_DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '否是被删除',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否初始化数据',
  `CREATOR_ID` int(11) NOT NULL COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_LOGIN_NAME` (`LOGIN_NAME`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of sm_user
-- ----------------------------
INSERT INTO sm_user VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '管理员', '2', '18620088324', '0000000000', '00000000@gmail.com', '000000000', '工程师', '9', '1', '1', '1', null, '12', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-27 19:26:33');
INSERT INTO sm_user VALUES ('2', 'huizijing', 'e10adc3949ba59abbe56e057f20f883e', '惠子敬（总裁）', '3', '18620623071', '18613891430', null, null, '董事长', '9', '0', '1', '2', null, '12', '0', '0', '1', '2014-08-18 14:59:11', '1', '2014-08-20 10:10:47');
INSERT INTO sm_user VALUES ('3', 'lihua', 'e10adc3949ba59abbe56e057f20f883e', '李华（投资经理）', '2', null, '18613891430', null, null, null, '9', '0', '1', '45', null, '12', '0', '0', '1', '2014-08-18 15:06:38', '1', '2014-08-18 15:08:23');
INSERT INTO sm_user VALUES ('4', 'luoxiaoli', 'e10adc3949ba59abbe56e057f20f883e', '罗晓丽（财务专员）', '3', null, null, null, null, '财务专员', '9', '0', '1', '40', null, '12', '0', '0', '1', '2014-08-18 15:18:50', '1', '2014-08-18 15:39:21');
INSERT INTO sm_user VALUES ('5', 'majingliang', 'e10adc3949ba59abbe56e057f20f883e', '马敬亮（投资总监）', '2', null, '18613891430', null, null, null, '9', '0', '1', '35', null, '12', '0', '0', '1', '2014-08-18 15:21:40', '1', '2014-08-18 15:22:38');
INSERT INTO sm_user VALUES ('6', 'xiayouxue', 'e10adc3949ba59abbe56e057f20f883e', '夏幼学（理财经理）', '2', null, null, null, null, null, '9', '0', '1', '2', null, '12', '0', '0', '1', '2014-08-18 15:23:39', '1', '2014-08-18 15:24:09');
INSERT INTO sm_user VALUES ('7', 'zhangxuemei', 'e10adc3949ba59abbe56e057f20f883e', '张雪梅（财务专员）', '2', '18620623071', null, null, '1051453718', '财务专员', '9', '0', '1', '40', null, '12', '0', '0', '1', '2014-08-18 15:27:51', '1', '2014-08-18 15:28:04');
INSERT INTO sm_user VALUES ('8', 'lixiao', 'e10adc3949ba59abbe56e057f20f883e', '李晓（理财经理）', '2', null, null, 'xiao.li@pcstars.com', null, '理财经理', '9', '0', '1', '46', null, '12', '0', '0', '1', '2014-08-18 15:42:45', '1', '2014-08-18 15:43:05');
INSERT INTO sm_user VALUES ('9', 'zhangyi', 'e10adc3949ba59abbe56e057f20f883e', '张毅（投资总监）', '2', null, null, null, null, '副总裁', '9', '0', '1', '36', null, '12', '0', '0', '1', '2014-08-18 15:47:35', '1', '2014-08-18 15:47:35');
INSERT INTO sm_user VALUES ('10', 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '张三（投资总监）', '2', null, null, null, null, null, '9', '0', '0', '36', null, '12', '0', '0', '1', '2014-08-18 15:48:40', '1', '2014-08-19 10:16:24');
INSERT INTO sm_user VALUES ('11', 'feizai', 'e10adc3949ba59abbe56e057f20f883e', '肥仔（昌平-理财经理）', '2', '18620623071', null, null, null, '理财经理', '9', '0', '1', '72', null, '12', '0', '0', '1', '2014-08-18 15:52:34', '1', '2014-08-18 15:52:34');
INSERT INTO sm_user VALUES ('12', 'hualong', 'e10adc3949ba59abbe56e057f20f883e', '华龙（海淀-投资经理）', '2', '18620623071', null, null, null, '海淀投资经理', '9', '0', '1', '72', null, '12', '0', '0', '1', '2014-08-18 15:54:16', '1', '2014-08-18 15:54:16');
INSERT INTO sm_user VALUES ('13', 'tangfei', 'e10adc3949ba59abbe56e057f20f883e', '唐飞（理财经理）', '3', null, null, null, null, null, '9', '0', '1', '1', null, '12', '0', '0', '1', '2014-08-18 16:03:00', '1', '2014-08-18 16:03:22');
INSERT INTO sm_user VALUES ('14', 'xiaolan', 'e10adc3949ba59abbe56e057f20f883e', '小兰（测试-理财专员）', '2', null, null, null, null, '理财专员', '9', '0', '1', '57', null, '12', '0', '0', '1', '2014-08-19 15:51:29', '1', '2014-08-19 15:51:30');
INSERT INTO sm_user VALUES ('15', 'xiaolan1', 'e10adc3949ba59abbe56e057f20f883e', '小兰1（理财经理）', '2', null, null, null, null, null, '9', '0', '1', '57', null, '12', '0', '0', '1', '2014-08-19 15:53:31', '1', '2014-08-19 15:53:31');
INSERT INTO sm_user VALUES ('16', 'xiaolan2', 'e10adc3949ba59abbe56e057f20f883e', '小兰2（投资经理）', '2', null, null, null, null, null, '9', '0', '1', '57', null, '12', '0', '0', '1', '2014-08-19 15:55:24', '1', '2014-08-19 15:55:25');
INSERT INTO sm_user VALUES ('17', 'xiaolan3', 'e10adc3949ba59abbe56e057f20f883e', '小兰3（投资总监）', '2', null, null, null, null, null, '9', '0', '1', '35', null, '12', '0', '0', '1', '2014-08-19 15:57:13', '1', '2014-08-19 15:57:13');
INSERT INTO sm_user VALUES ('18', 'xiaolan4', 'e10adc3949ba59abbe56e057f20f883e', '小兰4（副总裁）', '2', null, null, null, null, null, '9', '0', '1', '2', null, '12', '0', '0', '1', '2014-08-19 15:59:33', '1', '2014-08-19 15:59:33');
INSERT INTO sm_user VALUES ('19', 'xiaolan5', 'e10adc3949ba59abbe56e057f20f883e', '小兰5（总裁审核）', '2', null, null, null, null, '请问', '9', '0', '1', '2', null, '12', '0', '0', '1', '2014-08-19 16:01:34', '1', '2014-08-19 16:15:35');
INSERT INTO sm_user VALUES ('20', 'xiaoc', 'e10adc3949ba59abbe56e057f20f883e', '小c（理财专员）', '2', null, null, null, null, null, '9', '0', '1', '57', null, '12', '0', '0', '1', '2014-08-19 16:45:56', '1', '2014-08-19 16:46:22');
INSERT INTO sm_user VALUES ('21', 'xiaov', 'e10adc3949ba59abbe56e057f20f883e', 'xiaov（理财专员）', '2', null, null, null, null, null, '9', '0', '1', '45', null, '12', '0', '0', '1', '2014-08-19 17:29:20', '1', '2014-08-19 17:29:20');
INSERT INTO sm_user VALUES ('22', 'xsdsd', 'e10adc3949ba59abbe56e057f20f883e', 'xxx', '2', null, null, null, null, null, '9', '0', '1', '1', null, '12', '0', '0', '1', '2014-08-20 09:03:58', '1', '2014-08-20 09:03:58');

-- ----------------------------
-- Table structure for `sm_user_com`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_com`;
CREATE TABLE `sm_user_com` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `COM_ID` int(11) NOT NULL DEFAULT '0' COMMENT '组件ID',
  PRIMARY KEY (`USER_ID`,`COM_ID`),
  KEY `INDEX_USER_ID` (`USER_ID`) USING BTREE,
  KEY `INDEX_COM_ID` (`COM_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组件表';

-- ----------------------------
-- Records of sm_user_com
-- ----------------------------
INSERT INTO sm_user_com VALUES ('2', '8');
INSERT INTO sm_user_com VALUES ('2', '14');
INSERT INTO sm_user_com VALUES ('13', '8');
INSERT INTO sm_user_com VALUES ('13', '14');

-- ----------------------------
-- Table structure for `sm_user_func`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_func`;
CREATE TABLE `sm_user_func` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `FUNC_ID` int(11) NOT NULL DEFAULT '0' COMMENT '功能ID',
  PRIMARY KEY (`USER_ID`,`FUNC_ID`),
  KEY `INDEX_USER_ID` (`USER_ID`) USING BTREE,
  KEY `INDEX_FUNC_ID` (`FUNC_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户，功能 对应关系表';

-- ----------------------------
-- Records of sm_user_func
-- ----------------------------
INSERT INTO sm_user_func VALUES ('2', '7');
INSERT INTO sm_user_func VALUES ('2', '8');
INSERT INTO sm_user_func VALUES ('2', '9');
INSERT INTO sm_user_func VALUES ('2', '10');
INSERT INTO sm_user_func VALUES ('2', '11');
INSERT INTO sm_user_func VALUES ('2', '13');
INSERT INTO sm_user_func VALUES ('2', '14');
INSERT INTO sm_user_func VALUES ('2', '15');
INSERT INTO sm_user_func VALUES ('2', '16');
INSERT INTO sm_user_func VALUES ('2', '17');
INSERT INTO sm_user_func VALUES ('2', '19');
INSERT INTO sm_user_func VALUES ('2', '20');
INSERT INTO sm_user_func VALUES ('2', '21');
INSERT INTO sm_user_func VALUES ('2', '22');
INSERT INTO sm_user_func VALUES ('2', '23');
INSERT INTO sm_user_func VALUES ('2', '24');
INSERT INTO sm_user_func VALUES ('2', '26');
INSERT INTO sm_user_func VALUES ('2', '27');
INSERT INTO sm_user_func VALUES ('2', '28');
INSERT INTO sm_user_func VALUES ('2', '29');
INSERT INTO sm_user_func VALUES ('2', '30');
INSERT INTO sm_user_func VALUES ('2', '31');
INSERT INTO sm_user_func VALUES ('2', '32');
INSERT INTO sm_user_func VALUES ('2', '33');
INSERT INTO sm_user_func VALUES ('2', '34');
INSERT INTO sm_user_func VALUES ('2', '35');
INSERT INTO sm_user_func VALUES ('2', '36');
INSERT INTO sm_user_func VALUES ('2', '37');
INSERT INTO sm_user_func VALUES ('2', '38');
INSERT INTO sm_user_func VALUES ('2', '39');
INSERT INTO sm_user_func VALUES ('2', '40');
INSERT INTO sm_user_func VALUES ('2', '41');
INSERT INTO sm_user_func VALUES ('2', '42');
INSERT INTO sm_user_func VALUES ('2', '43');
INSERT INTO sm_user_func VALUES ('2', '44');
INSERT INTO sm_user_func VALUES ('2', '45');
INSERT INTO sm_user_func VALUES ('2', '46');
INSERT INTO sm_user_func VALUES ('2', '47');
INSERT INTO sm_user_func VALUES ('2', '48');
INSERT INTO sm_user_func VALUES ('2', '49');
INSERT INTO sm_user_func VALUES ('2', '50');
INSERT INTO sm_user_func VALUES ('2', '52');
INSERT INTO sm_user_func VALUES ('2', '53');
INSERT INTO sm_user_func VALUES ('2', '54');
INSERT INTO sm_user_func VALUES ('2', '55');
INSERT INTO sm_user_func VALUES ('2', '56');
INSERT INTO sm_user_func VALUES ('2', '57');
INSERT INTO sm_user_func VALUES ('2', '58');
INSERT INTO sm_user_func VALUES ('2', '59');
INSERT INTO sm_user_func VALUES ('2', '60');
INSERT INTO sm_user_func VALUES ('2', '61');
INSERT INTO sm_user_func VALUES ('2', '62');
INSERT INTO sm_user_func VALUES ('2', '63');
INSERT INTO sm_user_func VALUES ('2', '64');
INSERT INTO sm_user_func VALUES ('2', '65');
INSERT INTO sm_user_func VALUES ('2', '66');
INSERT INTO sm_user_func VALUES ('2', '67');
INSERT INTO sm_user_func VALUES ('2', '68');
INSERT INTO sm_user_func VALUES ('2', '69');
INSERT INTO sm_user_func VALUES ('2', '70');
INSERT INTO sm_user_func VALUES ('2', '71');
INSERT INTO sm_user_func VALUES ('2', '72');
INSERT INTO sm_user_func VALUES ('2', '73');
INSERT INTO sm_user_func VALUES ('2', '74');
INSERT INTO sm_user_func VALUES ('2', '75');
INSERT INTO sm_user_func VALUES ('2', '85');
INSERT INTO sm_user_func VALUES ('2', '86');
INSERT INTO sm_user_func VALUES ('2', '87');
INSERT INTO sm_user_func VALUES ('2', '88');
INSERT INTO sm_user_func VALUES ('2', '89');
INSERT INTO sm_user_func VALUES ('2', '90');
INSERT INTO sm_user_func VALUES ('2', '91');
INSERT INTO sm_user_func VALUES ('2', '92');
INSERT INTO sm_user_func VALUES ('2', '93');
INSERT INTO sm_user_func VALUES ('2', '94');
INSERT INTO sm_user_func VALUES ('2', '95');
INSERT INTO sm_user_func VALUES ('2', '97');
INSERT INTO sm_user_func VALUES ('2', '98');
INSERT INTO sm_user_func VALUES ('2', '99');
INSERT INTO sm_user_func VALUES ('2', '100');
INSERT INTO sm_user_func VALUES ('2', '106');
INSERT INTO sm_user_func VALUES ('2', '107');
INSERT INTO sm_user_func VALUES ('2', '108');
INSERT INTO sm_user_func VALUES ('2', '109');
INSERT INTO sm_user_func VALUES ('2', '110');
INSERT INTO sm_user_func VALUES ('2', '111');
INSERT INTO sm_user_func VALUES ('2', '112');
INSERT INTO sm_user_func VALUES ('2', '113');
INSERT INTO sm_user_func VALUES ('2', '114');
INSERT INTO sm_user_func VALUES ('2', '115');
INSERT INTO sm_user_func VALUES ('2', '116');
INSERT INTO sm_user_func VALUES ('2', '117');
INSERT INTO sm_user_func VALUES ('2', '120');
INSERT INTO sm_user_func VALUES ('2', '121');
INSERT INTO sm_user_func VALUES ('2', '122');
INSERT INTO sm_user_func VALUES ('2', '123');
INSERT INTO sm_user_func VALUES ('2', '124');
INSERT INTO sm_user_func VALUES ('2', '126');
INSERT INTO sm_user_func VALUES ('2', '127');
INSERT INTO sm_user_func VALUES ('2', '128');
INSERT INTO sm_user_func VALUES ('2', '129');
INSERT INTO sm_user_func VALUES ('2', '130');
INSERT INTO sm_user_func VALUES ('2', '131');
INSERT INTO sm_user_func VALUES ('2', '134');
INSERT INTO sm_user_func VALUES ('2', '135');
INSERT INTO sm_user_func VALUES ('2', '136');
INSERT INTO sm_user_func VALUES ('2', '137');
INSERT INTO sm_user_func VALUES ('2', '138');
INSERT INTO sm_user_func VALUES ('2', '139');
INSERT INTO sm_user_func VALUES ('2', '140');
INSERT INTO sm_user_func VALUES ('2', '141');
INSERT INTO sm_user_func VALUES ('2', '142');
INSERT INTO sm_user_func VALUES ('2', '145');
INSERT INTO sm_user_func VALUES ('2', '146');
INSERT INTO sm_user_func VALUES ('2', '147');
INSERT INTO sm_user_func VALUES ('2', '148');
INSERT INTO sm_user_func VALUES ('2', '149');
INSERT INTO sm_user_func VALUES ('2', '150');
INSERT INTO sm_user_func VALUES ('2', '151');
INSERT INTO sm_user_func VALUES ('2', '152');
INSERT INTO sm_user_func VALUES ('2', '153');
INSERT INTO sm_user_func VALUES ('2', '154');
INSERT INTO sm_user_func VALUES ('2', '155');
INSERT INTO sm_user_func VALUES ('2', '156');
INSERT INTO sm_user_func VALUES ('2', '157');
INSERT INTO sm_user_func VALUES ('2', '158');
INSERT INTO sm_user_func VALUES ('2', '159');
INSERT INTO sm_user_func VALUES ('2', '160');
INSERT INTO sm_user_func VALUES ('2', '161');
INSERT INTO sm_user_func VALUES ('2', '162');
INSERT INTO sm_user_func VALUES ('2', '163');
INSERT INTO sm_user_func VALUES ('2', '164');
INSERT INTO sm_user_func VALUES ('2', '165');
INSERT INTO sm_user_func VALUES ('2', '166');
INSERT INTO sm_user_func VALUES ('2', '167');
INSERT INTO sm_user_func VALUES ('2', '168');
INSERT INTO sm_user_func VALUES ('2', '169');
INSERT INTO sm_user_func VALUES ('2', '170');
INSERT INTO sm_user_func VALUES ('2', '171');
INSERT INTO sm_user_func VALUES ('2', '172');
INSERT INTO sm_user_func VALUES ('2', '173');
INSERT INTO sm_user_func VALUES ('2', '174');
INSERT INTO sm_user_func VALUES ('2', '175');
INSERT INTO sm_user_func VALUES ('2', '176');
INSERT INTO sm_user_func VALUES ('2', '177');
INSERT INTO sm_user_func VALUES ('2', '178');
INSERT INTO sm_user_func VALUES ('2', '179');
INSERT INTO sm_user_func VALUES ('2', '180');
INSERT INTO sm_user_func VALUES ('2', '181');
INSERT INTO sm_user_func VALUES ('2', '182');
INSERT INTO sm_user_func VALUES ('2', '183');
INSERT INTO sm_user_func VALUES ('2', '184');
INSERT INTO sm_user_func VALUES ('2', '185');
INSERT INTO sm_user_func VALUES ('2', '186');
INSERT INTO sm_user_func VALUES ('2', '187');
INSERT INTO sm_user_func VALUES ('2', '188');
INSERT INTO sm_user_func VALUES ('2', '189');
INSERT INTO sm_user_func VALUES ('2', '190');
INSERT INTO sm_user_func VALUES ('2', '191');
INSERT INTO sm_user_func VALUES ('2', '194');
INSERT INTO sm_user_func VALUES ('2', '195');
INSERT INTO sm_user_func VALUES ('2', '196');
INSERT INTO sm_user_func VALUES ('2', '197');
INSERT INTO sm_user_func VALUES ('2', '198');
INSERT INTO sm_user_func VALUES ('2', '199');
INSERT INTO sm_user_func VALUES ('2', '200');
INSERT INTO sm_user_func VALUES ('2', '202');
INSERT INTO sm_user_func VALUES ('2', '203');
INSERT INTO sm_user_func VALUES ('2', '204');
INSERT INTO sm_user_func VALUES ('2', '206');
INSERT INTO sm_user_func VALUES ('2', '207');
INSERT INTO sm_user_func VALUES ('2', '208');
INSERT INTO sm_user_func VALUES ('2', '209');
INSERT INTO sm_user_func VALUES ('2', '210');
INSERT INTO sm_user_func VALUES ('2', '211');
INSERT INTO sm_user_func VALUES ('2', '212');
INSERT INTO sm_user_func VALUES ('2', '213');
INSERT INTO sm_user_func VALUES ('2', '214');
INSERT INTO sm_user_func VALUES ('2', '215');
INSERT INTO sm_user_func VALUES ('2', '216');
INSERT INTO sm_user_func VALUES ('2', '222');
INSERT INTO sm_user_func VALUES ('2', '223');
INSERT INTO sm_user_func VALUES ('2', '224');
INSERT INTO sm_user_func VALUES ('2', '225');
INSERT INTO sm_user_func VALUES ('2', '226');
INSERT INTO sm_user_func VALUES ('2', '227');
INSERT INTO sm_user_func VALUES ('2', '228');
INSERT INTO sm_user_func VALUES ('2', '229');
INSERT INTO sm_user_func VALUES ('2', '230');
INSERT INTO sm_user_func VALUES ('2', '231');
INSERT INTO sm_user_func VALUES ('2', '232');
INSERT INTO sm_user_func VALUES ('2', '234');
INSERT INTO sm_user_func VALUES ('2', '236');
INSERT INTO sm_user_func VALUES ('2', '237');
INSERT INTO sm_user_func VALUES ('2', '238');
INSERT INTO sm_user_func VALUES ('2', '239');
INSERT INTO sm_user_func VALUES ('2', '305');
INSERT INTO sm_user_func VALUES ('2', '306');
INSERT INTO sm_user_func VALUES ('2', '307');
INSERT INTO sm_user_func VALUES ('2', '312');
INSERT INTO sm_user_func VALUES ('2', '313');
INSERT INTO sm_user_func VALUES ('2', '314');
INSERT INTO sm_user_func VALUES ('2', '315');
INSERT INTO sm_user_func VALUES ('2', '316');
INSERT INTO sm_user_func VALUES ('2', '318');
INSERT INTO sm_user_func VALUES ('2', '319');
INSERT INTO sm_user_func VALUES ('2', '320');
INSERT INTO sm_user_func VALUES ('2', '321');
INSERT INTO sm_user_func VALUES ('2', '322');
INSERT INTO sm_user_func VALUES ('2', '323');
INSERT INTO sm_user_func VALUES ('2', '324');
INSERT INTO sm_user_func VALUES ('2', '325');
INSERT INTO sm_user_func VALUES ('2', '326');
INSERT INTO sm_user_func VALUES ('2', '327');
INSERT INTO sm_user_func VALUES ('2', '328');
INSERT INTO sm_user_func VALUES ('3', '19');
INSERT INTO sm_user_func VALUES ('3', '117');
INSERT INTO sm_user_func VALUES ('3', '120');
INSERT INTO sm_user_func VALUES ('3', '121');
INSERT INTO sm_user_func VALUES ('3', '122');
INSERT INTO sm_user_func VALUES ('3', '123');
INSERT INTO sm_user_func VALUES ('3', '124');
INSERT INTO sm_user_func VALUES ('3', '126');
INSERT INTO sm_user_func VALUES ('3', '127');
INSERT INTO sm_user_func VALUES ('3', '128');
INSERT INTO sm_user_func VALUES ('3', '129');
INSERT INTO sm_user_func VALUES ('3', '130');
INSERT INTO sm_user_func VALUES ('3', '131');
INSERT INTO sm_user_func VALUES ('13', '7');
INSERT INTO sm_user_func VALUES ('13', '8');
INSERT INTO sm_user_func VALUES ('13', '9');
INSERT INTO sm_user_func VALUES ('13', '10');
INSERT INTO sm_user_func VALUES ('13', '11');
INSERT INTO sm_user_func VALUES ('13', '13');
INSERT INTO sm_user_func VALUES ('13', '14');
INSERT INTO sm_user_func VALUES ('13', '15');
INSERT INTO sm_user_func VALUES ('13', '16');
INSERT INTO sm_user_func VALUES ('13', '17');
INSERT INTO sm_user_func VALUES ('13', '19');
INSERT INTO sm_user_func VALUES ('13', '20');
INSERT INTO sm_user_func VALUES ('13', '21');
INSERT INTO sm_user_func VALUES ('13', '22');
INSERT INTO sm_user_func VALUES ('13', '23');
INSERT INTO sm_user_func VALUES ('13', '24');
INSERT INTO sm_user_func VALUES ('13', '26');
INSERT INTO sm_user_func VALUES ('13', '27');
INSERT INTO sm_user_func VALUES ('13', '28');
INSERT INTO sm_user_func VALUES ('13', '29');
INSERT INTO sm_user_func VALUES ('13', '30');
INSERT INTO sm_user_func VALUES ('13', '31');
INSERT INTO sm_user_func VALUES ('13', '32');
INSERT INTO sm_user_func VALUES ('13', '33');
INSERT INTO sm_user_func VALUES ('13', '34');
INSERT INTO sm_user_func VALUES ('13', '35');
INSERT INTO sm_user_func VALUES ('13', '36');
INSERT INTO sm_user_func VALUES ('13', '37');
INSERT INTO sm_user_func VALUES ('13', '38');
INSERT INTO sm_user_func VALUES ('13', '39');
INSERT INTO sm_user_func VALUES ('13', '40');
INSERT INTO sm_user_func VALUES ('13', '41');
INSERT INTO sm_user_func VALUES ('13', '42');
INSERT INTO sm_user_func VALUES ('13', '43');
INSERT INTO sm_user_func VALUES ('13', '44');
INSERT INTO sm_user_func VALUES ('13', '45');
INSERT INTO sm_user_func VALUES ('13', '46');
INSERT INTO sm_user_func VALUES ('13', '47');
INSERT INTO sm_user_func VALUES ('13', '48');
INSERT INTO sm_user_func VALUES ('13', '49');
INSERT INTO sm_user_func VALUES ('13', '50');
INSERT INTO sm_user_func VALUES ('13', '52');
INSERT INTO sm_user_func VALUES ('13', '53');
INSERT INTO sm_user_func VALUES ('13', '54');
INSERT INTO sm_user_func VALUES ('13', '55');
INSERT INTO sm_user_func VALUES ('13', '56');
INSERT INTO sm_user_func VALUES ('13', '57');
INSERT INTO sm_user_func VALUES ('13', '58');
INSERT INTO sm_user_func VALUES ('13', '59');
INSERT INTO sm_user_func VALUES ('13', '60');
INSERT INTO sm_user_func VALUES ('13', '61');
INSERT INTO sm_user_func VALUES ('13', '62');
INSERT INTO sm_user_func VALUES ('13', '63');
INSERT INTO sm_user_func VALUES ('13', '64');
INSERT INTO sm_user_func VALUES ('13', '65');
INSERT INTO sm_user_func VALUES ('13', '66');
INSERT INTO sm_user_func VALUES ('13', '67');
INSERT INTO sm_user_func VALUES ('13', '68');
INSERT INTO sm_user_func VALUES ('13', '69');
INSERT INTO sm_user_func VALUES ('13', '70');
INSERT INTO sm_user_func VALUES ('13', '71');
INSERT INTO sm_user_func VALUES ('13', '72');
INSERT INTO sm_user_func VALUES ('13', '73');
INSERT INTO sm_user_func VALUES ('13', '74');
INSERT INTO sm_user_func VALUES ('13', '75');
INSERT INTO sm_user_func VALUES ('13', '85');
INSERT INTO sm_user_func VALUES ('13', '86');
INSERT INTO sm_user_func VALUES ('13', '87');
INSERT INTO sm_user_func VALUES ('13', '88');
INSERT INTO sm_user_func VALUES ('13', '89');
INSERT INTO sm_user_func VALUES ('13', '90');
INSERT INTO sm_user_func VALUES ('13', '91');
INSERT INTO sm_user_func VALUES ('13', '92');
INSERT INTO sm_user_func VALUES ('13', '93');
INSERT INTO sm_user_func VALUES ('13', '94');
INSERT INTO sm_user_func VALUES ('13', '95');
INSERT INTO sm_user_func VALUES ('13', '97');
INSERT INTO sm_user_func VALUES ('13', '98');
INSERT INTO sm_user_func VALUES ('13', '99');
INSERT INTO sm_user_func VALUES ('13', '100');
INSERT INTO sm_user_func VALUES ('13', '106');
INSERT INTO sm_user_func VALUES ('13', '107');
INSERT INTO sm_user_func VALUES ('13', '108');
INSERT INTO sm_user_func VALUES ('13', '109');
INSERT INTO sm_user_func VALUES ('13', '110');
INSERT INTO sm_user_func VALUES ('13', '111');
INSERT INTO sm_user_func VALUES ('13', '112');
INSERT INTO sm_user_func VALUES ('13', '113');
INSERT INTO sm_user_func VALUES ('13', '114');
INSERT INTO sm_user_func VALUES ('13', '115');
INSERT INTO sm_user_func VALUES ('13', '116');
INSERT INTO sm_user_func VALUES ('13', '117');
INSERT INTO sm_user_func VALUES ('13', '120');
INSERT INTO sm_user_func VALUES ('13', '121');
INSERT INTO sm_user_func VALUES ('13', '122');
INSERT INTO sm_user_func VALUES ('13', '123');
INSERT INTO sm_user_func VALUES ('13', '124');
INSERT INTO sm_user_func VALUES ('13', '126');
INSERT INTO sm_user_func VALUES ('13', '127');
INSERT INTO sm_user_func VALUES ('13', '128');
INSERT INTO sm_user_func VALUES ('13', '129');
INSERT INTO sm_user_func VALUES ('13', '130');
INSERT INTO sm_user_func VALUES ('13', '131');
INSERT INTO sm_user_func VALUES ('13', '134');
INSERT INTO sm_user_func VALUES ('13', '135');
INSERT INTO sm_user_func VALUES ('13', '136');
INSERT INTO sm_user_func VALUES ('13', '137');
INSERT INTO sm_user_func VALUES ('13', '138');
INSERT INTO sm_user_func VALUES ('13', '139');
INSERT INTO sm_user_func VALUES ('13', '140');
INSERT INTO sm_user_func VALUES ('13', '141');
INSERT INTO sm_user_func VALUES ('13', '142');
INSERT INTO sm_user_func VALUES ('13', '145');
INSERT INTO sm_user_func VALUES ('13', '146');
INSERT INTO sm_user_func VALUES ('13', '147');
INSERT INTO sm_user_func VALUES ('13', '148');
INSERT INTO sm_user_func VALUES ('13', '149');
INSERT INTO sm_user_func VALUES ('13', '150');
INSERT INTO sm_user_func VALUES ('13', '151');
INSERT INTO sm_user_func VALUES ('13', '152');
INSERT INTO sm_user_func VALUES ('13', '153');
INSERT INTO sm_user_func VALUES ('13', '154');
INSERT INTO sm_user_func VALUES ('13', '155');
INSERT INTO sm_user_func VALUES ('13', '156');
INSERT INTO sm_user_func VALUES ('13', '157');
INSERT INTO sm_user_func VALUES ('13', '158');
INSERT INTO sm_user_func VALUES ('13', '159');
INSERT INTO sm_user_func VALUES ('13', '160');
INSERT INTO sm_user_func VALUES ('13', '161');
INSERT INTO sm_user_func VALUES ('13', '162');
INSERT INTO sm_user_func VALUES ('13', '163');
INSERT INTO sm_user_func VALUES ('13', '164');
INSERT INTO sm_user_func VALUES ('13', '165');
INSERT INTO sm_user_func VALUES ('13', '166');
INSERT INTO sm_user_func VALUES ('13', '167');
INSERT INTO sm_user_func VALUES ('13', '168');
INSERT INTO sm_user_func VALUES ('13', '169');
INSERT INTO sm_user_func VALUES ('13', '170');
INSERT INTO sm_user_func VALUES ('13', '171');
INSERT INTO sm_user_func VALUES ('13', '172');
INSERT INTO sm_user_func VALUES ('13', '173');
INSERT INTO sm_user_func VALUES ('13', '174');
INSERT INTO sm_user_func VALUES ('13', '175');
INSERT INTO sm_user_func VALUES ('13', '176');
INSERT INTO sm_user_func VALUES ('13', '177');
INSERT INTO sm_user_func VALUES ('13', '178');
INSERT INTO sm_user_func VALUES ('13', '179');
INSERT INTO sm_user_func VALUES ('13', '180');
INSERT INTO sm_user_func VALUES ('13', '181');
INSERT INTO sm_user_func VALUES ('13', '182');
INSERT INTO sm_user_func VALUES ('13', '183');
INSERT INTO sm_user_func VALUES ('13', '184');
INSERT INTO sm_user_func VALUES ('13', '185');
INSERT INTO sm_user_func VALUES ('13', '186');
INSERT INTO sm_user_func VALUES ('13', '187');
INSERT INTO sm_user_func VALUES ('13', '188');
INSERT INTO sm_user_func VALUES ('13', '189');
INSERT INTO sm_user_func VALUES ('13', '190');
INSERT INTO sm_user_func VALUES ('13', '191');
INSERT INTO sm_user_func VALUES ('13', '194');
INSERT INTO sm_user_func VALUES ('13', '195');
INSERT INTO sm_user_func VALUES ('13', '196');
INSERT INTO sm_user_func VALUES ('13', '197');
INSERT INTO sm_user_func VALUES ('13', '198');
INSERT INTO sm_user_func VALUES ('13', '199');
INSERT INTO sm_user_func VALUES ('13', '200');
INSERT INTO sm_user_func VALUES ('13', '202');
INSERT INTO sm_user_func VALUES ('13', '203');
INSERT INTO sm_user_func VALUES ('13', '204');
INSERT INTO sm_user_func VALUES ('13', '206');
INSERT INTO sm_user_func VALUES ('13', '207');
INSERT INTO sm_user_func VALUES ('13', '208');
INSERT INTO sm_user_func VALUES ('13', '209');
INSERT INTO sm_user_func VALUES ('13', '210');
INSERT INTO sm_user_func VALUES ('13', '211');
INSERT INTO sm_user_func VALUES ('13', '212');
INSERT INTO sm_user_func VALUES ('13', '213');
INSERT INTO sm_user_func VALUES ('13', '214');
INSERT INTO sm_user_func VALUES ('13', '215');
INSERT INTO sm_user_func VALUES ('13', '216');
INSERT INTO sm_user_func VALUES ('13', '222');
INSERT INTO sm_user_func VALUES ('13', '223');
INSERT INTO sm_user_func VALUES ('13', '224');
INSERT INTO sm_user_func VALUES ('13', '225');
INSERT INTO sm_user_func VALUES ('13', '226');
INSERT INTO sm_user_func VALUES ('13', '227');
INSERT INTO sm_user_func VALUES ('13', '228');
INSERT INTO sm_user_func VALUES ('13', '229');
INSERT INTO sm_user_func VALUES ('13', '230');
INSERT INTO sm_user_func VALUES ('13', '231');
INSERT INTO sm_user_func VALUES ('13', '232');
INSERT INTO sm_user_func VALUES ('13', '234');
INSERT INTO sm_user_func VALUES ('13', '236');
INSERT INTO sm_user_func VALUES ('13', '237');
INSERT INTO sm_user_func VALUES ('13', '238');
INSERT INTO sm_user_func VALUES ('13', '239');
INSERT INTO sm_user_func VALUES ('13', '305');
INSERT INTO sm_user_func VALUES ('13', '306');
INSERT INTO sm_user_func VALUES ('13', '307');
INSERT INTO sm_user_func VALUES ('13', '309');
INSERT INTO sm_user_func VALUES ('13', '310');
INSERT INTO sm_user_func VALUES ('13', '311');
INSERT INTO sm_user_func VALUES ('13', '312');
INSERT INTO sm_user_func VALUES ('13', '313');
INSERT INTO sm_user_func VALUES ('13', '314');
INSERT INTO sm_user_func VALUES ('13', '315');
INSERT INTO sm_user_func VALUES ('13', '316');
INSERT INTO sm_user_func VALUES ('13', '318');
INSERT INTO sm_user_func VALUES ('13', '319');
INSERT INTO sm_user_func VALUES ('13', '320');
INSERT INTO sm_user_func VALUES ('13', '321');
INSERT INTO sm_user_func VALUES ('13', '322');
INSERT INTO sm_user_func VALUES ('13', '323');
INSERT INTO sm_user_func VALUES ('13', '324');
INSERT INTO sm_user_func VALUES ('13', '325');
INSERT INTO sm_user_func VALUES ('13', '326');
INSERT INTO sm_user_func VALUES ('13', '327');
INSERT INTO sm_user_func VALUES ('13', '328');
INSERT INTO sm_user_func VALUES ('13', '329');
INSERT INTO sm_user_func VALUES ('14', '7');
INSERT INTO sm_user_func VALUES ('14', '8');
INSERT INTO sm_user_func VALUES ('14', '9');
INSERT INTO sm_user_func VALUES ('14', '10');
INSERT INTO sm_user_func VALUES ('14', '11');
INSERT INTO sm_user_func VALUES ('14', '13');
INSERT INTO sm_user_func VALUES ('14', '14');
INSERT INTO sm_user_func VALUES ('14', '15');
INSERT INTO sm_user_func VALUES ('14', '16');
INSERT INTO sm_user_func VALUES ('14', '17');
INSERT INTO sm_user_func VALUES ('14', '19');
INSERT INTO sm_user_func VALUES ('14', '20');
INSERT INTO sm_user_func VALUES ('14', '21');
INSERT INTO sm_user_func VALUES ('14', '22');
INSERT INTO sm_user_func VALUES ('14', '23');
INSERT INTO sm_user_func VALUES ('14', '24');
INSERT INTO sm_user_func VALUES ('14', '26');
INSERT INTO sm_user_func VALUES ('14', '27');
INSERT INTO sm_user_func VALUES ('14', '28');
INSERT INTO sm_user_func VALUES ('14', '29');
INSERT INTO sm_user_func VALUES ('14', '30');
INSERT INTO sm_user_func VALUES ('14', '31');
INSERT INTO sm_user_func VALUES ('14', '32');
INSERT INTO sm_user_func VALUES ('14', '33');
INSERT INTO sm_user_func VALUES ('14', '34');
INSERT INTO sm_user_func VALUES ('14', '35');
INSERT INTO sm_user_func VALUES ('14', '36');
INSERT INTO sm_user_func VALUES ('14', '37');
INSERT INTO sm_user_func VALUES ('14', '38');
INSERT INTO sm_user_func VALUES ('14', '39');
INSERT INTO sm_user_func VALUES ('14', '40');
INSERT INTO sm_user_func VALUES ('14', '41');
INSERT INTO sm_user_func VALUES ('14', '42');
INSERT INTO sm_user_func VALUES ('14', '43');
INSERT INTO sm_user_func VALUES ('14', '44');
INSERT INTO sm_user_func VALUES ('14', '45');
INSERT INTO sm_user_func VALUES ('14', '46');
INSERT INTO sm_user_func VALUES ('14', '47');
INSERT INTO sm_user_func VALUES ('14', '48');
INSERT INTO sm_user_func VALUES ('14', '49');
INSERT INTO sm_user_func VALUES ('14', '50');
INSERT INTO sm_user_func VALUES ('14', '52');
INSERT INTO sm_user_func VALUES ('14', '53');
INSERT INTO sm_user_func VALUES ('14', '54');
INSERT INTO sm_user_func VALUES ('14', '55');
INSERT INTO sm_user_func VALUES ('14', '56');
INSERT INTO sm_user_func VALUES ('14', '57');
INSERT INTO sm_user_func VALUES ('14', '58');
INSERT INTO sm_user_func VALUES ('14', '59');
INSERT INTO sm_user_func VALUES ('14', '60');
INSERT INTO sm_user_func VALUES ('14', '61');
INSERT INTO sm_user_func VALUES ('14', '62');
INSERT INTO sm_user_func VALUES ('14', '63');
INSERT INTO sm_user_func VALUES ('14', '64');
INSERT INTO sm_user_func VALUES ('14', '65');
INSERT INTO sm_user_func VALUES ('14', '66');
INSERT INTO sm_user_func VALUES ('14', '67');
INSERT INTO sm_user_func VALUES ('14', '68');
INSERT INTO sm_user_func VALUES ('14', '69');
INSERT INTO sm_user_func VALUES ('14', '70');
INSERT INTO sm_user_func VALUES ('14', '71');
INSERT INTO sm_user_func VALUES ('14', '72');
INSERT INTO sm_user_func VALUES ('14', '73');
INSERT INTO sm_user_func VALUES ('14', '74');
INSERT INTO sm_user_func VALUES ('14', '75');
INSERT INTO sm_user_func VALUES ('14', '85');
INSERT INTO sm_user_func VALUES ('14', '86');
INSERT INTO sm_user_func VALUES ('14', '87');
INSERT INTO sm_user_func VALUES ('14', '88');
INSERT INTO sm_user_func VALUES ('14', '89');
INSERT INTO sm_user_func VALUES ('14', '90');
INSERT INTO sm_user_func VALUES ('14', '91');
INSERT INTO sm_user_func VALUES ('14', '92');
INSERT INTO sm_user_func VALUES ('14', '93');
INSERT INTO sm_user_func VALUES ('14', '94');
INSERT INTO sm_user_func VALUES ('14', '95');
INSERT INTO sm_user_func VALUES ('14', '97');
INSERT INTO sm_user_func VALUES ('14', '98');
INSERT INTO sm_user_func VALUES ('14', '99');
INSERT INTO sm_user_func VALUES ('14', '100');
INSERT INTO sm_user_func VALUES ('14', '106');
INSERT INTO sm_user_func VALUES ('14', '107');
INSERT INTO sm_user_func VALUES ('14', '108');
INSERT INTO sm_user_func VALUES ('14', '109');
INSERT INTO sm_user_func VALUES ('14', '110');
INSERT INTO sm_user_func VALUES ('14', '117');
INSERT INTO sm_user_func VALUES ('14', '120');
INSERT INTO sm_user_func VALUES ('14', '121');
INSERT INTO sm_user_func VALUES ('14', '122');
INSERT INTO sm_user_func VALUES ('14', '123');
INSERT INTO sm_user_func VALUES ('14', '124');
INSERT INTO sm_user_func VALUES ('14', '126');
INSERT INTO sm_user_func VALUES ('14', '127');
INSERT INTO sm_user_func VALUES ('14', '128');
INSERT INTO sm_user_func VALUES ('14', '129');
INSERT INTO sm_user_func VALUES ('14', '130');
INSERT INTO sm_user_func VALUES ('14', '131');
INSERT INTO sm_user_func VALUES ('14', '170');
INSERT INTO sm_user_func VALUES ('14', '171');
INSERT INTO sm_user_func VALUES ('14', '172');
INSERT INTO sm_user_func VALUES ('14', '173');
INSERT INTO sm_user_func VALUES ('14', '174');
INSERT INTO sm_user_func VALUES ('14', '175');
INSERT INTO sm_user_func VALUES ('14', '176');
INSERT INTO sm_user_func VALUES ('14', '194');
INSERT INTO sm_user_func VALUES ('14', '195');
INSERT INTO sm_user_func VALUES ('14', '196');
INSERT INTO sm_user_func VALUES ('14', '197');
INSERT INTO sm_user_func VALUES ('14', '198');
INSERT INTO sm_user_func VALUES ('14', '199');
INSERT INTO sm_user_func VALUES ('14', '200');
INSERT INTO sm_user_func VALUES ('14', '202');
INSERT INTO sm_user_func VALUES ('14', '203');
INSERT INTO sm_user_func VALUES ('14', '204');
INSERT INTO sm_user_func VALUES ('14', '206');
INSERT INTO sm_user_func VALUES ('14', '207');
INSERT INTO sm_user_func VALUES ('14', '208');
INSERT INTO sm_user_func VALUES ('14', '209');
INSERT INTO sm_user_func VALUES ('14', '210');
INSERT INTO sm_user_func VALUES ('14', '211');
INSERT INTO sm_user_func VALUES ('14', '212');
INSERT INTO sm_user_func VALUES ('14', '213');
INSERT INTO sm_user_func VALUES ('14', '238');
INSERT INTO sm_user_func VALUES ('14', '239');
INSERT INTO sm_user_func VALUES ('14', '309');
INSERT INTO sm_user_func VALUES ('14', '312');
INSERT INTO sm_user_func VALUES ('14', '313');
INSERT INTO sm_user_func VALUES ('14', '314');
INSERT INTO sm_user_func VALUES ('14', '315');
INSERT INTO sm_user_func VALUES ('14', '316');
INSERT INTO sm_user_func VALUES ('14', '319');
INSERT INTO sm_user_func VALUES ('14', '320');
INSERT INTO sm_user_func VALUES ('14', '321');
INSERT INTO sm_user_func VALUES ('14', '322');
INSERT INTO sm_user_func VALUES ('14', '323');
INSERT INTO sm_user_func VALUES ('14', '324');
INSERT INTO sm_user_func VALUES ('14', '325');
INSERT INTO sm_user_func VALUES ('14', '326');
INSERT INTO sm_user_func VALUES ('14', '327');
INSERT INTO sm_user_func VALUES ('14', '328');
INSERT INTO sm_user_func VALUES ('14', '329');
INSERT INTO sm_user_func VALUES ('16', '7');
INSERT INTO sm_user_func VALUES ('16', '8');
INSERT INTO sm_user_func VALUES ('16', '9');
INSERT INTO sm_user_func VALUES ('16', '10');
INSERT INTO sm_user_func VALUES ('16', '11');
INSERT INTO sm_user_func VALUES ('16', '13');
INSERT INTO sm_user_func VALUES ('16', '14');
INSERT INTO sm_user_func VALUES ('16', '15');
INSERT INTO sm_user_func VALUES ('16', '16');
INSERT INTO sm_user_func VALUES ('16', '17');
INSERT INTO sm_user_func VALUES ('16', '19');
INSERT INTO sm_user_func VALUES ('16', '20');
INSERT INTO sm_user_func VALUES ('16', '21');
INSERT INTO sm_user_func VALUES ('16', '22');
INSERT INTO sm_user_func VALUES ('16', '23');
INSERT INTO sm_user_func VALUES ('16', '24');
INSERT INTO sm_user_func VALUES ('16', '26');
INSERT INTO sm_user_func VALUES ('16', '27');
INSERT INTO sm_user_func VALUES ('16', '28');
INSERT INTO sm_user_func VALUES ('16', '29');
INSERT INTO sm_user_func VALUES ('16', '30');
INSERT INTO sm_user_func VALUES ('16', '31');
INSERT INTO sm_user_func VALUES ('16', '32');
INSERT INTO sm_user_func VALUES ('16', '33');
INSERT INTO sm_user_func VALUES ('16', '34');
INSERT INTO sm_user_func VALUES ('16', '35');
INSERT INTO sm_user_func VALUES ('16', '36');
INSERT INTO sm_user_func VALUES ('16', '37');
INSERT INTO sm_user_func VALUES ('16', '38');
INSERT INTO sm_user_func VALUES ('16', '39');
INSERT INTO sm_user_func VALUES ('16', '40');
INSERT INTO sm_user_func VALUES ('16', '41');
INSERT INTO sm_user_func VALUES ('16', '42');
INSERT INTO sm_user_func VALUES ('16', '43');
INSERT INTO sm_user_func VALUES ('16', '44');
INSERT INTO sm_user_func VALUES ('16', '45');
INSERT INTO sm_user_func VALUES ('16', '46');
INSERT INTO sm_user_func VALUES ('16', '47');
INSERT INTO sm_user_func VALUES ('16', '48');
INSERT INTO sm_user_func VALUES ('16', '49');
INSERT INTO sm_user_func VALUES ('16', '50');
INSERT INTO sm_user_func VALUES ('16', '52');
INSERT INTO sm_user_func VALUES ('16', '53');
INSERT INTO sm_user_func VALUES ('16', '54');
INSERT INTO sm_user_func VALUES ('16', '55');
INSERT INTO sm_user_func VALUES ('16', '56');
INSERT INTO sm_user_func VALUES ('16', '89');
INSERT INTO sm_user_func VALUES ('16', '90');
INSERT INTO sm_user_func VALUES ('16', '91');
INSERT INTO sm_user_func VALUES ('16', '92');
INSERT INTO sm_user_func VALUES ('16', '93');
INSERT INTO sm_user_func VALUES ('16', '94');
INSERT INTO sm_user_func VALUES ('16', '95');
INSERT INTO sm_user_func VALUES ('16', '97');
INSERT INTO sm_user_func VALUES ('16', '98');
INSERT INTO sm_user_func VALUES ('16', '99');
INSERT INTO sm_user_func VALUES ('16', '100');
INSERT INTO sm_user_func VALUES ('16', '106');
INSERT INTO sm_user_func VALUES ('16', '107');
INSERT INTO sm_user_func VALUES ('16', '108');
INSERT INTO sm_user_func VALUES ('16', '109');
INSERT INTO sm_user_func VALUES ('16', '110');
INSERT INTO sm_user_func VALUES ('16', '117');
INSERT INTO sm_user_func VALUES ('16', '120');
INSERT INTO sm_user_func VALUES ('16', '121');
INSERT INTO sm_user_func VALUES ('16', '122');
INSERT INTO sm_user_func VALUES ('16', '123');
INSERT INTO sm_user_func VALUES ('16', '124');
INSERT INTO sm_user_func VALUES ('16', '126');
INSERT INTO sm_user_func VALUES ('16', '127');
INSERT INTO sm_user_func VALUES ('16', '128');
INSERT INTO sm_user_func VALUES ('16', '129');
INSERT INTO sm_user_func VALUES ('16', '130');
INSERT INTO sm_user_func VALUES ('16', '131');
INSERT INTO sm_user_func VALUES ('16', '134');
INSERT INTO sm_user_func VALUES ('16', '135');
INSERT INTO sm_user_func VALUES ('16', '136');
INSERT INTO sm_user_func VALUES ('16', '137');
INSERT INTO sm_user_func VALUES ('16', '138');
INSERT INTO sm_user_func VALUES ('16', '139');
INSERT INTO sm_user_func VALUES ('16', '140');
INSERT INTO sm_user_func VALUES ('16', '141');
INSERT INTO sm_user_func VALUES ('16', '142');
INSERT INTO sm_user_func VALUES ('16', '145');
INSERT INTO sm_user_func VALUES ('16', '146');
INSERT INTO sm_user_func VALUES ('16', '147');
INSERT INTO sm_user_func VALUES ('16', '148');
INSERT INTO sm_user_func VALUES ('16', '149');
INSERT INTO sm_user_func VALUES ('16', '150');
INSERT INTO sm_user_func VALUES ('16', '151');
INSERT INTO sm_user_func VALUES ('16', '152');
INSERT INTO sm_user_func VALUES ('16', '153');
INSERT INTO sm_user_func VALUES ('16', '154');
INSERT INTO sm_user_func VALUES ('16', '155');
INSERT INTO sm_user_func VALUES ('16', '156');
INSERT INTO sm_user_func VALUES ('16', '157');
INSERT INTO sm_user_func VALUES ('16', '177');
INSERT INTO sm_user_func VALUES ('16', '178');
INSERT INTO sm_user_func VALUES ('16', '179');
INSERT INTO sm_user_func VALUES ('16', '180');
INSERT INTO sm_user_func VALUES ('16', '181');
INSERT INTO sm_user_func VALUES ('16', '182');
INSERT INTO sm_user_func VALUES ('16', '186');
INSERT INTO sm_user_func VALUES ('16', '187');
INSERT INTO sm_user_func VALUES ('16', '188');
INSERT INTO sm_user_func VALUES ('16', '189');
INSERT INTO sm_user_func VALUES ('16', '190');
INSERT INTO sm_user_func VALUES ('16', '194');
INSERT INTO sm_user_func VALUES ('16', '195');
INSERT INTO sm_user_func VALUES ('16', '196');
INSERT INTO sm_user_func VALUES ('16', '197');
INSERT INTO sm_user_func VALUES ('16', '198');
INSERT INTO sm_user_func VALUES ('16', '199');
INSERT INTO sm_user_func VALUES ('16', '200');
INSERT INTO sm_user_func VALUES ('16', '202');
INSERT INTO sm_user_func VALUES ('16', '203');
INSERT INTO sm_user_func VALUES ('16', '204');
INSERT INTO sm_user_func VALUES ('16', '206');
INSERT INTO sm_user_func VALUES ('16', '207');
INSERT INTO sm_user_func VALUES ('16', '238');
INSERT INTO sm_user_func VALUES ('16', '239');
INSERT INTO sm_user_func VALUES ('16', '309');
INSERT INTO sm_user_func VALUES ('16', '319');
INSERT INTO sm_user_func VALUES ('16', '320');
INSERT INTO sm_user_func VALUES ('16', '321');
INSERT INTO sm_user_func VALUES ('16', '322');
INSERT INTO sm_user_func VALUES ('16', '323');
INSERT INTO sm_user_func VALUES ('16', '324');
INSERT INTO sm_user_func VALUES ('16', '325');
INSERT INTO sm_user_func VALUES ('16', '326');
INSERT INTO sm_user_func VALUES ('16', '327');
INSERT INTO sm_user_func VALUES ('16', '328');
INSERT INTO sm_user_func VALUES ('16', '329');
INSERT INTO sm_user_func VALUES ('17', '7');
INSERT INTO sm_user_func VALUES ('17', '8');
INSERT INTO sm_user_func VALUES ('17', '9');
INSERT INTO sm_user_func VALUES ('17', '10');
INSERT INTO sm_user_func VALUES ('17', '11');
INSERT INTO sm_user_func VALUES ('17', '13');
INSERT INTO sm_user_func VALUES ('17', '14');
INSERT INTO sm_user_func VALUES ('17', '15');
INSERT INTO sm_user_func VALUES ('17', '16');
INSERT INTO sm_user_func VALUES ('17', '17');
INSERT INTO sm_user_func VALUES ('17', '19');
INSERT INTO sm_user_func VALUES ('17', '20');
INSERT INTO sm_user_func VALUES ('17', '21');
INSERT INTO sm_user_func VALUES ('17', '22');
INSERT INTO sm_user_func VALUES ('17', '23');
INSERT INTO sm_user_func VALUES ('17', '24');
INSERT INTO sm_user_func VALUES ('17', '26');
INSERT INTO sm_user_func VALUES ('17', '27');
INSERT INTO sm_user_func VALUES ('17', '28');
INSERT INTO sm_user_func VALUES ('17', '29');
INSERT INTO sm_user_func VALUES ('17', '30');
INSERT INTO sm_user_func VALUES ('17', '31');
INSERT INTO sm_user_func VALUES ('17', '32');
INSERT INTO sm_user_func VALUES ('17', '33');
INSERT INTO sm_user_func VALUES ('17', '34');
INSERT INTO sm_user_func VALUES ('17', '35');
INSERT INTO sm_user_func VALUES ('17', '36');
INSERT INTO sm_user_func VALUES ('17', '37');
INSERT INTO sm_user_func VALUES ('17', '38');
INSERT INTO sm_user_func VALUES ('17', '39');
INSERT INTO sm_user_func VALUES ('17', '40');
INSERT INTO sm_user_func VALUES ('17', '41');
INSERT INTO sm_user_func VALUES ('17', '42');
INSERT INTO sm_user_func VALUES ('17', '43');
INSERT INTO sm_user_func VALUES ('17', '44');
INSERT INTO sm_user_func VALUES ('17', '45');
INSERT INTO sm_user_func VALUES ('17', '46');
INSERT INTO sm_user_func VALUES ('17', '47');
INSERT INTO sm_user_func VALUES ('17', '48');
INSERT INTO sm_user_func VALUES ('17', '49');
INSERT INTO sm_user_func VALUES ('17', '50');
INSERT INTO sm_user_func VALUES ('17', '52');
INSERT INTO sm_user_func VALUES ('17', '53');
INSERT INTO sm_user_func VALUES ('17', '54');
INSERT INTO sm_user_func VALUES ('17', '55');
INSERT INTO sm_user_func VALUES ('17', '56');
INSERT INTO sm_user_func VALUES ('17', '57');
INSERT INTO sm_user_func VALUES ('17', '58');
INSERT INTO sm_user_func VALUES ('17', '59');
INSERT INTO sm_user_func VALUES ('17', '60');
INSERT INTO sm_user_func VALUES ('17', '61');
INSERT INTO sm_user_func VALUES ('17', '62');
INSERT INTO sm_user_func VALUES ('17', '63');
INSERT INTO sm_user_func VALUES ('17', '64');
INSERT INTO sm_user_func VALUES ('17', '65');
INSERT INTO sm_user_func VALUES ('17', '66');
INSERT INTO sm_user_func VALUES ('17', '67');
INSERT INTO sm_user_func VALUES ('17', '68');
INSERT INTO sm_user_func VALUES ('17', '69');
INSERT INTO sm_user_func VALUES ('17', '70');
INSERT INTO sm_user_func VALUES ('17', '71');
INSERT INTO sm_user_func VALUES ('17', '72');
INSERT INTO sm_user_func VALUES ('17', '73');
INSERT INTO sm_user_func VALUES ('17', '74');
INSERT INTO sm_user_func VALUES ('17', '75');
INSERT INTO sm_user_func VALUES ('17', '85');
INSERT INTO sm_user_func VALUES ('17', '86');
INSERT INTO sm_user_func VALUES ('17', '87');
INSERT INTO sm_user_func VALUES ('17', '88');
INSERT INTO sm_user_func VALUES ('17', '89');
INSERT INTO sm_user_func VALUES ('17', '90');
INSERT INTO sm_user_func VALUES ('17', '91');
INSERT INTO sm_user_func VALUES ('17', '92');
INSERT INTO sm_user_func VALUES ('17', '93');
INSERT INTO sm_user_func VALUES ('17', '94');
INSERT INTO sm_user_func VALUES ('17', '95');
INSERT INTO sm_user_func VALUES ('17', '97');
INSERT INTO sm_user_func VALUES ('17', '98');
INSERT INTO sm_user_func VALUES ('17', '99');
INSERT INTO sm_user_func VALUES ('17', '100');
INSERT INTO sm_user_func VALUES ('17', '106');
INSERT INTO sm_user_func VALUES ('17', '107');
INSERT INTO sm_user_func VALUES ('17', '108');
INSERT INTO sm_user_func VALUES ('17', '109');
INSERT INTO sm_user_func VALUES ('17', '110');
INSERT INTO sm_user_func VALUES ('17', '111');
INSERT INTO sm_user_func VALUES ('17', '112');
INSERT INTO sm_user_func VALUES ('17', '113');
INSERT INTO sm_user_func VALUES ('17', '114');
INSERT INTO sm_user_func VALUES ('17', '115');
INSERT INTO sm_user_func VALUES ('17', '116');
INSERT INTO sm_user_func VALUES ('17', '117');
INSERT INTO sm_user_func VALUES ('17', '120');
INSERT INTO sm_user_func VALUES ('17', '121');
INSERT INTO sm_user_func VALUES ('17', '122');
INSERT INTO sm_user_func VALUES ('17', '123');
INSERT INTO sm_user_func VALUES ('17', '124');
INSERT INTO sm_user_func VALUES ('17', '126');
INSERT INTO sm_user_func VALUES ('17', '127');
INSERT INTO sm_user_func VALUES ('17', '128');
INSERT INTO sm_user_func VALUES ('17', '129');
INSERT INTO sm_user_func VALUES ('17', '130');
INSERT INTO sm_user_func VALUES ('17', '131');
INSERT INTO sm_user_func VALUES ('17', '134');
INSERT INTO sm_user_func VALUES ('17', '135');
INSERT INTO sm_user_func VALUES ('17', '136');
INSERT INTO sm_user_func VALUES ('17', '137');
INSERT INTO sm_user_func VALUES ('17', '138');
INSERT INTO sm_user_func VALUES ('17', '139');
INSERT INTO sm_user_func VALUES ('17', '140');
INSERT INTO sm_user_func VALUES ('17', '141');
INSERT INTO sm_user_func VALUES ('17', '142');
INSERT INTO sm_user_func VALUES ('17', '145');
INSERT INTO sm_user_func VALUES ('17', '146');
INSERT INTO sm_user_func VALUES ('17', '147');
INSERT INTO sm_user_func VALUES ('17', '148');
INSERT INTO sm_user_func VALUES ('17', '149');
INSERT INTO sm_user_func VALUES ('17', '150');
INSERT INTO sm_user_func VALUES ('17', '151');
INSERT INTO sm_user_func VALUES ('17', '152');
INSERT INTO sm_user_func VALUES ('17', '153');
INSERT INTO sm_user_func VALUES ('17', '154');
INSERT INTO sm_user_func VALUES ('17', '155');
INSERT INTO sm_user_func VALUES ('17', '156');
INSERT INTO sm_user_func VALUES ('17', '157');
INSERT INTO sm_user_func VALUES ('17', '158');
INSERT INTO sm_user_func VALUES ('17', '159');
INSERT INTO sm_user_func VALUES ('17', '160');
INSERT INTO sm_user_func VALUES ('17', '161');
INSERT INTO sm_user_func VALUES ('17', '162');
INSERT INTO sm_user_func VALUES ('17', '163');
INSERT INTO sm_user_func VALUES ('17', '164');
INSERT INTO sm_user_func VALUES ('17', '165');
INSERT INTO sm_user_func VALUES ('17', '166');
INSERT INTO sm_user_func VALUES ('17', '167');
INSERT INTO sm_user_func VALUES ('17', '168');
INSERT INTO sm_user_func VALUES ('17', '169');
INSERT INTO sm_user_func VALUES ('17', '170');
INSERT INTO sm_user_func VALUES ('17', '171');
INSERT INTO sm_user_func VALUES ('17', '172');
INSERT INTO sm_user_func VALUES ('17', '173');
INSERT INTO sm_user_func VALUES ('17', '174');
INSERT INTO sm_user_func VALUES ('17', '175');
INSERT INTO sm_user_func VALUES ('17', '176');
INSERT INTO sm_user_func VALUES ('17', '177');
INSERT INTO sm_user_func VALUES ('17', '178');
INSERT INTO sm_user_func VALUES ('17', '179');
INSERT INTO sm_user_func VALUES ('17', '180');
INSERT INTO sm_user_func VALUES ('17', '181');
INSERT INTO sm_user_func VALUES ('17', '182');
INSERT INTO sm_user_func VALUES ('17', '183');
INSERT INTO sm_user_func VALUES ('17', '184');
INSERT INTO sm_user_func VALUES ('17', '185');
INSERT INTO sm_user_func VALUES ('17', '186');
INSERT INTO sm_user_func VALUES ('17', '187');
INSERT INTO sm_user_func VALUES ('17', '188');
INSERT INTO sm_user_func VALUES ('17', '189');
INSERT INTO sm_user_func VALUES ('17', '190');
INSERT INTO sm_user_func VALUES ('17', '191');
INSERT INTO sm_user_func VALUES ('17', '194');
INSERT INTO sm_user_func VALUES ('17', '195');
INSERT INTO sm_user_func VALUES ('17', '196');
INSERT INTO sm_user_func VALUES ('17', '197');
INSERT INTO sm_user_func VALUES ('17', '198');
INSERT INTO sm_user_func VALUES ('17', '199');
INSERT INTO sm_user_func VALUES ('17', '200');
INSERT INTO sm_user_func VALUES ('17', '202');
INSERT INTO sm_user_func VALUES ('17', '203');
INSERT INTO sm_user_func VALUES ('17', '204');
INSERT INTO sm_user_func VALUES ('17', '206');
INSERT INTO sm_user_func VALUES ('17', '207');
INSERT INTO sm_user_func VALUES ('17', '208');
INSERT INTO sm_user_func VALUES ('17', '209');
INSERT INTO sm_user_func VALUES ('17', '210');
INSERT INTO sm_user_func VALUES ('17', '211');
INSERT INTO sm_user_func VALUES ('17', '212');
INSERT INTO sm_user_func VALUES ('17', '213');
INSERT INTO sm_user_func VALUES ('17', '214');
INSERT INTO sm_user_func VALUES ('17', '215');
INSERT INTO sm_user_func VALUES ('17', '216');
INSERT INTO sm_user_func VALUES ('17', '222');
INSERT INTO sm_user_func VALUES ('17', '223');
INSERT INTO sm_user_func VALUES ('17', '224');
INSERT INTO sm_user_func VALUES ('17', '225');
INSERT INTO sm_user_func VALUES ('17', '226');
INSERT INTO sm_user_func VALUES ('17', '227');
INSERT INTO sm_user_func VALUES ('17', '228');
INSERT INTO sm_user_func VALUES ('17', '229');
INSERT INTO sm_user_func VALUES ('17', '230');
INSERT INTO sm_user_func VALUES ('17', '231');
INSERT INTO sm_user_func VALUES ('17', '232');
INSERT INTO sm_user_func VALUES ('17', '234');
INSERT INTO sm_user_func VALUES ('17', '236');
INSERT INTO sm_user_func VALUES ('17', '237');
INSERT INTO sm_user_func VALUES ('17', '238');
INSERT INTO sm_user_func VALUES ('17', '239');
INSERT INTO sm_user_func VALUES ('17', '305');
INSERT INTO sm_user_func VALUES ('17', '306');
INSERT INTO sm_user_func VALUES ('17', '307');
INSERT INTO sm_user_func VALUES ('17', '309');
INSERT INTO sm_user_func VALUES ('17', '310');
INSERT INTO sm_user_func VALUES ('17', '311');
INSERT INTO sm_user_func VALUES ('17', '312');
INSERT INTO sm_user_func VALUES ('17', '313');
INSERT INTO sm_user_func VALUES ('17', '314');
INSERT INTO sm_user_func VALUES ('17', '315');
INSERT INTO sm_user_func VALUES ('17', '316');
INSERT INTO sm_user_func VALUES ('17', '318');
INSERT INTO sm_user_func VALUES ('17', '319');
INSERT INTO sm_user_func VALUES ('17', '320');
INSERT INTO sm_user_func VALUES ('17', '321');
INSERT INTO sm_user_func VALUES ('17', '322');
INSERT INTO sm_user_func VALUES ('17', '323');
INSERT INTO sm_user_func VALUES ('17', '324');
INSERT INTO sm_user_func VALUES ('17', '325');
INSERT INTO sm_user_func VALUES ('17', '326');
INSERT INTO sm_user_func VALUES ('17', '327');
INSERT INTO sm_user_func VALUES ('17', '328');
INSERT INTO sm_user_func VALUES ('17', '329');
INSERT INTO sm_user_func VALUES ('20', '7');
INSERT INTO sm_user_func VALUES ('20', '8');
INSERT INTO sm_user_func VALUES ('20', '9');
INSERT INTO sm_user_func VALUES ('20', '10');
INSERT INTO sm_user_func VALUES ('20', '11');
INSERT INTO sm_user_func VALUES ('20', '13');
INSERT INTO sm_user_func VALUES ('20', '14');
INSERT INTO sm_user_func VALUES ('20', '15');
INSERT INTO sm_user_func VALUES ('20', '16');
INSERT INTO sm_user_func VALUES ('20', '17');
INSERT INTO sm_user_func VALUES ('20', '19');
INSERT INTO sm_user_func VALUES ('20', '20');
INSERT INTO sm_user_func VALUES ('20', '21');
INSERT INTO sm_user_func VALUES ('20', '22');
INSERT INTO sm_user_func VALUES ('20', '23');
INSERT INTO sm_user_func VALUES ('20', '24');
INSERT INTO sm_user_func VALUES ('20', '26');
INSERT INTO sm_user_func VALUES ('20', '27');
INSERT INTO sm_user_func VALUES ('20', '28');
INSERT INTO sm_user_func VALUES ('20', '29');
INSERT INTO sm_user_func VALUES ('20', '30');
INSERT INTO sm_user_func VALUES ('20', '31');
INSERT INTO sm_user_func VALUES ('20', '32');
INSERT INTO sm_user_func VALUES ('20', '33');
INSERT INTO sm_user_func VALUES ('20', '34');
INSERT INTO sm_user_func VALUES ('20', '35');
INSERT INTO sm_user_func VALUES ('20', '36');
INSERT INTO sm_user_func VALUES ('20', '37');
INSERT INTO sm_user_func VALUES ('20', '38');
INSERT INTO sm_user_func VALUES ('20', '39');
INSERT INTO sm_user_func VALUES ('20', '40');
INSERT INTO sm_user_func VALUES ('20', '41');
INSERT INTO sm_user_func VALUES ('20', '42');
INSERT INTO sm_user_func VALUES ('20', '43');
INSERT INTO sm_user_func VALUES ('20', '44');
INSERT INTO sm_user_func VALUES ('20', '45');
INSERT INTO sm_user_func VALUES ('20', '46');
INSERT INTO sm_user_func VALUES ('20', '47');
INSERT INTO sm_user_func VALUES ('20', '48');
INSERT INTO sm_user_func VALUES ('20', '49');
INSERT INTO sm_user_func VALUES ('20', '50');
INSERT INTO sm_user_func VALUES ('20', '52');
INSERT INTO sm_user_func VALUES ('20', '53');
INSERT INTO sm_user_func VALUES ('20', '54');
INSERT INTO sm_user_func VALUES ('20', '55');
INSERT INTO sm_user_func VALUES ('20', '56');
INSERT INTO sm_user_func VALUES ('20', '57');
INSERT INTO sm_user_func VALUES ('20', '58');
INSERT INTO sm_user_func VALUES ('20', '59');
INSERT INTO sm_user_func VALUES ('20', '60');
INSERT INTO sm_user_func VALUES ('20', '61');
INSERT INTO sm_user_func VALUES ('20', '62');
INSERT INTO sm_user_func VALUES ('20', '63');
INSERT INTO sm_user_func VALUES ('20', '64');
INSERT INTO sm_user_func VALUES ('20', '65');
INSERT INTO sm_user_func VALUES ('20', '66');
INSERT INTO sm_user_func VALUES ('20', '67');
INSERT INTO sm_user_func VALUES ('20', '68');
INSERT INTO sm_user_func VALUES ('20', '69');
INSERT INTO sm_user_func VALUES ('20', '70');
INSERT INTO sm_user_func VALUES ('20', '71');
INSERT INTO sm_user_func VALUES ('20', '72');
INSERT INTO sm_user_func VALUES ('20', '73');
INSERT INTO sm_user_func VALUES ('20', '74');
INSERT INTO sm_user_func VALUES ('20', '75');
INSERT INTO sm_user_func VALUES ('20', '85');
INSERT INTO sm_user_func VALUES ('20', '86');
INSERT INTO sm_user_func VALUES ('20', '87');
INSERT INTO sm_user_func VALUES ('20', '88');
INSERT INTO sm_user_func VALUES ('20', '89');
INSERT INTO sm_user_func VALUES ('20', '90');
INSERT INTO sm_user_func VALUES ('20', '91');
INSERT INTO sm_user_func VALUES ('20', '92');
INSERT INTO sm_user_func VALUES ('20', '93');
INSERT INTO sm_user_func VALUES ('20', '94');
INSERT INTO sm_user_func VALUES ('20', '95');
INSERT INTO sm_user_func VALUES ('20', '97');
INSERT INTO sm_user_func VALUES ('20', '98');
INSERT INTO sm_user_func VALUES ('20', '99');
INSERT INTO sm_user_func VALUES ('20', '100');
INSERT INTO sm_user_func VALUES ('20', '117');
INSERT INTO sm_user_func VALUES ('20', '120');
INSERT INTO sm_user_func VALUES ('20', '121');
INSERT INTO sm_user_func VALUES ('20', '122');
INSERT INTO sm_user_func VALUES ('20', '123');
INSERT INTO sm_user_func VALUES ('20', '124');
INSERT INTO sm_user_func VALUES ('20', '126');
INSERT INTO sm_user_func VALUES ('20', '127');
INSERT INTO sm_user_func VALUES ('20', '128');
INSERT INTO sm_user_func VALUES ('20', '129');
INSERT INTO sm_user_func VALUES ('20', '130');
INSERT INTO sm_user_func VALUES ('20', '131');
INSERT INTO sm_user_func VALUES ('20', '134');
INSERT INTO sm_user_func VALUES ('20', '135');
INSERT INTO sm_user_func VALUES ('20', '136');
INSERT INTO sm_user_func VALUES ('20', '137');
INSERT INTO sm_user_func VALUES ('20', '138');
INSERT INTO sm_user_func VALUES ('20', '139');
INSERT INTO sm_user_func VALUES ('20', '140');
INSERT INTO sm_user_func VALUES ('20', '141');
INSERT INTO sm_user_func VALUES ('20', '142');
INSERT INTO sm_user_func VALUES ('20', '145');
INSERT INTO sm_user_func VALUES ('20', '170');
INSERT INTO sm_user_func VALUES ('20', '171');
INSERT INTO sm_user_func VALUES ('20', '172');
INSERT INTO sm_user_func VALUES ('20', '173');
INSERT INTO sm_user_func VALUES ('20', '174');
INSERT INTO sm_user_func VALUES ('20', '175');
INSERT INTO sm_user_func VALUES ('20', '176');
INSERT INTO sm_user_func VALUES ('20', '177');
INSERT INTO sm_user_func VALUES ('20', '178');
INSERT INTO sm_user_func VALUES ('20', '179');
INSERT INTO sm_user_func VALUES ('20', '180');
INSERT INTO sm_user_func VALUES ('20', '181');
INSERT INTO sm_user_func VALUES ('20', '182');
INSERT INTO sm_user_func VALUES ('20', '183');
INSERT INTO sm_user_func VALUES ('20', '184');
INSERT INTO sm_user_func VALUES ('20', '185');
INSERT INTO sm_user_func VALUES ('20', '186');
INSERT INTO sm_user_func VALUES ('20', '187');
INSERT INTO sm_user_func VALUES ('20', '188');
INSERT INTO sm_user_func VALUES ('20', '189');
INSERT INTO sm_user_func VALUES ('20', '190');
INSERT INTO sm_user_func VALUES ('20', '194');
INSERT INTO sm_user_func VALUES ('20', '195');
INSERT INTO sm_user_func VALUES ('20', '196');
INSERT INTO sm_user_func VALUES ('20', '197');
INSERT INTO sm_user_func VALUES ('20', '198');
INSERT INTO sm_user_func VALUES ('20', '199');
INSERT INTO sm_user_func VALUES ('20', '200');
INSERT INTO sm_user_func VALUES ('20', '202');
INSERT INTO sm_user_func VALUES ('20', '203');
INSERT INTO sm_user_func VALUES ('20', '204');
INSERT INTO sm_user_func VALUES ('20', '206');
INSERT INTO sm_user_func VALUES ('20', '207');
INSERT INTO sm_user_func VALUES ('20', '208');
INSERT INTO sm_user_func VALUES ('20', '209');
INSERT INTO sm_user_func VALUES ('20', '210');
INSERT INTO sm_user_func VALUES ('20', '211');
INSERT INTO sm_user_func VALUES ('20', '212');
INSERT INTO sm_user_func VALUES ('20', '213');
INSERT INTO sm_user_func VALUES ('20', '214');
INSERT INTO sm_user_func VALUES ('20', '238');
INSERT INTO sm_user_func VALUES ('20', '239');
INSERT INTO sm_user_func VALUES ('20', '305');
INSERT INTO sm_user_func VALUES ('20', '306');
INSERT INTO sm_user_func VALUES ('20', '307');
INSERT INTO sm_user_func VALUES ('20', '309');
INSERT INTO sm_user_func VALUES ('20', '312');
INSERT INTO sm_user_func VALUES ('20', '313');
INSERT INTO sm_user_func VALUES ('20', '314');
INSERT INTO sm_user_func VALUES ('20', '315');
INSERT INTO sm_user_func VALUES ('20', '316');
INSERT INTO sm_user_func VALUES ('20', '319');
INSERT INTO sm_user_func VALUES ('20', '320');
INSERT INTO sm_user_func VALUES ('20', '321');
INSERT INTO sm_user_func VALUES ('20', '322');
INSERT INTO sm_user_func VALUES ('20', '323');
INSERT INTO sm_user_func VALUES ('20', '324');
INSERT INTO sm_user_func VALUES ('20', '325');
INSERT INTO sm_user_func VALUES ('20', '326');
INSERT INTO sm_user_func VALUES ('20', '327');
INSERT INTO sm_user_func VALUES ('20', '328');
INSERT INTO sm_user_func VALUES ('20', '329');
INSERT INTO sm_user_func VALUES ('21', '7');
INSERT INTO sm_user_func VALUES ('21', '8');
INSERT INTO sm_user_func VALUES ('21', '9');
INSERT INTO sm_user_func VALUES ('21', '10');
INSERT INTO sm_user_func VALUES ('21', '11');
INSERT INTO sm_user_func VALUES ('21', '13');
INSERT INTO sm_user_func VALUES ('21', '14');
INSERT INTO sm_user_func VALUES ('21', '15');
INSERT INTO sm_user_func VALUES ('21', '16');
INSERT INTO sm_user_func VALUES ('21', '17');
INSERT INTO sm_user_func VALUES ('21', '19');
INSERT INTO sm_user_func VALUES ('21', '20');
INSERT INTO sm_user_func VALUES ('21', '21');
INSERT INTO sm_user_func VALUES ('21', '22');
INSERT INTO sm_user_func VALUES ('21', '23');
INSERT INTO sm_user_func VALUES ('21', '24');
INSERT INTO sm_user_func VALUES ('21', '26');
INSERT INTO sm_user_func VALUES ('21', '27');
INSERT INTO sm_user_func VALUES ('21', '28');
INSERT INTO sm_user_func VALUES ('21', '29');
INSERT INTO sm_user_func VALUES ('21', '30');
INSERT INTO sm_user_func VALUES ('21', '31');
INSERT INTO sm_user_func VALUES ('21', '32');
INSERT INTO sm_user_func VALUES ('21', '33');
INSERT INTO sm_user_func VALUES ('21', '34');
INSERT INTO sm_user_func VALUES ('21', '35');
INSERT INTO sm_user_func VALUES ('21', '36');
INSERT INTO sm_user_func VALUES ('21', '37');
INSERT INTO sm_user_func VALUES ('21', '38');
INSERT INTO sm_user_func VALUES ('21', '39');
INSERT INTO sm_user_func VALUES ('21', '40');
INSERT INTO sm_user_func VALUES ('21', '41');
INSERT INTO sm_user_func VALUES ('21', '42');
INSERT INTO sm_user_func VALUES ('21', '43');
INSERT INTO sm_user_func VALUES ('21', '44');
INSERT INTO sm_user_func VALUES ('21', '45');
INSERT INTO sm_user_func VALUES ('21', '46');
INSERT INTO sm_user_func VALUES ('21', '47');
INSERT INTO sm_user_func VALUES ('21', '48');
INSERT INTO sm_user_func VALUES ('21', '49');
INSERT INTO sm_user_func VALUES ('21', '50');
INSERT INTO sm_user_func VALUES ('21', '52');
INSERT INTO sm_user_func VALUES ('21', '53');
INSERT INTO sm_user_func VALUES ('21', '54');
INSERT INTO sm_user_func VALUES ('21', '55');
INSERT INTO sm_user_func VALUES ('21', '56');
INSERT INTO sm_user_func VALUES ('21', '57');
INSERT INTO sm_user_func VALUES ('21', '58');
INSERT INTO sm_user_func VALUES ('21', '59');
INSERT INTO sm_user_func VALUES ('21', '60');
INSERT INTO sm_user_func VALUES ('21', '61');
INSERT INTO sm_user_func VALUES ('21', '62');
INSERT INTO sm_user_func VALUES ('21', '63');
INSERT INTO sm_user_func VALUES ('21', '64');
INSERT INTO sm_user_func VALUES ('21', '65');
INSERT INTO sm_user_func VALUES ('21', '66');
INSERT INTO sm_user_func VALUES ('21', '67');
INSERT INTO sm_user_func VALUES ('21', '68');
INSERT INTO sm_user_func VALUES ('21', '69');
INSERT INTO sm_user_func VALUES ('21', '70');
INSERT INTO sm_user_func VALUES ('21', '71');
INSERT INTO sm_user_func VALUES ('21', '72');
INSERT INTO sm_user_func VALUES ('21', '73');
INSERT INTO sm_user_func VALUES ('21', '74');
INSERT INTO sm_user_func VALUES ('21', '75');
INSERT INTO sm_user_func VALUES ('21', '85');
INSERT INTO sm_user_func VALUES ('21', '86');
INSERT INTO sm_user_func VALUES ('21', '87');
INSERT INTO sm_user_func VALUES ('21', '88');
INSERT INTO sm_user_func VALUES ('21', '89');
INSERT INTO sm_user_func VALUES ('21', '90');
INSERT INTO sm_user_func VALUES ('21', '91');
INSERT INTO sm_user_func VALUES ('21', '92');
INSERT INTO sm_user_func VALUES ('21', '93');
INSERT INTO sm_user_func VALUES ('21', '94');
INSERT INTO sm_user_func VALUES ('21', '95');
INSERT INTO sm_user_func VALUES ('21', '97');
INSERT INTO sm_user_func VALUES ('21', '98');
INSERT INTO sm_user_func VALUES ('21', '99');
INSERT INTO sm_user_func VALUES ('21', '100');
INSERT INTO sm_user_func VALUES ('21', '106');
INSERT INTO sm_user_func VALUES ('21', '107');
INSERT INTO sm_user_func VALUES ('21', '108');
INSERT INTO sm_user_func VALUES ('21', '109');
INSERT INTO sm_user_func VALUES ('21', '110');
INSERT INTO sm_user_func VALUES ('21', '117');
INSERT INTO sm_user_func VALUES ('21', '120');
INSERT INTO sm_user_func VALUES ('21', '121');
INSERT INTO sm_user_func VALUES ('21', '122');
INSERT INTO sm_user_func VALUES ('21', '123');
INSERT INTO sm_user_func VALUES ('21', '124');
INSERT INTO sm_user_func VALUES ('21', '126');
INSERT INTO sm_user_func VALUES ('21', '127');
INSERT INTO sm_user_func VALUES ('21', '128');
INSERT INTO sm_user_func VALUES ('21', '129');
INSERT INTO sm_user_func VALUES ('21', '130');
INSERT INTO sm_user_func VALUES ('21', '131');
INSERT INTO sm_user_func VALUES ('21', '134');
INSERT INTO sm_user_func VALUES ('21', '135');
INSERT INTO sm_user_func VALUES ('21', '136');
INSERT INTO sm_user_func VALUES ('21', '137');
INSERT INTO sm_user_func VALUES ('21', '138');
INSERT INTO sm_user_func VALUES ('21', '139');
INSERT INTO sm_user_func VALUES ('21', '140');
INSERT INTO sm_user_func VALUES ('21', '141');
INSERT INTO sm_user_func VALUES ('21', '142');
INSERT INTO sm_user_func VALUES ('21', '145');
INSERT INTO sm_user_func VALUES ('21', '146');
INSERT INTO sm_user_func VALUES ('21', '147');
INSERT INTO sm_user_func VALUES ('21', '148');
INSERT INTO sm_user_func VALUES ('21', '149');
INSERT INTO sm_user_func VALUES ('21', '150');
INSERT INTO sm_user_func VALUES ('21', '151');
INSERT INTO sm_user_func VALUES ('21', '152');
INSERT INTO sm_user_func VALUES ('21', '153');
INSERT INTO sm_user_func VALUES ('21', '154');
INSERT INTO sm_user_func VALUES ('21', '155');
INSERT INTO sm_user_func VALUES ('21', '156');
INSERT INTO sm_user_func VALUES ('21', '157');
INSERT INTO sm_user_func VALUES ('21', '158');
INSERT INTO sm_user_func VALUES ('21', '159');
INSERT INTO sm_user_func VALUES ('21', '160');
INSERT INTO sm_user_func VALUES ('21', '161');
INSERT INTO sm_user_func VALUES ('21', '162');
INSERT INTO sm_user_func VALUES ('21', '163');
INSERT INTO sm_user_func VALUES ('21', '164');
INSERT INTO sm_user_func VALUES ('21', '165');
INSERT INTO sm_user_func VALUES ('21', '166');
INSERT INTO sm_user_func VALUES ('21', '167');
INSERT INTO sm_user_func VALUES ('21', '168');
INSERT INTO sm_user_func VALUES ('21', '177');
INSERT INTO sm_user_func VALUES ('21', '178');
INSERT INTO sm_user_func VALUES ('21', '179');
INSERT INTO sm_user_func VALUES ('21', '180');
INSERT INTO sm_user_func VALUES ('21', '181');
INSERT INTO sm_user_func VALUES ('21', '182');
INSERT INTO sm_user_func VALUES ('21', '183');
INSERT INTO sm_user_func VALUES ('21', '184');
INSERT INTO sm_user_func VALUES ('21', '185');
INSERT INTO sm_user_func VALUES ('21', '186');
INSERT INTO sm_user_func VALUES ('21', '187');
INSERT INTO sm_user_func VALUES ('21', '188');
INSERT INTO sm_user_func VALUES ('21', '189');
INSERT INTO sm_user_func VALUES ('21', '190');
INSERT INTO sm_user_func VALUES ('21', '194');
INSERT INTO sm_user_func VALUES ('21', '195');
INSERT INTO sm_user_func VALUES ('21', '196');
INSERT INTO sm_user_func VALUES ('21', '197');
INSERT INTO sm_user_func VALUES ('21', '198');
INSERT INTO sm_user_func VALUES ('21', '199');
INSERT INTO sm_user_func VALUES ('21', '200');
INSERT INTO sm_user_func VALUES ('21', '202');
INSERT INTO sm_user_func VALUES ('21', '203');
INSERT INTO sm_user_func VALUES ('21', '204');
INSERT INTO sm_user_func VALUES ('21', '206');
INSERT INTO sm_user_func VALUES ('21', '207');
INSERT INTO sm_user_func VALUES ('21', '208');
INSERT INTO sm_user_func VALUES ('21', '209');
INSERT INTO sm_user_func VALUES ('21', '210');
INSERT INTO sm_user_func VALUES ('21', '211');
INSERT INTO sm_user_func VALUES ('21', '212');
INSERT INTO sm_user_func VALUES ('21', '213');
INSERT INTO sm_user_func VALUES ('21', '214');
INSERT INTO sm_user_func VALUES ('21', '238');
INSERT INTO sm_user_func VALUES ('21', '239');
INSERT INTO sm_user_func VALUES ('21', '305');
INSERT INTO sm_user_func VALUES ('21', '306');
INSERT INTO sm_user_func VALUES ('21', '307');
INSERT INTO sm_user_func VALUES ('21', '309');
INSERT INTO sm_user_func VALUES ('21', '312');
INSERT INTO sm_user_func VALUES ('21', '313');
INSERT INTO sm_user_func VALUES ('21', '314');
INSERT INTO sm_user_func VALUES ('21', '315');
INSERT INTO sm_user_func VALUES ('21', '316');
INSERT INTO sm_user_func VALUES ('21', '319');
INSERT INTO sm_user_func VALUES ('21', '320');
INSERT INTO sm_user_func VALUES ('21', '321');
INSERT INTO sm_user_func VALUES ('21', '322');
INSERT INTO sm_user_func VALUES ('21', '323');
INSERT INTO sm_user_func VALUES ('21', '324');
INSERT INTO sm_user_func VALUES ('21', '325');
INSERT INTO sm_user_func VALUES ('21', '326');
INSERT INTO sm_user_func VALUES ('21', '327');
INSERT INTO sm_user_func VALUES ('21', '328');
INSERT INTO sm_user_func VALUES ('21', '329');

-- ----------------------------
-- Table structure for `sm_user_org`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_org`;
CREATE TABLE `sm_user_org` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ORG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '机构ID',
  PRIMARY KEY (`USER_ID`,`ORG_ID`),
  KEY `INDEX_USER_ID` (`USER_ID`) USING BTREE,
  KEY `INDEX_ORG_ID` (`ORG_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户机构表';

-- ----------------------------
-- Records of sm_user_org
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user_position`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_position`;
CREATE TABLE `sm_user_position` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `POS_ID` int(11) NOT NULL DEFAULT '0' COMMENT '岗位ID',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX-USER_ID` (`USER_ID`) USING BTREE,
  KEY `INDEX_POS_ID` (`POS_ID`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户岗位关联表';

-- ----------------------------
-- Records of sm_user_position
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_role`;
CREATE TABLE `sm_user_role` (
  `USER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ROLE_ID` int(4) NOT NULL DEFAULT '0' COMMENT '角色ID',
  PRIMARY KEY (`USER_ID`,`ROLE_ID`),
  KEY `INDEX_ROLE_ID` (`ROLE_ID`) USING BTREE,
  KEY `INDEX_USER_ID` (`USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色关联表';

-- ----------------------------
-- Records of sm_user_role
-- ----------------------------
INSERT INTO sm_user_role VALUES ('2', '1');
INSERT INTO sm_user_role VALUES ('19', '6');
INSERT INTO sm_user_role VALUES ('18', '7');
INSERT INTO sm_user_role VALUES ('4', '8');
INSERT INTO sm_user_role VALUES ('7', '8');
INSERT INTO sm_user_role VALUES ('5', '9');
INSERT INTO sm_user_role VALUES ('13', '9');
INSERT INTO sm_user_role VALUES ('17', '9');
INSERT INTO sm_user_role VALUES ('3', '10');
INSERT INTO sm_user_role VALUES ('16', '10');
INSERT INTO sm_user_role VALUES ('6', '11');
INSERT INTO sm_user_role VALUES ('13', '11');
INSERT INTO sm_user_role VALUES ('15', '11');

-- ----------------------------
-- Table structure for `sm_workbanch`
-- ----------------------------
DROP TABLE IF EXISTS `sm_workbanch`;
CREATE TABLE `sm_workbanch` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `URL` varchar(64) NOT NULL,
  `TITLE` varchar(64) NOT NULL DEFAULT '' COMMENT '标题',
  `MODULE` varchar(64) NOT NULL DEFAULT '' COMMENT '模块',
  `TYPE` varchar(64) NOT NULL DEFAULT '' COMMENT '类型',
  `WIDTH` varchar(64) NOT NULL DEFAULT '' COMMENT '宽度',
  `PARAMS` varchar(512) NOT NULL DEFAULT '' COMMENT '参数',
  `TIME_PARAM` varchar(64) NOT NULL DEFAULT '' COMMENT '时间参数',
  `OWNER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '所有者',
  `ORDER_INDEX` int(4) NOT NULL DEFAULT '0' COMMENT '排序标识',
  `IS_DELETED` int(4) NOT NULL DEFAULT '0' COMMENT '删除标识',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='工作台';

-- ----------------------------
-- Records of sm_workbanch
-- ----------------------------
INSERT INTO sm_workbanch VALUES ('1', '/customer/lead/query.do', '今日线索', 'lead', 'list', '49%', '{\'search_LIKE_name\':\'刘岚-测试\',\'search_LIKE_email\':\'liulan8627@163.com\',\'search_LIKE_mobile\':\'15911140672\',\'search_EQ_source.id\':\'92\',\'search_EQ_industry.id\':\'142\'}', 'today', '1', '1', '0', '2014-08-19 09:29:18', '2014-08-29 16:31:30');
INSERT INTO sm_workbanch VALUES ('2', '/customer/customer/query.do', '客户', 'customer', 'list', '99%', '{\'search_LIKE_name\':\'李华\',\'search_LIKE_mobile\':\'15911140896\',\'search_EQ_source.id\':\'127\'}', 'week', '1', '2', '0', '2014-08-19 09:32:31', '2014-08-29 16:31:30');
INSERT INTO sm_workbanch VALUES ('3', '/customer/contact/query.do', '联系人', 'contact', 'list', '49%', '{\'search_LIKE_name\':\'刘岚\',\'search_LIKE_phone\':\'15911140672\'}', 'month', '1', '3', '1', '2014-08-19 09:35:12', '2014-08-22 11:05:41');
INSERT INTO sm_workbanch VALUES ('4', '/project/supplier/query.do', '供应商', 'supplier', 'list', '49%', '{\'search_LIKE_name\':\'罗晓丽-测试\',\'search_LIKE_mobile\':\'18600589448\',\'search_LIKE_owner.realName\':\'李华\',\'search_EQ_type.id\':\'252\'}', 'week', '1', '0', '0', '2014-08-19 09:41:22', '2014-08-29 16:31:30');
INSERT INTO sm_workbanch VALUES ('5', '/customer/lead/query.do', '一月内线索', 'lead', 'list', '49%', '{\'search_LIKE_name\':\'李丽-测试\',\'search_LIKE_mobile\':\'13400589449\',\'search_EQ_source.id\':\'92\',\'search_EQ_industry.id\':\'144\'}', 'month', '1', '1', '1', '2014-08-19 09:45:14', '2014-08-22 11:05:43');
INSERT INTO sm_workbanch VALUES ('6', '/common/report/reportWorkbanch.comp?id=2', '市场活动报表', 'report', 'report', '49%', '{}', 'month', '1', '1', '1', '2014-08-22 11:07:27', '2014-08-29 13:20:42');
INSERT INTO sm_workbanch VALUES ('7', '/common/report/reportWorkbanch.comp?id=2', '市场活动报表', 'report', 'report', '49%', '{}', 'month', '1', '3', '1', '2014-08-29 16:28:06', '2014-08-29 16:30:55');
INSERT INTO sm_workbanch VALUES ('8', '/common/report/reportWorkbanch.comp?id=2', '市场活动报表', 'report', 'report', '49%', '{}', 'month', '1', '2', '1', '2014-08-30 15:02:06', '2014-08-30 15:02:30');
INSERT INTO sm_workbanch VALUES ('9', '/common/report/reportWorkbanch.comp?id=2', 'XXX', 'report', 'report', '49%', '{}', 'month', '1', '2', '1', '2014-08-30 15:03:00', '2014-10-22 10:58:59');

-- ----------------------------
-- Table structure for `supplier`
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '供应商名',
  `TYPE` int(4) NOT NULL DEFAULT '0' COMMENT '供应商分类',
  `CORPORATION` varchar(64) NOT NULL DEFAULT '' COMMENT '法人代表',
  `OWNER` int(11) NOT NULL DEFAULT '0' COMMENT '所有者',
  `PHONE` varchar(32) NOT NULL DEFAULT '' COMMENT '电话',
  `MOBILE` varchar(32) NOT NULL DEFAULT '' COMMENT '手机',
  `CARD_NUM` varchar(64) NOT NULL DEFAULT '' COMMENT '证件号码',
  `CARD_TYPE` int(11) DEFAULT NULL COMMENT '证件类型',
  `FAX` varchar(32) NOT NULL DEFAULT '' COMMENT '传真',
  `PROVINCE` varchar(32) DEFAULT NULL COMMENT '省份',
  `CITY` varchar(32) DEFAULT NULL COMMENT '城市',
  `COUNTY` varchar(32) DEFAULT NULL COMMENT '区/县',
  `EMAIL` varchar(32) NOT NULL DEFAULT '' COMMENT '邮箱',
  `ADDRESS` varchar(512) NOT NULL DEFAULT '' COMMENT '详细地址',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `IS_DELETED` int(11) DEFAULT '0',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_TYPE` (`TYPE`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='供应商';

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO supplier VALUES ('1', '中国人民银行丰台分行', '252', '易俊茹', '8', '18620623071', '18620623071', '18613891430212111', '235', '', '110000', '110100', '110102', 'hua.li@pcstars.com', '丰台区', '', '0', '1', '2014-08-18 15:58:09', '1', '2014-08-18 15:58:09');
INSERT INTO supplier VALUES ('2', 'luoxiaoli（测试数据）', '253', '罗蒙', '9', '15911140987', '', '511321198807158686', '232', '', null, null, null, '', '', '', '0', '1', '2014-08-19 14:18:32', '1', '2014-08-19 14:18:32');
INSERT INTO supplier VALUES ('3', 'awu(测试数据）', '252', '阿武', '13', '15911140670', '', '511321198607158990', '232', '', null, null, null, '', '', '', '0', '1', '2014-08-19 14:22:27', '1', '2014-08-19 14:22:27');
INSERT INTO supplier VALUES ('4', '供应商（测试）', '252', '何（测试）', '13', '', '', '5128967', '234', '', null, null, null, '', '', '', '0', '1', '2014-08-29 17:30:00', '1', '2014-08-29 17:30:00');
INSERT INTO supplier VALUES ('5', 'luoxiaoli', '253', '009', '14', '', '', '511321198607158888', '232', '', null, null, null, '', '', '', '1', '14', '2014-08-19 16:32:28', '14', '2014-08-21 09:52:10');

-- ----------------------------
-- Table structure for `user_message`
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `MESSAGE_ID` int(11) NOT NULL COMMENT '所发消息',
  `USER_ID` int(11) NOT NULL COMMENT '所发用户',
  `STATUS` int(11) NOT NULL COMMENT '读取状态',
  `TYPE` smallint(6) NOT NULL COMMENT '消息类型，发消息true或接收消息false',
  `IS_DELETED` tinyint(6) NOT NULL DEFAULT '0' COMMENT '是否被删除',
  `CREATED_TIME` datetime NOT NULL COMMENT '发送时间',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ID` (`ID`) USING BTREE,
  KEY `INDEX_MESSAGE_ID` (`MESSAGE_ID`) USING BTREE,
  KEY `INDEX_USER_ID` (`USER_ID`) USING BTREE,
  KEY `INDEX_STATUS` (`STATUS`) USING BTREE,
  KEY `INDEX_TYPE` (`TYPE`) USING BTREE,
  KEY `INDEX_CREATED_TIME` (`CREATED_TIME`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='系统消息与用户关联表';

-- ----------------------------
-- Records of user_message
-- ----------------------------
INSERT INTO user_message VALUES ('1', '1', '2', '0', '1', '0', '2014-08-18 15:40:12', '2014-08-18 15:40:12');
INSERT INTO user_message VALUES ('2', '1', '2', '0', '0', '0', '2014-08-18 15:40:12', '2014-08-18 15:40:12');
INSERT INTO user_message VALUES ('3', '1', '6', '0', '1', '0', '2014-08-18 15:40:13', '2014-08-18 15:40:13');
INSERT INTO user_message VALUES ('4', '1', '6', '0', '0', '0', '2014-08-18 15:40:13', '2014-08-18 15:40:13');
INSERT INTO user_message VALUES ('5', '2', '2', '0', '1', '0', '2014-08-18 15:41:54', '2014-08-18 15:41:54');
INSERT INTO user_message VALUES ('6', '2', '2', '0', '0', '0', '2014-08-18 15:41:54', '2014-08-18 15:41:54');
INSERT INTO user_message VALUES ('7', '2', '6', '0', '1', '0', '2014-08-18 15:41:56', '2014-08-18 15:41:56');
INSERT INTO user_message VALUES ('8', '2', '6', '0', '0', '0', '2014-08-18 15:41:56', '2014-08-18 15:41:56');
INSERT INTO user_message VALUES ('9', '2', '5', '0', '1', '0', '2014-08-18 15:41:58', '2014-08-18 15:41:58');
INSERT INTO user_message VALUES ('10', '2', '5', '0', '0', '0', '2014-08-18 15:41:58', '2014-08-18 15:41:58');
INSERT INTO user_message VALUES ('11', '2', '4', '0', '1', '0', '2014-08-18 15:42:01', '2014-08-18 15:42:01');
INSERT INTO user_message VALUES ('12', '2', '4', '0', '0', '0', '2014-08-18 15:42:01', '2014-08-18 15:42:01');
INSERT INTO user_message VALUES ('13', '2', '7', '0', '1', '0', '2014-08-18 15:42:03', '2014-08-18 15:42:03');
INSERT INTO user_message VALUES ('14', '2', '7', '0', '0', '0', '2014-08-18 15:42:03', '2014-08-18 15:42:03');
INSERT INTO user_message VALUES ('15', '2', '3', '0', '1', '0', '2014-08-18 15:42:03', '2014-08-18 15:42:03');
INSERT INTO user_message VALUES ('16', '2', '3', '0', '0', '0', '2014-08-18 15:42:03', '2014-08-18 15:42:03');
INSERT INTO user_message VALUES ('17', '3', '1', '0', '1', '0', '2014-08-18 15:46:23', '2014-08-18 15:46:23');
INSERT INTO user_message VALUES ('18', '3', '1', '1', '0', '0', '2014-08-18 15:46:23', '2014-08-20 18:34:58');
INSERT INTO user_message VALUES ('19', '4', '13', '0', '0', '0', '2014-08-20 09:41:32', '2014-08-20 09:41:01');
INSERT INTO user_message VALUES ('20', '5', '13', '0', '0', '0', '2014-08-20 09:44:13', '2014-08-20 09:43:42');
INSERT INTO user_message VALUES ('21', '6', '13', '0', '0', '0', '2014-08-20 14:24:42', '2014-08-20 14:24:11');
INSERT INTO user_message VALUES ('22', '7', '13', '0', '1', '0', '2014-08-21 10:55:44', '2014-08-21 10:55:44');
INSERT INTO user_message VALUES ('23', '7', '13', '0', '0', '0', '2014-08-21 10:55:44', '2014-08-21 10:55:44');
INSERT INTO user_message VALUES ('24', '7', '22', '0', '1', '0', '2014-08-21 10:55:44', '2014-08-21 10:55:44');
INSERT INTO user_message VALUES ('25', '7', '22', '0', '0', '0', '2014-08-21 10:55:44', '2014-08-21 10:55:44');
INSERT INTO user_message VALUES ('26', '7', '2', '0', '1', '0', '2014-08-21 10:55:45', '2014-08-21 10:55:45');
INSERT INTO user_message VALUES ('27', '7', '2', '0', '0', '0', '2014-08-21 10:55:45', '2014-08-21 10:55:45');
INSERT INTO user_message VALUES ('28', '7', '6', '0', '1', '0', '2014-08-21 10:55:45', '2014-08-21 10:55:45');
INSERT INTO user_message VALUES ('29', '7', '6', '0', '0', '0', '2014-08-21 10:55:45', '2014-08-21 10:55:45');
INSERT INTO user_message VALUES ('30', '7', '18', '0', '1', '0', '2014-08-21 10:55:46', '2014-08-21 10:55:46');
INSERT INTO user_message VALUES ('31', '7', '18', '0', '0', '0', '2014-08-21 10:55:46', '2014-08-21 10:55:46');
INSERT INTO user_message VALUES ('32', '7', '19', '0', '1', '0', '2014-08-21 10:55:47', '2014-08-21 10:55:47');
INSERT INTO user_message VALUES ('33', '7', '19', '0', '0', '0', '2014-08-21 10:55:47', '2014-08-21 10:55:47');
INSERT INTO user_message VALUES ('34', '7', '5', '0', '1', '0', '2014-08-21 10:55:47', '2014-08-21 10:55:47');
INSERT INTO user_message VALUES ('35', '7', '5', '0', '0', '0', '2014-08-21 10:55:47', '2014-08-21 10:55:47');
INSERT INTO user_message VALUES ('36', '7', '17', '0', '1', '0', '2014-08-21 10:55:48', '2014-08-21 10:55:48');
INSERT INTO user_message VALUES ('37', '7', '17', '0', '0', '0', '2014-08-21 10:55:48', '2014-08-21 10:55:48');
INSERT INTO user_message VALUES ('38', '7', '4', '0', '1', '0', '2014-08-21 10:55:48', '2014-08-21 10:55:48');
INSERT INTO user_message VALUES ('39', '7', '4', '0', '0', '0', '2014-08-21 10:55:48', '2014-08-21 10:55:48');
INSERT INTO user_message VALUES ('40', '7', '7', '0', '1', '0', '2014-08-21 10:55:49', '2014-08-21 10:55:49');
INSERT INTO user_message VALUES ('41', '7', '7', '0', '0', '0', '2014-08-21 10:55:49', '2014-08-21 10:55:49');
INSERT INTO user_message VALUES ('42', '7', '14', '0', '1', '0', '2014-08-21 10:55:49', '2014-08-21 10:55:49');
INSERT INTO user_message VALUES ('43', '7', '14', '0', '0', '0', '2014-08-21 10:55:49', '2014-08-21 10:55:49');
INSERT INTO user_message VALUES ('44', '7', '15', '0', '1', '0', '2014-08-21 10:55:50', '2014-08-21 10:55:50');
INSERT INTO user_message VALUES ('45', '7', '15', '0', '0', '0', '2014-08-21 10:55:50', '2014-08-21 10:55:50');
INSERT INTO user_message VALUES ('46', '7', '16', '0', '1', '0', '2014-08-21 10:55:51', '2014-08-21 10:55:51');
INSERT INTO user_message VALUES ('47', '7', '16', '0', '0', '0', '2014-08-21 10:55:51', '2014-08-21 10:55:51');
INSERT INTO user_message VALUES ('48', '7', '20', '0', '1', '0', '2014-08-21 10:55:51', '2014-08-21 10:55:51');
INSERT INTO user_message VALUES ('49', '7', '20', '0', '0', '0', '2014-08-21 10:55:51', '2014-08-21 10:55:51');
INSERT INTO user_message VALUES ('50', '7', '9', '0', '1', '0', '2014-08-21 10:55:52', '2014-08-21 10:55:52');
INSERT INTO user_message VALUES ('51', '7', '9', '0', '0', '0', '2014-08-21 10:55:52', '2014-08-21 10:55:52');
INSERT INTO user_message VALUES ('52', '7', '10', '1', '1', '0', '2014-08-21 10:55:53', '2014-08-27 10:52:42');
INSERT INTO user_message VALUES ('53', '7', '10', '0', '0', '0', '2014-08-21 10:55:53', '2014-08-21 10:55:53');
INSERT INTO user_message VALUES ('54', '7', '3', '0', '1', '0', '2014-08-21 10:55:53', '2014-08-21 10:55:53');
INSERT INTO user_message VALUES ('55', '7', '3', '0', '0', '0', '2014-08-21 10:55:53', '2014-08-21 10:55:53');
INSERT INTO user_message VALUES ('56', '7', '21', '0', '1', '0', '2014-08-21 10:55:54', '2014-08-21 10:55:54');
INSERT INTO user_message VALUES ('57', '7', '21', '0', '0', '0', '2014-08-21 10:55:54', '2014-08-21 10:55:54');
INSERT INTO user_message VALUES ('58', '7', '8', '0', '1', '0', '2014-08-21 10:55:54', '2014-08-21 10:55:54');
INSERT INTO user_message VALUES ('59', '7', '8', '0', '0', '0', '2014-08-21 10:55:54', '2014-08-21 10:55:54');
INSERT INTO user_message VALUES ('60', '7', '11', '1', '1', '0', '2014-08-21 10:55:55', '2014-08-21 11:20:25');
INSERT INTO user_message VALUES ('61', '7', '11', '0', '0', '0', '2014-08-21 10:55:55', '2014-08-21 10:55:55');
INSERT INTO user_message VALUES ('62', '7', '12', '1', '1', '0', '2014-08-21 10:55:55', '2014-08-21 11:20:36');
INSERT INTO user_message VALUES ('63', '7', '12', '0', '0', '0', '2014-08-21 10:55:55', '2014-08-21 10:55:55');
INSERT INTO user_message VALUES ('64', '8', '13', '1', '1', '0', '2014-08-27 10:38:19', '2014-08-27 10:48:06');
INSERT INTO user_message VALUES ('65', '8', '13', '0', '0', '0', '2014-08-27 10:38:19', '2014-08-27 10:38:19');

-- ----------------------------
-- Table structure for `wf_node`
-- ----------------------------
DROP TABLE IF EXISTS `wf_node`;
CREATE TABLE `wf_node` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `CODE` varchar(16) NOT NULL COMMENT '编号',
  `NAME` varchar(32) NOT NULL COMMENT '名称',
  `FLOW_ID` int(11) NOT NULL COMMENT '流程ID',
  `ROLE_ID` int(11) DEFAULT NULL COMMENT '对应的执行角色ID',
  `TYPE_ID` int(11) NOT NULL COMMENT '流程环节类型，开始：1、业务：2、结束：3',
  `ORDER` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='流程节点表';

-- ----------------------------
-- Records of wf_node
-- ----------------------------
INSERT INTO wf_node VALUES ('1', '060100', '开始', '60', null, '1', '1');
INSERT INTO wf_node VALUES ('2', '060101', '理财经理审核', '60', '11', '2', '2');
INSERT INTO wf_node VALUES ('3', '060102', '投资经理审核', '60', '10', '2', '3');
INSERT INTO wf_node VALUES ('4', '060103', '投资总监审核', '60', '9', '2', '4');
INSERT INTO wf_node VALUES ('5', '060104', '副总裁审核', '60', '7', '2', '5');
INSERT INTO wf_node VALUES ('6', '060105', '总裁审核', '60', '6', '2', '6');
INSERT INTO wf_node VALUES ('7', '060106', '财务审核', '60', '8', '2', '7');
INSERT INTO wf_node VALUES ('8', '060107', '结束', '60', null, '3', '8');
INSERT INTO wf_node VALUES ('9', '030101', '开始', '61', null, '1', '1');
INSERT INTO wf_node VALUES ('10', '030102', '投资总监审核', '61', '9', '2', '2');
INSERT INTO wf_node VALUES ('11', '030103', '总裁审核', '61', '6', '2', '3');
INSERT INTO wf_node VALUES ('12', '030104', '财务审核', '61', '8', '2', '4');
INSERT INTO wf_node VALUES ('13', '030105', '结束', '61', null, '3', '5');
INSERT INTO wf_node VALUES ('14', '030111', '开始', '62', null, '1', '1');
INSERT INTO wf_node VALUES ('15', '030113', '结束', '62', null, '3', '3');
INSERT INTO wf_node VALUES ('16', '030112', '理财经理审核', '62', '11', '2', '2');

-- ----------------------------
-- Table structure for `wf_task`
-- ----------------------------
DROP TABLE IF EXISTS `wf_task`;
CREATE TABLE `wf_task` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NODE_ID` int(11) NOT NULL COMMENT '流程环节ID',
  `MODULE_ID` int(11) NOT NULL COMMENT '模块ID',
  `RECORD_ID` int(11) NOT NULL COMMENT '关联记录ID',
  `ORG_ID` int(11) DEFAULT NULL COMMENT '机构ID',
  `APPROVER_ID` int(11) DEFAULT NULL,
  `IS_PASSED` tinyint(4) DEFAULT NULL COMMENT '否是通过',
  `APPROVE_TIME` datetime DEFAULT NULL COMMENT '审批时间',
  `REJECT_REASON` varchar(255) DEFAULT NULL COMMENT '退回原因',
  `CREATOR_ID` int(11) DEFAULT NULL COMMENT '创建者',
  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) DEFAULT NULL COMMENT '最后修改者',
  `MODIFIED_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='流程任务表';

-- ----------------------------
-- Records of wf_task
-- ----------------------------
INSERT INTO wf_task VALUES ('1', '1', '8', '2', null, '1', '1', '2014-08-20 09:41:32', null, '1', '2014-08-20 09:41:32', '1', '2014-08-20 09:41:32');
INSERT INTO wf_task VALUES ('2', '2', '8', '2', null, '13', null, null, null, null, null, null, '2014-08-20 09:41:00');
INSERT INTO wf_task VALUES ('3', '3', '8', '2', null, null, null, null, null, null, null, null, '2014-08-20 09:41:00');
INSERT INTO wf_task VALUES ('4', '4', '8', '2', null, null, null, null, null, null, null, null, '2014-08-20 09:41:00');
INSERT INTO wf_task VALUES ('5', '5', '8', '2', null, '18', null, null, null, null, null, null, '2014-08-20 09:41:00');
INSERT INTO wf_task VALUES ('6', '6', '8', '2', null, '19', null, null, null, null, null, null, '2014-08-20 09:41:00');
INSERT INTO wf_task VALUES ('7', '7', '8', '2', null, '4', null, null, null, null, null, null, '2014-08-20 09:41:00');
INSERT INTO wf_task VALUES ('8', '8', '8', '2', null, null, null, null, null, null, null, null, '2014-08-20 09:41:00');
INSERT INTO wf_task VALUES ('9', '14', '1', '1', null, '1', '1', '2014-08-20 09:44:13', null, '1', '2014-08-20 09:44:13', '1', '2014-08-20 09:44:13');
INSERT INTO wf_task VALUES ('10', '16', '1', '1', null, '13', null, null, null, null, null, null, '2014-08-20 09:43:41');
INSERT INTO wf_task VALUES ('11', '15', '1', '1', null, null, null, null, null, null, null, null, '2014-08-20 09:43:41');
INSERT INTO wf_task VALUES ('12', '1', '8', '1', null, '1', '1', '2014-08-20 14:24:42', null, '1', '2014-08-20 14:24:42', '1', '2014-08-20 14:24:42');
INSERT INTO wf_task VALUES ('13', '2', '8', '1', null, '13', null, null, null, null, null, null, '2014-08-20 14:24:10');
INSERT INTO wf_task VALUES ('14', '3', '8', '1', null, null, null, null, null, null, null, null, '2014-08-20 14:24:10');
INSERT INTO wf_task VALUES ('15', '4', '8', '1', null, null, null, null, null, null, null, null, '2014-08-20 14:24:10');
INSERT INTO wf_task VALUES ('16', '5', '8', '1', null, '18', null, null, null, null, null, null, '2014-08-20 14:24:10');
INSERT INTO wf_task VALUES ('17', '6', '8', '1', null, '19', null, null, null, null, null, null, '2014-08-20 14:24:10');
INSERT INTO wf_task VALUES ('18', '7', '8', '1', null, '4', null, null, null, null, null, null, '2014-08-20 14:24:10');
INSERT INTO wf_task VALUES ('19', '8', '8', '1', null, null, null, null, null, null, null, null, '2014-08-20 14:24:10');

-- ----------------------------
-- Procedure structure for `proc_marketactivity_sendmsg`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_marketactivity_sendmsg`;
DELIMITER ;;
CREATE DEFINER=`bhdc001admin`@`%` PROCEDURE `proc_marketactivity_sendmsg`()
begin
		/****************申明临时表*****************/
		create temporary table tmp_msg(id int auto_increment primary key, `ma_id` int(10), `userid` int(10), `title` varchar(100), 
				`content` varchar(500), `creatorid` int(10), `createtime` datetime, `modifierid` int(10));
		
		insert into tmp_msg(ma_id, userid, title, content, creatorid, createtime, modifierid)
		select id, bosshead, '系统提醒信息', concat(`NAME`,'，该市场活动已到举办时间，发送提醒消息！'), '0', sysdate(), '0'  
			from market_activity where begin_date=date_format(sysdate(),'%Y-%m-%d') and is_deleted = 0 and is_send = 0;

		/****************获取当前消息最大主键值*****/
		select @num:=ifnull(max(id),0) from sysmessage;

		/****************新增提示信息***************/
		insert into sysmessage(id, title, content, creator_id, created_time, modifier_id)
		select id+@num, title, content, creatorid, createtime, modifierid
			from tmp_msg;

		/****************发送给负责人***************/
		insert into user_message(message_id, user_id, `status`, type, is_deleted, created_time) 
			select id+@num, userid, '0', '1', '0', sysdate() from tmp_msg;

		/****************更新活动已发消息***********/
		update market_activity set is_send = 1 where id in (select ma_id from tmp_msg);

		drop table tmp_msg;
end
;;
DELIMITER ;

-- ----------------------------
-- Event structure for `msg_task`
-- ----------------------------
DROP EVENT IF EXISTS `msg_task`;
DELIMITER ;;
CREATE DEFINER=`bhdc001admin`@`%` EVENT `msg_task` ON SCHEDULE EVERY 60 SECOND STARTS '2014-07-24 21:06:48' ON COMPLETION PRESERVE ENABLE DO call proc_marketactivity_sendmsg()
;;
DELIMITER ;
