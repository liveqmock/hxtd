/*
MySQL Data Transfer
Source Host: 192.168.111.141
Source Database: hxtd
Target Host: 192.168.111.141
Target Database: hxtd
Date: 2014/7/22 23:06:19
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for attachment
-- ----------------------------
CREATE TABLE `attachment` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `MODULE_ID` int(4) NOT NULL DEFAULT '0' COMMENT '关联模块ID',
  `RECORD_ID` int(4) NOT NULL DEFAULT '0' COMMENT '关联模块内记录的ID',
  `TYPE_DICT` int(4) NOT NULL DEFAULT '0' COMMENT '附件类型',
  `NAME` varchar(64) NOT NULL DEFAULT '',
  `ADDRESS` varchar(512) NOT NULL DEFAULT '' COMMENT '存储地址',
  `IS_DELETED` smallint(6) NOT NULL DEFAULT '0',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改人ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_DICTIONARY_ID` (`RECORD_ID`),
  KEY `INDEX_TYPE` (`TYPE_DICT`),
  KEY `INDEX_CREATE_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODULE` (`MODULE_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Table structure for contact
-- ----------------------------
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
  KEY `INDEX_OWNER` (`OWNER`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_MOBILE` (`MOBILE`),
  KEY `INDEX_PHONE` (`PHONE`),
  KEY `INDEX_SUPPLIER_ID` (`SUPPLIER_ID`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='联系人';

-- ----------------------------
-- Table structure for contract
-- ----------------------------
CREATE TABLE `contract` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '合同ID',
  `NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '合同名称',
  `CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '合同编号',
  `TYPE_DIC` int(11) DEFAULT '0' COMMENT '合同类型',
  `CONTENT` text COMMENT '合同内容',
  `ORDER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `ACCOUNT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `REDEEM_TYPE_DIC` int(11) NOT NULL DEFAULT '0' COMMENT '赎回方式',
  `PURCHASE_MONEY` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '合同金额',
  `SIGN_TIME` datetime NOT NULL COMMENT '签订时间',
  `EFFECT_TIME` datetime NOT NULL COMMENT '生效时间',
  `BEREFT_TIME` datetime NOT NULL COMMENT '失效时间',
  `REMARK` varchar(512) DEFAULT '' COMMENT '备注',
  `IS_DELETED` int(11) NOT NULL DEFAULT '0' COMMENT '标记删除',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ORDER_ID` (`ORDER_ID`),
  KEY `INDEX_ACCOUNT_ID` (`ACCOUNT_ID`),
  KEY `INDEX_TYPE` (`TYPE_DIC`),
  KEY `INDEX_EFFECT_TIME` (`EFFECT_TIME`) USING BTREE,
  KEY `INDEX_SIGN_TIME` (`SIGN_TIME`) USING BTREE,
  KEY `INDEX_BEREFT_TIME` (`BEREFT_TIME`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='合同表';

-- ----------------------------
-- Table structure for customer
-- ----------------------------
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
  `APPOINTMENT` varchar(255) DEFAULT NULL COMMENT '邀约人',
  `FINANCIAL_ADVISOR` varchar(255) DEFAULT NULL COMMENT '理财顾问',
  `FINANCIAL_MANAGER` varchar(255) DEFAULT NULL COMMENT '理财经理',
  `FINANCIAL_DIRECTOR` varchar(255) DEFAULT NULL COMMENT '理财总监',
  `REMARK` varchar(512) DEFAULT '' COMMENT '备注',
  `IS_DELETED` tinyint(6) DEFAULT '0' COMMENT '是否被删除',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ACCOUNT_OWNER` (`OWNER`) USING BTREE,
  KEY `INDEX_PHONE` (`PHONE`),
  KEY `INDEX_MOBILE` (`MOBILE`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_TYPE` (`TYPE_DIC`),
  KEY `INDEX_PROVINCE` (`PROVINCE`),
  KEY `INDEX_CITY` (`CITY`),
  KEY `INDEX_COUNTY` (`COUNTY`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='客户表';

-- ----------------------------
-- Table structure for import_log
-- ----------------------------
CREATE TABLE `import_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '导入日志表ID',
  `START_TIME` datetime NOT NULL COMMENT '导入数据开始时间',
  `END_TIME` datetime NOT NULL COMMENT '导入数据结束时间',
  `STATUS` int(2) NOT NULL DEFAULT '0' COMMENT '导入状态：0 正在导入 1 导入结束 默认为0',
  `DESCRIPTION` varchar(512) DEFAULT NULL COMMENT '描述',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_IMPORT_LOG_ID` (`ID`),
  KEY `INDEX_STATUS` (`STATUS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='导入日志';

-- ----------------------------
-- Table structure for lead
-- ----------------------------
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
  `MARKET_ACTIVITY_ID` int(4) DEFAULT NULL COMMENT '关联市场活动',
  PRIMARY KEY (`ID`),
  KEY `INDEX_OWNER` (`OWNER`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_PHONE` (`PHONE`),
  KEY `INDEX_MOBILE` (`MOBILE`),
  KEY `INDEX_STATUS` (`STATUS`),
  KEY `INDEX_CREATER_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=801 DEFAULT CHARSET=utf8 COMMENT='线索';

-- ----------------------------
-- Table structure for market_activity
-- ----------------------------
CREATE TABLE `market_activity` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '活动名称',
  `TYPE_DIC` int(4) DEFAULT NULL COMMENT '活动类型',
  `STATUS_DIC` int(4) DEFAULT NULL COMMENT '活动状态',
  `BEGIN_DATE` datetime NOT NULL COMMENT '开始日期',
  `END_DATE` datetime NOT NULL COMMENT '结束日期',
  `PREDICT_COST` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '预计成本',
  `REALITY_COST` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '实际成本',
  `TIMES` int(4) NOT NULL DEFAULT '0' COMMENT '活动次数',
  `EXPECT_EFFECT` varchar(256) DEFAULT '' COMMENT '预期效果',
  `EXPECT_SUCCESS_RATE` float(6,2) DEFAULT '0.00' COMMENT '期望成功率',
  `SPONSOR` int(11) NOT NULL DEFAULT '0' COMMENT '发起者',
  `BOSSHEAD` int(11) NOT NULL DEFAULT '0' COMMENT '负责人',
  `REMARK` varchar(512) DEFAULT '' COMMENT '备注',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '删除标记',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ACTIVITY_STATUS` (`STATUS_DIC`),
  KEY `INDEX-CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX-MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='市场活动';

-- ----------------------------
-- Table structure for memoir
-- ----------------------------
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
  KEY `INDEX_ID` (`ID`),
  KEY `INDEX_TYPE` (`MODULE_ID`),
  KEY `INDEX_MODULE_ID` (`RECORD_ID`),
  KEY `INDEX_EMPLOYEE_ID` (`USER_ID`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='沟通纪要';

-- ----------------------------
-- Table structure for notice
-- ----------------------------
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
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='系统公告表';

-- ----------------------------
-- Table structure for order
-- ----------------------------
CREATE TABLE `order` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `PRODUCT_ID` int(4) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `CUSTOMER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `CODE` varchar(32) NOT NULL COMMENT '订单编号',
  `STATUS` int(11) DEFAULT NULL,
  `INVESTMENT_WAY` int(4) NOT NULL DEFAULT '0' COMMENT '投资方式',
  `PURCHASE_MONEY` decimal(10,4) NOT NULL COMMENT '购买金额',
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
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`),
  KEY `INDEX_PRODUCT_ID` (`PRODUCT_ID`),
  KEY `INDEX_ACCOUNT_ID` (`CUSTOMER_ID`),
  KEY `INDEX_SALES_PERSON_ID` (`OWNER`),
  KEY `INDEX_SALES_MANAGER_ID` (`SALES_MANAGER_ID`),
  KEY `INDEX_SALES_MAJORDOMO_ID` (`SALES_MAJORDOMO_ID`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Table structure for pro_city_area
-- ----------------------------
CREATE TABLE `pro_city_area` (
  `ID` int(4) NOT NULL COMMENT '主键ID',
  `NAME` varchar(32) NOT NULL COMMENT '名称',
  `PID` int(4) DEFAULT NULL COMMENT '父级ID',
  PRIMARY KEY (`ID`),
  KEY `INDEX_PID` (`PID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='省市县三级联动表';

-- ----------------------------
-- Table structure for product
-- ----------------------------
CREATE TABLE `product` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '产品名称',
  `CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '产品编号',
  `PROJECT_ID` int(4) NOT NULL DEFAULT '0' COMMENT '项目ID',
  `TYPE_DIC` int(4) DEFAULT '0' COMMENT '类型',
  `START_SELL_MONEY` decimal(10,4) DEFAULT '0.0000' COMMENT '出售金额',
  `ERNING_RATE` decimal(10,2) DEFAULT '0.00' COMMENT '最小利率',
  `EXPECT_PROFIT` decimal(10,4) DEFAULT '0.0000' COMMENT '预期收益',
  `SALE_LIMIT` int(4) DEFAULT '0' COMMENT '销售期限',
  `SALE_UNIT_DIC` int(4) DEFAULT '0' COMMENT '销售单位',
  `SALE_BEGIN_TIME` datetime DEFAULT NULL COMMENT '销售开始日期',
  `SALE_END_TIME` datetime DEFAULT NULL COMMENT '销售结束日期',
  `ADVANCE_REDEEM_RATE` decimal(10,4) DEFAULT NULL COMMENT '提前赎回率',
  `ADVANCE_REDEEM_FORMULA` varchar(216) DEFAULT '' COMMENT '提前赎回公式',
  `IS_EFFECT` char(1) DEFAULT '1' COMMENT '是否有效',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '标记删除',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`),
  KEY `INDEX_PROJECT_ID` (`PROJECT_ID`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Table structure for project
-- ----------------------------
CREATE TABLE `project` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `SUPPLIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '供应商ID',
  `CODE` varchar(64) NOT NULL DEFAULT '' COMMENT '项目编号',
  `NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '项目名称',
  `FINANCE_LIMIT` float(10,0) NOT NULL DEFAULT '0' COMMENT '融资额度',
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
  KEY `INDEX_SUPPLIER_ID` (`SUPPLIER_ID`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='项目表';

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
CREATE TABLE `qrtz_blob_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
CREATE TABLE `qrtz_calendars` (
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
CREATE TABLE `qrtz_cron_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
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
-- Table structure for qrtz_job_details
-- ----------------------------
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
-- Table structure for qrtz_job_listeners
-- ----------------------------
CREATE TABLE `qrtz_job_listeners` (
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `JOB_LISTENER` varchar(200) NOT NULL,
  PRIMARY KEY (`JOB_NAME`,`JOB_GROUP`,`JOB_LISTENER`),
  CONSTRAINT `qrtz_job_listeners_ibfk_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
CREATE TABLE `qrtz_locks` (
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
CREATE TABLE `qrtz_paused_trigger_grps` (
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
CREATE TABLE `qrtz_scheduler_state` (
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
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
-- Table structure for qrtz_trigger_listeners
-- ----------------------------
CREATE TABLE `qrtz_trigger_listeners` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `TRIGGER_LISTENER` varchar(200) NOT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_LISTENER`),
  CONSTRAINT `qrtz_trigger_listeners_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
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
-- Table structure for report
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='报表表';

-- ----------------------------
-- Table structure for sales_target
-- ----------------------------
CREATE TABLE `sales_target` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `TITLE` varchar(64) NOT NULL,
  `OWNER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '目标人员',
  `BARGAIN_MONEY` decimal(10,4) DEFAULT NULL COMMENT '目标成交金额',
  `BEGIN_TIME` datetime DEFAULT NULL COMMENT '开始时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '备注',
  `IS_DELETED` int(4) NOT NULL DEFAULT '0' COMMENT '删除标志',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ORG_ID` (`OWNER_ID`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='销售目标表';

-- ----------------------------
-- Table structure for sm_audit_log
-- ----------------------------
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
  KEY `INDEX_USER_ID` (`CREATOR_ID`),
  KEY `INDEX_MODULE_NAME` (`MODULE_NAME`) USING BTREE,
  KEY `INDEX_TYPE` (`TYPE`),
  KEY `INDEX_CREATED_TIME` (`CREATED_TIME`)
) ENGINE=InnoDB AUTO_INCREMENT=952 DEFAULT CHARSET=utf8 COMMENT='审计日志表';

-- ----------------------------
-- Table structure for sm_component
-- ----------------------------
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
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=990127 DEFAULT CHARSET=utf8 COMMENT='组件表';

-- ----------------------------
-- Table structure for sm_dictionary
-- ----------------------------
CREATE TABLE `sm_dictionary` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `KEY` varchar(64) NOT NULL DEFAULT '',
  `VALUE` varchar(64) NOT NULL DEFAULT '',
  `PARENT_ID` int(11) DEFAULT '0',
  `LEVEL` int(11) DEFAULT NULL,
  `ORDER` int(11) DEFAULT NULL,
  `TYPE` varchar(64) DEFAULT NULL,
  `IS_ACTIVE` int(11) DEFAULT '1',
  `REMARK` varchar(512) NOT NULL DEFAULT '',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '标记删除',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '1',
  `CREATOR_ID` int(10) unsigned DEFAULT '0',
  `CREATED_TIME` datetime NOT NULL,
  `MODIFIER_ID` int(11) DEFAULT '0',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=900019904 DEFAULT CHARSET=utf8 COMMENT='数据字典表';

-- ----------------------------
-- Table structure for sm_function
-- ----------------------------
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
  UNIQUE KEY `INDEX_URL` (`URL`),
  KEY `INDEX_MENU_ID` (`MENU_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_CODE` (`CODE`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=140159 DEFAULT CHARSET=utf8 COMMENT='功能表';

-- ----------------------------
-- Table structure for sm_menu
-- ----------------------------
CREATE TABLE `sm_menu` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键号编',
  `NAME` varchar(32) NOT NULL COMMENT '菜单名称',
  `URL` varchar(64) DEFAULT NULL COMMENT '链接地址',
  `SHOW_LOCATION_TYPE` int(11) DEFAULT '0' COMMENT '显示位置',
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
  UNIQUE KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_CREAOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_ORDER` (`ORDER`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Table structure for sm_module
-- ----------------------------
CREATE TABLE `sm_module` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(32) NOT NULL COMMENT '名称',
  `DESC` varchar(32) NOT NULL COMMENT '述描',
  `ENTITY_CLASS` varchar(256) NOT NULL COMMENT '关联实体类',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='模块表';

-- ----------------------------
-- Table structure for sm_module_type
-- ----------------------------
CREATE TABLE `sm_module_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键编号',
  `TYPE_ID` int(11) NOT NULL COMMENT '类型编号',
  `MODULE_ID` int(11) NOT NULL COMMENT '模块编号',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_TYPE_ID_MODULE_ID` (`TYPE_ID`,`MODULE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='模块类型表\r\n注意：类型编号和模块编号为联合的唯一列\r\n';

-- ----------------------------
-- Table structure for sm_org
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 COMMENT='机构表';

-- ----------------------------
-- Table structure for sm_org_role
-- ----------------------------
CREATE TABLE `sm_org_role` (
  `ORG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '组织ID',
  `ROLE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  PRIMARY KEY (`ORG_ID`,`ROLE_ID`),
  KEY `INDEX_ORG_ID` (`ORG_ID`),
  KEY `INDEX_ROLE_ID` (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='织组角色关联表';

-- ----------------------------
-- Table structure for sm_position
-- ----------------------------
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
  KEY `INDEX_NO` (`CODE`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_CREATEOR_ID` (`CREATEOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='岗位表';

-- ----------------------------
-- Table structure for sm_recyclebin
-- ----------------------------
CREATE TABLE `sm_recyclebin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `MODULE_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '模块名称',
  `RECORD_ID` int(11) NOT NULL DEFAULT '0' COMMENT '记录ID',
  `RECORD_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '记录名',
  `REMARK` varchar(64) DEFAULT NULL COMMENT '备注',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '操作者',
  `CREATED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_USER_ID` (`CREATOR_ID`),
  KEY `INDEX_MODULE_NAME` (`MODULE_NAME`) USING BTREE,
  KEY `INDEX_CREATED_TIME` (`CREATED_TIME`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COMMENT='回收站表';

-- ----------------------------
-- Table structure for sm_role
-- ----------------------------
CREATE TABLE `sm_role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `CODE` varchar(32) DEFAULT NULL COMMENT '角色代码',
  `NAME` varchar(16) DEFAULT NULL COMMENT '角色名',
  `TYPE` int(11) NOT NULL DEFAULT '0' COMMENT '角色类型',
  `REMARK` varchar(255) DEFAULT NULL,
  `IS_DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被删除',
  `IS_INITIALIZED` int(11) NOT NULL DEFAULT '0' COMMENT '是否是初始化数据',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL COMMENT '修改者',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_NAME` (`NAME`),
  UNIQUE KEY `INDEX_CODE` (`CODE`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Table structure for sm_role_com
-- ----------------------------
CREATE TABLE `sm_role_com` (
  `ROLE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `COM_ID` int(11) NOT NULL DEFAULT '0' COMMENT '组件ID',
  PRIMARY KEY (`ROLE_ID`,`COM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色组件表';

-- ----------------------------
-- Table structure for sm_role_func
-- ----------------------------
CREATE TABLE `sm_role_func` (
  `ROLE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `FUNC_ID` int(11) NOT NULL DEFAULT '0' COMMENT '功能ID',
  PRIMARY KEY (`ROLE_ID`,`FUNC_ID`),
  KEY `INDEX_ROLE_ID` (`ROLE_ID`),
  KEY `INDEX_FUNC_ID` (`FUNC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色功能表';

-- ----------------------------
-- Table structure for sm_user
-- ----------------------------
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
  UNIQUE KEY `INDEX_LOGIN_NAME` (`LOGIN_NAME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Table structure for sm_user_com
-- ----------------------------
CREATE TABLE `sm_user_com` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `COM_ID` int(11) NOT NULL DEFAULT '0' COMMENT '组件ID',
  PRIMARY KEY (`USER_ID`,`COM_ID`),
  KEY `INDEX_USER_ID` (`USER_ID`),
  KEY `INDEX_COM_ID` (`COM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组件表';

-- ----------------------------
-- Table structure for sm_user_func
-- ----------------------------
CREATE TABLE `sm_user_func` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `FUNC_ID` int(11) NOT NULL DEFAULT '0' COMMENT '功能ID',
  PRIMARY KEY (`USER_ID`,`FUNC_ID`),
  KEY `INDEX_USER_ID` (`USER_ID`),
  KEY `INDEX_FUNC_ID` (`FUNC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户，功能 对应关系表';

-- ----------------------------
-- Table structure for sm_user_org
-- ----------------------------
CREATE TABLE `sm_user_org` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ORG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '机构ID',
  PRIMARY KEY (`USER_ID`,`ORG_ID`),
  KEY `INDEX_USER_ID` (`USER_ID`),
  KEY `INDEX_ORG_ID` (`ORG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户机构表';

-- ----------------------------
-- Table structure for sm_user_position
-- ----------------------------
CREATE TABLE `sm_user_position` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `POS_ID` int(11) NOT NULL DEFAULT '0' COMMENT '岗位ID',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX-USER_ID` (`USER_ID`),
  KEY `INDEX_POS_ID` (`POS_ID`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户岗位关联表';

-- ----------------------------
-- Table structure for sm_user_role
-- ----------------------------
CREATE TABLE `sm_user_role` (
  `USER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ROLE_ID` int(4) NOT NULL DEFAULT '0' COMMENT '角色ID',
  PRIMARY KEY (`USER_ID`,`ROLE_ID`),
  KEY `INDEX_ROLE_ID` (`ROLE_ID`) USING BTREE,
  KEY `INDEX_USER_ID` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色关联表';

-- ----------------------------
-- Table structure for sm_workbanch
-- ----------------------------
CREATE TABLE `sm_workbanch` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `URL` varchar(64) NOT NULL,
  `TITLE` varchar(64) NOT NULL DEFAULT '' COMMENT '标题',
  `MODULE` varchar(64) NOT NULL DEFAULT '' COMMENT '模块',
  `TYPE` varchar(64) NOT NULL DEFAULT '' COMMENT '类型',
  `WIDTH` varchar(64) NOT NULL DEFAULT '' COMMENT '宽度',
  `PARAMS` varchar(64) DEFAULT '' COMMENT '参数',
  `OWNER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '所有者',
  `ORDER_INDEX` int(4) NOT NULL DEFAULT '0' COMMENT '排序标识',
  `IS_DELETED` int(4) NOT NULL DEFAULT '0' COMMENT '删除标识',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='工作台';

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
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
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_TYPE` (`TYPE`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='供应商';

-- ----------------------------
-- Table structure for sysmessage
-- ----------------------------
CREATE TABLE `sysmessage` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `TITLE` varchar(64) NOT NULL DEFAULT '' COMMENT '标题',
  `CONTENT` text NOT NULL COMMENT '内容',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `IS_DELETED` tinyint(6) NOT NULL DEFAULT '0' COMMENT '是否被删除',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='系统消息';

-- ----------------------------
-- Table structure for user_message
-- ----------------------------
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
  KEY `INDEX_ID` (`ID`),
  KEY `INDEX_MESSAGE_ID` (`MESSAGE_ID`),
  KEY `INDEX_USER_ID` (`USER_ID`),
  KEY `INDEX_STATUS` (`STATUS`),
  KEY `INDEX_TYPE` (`TYPE`),
  KEY `INDEX_CREATED_TIME` (`CREATED_TIME`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 COMMENT='系统消息与用户关联表';

-- ----------------------------
-- Table structure for wf_node
-- ----------------------------
CREATE TABLE `wf_node` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `CODE` varchar(16) DEFAULT NULL,
  `NAME` varchar(32) NOT NULL,
  `FLOW_ID` int(11) NOT NULL,
  `ROLE_ID` int(11) DEFAULT NULL,
  `TYPE_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='流程节点表';

-- ----------------------------
-- Table structure for wf_task
-- ----------------------------
CREATE TABLE `wf_task` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NODE_ID` int(11) DEFAULT NULL COMMENT '节点ID',
  `MODULE_ID` int(11) DEFAULT NULL COMMENT '模块类型id',
  `RECORD_ID` int(11) DEFAULT NULL COMMENT '关联模块记录ID',
  `ORG_ID` int(11) DEFAULT NULL COMMENT '机构id',
  `APPROVER_ID` int(11) DEFAULT NULL COMMENT '审批者',
  `APPROVE_STATUS` int(11) DEFAULT NULL COMMENT '审批状态',
  `APPROVE_TIME` datetime DEFAULT NULL COMMENT '审批时间',
  `REJECT_REASON` varchar(255) DEFAULT NULL COMMENT '退回原因',
  `CREATOR_ID` int(11) DEFAULT NULL COMMENT '流程创建者',
  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) DEFAULT NULL COMMENT '最后修改者',
  `MODIFIED_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='流程任务表';

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `attachment` VALUES ('1', '11010103', '64', '11010201', 'jzds.gif', 'E:\\Workspaces\\apache-tomcat-6.0.35\\webapps\\hxtd\\res\\20140717134246395.gif', '1', '1', '2014-07-17 13:42:46', '1', '2014-07-17 13:44:02');
INSERT INTO `attachment` VALUES ('2', '11010103', '41', '11010201', 'dyf.gif', 'E:\\Workspaces\\apache-tomcat-6.0.35\\webapps\\hxtd\\res\\20140717174611859.gif', '1', '1', '2014-07-17 17:46:11', '1', '2014-07-17 17:46:29');
INSERT INTO `attachment` VALUES ('3', '11010105', '14', '11010203', 'Jellyfish.jpg', 'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\hxtd\\res\\20140717175731179.jpg', '0', '1', '2014-07-17 17:57:31', '1', '2014-07-17 17:57:31');
INSERT INTO `attachment` VALUES ('4', '11010102', '7', '11010201', 'Desert.jpg', 'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\hxtd\\res\\20140717175917777.jpg', '0', '1', '2014-07-17 17:59:17', '1', '2014-07-17 17:59:17');
INSERT INTO `attachment` VALUES ('5', '11010102', '3', '11010201', 'Tulips.jpg', 'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\hxtd\\res\\20140718175947378.jpg', '0', '1', '2014-07-18 17:59:47', '1', '2014-07-18 17:59:47');
INSERT INTO `attachment` VALUES ('6', '11010102', '7', '11010202', '捕获.PNG', 'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\hxtd\\res\\20140721144951812.PNG', '0', '1', '2014-07-21 14:49:51', '1', '2014-07-21 14:49:51');
INSERT INTO `attachment` VALUES ('7', '11010102', '7', '11010202', '捕获.PNG', 'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\hxtd\\res\\20140721145021731.PNG', '0', '1', '2014-07-21 14:50:21', '1', '2014-07-21 14:50:21');
INSERT INTO `attachment` VALUES ('8', '11010103', '61', '11010201', '01.jpg', 'D:\\java\\apache-tomcat-6.0.35-windows-x64\\apache-tomcat-6.0.35\\webapps\\hxtd\\res\\20140721151651294.jpg', '1', '1', '2014-07-21 15:16:51', '1', '2014-07-21 15:17:06');
INSERT INTO `attachment` VALUES ('9', '11010103', '61', '11010201', '11.jpg', 'D:\\java\\apache-tomcat-6.0.35-windows-x64\\apache-tomcat-6.0.35\\webapps\\hxtd\\res\\20140721151658725.jpg', '1', '1', '2014-07-21 15:16:58', '1', '2014-07-21 15:17:08');
INSERT INTO `attachment` VALUES ('10', '11010103', '61', '11010201', '13.jpg', 'D:\\java\\apache-tomcat-6.0.35-windows-x64\\apache-tomcat-6.0.35\\webapps\\hxtd\\res\\20140721152631600.jpg', '0', '1', '2014-07-21 15:26:31', '1', '2014-07-21 15:26:31');
INSERT INTO `contact` VALUES ('5', '测试', '1', '7', null, '4010101', '啊啊', '是啥', '0451-82623629', '18613891430', '82623629@qq.com', '张小飞', '150001', '110000', '110000', '110108', '花园街', '0', '爱仕达', '1', '2014-07-21 10:09:07', '1', '2014-07-21 10:08:35');
INSERT INTO `contact` VALUES ('6', '测试', '1', '7', null, '4010101', '啊啊', '是啥', '0451-82623629', '18613891431', '82623629@qq.com1', '张小飞', '150001', '110000', '110000', '110108', '花园街', '0', '爱仕达', '1', '2014-07-21 10:09:07', '1', '2014-07-21 10:08:35');
INSERT INTO `contract` VALUES ('9', '管理员', '1235456', null, '', '2', '8', '7010101', '12.0000', '2014-07-15 00:00:00', '2014-07-24 00:00:00', '2014-07-15 00:00:00', '', '1', '1', '2014-07-15 11:44:40', '1', '2014-07-17 16:47:28');
INSERT INTO `contract` VALUES ('10', '32313213', '123131', null, null, '1', '8', '7010101', '14.5000', '2014-07-16 00:00:00', '2014-07-24 00:00:00', '2014-07-16 00:00:00', '', '1', '1', '2014-07-15 11:47:47', '1', '2014-07-17 16:47:28');
INSERT INTO `contract` VALUES ('12', '12444443', '344234234242423', null, '', '1', '2', '7010101', '12.0000', '2014-07-08 00:00:00', '2014-07-16 00:00:00', '2014-07-08 00:00:00', '', '1', '1', '2014-07-16 13:46:06', '1', '2014-07-17 16:47:35');
INSERT INTO `contract` VALUES ('13', '的淡淡的', 'sdsds2334', null, null, '1', '3', '7010101', '12.0000', '2014-07-17 00:00:00', '2014-07-23 00:00:00', '2014-07-17 00:00:00', '', '1', '1', '2014-07-16 15:36:27', '1', '2014-07-17 16:47:28');
INSERT INTO `contract` VALUES ('14', 'dsad ', '140714DQYT001', null, '<span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">                                        江苏省徐州市医疗机构集中限价竞价采购药品买卖合同</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">     合同编号: 签订地点: 签订时间: </span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">     买受人(简称:甲方): </span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">     出卖人(简称:乙方): </span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">           甲乙双方本着平等,诚实信用的原则,根据《中华人民共和国合同法》等法律,法规,规章,规范性采购</span>\n<div><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">文件及药品集中采购代理机构向乙方发出的成交候选通知书,经双方协商一致,就有关事项达成如下具体协议.</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">    药品品种,数量,价格</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">    采购药品品种和数量:甲方向乙方所采购的药品品种,剂型,规格,数量等详见药品成交品种买卖电子订单.</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">    药品的价格</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">在合同有效期</span><img /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">内乙方提交药品的价格必须是不高于成交候选通知书中确认的价格,本价格为甲方的入库价格.</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">成交药品临时最高零售价格执行期间,遇国家或省价格主管部门下调价格或其他情况时,对未供货部分,甲乙双方可协商调整供货价格.</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">质量标准</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">乙方交付的药品必须符合国家最新药典或国家药品监督管理部门规定的标准,并与供应时的承诺相一致,</span></div>\n<div><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">附有该药品生产企业同批号的出厂药品检验记录或合格证,以备验收检查.</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">药品有效期</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">乙方交付药品的有效期应与文件中规定的有效期相一致.</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">乙方所提供药品的有效期不得少于12个月;特殊品种双方另行商定.</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">包装标准</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">乙方提供的全部药品均应按国家规定的标准保护措施进行包装,每一个包装箱内应附有一份详细装箱</span></div>\n<div><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">数量单和该药品生产企业同批号的出厂药品检验记录或合格证(进口药品应提供进口药品注册证和口岸</span></div>\n<div><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">药检所的进口药品检验报告书复印件,并加盖经营企业公章).如为拼装箱件,箱内应按前述要求附有各种</span></div>\n<div><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">药品数量单和药品质量证明材料复印件,并加盖配送企业公章.</span><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\"><span class=\"copytips\" style=\"font-size: 0px; color: rgb(245, 248, 253); width: 0px; overflow: hidden; height: 0px; display: inline-block;\"></span></span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">特殊要求: </span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">配送服务</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">配送由乙方提供或组织提供,乙方按合同要求对甲方提供或组织配送服务,每次配送的时间和数量以乙方收到甲方的供货通知为准.</span></div>\n<div><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">原则上在乙方收到供货通知后36小时内送达,属急救及加急供货的应在4小时内送达.(具体做法见第十一条)</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">伴随服务</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">乙方应甲方要求提供或组织提供下列伴随服务:</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">药品的现场搬运或入库;</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">提供药品开箱或分装的用具;</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">对进货验收时发现的破损,有效期少于12个月或不符合特殊约定期限的药品及其他不合格包装的药品及时更换;</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">验收方式: </span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">在甲方指定地点(甲方医疗服务范围内)为所供药品的临床应用免费进行现场讲解或培训.</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">双方的权利义务</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">甲方必须按合同约定采购成交药品品种;除本条第四项规定外,甲方不得采购其他非成交药品替代成交品种.</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">甲方须在合同规定的时间内,按实际入库的药品数量及时结算货款;并在货,票验收后60日内结清货款.</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">甲方在接收药品时,应于当日对药品进行验收入库,对乙方提供的药品不符合合同约定的品种,数量,质量要求的部分,</span></div>\n<div><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">甲方有权拒绝接受.</span><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">甲方有证据证明乙方交付的药品不符合质量标准(以省,省辖市药监部门的检验结果为准)或延期交货等不按合同约定交货时,</span></div>\n<div><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">可以书面通知乙方终止该药品的供货;并可以另行采购替代药品;同时将选择的替代成交药品名称,价格,数量清单或另行采购替代药品的协议,</span></div>\n<div><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">在七日内由甲方送徐州市药品集中招标采购管理办公室和药品集中采购代理机构各一份备案.(具体做法见第十一条)</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">乙方必须按照合同约定的药品品种,数量,质量要求和期限,配送或组织配送成交药品并提供伴随服务.</span><br style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\" /><span style=\"font-family: Simsun; font-size: 14px; line-height: 28px;\">乙方应保证甲方在使用成交药品时,不存在该药品专利权,商标权或保护期等知识产权方面的争议,如产生争议由乙方自行处理和承担责任.</span></div>', '1', '2', '7010101', '12.4000', '2014-07-31 00:00:00', '2014-07-24 00:00:00', '2014-07-31 00:00:00', 'das', '1', '1', '2014-07-17 13:36:43', '1', '2014-07-21 09:21:21');
INSERT INTO `contract` VALUES ('15', 'admin', '123456', null, 'sa', '2', '3', '7010101', '12.3000', '2014-07-18 00:00:00', '2014-07-18 00:00:00', '2014-07-18 00:00:00', 'ds', '1', '1', '2014-07-17 15:44:19', '1', '2014-07-17 16:47:28');
INSERT INTO `contract` VALUES ('16', 'iu', '还不考虑看见了分公司的飞', null, 'df\n<div>fd</div>\n<div>w<font size=\"3\">eeee</font></div>\n<div><font size=\"3\">ee</font><br />\n<div style=\"float: right; width: 150px; margin: 10px; padding: 5px; border: 1px solid maroon; font-family: Arial, Helvetica, Georgia; font-weight: bold; line-height: 140%; background: rgb(255, 215, 0);\">eeee</div><br /><font size=\"3\">e</font>e</div>\n<div><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span></div><br />\n<table cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"border-top:1px solid #b8b8b8;border-left:1px solid #b8b8b8;padding-top:5px;padding-left:5px;\"><br />\n<div style=\"float: right; width: 150px; margin: 10px; padding: 5px; border: 1px solid maroon; font-family: Arial, Helvetica, Georgia; font-weight: bold; line-height: 140%; background: rgb(255, 215, 0);\">dfgd\n&nbsp;</div><br /></td>\n<td style=\"border-top-width: 1px; border-top-style: solid; border-top-color: rgb(184, 184, 184); border-right-width: 1px; border-right-style: solid; border-right-color: rgb(184, 184, 184); width: 21px; height: 17px;\"><br /></td></tr>\n<tr>\n<td width=\"*\" style=\"border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: rgb(184, 184, 184); border-left-width: 1px; border-left-style: solid; border-left-color: rgb(184, 184, 184);\">&nbsp;</td>\n<td style=\"width:21px;height:17px;\"><img src=\"http://localhost:8080/hxtd\" static=\"\" js=\"\" htmlbox=\"\" images=\"\" corner.gif?=\"\" style=\"width:21px;height:17px;\" /></td></tr></tbody></table><br />\n<div><br />\n<div style=\"float: right; width: 150px; margin: 10px; padding: 5px; border: 1px solid maroon; font-family: Arial, Helvetica, Georgia; font-weight: bold; line-height: 140%; background: rgb(255, 215, 0);\"></div><br /></div>', '3', '2', '7010101', '666.9900', '2014-07-25 00:00:00', '2014-07-18 00:00:00', '2014-07-25 00:00:00', '', '1', '1', '2014-07-17 15:47:03', '1', '2014-07-17 17:04:51');
INSERT INTO `contract` VALUES ('17', '333333', '140714DQYT001', null, 'ds', '1', '7', '7010101', '120.3000', '2014-07-24 00:00:00', '2014-07-23 00:00:00', '2014-07-24 00:00:00', '222', '0', '1', '2014-07-22 10:36:44', '1', '2014-07-22 10:36:44');
INSERT INTO `customer` VALUES ('7', '1', '罗晓丽1', '4030101', '4030204', '4030401', '4030301', '230467876534560992', '13910897865', '13910897865', '软件开发', '工程师', '362350061@qq.com', '100100000', '100000', '百会公司1', '4030501', '4030601', '4030701', '北京农行', '10000000', '110000', '110000', '110108', null, '朝阳', '未知', '1百万', '罗晓丽', '张三', '上三', '尚山', '****', '0', '1', '2014-07-20 21:55:22', '1', '2014-07-21 09:20:23');
INSERT INTO `customer` VALUES ('14', '13', '鹅鹅鹅饿饿', null, '4030203', null, null, '', '03166123701', '13909878908', '', '', '', '', '', '3123的大树大', '4030501', null, null, '', '', null, null, null, '', '', '', '', '', '', '', '', '', '0', '1', '2014-07-22 13:50:27', '1', '2014-07-22 13:56:00');
INSERT INTO `lead` VALUES ('61', '1', '百会17', '罗晓丽17', '研发中心17', '软件工程师17', '362350061@qq.com17', '18600884611', '18600884627', '18600884611', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100017', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼17', '无17', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('62', '1', '百会18', '罗晓丽18', '研发中心18', '软件工程师18', '362350061@qq.com18', '18600884612', '18600884628', '18600884612', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100018', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼18', '无18', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('63', '1', '百会19', '罗晓丽19', '研发中心19', '软件工程师19', '362350061@qq.com19', '18600884613', '18600884629', '18600884613', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100019', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼19', '无19', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('64', '1', '百会20', '罗晓丽20', '研发中心19', '软件工程师19', '362350061@qq.com20', '18600884614', '18600884630', '18600884614', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100020', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼19', '无19', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('65', '1', '百会21', '罗晓丽21', '研发中心1', '软件工程师1', '362350061@qq.com21', '18600884615', '18600884631', '18600884615', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100021', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼20', '无20', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('66', '1', '百会22', '罗晓丽22', '研发中心2', '软件工程师2', '362350061@qq.com22', '18600884616', '18600884632', '18600884616', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100022', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼21', '无21', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('67', '1', '百会23', '罗晓丽23', '研发中心3', '软件工程师3', '362350061@qq.com23', '18600884617', '18600884633', '18600884617', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100023', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼22', '无22', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('68', '1', '百会24', '罗晓丽24', '研发中心4', '软件工程师4', '362350061@qq.com24', '18600884618', '18600884634', '18600884618', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100024', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼23', '无23', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('69', '1', '百会25', '罗晓丽25', '研发中心5', '软件工程师5', '362350061@qq.com25', '18600884619', '18600884635', '18600884619', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100025', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼24', '无24', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('70', '1', '百会26', '罗晓丽26', '研发中心6', '软件工程师6', '362350061@qq.com26', '18600884620', '18600884636', '18600884620', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100026', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼25', '无25', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('71', '1', '百会27', '罗晓丽27', '研发中心7', '软件工程师7', '362350061@qq.com27', '18600884621', '18600884637', '18600884621', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100027', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼26', '无26', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('72', '1', '百会28', '罗晓丽28', '研发中心8', '软件工程师8', '362350061@qq.com28', '18600884622', '18600884638', '18600884622', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100028', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼27', '无27', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('73', '1', '百会29', '罗晓丽29', '研发中心9', '软件工程师9', '362350061@qq.com29', '18600884623', '18600884639', '18600884623', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100029', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼28', '无28', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('74', '1', '百会30', '罗晓丽30', '研发中心10', '软件工程师10', '362350061@qq.com30', '18600884624', '18600884640', '18600884624', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100030', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼29', '无29', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('75', '1', '百会32', '罗晓丽32', '研发中心12', '软件工程师12', '362350061@qq.com', '18600884626', '18600884642', '18600884626', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100032', '110000', null, null, '花园北路14号环星大厦D座二楼31', '无31', '0', '1', '2014-07-21 18:04:39', '1', '2014-07-21 18:04:39', '1');
INSERT INTO `lead` VALUES ('76', '1', '百会31', '罗晓丽31', '研发中心11', '软件工程师11', '362350061@qq.com31', '18600884625', '18600884641', '18600884625', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100031', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼30', '无30', '0', '1', '2014-07-21 16:26:47', '1', '2014-07-21 16:26:47', null);
INSERT INTO `lead` VALUES ('77', '1', '百会18', '罗晓丽18', '研发中心18', '软件工程师18', '362350061@qq.com18', '18600884612', '18600884628', '18600884612', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100018', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼18', '无18', '0', '1', '2014-07-19 16:25:51', '1', '2014-07-19 16:25:51', null);
INSERT INTO `lead` VALUES ('78', '1', '百会17', '罗晓丽17', '研发中心17', '软件工程师17', '362350061@qq.com17', '18600884611', '18600884627', '18600884611', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100017', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼17', '无17', '0', '1', '2014-07-19 16:25:51', '1', '2014-07-19 16:25:51', null);
INSERT INTO `lead` VALUES ('79', '1', '百会19', '罗晓丽19', '研发中心19', '软件工程师19', '362350061@qq.com19', '18600884614', '18600884629', '18600884614', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100019', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼19', '无19', '0', '1', '2014-07-19 16:25:51', '1', '2014-07-19 16:25:51', null);
INSERT INTO `lead` VALUES ('80', '1', '百会19', '罗晓丽19', '研发中心19', '软件工程师19', '362350061@qq.com19', '18600884613', '18600884629', '18600884613', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100019', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼19', '无19', '0', '1', '2014-07-19 16:25:51', '1', '2014-07-19 16:25:51', null);
INSERT INTO `lead` VALUES ('81', '1', '百会33', '罗晓丽33', '研发中心13', '软件工程师13', '362350061@qq.com33', '18600884627', '18600884643', '18600884627', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100033', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼32', '无32', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:11', null);
INSERT INTO `lead` VALUES ('82', '1', '百会34', '罗晓丽34', '研发中心14', '软件工程师14', '362350061@qq.com34', '18600884628', '18600884644', '18600884628', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100034', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼33', '无33', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:11', null);
INSERT INTO `lead` VALUES ('83', '1', '百会37', '罗晓丽37', '研发中心17', '软件工程师17', '362350061@qq.com37', '18600884631', '18600884647', '18600884631', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100037', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼36', '无36', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:11', null);
INSERT INTO `lead` VALUES ('84', '1', '百会38', '罗晓丽38', '研发中心18', '软件工程师18', '362350061@qq.com38', '18600884632', '18600884648', '18600884632', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100038', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼37', '无37', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:11', null);
INSERT INTO `lead` VALUES ('85', '1', '百会35', '罗晓丽35', '研发中心15', '软件工程师15', '362350061@qq.com35', '18600884629', '18600884645', '18600884629', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100035', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼34', '无34', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:11', null);
INSERT INTO `lead` VALUES ('86', '1', '百会36', '罗晓丽36', '研发中心16', '软件工程师16', '362350061@qq.com36', '18600884630', '18600884646', '18600884630', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100036', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼35', '无35', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:11', null);
INSERT INTO `lead` VALUES ('87', '1', '百会41', '罗晓丽41', '研发中心1', '软件工程师1', '362350061@qq.com41', '18600884635', '18600884651', '18600884635', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100041', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼40', '无40', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:11', null);
INSERT INTO `lead` VALUES ('88', '1', '百会42', '罗晓丽42', '研发中心2', '软件工程师2', '362350061@qq.com42', '18600884636', '18600884652', '18600884636', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100042', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼41', '无41', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:11', null);
INSERT INTO `lead` VALUES ('89', '1', '百会39', '罗晓丽39', '研发中心19', '软件工程师19', '362350061@qq.com39', '18600884633', '18600884649', '18600884633', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100039', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼38', '无38', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:11', null);
INSERT INTO `lead` VALUES ('90', '1', '百会40', '罗晓丽40', '研发中心19', '软件工程师19', '362350061@qq.com40', '18600884634', '18600884650', '18600884634', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100040', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼39', '无39', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:11', null);
INSERT INTO `lead` VALUES ('91', '1', '百会45', '罗晓丽45', '研发中心5', '软件工程师5', '362350061@qq.com45', '18600884639', '18600884655', '18600884639', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100045', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼44', '无44', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:11', null);
INSERT INTO `lead` VALUES ('92', '1', '百会46', '罗晓丽46', '研发中心6', '软件工程师6', '362350061@qq.com46', '18600884640', '18600884656', '18600884640', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100046', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼45', '无45', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:11', null);
INSERT INTO `lead` VALUES ('93', '1', '百会43', '罗晓丽43', '研发中心3', '软件工程师3', '362350061@qq.com43', '18600884637', '18600884653', '18600884637', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100043', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼42', '无42', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 18:26:07', null);
INSERT INTO `lead` VALUES ('94', '1', '百会44', '罗晓丽44', '研发中心4', '软件工程师4', '362350061@qq.com44', '18600884638', '18600884654', '18600884638', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100044', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼43', '无43', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 18:26:07', null);
INSERT INTO `lead` VALUES ('95', '1', '百会50', '罗晓丽50', '研发中心10', '软件工程师10', '362350061@qq.com50', '18600884644', '18600884660', '18600884644', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100050', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼49', '无49', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 18:26:07', null);
INSERT INTO `lead` VALUES ('96', '1', '百会49', '罗晓丽49', '研发中心9', '软件工程师9', '362350061@qq.com49', '18600884643', '18600884659', '18600884643', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100049', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼48', '无48', '0', '1', '2014-07-21 16:26:11', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('97', '1', '百会48', '罗晓丽48', '研发中心8', '软件工程师8', '362350061@qq.com48', '18600884642', '18600884658', '18600884642', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100048', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼47', '无47', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('98', '1', '百会47', '罗晓丽47', '研发中心7', '软件工程师7', '362350061@qq.com47', '18600884641', '18600884657', '18600884641', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100047', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼46', '无46', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('99', '1', '百会54', '罗晓丽54', '研发中心14', '软件工程师14', '362350061@qq.com54', '18600884648', '18600884664', '18600884648', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100054', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼53', '无53', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 18:26:07', null);
INSERT INTO `lead` VALUES ('100', '1', '百会53', '罗晓丽53', '研发中心13', '软件工程师13', '362350061@qq.com53', '18600884647', '18600884663', '18600884647', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100053', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼52', '无52', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 18:26:07', null);
INSERT INTO `lead` VALUES ('101', '1', '百会52', '罗晓丽52', '研发中心12', '软件工程师12', '362350061@qq.com52', '18600884646', '18600884662', '18600884646', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100052', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼51', '无51', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 18:26:07', null);
INSERT INTO `lead` VALUES ('102', '1', '百会51', '罗晓丽51', '研发中心11', '软件工程师11', '362350061@qq.com51', '18600884645', '18600884661', '18600884645', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100051', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼50', '无50', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('103', '1', '百会58', '罗晓丽58', '研发中心18', '软件工程师18', '362350061@qq.com45', '18600884652', '18600884668', '18600884652', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100058', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼57', '无57', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('104', '1', '百会57', '罗晓丽57', '研发中心17', '软件工程师17', '362350061@qq.com44', '18600884651', '18600884667', '18600884651', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100057', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼56', '无56', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('105', '1', '百会56', '罗晓丽56', '研发中心16', '软件工程师16', '362350061@qq.com43', '18600884650', '18600884666', '18600884650', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100056', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼55', '无55', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('106', '1', '百会55', '罗晓丽55', '研发中心15', '软件工程师15', '362350061@qq.com55', '18600884649', '18600884665', '18600884649', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100055', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼54', '无54', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('107', '1', '百会62', '罗晓丽62', '研发中心2', '软件工程师2', '362350061@qq.com49', '18600884656', '18600884672', '18600884656', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100062', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼61', '无61', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('108', '1', '百会61', '罗晓丽61', '研发中心1', '软件工程师1', '362350061@qq.com48', '18600884655', '18600884671', '18600884655', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100061', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼60', '无60', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('109', '1', '百会60', '罗晓丽60', '研发中心19', '软件工程师19', '362350061@qq.com47', '18600884654', '18600884670', '18600884654', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100060', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼59', '无59', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('110', '1', '百会59', '罗晓丽59', '研发中心19', '软件工程师19', '362350061@qq.com46', '18600884653', '18600884669', '18600884653', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100059', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼58', '无58', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('111', '1', '百会67', '罗晓丽67', '研发中心7', '软件工程师7', '362350061@qq.com54', '18600884661', '18600884677', '18600884661', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100067', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼66', '无66', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('112', '1', '百会68', '罗晓丽68', '研发中心8', '软件工程师8', '362350061@qq.com55', '18600884662', '18600884678', '18600884662', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100068', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼67', '无67', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('113', '1', '百会69', '罗晓丽69', '研发中心9', '软件工程师9', '362350061@qq.com56', '18600884663', '18600884679', '18600884663', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100069', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼68', '无68', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('114', '1', '百会70', '罗晓丽70', '研发中心10', '软件工程师10', '362350061@qq.com57', '18600884664', '18600884680', '18600884664', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100070', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼69', '无69', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('115', '1', '百会63', '罗晓丽63', '研发中心3', '软件工程师3', '362350061@qq.com50', '18600884657', '18600884673', '18600884657', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100063', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼62', '无62', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('116', '1', '百会64', '罗晓丽64', '研发中心4', '软件工程师4', '362350061@qq.com51', '18600884658', '18600884674', '18600884658', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100064', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼63', '无63', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('117', '1', '百会65', '罗晓丽65', '研发中心5', '软件工程师5', '362350061@qq.com52', '18600884659', '18600884675', '18600884659', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100065', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼64', '无64', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('118', '1', '百会66', '罗晓丽66', '研发中心6', '软件工程师6', '362350061@qq.com53', '18600884660', '18600884676', '18600884660', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100066', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼65', '无65', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('119', '1', '百会75', '罗晓丽75', '研发中心15', '软件工程师15', '362350061@qq.com62', '18600884669', '18600884685', '18600884669', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100075', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼74', '无74', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('120', '1', '百会76', '罗晓丽76', '研发中心16', '软件工程师16', '362350061@qq.com63', '18600884670', '18600884686', '18600884670', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100076', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼75', '无75', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('121', '1', '百会77', '罗晓丽77', '研发中心17', '软件工程师17', '362350061@qq.com64', '18600884671', '18600884687', '18600884671', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100077', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼76', '无76', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('122', '1', '百会78', '罗晓丽78', '研发中心18', '软件工程师18', '362350061@qq.com65', '18600884672', '18600884688', '18600884672', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100078', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼77', '无77', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('123', '1', '百会71', '罗晓丽71', '研发中心11', '软件工程师11', '362350061@qq.com58', '18600884665', '18600884681', '18600884665', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100071', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼70', '无70', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('124', '1', '百会72', '罗晓丽72', '研发中心12', '软件工程师12', '362350061@qq.com59', '18600884666', '18600884682', '18600884666', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100072', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼71', '无71', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('125', '1', '百会73', '罗晓丽73', '研发中心13', '软件工程师13', '362350061@qq.com60', '18600884667', '18600884683', '18600884667', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100073', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼72', '无72', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('126', '1', '百会74', '罗晓丽74', '研发中心14', '软件工程师14', '362350061@qq.com61', '18600884668', '18600884684', '18600884668', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100074', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼73', '无73', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('127', '1', '百会84', '罗晓丽84', '研发中心4', '软件工程师4', '362350061@qq.com71', '18600884678', '18600884694', '18600884678', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100084', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼83', '无83', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('128', '1', '百会83', '罗晓丽83', '研发中心3', '软件工程师3', '362350061@qq.com70', '18600884677', '18600884693', '18600884677', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100083', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼82', '无82', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('129', '1', '百会86', '罗晓丽86', '研发中心6', '软件工程师6', '362350061@qq.com73', '18600884680', '18600884696', '18600884680', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100086', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼85', '无85', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:12', null);
INSERT INTO `lead` VALUES ('130', '1', '百会85', '罗晓丽85', '研发中心5', '软件工程师5', '362350061@qq.com72', '18600884679', '18600884695', '18600884679', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100085', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼84', '无84', '0', '1', '2014-07-21 16:26:12', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('131', '1', '百会80', '罗晓丽80', '研发中心19', '软件工程师19', '362350061@qq.com67', '18600884674', '18600884690', '18600884674', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100080', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼79', '无79', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('132', '1', '百会79', '罗晓丽79', '研发中心19', '软件工程师19', '362350061@qq.com66', '18600884673', '18600884689', '18600884673', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100079', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼78', '无78', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('133', '1', '百会82', '罗晓丽82', '研发中心2', '软件工程师2', '362350061@qq.com69', '18600884676', '18600884692', '18600884676', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100082', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼81', '无81', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('134', '1', '百会81', '罗晓丽81', '研发中心1', '软件工程师1', '362350061@qq.com68', '18600884675', '18600884691', '18600884675', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100081', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼80', '无80', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('135', '1', '百会92', '罗晓丽92', '研发中心12', '软件工程师12', '362350061@qq.com79', '18600884686', '18600884702', '18600884686', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100092', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼91', '无91', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('136', '1', '百会91', '罗晓丽91', '研发中心11', '软件工程师11', '362350061@qq.com78', '18600884685', '18600884701', '18600884685', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100091', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼90', '无90', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('137', '1', '百会94', '罗晓丽94', '研发中心14', '软件工程师14', '362350061@qq.com81', '18600884688', '18600884704', '18600884688', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100094', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼93', '无93', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('138', '1', '百会93', '罗晓丽93', '研发中心13', '软件工程师13', '362350061@qq.com80', '18600884687', '18600884703', '18600884687', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100093', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼92', '无92', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('139', '1', '百会88', '罗晓丽88', '研发中心8', '软件工程师8', '362350061@qq.com75', '18600884682', '18600884698', '18600884682', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100088', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼87', '无87', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('140', '1', '百会87', '罗晓丽87', '研发中心7', '软件工程师7', '362350061@qq.com74', '18600884681', '18600884697', '18600884681', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100087', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼86', '无86', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('141', '1', '百会90', '罗晓丽90', '研发中心10', '软件工程师10', '362350061@qq.com77', '18600884684', '18600884700', '18600884684', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100090', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼89', '无89', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('142', '1', '百会89', '罗晓丽89', '研发中心9', '软件工程师9', '362350061@qq.com76', '18600884683', '18600884699', '18600884683', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100089', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼88', '无88', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('143', '1', '百会101', '罗晓丽101', '研发中心1', '软件工程师1', '362350061@qq.com88', '18600884695', '18600884711', '18600884695', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100101', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼100', '无100', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('144', '1', '百会102', '罗晓丽102', '研发中心2', '软件工程师2', '362350061@qq.com89', '18600884696', '18600884712', '18600884696', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100102', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼101', '无101', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('145', '1', '百会99', '罗晓丽99', '研发中心19', '软件工程师19', '362350061@qq.com86', '18600884693', '18600884709', '18600884693', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100099', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼98', '无98', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('146', '1', '百会100', '罗晓丽100', '研发中心19', '软件工程师19', '362350061@qq.com87', '18600884694', '18600884710', '18600884694', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100100', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼99', '无99', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('147', '1', '百会97', '罗晓丽97', '研发中心17', '软件工程师17', '362350061@qq.com84', '18600884691', '18600884707', '18600884691', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100097', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼96', '无96', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('148', '1', '百会98', '罗晓丽98', '研发中心18', '软件工程师18', '362350061@qq.com85', '18600884692', '18600884708', '18600884692', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100098', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼97', '无97', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('149', '1', '百会95', '罗晓丽95', '研发中心15', '软件工程师15', '362350061@qq.com82', '18600884689', '18600884705', '18600884689', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100095', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼94', '无94', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('150', '1', '百会96', '罗晓丽96', '研发中心16', '软件工程师16', '362350061@qq.com83', '18600884690', '18600884706', '18600884690', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100096', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼95', '无95', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('151', '1', '百会109', '罗晓丽109', '研发中心9', '软件工程师9', '362350061@qq.com96', '18600884703', '18600884719', '18600884703', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100109', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼108', '无108', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('152', '1', '百会110', '罗晓丽110', '研发中心10', '软件工程师10', '362350061@qq.com97', '18600884704', '18600884720', '18600884704', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100110', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼109', '无109', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('153', '1', '百会107', '罗晓丽107', '研发中心7', '软件工程师7', '362350061@qq.com94', '18600884701', '18600884717', '18600884701', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100107', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼106', '无106', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('154', '1', '百会108', '罗晓丽108', '研发中心8', '软件工程师8', '362350061@qq.com95', '18600884702', '18600884718', '18600884702', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100108', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼107', '无107', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('155', '1', '百会105', '罗晓丽105', '研发中心5', '软件工程师5', '362350061@qq.com92', '18600884699', '18600884715', '18600884699', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100105', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼104', '无104', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('156', '1', '百会106', '罗晓丽106', '研发中心6', '软件工程师6', '362350061@qq.com93', '18600884700', '18600884716', '18600884700', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100106', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼105', '无105', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('157', '1', '百会103', '罗晓丽103', '研发中心3', '软件工程师3', '362350061@qq.com90', '18600884697', '18600884713', '18600884697', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100103', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼102', '无102', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('158', '1', '百会104', '罗晓丽104', '研发中心4', '软件工程师4', '362350061@qq.com91', '18600884698', '18600884714', '18600884698', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100104', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼103', '无103', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('159', '1', '百会118', '罗晓丽118', '研发中心18', '软件工程师18', '362350061@qq.com105', '18600884712', '18600884728', '18600884712', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100118', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼117', '无117', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('160', '1', '百会117', '罗晓丽117', '研发中心17', '软件工程师17', '362350061@qq.com104', '18600884711', '18600884727', '18600884711', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100117', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼116', '无116', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('161', '1', '百会116', '罗晓丽116', '研发中心16', '软件工程师16', '362350061@qq.com103', '18600884710', '18600884726', '18600884710', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100116', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼115', '无115', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('162', '1', '百会115', '罗晓丽115', '研发中心15', '软件工程师15', '362350061@qq.com102', '18600884709', '18600884725', '18600884709', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100115', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼114', '无114', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('163', '1', '百会114', '罗晓丽114', '研发中心14', '软件工程师14', '362350061@qq.com101', '18600884708', '18600884724', '18600884708', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100114', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼113', '无113', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:13', null);
INSERT INTO `lead` VALUES ('164', '1', '百会113', '罗晓丽113', '研发中心13', '软件工程师13', '362350061@qq.com100', '18600884707', '18600884723', '18600884707', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100113', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼112', '无112', '0', '1', '2014-07-21 16:26:13', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('165', '1', '百会112', '罗晓丽112', '研发中心12', '软件工程师12', '362350061@qq.com99', '18600884706', '18600884722', '18600884706', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100112', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼111', '无111', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('166', '1', '百会111', '罗晓丽111', '研发中心11', '软件工程师11', '362350061@qq.com98', '18600884705', '18600884721', '18600884705', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100111', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼110', '无110', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('167', '1', '百会126', '罗晓丽126', '研发中心6', '软件工程师6', '362350061@qq.com113', '18600884720', '18600884736', '18600884720', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100126', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼125', '无125', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('168', '1', '百会125', '罗晓丽125', '研发中心5', '软件工程师5', '362350061@qq.com112', '18600884719', '18600884735', '18600884719', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100125', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼124', '无124', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('169', '1', '百会124', '罗晓丽124', '研发中心4', '软件工程师4', '362350061@qq.com111', '18600884718', '18600884734', '18600884718', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100124', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼123', '无123', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('170', '1', '百会123', '罗晓丽123', '研发中心3', '软件工程师3', '362350061@qq.com110', '18600884717', '18600884733', '18600884717', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100123', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼122', '无122', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('171', '1', '百会122', '罗晓丽122', '研发中心2', '软件工程师2', '362350061@qq.com109', '18600884716', '18600884732', '18600884716', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100122', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼121', '无121', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('172', '1', '百会121', '罗晓丽121', '研发中心1', '软件工程师1', '362350061@qq.com108', '18600884715', '18600884731', '18600884715', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100121', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼120', '无120', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('173', '1', '百会120', '罗晓丽120', '研发中心19', '软件工程师19', '362350061@qq.com107', '18600884714', '18600884730', '18600884714', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100120', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼119', '无119', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('174', '1', '百会119', '罗晓丽119', '研发中心19', '软件工程师19', '362350061@qq.com106', '18600884713', '18600884729', '18600884713', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100119', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼118', '无118', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('175', '1', '百会136', '罗晓丽136', '研发中心16', '软件工程师16', '362350061@qq.com123', '18600884730', '18600884746', '18600884730', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100136', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼135', '无135', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('176', '1', '百会135', '罗晓丽135', '研发中心15', '软件工程师15', '362350061@qq.com122', '18600884729', '18600884745', '18600884729', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100135', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼134', '无134', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('177', '1', '百会138', '罗晓丽138', '研发中心18', '软件工程师18', '362350061@qq.com125', '18600884732', '18600884748', '18600884732', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100138', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼137', '无137', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('178', '1', '百会137', '罗晓丽137', '研发中心17', '软件工程师17', '362350061@qq.com124', '18600884731', '18600884747', '18600884731', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100137', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼136', '无136', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('179', '1', '百会140', '罗晓丽140', '研发中心19', '软件工程师19', '362350061@qq.com127', '18600884734', '18600884750', '18600884734', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100140', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼139', '无139', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('180', '1', '百会139', '罗晓丽139', '研发中心19', '软件工程师19', '362350061@qq.com126', '18600884733', '18600884749', '18600884733', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100139', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼138', '无138', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('181', '1', '百会142', '罗晓丽142', '研发中心2', '软件工程师2', '362350061@qq.com129', '18600884736', '18600884752', '18600884736', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100142', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼141', '无141', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('182', '1', '百会141', '罗晓丽141', '研发中心1', '软件工程师1', '362350061@qq.com128', '18600884735', '18600884751', '18600884735', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100141', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼140', '无140', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('183', '1', '百会128', '罗晓丽128', '研发中心8', '软件工程师8', '362350061@qq.com115', '18600884722', '18600884738', '18600884722', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100128', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼127', '无127', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('184', '1', '百会127', '罗晓丽127', '研发中心7', '软件工程师7', '362350061@qq.com114', '18600884721', '18600884737', '18600884721', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100127', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼126', '无126', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('185', '1', '百会130', '罗晓丽130', '研发中心10', '软件工程师10', '362350061@qq.com117', '18600884724', '18600884740', '18600884724', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100130', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼129', '无129', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('186', '1', '百会129', '罗晓丽129', '研发中心9', '软件工程师9', '362350061@qq.com116', '18600884723', '18600884739', '18600884723', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100129', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼128', '无128', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('187', '1', '百会132', '罗晓丽132', '研发中心12', '软件工程师12', '362350061@qq.com119', '18600884726', '18600884742', '18600884726', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100132', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼131', '无131', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('188', '1', '百会131', '罗晓丽131', '研发中心11', '软件工程师11', '362350061@qq.com118', '18600884725', '18600884741', '18600884725', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100131', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼130', '无130', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('189', '1', '百会134', '罗晓丽134', '研发中心14', '软件工程师14', '362350061@qq.com121', '18600884728', '18600884744', '18600884728', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100134', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼133', '无133', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('190', '1', '百会133', '罗晓丽133', '研发中心13', '软件工程师13', '362350061@qq.com120', '18600884727', '18600884743', '18600884727', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100133', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼132', '无132', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('191', '1', '百会151', '罗晓丽151', '研发中心11', '软件工程师11', '362350061@qq.com138', '18600884745', '18600884761', '18600884745', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100151', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼150', '无150', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('192', '1', '百会152', '罗晓丽152', '研发中心12', '软件工程师12', '362350061@qq.com139', '18600884746', '18600884762', '18600884746', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100152', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼151', '无151', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('193', '1', '百会153', '罗晓丽153', '研发中心13', '软件工程师13', '362350061@qq.com140', '18600884747', '18600884763', '18600884747', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100153', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼152', '无152', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('194', '1', '百会154', '罗晓丽154', '研发中心14', '软件工程师14', '362350061@qq.com141', '18600884748', '18600884764', '18600884748', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100154', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼153', '无153', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('195', '1', '百会155', '罗晓丽155', '研发中心15', '软件工程师15', '362350061@qq.com142', '18600884749', '18600884765', '18600884749', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100155', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼154', '无154', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('196', '1', '百会156', '罗晓丽156', '研发中心16', '软件工程师16', '362350061@qq.com143', '18600884750', '18600884766', '18600884750', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100156', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼155', '无155', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('197', '1', '百会157', '罗晓丽157', '研发中心17', '软件工程师17', '362350061@qq.com144', '18600884751', '18600884767', '18600884751', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100157', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼156', '无156', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('198', '1', '百会158', '罗晓丽158', '研发中心18', '软件工程师18', '362350061@qq.com145', '18600884752', '18600884768', '18600884752', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100158', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼157', '无157', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('199', '1', '百会143', '罗晓丽143', '研发中心3', '软件工程师3', '362350061@qq.com130', '18600884737', '18600884753', '18600884737', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100143', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼142', '无142', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('200', '1', '百会144', '罗晓丽144', '研发中心4', '软件工程师4', '362350061@qq.com131', '18600884738', '18600884754', '18600884738', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100144', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼143', '无143', '0', '1', '2014-07-21 16:26:14', '1', '2014-07-21 16:26:14', null);
INSERT INTO `lead` VALUES ('201', '1', '百会145', '罗晓丽145', '研发中心5', '软件工程师5', '362350061@qq.com132', '18600884739', '18600884755', '18600884739', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100145', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼144', '无144', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('202', '1', '百会146', '罗晓丽146', '研发中心6', '软件工程师6', '362350061@qq.com133', '18600884740', '18600884756', '18600884740', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100146', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼145', '无145', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('203', '1', '百会147', '罗晓丽147', '研发中心7', '软件工程师7', '362350061@qq.com134', '18600884741', '18600884757', '18600884741', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100147', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼146', '无146', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('204', '1', '百会148', '罗晓丽148', '研发中心8', '软件工程师8', '362350061@qq.com135', '18600884742', '18600884758', '18600884742', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100148', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼147', '无147', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('205', '1', '百会149', '罗晓丽149', '研发中心9', '软件工程师9', '362350061@qq.com136', '18600884743', '18600884759', '18600884743', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100149', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼148', '无148', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('206', '1', '百会150', '罗晓丽150', '研发中心10', '软件工程师10', '362350061@qq.com137', '18600884744', '18600884760', '18600884744', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100150', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼149', '无149', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('207', '1', '百会170', '罗晓丽170', '研发中心10', '软件工程师10', '362350061@qq.com157', '18600884764', '18600884780', '18600884764', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100170', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼169', '无169', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('208', '1', '百会169', '罗晓丽169', '研发中心9', '软件工程师9', '362350061@qq.com156', '18600884763', '18600884779', '18600884763', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100169', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼168', '无168', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('209', '1', '百会168', '罗晓丽168', '研发中心8', '软件工程师8', '362350061@qq.com155', '18600884762', '18600884778', '18600884762', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100168', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼167', '无167', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('210', '1', '百会167', '罗晓丽167', '研发中心7', '软件工程师7', '362350061@qq.com154', '18600884761', '18600884777', '18600884761', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100167', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼166', '无166', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('211', '1', '百会174', '罗晓丽174', '研发中心14', '软件工程师14', '362350061@qq.com161', '18600884768', '18600884784', '18600884768', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100174', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼173', '无173', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('212', '1', '百会173', '罗晓丽173', '研发中心13', '软件工程师13', '362350061@qq.com160', '18600884767', '18600884783', '18600884767', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100173', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼172', '无172', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('213', '1', '百会172', '罗晓丽172', '研发中心12', '软件工程师12', '362350061@qq.com159', '18600884766', '18600884782', '18600884766', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100172', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼171', '无171', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('214', '1', '百会171', '罗晓丽171', '研发中心11', '软件工程师11', '362350061@qq.com158', '18600884765', '18600884781', '18600884765', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100171', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼170', '无170', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('215', '1', '百会162', '罗晓丽162', '研发中心2', '软件工程师2', '362350061@qq.com149', '18600884756', '18600884772', '18600884756', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100162', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼161', '无161', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('216', '1', '百会161', '罗晓丽161', '研发中心1', '软件工程师1', '362350061@qq.com148', '18600884755', '18600884771', '18600884755', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100161', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼160', '无160', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('217', '1', '百会160', '罗晓丽160', '研发中心19', '软件工程师19', '362350061@qq.com147', '18600884754', '18600884770', '18600884754', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100160', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼159', '无159', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('218', '1', '百会159', '罗晓丽159', '研发中心19', '软件工程师19', '362350061@qq.com146', '18600884753', '18600884769', '18600884753', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100159', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼158', '无158', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('219', '1', '百会166', '罗晓丽166', '研发中心6', '软件工程师6', '362350061@qq.com153', '18600884760', '18600884776', '18600884760', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100166', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼165', '无165', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('220', '1', '百会165', '罗晓丽165', '研发中心5', '软件工程师5', '362350061@qq.com152', '18600884759', '18600884775', '18600884759', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100165', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼164', '无164', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('221', '1', '百会164', '罗晓丽164', '研发中心4', '软件工程师4', '362350061@qq.com151', '18600884758', '18600884774', '18600884758', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100164', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼163', '无163', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('222', '1', '百会163', '罗晓丽163', '研发中心3', '软件工程师3', '362350061@qq.com150', '18600884757', '18600884773', '18600884757', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100163', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼162', '无162', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('223', '1', '百会185', '罗晓丽185', '研发中心5', '软件工程师5', '362350061@qq.com172', '18600884779', '18600884795', '18600884779', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100185', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼184', '无184', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('224', '1', '百会186', '罗晓丽186', '研发中心6', '软件工程师6', '362350061@qq.com173', '18600884780', '18600884796', '18600884780', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100186', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼185', '无185', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('225', '1', '百会183', '罗晓丽183', '研发中心3', '软件工程师3', '362350061@qq.com170', '18600884777', '18600884793', '18600884777', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100183', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼182', '无182', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('226', '1', '百会184', '罗晓丽184', '研发中心4', '软件工程师4', '362350061@qq.com171', '18600884778', '18600884794', '18600884778', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100184', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼183', '无183', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('227', '1', '百会189', '罗晓丽189', '研发中心9', '软件工程师9', '362350061@qq.com176', '18600884783', '18600884799', '18600884783', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100189', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼188', '无188', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('228', '1', '百会190', '罗晓丽190', '研发中心10', '软件工程师10', '362350061@qq.com177', '18600884784', '18600884800', '18600884784', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100190', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼189', '无189', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('229', '1', '百会187', '罗晓丽187', '研发中心7', '软件工程师7', '362350061@qq.com174', '18600884781', '18600884797', '18600884781', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100187', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼186', '无186', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('230', '1', '百会188', '罗晓丽188', '研发中心8', '软件工程师8', '362350061@qq.com175', '18600884782', '18600884798', '18600884782', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100188', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼187', '无187', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('231', '1', '百会177', '罗晓丽177', '研发中心17', '软件工程师17', '362350061@qq.com164', '18600884771', '18600884787', '18600884771', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100177', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼176', '无176', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('232', '1', '百会178', '罗晓丽178', '研发中心18', '软件工程师18', '362350061@qq.com165', '18600884772', '18600884788', '18600884772', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100178', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼177', '无177', '0', '1', '2014-07-21 16:26:15', '1', '2014-07-21 16:26:15', null);
INSERT INTO `lead` VALUES ('233', '1', '百会175', '罗晓丽175', '研发中心15', '软件工程师15', '362350061@qq.com162', '18600884769', '18600884785', '18600884769', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100175', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼174', '无174', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('234', '1', '百会176', '罗晓丽176', '研发中心16', '软件工程师16', '362350061@qq.com163', '18600884770', '18600884786', '18600884770', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100176', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼175', '无175', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('235', '1', '百会181', '罗晓丽181', '研发中心1', '软件工程师1', '362350061@qq.com168', '18600884775', '18600884791', '18600884775', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100181', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼180', '无180', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('236', '1', '百会182', '罗晓丽182', '研发中心2', '软件工程师2', '362350061@qq.com169', '18600884776', '18600884792', '18600884776', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100182', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼181', '无181', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('237', '1', '百会179', '罗晓丽179', '研发中心19', '软件工程师19', '362350061@qq.com166', '18600884773', '18600884789', '18600884773', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100179', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼178', '无178', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('238', '1', '百会180', '罗晓丽180', '研发中心19', '软件工程师19', '362350061@qq.com167', '18600884774', '18600884790', '18600884774', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100180', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼179', '无179', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('239', '1', '百会204', '罗晓丽204', '研发中心4', '软件工程师4', '362350061@qq.com191', '18600884798', '18600884814', '18600884798', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100204', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼203', '无203', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('240', '1', '百会203', '罗晓丽203', '研发中心3', '软件工程师3', '362350061@qq.com190', '18600884797', '18600884813', '18600884797', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100203', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼202', '无202', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('241', '1', '百会206', '罗晓丽206', '研发中心6', '软件工程师6', '362350061@qq.com193', '18600884800', '18600884816', '18600884800', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100206', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼205', '无205', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('242', '1', '百会205', '罗晓丽205', '研发中心5', '软件工程师5', '362350061@qq.com192', '18600884799', '18600884815', '18600884799', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100205', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼204', '无204', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('243', '1', '百会200', '罗晓丽200', '研发中心19', '软件工程师19', '362350061@qq.com187', '18600884794', '18600884810', '18600884794', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100200', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼199', '无199', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('244', '1', '百会199', '罗晓丽199', '研发中心19', '软件工程师19', '362350061@qq.com186', '18600884793', '18600884809', '18600884793', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100199', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼198', '无198', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('245', '1', '百会202', '罗晓丽202', '研发中心2', '软件工程师2', '362350061@qq.com189', '18600884796', '18600884812', '18600884796', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100202', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼201', '无201', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('246', '1', '百会201', '罗晓丽201', '研发中心1', '软件工程师1', '362350061@qq.com188', '18600884795', '18600884811', '18600884795', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100201', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼200', '无200', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('247', '1', '百会196', '罗晓丽196', '研发中心16', '软件工程师16', '362350061@qq.com183', '18600884790', '18600884806', '18600884790', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100196', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼195', '无195', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('248', '1', '百会195', '罗晓丽195', '研发中心15', '软件工程师15', '362350061@qq.com182', '18600884789', '18600884805', '18600884789', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100195', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼194', '无194', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('249', '1', '百会198', '罗晓丽198', '研发中心18', '软件工程师18', '362350061@qq.com185', '18600884792', '18600884808', '18600884792', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100198', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼197', '无197', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('250', '1', '百会197', '罗晓丽197', '研发中心17', '软件工程师17', '362350061@qq.com184', '18600884791', '18600884807', '18600884791', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100197', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼196', '无196', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('251', '1', '百会192', '罗晓丽192', '研发中心12', '软件工程师12', '362350061@qq.com179', '18600884786', '18600884802', '18600884786', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100192', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼191', '无191', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('252', '1', '百会191', '罗晓丽191', '研发中心11', '软件工程师11', '362350061@qq.com178', '18600884785', '18600884801', '18600884785', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100191', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼190', '无190', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('253', '1', '百会194', '罗晓丽194', '研发中心14', '软件工程师14', '362350061@qq.com181', '18600884788', '18600884804', '18600884788', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100194', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼193', '无193', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('254', '1', '百会193', '罗晓丽193', '研发中心13', '软件工程师13', '362350061@qq.com180', '18600884787', '18600884803', '18600884787', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100193', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼192', '无192', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('255', '1', '百会219', '罗晓丽219', '研发中心19', '软件工程师19', '362350061@qq.com206', '18600884813', '18600884829', '18600884813', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100219', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼218', '无218', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('256', '1', '百会220', '罗晓丽220', '研发中心19', '软件工程师19', '362350061@qq.com207', '18600884814', '18600884830', '18600884814', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100220', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼219', '无219', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('257', '1', '百会221', '罗晓丽221', '研发中心1', '软件工程师1', '362350061@qq.com208', '18600884815', '18600884831', '18600884815', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100221', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼220', '无220', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('258', '1', '百会222', '罗晓丽222', '研发中心2', '软件工程师2', '362350061@qq.com209', '18600884816', '18600884832', '18600884816', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100222', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼221', '无221', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('259', '1', '百会215', '罗晓丽215', '研发中心15', '软件工程师15', '362350061@qq.com202', '18600884809', '18600884825', '18600884809', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100215', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼214', '无214', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('260', '1', '百会216', '罗晓丽216', '研发中心16', '软件工程师16', '362350061@qq.com203', '18600884810', '18600884826', '18600884810', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100216', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼215', '无215', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('261', '1', '百会217', '罗晓丽217', '研发中心17', '软件工程师17', '362350061@qq.com204', '18600884811', '18600884827', '18600884811', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100217', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼216', '无216', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('262', '1', '百会218', '罗晓丽218', '研发中心18', '软件工程师18', '362350061@qq.com205', '18600884812', '18600884828', '18600884812', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100218', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼217', '无217', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('263', '1', '百会211', '罗晓丽211', '研发中心11', '软件工程师11', '362350061@qq.com198', '18600884805', '18600884821', '18600884805', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100211', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼210', '无210', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('264', '1', '百会212', '罗晓丽212', '研发中心12', '软件工程师12', '362350061@qq.com199', '18600884806', '18600884822', '18600884806', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100212', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼211', '无211', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('265', '1', '百会213', '罗晓丽213', '研发中心13', '软件工程师13', '362350061@qq.com200', '18600884807', '18600884823', '18600884807', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100213', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼212', '无212', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('266', '1', '百会214', '罗晓丽214', '研发中心14', '软件工程师14', '362350061@qq.com201', '18600884808', '18600884824', '18600884808', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100214', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼213', '无213', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('267', '1', '百会207', '罗晓丽207', '研发中心7', '软件工程师7', '362350061@qq.com194', '18600884801', '18600884817', '18600884801', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100207', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼206', '无206', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('268', '1', '百会208', '罗晓丽208', '研发中心8', '软件工程师8', '362350061@qq.com195', '18600884802', '18600884818', '18600884802', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100208', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼207', '无207', '0', '1', '2014-07-21 16:26:16', '1', '2014-07-21 16:26:16', null);
INSERT INTO `lead` VALUES ('269', '1', '百会209', '罗晓丽209', '研发中心9', '软件工程师9', '362350061@qq.com196', '18600884803', '18600884819', '18600884803', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100209', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼208', '无208', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('270', '1', '百会210', '罗晓丽210', '研发中心10', '软件工程师10', '362350061@qq.com197', '18600884804', '18600884820', '18600884804', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100210', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼209', '无209', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('271', '1', '百会238', '罗晓丽238', '研发中心18', '软件工程师18', '362350061@qq.com225', '18600884832', '18600884848', '18600884832', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100238', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼237', '无237', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('272', '1', '百会237', '罗晓丽237', '研发中心17', '软件工程师17', '362350061@qq.com224', '18600884831', '18600884847', '18600884831', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100237', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼236', '无236', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('273', '1', '百会236', '罗晓丽236', '研发中心16', '软件工程师16', '362350061@qq.com223', '18600884830', '18600884846', '18600884830', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100236', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼235', '无235', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('274', '1', '百会235', '罗晓丽235', '研发中心15', '软件工程师15', '362350061@qq.com222', '18600884829', '18600884845', '18600884829', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100235', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼234', '无234', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('275', '1', '百会234', '罗晓丽234', '研发中心14', '软件工程师14', '362350061@qq.com221', '18600884828', '18600884844', '18600884828', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100234', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼233', '无233', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('276', '1', '百会233', '罗晓丽233', '研发中心13', '软件工程师13', '362350061@qq.com220', '18600884827', '18600884843', '18600884827', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100233', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼232', '无232', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('277', '1', '百会232', '罗晓丽232', '研发中心12', '软件工程师12', '362350061@qq.com219', '18600884826', '18600884842', '18600884826', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100232', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼231', '无231', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('278', '1', '百会231', '罗晓丽231', '研发中心11', '软件工程师11', '362350061@qq.com218', '18600884825', '18600884841', '18600884825', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100231', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼230', '无230', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('279', '1', '百会230', '罗晓丽230', '研发中心10', '软件工程师10', '362350061@qq.com217', '18600884824', '18600884840', '18600884824', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100230', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼229', '无229', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('280', '1', '百会229', '罗晓丽229', '研发中心9', '软件工程师9', '362350061@qq.com216', '18600884823', '18600884839', '18600884823', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100229', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼228', '无228', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('281', '1', '百会228', '罗晓丽228', '研发中心8', '软件工程师8', '362350061@qq.com215', '18600884822', '18600884838', '18600884822', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100228', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼227', '无227', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('282', '1', '百会227', '罗晓丽227', '研发中心7', '软件工程师7', '362350061@qq.com214', '18600884821', '18600884837', '18600884821', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100227', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼226', '无226', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('283', '1', '百会226', '罗晓丽226', '研发中心6', '软件工程师6', '362350061@qq.com213', '18600884820', '18600884836', '18600884820', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100226', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼225', '无225', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('284', '1', '百会225', '罗晓丽225', '研发中心5', '软件工程师5', '362350061@qq.com212', '18600884819', '18600884835', '18600884819', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100225', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼224', '无224', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('285', '1', '百会224', '罗晓丽224', '研发中心4', '软件工程师4', '362350061@qq.com211', '18600884818', '18600884834', '18600884818', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100224', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼223', '无223', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('286', '1', '百会223', '罗晓丽223', '研发中心3', '软件工程师3', '362350061@qq.com210', '18600884817', '18600884833', '18600884817', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100223', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼222', '无222', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('287', '1', '百会253', '罗晓丽253', '研发中心13', '软件工程师13', '362350061@qq.com240', '18600884847', '18600884863', '18600884847', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100253', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼252', '无252', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('288', '1', '百会254', '罗晓丽254', '研发中心14', '软件工程师14', '362350061@qq.com241', '18600884848', '18600884864', '18600884848', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100254', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼253', '无253', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('289', '1', '百会251', '罗晓丽251', '研发中心11', '软件工程师11', '362350061@qq.com238', '18600884845', '18600884861', '18600884845', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100251', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼250', '无250', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('290', '1', '百会252', '罗晓丽252', '研发中心12', '软件工程师12', '362350061@qq.com239', '18600884846', '18600884862', '18600884846', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100252', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼251', '无251', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('291', '1', '百会249', '罗晓丽249', '研发中心9', '软件工程师9', '362350061@qq.com236', '18600884843', '18600884859', '18600884843', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100249', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼248', '无248', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('292', '1', '百会250', '罗晓丽250', '研发中心10', '软件工程师10', '362350061@qq.com237', '18600884844', '18600884860', '18600884844', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100250', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼249', '无249', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('293', '1', '百会247', '罗晓丽247', '研发中心7', '软件工程师7', '362350061@qq.com234', '18600884841', '18600884857', '18600884841', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100247', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼246', '无246', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('294', '1', '百会248', '罗晓丽248', '研发中心8', '软件工程师8', '362350061@qq.com235', '18600884842', '18600884858', '18600884842', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100248', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼247', '无247', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('295', '1', '百会245', '罗晓丽245', '研发中心5', '软件工程师5', '362350061@qq.com232', '18600884839', '18600884855', '18600884839', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100245', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼244', '无244', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('296', '1', '百会246', '罗晓丽246', '研发中心6', '软件工程师6', '362350061@qq.com233', '18600884840', '18600884856', '18600884840', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100246', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼245', '无245', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('297', '1', '百会243', '罗晓丽243', '研发中心3', '软件工程师3', '362350061@qq.com230', '18600884837', '18600884853', '18600884837', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100243', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼242', '无242', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('298', '1', '百会244', '罗晓丽244', '研发中心4', '软件工程师4', '362350061@qq.com231', '18600884838', '18600884854', '18600884838', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100244', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼243', '无243', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('299', '1', '百会241', '罗晓丽241', '研发中心1', '软件工程师1', '362350061@qq.com228', '18600884835', '18600884851', '18600884835', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100241', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼240', '无240', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('300', '1', '百会242', '罗晓丽242', '研发中心2', '软件工程师2', '362350061@qq.com229', '18600884836', '18600884852', '18600884836', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100242', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼241', '无241', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('301', '1', '百会239', '罗晓丽239', '研发中心19', '软件工程师19', '362350061@qq.com226', '18600884833', '18600884849', '18600884833', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100239', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼238', '无238', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('302', '1', '百会240', '罗晓丽240', '研发中心19', '软件工程师19', '362350061@qq.com227', '18600884834', '18600884850', '18600884834', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100240', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼239', '无239', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('303', '1', '百会274', '罗晓丽274', '研发中心14', '软件工程师14', '362350061@qq.com261', '18600884868', '18600884884', '18600884868', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100274', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼273', '无273', '0', '1', '2014-07-21 16:26:17', '1', '2014-07-21 16:26:17', null);
INSERT INTO `lead` VALUES ('304', '1', '百会273', '罗晓丽273', '研发中心13', '软件工程师13', '362350061@qq.com260', '18600884867', '18600884883', '18600884867', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100273', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼272', '无272', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('305', '1', '百会272', '罗晓丽272', '研发中心12', '软件工程师12', '362350061@qq.com259', '18600884866', '18600884882', '18600884866', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100272', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼271', '无271', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('306', '1', '百会271', '罗晓丽271', '研发中心11', '软件工程师11', '362350061@qq.com258', '18600884865', '18600884881', '18600884865', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100271', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼270', '无270', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('307', '1', '百会278', '罗晓丽278', '研发中心18', '软件工程师18', '362350061@qq.com265', '18600884872', '18600884888', '18600884872', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100278', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼277', '无277', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('308', '1', '百会277', '罗晓丽277', '研发中心17', '软件工程师17', '362350061@qq.com264', '18600884871', '18600884887', '18600884871', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100277', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼276', '无276', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('309', '1', '百会276', '罗晓丽276', '研发中心16', '软件工程师16', '362350061@qq.com263', '18600884870', '18600884886', '18600884870', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100276', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼275', '无275', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('310', '1', '百会275', '罗晓丽275', '研发中心15', '软件工程师15', '362350061@qq.com262', '18600884869', '18600884885', '18600884869', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100275', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼274', '无274', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('311', '1', '百会282', '罗晓丽282', '研发中心2', '软件工程师2', '362350061@qq.com269', '18600884876', '18600884892', '18600884876', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100282', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼281', '无281', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('312', '1', '百会281', '罗晓丽281', '研发中心1', '软件工程师1', '362350061@qq.com268', '18600884875', '18600884891', '18600884875', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100281', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼280', '无280', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('313', '1', '百会280', '罗晓丽280', '研发中心19', '软件工程师19', '362350061@qq.com267', '18600884874', '18600884890', '18600884874', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100280', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼279', '无279', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('314', '1', '百会279', '罗晓丽279', '研发中心19', '软件工程师19', '362350061@qq.com266', '18600884873', '18600884889', '18600884873', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100279', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼278', '无278', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('315', '1', '百会286', '罗晓丽286', '研发中心6', '软件工程师6', '362350061@qq.com273', '18600884880', '18600884896', '18600884880', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100286', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼285', '无285', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('316', '1', '百会285', '罗晓丽285', '研发中心5', '软件工程师5', '362350061@qq.com272', '18600884879', '18600884895', '18600884879', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100285', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼284', '无284', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('317', '1', '百会284', '罗晓丽284', '研发中心4', '软件工程师4', '362350061@qq.com271', '18600884878', '18600884894', '18600884878', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100284', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼283', '无283', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('318', '1', '百会283', '罗晓丽283', '研发中心3', '软件工程师3', '362350061@qq.com270', '18600884877', '18600884893', '18600884877', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100283', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼282', '无282', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('319', '1', '百会257', '罗晓丽257', '研发中心17', '软件工程师17', '362350061@qq.com244', '18600884851', '18600884867', '18600884851', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100257', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼256', '无256', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('320', '1', '百会258', '罗晓丽258', '研发中心18', '软件工程师18', '362350061@qq.com245', '18600884852', '18600884868', '18600884852', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100258', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼257', '无257', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('321', '1', '百会255', '罗晓丽255', '研发中心15', '软件工程师15', '362350061@qq.com242', '18600884849', '18600884865', '18600884849', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100255', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼254', '无254', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('322', '1', '百会256', '罗晓丽256', '研发中心16', '软件工程师16', '362350061@qq.com243', '18600884850', '18600884866', '18600884850', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100256', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼255', '无255', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('323', '1', '百会261', '罗晓丽261', '研发中心1', '软件工程师1', '362350061@qq.com248', '18600884855', '18600884871', '18600884855', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100261', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼260', '无260', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('324', '1', '百会262', '罗晓丽262', '研发中心2', '软件工程师2', '362350061@qq.com249', '18600884856', '18600884872', '18600884856', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100262', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼261', '无261', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('325', '1', '百会259', '罗晓丽259', '研发中心19', '软件工程师19', '362350061@qq.com246', '18600884853', '18600884869', '18600884853', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100259', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼258', '无258', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('326', '1', '百会260', '罗晓丽260', '研发中心19', '软件工程师19', '362350061@qq.com247', '18600884854', '18600884870', '18600884854', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100260', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼259', '无259', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('327', '1', '百会265', '罗晓丽265', '研发中心5', '软件工程师5', '362350061@qq.com252', '18600884859', '18600884875', '18600884859', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100265', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼264', '无264', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('328', '1', '百会266', '罗晓丽266', '研发中心6', '软件工程师6', '362350061@qq.com253', '18600884860', '18600884876', '18600884860', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100266', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼265', '无265', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('329', '1', '百会263', '罗晓丽263', '研发中心3', '软件工程师3', '362350061@qq.com250', '18600884857', '18600884873', '18600884857', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100263', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼262', '无262', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('330', '1', '百会264', '罗晓丽264', '研发中心4', '软件工程师4', '362350061@qq.com251', '18600884858', '18600884874', '18600884858', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100264', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼263', '无263', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('331', '1', '百会269', '罗晓丽269', '研发中心9', '软件工程师9', '362350061@qq.com256', '18600884863', '18600884879', '18600884863', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100269', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼268', '无268', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('332', '1', '百会270', '罗晓丽270', '研发中心10', '软件工程师10', '362350061@qq.com257', '18600884864', '18600884880', '18600884864', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100270', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼269', '无269', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('333', '1', '百会267', '罗晓丽267', '研发中心7', '软件工程师7', '362350061@qq.com254', '18600884861', '18600884877', '18600884861', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100267', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼266', '无266', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('334', '1', '百会268', '罗晓丽268', '研发中心8', '软件工程师8', '362350061@qq.com255', '18600884862', '18600884878', '18600884862', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100268', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼267', '无267', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('335', '1', '百会304', '罗晓丽304', '研发中心4', '软件工程师4', '362350061@qq.com291', '18600884898', '18600884914', '18600884898', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100304', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼303', '无303', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('336', '1', '百会303', '罗晓丽303', '研发中心3', '软件工程师3', '362350061@qq.com290', '18600884897', '18600884913', '18600884897', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100303', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼302', '无302', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('337', '1', '百会306', '罗晓丽306', '研发中心6', '软件工程师6', '362350061@qq.com293', '18600884900', '18600884916', '18600884900', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100306', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼305', '无305', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:18', null);
INSERT INTO `lead` VALUES ('338', '1', '百会305', '罗晓丽305', '研发中心5', '软件工程师5', '362350061@qq.com292', '18600884899', '18600884915', '18600884899', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100305', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼304', '无304', '0', '1', '2014-07-21 16:26:18', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('339', '1', '百会308', '罗晓丽308', '研发中心8', '软件工程师8', '362350061@qq.com295', '18600884902', '18600884918', '18600884902', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100308', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼307', '无307', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('340', '1', '百会307', '罗晓丽307', '研发中心7', '软件工程师7', '362350061@qq.com294', '18600884901', '18600884917', '18600884901', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100307', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼306', '无306', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('341', '1', '百会310', '罗晓丽310', '研发中心10', '软件工程师10', '362350061@qq.com297', '18600884904', '18600884920', '18600884904', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100310', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼309', '无309', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('342', '1', '百会309', '罗晓丽309', '研发中心9', '软件工程师9', '362350061@qq.com296', '18600884903', '18600884919', '18600884903', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100309', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼308', '无308', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('343', '1', '百会312', '罗晓丽312', '研发中心12', '软件工程师12', '362350061@qq.com299', '18600884906', '18600884922', '18600884906', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100312', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼311', '无311', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('344', '1', '百会311', '罗晓丽311', '研发中心11', '软件工程师11', '362350061@qq.com298', '18600884905', '18600884921', '18600884905', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100311', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼310', '无310', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('345', '1', '百会314', '罗晓丽314', '研发中心14', '软件工程师14', '362350061@qq.com301', '18600884908', '18600884924', '18600884908', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100314', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼313', '无313', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('346', '1', '百会313', '罗晓丽313', '研发中心13', '软件工程师13', '362350061@qq.com300', '18600884907', '18600884923', '18600884907', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100313', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼312', '无312', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('347', '1', '百会316', '罗晓丽316', '研发中心16', '软件工程师16', '362350061@qq.com303', '18600884910', '18600884926', '18600884910', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100316', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼315', '无315', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('348', '1', '百会315', '罗晓丽315', '研发中心15', '软件工程师15', '362350061@qq.com302', '18600884909', '18600884925', '18600884909', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100315', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼314', '无314', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('349', '1', '百会318', '罗晓丽318', '研发中心18', '软件工程师18', '362350061@qq.com305', '18600884912', '18600884928', '18600884912', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100318', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼317', '无317', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('350', '1', '百会317', '罗晓丽317', '研发中心17', '软件工程师17', '362350061@qq.com304', '18600884911', '18600884927', '18600884911', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100317', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼316', '无316', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('351', '1', '百会287', '罗晓丽287', '研发中心7', '软件工程师7', '362350061@qq.com274', '18600884881', '18600884897', '18600884881', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100287', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼286', '无286', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('352', '1', '百会288', '罗晓丽288', '研发中心8', '软件工程师8', '362350061@qq.com275', '18600884882', '18600884898', '18600884882', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100288', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼287', '无287', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('353', '1', '百会289', '罗晓丽289', '研发中心9', '软件工程师9', '362350061@qq.com276', '18600884883', '18600884899', '18600884883', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100289', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼288', '无288', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('354', '1', '百会290', '罗晓丽290', '研发中心10', '软件工程师10', '362350061@qq.com277', '18600884884', '18600884900', '18600884884', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100290', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼289', '无289', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('355', '1', '百会291', '罗晓丽291', '研发中心11', '软件工程师11', '362350061@qq.com278', '18600884885', '18600884901', '18600884885', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100291', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼290', '无290', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('356', '1', '百会292', '罗晓丽292', '研发中心12', '软件工程师12', '362350061@qq.com279', '18600884886', '18600884902', '18600884886', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100292', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼291', '无291', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('357', '1', '百会293', '罗晓丽293', '研发中心13', '软件工程师13', '362350061@qq.com280', '18600884887', '18600884903', '18600884887', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100293', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼292', '无292', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('358', '1', '百会294', '罗晓丽294', '研发中心14', '软件工程师14', '362350061@qq.com281', '18600884888', '18600884904', '18600884888', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100294', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼293', '无293', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('359', '1', '百会295', '罗晓丽295', '研发中心15', '软件工程师15', '362350061@qq.com282', '18600884889', '18600884905', '18600884889', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100295', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼294', '无294', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('360', '1', '百会296', '罗晓丽296', '研发中心16', '软件工程师16', '362350061@qq.com283', '18600884890', '18600884906', '18600884890', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100296', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼295', '无295', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('361', '1', '百会297', '罗晓丽297', '研发中心17', '软件工程师17', '362350061@qq.com284', '18600884891', '18600884907', '18600884891', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100297', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼296', '无296', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('362', '1', '百会298', '罗晓丽298', '研发中心18', '软件工程师18', '362350061@qq.com285', '18600884892', '18600884908', '18600884892', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100298', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼297', '无297', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('363', '1', '百会299', '罗晓丽299', '研发中心19', '软件工程师19', '362350061@qq.com286', '18600884893', '18600884909', '18600884893', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100299', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼298', '无298', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('364', '1', '百会300', '罗晓丽300', '研发中心19', '软件工程师19', '362350061@qq.com287', '18600884894', '18600884910', '18600884894', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100300', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼299', '无299', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('365', '1', '百会301', '罗晓丽301', '研发中心1', '软件工程师1', '362350061@qq.com288', '18600884895', '18600884911', '18600884895', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100301', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼300', '无300', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('366', '1', '百会302', '罗晓丽302', '研发中心2', '软件工程师2', '362350061@qq.com289', '18600884896', '18600884912', '18600884896', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100302', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼301', '无301', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('367', '1', '百会342', '罗晓丽342', '研发中心2', '软件工程师2', '362350061@qq.com329', '18600884936', '18600884952', '18600884936', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100342', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼341', '无341', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('368', '1', '百会341', '罗晓丽341', '研发中心1', '软件工程师1', '362350061@qq.com328', '18600884935', '18600884951', '18600884935', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100341', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼340', '无340', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('369', '1', '百会340', '罗晓丽340', '研发中心19', '软件工程师19', '362350061@qq.com327', '18600884934', '18600884950', '18600884934', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100340', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼339', '无339', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('370', '1', '百会339', '罗晓丽339', '研发中心19', '软件工程师19', '362350061@qq.com326', '18600884933', '18600884949', '18600884933', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100339', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼338', '无338', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('371', '1', '百会338', '罗晓丽338', '研发中心18', '软件工程师18', '362350061@qq.com325', '18600884932', '18600884948', '18600884932', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100338', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼337', '无337', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('372', '1', '百会337', '罗晓丽337', '研发中心17', '软件工程师17', '362350061@qq.com324', '18600884931', '18600884947', '18600884931', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100337', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼336', '无336', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('373', '1', '百会336', '罗晓丽336', '研发中心16', '软件工程师16', '362350061@qq.com323', '18600884930', '18600884946', '18600884930', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100336', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼335', '无335', '0', '1', '2014-07-21 16:26:19', '1', '2014-07-21 16:26:19', null);
INSERT INTO `lead` VALUES ('374', '1', '百会335', '罗晓丽335', '研发中心15', '软件工程师15', '362350061@qq.com322', '18600884929', '18600884945', '18600884929', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100335', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼334', '无334', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('375', '1', '百会350', '罗晓丽350', '研发中心10', '软件工程师10', '362350061@qq.com337', '18600884944', '18600884960', '18600884944', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100350', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼349', '无349', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('376', '1', '百会349', '罗晓丽349', '研发中心9', '软件工程师9', '362350061@qq.com336', '18600884943', '18600884959', '18600884943', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100349', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼348', '无348', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('377', '1', '百会348', '罗晓丽348', '研发中心8', '软件工程师8', '362350061@qq.com335', '18600884942', '18600884958', '18600884942', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100348', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼347', '无347', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('378', '1', '百会347', '罗晓丽347', '研发中心7', '软件工程师7', '362350061@qq.com334', '18600884941', '18600884957', '18600884941', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100347', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼346', '无346', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('379', '1', '百会346', '罗晓丽346', '研发中心6', '软件工程师6', '362350061@qq.com333', '18600884940', '18600884956', '18600884940', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100346', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼345', '无345', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('380', '1', '百会345', '罗晓丽345', '研发中心5', '软件工程师5', '362350061@qq.com332', '18600884939', '18600884955', '18600884939', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100345', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼344', '无344', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('381', '1', '百会344', '罗晓丽344', '研发中心4', '软件工程师4', '362350061@qq.com331', '18600884938', '18600884954', '18600884938', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100344', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼343', '无343', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('382', '1', '百会343', '罗晓丽343', '研发中心3', '软件工程师3', '362350061@qq.com330', '18600884937', '18600884953', '18600884937', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100343', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼342', '无342', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('383', '1', '百会325', '罗晓丽325', '研发中心5', '软件工程师5', '362350061@qq.com312', '18600884919', '18600884935', '18600884919', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100325', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼324', '无324', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('384', '1', '百会326', '罗晓丽326', '研发中心6', '软件工程师6', '362350061@qq.com313', '18600884920', '18600884936', '18600884920', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100326', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼325', '无325', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('385', '1', '百会323', '罗晓丽323', '研发中心3', '软件工程师3', '362350061@qq.com310', '18600884917', '18600884933', '18600884917', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100323', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼322', '无322', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('386', '1', '百会324', '罗晓丽324', '研发中心4', '软件工程师4', '362350061@qq.com311', '18600884918', '18600884934', '18600884918', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100324', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼323', '无323', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('387', '1', '百会321', '罗晓丽321', '研发中心1', '软件工程师1', '362350061@qq.com308', '18600884915', '18600884931', '18600884915', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100321', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼320', '无320', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('388', '1', '百会322', '罗晓丽322', '研发中心2', '软件工程师2', '362350061@qq.com309', '18600884916', '18600884932', '18600884916', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100322', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼321', '无321', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('389', '1', '百会319', '罗晓丽319', '研发中心19', '软件工程师19', '362350061@qq.com306', '18600884913', '18600884929', '18600884913', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100319', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼318', '无318', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('390', '1', '百会320', '罗晓丽320', '研发中心19', '软件工程师19', '362350061@qq.com307', '18600884914', '18600884930', '18600884914', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100320', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼319', '无319', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('391', '1', '百会333', '罗晓丽333', '研发中心13', '软件工程师13', '362350061@qq.com320', '18600884927', '18600884943', '18600884927', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100333', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼332', '无332', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('392', '1', '百会334', '罗晓丽334', '研发中心14', '软件工程师14', '362350061@qq.com321', '18600884928', '18600884944', '18600884928', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100334', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼333', '无333', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('393', '1', '百会331', '罗晓丽331', '研发中心11', '软件工程师11', '362350061@qq.com318', '18600884925', '18600884941', '18600884925', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100331', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼330', '无330', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('394', '1', '百会332', '罗晓丽332', '研发中心12', '软件工程师12', '362350061@qq.com319', '18600884926', '18600884942', '18600884926', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100332', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼331', '无331', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('395', '1', '百会329', '罗晓丽329', '研发中心9', '软件工程师9', '362350061@qq.com316', '18600884923', '18600884939', '18600884923', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100329', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼328', '无328', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('396', '1', '百会330', '罗晓丽330', '研发中心10', '软件工程师10', '362350061@qq.com317', '18600884924', '18600884940', '18600884924', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100330', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼329', '无329', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('397', '1', '百会327', '罗晓丽327', '研发中心7', '软件工程师7', '362350061@qq.com314', '18600884921', '18600884937', '18600884921', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100327', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼326', '无326', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('398', '1', '百会328', '罗晓丽328', '研发中心8', '软件工程师8', '362350061@qq.com315', '18600884922', '18600884938', '18600884922', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100328', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼327', '无327', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('399', '1', '百会372', '罗晓丽372', '研发中心12', '软件工程师12', '362350061@qq.com359', '18600884966', '18600884982', '18600884966', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100372', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼371', '无371', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('400', '1', '百会371', '罗晓丽371', '研发中心11', '软件工程师11', '362350061@qq.com358', '18600884965', '18600884981', '18600884965', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100371', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼370', '无370', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('401', '1', '百会374', '罗晓丽374', '研发中心14', '软件工程师14', '362350061@qq.com361', '18600884968', '18600884984', '18600884968', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100374', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼373', '无373', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('402', '1', '百会373', '罗晓丽373', '研发中心13', '软件工程师13', '362350061@qq.com360', '18600884967', '18600884983', '18600884967', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100373', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼372', '无372', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('403', '1', '百会368', '罗晓丽368', '研发中心8', '软件工程师8', '362350061@qq.com355', '18600884962', '18600884978', '18600884962', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100368', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼367', '无367', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('404', '1', '百会367', '罗晓丽367', '研发中心7', '软件工程师7', '362350061@qq.com354', '18600884961', '18600884977', '18600884961', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100367', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼366', '无366', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('405', '1', '百会370', '罗晓丽370', '研发中心10', '软件工程师10', '362350061@qq.com357', '18600884964', '18600884980', '18600884964', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100370', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼369', '无369', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('406', '1', '百会369', '罗晓丽369', '研发中心9', '软件工程师9', '362350061@qq.com356', '18600884963', '18600884979', '18600884963', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100369', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼368', '无368', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('407', '1', '百会380', '罗晓丽380', '研发中心19', '软件工程师19', '362350061@qq.com367', '18600884974', '18600884990', '18600884974', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100380', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼379', '无379', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('408', '1', '百会379', '罗晓丽379', '研发中心19', '软件工程师19', '362350061@qq.com366', '18600884973', '18600884989', '18600884973', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100379', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼378', '无378', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('409', '1', '百会382', '罗晓丽382', '研发中心2', '软件工程师2', '362350061@qq.com369', '18600884976', '18600884992', '18600884976', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100382', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼381', '无381', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('410', '1', '百会381', '罗晓丽381', '研发中心1', '软件工程师1', '362350061@qq.com368', '18600884975', '18600884991', '18600884975', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100381', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼380', '无380', '0', '1', '2014-07-21 16:26:20', '1', '2014-07-21 16:26:20', null);
INSERT INTO `lead` VALUES ('411', '1', '百会376', '罗晓丽376', '研发中心16', '软件工程师16', '362350061@qq.com363', '18600884970', '18600884986', '18600884970', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100376', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼375', '无375', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('412', '1', '百会375', '罗晓丽375', '研发中心15', '软件工程师15', '362350061@qq.com362', '18600884969', '18600884985', '18600884969', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100375', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼374', '无374', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('413', '1', '百会378', '罗晓丽378', '研发中心18', '软件工程师18', '362350061@qq.com365', '18600884972', '18600884988', '18600884972', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100378', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼377', '无377', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('414', '1', '百会377', '罗晓丽377', '研发中心17', '软件工程师17', '362350061@qq.com364', '18600884971', '18600884987', '18600884971', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100377', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼376', '无376', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('415', '1', '百会355', '罗晓丽355', '研发中心15', '软件工程师15', '362350061@qq.com342', '18600884949', '18600884965', '18600884949', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100355', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼354', '无354', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('416', '1', '百会356', '罗晓丽356', '研发中心16', '软件工程师16', '362350061@qq.com343', '18600884950', '18600884966', '18600884950', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100356', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼355', '无355', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('417', '1', '百会357', '罗晓丽357', '研发中心17', '软件工程师17', '362350061@qq.com344', '18600884951', '18600884967', '18600884951', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100357', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼356', '无356', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('418', '1', '百会358', '罗晓丽358', '研发中心18', '软件工程师18', '362350061@qq.com345', '18600884952', '18600884968', '18600884952', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100358', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼357', '无357', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('419', '1', '百会351', '罗晓丽351', '研发中心11', '软件工程师11', '362350061@qq.com338', '18600884945', '18600884961', '18600884945', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100351', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼350', '无350', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('420', '1', '百会352', '罗晓丽352', '研发中心12', '软件工程师12', '362350061@qq.com339', '18600884946', '18600884962', '18600884946', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100352', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼351', '无351', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('421', '1', '百会353', '罗晓丽353', '研发中心13', '软件工程师13', '362350061@qq.com340', '18600884947', '18600884963', '18600884947', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100353', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼352', '无352', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('422', '1', '百会354', '罗晓丽354', '研发中心14', '软件工程师14', '362350061@qq.com341', '18600884948', '18600884964', '18600884948', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100354', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼353', '无353', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('423', '1', '百会363', '罗晓丽363', '研发中心3', '软件工程师3', '362350061@qq.com350', '18600884957', '18600884973', '18600884957', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100363', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼362', '无362', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('424', '1', '百会364', '罗晓丽364', '研发中心4', '软件工程师4', '362350061@qq.com351', '18600884958', '18600884974', '18600884958', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100364', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼363', '无363', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('425', '1', '百会365', '罗晓丽365', '研发中心5', '软件工程师5', '362350061@qq.com352', '18600884959', '18600884975', '18600884959', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100365', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼364', '无364', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('426', '1', '百会366', '罗晓丽366', '研发中心6', '软件工程师6', '362350061@qq.com353', '18600884960', '18600884976', '18600884960', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100366', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼365', '无365', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('427', '1', '百会359', '罗晓丽359', '研发中心19', '软件工程师19', '362350061@qq.com346', '18600884953', '18600884969', '18600884953', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100359', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼358', '无358', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('428', '1', '百会360', '罗晓丽360', '研发中心19', '软件工程师19', '362350061@qq.com347', '18600884954', '18600884970', '18600884954', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100360', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼359', '无359', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('429', '1', '百会361', '罗晓丽361', '研发中心1', '软件工程师1', '362350061@qq.com348', '18600884955', '18600884971', '18600884955', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100361', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼360', '无360', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('430', '1', '百会362', '罗晓丽362', '研发中心2', '软件工程师2', '362350061@qq.com349', '18600884956', '18600884972', '18600884956', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100362', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼361', '无361', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('431', '1', '百会409', '罗晓丽409', '研发中心9', '软件工程师9', '362350061@qq.com396', '18600885003', '18600885019', '18600885003', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100409', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼408', '无408', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('432', '1', '百会410', '罗晓丽410', '研发中心10', '软件工程师10', '362350061@qq.com397', '18600885004', '18600885020', '18600885004', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100410', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼409', '无409', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('433', '1', '百会407', '罗晓丽407', '研发中心7', '软件工程师7', '362350061@qq.com394', '18600885001', '18600885017', '18600885001', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100407', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼406', '无406', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('434', '1', '百会408', '罗晓丽408', '研发中心8', '软件工程师8', '362350061@qq.com395', '18600885002', '18600885018', '18600885002', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100408', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼407', '无407', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('435', '1', '百会413', '罗晓丽413', '研发中心13', '软件工程师13', '362350061@qq.com400', '18600885007', '18600885023', '18600885007', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100413', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼412', '无412', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('436', '1', '百会414', '罗晓丽414', '研发中心14', '软件工程师14', '362350061@qq.com401', '18600885008', '18600885024', '18600885008', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100414', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼413', '无413', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('437', '1', '百会411', '罗晓丽411', '研发中心11', '软件工程师11', '362350061@qq.com398', '18600885005', '18600885021', '18600885005', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100411', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼410', '无410', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('438', '1', '百会412', '罗晓丽412', '研发中心12', '软件工程师12', '362350061@qq.com399', '18600885006', '18600885022', '18600885006', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100412', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼411', '无411', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('439', '1', '百会401', '罗晓丽401', '研发中心1', '软件工程师1', '362350061@qq.com388', '18600884995', '18600885011', '18600884995', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100401', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼400', '无400', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('440', '1', '百会402', '罗晓丽402', '研发中心2', '软件工程师2', '362350061@qq.com389', '18600884996', '18600885012', '18600884996', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100402', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼401', '无401', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('441', '1', '百会399', '罗晓丽399', '研发中心19', '软件工程师19', '362350061@qq.com386', '18600884993', '18600885009', '18600884993', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100399', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼398', '无398', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('442', '1', '百会400', '罗晓丽400', '研发中心19', '软件工程师19', '362350061@qq.com387', '18600884994', '18600885010', '18600884994', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100400', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼399', '无399', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('443', '1', '百会405', '罗晓丽405', '研发中心5', '软件工程师5', '362350061@qq.com392', '18600884999', '18600885015', '18600884999', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100405', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼404', '无404', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('444', '1', '百会406', '罗晓丽406', '研发中心6', '软件工程师6', '362350061@qq.com393', '18600885000', '18600885016', '18600885000', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100406', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼405', '无405', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:21', null);
INSERT INTO `lead` VALUES ('445', '1', '百会403', '罗晓丽403', '研发中心3', '软件工程师3', '362350061@qq.com390', '18600884997', '18600885013', '18600884997', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100403', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼402', '无402', '0', '1', '2014-07-21 16:26:21', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('446', '1', '百会404', '罗晓丽404', '研发中心4', '软件工程师4', '362350061@qq.com391', '18600884998', '18600885014', '18600884998', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100404', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼403', '无403', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('447', '1', '百会394', '罗晓丽394', '研发中心14', '软件工程师14', '362350061@qq.com381', '18600884988', '18600885004', '18600884988', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100394', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼393', '无393', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('448', '1', '百会393', '罗晓丽393', '研发中心13', '软件工程师13', '362350061@qq.com380', '18600884987', '18600885003', '18600884987', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100393', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼392', '无392', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('449', '1', '百会392', '罗晓丽392', '研发中心12', '软件工程师12', '362350061@qq.com379', '18600884986', '18600885002', '18600884986', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100392', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼391', '无391', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('450', '1', '百会391', '罗晓丽391', '研发中心11', '软件工程师11', '362350061@qq.com378', '18600884985', '18600885001', '18600884985', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100391', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼390', '无390', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('451', '1', '百会398', '罗晓丽398', '研发中心18', '软件工程师18', '362350061@qq.com385', '18600884992', '18600885008', '18600884992', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100398', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼397', '无397', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('452', '1', '百会397', '罗晓丽397', '研发中心17', '软件工程师17', '362350061@qq.com384', '18600884991', '18600885007', '18600884991', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100397', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼396', '无396', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('453', '1', '百会396', '罗晓丽396', '研发中心16', '软件工程师16', '362350061@qq.com383', '18600884990', '18600885006', '18600884990', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100396', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼395', '无395', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('454', '1', '百会395', '罗晓丽395', '研发中心15', '软件工程师15', '362350061@qq.com382', '18600884989', '18600885005', '18600884989', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100395', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼394', '无394', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('455', '1', '百会386', '罗晓丽386', '研发中心6', '软件工程师6', '362350061@qq.com373', '18600884980', '18600884996', '18600884980', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100386', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼385', '无385', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('456', '1', '百会385', '罗晓丽385', '研发中心5', '软件工程师5', '362350061@qq.com372', '18600884979', '18600884995', '18600884979', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100385', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼384', '无384', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('457', '1', '百会384', '罗晓丽384', '研发中心4', '软件工程师4', '362350061@qq.com371', '18600884978', '18600884994', '18600884978', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100384', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼383', '无383', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('458', '1', '百会383', '罗晓丽383', '研发中心3', '软件工程师3', '362350061@qq.com370', '18600884977', '18600884993', '18600884977', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100383', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼382', '无382', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('459', '1', '百会390', '罗晓丽390', '研发中心10', '软件工程师10', '362350061@qq.com377', '18600884984', '18600885000', '18600884984', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100390', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼389', '无389', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('460', '1', '百会389', '罗晓丽389', '研发中心9', '软件工程师9', '362350061@qq.com376', '18600884983', '18600884999', '18600884983', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100389', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼388', '无388', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('461', '1', '百会388', '罗晓丽388', '研发中心8', '软件工程师8', '362350061@qq.com375', '18600884982', '18600884998', '18600884982', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100388', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼387', '无387', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('462', '1', '百会387', '罗晓丽387', '研发中心7', '软件工程师7', '362350061@qq.com374', '18600884981', '18600884997', '18600884981', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100387', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼386', '无386', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('463', '1', '百会439', '罗晓丽439', '研发中心19', '软件工程师19', '362350061@qq.com426', '18600885033', '18600885049', '18600885033', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100439', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼438', '无438', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('464', '1', '百会440', '罗晓丽440', '研发中心19', '软件工程师19', '362350061@qq.com427', '18600885034', '18600885050', '18600885034', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100440', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼439', '无439', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('465', '1', '百会441', '罗晓丽441', '研发中心1', '软件工程师1', '362350061@qq.com428', '18600885035', '18600885051', '18600885035', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100441', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼440', '无440', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('466', '1', '百会442', '罗晓丽442', '研发中心2', '软件工程师2', '362350061@qq.com429', '18600885036', '18600885052', '18600885036', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100442', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼441', '无441', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('467', '1', '百会443', '罗晓丽443', '研发中心3', '软件工程师3', '362350061@qq.com430', '18600885037', '18600885053', '18600885037', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100443', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼442', '无442', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('468', '1', '百会444', '罗晓丽444', '研发中心4', '软件工程师4', '362350061@qq.com431', '18600885038', '18600885054', '18600885038', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100444', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼443', '无443', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('469', '1', '百会445', '罗晓丽445', '研发中心5', '软件工程师5', '362350061@qq.com432', '18600885039', '18600885055', '18600885039', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100445', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼444', '无444', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('470', '1', '百会446', '罗晓丽446', '研发中心6', '软件工程师6', '362350061@qq.com433', '18600885040', '18600885056', '18600885040', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100446', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼445', '无445', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('471', '1', '百会431', '罗晓丽431', '研发中心11', '软件工程师11', '362350061@qq.com418', '18600885025', '18600885041', '18600885025', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100431', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼430', '无430', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('472', '1', '百会432', '罗晓丽432', '研发中心12', '软件工程师12', '362350061@qq.com419', '18600885026', '18600885042', '18600885026', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100432', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼431', '无431', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('473', '1', '百会433', '罗晓丽433', '研发中心13', '软件工程师13', '362350061@qq.com420', '18600885027', '18600885043', '18600885027', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100433', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼432', '无432', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('474', '1', '百会434', '罗晓丽434', '研发中心14', '软件工程师14', '362350061@qq.com421', '18600885028', '18600885044', '18600885028', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100434', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼433', '无433', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('475', '1', '百会435', '罗晓丽435', '研发中心15', '软件工程师15', '362350061@qq.com422', '18600885029', '18600885045', '18600885029', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100435', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼434', '无434', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('476', '1', '百会436', '罗晓丽436', '研发中心16', '软件工程师16', '362350061@qq.com423', '18600885030', '18600885046', '18600885030', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100436', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼435', '无435', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('477', '1', '百会437', '罗晓丽437', '研发中心17', '软件工程师17', '362350061@qq.com424', '18600885031', '18600885047', '18600885031', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100437', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼436', '无436', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('478', '1', '百会438', '罗晓丽438', '研发中心18', '软件工程师18', '362350061@qq.com425', '18600885032', '18600885048', '18600885032', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100438', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼437', '无437', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('479', '1', '百会424', '罗晓丽424', '研发中心4', '软件工程师4', '362350061@qq.com411', '18600885018', '18600885034', '18600885018', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100424', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼423', '无423', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('480', '1', '百会423', '罗晓丽423', '研发中心3', '软件工程师3', '362350061@qq.com410', '18600885017', '18600885033', '18600885017', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100423', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼422', '无422', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:22', null);
INSERT INTO `lead` VALUES ('481', '1', '百会426', '罗晓丽426', '研发中心6', '软件工程师6', '362350061@qq.com413', '18600885020', '18600885036', '18600885020', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100426', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼425', '无425', '0', '1', '2014-07-21 16:26:22', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('482', '1', '百会425', '罗晓丽425', '研发中心5', '软件工程师5', '362350061@qq.com412', '18600885019', '18600885035', '18600885019', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100425', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼424', '无424', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('483', '1', '百会428', '罗晓丽428', '研发中心8', '软件工程师8', '362350061@qq.com415', '18600885022', '18600885038', '18600885022', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100428', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼427', '无427', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('484', '1', '百会427', '罗晓丽427', '研发中心7', '软件工程师7', '362350061@qq.com414', '18600885021', '18600885037', '18600885021', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100427', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼426', '无426', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('485', '1', '百会430', '罗晓丽430', '研发中心10', '软件工程师10', '362350061@qq.com417', '18600885024', '18600885040', '18600885024', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100430', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼429', '无429', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('486', '1', '百会429', '罗晓丽429', '研发中心9', '软件工程师9', '362350061@qq.com416', '18600885023', '18600885039', '18600885023', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100429', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼428', '无428', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('487', '1', '百会416', '罗晓丽416', '研发中心16', '软件工程师16', '362350061@qq.com403', '18600885010', '18600885026', '18600885010', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100416', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼415', '无415', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('488', '1', '百会415', '罗晓丽415', '研发中心15', '软件工程师15', '362350061@qq.com402', '18600885009', '18600885025', '18600885009', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100415', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼414', '无414', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('489', '1', '百会418', '罗晓丽418', '研发中心18', '软件工程师18', '362350061@qq.com405', '18600885012', '18600885028', '18600885012', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100418', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼417', '无417', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('490', '1', '百会417', '罗晓丽417', '研发中心17', '软件工程师17', '362350061@qq.com404', '18600885011', '18600885027', '18600885011', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100417', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼416', '无416', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('491', '1', '百会420', '罗晓丽420', '研发中心19', '软件工程师19', '362350061@qq.com407', '18600885014', '18600885030', '18600885014', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100420', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼419', '无419', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('492', '1', '百会419', '罗晓丽419', '研发中心19', '软件工程师19', '362350061@qq.com406', '18600885013', '18600885029', '18600885013', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100419', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼418', '无418', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('493', '1', '百会422', '罗晓丽422', '研发中心2', '软件工程师2', '362350061@qq.com409', '18600885016', '18600885032', '18600885016', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100422', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼421', '无421', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('494', '1', '百会421', '罗晓丽421', '研发中心1', '软件工程师1', '362350061@qq.com408', '18600885015', '18600885031', '18600885015', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100421', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼420', '无420', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('495', '1', '百会477', '罗晓丽477', '研发中心17', '软件工程师17', '362350061@qq.com464', '18600885071', '18600885087', '18600885071', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100477', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼476', '无476', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('496', '1', '百会478', '罗晓丽478', '研发中心18', '软件工程师18', '362350061@qq.com465', '18600885072', '18600885088', '18600885072', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100478', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼477', '无477', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('497', '1', '百会475', '罗晓丽475', '研发中心15', '软件工程师15', '362350061@qq.com462', '18600885069', '18600885085', '18600885069', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100475', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼474', '无474', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('498', '1', '百会476', '罗晓丽476', '研发中心16', '软件工程师16', '362350061@qq.com463', '18600885070', '18600885086', '18600885070', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100476', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼475', '无475', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('499', '1', '百会473', '罗晓丽473', '研发中心13', '软件工程师13', '362350061@qq.com460', '18600885067', '18600885083', '18600885067', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100473', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼472', '无472', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('500', '1', '百会474', '罗晓丽474', '研发中心14', '软件工程师14', '362350061@qq.com461', '18600885068', '18600885084', '18600885068', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100474', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼473', '无473', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('501', '1', '百会471', '罗晓丽471', '研发中心11', '软件工程师11', '362350061@qq.com458', '18600885065', '18600885081', '18600885065', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100471', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼470', '无470', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('502', '1', '百会472', '罗晓丽472', '研发中心12', '软件工程师12', '362350061@qq.com459', '18600885066', '18600885082', '18600885066', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100472', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼471', '无471', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('503', '1', '百会469', '罗晓丽469', '研发中心9', '软件工程师9', '362350061@qq.com456', '18600885063', '18600885079', '18600885063', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100469', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼468', '无468', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('504', '1', '百会470', '罗晓丽470', '研发中心10', '软件工程师10', '362350061@qq.com457', '18600885064', '18600885080', '18600885064', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100470', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼469', '无469', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('505', '1', '百会467', '罗晓丽467', '研发中心7', '软件工程师7', '362350061@qq.com454', '18600885061', '18600885077', '18600885061', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100467', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼466', '无466', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('506', '1', '百会468', '罗晓丽468', '研发中心8', '软件工程师8', '362350061@qq.com455', '18600885062', '18600885078', '18600885062', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100468', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼467', '无467', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('507', '1', '百会465', '罗晓丽465', '研发中心5', '软件工程师5', '362350061@qq.com452', '18600885059', '18600885075', '18600885059', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100465', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼464', '无464', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('508', '1', '百会466', '罗晓丽466', '研发中心6', '软件工程师6', '362350061@qq.com453', '18600885060', '18600885076', '18600885060', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100466', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼465', '无465', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('509', '1', '百会463', '罗晓丽463', '研发中心3', '软件工程师3', '362350061@qq.com450', '18600885057', '18600885073', '18600885057', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100463', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼462', '无462', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('510', '1', '百会464', '罗晓丽464', '研发中心4', '软件工程师4', '362350061@qq.com451', '18600885058', '18600885074', '18600885058', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100464', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼463', '无463', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('511', '1', '百会462', '罗晓丽462', '研发中心2', '软件工程师2', '362350061@qq.com449', '18600885056', '18600885072', '18600885056', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100462', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼461', '无461', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('512', '1', '百会461', '罗晓丽461', '研发中心1', '软件工程师1', '362350061@qq.com448', '18600885055', '18600885071', '18600885055', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100461', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼460', '无460', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('513', '1', '百会460', '罗晓丽460', '研发中心19', '软件工程师19', '362350061@qq.com447', '18600885054', '18600885070', '18600885054', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100460', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼459', '无459', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('514', '1', '百会459', '罗晓丽459', '研发中心19', '软件工程师19', '362350061@qq.com446', '18600885053', '18600885069', '18600885053', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100459', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼458', '无458', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('515', '1', '百会458', '罗晓丽458', '研发中心18', '软件工程师18', '362350061@qq.com445', '18600885052', '18600885068', '18600885052', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100458', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼457', '无457', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:23', null);
INSERT INTO `lead` VALUES ('516', '1', '百会457', '罗晓丽457', '研发中心17', '软件工程师17', '362350061@qq.com444', '18600885051', '18600885067', '18600885051', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100457', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼456', '无456', '0', '1', '2014-07-21 16:26:23', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('517', '1', '百会456', '罗晓丽456', '研发中心16', '软件工程师16', '362350061@qq.com443', '18600885050', '18600885066', '18600885050', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100456', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼455', '无455', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('518', '1', '百会455', '罗晓丽455', '研发中心15', '软件工程师15', '362350061@qq.com442', '18600885049', '18600885065', '18600885049', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100455', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼454', '无454', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('519', '1', '百会454', '罗晓丽454', '研发中心14', '软件工程师14', '362350061@qq.com441', '18600885048', '18600885064', '18600885048', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100454', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼453', '无453', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('520', '1', '百会453', '罗晓丽453', '研发中心13', '软件工程师13', '362350061@qq.com440', '18600885047', '18600885063', '18600885047', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100453', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼452', '无452', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('521', '1', '百会452', '罗晓丽452', '研发中心12', '软件工程师12', '362350061@qq.com439', '18600885046', '18600885062', '18600885046', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100452', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼451', '无451', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('522', '1', '百会451', '罗晓丽451', '研发中心11', '软件工程师11', '362350061@qq.com438', '18600885045', '18600885061', '18600885045', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100451', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼450', '无450', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('523', '1', '百会450', '罗晓丽450', '研发中心10', '软件工程师10', '362350061@qq.com437', '18600885044', '18600885060', '18600885044', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100450', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼449', '无449', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('524', '1', '百会449', '罗晓丽449', '研发中心9', '软件工程师9', '362350061@qq.com436', '18600885043', '18600885059', '18600885043', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100449', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼448', '无448', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('525', '1', '百会448', '罗晓丽448', '研发中心8', '软件工程师8', '362350061@qq.com435', '18600885042', '18600885058', '18600885042', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100448', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼447', '无447', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('526', '1', '百会447', '罗晓丽447', '研发中心7', '软件工程师7', '362350061@qq.com434', '18600885041', '18600885057', '18600885041', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100447', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼446', '无446', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('527', '1', '百会507', '罗晓丽507', '研发中心7', '软件工程师7', '362350061@qq.com494', '18600885101', '18600885117', '18600885101', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100507', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼506', '无506', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('528', '1', '百会508', '罗晓丽508', '研发中心8', '软件工程师8', '362350061@qq.com495', '18600885102', '18600885118', '18600885102', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100508', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼507', '无507', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('529', '1', '百会509', '罗晓丽509', '研发中心9', '软件工程师9', '362350061@qq.com496', '18600885103', '18600885119', '18600885103', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100509', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼508', '无508', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('530', '1', '百会510', '罗晓丽510', '研发中心10', '软件工程师10', '362350061@qq.com497', '18600885104', '18600885120', '18600885104', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100510', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼509', '无509', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('531', '1', '百会503', '罗晓丽503', '研发中心3', '软件工程师3', '362350061@qq.com490', '18600885097', '18600885113', '18600885097', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100503', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼502', '无502', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('532', '1', '百会504', '罗晓丽504', '研发中心4', '软件工程师4', '362350061@qq.com491', '18600885098', '18600885114', '18600885098', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100504', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼503', '无503', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('533', '1', '百会505', '罗晓丽505', '研发中心5', '软件工程师5', '362350061@qq.com492', '18600885099', '18600885115', '18600885099', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100505', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼504', '无504', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('534', '1', '百会506', '罗晓丽506', '研发中心6', '软件工程师6', '362350061@qq.com493', '18600885100', '18600885116', '18600885100', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100506', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼505', '无505', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('535', '1', '百会499', '罗晓丽499', '研发中心19', '软件工程师19', '362350061@qq.com486', '18600885093', '18600885109', '18600885093', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100499', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼498', '无498', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('536', '1', '百会500', '罗晓丽500', '研发中心19', '软件工程师19', '362350061@qq.com487', '18600885094', '18600885110', '18600885094', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100500', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼499', '无499', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('537', '1', '百会501', '罗晓丽501', '研发中心1', '软件工程师1', '362350061@qq.com488', '18600885095', '18600885111', '18600885095', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100501', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼500', '无500', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('538', '1', '百会502', '罗晓丽502', '研发中心2', '软件工程师2', '362350061@qq.com489', '18600885096', '18600885112', '18600885096', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100502', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼501', '无501', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('539', '1', '百会495', '罗晓丽495', '研发中心15', '软件工程师15', '362350061@qq.com482', '18600885089', '18600885105', '18600885089', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100495', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼494', '无494', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('540', '1', '百会496', '罗晓丽496', '研发中心16', '软件工程师16', '362350061@qq.com483', '18600885090', '18600885106', '18600885090', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100496', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼495', '无495', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('541', '1', '百会497', '罗晓丽497', '研发中心17', '软件工程师17', '362350061@qq.com484', '18600885091', '18600885107', '18600885091', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100497', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼496', '无496', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('542', '1', '百会498', '罗晓丽498', '研发中心18', '软件工程师18', '362350061@qq.com485', '18600885092', '18600885108', '18600885092', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100498', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼497', '无497', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('543', '1', '百会492', '罗晓丽492', '研发中心12', '软件工程师12', '362350061@qq.com479', '18600885086', '18600885102', '18600885086', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100492', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼491', '无491', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('544', '1', '百会491', '罗晓丽491', '研发中心11', '软件工程师11', '362350061@qq.com478', '18600885085', '18600885101', '18600885085', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100491', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼490', '无490', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('545', '1', '百会494', '罗晓丽494', '研发中心14', '软件工程师14', '362350061@qq.com481', '18600885088', '18600885104', '18600885088', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100494', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼493', '无493', '0', '1', '2014-07-21 16:26:24', '1', '2014-07-21 16:26:24', null);
INSERT INTO `lead` VALUES ('546', '1', '百会493', '罗晓丽493', '研发中心13', '软件工程师13', '362350061@qq.com480', '18600885087', '18600885103', '18600885087', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100493', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼492', '无492', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('547', '1', '百会488', '罗晓丽488', '研发中心8', '软件工程师8', '362350061@qq.com475', '18600885082', '18600885098', '18600885082', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100488', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼487', '无487', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('548', '1', '百会487', '罗晓丽487', '研发中心7', '软件工程师7', '362350061@qq.com474', '18600885081', '18600885097', '18600885081', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100487', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼486', '无486', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('549', '1', '百会490', '罗晓丽490', '研发中心10', '软件工程师10', '362350061@qq.com477', '18600885084', '18600885100', '18600885084', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100490', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼489', '无489', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('550', '1', '百会489', '罗晓丽489', '研发中心9', '软件工程师9', '362350061@qq.com476', '18600885083', '18600885099', '18600885083', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100489', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼488', '无488', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('551', '1', '百会484', '罗晓丽484', '研发中心4', '软件工程师4', '362350061@qq.com471', '18600885078', '18600885094', '18600885078', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100484', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼483', '无483', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('552', '1', '百会483', '罗晓丽483', '研发中心3', '软件工程师3', '362350061@qq.com470', '18600885077', '18600885093', '18600885077', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100483', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼482', '无482', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('553', '1', '百会486', '罗晓丽486', '研发中心6', '软件工程师6', '362350061@qq.com473', '18600885080', '18600885096', '18600885080', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100486', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼485', '无485', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('554', '1', '百会485', '罗晓丽485', '研发中心5', '软件工程师5', '362350061@qq.com472', '18600885079', '18600885095', '18600885079', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100485', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼484', '无484', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('555', '1', '百会480', '罗晓丽480', '研发中心19', '软件工程师19', '362350061@qq.com467', '18600885074', '18600885090', '18600885074', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100480', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼479', '无479', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('556', '1', '百会479', '罗晓丽479', '研发中心19', '软件工程师19', '362350061@qq.com466', '18600885073', '18600885089', '18600885073', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100479', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼478', '无478', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('557', '1', '百会482', '罗晓丽482', '研发中心2', '软件工程师2', '362350061@qq.com469', '18600885076', '18600885092', '18600885076', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100482', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼481', '无481', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('558', '1', '百会481', '罗晓丽481', '研发中心1', '软件工程师1', '362350061@qq.com468', '18600885075', '18600885091', '18600885075', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100481', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼480', '无480', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('559', '1', '百会549', '罗晓丽549', '研发中心9', '软件工程师9', '362350061@qq.com536', '18600885143', '18600885159', '18600885143', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100549', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼548', '无548', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('560', '1', '百会550', '罗晓丽550', '研发中心10', '软件工程师10', '362350061@qq.com537', '18600885144', '18600885160', '18600885144', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100550', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼549', '无549', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('561', '1', '百会547', '罗晓丽547', '研发中心7', '软件工程师7', '362350061@qq.com534', '18600885141', '18600885157', '18600885141', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100547', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼546', '无546', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('562', '1', '百会548', '罗晓丽548', '研发中心8', '软件工程师8', '362350061@qq.com535', '18600885142', '18600885158', '18600885142', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100548', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼547', '无547', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('563', '1', '百会545', '罗晓丽545', '研发中心5', '软件工程师5', '362350061@qq.com532', '18600885139', '18600885155', '18600885139', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100545', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼544', '无544', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('564', '1', '百会546', '罗晓丽546', '研发中心6', '软件工程师6', '362350061@qq.com533', '18600885140', '18600885156', '18600885140', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100546', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼545', '无545', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('565', '1', '百会543', '罗晓丽543', '研发中心3', '软件工程师3', '362350061@qq.com530', '18600885137', '18600885153', '18600885137', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100543', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼542', '无542', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('566', '1', '百会544', '罗晓丽544', '研发中心4', '软件工程师4', '362350061@qq.com531', '18600885138', '18600885154', '18600885138', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100544', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼543', '无543', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('567', '1', '百会557', '罗晓丽557', '研发中心17', '软件工程师17', '362350061@qq.com544', '18600885151', '18600885167', '18600885151', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100557', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼556', '无556', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('568', '1', '百会558', '罗晓丽558', '研发中心18', '软件工程师18', '362350061@qq.com545', '18600885152', '18600885168', '18600885152', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100558', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼557', '无557', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('569', '1', '百会555', '罗晓丽555', '研发中心15', '软件工程师15', '362350061@qq.com542', '18600885149', '18600885165', '18600885149', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100555', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼554', '无554', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('570', '1', '百会556', '罗晓丽556', '研发中心16', '软件工程师16', '362350061@qq.com543', '18600885150', '18600885166', '18600885150', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100556', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼555', '无555', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('571', '1', '百会553', '罗晓丽553', '研发中心13', '软件工程师13', '362350061@qq.com540', '18600885147', '18600885163', '18600885147', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100553', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼552', '无552', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('572', '1', '百会554', '罗晓丽554', '研发中心14', '软件工程师14', '362350061@qq.com541', '18600885148', '18600885164', '18600885148', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100554', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼553', '无553', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('573', '1', '百会551', '罗晓丽551', '研发中心11', '软件工程师11', '362350061@qq.com538', '18600885145', '18600885161', '18600885145', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100551', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼550', '无550', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('574', '1', '百会552', '罗晓丽552', '研发中心12', '软件工程师12', '362350061@qq.com539', '18600885146', '18600885162', '18600885146', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100552', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼551', '无551', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('575', '1', '百会566', '罗晓丽566', '研发中心6', '软件工程师6', '362350061@qq.com553', '18600885160', '18600885176', '18600885160', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100566', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼565', '无565', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('576', '1', '百会565', '罗晓丽565', '研发中心5', '软件工程师5', '362350061@qq.com552', '18600885159', '18600885175', '18600885159', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100565', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼564', '无564', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('577', '1', '百会564', '罗晓丽564', '研发中心4', '软件工程师4', '362350061@qq.com551', '18600885158', '18600885174', '18600885158', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100564', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼563', '无563', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('578', '1', '百会563', '罗晓丽563', '研发中心3', '软件工程师3', '362350061@qq.com550', '18600885157', '18600885173', '18600885157', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100563', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼562', '无562', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:25', null);
INSERT INTO `lead` VALUES ('579', '1', '百会562', '罗晓丽562', '研发中心2', '软件工程师2', '362350061@qq.com549', '18600885156', '18600885172', '18600885156', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100562', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼561', '无561', '0', '1', '2014-07-21 16:26:25', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('580', '1', '百会561', '罗晓丽561', '研发中心1', '软件工程师1', '362350061@qq.com548', '18600885155', '18600885171', '18600885155', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100561', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼560', '无560', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('581', '1', '百会560', '罗晓丽560', '研发中心19', '软件工程师19', '362350061@qq.com547', '18600885154', '18600885170', '18600885154', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100560', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼559', '无559', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('582', '1', '百会559', '罗晓丽559', '研发中心19', '软件工程师19', '362350061@qq.com546', '18600885153', '18600885169', '18600885153', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100559', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼558', '无558', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('583', '1', '百会574', '罗晓丽574', '研发中心14', '软件工程师14', '362350061@qq.com561', '18600885168', '18600885184', '18600885168', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100574', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼573', '无573', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('584', '1', '百会573', '罗晓丽573', '研发中心13', '软件工程师13', '362350061@qq.com560', '18600885167', '18600885183', '18600885167', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100573', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼572', '无572', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('585', '1', '百会572', '罗晓丽572', '研发中心12', '软件工程师12', '362350061@qq.com559', '18600885166', '18600885182', '18600885166', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100572', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼571', '无571', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('586', '1', '百会571', '罗晓丽571', '研发中心11', '软件工程师11', '362350061@qq.com558', '18600885165', '18600885181', '18600885165', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100571', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼570', '无570', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('587', '1', '百会570', '罗晓丽570', '研发中心10', '软件工程师10', '362350061@qq.com557', '18600885164', '18600885180', '18600885164', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100570', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼569', '无569', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('588', '1', '百会569', '罗晓丽569', '研发中心9', '软件工程师9', '362350061@qq.com556', '18600885163', '18600885179', '18600885163', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100569', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼568', '无568', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('589', '1', '百会568', '罗晓丽568', '研发中心8', '软件工程师8', '362350061@qq.com555', '18600885162', '18600885178', '18600885162', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100568', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼567', '无567', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('590', '1', '百会567', '罗晓丽567', '研发中心7', '软件工程师7', '362350061@qq.com554', '18600885161', '18600885177', '18600885161', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100567', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼566', '无566', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('591', '1', '百会515', '罗晓丽515', '研发中心15', '软件工程师15', '362350061@qq.com502', '18600885109', '18600885125', '18600885109', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100515', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼514', '无514', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('592', '1', '百会516', '罗晓丽516', '研发中心16', '软件工程师16', '362350061@qq.com503', '18600885110', '18600885126', '18600885110', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100516', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼515', '无515', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('593', '1', '百会517', '罗晓丽517', '研发中心17', '软件工程师17', '362350061@qq.com504', '18600885111', '18600885127', '18600885111', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100517', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼516', '无516', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('594', '1', '百会518', '罗晓丽518', '研发中心18', '软件工程师18', '362350061@qq.com505', '18600885112', '18600885128', '18600885112', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100518', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼517', '无517', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('595', '1', '百会511', '罗晓丽511', '研发中心11', '软件工程师11', '362350061@qq.com498', '18600885105', '18600885121', '18600885105', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100511', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼510', '无510', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('596', '1', '百会512', '罗晓丽512', '研发中心12', '软件工程师12', '362350061@qq.com499', '18600885106', '18600885122', '18600885106', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100512', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼511', '无511', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('597', '1', '百会513', '罗晓丽513', '研发中心13', '软件工程师13', '362350061@qq.com500', '18600885107', '18600885123', '18600885107', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100513', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼512', '无512', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('598', '1', '百会514', '罗晓丽514', '研发中心14', '软件工程师14', '362350061@qq.com501', '18600885108', '18600885124', '18600885108', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100514', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼513', '无513', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('599', '1', '百会523', '罗晓丽523', '研发中心3', '软件工程师3', '362350061@qq.com510', '18600885117', '18600885133', '18600885117', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100523', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼522', '无522', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('600', '1', '百会524', '罗晓丽524', '研发中心4', '软件工程师4', '362350061@qq.com511', '18600885118', '18600885134', '18600885118', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100524', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼523', '无523', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('601', '1', '百会525', '罗晓丽525', '研发中心5', '软件工程师5', '362350061@qq.com512', '18600885119', '18600885135', '18600885119', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100525', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼524', '无524', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('602', '1', '百会526', '罗晓丽526', '研发中心6', '软件工程师6', '362350061@qq.com513', '18600885120', '18600885136', '18600885120', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100526', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼525', '无525', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('603', '1', '百会519', '罗晓丽519', '研发中心19', '软件工程师19', '362350061@qq.com506', '18600885113', '18600885129', '18600885113', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100519', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼518', '无518', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('604', '1', '百会520', '罗晓丽520', '研发中心19', '软件工程师19', '362350061@qq.com507', '18600885114', '18600885130', '18600885114', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100520', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼519', '无519', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('605', '1', '百会521', '罗晓丽521', '研发中心1', '软件工程师1', '362350061@qq.com508', '18600885115', '18600885131', '18600885115', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100521', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼520', '无520', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('606', '1', '百会522', '罗晓丽522', '研发中心2', '软件工程师2', '362350061@qq.com509', '18600885116', '18600885132', '18600885116', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100522', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼521', '无521', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('607', '1', '百会532', '罗晓丽532', '研发中心12', '软件工程师12', '362350061@qq.com519', '18600885126', '18600885142', '18600885126', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100532', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼531', '无531', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('608', '1', '百会531', '罗晓丽531', '研发中心11', '软件工程师11', '362350061@qq.com518', '18600885125', '18600885141', '18600885125', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100531', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼530', '无530', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('609', '1', '百会534', '罗晓丽534', '研发中心14', '软件工程师14', '362350061@qq.com521', '18600885128', '18600885144', '18600885128', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100534', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼533', '无533', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('610', '1', '百会533', '罗晓丽533', '研发中心13', '软件工程师13', '362350061@qq.com520', '18600885127', '18600885143', '18600885127', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100533', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼532', '无532', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('611', '1', '百会528', '罗晓丽528', '研发中心8', '软件工程师8', '362350061@qq.com515', '18600885122', '18600885138', '18600885122', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100528', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼527', '无527', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('612', '1', '百会527', '罗晓丽527', '研发中心7', '软件工程师7', '362350061@qq.com514', '18600885121', '18600885137', '18600885121', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100527', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼526', '无526', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('613', '1', '百会530', '罗晓丽530', '研发中心10', '软件工程师10', '362350061@qq.com517', '18600885124', '18600885140', '18600885124', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100530', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼529', '无529', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('614', '1', '百会529', '罗晓丽529', '研发中心9', '软件工程师9', '362350061@qq.com516', '18600885123', '18600885139', '18600885123', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100529', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼528', '无528', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:26', null);
INSERT INTO `lead` VALUES ('615', '1', '百会540', '罗晓丽540', '研发中心19', '软件工程师19', '362350061@qq.com527', '18600885134', '18600885150', '18600885134', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100540', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼539', '无539', '0', '1', '2014-07-21 16:26:26', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('616', '1', '百会539', '罗晓丽539', '研发中心19', '软件工程师19', '362350061@qq.com526', '18600885133', '18600885149', '18600885133', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100539', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼538', '无538', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('617', '1', '百会542', '罗晓丽542', '研发中心2', '软件工程师2', '362350061@qq.com529', '18600885136', '18600885152', '18600885136', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100542', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼541', '无541', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('618', '1', '百会541', '罗晓丽541', '研发中心1', '软件工程师1', '362350061@qq.com528', '18600885135', '18600885151', '18600885135', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100541', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼540', '无540', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('619', '1', '百会536', '罗晓丽536', '研发中心16', '软件工程师16', '362350061@qq.com523', '18600885130', '18600885146', '18600885130', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100536', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼535', '无535', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('620', '1', '百会535', '罗晓丽535', '研发中心15', '软件工程师15', '362350061@qq.com522', '18600885129', '18600885145', '18600885129', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100535', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼534', '无534', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('621', '1', '百会538', '罗晓丽538', '研发中心18', '软件工程师18', '362350061@qq.com525', '18600885132', '18600885148', '18600885132', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100538', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼537', '无537', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('622', '1', '百会537', '罗晓丽537', '研发中心17', '软件工程师17', '362350061@qq.com524', '18600885131', '18600885147', '18600885131', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100537', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼536', '无536', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('623', '1', '百会609', '罗晓丽609', '研发中心9', '软件工程师9', '362350061@qq.com596', '18600885203', '18600885219', '18600885203', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100609', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼608', '无608', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('624', '1', '百会610', '罗晓丽610', '研发中心10', '软件工程师10', '362350061@qq.com597', '18600885204', '18600885220', '18600885204', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100610', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼609', '无609', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('625', '1', '百会607', '罗晓丽607', '研发中心7', '软件工程师7', '362350061@qq.com594', '18600885201', '18600885217', '18600885201', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100607', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼606', '无606', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('626', '1', '百会608', '罗晓丽608', '研发中心8', '软件工程师8', '362350061@qq.com595', '18600885202', '18600885218', '18600885202', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100608', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼607', '无607', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('627', '1', '百会613', '罗晓丽613', '研发中心13', '软件工程师13', '362350061@qq.com600', '18600885207', '18600885223', '18600885207', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100613', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼612', '无612', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('628', '1', '百会614', '罗晓丽614', '研发中心14', '软件工程师14', '362350061@qq.com601', '18600885208', '18600885224', '18600885208', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100614', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼613', '无613', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('629', '1', '百会611', '罗晓丽611', '研发中心11', '软件工程师11', '362350061@qq.com598', '18600885205', '18600885221', '18600885205', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100611', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼610', '无610', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('630', '1', '百会612', '罗晓丽612', '研发中心12', '软件工程师12', '362350061@qq.com599', '18600885206', '18600885222', '18600885206', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100612', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼611', '无611', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('631', '1', '百会617', '罗晓丽617', '研发中心17', '软件工程师17', '362350061@qq.com604', '18600885211', '18600885227', '18600885211', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100617', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼616', '无616', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('632', '1', '百会618', '罗晓丽618', '研发中心18', '软件工程师18', '362350061@qq.com605', '18600885212', '18600885228', '18600885212', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100618', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼617', '无617', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('633', '1', '百会615', '罗晓丽615', '研发中心15', '软件工程师15', '362350061@qq.com602', '18600885209', '18600885225', '18600885209', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100615', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼614', '无614', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('634', '1', '百会616', '罗晓丽616', '研发中心16', '软件工程师16', '362350061@qq.com603', '18600885210', '18600885226', '18600885210', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100616', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼615', '无615', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('635', '1', '百会621', '罗晓丽621', '研发中心1', '软件工程师1', '362350061@qq.com608', '18600885215', '18600885231', '18600885215', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100621', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼620', '无620', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('636', '1', '百会622', '罗晓丽622', '研发中心2', '软件工程师2', '362350061@qq.com609', '18600885216', '18600885232', '18600885216', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100622', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼621', '无621', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('637', '1', '百会619', '罗晓丽619', '研发中心19', '软件工程师19', '362350061@qq.com606', '18600885213', '18600885229', '18600885213', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100619', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼618', '无618', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('638', '1', '百会620', '罗晓丽620', '研发中心19', '软件工程师19', '362350061@qq.com607', '18600885214', '18600885230', '18600885214', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100620', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼619', '无619', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('639', '1', '百会626', '罗晓丽626', '研发中心6', '软件工程师6', '362350061@qq.com613', '18600885220', '18600885236', '18600885220', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100626', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼625', '无625', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('640', '1', '百会625', '罗晓丽625', '研发中心5', '软件工程师5', '362350061@qq.com612', '18600885219', '18600885235', '18600885219', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100625', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼624', '无624', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('641', '1', '百会624', '罗晓丽624', '研发中心4', '软件工程师4', '362350061@qq.com611', '18600885218', '18600885234', '18600885218', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100624', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼623', '无623', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('642', '1', '百会623', '罗晓丽623', '研发中心3', '软件工程师3', '362350061@qq.com610', '18600885217', '18600885233', '18600885217', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100623', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼622', '无622', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('643', '1', '百会630', '罗晓丽630', '研发中心10', '软件工程师10', '362350061@qq.com617', '18600885224', '18600885240', '18600885224', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100630', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼629', '无629', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('644', '1', '百会629', '罗晓丽629', '研发中心9', '软件工程师9', '362350061@qq.com616', '18600885223', '18600885239', '18600885223', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100629', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼628', '无628', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('645', '1', '百会628', '罗晓丽628', '研发中心8', '软件工程师8', '362350061@qq.com615', '18600885222', '18600885238', '18600885222', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100628', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼627', '无627', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('646', '1', '百会627', '罗晓丽627', '研发中心7', '软件工程师7', '362350061@qq.com614', '18600885221', '18600885237', '18600885221', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100627', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼626', '无626', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('647', '1', '百会634', '罗晓丽634', '研发中心14', '软件工程师14', '362350061@qq.com621', '18600885228', '18600885244', '18600885228', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100634', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼633', '无633', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('648', '1', '百会633', '罗晓丽633', '研发中心13', '软件工程师13', '362350061@qq.com620', '18600885227', '18600885243', '18600885227', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100633', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼632', '无632', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('649', '1', '百会632', '罗晓丽632', '研发中心12', '软件工程师12', '362350061@qq.com619', '18600885226', '18600885242', '18600885226', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100632', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼631', '无631', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('650', '1', '百会631', '罗晓丽631', '研发中心11', '软件工程师11', '362350061@qq.com618', '18600885225', '18600885241', '18600885225', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100631', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼630', '无630', '0', '1', '2014-07-21 16:26:27', '1', '2014-07-21 16:26:27', null);
INSERT INTO `lead` VALUES ('651', '1', '百会638', '罗晓丽638', '研发中心18', '软件工程师18', '362350061@qq.com625', '18600885232', '18600885248', '18600885232', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100638', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼637', '无637', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('652', '1', '百会637', '罗晓丽637', '研发中心17', '软件工程师17', '362350061@qq.com624', '18600885231', '18600885247', '18600885231', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100637', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼636', '无636', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('653', '1', '百会636', '罗晓丽636', '研发中心16', '软件工程师16', '362350061@qq.com623', '18600885230', '18600885246', '18600885230', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100636', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼635', '无635', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('654', '1', '百会635', '罗晓丽635', '研发中心15', '软件工程师15', '362350061@qq.com622', '18600885229', '18600885245', '18600885229', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100635', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼634', '无634', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('655', '1', '百会575', '罗晓丽575', '研发中心15', '软件工程师15', '362350061@qq.com562', '18600885169', '18600885185', '18600885169', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100575', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼574', '无574', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('656', '1', '百会576', '罗晓丽576', '研发中心16', '软件工程师16', '362350061@qq.com563', '18600885170', '18600885186', '18600885170', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100576', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼575', '无575', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('657', '1', '百会577', '罗晓丽577', '研发中心17', '软件工程师17', '362350061@qq.com564', '18600885171', '18600885187', '18600885171', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100577', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼576', '无576', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('658', '1', '百会578', '罗晓丽578', '研发中心18', '软件工程师18', '362350061@qq.com565', '18600885172', '18600885188', '18600885172', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100578', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼577', '无577', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('659', '1', '百会579', '罗晓丽579', '研发中心19', '软件工程师19', '362350061@qq.com566', '18600885173', '18600885189', '18600885173', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100579', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼578', '无578', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('660', '1', '百会580', '罗晓丽580', '研发中心19', '软件工程师19', '362350061@qq.com567', '18600885174', '18600885190', '18600885174', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100580', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼579', '无579', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('661', '1', '百会581', '罗晓丽581', '研发中心1', '软件工程师1', '362350061@qq.com568', '18600885175', '18600885191', '18600885175', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100581', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼580', '无580', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('662', '1', '百会582', '罗晓丽582', '研发中心2', '软件工程师2', '362350061@qq.com569', '18600885176', '18600885192', '18600885176', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100582', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼581', '无581', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('663', '1', '百会583', '罗晓丽583', '研发中心3', '软件工程师3', '362350061@qq.com570', '18600885177', '18600885193', '18600885177', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100583', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼582', '无582', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('664', '1', '百会584', '罗晓丽584', '研发中心4', '软件工程师4', '362350061@qq.com571', '18600885178', '18600885194', '18600885178', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100584', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼583', '无583', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('665', '1', '百会585', '罗晓丽585', '研发中心5', '软件工程师5', '362350061@qq.com572', '18600885179', '18600885195', '18600885179', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100585', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼584', '无584', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('666', '1', '百会586', '罗晓丽586', '研发中心6', '软件工程师6', '362350061@qq.com573', '18600885180', '18600885196', '18600885180', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100586', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼585', '无585', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('667', '1', '百会587', '罗晓丽587', '研发中心7', '软件工程师7', '362350061@qq.com574', '18600885181', '18600885197', '18600885181', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100587', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼586', '无586', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('668', '1', '百会588', '罗晓丽588', '研发中心8', '软件工程师8', '362350061@qq.com575', '18600885182', '18600885198', '18600885182', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100588', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼587', '无587', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('669', '1', '百会589', '罗晓丽589', '研发中心9', '软件工程师9', '362350061@qq.com576', '18600885183', '18600885199', '18600885183', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100589', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼588', '无588', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('670', '1', '百会590', '罗晓丽590', '研发中心10', '软件工程师10', '362350061@qq.com577', '18600885184', '18600885200', '18600885184', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100590', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼589', '无589', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('671', '1', '百会592', '罗晓丽592', '研发中心12', '软件工程师12', '362350061@qq.com579', '18600885186', '18600885202', '18600885186', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100592', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼591', '无591', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('672', '1', '百会591', '罗晓丽591', '研发中心11', '软件工程师11', '362350061@qq.com578', '18600885185', '18600885201', '18600885185', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100591', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼590', '无590', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('673', '1', '百会594', '罗晓丽594', '研发中心14', '软件工程师14', '362350061@qq.com581', '18600885188', '18600885204', '18600885188', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100594', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼593', '无593', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('674', '1', '百会593', '罗晓丽593', '研发中心13', '软件工程师13', '362350061@qq.com580', '18600885187', '18600885203', '18600885187', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100593', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼592', '无592', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('675', '1', '百会596', '罗晓丽596', '研发中心16', '软件工程师16', '362350061@qq.com583', '18600885190', '18600885206', '18600885190', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100596', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼595', '无595', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('676', '1', '百会595', '罗晓丽595', '研发中心15', '软件工程师15', '362350061@qq.com582', '18600885189', '18600885205', '18600885189', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100595', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼594', '无594', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('677', '1', '百会598', '罗晓丽598', '研发中心18', '软件工程师18', '362350061@qq.com585', '18600885192', '18600885208', '18600885192', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100598', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼597', '无597', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('678', '1', '百会597', '罗晓丽597', '研发中心17', '软件工程师17', '362350061@qq.com584', '18600885191', '18600885207', '18600885191', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100597', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼596', '无596', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('679', '1', '百会600', '罗晓丽600', '研发中心19', '软件工程师19', '362350061@qq.com587', '18600885194', '18600885210', '18600885194', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100600', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼599', '无599', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('680', '1', '百会599', '罗晓丽599', '研发中心19', '软件工程师19', '362350061@qq.com586', '18600885193', '18600885209', '18600885193', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100599', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼598', '无598', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('681', '1', '百会602', '罗晓丽602', '研发中心2', '软件工程师2', '362350061@qq.com589', '18600885196', '18600885212', '18600885196', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100602', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼601', '无601', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('682', '1', '百会601', '罗晓丽601', '研发中心1', '软件工程师1', '362350061@qq.com588', '18600885195', '18600885211', '18600885195', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100601', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼600', '无600', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('683', '1', '百会604', '罗晓丽604', '研发中心4', '软件工程师4', '362350061@qq.com591', '18600885198', '18600885214', '18600885198', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100604', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼603', '无603', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('684', '1', '百会603', '罗晓丽603', '研发中心3', '软件工程师3', '362350061@qq.com590', '18600885197', '18600885213', '18600885197', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100603', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼602', '无602', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('685', '1', '百会606', '罗晓丽606', '研发中心6', '软件工程师6', '362350061@qq.com593', '18600885200', '18600885216', '18600885200', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100606', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼605', '无605', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('686', '1', '百会605', '罗晓丽605', '研发中心5', '软件工程师5', '362350061@qq.com592', '18600885199', '18600885215', '18600885199', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100605', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼604', '无604', '0', '1', '2014-07-21 16:26:28', '1', '2014-07-21 16:26:28', null);
INSERT INTO `lead` VALUES ('687', '1', '百会686', '罗晓丽686', '研发中心6', '软件工程师6', '362350061@qq.com673', '18600885280', '18600885296', '18600885280', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100686', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼685', '无685', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('688', '1', '百会685', '罗晓丽685', '研发中心5', '软件工程师5', '362350061@qq.com672', '18600885279', '18600885295', '18600885279', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100685', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼684', '无684', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('689', '1', '百会684', '罗晓丽684', '研发中心4', '软件工程师4', '362350061@qq.com671', '18600885278', '18600885294', '18600885278', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100684', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼683', '无683', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('690', '1', '百会683', '罗晓丽683', '研发中心3', '软件工程师3', '362350061@qq.com670', '18600885277', '18600885293', '18600885277', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100683', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼682', '无682', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('691', '1', '百会682', '罗晓丽682', '研发中心2', '软件工程师2', '362350061@qq.com669', '18600885276', '18600885292', '18600885276', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100682', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼681', '无681', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('692', '1', '百会681', '罗晓丽681', '研发中心1', '软件工程师1', '362350061@qq.com668', '18600885275', '18600885291', '18600885275', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100681', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼680', '无680', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('693', '1', '百会680', '罗晓丽680', '研发中心19', '软件工程师19', '362350061@qq.com667', '18600885274', '18600885290', '18600885274', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100680', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼679', '无679', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('694', '1', '百会679', '罗晓丽679', '研发中心19', '软件工程师19', '362350061@qq.com666', '18600885273', '18600885289', '18600885273', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100679', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼678', '无678', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('695', '1', '百会678', '罗晓丽678', '研发中心18', '软件工程师18', '362350061@qq.com665', '18600885272', '18600885288', '18600885272', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100678', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼677', '无677', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('696', '1', '百会677', '罗晓丽677', '研发中心17', '软件工程师17', '362350061@qq.com664', '18600885271', '18600885287', '18600885271', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100677', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼676', '无676', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('697', '1', '百会676', '罗晓丽676', '研发中心16', '软件工程师16', '362350061@qq.com663', '18600885270', '18600885286', '18600885270', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100676', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼675', '无675', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('698', '1', '百会675', '罗晓丽675', '研发中心15', '软件工程师15', '362350061@qq.com662', '18600885269', '18600885285', '18600885269', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100675', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼674', '无674', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('699', '1', '百会674', '罗晓丽674', '研发中心14', '软件工程师14', '362350061@qq.com661', '18600885268', '18600885284', '18600885268', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100674', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼673', '无673', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('700', '1', '百会673', '罗晓丽673', '研发中心13', '软件工程师13', '362350061@qq.com660', '18600885267', '18600885283', '18600885267', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100673', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼672', '无672', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('701', '1', '百会672', '罗晓丽672', '研发中心12', '软件工程师12', '362350061@qq.com659', '18600885266', '18600885282', '18600885266', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100672', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼671', '无671', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('702', '1', '百会671', '罗晓丽671', '研发中心11', '软件工程师11', '362350061@qq.com658', '18600885265', '18600885281', '18600885265', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100671', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼670', '无670', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('703', '1', '百会701', '罗晓丽701', '研发中心1', '软件工程师1', '362350061@qq.com688', '18600885295', '18600885311', '18600885295', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100701', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼700', '无700', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('704', '1', '百会702', '罗晓丽702', '研发中心2', '软件工程师2', '362350061@qq.com689', '18600885296', '18600885312', '18600885296', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100702', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼701', '无701', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('705', '1', '百会699', '罗晓丽699', '研发中心19', '软件工程师19', '362350061@qq.com686', '18600885293', '18600885309', '18600885293', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100699', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼698', '无698', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('706', '1', '百会700', '罗晓丽700', '研发中心19', '软件工程师19', '362350061@qq.com687', '18600885294', '18600885310', '18600885294', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100700', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼699', '无699', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('707', '1', '百会697', '罗晓丽697', '研发中心17', '软件工程师17', '362350061@qq.com684', '18600885291', '18600885307', '18600885291', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100697', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼696', '无696', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('708', '1', '百会698', '罗晓丽698', '研发中心18', '软件工程师18', '362350061@qq.com685', '18600885292', '18600885308', '18600885292', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100698', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼697', '无697', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('709', '1', '百会695', '罗晓丽695', '研发中心15', '软件工程师15', '362350061@qq.com682', '18600885289', '18600885305', '18600885289', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100695', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼694', '无694', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('710', '1', '百会696', '罗晓丽696', '研发中心16', '软件工程师16', '362350061@qq.com683', '18600885290', '18600885306', '18600885290', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100696', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼695', '无695', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('711', '1', '百会693', '罗晓丽693', '研发中心13', '软件工程师13', '362350061@qq.com680', '18600885287', '18600885303', '18600885287', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100693', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼692', '无692', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('712', '1', '百会694', '罗晓丽694', '研发中心14', '软件工程师14', '362350061@qq.com681', '18600885288', '18600885304', '18600885288', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100694', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼693', '无693', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('713', '1', '百会691', '罗晓丽691', '研发中心11', '软件工程师11', '362350061@qq.com678', '18600885285', '18600885301', '18600885285', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100691', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼690', '无690', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('714', '1', '百会692', '罗晓丽692', '研发中心12', '软件工程师12', '362350061@qq.com679', '18600885286', '18600885302', '18600885286', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100692', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼691', '无691', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('715', '1', '百会689', '罗晓丽689', '研发中心9', '软件工程师9', '362350061@qq.com676', '18600885283', '18600885299', '18600885283', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100689', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼688', '无688', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('716', '1', '百会690', '罗晓丽690', '研发中心10', '软件工程师10', '362350061@qq.com677', '18600885284', '18600885300', '18600885284', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100690', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼689', '无689', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('717', '1', '百会687', '罗晓丽687', '研发中心7', '软件工程师7', '362350061@qq.com674', '18600885281', '18600885297', '18600885281', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100687', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼686', '无686', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('718', '1', '百会688', '罗晓丽688', '研发中心8', '软件工程师8', '362350061@qq.com675', '18600885282', '18600885298', '18600885282', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100688', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼687', '无687', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('719', '1', '百会652', '罗晓丽652', '研发中心12', '软件工程师12', '362350061@qq.com639', '18600885246', '18600885262', '18600885246', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100652', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼651', '无651', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('720', '1', '百会654', '罗晓丽654', '研发中心14', '软件工程师14', '362350061@qq.com641', '18600885248', '18600885264', '18600885248', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100654', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼653', '无653', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('721', '1', '百会653', '罗晓丽653', '研发中心13', '软件工程师13', '362350061@qq.com640', '18600885247', '18600885263', '18600885247', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100653', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼652', '无652', '0', '1', '2014-07-21 16:26:29', '1', '2014-07-21 16:26:29', null);
INSERT INTO `lead` VALUES ('722', '1', '百会648', '罗晓丽648', '研发中心8', '软件工程师8', '362350061@qq.com635', '18600885242', '18600885258', '18600885242', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100648', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼647', '无647', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('723', '1', '百会647', '罗晓丽647', '研发中心7', '软件工程师7', '362350061@qq.com634', '18600885241', '18600885257', '18600885241', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100647', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼646', '无646', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('724', '1', '百会650', '罗晓丽650', '研发中心10', '软件工程师10', '362350061@qq.com637', '18600885244', '18600885260', '18600885244', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100650', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼649', '无649', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('725', '1', '百会649', '罗晓丽649', '研发中心9', '软件工程师9', '362350061@qq.com636', '18600885243', '18600885259', '18600885243', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100649', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼648', '无648', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('726', '1', '百会643', '罗晓丽643', '研发中心3', '软件工程师3', '362350061@qq.com630', '18600885237', '18600885253', '18600885237', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100643', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼642', '无642', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('727', '1', '百会646', '罗晓丽646', '研发中心6', '软件工程师6', '362350061@qq.com633', '18600885240', '18600885256', '18600885240', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100646', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼645', '无645', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('728', '1', '百会645', '罗晓丽645', '研发中心5', '软件工程师5', '362350061@qq.com632', '18600885239', '18600885255', '18600885239', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100645', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼644', '无644', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('729', '1', '百会640', '罗晓丽640', '研发中心19', '软件工程师19', '362350061@qq.com627', '18600885234', '18600885250', '18600885234', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100640', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼639', '无639', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('730', '1', '百会639', '罗晓丽639', '研发中心19', '软件工程师19', '362350061@qq.com626', '18600885233', '18600885249', '18600885233', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100639', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼638', '无638', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('731', '1', '百会642', '罗晓丽642', '研发中心2', '软件工程师2', '362350061@qq.com629', '18600885236', '18600885252', '18600885236', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100642', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼641', '无641', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('732', '1', '百会641', '罗晓丽641', '研发中心1', '软件工程师1', '362350061@qq.com628', '18600885235', '18600885251', '18600885235', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100641', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼640', '无640', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('733', '1', '百会667', '罗晓丽667', '研发中心7', '软件工程师7', '362350061@qq.com654', '18600885261', '18600885277', '18600885261', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100667', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼666', '无666', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('734', '1', '百会669', '罗晓丽669', '研发中心9', '软件工程师9', '362350061@qq.com656', '18600885263', '18600885279', '18600885263', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100669', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼668', '无668', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('735', '1', '百会670', '罗晓丽670', '研发中心10', '软件工程师10', '362350061@qq.com657', '18600885264', '18600885280', '18600885264', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100670', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼669', '无669', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('736', '1', '百会663', '罗晓丽663', '研发中心3', '软件工程师3', '362350061@qq.com650', '18600885257', '18600885273', '18600885257', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100663', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼662', '无662', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('737', '1', '百会664', '罗晓丽664', '研发中心4', '软件工程师4', '362350061@qq.com651', '18600885258', '18600885274', '18600885258', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100664', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼663', '无663', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('738', '1', '百会665', '罗晓丽665', '研发中心5', '软件工程师5', '362350061@qq.com652', '18600885259', '18600885275', '18600885259', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100665', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼664', '无664', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('739', '1', '百会666', '罗晓丽666', '研发中心6', '软件工程师6', '362350061@qq.com653', '18600885260', '18600885276', '18600885260', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100666', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼665', '无665', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('740', '1', '百会659', '罗晓丽659', '研发中心19', '软件工程师19', '362350061@qq.com646', '18600885253', '18600885269', '18600885253', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100659', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼658', '无658', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('741', '1', '百会660', '罗晓丽660', '研发中心19', '软件工程师19', '362350061@qq.com647', '18600885254', '18600885270', '18600885254', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100660', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼659', '无659', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('742', '1', '百会661', '罗晓丽661', '研发中心1', '软件工程师1', '362350061@qq.com648', '18600885255', '18600885271', '18600885255', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100661', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼660', '无660', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('743', '1', '百会662', '罗晓丽662', '研发中心2', '软件工程师2', '362350061@qq.com649', '18600885256', '18600885272', '18600885256', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100662', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼661', '无661', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('744', '1', '百会655', '罗晓丽655', '研发中心15', '软件工程师15', '362350061@qq.com642', '18600885249', '18600885265', '18600885249', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100655', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼654', '无654', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('745', '1', '百会656', '罗晓丽656', '研发中心16', '软件工程师16', '362350061@qq.com643', '18600885250', '18600885266', '18600885250', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100656', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼655', '无655', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('746', '1', '百会657', '罗晓丽657', '研发中心17', '软件工程师17', '362350061@qq.com644', '18600885251', '18600885267', '18600885251', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100657', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼656', '无656', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('747', '1', '百会658', '罗晓丽658', '研发中心18', '软件工程师18', '362350061@qq.com645', '18600885252', '18600885268', '18600885252', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100658', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼657', '无657', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('748', '1', '百会746', '罗晓丽746', '研发中心6', '软件工程师6', '362350061@qq.com733', '18600885340', '18600885356', '18600885340', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100746', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼745', '无745', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('749', '1', '百会745', '罗晓丽745', '研发中心5', '软件工程师5', '362350061@qq.com732', '18600885339', '18600885355', '18600885339', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100745', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼744', '无744', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('750', '1', '百会744', '罗晓丽744', '研发中心4', '软件工程师4', '362350061@qq.com731', '18600885338', '18600885354', '18600885338', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100744', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼743', '无743', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('751', '1', '百会743', '罗晓丽743', '研发中心3', '软件工程师3', '362350061@qq.com730', '18600885337', '18600885353', '18600885337', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100743', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼742', '无742', '0', '1', '2014-07-21 16:26:30', '1', '2014-07-21 16:26:30', null);
INSERT INTO `lead` VALUES ('752', '1', '百会750', '罗晓丽750', '研发中心10', '软件工程师10', '362350061@qq.com737', '18600885344', '18600885360', '18600885344', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100750', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼749', '无749', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('753', '1', '百会749', '罗晓丽749', '研发中心9', '软件工程师9', '362350061@qq.com736', '18600885343', '18600885359', '18600885343', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100749', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼748', '无748', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('754', '1', '百会748', '罗晓丽748', '研发中心8', '软件工程师8', '362350061@qq.com735', '18600885342', '18600885358', '18600885342', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100748', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼747', '无747', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('755', '1', '百会747', '罗晓丽747', '研发中心7', '软件工程师7', '362350061@qq.com734', '18600885341', '18600885357', '18600885341', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100747', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼746', '无746', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('756', '1', '百会738', '罗晓丽738', '研发中心18', '软件工程师18', '362350061@qq.com725', '18600885332', '18600885348', '18600885332', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100738', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼737', '无737', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('757', '1', '百会737', '罗晓丽737', '研发中心17', '软件工程师17', '362350061@qq.com724', '18600885331', '18600885347', '18600885331', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100737', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼736', '无736', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('758', '1', '百会736', '罗晓丽736', '研发中心16', '软件工程师16', '362350061@qq.com723', '18600885330', '18600885346', '18600885330', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100736', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼735', '无735', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('759', '1', '百会735', '罗晓丽735', '研发中心15', '软件工程师15', '362350061@qq.com722', '18600885329', '18600885345', '18600885329', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100735', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼734', '无734', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('760', '1', '百会742', '罗晓丽742', '研发中心2', '软件工程师2', '362350061@qq.com729', '18600885336', '18600885352', '18600885336', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100742', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼741', '无741', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('761', '1', '百会741', '罗晓丽741', '研发中心1', '软件工程师1', '362350061@qq.com728', '18600885335', '18600885351', '18600885335', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100741', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼740', '无740', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('762', '1', '百会740', '罗晓丽740', '研发中心19', '软件工程师19', '362350061@qq.com727', '18600885334', '18600885350', '18600885334', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100740', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼739', '无739', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('763', '1', '百会739', '罗晓丽739', '研发中心19', '软件工程师19', '362350061@qq.com726', '18600885333', '18600885349', '18600885333', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100739', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼738', '无738', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('764', '1', '百会753', '罗晓丽753', '研发中心13', '软件工程师13', '362350061@qq.com740', '18600885347', '18600885363', '18600885347', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100753', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼752', '无752', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('765', '1', '百会751', '罗晓丽751', '研发中心11', '软件工程师11', '362350061@qq.com738', '18600885345', '18600885361', '18600885345', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100751', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼750', '无750', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('766', '1', '百会752', '罗晓丽752', '研发中心12', '软件工程师12', '362350061@qq.com739', '18600885346', '18600885362', '18600885346', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100752', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼751', '无751', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('767', '1', '百会712', '罗晓丽712', '研发中心12', '软件工程师12', '362350061@qq.com699', '18600885306', '18600885322', '18600885306', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100712', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼711', '无711', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('768', '1', '百会711', '罗晓丽711', '研发中心11', '软件工程师11', '362350061@qq.com698', '18600885305', '18600885321', '18600885305', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100711', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼710', '无710', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('769', '1', '百会714', '罗晓丽714', '研发中心14', '软件工程师14', '362350061@qq.com701', '18600885308', '18600885324', '18600885308', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100714', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼713', '无713', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('770', '1', '百会713', '罗晓丽713', '研发中心13', '软件工程师13', '362350061@qq.com700', '18600885307', '18600885323', '18600885307', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100713', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼712', '无712', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('771', '1', '百会716', '罗晓丽716', '研发中心16', '软件工程师16', '362350061@qq.com703', '18600885310', '18600885326', '18600885310', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100716', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼715', '无715', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('772', '1', '百会715', '罗晓丽715', '研发中心15', '软件工程师15', '362350061@qq.com702', '18600885309', '18600885325', '18600885309', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100715', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼714', '无714', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('773', '1', '百会718', '罗晓丽718', '研发中心18', '软件工程师18', '362350061@qq.com705', '18600885312', '18600885328', '18600885312', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100718', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼717', '无717', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('774', '1', '百会717', '罗晓丽717', '研发中心17', '软件工程师17', '362350061@qq.com704', '18600885311', '18600885327', '18600885311', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100717', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼716', '无716', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('775', '1', '百会704', '罗晓丽704', '研发中心4', '软件工程师4', '362350061@qq.com691', '18600885298', '18600885314', '18600885298', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100704', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼703', '无703', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('776', '1', '百会703', '罗晓丽703', '研发中心3', '软件工程师3', '362350061@qq.com690', '18600885297', '18600885313', '18600885297', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100703', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼702', '无702', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('777', '1', '百会706', '罗晓丽706', '研发中心6', '软件工程师6', '362350061@qq.com693', '18600885300', '18600885316', '18600885300', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100706', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼705', '无705', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('778', '1', '百会705', '罗晓丽705', '研发中心5', '软件工程师5', '362350061@qq.com692', '18600885299', '18600885315', '18600885299', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100705', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼704', '无704', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('779', '1', '百会708', '罗晓丽708', '研发中心8', '软件工程师8', '362350061@qq.com695', '18600885302', '18600885318', '18600885302', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100708', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼707', '无707', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:31', null);
INSERT INTO `lead` VALUES ('780', '1', '百会707', '罗晓丽707', '研发中心7', '软件工程师7', '362350061@qq.com694', '18600885301', '18600885317', '18600885301', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100707', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼706', '无706', '0', '1', '2014-07-21 16:26:31', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('781', '1', '百会710', '罗晓丽710', '研发中心10', '软件工程师10', '362350061@qq.com697', '18600885304', '18600885320', '18600885304', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100710', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼709', '无709', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('782', '1', '百会709', '罗晓丽709', '研发中心9', '软件工程师9', '362350061@qq.com696', '18600885303', '18600885319', '18600885303', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100709', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼708', '无708', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('783', '1', '百会727', '罗晓丽727', '研发中心7', '软件工程师7', '362350061@qq.com714', '18600885321', '18600885337', '18600885321', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100727', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼726', '无726', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('784', '1', '百会728', '罗晓丽728', '研发中心8', '软件工程师8', '362350061@qq.com715', '18600885322', '18600885338', '18600885322', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100728', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼727', '无727', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('785', '1', '百会729', '罗晓丽729', '研发中心9', '软件工程师9', '362350061@qq.com716', '18600885323', '18600885339', '18600885323', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100729', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼728', '无728', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('786', '1', '百会730', '罗晓丽730', '研发中心10', '软件工程师10', '362350061@qq.com717', '18600885324', '18600885340', '18600885324', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100730', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼729', '无729', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('787', '1', '百会731', '罗晓丽731', '研发中心11', '软件工程师11', '362350061@qq.com718', '18600885325', '18600885341', '18600885325', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100731', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼730', '无730', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('788', '1', '百会732', '罗晓丽732', '研发中心12', '软件工程师12', '362350061@qq.com719', '18600885326', '18600885342', '18600885326', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100732', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼731', '无731', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('789', '1', '百会733', '罗晓丽733', '研发中心13', '软件工程师13', '362350061@qq.com720', '18600885327', '18600885343', '18600885327', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100733', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼732', '无732', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('790', '1', '百会734', '罗晓丽734', '研发中心14', '软件工程师14', '362350061@qq.com721', '18600885328', '18600885344', '18600885328', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100734', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼733', '无733', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('791', '1', '百会719', '罗晓丽719', '研发中心19', '软件工程师19', '362350061@qq.com706', '18600885313', '18600885329', '18600885313', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100719', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼718', '无718', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('792', '1', '百会720', '罗晓丽720', '研发中心19', '软件工程师19', '362350061@qq.com707', '18600885314', '18600885330', '18600885314', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100720', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼719', '无719', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('793', '1', '百会721', '罗晓丽721', '研发中心1', '软件工程师1', '362350061@qq.com708', '18600885315', '18600885331', '18600885315', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100721', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼720', '无720', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('794', '1', '百会722', '罗晓丽722', '研发中心2', '软件工程师2', '362350061@qq.com709', '18600885316', '18600885332', '18600885316', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100722', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼721', '无721', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('795', '1', '百会723', '罗晓丽723', '研发中心3', '软件工程师3', '362350061@qq.com710', '18600885317', '18600885333', '18600885317', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100723', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼722', '无722', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('796', '1', '百会724', '罗晓丽724', '研发中心4', '软件工程师4', '362350061@qq.com711', '18600885318', '18600885334', '18600885318', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100724', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼723', '无723', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('797', '1', '百会725', '罗晓丽725', '研发中心5', '软件工程师5', '362350061@qq.com712', '18600885319', '18600885335', '18600885319', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100725', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼724', '无724', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('798', '1', '百会726', '罗晓丽726', '研发中心6', '软件工程师6', '362350061@qq.com713', '18600885320', '18600885336', '18600885320', '4010101', '4010201', '4010301', '1011400250354140', '4030501', '100726', '110000', '110000', '110108', '花园北路14号环星大厦D座二楼725', '无725', '0', '1', '2014-07-21 16:26:32', '1', '2014-07-21 16:26:32', null);
INSERT INTO `lead` VALUES ('799', '6', '56', 'liulan ', '', '', '', '', '', '', '4010101', '4010201', '4010301', '', '4030501', '', null, null, null, '', 'liulan ', '0', '1', '2014-07-21 18:21:09', '1', '2014-07-21 18:23:55', null);
INSERT INTO `lead` VALUES ('800', '6', '', '12345678', '', '', '', '', '', '', '4010101', '4010201', '4010301', '', '4030501', '', null, null, null, '', '', '0', '1', '2014-07-21 18:18:03', '1', '2014-07-21 18:26:07', null);
INSERT INTO `market_activity` VALUES ('1', '测试', '3010102', '3010201', '2014-07-21 00:00:00', '2014-07-21 00:00:00', '0.0000', '0.0000', '1', '多来人', '50.00', '1', '1', '爱仕达', '0', '1', '2014-07-21 15:38:44', '1', '2014-07-21 15:38:10');
INSERT INTO `memoir` VALUES ('1', '11010102', '2', '1', '1', '联系纪要', '2014-07-15 00:00:00', '联系要点', '', '0', '1', '2014-07-14 16:09:13', '1', '2014-07-14 16:09:13');
INSERT INTO `memoir` VALUES ('2', '11010102', '2', '1', '1', '联系纪要', '2014-07-25 00:00:00', '联系要点', '', '0', '1', '2014-07-14 16:09:53', '1', '2014-07-14 16:09:53');
INSERT INTO `memoir` VALUES ('3', '11010102', '8', '1', '1', '萨乌丁', '2014-07-17 00:00:00', '上午', '', '0', '1', '2014-07-16 10:30:27', '1', '2014-07-16 10:30:27');
INSERT INTO `memoir` VALUES ('4', '11010102', '3', '1', '1', 'sa', '2014-07-19 00:00:00', 'as', 'sa', '0', '1', '2014-07-18 18:00:34', '1', '2014-07-18 18:00:34');
INSERT INTO `notice` VALUES ('0001', '222', '222\n2\n2\n2\n2\ndd', '2014-07-01 11:26:00', '2014-07-31 00:17:00', '0', '1', '2014-07-14 15:58:39', '1', '2014-07-14 15:59:08');
INSERT INTO `notice` VALUES ('0002', '让我', '方法\n\n说明\n\nRestrictions.eq\n\n＝\n\nRestrictions.allEq方法\n\n说明\n\nRestrictions.eq\n\n＝\n\nRestrictions.allEq\n\n利用Map来进行多个等于的限制\n\nRestrictions.gt\n\n＞\n\nRestrictions.ge\n\n＞＝\n\nRestrictions.lt\n\n＜\n\nRes\n\n利用Map来进行多个等于的限制\n\nRestrictions.gt\n\n＞\n\nRestrictions.ge\n\n＞＝\n\nRestrictions.lt\n\n＜\n\nRestrictions.le\n\n＜＝\n\nRestrictions.between\n\nBETWEEN\n\nRestrictions.like\n\nLIKE\n\nRestrictions.in\n\nin\n\nRestrictions.and\n\nand\n\nRestrictions.or\n\nor\n\nRestrictions.sqlRestriction\n\n用SQL限定查询\n\n有空再添加上，代码示例。', '2014-07-14 00:00:00', '2014-07-29 05:00:00', '0', '1', '2014-07-14 16:32:51', '1', '2014-07-16 10:31:42');
INSERT INTO `notice` VALUES ('0003', '发布公告', '发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告发布公告！', '2014-07-09 00:00:00', '2014-07-18 00:00:00', '0', '1', '2014-07-16 17:40:43', '1', '2014-07-16 17:40:43');
INSERT INTO `notice` VALUES ('0004', '23456', '23456', '2014-07-04 09:14:00', '2014-07-31 12:41:00', '0', '1', '2014-07-16 17:41:33', '15', '2014-07-21 16:47:11');
INSERT INTO `notice` VALUES ('0005', '公告', '235', '2014-07-17 00:00:00', '2014-07-27 00:00:00', '0', '1', '2014-07-16 17:43:20', '1', '2014-07-16 17:43:20');
INSERT INTO `notice` VALUES ('0006', '好好好', '你好', '2014-07-16 08:20:00', '2014-07-27 08:42:00', '0', '1', '2014-07-16 17:55:13', '15', '2014-07-21 16:46:22');
INSERT INTO `notice` VALUES ('0007', '我的公告', '我的公告', '2014-07-19 00:00:00', '2014-07-26 00:00:00', '0', '1', '2014-07-16 17:57:00', '1', '2014-07-16 17:57:00');
INSERT INTO `notice` VALUES ('0008', '我的', '我', '2014-07-25 00:00:00', '2014-07-31 00:00:00', '0', '1', '2014-07-16 17:57:19', '1', '2014-07-16 17:57:19');
INSERT INTO `notice` VALUES ('0009', '你好', '你好', '2014-07-21 10:43:00', '2014-07-21 10:53:00', '0', '1', '2014-07-21 10:41:17', '1', '2014-07-21 10:42:44');
INSERT INTO `notice` VALUES ('0010', '今天开会', '今天在开会', '2014-07-21 10:44:00', '2014-07-21 13:34:00', '0', '1', '2014-07-21 10:44:16', '1', '2014-07-21 10:44:16');
INSERT INTO `notice` VALUES ('0011', '所得税', '收到', '2014-07-14 06:18:00', '2014-07-31 05:25:00', '0', '15', '2014-07-21 16:45:55', '15', '2014-07-21 16:45:55');
INSERT INTO `order` VALUES ('1', '1', '7', '140714DQYT001', '8', '6010102', '10000.0000', '10', '10', 'A+A*(b-A*b1-b2-b3)', '13', '1', '1', '2014-07-15 00:00:00', '', '0', '1', '2014-07-14 19:36:44', '1', '2014-07-22 14:04:59');
INSERT INTO `order` VALUES ('2', '1', '2', '123456', null, '6010101', '10.8000', '10', '10', '1*7', '13', '1', '3', '2014-07-09 00:00:00', '', '1', '1', '2014-07-16 13:42:30', '1', '2014-07-22 13:48:29');
INSERT INTO `order` VALUES ('3', '1', '3', '还不考虑看见了分公司的飞', null, '6010101', '123.0000', '10', '12', 'A+A*(b-A*b1-b2-b3)', '13', '1', '5', '2014-07-11 00:00:00', '', '1', '1', '2014-07-16 16:43:40', '1', '2014-07-22 13:48:36');
INSERT INTO `pro_city_area` VALUES ('0', ' 未知', null);
INSERT INTO `pro_city_area` VALUES ('110000', '北京市', '0');
INSERT INTO `pro_city_area` VALUES ('110100', '北京市', '110000');
INSERT INTO `pro_city_area` VALUES ('110101', '东城区', '110100');
INSERT INTO `pro_city_area` VALUES ('110102', '西城区', '110100');
INSERT INTO `pro_city_area` VALUES ('110103', '崇文区', '110100');
INSERT INTO `pro_city_area` VALUES ('110104', '宣武区', '110100');
INSERT INTO `pro_city_area` VALUES ('110105', '朝阳区', '110100');
INSERT INTO `pro_city_area` VALUES ('110106', '丰台区', '110100');
INSERT INTO `pro_city_area` VALUES ('110107', '石景山区', '110100');
INSERT INTO `pro_city_area` VALUES ('110108', '海淀区', '110100');
INSERT INTO `pro_city_area` VALUES ('110109', '门头沟区', '110100');
INSERT INTO `pro_city_area` VALUES ('110111', '房山区', '110100');
INSERT INTO `pro_city_area` VALUES ('110112', '通州区', '110100');
INSERT INTO `pro_city_area` VALUES ('110113', '顺义区', '110100');
INSERT INTO `pro_city_area` VALUES ('110114', '昌平区', '110100');
INSERT INTO `pro_city_area` VALUES ('110115', '大兴区', '110100');
INSERT INTO `pro_city_area` VALUES ('110116', '怀柔区', '110100');
INSERT INTO `pro_city_area` VALUES ('110117', '平谷区', '110100');
INSERT INTO `pro_city_area` VALUES ('110228', '密云县', '110200');
INSERT INTO `pro_city_area` VALUES ('110229', '延庆县', '110200');
INSERT INTO `pro_city_area` VALUES ('120000', '天津市', '0');
INSERT INTO `pro_city_area` VALUES ('120100', '天津市', '120000');
INSERT INTO `pro_city_area` VALUES ('120101', '和平区', '120100');
INSERT INTO `pro_city_area` VALUES ('120102', '河东区', '120100');
INSERT INTO `pro_city_area` VALUES ('120103', '河西区', '120100');
INSERT INTO `pro_city_area` VALUES ('120104', '南开区', '120100');
INSERT INTO `pro_city_area` VALUES ('120105', '河北区', '120100');
INSERT INTO `pro_city_area` VALUES ('120106', '红桥区', '120100');
INSERT INTO `pro_city_area` VALUES ('120107', '塘沽区', '120100');
INSERT INTO `pro_city_area` VALUES ('120108', '汉沽区', '120100');
INSERT INTO `pro_city_area` VALUES ('120109', '大港区', '120100');
INSERT INTO `pro_city_area` VALUES ('120110', '东丽区', '120100');
INSERT INTO `pro_city_area` VALUES ('120111', '西青区', '120100');
INSERT INTO `pro_city_area` VALUES ('120112', '津南区', '120100');
INSERT INTO `pro_city_area` VALUES ('120113', '北辰区', '120100');
INSERT INTO `pro_city_area` VALUES ('120114', '武清区', '120100');
INSERT INTO `pro_city_area` VALUES ('120115', '宝坻区', '120100');
INSERT INTO `pro_city_area` VALUES ('120221', '宁河县', '120200');
INSERT INTO `pro_city_area` VALUES ('120223', '静海县', '120200');
INSERT INTO `pro_city_area` VALUES ('120225', '蓟　县', '120200');
INSERT INTO `pro_city_area` VALUES ('130000', '河北省', '0');
INSERT INTO `pro_city_area` VALUES ('130100', '石家庄市', '130000');
INSERT INTO `pro_city_area` VALUES ('130101', '市辖区', '130100');
INSERT INTO `pro_city_area` VALUES ('130102', '长安区', '130100');
INSERT INTO `pro_city_area` VALUES ('130103', '桥东区', '130100');
INSERT INTO `pro_city_area` VALUES ('130104', '桥西区', '130100');
INSERT INTO `pro_city_area` VALUES ('130105', '新华区', '130100');
INSERT INTO `pro_city_area` VALUES ('130107', '井陉矿区', '130100');
INSERT INTO `pro_city_area` VALUES ('130108', '裕华区', '130100');
INSERT INTO `pro_city_area` VALUES ('130121', '井陉县', '130100');
INSERT INTO `pro_city_area` VALUES ('130123', '正定县', '130100');
INSERT INTO `pro_city_area` VALUES ('130124', '栾城县', '130100');
INSERT INTO `pro_city_area` VALUES ('130125', '行唐县', '130100');
INSERT INTO `pro_city_area` VALUES ('130126', '灵寿县', '130100');
INSERT INTO `pro_city_area` VALUES ('130127', '高邑县', '130100');
INSERT INTO `pro_city_area` VALUES ('130128', '深泽县', '130100');
INSERT INTO `pro_city_area` VALUES ('130129', '赞皇县', '130100');
INSERT INTO `pro_city_area` VALUES ('130130', '无极县', '130100');
INSERT INTO `pro_city_area` VALUES ('130131', '平山县', '130100');
INSERT INTO `pro_city_area` VALUES ('130132', '元氏县', '130100');
INSERT INTO `pro_city_area` VALUES ('130133', '赵　县', '130100');
INSERT INTO `pro_city_area` VALUES ('130181', '辛集市', '130100');
INSERT INTO `pro_city_area` VALUES ('130182', '藁城市', '130100');
INSERT INTO `pro_city_area` VALUES ('130183', '晋州市', '130100');
INSERT INTO `pro_city_area` VALUES ('130184', '新乐市', '130100');
INSERT INTO `pro_city_area` VALUES ('130185', '鹿泉市', '130100');
INSERT INTO `pro_city_area` VALUES ('130200', '唐山市', '130000');
INSERT INTO `pro_city_area` VALUES ('130201', '市辖区', '130200');
INSERT INTO `pro_city_area` VALUES ('130202', '路南区', '130200');
INSERT INTO `pro_city_area` VALUES ('130203', '路北区', '130200');
INSERT INTO `pro_city_area` VALUES ('130204', '古冶区', '130200');
INSERT INTO `pro_city_area` VALUES ('130205', '开平区', '130200');
INSERT INTO `pro_city_area` VALUES ('130207', '丰南区', '130200');
INSERT INTO `pro_city_area` VALUES ('130208', '丰润区', '130200');
INSERT INTO `pro_city_area` VALUES ('130223', '滦　县', '130200');
INSERT INTO `pro_city_area` VALUES ('130224', '滦南县', '130200');
INSERT INTO `pro_city_area` VALUES ('130225', '乐亭县', '130200');
INSERT INTO `pro_city_area` VALUES ('130227', '迁西县', '130200');
INSERT INTO `pro_city_area` VALUES ('130229', '玉田县', '130200');
INSERT INTO `pro_city_area` VALUES ('130230', '唐海县', '130200');
INSERT INTO `pro_city_area` VALUES ('130281', '遵化市', '130200');
INSERT INTO `pro_city_area` VALUES ('130283', '迁安市', '130200');
INSERT INTO `pro_city_area` VALUES ('130300', '秦皇岛市', '130000');
INSERT INTO `pro_city_area` VALUES ('130301', '市辖区', '130300');
INSERT INTO `pro_city_area` VALUES ('130302', '海港区', '130300');
INSERT INTO `pro_city_area` VALUES ('130303', '山海关区', '130300');
INSERT INTO `pro_city_area` VALUES ('130304', '北戴河区', '130300');
INSERT INTO `pro_city_area` VALUES ('130321', '青龙满族自治县', '130300');
INSERT INTO `pro_city_area` VALUES ('130322', '昌黎县', '130300');
INSERT INTO `pro_city_area` VALUES ('130323', '抚宁县', '130300');
INSERT INTO `pro_city_area` VALUES ('130324', '卢龙县', '130300');
INSERT INTO `pro_city_area` VALUES ('130400', '邯郸市', '130000');
INSERT INTO `pro_city_area` VALUES ('130401', '市辖区', '130400');
INSERT INTO `pro_city_area` VALUES ('130402', '邯山区', '130400');
INSERT INTO `pro_city_area` VALUES ('130403', '丛台区', '130400');
INSERT INTO `pro_city_area` VALUES ('130404', '复兴区', '130400');
INSERT INTO `pro_city_area` VALUES ('130406', '峰峰矿区', '130400');
INSERT INTO `pro_city_area` VALUES ('130421', '邯郸县', '130400');
INSERT INTO `pro_city_area` VALUES ('130423', '临漳县', '130400');
INSERT INTO `pro_city_area` VALUES ('130424', '成安县', '130400');
INSERT INTO `pro_city_area` VALUES ('130425', '大名县', '130400');
INSERT INTO `pro_city_area` VALUES ('130426', '涉　县', '130400');
INSERT INTO `pro_city_area` VALUES ('130427', '磁　县', '130400');
INSERT INTO `pro_city_area` VALUES ('130428', '肥乡县', '130400');
INSERT INTO `pro_city_area` VALUES ('130429', '永年县', '130400');
INSERT INTO `pro_city_area` VALUES ('130430', '邱　县', '130400');
INSERT INTO `pro_city_area` VALUES ('130431', '鸡泽县', '130400');
INSERT INTO `pro_city_area` VALUES ('130432', '广平县', '130400');
INSERT INTO `pro_city_area` VALUES ('130433', '馆陶县', '130400');
INSERT INTO `pro_city_area` VALUES ('130434', '魏　县', '130400');
INSERT INTO `pro_city_area` VALUES ('130435', '曲周县', '130400');
INSERT INTO `pro_city_area` VALUES ('130481', '武安市', '130400');
INSERT INTO `pro_city_area` VALUES ('130500', '邢台市', '130000');
INSERT INTO `pro_city_area` VALUES ('130501', '市辖区', '130500');
INSERT INTO `pro_city_area` VALUES ('130502', '桥东区', '130500');
INSERT INTO `pro_city_area` VALUES ('130503', '桥西区', '130500');
INSERT INTO `pro_city_area` VALUES ('130521', '邢台县', '130500');
INSERT INTO `pro_city_area` VALUES ('130522', '临城县', '130500');
INSERT INTO `pro_city_area` VALUES ('130523', '内丘县', '130500');
INSERT INTO `pro_city_area` VALUES ('130524', '柏乡县', '130500');
INSERT INTO `pro_city_area` VALUES ('130525', '隆尧县', '130500');
INSERT INTO `pro_city_area` VALUES ('130526', '任　县', '130500');
INSERT INTO `pro_city_area` VALUES ('130527', '南和县', '130500');
INSERT INTO `pro_city_area` VALUES ('130528', '宁晋县', '130500');
INSERT INTO `pro_city_area` VALUES ('130529', '巨鹿县', '130500');
INSERT INTO `pro_city_area` VALUES ('130530', '新河县', '130500');
INSERT INTO `pro_city_area` VALUES ('130531', '广宗县', '130500');
INSERT INTO `pro_city_area` VALUES ('130532', '平乡县', '130500');
INSERT INTO `pro_city_area` VALUES ('130533', '威　县', '130500');
INSERT INTO `pro_city_area` VALUES ('130534', '清河县', '130500');
INSERT INTO `pro_city_area` VALUES ('130535', '临西县', '130500');
INSERT INTO `pro_city_area` VALUES ('130581', '南宫市', '130500');
INSERT INTO `pro_city_area` VALUES ('130582', '沙河市', '130500');
INSERT INTO `pro_city_area` VALUES ('130600', '保定市', '130000');
INSERT INTO `pro_city_area` VALUES ('130601', '市辖区', '130600');
INSERT INTO `pro_city_area` VALUES ('130602', '新市区', '130600');
INSERT INTO `pro_city_area` VALUES ('130603', '北市区', '130600');
INSERT INTO `pro_city_area` VALUES ('130604', '南市区', '130600');
INSERT INTO `pro_city_area` VALUES ('130621', '满城县', '130600');
INSERT INTO `pro_city_area` VALUES ('130622', '清苑县', '130600');
INSERT INTO `pro_city_area` VALUES ('130623', '涞水县', '130600');
INSERT INTO `pro_city_area` VALUES ('130624', '阜平县', '130600');
INSERT INTO `pro_city_area` VALUES ('130625', '徐水县', '130600');
INSERT INTO `pro_city_area` VALUES ('130626', '定兴县', '130600');
INSERT INTO `pro_city_area` VALUES ('130627', '唐　县', '130600');
INSERT INTO `pro_city_area` VALUES ('130628', '高阳县', '130600');
INSERT INTO `pro_city_area` VALUES ('130629', '容城县', '130600');
INSERT INTO `pro_city_area` VALUES ('130630', '涞源县', '130600');
INSERT INTO `pro_city_area` VALUES ('130631', '望都县', '130600');
INSERT INTO `pro_city_area` VALUES ('130632', '安新县', '130600');
INSERT INTO `pro_city_area` VALUES ('130633', '易　县', '130600');
INSERT INTO `pro_city_area` VALUES ('130634', '曲阳县', '130600');
INSERT INTO `pro_city_area` VALUES ('130635', '蠡　县', '130600');
INSERT INTO `pro_city_area` VALUES ('130636', '顺平县', '130600');
INSERT INTO `pro_city_area` VALUES ('130637', '博野县', '130600');
INSERT INTO `pro_city_area` VALUES ('130638', '雄　县', '130600');
INSERT INTO `pro_city_area` VALUES ('130681', '涿州市', '130600');
INSERT INTO `pro_city_area` VALUES ('130682', '定州市', '130600');
INSERT INTO `pro_city_area` VALUES ('130683', '安国市', '130600');
INSERT INTO `pro_city_area` VALUES ('130684', '高碑店市', '130600');
INSERT INTO `pro_city_area` VALUES ('130700', '张家口市', '130000');
INSERT INTO `pro_city_area` VALUES ('130701', '市辖区', '130700');
INSERT INTO `pro_city_area` VALUES ('130702', '桥东区', '130700');
INSERT INTO `pro_city_area` VALUES ('130703', '桥西区', '130700');
INSERT INTO `pro_city_area` VALUES ('130705', '宣化区', '130700');
INSERT INTO `pro_city_area` VALUES ('130706', '下花园区', '130700');
INSERT INTO `pro_city_area` VALUES ('130721', '宣化县', '130700');
INSERT INTO `pro_city_area` VALUES ('130722', '张北县', '130700');
INSERT INTO `pro_city_area` VALUES ('130723', '康保县', '130700');
INSERT INTO `pro_city_area` VALUES ('130724', '沽源县', '130700');
INSERT INTO `pro_city_area` VALUES ('130725', '尚义县', '130700');
INSERT INTO `pro_city_area` VALUES ('130726', '蔚　县', '130700');
INSERT INTO `pro_city_area` VALUES ('130727', '阳原县', '130700');
INSERT INTO `pro_city_area` VALUES ('130728', '怀安县', '130700');
INSERT INTO `pro_city_area` VALUES ('130729', '万全县', '130700');
INSERT INTO `pro_city_area` VALUES ('130730', '怀来县', '130700');
INSERT INTO `pro_city_area` VALUES ('130731', '涿鹿县', '130700');
INSERT INTO `pro_city_area` VALUES ('130732', '赤城县', '130700');
INSERT INTO `pro_city_area` VALUES ('130733', '崇礼县', '130700');
INSERT INTO `pro_city_area` VALUES ('130800', '承德市', '130000');
INSERT INTO `pro_city_area` VALUES ('130801', '市辖区', '130800');
INSERT INTO `pro_city_area` VALUES ('130802', '双桥区', '130800');
INSERT INTO `pro_city_area` VALUES ('130803', '双滦区', '130800');
INSERT INTO `pro_city_area` VALUES ('130804', '鹰手营子矿区', '130800');
INSERT INTO `pro_city_area` VALUES ('130821', '承德县', '130800');
INSERT INTO `pro_city_area` VALUES ('130822', '兴隆县', '130800');
INSERT INTO `pro_city_area` VALUES ('130823', '平泉县', '130800');
INSERT INTO `pro_city_area` VALUES ('130824', '滦平县', '130800');
INSERT INTO `pro_city_area` VALUES ('130825', '隆化县', '130800');
INSERT INTO `pro_city_area` VALUES ('130826', '丰宁满族自治县', '130800');
INSERT INTO `pro_city_area` VALUES ('130827', '宽城满族自治县', '130800');
INSERT INTO `pro_city_area` VALUES ('130828', '围场满族蒙古族自治县', '130800');
INSERT INTO `pro_city_area` VALUES ('130900', '沧州市', '130000');
INSERT INTO `pro_city_area` VALUES ('130901', '市辖区', '130900');
INSERT INTO `pro_city_area` VALUES ('130902', '新华区', '130900');
INSERT INTO `pro_city_area` VALUES ('130903', '运河区', '130900');
INSERT INTO `pro_city_area` VALUES ('130921', '沧　县', '130900');
INSERT INTO `pro_city_area` VALUES ('130922', '青　县', '130900');
INSERT INTO `pro_city_area` VALUES ('130923', '东光县', '130900');
INSERT INTO `pro_city_area` VALUES ('130924', '海兴县', '130900');
INSERT INTO `pro_city_area` VALUES ('130925', '盐山县', '130900');
INSERT INTO `pro_city_area` VALUES ('130926', '肃宁县', '130900');
INSERT INTO `pro_city_area` VALUES ('130927', '南皮县', '130900');
INSERT INTO `pro_city_area` VALUES ('130928', '吴桥县', '130900');
INSERT INTO `pro_city_area` VALUES ('130929', '献　县', '130900');
INSERT INTO `pro_city_area` VALUES ('130930', '孟村回族自治县', '130900');
INSERT INTO `pro_city_area` VALUES ('130981', '泊头市', '130900');
INSERT INTO `pro_city_area` VALUES ('130982', '任丘市', '130900');
INSERT INTO `pro_city_area` VALUES ('130983', '黄骅市', '130900');
INSERT INTO `pro_city_area` VALUES ('130984', '河间市', '130900');
INSERT INTO `pro_city_area` VALUES ('131000', '廊坊市', '130000');
INSERT INTO `pro_city_area` VALUES ('131001', '市辖区', '131000');
INSERT INTO `pro_city_area` VALUES ('131002', '安次区', '131000');
INSERT INTO `pro_city_area` VALUES ('131003', '广阳区', '131000');
INSERT INTO `pro_city_area` VALUES ('131022', '固安县', '131000');
INSERT INTO `pro_city_area` VALUES ('131023', '永清县', '131000');
INSERT INTO `pro_city_area` VALUES ('131024', '香河县', '131000');
INSERT INTO `pro_city_area` VALUES ('131025', '大城县', '131000');
INSERT INTO `pro_city_area` VALUES ('131026', '文安县', '131000');
INSERT INTO `pro_city_area` VALUES ('131028', '大厂回族自治县', '131000');
INSERT INTO `pro_city_area` VALUES ('131081', '霸州市', '131000');
INSERT INTO `pro_city_area` VALUES ('131082', '三河市', '131000');
INSERT INTO `pro_city_area` VALUES ('131100', '衡水市', '130000');
INSERT INTO `pro_city_area` VALUES ('131101', '市辖区', '131100');
INSERT INTO `pro_city_area` VALUES ('131102', '桃城区', '131100');
INSERT INTO `pro_city_area` VALUES ('131121', '枣强县', '131100');
INSERT INTO `pro_city_area` VALUES ('131122', '武邑县', '131100');
INSERT INTO `pro_city_area` VALUES ('131123', '武强县', '131100');
INSERT INTO `pro_city_area` VALUES ('131124', '饶阳县', '131100');
INSERT INTO `pro_city_area` VALUES ('131125', '安平县', '131100');
INSERT INTO `pro_city_area` VALUES ('131126', '故城县', '131100');
INSERT INTO `pro_city_area` VALUES ('131127', '景　县', '131100');
INSERT INTO `pro_city_area` VALUES ('131128', '阜城县', '131100');
INSERT INTO `pro_city_area` VALUES ('131181', '冀州市', '131100');
INSERT INTO `pro_city_area` VALUES ('131182', '深州市', '131100');
INSERT INTO `pro_city_area` VALUES ('140000', '山西省', '0');
INSERT INTO `pro_city_area` VALUES ('140100', '太原市', '140000');
INSERT INTO `pro_city_area` VALUES ('140101', '市辖区', '140100');
INSERT INTO `pro_city_area` VALUES ('140105', '小店区', '140100');
INSERT INTO `pro_city_area` VALUES ('140106', '迎泽区', '140100');
INSERT INTO `pro_city_area` VALUES ('140107', '杏花岭区', '140100');
INSERT INTO `pro_city_area` VALUES ('140108', '尖草坪区', '140100');
INSERT INTO `pro_city_area` VALUES ('140109', '万柏林区', '140100');
INSERT INTO `pro_city_area` VALUES ('140110', '晋源区', '140100');
INSERT INTO `pro_city_area` VALUES ('140121', '清徐县', '140100');
INSERT INTO `pro_city_area` VALUES ('140122', '阳曲县', '140100');
INSERT INTO `pro_city_area` VALUES ('140123', '娄烦县', '140100');
INSERT INTO `pro_city_area` VALUES ('140181', '古交市', '140100');
INSERT INTO `pro_city_area` VALUES ('140200', '大同市', '140000');
INSERT INTO `pro_city_area` VALUES ('140201', '市辖区', '140200');
INSERT INTO `pro_city_area` VALUES ('140202', '城　区', '140200');
INSERT INTO `pro_city_area` VALUES ('140203', '矿　区', '140200');
INSERT INTO `pro_city_area` VALUES ('140211', '南郊区', '140200');
INSERT INTO `pro_city_area` VALUES ('140212', '新荣区', '140200');
INSERT INTO `pro_city_area` VALUES ('140221', '阳高县', '140200');
INSERT INTO `pro_city_area` VALUES ('140222', '天镇县', '140200');
INSERT INTO `pro_city_area` VALUES ('140223', '广灵县', '140200');
INSERT INTO `pro_city_area` VALUES ('140224', '灵丘县', '140200');
INSERT INTO `pro_city_area` VALUES ('140225', '浑源县', '140200');
INSERT INTO `pro_city_area` VALUES ('140226', '左云县', '140200');
INSERT INTO `pro_city_area` VALUES ('140227', '大同县', '140200');
INSERT INTO `pro_city_area` VALUES ('140300', '阳泉市', '140000');
INSERT INTO `pro_city_area` VALUES ('140301', '市辖区', '140300');
INSERT INTO `pro_city_area` VALUES ('140302', '城　区', '140300');
INSERT INTO `pro_city_area` VALUES ('140303', '矿　区', '140300');
INSERT INTO `pro_city_area` VALUES ('140311', '郊　区', '140300');
INSERT INTO `pro_city_area` VALUES ('140321', '平定县', '140300');
INSERT INTO `pro_city_area` VALUES ('140322', '盂　县', '140300');
INSERT INTO `pro_city_area` VALUES ('140400', '长治市', '140000');
INSERT INTO `pro_city_area` VALUES ('140401', '市辖区', '140400');
INSERT INTO `pro_city_area` VALUES ('140402', '城　区', '140400');
INSERT INTO `pro_city_area` VALUES ('140411', '郊　区', '140400');
INSERT INTO `pro_city_area` VALUES ('140421', '长治县', '140400');
INSERT INTO `pro_city_area` VALUES ('140423', '襄垣县', '140400');
INSERT INTO `pro_city_area` VALUES ('140424', '屯留县', '140400');
INSERT INTO `pro_city_area` VALUES ('140425', '平顺县', '140400');
INSERT INTO `pro_city_area` VALUES ('140426', '黎城县', '140400');
INSERT INTO `pro_city_area` VALUES ('140427', '壶关县', '140400');
INSERT INTO `pro_city_area` VALUES ('140428', '长子县', '140400');
INSERT INTO `pro_city_area` VALUES ('140429', '武乡县', '140400');
INSERT INTO `pro_city_area` VALUES ('140430', '沁　县', '140400');
INSERT INTO `pro_city_area` VALUES ('140431', '沁源县', '140400');
INSERT INTO `pro_city_area` VALUES ('140481', '潞城市', '140400');
INSERT INTO `pro_city_area` VALUES ('140500', '晋城市', '140000');
INSERT INTO `pro_city_area` VALUES ('140501', '市辖区', '140500');
INSERT INTO `pro_city_area` VALUES ('140502', '城　区', '140500');
INSERT INTO `pro_city_area` VALUES ('140521', '沁水县', '140500');
INSERT INTO `pro_city_area` VALUES ('140522', '阳城县', '140500');
INSERT INTO `pro_city_area` VALUES ('140524', '陵川县', '140500');
INSERT INTO `pro_city_area` VALUES ('140525', '泽州县', '140500');
INSERT INTO `pro_city_area` VALUES ('140581', '高平市', '140500');
INSERT INTO `pro_city_area` VALUES ('140600', '朔州市', '140000');
INSERT INTO `pro_city_area` VALUES ('140601', '市辖区', '140600');
INSERT INTO `pro_city_area` VALUES ('140602', '朔城区', '140600');
INSERT INTO `pro_city_area` VALUES ('140603', '平鲁区', '140600');
INSERT INTO `pro_city_area` VALUES ('140621', '山阴县', '140600');
INSERT INTO `pro_city_area` VALUES ('140622', '应　县', '140600');
INSERT INTO `pro_city_area` VALUES ('140623', '右玉县', '140600');
INSERT INTO `pro_city_area` VALUES ('140624', '怀仁县', '140600');
INSERT INTO `pro_city_area` VALUES ('140700', '晋中市', '140000');
INSERT INTO `pro_city_area` VALUES ('140701', '市辖区', '140700');
INSERT INTO `pro_city_area` VALUES ('140702', '榆次区', '140700');
INSERT INTO `pro_city_area` VALUES ('140721', '榆社县', '140700');
INSERT INTO `pro_city_area` VALUES ('140722', '左权县', '140700');
INSERT INTO `pro_city_area` VALUES ('140723', '和顺县', '140700');
INSERT INTO `pro_city_area` VALUES ('140724', '昔阳县', '140700');
INSERT INTO `pro_city_area` VALUES ('140725', '寿阳县', '140700');
INSERT INTO `pro_city_area` VALUES ('140726', '太谷县', '140700');
INSERT INTO `pro_city_area` VALUES ('140727', '祁　县', '140700');
INSERT INTO `pro_city_area` VALUES ('140728', '平遥县', '140700');
INSERT INTO `pro_city_area` VALUES ('140729', '灵石县', '140700');
INSERT INTO `pro_city_area` VALUES ('140781', '介休市', '140700');
INSERT INTO `pro_city_area` VALUES ('140800', '运城市', '140000');
INSERT INTO `pro_city_area` VALUES ('140801', '市辖区', '140800');
INSERT INTO `pro_city_area` VALUES ('140802', '盐湖区', '140800');
INSERT INTO `pro_city_area` VALUES ('140821', '临猗县', '140800');
INSERT INTO `pro_city_area` VALUES ('140822', '万荣县', '140800');
INSERT INTO `pro_city_area` VALUES ('140823', '闻喜县', '140800');
INSERT INTO `pro_city_area` VALUES ('140824', '稷山县', '140800');
INSERT INTO `pro_city_area` VALUES ('140825', '新绛县', '140800');
INSERT INTO `pro_city_area` VALUES ('140826', '绛　县', '140800');
INSERT INTO `pro_city_area` VALUES ('140827', '垣曲县', '140800');
INSERT INTO `pro_city_area` VALUES ('140828', '夏　县', '140800');
INSERT INTO `pro_city_area` VALUES ('140829', '平陆县', '140800');
INSERT INTO `pro_city_area` VALUES ('140830', '芮城县', '140800');
INSERT INTO `pro_city_area` VALUES ('140881', '永济市', '140800');
INSERT INTO `pro_city_area` VALUES ('140882', '河津市', '140800');
INSERT INTO `pro_city_area` VALUES ('140900', '忻州市', '140000');
INSERT INTO `pro_city_area` VALUES ('140901', '市辖区', '140900');
INSERT INTO `pro_city_area` VALUES ('140902', '忻府区', '140900');
INSERT INTO `pro_city_area` VALUES ('140921', '定襄县', '140900');
INSERT INTO `pro_city_area` VALUES ('140922', '五台县', '140900');
INSERT INTO `pro_city_area` VALUES ('140923', '代　县', '140900');
INSERT INTO `pro_city_area` VALUES ('140924', '繁峙县', '140900');
INSERT INTO `pro_city_area` VALUES ('140925', '宁武县', '140900');
INSERT INTO `pro_city_area` VALUES ('140926', '静乐县', '140900');
INSERT INTO `pro_city_area` VALUES ('140927', '神池县', '140900');
INSERT INTO `pro_city_area` VALUES ('140928', '五寨县', '140900');
INSERT INTO `pro_city_area` VALUES ('140929', '岢岚县', '140900');
INSERT INTO `pro_city_area` VALUES ('140930', '河曲县', '140900');
INSERT INTO `pro_city_area` VALUES ('140931', '保德县', '140900');
INSERT INTO `pro_city_area` VALUES ('140932', '偏关县', '140900');
INSERT INTO `pro_city_area` VALUES ('140981', '原平市', '140900');
INSERT INTO `pro_city_area` VALUES ('141000', '临汾市', '140000');
INSERT INTO `pro_city_area` VALUES ('141001', '市辖区', '141000');
INSERT INTO `pro_city_area` VALUES ('141002', '尧都区', '141000');
INSERT INTO `pro_city_area` VALUES ('141021', '曲沃县', '141000');
INSERT INTO `pro_city_area` VALUES ('141022', '翼城县', '141000');
INSERT INTO `pro_city_area` VALUES ('141023', '襄汾县', '141000');
INSERT INTO `pro_city_area` VALUES ('141024', '洪洞县', '141000');
INSERT INTO `pro_city_area` VALUES ('141025', '古　县', '141000');
INSERT INTO `pro_city_area` VALUES ('141026', '安泽县', '141000');
INSERT INTO `pro_city_area` VALUES ('141027', '浮山县', '141000');
INSERT INTO `pro_city_area` VALUES ('141028', '吉　县', '141000');
INSERT INTO `pro_city_area` VALUES ('141029', '乡宁县', '141000');
INSERT INTO `pro_city_area` VALUES ('141030', '大宁县', '141000');
INSERT INTO `pro_city_area` VALUES ('141031', '隰　县', '141000');
INSERT INTO `pro_city_area` VALUES ('141032', '永和县', '141000');
INSERT INTO `pro_city_area` VALUES ('141033', '蒲　县', '141000');
INSERT INTO `pro_city_area` VALUES ('141034', '汾西县', '141000');
INSERT INTO `pro_city_area` VALUES ('141081', '侯马市', '141000');
INSERT INTO `pro_city_area` VALUES ('141082', '霍州市', '141000');
INSERT INTO `pro_city_area` VALUES ('141100', '吕梁市', '140000');
INSERT INTO `pro_city_area` VALUES ('141101', '市辖区', '141100');
INSERT INTO `pro_city_area` VALUES ('141102', '离石区', '141100');
INSERT INTO `pro_city_area` VALUES ('141121', '文水县', '141100');
INSERT INTO `pro_city_area` VALUES ('141122', '交城县', '141100');
INSERT INTO `pro_city_area` VALUES ('141123', '兴　县', '141100');
INSERT INTO `pro_city_area` VALUES ('141124', '临　县', '141100');
INSERT INTO `pro_city_area` VALUES ('141125', '柳林县', '141100');
INSERT INTO `pro_city_area` VALUES ('141126', '石楼县', '141100');
INSERT INTO `pro_city_area` VALUES ('141127', '岚　县', '141100');
INSERT INTO `pro_city_area` VALUES ('141128', '方山县', '141100');
INSERT INTO `pro_city_area` VALUES ('141129', '中阳县', '141100');
INSERT INTO `pro_city_area` VALUES ('141130', '交口县', '141100');
INSERT INTO `pro_city_area` VALUES ('141181', '孝义市', '141100');
INSERT INTO `pro_city_area` VALUES ('141182', '汾阳市', '141100');
INSERT INTO `pro_city_area` VALUES ('150000', '内蒙古', '0');
INSERT INTO `pro_city_area` VALUES ('150100', '呼和浩特市', '150000');
INSERT INTO `pro_city_area` VALUES ('150101', '市辖区', '150100');
INSERT INTO `pro_city_area` VALUES ('150102', '新城区', '150100');
INSERT INTO `pro_city_area` VALUES ('150103', '回民区', '150100');
INSERT INTO `pro_city_area` VALUES ('150104', '玉泉区', '150100');
INSERT INTO `pro_city_area` VALUES ('150105', '赛罕区', '150100');
INSERT INTO `pro_city_area` VALUES ('150121', '土默特左旗', '150100');
INSERT INTO `pro_city_area` VALUES ('150122', '托克托县', '150100');
INSERT INTO `pro_city_area` VALUES ('150123', '和林格尔县', '150100');
INSERT INTO `pro_city_area` VALUES ('150124', '清水河县', '150100');
INSERT INTO `pro_city_area` VALUES ('150125', '武川县', '150100');
INSERT INTO `pro_city_area` VALUES ('150200', '包头市', '150000');
INSERT INTO `pro_city_area` VALUES ('150201', '市辖区', '150200');
INSERT INTO `pro_city_area` VALUES ('150202', '东河区', '150200');
INSERT INTO `pro_city_area` VALUES ('150203', '昆都仑区', '150200');
INSERT INTO `pro_city_area` VALUES ('150204', '青山区', '150200');
INSERT INTO `pro_city_area` VALUES ('150205', '石拐区', '150200');
INSERT INTO `pro_city_area` VALUES ('150206', '白云矿区', '150200');
INSERT INTO `pro_city_area` VALUES ('150207', '九原区', '150200');
INSERT INTO `pro_city_area` VALUES ('150221', '土默特右旗', '150200');
INSERT INTO `pro_city_area` VALUES ('150222', '固阳县', '150200');
INSERT INTO `pro_city_area` VALUES ('150223', '达尔罕茂明安联合旗', '150200');
INSERT INTO `pro_city_area` VALUES ('150300', '乌海市', '150000');
INSERT INTO `pro_city_area` VALUES ('150301', '市辖区', '150300');
INSERT INTO `pro_city_area` VALUES ('150302', '海勃湾区', '150300');
INSERT INTO `pro_city_area` VALUES ('150303', '海南区', '150300');
INSERT INTO `pro_city_area` VALUES ('150304', '乌达区', '150300');
INSERT INTO `pro_city_area` VALUES ('150400', '赤峰市', '150000');
INSERT INTO `pro_city_area` VALUES ('150401', '市辖区', '150400');
INSERT INTO `pro_city_area` VALUES ('150402', '红山区', '150400');
INSERT INTO `pro_city_area` VALUES ('150403', '元宝山区', '150400');
INSERT INTO `pro_city_area` VALUES ('150404', '松山区', '150400');
INSERT INTO `pro_city_area` VALUES ('150421', '阿鲁科尔沁旗', '150400');
INSERT INTO `pro_city_area` VALUES ('150422', '巴林左旗', '150400');
INSERT INTO `pro_city_area` VALUES ('150423', '巴林右旗', '150400');
INSERT INTO `pro_city_area` VALUES ('150424', '林西县', '150400');
INSERT INTO `pro_city_area` VALUES ('150425', '克什克腾旗', '150400');
INSERT INTO `pro_city_area` VALUES ('150426', '翁牛特旗', '150400');
INSERT INTO `pro_city_area` VALUES ('150428', '喀喇沁旗', '150400');
INSERT INTO `pro_city_area` VALUES ('150429', '宁城县', '150400');
INSERT INTO `pro_city_area` VALUES ('150430', '敖汉旗', '150400');
INSERT INTO `pro_city_area` VALUES ('150500', '通辽市', '150000');
INSERT INTO `pro_city_area` VALUES ('150501', '市辖区', '150500');
INSERT INTO `pro_city_area` VALUES ('150502', '科尔沁区', '150500');
INSERT INTO `pro_city_area` VALUES ('150521', '科尔沁左翼中旗', '150500');
INSERT INTO `pro_city_area` VALUES ('150522', '科尔沁左翼后旗', '150500');
INSERT INTO `pro_city_area` VALUES ('150523', '开鲁县', '150500');
INSERT INTO `pro_city_area` VALUES ('150524', '库伦旗', '150500');
INSERT INTO `pro_city_area` VALUES ('150525', '奈曼旗', '150500');
INSERT INTO `pro_city_area` VALUES ('150526', '扎鲁特旗', '150500');
INSERT INTO `pro_city_area` VALUES ('150581', '霍林郭勒市', '150500');
INSERT INTO `pro_city_area` VALUES ('150600', '鄂尔多斯市', '150000');
INSERT INTO `pro_city_area` VALUES ('150602', '东胜区', '150600');
INSERT INTO `pro_city_area` VALUES ('150621', '达拉特旗', '150600');
INSERT INTO `pro_city_area` VALUES ('150622', '准格尔旗', '150600');
INSERT INTO `pro_city_area` VALUES ('150623', '鄂托克前旗', '150600');
INSERT INTO `pro_city_area` VALUES ('150624', '鄂托克旗', '150600');
INSERT INTO `pro_city_area` VALUES ('150625', '杭锦旗', '150600');
INSERT INTO `pro_city_area` VALUES ('150626', '乌审旗', '150600');
INSERT INTO `pro_city_area` VALUES ('150627', '伊金霍洛旗', '150600');
INSERT INTO `pro_city_area` VALUES ('150700', '呼伦贝尔市', '150000');
INSERT INTO `pro_city_area` VALUES ('150701', '市辖区', '150700');
INSERT INTO `pro_city_area` VALUES ('150702', '海拉尔区', '150700');
INSERT INTO `pro_city_area` VALUES ('150721', '阿荣旗', '150700');
INSERT INTO `pro_city_area` VALUES ('150722', '莫力达瓦达斡尔族自治旗', '150700');
INSERT INTO `pro_city_area` VALUES ('150723', '鄂伦春自治旗', '150700');
INSERT INTO `pro_city_area` VALUES ('150724', '鄂温克族自治旗', '150700');
INSERT INTO `pro_city_area` VALUES ('150725', '陈巴尔虎旗', '150700');
INSERT INTO `pro_city_area` VALUES ('150726', '新巴尔虎左旗', '150700');
INSERT INTO `pro_city_area` VALUES ('150727', '新巴尔虎右旗', '150700');
INSERT INTO `pro_city_area` VALUES ('150781', '满洲里市', '150700');
INSERT INTO `pro_city_area` VALUES ('150782', '牙克石市', '150700');
INSERT INTO `pro_city_area` VALUES ('150783', '扎兰屯市', '150700');
INSERT INTO `pro_city_area` VALUES ('150784', '额尔古纳市', '150700');
INSERT INTO `pro_city_area` VALUES ('150785', '根河市', '150700');
INSERT INTO `pro_city_area` VALUES ('150800', '巴彦淖尔市', '150000');
INSERT INTO `pro_city_area` VALUES ('150801', '市辖区', '150800');
INSERT INTO `pro_city_area` VALUES ('150802', '临河区', '150800');
INSERT INTO `pro_city_area` VALUES ('150821', '五原县', '150800');
INSERT INTO `pro_city_area` VALUES ('150822', '磴口县', '150800');
INSERT INTO `pro_city_area` VALUES ('150823', '乌拉特前旗', '150800');
INSERT INTO `pro_city_area` VALUES ('150824', '乌拉特中旗', '150800');
INSERT INTO `pro_city_area` VALUES ('150825', '乌拉特后旗', '150800');
INSERT INTO `pro_city_area` VALUES ('150826', '杭锦后旗', '150800');
INSERT INTO `pro_city_area` VALUES ('150900', '乌兰察布市', '150000');
INSERT INTO `pro_city_area` VALUES ('150901', '市辖区', '150900');
INSERT INTO `pro_city_area` VALUES ('150902', '集宁区', '150900');
INSERT INTO `pro_city_area` VALUES ('150921', '卓资县', '150900');
INSERT INTO `pro_city_area` VALUES ('150922', '化德县', '150900');
INSERT INTO `pro_city_area` VALUES ('150923', '商都县', '150900');
INSERT INTO `pro_city_area` VALUES ('150924', '兴和县', '150900');
INSERT INTO `pro_city_area` VALUES ('150925', '凉城县', '150900');
INSERT INTO `pro_city_area` VALUES ('150926', '察哈尔右翼前旗', '150900');
INSERT INTO `pro_city_area` VALUES ('150927', '察哈尔右翼中旗', '150900');
INSERT INTO `pro_city_area` VALUES ('150928', '察哈尔右翼后旗', '150900');
INSERT INTO `pro_city_area` VALUES ('150929', '四子王旗', '150900');
INSERT INTO `pro_city_area` VALUES ('150981', '丰镇市', '150900');
INSERT INTO `pro_city_area` VALUES ('152200', '兴安盟', '150000');
INSERT INTO `pro_city_area` VALUES ('152201', '乌兰浩特市', '152200');
INSERT INTO `pro_city_area` VALUES ('152202', '阿尔山市', '152200');
INSERT INTO `pro_city_area` VALUES ('152221', '科尔沁右翼前旗', '152200');
INSERT INTO `pro_city_area` VALUES ('152222', '科尔沁右翼中旗', '152200');
INSERT INTO `pro_city_area` VALUES ('152223', '扎赉特旗', '152200');
INSERT INTO `pro_city_area` VALUES ('152224', '突泉县', '152200');
INSERT INTO `pro_city_area` VALUES ('152500', '锡林郭勒盟', '150000');
INSERT INTO `pro_city_area` VALUES ('152501', '二连浩特市', '152500');
INSERT INTO `pro_city_area` VALUES ('152502', '锡林浩特市', '152500');
INSERT INTO `pro_city_area` VALUES ('152522', '阿巴嘎旗', '152500');
INSERT INTO `pro_city_area` VALUES ('152523', '苏尼特左旗', '152500');
INSERT INTO `pro_city_area` VALUES ('152524', '苏尼特右旗', '152500');
INSERT INTO `pro_city_area` VALUES ('152525', '东乌珠穆沁旗', '152500');
INSERT INTO `pro_city_area` VALUES ('152526', '西乌珠穆沁旗', '152500');
INSERT INTO `pro_city_area` VALUES ('152527', '太仆寺旗', '152500');
INSERT INTO `pro_city_area` VALUES ('152528', '镶黄旗', '152500');
INSERT INTO `pro_city_area` VALUES ('152529', '正镶白旗', '152500');
INSERT INTO `pro_city_area` VALUES ('152530', '正蓝旗', '152500');
INSERT INTO `pro_city_area` VALUES ('152531', '多伦县', '152500');
INSERT INTO `pro_city_area` VALUES ('152900', '阿拉善盟', '150000');
INSERT INTO `pro_city_area` VALUES ('152921', '阿拉善左旗', '152900');
INSERT INTO `pro_city_area` VALUES ('152922', '阿拉善右旗', '152900');
INSERT INTO `pro_city_area` VALUES ('152923', '额济纳旗', '152900');
INSERT INTO `pro_city_area` VALUES ('210000', '辽宁省', '0');
INSERT INTO `pro_city_area` VALUES ('210100', '沈阳市', '210000');
INSERT INTO `pro_city_area` VALUES ('210101', '市辖区', '210100');
INSERT INTO `pro_city_area` VALUES ('210102', '和平区', '210100');
INSERT INTO `pro_city_area` VALUES ('210103', '沈河区', '210100');
INSERT INTO `pro_city_area` VALUES ('210104', '大东区', '210100');
INSERT INTO `pro_city_area` VALUES ('210105', '皇姑区', '210100');
INSERT INTO `pro_city_area` VALUES ('210106', '铁西区', '210100');
INSERT INTO `pro_city_area` VALUES ('210111', '苏家屯区', '210100');
INSERT INTO `pro_city_area` VALUES ('210112', '东陵区', '210100');
INSERT INTO `pro_city_area` VALUES ('210113', '新城子区', '210100');
INSERT INTO `pro_city_area` VALUES ('210114', '于洪区', '210100');
INSERT INTO `pro_city_area` VALUES ('210122', '辽中县', '210100');
INSERT INTO `pro_city_area` VALUES ('210123', '康平县', '210100');
INSERT INTO `pro_city_area` VALUES ('210124', '法库县', '210100');
INSERT INTO `pro_city_area` VALUES ('210181', '新民市', '210100');
INSERT INTO `pro_city_area` VALUES ('210200', '大连市', '210000');
INSERT INTO `pro_city_area` VALUES ('210201', '市辖区', '210200');
INSERT INTO `pro_city_area` VALUES ('210202', '中山区', '210200');
INSERT INTO `pro_city_area` VALUES ('210203', '西岗区', '210200');
INSERT INTO `pro_city_area` VALUES ('210204', '沙河口区', '210200');
INSERT INTO `pro_city_area` VALUES ('210211', '甘井子区', '210200');
INSERT INTO `pro_city_area` VALUES ('210212', '旅顺口区', '210200');
INSERT INTO `pro_city_area` VALUES ('210213', '金州区', '210200');
INSERT INTO `pro_city_area` VALUES ('210224', '长海县', '210200');
INSERT INTO `pro_city_area` VALUES ('210281', '瓦房店市', '210200');
INSERT INTO `pro_city_area` VALUES ('210282', '普兰店市', '210200');
INSERT INTO `pro_city_area` VALUES ('210283', '庄河市', '210200');
INSERT INTO `pro_city_area` VALUES ('210300', '鞍山市', '210000');
INSERT INTO `pro_city_area` VALUES ('210301', '市辖区', '210300');
INSERT INTO `pro_city_area` VALUES ('210302', '铁东区', '210300');
INSERT INTO `pro_city_area` VALUES ('210303', '铁西区', '210300');
INSERT INTO `pro_city_area` VALUES ('210304', '立山区', '210300');
INSERT INTO `pro_city_area` VALUES ('210311', '千山区', '210300');
INSERT INTO `pro_city_area` VALUES ('210321', '台安县', '210300');
INSERT INTO `pro_city_area` VALUES ('210323', '岫岩满族自治县', '210300');
INSERT INTO `pro_city_area` VALUES ('210381', '海城市', '210300');
INSERT INTO `pro_city_area` VALUES ('210400', '抚顺市', '210000');
INSERT INTO `pro_city_area` VALUES ('210401', '市辖区', '210400');
INSERT INTO `pro_city_area` VALUES ('210402', '新抚区', '210400');
INSERT INTO `pro_city_area` VALUES ('210403', '东洲区', '210400');
INSERT INTO `pro_city_area` VALUES ('210404', '望花区', '210400');
INSERT INTO `pro_city_area` VALUES ('210411', '顺城区', '210400');
INSERT INTO `pro_city_area` VALUES ('210421', '抚顺县', '210400');
INSERT INTO `pro_city_area` VALUES ('210422', '新宾满族自治县', '210400');
INSERT INTO `pro_city_area` VALUES ('210423', '清原满族自治县', '210400');
INSERT INTO `pro_city_area` VALUES ('210500', '本溪市', '210000');
INSERT INTO `pro_city_area` VALUES ('210501', '市辖区', '210500');
INSERT INTO `pro_city_area` VALUES ('210502', '平山区', '210500');
INSERT INTO `pro_city_area` VALUES ('210503', '溪湖区', '210500');
INSERT INTO `pro_city_area` VALUES ('210504', '明山区', '210500');
INSERT INTO `pro_city_area` VALUES ('210505', '南芬区', '210500');
INSERT INTO `pro_city_area` VALUES ('210521', '本溪满族自治县', '210500');
INSERT INTO `pro_city_area` VALUES ('210522', '桓仁满族自治县', '210500');
INSERT INTO `pro_city_area` VALUES ('210600', '丹东市', '210000');
INSERT INTO `pro_city_area` VALUES ('210601', '市辖区', '210600');
INSERT INTO `pro_city_area` VALUES ('210602', '元宝区', '210600');
INSERT INTO `pro_city_area` VALUES ('210603', '振兴区', '210600');
INSERT INTO `pro_city_area` VALUES ('210604', '振安区', '210600');
INSERT INTO `pro_city_area` VALUES ('210624', '宽甸满族自治县', '210600');
INSERT INTO `pro_city_area` VALUES ('210681', '东港市', '210600');
INSERT INTO `pro_city_area` VALUES ('210682', '凤城市', '210600');
INSERT INTO `pro_city_area` VALUES ('210700', '锦州市', '210000');
INSERT INTO `pro_city_area` VALUES ('210701', '市辖区', '210700');
INSERT INTO `pro_city_area` VALUES ('210702', '古塔区', '210700');
INSERT INTO `pro_city_area` VALUES ('210703', '凌河区', '210700');
INSERT INTO `pro_city_area` VALUES ('210711', '太和区', '210700');
INSERT INTO `pro_city_area` VALUES ('210726', '黑山县', '210700');
INSERT INTO `pro_city_area` VALUES ('210727', '义　县', '210700');
INSERT INTO `pro_city_area` VALUES ('210781', '凌海市', '210700');
INSERT INTO `pro_city_area` VALUES ('210782', '北宁市', '210700');
INSERT INTO `pro_city_area` VALUES ('210800', '营口市', '210000');
INSERT INTO `pro_city_area` VALUES ('210801', '市辖区', '210800');
INSERT INTO `pro_city_area` VALUES ('210802', '站前区', '210800');
INSERT INTO `pro_city_area` VALUES ('210803', '西市区', '210800');
INSERT INTO `pro_city_area` VALUES ('210804', '鲅鱼圈区', '210800');
INSERT INTO `pro_city_area` VALUES ('210811', '老边区', '210800');
INSERT INTO `pro_city_area` VALUES ('210881', '盖州市', '210800');
INSERT INTO `pro_city_area` VALUES ('210882', '大石桥市', '210800');
INSERT INTO `pro_city_area` VALUES ('210900', '阜新市', '210000');
INSERT INTO `pro_city_area` VALUES ('210901', '市辖区', '210900');
INSERT INTO `pro_city_area` VALUES ('210902', '海州区', '210900');
INSERT INTO `pro_city_area` VALUES ('210903', '新邱区', '210900');
INSERT INTO `pro_city_area` VALUES ('210904', '太平区', '210900');
INSERT INTO `pro_city_area` VALUES ('210905', '清河门区', '210900');
INSERT INTO `pro_city_area` VALUES ('210911', '细河区', '210900');
INSERT INTO `pro_city_area` VALUES ('210921', '阜新蒙古族自治县', '210900');
INSERT INTO `pro_city_area` VALUES ('210922', '彰武县', '210900');
INSERT INTO `pro_city_area` VALUES ('211000', '辽阳市', '210000');
INSERT INTO `pro_city_area` VALUES ('211001', '市辖区', '211000');
INSERT INTO `pro_city_area` VALUES ('211002', '白塔区', '211000');
INSERT INTO `pro_city_area` VALUES ('211003', '文圣区', '211000');
INSERT INTO `pro_city_area` VALUES ('211004', '宏伟区', '211000');
INSERT INTO `pro_city_area` VALUES ('211005', '弓长岭区', '211000');
INSERT INTO `pro_city_area` VALUES ('211011', '太子河区', '211000');
INSERT INTO `pro_city_area` VALUES ('211021', '辽阳县', '211000');
INSERT INTO `pro_city_area` VALUES ('211081', '灯塔市', '211000');
INSERT INTO `pro_city_area` VALUES ('211100', '盘锦市', '210000');
INSERT INTO `pro_city_area` VALUES ('211101', '市辖区', '211100');
INSERT INTO `pro_city_area` VALUES ('211102', '双台子区', '211100');
INSERT INTO `pro_city_area` VALUES ('211103', '兴隆台区', '211100');
INSERT INTO `pro_city_area` VALUES ('211121', '大洼县', '211100');
INSERT INTO `pro_city_area` VALUES ('211122', '盘山县', '211100');
INSERT INTO `pro_city_area` VALUES ('211200', '铁岭市', '210000');
INSERT INTO `pro_city_area` VALUES ('211201', '市辖区', '211200');
INSERT INTO `pro_city_area` VALUES ('211202', '银州区', '211200');
INSERT INTO `pro_city_area` VALUES ('211204', '清河区', '211200');
INSERT INTO `pro_city_area` VALUES ('211221', '铁岭县', '211200');
INSERT INTO `pro_city_area` VALUES ('211223', '西丰县', '211200');
INSERT INTO `pro_city_area` VALUES ('211224', '昌图县', '211200');
INSERT INTO `pro_city_area` VALUES ('211281', '调兵山市', '211200');
INSERT INTO `pro_city_area` VALUES ('211282', '开原市', '211200');
INSERT INTO `pro_city_area` VALUES ('211300', '朝阳市', '210000');
INSERT INTO `pro_city_area` VALUES ('211301', '市辖区', '211300');
INSERT INTO `pro_city_area` VALUES ('211302', '双塔区', '211300');
INSERT INTO `pro_city_area` VALUES ('211303', '龙城区', '211300');
INSERT INTO `pro_city_area` VALUES ('211321', '朝阳县', '211300');
INSERT INTO `pro_city_area` VALUES ('211322', '建平县', '211300');
INSERT INTO `pro_city_area` VALUES ('211324', '喀喇沁左翼蒙古族自治县', '211300');
INSERT INTO `pro_city_area` VALUES ('211381', '北票市', '211300');
INSERT INTO `pro_city_area` VALUES ('211382', '凌源市', '211300');
INSERT INTO `pro_city_area` VALUES ('211400', '葫芦岛市', '210000');
INSERT INTO `pro_city_area` VALUES ('211401', '市辖区', '211400');
INSERT INTO `pro_city_area` VALUES ('211402', '连山区', '211400');
INSERT INTO `pro_city_area` VALUES ('211403', '龙港区', '211400');
INSERT INTO `pro_city_area` VALUES ('211404', '南票区', '211400');
INSERT INTO `pro_city_area` VALUES ('211421', '绥中县', '211400');
INSERT INTO `pro_city_area` VALUES ('211422', '建昌县', '211400');
INSERT INTO `pro_city_area` VALUES ('211481', '兴城市', '211400');
INSERT INTO `pro_city_area` VALUES ('220000', '吉林省', '0');
INSERT INTO `pro_city_area` VALUES ('220100', '长春市', '220000');
INSERT INTO `pro_city_area` VALUES ('220101', '市辖区', '220100');
INSERT INTO `pro_city_area` VALUES ('220102', '南关区', '220100');
INSERT INTO `pro_city_area` VALUES ('220103', '宽城区', '220100');
INSERT INTO `pro_city_area` VALUES ('220104', '朝阳区', '220100');
INSERT INTO `pro_city_area` VALUES ('220105', '二道区', '220100');
INSERT INTO `pro_city_area` VALUES ('220106', '绿园区', '220100');
INSERT INTO `pro_city_area` VALUES ('220112', '双阳区', '220100');
INSERT INTO `pro_city_area` VALUES ('220122', '农安县', '220100');
INSERT INTO `pro_city_area` VALUES ('220181', '九台市', '220100');
INSERT INTO `pro_city_area` VALUES ('220182', '榆树市', '220100');
INSERT INTO `pro_city_area` VALUES ('220183', '德惠市', '220100');
INSERT INTO `pro_city_area` VALUES ('220200', '吉林市', '220000');
INSERT INTO `pro_city_area` VALUES ('220201', '市辖区', '220200');
INSERT INTO `pro_city_area` VALUES ('220202', '昌邑区', '220200');
INSERT INTO `pro_city_area` VALUES ('220203', '龙潭区', '220200');
INSERT INTO `pro_city_area` VALUES ('220204', '船营区', '220200');
INSERT INTO `pro_city_area` VALUES ('220211', '丰满区', '220200');
INSERT INTO `pro_city_area` VALUES ('220221', '永吉县', '220200');
INSERT INTO `pro_city_area` VALUES ('220281', '蛟河市', '220200');
INSERT INTO `pro_city_area` VALUES ('220282', '桦甸市', '220200');
INSERT INTO `pro_city_area` VALUES ('220283', '舒兰市', '220200');
INSERT INTO `pro_city_area` VALUES ('220284', '磐石市', '220200');
INSERT INTO `pro_city_area` VALUES ('220300', '四平市', '220000');
INSERT INTO `pro_city_area` VALUES ('220301', '市辖区', '220300');
INSERT INTO `pro_city_area` VALUES ('220302', '铁西区', '220300');
INSERT INTO `pro_city_area` VALUES ('220303', '铁东区', '220300');
INSERT INTO `pro_city_area` VALUES ('220322', '梨树县', '220300');
INSERT INTO `pro_city_area` VALUES ('220323', '伊通满族自治县', '220300');
INSERT INTO `pro_city_area` VALUES ('220381', '公主岭市', '220300');
INSERT INTO `pro_city_area` VALUES ('220382', '双辽市', '220300');
INSERT INTO `pro_city_area` VALUES ('220400', '辽源市', '220000');
INSERT INTO `pro_city_area` VALUES ('220401', '市辖区', '220400');
INSERT INTO `pro_city_area` VALUES ('220402', '龙山区', '220400');
INSERT INTO `pro_city_area` VALUES ('220403', '西安区', '220400');
INSERT INTO `pro_city_area` VALUES ('220421', '东丰县', '220400');
INSERT INTO `pro_city_area` VALUES ('220422', '东辽县', '220400');
INSERT INTO `pro_city_area` VALUES ('220500', '通化市', '220000');
INSERT INTO `pro_city_area` VALUES ('220501', '市辖区', '220500');
INSERT INTO `pro_city_area` VALUES ('220502', '东昌区', '220500');
INSERT INTO `pro_city_area` VALUES ('220503', '二道江区', '220500');
INSERT INTO `pro_city_area` VALUES ('220521', '通化县', '220500');
INSERT INTO `pro_city_area` VALUES ('220523', '辉南县', '220500');
INSERT INTO `pro_city_area` VALUES ('220524', '柳河县', '220500');
INSERT INTO `pro_city_area` VALUES ('220581', '梅河口市', '220500');
INSERT INTO `pro_city_area` VALUES ('220582', '集安市', '220500');
INSERT INTO `pro_city_area` VALUES ('220600', '白山市', '220000');
INSERT INTO `pro_city_area` VALUES ('220601', '市辖区', '220600');
INSERT INTO `pro_city_area` VALUES ('220602', '八道江区', '220600');
INSERT INTO `pro_city_area` VALUES ('220621', '抚松县', '220600');
INSERT INTO `pro_city_area` VALUES ('220622', '靖宇县', '220600');
INSERT INTO `pro_city_area` VALUES ('220623', '长白朝鲜族自治县', '220600');
INSERT INTO `pro_city_area` VALUES ('220625', '江源县', '220600');
INSERT INTO `pro_city_area` VALUES ('220681', '临江市', '220600');
INSERT INTO `pro_city_area` VALUES ('220700', '松原市', '220000');
INSERT INTO `pro_city_area` VALUES ('220701', '市辖区', '220700');
INSERT INTO `pro_city_area` VALUES ('220702', '宁江区', '220700');
INSERT INTO `pro_city_area` VALUES ('220721', '前郭尔罗斯蒙古族自治县', '220700');
INSERT INTO `pro_city_area` VALUES ('220722', '长岭县', '220700');
INSERT INTO `pro_city_area` VALUES ('220723', '乾安县', '220700');
INSERT INTO `pro_city_area` VALUES ('220724', '扶余县', '220700');
INSERT INTO `pro_city_area` VALUES ('220800', '白城市', '220000');
INSERT INTO `pro_city_area` VALUES ('220801', '市辖区', '220800');
INSERT INTO `pro_city_area` VALUES ('220802', '洮北区', '220800');
INSERT INTO `pro_city_area` VALUES ('220821', '镇赉县', '220800');
INSERT INTO `pro_city_area` VALUES ('220822', '通榆县', '220800');
INSERT INTO `pro_city_area` VALUES ('220881', '洮南市', '220800');
INSERT INTO `pro_city_area` VALUES ('220882', '大安市', '220800');
INSERT INTO `pro_city_area` VALUES ('222400', '延边朝鲜族自治州', '220000');
INSERT INTO `pro_city_area` VALUES ('222401', '延吉市', '222400');
INSERT INTO `pro_city_area` VALUES ('222402', '图们市', '222400');
INSERT INTO `pro_city_area` VALUES ('222403', '敦化市', '222400');
INSERT INTO `pro_city_area` VALUES ('222404', '珲春市', '222400');
INSERT INTO `pro_city_area` VALUES ('222405', '龙井市', '222400');
INSERT INTO `pro_city_area` VALUES ('222406', '和龙市', '222400');
INSERT INTO `pro_city_area` VALUES ('222424', '汪清县', '222400');
INSERT INTO `pro_city_area` VALUES ('222426', '安图县', '222400');
INSERT INTO `pro_city_area` VALUES ('230000', '黑龙江', '0');
INSERT INTO `pro_city_area` VALUES ('230100', '哈尔滨市', '230000');
INSERT INTO `pro_city_area` VALUES ('230101', '市辖区', '230100');
INSERT INTO `pro_city_area` VALUES ('230102', '道里区', '230100');
INSERT INTO `pro_city_area` VALUES ('230103', '南岗区', '230100');
INSERT INTO `pro_city_area` VALUES ('230104', '道外区', '230100');
INSERT INTO `pro_city_area` VALUES ('230106', '香坊区', '230100');
INSERT INTO `pro_city_area` VALUES ('230107', '动力区', '230100');
INSERT INTO `pro_city_area` VALUES ('230108', '平房区', '230100');
INSERT INTO `pro_city_area` VALUES ('230109', '松北区', '230100');
INSERT INTO `pro_city_area` VALUES ('230111', '呼兰区', '230100');
INSERT INTO `pro_city_area` VALUES ('230123', '依兰县', '230100');
INSERT INTO `pro_city_area` VALUES ('230124', '方正县', '230100');
INSERT INTO `pro_city_area` VALUES ('230125', '宾　县', '230100');
INSERT INTO `pro_city_area` VALUES ('230126', '巴彦县', '230100');
INSERT INTO `pro_city_area` VALUES ('230127', '木兰县', '230100');
INSERT INTO `pro_city_area` VALUES ('230128', '通河县', '230100');
INSERT INTO `pro_city_area` VALUES ('230129', '延寿县', '230100');
INSERT INTO `pro_city_area` VALUES ('230181', '阿城市', '230100');
INSERT INTO `pro_city_area` VALUES ('230182', '双城市', '230100');
INSERT INTO `pro_city_area` VALUES ('230183', '尚志市', '230100');
INSERT INTO `pro_city_area` VALUES ('230184', '五常市', '230100');
INSERT INTO `pro_city_area` VALUES ('230200', '齐齐哈尔市', '230000');
INSERT INTO `pro_city_area` VALUES ('230201', '市辖区', '230200');
INSERT INTO `pro_city_area` VALUES ('230202', '龙沙区', '230200');
INSERT INTO `pro_city_area` VALUES ('230203', '建华区', '230200');
INSERT INTO `pro_city_area` VALUES ('230204', '铁锋区', '230200');
INSERT INTO `pro_city_area` VALUES ('230205', '昂昂溪区', '230200');
INSERT INTO `pro_city_area` VALUES ('230206', '富拉尔基区', '230200');
INSERT INTO `pro_city_area` VALUES ('230207', '碾子山区', '230200');
INSERT INTO `pro_city_area` VALUES ('230208', '梅里斯达斡尔族区', '230200');
INSERT INTO `pro_city_area` VALUES ('230221', '龙江县', '230200');
INSERT INTO `pro_city_area` VALUES ('230223', '依安县', '230200');
INSERT INTO `pro_city_area` VALUES ('230224', '泰来县', '230200');
INSERT INTO `pro_city_area` VALUES ('230225', '甘南县', '230200');
INSERT INTO `pro_city_area` VALUES ('230227', '富裕县', '230200');
INSERT INTO `pro_city_area` VALUES ('230229', '克山县', '230200');
INSERT INTO `pro_city_area` VALUES ('230230', '克东县', '230200');
INSERT INTO `pro_city_area` VALUES ('230231', '拜泉县', '230200');
INSERT INTO `pro_city_area` VALUES ('230281', '讷河市', '230200');
INSERT INTO `pro_city_area` VALUES ('230300', '鸡西市', '230000');
INSERT INTO `pro_city_area` VALUES ('230301', '市辖区', '230300');
INSERT INTO `pro_city_area` VALUES ('230302', '鸡冠区', '230300');
INSERT INTO `pro_city_area` VALUES ('230303', '恒山区', '230300');
INSERT INTO `pro_city_area` VALUES ('230304', '滴道区', '230300');
INSERT INTO `pro_city_area` VALUES ('230305', '梨树区', '230300');
INSERT INTO `pro_city_area` VALUES ('230306', '城子河区', '230300');
INSERT INTO `pro_city_area` VALUES ('230307', '麻山区', '230300');
INSERT INTO `pro_city_area` VALUES ('230321', '鸡东县', '230300');
INSERT INTO `pro_city_area` VALUES ('230381', '虎林市', '230300');
INSERT INTO `pro_city_area` VALUES ('230382', '密山市', '230300');
INSERT INTO `pro_city_area` VALUES ('230400', '鹤岗市', '230000');
INSERT INTO `pro_city_area` VALUES ('230401', '市辖区', '230400');
INSERT INTO `pro_city_area` VALUES ('230402', '向阳区', '230400');
INSERT INTO `pro_city_area` VALUES ('230403', '工农区', '230400');
INSERT INTO `pro_city_area` VALUES ('230404', '南山区', '230400');
INSERT INTO `pro_city_area` VALUES ('230405', '兴安区', '230400');
INSERT INTO `pro_city_area` VALUES ('230406', '东山区', '230400');
INSERT INTO `pro_city_area` VALUES ('230407', '兴山区', '230400');
INSERT INTO `pro_city_area` VALUES ('230421', '萝北县', '230400');
INSERT INTO `pro_city_area` VALUES ('230422', '绥滨县', '230400');
INSERT INTO `pro_city_area` VALUES ('230500', '双鸭山市', '230000');
INSERT INTO `pro_city_area` VALUES ('230501', '市辖区', '230500');
INSERT INTO `pro_city_area` VALUES ('230502', '尖山区', '230500');
INSERT INTO `pro_city_area` VALUES ('230503', '岭东区', '230500');
INSERT INTO `pro_city_area` VALUES ('230505', '四方台区', '230500');
INSERT INTO `pro_city_area` VALUES ('230506', '宝山区', '230500');
INSERT INTO `pro_city_area` VALUES ('230521', '集贤县', '230500');
INSERT INTO `pro_city_area` VALUES ('230522', '友谊县', '230500');
INSERT INTO `pro_city_area` VALUES ('230523', '宝清县', '230500');
INSERT INTO `pro_city_area` VALUES ('230524', '饶河县', '230500');
INSERT INTO `pro_city_area` VALUES ('230600', '大庆市', '230000');
INSERT INTO `pro_city_area` VALUES ('230601', '市辖区', '230600');
INSERT INTO `pro_city_area` VALUES ('230602', '萨尔图区', '230600');
INSERT INTO `pro_city_area` VALUES ('230603', '龙凤区', '230600');
INSERT INTO `pro_city_area` VALUES ('230604', '让胡路区', '230600');
INSERT INTO `pro_city_area` VALUES ('230605', '红岗区', '230600');
INSERT INTO `pro_city_area` VALUES ('230606', '大同区', '230600');
INSERT INTO `pro_city_area` VALUES ('230621', '肇州县', '230600');
INSERT INTO `pro_city_area` VALUES ('230622', '肇源县', '230600');
INSERT INTO `pro_city_area` VALUES ('230623', '林甸县', '230600');
INSERT INTO `pro_city_area` VALUES ('230624', '杜尔伯特蒙古族自治县', '230600');
INSERT INTO `pro_city_area` VALUES ('230700', '伊春市', '230000');
INSERT INTO `pro_city_area` VALUES ('230701', '市辖区', '230700');
INSERT INTO `pro_city_area` VALUES ('230702', '伊春区', '230700');
INSERT INTO `pro_city_area` VALUES ('230703', '南岔区', '230700');
INSERT INTO `pro_city_area` VALUES ('230704', '友好区', '230700');
INSERT INTO `pro_city_area` VALUES ('230705', '西林区', '230700');
INSERT INTO `pro_city_area` VALUES ('230706', '翠峦区', '230700');
INSERT INTO `pro_city_area` VALUES ('230707', '新青区', '230700');
INSERT INTO `pro_city_area` VALUES ('230708', '美溪区', '230700');
INSERT INTO `pro_city_area` VALUES ('230709', '金山屯区', '230700');
INSERT INTO `pro_city_area` VALUES ('230710', '五营区', '230700');
INSERT INTO `pro_city_area` VALUES ('230711', '乌马河区', '230700');
INSERT INTO `pro_city_area` VALUES ('230712', '汤旺河区', '230700');
INSERT INTO `pro_city_area` VALUES ('230713', '带岭区', '230700');
INSERT INTO `pro_city_area` VALUES ('230714', '乌伊岭区', '230700');
INSERT INTO `pro_city_area` VALUES ('230715', '红星区', '230700');
INSERT INTO `pro_city_area` VALUES ('230716', '上甘岭区', '230700');
INSERT INTO `pro_city_area` VALUES ('230722', '嘉荫县', '230700');
INSERT INTO `pro_city_area` VALUES ('230781', '铁力市', '230700');
INSERT INTO `pro_city_area` VALUES ('230800', '佳木斯市', '230000');
INSERT INTO `pro_city_area` VALUES ('230801', '市辖区', '230800');
INSERT INTO `pro_city_area` VALUES ('230802', '永红区', '230800');
INSERT INTO `pro_city_area` VALUES ('230803', '向阳区', '230800');
INSERT INTO `pro_city_area` VALUES ('230804', '前进区', '230800');
INSERT INTO `pro_city_area` VALUES ('230805', '东风区', '230800');
INSERT INTO `pro_city_area` VALUES ('230811', '郊　区', '230800');
INSERT INTO `pro_city_area` VALUES ('230822', '桦南县', '230800');
INSERT INTO `pro_city_area` VALUES ('230826', '桦川县', '230800');
INSERT INTO `pro_city_area` VALUES ('230828', '汤原县', '230800');
INSERT INTO `pro_city_area` VALUES ('230833', '抚远县', '230800');
INSERT INTO `pro_city_area` VALUES ('230881', '同江市', '230800');
INSERT INTO `pro_city_area` VALUES ('230882', '富锦市', '230800');
INSERT INTO `pro_city_area` VALUES ('230900', '七台河市', '230000');
INSERT INTO `pro_city_area` VALUES ('230901', '市辖区', '230900');
INSERT INTO `pro_city_area` VALUES ('230902', '新兴区', '230900');
INSERT INTO `pro_city_area` VALUES ('230903', '桃山区', '230900');
INSERT INTO `pro_city_area` VALUES ('230904', '茄子河区', '230900');
INSERT INTO `pro_city_area` VALUES ('230921', '勃利县', '230900');
INSERT INTO `pro_city_area` VALUES ('231000', '牡丹江市', '230000');
INSERT INTO `pro_city_area` VALUES ('231001', '市辖区', '231000');
INSERT INTO `pro_city_area` VALUES ('231002', '东安区', '231000');
INSERT INTO `pro_city_area` VALUES ('231003', '阳明区', '231000');
INSERT INTO `pro_city_area` VALUES ('231004', '爱民区', '231000');
INSERT INTO `pro_city_area` VALUES ('231005', '西安区', '231000');
INSERT INTO `pro_city_area` VALUES ('231024', '东宁县', '231000');
INSERT INTO `pro_city_area` VALUES ('231025', '林口县', '231000');
INSERT INTO `pro_city_area` VALUES ('231081', '绥芬河市', '231000');
INSERT INTO `pro_city_area` VALUES ('231083', '海林市', '231000');
INSERT INTO `pro_city_area` VALUES ('231084', '宁安市', '231000');
INSERT INTO `pro_city_area` VALUES ('231085', '穆棱市', '231000');
INSERT INTO `pro_city_area` VALUES ('231100', '黑河市', '230000');
INSERT INTO `pro_city_area` VALUES ('231101', '市辖区', '231100');
INSERT INTO `pro_city_area` VALUES ('231102', '爱辉区', '231100');
INSERT INTO `pro_city_area` VALUES ('231121', '嫩江县', '231100');
INSERT INTO `pro_city_area` VALUES ('231123', '逊克县', '231100');
INSERT INTO `pro_city_area` VALUES ('231124', '孙吴县', '231100');
INSERT INTO `pro_city_area` VALUES ('231181', '北安市', '231100');
INSERT INTO `pro_city_area` VALUES ('231182', '五大连池市', '231100');
INSERT INTO `pro_city_area` VALUES ('231200', '绥化市', '230000');
INSERT INTO `pro_city_area` VALUES ('231201', '市辖区', '231200');
INSERT INTO `pro_city_area` VALUES ('231202', '北林区', '231200');
INSERT INTO `pro_city_area` VALUES ('231221', '望奎县', '231200');
INSERT INTO `pro_city_area` VALUES ('231222', '兰西县', '231200');
INSERT INTO `pro_city_area` VALUES ('231223', '青冈县', '231200');
INSERT INTO `pro_city_area` VALUES ('231224', '庆安县', '231200');
INSERT INTO `pro_city_area` VALUES ('231225', '明水县', '231200');
INSERT INTO `pro_city_area` VALUES ('231226', '绥棱县', '231200');
INSERT INTO `pro_city_area` VALUES ('231281', '安达市', '231200');
INSERT INTO `pro_city_area` VALUES ('231282', '肇东市', '231200');
INSERT INTO `pro_city_area` VALUES ('231283', '海伦市', '231200');
INSERT INTO `pro_city_area` VALUES ('232700', '大兴安岭地区', '230000');
INSERT INTO `pro_city_area` VALUES ('232721', '呼玛县', '232700');
INSERT INTO `pro_city_area` VALUES ('232722', '塔河县', '232700');
INSERT INTO `pro_city_area` VALUES ('232723', '漠河县', '232700');
INSERT INTO `pro_city_area` VALUES ('310000', '上海市', '0');
INSERT INTO `pro_city_area` VALUES ('310100', '市辖区', '310000');
INSERT INTO `pro_city_area` VALUES ('310101', '黄浦区', '310100');
INSERT INTO `pro_city_area` VALUES ('310103', '卢湾区', '310100');
INSERT INTO `pro_city_area` VALUES ('310104', '徐汇区', '310100');
INSERT INTO `pro_city_area` VALUES ('310105', '长宁区', '310100');
INSERT INTO `pro_city_area` VALUES ('310106', '静安区', '310100');
INSERT INTO `pro_city_area` VALUES ('310107', '普陀区', '310100');
INSERT INTO `pro_city_area` VALUES ('310108', '闸北区', '310100');
INSERT INTO `pro_city_area` VALUES ('310109', '虹口区', '310100');
INSERT INTO `pro_city_area` VALUES ('310110', '杨浦区', '310100');
INSERT INTO `pro_city_area` VALUES ('310112', '闵行区', '310100');
INSERT INTO `pro_city_area` VALUES ('310113', '宝山区', '310100');
INSERT INTO `pro_city_area` VALUES ('310114', '嘉定区', '310100');
INSERT INTO `pro_city_area` VALUES ('310115', '浦东新区', '310100');
INSERT INTO `pro_city_area` VALUES ('310116', '金山区', '310100');
INSERT INTO `pro_city_area` VALUES ('310117', '松江区', '310100');
INSERT INTO `pro_city_area` VALUES ('310118', '青浦区', '310100');
INSERT INTO `pro_city_area` VALUES ('310119', '南汇区', '310100');
INSERT INTO `pro_city_area` VALUES ('310120', '奉贤区', '310100');
INSERT INTO `pro_city_area` VALUES ('310200', '县', '310000');
INSERT INTO `pro_city_area` VALUES ('310230', '崇明县', '310200');
INSERT INTO `pro_city_area` VALUES ('320000', '江苏省', '0');
INSERT INTO `pro_city_area` VALUES ('320100', '南京市', '320000');
INSERT INTO `pro_city_area` VALUES ('320101', '市辖区', '320100');
INSERT INTO `pro_city_area` VALUES ('320102', '玄武区', '320100');
INSERT INTO `pro_city_area` VALUES ('320103', '白下区', '320100');
INSERT INTO `pro_city_area` VALUES ('320104', '秦淮区', '320100');
INSERT INTO `pro_city_area` VALUES ('320105', '建邺区', '320100');
INSERT INTO `pro_city_area` VALUES ('320106', '鼓楼区', '320100');
INSERT INTO `pro_city_area` VALUES ('320107', '下关区', '320100');
INSERT INTO `pro_city_area` VALUES ('320111', '浦口区', '320100');
INSERT INTO `pro_city_area` VALUES ('320113', '栖霞区', '320100');
INSERT INTO `pro_city_area` VALUES ('320114', '雨花台区', '320100');
INSERT INTO `pro_city_area` VALUES ('320115', '江宁区', '320100');
INSERT INTO `pro_city_area` VALUES ('320116', '六合区', '320100');
INSERT INTO `pro_city_area` VALUES ('320124', '溧水县', '320100');
INSERT INTO `pro_city_area` VALUES ('320125', '高淳县', '320100');
INSERT INTO `pro_city_area` VALUES ('320200', '无锡市', '320000');
INSERT INTO `pro_city_area` VALUES ('320201', '市辖区', '320200');
INSERT INTO `pro_city_area` VALUES ('320202', '崇安区', '320200');
INSERT INTO `pro_city_area` VALUES ('320203', '南长区', '320200');
INSERT INTO `pro_city_area` VALUES ('320204', '北塘区', '320200');
INSERT INTO `pro_city_area` VALUES ('320205', '锡山区', '320200');
INSERT INTO `pro_city_area` VALUES ('320206', '惠山区', '320200');
INSERT INTO `pro_city_area` VALUES ('320211', '滨湖区', '320200');
INSERT INTO `pro_city_area` VALUES ('320281', '江阴市', '320200');
INSERT INTO `pro_city_area` VALUES ('320282', '宜兴市', '320200');
INSERT INTO `pro_city_area` VALUES ('320300', '徐州市', '320000');
INSERT INTO `pro_city_area` VALUES ('320301', '市辖区', '320300');
INSERT INTO `pro_city_area` VALUES ('320302', '鼓楼区', '320300');
INSERT INTO `pro_city_area` VALUES ('320303', '云龙区', '320300');
INSERT INTO `pro_city_area` VALUES ('320304', '九里区', '320300');
INSERT INTO `pro_city_area` VALUES ('320305', '贾汪区', '320300');
INSERT INTO `pro_city_area` VALUES ('320311', '泉山区', '320300');
INSERT INTO `pro_city_area` VALUES ('320321', '丰　县', '320300');
INSERT INTO `pro_city_area` VALUES ('320322', '沛　县', '320300');
INSERT INTO `pro_city_area` VALUES ('320323', '铜山县', '320300');
INSERT INTO `pro_city_area` VALUES ('320324', '睢宁县', '320300');
INSERT INTO `pro_city_area` VALUES ('320381', '新沂市', '320300');
INSERT INTO `pro_city_area` VALUES ('320382', '邳州市', '320300');
INSERT INTO `pro_city_area` VALUES ('320400', '常州市', '320000');
INSERT INTO `pro_city_area` VALUES ('320401', '市辖区', '320400');
INSERT INTO `pro_city_area` VALUES ('320402', '天宁区', '320400');
INSERT INTO `pro_city_area` VALUES ('320404', '钟楼区', '320400');
INSERT INTO `pro_city_area` VALUES ('320405', '戚墅堰区', '320400');
INSERT INTO `pro_city_area` VALUES ('320411', '新北区', '320400');
INSERT INTO `pro_city_area` VALUES ('320412', '武进区', '320400');
INSERT INTO `pro_city_area` VALUES ('320481', '溧阳市', '320400');
INSERT INTO `pro_city_area` VALUES ('320482', '金坛市', '320400');
INSERT INTO `pro_city_area` VALUES ('320500', '苏州市', '320000');
INSERT INTO `pro_city_area` VALUES ('320501', '市辖区', '320500');
INSERT INTO `pro_city_area` VALUES ('320502', '沧浪区', '320500');
INSERT INTO `pro_city_area` VALUES ('320503', '平江区', '320500');
INSERT INTO `pro_city_area` VALUES ('320504', '金阊区', '320500');
INSERT INTO `pro_city_area` VALUES ('320505', '虎丘区', '320500');
INSERT INTO `pro_city_area` VALUES ('320506', '吴中区', '320500');
INSERT INTO `pro_city_area` VALUES ('320507', '相城区', '320500');
INSERT INTO `pro_city_area` VALUES ('320581', '常熟市', '320500');
INSERT INTO `pro_city_area` VALUES ('320582', '张家港市', '320500');
INSERT INTO `pro_city_area` VALUES ('320583', '昆山市', '320500');
INSERT INTO `pro_city_area` VALUES ('320584', '吴江市', '320500');
INSERT INTO `pro_city_area` VALUES ('320585', '太仓市', '320500');
INSERT INTO `pro_city_area` VALUES ('320600', '南通市', '320000');
INSERT INTO `pro_city_area` VALUES ('320601', '市辖区', '320600');
INSERT INTO `pro_city_area` VALUES ('320602', '崇川区', '320600');
INSERT INTO `pro_city_area` VALUES ('320611', '港闸区', '320600');
INSERT INTO `pro_city_area` VALUES ('320621', '海安县', '320600');
INSERT INTO `pro_city_area` VALUES ('320623', '如东县', '320600');
INSERT INTO `pro_city_area` VALUES ('320681', '启东市', '320600');
INSERT INTO `pro_city_area` VALUES ('320682', '如皋市', '320600');
INSERT INTO `pro_city_area` VALUES ('320683', '通州市', '320600');
INSERT INTO `pro_city_area` VALUES ('320684', '海门市', '320600');
INSERT INTO `pro_city_area` VALUES ('320700', '连云港市', '320000');
INSERT INTO `pro_city_area` VALUES ('320701', '市辖区', '320700');
INSERT INTO `pro_city_area` VALUES ('320703', '连云区', '320700');
INSERT INTO `pro_city_area` VALUES ('320705', '新浦区', '320700');
INSERT INTO `pro_city_area` VALUES ('320706', '海州区', '320700');
INSERT INTO `pro_city_area` VALUES ('320721', '赣榆县', '320700');
INSERT INTO `pro_city_area` VALUES ('320722', '东海县', '320700');
INSERT INTO `pro_city_area` VALUES ('320723', '灌云县', '320700');
INSERT INTO `pro_city_area` VALUES ('320724', '灌南县', '320700');
INSERT INTO `pro_city_area` VALUES ('320800', '淮安市', '320000');
INSERT INTO `pro_city_area` VALUES ('320801', '市辖区', '320800');
INSERT INTO `pro_city_area` VALUES ('320802', '清河区', '320800');
INSERT INTO `pro_city_area` VALUES ('320803', '楚州区', '320800');
INSERT INTO `pro_city_area` VALUES ('320804', '淮阴区', '320800');
INSERT INTO `pro_city_area` VALUES ('320811', '清浦区', '320800');
INSERT INTO `pro_city_area` VALUES ('320826', '涟水县', '320800');
INSERT INTO `pro_city_area` VALUES ('320829', '洪泽县', '320800');
INSERT INTO `pro_city_area` VALUES ('320830', '盱眙县', '320800');
INSERT INTO `pro_city_area` VALUES ('320831', '金湖县', '320800');
INSERT INTO `pro_city_area` VALUES ('320900', '盐城市', '320000');
INSERT INTO `pro_city_area` VALUES ('320901', '市辖区', '320900');
INSERT INTO `pro_city_area` VALUES ('320902', '亭湖区', '320900');
INSERT INTO `pro_city_area` VALUES ('320903', '盐都区', '320900');
INSERT INTO `pro_city_area` VALUES ('320921', '响水县', '320900');
INSERT INTO `pro_city_area` VALUES ('320922', '滨海县', '320900');
INSERT INTO `pro_city_area` VALUES ('320923', '阜宁县', '320900');
INSERT INTO `pro_city_area` VALUES ('320924', '射阳县', '320900');
INSERT INTO `pro_city_area` VALUES ('320925', '建湖县', '320900');
INSERT INTO `pro_city_area` VALUES ('320981', '东台市', '320900');
INSERT INTO `pro_city_area` VALUES ('320982', '大丰市', '320900');
INSERT INTO `pro_city_area` VALUES ('321000', '扬州市', '320000');
INSERT INTO `pro_city_area` VALUES ('321001', '市辖区', '321000');
INSERT INTO `pro_city_area` VALUES ('321002', '广陵区', '321000');
INSERT INTO `pro_city_area` VALUES ('321003', '邗江区', '321000');
INSERT INTO `pro_city_area` VALUES ('321011', '郊　区', '321000');
INSERT INTO `pro_city_area` VALUES ('321023', '宝应县', '321000');
INSERT INTO `pro_city_area` VALUES ('321081', '仪征市', '321000');
INSERT INTO `pro_city_area` VALUES ('321084', '高邮市', '321000');
INSERT INTO `pro_city_area` VALUES ('321088', '江都市', '321000');
INSERT INTO `pro_city_area` VALUES ('321100', '镇江市', '320000');
INSERT INTO `pro_city_area` VALUES ('321101', '市辖区', '321100');
INSERT INTO `pro_city_area` VALUES ('321102', '京口区', '321100');
INSERT INTO `pro_city_area` VALUES ('321111', '润州区', '321100');
INSERT INTO `pro_city_area` VALUES ('321112', '丹徒区', '321100');
INSERT INTO `pro_city_area` VALUES ('321181', '丹阳市', '321100');
INSERT INTO `pro_city_area` VALUES ('321182', '扬中市', '321100');
INSERT INTO `pro_city_area` VALUES ('321183', '句容市', '321100');
INSERT INTO `pro_city_area` VALUES ('321200', '泰州市', '320000');
INSERT INTO `pro_city_area` VALUES ('321201', '市辖区', '321200');
INSERT INTO `pro_city_area` VALUES ('321202', '海陵区', '321200');
INSERT INTO `pro_city_area` VALUES ('321203', '高港区', '321200');
INSERT INTO `pro_city_area` VALUES ('321281', '兴化市', '321200');
INSERT INTO `pro_city_area` VALUES ('321282', '靖江市', '321200');
INSERT INTO `pro_city_area` VALUES ('321283', '泰兴市', '321200');
INSERT INTO `pro_city_area` VALUES ('321284', '姜堰市', '321200');
INSERT INTO `pro_city_area` VALUES ('321300', '宿迁市', '320000');
INSERT INTO `pro_city_area` VALUES ('321301', '市辖区', '321300');
INSERT INTO `pro_city_area` VALUES ('321302', '宿城区', '321300');
INSERT INTO `pro_city_area` VALUES ('321311', '宿豫区', '321300');
INSERT INTO `pro_city_area` VALUES ('321322', '沭阳县', '321300');
INSERT INTO `pro_city_area` VALUES ('321323', '泗阳县', '321300');
INSERT INTO `pro_city_area` VALUES ('321324', '泗洪县', '321300');
INSERT INTO `pro_city_area` VALUES ('330000', '浙江省', '0');
INSERT INTO `pro_city_area` VALUES ('330100', '杭州市', '330000');
INSERT INTO `pro_city_area` VALUES ('330101', '市辖区', '330100');
INSERT INTO `pro_city_area` VALUES ('330102', '上城区', '330100');
INSERT INTO `pro_city_area` VALUES ('330103', '下城区', '330100');
INSERT INTO `pro_city_area` VALUES ('330104', '江干区', '330100');
INSERT INTO `pro_city_area` VALUES ('330105', '拱墅区', '330100');
INSERT INTO `pro_city_area` VALUES ('330106', '西湖区', '330100');
INSERT INTO `pro_city_area` VALUES ('330108', '滨江区', '330100');
INSERT INTO `pro_city_area` VALUES ('330109', '萧山区', '330100');
INSERT INTO `pro_city_area` VALUES ('330110', '余杭区', '330100');
INSERT INTO `pro_city_area` VALUES ('330122', '桐庐县', '330100');
INSERT INTO `pro_city_area` VALUES ('330127', '淳安县', '330100');
INSERT INTO `pro_city_area` VALUES ('330182', '建德市', '330100');
INSERT INTO `pro_city_area` VALUES ('330183', '富阳市', '330100');
INSERT INTO `pro_city_area` VALUES ('330185', '临安市', '330100');
INSERT INTO `pro_city_area` VALUES ('330200', '宁波市', '330000');
INSERT INTO `pro_city_area` VALUES ('330201', '市辖区', '330200');
INSERT INTO `pro_city_area` VALUES ('330203', '海曙区', '330200');
INSERT INTO `pro_city_area` VALUES ('330204', '江东区', '330200');
INSERT INTO `pro_city_area` VALUES ('330205', '江北区', '330200');
INSERT INTO `pro_city_area` VALUES ('330206', '北仑区', '330200');
INSERT INTO `pro_city_area` VALUES ('330211', '镇海区', '330200');
INSERT INTO `pro_city_area` VALUES ('330212', '鄞州区', '330200');
INSERT INTO `pro_city_area` VALUES ('330225', '象山县', '330200');
INSERT INTO `pro_city_area` VALUES ('330226', '宁海县', '330200');
INSERT INTO `pro_city_area` VALUES ('330281', '余姚市', '330200');
INSERT INTO `pro_city_area` VALUES ('330282', '慈溪市', '330200');
INSERT INTO `pro_city_area` VALUES ('330283', '奉化市', '330200');
INSERT INTO `pro_city_area` VALUES ('330300', '温州市', '330000');
INSERT INTO `pro_city_area` VALUES ('330301', '市辖区', '330300');
INSERT INTO `pro_city_area` VALUES ('330302', '鹿城区', '330300');
INSERT INTO `pro_city_area` VALUES ('330303', '龙湾区', '330300');
INSERT INTO `pro_city_area` VALUES ('330304', '瓯海区', '330300');
INSERT INTO `pro_city_area` VALUES ('330322', '洞头县', '330300');
INSERT INTO `pro_city_area` VALUES ('330324', '永嘉县', '330300');
INSERT INTO `pro_city_area` VALUES ('330326', '平阳县', '330300');
INSERT INTO `pro_city_area` VALUES ('330327', '苍南县', '330300');
INSERT INTO `pro_city_area` VALUES ('330328', '文成县', '330300');
INSERT INTO `pro_city_area` VALUES ('330329', '泰顺县', '330300');
INSERT INTO `pro_city_area` VALUES ('330381', '瑞安市', '330300');
INSERT INTO `pro_city_area` VALUES ('330382', '乐清市', '330300');
INSERT INTO `pro_city_area` VALUES ('330400', '嘉兴市', '330000');
INSERT INTO `pro_city_area` VALUES ('330401', '市辖区', '330400');
INSERT INTO `pro_city_area` VALUES ('330402', '秀城区', '330400');
INSERT INTO `pro_city_area` VALUES ('330411', '秀洲区', '330400');
INSERT INTO `pro_city_area` VALUES ('330421', '嘉善县', '330400');
INSERT INTO `pro_city_area` VALUES ('330424', '海盐县', '330400');
INSERT INTO `pro_city_area` VALUES ('330481', '海宁市', '330400');
INSERT INTO `pro_city_area` VALUES ('330482', '平湖市', '330400');
INSERT INTO `pro_city_area` VALUES ('330483', '桐乡市', '330400');
INSERT INTO `pro_city_area` VALUES ('330500', '湖州市', '330000');
INSERT INTO `pro_city_area` VALUES ('330501', '市辖区', '330500');
INSERT INTO `pro_city_area` VALUES ('330502', '吴兴区', '330500');
INSERT INTO `pro_city_area` VALUES ('330503', '南浔区', '330500');
INSERT INTO `pro_city_area` VALUES ('330521', '德清县', '330500');
INSERT INTO `pro_city_area` VALUES ('330522', '长兴县', '330500');
INSERT INTO `pro_city_area` VALUES ('330523', '安吉县', '330500');
INSERT INTO `pro_city_area` VALUES ('330600', '绍兴市', '330000');
INSERT INTO `pro_city_area` VALUES ('330601', '市辖区', '330600');
INSERT INTO `pro_city_area` VALUES ('330602', '越城区', '330600');
INSERT INTO `pro_city_area` VALUES ('330621', '绍兴县', '330600');
INSERT INTO `pro_city_area` VALUES ('330624', '新昌县', '330600');
INSERT INTO `pro_city_area` VALUES ('330681', '诸暨市', '330600');
INSERT INTO `pro_city_area` VALUES ('330682', '上虞市', '330600');
INSERT INTO `pro_city_area` VALUES ('330683', '嵊州市', '330600');
INSERT INTO `pro_city_area` VALUES ('330700', '金华市', '330000');
INSERT INTO `pro_city_area` VALUES ('330701', '市辖区', '330700');
INSERT INTO `pro_city_area` VALUES ('330702', '婺城区', '330700');
INSERT INTO `pro_city_area` VALUES ('330703', '金东区', '330700');
INSERT INTO `pro_city_area` VALUES ('330723', '武义县', '330700');
INSERT INTO `pro_city_area` VALUES ('330726', '浦江县', '330700');
INSERT INTO `pro_city_area` VALUES ('330727', '磐安县', '330700');
INSERT INTO `pro_city_area` VALUES ('330781', '兰溪市', '330700');
INSERT INTO `pro_city_area` VALUES ('330782', '义乌市', '330700');
INSERT INTO `pro_city_area` VALUES ('330783', '东阳市', '330700');
INSERT INTO `pro_city_area` VALUES ('330784', '永康市', '330700');
INSERT INTO `pro_city_area` VALUES ('330800', '衢州市', '330000');
INSERT INTO `pro_city_area` VALUES ('330801', '市辖区', '330800');
INSERT INTO `pro_city_area` VALUES ('330802', '柯城区', '330800');
INSERT INTO `pro_city_area` VALUES ('330803', '衢江区', '330800');
INSERT INTO `pro_city_area` VALUES ('330822', '常山县', '330800');
INSERT INTO `pro_city_area` VALUES ('330824', '开化县', '330800');
INSERT INTO `pro_city_area` VALUES ('330825', '龙游县', '330800');
INSERT INTO `pro_city_area` VALUES ('330881', '江山市', '330800');
INSERT INTO `pro_city_area` VALUES ('330900', '舟山市', '330000');
INSERT INTO `pro_city_area` VALUES ('330901', '市辖区', '330900');
INSERT INTO `pro_city_area` VALUES ('330902', '定海区', '330900');
INSERT INTO `pro_city_area` VALUES ('330903', '普陀区', '330900');
INSERT INTO `pro_city_area` VALUES ('330921', '岱山县', '330900');
INSERT INTO `pro_city_area` VALUES ('330922', '嵊泗县', '330900');
INSERT INTO `pro_city_area` VALUES ('331000', '台州市', '330000');
INSERT INTO `pro_city_area` VALUES ('331001', '市辖区', '331000');
INSERT INTO `pro_city_area` VALUES ('331002', '椒江区', '331000');
INSERT INTO `pro_city_area` VALUES ('331003', '黄岩区', '331000');
INSERT INTO `pro_city_area` VALUES ('331004', '路桥区', '331000');
INSERT INTO `pro_city_area` VALUES ('331021', '玉环县', '331000');
INSERT INTO `pro_city_area` VALUES ('331022', '三门县', '331000');
INSERT INTO `pro_city_area` VALUES ('331023', '天台县', '331000');
INSERT INTO `pro_city_area` VALUES ('331024', '仙居县', '331000');
INSERT INTO `pro_city_area` VALUES ('331081', '温岭市', '331000');
INSERT INTO `pro_city_area` VALUES ('331082', '临海市', '331000');
INSERT INTO `pro_city_area` VALUES ('331100', '丽水市', '330000');
INSERT INTO `pro_city_area` VALUES ('331101', '市辖区', '331100');
INSERT INTO `pro_city_area` VALUES ('331102', '莲都区', '331100');
INSERT INTO `pro_city_area` VALUES ('331121', '青田县', '331100');
INSERT INTO `pro_city_area` VALUES ('331122', '缙云县', '331100');
INSERT INTO `pro_city_area` VALUES ('331123', '遂昌县', '331100');
INSERT INTO `pro_city_area` VALUES ('331124', '松阳县', '331100');
INSERT INTO `pro_city_area` VALUES ('331125', '云和县', '331100');
INSERT INTO `pro_city_area` VALUES ('331126', '庆元县', '331100');
INSERT INTO `pro_city_area` VALUES ('331127', '景宁畲族自治县', '331100');
INSERT INTO `pro_city_area` VALUES ('331181', '龙泉市', '331100');
INSERT INTO `pro_city_area` VALUES ('340000', '安徽省', '0');
INSERT INTO `pro_city_area` VALUES ('340100', '合肥市', '340000');
INSERT INTO `pro_city_area` VALUES ('340101', '市辖区', '340100');
INSERT INTO `pro_city_area` VALUES ('340102', '瑶海区', '340100');
INSERT INTO `pro_city_area` VALUES ('340103', '庐阳区', '340100');
INSERT INTO `pro_city_area` VALUES ('340104', '蜀山区', '340100');
INSERT INTO `pro_city_area` VALUES ('340111', '包河区', '340100');
INSERT INTO `pro_city_area` VALUES ('340121', '长丰县', '340100');
INSERT INTO `pro_city_area` VALUES ('340122', '肥东县', '340100');
INSERT INTO `pro_city_area` VALUES ('340123', '肥西县', '340100');
INSERT INTO `pro_city_area` VALUES ('340200', '芜湖市', '340000');
INSERT INTO `pro_city_area` VALUES ('340201', '市辖区', '340200');
INSERT INTO `pro_city_area` VALUES ('340202', '镜湖区', '340200');
INSERT INTO `pro_city_area` VALUES ('340203', '马塘区', '340200');
INSERT INTO `pro_city_area` VALUES ('340204', '新芜区', '340200');
INSERT INTO `pro_city_area` VALUES ('340207', '鸠江区', '340200');
INSERT INTO `pro_city_area` VALUES ('340221', '芜湖县', '340200');
INSERT INTO `pro_city_area` VALUES ('340222', '繁昌县', '340200');
INSERT INTO `pro_city_area` VALUES ('340223', '南陵县', '340200');
INSERT INTO `pro_city_area` VALUES ('340300', '蚌埠市', '340000');
INSERT INTO `pro_city_area` VALUES ('340301', '市辖区', '340300');
INSERT INTO `pro_city_area` VALUES ('340302', '龙子湖区', '340300');
INSERT INTO `pro_city_area` VALUES ('340303', '蚌山区', '340300');
INSERT INTO `pro_city_area` VALUES ('340304', '禹会区', '340300');
INSERT INTO `pro_city_area` VALUES ('340311', '淮上区', '340300');
INSERT INTO `pro_city_area` VALUES ('340321', '怀远县', '340300');
INSERT INTO `pro_city_area` VALUES ('340322', '五河县', '340300');
INSERT INTO `pro_city_area` VALUES ('340323', '固镇县', '340300');
INSERT INTO `pro_city_area` VALUES ('340400', '淮南市', '340000');
INSERT INTO `pro_city_area` VALUES ('340401', '市辖区', '340400');
INSERT INTO `pro_city_area` VALUES ('340402', '大通区', '340400');
INSERT INTO `pro_city_area` VALUES ('340403', '田家庵区', '340400');
INSERT INTO `pro_city_area` VALUES ('340404', '谢家集区', '340400');
INSERT INTO `pro_city_area` VALUES ('340405', '八公山区', '340400');
INSERT INTO `pro_city_area` VALUES ('340406', '潘集区', '340400');
INSERT INTO `pro_city_area` VALUES ('340421', '凤台县', '340400');
INSERT INTO `pro_city_area` VALUES ('340500', '马鞍山市', '340000');
INSERT INTO `pro_city_area` VALUES ('340501', '市辖区', '340500');
INSERT INTO `pro_city_area` VALUES ('340502', '金家庄区', '340500');
INSERT INTO `pro_city_area` VALUES ('340503', '花山区', '340500');
INSERT INTO `pro_city_area` VALUES ('340504', '雨山区', '340500');
INSERT INTO `pro_city_area` VALUES ('340521', '当涂县', '340500');
INSERT INTO `pro_city_area` VALUES ('340600', '淮北市', '340000');
INSERT INTO `pro_city_area` VALUES ('340601', '市辖区', '340600');
INSERT INTO `pro_city_area` VALUES ('340602', '杜集区', '340600');
INSERT INTO `pro_city_area` VALUES ('340603', '相山区', '340600');
INSERT INTO `pro_city_area` VALUES ('340604', '烈山区', '340600');
INSERT INTO `pro_city_area` VALUES ('340621', '濉溪县', '340600');
INSERT INTO `pro_city_area` VALUES ('340700', '铜陵市', '340000');
INSERT INTO `pro_city_area` VALUES ('340701', '市辖区', '340700');
INSERT INTO `pro_city_area` VALUES ('340702', '铜官山区', '340700');
INSERT INTO `pro_city_area` VALUES ('340703', '狮子山区', '340700');
INSERT INTO `pro_city_area` VALUES ('340711', '郊　区', '340700');
INSERT INTO `pro_city_area` VALUES ('340721', '铜陵县', '340700');
INSERT INTO `pro_city_area` VALUES ('340800', '安庆市', '340000');
INSERT INTO `pro_city_area` VALUES ('340801', '市辖区', '340800');
INSERT INTO `pro_city_area` VALUES ('340802', '迎江区', '340800');
INSERT INTO `pro_city_area` VALUES ('340803', '大观区', '340800');
INSERT INTO `pro_city_area` VALUES ('340811', '郊　区', '340800');
INSERT INTO `pro_city_area` VALUES ('340822', '怀宁县', '340800');
INSERT INTO `pro_city_area` VALUES ('340823', '枞阳县', '340800');
INSERT INTO `pro_city_area` VALUES ('340824', '潜山县', '340800');
INSERT INTO `pro_city_area` VALUES ('340825', '太湖县', '340800');
INSERT INTO `pro_city_area` VALUES ('340826', '宿松县', '340800');
INSERT INTO `pro_city_area` VALUES ('340827', '望江县', '340800');
INSERT INTO `pro_city_area` VALUES ('340828', '岳西县', '340800');
INSERT INTO `pro_city_area` VALUES ('340881', '桐城市', '340800');
INSERT INTO `pro_city_area` VALUES ('341000', '黄山市', '340000');
INSERT INTO `pro_city_area` VALUES ('341001', '市辖区', '341000');
INSERT INTO `pro_city_area` VALUES ('341002', '屯溪区', '341000');
INSERT INTO `pro_city_area` VALUES ('341003', '黄山区', '341000');
INSERT INTO `pro_city_area` VALUES ('341004', '徽州区', '341000');
INSERT INTO `pro_city_area` VALUES ('341021', '歙　县', '341000');
INSERT INTO `pro_city_area` VALUES ('341022', '休宁县', '341000');
INSERT INTO `pro_city_area` VALUES ('341023', '黟　县', '341000');
INSERT INTO `pro_city_area` VALUES ('341024', '祁门县', '341000');
INSERT INTO `pro_city_area` VALUES ('341100', '滁州市', '340000');
INSERT INTO `pro_city_area` VALUES ('341101', '市辖区', '341100');
INSERT INTO `pro_city_area` VALUES ('341102', '琅琊区', '341100');
INSERT INTO `pro_city_area` VALUES ('341103', '南谯区', '341100');
INSERT INTO `pro_city_area` VALUES ('341122', '来安县', '341100');
INSERT INTO `pro_city_area` VALUES ('341124', '全椒县', '341100');
INSERT INTO `pro_city_area` VALUES ('341125', '定远县', '341100');
INSERT INTO `pro_city_area` VALUES ('341126', '凤阳县', '341100');
INSERT INTO `pro_city_area` VALUES ('341181', '天长市', '341100');
INSERT INTO `pro_city_area` VALUES ('341182', '明光市', '341100');
INSERT INTO `pro_city_area` VALUES ('341200', '阜阳市', '340000');
INSERT INTO `pro_city_area` VALUES ('341201', '市辖区', '341200');
INSERT INTO `pro_city_area` VALUES ('341202', '颍州区', '341200');
INSERT INTO `pro_city_area` VALUES ('341203', '颍东区', '341200');
INSERT INTO `pro_city_area` VALUES ('341204', '颍泉区', '341200');
INSERT INTO `pro_city_area` VALUES ('341221', '临泉县', '341200');
INSERT INTO `pro_city_area` VALUES ('341222', '太和县', '341200');
INSERT INTO `pro_city_area` VALUES ('341225', '阜南县', '341200');
INSERT INTO `pro_city_area` VALUES ('341226', '颍上县', '341200');
INSERT INTO `pro_city_area` VALUES ('341282', '界首市', '341200');
INSERT INTO `pro_city_area` VALUES ('341300', '宿州市', '340000');
INSERT INTO `pro_city_area` VALUES ('341301', '市辖区', '341300');
INSERT INTO `pro_city_area` VALUES ('341302', '墉桥区', '341300');
INSERT INTO `pro_city_area` VALUES ('341321', '砀山县', '341300');
INSERT INTO `pro_city_area` VALUES ('341322', '萧　县', '341300');
INSERT INTO `pro_city_area` VALUES ('341323', '灵璧县', '341300');
INSERT INTO `pro_city_area` VALUES ('341324', '泗　县', '341300');
INSERT INTO `pro_city_area` VALUES ('341400', '巢湖市', '340000');
INSERT INTO `pro_city_area` VALUES ('341401', '市辖区', '341400');
INSERT INTO `pro_city_area` VALUES ('341402', '居巢区', '341400');
INSERT INTO `pro_city_area` VALUES ('341421', '庐江县', '341400');
INSERT INTO `pro_city_area` VALUES ('341422', '无为县', '341400');
INSERT INTO `pro_city_area` VALUES ('341423', '含山县', '341400');
INSERT INTO `pro_city_area` VALUES ('341424', '和　县', '341400');
INSERT INTO `pro_city_area` VALUES ('341500', '六安市', '340000');
INSERT INTO `pro_city_area` VALUES ('341501', '市辖区', '341500');
INSERT INTO `pro_city_area` VALUES ('341502', '金安区', '341500');
INSERT INTO `pro_city_area` VALUES ('341503', '裕安区', '341500');
INSERT INTO `pro_city_area` VALUES ('341521', '寿　县', '341500');
INSERT INTO `pro_city_area` VALUES ('341522', '霍邱县', '341500');
INSERT INTO `pro_city_area` VALUES ('341523', '舒城县', '341500');
INSERT INTO `pro_city_area` VALUES ('341524', '金寨县', '341500');
INSERT INTO `pro_city_area` VALUES ('341525', '霍山县', '341500');
INSERT INTO `pro_city_area` VALUES ('341600', '亳州市', '340000');
INSERT INTO `pro_city_area` VALUES ('341601', '市辖区', '341600');
INSERT INTO `pro_city_area` VALUES ('341602', '谯城区', '341600');
INSERT INTO `pro_city_area` VALUES ('341621', '涡阳县', '341600');
INSERT INTO `pro_city_area` VALUES ('341622', '蒙城县', '341600');
INSERT INTO `pro_city_area` VALUES ('341623', '利辛县', '341600');
INSERT INTO `pro_city_area` VALUES ('341700', '池州市', '340000');
INSERT INTO `pro_city_area` VALUES ('341701', '市辖区', '341700');
INSERT INTO `pro_city_area` VALUES ('341702', '贵池区', '341700');
INSERT INTO `pro_city_area` VALUES ('341721', '东至县', '341700');
INSERT INTO `pro_city_area` VALUES ('341722', '石台县', '341700');
INSERT INTO `pro_city_area` VALUES ('341723', '青阳县', '341700');
INSERT INTO `pro_city_area` VALUES ('341800', '宣城市', '340000');
INSERT INTO `pro_city_area` VALUES ('341801', '市辖区', '341800');
INSERT INTO `pro_city_area` VALUES ('341802', '宣州区', '341800');
INSERT INTO `pro_city_area` VALUES ('341821', '郎溪县', '341800');
INSERT INTO `pro_city_area` VALUES ('341822', '广德县', '341800');
INSERT INTO `pro_city_area` VALUES ('341823', '泾　县', '341800');
INSERT INTO `pro_city_area` VALUES ('341824', '绩溪县', '341800');
INSERT INTO `pro_city_area` VALUES ('341825', '旌德县', '341800');
INSERT INTO `pro_city_area` VALUES ('341881', '宁国市', '341800');
INSERT INTO `pro_city_area` VALUES ('350000', '福建省', '0');
INSERT INTO `pro_city_area` VALUES ('350100', '福州市', '350000');
INSERT INTO `pro_city_area` VALUES ('350101', '市辖区', '350100');
INSERT INTO `pro_city_area` VALUES ('350102', '鼓楼区', '350100');
INSERT INTO `pro_city_area` VALUES ('350103', '台江区', '350100');
INSERT INTO `pro_city_area` VALUES ('350104', '仓山区', '350100');
INSERT INTO `pro_city_area` VALUES ('350105', '马尾区', '350100');
INSERT INTO `pro_city_area` VALUES ('350111', '晋安区', '350100');
INSERT INTO `pro_city_area` VALUES ('350121', '闽侯县', '350100');
INSERT INTO `pro_city_area` VALUES ('350122', '连江县', '350100');
INSERT INTO `pro_city_area` VALUES ('350123', '罗源县', '350100');
INSERT INTO `pro_city_area` VALUES ('350124', '闽清县', '350100');
INSERT INTO `pro_city_area` VALUES ('350125', '永泰县', '350100');
INSERT INTO `pro_city_area` VALUES ('350128', '平潭县', '350100');
INSERT INTO `pro_city_area` VALUES ('350181', '福清市', '350100');
INSERT INTO `pro_city_area` VALUES ('350182', '长乐市', '350100');
INSERT INTO `pro_city_area` VALUES ('350200', '厦门市', '350000');
INSERT INTO `pro_city_area` VALUES ('350201', '市辖区', '350200');
INSERT INTO `pro_city_area` VALUES ('350203', '思明区', '350200');
INSERT INTO `pro_city_area` VALUES ('350205', '海沧区', '350200');
INSERT INTO `pro_city_area` VALUES ('350206', '湖里区', '350200');
INSERT INTO `pro_city_area` VALUES ('350211', '集美区', '350200');
INSERT INTO `pro_city_area` VALUES ('350212', '同安区', '350200');
INSERT INTO `pro_city_area` VALUES ('350213', '翔安区', '350200');
INSERT INTO `pro_city_area` VALUES ('350300', '莆田市', '350000');
INSERT INTO `pro_city_area` VALUES ('350301', '市辖区', '350300');
INSERT INTO `pro_city_area` VALUES ('350302', '城厢区', '350300');
INSERT INTO `pro_city_area` VALUES ('350303', '涵江区', '350300');
INSERT INTO `pro_city_area` VALUES ('350304', '荔城区', '350300');
INSERT INTO `pro_city_area` VALUES ('350305', '秀屿区', '350300');
INSERT INTO `pro_city_area` VALUES ('350322', '仙游县', '350300');
INSERT INTO `pro_city_area` VALUES ('350400', '三明市', '350000');
INSERT INTO `pro_city_area` VALUES ('350401', '市辖区', '350400');
INSERT INTO `pro_city_area` VALUES ('350402', '梅列区', '350400');
INSERT INTO `pro_city_area` VALUES ('350403', '三元区', '350400');
INSERT INTO `pro_city_area` VALUES ('350421', '明溪县', '350400');
INSERT INTO `pro_city_area` VALUES ('350423', '清流县', '350400');
INSERT INTO `pro_city_area` VALUES ('350424', '宁化县', '350400');
INSERT INTO `pro_city_area` VALUES ('350425', '大田县', '350400');
INSERT INTO `pro_city_area` VALUES ('350426', '尤溪县', '350400');
INSERT INTO `pro_city_area` VALUES ('350427', '沙　县', '350400');
INSERT INTO `pro_city_area` VALUES ('350428', '将乐县', '350400');
INSERT INTO `pro_city_area` VALUES ('350429', '泰宁县', '350400');
INSERT INTO `pro_city_area` VALUES ('350430', '建宁县', '350400');
INSERT INTO `pro_city_area` VALUES ('350481', '永安市', '350400');
INSERT INTO `pro_city_area` VALUES ('350500', '泉州市', '350000');
INSERT INTO `pro_city_area` VALUES ('350501', '市辖区', '350500');
INSERT INTO `pro_city_area` VALUES ('350502', '鲤城区', '350500');
INSERT INTO `pro_city_area` VALUES ('350503', '丰泽区', '350500');
INSERT INTO `pro_city_area` VALUES ('350504', '洛江区', '350500');
INSERT INTO `pro_city_area` VALUES ('350505', '泉港区', '350500');
INSERT INTO `pro_city_area` VALUES ('350521', '惠安县', '350500');
INSERT INTO `pro_city_area` VALUES ('350524', '安溪县', '350500');
INSERT INTO `pro_city_area` VALUES ('350525', '永春县', '350500');
INSERT INTO `pro_city_area` VALUES ('350526', '德化县', '350500');
INSERT INTO `pro_city_area` VALUES ('350527', '金门县', '350500');
INSERT INTO `pro_city_area` VALUES ('350581', '石狮市', '350500');
INSERT INTO `pro_city_area` VALUES ('350582', '晋江市', '350500');
INSERT INTO `pro_city_area` VALUES ('350583', '南安市', '350500');
INSERT INTO `pro_city_area` VALUES ('350600', '漳州市', '350000');
INSERT INTO `pro_city_area` VALUES ('350601', '市辖区', '350600');
INSERT INTO `pro_city_area` VALUES ('350602', '芗城区', '350600');
INSERT INTO `pro_city_area` VALUES ('350603', '龙文区', '350600');
INSERT INTO `pro_city_area` VALUES ('350622', '云霄县', '350600');
INSERT INTO `pro_city_area` VALUES ('350623', '漳浦县', '350600');
INSERT INTO `pro_city_area` VALUES ('350624', '诏安县', '350600');
INSERT INTO `pro_city_area` VALUES ('350625', '长泰县', '350600');
INSERT INTO `pro_city_area` VALUES ('350626', '东山县', '350600');
INSERT INTO `pro_city_area` VALUES ('350627', '南靖县', '350600');
INSERT INTO `pro_city_area` VALUES ('350628', '平和县', '350600');
INSERT INTO `pro_city_area` VALUES ('350629', '华安县', '350600');
INSERT INTO `pro_city_area` VALUES ('350681', '龙海市', '350600');
INSERT INTO `pro_city_area` VALUES ('350700', '南平市', '350000');
INSERT INTO `pro_city_area` VALUES ('350701', '市辖区', '350700');
INSERT INTO `pro_city_area` VALUES ('350702', '延平区', '350700');
INSERT INTO `pro_city_area` VALUES ('350721', '顺昌县', '350700');
INSERT INTO `pro_city_area` VALUES ('350722', '浦城县', '350700');
INSERT INTO `pro_city_area` VALUES ('350723', '光泽县', '350700');
INSERT INTO `pro_city_area` VALUES ('350724', '松溪县', '350700');
INSERT INTO `pro_city_area` VALUES ('350725', '政和县', '350700');
INSERT INTO `pro_city_area` VALUES ('350781', '邵武市', '350700');
INSERT INTO `pro_city_area` VALUES ('350782', '武夷山市', '350700');
INSERT INTO `pro_city_area` VALUES ('350783', '建瓯市', '350700');
INSERT INTO `pro_city_area` VALUES ('350784', '建阳市', '350700');
INSERT INTO `pro_city_area` VALUES ('350800', '龙岩市', '350000');
INSERT INTO `pro_city_area` VALUES ('350801', '市辖区', '350800');
INSERT INTO `pro_city_area` VALUES ('350802', '新罗区', '350800');
INSERT INTO `pro_city_area` VALUES ('350821', '长汀县', '350800');
INSERT INTO `pro_city_area` VALUES ('350822', '永定县', '350800');
INSERT INTO `pro_city_area` VALUES ('350823', '上杭县', '350800');
INSERT INTO `pro_city_area` VALUES ('350824', '武平县', '350800');
INSERT INTO `pro_city_area` VALUES ('350825', '连城县', '350800');
INSERT INTO `pro_city_area` VALUES ('350881', '漳平市', '350800');
INSERT INTO `pro_city_area` VALUES ('350900', '宁德市', '350000');
INSERT INTO `pro_city_area` VALUES ('350901', '市辖区', '350900');
INSERT INTO `pro_city_area` VALUES ('350902', '蕉城区', '350900');
INSERT INTO `pro_city_area` VALUES ('350921', '霞浦县', '350900');
INSERT INTO `pro_city_area` VALUES ('350922', '古田县', '350900');
INSERT INTO `pro_city_area` VALUES ('350923', '屏南县', '350900');
INSERT INTO `pro_city_area` VALUES ('350924', '寿宁县', '350900');
INSERT INTO `pro_city_area` VALUES ('350925', '周宁县', '350900');
INSERT INTO `pro_city_area` VALUES ('350926', '柘荣县', '350900');
INSERT INTO `pro_city_area` VALUES ('350981', '福安市', '350900');
INSERT INTO `pro_city_area` VALUES ('350982', '福鼎市', '350900');
INSERT INTO `pro_city_area` VALUES ('360000', '江西省', '0');
INSERT INTO `pro_city_area` VALUES ('360100', '南昌市', '360000');
INSERT INTO `pro_city_area` VALUES ('360101', '市辖区', '360100');
INSERT INTO `pro_city_area` VALUES ('360102', '东湖区', '360100');
INSERT INTO `pro_city_area` VALUES ('360103', '西湖区', '360100');
INSERT INTO `pro_city_area` VALUES ('360104', '青云谱区', '360100');
INSERT INTO `pro_city_area` VALUES ('360105', '湾里区', '360100');
INSERT INTO `pro_city_area` VALUES ('360111', '青山湖区', '360100');
INSERT INTO `pro_city_area` VALUES ('360121', '南昌县', '360100');
INSERT INTO `pro_city_area` VALUES ('360122', '新建县', '360100');
INSERT INTO `pro_city_area` VALUES ('360123', '安义县', '360100');
INSERT INTO `pro_city_area` VALUES ('360124', '进贤县', '360100');
INSERT INTO `pro_city_area` VALUES ('360200', '景德镇市', '360000');
INSERT INTO `pro_city_area` VALUES ('360201', '市辖区', '360200');
INSERT INTO `pro_city_area` VALUES ('360202', '昌江区', '360200');
INSERT INTO `pro_city_area` VALUES ('360203', '珠山区', '360200');
INSERT INTO `pro_city_area` VALUES ('360222', '浮梁县', '360200');
INSERT INTO `pro_city_area` VALUES ('360281', '乐平市', '360200');
INSERT INTO `pro_city_area` VALUES ('360300', '萍乡市', '360000');
INSERT INTO `pro_city_area` VALUES ('360301', '市辖区', '360300');
INSERT INTO `pro_city_area` VALUES ('360302', '安源区', '360300');
INSERT INTO `pro_city_area` VALUES ('360313', '湘东区', '360300');
INSERT INTO `pro_city_area` VALUES ('360321', '莲花县', '360300');
INSERT INTO `pro_city_area` VALUES ('360322', '上栗县', '360300');
INSERT INTO `pro_city_area` VALUES ('360323', '芦溪县', '360300');
INSERT INTO `pro_city_area` VALUES ('360400', '九江市', '360000');
INSERT INTO `pro_city_area` VALUES ('360401', '市辖区', '360400');
INSERT INTO `pro_city_area` VALUES ('360402', '庐山区', '360400');
INSERT INTO `pro_city_area` VALUES ('360403', '浔阳区', '360400');
INSERT INTO `pro_city_area` VALUES ('360421', '九江县', '360400');
INSERT INTO `pro_city_area` VALUES ('360423', '武宁县', '360400');
INSERT INTO `pro_city_area` VALUES ('360424', '修水县', '360400');
INSERT INTO `pro_city_area` VALUES ('360425', '永修县', '360400');
INSERT INTO `pro_city_area` VALUES ('360426', '德安县', '360400');
INSERT INTO `pro_city_area` VALUES ('360427', '星子县', '360400');
INSERT INTO `pro_city_area` VALUES ('360428', '都昌县', '360400');
INSERT INTO `pro_city_area` VALUES ('360429', '湖口县', '360400');
INSERT INTO `pro_city_area` VALUES ('360430', '彭泽县', '360400');
INSERT INTO `pro_city_area` VALUES ('360481', '瑞昌市', '360400');
INSERT INTO `pro_city_area` VALUES ('360500', '新余市', '360000');
INSERT INTO `pro_city_area` VALUES ('360501', '市辖区', '360500');
INSERT INTO `pro_city_area` VALUES ('360502', '渝水区', '360500');
INSERT INTO `pro_city_area` VALUES ('360521', '分宜县', '360500');
INSERT INTO `pro_city_area` VALUES ('360600', '鹰潭市', '360000');
INSERT INTO `pro_city_area` VALUES ('360601', '市辖区', '360600');
INSERT INTO `pro_city_area` VALUES ('360602', '月湖区', '360600');
INSERT INTO `pro_city_area` VALUES ('360622', '余江县', '360600');
INSERT INTO `pro_city_area` VALUES ('360681', '贵溪市', '360600');
INSERT INTO `pro_city_area` VALUES ('360700', '赣州市', '360000');
INSERT INTO `pro_city_area` VALUES ('360701', '市辖区', '360700');
INSERT INTO `pro_city_area` VALUES ('360702', '章贡区', '360700');
INSERT INTO `pro_city_area` VALUES ('360721', '赣　县', '360700');
INSERT INTO `pro_city_area` VALUES ('360722', '信丰县', '360700');
INSERT INTO `pro_city_area` VALUES ('360723', '大余县', '360700');
INSERT INTO `pro_city_area` VALUES ('360724', '上犹县', '360700');
INSERT INTO `pro_city_area` VALUES ('360725', '崇义县', '360700');
INSERT INTO `pro_city_area` VALUES ('360726', '安远县', '360700');
INSERT INTO `pro_city_area` VALUES ('360727', '龙南县', '360700');
INSERT INTO `pro_city_area` VALUES ('360728', '定南县', '360700');
INSERT INTO `pro_city_area` VALUES ('360729', '全南县', '360700');
INSERT INTO `pro_city_area` VALUES ('360730', '宁都县', '360700');
INSERT INTO `pro_city_area` VALUES ('360731', '于都县', '360700');
INSERT INTO `pro_city_area` VALUES ('360732', '兴国县', '360700');
INSERT INTO `pro_city_area` VALUES ('360733', '会昌县', '360700');
INSERT INTO `pro_city_area` VALUES ('360734', '寻乌县', '360700');
INSERT INTO `pro_city_area` VALUES ('360735', '石城县', '360700');
INSERT INTO `pro_city_area` VALUES ('360781', '瑞金市', '360700');
INSERT INTO `pro_city_area` VALUES ('360782', '南康市', '360700');
INSERT INTO `pro_city_area` VALUES ('360800', '吉安市', '360000');
INSERT INTO `pro_city_area` VALUES ('360801', '市辖区', '360800');
INSERT INTO `pro_city_area` VALUES ('360802', '吉州区', '360800');
INSERT INTO `pro_city_area` VALUES ('360803', '青原区', '360800');
INSERT INTO `pro_city_area` VALUES ('360821', '吉安县', '360800');
INSERT INTO `pro_city_area` VALUES ('360822', '吉水县', '360800');
INSERT INTO `pro_city_area` VALUES ('360823', '峡江县', '360800');
INSERT INTO `pro_city_area` VALUES ('360824', '新干县', '360800');
INSERT INTO `pro_city_area` VALUES ('360825', '永丰县', '360800');
INSERT INTO `pro_city_area` VALUES ('360826', '泰和县', '360800');
INSERT INTO `pro_city_area` VALUES ('360827', '遂川县', '360800');
INSERT INTO `pro_city_area` VALUES ('360828', '万安县', '360800');
INSERT INTO `pro_city_area` VALUES ('360829', '安福县', '360800');
INSERT INTO `pro_city_area` VALUES ('360830', '永新县', '360800');
INSERT INTO `pro_city_area` VALUES ('360881', '井冈山市', '360800');
INSERT INTO `pro_city_area` VALUES ('360900', '宜春市', '360000');
INSERT INTO `pro_city_area` VALUES ('360901', '市辖区', '360900');
INSERT INTO `pro_city_area` VALUES ('360902', '袁州区', '360900');
INSERT INTO `pro_city_area` VALUES ('360921', '奉新县', '360900');
INSERT INTO `pro_city_area` VALUES ('360922', '万载县', '360900');
INSERT INTO `pro_city_area` VALUES ('360923', '上高县', '360900');
INSERT INTO `pro_city_area` VALUES ('360924', '宜丰县', '360900');
INSERT INTO `pro_city_area` VALUES ('360925', '靖安县', '360900');
INSERT INTO `pro_city_area` VALUES ('360926', '铜鼓县', '360900');
INSERT INTO `pro_city_area` VALUES ('360981', '丰城市', '360900');
INSERT INTO `pro_city_area` VALUES ('360982', '樟树市', '360900');
INSERT INTO `pro_city_area` VALUES ('360983', '高安市', '360900');
INSERT INTO `pro_city_area` VALUES ('361000', '抚州市', '360000');
INSERT INTO `pro_city_area` VALUES ('361001', '市辖区', '361000');
INSERT INTO `pro_city_area` VALUES ('361002', '临川区', '361000');
INSERT INTO `pro_city_area` VALUES ('361021', '南城县', '361000');
INSERT INTO `pro_city_area` VALUES ('361022', '黎川县', '361000');
INSERT INTO `pro_city_area` VALUES ('361023', '南丰县', '361000');
INSERT INTO `pro_city_area` VALUES ('361024', '崇仁县', '361000');
INSERT INTO `pro_city_area` VALUES ('361025', '乐安县', '361000');
INSERT INTO `pro_city_area` VALUES ('361026', '宜黄县', '361000');
INSERT INTO `pro_city_area` VALUES ('361027', '金溪县', '361000');
INSERT INTO `pro_city_area` VALUES ('361028', '资溪县', '361000');
INSERT INTO `pro_city_area` VALUES ('361029', '东乡县', '361000');
INSERT INTO `pro_city_area` VALUES ('361030', '广昌县', '361000');
INSERT INTO `pro_city_area` VALUES ('361100', '上饶市', '360000');
INSERT INTO `pro_city_area` VALUES ('361101', '市辖区', '361100');
INSERT INTO `pro_city_area` VALUES ('361102', '信州区', '361100');
INSERT INTO `pro_city_area` VALUES ('361121', '上饶县', '361100');
INSERT INTO `pro_city_area` VALUES ('361122', '广丰县', '361100');
INSERT INTO `pro_city_area` VALUES ('361123', '玉山县', '361100');
INSERT INTO `pro_city_area` VALUES ('361124', '铅山县', '361100');
INSERT INTO `pro_city_area` VALUES ('361125', '横峰县', '361100');
INSERT INTO `pro_city_area` VALUES ('361126', '弋阳县', '361100');
INSERT INTO `pro_city_area` VALUES ('361127', '余干县', '361100');
INSERT INTO `pro_city_area` VALUES ('361128', '鄱阳县', '361100');
INSERT INTO `pro_city_area` VALUES ('361129', '万年县', '361100');
INSERT INTO `pro_city_area` VALUES ('361130', '婺源县', '361100');
INSERT INTO `pro_city_area` VALUES ('361181', '德兴市', '361100');
INSERT INTO `pro_city_area` VALUES ('370000', '山东省', '0');
INSERT INTO `pro_city_area` VALUES ('370100', '济南市', '370000');
INSERT INTO `pro_city_area` VALUES ('370101', '市辖区', '370100');
INSERT INTO `pro_city_area` VALUES ('370102', '历下区', '370100');
INSERT INTO `pro_city_area` VALUES ('370103', '市中区', '370100');
INSERT INTO `pro_city_area` VALUES ('370104', '槐荫区', '370100');
INSERT INTO `pro_city_area` VALUES ('370105', '天桥区', '370100');
INSERT INTO `pro_city_area` VALUES ('370112', '历城区', '370100');
INSERT INTO `pro_city_area` VALUES ('370113', '长清区', '370100');
INSERT INTO `pro_city_area` VALUES ('370124', '平阴县', '370100');
INSERT INTO `pro_city_area` VALUES ('370125', '济阳县', '370100');
INSERT INTO `pro_city_area` VALUES ('370126', '商河县', '370100');
INSERT INTO `pro_city_area` VALUES ('370181', '章丘市', '370100');
INSERT INTO `pro_city_area` VALUES ('370200', '青岛市', '370000');
INSERT INTO `pro_city_area` VALUES ('370201', '市辖区', '370200');
INSERT INTO `pro_city_area` VALUES ('370202', '市南区', '370200');
INSERT INTO `pro_city_area` VALUES ('370203', '市北区', '370200');
INSERT INTO `pro_city_area` VALUES ('370205', '四方区', '370200');
INSERT INTO `pro_city_area` VALUES ('370211', '黄岛区', '370200');
INSERT INTO `pro_city_area` VALUES ('370212', '崂山区', '370200');
INSERT INTO `pro_city_area` VALUES ('370213', '李沧区', '370200');
INSERT INTO `pro_city_area` VALUES ('370214', '城阳区', '370200');
INSERT INTO `pro_city_area` VALUES ('370281', '胶州市', '370200');
INSERT INTO `pro_city_area` VALUES ('370282', '即墨市', '370200');
INSERT INTO `pro_city_area` VALUES ('370283', '平度市', '370200');
INSERT INTO `pro_city_area` VALUES ('370284', '胶南市', '370200');
INSERT INTO `pro_city_area` VALUES ('370285', '莱西市', '370200');
INSERT INTO `pro_city_area` VALUES ('370300', '淄博市', '370000');
INSERT INTO `pro_city_area` VALUES ('370301', '市辖区', '370300');
INSERT INTO `pro_city_area` VALUES ('370302', '淄川区', '370300');
INSERT INTO `pro_city_area` VALUES ('370303', '张店区', '370300');
INSERT INTO `pro_city_area` VALUES ('370304', '博山区', '370300');
INSERT INTO `pro_city_area` VALUES ('370305', '临淄区', '370300');
INSERT INTO `pro_city_area` VALUES ('370306', '周村区', '370300');
INSERT INTO `pro_city_area` VALUES ('370321', '桓台县', '370300');
INSERT INTO `pro_city_area` VALUES ('370322', '高青县', '370300');
INSERT INTO `pro_city_area` VALUES ('370323', '沂源县', '370300');
INSERT INTO `pro_city_area` VALUES ('370400', '枣庄市', '370000');
INSERT INTO `pro_city_area` VALUES ('370401', '市辖区', '370400');
INSERT INTO `pro_city_area` VALUES ('370402', '市中区', '370400');
INSERT INTO `pro_city_area` VALUES ('370403', '薛城区', '370400');
INSERT INTO `pro_city_area` VALUES ('370404', '峄城区', '370400');
INSERT INTO `pro_city_area` VALUES ('370405', '台儿庄区', '370400');
INSERT INTO `pro_city_area` VALUES ('370406', '山亭区', '370400');
INSERT INTO `pro_city_area` VALUES ('370481', '滕州市', '370400');
INSERT INTO `pro_city_area` VALUES ('370500', '东营市', '370000');
INSERT INTO `pro_city_area` VALUES ('370501', '市辖区', '370500');
INSERT INTO `pro_city_area` VALUES ('370502', '东营区', '370500');
INSERT INTO `pro_city_area` VALUES ('370503', '河口区', '370500');
INSERT INTO `pro_city_area` VALUES ('370521', '垦利县', '370500');
INSERT INTO `pro_city_area` VALUES ('370522', '利津县', '370500');
INSERT INTO `pro_city_area` VALUES ('370523', '广饶县', '370500');
INSERT INTO `pro_city_area` VALUES ('370600', '烟台市', '370000');
INSERT INTO `pro_city_area` VALUES ('370601', '市辖区', '370600');
INSERT INTO `pro_city_area` VALUES ('370602', '芝罘区', '370600');
INSERT INTO `pro_city_area` VALUES ('370611', '福山区', '370600');
INSERT INTO `pro_city_area` VALUES ('370612', '牟平区', '370600');
INSERT INTO `pro_city_area` VALUES ('370613', '莱山区', '370600');
INSERT INTO `pro_city_area` VALUES ('370634', '长岛县', '370600');
INSERT INTO `pro_city_area` VALUES ('370681', '龙口市', '370600');
INSERT INTO `pro_city_area` VALUES ('370682', '莱阳市', '370600');
INSERT INTO `pro_city_area` VALUES ('370683', '莱州市', '370600');
INSERT INTO `pro_city_area` VALUES ('370684', '蓬莱市', '370600');
INSERT INTO `pro_city_area` VALUES ('370685', '招远市', '370600');
INSERT INTO `pro_city_area` VALUES ('370686', '栖霞市', '370600');
INSERT INTO `pro_city_area` VALUES ('370687', '海阳市', '370600');
INSERT INTO `pro_city_area` VALUES ('370700', '潍坊市', '370000');
INSERT INTO `pro_city_area` VALUES ('370701', '市辖区', '370700');
INSERT INTO `pro_city_area` VALUES ('370702', '潍城区', '370700');
INSERT INTO `pro_city_area` VALUES ('370703', '寒亭区', '370700');
INSERT INTO `pro_city_area` VALUES ('370704', '坊子区', '370700');
INSERT INTO `pro_city_area` VALUES ('370705', '奎文区', '370700');
INSERT INTO `pro_city_area` VALUES ('370724', '临朐县', '370700');
INSERT INTO `pro_city_area` VALUES ('370725', '昌乐县', '370700');
INSERT INTO `pro_city_area` VALUES ('370781', '青州市', '370700');
INSERT INTO `pro_city_area` VALUES ('370782', '诸城市', '370700');
INSERT INTO `pro_city_area` VALUES ('370783', '寿光市', '370700');
INSERT INTO `pro_city_area` VALUES ('370784', '安丘市', '370700');
INSERT INTO `pro_city_area` VALUES ('370785', '高密市', '370700');
INSERT INTO `pro_city_area` VALUES ('370786', '昌邑市', '370700');
INSERT INTO `pro_city_area` VALUES ('370800', '济宁市', '370000');
INSERT INTO `pro_city_area` VALUES ('370801', '市辖区', '370800');
INSERT INTO `pro_city_area` VALUES ('370802', '市中区', '370800');
INSERT INTO `pro_city_area` VALUES ('370811', '任城区', '370800');
INSERT INTO `pro_city_area` VALUES ('370826', '微山县', '370800');
INSERT INTO `pro_city_area` VALUES ('370827', '鱼台县', '370800');
INSERT INTO `pro_city_area` VALUES ('370828', '金乡县', '370800');
INSERT INTO `pro_city_area` VALUES ('370829', '嘉祥县', '370800');
INSERT INTO `pro_city_area` VALUES ('370830', '汶上县', '370800');
INSERT INTO `pro_city_area` VALUES ('370831', '泗水县', '370800');
INSERT INTO `pro_city_area` VALUES ('370832', '梁山县', '370800');
INSERT INTO `pro_city_area` VALUES ('370881', '曲阜市', '370800');
INSERT INTO `pro_city_area` VALUES ('370882', '兖州市', '370800');
INSERT INTO `pro_city_area` VALUES ('370883', '邹城市', '370800');
INSERT INTO `pro_city_area` VALUES ('370900', '泰安市', '370000');
INSERT INTO `pro_city_area` VALUES ('370901', '市辖区', '370900');
INSERT INTO `pro_city_area` VALUES ('370902', '泰山区', '370900');
INSERT INTO `pro_city_area` VALUES ('370903', '岱岳区', '370900');
INSERT INTO `pro_city_area` VALUES ('370921', '宁阳县', '370900');
INSERT INTO `pro_city_area` VALUES ('370923', '东平县', '370900');
INSERT INTO `pro_city_area` VALUES ('370982', '新泰市', '370900');
INSERT INTO `pro_city_area` VALUES ('370983', '肥城市', '370900');
INSERT INTO `pro_city_area` VALUES ('371000', '威海市', '370000');
INSERT INTO `pro_city_area` VALUES ('371001', '市辖区', '371000');
INSERT INTO `pro_city_area` VALUES ('371002', '环翠区', '371000');
INSERT INTO `pro_city_area` VALUES ('371081', '文登市', '371000');
INSERT INTO `pro_city_area` VALUES ('371082', '荣成市', '371000');
INSERT INTO `pro_city_area` VALUES ('371083', '乳山市', '371000');
INSERT INTO `pro_city_area` VALUES ('371100', '日照市', '370000');
INSERT INTO `pro_city_area` VALUES ('371101', '市辖区', '371100');
INSERT INTO `pro_city_area` VALUES ('371102', '东港区', '371100');
INSERT INTO `pro_city_area` VALUES ('371103', '岚山区', '371100');
INSERT INTO `pro_city_area` VALUES ('371121', '五莲县', '371100');
INSERT INTO `pro_city_area` VALUES ('371122', '莒　县', '371100');
INSERT INTO `pro_city_area` VALUES ('371200', '莱芜市', '370000');
INSERT INTO `pro_city_area` VALUES ('371201', '市辖区', '371200');
INSERT INTO `pro_city_area` VALUES ('371202', '莱城区', '371200');
INSERT INTO `pro_city_area` VALUES ('371203', '钢城区', '371200');
INSERT INTO `pro_city_area` VALUES ('371300', '临沂市', '370000');
INSERT INTO `pro_city_area` VALUES ('371301', '市辖区', '371300');
INSERT INTO `pro_city_area` VALUES ('371302', '兰山区', '371300');
INSERT INTO `pro_city_area` VALUES ('371311', '罗庄区', '371300');
INSERT INTO `pro_city_area` VALUES ('371312', '河东区', '371300');
INSERT INTO `pro_city_area` VALUES ('371321', '沂南县', '371300');
INSERT INTO `pro_city_area` VALUES ('371322', '郯城县', '371300');
INSERT INTO `pro_city_area` VALUES ('371323', '沂水县', '371300');
INSERT INTO `pro_city_area` VALUES ('371324', '苍山县', '371300');
INSERT INTO `pro_city_area` VALUES ('371325', '费　县', '371300');
INSERT INTO `pro_city_area` VALUES ('371326', '平邑县', '371300');
INSERT INTO `pro_city_area` VALUES ('371327', '莒南县', '371300');
INSERT INTO `pro_city_area` VALUES ('371328', '蒙阴县', '371300');
INSERT INTO `pro_city_area` VALUES ('371329', '临沭县', '371300');
INSERT INTO `pro_city_area` VALUES ('371400', '德州市', '370000');
INSERT INTO `pro_city_area` VALUES ('371401', '市辖区', '371400');
INSERT INTO `pro_city_area` VALUES ('371402', '德城区', '371400');
INSERT INTO `pro_city_area` VALUES ('371421', '陵　县', '371400');
INSERT INTO `pro_city_area` VALUES ('371422', '宁津县', '371400');
INSERT INTO `pro_city_area` VALUES ('371423', '庆云县', '371400');
INSERT INTO `pro_city_area` VALUES ('371424', '临邑县', '371400');
INSERT INTO `pro_city_area` VALUES ('371425', '齐河县', '371400');
INSERT INTO `pro_city_area` VALUES ('371426', '平原县', '371400');
INSERT INTO `pro_city_area` VALUES ('371427', '夏津县', '371400');
INSERT INTO `pro_city_area` VALUES ('371428', '武城县', '371400');
INSERT INTO `pro_city_area` VALUES ('371481', '乐陵市', '371400');
INSERT INTO `pro_city_area` VALUES ('371482', '禹城市', '371400');
INSERT INTO `pro_city_area` VALUES ('371500', '聊城市', '370000');
INSERT INTO `pro_city_area` VALUES ('371501', '市辖区', '371500');
INSERT INTO `pro_city_area` VALUES ('371502', '东昌府区', '371500');
INSERT INTO `pro_city_area` VALUES ('371521', '阳谷县', '371500');
INSERT INTO `pro_city_area` VALUES ('371522', '莘　县', '371500');
INSERT INTO `pro_city_area` VALUES ('371523', '茌平县', '371500');
INSERT INTO `pro_city_area` VALUES ('371524', '东阿县', '371500');
INSERT INTO `pro_city_area` VALUES ('371525', '冠　县', '371500');
INSERT INTO `pro_city_area` VALUES ('371526', '高唐县', '371500');
INSERT INTO `pro_city_area` VALUES ('371581', '临清市', '371500');
INSERT INTO `pro_city_area` VALUES ('371600', '滨州市', '370000');
INSERT INTO `pro_city_area` VALUES ('371601', '市辖区', '371600');
INSERT INTO `pro_city_area` VALUES ('371602', '滨城区', '371600');
INSERT INTO `pro_city_area` VALUES ('371621', '惠民县', '371600');
INSERT INTO `pro_city_area` VALUES ('371622', '阳信县', '371600');
INSERT INTO `pro_city_area` VALUES ('371623', '无棣县', '371600');
INSERT INTO `pro_city_area` VALUES ('371624', '沾化县', '371600');
INSERT INTO `pro_city_area` VALUES ('371625', '博兴县', '371600');
INSERT INTO `pro_city_area` VALUES ('371626', '邹平县', '371600');
INSERT INTO `pro_city_area` VALUES ('371700', '荷泽市', '370000');
INSERT INTO `pro_city_area` VALUES ('371701', '市辖区', '371700');
INSERT INTO `pro_city_area` VALUES ('371702', '牡丹区', '371700');
INSERT INTO `pro_city_area` VALUES ('371721', '曹　县', '371700');
INSERT INTO `pro_city_area` VALUES ('371722', '单　县', '371700');
INSERT INTO `pro_city_area` VALUES ('371723', '成武县', '371700');
INSERT INTO `pro_city_area` VALUES ('371724', '巨野县', '371700');
INSERT INTO `pro_city_area` VALUES ('371725', '郓城县', '371700');
INSERT INTO `pro_city_area` VALUES ('371726', '鄄城县', '371700');
INSERT INTO `pro_city_area` VALUES ('371727', '定陶县', '371700');
INSERT INTO `pro_city_area` VALUES ('371728', '东明县', '371700');
INSERT INTO `pro_city_area` VALUES ('410000', '河南省', '0');
INSERT INTO `pro_city_area` VALUES ('410100', '郑州市', '410000');
INSERT INTO `pro_city_area` VALUES ('410101', '市辖区', '410100');
INSERT INTO `pro_city_area` VALUES ('410102', '中原区', '410100');
INSERT INTO `pro_city_area` VALUES ('410103', '二七区', '410100');
INSERT INTO `pro_city_area` VALUES ('410104', '管城回族区', '410100');
INSERT INTO `pro_city_area` VALUES ('410105', '金水区', '410100');
INSERT INTO `pro_city_area` VALUES ('410106', '上街区', '410100');
INSERT INTO `pro_city_area` VALUES ('410108', '邙山区', '410100');
INSERT INTO `pro_city_area` VALUES ('410122', '中牟县', '410100');
INSERT INTO `pro_city_area` VALUES ('410181', '巩义市', '410100');
INSERT INTO `pro_city_area` VALUES ('410182', '荥阳市', '410100');
INSERT INTO `pro_city_area` VALUES ('410183', '新密市', '410100');
INSERT INTO `pro_city_area` VALUES ('410184', '新郑市', '410100');
INSERT INTO `pro_city_area` VALUES ('410185', '登封市', '410100');
INSERT INTO `pro_city_area` VALUES ('410200', '开封市', '410000');
INSERT INTO `pro_city_area` VALUES ('410201', '市辖区', '410200');
INSERT INTO `pro_city_area` VALUES ('410202', '龙亭区', '410200');
INSERT INTO `pro_city_area` VALUES ('410203', '顺河回族区', '410200');
INSERT INTO `pro_city_area` VALUES ('410204', '鼓楼区', '410200');
INSERT INTO `pro_city_area` VALUES ('410205', '南关区', '410200');
INSERT INTO `pro_city_area` VALUES ('410211', '郊　区', '410200');
INSERT INTO `pro_city_area` VALUES ('410221', '杞　县', '410200');
INSERT INTO `pro_city_area` VALUES ('410222', '通许县', '410200');
INSERT INTO `pro_city_area` VALUES ('410223', '尉氏县', '410200');
INSERT INTO `pro_city_area` VALUES ('410224', '开封县', '410200');
INSERT INTO `pro_city_area` VALUES ('410225', '兰考县', '410200');
INSERT INTO `pro_city_area` VALUES ('410300', '洛阳市', '410000');
INSERT INTO `pro_city_area` VALUES ('410301', '市辖区', '410300');
INSERT INTO `pro_city_area` VALUES ('410302', '老城区', '410300');
INSERT INTO `pro_city_area` VALUES ('410303', '西工区', '410300');
INSERT INTO `pro_city_area` VALUES ('410304', '廛河回族区', '410300');
INSERT INTO `pro_city_area` VALUES ('410305', '涧西区', '410300');
INSERT INTO `pro_city_area` VALUES ('410306', '吉利区', '410300');
INSERT INTO `pro_city_area` VALUES ('410307', '洛龙区', '410300');
INSERT INTO `pro_city_area` VALUES ('410322', '孟津县', '410300');
INSERT INTO `pro_city_area` VALUES ('410323', '新安县', '410300');
INSERT INTO `pro_city_area` VALUES ('410324', '栾川县', '410300');
INSERT INTO `pro_city_area` VALUES ('410325', '嵩　县', '410300');
INSERT INTO `pro_city_area` VALUES ('410326', '汝阳县', '410300');
INSERT INTO `pro_city_area` VALUES ('410327', '宜阳县', '410300');
INSERT INTO `pro_city_area` VALUES ('410328', '洛宁县', '410300');
INSERT INTO `pro_city_area` VALUES ('410329', '伊川县', '410300');
INSERT INTO `pro_city_area` VALUES ('410381', '偃师市', '410300');
INSERT INTO `pro_city_area` VALUES ('410400', '平顶山市', '410000');
INSERT INTO `pro_city_area` VALUES ('410401', '市辖区', '410400');
INSERT INTO `pro_city_area` VALUES ('410402', '新华区', '410400');
INSERT INTO `pro_city_area` VALUES ('410403', '卫东区', '410400');
INSERT INTO `pro_city_area` VALUES ('410404', '石龙区', '410400');
INSERT INTO `pro_city_area` VALUES ('410411', '湛河区', '410400');
INSERT INTO `pro_city_area` VALUES ('410421', '宝丰县', '410400');
INSERT INTO `pro_city_area` VALUES ('410422', '叶　县', '410400');
INSERT INTO `pro_city_area` VALUES ('410423', '鲁山县', '410400');
INSERT INTO `pro_city_area` VALUES ('410425', '郏　县', '410400');
INSERT INTO `pro_city_area` VALUES ('410481', '舞钢市', '410400');
INSERT INTO `pro_city_area` VALUES ('410482', '汝州市', '410400');
INSERT INTO `pro_city_area` VALUES ('410500', '安阳市', '410000');
INSERT INTO `pro_city_area` VALUES ('410501', '市辖区', '410500');
INSERT INTO `pro_city_area` VALUES ('410502', '文峰区', '410500');
INSERT INTO `pro_city_area` VALUES ('410503', '北关区', '410500');
INSERT INTO `pro_city_area` VALUES ('410505', '殷都区', '410500');
INSERT INTO `pro_city_area` VALUES ('410506', '龙安区', '410500');
INSERT INTO `pro_city_area` VALUES ('410522', '安阳县', '410500');
INSERT INTO `pro_city_area` VALUES ('410523', '汤阴县', '410500');
INSERT INTO `pro_city_area` VALUES ('410526', '滑　县', '410500');
INSERT INTO `pro_city_area` VALUES ('410527', '内黄县', '410500');
INSERT INTO `pro_city_area` VALUES ('410581', '林州市', '410500');
INSERT INTO `pro_city_area` VALUES ('410600', '鹤壁市', '410000');
INSERT INTO `pro_city_area` VALUES ('410601', '市辖区', '410600');
INSERT INTO `pro_city_area` VALUES ('410602', '鹤山区', '410600');
INSERT INTO `pro_city_area` VALUES ('410603', '山城区', '410600');
INSERT INTO `pro_city_area` VALUES ('410611', '淇滨区', '410600');
INSERT INTO `pro_city_area` VALUES ('410621', '浚　县', '410600');
INSERT INTO `pro_city_area` VALUES ('410622', '淇　县', '410600');
INSERT INTO `pro_city_area` VALUES ('410700', '新乡市', '410000');
INSERT INTO `pro_city_area` VALUES ('410701', '市辖区', '410700');
INSERT INTO `pro_city_area` VALUES ('410702', '红旗区', '410700');
INSERT INTO `pro_city_area` VALUES ('410703', '卫滨区', '410700');
INSERT INTO `pro_city_area` VALUES ('410704', '凤泉区', '410700');
INSERT INTO `pro_city_area` VALUES ('410711', '牧野区', '410700');
INSERT INTO `pro_city_area` VALUES ('410721', '新乡县', '410700');
INSERT INTO `pro_city_area` VALUES ('410724', '获嘉县', '410700');
INSERT INTO `pro_city_area` VALUES ('410725', '原阳县', '410700');
INSERT INTO `pro_city_area` VALUES ('410726', '延津县', '410700');
INSERT INTO `pro_city_area` VALUES ('410727', '封丘县', '410700');
INSERT INTO `pro_city_area` VALUES ('410728', '长垣县', '410700');
INSERT INTO `pro_city_area` VALUES ('410781', '卫辉市', '410700');
INSERT INTO `pro_city_area` VALUES ('410782', '辉县市', '410700');
INSERT INTO `pro_city_area` VALUES ('410800', '焦作市', '410000');
INSERT INTO `pro_city_area` VALUES ('410801', '市辖区', '410800');
INSERT INTO `pro_city_area` VALUES ('410802', '解放区', '410800');
INSERT INTO `pro_city_area` VALUES ('410803', '中站区', '410800');
INSERT INTO `pro_city_area` VALUES ('410804', '马村区', '410800');
INSERT INTO `pro_city_area` VALUES ('410811', '山阳区', '410800');
INSERT INTO `pro_city_area` VALUES ('410821', '修武县', '410800');
INSERT INTO `pro_city_area` VALUES ('410822', '博爱县', '410800');
INSERT INTO `pro_city_area` VALUES ('410823', '武陟县', '410800');
INSERT INTO `pro_city_area` VALUES ('410825', '温　县', '410800');
INSERT INTO `pro_city_area` VALUES ('410881', '济源市', '410800');
INSERT INTO `pro_city_area` VALUES ('410882', '沁阳市', '410800');
INSERT INTO `pro_city_area` VALUES ('410883', '孟州市', '410800');
INSERT INTO `pro_city_area` VALUES ('410900', '濮阳市', '410000');
INSERT INTO `pro_city_area` VALUES ('410901', '市辖区', '410900');
INSERT INTO `pro_city_area` VALUES ('410902', '华龙区', '410900');
INSERT INTO `pro_city_area` VALUES ('410922', '清丰县', '410900');
INSERT INTO `pro_city_area` VALUES ('410923', '南乐县', '410900');
INSERT INTO `pro_city_area` VALUES ('410926', '范　县', '410900');
INSERT INTO `pro_city_area` VALUES ('410927', '台前县', '410900');
INSERT INTO `pro_city_area` VALUES ('410928', '濮阳县', '410900');
INSERT INTO `pro_city_area` VALUES ('411000', '许昌市', '410000');
INSERT INTO `pro_city_area` VALUES ('411001', '市辖区', '411000');
INSERT INTO `pro_city_area` VALUES ('411002', '魏都区', '411000');
INSERT INTO `pro_city_area` VALUES ('411023', '许昌县', '411000');
INSERT INTO `pro_city_area` VALUES ('411024', '鄢陵县', '411000');
INSERT INTO `pro_city_area` VALUES ('411025', '襄城县', '411000');
INSERT INTO `pro_city_area` VALUES ('411081', '禹州市', '411000');
INSERT INTO `pro_city_area` VALUES ('411082', '长葛市', '411000');
INSERT INTO `pro_city_area` VALUES ('411100', '漯河市', '410000');
INSERT INTO `pro_city_area` VALUES ('411101', '市辖区', '411100');
INSERT INTO `pro_city_area` VALUES ('411102', '源汇区', '411100');
INSERT INTO `pro_city_area` VALUES ('411103', '郾城区', '411100');
INSERT INTO `pro_city_area` VALUES ('411104', '召陵区', '411100');
INSERT INTO `pro_city_area` VALUES ('411121', '舞阳县', '411100');
INSERT INTO `pro_city_area` VALUES ('411122', '临颍县', '411100');
INSERT INTO `pro_city_area` VALUES ('411200', '三门峡市', '410000');
INSERT INTO `pro_city_area` VALUES ('411201', '市辖区', '411200');
INSERT INTO `pro_city_area` VALUES ('411202', '湖滨区', '411200');
INSERT INTO `pro_city_area` VALUES ('411221', '渑池县', '411200');
INSERT INTO `pro_city_area` VALUES ('411222', '陕　县', '411200');
INSERT INTO `pro_city_area` VALUES ('411224', '卢氏县', '411200');
INSERT INTO `pro_city_area` VALUES ('411281', '义马市', '411200');
INSERT INTO `pro_city_area` VALUES ('411282', '灵宝市', '411200');
INSERT INTO `pro_city_area` VALUES ('411300', '南阳市', '410000');
INSERT INTO `pro_city_area` VALUES ('411301', '市辖区', '411300');
INSERT INTO `pro_city_area` VALUES ('411302', '宛城区', '411300');
INSERT INTO `pro_city_area` VALUES ('411303', '卧龙区', '411300');
INSERT INTO `pro_city_area` VALUES ('411321', '南召县', '411300');
INSERT INTO `pro_city_area` VALUES ('411322', '方城县', '411300');
INSERT INTO `pro_city_area` VALUES ('411323', '西峡县', '411300');
INSERT INTO `pro_city_area` VALUES ('411324', '镇平县', '411300');
INSERT INTO `pro_city_area` VALUES ('411325', '内乡县', '411300');
INSERT INTO `pro_city_area` VALUES ('411326', '淅川县', '411300');
INSERT INTO `pro_city_area` VALUES ('411327', '社旗县', '411300');
INSERT INTO `pro_city_area` VALUES ('411328', '唐河县', '411300');
INSERT INTO `pro_city_area` VALUES ('411329', '新野县', '411300');
INSERT INTO `pro_city_area` VALUES ('411330', '桐柏县', '411300');
INSERT INTO `pro_city_area` VALUES ('411381', '邓州市', '411300');
INSERT INTO `pro_city_area` VALUES ('411400', '商丘市', '410000');
INSERT INTO `pro_city_area` VALUES ('411401', '市辖区', '411400');
INSERT INTO `pro_city_area` VALUES ('411402', '梁园区', '411400');
INSERT INTO `pro_city_area` VALUES ('411403', '睢阳区', '411400');
INSERT INTO `pro_city_area` VALUES ('411421', '民权县', '411400');
INSERT INTO `pro_city_area` VALUES ('411422', '睢　县', '411400');
INSERT INTO `pro_city_area` VALUES ('411423', '宁陵县', '411400');
INSERT INTO `pro_city_area` VALUES ('411424', '柘城县', '411400');
INSERT INTO `pro_city_area` VALUES ('411425', '虞城县', '411400');
INSERT INTO `pro_city_area` VALUES ('411426', '夏邑县', '411400');
INSERT INTO `pro_city_area` VALUES ('411481', '永城市', '411400');
INSERT INTO `pro_city_area` VALUES ('411500', '信阳市', '410000');
INSERT INTO `pro_city_area` VALUES ('411501', '市辖区', '411500');
INSERT INTO `pro_city_area` VALUES ('411502', '师河区', '411500');
INSERT INTO `pro_city_area` VALUES ('411503', '平桥区', '411500');
INSERT INTO `pro_city_area` VALUES ('411521', '罗山县', '411500');
INSERT INTO `pro_city_area` VALUES ('411522', '光山县', '411500');
INSERT INTO `pro_city_area` VALUES ('411523', '新　县', '411500');
INSERT INTO `pro_city_area` VALUES ('411524', '商城县', '411500');
INSERT INTO `pro_city_area` VALUES ('411525', '固始县', '411500');
INSERT INTO `pro_city_area` VALUES ('411526', '潢川县', '411500');
INSERT INTO `pro_city_area` VALUES ('411527', '淮滨县', '411500');
INSERT INTO `pro_city_area` VALUES ('411528', '息　县', '411500');
INSERT INTO `pro_city_area` VALUES ('411600', '周口市', '410000');
INSERT INTO `pro_city_area` VALUES ('411601', '市辖区', '411600');
INSERT INTO `pro_city_area` VALUES ('411602', '川汇区', '411600');
INSERT INTO `pro_city_area` VALUES ('411621', '扶沟县', '411600');
INSERT INTO `pro_city_area` VALUES ('411622', '西华县', '411600');
INSERT INTO `pro_city_area` VALUES ('411623', '商水县', '411600');
INSERT INTO `pro_city_area` VALUES ('411624', '沈丘县', '411600');
INSERT INTO `pro_city_area` VALUES ('411625', '郸城县', '411600');
INSERT INTO `pro_city_area` VALUES ('411626', '淮阳县', '411600');
INSERT INTO `pro_city_area` VALUES ('411627', '太康县', '411600');
INSERT INTO `pro_city_area` VALUES ('411628', '鹿邑县', '411600');
INSERT INTO `pro_city_area` VALUES ('411681', '项城市', '411600');
INSERT INTO `pro_city_area` VALUES ('411700', '驻马店市', '410000');
INSERT INTO `pro_city_area` VALUES ('411701', '市辖区', '411700');
INSERT INTO `pro_city_area` VALUES ('411702', '驿城区', '411700');
INSERT INTO `pro_city_area` VALUES ('411721', '西平县', '411700');
INSERT INTO `pro_city_area` VALUES ('411722', '上蔡县', '411700');
INSERT INTO `pro_city_area` VALUES ('411723', '平舆县', '411700');
INSERT INTO `pro_city_area` VALUES ('411724', '正阳县', '411700');
INSERT INTO `pro_city_area` VALUES ('411725', '确山县', '411700');
INSERT INTO `pro_city_area` VALUES ('411726', '泌阳县', '411700');
INSERT INTO `pro_city_area` VALUES ('411727', '汝南县', '411700');
INSERT INTO `pro_city_area` VALUES ('411728', '遂平县', '411700');
INSERT INTO `pro_city_area` VALUES ('411729', '新蔡县', '411700');
INSERT INTO `pro_city_area` VALUES ('420000', '湖北省', '0');
INSERT INTO `pro_city_area` VALUES ('420100', '武汉市', '420000');
INSERT INTO `pro_city_area` VALUES ('420101', '市辖区', '420100');
INSERT INTO `pro_city_area` VALUES ('420102', '江岸区', '420100');
INSERT INTO `pro_city_area` VALUES ('420103', '江汉区', '420100');
INSERT INTO `pro_city_area` VALUES ('420104', '乔口区', '420100');
INSERT INTO `pro_city_area` VALUES ('420105', '汉阳区', '420100');
INSERT INTO `pro_city_area` VALUES ('420106', '武昌区', '420100');
INSERT INTO `pro_city_area` VALUES ('420107', '青山区', '420100');
INSERT INTO `pro_city_area` VALUES ('420111', '洪山区', '420100');
INSERT INTO `pro_city_area` VALUES ('420112', '东西湖区', '420100');
INSERT INTO `pro_city_area` VALUES ('420113', '汉南区', '420100');
INSERT INTO `pro_city_area` VALUES ('420114', '蔡甸区', '420100');
INSERT INTO `pro_city_area` VALUES ('420115', '江夏区', '420100');
INSERT INTO `pro_city_area` VALUES ('420116', '黄陂区', '420100');
INSERT INTO `pro_city_area` VALUES ('420117', '新洲区', '420100');
INSERT INTO `pro_city_area` VALUES ('420200', '黄石市', '420000');
INSERT INTO `pro_city_area` VALUES ('420201', '市辖区', '420200');
INSERT INTO `pro_city_area` VALUES ('420202', '黄石港区', '420200');
INSERT INTO `pro_city_area` VALUES ('420203', '西塞山区', '420200');
INSERT INTO `pro_city_area` VALUES ('420204', '下陆区', '420200');
INSERT INTO `pro_city_area` VALUES ('420205', '铁山区', '420200');
INSERT INTO `pro_city_area` VALUES ('420222', '阳新县', '420200');
INSERT INTO `pro_city_area` VALUES ('420281', '大冶市', '420200');
INSERT INTO `pro_city_area` VALUES ('420300', '十堰市', '420000');
INSERT INTO `pro_city_area` VALUES ('420301', '市辖区', '420300');
INSERT INTO `pro_city_area` VALUES ('420302', '茅箭区', '420300');
INSERT INTO `pro_city_area` VALUES ('420303', '张湾区', '420300');
INSERT INTO `pro_city_area` VALUES ('420321', '郧　县', '420300');
INSERT INTO `pro_city_area` VALUES ('420322', '郧西县', '420300');
INSERT INTO `pro_city_area` VALUES ('420323', '竹山县', '420300');
INSERT INTO `pro_city_area` VALUES ('420324', '竹溪县', '420300');
INSERT INTO `pro_city_area` VALUES ('420325', '房　县', '420300');
INSERT INTO `pro_city_area` VALUES ('420381', '丹江口市', '420300');
INSERT INTO `pro_city_area` VALUES ('420500', '宜昌市', '420000');
INSERT INTO `pro_city_area` VALUES ('420501', '市辖区', '420500');
INSERT INTO `pro_city_area` VALUES ('420502', '西陵区', '420500');
INSERT INTO `pro_city_area` VALUES ('420503', '伍家岗区', '420500');
INSERT INTO `pro_city_area` VALUES ('420504', '点军区', '420500');
INSERT INTO `pro_city_area` VALUES ('420505', '猇亭区', '420500');
INSERT INTO `pro_city_area` VALUES ('420506', '夷陵区', '420500');
INSERT INTO `pro_city_area` VALUES ('420525', '远安县', '420500');
INSERT INTO `pro_city_area` VALUES ('420526', '兴山县', '420500');
INSERT INTO `pro_city_area` VALUES ('420527', '秭归县', '420500');
INSERT INTO `pro_city_area` VALUES ('420528', '长阳土家族自治县', '420500');
INSERT INTO `pro_city_area` VALUES ('420529', '五峰土家族自治县', '420500');
INSERT INTO `pro_city_area` VALUES ('420581', '宜都市', '420500');
INSERT INTO `pro_city_area` VALUES ('420582', '当阳市', '420500');
INSERT INTO `pro_city_area` VALUES ('420583', '枝江市', '420500');
INSERT INTO `pro_city_area` VALUES ('420600', '襄樊市', '420000');
INSERT INTO `pro_city_area` VALUES ('420601', '市辖区', '420600');
INSERT INTO `pro_city_area` VALUES ('420602', '襄城区', '420600');
INSERT INTO `pro_city_area` VALUES ('420606', '樊城区', '420600');
INSERT INTO `pro_city_area` VALUES ('420607', '襄阳区', '420600');
INSERT INTO `pro_city_area` VALUES ('420624', '南漳县', '420600');
INSERT INTO `pro_city_area` VALUES ('420625', '谷城县', '420600');
INSERT INTO `pro_city_area` VALUES ('420626', '保康县', '420600');
INSERT INTO `pro_city_area` VALUES ('420682', '老河口市', '420600');
INSERT INTO `pro_city_area` VALUES ('420683', '枣阳市', '420600');
INSERT INTO `pro_city_area` VALUES ('420684', '宜城市', '420600');
INSERT INTO `pro_city_area` VALUES ('420700', '鄂州市', '420000');
INSERT INTO `pro_city_area` VALUES ('420701', '市辖区', '420700');
INSERT INTO `pro_city_area` VALUES ('420702', '梁子湖区', '420700');
INSERT INTO `pro_city_area` VALUES ('420703', '华容区', '420700');
INSERT INTO `pro_city_area` VALUES ('420704', '鄂城区', '420700');
INSERT INTO `pro_city_area` VALUES ('420800', '荆门市', '420000');
INSERT INTO `pro_city_area` VALUES ('420801', '市辖区', '420800');
INSERT INTO `pro_city_area` VALUES ('420802', '东宝区', '420800');
INSERT INTO `pro_city_area` VALUES ('420804', '掇刀区', '420800');
INSERT INTO `pro_city_area` VALUES ('420821', '京山县', '420800');
INSERT INTO `pro_city_area` VALUES ('420822', '沙洋县', '420800');
INSERT INTO `pro_city_area` VALUES ('420881', '钟祥市', '420800');
INSERT INTO `pro_city_area` VALUES ('420900', '孝感市', '420000');
INSERT INTO `pro_city_area` VALUES ('420901', '市辖区', '420900');
INSERT INTO `pro_city_area` VALUES ('420902', '孝南区', '420900');
INSERT INTO `pro_city_area` VALUES ('420921', '孝昌县', '420900');
INSERT INTO `pro_city_area` VALUES ('420922', '大悟县', '420900');
INSERT INTO `pro_city_area` VALUES ('420923', '云梦县', '420900');
INSERT INTO `pro_city_area` VALUES ('420981', '应城市', '420900');
INSERT INTO `pro_city_area` VALUES ('420982', '安陆市', '420900');
INSERT INTO `pro_city_area` VALUES ('420984', '汉川市', '420900');
INSERT INTO `pro_city_area` VALUES ('421000', '荆州市', '420000');
INSERT INTO `pro_city_area` VALUES ('421001', '市辖区', '421000');
INSERT INTO `pro_city_area` VALUES ('421002', '沙市区', '421000');
INSERT INTO `pro_city_area` VALUES ('421003', '荆州区', '421000');
INSERT INTO `pro_city_area` VALUES ('421022', '公安县', '421000');
INSERT INTO `pro_city_area` VALUES ('421023', '监利县', '421000');
INSERT INTO `pro_city_area` VALUES ('421024', '江陵县', '421000');
INSERT INTO `pro_city_area` VALUES ('421081', '石首市', '421000');
INSERT INTO `pro_city_area` VALUES ('421083', '洪湖市', '421000');
INSERT INTO `pro_city_area` VALUES ('421087', '松滋市', '421000');
INSERT INTO `pro_city_area` VALUES ('421100', '黄冈市', '420000');
INSERT INTO `pro_city_area` VALUES ('421101', '市辖区', '421100');
INSERT INTO `pro_city_area` VALUES ('421102', '黄州区', '421100');
INSERT INTO `pro_city_area` VALUES ('421121', '团风县', '421100');
INSERT INTO `pro_city_area` VALUES ('421122', '红安县', '421100');
INSERT INTO `pro_city_area` VALUES ('421123', '罗田县', '421100');
INSERT INTO `pro_city_area` VALUES ('421124', '英山县', '421100');
INSERT INTO `pro_city_area` VALUES ('421125', '浠水县', '421100');
INSERT INTO `pro_city_area` VALUES ('421126', '蕲春县', '421100');
INSERT INTO `pro_city_area` VALUES ('421127', '黄梅县', '421100');
INSERT INTO `pro_city_area` VALUES ('421181', '麻城市', '421100');
INSERT INTO `pro_city_area` VALUES ('421182', '武穴市', '421100');
INSERT INTO `pro_city_area` VALUES ('421200', '咸宁市', '420000');
INSERT INTO `pro_city_area` VALUES ('421201', '市辖区', '421200');
INSERT INTO `pro_city_area` VALUES ('421202', '咸安区', '421200');
INSERT INTO `pro_city_area` VALUES ('421221', '嘉鱼县', '421200');
INSERT INTO `pro_city_area` VALUES ('421222', '通城县', '421200');
INSERT INTO `pro_city_area` VALUES ('421223', '崇阳县', '421200');
INSERT INTO `pro_city_area` VALUES ('421224', '通山县', '421200');
INSERT INTO `pro_city_area` VALUES ('421281', '赤壁市', '421200');
INSERT INTO `pro_city_area` VALUES ('421300', '随州市', '420000');
INSERT INTO `pro_city_area` VALUES ('421301', '市辖区', '421300');
INSERT INTO `pro_city_area` VALUES ('421302', '曾都区', '421300');
INSERT INTO `pro_city_area` VALUES ('421381', '广水市', '421300');
INSERT INTO `pro_city_area` VALUES ('422800', '恩施土家族苗族自治州', '420000');
INSERT INTO `pro_city_area` VALUES ('422801', '恩施市', '422800');
INSERT INTO `pro_city_area` VALUES ('422802', '利川市', '422800');
INSERT INTO `pro_city_area` VALUES ('422822', '建始县', '422800');
INSERT INTO `pro_city_area` VALUES ('422823', '巴东县', '422800');
INSERT INTO `pro_city_area` VALUES ('422825', '宣恩县', '422800');
INSERT INTO `pro_city_area` VALUES ('422826', '咸丰县', '422800');
INSERT INTO `pro_city_area` VALUES ('422827', '来凤县', '422800');
INSERT INTO `pro_city_area` VALUES ('422828', '鹤峰县', '422800');
INSERT INTO `pro_city_area` VALUES ('429000', '省直辖行政单位', '420000');
INSERT INTO `pro_city_area` VALUES ('429004', '仙桃市', '429000');
INSERT INTO `pro_city_area` VALUES ('429005', '潜江市', '429000');
INSERT INTO `pro_city_area` VALUES ('429006', '天门市', '429000');
INSERT INTO `pro_city_area` VALUES ('429021', '神农架林区', '429000');
INSERT INTO `pro_city_area` VALUES ('430000', '湖南省', '0');
INSERT INTO `pro_city_area` VALUES ('430100', '长沙市', '430000');
INSERT INTO `pro_city_area` VALUES ('430101', '市辖区', '430100');
INSERT INTO `pro_city_area` VALUES ('430102', '芙蓉区', '430100');
INSERT INTO `pro_city_area` VALUES ('430103', '天心区', '430100');
INSERT INTO `pro_city_area` VALUES ('430104', '岳麓区', '430100');
INSERT INTO `pro_city_area` VALUES ('430105', '开福区', '430100');
INSERT INTO `pro_city_area` VALUES ('430111', '雨花区', '430100');
INSERT INTO `pro_city_area` VALUES ('430121', '长沙县', '430100');
INSERT INTO `pro_city_area` VALUES ('430122', '望城县', '430100');
INSERT INTO `pro_city_area` VALUES ('430124', '宁乡县', '430100');
INSERT INTO `pro_city_area` VALUES ('430181', '浏阳市', '430100');
INSERT INTO `pro_city_area` VALUES ('430200', '株洲市', '430000');
INSERT INTO `pro_city_area` VALUES ('430201', '市辖区', '430200');
INSERT INTO `pro_city_area` VALUES ('430202', '荷塘区', '430200');
INSERT INTO `pro_city_area` VALUES ('430203', '芦淞区', '430200');
INSERT INTO `pro_city_area` VALUES ('430204', '石峰区', '430200');
INSERT INTO `pro_city_area` VALUES ('430211', '天元区', '430200');
INSERT INTO `pro_city_area` VALUES ('430221', '株洲县', '430200');
INSERT INTO `pro_city_area` VALUES ('430223', '攸　县', '430200');
INSERT INTO `pro_city_area` VALUES ('430224', '茶陵县', '430200');
INSERT INTO `pro_city_area` VALUES ('430225', '炎陵县', '430200');
INSERT INTO `pro_city_area` VALUES ('430281', '醴陵市', '430200');
INSERT INTO `pro_city_area` VALUES ('430300', '湘潭市', '430000');
INSERT INTO `pro_city_area` VALUES ('430301', '市辖区', '430300');
INSERT INTO `pro_city_area` VALUES ('430302', '雨湖区', '430300');
INSERT INTO `pro_city_area` VALUES ('430304', '岳塘区', '430300');
INSERT INTO `pro_city_area` VALUES ('430321', '湘潭县', '430300');
INSERT INTO `pro_city_area` VALUES ('430381', '湘乡市', '430300');
INSERT INTO `pro_city_area` VALUES ('430382', '韶山市', '430300');
INSERT INTO `pro_city_area` VALUES ('430400', '衡阳市', '430000');
INSERT INTO `pro_city_area` VALUES ('430401', '市辖区', '430400');
INSERT INTO `pro_city_area` VALUES ('430405', '珠晖区', '430400');
INSERT INTO `pro_city_area` VALUES ('430406', '雁峰区', '430400');
INSERT INTO `pro_city_area` VALUES ('430407', '石鼓区', '430400');
INSERT INTO `pro_city_area` VALUES ('430408', '蒸湘区', '430400');
INSERT INTO `pro_city_area` VALUES ('430412', '南岳区', '430400');
INSERT INTO `pro_city_area` VALUES ('430421', '衡阳县', '430400');
INSERT INTO `pro_city_area` VALUES ('430422', '衡南县', '430400');
INSERT INTO `pro_city_area` VALUES ('430423', '衡山县', '430400');
INSERT INTO `pro_city_area` VALUES ('430424', '衡东县', '430400');
INSERT INTO `pro_city_area` VALUES ('430426', '祁东县', '430400');
INSERT INTO `pro_city_area` VALUES ('430481', '耒阳市', '430400');
INSERT INTO `pro_city_area` VALUES ('430482', '常宁市', '430400');
INSERT INTO `pro_city_area` VALUES ('430500', '邵阳市', '430000');
INSERT INTO `pro_city_area` VALUES ('430501', '市辖区', '430500');
INSERT INTO `pro_city_area` VALUES ('430502', '双清区', '430500');
INSERT INTO `pro_city_area` VALUES ('430503', '大祥区', '430500');
INSERT INTO `pro_city_area` VALUES ('430511', '北塔区', '430500');
INSERT INTO `pro_city_area` VALUES ('430521', '邵东县', '430500');
INSERT INTO `pro_city_area` VALUES ('430522', '新邵县', '430500');
INSERT INTO `pro_city_area` VALUES ('430523', '邵阳县', '430500');
INSERT INTO `pro_city_area` VALUES ('430524', '隆回县', '430500');
INSERT INTO `pro_city_area` VALUES ('430525', '洞口县', '430500');
INSERT INTO `pro_city_area` VALUES ('430527', '绥宁县', '430500');
INSERT INTO `pro_city_area` VALUES ('430528', '新宁县', '430500');
INSERT INTO `pro_city_area` VALUES ('430529', '城步苗族自治县', '430500');
INSERT INTO `pro_city_area` VALUES ('430581', '武冈市', '430500');
INSERT INTO `pro_city_area` VALUES ('430600', '岳阳市', '430000');
INSERT INTO `pro_city_area` VALUES ('430601', '市辖区', '430600');
INSERT INTO `pro_city_area` VALUES ('430602', '岳阳楼区', '430600');
INSERT INTO `pro_city_area` VALUES ('430603', '云溪区', '430600');
INSERT INTO `pro_city_area` VALUES ('430611', '君山区', '430600');
INSERT INTO `pro_city_area` VALUES ('430621', '岳阳县', '430600');
INSERT INTO `pro_city_area` VALUES ('430623', '华容县', '430600');
INSERT INTO `pro_city_area` VALUES ('430624', '湘阴县', '430600');
INSERT INTO `pro_city_area` VALUES ('430626', '平江县', '430600');
INSERT INTO `pro_city_area` VALUES ('430681', '汨罗市', '430600');
INSERT INTO `pro_city_area` VALUES ('430682', '临湘市', '430600');
INSERT INTO `pro_city_area` VALUES ('430700', '常德市', '430000');
INSERT INTO `pro_city_area` VALUES ('430701', '市辖区', '430700');
INSERT INTO `pro_city_area` VALUES ('430702', '武陵区', '430700');
INSERT INTO `pro_city_area` VALUES ('430703', '鼎城区', '430700');
INSERT INTO `pro_city_area` VALUES ('430721', '安乡县', '430700');
INSERT INTO `pro_city_area` VALUES ('430722', '汉寿县', '430700');
INSERT INTO `pro_city_area` VALUES ('430723', '澧　县', '430700');
INSERT INTO `pro_city_area` VALUES ('430724', '临澧县', '430700');
INSERT INTO `pro_city_area` VALUES ('430725', '桃源县', '430700');
INSERT INTO `pro_city_area` VALUES ('430726', '石门县', '430700');
INSERT INTO `pro_city_area` VALUES ('430781', '津市市', '430700');
INSERT INTO `pro_city_area` VALUES ('430800', '张家界市', '430000');
INSERT INTO `pro_city_area` VALUES ('430801', '市辖区', '430800');
INSERT INTO `pro_city_area` VALUES ('430802', '永定区', '430800');
INSERT INTO `pro_city_area` VALUES ('430811', '武陵源区', '430800');
INSERT INTO `pro_city_area` VALUES ('430821', '慈利县', '430800');
INSERT INTO `pro_city_area` VALUES ('430822', '桑植县', '430800');
INSERT INTO `pro_city_area` VALUES ('430900', '益阳市', '430000');
INSERT INTO `pro_city_area` VALUES ('430901', '市辖区', '430900');
INSERT INTO `pro_city_area` VALUES ('430902', '资阳区', '430900');
INSERT INTO `pro_city_area` VALUES ('430903', '赫山区', '430900');
INSERT INTO `pro_city_area` VALUES ('430921', '南　县', '430900');
INSERT INTO `pro_city_area` VALUES ('430922', '桃江县', '430900');
INSERT INTO `pro_city_area` VALUES ('430923', '安化县', '430900');
INSERT INTO `pro_city_area` VALUES ('430981', '沅江市', '430900');
INSERT INTO `pro_city_area` VALUES ('431000', '郴州市', '430000');
INSERT INTO `pro_city_area` VALUES ('431001', '市辖区', '431000');
INSERT INTO `pro_city_area` VALUES ('431002', '北湖区', '431000');
INSERT INTO `pro_city_area` VALUES ('431003', '苏仙区', '431000');
INSERT INTO `pro_city_area` VALUES ('431021', '桂阳县', '431000');
INSERT INTO `pro_city_area` VALUES ('431022', '宜章县', '431000');
INSERT INTO `pro_city_area` VALUES ('431023', '永兴县', '431000');
INSERT INTO `pro_city_area` VALUES ('431024', '嘉禾县', '431000');
INSERT INTO `pro_city_area` VALUES ('431025', '临武县', '431000');
INSERT INTO `pro_city_area` VALUES ('431026', '汝城县', '431000');
INSERT INTO `pro_city_area` VALUES ('431027', '桂东县', '431000');
INSERT INTO `pro_city_area` VALUES ('431028', '安仁县', '431000');
INSERT INTO `pro_city_area` VALUES ('431081', '资兴市', '431000');
INSERT INTO `pro_city_area` VALUES ('431100', '永州市', '430000');
INSERT INTO `pro_city_area` VALUES ('431101', '市辖区', '431100');
INSERT INTO `pro_city_area` VALUES ('431102', '芝山区', '431100');
INSERT INTO `pro_city_area` VALUES ('431103', '冷水滩区', '431100');
INSERT INTO `pro_city_area` VALUES ('431121', '祁阳县', '431100');
INSERT INTO `pro_city_area` VALUES ('431122', '东安县', '431100');
INSERT INTO `pro_city_area` VALUES ('431123', '双牌县', '431100');
INSERT INTO `pro_city_area` VALUES ('431124', '道　县', '431100');
INSERT INTO `pro_city_area` VALUES ('431125', '江永县', '431100');
INSERT INTO `pro_city_area` VALUES ('431126', '宁远县', '431100');
INSERT INTO `pro_city_area` VALUES ('431127', '蓝山县', '431100');
INSERT INTO `pro_city_area` VALUES ('431128', '新田县', '431100');
INSERT INTO `pro_city_area` VALUES ('431129', '江华瑶族自治县', '431100');
INSERT INTO `pro_city_area` VALUES ('431200', '怀化市', '430000');
INSERT INTO `pro_city_area` VALUES ('431201', '市辖区', '431200');
INSERT INTO `pro_city_area` VALUES ('431202', '鹤城区', '431200');
INSERT INTO `pro_city_area` VALUES ('431221', '中方县', '431200');
INSERT INTO `pro_city_area` VALUES ('431222', '沅陵县', '431200');
INSERT INTO `pro_city_area` VALUES ('431223', '辰溪县', '431200');
INSERT INTO `pro_city_area` VALUES ('431224', '溆浦县', '431200');
INSERT INTO `pro_city_area` VALUES ('431225', '会同县', '431200');
INSERT INTO `pro_city_area` VALUES ('431226', '麻阳苗族自治县', '431200');
INSERT INTO `pro_city_area` VALUES ('431227', '新晃侗族自治县', '431200');
INSERT INTO `pro_city_area` VALUES ('431228', '芷江侗族自治县', '431200');
INSERT INTO `pro_city_area` VALUES ('431229', '靖州苗族侗族自治县', '431200');
INSERT INTO `pro_city_area` VALUES ('431230', '通道侗族自治县', '431200');
INSERT INTO `pro_city_area` VALUES ('431281', '洪江市', '431200');
INSERT INTO `pro_city_area` VALUES ('431300', '娄底市', '430000');
INSERT INTO `pro_city_area` VALUES ('431301', '市辖区', '431300');
INSERT INTO `pro_city_area` VALUES ('431302', '娄星区', '431300');
INSERT INTO `pro_city_area` VALUES ('431321', '双峰县', '431300');
INSERT INTO `pro_city_area` VALUES ('431322', '新化县', '431300');
INSERT INTO `pro_city_area` VALUES ('431381', '冷水江市', '431300');
INSERT INTO `pro_city_area` VALUES ('431382', '涟源市', '431300');
INSERT INTO `pro_city_area` VALUES ('433100', '湘西土家族苗族自治州', '430000');
INSERT INTO `pro_city_area` VALUES ('433101', '吉首市', '433100');
INSERT INTO `pro_city_area` VALUES ('433122', '泸溪县', '433100');
INSERT INTO `pro_city_area` VALUES ('433123', '凤凰县', '433100');
INSERT INTO `pro_city_area` VALUES ('433124', '花垣县', '433100');
INSERT INTO `pro_city_area` VALUES ('433125', '保靖县', '433100');
INSERT INTO `pro_city_area` VALUES ('433126', '古丈县', '433100');
INSERT INTO `pro_city_area` VALUES ('433127', '永顺县', '433100');
INSERT INTO `pro_city_area` VALUES ('433130', '龙山县', '433100');
INSERT INTO `pro_city_area` VALUES ('440000', '广东省', '0');
INSERT INTO `pro_city_area` VALUES ('440100', '广州市', '440000');
INSERT INTO `pro_city_area` VALUES ('440101', '市辖区', '440100');
INSERT INTO `pro_city_area` VALUES ('440102', '东山区', '440100');
INSERT INTO `pro_city_area` VALUES ('440103', '荔湾区', '440100');
INSERT INTO `pro_city_area` VALUES ('440104', '越秀区', '440100');
INSERT INTO `pro_city_area` VALUES ('440105', '海珠区', '440100');
INSERT INTO `pro_city_area` VALUES ('440106', '天河区', '440100');
INSERT INTO `pro_city_area` VALUES ('440107', '芳村区', '440100');
INSERT INTO `pro_city_area` VALUES ('440111', '白云区', '440100');
INSERT INTO `pro_city_area` VALUES ('440112', '黄埔区', '440100');
INSERT INTO `pro_city_area` VALUES ('440113', '番禺区', '440100');
INSERT INTO `pro_city_area` VALUES ('440114', '花都区', '440100');
INSERT INTO `pro_city_area` VALUES ('440183', '增城市', '440100');
INSERT INTO `pro_city_area` VALUES ('440184', '从化市', '440100');
INSERT INTO `pro_city_area` VALUES ('440200', '韶关市', '440000');
INSERT INTO `pro_city_area` VALUES ('440201', '市辖区', '440200');
INSERT INTO `pro_city_area` VALUES ('440203', '武江区', '440200');
INSERT INTO `pro_city_area` VALUES ('440204', '浈江区', '440200');
INSERT INTO `pro_city_area` VALUES ('440205', '曲江区', '440200');
INSERT INTO `pro_city_area` VALUES ('440222', '始兴县', '440200');
INSERT INTO `pro_city_area` VALUES ('440224', '仁化县', '440200');
INSERT INTO `pro_city_area` VALUES ('440229', '翁源县', '440200');
INSERT INTO `pro_city_area` VALUES ('440232', '乳源瑶族自治县', '440200');
INSERT INTO `pro_city_area` VALUES ('440233', '新丰县', '440200');
INSERT INTO `pro_city_area` VALUES ('440281', '乐昌市', '440200');
INSERT INTO `pro_city_area` VALUES ('440282', '南雄市', '440200');
INSERT INTO `pro_city_area` VALUES ('440300', '深圳市', '440000');
INSERT INTO `pro_city_area` VALUES ('440301', '市辖区', '440300');
INSERT INTO `pro_city_area` VALUES ('440303', '罗湖区', '440300');
INSERT INTO `pro_city_area` VALUES ('440304', '福田区', '440300');
INSERT INTO `pro_city_area` VALUES ('440305', '南山区', '440300');
INSERT INTO `pro_city_area` VALUES ('440306', '宝安区', '440300');
INSERT INTO `pro_city_area` VALUES ('440307', '龙岗区', '440300');
INSERT INTO `pro_city_area` VALUES ('440308', '盐田区', '440300');
INSERT INTO `pro_city_area` VALUES ('440400', '珠海市', '440000');
INSERT INTO `pro_city_area` VALUES ('440401', '市辖区', '440400');
INSERT INTO `pro_city_area` VALUES ('440402', '香洲区', '440400');
INSERT INTO `pro_city_area` VALUES ('440403', '斗门区', '440400');
INSERT INTO `pro_city_area` VALUES ('440404', '金湾区', '440400');
INSERT INTO `pro_city_area` VALUES ('440500', '汕头市', '440000');
INSERT INTO `pro_city_area` VALUES ('440501', '市辖区', '440500');
INSERT INTO `pro_city_area` VALUES ('440507', '龙湖区', '440500');
INSERT INTO `pro_city_area` VALUES ('440511', '金平区', '440500');
INSERT INTO `pro_city_area` VALUES ('440512', '濠江区', '440500');
INSERT INTO `pro_city_area` VALUES ('440513', '潮阳区', '440500');
INSERT INTO `pro_city_area` VALUES ('440514', '潮南区', '440500');
INSERT INTO `pro_city_area` VALUES ('440515', '澄海区', '440500');
INSERT INTO `pro_city_area` VALUES ('440523', '南澳县', '440500');
INSERT INTO `pro_city_area` VALUES ('440600', '佛山市', '440000');
INSERT INTO `pro_city_area` VALUES ('440601', '市辖区', '440600');
INSERT INTO `pro_city_area` VALUES ('440604', '禅城区', '440600');
INSERT INTO `pro_city_area` VALUES ('440605', '南海区', '440600');
INSERT INTO `pro_city_area` VALUES ('440606', '顺德区', '440600');
INSERT INTO `pro_city_area` VALUES ('440607', '三水区', '440600');
INSERT INTO `pro_city_area` VALUES ('440608', '高明区', '440600');
INSERT INTO `pro_city_area` VALUES ('440700', '江门市', '440000');
INSERT INTO `pro_city_area` VALUES ('440701', '市辖区', '440700');
INSERT INTO `pro_city_area` VALUES ('440703', '蓬江区', '440700');
INSERT INTO `pro_city_area` VALUES ('440704', '江海区', '440700');
INSERT INTO `pro_city_area` VALUES ('440705', '新会区', '440700');
INSERT INTO `pro_city_area` VALUES ('440781', '台山市', '440700');
INSERT INTO `pro_city_area` VALUES ('440783', '开平市', '440700');
INSERT INTO `pro_city_area` VALUES ('440784', '鹤山市', '440700');
INSERT INTO `pro_city_area` VALUES ('440785', '恩平市', '440700');
INSERT INTO `pro_city_area` VALUES ('440800', '湛江市', '440000');
INSERT INTO `pro_city_area` VALUES ('440801', '市辖区', '440800');
INSERT INTO `pro_city_area` VALUES ('440802', '赤坎区', '440800');
INSERT INTO `pro_city_area` VALUES ('440803', '霞山区', '440800');
INSERT INTO `pro_city_area` VALUES ('440804', '坡头区', '440800');
INSERT INTO `pro_city_area` VALUES ('440811', '麻章区', '440800');
INSERT INTO `pro_city_area` VALUES ('440823', '遂溪县', '440800');
INSERT INTO `pro_city_area` VALUES ('440825', '徐闻县', '440800');
INSERT INTO `pro_city_area` VALUES ('440881', '廉江市', '440800');
INSERT INTO `pro_city_area` VALUES ('440882', '雷州市', '440800');
INSERT INTO `pro_city_area` VALUES ('440883', '吴川市', '440800');
INSERT INTO `pro_city_area` VALUES ('440900', '茂名市', '440000');
INSERT INTO `pro_city_area` VALUES ('440901', '市辖区', '440900');
INSERT INTO `pro_city_area` VALUES ('440902', '茂南区', '440900');
INSERT INTO `pro_city_area` VALUES ('440903', '茂港区', '440900');
INSERT INTO `pro_city_area` VALUES ('440923', '电白县', '440900');
INSERT INTO `pro_city_area` VALUES ('440981', '高州市', '440900');
INSERT INTO `pro_city_area` VALUES ('440982', '化州市', '440900');
INSERT INTO `pro_city_area` VALUES ('440983', '信宜市', '440900');
INSERT INTO `pro_city_area` VALUES ('441200', '肇庆市', '440000');
INSERT INTO `pro_city_area` VALUES ('441201', '市辖区', '441200');
INSERT INTO `pro_city_area` VALUES ('441202', '端州区', '441200');
INSERT INTO `pro_city_area` VALUES ('441203', '鼎湖区', '441200');
INSERT INTO `pro_city_area` VALUES ('441223', '广宁县', '441200');
INSERT INTO `pro_city_area` VALUES ('441224', '怀集县', '441200');
INSERT INTO `pro_city_area` VALUES ('441225', '封开县', '441200');
INSERT INTO `pro_city_area` VALUES ('441226', '德庆县', '441200');
INSERT INTO `pro_city_area` VALUES ('441283', '高要市', '441200');
INSERT INTO `pro_city_area` VALUES ('441284', '四会市', '441200');
INSERT INTO `pro_city_area` VALUES ('441300', '惠州市', '440000');
INSERT INTO `pro_city_area` VALUES ('441301', '市辖区', '441300');
INSERT INTO `pro_city_area` VALUES ('441302', '惠城区', '441300');
INSERT INTO `pro_city_area` VALUES ('441303', '惠阳区', '441300');
INSERT INTO `pro_city_area` VALUES ('441322', '博罗县', '441300');
INSERT INTO `pro_city_area` VALUES ('441323', '惠东县', '441300');
INSERT INTO `pro_city_area` VALUES ('441324', '龙门县', '441300');
INSERT INTO `pro_city_area` VALUES ('441400', '梅州市', '440000');
INSERT INTO `pro_city_area` VALUES ('441401', '市辖区', '441400');
INSERT INTO `pro_city_area` VALUES ('441402', '梅江区', '441400');
INSERT INTO `pro_city_area` VALUES ('441421', '梅　县', '441400');
INSERT INTO `pro_city_area` VALUES ('441422', '大埔县', '441400');
INSERT INTO `pro_city_area` VALUES ('441423', '丰顺县', '441400');
INSERT INTO `pro_city_area` VALUES ('441424', '五华县', '441400');
INSERT INTO `pro_city_area` VALUES ('441426', '平远县', '441400');
INSERT INTO `pro_city_area` VALUES ('441427', '蕉岭县', '441400');
INSERT INTO `pro_city_area` VALUES ('441481', '兴宁市', '441400');
INSERT INTO `pro_city_area` VALUES ('441500', '汕尾市', '440000');
INSERT INTO `pro_city_area` VALUES ('441501', '市辖区', '441500');
INSERT INTO `pro_city_area` VALUES ('441502', '城　区', '441500');
INSERT INTO `pro_city_area` VALUES ('441521', '海丰县', '441500');
INSERT INTO `pro_city_area` VALUES ('441523', '陆河县', '441500');
INSERT INTO `pro_city_area` VALUES ('441581', '陆丰市', '441500');
INSERT INTO `pro_city_area` VALUES ('441600', '河源市', '440000');
INSERT INTO `pro_city_area` VALUES ('441601', '市辖区', '441600');
INSERT INTO `pro_city_area` VALUES ('441602', '源城区', '441600');
INSERT INTO `pro_city_area` VALUES ('441621', '紫金县', '441600');
INSERT INTO `pro_city_area` VALUES ('441622', '龙川县', '441600');
INSERT INTO `pro_city_area` VALUES ('441623', '连平县', '441600');
INSERT INTO `pro_city_area` VALUES ('441624', '和平县', '441600');
INSERT INTO `pro_city_area` VALUES ('441625', '东源县', '441600');
INSERT INTO `pro_city_area` VALUES ('441700', '阳江市', '440000');
INSERT INTO `pro_city_area` VALUES ('441701', '市辖区', '441700');
INSERT INTO `pro_city_area` VALUES ('441702', '江城区', '441700');
INSERT INTO `pro_city_area` VALUES ('441721', '阳西县', '441700');
INSERT INTO `pro_city_area` VALUES ('441723', '阳东县', '441700');
INSERT INTO `pro_city_area` VALUES ('441781', '阳春市', '441700');
INSERT INTO `pro_city_area` VALUES ('441800', '清远市', '440000');
INSERT INTO `pro_city_area` VALUES ('441801', '市辖区', '441800');
INSERT INTO `pro_city_area` VALUES ('441802', '清城区', '441800');
INSERT INTO `pro_city_area` VALUES ('441821', '佛冈县', '441800');
INSERT INTO `pro_city_area` VALUES ('441823', '阳山县', '441800');
INSERT INTO `pro_city_area` VALUES ('441825', '连山壮族瑶族自治县', '441800');
INSERT INTO `pro_city_area` VALUES ('441826', '连南瑶族自治县', '441800');
INSERT INTO `pro_city_area` VALUES ('441827', '清新县', '441800');
INSERT INTO `pro_city_area` VALUES ('441881', '英德市', '441800');
INSERT INTO `pro_city_area` VALUES ('441882', '连州市', '441800');
INSERT INTO `pro_city_area` VALUES ('441900', '东莞市', '440000');
INSERT INTO `pro_city_area` VALUES ('442000', '中山市', '440000');
INSERT INTO `pro_city_area` VALUES ('445100', '潮州市', '440000');
INSERT INTO `pro_city_area` VALUES ('445101', '市辖区', '445100');
INSERT INTO `pro_city_area` VALUES ('445102', '湘桥区', '445100');
INSERT INTO `pro_city_area` VALUES ('445121', '潮安县', '445100');
INSERT INTO `pro_city_area` VALUES ('445122', '饶平县', '445100');
INSERT INTO `pro_city_area` VALUES ('445200', '揭阳市', '440000');
INSERT INTO `pro_city_area` VALUES ('445201', '市辖区', '445200');
INSERT INTO `pro_city_area` VALUES ('445202', '榕城区', '445200');
INSERT INTO `pro_city_area` VALUES ('445221', '揭东县', '445200');
INSERT INTO `pro_city_area` VALUES ('445222', '揭西县', '445200');
INSERT INTO `pro_city_area` VALUES ('445224', '惠来县', '445200');
INSERT INTO `pro_city_area` VALUES ('445281', '普宁市', '445200');
INSERT INTO `pro_city_area` VALUES ('445300', '云浮市', '440000');
INSERT INTO `pro_city_area` VALUES ('445301', '市辖区', '445300');
INSERT INTO `pro_city_area` VALUES ('445302', '云城区', '445300');
INSERT INTO `pro_city_area` VALUES ('445321', '新兴县', '445300');
INSERT INTO `pro_city_area` VALUES ('445322', '郁南县', '445300');
INSERT INTO `pro_city_area` VALUES ('445323', '云安县', '445300');
INSERT INTO `pro_city_area` VALUES ('445381', '罗定市', '445300');
INSERT INTO `pro_city_area` VALUES ('450000', '广  西', '0');
INSERT INTO `pro_city_area` VALUES ('450100', '南宁市', '450000');
INSERT INTO `pro_city_area` VALUES ('450101', '市辖区', '450100');
INSERT INTO `pro_city_area` VALUES ('450102', '兴宁区', '450100');
INSERT INTO `pro_city_area` VALUES ('450103', '青秀区', '450100');
INSERT INTO `pro_city_area` VALUES ('450105', '江南区', '450100');
INSERT INTO `pro_city_area` VALUES ('450107', '西乡塘区', '450100');
INSERT INTO `pro_city_area` VALUES ('450108', '良庆区', '450100');
INSERT INTO `pro_city_area` VALUES ('450109', '邕宁区', '450100');
INSERT INTO `pro_city_area` VALUES ('450122', '武鸣县', '450100');
INSERT INTO `pro_city_area` VALUES ('450123', '隆安县', '450100');
INSERT INTO `pro_city_area` VALUES ('450124', '马山县', '450100');
INSERT INTO `pro_city_area` VALUES ('450125', '上林县', '450100');
INSERT INTO `pro_city_area` VALUES ('450126', '宾阳县', '450100');
INSERT INTO `pro_city_area` VALUES ('450127', '横　县', '450100');
INSERT INTO `pro_city_area` VALUES ('450200', '柳州市', '450000');
INSERT INTO `pro_city_area` VALUES ('450201', '市辖区', '450200');
INSERT INTO `pro_city_area` VALUES ('450202', '城中区', '450200');
INSERT INTO `pro_city_area` VALUES ('450203', '鱼峰区', '450200');
INSERT INTO `pro_city_area` VALUES ('450204', '柳南区', '450200');
INSERT INTO `pro_city_area` VALUES ('450205', '柳北区', '450200');
INSERT INTO `pro_city_area` VALUES ('450221', '柳江县', '450200');
INSERT INTO `pro_city_area` VALUES ('450222', '柳城县', '450200');
INSERT INTO `pro_city_area` VALUES ('450223', '鹿寨县', '450200');
INSERT INTO `pro_city_area` VALUES ('450224', '融安县', '450200');
INSERT INTO `pro_city_area` VALUES ('450225', '融水苗族自治县', '450200');
INSERT INTO `pro_city_area` VALUES ('450226', '三江侗族自治县', '450200');
INSERT INTO `pro_city_area` VALUES ('450300', '桂林市', '450000');
INSERT INTO `pro_city_area` VALUES ('450301', '市辖区', '450300');
INSERT INTO `pro_city_area` VALUES ('450302', '秀峰区', '450300');
INSERT INTO `pro_city_area` VALUES ('450303', '叠彩区', '450300');
INSERT INTO `pro_city_area` VALUES ('450304', '象山区', '450300');
INSERT INTO `pro_city_area` VALUES ('450305', '七星区', '450300');
INSERT INTO `pro_city_area` VALUES ('450311', '雁山区', '450300');
INSERT INTO `pro_city_area` VALUES ('450321', '阳朔县', '450300');
INSERT INTO `pro_city_area` VALUES ('450322', '临桂县', '450300');
INSERT INTO `pro_city_area` VALUES ('450323', '灵川县', '450300');
INSERT INTO `pro_city_area` VALUES ('450324', '全州县', '450300');
INSERT INTO `pro_city_area` VALUES ('450325', '兴安县', '450300');
INSERT INTO `pro_city_area` VALUES ('450326', '永福县', '450300');
INSERT INTO `pro_city_area` VALUES ('450327', '灌阳县', '450300');
INSERT INTO `pro_city_area` VALUES ('450328', '龙胜各族自治县', '450300');
INSERT INTO `pro_city_area` VALUES ('450329', '资源县', '450300');
INSERT INTO `pro_city_area` VALUES ('450330', '平乐县', '450300');
INSERT INTO `pro_city_area` VALUES ('450331', '荔蒲县', '450300');
INSERT INTO `pro_city_area` VALUES ('450332', '恭城瑶族自治县', '450300');
INSERT INTO `pro_city_area` VALUES ('450400', '梧州市', '450000');
INSERT INTO `pro_city_area` VALUES ('450401', '市辖区', '450400');
INSERT INTO `pro_city_area` VALUES ('450403', '万秀区', '450400');
INSERT INTO `pro_city_area` VALUES ('450404', '蝶山区', '450400');
INSERT INTO `pro_city_area` VALUES ('450405', '长洲区', '450400');
INSERT INTO `pro_city_area` VALUES ('450421', '苍梧县', '450400');
INSERT INTO `pro_city_area` VALUES ('450422', '藤　县', '450400');
INSERT INTO `pro_city_area` VALUES ('450423', '蒙山县', '450400');
INSERT INTO `pro_city_area` VALUES ('450481', '岑溪市', '450400');
INSERT INTO `pro_city_area` VALUES ('450500', '北海市', '450000');
INSERT INTO `pro_city_area` VALUES ('450501', '市辖区', '450500');
INSERT INTO `pro_city_area` VALUES ('450502', '海城区', '450500');
INSERT INTO `pro_city_area` VALUES ('450503', '银海区', '450500');
INSERT INTO `pro_city_area` VALUES ('450512', '铁山港区', '450500');
INSERT INTO `pro_city_area` VALUES ('450521', '合浦县', '450500');
INSERT INTO `pro_city_area` VALUES ('450600', '防城港市', '450000');
INSERT INTO `pro_city_area` VALUES ('450601', '市辖区', '450600');
INSERT INTO `pro_city_area` VALUES ('450602', '港口区', '450600');
INSERT INTO `pro_city_area` VALUES ('450603', '防城区', '450600');
INSERT INTO `pro_city_area` VALUES ('450621', '上思县', '450600');
INSERT INTO `pro_city_area` VALUES ('450681', '东兴市', '450600');
INSERT INTO `pro_city_area` VALUES ('450700', '钦州市', '450000');
INSERT INTO `pro_city_area` VALUES ('450701', '市辖区', '450700');
INSERT INTO `pro_city_area` VALUES ('450702', '钦南区', '450700');
INSERT INTO `pro_city_area` VALUES ('450703', '钦北区', '450700');
INSERT INTO `pro_city_area` VALUES ('450721', '灵山县', '450700');
INSERT INTO `pro_city_area` VALUES ('450722', '浦北县', '450700');
INSERT INTO `pro_city_area` VALUES ('450800', '贵港市', '450000');
INSERT INTO `pro_city_area` VALUES ('450801', '市辖区', '450800');
INSERT INTO `pro_city_area` VALUES ('450802', '港北区', '450800');
INSERT INTO `pro_city_area` VALUES ('450803', '港南区', '450800');
INSERT INTO `pro_city_area` VALUES ('450804', '覃塘区', '450800');
INSERT INTO `pro_city_area` VALUES ('450821', '平南县', '450800');
INSERT INTO `pro_city_area` VALUES ('450881', '桂平市', '450800');
INSERT INTO `pro_city_area` VALUES ('450900', '玉林市', '450000');
INSERT INTO `pro_city_area` VALUES ('450901', '市辖区', '450900');
INSERT INTO `pro_city_area` VALUES ('450902', '玉州区', '450900');
INSERT INTO `pro_city_area` VALUES ('450921', '容　县', '450900');
INSERT INTO `pro_city_area` VALUES ('450922', '陆川县', '450900');
INSERT INTO `pro_city_area` VALUES ('450923', '博白县', '450900');
INSERT INTO `pro_city_area` VALUES ('450924', '兴业县', '450900');
INSERT INTO `pro_city_area` VALUES ('450981', '北流市', '450900');
INSERT INTO `pro_city_area` VALUES ('451000', '百色市', '450000');
INSERT INTO `pro_city_area` VALUES ('451001', '市辖区', '451000');
INSERT INTO `pro_city_area` VALUES ('451002', '右江区', '451000');
INSERT INTO `pro_city_area` VALUES ('451021', '田阳县', '451000');
INSERT INTO `pro_city_area` VALUES ('451022', '田东县', '451000');
INSERT INTO `pro_city_area` VALUES ('451023', '平果县', '451000');
INSERT INTO `pro_city_area` VALUES ('451024', '德保县', '451000');
INSERT INTO `pro_city_area` VALUES ('451025', '靖西县', '451000');
INSERT INTO `pro_city_area` VALUES ('451026', '那坡县', '451000');
INSERT INTO `pro_city_area` VALUES ('451027', '凌云县', '451000');
INSERT INTO `pro_city_area` VALUES ('451028', '乐业县', '451000');
INSERT INTO `pro_city_area` VALUES ('451029', '田林县', '451000');
INSERT INTO `pro_city_area` VALUES ('451030', '西林县', '451000');
INSERT INTO `pro_city_area` VALUES ('451031', '隆林各族自治县', '451000');
INSERT INTO `pro_city_area` VALUES ('451100', '贺州市', '450000');
INSERT INTO `pro_city_area` VALUES ('451101', '市辖区', '451100');
INSERT INTO `pro_city_area` VALUES ('451102', '八步区', '451100');
INSERT INTO `pro_city_area` VALUES ('451121', '昭平县', '451100');
INSERT INTO `pro_city_area` VALUES ('451122', '钟山县', '451100');
INSERT INTO `pro_city_area` VALUES ('451123', '富川瑶族自治县', '451100');
INSERT INTO `pro_city_area` VALUES ('451200', '河池市', '450000');
INSERT INTO `pro_city_area` VALUES ('451201', '市辖区', '451200');
INSERT INTO `pro_city_area` VALUES ('451202', '金城江区', '451200');
INSERT INTO `pro_city_area` VALUES ('451221', '南丹县', '451200');
INSERT INTO `pro_city_area` VALUES ('451222', '天峨县', '451200');
INSERT INTO `pro_city_area` VALUES ('451223', '凤山县', '451200');
INSERT INTO `pro_city_area` VALUES ('451224', '东兰县', '451200');
INSERT INTO `pro_city_area` VALUES ('451225', '罗城仫佬族自治县', '451200');
INSERT INTO `pro_city_area` VALUES ('451226', '环江毛南族自治县', '451200');
INSERT INTO `pro_city_area` VALUES ('451227', '巴马瑶族自治县', '451200');
INSERT INTO `pro_city_area` VALUES ('451228', '都安瑶族自治县', '451200');
INSERT INTO `pro_city_area` VALUES ('451229', '大化瑶族自治县', '451200');
INSERT INTO `pro_city_area` VALUES ('451281', '宜州市', '451200');
INSERT INTO `pro_city_area` VALUES ('451300', '来宾市', '450000');
INSERT INTO `pro_city_area` VALUES ('451301', '市辖区', '451300');
INSERT INTO `pro_city_area` VALUES ('451302', '兴宾区', '451300');
INSERT INTO `pro_city_area` VALUES ('451321', '忻城县', '451300');
INSERT INTO `pro_city_area` VALUES ('451322', '象州县', '451300');
INSERT INTO `pro_city_area` VALUES ('451323', '武宣县', '451300');
INSERT INTO `pro_city_area` VALUES ('451324', '金秀瑶族自治县', '451300');
INSERT INTO `pro_city_area` VALUES ('451381', '合山市', '451300');
INSERT INTO `pro_city_area` VALUES ('451400', '崇左市', '450000');
INSERT INTO `pro_city_area` VALUES ('451401', '市辖区', '451400');
INSERT INTO `pro_city_area` VALUES ('451402', '江洲区', '451400');
INSERT INTO `pro_city_area` VALUES ('451421', '扶绥县', '451400');
INSERT INTO `pro_city_area` VALUES ('451422', '宁明县', '451400');
INSERT INTO `pro_city_area` VALUES ('451423', '龙州县', '451400');
INSERT INTO `pro_city_area` VALUES ('451424', '大新县', '451400');
INSERT INTO `pro_city_area` VALUES ('451425', '天等县', '451400');
INSERT INTO `pro_city_area` VALUES ('451481', '凭祥市', '451400');
INSERT INTO `pro_city_area` VALUES ('460000', '海南省', '0');
INSERT INTO `pro_city_area` VALUES ('460100', '海口市', '460000');
INSERT INTO `pro_city_area` VALUES ('460101', '市辖区', '460100');
INSERT INTO `pro_city_area` VALUES ('460105', '秀英区', '460100');
INSERT INTO `pro_city_area` VALUES ('460106', '龙华区', '460100');
INSERT INTO `pro_city_area` VALUES ('460107', '琼山区', '460100');
INSERT INTO `pro_city_area` VALUES ('460108', '美兰区', '460100');
INSERT INTO `pro_city_area` VALUES ('460200', '三亚市', '460000');
INSERT INTO `pro_city_area` VALUES ('460201', '市辖区', '460200');
INSERT INTO `pro_city_area` VALUES ('469000', '省直辖县级行政单位', '460000');
INSERT INTO `pro_city_area` VALUES ('469001', '五指山市', '469000');
INSERT INTO `pro_city_area` VALUES ('469002', '琼海市', '469000');
INSERT INTO `pro_city_area` VALUES ('469003', '儋州市', '469000');
INSERT INTO `pro_city_area` VALUES ('469005', '文昌市', '469000');
INSERT INTO `pro_city_area` VALUES ('469006', '万宁市', '469000');
INSERT INTO `pro_city_area` VALUES ('469007', '东方市', '469000');
INSERT INTO `pro_city_area` VALUES ('469025', '定安县', '469000');
INSERT INTO `pro_city_area` VALUES ('469026', '屯昌县', '469000');
INSERT INTO `pro_city_area` VALUES ('469027', '澄迈县', '469000');
INSERT INTO `pro_city_area` VALUES ('469028', '临高县', '469000');
INSERT INTO `pro_city_area` VALUES ('469030', '白沙黎族自治县', '469000');
INSERT INTO `pro_city_area` VALUES ('469031', '昌江黎族自治县', '469000');
INSERT INTO `pro_city_area` VALUES ('469033', '乐东黎族自治县', '469000');
INSERT INTO `pro_city_area` VALUES ('469034', '陵水黎族自治县', '469000');
INSERT INTO `pro_city_area` VALUES ('469035', '保亭黎族苗族自治县', '469000');
INSERT INTO `pro_city_area` VALUES ('469036', '琼中黎族苗族自治县', '469000');
INSERT INTO `pro_city_area` VALUES ('469037', '西沙群岛', '469000');
INSERT INTO `pro_city_area` VALUES ('469038', '南沙群岛', '469000');
INSERT INTO `pro_city_area` VALUES ('469039', '中沙群岛的岛礁及其海域', '469000');
INSERT INTO `pro_city_area` VALUES ('500000', '重庆市', '0');
INSERT INTO `pro_city_area` VALUES ('500100', '市辖区', '500000');
INSERT INTO `pro_city_area` VALUES ('500101', '万州区', '500100');
INSERT INTO `pro_city_area` VALUES ('500102', '涪陵区', '500100');
INSERT INTO `pro_city_area` VALUES ('500103', '渝中区', '500100');
INSERT INTO `pro_city_area` VALUES ('500104', '大渡口区', '500100');
INSERT INTO `pro_city_area` VALUES ('500105', '江北区', '500100');
INSERT INTO `pro_city_area` VALUES ('500106', '沙坪坝区', '500100');
INSERT INTO `pro_city_area` VALUES ('500107', '九龙坡区', '500100');
INSERT INTO `pro_city_area` VALUES ('500108', '南岸区', '500100');
INSERT INTO `pro_city_area` VALUES ('500109', '北碚区', '500100');
INSERT INTO `pro_city_area` VALUES ('500110', '万盛区', '500100');
INSERT INTO `pro_city_area` VALUES ('500111', '双桥区', '500100');
INSERT INTO `pro_city_area` VALUES ('500112', '渝北区', '500100');
INSERT INTO `pro_city_area` VALUES ('500113', '巴南区', '500100');
INSERT INTO `pro_city_area` VALUES ('500114', '黔江区', '500100');
INSERT INTO `pro_city_area` VALUES ('500115', '长寿区', '500100');
INSERT INTO `pro_city_area` VALUES ('500200', '县', '500000');
INSERT INTO `pro_city_area` VALUES ('500222', '綦江县', '500200');
INSERT INTO `pro_city_area` VALUES ('500223', '潼南县', '500200');
INSERT INTO `pro_city_area` VALUES ('500224', '铜梁县', '500200');
INSERT INTO `pro_city_area` VALUES ('500225', '大足县', '500200');
INSERT INTO `pro_city_area` VALUES ('500226', '荣昌县', '500200');
INSERT INTO `pro_city_area` VALUES ('500227', '璧山县', '500200');
INSERT INTO `pro_city_area` VALUES ('500228', '梁平县', '500200');
INSERT INTO `pro_city_area` VALUES ('500229', '城口县', '500200');
INSERT INTO `pro_city_area` VALUES ('500230', '丰都县', '500200');
INSERT INTO `pro_city_area` VALUES ('500231', '垫江县', '500200');
INSERT INTO `pro_city_area` VALUES ('500232', '武隆县', '500200');
INSERT INTO `pro_city_area` VALUES ('500233', '忠　县', '500200');
INSERT INTO `pro_city_area` VALUES ('500234', '开　县', '500200');
INSERT INTO `pro_city_area` VALUES ('500235', '云阳县', '500200');
INSERT INTO `pro_city_area` VALUES ('500236', '奉节县', '500200');
INSERT INTO `pro_city_area` VALUES ('500237', '巫山县', '500200');
INSERT INTO `pro_city_area` VALUES ('500238', '巫溪县', '500200');
INSERT INTO `pro_city_area` VALUES ('500240', '石柱土家族自治县', '500200');
INSERT INTO `pro_city_area` VALUES ('500241', '秀山土家族苗族自治县', '500200');
INSERT INTO `pro_city_area` VALUES ('500242', '酉阳土家族苗族自治县', '500200');
INSERT INTO `pro_city_area` VALUES ('500243', '彭水苗族土家族自治县', '500200');
INSERT INTO `pro_city_area` VALUES ('500300', '市', '500000');
INSERT INTO `pro_city_area` VALUES ('500381', '江津市', '500300');
INSERT INTO `pro_city_area` VALUES ('500382', '合川市', '500300');
INSERT INTO `pro_city_area` VALUES ('500383', '永川市', '500300');
INSERT INTO `pro_city_area` VALUES ('500384', '南川市', '500300');
INSERT INTO `pro_city_area` VALUES ('510000', '四川省', '0');
INSERT INTO `pro_city_area` VALUES ('510100', '成都市', '510000');
INSERT INTO `pro_city_area` VALUES ('510101', '市辖区', '510100');
INSERT INTO `pro_city_area` VALUES ('510104', '锦江区', '510100');
INSERT INTO `pro_city_area` VALUES ('510105', '青羊区', '510100');
INSERT INTO `pro_city_area` VALUES ('510106', '金牛区', '510100');
INSERT INTO `pro_city_area` VALUES ('510107', '武侯区', '510100');
INSERT INTO `pro_city_area` VALUES ('510108', '成华区', '510100');
INSERT INTO `pro_city_area` VALUES ('510112', '龙泉驿区', '510100');
INSERT INTO `pro_city_area` VALUES ('510113', '青白江区', '510100');
INSERT INTO `pro_city_area` VALUES ('510114', '新都区', '510100');
INSERT INTO `pro_city_area` VALUES ('510115', '温江区', '510100');
INSERT INTO `pro_city_area` VALUES ('510121', '金堂县', '510100');
INSERT INTO `pro_city_area` VALUES ('510122', '双流县', '510100');
INSERT INTO `pro_city_area` VALUES ('510124', '郫　县', '510100');
INSERT INTO `pro_city_area` VALUES ('510129', '大邑县', '510100');
INSERT INTO `pro_city_area` VALUES ('510131', '蒲江县', '510100');
INSERT INTO `pro_city_area` VALUES ('510132', '新津县', '510100');
INSERT INTO `pro_city_area` VALUES ('510181', '都江堰市', '510100');
INSERT INTO `pro_city_area` VALUES ('510182', '彭州市', '510100');
INSERT INTO `pro_city_area` VALUES ('510183', '邛崃市', '510100');
INSERT INTO `pro_city_area` VALUES ('510184', '崇州市', '510100');
INSERT INTO `pro_city_area` VALUES ('510300', '自贡市', '510000');
INSERT INTO `pro_city_area` VALUES ('510301', '市辖区', '510300');
INSERT INTO `pro_city_area` VALUES ('510302', '自流井区', '510300');
INSERT INTO `pro_city_area` VALUES ('510303', '贡井区', '510300');
INSERT INTO `pro_city_area` VALUES ('510304', '大安区', '510300');
INSERT INTO `pro_city_area` VALUES ('510311', '沿滩区', '510300');
INSERT INTO `pro_city_area` VALUES ('510321', '荣　县', '510300');
INSERT INTO `pro_city_area` VALUES ('510322', '富顺县', '510300');
INSERT INTO `pro_city_area` VALUES ('510400', '攀枝花市', '510000');
INSERT INTO `pro_city_area` VALUES ('510401', '市辖区', '510400');
INSERT INTO `pro_city_area` VALUES ('510402', '东　区', '510400');
INSERT INTO `pro_city_area` VALUES ('510403', '西　区', '510400');
INSERT INTO `pro_city_area` VALUES ('510411', '仁和区', '510400');
INSERT INTO `pro_city_area` VALUES ('510421', '米易县', '510400');
INSERT INTO `pro_city_area` VALUES ('510422', '盐边县', '510400');
INSERT INTO `pro_city_area` VALUES ('510500', '泸州市', '510000');
INSERT INTO `pro_city_area` VALUES ('510501', '市辖区', '510500');
INSERT INTO `pro_city_area` VALUES ('510502', '江阳区', '510500');
INSERT INTO `pro_city_area` VALUES ('510503', '纳溪区', '510500');
INSERT INTO `pro_city_area` VALUES ('510504', '龙马潭区', '510500');
INSERT INTO `pro_city_area` VALUES ('510521', '泸　县', '510500');
INSERT INTO `pro_city_area` VALUES ('510522', '合江县', '510500');
INSERT INTO `pro_city_area` VALUES ('510524', '叙永县', '510500');
INSERT INTO `pro_city_area` VALUES ('510525', '古蔺县', '510500');
INSERT INTO `pro_city_area` VALUES ('510600', '德阳市', '510000');
INSERT INTO `pro_city_area` VALUES ('510601', '市辖区', '510600');
INSERT INTO `pro_city_area` VALUES ('510603', '旌阳区', '510600');
INSERT INTO `pro_city_area` VALUES ('510623', '中江县', '510600');
INSERT INTO `pro_city_area` VALUES ('510626', '罗江县', '510600');
INSERT INTO `pro_city_area` VALUES ('510681', '广汉市', '510600');
INSERT INTO `pro_city_area` VALUES ('510682', '什邡市', '510600');
INSERT INTO `pro_city_area` VALUES ('510683', '绵竹市', '510600');
INSERT INTO `pro_city_area` VALUES ('510700', '绵阳市', '510000');
INSERT INTO `pro_city_area` VALUES ('510701', '市辖区', '510700');
INSERT INTO `pro_city_area` VALUES ('510703', '涪城区', '510700');
INSERT INTO `pro_city_area` VALUES ('510704', '游仙区', '510700');
INSERT INTO `pro_city_area` VALUES ('510722', '三台县', '510700');
INSERT INTO `pro_city_area` VALUES ('510723', '盐亭县', '510700');
INSERT INTO `pro_city_area` VALUES ('510724', '安　县', '510700');
INSERT INTO `pro_city_area` VALUES ('510725', '梓潼县', '510700');
INSERT INTO `pro_city_area` VALUES ('510726', '北川羌族自治县', '510700');
INSERT INTO `pro_city_area` VALUES ('510727', '平武县', '510700');
INSERT INTO `pro_city_area` VALUES ('510781', '江油市', '510700');
INSERT INTO `pro_city_area` VALUES ('510800', '广元市', '510000');
INSERT INTO `pro_city_area` VALUES ('510801', '市辖区', '510800');
INSERT INTO `pro_city_area` VALUES ('510802', '市中区', '510800');
INSERT INTO `pro_city_area` VALUES ('510811', '元坝区', '510800');
INSERT INTO `pro_city_area` VALUES ('510812', '朝天区', '510800');
INSERT INTO `pro_city_area` VALUES ('510821', '旺苍县', '510800');
INSERT INTO `pro_city_area` VALUES ('510822', '青川县', '510800');
INSERT INTO `pro_city_area` VALUES ('510823', '剑阁县', '510800');
INSERT INTO `pro_city_area` VALUES ('510824', '苍溪县', '510800');
INSERT INTO `pro_city_area` VALUES ('510900', '遂宁市', '510000');
INSERT INTO `pro_city_area` VALUES ('510901', '市辖区', '510900');
INSERT INTO `pro_city_area` VALUES ('510903', '船山区', '510900');
INSERT INTO `pro_city_area` VALUES ('510904', '安居区', '510900');
INSERT INTO `pro_city_area` VALUES ('510921', '蓬溪县', '510900');
INSERT INTO `pro_city_area` VALUES ('510922', '射洪县', '510900');
INSERT INTO `pro_city_area` VALUES ('510923', '大英县', '510900');
INSERT INTO `pro_city_area` VALUES ('511000', '内江市', '510000');
INSERT INTO `pro_city_area` VALUES ('511001', '市辖区', '511000');
INSERT INTO `pro_city_area` VALUES ('511002', '市中区', '511000');
INSERT INTO `pro_city_area` VALUES ('511011', '东兴区', '511000');
INSERT INTO `pro_city_area` VALUES ('511024', '威远县', '511000');
INSERT INTO `pro_city_area` VALUES ('511025', '资中县', '511000');
INSERT INTO `pro_city_area` VALUES ('511028', '隆昌县', '511000');
INSERT INTO `pro_city_area` VALUES ('511100', '乐山市', '510000');
INSERT INTO `pro_city_area` VALUES ('511101', '市辖区', '511100');
INSERT INTO `pro_city_area` VALUES ('511102', '市中区', '511100');
INSERT INTO `pro_city_area` VALUES ('511111', '沙湾区', '511100');
INSERT INTO `pro_city_area` VALUES ('511112', '五通桥区', '511100');
INSERT INTO `pro_city_area` VALUES ('511113', '金口河区', '511100');
INSERT INTO `pro_city_area` VALUES ('511123', '犍为县', '511100');
INSERT INTO `pro_city_area` VALUES ('511124', '井研县', '511100');
INSERT INTO `pro_city_area` VALUES ('511126', '夹江县', '511100');
INSERT INTO `pro_city_area` VALUES ('511129', '沐川县', '511100');
INSERT INTO `pro_city_area` VALUES ('511132', '峨边彝族自治县', '511100');
INSERT INTO `pro_city_area` VALUES ('511133', '马边彝族自治县', '511100');
INSERT INTO `pro_city_area` VALUES ('511181', '峨眉山市', '511100');
INSERT INTO `pro_city_area` VALUES ('511300', '南充市', '510000');
INSERT INTO `pro_city_area` VALUES ('511301', '市辖区', '511300');
INSERT INTO `pro_city_area` VALUES ('511302', '顺庆区', '511300');
INSERT INTO `pro_city_area` VALUES ('511303', '高坪区', '511300');
INSERT INTO `pro_city_area` VALUES ('511304', '嘉陵区', '511300');
INSERT INTO `pro_city_area` VALUES ('511321', '南部县', '511300');
INSERT INTO `pro_city_area` VALUES ('511322', '营山县', '511300');
INSERT INTO `pro_city_area` VALUES ('511323', '蓬安县', '511300');
INSERT INTO `pro_city_area` VALUES ('511324', '仪陇县', '511300');
INSERT INTO `pro_city_area` VALUES ('511325', '西充县', '511300');
INSERT INTO `pro_city_area` VALUES ('511381', '阆中市', '511300');
INSERT INTO `pro_city_area` VALUES ('511400', '眉山市', '510000');
INSERT INTO `pro_city_area` VALUES ('511401', '市辖区', '511400');
INSERT INTO `pro_city_area` VALUES ('511402', '东坡区', '511400');
INSERT INTO `pro_city_area` VALUES ('511421', '仁寿县', '511400');
INSERT INTO `pro_city_area` VALUES ('511422', '彭山县', '511400');
INSERT INTO `pro_city_area` VALUES ('511423', '洪雅县', '511400');
INSERT INTO `pro_city_area` VALUES ('511424', '丹棱县', '511400');
INSERT INTO `pro_city_area` VALUES ('511425', '青神县', '511400');
INSERT INTO `pro_city_area` VALUES ('511500', '宜宾市', '510000');
INSERT INTO `pro_city_area` VALUES ('511501', '市辖区', '511500');
INSERT INTO `pro_city_area` VALUES ('511502', '翠屏区', '511500');
INSERT INTO `pro_city_area` VALUES ('511521', '宜宾县', '511500');
INSERT INTO `pro_city_area` VALUES ('511522', '南溪县', '511500');
INSERT INTO `pro_city_area` VALUES ('511523', '江安县', '511500');
INSERT INTO `pro_city_area` VALUES ('511524', '长宁县', '511500');
INSERT INTO `pro_city_area` VALUES ('511525', '高　县', '511500');
INSERT INTO `pro_city_area` VALUES ('511526', '珙　县', '511500');
INSERT INTO `pro_city_area` VALUES ('511527', '筠连县', '511500');
INSERT INTO `pro_city_area` VALUES ('511528', '兴文县', '511500');
INSERT INTO `pro_city_area` VALUES ('511529', '屏山县', '511500');
INSERT INTO `pro_city_area` VALUES ('511600', '广安市', '510000');
INSERT INTO `pro_city_area` VALUES ('511601', '市辖区', '511600');
INSERT INTO `pro_city_area` VALUES ('511602', '广安区', '511600');
INSERT INTO `pro_city_area` VALUES ('511621', '岳池县', '511600');
INSERT INTO `pro_city_area` VALUES ('511622', '武胜县', '511600');
INSERT INTO `pro_city_area` VALUES ('511623', '邻水县', '511600');
INSERT INTO `pro_city_area` VALUES ('511681', '华莹市', '511600');
INSERT INTO `pro_city_area` VALUES ('511700', '达州市', '510000');
INSERT INTO `pro_city_area` VALUES ('511701', '市辖区', '511700');
INSERT INTO `pro_city_area` VALUES ('511702', '通川区', '511700');
INSERT INTO `pro_city_area` VALUES ('511721', '达　县', '511700');
INSERT INTO `pro_city_area` VALUES ('511722', '宣汉县', '511700');
INSERT INTO `pro_city_area` VALUES ('511723', '开江县', '511700');
INSERT INTO `pro_city_area` VALUES ('511724', '大竹县', '511700');
INSERT INTO `pro_city_area` VALUES ('511725', '渠　县', '511700');
INSERT INTO `pro_city_area` VALUES ('511781', '万源市', '511700');
INSERT INTO `pro_city_area` VALUES ('511800', '雅安市', '510000');
INSERT INTO `pro_city_area` VALUES ('511801', '市辖区', '511800');
INSERT INTO `pro_city_area` VALUES ('511802', '雨城区', '511800');
INSERT INTO `pro_city_area` VALUES ('511821', '名山县', '511800');
INSERT INTO `pro_city_area` VALUES ('511822', '荥经县', '511800');
INSERT INTO `pro_city_area` VALUES ('511823', '汉源县', '511800');
INSERT INTO `pro_city_area` VALUES ('511824', '石棉县', '511800');
INSERT INTO `pro_city_area` VALUES ('511825', '天全县', '511800');
INSERT INTO `pro_city_area` VALUES ('511826', '芦山县', '511800');
INSERT INTO `pro_city_area` VALUES ('511827', '宝兴县', '511800');
INSERT INTO `pro_city_area` VALUES ('511900', '巴中市', '510000');
INSERT INTO `pro_city_area` VALUES ('511901', '市辖区', '511900');
INSERT INTO `pro_city_area` VALUES ('511902', '巴州区', '511900');
INSERT INTO `pro_city_area` VALUES ('511921', '通江县', '511900');
INSERT INTO `pro_city_area` VALUES ('511922', '南江县', '511900');
INSERT INTO `pro_city_area` VALUES ('511923', '平昌县', '511900');
INSERT INTO `pro_city_area` VALUES ('512000', '资阳市', '510000');
INSERT INTO `pro_city_area` VALUES ('512001', '市辖区', '512000');
INSERT INTO `pro_city_area` VALUES ('512002', '雁江区', '512000');
INSERT INTO `pro_city_area` VALUES ('512021', '安岳县', '512000');
INSERT INTO `pro_city_area` VALUES ('512022', '乐至县', '512000');
INSERT INTO `pro_city_area` VALUES ('512081', '简阳市', '512000');
INSERT INTO `pro_city_area` VALUES ('513200', '阿坝藏族羌族自治州', '510000');
INSERT INTO `pro_city_area` VALUES ('513221', '汶川县', '513200');
INSERT INTO `pro_city_area` VALUES ('513222', '理　县', '513200');
INSERT INTO `pro_city_area` VALUES ('513223', '茂　县', '513200');
INSERT INTO `pro_city_area` VALUES ('513224', '松潘县', '513200');
INSERT INTO `pro_city_area` VALUES ('513225', '九寨沟县', '513200');
INSERT INTO `pro_city_area` VALUES ('513226', '金川县', '513200');
INSERT INTO `pro_city_area` VALUES ('513227', '小金县', '513200');
INSERT INTO `pro_city_area` VALUES ('513228', '黑水县', '513200');
INSERT INTO `pro_city_area` VALUES ('513229', '马尔康县', '513200');
INSERT INTO `pro_city_area` VALUES ('513230', '壤塘县', '513200');
INSERT INTO `pro_city_area` VALUES ('513231', '阿坝县', '513200');
INSERT INTO `pro_city_area` VALUES ('513232', '若尔盖县', '513200');
INSERT INTO `pro_city_area` VALUES ('513233', '红原县', '513200');
INSERT INTO `pro_city_area` VALUES ('513300', '甘孜藏族自治州', '510000');
INSERT INTO `pro_city_area` VALUES ('513321', '康定县', '513300');
INSERT INTO `pro_city_area` VALUES ('513322', '泸定县', '513300');
INSERT INTO `pro_city_area` VALUES ('513323', '丹巴县', '513300');
INSERT INTO `pro_city_area` VALUES ('513324', '九龙县', '513300');
INSERT INTO `pro_city_area` VALUES ('513325', '雅江县', '513300');
INSERT INTO `pro_city_area` VALUES ('513326', '道孚县', '513300');
INSERT INTO `pro_city_area` VALUES ('513327', '炉霍县', '513300');
INSERT INTO `pro_city_area` VALUES ('513328', '甘孜县', '513300');
INSERT INTO `pro_city_area` VALUES ('513329', '新龙县', '513300');
INSERT INTO `pro_city_area` VALUES ('513330', '德格县', '513300');
INSERT INTO `pro_city_area` VALUES ('513331', '白玉县', '513300');
INSERT INTO `pro_city_area` VALUES ('513332', '石渠县', '513300');
INSERT INTO `pro_city_area` VALUES ('513333', '色达县', '513300');
INSERT INTO `pro_city_area` VALUES ('513334', '理塘县', '513300');
INSERT INTO `pro_city_area` VALUES ('513335', '巴塘县', '513300');
INSERT INTO `pro_city_area` VALUES ('513336', '乡城县', '513300');
INSERT INTO `pro_city_area` VALUES ('513337', '稻城县', '513300');
INSERT INTO `pro_city_area` VALUES ('513338', '得荣县', '513300');
INSERT INTO `pro_city_area` VALUES ('513400', '凉山彝族自治州', '510000');
INSERT INTO `pro_city_area` VALUES ('513401', '西昌市', '513400');
INSERT INTO `pro_city_area` VALUES ('513422', '木里藏族自治县', '513400');
INSERT INTO `pro_city_area` VALUES ('513423', '盐源县', '513400');
INSERT INTO `pro_city_area` VALUES ('513424', '德昌县', '513400');
INSERT INTO `pro_city_area` VALUES ('513425', '会理县', '513400');
INSERT INTO `pro_city_area` VALUES ('513426', '会东县', '513400');
INSERT INTO `pro_city_area` VALUES ('513427', '宁南县', '513400');
INSERT INTO `pro_city_area` VALUES ('513428', '普格县', '513400');
INSERT INTO `pro_city_area` VALUES ('513429', '布拖县', '513400');
INSERT INTO `pro_city_area` VALUES ('513430', '金阳县', '513400');
INSERT INTO `pro_city_area` VALUES ('513431', '昭觉县', '513400');
INSERT INTO `pro_city_area` VALUES ('513432', '喜德县', '513400');
INSERT INTO `pro_city_area` VALUES ('513433', '冕宁县', '513400');
INSERT INTO `pro_city_area` VALUES ('513434', '越西县', '513400');
INSERT INTO `pro_city_area` VALUES ('513435', '甘洛县', '513400');
INSERT INTO `pro_city_area` VALUES ('513436', '美姑县', '513400');
INSERT INTO `pro_city_area` VALUES ('513437', '雷波县', '513400');
INSERT INTO `pro_city_area` VALUES ('520000', '贵州省', '0');
INSERT INTO `pro_city_area` VALUES ('520100', '贵阳市', '520000');
INSERT INTO `pro_city_area` VALUES ('520101', '市辖区', '520100');
INSERT INTO `pro_city_area` VALUES ('520102', '南明区', '520100');
INSERT INTO `pro_city_area` VALUES ('520103', '云岩区', '520100');
INSERT INTO `pro_city_area` VALUES ('520111', '花溪区', '520100');
INSERT INTO `pro_city_area` VALUES ('520112', '乌当区', '520100');
INSERT INTO `pro_city_area` VALUES ('520113', '白云区', '520100');
INSERT INTO `pro_city_area` VALUES ('520114', '小河区', '520100');
INSERT INTO `pro_city_area` VALUES ('520121', '开阳县', '520100');
INSERT INTO `pro_city_area` VALUES ('520122', '息烽县', '520100');
INSERT INTO `pro_city_area` VALUES ('520123', '修文县', '520100');
INSERT INTO `pro_city_area` VALUES ('520181', '清镇市', '520100');
INSERT INTO `pro_city_area` VALUES ('520200', '六盘水市', '520000');
INSERT INTO `pro_city_area` VALUES ('520201', '钟山区', '520200');
INSERT INTO `pro_city_area` VALUES ('520203', '六枝特区', '520200');
INSERT INTO `pro_city_area` VALUES ('520221', '水城县', '520200');
INSERT INTO `pro_city_area` VALUES ('520222', '盘　县', '520200');
INSERT INTO `pro_city_area` VALUES ('520300', '遵义市', '520000');
INSERT INTO `pro_city_area` VALUES ('520301', '市辖区', '520300');
INSERT INTO `pro_city_area` VALUES ('520302', '红花岗区', '520300');
INSERT INTO `pro_city_area` VALUES ('520303', '汇川区', '520300');
INSERT INTO `pro_city_area` VALUES ('520321', '遵义县', '520300');
INSERT INTO `pro_city_area` VALUES ('520322', '桐梓县', '520300');
INSERT INTO `pro_city_area` VALUES ('520323', '绥阳县', '520300');
INSERT INTO `pro_city_area` VALUES ('520324', '正安县', '520300');
INSERT INTO `pro_city_area` VALUES ('520325', '道真仡佬族苗族自治县', '520300');
INSERT INTO `pro_city_area` VALUES ('520326', '务川仡佬族苗族自治县', '520300');
INSERT INTO `pro_city_area` VALUES ('520327', '凤冈县', '520300');
INSERT INTO `pro_city_area` VALUES ('520328', '湄潭县', '520300');
INSERT INTO `pro_city_area` VALUES ('520329', '余庆县', '520300');
INSERT INTO `pro_city_area` VALUES ('520330', '习水县', '520300');
INSERT INTO `pro_city_area` VALUES ('520381', '赤水市', '520300');
INSERT INTO `pro_city_area` VALUES ('520382', '仁怀市', '520300');
INSERT INTO `pro_city_area` VALUES ('520400', '安顺市', '520000');
INSERT INTO `pro_city_area` VALUES ('520401', '市辖区', '520400');
INSERT INTO `pro_city_area` VALUES ('520402', '西秀区', '520400');
INSERT INTO `pro_city_area` VALUES ('520421', '平坝县', '520400');
INSERT INTO `pro_city_area` VALUES ('520422', '普定县', '520400');
INSERT INTO `pro_city_area` VALUES ('520423', '镇宁布依族苗族自治县', '520400');
INSERT INTO `pro_city_area` VALUES ('520424', '关岭布依族苗族自治县', '520400');
INSERT INTO `pro_city_area` VALUES ('520425', '紫云苗族布依族自治县', '520400');
INSERT INTO `pro_city_area` VALUES ('522200', '铜仁地区', '520000');
INSERT INTO `pro_city_area` VALUES ('522201', '铜仁市', '522200');
INSERT INTO `pro_city_area` VALUES ('522222', '江口县', '522200');
INSERT INTO `pro_city_area` VALUES ('522223', '玉屏侗族自治县', '522200');
INSERT INTO `pro_city_area` VALUES ('522224', '石阡县', '522200');
INSERT INTO `pro_city_area` VALUES ('522225', '思南县', '522200');
INSERT INTO `pro_city_area` VALUES ('522226', '印江土家族苗族自治县', '522200');
INSERT INTO `pro_city_area` VALUES ('522227', '德江县', '522200');
INSERT INTO `pro_city_area` VALUES ('522228', '沿河土家族自治县', '522200');
INSERT INTO `pro_city_area` VALUES ('522229', '松桃苗族自治县', '522200');
INSERT INTO `pro_city_area` VALUES ('522230', '万山特区', '522200');
INSERT INTO `pro_city_area` VALUES ('522300', '黔西南布依族苗族自治州', '520000');
INSERT INTO `pro_city_area` VALUES ('522301', '兴义市', '522300');
INSERT INTO `pro_city_area` VALUES ('522322', '兴仁县', '522300');
INSERT INTO `pro_city_area` VALUES ('522323', '普安县', '522300');
INSERT INTO `pro_city_area` VALUES ('522324', '晴隆县', '522300');
INSERT INTO `pro_city_area` VALUES ('522325', '贞丰县', '522300');
INSERT INTO `pro_city_area` VALUES ('522326', '望谟县', '522300');
INSERT INTO `pro_city_area` VALUES ('522327', '册亨县', '522300');
INSERT INTO `pro_city_area` VALUES ('522328', '安龙县', '522300');
INSERT INTO `pro_city_area` VALUES ('522400', '毕节地区', '520000');
INSERT INTO `pro_city_area` VALUES ('522401', '毕节市', '522400');
INSERT INTO `pro_city_area` VALUES ('522422', '大方县', '522400');
INSERT INTO `pro_city_area` VALUES ('522423', '黔西县', '522400');
INSERT INTO `pro_city_area` VALUES ('522424', '金沙县', '522400');
INSERT INTO `pro_city_area` VALUES ('522425', '织金县', '522400');
INSERT INTO `pro_city_area` VALUES ('522426', '纳雍县', '522400');
INSERT INTO `pro_city_area` VALUES ('522427', '威宁彝族回族苗族自治县', '522400');
INSERT INTO `pro_city_area` VALUES ('522428', '赫章县', '522400');
INSERT INTO `pro_city_area` VALUES ('522600', '黔东南苗族侗族自治州', '520000');
INSERT INTO `pro_city_area` VALUES ('522601', '凯里市', '522600');
INSERT INTO `pro_city_area` VALUES ('522622', '黄平县', '522600');
INSERT INTO `pro_city_area` VALUES ('522623', '施秉县', '522600');
INSERT INTO `pro_city_area` VALUES ('522624', '三穗县', '522600');
INSERT INTO `pro_city_area` VALUES ('522625', '镇远县', '522600');
INSERT INTO `pro_city_area` VALUES ('522626', '岑巩县', '522600');
INSERT INTO `pro_city_area` VALUES ('522627', '天柱县', '522600');
INSERT INTO `pro_city_area` VALUES ('522628', '锦屏县', '522600');
INSERT INTO `pro_city_area` VALUES ('522629', '剑河县', '522600');
INSERT INTO `pro_city_area` VALUES ('522630', '台江县', '522600');
INSERT INTO `pro_city_area` VALUES ('522631', '黎平县', '522600');
INSERT INTO `pro_city_area` VALUES ('522632', '榕江县', '522600');
INSERT INTO `pro_city_area` VALUES ('522633', '从江县', '522600');
INSERT INTO `pro_city_area` VALUES ('522634', '雷山县', '522600');
INSERT INTO `pro_city_area` VALUES ('522635', '麻江县', '522600');
INSERT INTO `pro_city_area` VALUES ('522636', '丹寨县', '522600');
INSERT INTO `pro_city_area` VALUES ('522700', '黔南布依族苗族自治州', '520000');
INSERT INTO `pro_city_area` VALUES ('522701', '都匀市', '522700');
INSERT INTO `pro_city_area` VALUES ('522702', '福泉市', '522700');
INSERT INTO `pro_city_area` VALUES ('522722', '荔波县', '522700');
INSERT INTO `pro_city_area` VALUES ('522723', '贵定县', '522700');
INSERT INTO `pro_city_area` VALUES ('522725', '瓮安县', '522700');
INSERT INTO `pro_city_area` VALUES ('522726', '独山县', '522700');
INSERT INTO `pro_city_area` VALUES ('522727', '平塘县', '522700');
INSERT INTO `pro_city_area` VALUES ('522728', '罗甸县', '522700');
INSERT INTO `pro_city_area` VALUES ('522729', '长顺县', '522700');
INSERT INTO `pro_city_area` VALUES ('522730', '龙里县', '522700');
INSERT INTO `pro_city_area` VALUES ('522731', '惠水县', '522700');
INSERT INTO `pro_city_area` VALUES ('522732', '三都水族自治县', '522700');
INSERT INTO `pro_city_area` VALUES ('530000', '云南省', '0');
INSERT INTO `pro_city_area` VALUES ('530100', '昆明市', '530000');
INSERT INTO `pro_city_area` VALUES ('530101', '市辖区', '530100');
INSERT INTO `pro_city_area` VALUES ('530102', '五华区', '530100');
INSERT INTO `pro_city_area` VALUES ('530103', '盘龙区', '530100');
INSERT INTO `pro_city_area` VALUES ('530111', '官渡区', '530100');
INSERT INTO `pro_city_area` VALUES ('530112', '西山区', '530100');
INSERT INTO `pro_city_area` VALUES ('530113', '东川区', '530100');
INSERT INTO `pro_city_area` VALUES ('530121', '呈贡县', '530100');
INSERT INTO `pro_city_area` VALUES ('530122', '晋宁县', '530100');
INSERT INTO `pro_city_area` VALUES ('530124', '富民县', '530100');
INSERT INTO `pro_city_area` VALUES ('530125', '宜良县', '530100');
INSERT INTO `pro_city_area` VALUES ('530126', '石林彝族自治县', '530100');
INSERT INTO `pro_city_area` VALUES ('530127', '嵩明县', '530100');
INSERT INTO `pro_city_area` VALUES ('530128', '禄劝彝族苗族自治县', '530100');
INSERT INTO `pro_city_area` VALUES ('530129', '寻甸回族彝族自治县', '530100');
INSERT INTO `pro_city_area` VALUES ('530181', '安宁市', '530100');
INSERT INTO `pro_city_area` VALUES ('530300', '曲靖市', '530000');
INSERT INTO `pro_city_area` VALUES ('530301', '市辖区', '530300');
INSERT INTO `pro_city_area` VALUES ('530302', '麒麟区', '530300');
INSERT INTO `pro_city_area` VALUES ('530321', '马龙县', '530300');
INSERT INTO `pro_city_area` VALUES ('530322', '陆良县', '530300');
INSERT INTO `pro_city_area` VALUES ('530323', '师宗县', '530300');
INSERT INTO `pro_city_area` VALUES ('530324', '罗平县', '530300');
INSERT INTO `pro_city_area` VALUES ('530325', '富源县', '530300');
INSERT INTO `pro_city_area` VALUES ('530326', '会泽县', '530300');
INSERT INTO `pro_city_area` VALUES ('530328', '沾益县', '530300');
INSERT INTO `pro_city_area` VALUES ('530381', '宣威市', '530300');
INSERT INTO `pro_city_area` VALUES ('530400', '玉溪市', '530000');
INSERT INTO `pro_city_area` VALUES ('530401', '市辖区', '530400');
INSERT INTO `pro_city_area` VALUES ('530402', '红塔区', '530400');
INSERT INTO `pro_city_area` VALUES ('530421', '江川县', '530400');
INSERT INTO `pro_city_area` VALUES ('530422', '澄江县', '530400');
INSERT INTO `pro_city_area` VALUES ('530423', '通海县', '530400');
INSERT INTO `pro_city_area` VALUES ('530424', '华宁县', '530400');
INSERT INTO `pro_city_area` VALUES ('530425', '易门县', '530400');
INSERT INTO `pro_city_area` VALUES ('530426', '峨山彝族自治县', '530400');
INSERT INTO `pro_city_area` VALUES ('530427', '新平彝族傣族自治县', '530400');
INSERT INTO `pro_city_area` VALUES ('530428', '元江哈尼族彝族傣族自治县', '530400');
INSERT INTO `pro_city_area` VALUES ('530500', '保山市', '530000');
INSERT INTO `pro_city_area` VALUES ('530501', '市辖区', '530500');
INSERT INTO `pro_city_area` VALUES ('530502', '隆阳区', '530500');
INSERT INTO `pro_city_area` VALUES ('530521', '施甸县', '530500');
INSERT INTO `pro_city_area` VALUES ('530522', '腾冲县', '530500');
INSERT INTO `pro_city_area` VALUES ('530523', '龙陵县', '530500');
INSERT INTO `pro_city_area` VALUES ('530524', '昌宁县', '530500');
INSERT INTO `pro_city_area` VALUES ('530600', '昭通市', '530000');
INSERT INTO `pro_city_area` VALUES ('530601', '市辖区', '530600');
INSERT INTO `pro_city_area` VALUES ('530602', '昭阳区', '530600');
INSERT INTO `pro_city_area` VALUES ('530621', '鲁甸县', '530600');
INSERT INTO `pro_city_area` VALUES ('530622', '巧家县', '530600');
INSERT INTO `pro_city_area` VALUES ('530623', '盐津县', '530600');
INSERT INTO `pro_city_area` VALUES ('530624', '大关县', '530600');
INSERT INTO `pro_city_area` VALUES ('530625', '永善县', '530600');
INSERT INTO `pro_city_area` VALUES ('530626', '绥江县', '530600');
INSERT INTO `pro_city_area` VALUES ('530627', '镇雄县', '530600');
INSERT INTO `pro_city_area` VALUES ('530628', '彝良县', '530600');
INSERT INTO `pro_city_area` VALUES ('530629', '威信县', '530600');
INSERT INTO `pro_city_area` VALUES ('530630', '水富县', '530600');
INSERT INTO `pro_city_area` VALUES ('530700', '丽江市', '530000');
INSERT INTO `pro_city_area` VALUES ('530701', '市辖区', '530700');
INSERT INTO `pro_city_area` VALUES ('530702', '古城区', '530700');
INSERT INTO `pro_city_area` VALUES ('530721', '玉龙纳西族自治县', '530700');
INSERT INTO `pro_city_area` VALUES ('530722', '永胜县', '530700');
INSERT INTO `pro_city_area` VALUES ('530723', '华坪县', '530700');
INSERT INTO `pro_city_area` VALUES ('530724', '宁蒗彝族自治县', '530700');
INSERT INTO `pro_city_area` VALUES ('530800', '思茅市', '530000');
INSERT INTO `pro_city_area` VALUES ('530801', '市辖区', '530800');
INSERT INTO `pro_city_area` VALUES ('530802', '翠云区', '530800');
INSERT INTO `pro_city_area` VALUES ('530821', '普洱哈尼族彝族自治县', '530800');
INSERT INTO `pro_city_area` VALUES ('530822', '墨江哈尼族自治县', '530800');
INSERT INTO `pro_city_area` VALUES ('530823', '景东彝族自治县', '530800');
INSERT INTO `pro_city_area` VALUES ('530824', '景谷傣族彝族自治县', '530800');
INSERT INTO `pro_city_area` VALUES ('530825', '镇沅彝族哈尼族拉祜族自治县', '530800');
INSERT INTO `pro_city_area` VALUES ('530826', '江城哈尼族彝族自治县', '530800');
INSERT INTO `pro_city_area` VALUES ('530827', '孟连傣族拉祜族佤族自治县', '530800');
INSERT INTO `pro_city_area` VALUES ('530828', '澜沧拉祜族自治县', '530800');
INSERT INTO `pro_city_area` VALUES ('530829', '西盟佤族自治县', '530800');
INSERT INTO `pro_city_area` VALUES ('530900', '临沧市', '530000');
INSERT INTO `pro_city_area` VALUES ('530901', '市辖区', '530900');
INSERT INTO `pro_city_area` VALUES ('530902', '临翔区', '530900');
INSERT INTO `pro_city_area` VALUES ('530921', '凤庆县', '530900');
INSERT INTO `pro_city_area` VALUES ('530922', '云　县', '530900');
INSERT INTO `pro_city_area` VALUES ('530923', '永德县', '530900');
INSERT INTO `pro_city_area` VALUES ('530924', '镇康县', '530900');
INSERT INTO `pro_city_area` VALUES ('530925', '双江拉祜族佤族布朗族傣族自治县', '530900');
INSERT INTO `pro_city_area` VALUES ('530926', '耿马傣族佤族自治县', '530900');
INSERT INTO `pro_city_area` VALUES ('530927', '沧源佤族自治县', '530900');
INSERT INTO `pro_city_area` VALUES ('532300', '楚雄彝族自治州', '530000');
INSERT INTO `pro_city_area` VALUES ('532301', '楚雄市', '532300');
INSERT INTO `pro_city_area` VALUES ('532322', '双柏县', '532300');
INSERT INTO `pro_city_area` VALUES ('532323', '牟定县', '532300');
INSERT INTO `pro_city_area` VALUES ('532324', '南华县', '532300');
INSERT INTO `pro_city_area` VALUES ('532325', '姚安县', '532300');
INSERT INTO `pro_city_area` VALUES ('532326', '大姚县', '532300');
INSERT INTO `pro_city_area` VALUES ('532327', '永仁县', '532300');
INSERT INTO `pro_city_area` VALUES ('532328', '元谋县', '532300');
INSERT INTO `pro_city_area` VALUES ('532329', '武定县', '532300');
INSERT INTO `pro_city_area` VALUES ('532331', '禄丰县', '532300');
INSERT INTO `pro_city_area` VALUES ('532500', '红河哈尼族彝族自治州', '530000');
INSERT INTO `pro_city_area` VALUES ('532501', '个旧市', '532500');
INSERT INTO `pro_city_area` VALUES ('532502', '开远市', '532500');
INSERT INTO `pro_city_area` VALUES ('532522', '蒙自县', '532500');
INSERT INTO `pro_city_area` VALUES ('532523', '屏边苗族自治县', '532500');
INSERT INTO `pro_city_area` VALUES ('532524', '建水县', '532500');
INSERT INTO `pro_city_area` VALUES ('532525', '石屏县', '532500');
INSERT INTO `pro_city_area` VALUES ('532526', '弥勒县', '532500');
INSERT INTO `pro_city_area` VALUES ('532527', '泸西县', '532500');
INSERT INTO `pro_city_area` VALUES ('532528', '元阳县', '532500');
INSERT INTO `pro_city_area` VALUES ('532529', '红河县', '532500');
INSERT INTO `pro_city_area` VALUES ('532530', '金平苗族瑶族傣族自治县', '532500');
INSERT INTO `pro_city_area` VALUES ('532531', '绿春县', '532500');
INSERT INTO `pro_city_area` VALUES ('532532', '河口瑶族自治县', '532500');
INSERT INTO `pro_city_area` VALUES ('532600', '文山壮族苗族自治州', '530000');
INSERT INTO `pro_city_area` VALUES ('532621', '文山县', '532600');
INSERT INTO `pro_city_area` VALUES ('532622', '砚山县', '532600');
INSERT INTO `pro_city_area` VALUES ('532623', '西畴县', '532600');
INSERT INTO `pro_city_area` VALUES ('532624', '麻栗坡县', '532600');
INSERT INTO `pro_city_area` VALUES ('532625', '马关县', '532600');
INSERT INTO `pro_city_area` VALUES ('532626', '丘北县', '532600');
INSERT INTO `pro_city_area` VALUES ('532627', '广南县', '532600');
INSERT INTO `pro_city_area` VALUES ('532628', '富宁县', '532600');
INSERT INTO `pro_city_area` VALUES ('532800', '西双版纳傣族自治州', '530000');
INSERT INTO `pro_city_area` VALUES ('532801', '景洪市', '532800');
INSERT INTO `pro_city_area` VALUES ('532822', '勐海县', '532800');
INSERT INTO `pro_city_area` VALUES ('532823', '勐腊县', '532800');
INSERT INTO `pro_city_area` VALUES ('532900', '大理白族自治州', '530000');
INSERT INTO `pro_city_area` VALUES ('532901', '大理市', '532900');
INSERT INTO `pro_city_area` VALUES ('532922', '漾濞彝族自治县', '532900');
INSERT INTO `pro_city_area` VALUES ('532923', '祥云县', '532900');
INSERT INTO `pro_city_area` VALUES ('532924', '宾川县', '532900');
INSERT INTO `pro_city_area` VALUES ('532925', '弥渡县', '532900');
INSERT INTO `pro_city_area` VALUES ('532926', '南涧彝族自治县', '532900');
INSERT INTO `pro_city_area` VALUES ('532927', '巍山彝族回族自治县', '532900');
INSERT INTO `pro_city_area` VALUES ('532928', '永平县', '532900');
INSERT INTO `pro_city_area` VALUES ('532929', '云龙县', '532900');
INSERT INTO `pro_city_area` VALUES ('532930', '洱源县', '532900');
INSERT INTO `pro_city_area` VALUES ('532931', '剑川县', '532900');
INSERT INTO `pro_city_area` VALUES ('532932', '鹤庆县', '532900');
INSERT INTO `pro_city_area` VALUES ('533100', '德宏傣族景颇族自治州', '530000');
INSERT INTO `pro_city_area` VALUES ('533102', '瑞丽市', '533100');
INSERT INTO `pro_city_area` VALUES ('533103', '潞西市', '533100');
INSERT INTO `pro_city_area` VALUES ('533122', '梁河县', '533100');
INSERT INTO `pro_city_area` VALUES ('533123', '盈江县', '533100');
INSERT INTO `pro_city_area` VALUES ('533124', '陇川县', '533100');
INSERT INTO `pro_city_area` VALUES ('533300', '怒江傈僳族自治州', '530000');
INSERT INTO `pro_city_area` VALUES ('533321', '泸水县', '533300');
INSERT INTO `pro_city_area` VALUES ('533323', '福贡县', '533300');
INSERT INTO `pro_city_area` VALUES ('533324', '贡山独龙族怒族自治县', '533300');
INSERT INTO `pro_city_area` VALUES ('533325', '兰坪白族普米族自治县', '533300');
INSERT INTO `pro_city_area` VALUES ('533400', '迪庆藏族自治州', '530000');
INSERT INTO `pro_city_area` VALUES ('533421', '香格里拉县', '533400');
INSERT INTO `pro_city_area` VALUES ('533422', '德钦县', '533400');
INSERT INTO `pro_city_area` VALUES ('533423', '维西傈僳族自治县', '533400');
INSERT INTO `pro_city_area` VALUES ('540000', '西  藏', '0');
INSERT INTO `pro_city_area` VALUES ('540100', '拉萨市', '540000');
INSERT INTO `pro_city_area` VALUES ('540101', '市辖区', '540100');
INSERT INTO `pro_city_area` VALUES ('540102', '城关区', '540100');
INSERT INTO `pro_city_area` VALUES ('540121', '林周县', '540100');
INSERT INTO `pro_city_area` VALUES ('540122', '当雄县', '540100');
INSERT INTO `pro_city_area` VALUES ('540123', '尼木县', '540100');
INSERT INTO `pro_city_area` VALUES ('540124', '曲水县', '540100');
INSERT INTO `pro_city_area` VALUES ('540125', '堆龙德庆县', '540100');
INSERT INTO `pro_city_area` VALUES ('540126', '达孜县', '540100');
INSERT INTO `pro_city_area` VALUES ('540127', '墨竹工卡县', '540100');
INSERT INTO `pro_city_area` VALUES ('542100', '昌都地区', '540000');
INSERT INTO `pro_city_area` VALUES ('542121', '昌都县', '542100');
INSERT INTO `pro_city_area` VALUES ('542122', '江达县', '542100');
INSERT INTO `pro_city_area` VALUES ('542123', '贡觉县', '542100');
INSERT INTO `pro_city_area` VALUES ('542124', '类乌齐县', '542100');
INSERT INTO `pro_city_area` VALUES ('542125', '丁青县', '542100');
INSERT INTO `pro_city_area` VALUES ('542126', '察雅县', '542100');
INSERT INTO `pro_city_area` VALUES ('542127', '八宿县', '542100');
INSERT INTO `pro_city_area` VALUES ('542128', '左贡县', '542100');
INSERT INTO `pro_city_area` VALUES ('542129', '芒康县', '542100');
INSERT INTO `pro_city_area` VALUES ('542132', '洛隆县', '542100');
INSERT INTO `pro_city_area` VALUES ('542133', '边坝县', '542100');
INSERT INTO `pro_city_area` VALUES ('542200', '山南地区', '540000');
INSERT INTO `pro_city_area` VALUES ('542221', '乃东县', '542200');
INSERT INTO `pro_city_area` VALUES ('542222', '扎囊县', '542200');
INSERT INTO `pro_city_area` VALUES ('542223', '贡嘎县', '542200');
INSERT INTO `pro_city_area` VALUES ('542224', '桑日县', '542200');
INSERT INTO `pro_city_area` VALUES ('542225', '琼结县', '542200');
INSERT INTO `pro_city_area` VALUES ('542226', '曲松县', '542200');
INSERT INTO `pro_city_area` VALUES ('542227', '措美县', '542200');
INSERT INTO `pro_city_area` VALUES ('542228', '洛扎县', '542200');
INSERT INTO `pro_city_area` VALUES ('542229', '加查县', '542200');
INSERT INTO `pro_city_area` VALUES ('542231', '隆子县', '542200');
INSERT INTO `pro_city_area` VALUES ('542232', '错那县', '542200');
INSERT INTO `pro_city_area` VALUES ('542233', '浪卡子县', '542200');
INSERT INTO `pro_city_area` VALUES ('542300', '日喀则地区', '540000');
INSERT INTO `pro_city_area` VALUES ('542301', '日喀则市', '542300');
INSERT INTO `pro_city_area` VALUES ('542322', '南木林县', '542300');
INSERT INTO `pro_city_area` VALUES ('542323', '江孜县', '542300');
INSERT INTO `pro_city_area` VALUES ('542324', '定日县', '542300');
INSERT INTO `pro_city_area` VALUES ('542325', '萨迦县', '542300');
INSERT INTO `pro_city_area` VALUES ('542326', '拉孜县', '542300');
INSERT INTO `pro_city_area` VALUES ('542327', '昂仁县', '542300');
INSERT INTO `pro_city_area` VALUES ('542328', '谢通门县', '542300');
INSERT INTO `pro_city_area` VALUES ('542329', '白朗县', '542300');
INSERT INTO `pro_city_area` VALUES ('542330', '仁布县', '542300');
INSERT INTO `pro_city_area` VALUES ('542331', '康马县', '542300');
INSERT INTO `pro_city_area` VALUES ('542332', '定结县', '542300');
INSERT INTO `pro_city_area` VALUES ('542333', '仲巴县', '542300');
INSERT INTO `pro_city_area` VALUES ('542334', '亚东县', '542300');
INSERT INTO `pro_city_area` VALUES ('542335', '吉隆县', '542300');
INSERT INTO `pro_city_area` VALUES ('542336', '聂拉木县', '542300');
INSERT INTO `pro_city_area` VALUES ('542337', '萨嘎县', '542300');
INSERT INTO `pro_city_area` VALUES ('542338', '岗巴县', '542300');
INSERT INTO `pro_city_area` VALUES ('542400', '那曲地区', '540000');
INSERT INTO `pro_city_area` VALUES ('542421', '那曲县', '542400');
INSERT INTO `pro_city_area` VALUES ('542422', '嘉黎县', '542400');
INSERT INTO `pro_city_area` VALUES ('542423', '比如县', '542400');
INSERT INTO `pro_city_area` VALUES ('542424', '聂荣县', '542400');
INSERT INTO `pro_city_area` VALUES ('542425', '安多县', '542400');
INSERT INTO `pro_city_area` VALUES ('542426', '申扎县', '542400');
INSERT INTO `pro_city_area` VALUES ('542427', '索　县', '542400');
INSERT INTO `pro_city_area` VALUES ('542428', '班戈县', '542400');
INSERT INTO `pro_city_area` VALUES ('542429', '巴青县', '542400');
INSERT INTO `pro_city_area` VALUES ('542430', '尼玛县', '542400');
INSERT INTO `pro_city_area` VALUES ('542500', '阿里地区', '540000');
INSERT INTO `pro_city_area` VALUES ('542521', '普兰县', '542500');
INSERT INTO `pro_city_area` VALUES ('542522', '札达县', '542500');
INSERT INTO `pro_city_area` VALUES ('542523', '噶尔县', '542500');
INSERT INTO `pro_city_area` VALUES ('542524', '日土县', '542500');
INSERT INTO `pro_city_area` VALUES ('542525', '革吉县', '542500');
INSERT INTO `pro_city_area` VALUES ('542526', '改则县', '542500');
INSERT INTO `pro_city_area` VALUES ('542527', '措勤县', '542500');
INSERT INTO `pro_city_area` VALUES ('542600', '林芝地区', '540000');
INSERT INTO `pro_city_area` VALUES ('542621', '林芝县', '542600');
INSERT INTO `pro_city_area` VALUES ('542622', '工布江达县', '542600');
INSERT INTO `pro_city_area` VALUES ('542623', '米林县', '542600');
INSERT INTO `pro_city_area` VALUES ('542624', '墨脱县', '542600');
INSERT INTO `pro_city_area` VALUES ('542625', '波密县', '542600');
INSERT INTO `pro_city_area` VALUES ('542626', '察隅县', '542600');
INSERT INTO `pro_city_area` VALUES ('542627', '朗　县', '542600');
INSERT INTO `pro_city_area` VALUES ('610000', '陕西省', '0');
INSERT INTO `pro_city_area` VALUES ('610100', '西安市', '610000');
INSERT INTO `pro_city_area` VALUES ('610101', '市辖区', '610100');
INSERT INTO `pro_city_area` VALUES ('610102', '新城区', '610100');
INSERT INTO `pro_city_area` VALUES ('610103', '碑林区', '610100');
INSERT INTO `pro_city_area` VALUES ('610104', '莲湖区', '610100');
INSERT INTO `pro_city_area` VALUES ('610111', '灞桥区', '610100');
INSERT INTO `pro_city_area` VALUES ('610112', '未央区', '610100');
INSERT INTO `pro_city_area` VALUES ('610113', '雁塔区', '610100');
INSERT INTO `pro_city_area` VALUES ('610114', '阎良区', '610100');
INSERT INTO `pro_city_area` VALUES ('610115', '临潼区', '610100');
INSERT INTO `pro_city_area` VALUES ('610116', '长安区', '610100');
INSERT INTO `pro_city_area` VALUES ('610122', '蓝田县', '610100');
INSERT INTO `pro_city_area` VALUES ('610124', '周至县', '610100');
INSERT INTO `pro_city_area` VALUES ('610125', '户　县', '610100');
INSERT INTO `pro_city_area` VALUES ('610126', '高陵县', '610100');
INSERT INTO `pro_city_area` VALUES ('610200', '铜川市', '610000');
INSERT INTO `pro_city_area` VALUES ('610201', '市辖区', '610200');
INSERT INTO `pro_city_area` VALUES ('610202', '王益区', '610200');
INSERT INTO `pro_city_area` VALUES ('610203', '印台区', '610200');
INSERT INTO `pro_city_area` VALUES ('610204', '耀州区', '610200');
INSERT INTO `pro_city_area` VALUES ('610222', '宜君县', '610200');
INSERT INTO `pro_city_area` VALUES ('610300', '宝鸡市', '610000');
INSERT INTO `pro_city_area` VALUES ('610301', '市辖区', '610300');
INSERT INTO `pro_city_area` VALUES ('610302', '渭滨区', '610300');
INSERT INTO `pro_city_area` VALUES ('610303', '金台区', '610300');
INSERT INTO `pro_city_area` VALUES ('610304', '陈仓区', '610300');
INSERT INTO `pro_city_area` VALUES ('610322', '凤翔县', '610300');
INSERT INTO `pro_city_area` VALUES ('610323', '岐山县', '610300');
INSERT INTO `pro_city_area` VALUES ('610324', '扶风县', '610300');
INSERT INTO `pro_city_area` VALUES ('610326', '眉　县', '610300');
INSERT INTO `pro_city_area` VALUES ('610327', '陇　县', '610300');
INSERT INTO `pro_city_area` VALUES ('610328', '千阳县', '610300');
INSERT INTO `pro_city_area` VALUES ('610329', '麟游县', '610300');
INSERT INTO `pro_city_area` VALUES ('610330', '凤　县', '610300');
INSERT INTO `pro_city_area` VALUES ('610331', '太白县', '610300');
INSERT INTO `pro_city_area` VALUES ('610400', '咸阳市', '610000');
INSERT INTO `pro_city_area` VALUES ('610401', '市辖区', '610400');
INSERT INTO `pro_city_area` VALUES ('610402', '秦都区', '610400');
INSERT INTO `pro_city_area` VALUES ('610403', '杨凌区', '610400');
INSERT INTO `pro_city_area` VALUES ('610404', '渭城区', '610400');
INSERT INTO `pro_city_area` VALUES ('610422', '三原县', '610400');
INSERT INTO `pro_city_area` VALUES ('610423', '泾阳县', '610400');
INSERT INTO `pro_city_area` VALUES ('610424', '乾　县', '610400');
INSERT INTO `pro_city_area` VALUES ('610425', '礼泉县', '610400');
INSERT INTO `pro_city_area` VALUES ('610426', '永寿县', '610400');
INSERT INTO `pro_city_area` VALUES ('610427', '彬　县', '610400');
INSERT INTO `pro_city_area` VALUES ('610428', '长武县', '610400');
INSERT INTO `pro_city_area` VALUES ('610429', '旬邑县', '610400');
INSERT INTO `pro_city_area` VALUES ('610430', '淳化县', '610400');
INSERT INTO `pro_city_area` VALUES ('610431', '武功县', '610400');
INSERT INTO `pro_city_area` VALUES ('610481', '兴平市', '610400');
INSERT INTO `pro_city_area` VALUES ('610500', '渭南市', '610000');
INSERT INTO `pro_city_area` VALUES ('610501', '市辖区', '610500');
INSERT INTO `pro_city_area` VALUES ('610502', '临渭区', '610500');
INSERT INTO `pro_city_area` VALUES ('610521', '华　县', '610500');
INSERT INTO `pro_city_area` VALUES ('610522', '潼关县', '610500');
INSERT INTO `pro_city_area` VALUES ('610523', '大荔县', '610500');
INSERT INTO `pro_city_area` VALUES ('610524', '合阳县', '610500');
INSERT INTO `pro_city_area` VALUES ('610525', '澄城县', '610500');
INSERT INTO `pro_city_area` VALUES ('610526', '蒲城县', '610500');
INSERT INTO `pro_city_area` VALUES ('610527', '白水县', '610500');
INSERT INTO `pro_city_area` VALUES ('610528', '富平县', '610500');
INSERT INTO `pro_city_area` VALUES ('610581', '韩城市', '610500');
INSERT INTO `pro_city_area` VALUES ('610582', '华阴市', '610500');
INSERT INTO `pro_city_area` VALUES ('610600', '延安市', '610000');
INSERT INTO `pro_city_area` VALUES ('610601', '市辖区', '610600');
INSERT INTO `pro_city_area` VALUES ('610602', '宝塔区', '610600');
INSERT INTO `pro_city_area` VALUES ('610621', '延长县', '610600');
INSERT INTO `pro_city_area` VALUES ('610622', '延川县', '610600');
INSERT INTO `pro_city_area` VALUES ('610623', '子长县', '610600');
INSERT INTO `pro_city_area` VALUES ('610624', '安塞县', '610600');
INSERT INTO `pro_city_area` VALUES ('610625', '志丹县', '610600');
INSERT INTO `pro_city_area` VALUES ('610626', '吴旗县', '610600');
INSERT INTO `pro_city_area` VALUES ('610627', '甘泉县', '610600');
INSERT INTO `pro_city_area` VALUES ('610628', '富　县', '610600');
INSERT INTO `pro_city_area` VALUES ('610629', '洛川县', '610600');
INSERT INTO `pro_city_area` VALUES ('610630', '宜川县', '610600');
INSERT INTO `pro_city_area` VALUES ('610631', '黄龙县', '610600');
INSERT INTO `pro_city_area` VALUES ('610632', '黄陵县', '610600');
INSERT INTO `pro_city_area` VALUES ('610700', '汉中市', '610000');
INSERT INTO `pro_city_area` VALUES ('610701', '市辖区', '610700');
INSERT INTO `pro_city_area` VALUES ('610702', '汉台区', '610700');
INSERT INTO `pro_city_area` VALUES ('610721', '南郑县', '610700');
INSERT INTO `pro_city_area` VALUES ('610722', '城固县', '610700');
INSERT INTO `pro_city_area` VALUES ('610723', '洋　县', '610700');
INSERT INTO `pro_city_area` VALUES ('610724', '西乡县', '610700');
INSERT INTO `pro_city_area` VALUES ('610725', '勉　县', '610700');
INSERT INTO `pro_city_area` VALUES ('610726', '宁强县', '610700');
INSERT INTO `pro_city_area` VALUES ('610727', '略阳县', '610700');
INSERT INTO `pro_city_area` VALUES ('610728', '镇巴县', '610700');
INSERT INTO `pro_city_area` VALUES ('610729', '留坝县', '610700');
INSERT INTO `pro_city_area` VALUES ('610730', '佛坪县', '610700');
INSERT INTO `pro_city_area` VALUES ('610800', '榆林市', '610000');
INSERT INTO `pro_city_area` VALUES ('610801', '市辖区', '610800');
INSERT INTO `pro_city_area` VALUES ('610802', '榆阳区', '610800');
INSERT INTO `pro_city_area` VALUES ('610821', '神木县', '610800');
INSERT INTO `pro_city_area` VALUES ('610822', '府谷县', '610800');
INSERT INTO `pro_city_area` VALUES ('610823', '横山县', '610800');
INSERT INTO `pro_city_area` VALUES ('610824', '靖边县', '610800');
INSERT INTO `pro_city_area` VALUES ('610825', '定边县', '610800');
INSERT INTO `pro_city_area` VALUES ('610826', '绥德县', '610800');
INSERT INTO `pro_city_area` VALUES ('610827', '米脂县', '610800');
INSERT INTO `pro_city_area` VALUES ('610828', '佳　县', '610800');
INSERT INTO `pro_city_area` VALUES ('610829', '吴堡县', '610800');
INSERT INTO `pro_city_area` VALUES ('610830', '清涧县', '610800');
INSERT INTO `pro_city_area` VALUES ('610831', '子洲县', '610800');
INSERT INTO `pro_city_area` VALUES ('610900', '安康市', '610000');
INSERT INTO `pro_city_area` VALUES ('610901', '市辖区', '610900');
INSERT INTO `pro_city_area` VALUES ('610902', '汉滨区', '610900');
INSERT INTO `pro_city_area` VALUES ('610921', '汉阴县', '610900');
INSERT INTO `pro_city_area` VALUES ('610922', '石泉县', '610900');
INSERT INTO `pro_city_area` VALUES ('610923', '宁陕县', '610900');
INSERT INTO `pro_city_area` VALUES ('610924', '紫阳县', '610900');
INSERT INTO `pro_city_area` VALUES ('610925', '岚皋县', '610900');
INSERT INTO `pro_city_area` VALUES ('610926', '平利县', '610900');
INSERT INTO `pro_city_area` VALUES ('610927', '镇坪县', '610900');
INSERT INTO `pro_city_area` VALUES ('610928', '旬阳县', '610900');
INSERT INTO `pro_city_area` VALUES ('610929', '白河县', '610900');
INSERT INTO `pro_city_area` VALUES ('611000', '商洛市', '610000');
INSERT INTO `pro_city_area` VALUES ('611001', '市辖区', '611000');
INSERT INTO `pro_city_area` VALUES ('611002', '商州区', '611000');
INSERT INTO `pro_city_area` VALUES ('611021', '洛南县', '611000');
INSERT INTO `pro_city_area` VALUES ('611022', '丹凤县', '611000');
INSERT INTO `pro_city_area` VALUES ('611023', '商南县', '611000');
INSERT INTO `pro_city_area` VALUES ('611024', '山阳县', '611000');
INSERT INTO `pro_city_area` VALUES ('611025', '镇安县', '611000');
INSERT INTO `pro_city_area` VALUES ('611026', '柞水县', '611000');
INSERT INTO `pro_city_area` VALUES ('620000', '甘肃省', '0');
INSERT INTO `pro_city_area` VALUES ('620100', '兰州市', '620000');
INSERT INTO `pro_city_area` VALUES ('620101', '市辖区', '620100');
INSERT INTO `pro_city_area` VALUES ('620102', '城关区', '620100');
INSERT INTO `pro_city_area` VALUES ('620103', '七里河区', '620100');
INSERT INTO `pro_city_area` VALUES ('620104', '西固区', '620100');
INSERT INTO `pro_city_area` VALUES ('620105', '安宁区', '620100');
INSERT INTO `pro_city_area` VALUES ('620111', '红古区', '620100');
INSERT INTO `pro_city_area` VALUES ('620121', '永登县', '620100');
INSERT INTO `pro_city_area` VALUES ('620122', '皋兰县', '620100');
INSERT INTO `pro_city_area` VALUES ('620123', '榆中县', '620100');
INSERT INTO `pro_city_area` VALUES ('620200', '嘉峪关市', '620000');
INSERT INTO `pro_city_area` VALUES ('620201', '市辖区', '620200');
INSERT INTO `pro_city_area` VALUES ('620300', '金昌市', '620000');
INSERT INTO `pro_city_area` VALUES ('620301', '市辖区', '620300');
INSERT INTO `pro_city_area` VALUES ('620302', '金川区', '620300');
INSERT INTO `pro_city_area` VALUES ('620321', '永昌县', '620300');
INSERT INTO `pro_city_area` VALUES ('620400', '白银市', '620000');
INSERT INTO `pro_city_area` VALUES ('620401', '市辖区', '620400');
INSERT INTO `pro_city_area` VALUES ('620402', '白银区', '620400');
INSERT INTO `pro_city_area` VALUES ('620403', '平川区', '620400');
INSERT INTO `pro_city_area` VALUES ('620421', '靖远县', '620400');
INSERT INTO `pro_city_area` VALUES ('620422', '会宁县', '620400');
INSERT INTO `pro_city_area` VALUES ('620423', '景泰县', '620400');
INSERT INTO `pro_city_area` VALUES ('620500', '天水市', '620000');
INSERT INTO `pro_city_area` VALUES ('620501', '市辖区', '620500');
INSERT INTO `pro_city_area` VALUES ('620502', '秦城区', '620500');
INSERT INTO `pro_city_area` VALUES ('620503', '北道区', '620500');
INSERT INTO `pro_city_area` VALUES ('620521', '清水县', '620500');
INSERT INTO `pro_city_area` VALUES ('620522', '秦安县', '620500');
INSERT INTO `pro_city_area` VALUES ('620523', '甘谷县', '620500');
INSERT INTO `pro_city_area` VALUES ('620524', '武山县', '620500');
INSERT INTO `pro_city_area` VALUES ('620525', '张家川回族自治县', '620500');
INSERT INTO `pro_city_area` VALUES ('620600', '武威市', '620000');
INSERT INTO `pro_city_area` VALUES ('620601', '市辖区', '620600');
INSERT INTO `pro_city_area` VALUES ('620602', '凉州区', '620600');
INSERT INTO `pro_city_area` VALUES ('620621', '民勤县', '620600');
INSERT INTO `pro_city_area` VALUES ('620622', '古浪县', '620600');
INSERT INTO `pro_city_area` VALUES ('620623', '天祝藏族自治县', '620600');
INSERT INTO `pro_city_area` VALUES ('620700', '张掖市', '620000');
INSERT INTO `pro_city_area` VALUES ('620701', '市辖区', '620700');
INSERT INTO `pro_city_area` VALUES ('620702', '甘州区', '620700');
INSERT INTO `pro_city_area` VALUES ('620721', '肃南裕固族自治县', '620700');
INSERT INTO `pro_city_area` VALUES ('620722', '民乐县', '620700');
INSERT INTO `pro_city_area` VALUES ('620723', '临泽县', '620700');
INSERT INTO `pro_city_area` VALUES ('620724', '高台县', '620700');
INSERT INTO `pro_city_area` VALUES ('620725', '山丹县', '620700');
INSERT INTO `pro_city_area` VALUES ('620800', '平凉市', '620000');
INSERT INTO `pro_city_area` VALUES ('620801', '市辖区', '620800');
INSERT INTO `pro_city_area` VALUES ('620802', '崆峒区', '620800');
INSERT INTO `pro_city_area` VALUES ('620821', '泾川县', '620800');
INSERT INTO `pro_city_area` VALUES ('620822', '灵台县', '620800');
INSERT INTO `pro_city_area` VALUES ('620823', '崇信县', '620800');
INSERT INTO `pro_city_area` VALUES ('620824', '华亭县', '620800');
INSERT INTO `pro_city_area` VALUES ('620825', '庄浪县', '620800');
INSERT INTO `pro_city_area` VALUES ('620826', '静宁县', '620800');
INSERT INTO `pro_city_area` VALUES ('620900', '酒泉市', '620000');
INSERT INTO `pro_city_area` VALUES ('620901', '市辖区', '620900');
INSERT INTO `pro_city_area` VALUES ('620902', '肃州区', '620900');
INSERT INTO `pro_city_area` VALUES ('620921', '金塔县', '620900');
INSERT INTO `pro_city_area` VALUES ('620922', '安西县', '620900');
INSERT INTO `pro_city_area` VALUES ('620923', '肃北蒙古族自治县', '620900');
INSERT INTO `pro_city_area` VALUES ('620924', '阿克塞哈萨克族自治县', '620900');
INSERT INTO `pro_city_area` VALUES ('620981', '玉门市', '620900');
INSERT INTO `pro_city_area` VALUES ('620982', '敦煌市', '620900');
INSERT INTO `pro_city_area` VALUES ('621000', '庆阳市', '620000');
INSERT INTO `pro_city_area` VALUES ('621001', '市辖区', '621000');
INSERT INTO `pro_city_area` VALUES ('621002', '西峰区', '621000');
INSERT INTO `pro_city_area` VALUES ('621021', '庆城县', '621000');
INSERT INTO `pro_city_area` VALUES ('621022', '环　县', '621000');
INSERT INTO `pro_city_area` VALUES ('621023', '华池县', '621000');
INSERT INTO `pro_city_area` VALUES ('621024', '合水县', '621000');
INSERT INTO `pro_city_area` VALUES ('621025', '正宁县', '621000');
INSERT INTO `pro_city_area` VALUES ('621026', '宁　县', '621000');
INSERT INTO `pro_city_area` VALUES ('621027', '镇原县', '621000');
INSERT INTO `pro_city_area` VALUES ('621100', '定西市', '620000');
INSERT INTO `pro_city_area` VALUES ('621101', '市辖区', '621100');
INSERT INTO `pro_city_area` VALUES ('621102', '安定区', '621100');
INSERT INTO `pro_city_area` VALUES ('621121', '通渭县', '621100');
INSERT INTO `pro_city_area` VALUES ('621122', '陇西县', '621100');
INSERT INTO `pro_city_area` VALUES ('621123', '渭源县', '621100');
INSERT INTO `pro_city_area` VALUES ('621124', '临洮县', '621100');
INSERT INTO `pro_city_area` VALUES ('621125', '漳　县', '621100');
INSERT INTO `pro_city_area` VALUES ('621126', '岷　县', '621100');
INSERT INTO `pro_city_area` VALUES ('621200', '陇南市', '620000');
INSERT INTO `pro_city_area` VALUES ('621201', '市辖区', '621200');
INSERT INTO `pro_city_area` VALUES ('621202', '武都区', '621200');
INSERT INTO `pro_city_area` VALUES ('621221', '成　县', '621200');
INSERT INTO `pro_city_area` VALUES ('621222', '文　县', '621200');
INSERT INTO `pro_city_area` VALUES ('621223', '宕昌县', '621200');
INSERT INTO `pro_city_area` VALUES ('621224', '康　县', '621200');
INSERT INTO `pro_city_area` VALUES ('621225', '西和县', '621200');
INSERT INTO `pro_city_area` VALUES ('621226', '礼　县', '621200');
INSERT INTO `pro_city_area` VALUES ('621227', '徽　县', '621200');
INSERT INTO `pro_city_area` VALUES ('621228', '两当县', '621200');
INSERT INTO `pro_city_area` VALUES ('622900', '临夏回族自治州', '620000');
INSERT INTO `pro_city_area` VALUES ('622901', '临夏市', '622900');
INSERT INTO `pro_city_area` VALUES ('622921', '临夏县', '622900');
INSERT INTO `pro_city_area` VALUES ('622922', '康乐县', '622900');
INSERT INTO `pro_city_area` VALUES ('622923', '永靖县', '622900');
INSERT INTO `pro_city_area` VALUES ('622924', '广河县', '622900');
INSERT INTO `pro_city_area` VALUES ('622925', '和政县', '622900');
INSERT INTO `pro_city_area` VALUES ('622926', '东乡族自治县', '622900');
INSERT INTO `pro_city_area` VALUES ('622927', '积石山保安族东乡族撒拉族自治县', '622900');
INSERT INTO `pro_city_area` VALUES ('623000', '甘南藏族自治州', '620000');
INSERT INTO `pro_city_area` VALUES ('623001', '合作市', '623000');
INSERT INTO `pro_city_area` VALUES ('623021', '临潭县', '623000');
INSERT INTO `pro_city_area` VALUES ('623022', '卓尼县', '623000');
INSERT INTO `pro_city_area` VALUES ('623023', '舟曲县', '623000');
INSERT INTO `pro_city_area` VALUES ('623024', '迭部县', '623000');
INSERT INTO `pro_city_area` VALUES ('623025', '玛曲县', '623000');
INSERT INTO `pro_city_area` VALUES ('623026', '碌曲县', '623000');
INSERT INTO `pro_city_area` VALUES ('623027', '夏河县', '623000');
INSERT INTO `pro_city_area` VALUES ('630000', '青海省', '0');
INSERT INTO `pro_city_area` VALUES ('630100', '西宁市', '630000');
INSERT INTO `pro_city_area` VALUES ('630101', '市辖区', '630100');
INSERT INTO `pro_city_area` VALUES ('630102', '城东区', '630100');
INSERT INTO `pro_city_area` VALUES ('630103', '城中区', '630100');
INSERT INTO `pro_city_area` VALUES ('630104', '城西区', '630100');
INSERT INTO `pro_city_area` VALUES ('630105', '城北区', '630100');
INSERT INTO `pro_city_area` VALUES ('630121', '大通回族土族自治县', '630100');
INSERT INTO `pro_city_area` VALUES ('630122', '湟中县', '630100');
INSERT INTO `pro_city_area` VALUES ('630123', '湟源县', '630100');
INSERT INTO `pro_city_area` VALUES ('632100', '海东地区', '630000');
INSERT INTO `pro_city_area` VALUES ('632121', '平安县', '632100');
INSERT INTO `pro_city_area` VALUES ('632122', '民和回族土族自治县', '632100');
INSERT INTO `pro_city_area` VALUES ('632123', '乐都县', '632100');
INSERT INTO `pro_city_area` VALUES ('632126', '互助土族自治县', '632100');
INSERT INTO `pro_city_area` VALUES ('632127', '化隆回族自治县', '632100');
INSERT INTO `pro_city_area` VALUES ('632128', '循化撒拉族自治县', '632100');
INSERT INTO `pro_city_area` VALUES ('632200', '海北藏族自治州', '630000');
INSERT INTO `pro_city_area` VALUES ('632221', '门源回族自治县', '632200');
INSERT INTO `pro_city_area` VALUES ('632222', '祁连县', '632200');
INSERT INTO `pro_city_area` VALUES ('632223', '海晏县', '632200');
INSERT INTO `pro_city_area` VALUES ('632224', '刚察县', '632200');
INSERT INTO `pro_city_area` VALUES ('632300', '黄南藏族自治州', '630000');
INSERT INTO `pro_city_area` VALUES ('632321', '同仁县', '632300');
INSERT INTO `pro_city_area` VALUES ('632322', '尖扎县', '632300');
INSERT INTO `pro_city_area` VALUES ('632323', '泽库县', '632300');
INSERT INTO `pro_city_area` VALUES ('632324', '河南蒙古族自治县', '632300');
INSERT INTO `pro_city_area` VALUES ('632500', '海南藏族自治州', '630000');
INSERT INTO `pro_city_area` VALUES ('632521', '共和县', '632500');
INSERT INTO `pro_city_area` VALUES ('632522', '同德县', '632500');
INSERT INTO `pro_city_area` VALUES ('632523', '贵德县', '632500');
INSERT INTO `pro_city_area` VALUES ('632524', '兴海县', '632500');
INSERT INTO `pro_city_area` VALUES ('632525', '贵南县', '632500');
INSERT INTO `pro_city_area` VALUES ('632600', '果洛藏族自治州', '630000');
INSERT INTO `pro_city_area` VALUES ('632621', '玛沁县', '632600');
INSERT INTO `pro_city_area` VALUES ('632622', '班玛县', '632600');
INSERT INTO `pro_city_area` VALUES ('632623', '甘德县', '632600');
INSERT INTO `pro_city_area` VALUES ('632624', '达日县', '632600');
INSERT INTO `pro_city_area` VALUES ('632625', '久治县', '632600');
INSERT INTO `pro_city_area` VALUES ('632626', '玛多县', '632600');
INSERT INTO `pro_city_area` VALUES ('632700', '玉树藏族自治州', '630000');
INSERT INTO `pro_city_area` VALUES ('632721', '玉树县', '632700');
INSERT INTO `pro_city_area` VALUES ('632722', '杂多县', '632700');
INSERT INTO `pro_city_area` VALUES ('632723', '称多县', '632700');
INSERT INTO `pro_city_area` VALUES ('632724', '治多县', '632700');
INSERT INTO `pro_city_area` VALUES ('632725', '囊谦县', '632700');
INSERT INTO `pro_city_area` VALUES ('632726', '曲麻莱县', '632700');
INSERT INTO `pro_city_area` VALUES ('632800', '海西蒙古族藏族自治州', '630000');
INSERT INTO `pro_city_area` VALUES ('632801', '格尔木市', '632800');
INSERT INTO `pro_city_area` VALUES ('632802', '德令哈市', '632800');
INSERT INTO `pro_city_area` VALUES ('632821', '乌兰县', '632800');
INSERT INTO `pro_city_area` VALUES ('632822', '都兰县', '632800');
INSERT INTO `pro_city_area` VALUES ('632823', '天峻县', '632800');
INSERT INTO `pro_city_area` VALUES ('640000', '宁  夏', '0');
INSERT INTO `pro_city_area` VALUES ('640100', '银川市', '640000');
INSERT INTO `pro_city_area` VALUES ('640101', '市辖区', '640100');
INSERT INTO `pro_city_area` VALUES ('640104', '兴庆区', '640100');
INSERT INTO `pro_city_area` VALUES ('640105', '西夏区', '640100');
INSERT INTO `pro_city_area` VALUES ('640106', '金凤区', '640100');
INSERT INTO `pro_city_area` VALUES ('640121', '永宁县', '640100');
INSERT INTO `pro_city_area` VALUES ('640122', '贺兰县', '640100');
INSERT INTO `pro_city_area` VALUES ('640181', '灵武市', '640100');
INSERT INTO `pro_city_area` VALUES ('640200', '石嘴山市', '640000');
INSERT INTO `pro_city_area` VALUES ('640201', '市辖区', '640200');
INSERT INTO `pro_city_area` VALUES ('640202', '大武口区', '640200');
INSERT INTO `pro_city_area` VALUES ('640205', '惠农区', '640200');
INSERT INTO `pro_city_area` VALUES ('640221', '平罗县', '640200');
INSERT INTO `pro_city_area` VALUES ('640300', '吴忠市', '640000');
INSERT INTO `pro_city_area` VALUES ('640301', '市辖区', '640300');
INSERT INTO `pro_city_area` VALUES ('640302', '利通区', '640300');
INSERT INTO `pro_city_area` VALUES ('640323', '盐池县', '640300');
INSERT INTO `pro_city_area` VALUES ('640324', '同心县', '640300');
INSERT INTO `pro_city_area` VALUES ('640381', '青铜峡市', '640300');
INSERT INTO `pro_city_area` VALUES ('640400', '固原市', '640000');
INSERT INTO `pro_city_area` VALUES ('640401', '市辖区', '640400');
INSERT INTO `pro_city_area` VALUES ('640402', '原州区', '640400');
INSERT INTO `pro_city_area` VALUES ('640422', '西吉县', '640400');
INSERT INTO `pro_city_area` VALUES ('640423', '隆德县', '640400');
INSERT INTO `pro_city_area` VALUES ('640424', '泾源县', '640400');
INSERT INTO `pro_city_area` VALUES ('640425', '彭阳县', '640400');
INSERT INTO `pro_city_area` VALUES ('640500', '中卫市', '640000');
INSERT INTO `pro_city_area` VALUES ('640501', '市辖区', '640500');
INSERT INTO `pro_city_area` VALUES ('640502', '沙坡头区', '640500');
INSERT INTO `pro_city_area` VALUES ('640521', '中宁县', '640500');
INSERT INTO `pro_city_area` VALUES ('640522', '海原县', '640500');
INSERT INTO `pro_city_area` VALUES ('650000', '新  疆', '0');
INSERT INTO `pro_city_area` VALUES ('650100', '乌鲁木齐市', '650000');
INSERT INTO `pro_city_area` VALUES ('650101', '市辖区', '650100');
INSERT INTO `pro_city_area` VALUES ('650102', '天山区', '650100');
INSERT INTO `pro_city_area` VALUES ('650103', '沙依巴克区', '650100');
INSERT INTO `pro_city_area` VALUES ('650104', '新市区', '650100');
INSERT INTO `pro_city_area` VALUES ('650105', '水磨沟区', '650100');
INSERT INTO `pro_city_area` VALUES ('650106', '头屯河区', '650100');
INSERT INTO `pro_city_area` VALUES ('650107', '达坂城区', '650100');
INSERT INTO `pro_city_area` VALUES ('650108', '东山区', '650100');
INSERT INTO `pro_city_area` VALUES ('650121', '乌鲁木齐县', '650100');
INSERT INTO `pro_city_area` VALUES ('650200', '克拉玛依市', '650000');
INSERT INTO `pro_city_area` VALUES ('650201', '市辖区', '650200');
INSERT INTO `pro_city_area` VALUES ('650202', '独山子区', '650200');
INSERT INTO `pro_city_area` VALUES ('650203', '克拉玛依区', '650200');
INSERT INTO `pro_city_area` VALUES ('650204', '白碱滩区', '650200');
INSERT INTO `pro_city_area` VALUES ('650205', '乌尔禾区', '650200');
INSERT INTO `pro_city_area` VALUES ('652100', '吐鲁番地区', '650000');
INSERT INTO `pro_city_area` VALUES ('652101', '吐鲁番市', '652100');
INSERT INTO `pro_city_area` VALUES ('652122', '鄯善县', '652100');
INSERT INTO `pro_city_area` VALUES ('652123', '托克逊县', '652100');
INSERT INTO `pro_city_area` VALUES ('652200', '哈密地区', '650000');
INSERT INTO `pro_city_area` VALUES ('652201', '哈密市', '652200');
INSERT INTO `pro_city_area` VALUES ('652222', '巴里坤哈萨克自治县', '652200');
INSERT INTO `pro_city_area` VALUES ('652223', '伊吾县', '652200');
INSERT INTO `pro_city_area` VALUES ('652300', '昌吉回族自治州', '650000');
INSERT INTO `pro_city_area` VALUES ('652301', '昌吉市', '652300');
INSERT INTO `pro_city_area` VALUES ('652302', '阜康市', '652300');
INSERT INTO `pro_city_area` VALUES ('652303', '米泉市', '652300');
INSERT INTO `pro_city_area` VALUES ('652323', '呼图壁县', '652300');
INSERT INTO `pro_city_area` VALUES ('652324', '玛纳斯县', '652300');
INSERT INTO `pro_city_area` VALUES ('652325', '奇台县', '652300');
INSERT INTO `pro_city_area` VALUES ('652327', '吉木萨尔县', '652300');
INSERT INTO `pro_city_area` VALUES ('652328', '木垒哈萨克自治县', '652300');
INSERT INTO `pro_city_area` VALUES ('652700', '博尔塔拉蒙古自治州', '650000');
INSERT INTO `pro_city_area` VALUES ('652701', '博乐市', '652700');
INSERT INTO `pro_city_area` VALUES ('652722', '精河县', '652700');
INSERT INTO `pro_city_area` VALUES ('652723', '温泉县', '652700');
INSERT INTO `pro_city_area` VALUES ('652800', '巴音郭楞蒙古自治州', '650000');
INSERT INTO `pro_city_area` VALUES ('652801', '库尔勒市', '652800');
INSERT INTO `pro_city_area` VALUES ('652822', '轮台县', '652800');
INSERT INTO `pro_city_area` VALUES ('652823', '尉犁县', '652800');
INSERT INTO `pro_city_area` VALUES ('652824', '若羌县', '652800');
INSERT INTO `pro_city_area` VALUES ('652825', '且末县', '652800');
INSERT INTO `pro_city_area` VALUES ('652826', '焉耆回族自治县', '652800');
INSERT INTO `pro_city_area` VALUES ('652827', '和静县', '652800');
INSERT INTO `pro_city_area` VALUES ('652828', '和硕县', '652800');
INSERT INTO `pro_city_area` VALUES ('652829', '博湖县', '652800');
INSERT INTO `pro_city_area` VALUES ('652900', '阿克苏地区', '650000');
INSERT INTO `pro_city_area` VALUES ('652901', '阿克苏市', '652900');
INSERT INTO `pro_city_area` VALUES ('652922', '温宿县', '652900');
INSERT INTO `pro_city_area` VALUES ('652923', '库车县', '652900');
INSERT INTO `pro_city_area` VALUES ('652924', '沙雅县', '652900');
INSERT INTO `pro_city_area` VALUES ('652925', '新和县', '652900');
INSERT INTO `pro_city_area` VALUES ('652926', '拜城县', '652900');
INSERT INTO `pro_city_area` VALUES ('652927', '乌什县', '652900');
INSERT INTO `pro_city_area` VALUES ('652928', '阿瓦提县', '652900');
INSERT INTO `pro_city_area` VALUES ('652929', '柯坪县', '652900');
INSERT INTO `pro_city_area` VALUES ('653000', '克孜勒苏柯尔克孜自治州', '650000');
INSERT INTO `pro_city_area` VALUES ('653001', '阿图什市', '653000');
INSERT INTO `pro_city_area` VALUES ('653022', '阿克陶县', '653000');
INSERT INTO `pro_city_area` VALUES ('653023', '阿合奇县', '653000');
INSERT INTO `pro_city_area` VALUES ('653024', '乌恰县', '653000');
INSERT INTO `pro_city_area` VALUES ('653100', '喀什地区', '650000');
INSERT INTO `pro_city_area` VALUES ('653101', '喀什市', '653100');
INSERT INTO `pro_city_area` VALUES ('653121', '疏附县', '653100');
INSERT INTO `pro_city_area` VALUES ('653122', '疏勒县', '653100');
INSERT INTO `pro_city_area` VALUES ('653123', '英吉沙县', '653100');
INSERT INTO `pro_city_area` VALUES ('653124', '泽普县', '653100');
INSERT INTO `pro_city_area` VALUES ('653125', '莎车县', '653100');
INSERT INTO `pro_city_area` VALUES ('653126', '叶城县', '653100');
INSERT INTO `pro_city_area` VALUES ('653127', '麦盖提县', '653100');
INSERT INTO `pro_city_area` VALUES ('653128', '岳普湖县', '653100');
INSERT INTO `pro_city_area` VALUES ('653129', '伽师县', '653100');
INSERT INTO `pro_city_area` VALUES ('653130', '巴楚县', '653100');
INSERT INTO `pro_city_area` VALUES ('653131', '塔什库尔干塔吉克自治县', '653100');
INSERT INTO `pro_city_area` VALUES ('653200', '和田地区', '650000');
INSERT INTO `pro_city_area` VALUES ('653201', '和田市', '653200');
INSERT INTO `pro_city_area` VALUES ('653221', '和田县', '653200');
INSERT INTO `pro_city_area` VALUES ('653222', '墨玉县', '653200');
INSERT INTO `pro_city_area` VALUES ('653223', '皮山县', '653200');
INSERT INTO `pro_city_area` VALUES ('653224', '洛浦县', '653200');
INSERT INTO `pro_city_area` VALUES ('653225', '策勒县', '653200');
INSERT INTO `pro_city_area` VALUES ('653226', '于田县', '653200');
INSERT INTO `pro_city_area` VALUES ('653227', '民丰县', '653200');
INSERT INTO `pro_city_area` VALUES ('654000', '伊犁哈萨克自治州', '650000');
INSERT INTO `pro_city_area` VALUES ('654002', '伊宁市', '654000');
INSERT INTO `pro_city_area` VALUES ('654003', '奎屯市', '654000');
INSERT INTO `pro_city_area` VALUES ('654021', '伊宁县', '654000');
INSERT INTO `pro_city_area` VALUES ('654022', '察布查尔锡伯自治县', '654000');
INSERT INTO `pro_city_area` VALUES ('654023', '霍城县', '654000');
INSERT INTO `pro_city_area` VALUES ('654024', '巩留县', '654000');
INSERT INTO `pro_city_area` VALUES ('654025', '新源县', '654000');
INSERT INTO `pro_city_area` VALUES ('654026', '昭苏县', '654000');
INSERT INTO `pro_city_area` VALUES ('654027', '特克斯县', '654000');
INSERT INTO `pro_city_area` VALUES ('654028', '尼勒克县', '654000');
INSERT INTO `pro_city_area` VALUES ('654200', '塔城地区', '650000');
INSERT INTO `pro_city_area` VALUES ('654201', '塔城市', '654200');
INSERT INTO `pro_city_area` VALUES ('654202', '乌苏市', '654200');
INSERT INTO `pro_city_area` VALUES ('654221', '额敏县', '654200');
INSERT INTO `pro_city_area` VALUES ('654223', '沙湾县', '654200');
INSERT INTO `pro_city_area` VALUES ('654224', '托里县', '654200');
INSERT INTO `pro_city_area` VALUES ('654225', '裕民县', '654200');
INSERT INTO `pro_city_area` VALUES ('654226', '和布克赛尔蒙古自治县', '654200');
INSERT INTO `pro_city_area` VALUES ('654300', '阿勒泰地区', '650000');
INSERT INTO `pro_city_area` VALUES ('654301', '阿勒泰市', '654300');
INSERT INTO `pro_city_area` VALUES ('654321', '布尔津县', '654300');
INSERT INTO `pro_city_area` VALUES ('654322', '富蕴县', '654300');
INSERT INTO `pro_city_area` VALUES ('654323', '福海县', '654300');
INSERT INTO `pro_city_area` VALUES ('654324', '哈巴河县', '654300');
INSERT INTO `pro_city_area` VALUES ('654325', '青河县', '654300');
INSERT INTO `pro_city_area` VALUES ('654326', '吉木乃县', '654300');
INSERT INTO `pro_city_area` VALUES ('659000', '省直辖行政单位', '650000');
INSERT INTO `pro_city_area` VALUES ('659001', '石河子市', '659000');
INSERT INTO `pro_city_area` VALUES ('659002', '阿拉尔市', '659000');
INSERT INTO `pro_city_area` VALUES ('659003', '图木舒克市', '659000');
INSERT INTO `pro_city_area` VALUES ('659004', '五家渠市', '659000');
INSERT INTO `pro_city_area` VALUES ('710000', '台湾省', '0');
INSERT INTO `pro_city_area` VALUES ('810000', '香  港', '0');
INSERT INTO `pro_city_area` VALUES ('820000', '澳  门', '0');
INSERT INTO `product` VALUES ('1', '东北大庆油田一期基金78', '140714DQYT001X', '2', '11010213', '450000.0000', '10.00', '12000.0000', '6', '11010212', '2014-07-15 00:00:00', '2014-09-30 00:00:00', '5.0000', 'A1*(a1-a3)-A*a2', '', '0', '东北大庆油田一期基金67890789', '1', '2014-07-14 15:41:51', '1', '2014-07-22 20:57:54');
INSERT INTO `product` VALUES ('2', '东北大庆油田一期二期', '140714DQYT002', '2', '11010213', '500000.0000', '10.00', '10000.0000', '1', '11010210', '2014-07-15 00:00:00', '2014-10-31 00:00:00', '10.0000', 'A+A*(b-A*b1-b2-b3)', '', '0', '东北大庆油田一期二期', '1', '2014-07-14 15:51:13', '1', '2014-07-22 20:57:56');
INSERT INTO `project` VALUES ('1', '5', '140714DQYT001', '东北大庆油田一期', '5000000', '2014-07-14 00:00:00', '10', '20', '2014-07-31 00:00:00', '2014-08-31 00:00:00', '10', '5', '4020101', '东北大庆油田一期测试数据890', '0', '1', '2014-07-21 19:56:42', '1', '2014-07-21 19:56:42');
INSERT INTO `project` VALUES ('2', '5', '140716CZYJGGD001', '常州亿晶光电5千万上市前私募股权投资', '50000000', '2014-07-16 00:00:00', '1', '20', '2014-11-12 00:00:00', '2015-02-28 00:00:00', '10', '15', '4020104', '', '1', '1', '2014-07-16 14:45:37', '1', '2014-07-21 19:57:01');
INSERT INTO `qrtz_locks` VALUES ('CALENDAR_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('JOB_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('MISFIRE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('TRIGGER_ACCESS');
INSERT INTO `report` VALUES ('6', '1', '不同性别用户每月注册量', '9', 'createdTime', '900010102', 'id', '9000201', 'sex', '900019901', '9000303', '测试时间字典的三维报表', '1', '2014-07-14 11:05:57', '1', '2014-07-17 16:11:38', '0', '0');
INSERT INTO `report` VALUES ('7', '2', '不同性别用户注册量', '9', 'sex', '900019901', 'id', '9000205', null, null, '9000302', '测试非日期类型统计', '1', '2014-07-14 14:15:44', '1', '2014-07-15 17:21:44', '0', '0');
INSERT INTO `report` VALUES ('8', '3', '统计名称', '10', 'name', '900019901', 'id', '9000201', null, null, '9000302', null, '1', '2014-07-15 17:10:53', '1', '2014-07-15 17:11:03', '0', '0');
INSERT INTO `sm_audit_log` VALUES ('1', 'report', null, '不同性别用户每月注册量', '1', null, '1', '2014-07-14 00:00:00');
INSERT INTO `sm_audit_log` VALUES ('2', 'lead', '3', 'admin', '1', null, '1', '2014-07-14 00:00:00');
INSERT INTO `sm_audit_log` VALUES ('3', 'user', '3', 'manager', '1', null, '1', '2014-07-14 00:00:00');
INSERT INTO `sm_audit_log` VALUES ('4', 'customer', '10', 'admin', '1', null, '1', '2014-07-14 14:12:15');
INSERT INTO `sm_audit_log` VALUES ('5', 'lead', '4', 'admin', '1', null, '1', '2014-07-14 14:12:18');
INSERT INTO `sm_audit_log` VALUES ('6', 'organization', '34', '313', '1', '组织增加', '1', '2014-07-14 00:00:00');
INSERT INTO `sm_audit_log` VALUES ('8', 'lead', '5', 'admin', '1', null, '1', '2014-07-14 00:00:00');
INSERT INTO `sm_audit_log` VALUES ('11', 'supplier', null, 'admin', '1', null, '1', '2014-07-14 14:11:01');
INSERT INTO `sm_audit_log` VALUES ('12', 'report', null, '不同性别用户注册量', '1', null, '1', '2014-07-14 14:15:32');
INSERT INTO `sm_audit_log` VALUES ('13', 'supplier', null, 'admin', '1', null, '1', '2014-07-14 14:17:17');
INSERT INTO `sm_audit_log` VALUES ('14', 'supplier', null, 'asas', '1', null, '1', '2014-07-14 14:21:28');
INSERT INTO `sm_audit_log` VALUES ('15', 'supplier', '5', 'asas', '2', null, '1', '2014-07-14 14:24:37');
INSERT INTO `sm_audit_log` VALUES ('16', 'customer', '10', 'admin', '4', null, '1', '2014-07-14 14:30:11');
INSERT INTO `sm_audit_log` VALUES ('17', 'recyclebin', '1', 'admin', '13', '还原删除数据', '1', '2014-07-14 14:30:43');
INSERT INTO `sm_audit_log` VALUES ('18', 'user', '3', 'manager', '10', '禁用用户', '1', '2014-07-14 14:31:29');
INSERT INTO `sm_audit_log` VALUES ('19', 'user', '3', 'manager', '9', '启用用户', '1', '2014-07-14 14:31:32');
INSERT INTO `sm_audit_log` VALUES ('20', 'role', '4', '组织数据管理员', '1', '角色增加', '1', '2014-07-14 14:34:12');
INSERT INTO `sm_audit_log` VALUES ('21', 'role', '4', '组织数据管理员', '4', '角色删除', '1', '2014-07-14 14:35:16');
INSERT INTO `sm_audit_log` VALUES ('22', 'notice', '2', 'rwer', '1', null, '1', '2014-07-14 14:39:03');
INSERT INTO `sm_audit_log` VALUES ('23', 'notice', '2', 'rwer', '2', null, '1', '2014-07-14 14:39:13');
INSERT INTO `sm_audit_log` VALUES ('24', 'notice', '2', 'rwer', '4', null, '1', '2014-07-14 14:39:21');
INSERT INTO `sm_audit_log` VALUES ('25', 'recyclebin', '3', 'rwer', '13', '还原删除数据', '1', '2014-07-14 14:39:37');
INSERT INTO `sm_audit_log` VALUES ('26', 'userMessage', '2', '企鹅我去额', '1', null, '1', '2014-07-14 14:42:16');
INSERT INTO `sm_audit_log` VALUES ('27', 'userMessage', '1', '企鹅我去额', '4', null, '1', '2014-07-14 14:42:38');
INSERT INTO `sm_audit_log` VALUES ('28', 'recyclebin', '4', '企鹅我去额', '13', '还原删除数据', '1', '2014-07-14 14:42:47');
INSERT INTO `sm_audit_log` VALUES ('29', 'customer', '11', '432', '1', null, '1', '2014-07-14 14:49:04');
INSERT INTO `sm_audit_log` VALUES ('31', 'customer', '11', '432', '2', null, '1', '2014-07-14 14:51:59');
INSERT INTO `sm_audit_log` VALUES ('32', 'user', '3', 'manager', '2', null, '1', '2014-07-14 14:53:08');
INSERT INTO `sm_audit_log` VALUES ('33', 'user', '4', '12322', '1', null, '1', '2014-07-14 14:59:32');
INSERT INTO `sm_audit_log` VALUES ('34', 'user', '4', '12322', '2', null, '1', '2014-07-14 14:59:43');
INSERT INTO `sm_audit_log` VALUES ('35', 'user', '4', '12322', '4', null, '1', '2014-07-14 14:59:59');
INSERT INTO `sm_audit_log` VALUES ('36', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 15:00:23');
INSERT INTO `sm_audit_log` VALUES ('37', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 15:09:40');
INSERT INTO `sm_audit_log` VALUES ('38', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 15:14:16');
INSERT INTO `sm_audit_log` VALUES ('39', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 15:14:19');
INSERT INTO `sm_audit_log` VALUES ('40', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 15:14:22');
INSERT INTO `sm_audit_log` VALUES ('41', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 15:14:30');
INSERT INTO `sm_audit_log` VALUES ('42', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 15:14:32');
INSERT INTO `sm_audit_log` VALUES ('43', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 15:15:39');
INSERT INTO `sm_audit_log` VALUES ('44', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 15:15:41');
INSERT INTO `sm_audit_log` VALUES ('45', 'user', '3', 'manager', '8', '重置密码', '1', '2014-07-14 15:18:14');
INSERT INTO `sm_audit_log` VALUES ('46', 'user', '3', 'manager', '10', '禁用用户', '1', '2014-07-14 15:18:18');
INSERT INTO `sm_audit_log` VALUES ('47', 'project', '1', '东北大庆油田一期', '1', null, '1', '2014-07-14 15:19:13');
INSERT INTO `sm_audit_log` VALUES ('48', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 15:31:39');
INSERT INTO `sm_audit_log` VALUES ('49', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 15:31:47');
INSERT INTO `sm_audit_log` VALUES ('50', 'user', '3', 'manager', '7', '用户授权', '1', '2014-07-14 15:32:56');
INSERT INTO `sm_audit_log` VALUES ('51', 'user', '3', 'manager', '7', '用户授权', '1', '2014-07-14 15:33:01');
INSERT INTO `sm_audit_log` VALUES ('52', 'user', '3', 'manager', '9', '启用用户', '1', '2014-07-14 15:33:12');
INSERT INTO `sm_audit_log` VALUES ('53', 'user', '3', 'manager', '7', '用户授权', '1', '2014-07-14 15:33:26');
INSERT INTO `sm_audit_log` VALUES ('54', 'customer', '1', 'admin', '1', null, '3', '2014-07-14 15:34:06');
INSERT INTO `sm_audit_log` VALUES ('55', 'customer', '2', 'a额问问', '1', null, '3', '2014-07-14 15:37:29');
INSERT INTO `sm_audit_log` VALUES ('56', 'customer', '2', 'a额问问', '2', null, '3', '2014-07-14 15:38:04');
INSERT INTO `sm_audit_log` VALUES ('57', 'customer', '2', 'a额问问', '2', null, '1', '2014-07-14 15:40:21');
INSERT INTO `sm_audit_log` VALUES ('58', 'product', '1', '东北大庆油田一期基金', '1', null, '1', '2014-07-14 15:41:53');
INSERT INTO `sm_audit_log` VALUES ('59', 'product', '2', '东北大庆油田一期二期', '1', null, '1', '2014-07-14 15:51:15');
INSERT INTO `sm_audit_log` VALUES ('60', 'product', '2', '东北大庆油田一期二期', '2', null, '1', '2014-07-14 15:55:39');
INSERT INTO `sm_audit_log` VALUES ('61', 'product', '2', '东北大庆油田一期二期', '2', null, '1', '2014-07-14 15:56:22');
INSERT INTO `sm_audit_log` VALUES ('62', 'notice', '1', '222', '1', null, '1', '2014-07-14 15:58:16');
INSERT INTO `sm_audit_log` VALUES ('63', 'notice', '1', '222', '2', null, '1', '2014-07-14 15:58:26');
INSERT INTO `sm_audit_log` VALUES ('64', 'notice', '1', '222', '4', null, '1', '2014-07-14 15:58:34');
INSERT INTO `sm_audit_log` VALUES ('65', 'recyclebin', '6', '222', '13', '还原删除数据', '1', '2014-07-14 15:58:44');
INSERT INTO `sm_audit_log` VALUES ('66', 'user', '3', 'manager', '7', '用户授权', '1', '2014-07-14 15:59:42');
INSERT INTO `sm_audit_log` VALUES ('67', 'userMessage', '4', '往前冲', '1', null, '3', '2014-07-14 16:00:23');
INSERT INTO `sm_audit_log` VALUES ('68', 'user', '5', 'test', '1', null, '3', '2014-07-14 16:01:20');
INSERT INTO `sm_audit_log` VALUES ('69', 'customer', '3', 'ad撒', '1', null, '3', '2014-07-14 16:02:06');
INSERT INTO `sm_audit_log` VALUES ('70', 'user', '5', 'test', '7', '用户授权', '1', '2014-07-14 16:02:44');
INSERT INTO `sm_audit_log` VALUES ('71', 'customer', '3', 'ad撒', '2', null, '1', '2014-07-14 16:17:34');
INSERT INTO `sm_audit_log` VALUES ('72', 'lead', '1', '32', '1', null, '1', '2014-07-14 16:18:09');
INSERT INTO `sm_audit_log` VALUES ('73', 'customer', '7', 'admin', '1', null, '1', '2014-07-14 16:26:06');
INSERT INTO `sm_audit_log` VALUES ('74', 'order', '1', '140714DQYT001', '1', null, '1', '2014-07-14 16:27:02');
INSERT INTO `sm_audit_log` VALUES ('75', 'customer', '8', '323', '1', null, '1', '2014-07-14 16:28:32');
INSERT INTO `sm_audit_log` VALUES ('76', 'notice', '2', '让我', '1', null, '1', '2014-07-14 16:32:51');
INSERT INTO `sm_audit_log` VALUES ('77', 'product', '1', '东北大庆油田一期基金', '2', null, '1', '2014-07-14 16:49:51');
INSERT INTO `sm_audit_log` VALUES ('78', 'product', '1', '东北大庆油田一期基金', '2', null, '1', '2014-07-14 16:50:38');
INSERT INTO `sm_audit_log` VALUES ('79', 'product', '1', '东北大庆油田一期基金', '2', null, '1', '2014-07-14 16:51:36');
INSERT INTO `sm_audit_log` VALUES ('80', 'product', '2', '东北大庆油田一期二期', '2', null, '1', '2014-07-14 16:52:47');
INSERT INTO `sm_audit_log` VALUES ('81', 'lead', null, '导出列表选中的数据', '6', '共导出1条数据', '1', '2014-07-14 17:04:16');
INSERT INTO `sm_audit_log` VALUES ('82', 'lead', null, '导出列表选中的数据', '6', '共导出1条数据', '1', '2014-07-14 18:15:44');
INSERT INTO `sm_audit_log` VALUES ('83', 'customer', null, '导出列表选中的数据', '6', '共导出1条数据', '1', '2014-07-14 18:16:09');
INSERT INTO `sm_audit_log` VALUES ('84', 'supplier', null, '导出列表选中的数据', '6', '共导出1条数据', '1', '2014-07-14 18:16:16');
INSERT INTO `sm_audit_log` VALUES ('85', 'project', null, '导出列表选中的数据', '6', '共导出1条数据', '1', '2014-07-14 18:16:23');
INSERT INTO `sm_audit_log` VALUES ('88', 'order', '1', '140714DQYT001', '2', null, '1', '2014-07-14 18:20:26');
INSERT INTO `sm_audit_log` VALUES ('89', 'recyclebin', '5', '12322', '13', '还原删除数据', '1', '2014-07-14 18:23:11');
INSERT INTO `sm_audit_log` VALUES ('90', 'user', '4', '12322', '4', null, '1', '2014-07-14 18:24:21');
INSERT INTO `sm_audit_log` VALUES ('91', 'user', '4', '12322', '2', null, '1', '2014-07-14 18:24:37');
INSERT INTO `sm_audit_log` VALUES ('92', 'recyclebin', '7', '12322', '13', '还原删除数据', '1', '2014-07-14 18:25:18');
INSERT INTO `sm_audit_log` VALUES ('93', 'recyclebin', '2', '组织数据管理员', '12', '真实删除数据', '1', '2014-07-14 18:34:52');
INSERT INTO `sm_audit_log` VALUES ('94', 'user', '4', '12322', '4', null, '1', '2014-07-14 18:35:06');
INSERT INTO `sm_audit_log` VALUES ('95', 'product', null, '导出列表选中的数据', '6', '共导出1条数据', '1', '2014-07-14 19:11:16');
INSERT INTO `sm_audit_log` VALUES ('96', 'user', '3', 'manager', '7', '用户授权', '1', '2014-07-14 19:26:13');
INSERT INTO `sm_audit_log` VALUES ('97', 'order', '1', '140714DQYT001', '2', null, '1', '2014-07-14 19:36:44');
INSERT INTO `sm_audit_log` VALUES ('98', 'order', null, '导出列表选中的数据', '6', '共导出1条数据', '1', '2014-07-14 19:43:26');
INSERT INTO `sm_audit_log` VALUES ('99', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 20:12:44');
INSERT INTO `sm_audit_log` VALUES ('100', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-14 20:12:51');
INSERT INTO `sm_audit_log` VALUES ('101', 'user', '1', '管理员', '8', '重置密码', '1', '2014-07-14 20:16:18');
INSERT INTO `sm_audit_log` VALUES ('102', 'user', '3', 'manager', '8', '重置密码', '1', '2014-07-14 20:16:27');
INSERT INTO `sm_audit_log` VALUES ('103', 'user', '3', 'manager', '8', '重置密码', '1', '2014-07-14 20:16:33');
INSERT INTO `sm_audit_log` VALUES ('104', 'report', '7', '不同性别用户注册量', '2', null, '1', '2014-07-14 21:52:14');
INSERT INTO `sm_audit_log` VALUES ('105', 'order', '2', '123456', '1', null, '1', '2014-07-15 09:59:30');
INSERT INTO `sm_audit_log` VALUES ('106', 'contract', '5', '1335', '4', null, '1', '2014-07-15 13:45:50');
INSERT INTO `sm_audit_log` VALUES ('107', 'contract', '10', '123131', '4', null, '1', '2014-07-15 13:45:57');
INSERT INTO `sm_audit_log` VALUES ('108', 'report', '7', '不同性别用户注册量', '2', null, '1', '2014-07-15 14:33:00');
INSERT INTO `sm_audit_log` VALUES ('109', 'customer', null, '导出列表选中的数据', '6', '共导出0条数据', '1', '2014-07-15 15:15:13');
INSERT INTO `sm_audit_log` VALUES ('110', 'contract', null, '导出列表选中的数据', '6', '共导出2条数据', '1', '2014-07-15 15:16:53');
INSERT INTO `sm_audit_log` VALUES ('111', 'report', '6', '不同性别用户每月注册量', '2', null, '1', '2014-07-15 15:33:00');
INSERT INTO `sm_audit_log` VALUES ('112', 'report', '7', '不同性别用户注册量', '2', null, '1', '2014-07-15 15:37:26');
INSERT INTO `sm_audit_log` VALUES ('113', 'report', '7', '不同性别用户注册量', '2', null, '1', '2014-07-15 16:27:28');
INSERT INTO `sm_audit_log` VALUES ('114', 'report', '7', '不同性别用户注册量', '2', null, '1', '2014-07-15 16:27:45');
INSERT INTO `sm_audit_log` VALUES ('115', 'report', '7', '不同性别用户注册量', '2', null, '1', '2014-07-15 16:30:10');
INSERT INTO `sm_audit_log` VALUES ('116', 'report', '7', '不同性别用户注册量', '2', null, '1', '2014-07-15 16:30:28');
INSERT INTO `sm_audit_log` VALUES ('117', 'report', '7', '不同性别用户注册量', '2', null, '1', '2014-07-15 16:32:59');
INSERT INTO `sm_audit_log` VALUES ('118', 'report', '7', '不同性别用户注册量', '2', null, '1', '2014-07-15 16:33:10');
INSERT INTO `sm_audit_log` VALUES ('119', 'report', '8', '统计名称', '1', null, '1', '2014-07-15 17:11:03');
INSERT INTO `sm_audit_log` VALUES ('120', 'report', '6', '不同性别用户每月注册量', '2', null, '1', '2014-07-15 17:19:17');
INSERT INTO `sm_audit_log` VALUES ('121', 'contract', '11', '4324242343242', '2', null, '1', '2014-07-15 17:20:23');
INSERT INTO `sm_audit_log` VALUES ('122', 'contract', '11', '4324242343242', '2', null, '1', '2014-07-15 17:21:10');
INSERT INTO `sm_audit_log` VALUES ('123', 'report', '7', '不同性别用户注册量', '2', null, '1', '2014-07-15 17:21:44');
INSERT INTO `sm_audit_log` VALUES ('124', 'contract', '11', '4324242343242', '2', null, '1', '2014-07-15 17:22:44');
INSERT INTO `sm_audit_log` VALUES ('125', 'contract', '11', '4324242343242', '2', null, '1', '2014-07-15 17:22:55');
INSERT INTO `sm_audit_log` VALUES ('126', 'contract', '11', '4324242343242', '2', null, '1', '2014-07-15 17:25:03');
INSERT INTO `sm_audit_log` VALUES ('127', 'report', '6', '不同性别用户每月注册量', '2', null, '1', '2014-07-15 18:34:40');
INSERT INTO `sm_audit_log` VALUES ('128', 'user', '5', 'test', '10', '禁用用户', '1', '2014-07-16 01:47:47');
INSERT INTO `sm_audit_log` VALUES ('129', 'user', '3', 'manager', '10', '禁用用户', '1', '2014-07-16 01:48:11');
INSERT INTO `sm_audit_log` VALUES ('130', 'role', '1', '系统管理员', '7', '角色授权', '1', '2014-07-16 02:03:37');
INSERT INTO `sm_audit_log` VALUES ('131', 'role', '1', '系统管理员', '7', '角色授权', '1', '2014-07-16 02:03:51');
INSERT INTO `sm_audit_log` VALUES ('132', 'user', '3', 'manager', '9', '启用用户', '1', '2014-07-16 03:25:55');
INSERT INTO `sm_audit_log` VALUES ('133', 'user', '3', 'manager', '10', '禁用用户', '1', '2014-07-16 03:25:58');
INSERT INTO `sm_audit_log` VALUES ('134', 'recyclebin', '10', '123131', '13', '还原删除数据', '1', '2014-07-16 10:26:09');
INSERT INTO `sm_audit_log` VALUES ('135', 'recyclebin', '8', '12322', '12', '真实删除数据', '1', '2014-07-16 10:26:15');
INSERT INTO `sm_audit_log` VALUES ('136', 'recyclebin', '9', '12322', '12', '真实删除数据', '1', '2014-07-16 10:26:15');
INSERT INTO `sm_audit_log` VALUES ('137', 'recyclebin', '8', '1335', '12', '真实删除数据', '1', '2014-07-16 10:26:15');
INSERT INTO `sm_audit_log` VALUES ('138', 'recyclebin', '9', '1335', '12', '真实删除数据', '1', '2014-07-16 10:26:15');
INSERT INTO `sm_audit_log` VALUES ('139', 'contract', '11', '4324242343242', '4', null, '1', '2014-07-16 10:27:43');
INSERT INTO `sm_audit_log` VALUES ('140', 'recyclebin', '11', '4324242343242', '12', '真实删除数据', '1', '2014-07-16 10:27:51');
INSERT INTO `sm_audit_log` VALUES ('141', 'notice', '2', '让我', '2', null, '1', '2014-07-16 10:31:21');
INSERT INTO `sm_audit_log` VALUES ('142', 'notice', '2', '让我', '2', null, '1', '2014-07-16 10:31:42');
INSERT INTO `sm_audit_log` VALUES ('143', 'customer', '8', '323', '4', null, '1', '2014-07-16 11:04:52');
INSERT INTO `sm_audit_log` VALUES ('144', 'organization', '35', '总办', '1', '组织增加', '1', '2014-07-16 11:41:51');
INSERT INTO `sm_audit_log` VALUES ('145', 'organization', '36', '投资基金管理', '1', '组织增加', '1', '2014-07-16 11:42:15');
INSERT INTO `sm_audit_log` VALUES ('146', 'organization', '37', '资产管理', '1', '组织增加', '1', '2014-07-16 11:42:28');
INSERT INTO `sm_audit_log` VALUES ('147', 'organization', '38', '行政', '1', '组织增加', '1', '2014-07-16 11:42:54');
INSERT INTO `sm_audit_log` VALUES ('148', 'organization', '39', '人力', '1', '组织增加', '1', '2014-07-16 11:43:09');
INSERT INTO `sm_audit_log` VALUES ('149', 'organization', '40', '财务', '1', '组织增加', '1', '2014-07-16 11:43:24');
INSERT INTO `sm_audit_log` VALUES ('150', 'organization', '41', '秘书', '1', '组织增加', '1', '2014-07-16 11:43:38');
INSERT INTO `sm_audit_log` VALUES ('151', 'organization', '42', '法务', '1', '组织增加', '1', '2014-07-16 11:43:52');
INSERT INTO `sm_audit_log` VALUES ('152', 'organization', '43', '项目', '1', '组织增加', '1', '2014-07-16 11:44:08');
INSERT INTO `sm_audit_log` VALUES ('153', 'organization', '44', '风控', '1', '组织增加', '1', '2014-07-16 11:44:21');
INSERT INTO `sm_audit_log` VALUES ('154', 'organization', '45', '投资', '1', '组织增加', '1', '2014-07-16 11:44:35');
INSERT INTO `sm_audit_log` VALUES ('155', 'organization', '46', '理财', '1', '组织增加', '1', '2014-07-16 11:45:33');
INSERT INTO `sm_audit_log` VALUES ('156', 'organization', '43', '项目', '2', '组织修改', '1', '2014-07-16 11:46:09');
INSERT INTO `sm_audit_log` VALUES ('157', 'organization', '44', '风控', '2', '组织修改', '1', '2014-07-16 11:46:35');
INSERT INTO `sm_audit_log` VALUES ('158', 'organization', '47', '渠道', '1', '组织增加', '1', '2014-07-16 11:47:02');
INSERT INTO `sm_audit_log` VALUES ('159', 'organization', '45', '投资', '2', '组织修改', '1', '2014-07-16 11:47:52');
INSERT INTO `sm_audit_log` VALUES ('160', 'organization', '48', '企划', '1', '组织增加', '1', '2014-07-16 11:49:12');
INSERT INTO `sm_audit_log` VALUES ('161', 'organization', '49', '品牌', '1', '组织增加', '1', '2014-07-16 11:49:32');
INSERT INTO `sm_audit_log` VALUES ('162', 'organization', '50', '技术', '1', '组织增加', '1', '2014-07-16 11:49:50');
INSERT INTO `sm_audit_log` VALUES ('164', 'organization', '51', '海淀区分部', '1', '组织增加', '1', '2014-07-16 11:52:36');
INSERT INTO `sm_audit_log` VALUES ('165', 'organization', '52', '昌平区分部', '1', '组织增加', '1', '2014-07-16 11:53:00');
INSERT INTO `sm_audit_log` VALUES ('166', 'organization', '53', '行政部', '1', '组织增加', '1', '2014-07-16 11:58:00');
INSERT INTO `sm_audit_log` VALUES ('168', 'organization', '54', '人力部', '1', '组织增加', '1', '2014-07-16 12:03:49');
INSERT INTO `sm_audit_log` VALUES ('170', 'organization', '55', '华兴泰达', '1', '组织增加', '1', '2014-07-16 12:07:10');
INSERT INTO `sm_audit_log` VALUES ('171', 'organization', '56', '运营部', '1', '组织增加', '1', '2014-07-16 12:08:36');
INSERT INTO `sm_audit_log` VALUES ('173', 'organization', '57', '市场部', '1', '组织增加', '1', '2014-07-16 12:19:34');
INSERT INTO `sm_audit_log` VALUES ('174', 'organization', '58', '总裁办公室', '1', '组织增加', '1', '2014-07-16 12:23:17');
INSERT INTO `sm_audit_log` VALUES ('175', 'organization', '59', '朝阳区分部', '1', '组织增加', '1', '2014-07-16 13:08:43');
INSERT INTO `sm_audit_log` VALUES ('176', 'organization', '60', '房山区分部', '1', '组织增加', '1', '2014-07-16 13:09:00');
INSERT INTO `sm_audit_log` VALUES ('177', 'user', '6', '李总裁', '1', null, '1', '2014-07-16 13:18:53');
INSERT INTO `sm_audit_log` VALUES ('178', 'user', '7', '夏幼学', '1', null, '1', '2014-07-16 13:20:44');
INSERT INTO `sm_audit_log` VALUES ('179', 'user', '8', '栾瑞松', '1', null, '1', '2014-07-16 13:21:47');
INSERT INTO `sm_audit_log` VALUES ('180', 'user', '3', 'manager', '4', null, '1', '2014-07-16 13:22:01');
INSERT INTO `sm_audit_log` VALUES ('181', 'user', '7', '夏幼学', '2', null, '1', '2014-07-16 13:22:05');
INSERT INTO `sm_audit_log` VALUES ('182', 'contract', '10', '123131', '2', null, '1', '2014-07-16 13:40:50');
INSERT INTO `sm_audit_log` VALUES ('183', 'order', '2', '123456', '2', null, '1', '2014-07-16 13:42:30');
INSERT INTO `sm_audit_log` VALUES ('184', 'contract', '12', '344234234242423', '1', null, '1', '2014-07-16 13:46:06');
INSERT INTO `sm_audit_log` VALUES ('185', 'user', '6', '李华', '2', null, '1', '2014-07-16 14:00:26');
INSERT INTO `sm_audit_log` VALUES ('186', 'customer', '7', 'admin', '4', null, '1', '2014-07-16 14:00:47');
INSERT INTO `sm_audit_log` VALUES ('187', 'customer', '3', 'ad撒', '4', null, '1', '2014-07-16 14:00:47');
INSERT INTO `sm_audit_log` VALUES ('188', 'customer', '2', 'a额问问', '4', null, '1', '2014-07-16 14:00:47');
INSERT INTO `sm_audit_log` VALUES ('189', 'customer', '1', 'admin', '4', null, '1', '2014-07-16 14:00:47');
INSERT INTO `sm_audit_log` VALUES ('190', 'customer', '2', 'a额问问', '4', null, '1', '2014-07-16 14:06:48');
INSERT INTO `sm_audit_log` VALUES ('191', 'customer', '1', 'admin', '4', null, '1', '2014-07-16 14:07:19');
INSERT INTO `sm_audit_log` VALUES ('192', 'customer', '7', 'admin', '4', null, '1', '2014-07-16 14:07:24');
INSERT INTO `sm_audit_log` VALUES ('193', 'user', '5', 'test', '9', '启用用户', '1', '2014-07-16 14:18:03');
INSERT INTO `sm_audit_log` VALUES ('194', 'user', '8', '栾瑞松', '10', '禁用用户', '1', '2014-07-16 14:18:05');
INSERT INTO `sm_audit_log` VALUES ('195', 'user', '7', '夏幼学', '10', '禁用用户', '1', '2014-07-16 14:18:08');
INSERT INTO `sm_audit_log` VALUES ('196', 'user', '6', '李华', '10', '禁用用户', '1', '2014-07-16 14:18:10');
INSERT INTO `sm_audit_log` VALUES ('197', 'user', '5', 'test', '10', '禁用用户', '1', '2014-07-16 14:18:17');
INSERT INTO `sm_audit_log` VALUES ('198', 'user', '8', '栾瑞松', '9', '启用用户', '1', '2014-07-16 14:18:19');
INSERT INTO `sm_audit_log` VALUES ('199', 'user', '7', '夏幼学', '9', '启用用户', '1', '2014-07-16 14:18:30');
INSERT INTO `sm_audit_log` VALUES ('200', 'user', '6', '李华', '9', '启用用户', '1', '2014-07-16 14:18:35');
INSERT INTO `sm_audit_log` VALUES ('201', 'user', '5', 'test', '9', '启用用户', '1', '2014-07-16 14:18:42');
INSERT INTO `sm_audit_log` VALUES ('202', 'user', '8', '栾瑞松', '10', '禁用用户', '1', '2014-07-16 14:18:45');
INSERT INTO `sm_audit_log` VALUES ('203', 'user', '7', '夏幼学', '10', '禁用用户', '1', '2014-07-16 14:18:52');
INSERT INTO `sm_audit_log` VALUES ('204', 'user', '6', '李华', '10', '禁用用户', '1', '2014-07-16 14:19:03');
INSERT INTO `sm_audit_log` VALUES ('205', 'user', '5', 'test', '10', '禁用用户', '1', '2014-07-16 14:19:16');
INSERT INTO `sm_audit_log` VALUES ('206', 'user', '8', '栾瑞松', '9', '启用用户', '1', '2014-07-16 14:19:19');
INSERT INTO `sm_audit_log` VALUES ('207', 'user', '7', '夏幼学', '9', '启用用户', '1', '2014-07-16 14:19:33');
INSERT INTO `sm_audit_log` VALUES ('208', 'user', '6', '李华', '9', '启用用户', '1', '2014-07-16 14:19:42');
INSERT INTO `sm_audit_log` VALUES ('209', 'user', '5', 'test', '9', '启用用户', '1', '2014-07-16 14:19:45');
INSERT INTO `sm_audit_log` VALUES ('210', 'user', '8', '栾瑞松', '10', '禁用用户', '1', '2014-07-16 14:19:49');
INSERT INTO `sm_audit_log` VALUES ('211', 'user', '7', '夏幼学', '10', '禁用用户', '1', '2014-07-16 14:20:04');
INSERT INTO `sm_audit_log` VALUES ('212', 'organization', '61', '华兴瑞泰(北京)', '1', '组织增加', '1', '2014-07-16 14:25:37');
INSERT INTO `sm_audit_log` VALUES ('213', 'user', '8', '栾瑞松', '9', '启用用户', '1', '2014-07-16 14:31:57');
INSERT INTO `sm_audit_log` VALUES ('214', 'user', '8', '栾瑞松', '10', '禁用用户', '1', '2014-07-16 14:32:15');
INSERT INTO `sm_audit_log` VALUES ('215', 'user', '6', '李华', '10', '禁用用户', '1', '2014-07-16 14:32:25');
INSERT INTO `sm_audit_log` VALUES ('217', 'project', '2', '常州亿晶光电5千万上市前私募股权投资', '1', null, '1', '2014-07-16 14:45:37');
INSERT INTO `sm_audit_log` VALUES ('218', 'user', '7', '夏幼学', '9', '启用用户', '1', '2014-07-16 14:50:51');
INSERT INTO `sm_audit_log` VALUES ('219', 'contract', '13', 'sdsds2334', '1', null, '1', '2014-07-16 15:36:32');
INSERT INTO `sm_audit_log` VALUES ('220', 'contract', '12', '344234234242423', '4', null, '1', '2014-07-16 15:38:00');
INSERT INTO `sm_audit_log` VALUES ('221', 'contract', '13', 'sdsds2334', '4', null, '1', '2014-07-16 15:38:04');
INSERT INTO `sm_audit_log` VALUES ('222', 'organization', '54', '人力部', '4', '组织删除', '1', '2014-07-16 15:40:02');
INSERT INTO `sm_audit_log` VALUES ('223', 'organization', '53', '行政部', '4', '组织删除', '1', '2014-07-16 15:40:17');
INSERT INTO `sm_audit_log` VALUES ('224', 'recyclebin', '23', '人力部', '12', '真实删除数据', '1', '2014-07-16 15:40:48');
INSERT INTO `sm_audit_log` VALUES ('225', 'recyclebin', '24', '人力部', '12', '真实删除数据', '1', '2014-07-16 15:40:48');
INSERT INTO `sm_audit_log` VALUES ('226', 'recyclebin', '23', '行政部', '12', '真实删除数据', '1', '2014-07-16 15:40:48');
INSERT INTO `sm_audit_log` VALUES ('227', 'recyclebin', '24', '行政部', '12', '真实删除数据', '1', '2014-07-16 15:40:48');
INSERT INTO `sm_audit_log` VALUES ('228', 'contract', '10', '123131', '2', null, '1', '2014-07-16 15:42:31');
INSERT INTO `sm_audit_log` VALUES ('229', 'supplier', '1', '2014第一季度销售目标', '1', null, '1', '2014-07-16 15:43:50');
INSERT INTO `sm_audit_log` VALUES ('230', 'contract', '10', '123131', '2', null, '1', '2014-07-16 15:45:48');
INSERT INTO `sm_audit_log` VALUES ('231', 'supplier', '2', '按时大时代', '1', null, '1', '2014-07-16 15:46:15');
INSERT INTO `sm_audit_log` VALUES ('234', 'organization', '62', '银行渠道部', '1', '组织增加', '1', '2014-07-16 15:56:47');
INSERT INTO `sm_audit_log` VALUES ('235', 'organization', '63', 'ds ', '1', '组织增加', '1', '2014-07-16 15:58:32');
INSERT INTO `sm_audit_log` VALUES ('238', 'supplier', '1', '2014第一季度销售目标', '2', null, '1', '2014-07-16 16:05:26');
INSERT INTO `sm_audit_log` VALUES ('239', 'organization', '64', '渠道部', '1', '组织增加', '1', '2014-07-16 16:09:37');
INSERT INTO `sm_audit_log` VALUES ('240', 'organization', '65', '渠道部', '1', '组织增加', '1', '2014-07-16 16:10:29');
INSERT INTO `sm_audit_log` VALUES ('241', 'organization', '66', '投资理财部', '1', '组织增加', '1', '2014-07-16 16:10:53');
INSERT INTO `sm_audit_log` VALUES ('242', 'organization', '67', '投资理财部', '1', '组织增加', '1', '2014-07-16 16:22:02');
INSERT INTO `sm_audit_log` VALUES ('243', 'organization', '68', '渠道1组', '1', '组织增加', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_audit_log` VALUES ('244', 'organization', '69', '渠道2组', '1', '组织增加', '1', '2014-07-16 16:25:53');
INSERT INTO `sm_audit_log` VALUES ('245', 'supplier', '2', '按时大时代', '2', null, '1', '2014-07-16 16:27:37');
INSERT INTO `sm_audit_log` VALUES ('246', 'supplier', '2', '按时大时代', '2', null, '1', '2014-07-16 16:28:05');
INSERT INTO `sm_audit_log` VALUES ('247', 'organization', '70', '渠道3组', '1', '组织增加', '1', '2014-07-16 16:29:33');
INSERT INTO `sm_audit_log` VALUES ('248', 'salesTarget', '1', '2014第一季度销售目标', '2', null, '1', '2014-07-16 16:32:36');
INSERT INTO `sm_audit_log` VALUES ('249', 'organization', '71', '理财1组', '1', '组织增加', '1', '2014-07-16 16:33:29');
INSERT INTO `sm_audit_log` VALUES ('250', 'organization', '72', '理财2组', '1', '组织增加', '1', '2014-07-16 16:34:16');
INSERT INTO `sm_audit_log` VALUES ('251', 'organization', '73', '理财3组', '1', '组织增加', '1', '2014-07-16 16:37:03');
INSERT INTO `sm_audit_log` VALUES ('252', 'organization', '74', '理财部', '1', '组织增加', '1', '2014-07-16 16:38:17');
INSERT INTO `sm_audit_log` VALUES ('254', 'organization', '75', '渠道1组', '1', '组织增加', '1', '2014-07-16 16:39:52');
INSERT INTO `sm_audit_log` VALUES ('256', 'salesTarget', '2', '按时大时代', '2', null, '1', '2014-07-16 16:41:03');
INSERT INTO `sm_audit_log` VALUES ('257', 'organization', '76', '渠道2组', '1', '组织增加', '1', '2014-07-16 16:41:34');
INSERT INTO `sm_audit_log` VALUES ('258', 'organization', '77', '渠道3组', '1', '组织增加', '1', '2014-07-16 16:42:14');
INSERT INTO `sm_audit_log` VALUES ('259', 'organization', '78', '理财1组', '1', '组织增加', '1', '2014-07-16 16:43:29');
INSERT INTO `sm_audit_log` VALUES ('260', 'order', '3', '还不考虑看见了分公司的飞', '1', null, '1', '2014-07-16 16:43:40');
INSERT INTO `sm_audit_log` VALUES ('261', 'salesTarget', '3', '爱仕达', '1', null, '1', '2014-07-16 16:43:55');
INSERT INTO `sm_audit_log` VALUES ('262', 'organization', '79', '理财2组', '1', '组织增加', '1', '2014-07-16 16:44:32');
INSERT INTO `sm_audit_log` VALUES ('263', 'organization', '80', '理财1组', '1', '组织增加', '1', '2014-07-16 16:45:10');
INSERT INTO `sm_audit_log` VALUES ('264', 'organization', '81', '理财3组', '1', '组织增加', '1', '2014-07-16 16:45:30');
INSERT INTO `sm_audit_log` VALUES ('265', 'userMessage', '6', '你好', '1', null, '1', '2014-07-16 16:46:00');
INSERT INTO `sm_audit_log` VALUES ('266', 'organization', '82', '理财2组', '1', '组织增加', '1', '2014-07-16 16:46:40');
INSERT INTO `sm_audit_log` VALUES ('267', 'organization', '83', '理财3组', '1', '组织增加', '1', '2014-07-16 16:47:33');
INSERT INTO `sm_audit_log` VALUES ('268', 'salesTarget', '3', '爱仕达', '2', null, '1', '2014-07-16 16:47:41');
INSERT INTO `sm_audit_log` VALUES ('269', 'organization', '84', '理财部', '1', '组织增加', '1', '2014-07-16 16:49:19');
INSERT INTO `sm_audit_log` VALUES ('270', 'organization', '85', '渠道1组', '1', '组织增加', '1', '2014-07-16 16:50:08');
INSERT INTO `sm_audit_log` VALUES ('271', 'salesTarget', '1', '2014第一季度销售目标', '2', null, '1', '2014-07-16 16:50:09');
INSERT INTO `sm_audit_log` VALUES ('272', 'userMessage', '8', '测试', '1', null, '1', '2014-07-16 16:50:54');
INSERT INTO `sm_audit_log` VALUES ('273', 'userMessage', '10', '测试', '1', null, '1', '2014-07-16 16:50:55');
INSERT INTO `sm_audit_log` VALUES ('274', 'userMessage', '12', '测试', '1', null, '1', '2014-07-16 16:50:55');
INSERT INTO `sm_audit_log` VALUES ('275', 'organization', '86', '渠道2组', '1', '组织增加', '1', '2014-07-16 16:51:21');
INSERT INTO `sm_audit_log` VALUES ('276', 'organization', '87', '渠道3组', '1', '组织增加', '1', '2014-07-16 16:52:38');
INSERT INTO `sm_audit_log` VALUES ('277', 'userMessage', '14', '我好想睡觉', '1', null, '1', '2014-07-16 16:53:20');
INSERT INTO `sm_audit_log` VALUES ('278', 'userMessage', '16', '我好想睡觉', '1', null, '1', '2014-07-16 16:53:20');
INSERT INTO `sm_audit_log` VALUES ('279', 'userMessage', '18', '我好想睡觉', '1', null, '1', '2014-07-16 16:53:20');
INSERT INTO `sm_audit_log` VALUES ('280', 'userMessage', '20', '我好想睡觉', '1', null, '1', '2014-07-16 16:53:21');
INSERT INTO `sm_audit_log` VALUES ('281', 'userMessage', '22', '我好想睡觉', '1', null, '1', '2014-07-16 16:53:21');
INSERT INTO `sm_audit_log` VALUES ('282', 'organization', '88', '理财1组', '1', '组织增加', '1', '2014-07-16 16:53:31');
INSERT INTO `sm_audit_log` VALUES ('283', 'userMessage', '24', '123', '1', null, '1', '2014-07-16 16:55:17');
INSERT INTO `sm_audit_log` VALUES ('284', 'userMessage', '26', '123', '1', null, '1', '2014-07-16 16:55:17');
INSERT INTO `sm_audit_log` VALUES ('285', 'organization', '89', '理财2组', '1', '组织增加', '1', '2014-07-16 16:55:17');
INSERT INTO `sm_audit_log` VALUES ('286', 'userMessage', '28', '123', '1', null, '1', '2014-07-16 16:55:17');
INSERT INTO `sm_audit_log` VALUES ('287', 'organization', '90', '理财3组', '1', '组织增加', '1', '2014-07-16 16:55:58');
INSERT INTO `sm_audit_log` VALUES ('288', 'salesTarget', '2', '按时大时代', '2', null, '1', '2014-07-16 16:58:33');
INSERT INTO `sm_audit_log` VALUES ('289', 'salesTarget', '3', '爱仕达', '2', null, '1', '2014-07-16 16:58:41');
INSERT INTO `sm_audit_log` VALUES ('290', 'user', '9', '陈振', '1', null, '1', '2014-07-16 17:01:35');
INSERT INTO `sm_audit_log` VALUES ('291', 'userMessage', '30', '你好', '1', null, '1', '2014-07-16 17:02:21');
INSERT INTO `sm_audit_log` VALUES ('292', 'userMessage', '32', '你好呀', '1', null, '1', '2014-07-16 17:03:54');
INSERT INTO `sm_audit_log` VALUES ('293', 'user', '10', '张家辉', '1', null, '1', '2014-07-16 17:04:33');
INSERT INTO `sm_audit_log` VALUES ('294', 'user', '11', '成龙', '1', null, '1', '2014-07-16 17:05:43');
INSERT INTO `sm_audit_log` VALUES ('295', 'user', '12', '陈龙', '1', null, '1', '2014-07-16 17:06:40');
INSERT INTO `sm_audit_log` VALUES ('296', 'user', '10', '张家辉', '2', null, '1', '2014-07-16 17:07:21');
INSERT INTO `sm_audit_log` VALUES ('297', 'user', '11', '成龙', '2', null, '1', '2014-07-16 17:07:44');
INSERT INTO `sm_audit_log` VALUES ('298', 'user', '12', '陈龙', '2', null, '1', '2014-07-16 17:07:54');
INSERT INTO `sm_audit_log` VALUES ('299', 'userMessage', '34', '你好呀', '1', null, '1', '2014-07-16 17:08:31');
INSERT INTO `sm_audit_log` VALUES ('300', 'userMessage', '36', '你好呀', '1', null, '1', '2014-07-16 17:08:32');
INSERT INTO `sm_audit_log` VALUES ('301', 'userMessage', '38', '你好呀', '1', null, '1', '2014-07-16 17:08:32');
INSERT INTO `sm_audit_log` VALUES ('302', 'userMessage', '40', '你好呀', '1', null, '1', '2014-07-16 17:09:18');
INSERT INTO `sm_audit_log` VALUES ('303', 'userMessage', '42', '你好呀', '1', null, '1', '2014-07-16 17:09:18');
INSERT INTO `sm_audit_log` VALUES ('304', 'userMessage', '44', '你好呀', '1', null, '1', '2014-07-16 17:09:19');
INSERT INTO `sm_audit_log` VALUES ('305', 'userMessage', '46', '你好呀', '1', null, '1', '2014-07-16 17:09:19');
INSERT INTO `sm_audit_log` VALUES ('306', 'userMessage', '48', '你好呀', '1', null, '1', '2014-07-16 17:09:20');
INSERT INTO `sm_audit_log` VALUES ('307', 'userMessage', '50', '你好呀', '1', null, '1', '2014-07-16 17:09:20');
INSERT INTO `sm_audit_log` VALUES ('308', 'userMessage', '52', '你好呀', '1', null, '1', '2014-07-16 17:09:20');
INSERT INTO `sm_audit_log` VALUES ('309', 'userMessage', '54', '你好呀', '1', null, '1', '2014-07-16 17:09:21');
INSERT INTO `sm_audit_log` VALUES ('310', 'userMessage', '56', '你好呀', '1', null, '1', '2014-07-16 17:09:21');
INSERT INTO `sm_audit_log` VALUES ('311', 'user', '5', 'test', '4', null, '1', '2014-07-16 17:09:32');
INSERT INTO `sm_audit_log` VALUES ('312', 'user', '6', '刘亦菲', '2', null, '1', '2014-07-16 17:10:26');
INSERT INTO `sm_audit_log` VALUES ('313', 'userMessage', '53', '你好呀', '4', null, '1', '2014-07-16 17:11:04');
INSERT INTO `sm_audit_log` VALUES ('314', 'user', '9', '陈振', '2', null, '1', '2014-07-16 17:11:47');
INSERT INTO `sm_audit_log` VALUES ('315', 'user', '9', '陈振', '2', null, '1', '2014-07-16 17:12:11');
INSERT INTO `sm_audit_log` VALUES ('316', 'userMessage', '55', '你好呀', '4', null, '1', '2014-07-16 17:12:27');
INSERT INTO `sm_audit_log` VALUES ('317', 'userMessage', '51', '你好呀', '4', null, '1', '2014-07-16 17:12:27');
INSERT INTO `sm_audit_log` VALUES ('318', 'recyclebin', '27', '你好呀', '13', '还原删除数据', '1', '2014-07-16 17:12:58');
INSERT INTO `sm_audit_log` VALUES ('319', 'recyclebin', '28', '你好呀', '13', '还原删除数据', '1', '2014-07-16 17:12:58');
INSERT INTO `sm_audit_log` VALUES ('320', 'recyclebin', '27', '你好呀', '13', '还原删除数据', '1', '2014-07-16 17:12:58');
INSERT INTO `sm_audit_log` VALUES ('321', 'recyclebin', '28', '你好呀', '13', '还原删除数据', '1', '2014-07-16 17:12:58');
INSERT INTO `sm_audit_log` VALUES ('322', 'user', '13', '刘德华', '1', null, '1', '2014-07-16 17:16:35');
INSERT INTO `sm_audit_log` VALUES ('323', 'user', '14', '马敬亮', '1', null, '1', '2014-07-16 17:17:18');
INSERT INTO `sm_audit_log` VALUES ('324', 'user', '15', 'lihua', '1', null, '1', '2014-07-16 17:19:02');
INSERT INTO `sm_audit_log` VALUES ('325', 'user', '16', '栾瑞松', '1', null, '1', '2014-07-16 17:19:33');
INSERT INTO `sm_audit_log` VALUES ('326', 'user', '17', '夏幼学', '1', null, '1', '2014-07-16 17:20:03');
INSERT INTO `sm_audit_log` VALUES ('327', 'user', '18', '罗晓丽', '1', null, '1', '2014-07-16 17:20:45');
INSERT INTO `sm_audit_log` VALUES ('328', 'user', '19', '惠子敬', '1', null, '1', '2014-07-16 17:21:25');
INSERT INTO `sm_audit_log` VALUES ('329', 'user', '17', '夏幼学', '2', null, '1', '2014-07-16 17:21:54');
INSERT INTO `sm_audit_log` VALUES ('330', 'lead', '3', '爱仕达', '4', null, '1', '2014-07-16 17:21:57');
INSERT INTO `sm_audit_log` VALUES ('331', 'user', '15', '李华', '2', null, '1', '2014-07-16 17:22:43');
INSERT INTO `sm_audit_log` VALUES ('332', 'user', '8', '曹操', '9', '启用用户', '1', '2014-07-16 17:23:45');
INSERT INTO `sm_audit_log` VALUES ('333', 'role', '5', '理财专员', '1', '角色增加', '1', '2014-07-16 17:25:50');
INSERT INTO `sm_audit_log` VALUES ('334', 'role', '6', '理财经理', '1', '角色增加', '1', '2014-07-16 17:26:02');
INSERT INTO `sm_audit_log` VALUES ('335', 'role', '7', '理财总监', '1', '角色增加', '1', '2014-07-16 17:26:10');
INSERT INTO `sm_audit_log` VALUES ('336', 'role', '5', '理财专员', '2', '角色修改', '1', '2014-07-16 17:26:29');
INSERT INTO `sm_audit_log` VALUES ('337', 'role', '8', '副总裁', '1', '角色增加', '1', '2014-07-16 17:27:07');
INSERT INTO `sm_audit_log` VALUES ('338', 'role', '9', '投资总监', '1', '角色增加', '1', '2014-07-16 17:28:34');
INSERT INTO `sm_audit_log` VALUES ('339', 'role', '10', '投资经理', '1', '角色增加', '1', '2014-07-16 17:28:41');
INSERT INTO `sm_audit_log` VALUES ('340', 'notice', '3', '发布公告', '1', null, '1', '2014-07-16 17:40:43');
INSERT INTO `sm_audit_log` VALUES ('341', 'notice', '3', '发布公告', '2', null, '1', '2014-07-16 17:40:55');
INSERT INTO `sm_audit_log` VALUES ('342', 'notice', '4', '23456', '1', null, '1', '2014-07-16 17:41:33');
INSERT INTO `sm_audit_log` VALUES ('343', 'notice', '5', '公告', '1', null, '1', '2014-07-16 17:43:20');
INSERT INTO `sm_audit_log` VALUES ('344', 'user', '11', '成龙', '2', null, '1', '2014-07-16 17:51:27');
INSERT INTO `sm_audit_log` VALUES ('345', 'user', '12', '陈龙', '2', null, '1', '2014-07-16 17:51:45');
INSERT INTO `sm_audit_log` VALUES ('346', 'user', '13', '刘德华', '2', null, '1', '2014-07-16 17:52:00');
INSERT INTO `sm_audit_log` VALUES ('347', 'user', '15', '李华', '7', '用户授权', '1', '2014-07-16 17:53:35');
INSERT INTO `sm_audit_log` VALUES ('348', 'notice', '6', '你好', '1', null, '1', '2014-07-16 17:55:13');
INSERT INTO `sm_audit_log` VALUES ('349', 'notice', '6', '好好好', '2', null, '1', '2014-07-16 17:55:26');
INSERT INTO `sm_audit_log` VALUES ('350', 'notice', '7', '我的公告', '1', null, '1', '2014-07-16 17:57:00');
INSERT INTO `sm_audit_log` VALUES ('351', 'notice', '8', '我的', '1', null, '1', '2014-07-16 17:57:19');
INSERT INTO `sm_audit_log` VALUES ('352', 'user', '11', '成龙', '2', null, '1', '2014-07-16 17:58:05');
INSERT INTO `sm_audit_log` VALUES ('353', 'user', '12', '陈龙', '2', null, '1', '2014-07-16 17:58:53');
INSERT INTO `sm_audit_log` VALUES ('354', 'user', '11', '成龙', '2', null, '1', '2014-07-16 17:59:27');
INSERT INTO `sm_audit_log` VALUES ('355', 'user', '9', '陈振', '2', null, '1', '2014-07-16 18:01:31');
INSERT INTO `sm_audit_log` VALUES ('356', 'user', '6', '刘亦菲', '9', '启用用户', '1', '2014-07-16 18:01:37');
INSERT INTO `sm_audit_log` VALUES ('357', 'user', '6', '刘亦菲', '10', '禁用用户', '1', '2014-07-16 18:01:40');
INSERT INTO `sm_audit_log` VALUES ('358', 'role', '5', '理财专员', '4', '角色删除', '1', '2014-07-16 18:02:04');
INSERT INTO `sm_audit_log` VALUES ('359', 'role', '7', '理财总监', '4', '角色删除', '1', '2014-07-16 18:02:04');
INSERT INTO `sm_audit_log` VALUES ('360', 'role', '11', 'IT人员', '1', '角色增加', '1', '2014-07-16 18:03:07');
INSERT INTO `sm_audit_log` VALUES ('361', 'user', '7', '夏侯惇', '10', '禁用用户', '1', '2014-07-16 18:03:57');
INSERT INTO `sm_audit_log` VALUES ('362', 'user', '7', '夏侯惇', '9', '启用用户', '1', '2014-07-16 18:04:00');
INSERT INTO `sm_audit_log` VALUES ('363', 'organization', '91', 'test1', '1', '组织增加', '1', '2014-07-16 18:06:04');
INSERT INTO `sm_audit_log` VALUES ('364', 'organization', '92', 'test2', '1', '组织增加', '1', '2014-07-16 18:06:24');
INSERT INTO `sm_audit_log` VALUES ('365', 'organization', '91', 'test1', '4', '组织删除', '1', '2014-07-16 18:06:46');
INSERT INTO `sm_audit_log` VALUES ('366', 'organization', '92', 'test2', '4', '组织删除', '1', '2014-07-16 18:06:46');
INSERT INTO `sm_audit_log` VALUES ('367', 'user', '15', '李华', '7', '用户授权', '1', '2014-07-16 18:14:59');
INSERT INTO `sm_audit_log` VALUES ('368', 'user', '15', '李华', '7', '用户授权', '1', '2014-07-16 18:27:46');
INSERT INTO `sm_audit_log` VALUES ('369', 'function', '140113', '发送审批', '1', null, '1', '2014-07-16 21:03:03');
INSERT INTO `sm_audit_log` VALUES ('370', 'function', '140113', '发送审批', '2', null, '1', '2014-07-16 21:30:35');
INSERT INTO `sm_audit_log` VALUES ('371', 'user', '20', '12345', '1', null, '1', '2014-07-17 11:19:48');
INSERT INTO `sm_audit_log` VALUES ('372', 'user', '21', '刘岚', '1', null, '1', '2014-07-17 11:26:51');
INSERT INTO `sm_audit_log` VALUES ('373', 'user', '22', 'liu', '1', null, '1', '2014-07-17 11:29:43');
INSERT INTO `sm_audit_log` VALUES ('374', 'user', '8', '曹操', '4', null, '1', '2014-07-17 11:33:08');
INSERT INTO `sm_audit_log` VALUES ('375', 'user', '7', '夏侯惇', '10', '禁用用户', '1', '2014-07-17 11:33:39');
INSERT INTO `sm_audit_log` VALUES ('376', 'user', '7', '夏侯惇', '9', '启用用户', '1', '2014-07-17 11:33:46');
INSERT INTO `sm_audit_log` VALUES ('377', 'user', '6', '刘亦菲', '9', '启用用户', '1', '2014-07-17 11:33:52');
INSERT INTO `sm_audit_log` VALUES ('378', 'user', '6', '刘亦菲', '10', '禁用用户', '1', '2014-07-17 11:34:59');
INSERT INTO `sm_audit_log` VALUES ('379', 'user', '6', '刘亦菲', '9', '启用用户', '1', '2014-07-17 11:35:56');
INSERT INTO `sm_audit_log` VALUES ('380', 'user', '6', '刘亦菲', '10', '禁用用户', '1', '2014-07-17 11:36:20');
INSERT INTO `sm_audit_log` VALUES ('381', 'user', '6', '刘亦菲', '2', null, '1', '2014-07-17 11:36:35');
INSERT INTO `sm_audit_log` VALUES ('382', 'user', '23', '098', '1', null, '1', '2014-07-17 11:37:29');
INSERT INTO `sm_audit_log` VALUES ('383', 'user', '6', '刘亦菲', '9', '启用用户', '1', '2014-07-17 11:37:45');
INSERT INTO `sm_audit_log` VALUES ('384', 'user', '24', '123456', '1', null, '1', '2014-07-17 11:38:16');
INSERT INTO `sm_audit_log` VALUES ('385', 'user', '6', '刘亦菲', '10', '禁用用户', '1', '2014-07-17 11:38:42');
INSERT INTO `sm_audit_log` VALUES ('386', 'user', '7', '夏侯惇', '2', null, '1', '2014-07-17 11:39:36');
INSERT INTO `sm_audit_log` VALUES ('387', 'user', '7', '夏侯惇', '7', '用户授权', '1', '2014-07-17 11:40:06');
INSERT INTO `sm_audit_log` VALUES ('388', 'user', '7', '夏侯惇', '8', '重置密码', '1', '2014-07-17 11:40:29');
INSERT INTO `sm_audit_log` VALUES ('389', 'user', '7', '夏侯惇', '8', '重置密码', '1', '2014-07-17 11:40:36');
INSERT INTO `sm_audit_log` VALUES ('390', 'user', '7', '夏侯惇', '7', '用户授权', '1', '2014-07-17 11:51:42');
INSERT INTO `sm_audit_log` VALUES ('391', 'user', '7', '夏侯惇', '4', null, '1', '2014-07-17 11:52:19');
INSERT INTO `sm_audit_log` VALUES ('392', 'user', '9', '陈振', '8', '重置密码', '1', '2014-07-17 11:55:58');
INSERT INTO `sm_audit_log` VALUES ('393', 'user', '25', '刘岚', '1', null, '1', '2014-07-17 11:57:19');
INSERT INTO `sm_audit_log` VALUES ('394', 'user', '6', '刘亦菲', '9', '启用用户', '1', '2014-07-17 13:26:04');
INSERT INTO `sm_audit_log` VALUES ('395', 'user', '6', '刘亦菲', '2', null, '1', '2014-07-17 13:36:43');
INSERT INTO `sm_audit_log` VALUES ('396', 'contract', '14', 'dsd', '1', null, '1', '2014-07-17 13:36:43');
INSERT INTO `sm_audit_log` VALUES ('397', 'contract', '14', 'dsd', '2', null, '1', '2014-07-17 13:38:22');
INSERT INTO `sm_audit_log` VALUES ('398', 'contract', '14', '123456', '2', null, '1', '2014-07-17 14:07:57');
INSERT INTO `sm_audit_log` VALUES ('399', 'contract', '14', '123456wwwww', '2', null, '1', '2014-07-17 14:11:23');
INSERT INTO `sm_audit_log` VALUES ('400', 'userMessage', '58', 'sa', '1', null, '1', '2014-07-17 14:18:52');
INSERT INTO `sm_audit_log` VALUES ('401', 'userMessage', '60', 'sa', '1', null, '1', '2014-07-17 14:20:27');
INSERT INTO `sm_audit_log` VALUES ('402', 'userMessage', '62', 'dddd', '1', null, '1', '2014-07-17 14:21:22');
INSERT INTO `sm_audit_log` VALUES ('403', 'userMessage', '64', 'sa', '1', null, '1', '2014-07-17 14:25:06');
INSERT INTO `sm_audit_log` VALUES ('404', 'user', null, '导出列表选中的数据', '6', '共导出2条数据', '1', '2014-07-17 14:38:44');
INSERT INTO `sm_audit_log` VALUES ('405', 'user', null, '导出列表选中的数据', '6', '共导出2条数据', '1', '2014-07-17 14:38:47');
INSERT INTO `sm_audit_log` VALUES ('406', 'user', null, '导出列表选中的数据', '6', '共导出10条数据', '1', '2014-07-17 14:39:06');
INSERT INTO `sm_audit_log` VALUES ('407', 'role', '12', '测试人员', '1', '角色增加', '1', '2014-07-17 14:47:15');
INSERT INTO `sm_audit_log` VALUES ('408', 'role', '12', '测试人员', '2', '角色修改', '1', '2014-07-17 14:47:32');
INSERT INTO `sm_audit_log` VALUES ('409', 'role', '12', '测试人员', '2', '角色修改', '1', '2014-07-17 14:48:09');
INSERT INTO `sm_audit_log` VALUES ('410', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-17 14:49:37');
INSERT INTO `sm_audit_log` VALUES ('411', 'role', '12', '测试人员', '7', '角色授权', '1', '2014-07-17 14:50:29');
INSERT INTO `sm_audit_log` VALUES ('412', 'role', '12', '测试人员', '7', '角色授权', '1', '2014-07-17 14:50:40');
INSERT INTO `sm_audit_log` VALUES ('413', 'role', '12', '测试人员', '7', '角色授权', '1', '2014-07-17 14:51:13');
INSERT INTO `sm_audit_log` VALUES ('414', 'user', '25', '刘岚', '8', '重置密码', '1', '2014-07-17 14:53:22');
INSERT INTO `sm_audit_log` VALUES ('415', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-17 14:59:57');
INSERT INTO `sm_audit_log` VALUES ('416', 'contract', '15', '123456', '1', null, '1', '2014-07-17 15:44:19');
INSERT INTO `sm_audit_log` VALUES ('417', 'contract', '16', '还不考虑看见了分公司的飞', '1', null, '1', '2014-07-17 15:47:03');
INSERT INTO `sm_audit_log` VALUES ('418', 'report', '6', '不同性别用户每月注册量', '2', null, '1', '2014-07-17 16:11:38');
INSERT INTO `sm_audit_log` VALUES ('419', 'user', '25', '刘岚', '2', null, '1', '2014-07-17 16:13:41');
INSERT INTO `sm_audit_log` VALUES ('420', 'role', '13', '测试工程师', '1', '角色增加', '1', '2014-07-17 16:21:50');
INSERT INTO `sm_audit_log` VALUES ('421', 'contract', '13', 'sdsds2334', '4', null, '1', '2014-07-17 16:47:01');
INSERT INTO `sm_audit_log` VALUES ('422', 'contract', '10', '123131', '4', null, '1', '2014-07-17 16:47:01');
INSERT INTO `sm_audit_log` VALUES ('423', 'contract', '9', '1235456', '4', null, '1', '2014-07-17 16:47:01');
INSERT INTO `sm_audit_log` VALUES ('424', 'contract', '12', '344234234242423', '4', null, '1', '2014-07-17 16:47:01');
INSERT INTO `sm_audit_log` VALUES ('425', 'contract', '15', '123456', '4', null, '1', '2014-07-17 16:47:20');
INSERT INTO `sm_audit_log` VALUES ('426', 'contract', '13', 'sdsds2334', '4', null, '1', '2014-07-17 16:47:20');
INSERT INTO `sm_audit_log` VALUES ('427', 'contract', '10', '123131', '4', null, '1', '2014-07-17 16:47:20');
INSERT INTO `sm_audit_log` VALUES ('428', 'contract', '9', '1235456', '4', null, '1', '2014-07-17 16:47:20');
INSERT INTO `sm_audit_log` VALUES ('429', 'contract', '12', '344234234242423', '4', null, '1', '2014-07-17 16:47:20');
INSERT INTO `sm_audit_log` VALUES ('430', 'contract', '12', '344234234242423', '4', null, '1', '2014-07-17 16:47:26');
INSERT INTO `sm_audit_log` VALUES ('431', 'contract', '16', '还不考虑看见了分公司的飞', '4', null, '1', '2014-07-17 16:50:56');
INSERT INTO `sm_audit_log` VALUES ('432', 'contract', '14', '123456wwwww', '4', null, '1', '2014-07-17 16:50:56');
INSERT INTO `sm_audit_log` VALUES ('433', 'recyclebin', '46', '还不考虑看见了分公司的飞', '13', '还原删除数据', '1', '2014-07-17 16:51:10');
INSERT INTO `sm_audit_log` VALUES ('434', 'recyclebin', '47', '还不考虑看见了分公司的飞', '13', '还原删除数据', '1', '2014-07-17 16:51:10');
INSERT INTO `sm_audit_log` VALUES ('435', 'recyclebin', '46', '123456wwwww', '13', '还原删除数据', '1', '2014-07-17 16:51:10');
INSERT INTO `sm_audit_log` VALUES ('436', 'recyclebin', '47', '123456wwwww', '13', '还原删除数据', '1', '2014-07-17 16:51:10');
INSERT INTO `sm_audit_log` VALUES ('437', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 16:52:01');
INSERT INTO `sm_audit_log` VALUES ('438', 'component', '990112', '工作台报表', '1', '增加组件', '1', '2014-07-17 17:00:46');
INSERT INTO `sm_audit_log` VALUES ('439', 'contract', '16', '还不考虑看见了分公司的飞', '2', null, '1', '2014-07-17 17:02:10');
INSERT INTO `sm_audit_log` VALUES ('440', 'role', '14', '2345', '1', '角色增加', '1', '2014-07-17 17:02:14');
INSERT INTO `sm_audit_log` VALUES ('441', 'role', '15', '1234567', '1', '角色增加', '1', '2014-07-17 17:02:34');
INSERT INTO `sm_audit_log` VALUES ('442', 'role', '17', '12345679', '1', '角色增加', '1', '2014-07-17 17:02:57');
INSERT INTO `sm_audit_log` VALUES ('443', 'contract', '16', '还不考虑看见了分公司的飞', '2', null, '1', '2014-07-17 17:03:03');
INSERT INTO `sm_audit_log` VALUES ('444', 'role', '18', '908', '1', '角色增加', '1', '2014-07-17 17:03:14');
INSERT INTO `sm_audit_log` VALUES ('445', 'contract', '16', '还不考虑看见了分公司的飞', '2', null, '1', '2014-07-17 17:04:18');
INSERT INTO `sm_audit_log` VALUES ('446', 'role', '15', '1234567', '4', '角色删除', '1', '2014-07-17 17:04:39');
INSERT INTO `sm_audit_log` VALUES ('447', 'role', '17', '12345679', '4', '角色删除', '1', '2014-07-17 17:04:39');
INSERT INTO `sm_audit_log` VALUES ('448', 'contract', '16', '还不考虑看见了分公司的飞', '4', null, '1', '2014-07-17 17:04:43');
INSERT INTO `sm_audit_log` VALUES ('449', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 17:05:12');
INSERT INTO `sm_audit_log` VALUES ('450', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 17:10:47');
INSERT INTO `sm_audit_log` VALUES ('451', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 17:11:38');
INSERT INTO `sm_audit_log` VALUES ('452', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 17:12:12');
INSERT INTO `sm_audit_log` VALUES ('453', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 17:12:42');
INSERT INTO `sm_audit_log` VALUES ('454', 'role', '6', '理财经理', '2', '角色修改', '1', '2014-07-17 17:13:50');
INSERT INTO `sm_audit_log` VALUES ('455', 'role', '6', '理财经理', '7', '角色授权', '1', '2014-07-17 17:14:21');
INSERT INTO `sm_audit_log` VALUES ('456', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 17:14:24');
INSERT INTO `sm_audit_log` VALUES ('457', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 17:16:37');
INSERT INTO `sm_audit_log` VALUES ('458', 'salesTarget', '4', '成交金额', '1', null, '1', '2014-07-17 17:24:33');
INSERT INTO `sm_audit_log` VALUES ('459', 'lead', '2', '按时大时代', '4', null, '1', '2014-07-17 17:24:54');
INSERT INTO `sm_audit_log` VALUES ('460', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 18:22:13');
INSERT INTO `sm_audit_log` VALUES ('461', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 18:23:26');
INSERT INTO `sm_audit_log` VALUES ('462', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 18:23:53');
INSERT INTO `sm_audit_log` VALUES ('463', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 18:24:27');
INSERT INTO `sm_audit_log` VALUES ('464', 'contract', '14', '140714DQYT001', '2', null, '1', '2014-07-17 18:33:57');
INSERT INTO `sm_audit_log` VALUES ('465', 'customer', '7', '张小飞', '2', null, '1', '2014-07-18 09:59:06');
INSERT INTO `sm_audit_log` VALUES ('466', 'contract', '14', '140714DQYT001', '4', null, '1', '2014-07-18 09:59:41');
INSERT INTO `sm_audit_log` VALUES ('467', 'recyclebin', '52', '140714DQYT001', '13', '还原删除数据', '1', '2014-07-18 10:59:48');
INSERT INTO `sm_audit_log` VALUES ('468', 'contract', '14', '140714DQYT001', '4', null, '1', '2014-07-18 11:00:54');
INSERT INTO `sm_audit_log` VALUES ('469', 'recyclebin', '53', '140714DQYT001', '13', '还原删除数据', '1', '2014-07-18 11:02:38');
INSERT INTO `sm_audit_log` VALUES ('470', 'user', '15', '李华', '7', '用户授权', '1', '2014-07-18 11:51:43');
INSERT INTO `sm_audit_log` VALUES ('471', 'userMessage', '66', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:04');
INSERT INTO `sm_audit_log` VALUES ('472', 'userMessage', '68', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:04');
INSERT INTO `sm_audit_log` VALUES ('473', 'userMessage', '70', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:04');
INSERT INTO `sm_audit_log` VALUES ('474', 'userMessage', '72', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:05');
INSERT INTO `sm_audit_log` VALUES ('475', 'userMessage', '74', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:05');
INSERT INTO `sm_audit_log` VALUES ('476', 'userMessage', '76', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:05');
INSERT INTO `sm_audit_log` VALUES ('477', 'userMessage', '78', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:05');
INSERT INTO `sm_audit_log` VALUES ('478', 'userMessage', '80', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:06');
INSERT INTO `sm_audit_log` VALUES ('479', 'userMessage', '82', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:06');
INSERT INTO `sm_audit_log` VALUES ('480', 'userMessage', '84', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:06');
INSERT INTO `sm_audit_log` VALUES ('481', 'userMessage', '86', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:07');
INSERT INTO `sm_audit_log` VALUES ('482', 'userMessage', '88', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:07');
INSERT INTO `sm_audit_log` VALUES ('483', 'userMessage', '90', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:07');
INSERT INTO `sm_audit_log` VALUES ('484', 'userMessage', '92', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:07');
INSERT INTO `sm_audit_log` VALUES ('485', 'userMessage', '94', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:08');
INSERT INTO `sm_audit_log` VALUES ('486', 'userMessage', '96', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:08');
INSERT INTO `sm_audit_log` VALUES ('487', 'userMessage', '98', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:08');
INSERT INTO `sm_audit_log` VALUES ('488', 'userMessage', '100', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:08');
INSERT INTO `sm_audit_log` VALUES ('489', 'userMessage', '102', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:09');
INSERT INTO `sm_audit_log` VALUES ('490', 'userMessage', '104', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:09');
INSERT INTO `sm_audit_log` VALUES ('491', 'userMessage', '106', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:09');
INSERT INTO `sm_audit_log` VALUES ('492', 'userMessage', '108', '实用硬件防火墙', '1', null, '15', '2014-07-18 11:53:09');
INSERT INTO `sm_audit_log` VALUES ('493', 'user', '6', '刘亦菲', '10', '禁用用户', '1', '2014-07-18 14:30:10');
INSERT INTO `sm_audit_log` VALUES ('494', 'user', '6', '刘亦菲', '9', '启用用户', '1', '2014-07-18 14:32:08');
INSERT INTO `sm_audit_log` VALUES ('495', 'organization', '2', '董事会', '7', '组织授权', '1', '2014-07-18 14:32:50');
INSERT INTO `sm_audit_log` VALUES ('496', 'role', '19', '测试', '1', '角色增加', '1', '2014-07-18 14:49:59');
INSERT INTO `sm_audit_log` VALUES ('497', 'role', '19', '测试', '2', '角色修改', '1', '2014-07-18 14:50:07');
INSERT INTO `sm_audit_log` VALUES ('498', 'role', '14', '2345', '4', '角色删除', '1', '2014-07-18 14:50:28');
INSERT INTO `sm_audit_log` VALUES ('499', 'role', '18', '908', '4', '角色删除', '1', '2014-07-18 14:50:28');
INSERT INTO `sm_audit_log` VALUES ('500', 'role', '19', '测试', '4', '角色删除', '1', '2014-07-18 14:50:28');
INSERT INTO `sm_audit_log` VALUES ('501', 'role', '11', 'IT人员', '4', '角色删除', '1', '2014-07-18 14:53:08');
INSERT INTO `sm_audit_log` VALUES ('502', 'role', '12', '测试人员', '4', '角色删除', '1', '2014-07-18 14:53:08');
INSERT INTO `sm_audit_log` VALUES ('503', 'role', '13', '测试工程师', '4', '角色删除', '1', '2014-07-18 14:53:08');
INSERT INTO `sm_audit_log` VALUES ('504', 'role', '6', '理财经理', '2', '角色修改', '1', '2014-07-18 14:59:51');
INSERT INTO `sm_audit_log` VALUES ('505', 'role', '6', '理财经理', '2', '角色修改', '1', '2014-07-18 15:00:37');
INSERT INTO `sm_audit_log` VALUES ('506', 'role', '6', '理财经理', '2', '角色修改', '1', '2014-07-18 15:01:35');
INSERT INTO `sm_audit_log` VALUES ('507', 'role', '6', '理财经理', '2', '角色修改', '1', '2014-07-18 15:02:04');
INSERT INTO `sm_audit_log` VALUES ('508', 'user', '27', 'liulan', '1', null, '1', '2014-07-18 16:37:33');
INSERT INTO `sm_audit_log` VALUES ('509', 'user', '27', 'liulan', '2', null, '1', '2014-07-18 16:39:03');
INSERT INTO `sm_audit_log` VALUES ('510', 'user', '27', 'liulan', '2', null, '1', '2014-07-18 16:39:26');
INSERT INTO `sm_audit_log` VALUES ('511', 'user', '27', 'liulan', '2', null, '1', '2014-07-18 16:39:41');
INSERT INTO `sm_audit_log` VALUES ('512', 'user', '28', '刘岚1', '1', null, '1', '2014-07-18 16:40:32');
INSERT INTO `sm_audit_log` VALUES ('513', 'user', '28', '刘岚1', '2', null, '1', '2014-07-18 16:40:55');
INSERT INTO `sm_audit_log` VALUES ('514', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-18 16:41:48');
INSERT INTO `sm_audit_log` VALUES ('515', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-18 16:41:55');
INSERT INTO `sm_audit_log` VALUES ('516', 'user', '25', '刘岚', '2', null, '1', '2014-07-18 16:43:27');
INSERT INTO `sm_audit_log` VALUES ('517', 'role', '21', '250', '1', '角色增加', '1', '2014-07-18 16:45:34');
INSERT INTO `sm_audit_log` VALUES ('518', 'role', '21', '250', '2', '角色修改', '1', '2014-07-18 16:45:50');
INSERT INTO `sm_audit_log` VALUES ('519', 'role', '22', '260', '1', '角色增加', '1', '2014-07-18 16:46:09');
INSERT INTO `sm_audit_log` VALUES ('520', 'role', '21', '250', '7', '角色授权', '1', '2014-07-18 16:47:27');
INSERT INTO `sm_audit_log` VALUES ('521', 'role', '21', '250', '7', '角色授权', '1', '2014-07-18 16:47:48');
INSERT INTO `sm_audit_log` VALUES ('522', 'role', '21', '250', '4', '角色删除', '1', '2014-07-18 16:53:58');
INSERT INTO `sm_audit_log` VALUES ('525', 'function', '140119', '123', '1', null, '1', '2014-07-18 17:19:44');
INSERT INTO `sm_audit_log` VALUES ('526', 'function', '140119', '123', '2', null, '1', '2014-07-18 17:20:48');
INSERT INTO `sm_audit_log` VALUES ('529', 'function', '140119', '123', '2', null, '1', '2014-07-18 17:22:09');
INSERT INTO `sm_audit_log` VALUES ('533', 'function', '140119', '123', '2', null, '1', '2014-07-18 17:23:25');
INSERT INTO `sm_audit_log` VALUES ('534', 'function', '140119', '123', '2', null, '1', '2014-07-18 17:23:42');
INSERT INTO `sm_audit_log` VALUES ('536', 'function', '140119', '123', '2', null, '1', '2014-07-18 17:26:47');
INSERT INTO `sm_audit_log` VALUES ('537', 'function', '140126', '123444', '1', null, '1', '2014-07-18 17:27:09');
INSERT INTO `sm_audit_log` VALUES ('538', 'function', '140126', '123444', '2', null, '1', '2014-07-18 17:28:34');
INSERT INTO `sm_audit_log` VALUES ('540', 'function', '140126', '123444', '2', null, '1', '2014-07-18 17:30:03');
INSERT INTO `sm_audit_log` VALUES ('544', 'customer', '3', 'ad撒', '4', null, '1', '2014-07-18 17:55:39');
INSERT INTO `sm_audit_log` VALUES ('545', 'customer', '2', 'a额问问', '4', null, '1', '2014-07-18 17:55:53');
INSERT INTO `sm_audit_log` VALUES ('546', 'customer', '3', 'ad撒', '4', null, '1', '2014-07-18 17:56:07');
INSERT INTO `sm_audit_log` VALUES ('547', 'recyclebin', '61', 'ad撒', '13', '还原删除数据', '1', '2014-07-21 09:18:34');
INSERT INTO `sm_audit_log` VALUES ('548', 'recyclebin', '62', 'ad撒', '13', '还原删除数据', '1', '2014-07-21 09:18:34');
INSERT INTO `sm_audit_log` VALUES ('549', 'recyclebin', '63', 'ad撒', '13', '还原删除数据', '1', '2014-07-21 09:18:34');
INSERT INTO `sm_audit_log` VALUES ('550', 'recyclebin', '61', 'a额问问', '13', '还原删除数据', '1', '2014-07-21 09:18:34');
INSERT INTO `sm_audit_log` VALUES ('551', 'recyclebin', '62', 'a额问问', '13', '还原删除数据', '1', '2014-07-21 09:18:34');
INSERT INTO `sm_audit_log` VALUES ('552', 'recyclebin', '63', 'a额问问', '13', '还原删除数据', '1', '2014-07-21 09:18:34');
INSERT INTO `sm_audit_log` VALUES ('553', 'recyclebin', '61', 'ad撒', '13', '还原删除数据', '1', '2014-07-21 09:18:34');
INSERT INTO `sm_audit_log` VALUES ('554', 'recyclebin', '62', 'ad撒', '13', '还原删除数据', '1', '2014-07-21 09:18:34');
INSERT INTO `sm_audit_log` VALUES ('555', 'recyclebin', '63', 'ad撒', '13', '还原删除数据', '1', '2014-07-21 09:18:34');
INSERT INTO `sm_audit_log` VALUES ('556', 'contract', '14', '140714DQYT001', '4', null, '1', '2014-07-21 09:20:57');
INSERT INTO `sm_audit_log` VALUES ('557', 'lead', '61', '罗晓丽17', '2', null, '1', '2014-07-21 10:31:13');
INSERT INTO `sm_audit_log` VALUES ('558', 'notice', '9', '你好', '1', null, '1', '2014-07-21 10:41:18');
INSERT INTO `sm_audit_log` VALUES ('559', 'notice', '9', '你好', '2', null, '1', '2014-07-21 10:42:44');
INSERT INTO `sm_audit_log` VALUES ('560', 'notice', '8', '我的', '2', null, '1', '2014-07-21 10:43:17');
INSERT INTO `sm_audit_log` VALUES ('561', 'notice', '10', '今天开会', '1', null, '1', '2014-07-21 10:44:16');
INSERT INTO `sm_audit_log` VALUES ('562', 'function', '140137', '测试', '1', null, '1', '2014-07-21 10:56:08');
INSERT INTO `sm_audit_log` VALUES ('564', 'component', '110210', 'ce2', '4', null, '110210', '2014-07-21 11:56:07');
INSERT INTO `sm_audit_log` VALUES ('565', 'component', '990114', '测试组件', '1', '增加组件', '1', '2014-07-21 12:01:11');
INSERT INTO `sm_audit_log` VALUES ('566', 'component', '990115', '23456', '1', '增加组件', '1', '2014-07-21 12:01:58');
INSERT INTO `sm_audit_log` VALUES ('567', 'user', '1', '管理员', '7', '用户授权', '1', '2014-07-21 12:03:26');
INSERT INTO `sm_audit_log` VALUES ('571', 'function', '140143', '54', '1', null, '1', '2014-07-21 12:50:33');
INSERT INTO `sm_audit_log` VALUES ('572', 'user', '12', '陈龙', '4', null, '1', '2014-07-21 13:16:54');
INSERT INTO `sm_audit_log` VALUES ('574', 'function', '140145', '管理员', '1', null, '1', '2014-07-21 13:24:00');
INSERT INTO `sm_audit_log` VALUES ('576', 'function', '140147', 'admin', '1', null, '1', '2014-07-21 13:33:12');
INSERT INTO `sm_audit_log` VALUES ('577', 'function', '140147', 'admin', '4', '功能删除', '1', '2014-07-21 13:34:51');
INSERT INTO `sm_audit_log` VALUES ('578', 'function', '140145', '管理员', '4', '功能删除', '1', '2014-07-21 13:34:58');
INSERT INTO `sm_audit_log` VALUES ('579', 'component', '990116', '爱仕达', '1', '增加组件', '1', '2014-07-21 13:38:37');
INSERT INTO `sm_audit_log` VALUES ('580', 'user', '6', '刘亦菲1', '2', null, '1', '2014-07-21 13:39:42');
INSERT INTO `sm_audit_log` VALUES ('581', 'component', '990117', '3455', '1', '增加组件', '1', '2014-07-21 13:42:28');
INSERT INTO `sm_audit_log` VALUES ('582', 'component', '990117', '3455', '2', '修改组件', '1', '2014-07-21 13:42:40');
INSERT INTO `sm_audit_log` VALUES ('583', 'function', '140148', '·12345', '1', null, '1', '2014-07-21 13:43:27');
INSERT INTO `sm_audit_log` VALUES ('584', 'user', '29', '公告', '1', null, '1', '2014-07-21 13:44:05');
INSERT INTO `sm_audit_log` VALUES ('585', 'component', '990123', '12345', '1', '增加组件', '1', '2014-07-21 13:45:12');
INSERT INTO `sm_audit_log` VALUES ('586', 'component', '990124', '23456', '1', '增加组件', '1', '2014-07-21 13:45:48');
INSERT INTO `sm_audit_log` VALUES ('587', 'component', '990125', '3456', '1', '增加组件', '1', '2014-07-21 13:46:12');
INSERT INTO `sm_audit_log` VALUES ('588', 'component', '990126', '3456', '1', '增加组件', '1', '2014-07-21 13:46:37');
INSERT INTO `sm_audit_log` VALUES ('589', 'component', '990126', '3456', '2', '修改组件', '1', '2014-07-21 13:46:46');
INSERT INTO `sm_audit_log` VALUES ('590', 'component', '990126', '3456', '2', '修改组件', '1', '2014-07-21 13:46:55');
INSERT INTO `sm_audit_log` VALUES ('591', 'function', '140149', '234', '1', null, '1', '2014-07-21 13:47:40');
INSERT INTO `sm_audit_log` VALUES ('592', 'function', '140150', '测试', '1', null, '1', '2014-07-21 13:56:56');
INSERT INTO `sm_audit_log` VALUES ('593', 'component', '990125', '3456', '4', null, '990125', '2014-07-21 13:59:08');
INSERT INTO `sm_audit_log` VALUES ('594', 'component', '990117', '3455', '4', null, '990117', '2014-07-21 13:59:25');
INSERT INTO `sm_audit_log` VALUES ('595', 'user', '1', '管理员', '11', '用户修改密码', '1', '2014-07-21 14:03:17');
INSERT INTO `sm_audit_log` VALUES ('596', 'user', '6', '刘亦菲1', '2', null, '1', '2014-07-21 14:04:29');
INSERT INTO `sm_audit_log` VALUES ('597', 'user', '25', '刘岚', '4', null, '1', '2014-07-21 14:08:17');
INSERT INTO `sm_audit_log` VALUES ('598', 'user', '27', 'liulan', '4', null, '1', '2014-07-21 14:08:17');
INSERT INTO `sm_audit_log` VALUES ('599', 'user', '28', '刘岚1', '4', null, '1', '2014-07-21 14:08:17');
INSERT INTO `sm_audit_log` VALUES ('600', 'user', '30', '刘岚', '1', null, '1', '2014-07-21 14:10:31');
INSERT INTO `sm_audit_log` VALUES ('601', 'user', '30', '刘岚', '2', null, '1', '2014-07-21 14:10:44');
INSERT INTO `sm_audit_log` VALUES ('602', 'user', '30', '刘岚', '10', '禁用用户', '1', '2014-07-21 14:12:05');
INSERT INTO `sm_audit_log` VALUES ('603', 'user', '30', '刘岚', '9', '启用用户', '1', '2014-07-21 14:13:17');
INSERT INTO `sm_audit_log` VALUES ('604', 'user', '32', '刘岚', '1', null, '1', '2014-07-21 14:31:14');
INSERT INTO `sm_audit_log` VALUES ('605', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 14:40:14');
INSERT INTO `sm_audit_log` VALUES ('606', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 14:44:19');
INSERT INTO `sm_audit_log` VALUES ('607', 'user', '33', '兰儿', '1', null, '1', '2014-07-21 14:53:32');
INSERT INTO `sm_audit_log` VALUES ('608', 'user', '33', '兰儿', '9', '启用用户', '1', '2014-07-21 14:53:55');
INSERT INTO `sm_audit_log` VALUES ('609', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 14:54:54');
INSERT INTO `sm_audit_log` VALUES ('610', 'user', '33', '兰儿', '2', null, '1', '2014-07-21 14:55:41');
INSERT INTO `sm_audit_log` VALUES ('611', 'user', '33', '兰儿', '7', '用户授权', '1', '2014-07-21 14:56:57');
INSERT INTO `sm_audit_log` VALUES ('612', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 14:57:13');
INSERT INTO `sm_audit_log` VALUES ('613', 'user', '33', '兰儿', '7', '用户授权', '1', '2014-07-21 14:57:26');
INSERT INTO `sm_audit_log` VALUES ('614', 'user', '33', '兰儿', '7', '用户授权', '1', '2014-07-21 14:57:54');
INSERT INTO `sm_audit_log` VALUES ('615', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 14:59:45');
INSERT INTO `sm_audit_log` VALUES ('616', 'user', '6', '刘亦菲1', '2', null, '1', '2014-07-21 15:00:44');
INSERT INTO `sm_audit_log` VALUES ('617', 'user', '6', '刘亦菲1', '2', null, '1', '2014-07-21 15:01:04');
INSERT INTO `sm_audit_log` VALUES ('618', 'user', '33', '兰儿', '8', '重置密码', '1', '2014-07-21 15:11:30');
INSERT INTO `sm_audit_log` VALUES ('619', 'user', '33', '兰儿', '8', '重置密码', '1', '2014-07-21 15:11:41');
INSERT INTO `sm_audit_log` VALUES ('620', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 15:13:16');
INSERT INTO `sm_audit_log` VALUES ('621', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 15:18:53');
INSERT INTO `sm_audit_log` VALUES ('622', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 15:29:13');
INSERT INTO `sm_audit_log` VALUES ('623', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 15:32:06');
INSERT INTO `sm_audit_log` VALUES ('624', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 15:34:56');
INSERT INTO `sm_audit_log` VALUES ('625', 'user', null, '导出列表选中的数据', '6', '共导出1条数据', '1', '2014-07-21 15:35:39');
INSERT INTO `sm_audit_log` VALUES ('626', 'user', '33', '兰儿', '2', null, '1', '2014-07-21 15:36:32');
INSERT INTO `sm_audit_log` VALUES ('627', 'user', '34', '得得得', '1', null, '1', '2014-07-21 15:37:33');
INSERT INTO `sm_audit_log` VALUES ('628', 'marketActivity', '1', '测试', '1', null, '1', '2014-07-21 15:38:10');
INSERT INTO `sm_audit_log` VALUES ('629', 'user', '34', '得得得', '7', '用户授权', '1', '2014-07-21 15:38:48');
INSERT INTO `sm_audit_log` VALUES ('630', 'user', '34', '得得得', '11', '用户修改密码', '34', '2014-07-21 15:39:19');
INSERT INTO `sm_audit_log` VALUES ('631', 'user', null, '导出列表选中的数据', '6', '共导出22条数据', '1', '2014-07-21 15:39:19');
INSERT INTO `sm_audit_log` VALUES ('632', 'lead', '63', '罗晓丽19', '2', null, '1', '2014-07-21 15:39:50');
INSERT INTO `sm_audit_log` VALUES ('633', 'user', '34', '得得得', '8', '重置密码', '1', '2014-07-21 15:39:55');
INSERT INTO `sm_audit_log` VALUES ('634', 'user', '34', '得得得', '11', '用户修改密码', '34', '2014-07-21 15:42:54');
INSERT INTO `sm_audit_log` VALUES ('635', 'lead', '63', '罗晓丽19', '2', null, '1', '2014-07-21 15:44:51');
INSERT INTO `sm_audit_log` VALUES ('636', 'lead', '63', '罗晓丽19', '2', null, '1', '2014-07-21 15:46:40');
INSERT INTO `sm_audit_log` VALUES ('637', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 15:47:48');
INSERT INTO `sm_audit_log` VALUES ('638', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 15:48:55');
INSERT INTO `sm_audit_log` VALUES ('639', 'user', '6', '刘亦菲1', '7', '用户授权', '1', '2014-07-21 15:52:08');
INSERT INTO `sm_audit_log` VALUES ('640', 'user', '6', '刘亦菲1', '7', '用户授权', '1', '2014-07-21 15:52:29');
INSERT INTO `sm_audit_log` VALUES ('641', 'user', '6', '刘亦菲1', '7', '用户授权', '1', '2014-07-21 15:53:01');
INSERT INTO `sm_audit_log` VALUES ('642', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 15:55:23');
INSERT INTO `sm_audit_log` VALUES ('643', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 15:56:16');
INSERT INTO `sm_audit_log` VALUES ('644', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 15:57:13');
INSERT INTO `sm_audit_log` VALUES ('645', 'organization', '93', 'ceccecee1', '1', '组织增加', '1', '2014-07-21 16:00:33');
INSERT INTO `sm_audit_log` VALUES ('650', 'user', '33', '兰儿', '2', null, '1', '2014-07-21 16:07:26');
INSERT INTO `sm_audit_log` VALUES ('651', 'user', '33', '兰儿1', '2', null, '1', '2014-07-21 16:07:49');
INSERT INTO `sm_audit_log` VALUES ('654', 'function', '140150', '测试', '4', '功能删除', '1', '2014-07-21 16:14:21');
INSERT INTO `sm_audit_log` VALUES ('655', 'function', '140149', '234', '4', '功能删除', '1', '2014-07-21 16:14:21');
INSERT INTO `sm_audit_log` VALUES ('656', 'function', '140148', '·12345', '4', '功能删除', '1', '2014-07-21 16:14:21');
INSERT INTO `sm_audit_log` VALUES ('657', 'function', '140137', '测试', '4', '功能删除', '1', '2014-07-21 16:14:34');
INSERT INTO `sm_audit_log` VALUES ('658', 'function', '140126', '123444', '4', '功能删除', '1', '2014-07-21 16:14:34');
INSERT INTO `sm_audit_log` VALUES ('659', 'function', '140119', '123', '4', '功能删除', '1', '2014-07-21 16:14:34');
INSERT INTO `sm_audit_log` VALUES ('660', 'organization', '94', '浏览', '1', '组织增加', '1', '2014-07-21 16:17:07');
INSERT INTO `sm_audit_log` VALUES ('663', 'organization', '95', '丽丽', '1', '组织增加', '1', '2014-07-21 16:17:56');
INSERT INTO `sm_audit_log` VALUES ('664', 'organization', '96', '90890', '1', '组织增加', '1', '2014-07-21 16:19:22');
INSERT INTO `sm_audit_log` VALUES ('665', 'organization', '3', '监视会', '7', '组织授权', '1', '2014-07-21 16:21:22');
INSERT INTO `sm_audit_log` VALUES ('666', 'organization', '97', '123456', '1', '组织增加', '1', '2014-07-21 16:22:08');
INSERT INTO `sm_audit_log` VALUES ('667', 'organization', '98', '567', '1', '组织增加', '1', '2014-07-21 16:22:25');
INSERT INTO `sm_audit_log` VALUES ('668', 'component', '110208', 'ceshi 11', '4', null, '110208', '2014-07-21 16:22:45');
INSERT INTO `sm_audit_log` VALUES ('669', 'user', '35', '333', '1', null, '1', '2014-07-21 16:25:18');
INSERT INTO `sm_audit_log` VALUES ('670', 'organization', '97', '123456', '4', '组织删除', '1', '2014-07-21 16:29:47');
INSERT INTO `sm_audit_log` VALUES ('671', 'organization', '98', '567', '4', '组织删除', '1', '2014-07-21 16:29:55');
INSERT INTO `sm_audit_log` VALUES ('672', 'component', '110211', 'admin12', '4', null, '1', '2014-07-21 16:32:53');
INSERT INTO `sm_audit_log` VALUES ('673', 'component', '110212', '3443', '4', null, '1', '2014-07-21 16:32:53');
INSERT INTO `sm_audit_log` VALUES ('674', 'organization', '96', '90890', '4', '组织删除', '1', '2014-07-21 16:33:01');
INSERT INTO `sm_audit_log` VALUES ('675', 'component', '990114', '测试组件', '4', null, '1', '2014-07-21 16:33:07');
INSERT INTO `sm_audit_log` VALUES ('676', 'component', '990115', '23456', '4', null, '1', '2014-07-21 16:33:07');
INSERT INTO `sm_audit_log` VALUES ('677', 'component', '990116', '爱仕达', '4', null, '1', '2014-07-21 16:33:07');
INSERT INTO `sm_audit_log` VALUES ('678', 'component', '990123', '12345', '4', null, '1', '2014-07-21 16:33:07');
INSERT INTO `sm_audit_log` VALUES ('679', 'component', '990124', '23456', '4', null, '1', '2014-07-21 16:33:07');
INSERT INTO `sm_audit_log` VALUES ('680', 'organization', '93', 'ceccecee1', '4', '组织删除', '1', '2014-07-21 16:34:47');
INSERT INTO `sm_audit_log` VALUES ('681', 'organization', '94', '浏览', '4', '组织删除', '1', '2014-07-21 16:34:47');
INSERT INTO `sm_audit_log` VALUES ('682', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 16:38:49');
INSERT INTO `sm_audit_log` VALUES ('683', 'user', '15', '李华', '11', '用户修改密码', '15', '2014-07-21 16:41:08');
INSERT INTO `sm_audit_log` VALUES ('685', 'function', '140152', '11', '1', null, '1', '2014-07-21 16:42:13');
INSERT INTO `sm_audit_log` VALUES ('686', 'function', '140152', '11', '2', null, '1', '2014-07-21 16:42:25');
INSERT INTO `sm_audit_log` VALUES ('687', 'function', '140152', '11', '2', null, '1', '2014-07-21 16:42:35');
INSERT INTO `sm_audit_log` VALUES ('688', 'function', '140153', '请求', '1', null, '1', '2014-07-21 16:42:57');
INSERT INTO `sm_audit_log` VALUES ('689', 'notice', '11', '所得税', '1', null, '15', '2014-07-21 16:45:55');
INSERT INTO `sm_audit_log` VALUES ('690', 'notice', '6', '好好好', '2', null, '15', '2014-07-21 16:46:22');
INSERT INTO `sm_audit_log` VALUES ('691', 'notice', '4', '23456', '2', null, '15', '2014-07-21 16:46:53');
INSERT INTO `sm_audit_log` VALUES ('692', 'notice', '4', '23456', '2', null, '15', '2014-07-21 16:47:11');
INSERT INTO `sm_audit_log` VALUES ('693', 'organization', '99', '策划部测测', '1', '组织增加', '1', '2014-07-21 16:53:22');
INSERT INTO `sm_audit_log` VALUES ('694', 'organization', '95', '丽丽', '4', '组织删除', '1', '2014-07-21 16:53:35');
INSERT INTO `sm_audit_log` VALUES ('697', 'recyclebin', '93', '丽丽', '13', '还原删除数据', '1', '2014-07-21 16:53:47');
INSERT INTO `sm_audit_log` VALUES ('698', 'organization', '100', '33', '1', '组织增加', '1', '2014-07-21 16:56:48');
INSERT INTO `sm_audit_log` VALUES ('699', 'organization', '100', '33', '4', '组织删除', '1', '2014-07-21 16:57:05');
INSERT INTO `sm_audit_log` VALUES ('700', 'organization', '99', '策划部测测', '4', '组织删除', '1', '2014-07-21 17:01:17');
INSERT INTO `sm_audit_log` VALUES ('701', 'organization', '101', '123456', '1', '组织增加', '1', '2014-07-21 17:01:56');
INSERT INTO `sm_audit_log` VALUES ('702', 'organization', '95', '丽丽', '4', '组织删除', '1', '2014-07-21 17:02:17');
INSERT INTO `sm_audit_log` VALUES ('703', 'organization', '101', '123456', '4', '组织删除', '1', '2014-07-21 17:02:17');
INSERT INTO `sm_audit_log` VALUES ('704', 'organization', '102', '超人', '1', '组织增加', '1', '2014-07-21 17:05:32');
INSERT INTO `sm_audit_log` VALUES ('708', 'function', '140154', '爱仕达', '1', null, '1', '2014-07-21 17:14:12');
INSERT INTO `sm_audit_log` VALUES ('709', 'organization', '35', '总办', '2', '组织修改', '1', '2014-07-21 17:16:45');
INSERT INTO `sm_audit_log` VALUES ('710', 'organization', '35', '总办', '2', '组织修改', '1', '2014-07-21 17:16:54');
INSERT INTO `sm_audit_log` VALUES ('711', 'lead', null, '导出列表选中的数据', '6', '共导出738条数据', '1', '2014-07-21 17:57:44');
INSERT INTO `sm_audit_log` VALUES ('712', 'lead', null, '导出列表选中的数据', '6', '共导出738条数据', '1', '2014-07-21 17:57:46');
INSERT INTO `sm_audit_log` VALUES ('713', 'contact', null, '导出列表选中的数据', '6', '共导出2条数据', '1', '2014-07-21 18:00:05');
INSERT INTO `sm_audit_log` VALUES ('714', 'supplier', null, '导出列表选中的数据', '6', '共导出4条数据', '1', '2014-07-21 18:01:42');
INSERT INTO `sm_audit_log` VALUES ('715', 'supplier', null, '导出列表选中的数据', '6', '共导出4条数据', '1', '2014-07-21 18:02:33');
INSERT INTO `sm_audit_log` VALUES ('716', 'lead', '75', '罗晓丽32', '2', null, '1', '2014-07-21 18:04:39');
INSERT INTO `sm_audit_log` VALUES ('717', 'function', '140156', '爱仕达', '1', null, '1', '2014-07-21 18:06:20');
INSERT INTO `sm_audit_log` VALUES ('718', 'function', '140156', '爱仕达', '4', '功能删除', '1', '2014-07-21 18:06:45');
INSERT INTO `sm_audit_log` VALUES ('719', 'function', '140154', '爱仕达', '4', '功能删除', '1', '2014-07-21 18:06:49');
INSERT INTO `sm_audit_log` VALUES ('720', 'dictionary', '900019902', '33', '1', '字典增加', '1', '2014-07-21 18:11:27');
INSERT INTO `sm_audit_log` VALUES ('721', 'dictionary', '900019903', '33', '1', '字典增加', '1', '2014-07-21 18:12:33');
INSERT INTO `sm_audit_log` VALUES ('722', 'organization', '36', '投资基金管理', '2', '组织修改', '1', '2014-07-21 18:15:48');
INSERT INTO `sm_audit_log` VALUES ('723', 'lead', '799', 'liulan ', '1', null, '1', '2014-07-21 18:17:08');
INSERT INTO `sm_audit_log` VALUES ('724', 'lead', '800', '12345678', '1', null, '1', '2014-07-21 18:18:03');
INSERT INTO `sm_audit_log` VALUES ('725', 'lead', '800', '12345678', '4', null, '1', '2014-07-21 18:18:48');
INSERT INTO `sm_audit_log` VALUES ('726', 'recyclebin', '99', '爱仕达', '13', '还原删除数据', '1', '2014-07-21 18:20:13');
INSERT INTO `sm_audit_log` VALUES ('727', 'lead', '799', 'liulan ', '2', null, '1', '2014-07-21 18:20:45');
INSERT INTO `sm_audit_log` VALUES ('728', 'lead', '799', 'liulan ', '2', null, '1', '2014-07-21 18:21:09');
INSERT INTO `sm_audit_log` VALUES ('729', 'lead', '799', 'liulan ', '4', null, '1', '2014-07-21 18:23:16');
INSERT INTO `sm_audit_log` VALUES ('730', 'recyclebin', '101', 'liulan ', '13', '还原删除数据', '1', '2014-07-21 18:23:49');
INSERT INTO `sm_audit_log` VALUES ('731', 'recyclebin', '86', '测试组件', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('732', 'recyclebin', '87', '测试组件', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('733', 'recyclebin', '91', '测试组件', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('734', 'recyclebin', '92', '测试组件', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('735', 'recyclebin', '94', '测试组件', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('736', 'recyclebin', '95', '测试组件', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('737', 'recyclebin', '96', '测试组件', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('738', 'recyclebin', '97', '测试组件', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('739', 'recyclebin', '98', '测试组件', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('740', 'recyclebin', '100', '测试组件', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('741', 'recyclebin', '86', '23456', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('742', 'recyclebin', '87', '23456', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('743', 'recyclebin', '91', '23456', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('744', 'recyclebin', '92', '23456', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('745', 'recyclebin', '94', '23456', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('746', 'recyclebin', '95', '23456', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('747', 'recyclebin', '96', '23456', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('748', 'recyclebin', '97', '23456', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('749', 'recyclebin', '98', '23456', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('750', 'recyclebin', '100', '23456', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('751', 'recyclebin', '86', 'ceccecee1', '13', '还原删除数据', '1', '2014-07-21 18:25:58');
INSERT INTO `sm_audit_log` VALUES ('752', 'recyclebin', '87', 'ceccecee1', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('753', 'recyclebin', '91', 'ceccecee1', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('754', 'recyclebin', '92', 'ceccecee1', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('755', 'recyclebin', '94', 'ceccecee1', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('756', 'recyclebin', '95', 'ceccecee1', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('757', 'recyclebin', '96', 'ceccecee1', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('758', 'recyclebin', '97', 'ceccecee1', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('759', 'recyclebin', '98', 'ceccecee1', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('760', 'recyclebin', '100', 'ceccecee1', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('761', 'recyclebin', '86', '浏览', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('762', 'recyclebin', '87', '浏览', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('763', 'recyclebin', '91', '浏览', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('764', 'recyclebin', '92', '浏览', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('765', 'recyclebin', '94', '浏览', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('766', 'recyclebin', '95', '浏览', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('767', 'recyclebin', '96', '浏览', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('768', 'recyclebin', '97', '浏览', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('769', 'recyclebin', '98', '浏览', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('770', 'recyclebin', '100', '浏览', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('771', 'recyclebin', '86', '33', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('772', 'recyclebin', '87', '33', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('773', 'recyclebin', '91', '33', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('774', 'recyclebin', '92', '33', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('775', 'recyclebin', '94', '33', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('776', 'recyclebin', '95', '33', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('777', 'recyclebin', '96', '33', '13', '还原删除数据', '1', '2014-07-21 18:25:59');
INSERT INTO `sm_audit_log` VALUES ('778', 'recyclebin', '97', '33', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('779', 'recyclebin', '98', '33', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('780', 'recyclebin', '100', '33', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('781', 'recyclebin', '86', '策划部测测', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('782', 'recyclebin', '87', '策划部测测', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('783', 'recyclebin', '91', '策划部测测', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('784', 'recyclebin', '92', '策划部测测', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('785', 'recyclebin', '94', '策划部测测', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('786', 'recyclebin', '95', '策划部测测', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('787', 'recyclebin', '96', '策划部测测', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('788', 'recyclebin', '97', '策划部测测', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('789', 'recyclebin', '98', '策划部测测', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('790', 'recyclebin', '100', '策划部测测', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('791', 'recyclebin', '86', '丽丽', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('792', 'recyclebin', '87', '丽丽', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('793', 'recyclebin', '91', '丽丽', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('794', 'recyclebin', '92', '丽丽', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('795', 'recyclebin', '94', '丽丽', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('796', 'recyclebin', '95', '丽丽', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('797', 'recyclebin', '96', '丽丽', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('798', 'recyclebin', '97', '丽丽', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('799', 'recyclebin', '98', '丽丽', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('800', 'recyclebin', '100', '丽丽', '13', '还原删除数据', '1', '2014-07-21 18:26:00');
INSERT INTO `sm_audit_log` VALUES ('801', 'recyclebin', '86', '123456', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('802', 'recyclebin', '87', '123456', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('803', 'recyclebin', '91', '123456', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('804', 'recyclebin', '92', '123456', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('805', 'recyclebin', '94', '123456', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('806', 'recyclebin', '95', '123456', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('807', 'recyclebin', '96', '123456', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('808', 'recyclebin', '97', '123456', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('809', 'recyclebin', '98', '123456', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('810', 'recyclebin', '100', '123456', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('811', 'recyclebin', '86', '爱仕达', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('812', 'recyclebin', '87', '爱仕达', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('813', 'recyclebin', '91', '爱仕达', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('814', 'recyclebin', '92', '爱仕达', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('815', 'recyclebin', '94', '爱仕达', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('816', 'recyclebin', '95', '爱仕达', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('817', 'recyclebin', '96', '爱仕达', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('818', 'recyclebin', '97', '爱仕达', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('819', 'recyclebin', '98', '爱仕达', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('820', 'recyclebin', '100', '爱仕达', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('821', 'recyclebin', '86', '12345678', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('822', 'recyclebin', '87', '12345678', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('823', 'recyclebin', '91', '12345678', '13', '还原删除数据', '1', '2014-07-21 18:26:01');
INSERT INTO `sm_audit_log` VALUES ('824', 'recyclebin', '92', '12345678', '13', '还原删除数据', '1', '2014-07-21 18:26:02');
INSERT INTO `sm_audit_log` VALUES ('825', 'recyclebin', '94', '12345678', '13', '还原删除数据', '1', '2014-07-21 18:26:02');
INSERT INTO `sm_audit_log` VALUES ('826', 'recyclebin', '95', '12345678', '13', '还原删除数据', '1', '2014-07-21 18:26:02');
INSERT INTO `sm_audit_log` VALUES ('827', 'recyclebin', '96', '12345678', '13', '还原删除数据', '1', '2014-07-21 18:26:02');
INSERT INTO `sm_audit_log` VALUES ('828', 'recyclebin', '97', '12345678', '13', '还原删除数据', '1', '2014-07-21 18:26:02');
INSERT INTO `sm_audit_log` VALUES ('829', 'recyclebin', '98', '12345678', '13', '还原删除数据', '1', '2014-07-21 18:26:02');
INSERT INTO `sm_audit_log` VALUES ('830', 'recyclebin', '100', '12345678', '13', '还原删除数据', '1', '2014-07-21 18:26:02');
INSERT INTO `sm_audit_log` VALUES ('831', 'recyclebin', '90', '23456', '13', '还原删除数据', '1', '2014-07-21 18:26:12');
INSERT INTO `sm_audit_log` VALUES ('832', 'recyclebin', '80', 'ceshi 11', '12', '真实删除数据', '1', '2014-07-21 18:34:28');
INSERT INTO `sm_audit_log` VALUES ('833', 'recyclebin', '77', '测试', '12', '真实删除数据', '1', '2014-07-21 18:34:39');
INSERT INTO `sm_audit_log` VALUES ('834', 'recyclebin', '78', '测试', '12', '真实删除数据', '1', '2014-07-21 18:34:39');
INSERT INTO `sm_audit_log` VALUES ('835', 'recyclebin', '77', '123444', '12', '真实删除数据', '1', '2014-07-21 18:34:39');
INSERT INTO `sm_audit_log` VALUES ('836', 'recyclebin', '78', '123444', '12', '真实删除数据', '1', '2014-07-21 18:34:39');
INSERT INTO `sm_audit_log` VALUES ('842', 'supplier', '5', '东北大庆油田集团公司', '2', null, '1', '2014-07-21 19:18:12');
INSERT INTO `sm_audit_log` VALUES ('849', 'supplier', '5', '东北大庆油田集团公司', '2', null, '1', '2014-07-21 19:32:54');
INSERT INTO `sm_audit_log` VALUES ('850', 'supplier', '5', '东北大庆油田集团公司', '2', null, '1', '2014-07-21 19:33:15');
INSERT INTO `sm_audit_log` VALUES ('851', 'lead', '5', '东北大庆油田集团公司', '4', null, '1', '2014-07-21 19:33:33');
INSERT INTO `sm_audit_log` VALUES ('852', 'lead', '5', '东北大庆油田集团公司', '4', null, '1', '2014-07-21 19:33:48');
INSERT INTO `sm_audit_log` VALUES ('853', 'lead', '5', '东北大庆油田集团公司', '4', null, '1', '2014-07-21 19:34:50');
INSERT INTO `sm_audit_log` VALUES ('854', 'lead', '5', '东北大庆油田集团公司', '4', null, '1', '2014-07-21 19:35:03');
INSERT INTO `sm_audit_log` VALUES ('855', 'lead', '5', '东北大庆油田集团公司', '4', null, '1', '2014-07-21 19:41:13');
INSERT INTO `sm_audit_log` VALUES ('856', 'supplier', null, '导出列表选中的数据', '6', '共导出1条数据', '1', '2014-07-21 19:42:10');
INSERT INTO `sm_audit_log` VALUES ('857', 'supplier', null, '导出列表选中的数据', '6', '共导出2条数据', '1', '2014-07-21 19:42:21');
INSERT INTO `sm_audit_log` VALUES ('858', 'project', '1', '东北大庆油田一期', '2', null, '1', '2014-07-21 19:56:20');
INSERT INTO `sm_audit_log` VALUES ('859', 'project', '1', '东北大庆油田一期', '2', null, '1', '2014-07-21 19:56:42');
INSERT INTO `sm_audit_log` VALUES ('860', 'recyclebin', '106', '东北大庆油田集团公司', '13', '还原删除数据', '1', '2014-07-21 19:57:51');
INSERT INTO `sm_audit_log` VALUES ('861', 'recyclebin', '104', '东北大庆油田集团公司', '13', '还原删除数据', '1', '2014-07-21 19:59:01');
INSERT INTO `sm_audit_log` VALUES ('862', 'recyclebin', '105', '东北大庆油田集团公司', '13', '还原删除数据', '1', '2014-07-21 19:59:01');
INSERT INTO `sm_audit_log` VALUES ('863', 'recyclebin', '104', '东北大庆油田集团公司', '13', '还原删除数据', '1', '2014-07-21 19:59:01');
INSERT INTO `sm_audit_log` VALUES ('864', 'recyclebin', '105', '东北大庆油田集团公司', '13', '还原删除数据', '1', '2014-07-21 19:59:01');
INSERT INTO `sm_audit_log` VALUES ('865', 'product', '1', '东北大庆油田一期基金', '4', null, '1', '2014-07-21 20:16:54');
INSERT INTO `sm_audit_log` VALUES ('866', 'product', null, '导出列表选中的数据', '6', '共导出1条数据', '1', '2014-07-21 20:17:03');
INSERT INTO `sm_audit_log` VALUES ('867', 'product', null, '导出列表选中的数据', '6', '共导出1条数据', '1', '2014-07-21 20:17:05');
INSERT INTO `sm_audit_log` VALUES ('868', 'product', null, '导出列表选中的数据', '6', '共导出2条数据', '1', '2014-07-21 20:17:15');
INSERT INTO `sm_audit_log` VALUES ('869', 'product', '1', '东北大庆油田一期基金', '2', null, '1', '2014-07-21 20:18:18');
INSERT INTO `sm_audit_log` VALUES ('870', 'product', '1', '东北大庆油田一期基金78', '2', null, '1', '2014-07-21 20:18:43');
INSERT INTO `sm_audit_log` VALUES ('871', 'product', '2', '东北大庆油田一期二期', '4', null, '1', '2014-07-21 20:19:55');
INSERT INTO `sm_audit_log` VALUES ('872', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 09:44:43');
INSERT INTO `sm_audit_log` VALUES ('873', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 09:46:59');
INSERT INTO `sm_audit_log` VALUES ('874', 'user', '16', '栾瑞松', '8', '重置密码', '1', '2014-07-22 09:48:41');
INSERT INTO `sm_audit_log` VALUES ('875', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 09:48:51');
INSERT INTO `sm_audit_log` VALUES ('876', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 09:51:53');
INSERT INTO `sm_audit_log` VALUES ('877', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 09:52:19');
INSERT INTO `sm_audit_log` VALUES ('878', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 09:54:32');
INSERT INTO `sm_audit_log` VALUES ('879', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 09:56:05');
INSERT INTO `sm_audit_log` VALUES ('880', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 09:56:21');
INSERT INTO `sm_audit_log` VALUES ('881', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 10:03:59');
INSERT INTO `sm_audit_log` VALUES ('882', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 10:04:12');
INSERT INTO `sm_audit_log` VALUES ('883', 'organization', '103', 'dsd', '1', '组织增加', '1', '2014-07-22 10:04:32');
INSERT INTO `sm_audit_log` VALUES ('884', 'organization', '103', 'dsd', '4', '组织删除', '1', '2014-07-22 10:04:43');
INSERT INTO `sm_audit_log` VALUES ('885', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 10:05:54');
INSERT INTO `sm_audit_log` VALUES ('886', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 10:06:24');
INSERT INTO `sm_audit_log` VALUES ('887', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 10:07:28');
INSERT INTO `sm_audit_log` VALUES ('888', 'organization', '102', '超人', '2', '组织修改', '1', '2014-07-22 10:09:08');
INSERT INTO `sm_audit_log` VALUES ('889', 'recyclebin', '108', '东北大庆油田一期二期', '12', '真实删除数据', '1', '2014-07-22 10:17:35');
INSERT INTO `sm_audit_log` VALUES ('890', 'recyclebin', '88', '爱仕达', '12', '真实删除数据', '1', '2014-07-22 10:21:07');
INSERT INTO `sm_audit_log` VALUES ('891', 'recyclebin', '16', 'a额问问', '13', '还原删除数据', '1', '2014-07-22 10:22:01');
INSERT INTO `sm_audit_log` VALUES ('892', 'contract', '17', '140714DQYT001', '1', null, '1', '2014-07-22 10:36:44');
INSERT INTO `sm_audit_log` VALUES ('893', 'order', '3', '还不考虑看见了分公司的飞', '4', '导入订单', '1', '2014-07-22 13:37:00');
INSERT INTO `sm_audit_log` VALUES ('894', 'order', '2', '123456', '4', '导入订单', '1', '2014-07-22 13:37:00');
INSERT INTO `sm_audit_log` VALUES ('895', 'recyclebin', '110', '还不考虑看见了分公司的飞', '13', '还原删除数据', '1', '2014-07-22 13:38:51');
INSERT INTO `sm_audit_log` VALUES ('896', 'recyclebin', '111', '还不考虑看见了分公司的飞', '13', '还原删除数据', '1', '2014-07-22 13:38:51');
INSERT INTO `sm_audit_log` VALUES ('897', 'recyclebin', '110', '123456', '13', '还原删除数据', '1', '2014-07-22 13:38:51');
INSERT INTO `sm_audit_log` VALUES ('898', 'recyclebin', '111', '123456', '13', '还原删除数据', '1', '2014-07-22 13:38:51');
INSERT INTO `sm_audit_log` VALUES ('899', 'order', '2', '123456', '4', '删除订单', '1', '2014-07-22 13:39:12');
INSERT INTO `sm_audit_log` VALUES ('900', 'order', '3', '还不考虑看见了分公司的飞', '4', '删除订单', '1', '2014-07-22 13:39:12');
INSERT INTO `sm_audit_log` VALUES ('901', 'recyclebin', '112', '123456', '13', '还原删除数据', '1', '2014-07-22 13:48:17');
INSERT INTO `sm_audit_log` VALUES ('902', 'recyclebin', '113', '123456', '13', '还原删除数据', '1', '2014-07-22 13:48:17');
INSERT INTO `sm_audit_log` VALUES ('903', 'recyclebin', '112', '还不考虑看见了分公司的飞', '13', '还原删除数据', '1', '2014-07-22 13:48:17');
INSERT INTO `sm_audit_log` VALUES ('904', 'recyclebin', '113', '还不考虑看见了分公司的飞', '13', '还原删除数据', '1', '2014-07-22 13:48:17');
INSERT INTO `sm_audit_log` VALUES ('905', 'order', '2', '123456', '4', '删除订单', '1', '2014-07-22 13:48:26');
INSERT INTO `sm_audit_log` VALUES ('906', 'order', '3', '还不考虑看见了分公司的飞', '4', '删除订单', '1', '2014-07-22 13:48:33');
INSERT INTO `sm_audit_log` VALUES ('907', 'customer', '14', '鹅鹅鹅饿饿', '1', '增加客户', '1', '2014-07-22 13:50:27');
INSERT INTO `sm_audit_log` VALUES ('908', 'customer', '14', '鹅鹅鹅饿饿', '2', '批量更改所有者', '1', '2014-07-22 13:56:00');
INSERT INTO `sm_audit_log` VALUES ('909', 'organization', '100', '33', '4', '组织删除', '1', '2014-07-22 13:57:38');
INSERT INTO `sm_audit_log` VALUES ('910', 'userMessage', '63', 'sa', '4', '删除系统消息', '1', '2014-07-22 14:00:38');
INSERT INTO `sm_audit_log` VALUES ('911', 'organization', '101', '123456', '4', '组织删除', '1', '2014-07-22 14:02:10');
INSERT INTO `sm_audit_log` VALUES ('912', 'recyclebin', '118', '123456', '13', '还原删除数据', '1', '2014-07-22 14:02:23');
INSERT INTO `sm_audit_log` VALUES ('913', 'organization', '101', '123456', '4', '组织删除', '1', '2014-07-22 14:02:38');
INSERT INTO `sm_audit_log` VALUES ('914', 'order', '1', '140714DQYT001', '4', '删除订单', '1', '2014-07-22 14:04:45');
INSERT INTO `sm_audit_log` VALUES ('915', 'recyclebin', '120', '140714DQYT001', '13', '还原删除数据', '1', '2014-07-22 14:04:56');
INSERT INTO `sm_audit_log` VALUES ('916', 'user', '36', '总裁', '1', null, '1', '2014-07-22 14:06:21');
INSERT INTO `sm_audit_log` VALUES ('917', 'user', '37', '副总裁1', '1', null, '1', '2014-07-22 14:07:00');
INSERT INTO `sm_audit_log` VALUES ('918', 'user', '38', '副总裁2', '1', null, '1', '2014-07-22 14:07:29');
INSERT INTO `sm_audit_log` VALUES ('919', 'user', '39', '财务1', '1', null, '1', '2014-07-22 14:08:05');
INSERT INTO `sm_audit_log` VALUES ('920', 'user', '40', '财务2', '1', null, '1', '2014-07-22 14:08:30');
INSERT INTO `sm_audit_log` VALUES ('921', 'recyclebin', '119', '123456', '13', '还原删除数据', '1', '2014-07-22 14:09:09');
INSERT INTO `sm_audit_log` VALUES ('922', 'user', '41', '投资总监1', '1', null, '1', '2014-07-22 14:09:39');
INSERT INTO `sm_audit_log` VALUES ('923', 'user', '42', '投资总监2', '1', null, '1', '2014-07-22 14:10:46');
INSERT INTO `sm_audit_log` VALUES ('924', 'user', '43', '投资经理1', '1', null, '1', '2014-07-22 14:11:18');
INSERT INTO `sm_audit_log` VALUES ('925', 'user', '44', '投资经理2', '1', null, '1', '2014-07-22 14:11:52');
INSERT INTO `sm_audit_log` VALUES ('926', 'user', '45', '理财经理1', '1', null, '1', '2014-07-22 14:12:20');
INSERT INTO `sm_audit_log` VALUES ('927', 'user', '46', '理财经理2', '1', null, '1', '2014-07-22 14:12:43');
INSERT INTO `sm_audit_log` VALUES ('928', 'userMessage', '61', 'dddd', '4', '删除系统消息', '1', '2014-07-22 14:16:50');
INSERT INTO `sm_audit_log` VALUES ('929', 'user', '13', '刘德华', '7', '用户授权', '1', '2014-07-22 14:17:19');
INSERT INTO `sm_audit_log` VALUES ('930', 'recyclebin', '121', 'dddd', '12', '真实删除数据', '1', '2014-07-22 14:17:25');
INSERT INTO `sm_audit_log` VALUES ('931', 'userMessage', '57', 'sa', '4', '删除系统消息', '1', '2014-07-22 14:17:36');
INSERT INTO `sm_audit_log` VALUES ('932', 'user', '13', '刘德华', '7', '用户授权', '1', '2014-07-22 14:18:13');
INSERT INTO `sm_audit_log` VALUES ('933', 'user', '13', '刘德华', '7', '用户授权', '1', '2014-07-22 14:19:30');
INSERT INTO `sm_audit_log` VALUES ('934', 'user', '13', '刘德华', '7', '用户授权', '1', '2014-07-22 14:21:37');
INSERT INTO `sm_audit_log` VALUES ('935', 'userMessage', '51', '你好呀', '4', '删除系统消息', '1', '2014-07-22 14:24:23');
INSERT INTO `sm_audit_log` VALUES ('936', 'userMessage', '55', '你好呀', '4', '删除系统消息', '1', '2014-07-22 14:25:12');
INSERT INTO `sm_audit_log` VALUES ('937', 'user', '36', '总裁', '7', '用户授权', '1', '2014-07-22 14:38:11');
INSERT INTO `sm_audit_log` VALUES ('938', 'user', '37', '副总裁1', '7', '用户授权', '1', '2014-07-22 14:38:25');
INSERT INTO `sm_audit_log` VALUES ('939', 'user', '38', '副总裁2', '7', '用户授权', '1', '2014-07-22 14:38:38');
INSERT INTO `sm_audit_log` VALUES ('940', 'user', '39', '财务1', '7', '用户授权', '1', '2014-07-22 14:39:01');
INSERT INTO `sm_audit_log` VALUES ('941', 'user', '40', '财务2', '7', '用户授权', '1', '2014-07-22 14:39:10');
INSERT INTO `sm_audit_log` VALUES ('942', 'user', '41', '投资总监1', '7', '用户授权', '1', '2014-07-22 14:39:42');
INSERT INTO `sm_audit_log` VALUES ('943', 'user', '42', '投资总监2', '7', '用户授权', '1', '2014-07-22 14:40:34');
INSERT INTO `sm_audit_log` VALUES ('944', 'user', '43', '投资经理1', '7', '用户授权', '1', '2014-07-22 14:40:43');
INSERT INTO `sm_audit_log` VALUES ('945', 'user', '44', '投资经理2', '7', '用户授权', '1', '2014-07-22 14:40:53');
INSERT INTO `sm_audit_log` VALUES ('946', 'user', '45', '理财经理1', '7', '用户授权', '1', '2014-07-22 14:41:03');
INSERT INTO `sm_audit_log` VALUES ('947', 'user', '46', '理财经理2', '7', '用户授权', '1', '2014-07-22 14:41:11');
INSERT INTO `sm_audit_log` VALUES ('948', 'user', '13', '刘德华', '2', null, '1', '2014-07-22 14:45:14');
INSERT INTO `sm_audit_log` VALUES ('949', 'user', '13', '刘德华', '7', '用户授权', '1', '2014-07-22 14:46:50');
INSERT INTO `sm_audit_log` VALUES ('950', 'role', '22', '260', '4', '角色删除', '1', '2014-07-22 21:15:04');
INSERT INTO `sm_audit_log` VALUES ('951', 'role', '9999', '订单测试角色', '7', '角色授权', '1', '2014-07-22 21:15:15');
INSERT INTO `sm_component` VALUES ('1', '001', '省市区三级联动', '/common/pcas/getChildren.docomp', '请问士大夫', '1060101', '1', '1', '1', '2014-06-17 00:00:00', '1', '2014-06-19 14:57:12');
INSERT INTO `sm_component` VALUES ('2', '003', '查询组件联系纪要', '/common/memoir/query.do', '查询组件联系纪要', '1060103', '0', '1', '1', '2014-06-19 00:00:00', '1', '2014-06-19 00:00:00');
INSERT INTO `sm_component` VALUES ('3', '002', '新增联系纪要', '/common/memoir/add.docomp', '新增联系纪要', '1060103', '0', '1', '1', '2014-06-19 00:00:00', '1', '2014-06-19 00:00:00');
INSERT INTO `sm_component` VALUES ('4', '004', '编辑联系纪要', '/common/memoir/modify.docomp', '查看联系纪要', '1060103', '0', '1', '1', '2014-05-30 16:09:57', '1', '2014-06-19 14:57:00');
INSERT INTO `sm_component` VALUES ('5', '005', '查看联系纪要', '/common/memoir/view.docomp', '查看联系纪要', '1060103', '1', '1', '1', '2014-05-30 16:11:08', '1', '2014-06-19 15:00:29');
INSERT INTO `sm_component` VALUES ('6', '006', '省市区三级联动获取根', '/common/pcas/getRoot.docomp', '', '1060101', '0', '1', '1', '2014-06-04 00:00:00', '1', '2014-06-10 14:47:26');
INSERT INTO `sm_component` VALUES ('101', '000101', '唯一性验证', '/common/common/unique.docomp', '', '1060101', '0', '1', '1', '2014-01-01 00:00:00', '1', '2014-07-21 18:26:04');
INSERT INTO `sm_component` VALUES ('90001', '090001', '查找分组类型', '/common/report/findGroupType.docomp', '查找分组类型通过模块名称和字段名称', '1060102', '0', '1', '1', '2014-01-01 00:00:00', '1', '2014-01-01 00:00:00');
INSERT INTO `sm_component` VALUES ('110204', '007', '项目列表组件', '/project/project/toQueryPage.comp', '项目列表组件', '1060101', '0', '1', '1', '2014-06-10 00:00:00', '1', '2014-06-10 00:00:00');
INSERT INTO `sm_component` VALUES ('110205', '1222', '无法认同', '爱仕达f', ' 等方式', '1060101', '0', '1', '1', '2014-06-14 00:00:00', '1', '2014-06-19 14:57:05');
INSERT INTO `sm_component` VALUES ('110206', '0200', '线索名称', '/workbanch/toViewPage.do', 'FDASF', '1060101', '0', '1', '1', '2014-06-19 00:00:00', '1', '2014-06-19 00:00:00');
INSERT INTO `sm_component` VALUES ('110207', '008', '产品组件', '/project/product/toQueryPage.comp', '', '1060101', '0', '1', '1', '2014-07-01 09:35:35', '1', '2014-07-01 09:35:38');
INSERT INTO `sm_component` VALUES ('110210', 'ce2', 'ce2', 'ce2', '', '1060101', '1', '0', '1', '2014-07-02 00:00:00', '1', '2014-07-21 11:56:12');
INSERT INTO `sm_component` VALUES ('110211', '1335121', 'admin12', '/test/test/view.do', '', '1060101', '1', '0', '1', '2014-07-08 00:00:00', '1', '2014-07-21 16:33:27');
INSERT INTO `sm_component` VALUES ('110212', '4343434343', '3443', '/common/attggach/view.do', '', '1060102', '1', '0', '1', '2014-07-08 00:00:00', '1', '2014-07-21 16:33:27');
INSERT INTO `sm_component` VALUES ('110213', '009', '工作台位置记忆', '/workbanch/modifyOrder.do', '', '1060101', '0', '1', '1', '2014-07-09 00:00:00', '1', '2014-07-21 16:23:40');
INSERT INTO `sm_component` VALUES ('110214', '010', '工作台删除', '/workbanch/delete.do', '', '1060101', '0', '1', '1', '2014-07-09 00:00:00', '1', '2014-07-21 16:23:42');
INSERT INTO `sm_component` VALUES ('990110', '990110', '查找模块字段', '/common/module/findModuleFields.docomp', '查找模块字段通过模块主键编号', '1060102', '0', '1', '1', '2014-01-01 00:00:00', '1', '2014-01-01 00:00:00');
INSERT INTO `sm_component` VALUES ('990111', '012', '工作台添加', '/workbanch/add.do', '', '1060101', '0', '1', '1', '2014-07-14 21:30:39', '1', '2014-07-14 21:30:40');
INSERT INTO `sm_component` VALUES ('990112', '049', '工作台报表', '/common/report/reportWorkbanch.comp', '', '1060101', '0', '1', '1', '2014-07-17 17:00:46', '1', '2014-07-21 16:23:44');
INSERT INTO `sm_component` VALUES ('990114', '123456', '测试组件', '公公给', '123456', '1060101', '0', '0', '1', '2014-07-21 12:01:11', '1', '2014-07-21 18:26:04');
INSERT INTO `sm_component` VALUES ('990115', '2345', '23456', '345', '', '1060101', '0', '0', '1', '2014-07-21 12:01:58', '1', '2014-07-21 18:26:04');
INSERT INTO `sm_component` VALUES ('990117', '23456', '3455', '34567', '', '1060103', '1', '0', '1', '2014-07-21 13:42:40', '1', '2014-07-21 13:59:30');
INSERT INTO `sm_component` VALUES ('990123', '678', '12345', '345', '', '1060101', '1', '0', '1', '2014-07-21 13:45:12', '1', '2014-07-21 16:33:41');
INSERT INTO `sm_component` VALUES ('990124', '567', '23456', '245', '', '1060102', '0', '0', '1', '2014-07-21 13:45:47', '1', '2014-07-21 18:26:17');
INSERT INTO `sm_component` VALUES ('990125', '780', '3456', '5678', '', '1060101', '1', '0', '1', '2014-07-21 13:46:12', '1', '2014-07-21 13:59:13');
INSERT INTO `sm_component` VALUES ('990126', '009856', '3456', '567', '', '1060103', '0', '0', '1', '2014-07-21 13:46:55', '1', '2014-07-21 13:46:55');
INSERT INTO `sm_dictionary` VALUES ('1', '打开方式', '01', '1030101', null, '0', '显示位置', '1', '', '1', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('2', '显示位置', '02', null, null, null, null, '1', '', '0', '1', '1', '2014-06-06 13:34:20', '1', '2014-06-19 14:23:56');
INSERT INTO `sm_dictionary` VALUES ('3', '机构类型', '03', null, null, null, null, '1', '', '0', '1', '1', '2014-06-06 13:35:25', '1', '2014-06-06 13:36:14');
INSERT INTO `sm_dictionary` VALUES ('5', '2年期标准型', '011010214', '11010208', null, null, '产品类型', '1', '', '0', '1', '1', '2014-07-14 17:13:14', '1', '2014-07-14 17:14:08');
INSERT INTO `sm_dictionary` VALUES ('6', '2.5年期标准型', '011010215', '11010208', null, null, '产品类型', '1', '', '0', '1', '1', '2014-07-14 17:15:40', '1', '2014-07-14 17:15:47');
INSERT INTO `sm_dictionary` VALUES ('10201', '打开方式', '010201', null, null, '0', null, '1', '用户菜单打开方式', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-06-19 14:24:06');
INSERT INTO `sm_dictionary` VALUES ('10202', '显示位置', '010202', null, '0', '0', null, '1', '菜单显示位置', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02');
INSERT INTO `sm_dictionary` VALUES ('10301', '类型', '010301', null, '0', '0', null, '1', '组织类型', '1', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02');
INSERT INTO `sm_dictionary` VALUES ('10401', '类型', '010401', null, '0', '0', null, '1', '用户类型', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02');
INSERT INTO `sm_dictionary` VALUES ('10403', '工作状态', '010403', null, '0', '0', null, '1', '用户工作状态', '1', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('10404', '数据存储状态', '010404', null, '0', '0', null, '1', '用户数据存储状态', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('10501', '角色类型', '010501', null, '0', '0', null, '1', '角色类型', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('10601', '权限级别', '010601', null, '0', '0', null, '1', '功能权限级别', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-06-04 10:59:39');
INSERT INTO `sm_dictionary` VALUES ('30101', '活动类型', '030101', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-27 10:50:08', '1', '2014-05-27 10:50:08');
INSERT INTO `sm_dictionary` VALUES ('30102', '活动状态', '030102', null, '0', '0', null, '1', '', '0', '1', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52');
INSERT INTO `sm_dictionary` VALUES ('40101', '线索来源', '040101', null, '0', '0', null, '1', '线索来源', '0', '1', '1', '2014-05-29 10:10:48', '1', '2014-05-29 10:10:38');
INSERT INTO `sm_dictionary` VALUES ('40102', '线索状态', '040102', null, '0', '0', null, '1', '线索状态', '0', '1', '1', '2014-05-29 10:12:27', '1', '2014-05-29 10:12:16');
INSERT INTO `sm_dictionary` VALUES ('40103', '银行卡类型', '040103', null, '0', '0', null, '1', '证件类型', '0', '1', '1', '2014-05-29 10:13:42', '1', '2014-06-05 16:38:25');
INSERT INTO `sm_dictionary` VALUES ('40201', '支付方式', '040201', null, '0', '0', null, '1', '支付方式', '0', '1', '1', '2014-06-26 16:10:17', '1', '2014-06-26 16:10:10');
INSERT INTO `sm_dictionary` VALUES ('40301', '客户类型', '040301', null, '0', '0', null, '1', '客户类型', '0', '1', '1', '2014-05-27 15:20:19', '1', '2014-05-28 12:36:53');
INSERT INTO `sm_dictionary` VALUES ('40302', '客户来源', '040302', null, '0', '0', null, '1', '客户来源', '0', '1', '1', '2014-05-27 17:16:45', '1', '2014-05-27 17:34:23');
INSERT INTO `sm_dictionary` VALUES ('40303', '证件类型', '040303', null, '0', '0', null, '1', '证件类型', '0', '1', '1', '2014-05-27 17:39:55', '1', '2014-05-27 17:40:02');
INSERT INTO `sm_dictionary` VALUES ('40304', '风险等级', '040304', null, '0', '0', null, '1', '风险等级', '0', '1', '1', '2014-05-27 17:48:08', '1', '2014-05-27 17:48:20');
INSERT INTO `sm_dictionary` VALUES ('40305', '行业', '040305', null, '0', '0', null, '1', '行业', '0', '1', '1', '2014-05-29 10:14:48', '1', '2014-05-29 10:16:08');
INSERT INTO `sm_dictionary` VALUES ('40306', '所有权', '040306', null, '0', '0', null, '1', '所有权', '0', '1', '1', '2014-05-27 18:05:37', '1', '2014-05-27 18:05:43');
INSERT INTO `sm_dictionary` VALUES ('40307', '开户行', '040307', null, '0', '0', null, '1', '开户行', '0', '1', '1', '2014-05-27 18:29:45', '1', '2014-05-27 18:29:50');
INSERT INTO `sm_dictionary` VALUES ('50101', '供应商类型', '050101', null, '0', '0', null, '1', '供应商类型', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-29 10:10:02');
INSERT INTO `sm_dictionary` VALUES ('60101', '投资方式', '060101', null, '0', '0', null, '1', '投资方式', '0', '1', '1', '2014-07-01 10:51:17', '1', '2014-07-01 10:51:17');
INSERT INTO `sm_dictionary` VALUES ('60102', '订单状态', '060102', null, '0', '0', null, '1', '订单状态', '0', '1', '1', '2014-07-01 10:55:02', '1', '2014-07-01 10:55:01');
INSERT INTO `sm_dictionary` VALUES ('60103', '财务审核状态', '060103', null, '0', '0', null, '1', '财务审核状态', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO `sm_dictionary` VALUES ('70101', '赎回方式', '070101', null, '0', '0', null, '1', '赎回方式', '0', '1', '1', '2014-07-14 19:20:02', '1', '2014-07-14 19:20:08');
INSERT INTO `sm_dictionary` VALUES ('80101', '时间单位', '080101', null, '0', '0', '', '1', '时间单位', '0', '1', '1', '2014-07-15 15:14:10', '1', '2014-07-15 15:14:07');
INSERT INTO `sm_dictionary` VALUES ('90001', '报表分组类型', '090001', null, '1', '0', 'report_group', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('90002', '报表聚合类型', '090002', null, '1', '0', 'report_aggregate', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('90003', '报表图表类型', '090003', null, '1', '0', 'report_chart', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('100401', '操作类型', '100401', '0', '0', '0', null, '1', '操作类型', '0', '1', '1', '2014-06-23 18:36:54', '1', '2014-06-23 18:37:07');
INSERT INTO `sm_dictionary` VALUES ('110101', '关联模块', '110101', null, '0', '0', null, '1', '附件关联模块', '0', '1', '1', '2014-05-27 10:29:14', '1', '2014-05-27 10:29:21');
INSERT INTO `sm_dictionary` VALUES ('110102', '附件类型', '110102', null, '0', '0', null, '1', '附件类型', '0', '1', '1', '2014-05-27 10:29:53', '1', '2014-05-27 10:29:50');
INSERT INTO `sm_dictionary` VALUES ('900101', '报表分组', '900101', null, '1', '0', 'report_group', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('990101', '模块类型', '990101', null, '1', '0', 'module_type', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('990201', '流程类型', '990201', null, '1', '0', 'flow_type', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('1020101', '常规的', '01020101', '10201', '0', '0', '菜单打开方式', '1', '用户菜单打开方式', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02');
INSERT INTO `sm_dictionary` VALUES ('1020201', '设置页', '01020201', '10202', '0', '0', '显示位置', '1', '菜单显示位置', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02');
INSERT INTO `sm_dictionary` VALUES ('1020202', '菜单栏', '01020202', '10202', '0', '0', '显示位置', '1', '菜单显示位置', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02');
INSERT INTO `sm_dictionary` VALUES ('1030101', '公司', '01030101', '10301', '0', '0', '机构类型', '1', '组织类型', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02');
INSERT INTO `sm_dictionary` VALUES ('1030102', '部门', '01030102', '10301', '0', '0', '机构类型', '1', '组织类型', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02');
INSERT INTO `sm_dictionary` VALUES ('1030103', '组', '01030103', '10301', '0', '0', '机构类型', '1', '组织类型', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02');
INSERT INTO `sm_dictionary` VALUES ('1040101', '管理员', '01040101', '10401', '0', '0', '用户类型', '1', '用户类型', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('1040102', '常规人员', '01040102', '10401', '0', '0', '用户类型', '1', '用户类型', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('1040301', '在岗', '01040301', '10403', '0', '0', '在岗状态', '1', '用户工作状态', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('1040302', '离岗', '01040302', '10403', '0', '0', '在岗状态', '1', '用户工作状态', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('1040401', '最新的', '01040401', '10404', '0', '0', '数据存储状态', '1', '用户数据存储状态', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('1040402', '延迟的', '01040402', '10404', '0', '0', '数据存储状态', '1', '用户数据存储状态', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('1050101', '常规的', '01050101', '10501', '0', '0', '角色类型', '1', '角色类型', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('1060101', '公共', '01060101', '10601', '0', '0', '权限级别', '1', '功能权限级别', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('1060102', '身份认证', '01060102', '10601', '0', '0', '权限级别', '1', '功能权限级别', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('1060103', '权限认证', '01060103', '10601', '0', '0', '权限级别', '1', '功能权限级别', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('3010101', '交易会', '03010101', '30101', '0', '0', '活动类型', '1', '', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO `sm_dictionary` VALUES ('3010102', 'Web研讨', '03010102', '30101', '0', '0', '活动类型', '1', '', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO `sm_dictionary` VALUES ('3010103', '公开媒体', '03010103', '30101', '0', '0', '活动类型', '1', '', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO `sm_dictionary` VALUES ('3010104', '合作伙伴', '03010104', '30101', '0', '0', '活动类型', '1', '', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO `sm_dictionary` VALUES ('3010105', '广告', '03010105', '30101', '0', '0', '活动类型', '1', '', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO `sm_dictionary` VALUES ('3010106', '电子市场', '03010106', '30101', '0', '0', '活动类型', '1', '', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO `sm_dictionary` VALUES ('3010107', '邮箱', '03010107', '30101', '0', '0', '活动类型', '1', '', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO `sm_dictionary` VALUES ('3010108', '其它', '03010108', '30101', '0', '0', '活动类型', '1', '', '0', '1', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58');
INSERT INTO `sm_dictionary` VALUES ('3010201', '计划中', '03010201', '30102', '0', '0', '活动状态', '1', '', '0', '1', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52');
INSERT INTO `sm_dictionary` VALUES ('3010202', '激活', '03010202', '30102', '0', '0', '活动状态', '1', '', '0', '1', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52');
INSERT INTO `sm_dictionary` VALUES ('3010203', '休眠', '03010203', '30102', '0', '0', '活动状态', '1', '', '0', '1', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52');
INSERT INTO `sm_dictionary` VALUES ('3010204', '完成', '03010204', '30102', '0', '0', '活动状态', '1', '', '0', '1', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52');
INSERT INTO `sm_dictionary` VALUES ('4010101', '市场活动获得', '04010101', '40101', '0', '0', '线索来源', '1', '市场活动获得', '0', '1', '1', '2014-05-29 10:11:36', '1', '2014-05-29 10:15:46');
INSERT INTO `sm_dictionary` VALUES ('4010201', '待跟进', '04010201', '40102', '0', '0', '线索状态', '1', '待跟进', '0', '1', '1', '2014-05-29 10:12:54', '1', '2014-05-29 10:15:49');
INSERT INTO `sm_dictionary` VALUES ('4010301', '借记卡', '04010301', '40103', '0', '0', '银行卡类型', '1', '借记卡', '0', '1', '1', '2014-05-29 10:14:10', '1', '2014-05-29 11:17:02');
INSERT INTO `sm_dictionary` VALUES ('4020101', '银行柜台转账', '04020101', '40201', '0', '0', '支付方式', '1', '银行柜台转账', '0', '1', '1', '2014-06-26 16:11:08', '1', '2014-06-26 16:10:56');
INSERT INTO `sm_dictionary` VALUES ('4020102', 'ATM转账', '04020102', '40201', '0', '0', '支付方式', '1', 'ATM转账', '0', '1', '1', '2014-06-26 16:11:52', '1', '2014-06-26 16:11:40');
INSERT INTO `sm_dictionary` VALUES ('4020103', 'POS转账', '04020103', '40201', '0', '0', '支付方式', '1', 'POS转账', '0', '1', '1', '2014-07-14 16:58:29', '1', '2014-07-14 16:58:38');
INSERT INTO `sm_dictionary` VALUES ('4020104', '网银转账', '04020104', '40201', '0', '0', '支付方式', '1', '网银转账', '0', '1', '1', '2014-07-14 16:59:39', '1', '2014-07-14 16:59:46');
INSERT INTO `sm_dictionary` VALUES ('4030101', '个人客户', '04030101', '40301', '0', '0', '客户类型', '1', '个人客户', '0', '1', '1', '2014-05-27 15:21:24', '1', '2014-05-27 15:21:24');
INSERT INTO `sm_dictionary` VALUES ('4030102', '机构客户', '04030102', '40301', '0', '0', '客户类型', '1', '机构客户', '0', '1', '1', '2014-05-27 15:22:02', '1', '2014-05-27 15:22:01');
INSERT INTO `sm_dictionary` VALUES ('4030201', '直购渠道', '04030201', '40302', '0', '0', '客户来源', '1', '直购渠道', '0', '1', '1', '2014-05-27 17:18:10', '1', '2014-05-28 14:04:26');
INSERT INTO `sm_dictionary` VALUES ('4030202', '合作渠道', '04030202', '40302', '0', '0', '客户来源', '1', '合作渠道', '0', '1', '1', '2014-05-27 17:19:28', '1', '2014-05-28 14:04:29');
INSERT INTO `sm_dictionary` VALUES ('4030203', '内部推荐', '04030203', '40302', '0', '0', '客户来源', '1', '内部推荐', '0', '1', '1', '2014-05-27 17:20:22', '1', '2014-05-29 17:01:06');
INSERT INTO `sm_dictionary` VALUES ('4030204', '直接客户', '04030204', '40302', '0', '0', '客户来源', '1', '直接客户', '0', '1', '1', '2014-05-27 17:21:27', '1', '2014-05-29 17:01:07');
INSERT INTO `sm_dictionary` VALUES ('4030206', '市场活动获得', '04030206', '40302', '0', '0', '客户来源', '1', '市场活动获得', '0', '1', '1', '2014-07-14 16:22:45', '1', '2014-07-14 16:22:52');
INSERT INTO `sm_dictionary` VALUES ('4030301', '身份证', '04030301', '40303', '0', '0', '证件类型', '1', '身份证', '0', '1', '1', '2014-05-27 17:41:26', '1', '2014-05-28 14:05:00');
INSERT INTO `sm_dictionary` VALUES ('4030302', '工作证', '04030302', '40303', '0', '0', '证件类型', '1', '工作证', '0', '1', '1', '2014-05-27 17:42:26', '1', '2014-05-28 14:05:04');
INSERT INTO `sm_dictionary` VALUES ('4030303', '其他', '04030303', '40303', '0', '0', '证件类型', '1', '其他', '0', '1', '1', '2014-05-27 17:43:09', '1', '2014-05-28 14:05:08');
INSERT INTO `sm_dictionary` VALUES ('4030401', '一级', '04030401', '40304', '0', '0', '风险等级', '1', '一级', '0', '1', '1', '2014-05-27 17:49:01', '1', '2014-05-28 14:05:17');
INSERT INTO `sm_dictionary` VALUES ('4030402', '二级', '04030402', '40304', '0', '0', '风险等级', '1', '二级', '0', '1', '2', '2014-05-27 17:49:32', '1', '2014-05-28 14:05:31');
INSERT INTO `sm_dictionary` VALUES ('4030501', '金融', '04030501', '40305', '0', '0', '行业', '1', '金融', '0', '1', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26');
INSERT INTO `sm_dictionary` VALUES ('4030601', '国有', '04030601', '40306', '0', '0', '所有权', '1', '国有', '0', '1', '1', '2014-05-27 18:06:39', '1', '2014-05-28 14:05:23');
INSERT INTO `sm_dictionary` VALUES ('4030602', '私营', '04030602', '40306', '0', '0', '所有权', '1', '私营', '0', '1', '1', '2014-05-29 14:01:39', '1', '2014-05-29 14:01:47');
INSERT INTO `sm_dictionary` VALUES ('4030701', '农行', '04030701', '40307', '0', '0', '开户行', '1', '农行', '0', '1', '1', '2014-05-27 18:30:35', '1', '2014-05-28 14:05:20');
INSERT INTO `sm_dictionary` VALUES ('5010101', '普通供应商', '01050101', '50101', '0', '0', '供应商类型', '1', '供应商类型', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_dictionary` VALUES ('5010102', '非普通供应商', '05010102', '50101', '0', '0', '供应商类型', '1', '供应商类型', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-27 14:20:17');
INSERT INTO `sm_dictionary` VALUES ('6010101', '短期', '06010101', '60101', '0', '0', '投资方式', '1', '短期', '0', '1', '1', '2014-07-01 10:52:09', '1', '2014-07-01 10:52:09');
INSERT INTO `sm_dictionary` VALUES ('6010102', '长期', '06010102', '60101', '0', '0', '投资方式', '1', '长期', '0', '1', '1', '2014-07-01 10:52:46', '1', '2014-07-01 10:52:46');
INSERT INTO `sm_dictionary` VALUES ('6010201', '未审核', '06010201', '60102', '0', '0', '订单状态', '1', '订单状态', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO `sm_dictionary` VALUES ('6010202', '待主管审核', '06010202', '60102', '0', '0', '订单状态', '1', '订单状态', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO `sm_dictionary` VALUES ('6010203', '待总监审核', '06010203', '60102', '0', '0', '订单状态', '1', '订单状态', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO `sm_dictionary` VALUES ('6010204', '审核通过', '06010204', '60102', '0', '0', '订单状态', '1', '订单状态', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO `sm_dictionary` VALUES ('6010301', '未收款', '06010301', '60103', '0', '0', '订单状态', '1', '订单状态', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO `sm_dictionary` VALUES ('6010302', '已收款', '06010302', '60103', '0', '0', '订单状态', '1', '订单状态', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO `sm_dictionary` VALUES ('7010101', '到期赎回', '07010101', '70101', '0', '0', '到期赎回', '1', '到期赎回', '0', '1', '1', '2014-07-14 19:21:23', '1', '2014-07-14 19:21:28');
INSERT INTO `sm_dictionary` VALUES ('8010101', '年度', '08010101', '80101', '1', '0', '时间单位', '1', '时间单位', '0', '1', '1', '2014-07-15 15:15:08', '1', '2014-07-15 15:15:04');
INSERT INTO `sm_dictionary` VALUES ('8010102', '季度', '08010102', '80101', '1', '0', '时间单位', '1', '时间单位', '0', '1', '1', '2014-07-15 15:15:48', '1', '2014-07-15 15:15:44');
INSERT INTO `sm_dictionary` VALUES ('8010103', '月', '08010103', '80101', '1', '0', '时间单位', '1', '时间单位', '0', '1', '1', '2014-07-15 15:16:27', '1', '2014-07-15 15:16:23');
INSERT INTO `sm_dictionary` VALUES ('9000101', '日期', '09000101', '90001', '2', '0', 'report_group_time', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('9000199', '其他', '09000199', '90001', '2', '0', 'report_group_else', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('9000201', '总计', '09000201', '90002', '2', '0', 'report_aggregate', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('9000202', '求和', '09000202', '90002', '2', '0', 'report_aggregate', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('9000203', '平均', '09000203', '90002', '2', '0', 'report_aggregate', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('9000204', '最大', '09000204', '90002', '2', '0', 'report_aggregate', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('9000205', '最小', '09000205', '90002', '2', '0', 'report_aggregate', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('9000301', '饼状图', '09000301', '90003', '2', '0', 'report_chart', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('9000302', '柱状图', '09000302', '90003', '2', '0', 'report_chart', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('9000303', '折线图', '09000303', '90003', '2', '0', 'report_chart', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('10040101', '新增', '10040101', '100401', '0', '0', '操作类型', '1', '新增', '0', '1', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16');
INSERT INTO `sm_dictionary` VALUES ('10040102', '修改', '10040102', '100401', '0', '0', '操作类型', '1', '修改', '0', '1', '1', '2014-06-23 18:39:20', '1', '2014-06-23 18:39:31');
INSERT INTO `sm_dictionary` VALUES ('10040103', '删除', '10040103', '100401', '0', '0', '操作类型', '1', '删除', '0', '1', '1', '2014-06-23 18:39:59', '1', '2014-06-23 18:40:08');
INSERT INTO `sm_dictionary` VALUES ('10040104', '线索转换', '10040104', '100401', '0', '0', '操作类型', '1', '线索转换', '0', '1', '1', '2014-07-02 16:55:17', '1', '2014-07-02 16:55:18');
INSERT INTO `sm_dictionary` VALUES ('10040105', '更改所有者', '10040105', '10040105', '0', '0', '操作类型', '1', '更改所有者', '0', '1', '1', '2014-07-02 17:25:16', '1', '2014-07-02 17:25:16');
INSERT INTO `sm_dictionary` VALUES ('11010101', '供应商', '11010101', '110101', '0', '0', '模块类型', '1', '供应商模块', '0', '1', '1', '2014-05-27 10:30:55', '1', '2014-05-27 10:30:52');
INSERT INTO `sm_dictionary` VALUES ('11010102', '客户', '11010102', '110101', '0', '0', '模块类型', '1', '客户模块', '0', '1', '1', '2014-05-28 13:21:01', '1', '2014-05-28 13:20:54');
INSERT INTO `sm_dictionary` VALUES ('11010103', '线索', '11010103', '110101', '0', '0', '模块类型', '1', '线索模块', '0', '1', '1', '2014-05-28 13:21:37', '1', '2014-05-28 13:21:30');
INSERT INTO `sm_dictionary` VALUES ('11010104', '联系人', '11010104', '110101', '0', '0', '模块类型', '1', '联系人模块', '0', '1', '1', '2014-05-28 13:22:06', '1', '2014-05-28 13:21:59');
INSERT INTO `sm_dictionary` VALUES ('11010105', '合同', '11010105', '110101', '0', '0', '模块类型', '1', '合同模块', '0', '1', '1', '2014-07-15 09:30:15', '1', '2014-07-15 09:30:25');
INSERT INTO `sm_dictionary` VALUES ('11010201', '身份证', '11010201', '110102', '0', '0', '附件类型', '1', '身份证', '0', '1', '1', '2014-05-27 10:31:38', '1', '2014-05-27 10:32:31');
INSERT INTO `sm_dictionary` VALUES ('11010202', '营业执照', '11010202', '110102', '0', '0', '附件类型', '1', '营业执照', '0', '1', '1', '2014-05-27 10:32:26', '1', '2014-05-27 10:32:24');
INSERT INTO `sm_dictionary` VALUES ('11010203', '合同', '11010203', '110102', '0', '0', '附件类型', '1', '合同', '0', '1', '1', '2014-07-15 09:33:21', '1', '2014-07-15 09:33:29');
INSERT INTO `sm_dictionary` VALUES ('11010206', '用户类型', '04', null, null, null, null, '1', '', '0', '1', '1', '2014-06-06 13:36:46', '1', '2014-06-06 13:37:12');
INSERT INTO `sm_dictionary` VALUES ('11010207', '在岗状态', '05', null, null, null, null, '1', '', '0', '1', '1', '2014-06-06 13:37:12', '1', '2014-06-06 13:37:39');
INSERT INTO `sm_dictionary` VALUES ('11010208', '产品类型', '06', null, null, null, null, '1', '', '0', '1', '1', '2014-06-09 16:24:46', '1', '2014-06-09 17:17:31');
INSERT INTO `sm_dictionary` VALUES ('11010209', '期限单位', '07', null, null, null, null, '1', '', '0', '1', '1', '2014-06-09 16:45:47', '1', '2014-06-09 17:17:41');
INSERT INTO `sm_dictionary` VALUES ('11010210', '年', 'year', null, null, null, '期限单位', '1', '', '0', '1', '1', '2014-06-09 16:51:09', '1', '2014-06-09 17:16:21');
INSERT INTO `sm_dictionary` VALUES ('11010211', '月', 'month', null, null, null, '期限单位', '1', '', '0', '1', '1', '2014-06-09 17:17:16', '1', '2014-06-09 17:16:49');
INSERT INTO `sm_dictionary` VALUES ('11010212', '日', 'day', null, null, null, '期限单位', '1', '', '0', '1', '1', '2014-06-09 17:17:32', '1', '2014-06-09 17:17:06');
INSERT INTO `sm_dictionary` VALUES ('11010213', '1年期标准型', '011010213', '11010208', null, null, '产品类型', '1', '', '0', '1', '1', '2014-06-09 17:19:51', '1', '2014-06-09 17:19:25');
INSERT INTO `sm_dictionary` VALUES ('11010214', '性别', '0001', null, null, null, null, '1', '', '0', '1', '1', '2014-06-10 10:52:46', '1', '2014-06-10 10:59:15');
INSERT INTO `sm_dictionary` VALUES ('11010215', '男', '000101', '11010214', null, null, '性别', '1', '', '0', '1', '1', '2014-06-10 10:53:12', '1', '2014-06-10 10:59:48');
INSERT INTO `sm_dictionary` VALUES ('11010216', '女', '000102', '11010214', null, null, '性别', '1', '', '0', '1', '1', '2014-06-10 11:00:36', '1', '2014-06-10 11:00:10');
INSERT INTO `sm_dictionary` VALUES ('11010217', 'ceshi(liu)', '01', '1020101', null, '1', null, '1', '', '0', '1', '1', '2014-06-28 16:44:45', '1', '2014-06-27 16:45:15');
INSERT INTO `sm_dictionary` VALUES ('11010218', 'ceshi(liu)', '01', null, null, '1', null, '1', '', '0', '1', '1', '2014-06-28 16:44:59', '1', '2014-06-27 16:45:29');
INSERT INTO `sm_dictionary` VALUES ('11010219', 'ceshi(liu)', '01', null, null, '1', null, '1', '', '1', '1', '1', '2014-06-28 16:47:21', '1', '2014-06-28 17:00:21');
INSERT INTO `sm_dictionary` VALUES ('90010101', '日期', '90010101', '900101', '2', '0', 'report_group_time', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('99010101', '报表', '99010101', '990101', '2', '0', 'module_type', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('99020101', '订单审批', '99020101', '990201', '2', '0', 'flow_type', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('99020102', '订单赎回', '99020102', '990201', '2', '0', 'flow_type', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('900010101', '年', '0900010101', '9000101', '3', '0', 'report_group_time', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('900010102', '季', '0900010102', '9000101', '3', '0', 'report_group_time', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('900010103', '月', '0900010103', '9000101', '3', '0', 'report_group_time', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('900010104', '周', '0900010104', '9000101', '3', '0', 'report_group_time', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('900010105', '日', '0900010105', '9000101', '3', '0', 'report_group_time', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('900010106', '时', '0900010106', '9000101', '3', '0', 'report_group_time', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('900010107', '分', '0900010107', '9000101', '3', '0', 'report_group_time', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('900010108', '秒', '0900010108', '9000101', '3', '0', 'report_group_time', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_dictionary` VALUES ('900019901', '最细化', '0900019901', '9000199', '3', '0', 'report_group_else', '1', '', '0', '1', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51');
INSERT INTO `sm_function` VALUES ('1', null, '000001', '查询', '/query.do', '', '0', '1060101', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-06-03 15:43:28');
INSERT INTO `sm_function` VALUES ('2', null, '000002', '新增', '/add.do', '', '0', '1060101', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-06-03 15:43:30');
INSERT INTO `sm_function` VALUES ('3', null, '000003', '详情', '/view.do', '', '0', '1060101', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29');
INSERT INTO `sm_function` VALUES ('4', null, '000004', '编辑', '/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45');
INSERT INTO `sm_function` VALUES ('5', null, '000005', '删除', '/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05');
INSERT INTO `sm_function` VALUES ('6', null, '000006', '导出', '/export.do', '', '0', '1060103', '6', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-01 16:24:07');
INSERT INTO `sm_function` VALUES ('22', '17', '2', '联系纪要查询', '/common/memoir/query.do', '', '0', '1060103', null, '1', '1', '2014-05-29 15:03:40', '1', '2014-07-11 17:12:38');
INSERT INTO `sm_function` VALUES ('23', '17', '3', '联系纪要新增', '/common/memoir/add.do', '', '0', '1060103', null, '1', '1', '2014-05-30 10:02:38', '1', '2014-07-11 17:12:41');
INSERT INTO `sm_function` VALUES ('24', '17', '4', '联系纪要编辑', '/common/memoir/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-30 16:07:58', '1', '2014-07-11 17:12:42');
INSERT INTO `sm_function` VALUES ('25', '17', '5', '联系纪要删除', '/common/memoir/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-30 16:08:47', '1', '2014-07-11 17:12:44');
INSERT INTO `sm_function` VALUES ('26', '17', '6', '附件查询', '/contact/attachment/query.do', '', '0', '1060103', null, '1', '1', '2014-06-12 15:46:21', '1', '2014-07-11 17:12:45');
INSERT INTO `sm_function` VALUES ('27', '17', '7', '附件预览', '/contact/attachment/view.do', '', '0', '1060103', null, '1', '1', '2014-06-12 15:46:21', '1', '2014-07-11 17:12:47');
INSERT INTO `sm_function` VALUES ('28', '17', '8', '附件上传', '/contact/attachment/upload.do', '', '0', '1060103', null, '1', '1', '2014-06-24 15:31:05', '1', '2014-07-11 17:12:48');
INSERT INTO `sm_function` VALUES ('29', '17', '9', '附件下载', '/contact/attachment/download.do', '', '0', '1060103', null, '1', '1', '2014-06-24 15:32:06', '1', '2014-07-11 17:12:49');
INSERT INTO `sm_function` VALUES ('30', '17', '10', '附件列表', '/common/attach/query.do', '', '0', '1060103', null, '1', '1', '2014-06-25 13:32:58', '1', '2014-07-11 17:12:51');
INSERT INTO `sm_function` VALUES ('31', '17', '11', '附件预览 ', '/common/attach/view.do', '', '0', '1060103', null, '1', '1', '2014-06-25 13:49:11', '1', '2014-07-11 17:12:52');
INSERT INTO `sm_function` VALUES ('32', '17', '12', '联系纪要查看', '/common/memoir/view.do', '', '0', '1060103', null, '1', '1', '2014-06-25 19:53:40', '1', '2014-07-11 17:12:53');
INSERT INTO `sm_function` VALUES ('33', '1', '020001', '详情', '/workbanch/view.do', '', '0', '1060101', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-19 11:03:25');
INSERT INTO `sm_function` VALUES ('34', '29', '020002', '列表', '/workbanch/query.do', '', '0', '1060103', null, '1', '1', '2014-07-09 15:17:07', '1', '2014-07-19 11:03:09');
INSERT INTO `sm_function` VALUES ('35', '15', '030101', '查询', '/market/marketactivity/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:38:17');
INSERT INTO `sm_function` VALUES ('36', '15', '030102', '新增', '/market/marketactivity/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:38:19');
INSERT INTO `sm_function` VALUES ('37', '15', '030103', '详情', '/market/marketactivity/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:38:21');
INSERT INTO `sm_function` VALUES ('38', '15', '030104', '编辑', '/market/marketactivity/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:38:23');
INSERT INTO `sm_function` VALUES ('39', '15', '030105', '删除', '/market/marketactivity/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:38:25');
INSERT INTO `sm_function` VALUES ('40', '15', '030106', '市场活动导出', '/market/marketactivity/export.do', '', '0', '1060103', '6', '1', '1', '2014-06-25 15:40:02', '1', '2014-07-11 17:38:27');
INSERT INTO `sm_function` VALUES ('41', '16', '040101', '查询', '/customer/lead/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:38:29');
INSERT INTO `sm_function` VALUES ('42', '16', '040102', '新增', '/customer/lead/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:38:31');
INSERT INTO `sm_function` VALUES ('43', '16', '040103', '详情', '/customer/lead/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:38:32');
INSERT INTO `sm_function` VALUES ('44', '16', '040104', '编辑', '/customer/lead/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:38:35');
INSERT INTO `sm_function` VALUES ('45', '16', '040105', '删除', '/customer/lead/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:38:38');
INSERT INTO `sm_function` VALUES ('46', '16', '040106', '修改所有者', '/customer/lead/modifyOwner.do', '', '0', '1060103', null, '1', '1', '2014-06-04 10:01:11', '1', '2014-07-11 17:38:39');
INSERT INTO `sm_function` VALUES ('47', '16', '040107', '线索导出', '/customer/lead/export.do', '', '0', '1060103', '6', '1', '1', '2014-06-18 20:31:35', '1', '2014-07-11 17:38:41');
INSERT INTO `sm_function` VALUES ('48', '16', '040108', '附件列表', '/lead/attachment/query.do', '', '0', '1060103', null, '1', '1', '2014-06-22 16:34:33', '1', '2014-07-11 17:38:43');
INSERT INTO `sm_function` VALUES ('49', '16', '040109', '附件上传', '/lead/attachment/upload.do', '', '0', '1060103', null, '1', '1', '2014-06-22 16:35:39', '1', '2014-07-11 17:38:45');
INSERT INTO `sm_function` VALUES ('50', '16', '040110', '附件预览', '/lead/attachment/view.comp', '', '0', '1060103', null, '1', '1', '2014-06-22 16:37:16', '1', '2014-07-11 17:38:50');
INSERT INTO `sm_function` VALUES ('51', '16', '040111', '附件下载', '/lead/attachment/download.do', '', '0', '1060103', null, '1', '1', '2014-06-22 16:38:30', '1', '2014-07-11 17:38:52');
INSERT INTO `sm_function` VALUES ('52', '16', '040112', '附件删除', '/lead/attachment/delete.do', '', '0', '1060103', null, '1', '1', '2014-06-26 18:40:37', '1', '2014-07-11 17:38:54');
INSERT INTO `sm_function` VALUES ('53', '16', '040113', '线索转换', '/customer/lead/leadConverter.do', '', '0', '1060103', null, '1', '1', '2014-06-25 17:23:50', '1', '2014-07-11 17:38:55');
INSERT INTO `sm_function` VALUES ('54', '17', '040201', '查询', '/customer/contact/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:38:58');
INSERT INTO `sm_function` VALUES ('55', '17', '040202', '新增', '/customer/contact/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:38:59');
INSERT INTO `sm_function` VALUES ('56', '17', '040203', '详情', '/customer/contact/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:39:01');
INSERT INTO `sm_function` VALUES ('57', '17', '040204', '编辑', '/customer/contact/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:39:03');
INSERT INTO `sm_function` VALUES ('58', '17', '040205', '删除', '/customer/contact/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:39:05');
INSERT INTO `sm_function` VALUES ('59', '17', '040206', '联系人导出', '/customer/contact/export.do', '', '0', '1060103', '6', '1', '1', '2014-06-25 15:41:18', '1', '2014-07-11 17:39:07');
INSERT INTO `sm_function` VALUES ('60', '18', '040301', '查询', '/customer/customer/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:39:09');
INSERT INTO `sm_function` VALUES ('61', '18', '040302', '新增', '/customer/customer/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:39:11');
INSERT INTO `sm_function` VALUES ('62', '18', '040303', '详情', '/customer/customer/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:39:13');
INSERT INTO `sm_function` VALUES ('63', '18', '040304', '编辑', '/customer/customer/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:39:15');
INSERT INTO `sm_function` VALUES ('64', '18', '040305', '删除', '/customer/customer/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:39:17');
INSERT INTO `sm_function` VALUES ('65', '18', '040306', '客户导出', '/customer/customer/export.do', '', '0', '1060103', '6', '1', '1', '2014-06-18 20:54:48', '1', '2014-07-11 17:39:19');
INSERT INTO `sm_function` VALUES ('67', '18', '040307', '附件查询', '/customer/attachment/query.do', '', '0', '1060103', null, '1', '1', '2014-06-22 16:34:33', '1', '2014-07-15 15:23:06');
INSERT INTO `sm_function` VALUES ('68', '18', '040308', '附件上传', '/customer/attachment/upload.do', '', '0', '1060103', null, '1', '1', '2014-06-22 16:35:39', '1', '2014-07-11 17:39:23');
INSERT INTO `sm_function` VALUES ('69', '18', '040309', '附件预览', '/customer/attachment/view.comp', '', '0', '1060103', null, '1', '1', '2014-06-22 16:37:16', '1', '2014-07-11 17:39:28');
INSERT INTO `sm_function` VALUES ('70', '18', '040310', '附件下载', '/customer/attachment/download.do', '', '0', '1060103', null, '1', '1', '2014-06-22 16:38:30', '1', '2014-07-11 17:39:52');
INSERT INTO `sm_function` VALUES ('71', '18', '040311', '附件删除', '/customer/attachment/delete.do', '', '0', '1060103', null, '1', '1', '2014-06-27 09:39:53', '1', '2014-07-11 17:39:54');
INSERT INTO `sm_function` VALUES ('72', '19', '050101', '查询', '/project/supplier/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:39:55');
INSERT INTO `sm_function` VALUES ('73', '19', '050102', '新增', '/project/supplier/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:39:57');
INSERT INTO `sm_function` VALUES ('74', '19', '050103', '详情', '/project/supplier/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:39:59');
INSERT INTO `sm_function` VALUES ('75', '19', '050104', '编辑', '/project/supplier/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:00');
INSERT INTO `sm_function` VALUES ('76', '19', '050105', '删除', '/project/supplier/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:02');
INSERT INTO `sm_function` VALUES ('77', '19', '050106', '附件查询', '/supplier/attachment/query.do', '', '0', '1060103', null, '1', '1', '2014-05-27 10:14:03', '1', '2014-07-11 17:40:03');
INSERT INTO `sm_function` VALUES ('78', '19', '050107', '附件上传', '/supplier/attachment/upload.do', '地方官', '0', '1060103', null, '1', '1', '2014-05-27 14:06:48', '1', '2014-07-11 17:40:05');
INSERT INTO `sm_function` VALUES ('79', '19', '050108', '附件预览', '/supplier/attachment/view.comp', '', '0', '1060103', null, '1', '1', '2014-05-27 10:16:13', '1', '2014-07-11 17:40:06');
INSERT INTO `sm_function` VALUES ('80', '19', '050109', '附件下载', '/supplier/attachment/download.do', '', '0', '1060103', null, '1', '1', '2014-05-27 10:17:17', '1', '2014-07-11 17:40:09');
INSERT INTO `sm_function` VALUES ('81', '19', '050110', '供应商导出', '/project/supplier/export.do', '', '0', '1060103', '6', '1', '1', '2014-06-19 14:48:13', '1', '2014-07-11 17:40:15');
INSERT INTO `sm_function` VALUES ('82', '19', '050111', '附件删除', '/supplier/attachment/delete.do', '', '0', '1060103', null, '1', '1', '2014-06-26 19:14:18', '1', '2014-07-11 17:40:17');
INSERT INTO `sm_function` VALUES ('83', '20', '050201', '查询', '/project/project/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:19');
INSERT INTO `sm_function` VALUES ('84', '20', '050202', '新增', '/project/project/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:21');
INSERT INTO `sm_function` VALUES ('85', '20', '050203', '详情', '/project/project/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:22');
INSERT INTO `sm_function` VALUES ('86', '20', '050204', '编辑', '/project/project/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:24');
INSERT INTO `sm_function` VALUES ('87', '20', '050205', '删除', '/project/project/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:26');
INSERT INTO `sm_function` VALUES ('88', '20', '050206', '项目导出', '/project/project/export.do', '', '0', '1060103', '6', '1', '1', '2014-06-26 16:37:17', '1', '2014-07-11 17:40:28');
INSERT INTO `sm_function` VALUES ('89', '21', '050301', '查询', '/project/product/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:30');
INSERT INTO `sm_function` VALUES ('90', '21', '050302', '新增', '/project/product/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:32');
INSERT INTO `sm_function` VALUES ('100', '21', '050303', '详情', '/project/product/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-21 18:26:07');
INSERT INTO `sm_function` VALUES ('101', '21', '050304', '编辑', '/project/product/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-21 18:26:07');
INSERT INTO `sm_function` VALUES ('102', '21', '050305', '删除', '/project/product/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:38');
INSERT INTO `sm_function` VALUES ('103', '21', '050306', '产品导出', '/project/product/export.do', '', '0', '1060103', '6', '1', '1', '2014-06-25 15:42:30', '1', '2014-07-11 17:40:40');
INSERT INTO `sm_function` VALUES ('104', '22', '060101', '查询', '/order/order/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:46');
INSERT INTO `sm_function` VALUES ('105', '22', '060102', '新增', '/order/order/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:48');
INSERT INTO `sm_function` VALUES ('106', '22', '060103', '详情', '/order/order/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:51');
INSERT INTO `sm_function` VALUES ('107', '22', '060104', '编辑', '/order/order/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:53');
INSERT INTO `sm_function` VALUES ('108', '22', '060105', '删除', '/order/order/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:40:55');
INSERT INTO `sm_function` VALUES ('109', '22', '060106', '导出', '/order/order/export.do', '', '0', '1060103', null, '1', '1', '2014-07-01 16:59:44', '1', '2014-07-11 17:40:57');
INSERT INTO `sm_function` VALUES ('110', '23', '060201', '查询', '/order/contract/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-17 16:42:42');
INSERT INTO `sm_function` VALUES ('112', '23', '060202', '新增', '/order/contract/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-17 16:42:46');
INSERT INTO `sm_function` VALUES ('113', '23', '060203', '详情', '/order/contract/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-17 16:42:49');
INSERT INTO `sm_function` VALUES ('114', '23', '060204', '编辑', '/order/contract/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-17 16:42:53');
INSERT INTO `sm_function` VALUES ('115', '23', '060205', '删除', '/order/contract/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-17 16:43:02');
INSERT INTO `sm_function` VALUES ('116', '25', '070201', '查询', null, '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:41:18');
INSERT INTO `sm_function` VALUES ('117', '25', '070202', '新增', null, '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:41:20');
INSERT INTO `sm_function` VALUES ('118', '25', '070203', '详情', null, '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:41:21');
INSERT INTO `sm_function` VALUES ('119', '25', '070204', '编辑', null, '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:41:23');
INSERT INTO `sm_function` VALUES ('120', '25', '070205', '删除', null, '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:41:25');
INSERT INTO `sm_function` VALUES ('121', '26', '080101', '查询', '/sales/salesTarget/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-15 13:35:10');
INSERT INTO `sm_function` VALUES ('122', '26', '080102', '新增', '/sales/salesTarget/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-15 13:35:17');
INSERT INTO `sm_function` VALUES ('123', '26', '080103', '详情', '/sales/salesTarget/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-16 16:01:17');
INSERT INTO `sm_function` VALUES ('124', '26', '080104', '编辑', '/sales/salesTarget/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-16 16:01:17');
INSERT INTO `sm_function` VALUES ('125', '26', '080105', '删除', '/sales/salesTarget/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-16 16:01:19');
INSERT INTO `sm_function` VALUES ('126', '8', '090001', '查询', '/common/report/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-14 10:07:16');
INSERT INTO `sm_function` VALUES ('127', '8', '090002', '新增', '/common/report/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-14 10:07:17');
INSERT INTO `sm_function` VALUES ('128', '8', '090003', '查看', '/common/report/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-14 10:07:17');
INSERT INTO `sm_function` VALUES ('129', '8', '090004', '修改', '/common/report/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-14 10:07:18');
INSERT INTO `sm_function` VALUES ('130', '8', '090005', '删除', '/common/report/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-14 10:07:18');
INSERT INTO `sm_function` VALUES ('131', '8', '090006', '生成报表', '/common/report/generate.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-14 10:07:19');
INSERT INTO `sm_function` VALUES ('132', '27', '100101', '详情', '/system/user/viewSelf.do', '', '0', '1060102', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-16 14:00:01');
INSERT INTO `sm_function` VALUES ('133', '28', '100201', '修改密码', '/system/user/modifyPassword.do', '', '0', '1060102', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-16 14:14:30');
INSERT INTO `sm_function` VALUES ('134', '1', '100301', '详情', '/system/workbench/custom.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:41:59');
INSERT INTO `sm_function` VALUES ('135', '30', '100501', '查询', '/system/message/query.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:01');
INSERT INTO `sm_function` VALUES ('136', '30', '100502', '新增', '/system/message/add.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:02');
INSERT INTO `sm_function` VALUES ('137', '30', '100503', '详情', '/system/message/view.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:08');
INSERT INTO `sm_function` VALUES ('138', '30', '100504', '编辑', '/system/message/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:10');
INSERT INTO `sm_function` VALUES ('139', '30', '100505', '删除', '/system/message/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:12');
INSERT INTO `sm_function` VALUES ('140', '30', '100506', '系统消息导出', '/system/message/export.do', '', '0', '1060103', '6', '1', '1', '2014-06-19 11:40:13', '1', '2014-07-11 17:42:14');
INSERT INTO `sm_function` VALUES ('141', '31', '100601', '查询', '/system/notice/query.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:18');
INSERT INTO `sm_function` VALUES ('142', '31', '100602', '新增', '/system/notice/add.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:21');
INSERT INTO `sm_function` VALUES ('143', '31', '100603', '详情', '/system/notice/view.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:25');
INSERT INTO `sm_function` VALUES ('144', '31', '100604', '编辑', '/system/notice/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:26');
INSERT INTO `sm_function` VALUES ('145', '31', '100605', '删除', '/system/notice/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:28');
INSERT INTO `sm_function` VALUES ('146', '31', '100606', '导入', '/system/notice/import.do', '', '0', '1060103', null, '1', '1', '2014-06-18 19:47:57', '1', '2014-07-11 17:42:30');
INSERT INTO `sm_function` VALUES ('147', '31', '100607', '系统公告导出', '/system/notice/export.do', '', '0', '1060103', '6', '1', '1', '2014-06-18 19:50:14', '1', '2014-07-11 17:42:32');
INSERT INTO `sm_function` VALUES ('148', '44', '100701', '详情', '/system/help/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:42:34');
INSERT INTO `sm_function` VALUES ('149', '32', '110101', '查询', '/system/user/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:42:37');
INSERT INTO `sm_function` VALUES ('150', '32', '110102', '新增', '/system/user/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:42:43');
INSERT INTO `sm_function` VALUES ('151', '32', '110103', '编辑', '/system/user/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:42:47');
INSERT INTO `sm_function` VALUES ('152', '32', '110104', '删除', '/system/user/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:42:49');
INSERT INTO `sm_function` VALUES ('153', '32', '110105', '授权', '/system/user/authorization.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:42:51');
INSERT INTO `sm_function` VALUES ('154', '32', '110106', '重置密码', '/system/user/resetPassword.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:53');
INSERT INTO `sm_function` VALUES ('155', '32', '110107', '启用', '/system/user/enable.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:55');
INSERT INTO `sm_function` VALUES ('156', '32', '110108', '禁用', '/system/user/disable.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:42:58');
INSERT INTO `sm_function` VALUES ('157', '32', '110109', '导入', '/system/user/import.do', '', '0', '1060103', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:43:00');
INSERT INTO `sm_function` VALUES ('158', '9', '10410', '登录', '/login.doself', '', '0', '1060101', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:43:03');
INSERT INTO `sm_function` VALUES ('159', '9', '10411', '注销', '/logout.doself', '', '0', '1060101', null, '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:43:06');
INSERT INTO `sm_function` VALUES ('160', '32', '110112', '用户导出', '/system/user/export.do', '', '0', '1060103', '6', '1', '1', '2014-05-31 00:00:00', '1', '2014-07-11 17:43:09');
INSERT INTO `sm_function` VALUES ('161', '33', '110201', '查询', '/system/role/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:11');
INSERT INTO `sm_function` VALUES ('162', '33', '110202', '新增', '/system/role/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:13');
INSERT INTO `sm_function` VALUES ('163', '33', '110203', '详情', '/system/role/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:15');
INSERT INTO `sm_function` VALUES ('164', '33', '110204', '编辑', '/system/role/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:17');
INSERT INTO `sm_function` VALUES ('165', '33', '110205', '删除', '/system/role/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:19');
INSERT INTO `sm_function` VALUES ('166', '33', '110206', '授权', '/system/role/authorization.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:20');
INSERT INTO `sm_function` VALUES ('167', '34', '110301', '查询', '/system/menu/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:22');
INSERT INTO `sm_function` VALUES ('168', '34', '110302', '新增', '/system/menu/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:25');
INSERT INTO `sm_function` VALUES ('169', '34', '110303', '详情', '/system/menu/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:27');
INSERT INTO `sm_function` VALUES ('170', '34', '110304', '编辑', '/system/menu/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:29');
INSERT INTO `sm_function` VALUES ('171', '34', '110305', '删除', '/system/menu/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:33');
INSERT INTO `sm_function` VALUES ('172', '34', '110306', '移动', '/system/menu/move.doself', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:35');
INSERT INTO `sm_function` VALUES ('173', '35', '110401', '查询', '/system/function/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:37');
INSERT INTO `sm_function` VALUES ('174', '35', '110402', '新增', '/system/function/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:41');
INSERT INTO `sm_function` VALUES ('175', '35', '110403', '详情', '/system/function/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:43');
INSERT INTO `sm_function` VALUES ('176', '35', '110404', '编辑', '/system/function/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:45');
INSERT INTO `sm_function` VALUES ('177', '35', '110405', '删除', '/system/function/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:43:51');
INSERT INTO `sm_function` VALUES ('178', '35', '110406', '首页', '/system/function/index.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:00');
INSERT INTO `sm_function` VALUES ('179', '36', '110501', '查询', '/system/component/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:02');
INSERT INTO `sm_function` VALUES ('180', '36', '110502', '新增', '/system/component/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:05');
INSERT INTO `sm_function` VALUES ('181', '36', '110503', '详情', '/system/component/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:07');
INSERT INTO `sm_function` VALUES ('182', '36', '110504', '编辑', '/system/component/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:09');
INSERT INTO `sm_function` VALUES ('183', '36', '110505', '删除', '/system/component/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:11');
INSERT INTO `sm_function` VALUES ('184', '38', '110601', '权限设置', '/system/authorization.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:13');
INSERT INTO `sm_function` VALUES ('185', '38', '120101', '查询', '/system/organization/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:16');
INSERT INTO `sm_function` VALUES ('186', '38', '120102', '新增', '/system/organization/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:18');
INSERT INTO `sm_function` VALUES ('187', '38', '120103', '详情', '/system/organization/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:20');
INSERT INTO `sm_function` VALUES ('188', '38', '120104', '编辑', '/system/organization/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:21');
INSERT INTO `sm_function` VALUES ('189', '38', '120105', '删除', '/system/organization/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:23');
INSERT INTO `sm_function` VALUES ('190', '38', '120106', '授权', '/system/organization/authorization.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:26');
INSERT INTO `sm_function` VALUES ('191', '38', '120107', '移动', '/system/organization/move.doself', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:28');
INSERT INTO `sm_function` VALUES ('192', '39', '130101', '查询', '/system/dictionary/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:31');
INSERT INTO `sm_function` VALUES ('193', '39', '130102', '新增', '/system/dictionary/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:33');
INSERT INTO `sm_function` VALUES ('194', '39', '130103', '详情', '/system/dictionary/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:35');
INSERT INTO `sm_function` VALUES ('195', '39', '130104', '编辑', '/system/dictionary/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:40');
INSERT INTO `sm_function` VALUES ('196', '39', '130105', '删除', '/system/dictionary/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:43');
INSERT INTO `sm_function` VALUES ('197', '40', '130201', '详情', '/system/data/export.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:45');
INSERT INTO `sm_function` VALUES ('198', '41', '130301', '查询', '/system/recyclebin/query.do', '', '0', '1060103', null, '1', '1', '2014-06-26 11:09:36', '1', '2014-07-11 17:44:49');
INSERT INTO `sm_function` VALUES ('199', '41', '130302', '删除', '/system/recyclebin/delete.do', '', '0', '1060103', null, '1', '1', '2014-06-26 11:10:30', '1', '2014-07-11 17:44:51');
INSERT INTO `sm_function` VALUES ('200', '41', '130303', '恢复', '/system/recyclebin/recovery.do', '', '0', '1060103', null, '1', '1', '2014-06-26 11:11:14', '1', '2014-07-11 17:44:53');
INSERT INTO `sm_function` VALUES ('201', '42', '130401', '查询', '/system/auditlog/query.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:56');
INSERT INTO `sm_function` VALUES ('202', '42', '130402', '新增', '/system/auditlog/add.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:44:59');
INSERT INTO `sm_function` VALUES ('203', '42', '130403', '详情', '/system/auditlog/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:45:01');
INSERT INTO `sm_function` VALUES ('204', '42', '130404', '编辑', '/system/auditlog/modify.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:45:04');
INSERT INTO `sm_function` VALUES ('205', '42', '130405', '删除', '/system/auditlog/delete.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:45:06');
INSERT INTO `sm_function` VALUES ('206', '43', '140101', '详情', '/system/developer/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-11 17:45:11');
INSERT INTO `sm_function` VALUES ('207', '40', '024568', 'ceshi 1', '/service/doPost', '', '0', '1060101', null, '0', '1', '2014-07-02 13:18:41', '1', '2014-07-11 17:45:13');
INSERT INTO `sm_function` VALUES ('208', '45', '1335', '详情', '/test/test/view.do', '', '0', '1060103', null, '0', '1', '2014-07-04 11:55:10', '1', '2014-07-11 17:45:15');
INSERT INTO `sm_function` VALUES ('209', '16', '040114', '线索导入', '/common/imports/import.do', '', '0', '1060103', null, '1', '1', '2014-07-14 10:05:18', '1', '2014-07-14 10:48:19');
INSERT INTO `sm_function` VALUES ('210', '23', '060206', '合同导出', '/order/contract/export.do', '', '0', '1060103', null, '1', '1', '2014-07-15 14:47:05', '1', '2014-07-17 16:43:17');
INSERT INTO `sm_function` VALUES ('211', '23', '060207', '附件查询', '/contract/attachment/query.do', '', '0', '1060103', null, '1', '1', '2014-06-22 16:34:33', '1', '2014-07-17 16:43:21');
INSERT INTO `sm_function` VALUES ('212', '23', '060208', '附件上传', '/contract/attachment/upload.do', '', '0', '1060103', null, '1', '1', '2014-06-22 16:35:39', '1', '2014-07-17 16:43:24');
INSERT INTO `sm_function` VALUES ('213', '23', '060209', '附件预览', '/contract/attachment/view.comp', '', '0', '1060103', null, '1', '1', '2014-06-22 16:37:16', '1', '2014-07-17 16:43:27');
INSERT INTO `sm_function` VALUES ('214', '23', '060210', '附件下载', '/contract/attachment/download.do', '', '0', '1060103', null, '1', '1', '2014-06-22 16:38:30', '1', '2014-07-17 16:43:29');
INSERT INTO `sm_function` VALUES ('215', '23', '060211', '附件删除', '/contract/attachment/delete.do', '', '0', '1060103', null, '1', '1', '2014-06-27 09:39:53', '1', '2014-07-17 16:43:35');
INSERT INTO `sm_function` VALUES ('216', '22', '060107', '查询未被关联订单', '/order/order/queryList.do', '', '0', '1060103', null, '1', '1', '2014-07-17 15:33:54', '1', '2014-07-17 16:43:42');
INSERT INTO `sm_function` VALUES ('140111', '32', '110113', '查看', '/system/user/view.do', '', '0', '1060103', null, '1', '1', '2014-05-26 00:00:00', '1', '2014-07-16 14:29:04');
INSERT INTO `sm_function` VALUES ('140112', '26', '080106', '导出', '/sales/salesTarget/export.do', '', '0', '1060103', null, '1', '1', '2014-07-16 17:19:58', '1', '2014-07-16 17:19:58');
INSERT INTO `sm_function` VALUES ('140113', '22', '20140716001', '发送审批', '/common/approve/send.do', '订单详情页发送审批流程', '0', '1060103', null, '0', '1', '2014-07-16 21:03:03', '1', '2014-07-16 21:42:42');
INSERT INTO `sm_function` VALUES ('140115', '22', '060108', '启动审批', '/order/order/startApprove.do', '', '0', '1060102', null, '1', '1', '2014-07-17 15:33:54', '1', '2014-07-17 16:43:42');
INSERT INTO `sm_function` VALUES ('140116', '22', '060109', '执行审批', '/order/order/executeApprove.do', '', '0', '1060102', null, '1', '1', '2014-07-17 15:33:54', '1', '2014-07-17 16:43:42');
INSERT INTO `sm_function` VALUES ('140119', '1', '123456', '123', '123', '我的工作台1236', '1', '1060101', null, '0', '1', '2014-07-18 17:19:44', '1', '2014-07-21 16:15:08');
INSERT INTO `sm_function` VALUES ('140145', '15', '3123', '管理员', '/test/test/vi2ew.do', '', '1', '1060101', null, '0', '1', '2014-07-21 13:24:00', '1', '2014-07-21 13:35:21');
INSERT INTO `sm_function` VALUES ('140147', null, '1235456', 'admin', '/test/test/vie4w.do', '', '1', '1060102', null, '0', '1', '2014-07-21 13:33:09', '1', '2014-07-21 13:35:14');
INSERT INTO `sm_function` VALUES ('140148', '1', '34567', '·12345', '12345', '', '1', '1060102', null, '0', '1', '2014-07-21 13:43:27', '1', '2014-07-21 16:14:55');
INSERT INTO `sm_function` VALUES ('140149', '1', '890', '234', '89000', '', '1', '1060101', null, '0', '1', '2014-07-21 13:47:40', '1', '2014-07-21 16:14:55');
INSERT INTO `sm_function` VALUES ('140150', '1', '123', '测试', '4567', '', '1', '1060101', null, '0', '1', '2014-07-21 13:56:56', '1', '2014-07-21 16:14:55');
INSERT INTO `sm_function` VALUES ('140152', '1', '111qq', '11', '1', '', '0', '1060101', null, '0', '1', '2014-07-21 16:42:13', '1', '2014-07-21 16:42:34');
INSERT INTO `sm_function` VALUES ('140153', '18', 'QQ群', '请求', '请求', '', '0', '1060103', null, '0', '1', '2014-07-21 16:42:57', '1', '2014-07-21 16:42:57');
INSERT INTO `sm_function` VALUES ('140154', '3', '31413541341', '爱仕达', '爱仕达', '', '0', '1060101', null, '0', '1', '2014-07-21 17:14:11', '1', '2014-07-21 18:20:18');
INSERT INTO `sm_function` VALUES ('140156', '3', '123445151223123123', '爱仕达', '/common/pcas/getChildren.docomp', '', '0', '1060102', null, '0', '1', '2014-07-21 18:06:20', '1', '2014-07-21 18:26:07');
INSERT INTO `sm_menu` VALUES ('1', '工作台', '/workbanch/toViewPage.do', '1', '1', '33', '1', '1', '1', null, '20000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-21 14:51:00');
INSERT INTO `sm_menu` VALUES ('2', '市场营销', null, '1', '0', null, '1', '1', '0', null, '40000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('3', '客户管理', null, '1', '0', null, '1', '1', '0', null, '30000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('4', '项目管理', null, '1', '0', null, '1', '1', '0', null, '50000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('5', '订单管理', null, '1', '0', null, '1', '1', '0', null, '60000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('6', '财务管理', null, '1', '0', null, '1', '1', '0', null, '70000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('7', '销售管理', null, '1', '0', null, '1', '1', '0', null, '80000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('8', '报表管理', '/common/report/toQueryPage.do', '1', '0', '126', '1', '1', '1', null, '90000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('9', '个人设置', '', '2', '0', null, '1', '1', '0', null, '100000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('10', '用户及权限', null, '2', '0', null, '1', '1', '0', null, '110000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('11', '机构设置', null, '2', '0', null, '1', '1', '0', null, '120000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('12', '数据管理', '', '2', '0', null, '1', '1', '0', null, '130000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('13', '开发者空间', '', '2', '0', null, '1', '1', '0', null, '140000', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('14', '帮助', '', '2', '0', null, '1', '1', '0', null, '150000', '', '0', '1', '1', '2014-07-01 17:39:20', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('15', '市场活动', '/market/marketactivity/toQueryPage.do', '1', '0', '35', '1', '2', '1', '2', '40100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('16', '线索', '/customer/lead/toQueryPage.do', '1', '0', '41', '1', '2', '1', '3', '30100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-21 13:14:10');
INSERT INTO `sm_menu` VALUES ('17', '联系人', '/customer/contact/toQueryPage.do', '1', '0', '54', '1', '2', '1', '3', '30100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-21 13:14:10');
INSERT INTO `sm_menu` VALUES ('18', '客户', '/customer/customer/toQueryPage.do', '1', '0', '60', '1', '2', '1', '3', '30300', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('19', '供应商', '/project/supplier/toQueryPage.do', '1', '0', '72', '1', '2', '1', '4', '50100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('20', '项目', '/project/project/toQueryPage.do', '1', '0', '83', '1', '2', '1', '4', '50200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('21', '产品', null, '1', '0', '89', '1', '2', '1', '4', '50300', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('22', '订单', '/order/order/toQueryPage.do', '1', '0', '104', '1', '2', '1', '5', '60100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('23', '合同', '/order/contract/toQueryPage.do', '1', '0', '110', '1', '2', '1', '5', '60200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('24', '财务审批', null, '1', '0', '116', '1', '2', '1', '6', '70100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('25', '财务款项', null, '1', '0', '117', '1', '2', '1', '6', '70200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('26', '销售目标', '/sales/salesTarget/toQueryPage.do', '1', '0', '121', '1', '2', '1', '7', '80100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('27', '账号信息', '/system/user/toViewSelfPage.do', '2', '0', '132', '1', '2', '1', '9', '100100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('28', '更改密码', '/system/user/toModifyPasswordPage.do', '2', '0', '133', '1', '2', '1', '9', '100200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('29', '自定义工作台', '/workbanch/toQueryPage.do', '2', '0', '134', '1', '2', '1', '9', '100300', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('30', '系统消息', '/system/message/toQueryPage.do', '2', '0', '135', '1', '2', '1', '9', '100500', '', '0', '1', '1', '2014-06-26 11:35:41', '0', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('31', '系统公告', '/system/notice/toQueryPage.do', '2', '0', '141', '1', '2', '1', '9', '100600', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('32', '用户', '/system/user/toQueryPage.do', '2', '0', '149', '1', '2', '1', '10', '110100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('33', '角色', '/system/role/toQueryPage.do', '2', '0', '161', '1', '2', '1', '10', '110200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('34', '菜单', '/system/menu/toQueryPage.do', '2', '0', '167', '1', '2', '1', '10', '110300', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('35', '功能', '/system/function/toQueryPage.do', '2', '0', '173', '1', '2', '1', '10', '110400', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('36', '组件', '/system/component/toQueryPage.do', '2', '0', '179', '1', '2', '1', '10', '110500', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('37', '权限设置', '/system/user/toAuthorizationPage.do', '2', '0', '184', '1', '2', '1', '10', '110600', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('38', '组织机构', '/system/organization/toQueryPage.do', '2', '0', '185', '1', '2', '1', '11', '120100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('39', '字典维护', '/system/dictionary/toQueryPage.do', '2', '0', '192', '1', '2', '1', '12', '130100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('40', '导出数据', '/system/data/toExportPage.do', '2', '0', '197', '1', '2', '1', '12', '130200', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('41', '回收站', '/system/recyclebin/toQueryPage.do', '2', '0', '198', '1', '2', '1', '12', '130300', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('42', '审计日志', '/system/auditlog/toQueryPage.do', '2', '0', '201', '1', '2', '1', '12', '130400', '', '0', '1', '1', '2014-06-22 16:41:41', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('43', 'CRM API', '/system/developer/toViewPage.do', '2', '0', '206', '1', '2', '1', '13', '140100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('44', '系统操作手册', '/system/help/toViewPage.do', '2', '0', '0', '1', '2', '1', '14', '150100', '', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-18 17:06:18');
INSERT INTO `sm_menu` VALUES ('46', '导入数据', '/common/imports/toImportPage.do', '2', '0', '196', '1', '2', '1', '12', '130105', null, '0', '1', '1', '2014-07-21 13:29:04', '1', '2014-07-21 13:30:34');
INSERT INTO `sm_module` VALUES ('1', 'marketActivity', '市场活动', 'com.baihui.hxtd.soa.market.entity.MarketActivity');
INSERT INTO `sm_module` VALUES ('2', 'lead', '线索', 'com.baihui.hxtd.soa.customer.entity.Lead');
INSERT INTO `sm_module` VALUES ('3', 'contact', '联系人', 'com.baihui.hxtd.soa.customer.entity.Contact');
INSERT INTO `sm_module` VALUES ('4', 'customer', '客户', 'com.baihui.hxtd.soa.customer.entity.Customer');
INSERT INTO `sm_module` VALUES ('5', 'supplier', '供应商', 'com.baihui.hxtd.soa.project.entity.Supplier');
INSERT INTO `sm_module` VALUES ('6', 'project', '项目', 'com.baihui.hxtd.soa.project.entity.Project');
INSERT INTO `sm_module` VALUES ('7', 'product', '产品', 'com.baihui.hxtd.soa.project.entity.Product');
INSERT INTO `sm_module` VALUES ('8', 'order', '订单', 'com.baihui.hxtd.soa.order.entity.Order');
INSERT INTO `sm_module` VALUES ('9', 'user', '用户', 'com.baihui.hxtd.soa.system.entity.User');
INSERT INTO `sm_module` VALUES ('10', 'role', '角色', 'com.baihui.hxtd.soa.system.entity.Role');
INSERT INTO `sm_module` VALUES ('11', 'menu', '菜单', 'com.baihui.hxtd.soa.system.entity.Menu');
INSERT INTO `sm_module` VALUES ('12', 'function', '功能', 'com.baihui.hxtd.soa.system.entity.Function');
INSERT INTO `sm_module` VALUES ('13', 'component', '组件', 'com.baihui.hxtd.soa.system.entity.Component');
INSERT INTO `sm_module` VALUES ('14', 'organization', '组织', 'com.baihui.hxtd.soa.system.entity.Organization');
INSERT INTO `sm_module` VALUES ('15', 'userMessage', '系统消息', 'com.baihui.hxtd.soa.system.entity.UserMessage');
INSERT INTO `sm_module` VALUES ('16', 'notice', '系统公告', 'com.baihui.hxtd.soa.system.entity.Notice');
INSERT INTO `sm_module` VALUES ('17', 'dictionary', '字典', 'com.baihui.hxtd.soa.system.entity.Dictionary');
INSERT INTO `sm_module` VALUES ('18', 'auditLog', '审计日志', 'com.baihui.hxtd.soa.system.entity.AuditLog');
INSERT INTO `sm_module` VALUES ('19', 'recycleBin', '回收站', 'com.baihui.hxtd.soa.system.entity.RecycleBin');
INSERT INTO `sm_module` VALUES ('20', 'attachment', '附件', 'com.baihui.hxtd.soa.common.entity.Attachment');
INSERT INTO `sm_module` VALUES ('21', 'memoir', '联系人纪要', 'com.baihui.hxtd.soa.common.entity.Memoir');
INSERT INTO `sm_module_type` VALUES ('2', '99010101', '1');
INSERT INTO `sm_module_type` VALUES ('3', '99010101', '2');
INSERT INTO `sm_module_type` VALUES ('4', '99010101', '3');
INSERT INTO `sm_module_type` VALUES ('5', '99010101', '4');
INSERT INTO `sm_module_type` VALUES ('6', '99010101', '5');
INSERT INTO `sm_module_type` VALUES ('7', '99010101', '6');
INSERT INTO `sm_module_type` VALUES ('8', '99010101', '7');
INSERT INTO `sm_module_type` VALUES ('9', '99010101', '8');
INSERT INTO `sm_module_type` VALUES ('10', '99010101', '9');
INSERT INTO `sm_module_type` VALUES ('11', '99010101', '10');
INSERT INTO `sm_module_type` VALUES ('12', '99010101', '11');
INSERT INTO `sm_module_type` VALUES ('13', '99010101', '12');
INSERT INTO `sm_module_type` VALUES ('14', '99010101', '13');
INSERT INTO `sm_module_type` VALUES ('15', '99010101', '14');
INSERT INTO `sm_module_type` VALUES ('16', '99010101', '15');
INSERT INTO `sm_module_type` VALUES ('17', '99010101', '16');
INSERT INTO `sm_module_type` VALUES ('18', '99010101', '17');
INSERT INTO `sm_module_type` VALUES ('19', '99010101', '18');
INSERT INTO `sm_module_type` VALUES ('20', '99010101', '19');
INSERT INTO `sm_module_type` VALUES ('21', '99010101', '20');
INSERT INTO `sm_module_type` VALUES ('22', '99010101', '21');
INSERT INTO `sm_org` VALUES ('1', '华兴控股', '华兴控股', '1030101', '18620088324', '1429457@163.com', '北京市海淀区', '100000', 'http://hxtd.crm.com', null, '1', '0', null, '100000000', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('2', '董事会', '董事会', '1030103', '', '', '', '', '', null, '2', '0', '1', '101000000', '0', '1', '1', '2014-07-10 15:17:25', '1', '2014-07-16 18:06:04');
INSERT INTO `sm_org` VALUES ('3', '监视会', '监视会', '1030103', '18620088324', '1429457@163.com', '北京市海淀区', '100000', 'http://hxtd.crm.com', null, '2', '1', '1', '102000000', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('4', '三级委员会', '三级委员会', '1030103', '1862008324', '1429457@163.com', '北京市海淀区', '100000', 'http://hxtd.crm.com', null, '2', '0', '1', '103000000', '1', '1', '1', '2014-05-26 00:00:00', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('5', '风险控制委员会', '风险控制委员会', '1030103', '1231331111', '', '', '', '', null, '3', '1', '4', '103010000', '1', '1', '1', '2014-07-10 15:27:43', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('6', '投资决策委员会', '投资决策委员会', '1030103', '18620623071', '', '', '', '', null, '3', '1', '4', '103020000', '1', '1', '1', '2014-07-10 15:33:09', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('7', '专家评审委员会', '专家评审委员会', '1030103', '12345678945', '', '', '', '', null, '3', '1', '4', '103030000', '1', '1', '1', '2014-07-10 15:35:29', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('8', '华兴银汇资本运营中心', '华兴银汇资本运营中心', '1030102', '12346659699', '', '', '', '', null, '2', '1', '1', '104000000', '1', '1', '1', '2014-07-10 15:37:43', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('9', '华兴汇富资产管理中心', '华兴汇富资产管理中心', '1030102', '12345678999', '', '', '', '', null, '2', '1', '1', '105000000', '1', '1', '1', '2014-07-10 15:39:36', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('10', '华兴泰瑞资产管理中心', '华兴泰瑞资产管理中心', '1030102', '12345678999', '', '', '', '', null, '2', '1', '1', '106000000', '1', '1', '1', '2014-07-10 15:40:23', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('11', '总裁办公室', '总裁办公室', '1030102', '18500726985', '', '', '', '', null, '2', '1', '1', '107000000', '1', '1', '1', '2014-07-10 15:46:24', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('12', '法务部', '法务部', '1030102', '18620623071', '', '', '', '', null, '1', '1', '1', '108000000', '1', '1', '1', '2014-07-10 15:47:04', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('13', '财务中心', '财务中心', '1030102', '18620623071', '', '', '', '', null, '2', '0', '1', '109000000', '1', '1', '1', '2014-07-10 15:47:28', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('14', '人力资源行政管理中心', '人力资源行政管理中心', '1030102', '18620623071', '', '', '', '', null, '2', '0', '1', '110000000', '1', '1', '1', '2014-07-10 15:47:51', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('15', '成本控制中心', '成本控制中心', '1030102', '18620623071', '', '', '', '', null, '2', '1', '1', '111000000', '1', '1', '1', '2014-07-10 15:48:15', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('16', '技术管理中心', '技术管理中心', '1030102', '18620623071', '', '', '', '', null, '2', '1', '1', '112000000', '1', '1', '1', '2014-07-10 15:48:30', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('17', '企划营销中心', '企划营销中心', '1030102', '18620623071', '', '', '', '', null, '1', '1', '1', '113000000', '1', '1', '1', '2014-07-10 15:48:45', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('18', '出资部', '出资部', '1030102', '18620623071', '', '', '', '', null, '2', '1', '1', '114000000', '1', '1', '1', '2014-07-10 15:49:29', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('19', '风控部', '风控部', '1030102', '18620623071', '', '', '', '', null, '1', '1', '1', '115000000', '1', '1', '1', '2014-07-10 15:49:43', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('20', '理财部', '理财部', '1030102', '18620623071', '', '', '', '', null, '2', '1', '1', '116000000', '1', '1', '1', '2014-07-10 15:49:54', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('21', '重大项目部', '重大项目部', '1030102', '18620623071', '', '', '', '', null, '2', '1', '1', '117000000', '1', '1', '1', '2014-07-10 15:50:08', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('22', '运营部', '运营部', '1030102', '18620623071', '', '', '', '', null, '2', '1', '1', '118000000', '1', '1', '1', '2014-07-10 15:50:19', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('23', '渠道合作部', '渠道合作部', '1030102', '18620623071', '', '', '', '', null, '2', '1', '1', '119000000', '1', '1', '1', '2014-07-10 15:50:33', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('24', '秘书处', '秘书处', '1030102', '18620623071', '', '', '', '', null, '2', '1', '1', '120000000', '1', '1', '1', '2014-07-10 15:50:49', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('25', '行政部', '行政部', '1030102', '18620623071', '', '', '', '', null, '3', '1', '14', '110010000', '1', '1', '1', '2014-07-10 15:51:36', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('26', '人力资源部', '人力资源部', '1030102', '18620623071', '', '', '', '', null, '3', '1', '14', '110020000', '1', '1', '1', '2014-07-10 15:52:03', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('27', '技术部', '技术部', '1030102', '18620623071', '', '', '', '', null, '2', '1', '1', '121000000', '1', '1', '1', '2014-07-10 15:52:19', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('28', 'IT部', 'IT部', '1030102', '18620623071', '', '', '', '', null, '2', '1', '1', '122000000', '1', '1', '1', '2014-07-10 15:52:34', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('29', '品牌媒介部', '品牌媒介部', '1030102', '18620623071', '', '', '', '', null, '2', '1', '1', '123000000', '1', '1', '1', '2014-07-10 15:52:47', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('30', '市场策划部', '市场策划部', '1030102', '18620623071', '', '', '', '', null, '2', '1', '1', '124000000', '1', '1', '1', '2014-07-10 15:52:59', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('31', '财务部', '财务部', '1030102', '18620623071', '', '', '', '', null, '3', '1', '13', '109010000', '1', '1', '1', '2014-07-10 15:53:43', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('32', '华兴泰达', '华兴泰达出资基金管理有限公司', '1030101', '12345678977', '', '', '', '', null, '2', '1', '1', '125000000', '1', '1', '1', '2014-07-10 16:01:18', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('33', '华兴泰瑞（北京）', '华兴泰瑞（北京）资产管理有限公司', '1030101', '12345678988', '', '', '', '', null, '2', '1', '1', '126000000', '1', '1', '1', '2014-07-10 16:03:48', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('35', '总办', '总办', '1030102', '18500723906', null, '北京市海淀区', null, null, null, '2', '0', '1', '141000000', '0', '0', '1', '2014-07-16 11:41:51', '1', '2014-07-21 17:16:54');
INSERT INTO `sm_org` VALUES ('36', '投资基金管理', '投资基金管理', '1030102', '18500230212', null, null, null, null, null, '2', '0', '1', '142000000', '0', '0', '1', '2014-07-16 11:42:14', '1', '2014-07-21 18:15:48');
INSERT INTO `sm_org` VALUES ('37', '资产管理', '资产管理', '1030102', null, null, null, null, null, null, '2', '0', '1', '129000000', '0', '0', '1', '2014-07-16 11:42:28', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('38', '行政部', '行政部', '1030102', null, null, null, null, null, null, '3', '1', '35', '127010000', '0', '0', '1', '2014-07-16 11:42:54', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('39', '人力资源部', '人力资源部', '1030102', null, null, null, null, null, null, '3', '1', '35', '127020000', '0', '0', '1', '2014-07-16 11:43:09', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('40', '财务部', '财务部', '1030102', null, null, null, null, null, null, '3', '1', '35', '127030000', '0', '0', '1', '2014-07-16 11:43:23', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('41', '秘书处', '秘书处', '1030102', null, null, null, null, null, null, '3', '1', '35', '127040000', '0', '0', '1', '2014-07-16 11:43:38', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('42', '法务部', '法务部', '1030102', null, null, null, null, null, null, '3', '1', '35', '127050000', '0', '0', '1', '2014-07-16 11:43:52', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('43', '项目部', '重大项目部', '1030102', null, null, null, null, null, null, '3', '1', '37', '129020000', '0', '0', '1', '2014-07-16 11:44:08', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('44', '风控部', '风控部', '1030102', null, null, null, null, null, null, '3', '1', '37', '129030000', '0', '0', '1', '2014-07-16 11:44:21', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('45', '投资部', '投资部', '1030102', null, null, null, null, null, null, '3', '1', '36', '128050000', '0', '0', '1', '2014-07-16 11:44:35', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('46', '理财部', '理财部', '1030102', null, null, null, null, null, null, '3', '1', '36', '128030000', '0', '0', '1', '2014-07-16 11:45:33', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('47', '渠道合作部', '渠道合作部', '1030102', null, null, null, null, null, null, '3', '1', '36', '128040000', '0', '0', '1', '2014-07-16 11:47:02', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('48', '企划部', '企划部', '1030102', null, null, null, null, null, null, '3', '1', '35', '127060000', '0', '0', '1', '2014-07-16 11:49:12', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('49', '品牌媒介部', '品牌媒介部', '1030102', null, null, null, null, null, null, '3', '1', '35', '127070000', '0', '0', '1', '2014-07-16 11:49:32', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('50', '技术部', '技术部', '1030102', null, null, null, null, null, null, '3', '1', '35', '127080000', '0', '0', '1', '2014-07-16 11:49:50', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('51', '海淀区分部', '海淀区分部', '1030101', null, null, null, null, null, '海淀区销售', '3', '0', '36', '128060000', '0', '0', '1', '2014-07-16 11:52:36', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('52', '昌平区分部', '昌平区分部', '1030101', null, null, null, null, null, '昌平区销售', '3', '0', '36', '128070000', '0', '0', '1', '2014-07-16 11:53:00', '1', '2014-07-16 16:39:06');
INSERT INTO `sm_org` VALUES ('55', '华兴泰达(北京)', '北京华兴泰达投资基金管理有限公司', '1030101', null, null, null, null, null, null, '3', '0', '36', '128080000', '0', '0', '1', '2014-07-16 12:07:10', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('56', '运营部', '运营部', '1030102', null, null, null, null, null, null, '4', '1', '55', '128080100', '0', '0', '1', '2014-07-16 12:08:36', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('57', '市场策划部', '市场策划部', '1030102', null, null, null, null, null, null, '3', '1', '35', '127090000', '0', '0', '1', '2014-07-16 12:19:34', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('58', '总裁办公室', '总裁办公室', '1030102', null, null, null, null, null, null, '3', '1', '35', '127100000', '0', '0', '1', '2014-07-16 12:23:17', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('59', '朝阳区分部', '朝阳区分部', '1030101', null, null, null, null, null, '朝阳区销售', '3', '0', '36', '128090000', '0', '0', '1', '2014-07-16 13:08:43', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('60', '房山区分部', '房山区分部', '1030101', null, null, null, null, null, '房山区销售', '3', '0', '36', '128100000', '0', '0', '1', '2014-07-16 13:09:00', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('61', '华兴瑞泰(北京)', '北京华兴瑞泰资产管理中心', '1030101', null, null, null, null, null, null, '3', '1', '37', '129040000', '0', '0', '1', '2014-07-16 14:25:37', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('62', '银行渠道部', '银行渠道部', '1030102', null, null, null, null, null, null, '4', '0', '51', '128060100', '0', '0', '1', '2014-07-16 15:56:47', '1', '2014-07-16 16:29:33');
INSERT INTO `sm_org` VALUES ('64', '渠道部', '渠道部', '1030102', null, null, null, null, null, null, '4', '0', '52', '128070100', '0', '0', '1', '2014-07-16 16:09:37', '1', '2014-07-16 16:58:41');
INSERT INTO `sm_org` VALUES ('65', '渠道部', '渠道部', '1030102', null, null, null, null, null, null, '4', '0', '60', '128100100', '0', '0', '1', '2014-07-16 16:10:29', '1', '2014-07-16 16:52:38');
INSERT INTO `sm_org` VALUES ('66', '投资理财部', '投资理财部', '1030102', null, null, null, null, null, null, '4', '0', '59', '128090100', '0', '0', '1', '2014-07-16 16:10:53', '1', '2014-07-16 16:47:33');
INSERT INTO `sm_org` VALUES ('67', '投资理财部', '投资理财部', '1030102', null, null, null, null, null, null, '4', '0', '51', '128060100', '0', '0', '1', '2014-07-16 16:22:02', '1', '2014-07-16 16:49:27');
INSERT INTO `sm_org` VALUES ('68', '渠道1组', '渠道1组', '1030103', null, null, null, null, null, null, '5', '1', '62', '128060101', '0', '0', '1', '2014-07-16 16:23:18', '1', '2014-07-16 16:23:18');
INSERT INTO `sm_org` VALUES ('69', '渠道2组', '渠道2组', '1030103', null, '', null, null, null, null, '5', '1', '62', '128060101', '0', '0', '1', '2014-07-16 16:25:53', '1', '2014-07-16 16:44:42');
INSERT INTO `sm_org` VALUES ('70', '渠道3组', '渠道3组', '1030103', null, null, null, null, null, null, '5', '1', '62', '128060101', '0', '0', '1', '2014-07-16 16:29:33', '1', '2014-07-16 16:29:33');
INSERT INTO `sm_org` VALUES ('71', '理财1组', '理财1组', '1030103', null, null, null, null, null, null, '5', '1', '67', '128060101', '0', '0', '1', '2014-07-16 16:33:29', '1', '2014-07-16 16:33:29');
INSERT INTO `sm_org` VALUES ('72', '理财2组', '理财2组', '1030103', null, null, null, null, null, null, '5', '1', '67', '128060101', '0', '0', '1', '2014-07-16 16:34:16', '1', '2014-07-16 16:34:16');
INSERT INTO `sm_org` VALUES ('73', '理财3组', '理财3组', '1030103', null, null, null, null, null, null, '5', '1', '67', '128060101', '0', '0', '1', '2014-07-16 16:37:03', '1', '2014-07-16 16:37:03');
INSERT INTO `sm_org` VALUES ('74', '理财部', '理财部', '1030102', null, null, null, null, null, null, '4', '0', '52', '128070200', '0', '0', '1', '2014-07-16 16:38:17', '1', '2014-07-16 16:59:02');
INSERT INTO `sm_org` VALUES ('75', '渠道1组', '渠道1组', '1030102', null, null, null, null, null, null, '5', '1', '64', '128070101', '0', '0', '1', '2014-07-16 16:39:52', '1', '2014-07-16 16:39:52');
INSERT INTO `sm_org` VALUES ('76', '渠道2组', '渠道2组', '1030103', null, null, null, null, null, null, '5', '1', '64', '128070101', '0', '0', '1', '2014-07-16 16:41:34', '1', '2014-07-16 16:41:34');
INSERT INTO `sm_org` VALUES ('77', '渠道3组', '渠道3组', '1030103', null, null, null, null, null, null, '5', '1', '64', '128070101', '0', '0', '1', '2014-07-16 16:42:14', '1', '2014-07-16 16:42:14');
INSERT INTO `sm_org` VALUES ('78', '理财1组', '理财1组', '1030103', null, null, null, null, null, null, '5', '1', '74', '128070201', '0', '0', '1', '2014-07-16 16:43:29', '1', '2014-07-16 16:43:29');
INSERT INTO `sm_org` VALUES ('79', '理财2组', '理财2组', '1030103', null, null, null, null, null, null, '5', '1', '74', '128070201', '0', '0', '1', '2014-07-16 16:44:32', '1', '2014-07-16 16:44:32');
INSERT INTO `sm_org` VALUES ('80', '理财1组', '理财1组', '1030103', null, null, null, null, null, null, '5', '1', '66', '128090101', '0', '0', '1', '2014-07-16 16:45:10', '1', '2014-07-16 16:45:10');
INSERT INTO `sm_org` VALUES ('81', '理财3组', '理财3组', '1030103', null, null, null, null, null, null, '5', '1', '74', '128070201', '0', '0', '1', '2014-07-16 16:45:30', '1', '2014-07-16 16:45:30');
INSERT INTO `sm_org` VALUES ('82', '理财2组', '理财2组', '1030103', null, null, null, null, null, null, '5', '1', '66', '128090101', '0', '0', '1', '2014-07-16 16:46:40', '1', '2014-07-16 16:46:40');
INSERT INTO `sm_org` VALUES ('83', '理财3组', '理财3组', '1030103', null, null, null, null, null, null, '5', '1', '66', '128090101', '0', '0', '1', '2014-07-16 16:47:33', '1', '2014-07-16 16:47:33');
INSERT INTO `sm_org` VALUES ('84', '理财部', '理财部', '1030102', null, null, null, null, null, null, '4', '0', '60', '128100200', '0', '0', '1', '2014-07-16 16:49:19', '1', '2014-07-16 16:55:58');
INSERT INTO `sm_org` VALUES ('85', '渠道1组', '渠道1组', '1030102', null, null, null, null, null, null, '5', '1', '65', '128100101', '0', '0', '1', '2014-07-16 16:50:08', '1', '2014-07-16 16:50:08');
INSERT INTO `sm_org` VALUES ('86', '渠道2组', '渠道2组', '1030103', null, null, null, null, null, null, '5', '1', '65', '128100101', '0', '0', '1', '2014-07-16 16:51:21', '1', '2014-07-16 16:51:21');
INSERT INTO `sm_org` VALUES ('87', '渠道3组', '渠道3组', '1030103', null, null, null, null, null, null, '5', '1', '65', '128100101', '0', '0', '1', '2014-07-16 16:52:38', '1', '2014-07-16 16:52:38');
INSERT INTO `sm_org` VALUES ('88', '理财1组', '理财1组', '1030103', null, null, null, null, null, null, '5', '1', '84', '128100201', '0', '0', '1', '2014-07-16 16:53:31', '1', '2014-07-16 16:53:31');
INSERT INTO `sm_org` VALUES ('89', '理财2组', '理财2组', '1030103', null, null, null, null, null, null, '5', '1', '84', '128100201', '0', '0', '1', '2014-07-16 16:55:17', '1', '2014-07-16 16:55:17');
INSERT INTO `sm_org` VALUES ('90', '理财3组', '理财3组', '1030103', null, null, null, null, null, null, '5', '1', '84', '128100201', '0', '0', '1', '2014-07-16 16:55:58', '1', '2014-07-16 16:55:58');
INSERT INTO `sm_org` VALUES ('91', 'test1', 'test1', '1030102', null, null, null, null, null, null, '3', '1', '2', '101010000', '1', '0', '1', '2014-07-16 18:06:04', '1', '2014-07-16 18:06:54');
INSERT INTO `sm_org` VALUES ('92', 'test2', 'test2', '1030102', null, null, null, null, null, null, '3', '1', '2', '101020000', '1', '0', '1', '2014-07-16 18:06:24', '1', '2014-07-16 18:06:54');
INSERT INTO `sm_org` VALUES ('93', 'ceccecee1', '234', '1030101', null, null, null, null, null, 'qwerrttt你好啊', '2', '1', '1', '130000000', '0', '0', '1', '2014-07-21 16:00:33', '1', '2014-07-21 18:26:06');
INSERT INTO `sm_org` VALUES ('94', '浏览', 'sho', '1030101', null, null, '2', null, null, null, '2', '1', '1', '131000000', '0', '0', '1', '2014-07-21 16:17:06', '1', '2014-07-21 18:26:06');
INSERT INTO `sm_org` VALUES ('95', '丽丽', '90', '1030101', null, null, null, null, null, null, '2', '1', '1', '132000000', '0', '0', '1', '2014-07-21 16:17:56', '1', '2014-07-21 18:26:06');
INSERT INTO `sm_org` VALUES ('96', '90890', '浏览', '1030102', null, null, null, null, null, null, '2', '1', '1', '133000000', '1', '0', '1', '2014-07-21 16:19:22', '1', '2014-07-21 16:33:07');
INSERT INTO `sm_org` VALUES ('97', '123456', '23456', '1030102', null, null, null, null, null, null, '2', '1', '1', '134000000', '1', '0', '1', '2014-07-21 16:22:08', '1', '2014-07-21 16:29:52');
INSERT INTO `sm_org` VALUES ('98', '567', '567', '1030103', null, null, null, null, null, null, '2', '1', '1', '135000000', '1', '0', '1', '2014-07-21 16:22:24', '1', '2014-07-21 16:30:01');
INSERT INTO `sm_org` VALUES ('99', '策划部测测', '1234', '1030101', null, null, null, null, null, null, '2', '1', '1', '136000000', '0', '0', '1', '2014-07-21 16:53:22', '1', '2014-07-21 18:26:06');
INSERT INTO `sm_org` VALUES ('100', '33', '3333', '1030101', null, null, null, null, null, null, '2', '1', '1', '137000000', '1', '0', '1', '2014-07-21 16:56:48', '1', '2014-07-22 13:57:40');
INSERT INTO `sm_org` VALUES ('101', '123456', '23456', '1030101', null, null, null, null, null, null, '2', '1', '1', '138000000', '0', '0', '1', '2014-07-21 17:01:56', '1', '2014-07-22 14:09:11');
INSERT INTO `sm_org` VALUES ('102', '超人', '超人公司', '1030101', null, null, null, null, null, 'xzxzsdfdssssgdxz', '2', '1', '1', '157000000', '0', '0', '1', '2014-07-21 17:05:32', '1', '2014-07-22 10:09:08');
INSERT INTO `sm_org` VALUES ('103', 'dsd', 'dsd', '1030102', null, null, null, null, null, null, '2', '1', '1', '153000000', '1', '0', '1', '2014-07-22 10:04:32', '1', '2014-07-22 10:04:45');
INSERT INTO `sm_org_role` VALUES ('2', '8');
INSERT INTO `sm_org_role` VALUES ('3', '1');
INSERT INTO `sm_org_role` VALUES ('3', '9');
INSERT INTO `sm_recyclebin` VALUES ('12', 'customer', '8', '323', null, '1', '2014-07-16 11:04:52');
INSERT INTO `sm_recyclebin` VALUES ('13', 'user', '3', 'manager', null, '1', '2014-07-16 13:22:01');
INSERT INTO `sm_recyclebin` VALUES ('14', 'customer', '7', 'admin', null, '1', '2014-07-16 14:00:47');
INSERT INTO `sm_recyclebin` VALUES ('15', 'customer', '3', 'ad撒', null, '1', '2014-07-16 14:00:47');
INSERT INTO `sm_recyclebin` VALUES ('17', 'customer', '1', 'admin', null, '1', '2014-07-16 14:00:47');
INSERT INTO `sm_recyclebin` VALUES ('18', 'customer', '2', 'a额问问', null, '1', '2014-07-16 14:06:48');
INSERT INTO `sm_recyclebin` VALUES ('19', 'customer', '1', 'admin', null, '1', '2014-07-16 14:07:19');
INSERT INTO `sm_recyclebin` VALUES ('20', 'customer', '7', 'admin', null, '1', '2014-07-16 14:07:24');
INSERT INTO `sm_recyclebin` VALUES ('21', 'contract', '12', '344234234242423', null, '1', '2014-07-16 15:38:00');
INSERT INTO `sm_recyclebin` VALUES ('22', 'contract', '13', 'sdsds2334', null, '1', '2014-07-16 15:38:04');
INSERT INTO `sm_recyclebin` VALUES ('25', 'user', '5', 'test', null, '1', '2014-07-16 17:09:32');
INSERT INTO `sm_recyclebin` VALUES ('26', 'userMessage', '53', '你好呀', null, '1', '2014-07-16 17:11:03');
INSERT INTO `sm_recyclebin` VALUES ('29', 'lead', '3', '爱仕达', null, '1', '2014-07-16 17:21:57');
INSERT INTO `sm_recyclebin` VALUES ('30', 'role', '5', '理财专员', '角色删除', '1', '2014-07-16 18:02:04');
INSERT INTO `sm_recyclebin` VALUES ('31', 'role', '7', '理财总监', '角色删除', '1', '2014-07-16 18:02:04');
INSERT INTO `sm_recyclebin` VALUES ('32', 'organization', '91', 'test1', '组织删除', '1', '2014-07-16 18:06:46');
INSERT INTO `sm_recyclebin` VALUES ('33', 'organization', '92', 'test2', '组织删除', '1', '2014-07-16 18:06:46');
INSERT INTO `sm_recyclebin` VALUES ('34', 'user', '8', '曹操', null, '1', '2014-07-17 11:33:08');
INSERT INTO `sm_recyclebin` VALUES ('35', 'user', '7', '夏侯惇', null, '1', '2014-07-17 11:52:19');
INSERT INTO `sm_recyclebin` VALUES ('36', 'contract', '13', 'sdsds2334', null, '1', '2014-07-17 16:47:01');
INSERT INTO `sm_recyclebin` VALUES ('37', 'contract', '10', '123131', null, '1', '2014-07-17 16:47:01');
INSERT INTO `sm_recyclebin` VALUES ('38', 'contract', '9', '1235456', null, '1', '2014-07-17 16:47:01');
INSERT INTO `sm_recyclebin` VALUES ('39', 'contract', '12', '344234234242423', null, '1', '2014-07-17 16:47:01');
INSERT INTO `sm_recyclebin` VALUES ('40', 'contract', '15', '123456', null, '1', '2014-07-17 16:47:20');
INSERT INTO `sm_recyclebin` VALUES ('41', 'contract', '13', 'sdsds2334', null, '1', '2014-07-17 16:47:20');
INSERT INTO `sm_recyclebin` VALUES ('42', 'contract', '10', '123131', null, '1', '2014-07-17 16:47:20');
INSERT INTO `sm_recyclebin` VALUES ('43', 'contract', '9', '1235456', null, '1', '2014-07-17 16:47:20');
INSERT INTO `sm_recyclebin` VALUES ('44', 'contract', '12', '344234234242423', null, '1', '2014-07-17 16:47:20');
INSERT INTO `sm_recyclebin` VALUES ('45', 'contract', '12', '344234234242423', null, '1', '2014-07-17 16:47:26');
INSERT INTO `sm_recyclebin` VALUES ('48', 'role', '15', '1234567', '角色删除', '1', '2014-07-17 17:04:39');
INSERT INTO `sm_recyclebin` VALUES ('49', 'role', '17', '12345679', '角色删除', '1', '2014-07-17 17:04:39');
INSERT INTO `sm_recyclebin` VALUES ('50', 'contract', '16', '还不考虑看见了分公司的飞', null, '1', '2014-07-17 17:04:42');
INSERT INTO `sm_recyclebin` VALUES ('51', 'lead', '2', '按时大时代', null, '1', '2014-07-17 17:24:54');
INSERT INTO `sm_recyclebin` VALUES ('54', 'role', '14', '2345', '角色删除', '1', '2014-07-18 14:50:28');
INSERT INTO `sm_recyclebin` VALUES ('55', 'role', '18', '908', '角色删除', '1', '2014-07-18 14:50:28');
INSERT INTO `sm_recyclebin` VALUES ('56', 'role', '19', '测试', '角色删除', '1', '2014-07-18 14:50:28');
INSERT INTO `sm_recyclebin` VALUES ('57', 'role', '11', 'IT人员', '角色删除', '1', '2014-07-18 14:53:08');
INSERT INTO `sm_recyclebin` VALUES ('58', 'role', '12', '测试人员', '角色删除', '1', '2014-07-18 14:53:08');
INSERT INTO `sm_recyclebin` VALUES ('59', 'role', '13', '测试工程师', '角色删除', '1', '2014-07-18 14:53:08');
INSERT INTO `sm_recyclebin` VALUES ('60', 'role', '21', '250', '角色删除', '1', '2014-07-18 16:53:58');
INSERT INTO `sm_recyclebin` VALUES ('64', 'contract', '14', '140714DQYT001', null, '1', '2014-07-21 09:20:57');
INSERT INTO `sm_recyclebin` VALUES ('65', 'component', '110210', 'ce2', null, '110210', '2014-07-21 11:56:07');
INSERT INTO `sm_recyclebin` VALUES ('66', 'user', '12', '陈龙', null, '1', '2014-07-21 13:16:54');
INSERT INTO `sm_recyclebin` VALUES ('67', 'function', '140147', 'admin', '功能删除', '1', '2014-07-21 13:34:51');
INSERT INTO `sm_recyclebin` VALUES ('68', 'function', '140145', '管理员', '功能删除', '1', '2014-07-21 13:34:58');
INSERT INTO `sm_recyclebin` VALUES ('69', 'component', '990125', '3456', null, '990125', '2014-07-21 13:59:08');
INSERT INTO `sm_recyclebin` VALUES ('70', 'component', '990117', '3455', null, '990117', '2014-07-21 13:59:25');
INSERT INTO `sm_recyclebin` VALUES ('71', 'user', '25', '刘岚', null, '1', '2014-07-21 14:08:17');
INSERT INTO `sm_recyclebin` VALUES ('72', 'user', '27', 'liulan', null, '1', '2014-07-21 14:08:17');
INSERT INTO `sm_recyclebin` VALUES ('73', 'user', '28', '刘岚1', null, '1', '2014-07-21 14:08:17');
INSERT INTO `sm_recyclebin` VALUES ('74', 'function', '140150', '测试', '功能删除', '1', '2014-07-21 16:14:21');
INSERT INTO `sm_recyclebin` VALUES ('75', 'function', '140149', '234', '功能删除', '1', '2014-07-21 16:14:21');
INSERT INTO `sm_recyclebin` VALUES ('76', 'function', '140148', '·12345', '功能删除', '1', '2014-07-21 16:14:21');
INSERT INTO `sm_recyclebin` VALUES ('79', 'function', '140119', '123', '功能删除', '1', '2014-07-21 16:14:34');
INSERT INTO `sm_recyclebin` VALUES ('81', 'organization', '97', '123456', '组织删除', '1', '2014-07-21 16:29:47');
INSERT INTO `sm_recyclebin` VALUES ('82', 'organization', '98', '567', '组织删除', '1', '2014-07-21 16:29:55');
INSERT INTO `sm_recyclebin` VALUES ('83', 'component', '110211', 'admin12', null, '1', '2014-07-21 16:32:53');
INSERT INTO `sm_recyclebin` VALUES ('84', 'component', '110212', '3443', null, '1', '2014-07-21 16:32:53');
INSERT INTO `sm_recyclebin` VALUES ('85', 'organization', '96', '90890', '组织删除', '1', '2014-07-21 16:33:01');
INSERT INTO `sm_recyclebin` VALUES ('89', 'component', '990123', '12345', null, '1', '2014-07-21 16:33:07');
INSERT INTO `sm_recyclebin` VALUES ('102', 'lead', '5', '东北大庆油田集团公司', null, '1', '2014-07-21 19:33:33');
INSERT INTO `sm_recyclebin` VALUES ('103', 'lead', '5', '东北大庆油田集团公司', null, '1', '2014-07-21 19:33:48');
INSERT INTO `sm_recyclebin` VALUES ('107', 'product', '1', '东北大庆油田一期基金', null, '1', '2014-07-21 20:16:54');
INSERT INTO `sm_recyclebin` VALUES ('109', 'organization', '103', 'dsd', '组织删除', '1', '2014-07-22 10:04:43');
INSERT INTO `sm_recyclebin` VALUES ('114', 'order', '2', '123456', null, '1', '2014-07-22 13:48:26');
INSERT INTO `sm_recyclebin` VALUES ('115', 'order', '3', '还不考虑看见了分公司的飞', null, '1', '2014-07-22 13:48:33');
INSERT INTO `sm_recyclebin` VALUES ('116', 'organization', '100', '33', '组织删除', '1', '2014-07-22 13:57:38');
INSERT INTO `sm_recyclebin` VALUES ('117', 'userMessage', '63', 'sa', null, '1', '2014-07-22 14:00:38');
INSERT INTO `sm_recyclebin` VALUES ('122', 'userMessage', '57', 'sa', '删除系统消息', '1', '2014-07-22 14:17:36');
INSERT INTO `sm_recyclebin` VALUES ('123', 'userMessage', '51', '你好呀', '删除系统消息', '1', '2014-07-22 14:24:23');
INSERT INTO `sm_recyclebin` VALUES ('124', 'userMessage', '55', '你好呀', '删除系统消息', '1', '2014-07-22 14:25:12');
INSERT INTO `sm_recyclebin` VALUES ('125', 'role', '22', '260', '角色删除', '1', '2014-07-22 21:15:04');
INSERT INTO `sm_role` VALUES ('1', '1', '系统管理员', '1050101', '可进行系统所有操作', '0', '1', '1', '2014-06-19 13:49:31', '1', '2014-06-19 13:49:31');
INSERT INTO `sm_role` VALUES ('2', '2', '系统数据管理员', '1050101', '可查看系统所有数据', '0', '1', '1', '2014-06-19 13:49:31', '1', '2014-06-19 13:49:31');
INSERT INTO `sm_role` VALUES ('3', '3', '主管数据管理员', '1050101', '可查看所属组织及下级内数据', '0', '1', '1', '2014-06-19 13:49:31', '1', '2014-06-19 13:49:31');
INSERT INTO `sm_role` VALUES ('6', 'ORG_00001', '总裁', '1050101', '总裁', '0', '1', '1', '2014-07-16 17:26:02', '1', '2014-07-22 14:27:47');
INSERT INTO `sm_role` VALUES ('7', 'ORG_00002', '副总裁', '1050101', '副总裁', '0', '1', '1', '2014-07-16 17:26:10', '1', '2014-07-22 14:27:50');
INSERT INTO `sm_role` VALUES ('8', 'ORG_00003', '财务', '1050101', '财务', '0', '0', '1', '2014-07-16 17:26:10', '1', '2014-07-22 14:27:52');
INSERT INTO `sm_role` VALUES ('9', 'ORG_00004', '投资总监', '1050101', '投资总监', '0', '1', '1', '2014-07-16 17:27:07', '1', '2014-07-22 14:27:53');
INSERT INTO `sm_role` VALUES ('10', 'ORG_00005', '投资经理', '1050101', '投资经理', '0', '1', '1', '2014-07-16 17:28:34', '1', '2014-07-22 14:27:55');
INSERT INTO `sm_role` VALUES ('11', 'ORG_00006', '理财经理', '1050101', '理财经理', '0', '1', '1', '2014-07-16 17:28:40', '1', '2014-07-22 14:27:57');
INSERT INTO `sm_role` VALUES ('21', '', '250', '1050101', '250250250250250250250250250250250250250250250250250250250250250250250250250250250250250250250250250250250250250250250和哈哈哈弄弄哦哦哦呢', '1', '0', '1', '2014-07-18 16:45:34', '1', '2014-07-22 14:27:59');
INSERT INTO `sm_role` VALUES ('22', null, '260', '1050101', '260是谁', '1', '0', '1', '2014-07-18 16:46:09', '1', '2014-07-22 21:15:07');
INSERT INTO `sm_role` VALUES ('9999', null, '订单测试角色', '1050101', '订单测试角色', '0', '1', '1', '2014-07-18 16:46:09', '1', '2014-07-18 16:46:09');
INSERT INTO `sm_role_com` VALUES ('1', '2');
INSERT INTO `sm_role_com` VALUES ('1', '110204');
INSERT INTO `sm_role_com` VALUES ('1', '110211');
INSERT INTO `sm_role_com` VALUES ('12', '2');
INSERT INTO `sm_role_com` VALUES ('12', '3');
INSERT INTO `sm_role_com` VALUES ('12', '110204');
INSERT INTO `sm_role_com` VALUES ('12', '110205');
INSERT INTO `sm_role_com` VALUES ('12', '110211');
INSERT INTO `sm_role_com` VALUES ('12', '110212');
INSERT INTO `sm_role_com` VALUES ('21', '2');
INSERT INTO `sm_role_com` VALUES ('21', '3');
INSERT INTO `sm_role_com` VALUES ('21', '4');
INSERT INTO `sm_role_com` VALUES ('21', '6');
INSERT INTO `sm_role_com` VALUES ('21', '101');
INSERT INTO `sm_role_com` VALUES ('21', '90001');
INSERT INTO `sm_role_com` VALUES ('21', '110204');
INSERT INTO `sm_role_com` VALUES ('21', '110205');
INSERT INTO `sm_role_com` VALUES ('21', '110206');
INSERT INTO `sm_role_com` VALUES ('21', '110207');
INSERT INTO `sm_role_com` VALUES ('21', '110210');
INSERT INTO `sm_role_com` VALUES ('21', '110211');
INSERT INTO `sm_role_com` VALUES ('21', '110212');
INSERT INTO `sm_role_com` VALUES ('21', '110213');
INSERT INTO `sm_role_com` VALUES ('21', '110214');
INSERT INTO `sm_role_com` VALUES ('21', '990110');
INSERT INTO `sm_role_com` VALUES ('21', '990111');
INSERT INTO `sm_role_com` VALUES ('21', '990112');
INSERT INTO `sm_role_func` VALUES ('1', '33');
INSERT INTO `sm_role_func` VALUES ('1', '35');
INSERT INTO `sm_role_func` VALUES ('12', '22');
INSERT INTO `sm_role_func` VALUES ('12', '23');
INSERT INTO `sm_role_func` VALUES ('12', '24');
INSERT INTO `sm_role_func` VALUES ('12', '25');
INSERT INTO `sm_role_func` VALUES ('12', '26');
INSERT INTO `sm_role_func` VALUES ('12', '27');
INSERT INTO `sm_role_func` VALUES ('12', '28');
INSERT INTO `sm_role_func` VALUES ('12', '29');
INSERT INTO `sm_role_func` VALUES ('12', '30');
INSERT INTO `sm_role_func` VALUES ('12', '31');
INSERT INTO `sm_role_func` VALUES ('12', '32');
INSERT INTO `sm_role_func` VALUES ('12', '33');
INSERT INTO `sm_role_func` VALUES ('12', '34');
INSERT INTO `sm_role_func` VALUES ('12', '35');
INSERT INTO `sm_role_func` VALUES ('12', '36');
INSERT INTO `sm_role_func` VALUES ('12', '37');
INSERT INTO `sm_role_func` VALUES ('12', '38');
INSERT INTO `sm_role_func` VALUES ('12', '39');
INSERT INTO `sm_role_func` VALUES ('12', '40');
INSERT INTO `sm_role_func` VALUES ('12', '41');
INSERT INTO `sm_role_func` VALUES ('12', '42');
INSERT INTO `sm_role_func` VALUES ('12', '43');
INSERT INTO `sm_role_func` VALUES ('12', '44');
INSERT INTO `sm_role_func` VALUES ('12', '45');
INSERT INTO `sm_role_func` VALUES ('12', '46');
INSERT INTO `sm_role_func` VALUES ('12', '47');
INSERT INTO `sm_role_func` VALUES ('12', '48');
INSERT INTO `sm_role_func` VALUES ('12', '49');
INSERT INTO `sm_role_func` VALUES ('12', '50');
INSERT INTO `sm_role_func` VALUES ('12', '51');
INSERT INTO `sm_role_func` VALUES ('12', '52');
INSERT INTO `sm_role_func` VALUES ('12', '53');
INSERT INTO `sm_role_func` VALUES ('12', '54');
INSERT INTO `sm_role_func` VALUES ('12', '55');
INSERT INTO `sm_role_func` VALUES ('12', '56');
INSERT INTO `sm_role_func` VALUES ('12', '57');
INSERT INTO `sm_role_func` VALUES ('12', '58');
INSERT INTO `sm_role_func` VALUES ('12', '59');
INSERT INTO `sm_role_func` VALUES ('12', '60');
INSERT INTO `sm_role_func` VALUES ('12', '61');
INSERT INTO `sm_role_func` VALUES ('12', '62');
INSERT INTO `sm_role_func` VALUES ('12', '63');
INSERT INTO `sm_role_func` VALUES ('12', '64');
INSERT INTO `sm_role_func` VALUES ('12', '65');
INSERT INTO `sm_role_func` VALUES ('12', '67');
INSERT INTO `sm_role_func` VALUES ('12', '68');
INSERT INTO `sm_role_func` VALUES ('12', '69');
INSERT INTO `sm_role_func` VALUES ('12', '70');
INSERT INTO `sm_role_func` VALUES ('12', '71');
INSERT INTO `sm_role_func` VALUES ('12', '72');
INSERT INTO `sm_role_func` VALUES ('12', '73');
INSERT INTO `sm_role_func` VALUES ('12', '74');
INSERT INTO `sm_role_func` VALUES ('12', '75');
INSERT INTO `sm_role_func` VALUES ('12', '76');
INSERT INTO `sm_role_func` VALUES ('12', '77');
INSERT INTO `sm_role_func` VALUES ('12', '78');
INSERT INTO `sm_role_func` VALUES ('12', '79');
INSERT INTO `sm_role_func` VALUES ('12', '80');
INSERT INTO `sm_role_func` VALUES ('12', '81');
INSERT INTO `sm_role_func` VALUES ('12', '82');
INSERT INTO `sm_role_func` VALUES ('12', '83');
INSERT INTO `sm_role_func` VALUES ('12', '84');
INSERT INTO `sm_role_func` VALUES ('12', '85');
INSERT INTO `sm_role_func` VALUES ('12', '86');
INSERT INTO `sm_role_func` VALUES ('12', '87');
INSERT INTO `sm_role_func` VALUES ('12', '88');
INSERT INTO `sm_role_func` VALUES ('12', '89');
INSERT INTO `sm_role_func` VALUES ('12', '90');
INSERT INTO `sm_role_func` VALUES ('12', '100');
INSERT INTO `sm_role_func` VALUES ('12', '101');
INSERT INTO `sm_role_func` VALUES ('12', '102');
INSERT INTO `sm_role_func` VALUES ('12', '103');
INSERT INTO `sm_role_func` VALUES ('12', '104');
INSERT INTO `sm_role_func` VALUES ('12', '105');
INSERT INTO `sm_role_func` VALUES ('12', '106');
INSERT INTO `sm_role_func` VALUES ('12', '107');
INSERT INTO `sm_role_func` VALUES ('12', '108');
INSERT INTO `sm_role_func` VALUES ('12', '109');
INSERT INTO `sm_role_func` VALUES ('12', '110');
INSERT INTO `sm_role_func` VALUES ('12', '112');
INSERT INTO `sm_role_func` VALUES ('12', '113');
INSERT INTO `sm_role_func` VALUES ('12', '114');
INSERT INTO `sm_role_func` VALUES ('12', '115');
INSERT INTO `sm_role_func` VALUES ('12', '116');
INSERT INTO `sm_role_func` VALUES ('12', '117');
INSERT INTO `sm_role_func` VALUES ('12', '118');
INSERT INTO `sm_role_func` VALUES ('12', '119');
INSERT INTO `sm_role_func` VALUES ('12', '120');
INSERT INTO `sm_role_func` VALUES ('12', '126');
INSERT INTO `sm_role_func` VALUES ('12', '127');
INSERT INTO `sm_role_func` VALUES ('12', '128');
INSERT INTO `sm_role_func` VALUES ('12', '129');
INSERT INTO `sm_role_func` VALUES ('12', '130');
INSERT INTO `sm_role_func` VALUES ('12', '131');
INSERT INTO `sm_role_func` VALUES ('12', '134');
INSERT INTO `sm_role_func` VALUES ('12', '209');
INSERT INTO `sm_role_func` VALUES ('21', '22');
INSERT INTO `sm_role_func` VALUES ('21', '23');
INSERT INTO `sm_role_func` VALUES ('21', '24');
INSERT INTO `sm_role_func` VALUES ('21', '25');
INSERT INTO `sm_role_func` VALUES ('21', '26');
INSERT INTO `sm_role_func` VALUES ('21', '27');
INSERT INTO `sm_role_func` VALUES ('21', '28');
INSERT INTO `sm_role_func` VALUES ('21', '29');
INSERT INTO `sm_role_func` VALUES ('21', '30');
INSERT INTO `sm_role_func` VALUES ('21', '31');
INSERT INTO `sm_role_func` VALUES ('21', '32');
INSERT INTO `sm_role_func` VALUES ('21', '33');
INSERT INTO `sm_role_func` VALUES ('21', '34');
INSERT INTO `sm_role_func` VALUES ('21', '35');
INSERT INTO `sm_role_func` VALUES ('21', '36');
INSERT INTO `sm_role_func` VALUES ('21', '37');
INSERT INTO `sm_role_func` VALUES ('21', '38');
INSERT INTO `sm_role_func` VALUES ('21', '39');
INSERT INTO `sm_role_func` VALUES ('21', '40');
INSERT INTO `sm_role_func` VALUES ('21', '41');
INSERT INTO `sm_role_func` VALUES ('21', '42');
INSERT INTO `sm_role_func` VALUES ('21', '43');
INSERT INTO `sm_role_func` VALUES ('21', '44');
INSERT INTO `sm_role_func` VALUES ('21', '45');
INSERT INTO `sm_role_func` VALUES ('21', '46');
INSERT INTO `sm_role_func` VALUES ('21', '47');
INSERT INTO `sm_role_func` VALUES ('21', '48');
INSERT INTO `sm_role_func` VALUES ('21', '49');
INSERT INTO `sm_role_func` VALUES ('21', '50');
INSERT INTO `sm_role_func` VALUES ('21', '51');
INSERT INTO `sm_role_func` VALUES ('21', '52');
INSERT INTO `sm_role_func` VALUES ('21', '53');
INSERT INTO `sm_role_func` VALUES ('21', '54');
INSERT INTO `sm_role_func` VALUES ('21', '55');
INSERT INTO `sm_role_func` VALUES ('21', '56');
INSERT INTO `sm_role_func` VALUES ('21', '57');
INSERT INTO `sm_role_func` VALUES ('21', '58');
INSERT INTO `sm_role_func` VALUES ('21', '59');
INSERT INTO `sm_role_func` VALUES ('21', '60');
INSERT INTO `sm_role_func` VALUES ('21', '61');
INSERT INTO `sm_role_func` VALUES ('21', '62');
INSERT INTO `sm_role_func` VALUES ('21', '63');
INSERT INTO `sm_role_func` VALUES ('21', '64');
INSERT INTO `sm_role_func` VALUES ('21', '65');
INSERT INTO `sm_role_func` VALUES ('21', '67');
INSERT INTO `sm_role_func` VALUES ('21', '68');
INSERT INTO `sm_role_func` VALUES ('21', '69');
INSERT INTO `sm_role_func` VALUES ('21', '70');
INSERT INTO `sm_role_func` VALUES ('21', '71');
INSERT INTO `sm_role_func` VALUES ('21', '72');
INSERT INTO `sm_role_func` VALUES ('21', '73');
INSERT INTO `sm_role_func` VALUES ('21', '74');
INSERT INTO `sm_role_func` VALUES ('21', '75');
INSERT INTO `sm_role_func` VALUES ('21', '76');
INSERT INTO `sm_role_func` VALUES ('21', '77');
INSERT INTO `sm_role_func` VALUES ('21', '78');
INSERT INTO `sm_role_func` VALUES ('21', '79');
INSERT INTO `sm_role_func` VALUES ('21', '80');
INSERT INTO `sm_role_func` VALUES ('21', '81');
INSERT INTO `sm_role_func` VALUES ('21', '82');
INSERT INTO `sm_role_func` VALUES ('21', '83');
INSERT INTO `sm_role_func` VALUES ('21', '84');
INSERT INTO `sm_role_func` VALUES ('21', '85');
INSERT INTO `sm_role_func` VALUES ('21', '86');
INSERT INTO `sm_role_func` VALUES ('21', '87');
INSERT INTO `sm_role_func` VALUES ('21', '88');
INSERT INTO `sm_role_func` VALUES ('21', '89');
INSERT INTO `sm_role_func` VALUES ('21', '90');
INSERT INTO `sm_role_func` VALUES ('21', '100');
INSERT INTO `sm_role_func` VALUES ('21', '101');
INSERT INTO `sm_role_func` VALUES ('21', '102');
INSERT INTO `sm_role_func` VALUES ('21', '103');
INSERT INTO `sm_role_func` VALUES ('21', '134');
INSERT INTO `sm_role_func` VALUES ('21', '209');
INSERT INTO `sm_role_func` VALUES ('9999', '22');
INSERT INTO `sm_role_func` VALUES ('9999', '23');
INSERT INTO `sm_role_func` VALUES ('9999', '24');
INSERT INTO `sm_role_func` VALUES ('9999', '25');
INSERT INTO `sm_role_func` VALUES ('9999', '26');
INSERT INTO `sm_role_func` VALUES ('9999', '27');
INSERT INTO `sm_role_func` VALUES ('9999', '28');
INSERT INTO `sm_role_func` VALUES ('9999', '29');
INSERT INTO `sm_role_func` VALUES ('9999', '30');
INSERT INTO `sm_role_func` VALUES ('9999', '31');
INSERT INTO `sm_role_func` VALUES ('9999', '32');
INSERT INTO `sm_role_func` VALUES ('9999', '35');
INSERT INTO `sm_role_func` VALUES ('9999', '36');
INSERT INTO `sm_role_func` VALUES ('9999', '37');
INSERT INTO `sm_role_func` VALUES ('9999', '38');
INSERT INTO `sm_role_func` VALUES ('9999', '39');
INSERT INTO `sm_role_func` VALUES ('9999', '40');
INSERT INTO `sm_role_func` VALUES ('9999', '41');
INSERT INTO `sm_role_func` VALUES ('9999', '42');
INSERT INTO `sm_role_func` VALUES ('9999', '43');
INSERT INTO `sm_role_func` VALUES ('9999', '44');
INSERT INTO `sm_role_func` VALUES ('9999', '45');
INSERT INTO `sm_role_func` VALUES ('9999', '46');
INSERT INTO `sm_role_func` VALUES ('9999', '47');
INSERT INTO `sm_role_func` VALUES ('9999', '48');
INSERT INTO `sm_role_func` VALUES ('9999', '49');
INSERT INTO `sm_role_func` VALUES ('9999', '50');
INSERT INTO `sm_role_func` VALUES ('9999', '51');
INSERT INTO `sm_role_func` VALUES ('9999', '52');
INSERT INTO `sm_role_func` VALUES ('9999', '53');
INSERT INTO `sm_role_func` VALUES ('9999', '54');
INSERT INTO `sm_role_func` VALUES ('9999', '55');
INSERT INTO `sm_role_func` VALUES ('9999', '56');
INSERT INTO `sm_role_func` VALUES ('9999', '57');
INSERT INTO `sm_role_func` VALUES ('9999', '58');
INSERT INTO `sm_role_func` VALUES ('9999', '59');
INSERT INTO `sm_role_func` VALUES ('9999', '60');
INSERT INTO `sm_role_func` VALUES ('9999', '61');
INSERT INTO `sm_role_func` VALUES ('9999', '62');
INSERT INTO `sm_role_func` VALUES ('9999', '63');
INSERT INTO `sm_role_func` VALUES ('9999', '64');
INSERT INTO `sm_role_func` VALUES ('9999', '65');
INSERT INTO `sm_role_func` VALUES ('9999', '67');
INSERT INTO `sm_role_func` VALUES ('9999', '68');
INSERT INTO `sm_role_func` VALUES ('9999', '69');
INSERT INTO `sm_role_func` VALUES ('9999', '70');
INSERT INTO `sm_role_func` VALUES ('9999', '71');
INSERT INTO `sm_role_func` VALUES ('9999', '72');
INSERT INTO `sm_role_func` VALUES ('9999', '73');
INSERT INTO `sm_role_func` VALUES ('9999', '74');
INSERT INTO `sm_role_func` VALUES ('9999', '75');
INSERT INTO `sm_role_func` VALUES ('9999', '76');
INSERT INTO `sm_role_func` VALUES ('9999', '77');
INSERT INTO `sm_role_func` VALUES ('9999', '78');
INSERT INTO `sm_role_func` VALUES ('9999', '79');
INSERT INTO `sm_role_func` VALUES ('9999', '80');
INSERT INTO `sm_role_func` VALUES ('9999', '81');
INSERT INTO `sm_role_func` VALUES ('9999', '82');
INSERT INTO `sm_role_func` VALUES ('9999', '83');
INSERT INTO `sm_role_func` VALUES ('9999', '84');
INSERT INTO `sm_role_func` VALUES ('9999', '85');
INSERT INTO `sm_role_func` VALUES ('9999', '86');
INSERT INTO `sm_role_func` VALUES ('9999', '87');
INSERT INTO `sm_role_func` VALUES ('9999', '88');
INSERT INTO `sm_role_func` VALUES ('9999', '89');
INSERT INTO `sm_role_func` VALUES ('9999', '90');
INSERT INTO `sm_role_func` VALUES ('9999', '100');
INSERT INTO `sm_role_func` VALUES ('9999', '101');
INSERT INTO `sm_role_func` VALUES ('9999', '102');
INSERT INTO `sm_role_func` VALUES ('9999', '103');
INSERT INTO `sm_role_func` VALUES ('9999', '104');
INSERT INTO `sm_role_func` VALUES ('9999', '105');
INSERT INTO `sm_role_func` VALUES ('9999', '106');
INSERT INTO `sm_role_func` VALUES ('9999', '107');
INSERT INTO `sm_role_func` VALUES ('9999', '108');
INSERT INTO `sm_role_func` VALUES ('9999', '109');
INSERT INTO `sm_role_func` VALUES ('9999', '110');
INSERT INTO `sm_role_func` VALUES ('9999', '112');
INSERT INTO `sm_role_func` VALUES ('9999', '113');
INSERT INTO `sm_role_func` VALUES ('9999', '114');
INSERT INTO `sm_role_func` VALUES ('9999', '115');
INSERT INTO `sm_role_func` VALUES ('9999', '209');
INSERT INTO `sm_role_func` VALUES ('9999', '210');
INSERT INTO `sm_role_func` VALUES ('9999', '211');
INSERT INTO `sm_role_func` VALUES ('9999', '212');
INSERT INTO `sm_role_func` VALUES ('9999', '213');
INSERT INTO `sm_role_func` VALUES ('9999', '214');
INSERT INTO `sm_role_func` VALUES ('9999', '215');
INSERT INTO `sm_role_func` VALUES ('9999', '216');
INSERT INTO `sm_role_func` VALUES ('9999', '140113');
INSERT INTO `sm_role_func` VALUES ('9999', '140115');
INSERT INTO `sm_role_func` VALUES ('9999', '140116');
INSERT INTO `sm_role_func` VALUES ('9999', '140153');
INSERT INTO `sm_role_func` VALUES ('9999', '140154');
INSERT INTO `sm_role_func` VALUES ('9999', '140156');
INSERT INTO `sm_user` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '管理员', '11010215', '18620088324', '0000000000', '00000000@gmail.com', '000000000', '工程师', '1040301', '1', '1', '1', null, '1040401', '0', '1', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03');
INSERT INTO `sm_user` VALUES ('3', 'admin1', 'e10adc3949ba59abbe56e057f20f883e', 'manager', '11010216', '18620623071', '13909878908', '00000000@gmail.com', '10245', '工程师', '1040301', '0', '0', '18', 'io', '1040401', '1', '0', '1', '2014-07-14 11:20:11', '1', '2014-07-16 13:22:08');
INSERT INTO `sm_user` VALUES ('5', 'test', 'e10adc3949ba59abbe56e057f20f883e', 'test', '11010215', null, null, null, null, null, '1040301', '0', '1', '18', null, '1040401', '1', '0', '3', '2014-07-14 16:01:43', '3', '2014-07-16 17:09:08');
INSERT INTO `sm_user` VALUES ('6', 'liuyifei', 'e10adc3949ba59abbe56e057f20f883e', '刘亦菲1', '11010216', '18620623071', '18620623071', 'yifei.liu@pcstars.com', null, '董事长', '1040302', '1', '1', '2', '华兴控股集团总裁', '1040401', '0', '0', '1', '2014-07-16 13:18:53', '1', '2014-07-21 15:01:04');
INSERT INTO `sm_user` VALUES ('7', 'xiahoudun', 'e10adc3949ba59abbe56e057f20f883e', '夏侯惇', '11010215', null, null, null, null, '副总裁', '1040301', '0', '1', '2', '华兴控股集团夏副总裁', '1040401', '1', '0', '1', '2014-07-16 13:20:44', '1', '2014-07-17 11:52:15');
INSERT INTO `sm_user` VALUES ('8', 'caocao', 'e10adc3949ba59abbe56e057f20f883e', '曹操', '11010215', null, null, null, null, '副总裁', '1040301', '0', '1', '2', '华兴控股集团副总裁', '1040401', '1', '0', '1', '2014-07-16 13:21:47', '1', '2014-07-17 11:33:05');
INSERT INTO `sm_user` VALUES ('9', 'chenzheng', 'e10adc3949ba59abbe56e057f20f883e', '陈振', '11010215', null, null, null, null, '投资总监', '1040301', '0', '1', '74', '昌平区理财部投资总监', '1040401', '0', '0', '1', '2014-07-16 17:01:35', '1', '2014-07-16 18:01:31');
INSERT INTO `sm_user` VALUES ('10', 'zhangjiahui', 'e10adc3949ba59abbe56e057f20f883e', '张家辉', '11010215', null, null, null, null, '理财经理', '1040301', '0', '1', '78', '昌平区理财部理财1组经理张家辉', '1040401', '0', '0', '1', '2014-07-16 17:04:33', '1', '2014-07-16 17:07:21');
INSERT INTO `sm_user` VALUES ('11', 'chenglong', 'e10adc3949ba59abbe56e057f20f883e', '成龙', '11010215', null, null, null, null, '理财经理', '1040301', '0', '1', '78', '昌平区分部理财部理财1组理财经理成龙', '1040401', '0', '0', '1', '2014-07-16 17:05:43', '1', '2014-07-16 17:59:27');
INSERT INTO `sm_user` VALUES ('12', 'chenlong', 'e10adc3949ba59abbe56e057f20f883e', '陈龙', '11010215', null, null, null, null, '投资经理', '1040301', '0', '1', '78', '昌平区分部理财1组投资经理', '1040401', '1', '0', '1', '2014-07-16 17:06:40', '1', '2014-07-21 13:17:17');
INSERT INTO `sm_user` VALUES ('13', 'liudehua', 'e10adc3949ba59abbe56e057f20f883e', '刘德华', '11010215', null, null, null, null, '理财经理', '1040301', '0', '1', '78', '昌平区理财部理财2组理财经理', '1040401', '0', '0', '1', '2014-07-16 17:16:35', '1', '2014-07-22 14:45:14');
INSERT INTO `sm_user` VALUES ('14', 'majingliang', 'e10adc3949ba59abbe56e057f20f883e', '马敬亮', '11010215', null, null, null, null, '技术经理', '1040301', '0', '1', '50', null, '1040401', '0', '0', '1', '2014-07-16 17:17:18', '1', '2014-07-16 17:17:18');
INSERT INTO `sm_user` VALUES ('15', 'lihua', 'fcea920f7412b5da7be0cf42b8c93759', '李华', '11010215', null, null, null, null, '程序员', '1040301', '0', '1', '50', null, '1040401', '0', '0', '1', '2014-07-16 17:19:02', '1', '2014-07-21 16:38:49');
INSERT INTO `sm_user` VALUES ('16', 'luanruisong', 'e10adc3949ba59abbe56e057f20f883e', '栾瑞松', '11010215', null, null, null, null, '程序员', '1040301', '0', '1', '50', null, '1040401', '0', '0', '1', '2014-07-16 17:19:33', '1', '2014-07-16 17:19:33');
INSERT INTO `sm_user` VALUES ('17', 'xiayouxue', 'e10adc3949ba59abbe56e057f20f883e', '夏幼学', '11010215', null, null, null, null, '程序员', '1040301', '0', '1', '50', null, '1040401', '0', '0', '1', '2014-07-16 17:20:03', '1', '2014-07-16 17:21:54');
INSERT INTO `sm_user` VALUES ('18', 'luoxiaoli', 'e10adc3949ba59abbe56e057f20f883e', '罗晓丽', '11010215', null, null, null, null, '程序员', '1040301', '0', '1', '50', null, '1040401', '0', '0', '1', '2014-07-16 17:20:45', '1', '2014-07-16 17:20:45');
INSERT INTO `sm_user` VALUES ('19', 'huizijing', 'e10adc3949ba59abbe56e057f20f883e', '惠子敬', '11010215', null, null, null, null, '程序员', '1040301', '0', '1', '50', null, '1040401', '0', '0', '1', '2014-07-16 17:21:25', '1', '2014-07-16 17:21:25');
INSERT INTO `sm_user` VALUES ('20', 'liu', '827ccb0eea8a706c4c34a16891f84e7b', '12345', '11010215', null, null, null, null, 'office', '1040301', '0', '1', '37', null, '1040401', '0', '0', '1', '2014-07-17 11:19:44', '1', '2014-07-17 11:19:44');
INSERT INTO `sm_user` VALUES ('21', 'adm0', 'e10adc3949ba59abbe56e057f20f883e', '刘岚', '11010215', null, null, '15911140672@qq.com', null, null, '1040301', '0', '1', '36', null, '1040401', '0', '0', '1', '2014-07-17 11:26:47', '1', '2014-07-17 11:26:47');
INSERT INTO `sm_user` VALUES ('22', '12345', '202cb962ac59075b964b07152d234b70', 'liu', '11010215', '15911140672', null, 'liulan8627@163.com', null, null, '1040301', '0', '1', '37', null, '1040401', '0', '0', '1', '2014-07-17 11:29:39', '1', '2014-07-17 11:29:39');
INSERT INTO `sm_user` VALUES ('23', '890', 'e10adc3949ba59abbe56e057f20f883e', '098', '11010215', null, null, null, null, null, '1040301', '0', '1', '3', null, '1040401', '0', '0', '1', '2014-07-17 11:37:26', '1', '2014-07-17 11:37:26');
INSERT INTO `sm_user` VALUES ('24', '123456', 'e10adc3949ba59abbe56e057f20f883e', '123456', '11010215', null, null, null, null, null, '1040301', '1', '1', '36', null, '1040401', '0', '0', '1', '2014-07-17 11:38:13', '1', '2014-07-17 11:38:13');
INSERT INTO `sm_user` VALUES ('25', '刘岚', 'e10adc3949ba59abbe56e057f20f883e', '刘岚', '11010215', null, null, null, null, null, '1040301', '0', '1', '1', null, '1040401', '1', '0', '1', '2014-07-17 11:57:15', '1', '2014-07-21 14:08:22');
INSERT INTO `sm_user` VALUES ('27', 'nihaoma', 'e10adc3949ba59abbe56e057f20f883e', 'liulan', '11010215', null, null, null, null, null, '1040301', '0', '1', '3', null, '1040401', '1', '0', '1', '2014-07-18 16:37:32', '1', '2014-07-21 14:08:22');
INSERT INTO `sm_user` VALUES ('28', '刘岚1', 'adcaec3805aa912c0d0b14a81bedb6ff', '刘岚1', '11010215', null, null, null, null, null, '1040301', '0', '1', '3', '描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息描述信息。', '1040401', '1', '0', '1', '2014-07-18 16:40:32', '1', '2014-07-21 14:08:22');
INSERT INTO `sm_user` VALUES ('29', '呵呵', 'e10adc3949ba59abbe56e057f20f883e', '公告', '11010215', null, null, null, null, null, '1040301', '0', '1', '3', null, '1040401', '0', '0', '1', '2014-07-21 13:44:05', '1', '2014-07-21 13:44:05');
INSERT INTO `sm_user` VALUES ('30', 'liulan', 'e10adc3949ba59abbe56e057f20f883e', '刘岚', '11010215', null, null, null, null, null, '1040301', '0', '1', '3', null, '1040401', '0', '0', '1', '2014-07-21 14:10:31', '1', '2014-07-21 14:13:17');
INSERT INTO `sm_user` VALUES ('32', '篮子', 'e10adc3949ba59abbe56e057f20f883e', '刘岚', '11010216', null, null, null, null, 'edg', '1040301', '0', '1', '35', null, '1040401', '0', '0', '1', '2014-07-21 14:31:14', '1', '2014-07-21 14:31:14');
INSERT INTO `sm_user` VALUES ('33', 'liuliu', 'e10adc3949ba59abbe56e057f20f883e', '兰儿1', '11010216', '15911140672', '15911140672', null, null, null, '1040302', '0', '1', '35', '兰儿，兰儿', '1040401', '0', '0', '1', '2014-07-21 14:53:32', '1', '2014-07-21 16:07:49');
INSERT INTO `sm_user` VALUES ('34', 'dddd', 'e10adc3949ba59abbe56e057f20f883e', '得得得', '11010215', null, null, null, null, null, '1040301', '0', '1', '37', null, '1040401', '0', '0', '1', '2014-07-21 15:37:33', '1', '2014-07-21 15:39:55');
INSERT INTO `sm_user` VALUES ('35', '123', '182be0c5cdcd5072bb1864cdee4d3d6e', '333', '11010215', null, null, null, null, null, '1040302', '0', '1', '36', null, '1040401', '0', '0', '1', '2014-07-21 16:25:18', '1', '2014-07-21 16:25:18');
INSERT INTO `sm_user` VALUES ('36', 'CEO', 'e10adc3949ba59abbe56e057f20f883e', '总裁', '11010215', null, null, null, null, null, '1040301', '0', '1', '2', null, '1040401', '0', '0', '1', '2014-07-22 14:06:20', '1', '2014-07-22 14:06:20');
INSERT INTO `sm_user` VALUES ('37', 'VICECEO1', 'e10adc3949ba59abbe56e057f20f883e', '副总裁1', '11010215', null, null, null, null, null, '1040301', '0', '1', '2', null, '1040401', '0', '0', '1', '2014-07-22 14:07:00', '1', '2014-07-22 14:07:00');
INSERT INTO `sm_user` VALUES ('38', 'VICECEO2', 'e10adc3949ba59abbe56e057f20f883e', '副总裁2', '11010215', null, null, null, null, null, '1040301', '0', '1', '2', null, '1040401', '0', '0', '1', '2014-07-22 14:07:29', '1', '2014-07-22 14:07:29');
INSERT INTO `sm_user` VALUES ('39', 'FINANCER1', 'e10adc3949ba59abbe56e057f20f883e', '财务1', '11010215', null, null, null, null, null, '1040301', '0', '1', '40', null, '1040401', '0', '0', '1', '2014-07-22 14:08:05', '1', '2014-07-22 14:08:05');
INSERT INTO `sm_user` VALUES ('40', 'FINANCER2', 'e10adc3949ba59abbe56e057f20f883e', '财务2', '11010215', null, null, null, null, null, '1040301', '0', '1', '40', null, '1040401', '0', '0', '1', '2014-07-22 14:08:30', '1', '2014-07-22 14:08:30');
INSERT INTO `sm_user` VALUES ('41', 'INVESTMENTDIREC1', 'e10adc3949ba59abbe56e057f20f883e', '投资总监1', '11010215', null, null, null, null, null, '1040301', '0', '1', '74', null, '1040401', '0', '0', '1', '2014-07-22 14:09:39', '1', '2014-07-22 14:09:39');
INSERT INTO `sm_user` VALUES ('42', 'INVESTMENTDIREC2', 'e10adc3949ba59abbe56e057f20f883e', '投资总监2', '11010215', null, null, null, null, null, '1040301', '0', '1', '74', null, '1040401', '0', '0', '1', '2014-07-22 14:10:46', '1', '2014-07-22 14:10:46');
INSERT INTO `sm_user` VALUES ('43', 'INVESTMENTMANAG1', 'e10adc3949ba59abbe56e057f20f883e', '投资经理1', '11010215', null, null, null, null, null, '1040301', '0', '1', '78', null, '1040401', '0', '0', '1', '2014-07-22 14:11:18', '1', '2014-07-22 14:11:18');
INSERT INTO `sm_user` VALUES ('44', 'INVESTMENTMANAG2', 'e10adc3949ba59abbe56e057f20f883e', '投资经理2', '11010215', null, null, null, null, null, '1040301', '0', '1', '78', null, '1040401', '0', '0', '1', '2014-07-22 14:11:52', '1', '2014-07-22 14:11:52');
INSERT INTO `sm_user` VALUES ('45', 'FINANCIALMANAGE1', 'e10adc3949ba59abbe56e057f20f883e', '理财经理1', '11010215', null, null, null, null, null, '1040301', '0', '1', '78', null, '1040401', '0', '0', '1', '2014-07-22 14:12:20', '1', '2014-07-22 14:12:20');
INSERT INTO `sm_user` VALUES ('46', 'FINANCIALMANAGE2', 'e10adc3949ba59abbe56e057f20f883e', '理财经理2', '11010215', null, null, null, null, null, '1040301', '0', '1', '78', null, '1040401', '0', '0', '1', '2014-07-22 14:12:43', '1', '2014-07-22 14:12:43');
INSERT INTO `sm_user_com` VALUES ('6', '2');
INSERT INTO `sm_user_com` VALUES ('6', '3');
INSERT INTO `sm_user_com` VALUES ('6', '4');
INSERT INTO `sm_user_com` VALUES ('6', '6');
INSERT INTO `sm_user_com` VALUES ('6', '101');
INSERT INTO `sm_user_com` VALUES ('6', '90001');
INSERT INTO `sm_user_com` VALUES ('6', '110204');
INSERT INTO `sm_user_com` VALUES ('6', '110205');
INSERT INTO `sm_user_com` VALUES ('6', '110206');
INSERT INTO `sm_user_com` VALUES ('6', '110207');
INSERT INTO `sm_user_com` VALUES ('6', '110210');
INSERT INTO `sm_user_com` VALUES ('6', '110211');
INSERT INTO `sm_user_com` VALUES ('6', '110212');
INSERT INTO `sm_user_com` VALUES ('6', '110213');
INSERT INTO `sm_user_com` VALUES ('6', '110214');
INSERT INTO `sm_user_com` VALUES ('6', '990110');
INSERT INTO `sm_user_com` VALUES ('6', '990111');
INSERT INTO `sm_user_com` VALUES ('6', '990112');
INSERT INTO `sm_user_func` VALUES ('3', '22');
INSERT INTO `sm_user_func` VALUES ('3', '23');
INSERT INTO `sm_user_func` VALUES ('3', '24');
INSERT INTO `sm_user_func` VALUES ('3', '25');
INSERT INTO `sm_user_func` VALUES ('3', '26');
INSERT INTO `sm_user_func` VALUES ('3', '27');
INSERT INTO `sm_user_func` VALUES ('3', '28');
INSERT INTO `sm_user_func` VALUES ('3', '29');
INSERT INTO `sm_user_func` VALUES ('3', '30');
INSERT INTO `sm_user_func` VALUES ('3', '31');
INSERT INTO `sm_user_func` VALUES ('3', '32');
INSERT INTO `sm_user_func` VALUES ('3', '41');
INSERT INTO `sm_user_func` VALUES ('3', '42');
INSERT INTO `sm_user_func` VALUES ('3', '43');
INSERT INTO `sm_user_func` VALUES ('3', '44');
INSERT INTO `sm_user_func` VALUES ('3', '45');
INSERT INTO `sm_user_func` VALUES ('3', '46');
INSERT INTO `sm_user_func` VALUES ('3', '47');
INSERT INTO `sm_user_func` VALUES ('3', '48');
INSERT INTO `sm_user_func` VALUES ('3', '49');
INSERT INTO `sm_user_func` VALUES ('3', '50');
INSERT INTO `sm_user_func` VALUES ('3', '51');
INSERT INTO `sm_user_func` VALUES ('3', '52');
INSERT INTO `sm_user_func` VALUES ('3', '53');
INSERT INTO `sm_user_func` VALUES ('3', '54');
INSERT INTO `sm_user_func` VALUES ('3', '55');
INSERT INTO `sm_user_func` VALUES ('3', '56');
INSERT INTO `sm_user_func` VALUES ('3', '57');
INSERT INTO `sm_user_func` VALUES ('3', '58');
INSERT INTO `sm_user_func` VALUES ('3', '59');
INSERT INTO `sm_user_func` VALUES ('3', '60');
INSERT INTO `sm_user_func` VALUES ('3', '61');
INSERT INTO `sm_user_func` VALUES ('3', '62');
INSERT INTO `sm_user_func` VALUES ('3', '63');
INSERT INTO `sm_user_func` VALUES ('3', '64');
INSERT INTO `sm_user_func` VALUES ('3', '65');
INSERT INTO `sm_user_func` VALUES ('3', '67');
INSERT INTO `sm_user_func` VALUES ('3', '68');
INSERT INTO `sm_user_func` VALUES ('3', '69');
INSERT INTO `sm_user_func` VALUES ('3', '70');
INSERT INTO `sm_user_func` VALUES ('3', '71');
INSERT INTO `sm_user_func` VALUES ('3', '132');
INSERT INTO `sm_user_func` VALUES ('3', '133');
INSERT INTO `sm_user_func` VALUES ('3', '135');
INSERT INTO `sm_user_func` VALUES ('3', '136');
INSERT INTO `sm_user_func` VALUES ('3', '137');
INSERT INTO `sm_user_func` VALUES ('3', '138');
INSERT INTO `sm_user_func` VALUES ('3', '139');
INSERT INTO `sm_user_func` VALUES ('3', '140');
INSERT INTO `sm_user_func` VALUES ('3', '141');
INSERT INTO `sm_user_func` VALUES ('3', '142');
INSERT INTO `sm_user_func` VALUES ('3', '143');
INSERT INTO `sm_user_func` VALUES ('3', '144');
INSERT INTO `sm_user_func` VALUES ('3', '145');
INSERT INTO `sm_user_func` VALUES ('3', '146');
INSERT INTO `sm_user_func` VALUES ('3', '147');
INSERT INTO `sm_user_func` VALUES ('3', '149');
INSERT INTO `sm_user_func` VALUES ('3', '150');
INSERT INTO `sm_user_func` VALUES ('3', '151');
INSERT INTO `sm_user_func` VALUES ('3', '152');
INSERT INTO `sm_user_func` VALUES ('3', '153');
INSERT INTO `sm_user_func` VALUES ('3', '154');
INSERT INTO `sm_user_func` VALUES ('3', '155');
INSERT INTO `sm_user_func` VALUES ('3', '156');
INSERT INTO `sm_user_func` VALUES ('3', '157');
INSERT INTO `sm_user_func` VALUES ('3', '158');
INSERT INTO `sm_user_func` VALUES ('3', '159');
INSERT INTO `sm_user_func` VALUES ('3', '160');
INSERT INTO `sm_user_func` VALUES ('3', '161');
INSERT INTO `sm_user_func` VALUES ('3', '162');
INSERT INTO `sm_user_func` VALUES ('3', '163');
INSERT INTO `sm_user_func` VALUES ('3', '164');
INSERT INTO `sm_user_func` VALUES ('3', '165');
INSERT INTO `sm_user_func` VALUES ('3', '166');
INSERT INTO `sm_user_func` VALUES ('3', '167');
INSERT INTO `sm_user_func` VALUES ('3', '168');
INSERT INTO `sm_user_func` VALUES ('3', '169');
INSERT INTO `sm_user_func` VALUES ('3', '170');
INSERT INTO `sm_user_func` VALUES ('3', '171');
INSERT INTO `sm_user_func` VALUES ('3', '172');
INSERT INTO `sm_user_func` VALUES ('3', '173');
INSERT INTO `sm_user_func` VALUES ('3', '174');
INSERT INTO `sm_user_func` VALUES ('3', '175');
INSERT INTO `sm_user_func` VALUES ('3', '176');
INSERT INTO `sm_user_func` VALUES ('3', '177');
INSERT INTO `sm_user_func` VALUES ('3', '178');
INSERT INTO `sm_user_func` VALUES ('3', '179');
INSERT INTO `sm_user_func` VALUES ('3', '180');
INSERT INTO `sm_user_func` VALUES ('3', '181');
INSERT INTO `sm_user_func` VALUES ('3', '182');
INSERT INTO `sm_user_func` VALUES ('3', '183');
INSERT INTO `sm_user_func` VALUES ('3', '209');
INSERT INTO `sm_user_func` VALUES ('5', '22');
INSERT INTO `sm_user_func` VALUES ('5', '23');
INSERT INTO `sm_user_func` VALUES ('5', '24');
INSERT INTO `sm_user_func` VALUES ('5', '25');
INSERT INTO `sm_user_func` VALUES ('5', '26');
INSERT INTO `sm_user_func` VALUES ('5', '27');
INSERT INTO `sm_user_func` VALUES ('5', '28');
INSERT INTO `sm_user_func` VALUES ('5', '29');
INSERT INTO `sm_user_func` VALUES ('5', '30');
INSERT INTO `sm_user_func` VALUES ('5', '31');
INSERT INTO `sm_user_func` VALUES ('5', '32');
INSERT INTO `sm_user_func` VALUES ('5', '41');
INSERT INTO `sm_user_func` VALUES ('5', '42');
INSERT INTO `sm_user_func` VALUES ('5', '43');
INSERT INTO `sm_user_func` VALUES ('5', '44');
INSERT INTO `sm_user_func` VALUES ('5', '45');
INSERT INTO `sm_user_func` VALUES ('5', '46');
INSERT INTO `sm_user_func` VALUES ('5', '47');
INSERT INTO `sm_user_func` VALUES ('5', '48');
INSERT INTO `sm_user_func` VALUES ('5', '49');
INSERT INTO `sm_user_func` VALUES ('5', '50');
INSERT INTO `sm_user_func` VALUES ('5', '51');
INSERT INTO `sm_user_func` VALUES ('5', '52');
INSERT INTO `sm_user_func` VALUES ('5', '53');
INSERT INTO `sm_user_func` VALUES ('5', '54');
INSERT INTO `sm_user_func` VALUES ('5', '55');
INSERT INTO `sm_user_func` VALUES ('5', '56');
INSERT INTO `sm_user_func` VALUES ('5', '57');
INSERT INTO `sm_user_func` VALUES ('5', '58');
INSERT INTO `sm_user_func` VALUES ('5', '59');
INSERT INTO `sm_user_func` VALUES ('5', '60');
INSERT INTO `sm_user_func` VALUES ('5', '61');
INSERT INTO `sm_user_func` VALUES ('5', '62');
INSERT INTO `sm_user_func` VALUES ('5', '63');
INSERT INTO `sm_user_func` VALUES ('5', '64');
INSERT INTO `sm_user_func` VALUES ('5', '65');
INSERT INTO `sm_user_func` VALUES ('5', '67');
INSERT INTO `sm_user_func` VALUES ('5', '68');
INSERT INTO `sm_user_func` VALUES ('5', '69');
INSERT INTO `sm_user_func` VALUES ('5', '70');
INSERT INTO `sm_user_func` VALUES ('5', '71');
INSERT INTO `sm_user_func` VALUES ('5', '209');
INSERT INTO `sm_user_func` VALUES ('6', '22');
INSERT INTO `sm_user_func` VALUES ('6', '23');
INSERT INTO `sm_user_func` VALUES ('6', '24');
INSERT INTO `sm_user_func` VALUES ('6', '25');
INSERT INTO `sm_user_func` VALUES ('6', '26');
INSERT INTO `sm_user_func` VALUES ('6', '27');
INSERT INTO `sm_user_func` VALUES ('6', '28');
INSERT INTO `sm_user_func` VALUES ('6', '29');
INSERT INTO `sm_user_func` VALUES ('6', '30');
INSERT INTO `sm_user_func` VALUES ('6', '31');
INSERT INTO `sm_user_func` VALUES ('6', '32');
INSERT INTO `sm_user_func` VALUES ('6', '33');
INSERT INTO `sm_user_func` VALUES ('6', '35');
INSERT INTO `sm_user_func` VALUES ('6', '36');
INSERT INTO `sm_user_func` VALUES ('6', '37');
INSERT INTO `sm_user_func` VALUES ('6', '38');
INSERT INTO `sm_user_func` VALUES ('6', '39');
INSERT INTO `sm_user_func` VALUES ('6', '40');
INSERT INTO `sm_user_func` VALUES ('6', '41');
INSERT INTO `sm_user_func` VALUES ('6', '42');
INSERT INTO `sm_user_func` VALUES ('6', '43');
INSERT INTO `sm_user_func` VALUES ('6', '44');
INSERT INTO `sm_user_func` VALUES ('6', '45');
INSERT INTO `sm_user_func` VALUES ('6', '46');
INSERT INTO `sm_user_func` VALUES ('6', '47');
INSERT INTO `sm_user_func` VALUES ('6', '48');
INSERT INTO `sm_user_func` VALUES ('6', '49');
INSERT INTO `sm_user_func` VALUES ('6', '50');
INSERT INTO `sm_user_func` VALUES ('6', '51');
INSERT INTO `sm_user_func` VALUES ('6', '52');
INSERT INTO `sm_user_func` VALUES ('6', '53');
INSERT INTO `sm_user_func` VALUES ('6', '54');
INSERT INTO `sm_user_func` VALUES ('6', '55');
INSERT INTO `sm_user_func` VALUES ('6', '56');
INSERT INTO `sm_user_func` VALUES ('6', '57');
INSERT INTO `sm_user_func` VALUES ('6', '58');
INSERT INTO `sm_user_func` VALUES ('6', '59');
INSERT INTO `sm_user_func` VALUES ('6', '60');
INSERT INTO `sm_user_func` VALUES ('6', '61');
INSERT INTO `sm_user_func` VALUES ('6', '62');
INSERT INTO `sm_user_func` VALUES ('6', '63');
INSERT INTO `sm_user_func` VALUES ('6', '64');
INSERT INTO `sm_user_func` VALUES ('6', '65');
INSERT INTO `sm_user_func` VALUES ('6', '67');
INSERT INTO `sm_user_func` VALUES ('6', '68');
INSERT INTO `sm_user_func` VALUES ('6', '69');
INSERT INTO `sm_user_func` VALUES ('6', '70');
INSERT INTO `sm_user_func` VALUES ('6', '71');
INSERT INTO `sm_user_func` VALUES ('6', '134');
INSERT INTO `sm_user_func` VALUES ('6', '209');
INSERT INTO `sm_user_func` VALUES ('6', '140119');
INSERT INTO `sm_user_func` VALUES ('13', '22');
INSERT INTO `sm_user_func` VALUES ('13', '23');
INSERT INTO `sm_user_func` VALUES ('13', '24');
INSERT INTO `sm_user_func` VALUES ('13', '25');
INSERT INTO `sm_user_func` VALUES ('13', '26');
INSERT INTO `sm_user_func` VALUES ('13', '27');
INSERT INTO `sm_user_func` VALUES ('13', '28');
INSERT INTO `sm_user_func` VALUES ('13', '29');
INSERT INTO `sm_user_func` VALUES ('13', '30');
INSERT INTO `sm_user_func` VALUES ('13', '31');
INSERT INTO `sm_user_func` VALUES ('13', '32');
INSERT INTO `sm_user_func` VALUES ('13', '35');
INSERT INTO `sm_user_func` VALUES ('13', '36');
INSERT INTO `sm_user_func` VALUES ('13', '37');
INSERT INTO `sm_user_func` VALUES ('13', '38');
INSERT INTO `sm_user_func` VALUES ('13', '39');
INSERT INTO `sm_user_func` VALUES ('13', '40');
INSERT INTO `sm_user_func` VALUES ('13', '41');
INSERT INTO `sm_user_func` VALUES ('13', '42');
INSERT INTO `sm_user_func` VALUES ('13', '43');
INSERT INTO `sm_user_func` VALUES ('13', '44');
INSERT INTO `sm_user_func` VALUES ('13', '45');
INSERT INTO `sm_user_func` VALUES ('13', '46');
INSERT INTO `sm_user_func` VALUES ('13', '47');
INSERT INTO `sm_user_func` VALUES ('13', '48');
INSERT INTO `sm_user_func` VALUES ('13', '49');
INSERT INTO `sm_user_func` VALUES ('13', '50');
INSERT INTO `sm_user_func` VALUES ('13', '51');
INSERT INTO `sm_user_func` VALUES ('13', '52');
INSERT INTO `sm_user_func` VALUES ('13', '53');
INSERT INTO `sm_user_func` VALUES ('13', '54');
INSERT INTO `sm_user_func` VALUES ('13', '55');
INSERT INTO `sm_user_func` VALUES ('13', '56');
INSERT INTO `sm_user_func` VALUES ('13', '57');
INSERT INTO `sm_user_func` VALUES ('13', '58');
INSERT INTO `sm_user_func` VALUES ('13', '59');
INSERT INTO `sm_user_func` VALUES ('13', '60');
INSERT INTO `sm_user_func` VALUES ('13', '61');
INSERT INTO `sm_user_func` VALUES ('13', '62');
INSERT INTO `sm_user_func` VALUES ('13', '63');
INSERT INTO `sm_user_func` VALUES ('13', '64');
INSERT INTO `sm_user_func` VALUES ('13', '65');
INSERT INTO `sm_user_func` VALUES ('13', '67');
INSERT INTO `sm_user_func` VALUES ('13', '68');
INSERT INTO `sm_user_func` VALUES ('13', '69');
INSERT INTO `sm_user_func` VALUES ('13', '70');
INSERT INTO `sm_user_func` VALUES ('13', '71');
INSERT INTO `sm_user_func` VALUES ('13', '72');
INSERT INTO `sm_user_func` VALUES ('13', '73');
INSERT INTO `sm_user_func` VALUES ('13', '74');
INSERT INTO `sm_user_func` VALUES ('13', '75');
INSERT INTO `sm_user_func` VALUES ('13', '76');
INSERT INTO `sm_user_func` VALUES ('13', '77');
INSERT INTO `sm_user_func` VALUES ('13', '78');
INSERT INTO `sm_user_func` VALUES ('13', '79');
INSERT INTO `sm_user_func` VALUES ('13', '80');
INSERT INTO `sm_user_func` VALUES ('13', '81');
INSERT INTO `sm_user_func` VALUES ('13', '82');
INSERT INTO `sm_user_func` VALUES ('13', '83');
INSERT INTO `sm_user_func` VALUES ('13', '84');
INSERT INTO `sm_user_func` VALUES ('13', '85');
INSERT INTO `sm_user_func` VALUES ('13', '86');
INSERT INTO `sm_user_func` VALUES ('13', '87');
INSERT INTO `sm_user_func` VALUES ('13', '88');
INSERT INTO `sm_user_func` VALUES ('13', '89');
INSERT INTO `sm_user_func` VALUES ('13', '90');
INSERT INTO `sm_user_func` VALUES ('13', '100');
INSERT INTO `sm_user_func` VALUES ('13', '101');
INSERT INTO `sm_user_func` VALUES ('13', '102');
INSERT INTO `sm_user_func` VALUES ('13', '103');
INSERT INTO `sm_user_func` VALUES ('13', '104');
INSERT INTO `sm_user_func` VALUES ('13', '105');
INSERT INTO `sm_user_func` VALUES ('13', '106');
INSERT INTO `sm_user_func` VALUES ('13', '107');
INSERT INTO `sm_user_func` VALUES ('13', '108');
INSERT INTO `sm_user_func` VALUES ('13', '109');
INSERT INTO `sm_user_func` VALUES ('13', '110');
INSERT INTO `sm_user_func` VALUES ('13', '112');
INSERT INTO `sm_user_func` VALUES ('13', '113');
INSERT INTO `sm_user_func` VALUES ('13', '114');
INSERT INTO `sm_user_func` VALUES ('13', '115');
INSERT INTO `sm_user_func` VALUES ('13', '209');
INSERT INTO `sm_user_func` VALUES ('13', '210');
INSERT INTO `sm_user_func` VALUES ('13', '211');
INSERT INTO `sm_user_func` VALUES ('13', '212');
INSERT INTO `sm_user_func` VALUES ('13', '213');
INSERT INTO `sm_user_func` VALUES ('13', '214');
INSERT INTO `sm_user_func` VALUES ('13', '215');
INSERT INTO `sm_user_func` VALUES ('13', '216');
INSERT INTO `sm_user_func` VALUES ('13', '140113');
INSERT INTO `sm_user_func` VALUES ('13', '140115');
INSERT INTO `sm_user_func` VALUES ('13', '140116');
INSERT INTO `sm_user_func` VALUES ('13', '140153');
INSERT INTO `sm_user_func` VALUES ('13', '140154');
INSERT INTO `sm_user_func` VALUES ('13', '140156');
INSERT INTO `sm_user_func` VALUES ('15', '22');
INSERT INTO `sm_user_func` VALUES ('15', '23');
INSERT INTO `sm_user_func` VALUES ('15', '24');
INSERT INTO `sm_user_func` VALUES ('15', '25');
INSERT INTO `sm_user_func` VALUES ('15', '26');
INSERT INTO `sm_user_func` VALUES ('15', '27');
INSERT INTO `sm_user_func` VALUES ('15', '28');
INSERT INTO `sm_user_func` VALUES ('15', '29');
INSERT INTO `sm_user_func` VALUES ('15', '30');
INSERT INTO `sm_user_func` VALUES ('15', '31');
INSERT INTO `sm_user_func` VALUES ('15', '32');
INSERT INTO `sm_user_func` VALUES ('15', '34');
INSERT INTO `sm_user_func` VALUES ('15', '41');
INSERT INTO `sm_user_func` VALUES ('15', '42');
INSERT INTO `sm_user_func` VALUES ('15', '43');
INSERT INTO `sm_user_func` VALUES ('15', '44');
INSERT INTO `sm_user_func` VALUES ('15', '45');
INSERT INTO `sm_user_func` VALUES ('15', '46');
INSERT INTO `sm_user_func` VALUES ('15', '47');
INSERT INTO `sm_user_func` VALUES ('15', '48');
INSERT INTO `sm_user_func` VALUES ('15', '49');
INSERT INTO `sm_user_func` VALUES ('15', '50');
INSERT INTO `sm_user_func` VALUES ('15', '51');
INSERT INTO `sm_user_func` VALUES ('15', '52');
INSERT INTO `sm_user_func` VALUES ('15', '53');
INSERT INTO `sm_user_func` VALUES ('15', '54');
INSERT INTO `sm_user_func` VALUES ('15', '55');
INSERT INTO `sm_user_func` VALUES ('15', '56');
INSERT INTO `sm_user_func` VALUES ('15', '57');
INSERT INTO `sm_user_func` VALUES ('15', '58');
INSERT INTO `sm_user_func` VALUES ('15', '59');
INSERT INTO `sm_user_func` VALUES ('15', '60');
INSERT INTO `sm_user_func` VALUES ('15', '61');
INSERT INTO `sm_user_func` VALUES ('15', '62');
INSERT INTO `sm_user_func` VALUES ('15', '63');
INSERT INTO `sm_user_func` VALUES ('15', '64');
INSERT INTO `sm_user_func` VALUES ('15', '65');
INSERT INTO `sm_user_func` VALUES ('15', '67');
INSERT INTO `sm_user_func` VALUES ('15', '68');
INSERT INTO `sm_user_func` VALUES ('15', '69');
INSERT INTO `sm_user_func` VALUES ('15', '70');
INSERT INTO `sm_user_func` VALUES ('15', '71');
INSERT INTO `sm_user_func` VALUES ('15', '72');
INSERT INTO `sm_user_func` VALUES ('15', '73');
INSERT INTO `sm_user_func` VALUES ('15', '74');
INSERT INTO `sm_user_func` VALUES ('15', '75');
INSERT INTO `sm_user_func` VALUES ('15', '76');
INSERT INTO `sm_user_func` VALUES ('15', '77');
INSERT INTO `sm_user_func` VALUES ('15', '78');
INSERT INTO `sm_user_func` VALUES ('15', '79');
INSERT INTO `sm_user_func` VALUES ('15', '80');
INSERT INTO `sm_user_func` VALUES ('15', '81');
INSERT INTO `sm_user_func` VALUES ('15', '82');
INSERT INTO `sm_user_func` VALUES ('15', '83');
INSERT INTO `sm_user_func` VALUES ('15', '84');
INSERT INTO `sm_user_func` VALUES ('15', '85');
INSERT INTO `sm_user_func` VALUES ('15', '86');
INSERT INTO `sm_user_func` VALUES ('15', '87');
INSERT INTO `sm_user_func` VALUES ('15', '88');
INSERT INTO `sm_user_func` VALUES ('15', '89');
INSERT INTO `sm_user_func` VALUES ('15', '90');
INSERT INTO `sm_user_func` VALUES ('15', '100');
INSERT INTO `sm_user_func` VALUES ('15', '101');
INSERT INTO `sm_user_func` VALUES ('15', '102');
INSERT INTO `sm_user_func` VALUES ('15', '103');
INSERT INTO `sm_user_func` VALUES ('15', '104');
INSERT INTO `sm_user_func` VALUES ('15', '105');
INSERT INTO `sm_user_func` VALUES ('15', '106');
INSERT INTO `sm_user_func` VALUES ('15', '107');
INSERT INTO `sm_user_func` VALUES ('15', '108');
INSERT INTO `sm_user_func` VALUES ('15', '109');
INSERT INTO `sm_user_func` VALUES ('15', '121');
INSERT INTO `sm_user_func` VALUES ('15', '122');
INSERT INTO `sm_user_func` VALUES ('15', '123');
INSERT INTO `sm_user_func` VALUES ('15', '124');
INSERT INTO `sm_user_func` VALUES ('15', '125');
INSERT INTO `sm_user_func` VALUES ('15', '126');
INSERT INTO `sm_user_func` VALUES ('15', '127');
INSERT INTO `sm_user_func` VALUES ('15', '128');
INSERT INTO `sm_user_func` VALUES ('15', '129');
INSERT INTO `sm_user_func` VALUES ('15', '130');
INSERT INTO `sm_user_func` VALUES ('15', '131');
INSERT INTO `sm_user_func` VALUES ('15', '132');
INSERT INTO `sm_user_func` VALUES ('15', '133');
INSERT INTO `sm_user_func` VALUES ('15', '135');
INSERT INTO `sm_user_func` VALUES ('15', '136');
INSERT INTO `sm_user_func` VALUES ('15', '137');
INSERT INTO `sm_user_func` VALUES ('15', '138');
INSERT INTO `sm_user_func` VALUES ('15', '139');
INSERT INTO `sm_user_func` VALUES ('15', '140');
INSERT INTO `sm_user_func` VALUES ('15', '141');
INSERT INTO `sm_user_func` VALUES ('15', '142');
INSERT INTO `sm_user_func` VALUES ('15', '143');
INSERT INTO `sm_user_func` VALUES ('15', '144');
INSERT INTO `sm_user_func` VALUES ('15', '145');
INSERT INTO `sm_user_func` VALUES ('15', '146');
INSERT INTO `sm_user_func` VALUES ('15', '147');
INSERT INTO `sm_user_func` VALUES ('15', '149');
INSERT INTO `sm_user_func` VALUES ('15', '150');
INSERT INTO `sm_user_func` VALUES ('15', '151');
INSERT INTO `sm_user_func` VALUES ('15', '152');
INSERT INTO `sm_user_func` VALUES ('15', '153');
INSERT INTO `sm_user_func` VALUES ('15', '154');
INSERT INTO `sm_user_func` VALUES ('15', '155');
INSERT INTO `sm_user_func` VALUES ('15', '156');
INSERT INTO `sm_user_func` VALUES ('15', '157');
INSERT INTO `sm_user_func` VALUES ('15', '158');
INSERT INTO `sm_user_func` VALUES ('15', '159');
INSERT INTO `sm_user_func` VALUES ('15', '160');
INSERT INTO `sm_user_func` VALUES ('15', '161');
INSERT INTO `sm_user_func` VALUES ('15', '162');
INSERT INTO `sm_user_func` VALUES ('15', '163');
INSERT INTO `sm_user_func` VALUES ('15', '164');
INSERT INTO `sm_user_func` VALUES ('15', '165');
INSERT INTO `sm_user_func` VALUES ('15', '166');
INSERT INTO `sm_user_func` VALUES ('15', '167');
INSERT INTO `sm_user_func` VALUES ('15', '168');
INSERT INTO `sm_user_func` VALUES ('15', '169');
INSERT INTO `sm_user_func` VALUES ('15', '170');
INSERT INTO `sm_user_func` VALUES ('15', '171');
INSERT INTO `sm_user_func` VALUES ('15', '172');
INSERT INTO `sm_user_func` VALUES ('15', '173');
INSERT INTO `sm_user_func` VALUES ('15', '174');
INSERT INTO `sm_user_func` VALUES ('15', '175');
INSERT INTO `sm_user_func` VALUES ('15', '176');
INSERT INTO `sm_user_func` VALUES ('15', '177');
INSERT INTO `sm_user_func` VALUES ('15', '178');
INSERT INTO `sm_user_func` VALUES ('15', '179');
INSERT INTO `sm_user_func` VALUES ('15', '180');
INSERT INTO `sm_user_func` VALUES ('15', '181');
INSERT INTO `sm_user_func` VALUES ('15', '182');
INSERT INTO `sm_user_func` VALUES ('15', '183');
INSERT INTO `sm_user_func` VALUES ('15', '184');
INSERT INTO `sm_user_func` VALUES ('15', '185');
INSERT INTO `sm_user_func` VALUES ('15', '186');
INSERT INTO `sm_user_func` VALUES ('15', '187');
INSERT INTO `sm_user_func` VALUES ('15', '188');
INSERT INTO `sm_user_func` VALUES ('15', '189');
INSERT INTO `sm_user_func` VALUES ('15', '190');
INSERT INTO `sm_user_func` VALUES ('15', '191');
INSERT INTO `sm_user_func` VALUES ('15', '192');
INSERT INTO `sm_user_func` VALUES ('15', '193');
INSERT INTO `sm_user_func` VALUES ('15', '194');
INSERT INTO `sm_user_func` VALUES ('15', '195');
INSERT INTO `sm_user_func` VALUES ('15', '196');
INSERT INTO `sm_user_func` VALUES ('15', '197');
INSERT INTO `sm_user_func` VALUES ('15', '198');
INSERT INTO `sm_user_func` VALUES ('15', '199');
INSERT INTO `sm_user_func` VALUES ('15', '200');
INSERT INTO `sm_user_func` VALUES ('15', '201');
INSERT INTO `sm_user_func` VALUES ('15', '202');
INSERT INTO `sm_user_func` VALUES ('15', '203');
INSERT INTO `sm_user_func` VALUES ('15', '204');
INSERT INTO `sm_user_func` VALUES ('15', '205');
INSERT INTO `sm_user_func` VALUES ('15', '207');
INSERT INTO `sm_user_func` VALUES ('15', '209');
INSERT INTO `sm_user_func` VALUES ('15', '140111');
INSERT INTO `sm_user_func` VALUES ('15', '140112');
INSERT INTO `sm_user_func` VALUES ('34', '34');
INSERT INTO `sm_user_func` VALUES ('34', '132');
INSERT INTO `sm_user_func` VALUES ('34', '133');
INSERT INTO `sm_user_func` VALUES ('34', '135');
INSERT INTO `sm_user_func` VALUES ('34', '136');
INSERT INTO `sm_user_func` VALUES ('34', '137');
INSERT INTO `sm_user_func` VALUES ('34', '138');
INSERT INTO `sm_user_func` VALUES ('34', '139');
INSERT INTO `sm_user_func` VALUES ('34', '140');
INSERT INTO `sm_user_func` VALUES ('34', '141');
INSERT INTO `sm_user_func` VALUES ('34', '142');
INSERT INTO `sm_user_func` VALUES ('34', '143');
INSERT INTO `sm_user_func` VALUES ('34', '144');
INSERT INTO `sm_user_func` VALUES ('34', '145');
INSERT INTO `sm_user_func` VALUES ('34', '146');
INSERT INTO `sm_user_func` VALUES ('34', '147');
INSERT INTO `sm_user_func` VALUES ('34', '158');
INSERT INTO `sm_user_func` VALUES ('34', '159');
INSERT INTO `sm_user_role` VALUES ('1', '1');
INSERT INTO `sm_user_role` VALUES ('6', '1');
INSERT INTO `sm_user_role` VALUES ('7', '1');
INSERT INTO `sm_user_role` VALUES ('1', '2');
INSERT INTO `sm_user_role` VALUES ('1', '3');
INSERT INTO `sm_user_role` VALUES ('1', '6');
INSERT INTO `sm_user_role` VALUES ('36', '6');
INSERT INTO `sm_user_role` VALUES ('1', '7');
INSERT INTO `sm_user_role` VALUES ('37', '7');
INSERT INTO `sm_user_role` VALUES ('38', '7');
INSERT INTO `sm_user_role` VALUES ('1', '8');
INSERT INTO `sm_user_role` VALUES ('39', '8');
INSERT INTO `sm_user_role` VALUES ('40', '8');
INSERT INTO `sm_user_role` VALUES ('1', '9');
INSERT INTO `sm_user_role` VALUES ('41', '9');
INSERT INTO `sm_user_role` VALUES ('42', '9');
INSERT INTO `sm_user_role` VALUES ('1', '10');
INSERT INTO `sm_user_role` VALUES ('43', '10');
INSERT INTO `sm_user_role` VALUES ('44', '10');
INSERT INTO `sm_user_role` VALUES ('1', '11');
INSERT INTO `sm_user_role` VALUES ('45', '11');
INSERT INTO `sm_user_role` VALUES ('46', '11');
INSERT INTO `sm_user_role` VALUES ('1', '22');
INSERT INTO `sm_user_role` VALUES ('36', '9999');
INSERT INTO `sm_user_role` VALUES ('37', '9999');
INSERT INTO `sm_user_role` VALUES ('38', '9999');
INSERT INTO `sm_user_role` VALUES ('39', '9999');
INSERT INTO `sm_user_role` VALUES ('40', '9999');
INSERT INTO `sm_user_role` VALUES ('41', '9999');
INSERT INTO `sm_user_role` VALUES ('42', '9999');
INSERT INTO `sm_user_role` VALUES ('43', '9999');
INSERT INTO `sm_user_role` VALUES ('44', '9999');
INSERT INTO `sm_user_role` VALUES ('45', '9999');
INSERT INTO `sm_user_role` VALUES ('46', '9999');
INSERT INTO `sm_workbanch` VALUES ('1', '/customer/lead/query.do', '线索', 'lead', 'list', '49%', '', '1', '3', '1', '2014-07-09 11:12:13', '2014-07-14 18:28:01');
INSERT INTO `sm_workbanch` VALUES ('2', '/project/supplier/query.do', '供应商', 'supplier', 'list', '49%', '', '1', '3', '1', '2014-07-09 11:12:21', '2014-07-16 23:09:02');
INSERT INTO `sm_workbanch` VALUES ('3', '/customer/customer/query.do', '客户', 'customer', 'list', '99%', '', '1', '4', '1', '2014-07-09 15:40:13', '2014-07-16 23:09:02');
INSERT INTO `sm_workbanch` VALUES ('4', '/customer/contact/query.do', '联系人', 'contact', 'list', '49%', '', '1', '2', '1', '2014-07-09 15:44:00', '2014-07-16 23:09:02');
INSERT INTO `sm_workbanch` VALUES ('5', '/hxtd/customer/lead/query.do', '全文', 'lead', 'list', '49%', null, '1', '2', '1', '2014-07-16 22:21:59', '2014-07-16 22:24:22');
INSERT INTO `sm_workbanch` VALUES ('6', '/customer/customer/query.do', '阿斯顿', 'customer', 'list', '99%', null, '1', '1', '1', '2014-07-16 22:23:16', '2014-07-16 23:09:02');
INSERT INTO `sm_workbanch` VALUES ('7', '/customer/lead/query.do', '全文', 'lead', 'list', '49%', null, '1', '0', '1', '2014-07-16 22:38:10', '2014-07-16 23:09:02');
INSERT INTO `sm_workbanch` VALUES ('8', '/customer/lead/query.do', 'ff ', 'lead', 'list', '49%', 'today', '1', '4', '1', '2014-07-16 22:40:57', '2014-07-16 23:09:02');
INSERT INTO `sm_workbanch` VALUES ('9', '/customer/lead/query.do', 'asd ', 'lead', 'list', '49%', 'today', '1', '3', '1', '2014-07-16 23:10:50', '2014-07-17 18:27:28');
INSERT INTO `sm_workbanch` VALUES ('10', '/common/report/reportWorkbanch.comp?id=8', '报表', 'report', 'report', '49%', '', '1', '0', '1', '2014-07-17 17:12:39', '2014-07-17 18:27:28');
INSERT INTO `sm_workbanch` VALUES ('11', '/common/report/reportWorkbanch.comp?id=7', '报表2', 'report', 'report', '49%', '', '1', '2', '1', '2014-07-17 17:13:20', '2014-07-17 18:27:28');
INSERT INTO `sm_workbanch` VALUES ('12', '/project/project/query.do', '项目列表', 'project', 'list', '99%', 'today', '1', '4', '1', '2014-07-17 17:34:50', '2014-07-17 18:10:22');
INSERT INTO `sm_workbanch` VALUES ('13', '/common/report/reportWorkbanch.comp?id=7', 'asdasd', '请选择', 'report', '49%', 'today', '1', '1', '1', '2014-07-17 18:09:52', '2014-07-17 18:27:28');
INSERT INTO `sm_workbanch` VALUES ('14', '/common/report/reportWorkbanch.comp?id=7', '测试报表', 'report', 'report', '49%', 'today', '1', '3', '1', '2014-07-17 18:22:37', '2014-07-17 18:27:28');
INSERT INTO `sm_workbanch` VALUES ('15', '/customer/lead/query.do', '爱仕达', 'lead', 'list', '49%', 'today', '1', '3', '1', '2014-07-17 18:25:10', '2014-07-17 18:27:28');
INSERT INTO `sm_workbanch` VALUES ('16', '/common/report/reportWorkbanch.comp?id=6', '啊啊啊', 'report', 'report', '49%', 'today', '1', '3', '1', '2014-07-17 18:25:27', '2014-07-17 18:27:28');
INSERT INTO `sm_workbanch` VALUES ('17', '/common/report/reportWorkbanch.comp?id=6', 'vc', 'report', 'report', '49%', 'today', '1', '0', '1', '2014-07-17 18:27:20', '2014-07-17 19:59:39');
INSERT INTO `sm_workbanch` VALUES ('18', '/common/report/reportWorkbanch.comp?id=7', '爱仕达', 'report', 'report', '49%', 'today', '1', '0', '1', '2014-07-17 18:27:39', '2014-07-17 19:59:39');
INSERT INTO `sm_workbanch` VALUES ('19', '', '', '', 'list', '49%', '', '1', '0', '1', '2014-07-17 18:38:44', '2014-07-17 18:39:07');
INSERT INTO `sm_workbanch` VALUES ('20', '', '', '', '', '49%', '', '1', '0', '1', '2014-07-17 18:39:09', '2014-07-17 18:39:28');
INSERT INTO `sm_workbanch` VALUES ('21', '', '', '请选择', '', '49%', 'today', '1', '0', '1', '2014-07-17 19:25:10', '2014-07-17 19:43:24');
INSERT INTO `sm_workbanch` VALUES ('22', '', '', '请选择', '', '49%', 'today', '1', '0', '1', '2014-07-17 19:25:16', '2014-07-17 19:43:24');
INSERT INTO `sm_workbanch` VALUES ('23', '', '', '请选择', '', '49%', 'today', '1', '0', '1', '2014-07-17 19:25:20', '2014-07-17 19:43:24');
INSERT INTO `sm_workbanch` VALUES ('24', '/customer/contact/query.do', '', 'contact', 'list', '49%', 'today', '1', '0', '1', '2014-07-17 19:25:27', '2014-07-17 19:59:39');
INSERT INTO `sm_workbanch` VALUES ('25', '', '', '请选择', '', '49%', 'today', '1', '0', '1', '2014-07-17 19:27:20', '2014-07-17 19:43:24');
INSERT INTO `sm_workbanch` VALUES ('26', '', '', '请选择', '', '49%', 'today', '1', '0', '1', '2014-07-17 19:27:39', '2014-07-17 19:43:24');
INSERT INTO `sm_workbanch` VALUES ('27', '', '', '', '', '49%', '', '1', '0', '1', '2014-07-17 19:31:46', '2014-07-17 19:43:08');
INSERT INTO `sm_workbanch` VALUES ('28', '', '', '', 'list', '49%', '', '1', '0', '1', '2014-07-17 19:33:26', '2014-07-17 19:43:04');
INSERT INTO `sm_workbanch` VALUES ('29', '', '', '', '', '49%', '', '1', '0', '1', '2014-07-17 19:33:40', '2014-07-17 19:43:01');
INSERT INTO `sm_workbanch` VALUES ('30', '', '', '', '', '49%', '', '1', '0', '1', '2014-07-17 19:35:03', '2014-07-17 19:42:58');
INSERT INTO `sm_workbanch` VALUES ('31', '/customer/lead/query.do', '今日线索', 'lead', 'list', '49%', 'today', '1', '2', '0', '2014-07-17 20:02:34', '2014-07-21 13:24:11');
INSERT INTO `sm_workbanch` VALUES ('32', '/customer/customer/query.do', '啊啊', 'customer', 'list', '49%', 'today', '1', '0', '0', '2014-07-17 20:03:46', '2014-07-18 21:10:52');
INSERT INTO `sm_workbanch` VALUES ('33', '/customer/contact/query.do', '按时打算的', 'contact', 'list', '49%', 'today', '1', '1', '0', '2014-07-17 20:04:23', '2014-07-21 13:24:11');
INSERT INTO `sm_workbanch` VALUES ('34', '/common/report/reportWorkbanch.comp?id=7', '让他', 'report', 'report', '99%', '', '1', '0', '1', '2014-07-17 20:09:41', '2014-07-18 17:40:59');
INSERT INTO `sm_workbanch` VALUES ('35', '/customer/contact/query.do', '联系人0', 'contact', 'list', '49%', 'today', '1', '0', '1', '2014-07-18 17:39:03', '2014-07-18 17:40:21');
INSERT INTO `sm_workbanch` VALUES ('36', '', '测试报表', '请选择', 'report', '49%', 'today', '1', '0', '1', '2014-07-18 17:39:57', '2014-07-18 17:40:51');
INSERT INTO `sm_workbanch` VALUES ('37', '/customer/customer/query.do', '舅舅家', 'customer', 'list', '49%', 'today', '1', '2', '0', '2014-07-21 13:41:55', '2014-07-21 13:41:55');
INSERT INTO `sm_workbanch` VALUES ('38', '/common/report/reportWorkbanch.comp?id=7', '1是', 'report', 'report', '49%', '', '1', '2', '0', '2014-07-21 13:42:49', '2014-07-21 13:42:49');
INSERT INTO `sm_workbanch` VALUES ('39', '/customer/lead/query.do', 'uu', 'lead', 'list', '49%', 'today', '1', '2', '0', '2014-07-21 13:48:14', '2014-07-21 13:48:14');
INSERT INTO `sm_workbanch` VALUES ('40', '/customer/customer/query.do', '爱仕达', 'customer', 'list', '49%', 'week', '1', '2', '0', '2014-07-21 13:49:11', '2014-07-21 13:49:11');
INSERT INTO `sm_workbanch` VALUES ('41', '/customer/lead/query.do', '线索', 'lead', 'list', '49%', 'today', '1', '2', '0', '2014-07-21 18:05:00', '2014-07-21 18:05:00');
INSERT INTO `supplier` VALUES ('3', 'admin', '5010101', '', '1', '', '', '', '4030301', '', '140000', '140400', '140411', '', '', '', '1', '1', '2014-07-14 14:11:00', '1', '2014-07-14 14:12:57');
INSERT INTO `supplier` VALUES ('4', 'admin', '5010101', '', '3', '', '', '', '4030302', '', '130000', '130300', '130302', '', '', '', '1', '1', '2014-07-14 14:17:17', '1', '2014-07-14 14:18:38');
INSERT INTO `supplier` VALUES ('5', '东北大庆油田集团公司', '5010102', '', '1', '', '', '', '4030302', '', '140000', '140300', '140303', '', '', '', '0', '1', '2014-07-21 19:33:15', '1', '2014-07-21 19:33:15');
INSERT INTO `supplier` VALUES ('16', '供应商1', '5010101', '百会公司', '1', '789654123', '13698754698', '23546987854', '4030301', '13698754698', '110000', '110000', '110108', '362356687@qq.com', '花园北路14号环星大厦D座二层', '无', '0', '1', '2014-07-21 11:33:49', '1', '2014-07-21 11:33:49');
INSERT INTO `sysmessage` VALUES ('1', '企鹅我去额', 'afd\ndasw\n', '1', '2014-07-14 14:42:39', '0', '1', '2014-07-14 14:42:16');
INSERT INTO `sysmessage` VALUES ('2', '往前冲', '  sdas\n sdfs  ', '3', '2014-07-14 16:00:47', '0', '3', '2014-07-14 16:00:23');
INSERT INTO `sysmessage` VALUES ('3', '你好', '你好欢迎使用强大为', '1', '2014-07-16 16:45:54', '0', '1', '2014-07-16 16:46:00');
INSERT INTO `sysmessage` VALUES ('4', '测试', '侧手册', '1', '2014-07-16 16:50:49', '0', '1', '2014-07-16 16:50:54');
INSERT INTO `sysmessage` VALUES ('5', '我好想睡觉', '我好想睡觉', '1', '2014-07-16 16:53:14', '0', '1', '2014-07-16 16:53:19');
INSERT INTO `sysmessage` VALUES ('6', '123', '1234', '1', '2014-07-16 16:55:11', '0', '1', '2014-07-16 16:55:16');
INSERT INTO `sysmessage` VALUES ('7', '你好', '你好呀，大哥', '1', '2014-07-16 17:02:15', '0', '1', '2014-07-16 17:02:21');
INSERT INTO `sysmessage` VALUES ('8', '你好呀', '你好呀', '1', '2014-07-16 17:03:49', '0', '1', '2014-07-16 17:03:54');
INSERT INTO `sysmessage` VALUES ('9', '你好呀', '你好呀', '1', '2014-07-16 17:08:26', '0', '1', '2014-07-16 17:08:31');
INSERT INTO `sysmessage` VALUES ('10', '你好呀', '你好呀', '1', '2014-07-16 17:09:12', '0', '1', '2014-07-16 17:09:17');
INSERT INTO `sysmessage` VALUES ('11', 'sa', 'sa', '1', '2014-07-17 14:18:59', '0', '1', '2014-07-17 14:18:52');
INSERT INTO `sysmessage` VALUES ('12', 'sa', 'sa', '1', '2014-07-17 14:20:34', '0', '1', '2014-07-17 14:20:27');
INSERT INTO `sysmessage` VALUES ('13', 'dddd', 'f', '1', '2014-07-17 14:21:30', '0', '1', '2014-07-17 14:21:22');
INSERT INTO `sysmessage` VALUES ('14', 'sa', 'sa', '1', '2014-07-17 14:25:13', '0', '1', '2014-07-17 14:25:05');
INSERT INTO `sysmessage` VALUES ('15', '实用硬件防火墙', '如何感知用户网络行为,实现对用户网络行为的审计,并根据审计结果对用户网络行为进行控制,一直是网络管理者关注却难以解决的问题.针对硬件防火墙系统的特点,设计了一个安全,实用的日志审计系统.系统的设计原则是以日志的形式详细记录用户的网络活动.该系统的审计目的是监视、记录和控制用户网络行为,为管理员提供决策依据,并且提供日志作为事后追查的证据.应用结果表明,该系统能帮助管理员有效地管理网络,提高系统的安全性能', '15', '2014-07-18 11:53:13', '0', '15', '2014-07-18 11:53:04');
INSERT INTO `user_message` VALUES ('1', '1', '3', '0', '1', '0', '2014-07-14 14:42:39', '2014-07-14 14:43:10');
INSERT INTO `user_message` VALUES ('2', '1', '3', '0', '0', '0', '2014-07-14 14:42:39', '2014-07-14 14:42:16');
INSERT INTO `user_message` VALUES ('3', '2', '1', '0', '1', '0', '2014-07-14 16:00:47', '2014-07-14 16:00:23');
INSERT INTO `user_message` VALUES ('4', '2', '1', '1', '0', '0', '2014-07-14 16:00:47', '2014-07-14 17:39:49');
INSERT INTO `user_message` VALUES ('5', '3', '8', '0', '1', '0', '2014-07-16 16:46:00', '2014-07-16 16:46:00');
INSERT INTO `user_message` VALUES ('6', '3', '8', '0', '0', '0', '2014-07-16 16:46:00', '2014-07-16 16:46:00');
INSERT INTO `user_message` VALUES ('7', '4', '7', '0', '1', '0', '2014-07-16 16:50:54', '2014-07-16 16:50:54');
INSERT INTO `user_message` VALUES ('8', '4', '7', '0', '0', '0', '2014-07-16 16:50:54', '2014-07-16 16:50:54');
INSERT INTO `user_message` VALUES ('9', '4', '8', '0', '1', '0', '2014-07-16 16:50:55', '2014-07-16 16:50:55');
INSERT INTO `user_message` VALUES ('10', '4', '8', '0', '0', '0', '2014-07-16 16:50:55', '2014-07-16 16:50:55');
INSERT INTO `user_message` VALUES ('11', '4', '6', '0', '1', '0', '2014-07-16 16:50:55', '2014-07-16 16:50:55');
INSERT INTO `user_message` VALUES ('12', '4', '6', '0', '0', '0', '2014-07-16 16:50:55', '2014-07-16 16:50:55');
INSERT INTO `user_message` VALUES ('13', '5', '6', '0', '1', '0', '2014-07-16 16:53:19', '2014-07-16 16:53:19');
INSERT INTO `user_message` VALUES ('14', '5', '6', '0', '0', '0', '2014-07-16 16:53:19', '2014-07-16 16:53:19');
INSERT INTO `user_message` VALUES ('15', '5', '7', '0', '1', '0', '2014-07-16 16:53:20', '2014-07-16 16:53:20');
INSERT INTO `user_message` VALUES ('16', '5', '7', '0', '0', '0', '2014-07-16 16:53:20', '2014-07-16 16:53:20');
INSERT INTO `user_message` VALUES ('17', '5', '8', '0', '1', '0', '2014-07-16 16:53:20', '2014-07-16 16:53:20');
INSERT INTO `user_message` VALUES ('18', '5', '8', '0', '0', '0', '2014-07-16 16:53:20', '2014-07-16 16:53:20');
INSERT INTO `user_message` VALUES ('19', '5', '5', '0', '1', '0', '2014-07-16 16:53:21', '2014-07-16 16:53:21');
INSERT INTO `user_message` VALUES ('20', '5', '5', '0', '0', '0', '2014-07-16 16:53:21', '2014-07-16 16:53:21');
INSERT INTO `user_message` VALUES ('21', '5', '3', '0', '1', '0', '2014-07-16 16:53:21', '2014-07-16 16:53:21');
INSERT INTO `user_message` VALUES ('22', '5', '3', '0', '0', '0', '2014-07-16 16:53:21', '2014-07-16 16:53:21');
INSERT INTO `user_message` VALUES ('23', '6', '6', '0', '1', '0', '2014-07-16 16:55:16', '2014-07-16 16:55:16');
INSERT INTO `user_message` VALUES ('24', '6', '6', '0', '0', '0', '2014-07-16 16:55:17', '2014-07-16 16:55:17');
INSERT INTO `user_message` VALUES ('25', '6', '7', '1', '1', '0', '2014-07-16 16:55:17', '2014-07-16 16:56:06');
INSERT INTO `user_message` VALUES ('26', '6', '7', '0', '0', '0', '2014-07-16 16:55:17', '2014-07-16 16:55:17');
INSERT INTO `user_message` VALUES ('27', '6', '8', '0', '1', '0', '2014-07-16 16:55:17', '2014-07-16 16:55:17');
INSERT INTO `user_message` VALUES ('28', '6', '8', '0', '0', '0', '2014-07-16 16:55:17', '2014-07-16 16:55:17');
INSERT INTO `user_message` VALUES ('29', '7', '3', '0', '1', '0', '2014-07-16 17:02:21', '2014-07-16 17:02:21');
INSERT INTO `user_message` VALUES ('30', '7', '3', '0', '0', '0', '2014-07-16 17:02:21', '2014-07-16 17:02:21');
INSERT INTO `user_message` VALUES ('31', '8', '3', '1', '1', '0', '2014-07-16 17:03:54', '2014-07-16 17:08:07');
INSERT INTO `user_message` VALUES ('32', '8', '3', '0', '0', '0', '2014-07-16 17:03:54', '2014-07-16 17:03:54');
INSERT INTO `user_message` VALUES ('33', '9', '6', '0', '1', '0', '2014-07-16 17:08:31', '2014-07-16 17:08:31');
INSERT INTO `user_message` VALUES ('34', '9', '6', '0', '0', '0', '2014-07-16 17:08:31', '2014-07-16 17:08:31');
INSERT INTO `user_message` VALUES ('35', '9', '7', '0', '1', '0', '2014-07-16 17:08:32', '2014-07-16 17:08:32');
INSERT INTO `user_message` VALUES ('36', '9', '7', '0', '0', '0', '2014-07-16 17:08:32', '2014-07-16 17:08:32');
INSERT INTO `user_message` VALUES ('37', '9', '8', '1', '1', '0', '2014-07-16 17:08:32', '2014-07-16 17:08:56');
INSERT INTO `user_message` VALUES ('38', '9', '8', '0', '0', '0', '2014-07-16 17:08:32', '2014-07-16 17:08:32');
INSERT INTO `user_message` VALUES ('39', '10', '8', '0', '1', '0', '2014-07-16 17:09:18', '2014-07-16 17:09:18');
INSERT INTO `user_message` VALUES ('40', '10', '8', '0', '0', '0', '2014-07-16 17:09:18', '2014-07-16 17:09:18');
INSERT INTO `user_message` VALUES ('41', '10', '6', '0', '1', '0', '2014-07-16 17:09:18', '2014-07-16 17:09:18');
INSERT INTO `user_message` VALUES ('42', '10', '6', '0', '0', '0', '2014-07-16 17:09:18', '2014-07-16 17:09:18');
INSERT INTO `user_message` VALUES ('43', '10', '7', '1', '1', '0', '2014-07-16 17:09:19', '2014-07-18 13:20:01');
INSERT INTO `user_message` VALUES ('44', '10', '7', '0', '0', '0', '2014-07-16 17:09:19', '2014-07-16 17:09:19');
INSERT INTO `user_message` VALUES ('45', '10', '3', '0', '1', '0', '2014-07-16 17:09:19', '2014-07-16 17:09:19');
INSERT INTO `user_message` VALUES ('46', '10', '3', '0', '0', '0', '2014-07-16 17:09:19', '2014-07-16 17:09:19');
INSERT INTO `user_message` VALUES ('47', '10', '5', '0', '1', '0', '2014-07-16 17:09:19', '2014-07-16 17:09:20');
INSERT INTO `user_message` VALUES ('48', '10', '5', '0', '0', '0', '2014-07-16 17:09:20', '2014-07-16 17:09:20');
INSERT INTO `user_message` VALUES ('49', '10', '9', '0', '1', '0', '2014-07-16 17:09:20', '2014-07-16 17:09:20');
INSERT INTO `user_message` VALUES ('50', '10', '9', '0', '0', '0', '2014-07-16 17:09:20', '2014-07-16 17:09:20');
INSERT INTO `user_message` VALUES ('51', '10', '12', '0', '1', '1', '2014-07-16 17:09:20', '2014-07-22 14:24:25');
INSERT INTO `user_message` VALUES ('52', '10', '12', '0', '0', '0', '2014-07-16 17:09:20', '2014-07-16 17:09:20');
INSERT INTO `user_message` VALUES ('53', '10', '11', '0', '1', '1', '2014-07-16 17:09:21', '2014-07-16 17:10:58');
INSERT INTO `user_message` VALUES ('54', '10', '11', '0', '0', '0', '2014-07-16 17:09:21', '2014-07-16 17:09:21');
INSERT INTO `user_message` VALUES ('55', '10', '10', '1', '1', '1', '2014-07-16 17:09:21', '2014-07-22 14:25:14');
INSERT INTO `user_message` VALUES ('56', '10', '10', '0', '0', '0', '2014-07-16 17:09:21', '2014-07-16 17:09:21');
INSERT INTO `user_message` VALUES ('57', '11', '3', '0', '1', '1', '2014-07-17 14:18:52', '2014-07-22 14:17:39');
INSERT INTO `user_message` VALUES ('58', '11', '3', '0', '0', '0', '2014-07-17 14:18:52', '2014-07-17 14:18:52');
INSERT INTO `user_message` VALUES ('59', '12', '3', '1', '1', '0', '2014-07-17 14:20:27', '2014-07-17 14:24:53');
INSERT INTO `user_message` VALUES ('60', '12', '3', '0', '0', '0', '2014-07-17 14:20:27', '2014-07-17 14:20:27');
INSERT INTO `user_message` VALUES ('62', '13', '3', '0', '0', '0', '2014-07-17 14:21:22', '2014-07-17 14:21:22');
INSERT INTO `user_message` VALUES ('63', '14', '25', '0', '1', '1', '2014-07-17 14:25:06', '2014-07-22 14:00:40');
INSERT INTO `user_message` VALUES ('64', '14', '25', '0', '0', '0', '2014-07-17 14:25:06', '2014-07-17 14:25:06');
INSERT INTO `user_message` VALUES ('65', '15', '1', '0', '1', '0', '2014-07-18 11:53:04', '2014-07-18 11:53:04');
INSERT INTO `user_message` VALUES ('66', '15', '1', '1', '0', '0', '2014-07-18 11:53:04', '2014-07-18 13:15:40');
INSERT INTO `user_message` VALUES ('67', '15', '25', '0', '1', '0', '2014-07-18 11:53:04', '2014-07-18 11:53:04');
INSERT INTO `user_message` VALUES ('68', '15', '25', '0', '0', '0', '2014-07-18 11:53:04', '2014-07-18 11:53:04');
INSERT INTO `user_message` VALUES ('69', '15', '6', '0', '1', '0', '2014-07-18 11:53:04', '2014-07-18 11:53:04');
INSERT INTO `user_message` VALUES ('70', '15', '6', '0', '0', '0', '2014-07-18 11:53:04', '2014-07-18 11:53:04');
INSERT INTO `user_message` VALUES ('71', '15', '7', '0', '1', '0', '2014-07-18 11:53:05', '2014-07-18 11:53:05');
INSERT INTO `user_message` VALUES ('72', '15', '7', '0', '0', '0', '2014-07-18 11:53:05', '2014-07-18 11:53:05');
INSERT INTO `user_message` VALUES ('73', '15', '8', '0', '1', '0', '2014-07-18 11:53:05', '2014-07-18 11:53:05');
INSERT INTO `user_message` VALUES ('74', '15', '8', '0', '0', '0', '2014-07-18 11:53:05', '2014-07-18 11:53:05');
INSERT INTO `user_message` VALUES ('75', '15', '23', '0', '1', '0', '2014-07-18 11:53:05', '2014-07-18 11:53:05');
INSERT INTO `user_message` VALUES ('76', '15', '23', '0', '0', '0', '2014-07-18 11:53:05', '2014-07-18 11:53:05');
INSERT INTO `user_message` VALUES ('77', '15', '5', '0', '1', '0', '2014-07-18 11:53:05', '2014-07-18 11:53:05');
INSERT INTO `user_message` VALUES ('78', '15', '5', '0', '0', '0', '2014-07-18 11:53:05', '2014-07-18 11:53:05');
INSERT INTO `user_message` VALUES ('79', '15', '3', '0', '1', '0', '2014-07-18 11:53:06', '2014-07-18 11:53:06');
INSERT INTO `user_message` VALUES ('80', '15', '3', '0', '0', '0', '2014-07-18 11:53:06', '2014-07-18 11:53:06');
INSERT INTO `user_message` VALUES ('81', '15', '18', '0', '1', '0', '2014-07-18 11:53:06', '2014-07-18 11:53:06');
INSERT INTO `user_message` VALUES ('82', '15', '18', '0', '0', '0', '2014-07-18 11:53:06', '2014-07-18 11:53:06');
INSERT INTO `user_message` VALUES ('83', '15', '16', '0', '1', '0', '2014-07-18 11:53:06', '2014-07-18 11:53:06');
INSERT INTO `user_message` VALUES ('84', '15', '16', '0', '0', '0', '2014-07-18 11:53:06', '2014-07-18 11:53:06');
INSERT INTO `user_message` VALUES ('85', '15', '14', '0', '1', '0', '2014-07-18 11:53:06', '2014-07-18 11:53:06');
INSERT INTO `user_message` VALUES ('86', '15', '14', '0', '0', '0', '2014-07-18 11:53:06', '2014-07-18 11:53:06');
INSERT INTO `user_message` VALUES ('87', '15', '19', '0', '1', '0', '2014-07-18 11:53:07', '2014-07-18 11:53:07');
INSERT INTO `user_message` VALUES ('88', '15', '19', '0', '0', '0', '2014-07-18 11:53:07', '2014-07-18 11:53:07');
INSERT INTO `user_message` VALUES ('89', '15', '17', '0', '1', '0', '2014-07-18 11:53:07', '2014-07-18 11:53:07');
INSERT INTO `user_message` VALUES ('90', '15', '17', '0', '0', '0', '2014-07-18 11:53:07', '2014-07-18 11:53:07');
INSERT INTO `user_message` VALUES ('91', '15', '24', '0', '1', '0', '2014-07-18 11:53:07', '2014-07-18 11:53:07');
INSERT INTO `user_message` VALUES ('92', '15', '24', '0', '0', '0', '2014-07-18 11:53:07', '2014-07-18 11:53:07');
INSERT INTO `user_message` VALUES ('93', '15', '21', '0', '1', '0', '2014-07-18 11:53:07', '2014-07-18 11:53:07');
INSERT INTO `user_message` VALUES ('94', '15', '21', '0', '0', '0', '2014-07-18 11:53:07', '2014-07-18 11:53:08');
INSERT INTO `user_message` VALUES ('95', '15', '9', '0', '1', '0', '2014-07-18 11:53:08', '2014-07-18 11:53:08');
INSERT INTO `user_message` VALUES ('96', '15', '9', '0', '0', '0', '2014-07-18 11:53:08', '2014-07-18 11:53:08');
INSERT INTO `user_message` VALUES ('97', '15', '11', '0', '1', '0', '2014-07-18 11:53:08', '2014-07-18 11:53:08');
INSERT INTO `user_message` VALUES ('98', '15', '11', '0', '0', '0', '2014-07-18 11:53:08', '2014-07-18 11:53:08');
INSERT INTO `user_message` VALUES ('99', '15', '10', '0', '1', '0', '2014-07-18 11:53:08', '2014-07-18 11:53:08');
INSERT INTO `user_message` VALUES ('100', '15', '10', '0', '0', '0', '2014-07-18 11:53:08', '2014-07-18 11:53:08');
INSERT INTO `user_message` VALUES ('101', '15', '12', '0', '1', '0', '2014-07-18 11:53:08', '2014-07-18 11:53:08');
INSERT INTO `user_message` VALUES ('102', '15', '12', '0', '0', '0', '2014-07-18 11:53:08', '2014-07-18 11:53:08');
INSERT INTO `user_message` VALUES ('103', '15', '13', '0', '1', '0', '2014-07-18 11:53:09', '2014-07-18 11:53:09');
INSERT INTO `user_message` VALUES ('104', '15', '13', '0', '0', '0', '2014-07-18 11:53:09', '2014-07-18 11:53:09');
INSERT INTO `user_message` VALUES ('105', '15', '20', '0', '1', '0', '2014-07-18 11:53:09', '2014-07-18 11:53:09');
INSERT INTO `user_message` VALUES ('106', '15', '20', '0', '0', '0', '2014-07-18 11:53:09', '2014-07-18 11:53:09');
INSERT INTO `user_message` VALUES ('107', '15', '22', '0', '1', '0', '2014-07-18 11:53:09', '2014-07-18 11:53:09');
INSERT INTO `user_message` VALUES ('108', '15', '22', '0', '0', '0', '2014-07-18 11:53:09', '2014-07-18 11:53:09');
INSERT INTO `wf_node` VALUES ('8', '060100', '开始', '99020101', null, '1');
INSERT INTO `wf_node` VALUES ('9', '060101', '理财经理审核', '99020101', '11', '2');
INSERT INTO `wf_node` VALUES ('10', '060102', '投资经理审核', '99020101', '10', '2');
INSERT INTO `wf_node` VALUES ('11', '060103', '投资总监审核', '99020101', '9', '2');
INSERT INTO `wf_node` VALUES ('12', '060104', '副总裁审核', '99020101', '7', '2');
INSERT INTO `wf_node` VALUES ('13', '060105', '总裁审核', '99020101', '6', '2');
INSERT INTO `wf_node` VALUES ('14', '060106', '财务审核', '99020101', '8', '2');
INSERT INTO `wf_node` VALUES ('15', '060107', '结束', '99020101', null, '3');
INSERT INTO `wf_task` VALUES ('1', '8', '8', '1', null, '13', null, '2014-07-22 21:02:22', null, '13', '2014-07-22 21:02:22', '13', '2014-07-22 21:02:22');
INSERT INTO `wf_task` VALUES ('2', '9', '8', '1', null, '45', null, null, null, '13', '2014-07-22 21:02:22', '13', '2014-07-22 21:02:22');
INSERT INTO `wf_task` VALUES ('3', '10', '8', '1', null, '43', null, null, null, '13', '2014-07-22 21:02:22', '13', '2014-07-22 21:02:22');
INSERT INTO `wf_task` VALUES ('4', '11', '8', '1', null, '41', null, null, null, '13', '2014-07-22 21:02:22', '13', '2014-07-22 21:02:22');
INSERT INTO `wf_task` VALUES ('5', '12', '8', '1', null, '1', null, null, null, '13', '2014-07-22 21:02:22', '13', '2014-07-22 21:02:22');
INSERT INTO `wf_task` VALUES ('6', '13', '8', '1', null, '1', null, null, null, '13', '2014-07-22 21:02:22', '13', '2014-07-22 21:02:22');
INSERT INTO `wf_task` VALUES ('7', '14', '8', '1', null, '1', null, null, null, '13', '2014-07-22 21:02:22', '13', '2014-07-22 21:02:22');
INSERT INTO `wf_task` VALUES ('8', '15', '8', '1', null, null, null, null, null, '13', '2014-07-22 21:02:22', '13', '2014-07-22 21:02:22');
