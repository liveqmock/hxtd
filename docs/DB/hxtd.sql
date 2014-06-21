/*
Navicat MySQL Data Transfer

Source Server         : 192.168.111.141
Source Server Version : 50517
Source Host           : 192.168.111.141:3306
Source Database       : hxtd

Target Server Type    : MYSQL
Target Server Version : 50517
File Encoding         : 65001

Date: 2014-05-04 11:40:39
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ACCOUNT_OWNER` int(11) DEFAULT NULL,
  `NAME` varchar(64) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL COMMENT '客户类型',
  `SOURCE` varchar(256) DEFAULT NULL,
  `RISK_GRADE` int(11) DEFAULT NULL COMMENT '风险等级',
  `CARD_TYPE` int(11) DEFAULT NULL,
  `CARD_NUM` varchar(64) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  `MOBILE` varchar(32) DEFAULT NULL,
  `POST_CODE` varchar(16) DEFAULT NULL,
  `FAX` varchar(16) DEFAULT NULL,
  `COMPANY` varchar(64) DEFAULT NULL,
  `OPEN_BANK` varchar(64) DEFAULT NULL,
  `BANK_NAME` varchar(64) DEFAULT NULL,
  `BANK_ACCOUNT` varchar(64) DEFAULT NULL,
  `OWNERSHIP` varchar(64) DEFAULT NULL COMMENT '所有权',
  `INDUSTRY` varchar(64) DEFAULT NULL COMMENT '行业',
  `PROVINCE` int(11) DEFAULT NULL,
  `CITY` int(11) DEFAULT NULL,
  `COUNTY` int(11) DEFAULT NULL,
  `ADDRESS` varchar(255) DEFAULT NULL,
  `REMARK` varchar(512) DEFAULT NULL COMMENT '备注',
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ACCOUNT_OWNER` (`ACCOUNT_OWNER`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`ACCOUNT_OWNER`) REFERENCES `sm_user` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------

-- ----------------------------
-- Table structure for `contact`
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TYPE` int(11) DEFAULT NULL,
  `SUPPLIER_ID` int(11) DEFAULT NULL,
  `OWNER` int(11) DEFAULT NULL,
  `ANME` varchar(64) DEFAULT NULL COMMENT '联系人姓名',
  `DEPARTMENT` varchar(32) DEFAULT NULL,
  `POSITION` varchar(32) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  `MOBILE` varchar(23) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `FAX` varchar(32) DEFAULT NULL,
  `POST_CODE` varchar(32) DEFAULT NULL,
  `PROVINCE` int(11) DEFAULT NULL,
  `CITY` int(11) DEFAULT NULL,
  `COUNTY` int(11) DEFAULT NULL,
  `ADDRESS` varchar(512) DEFAULT NULL,
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contact
-- ----------------------------

-- ----------------------------
-- Table structure for `contract`
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORDER_ID` int(11) DEFAULT NULL,
  `ACCOUNT_ID` int(11) DEFAULT NULL,
  `NAME` varchar(128) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `GATHER_CODE` varchar(128) DEFAULT NULL COMMENT '收款书编号',
  `REDEEM_TYPE` int(11) DEFAULT NULL COMMENT '赎回方式',
  `CONTENT` text,
  `SIGN_TIME` datetime DEFAULT NULL,
  `EFFECT_TIME` datetime DEFAULT NULL,
  `BEREFT_TIME` datetime DEFAULT NULL,
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contract
-- ----------------------------

-- ----------------------------
-- Table structure for `lead`
-- ----------------------------
DROP TABLE IF EXISTS `lead`;
CREATE TABLE `lead` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '线索ID ',
  `OWNER` int(11) DEFAULT NULL COMMENT '线索所有者',
  `COMPANY` varchar(64) DEFAULT NULL COMMENT '公司名称',
  `NAME` varchar(64) DEFAULT NULL COMMENT '姓名',
  `DEPARTMENT` varchar(64) DEFAULT NULL COMMENT '部门',
  `POSITION` varchar(64) DEFAULT NULL COMMENT '职位',
  `EMAIL` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `PHONE` varchar(32) DEFAULT NULL COMMENT '电话',
  `FAX` varchar(32) DEFAULT NULL COMMENT '传真',
  `MOBILE` varchar(32) DEFAULT NULL COMMENT '手机',
  `SOURCE` varchar(256) DEFAULT NULL COMMENT '线索来源',
  `STATUS` int(11) DEFAULT NULL COMMENT '线索状态',
  `TYPE` int(11) DEFAULT NULL COMMENT '证件类型',
  `CARD_NUM` varchar(64) DEFAULT NULL COMMENT '证件号码',
  `INDUSTRY` varchar(64) DEFAULT NULL COMMENT '行业',
  `POST_CODE` varchar(16) DEFAULT NULL COMMENT '邮编',
  `ADDRESS` varchar(256) DEFAULT NULL COMMENT '详细地址',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '备注',
  `CREATER` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lead
-- ----------------------------

-- ----------------------------
-- Table structure for `market_activity`
-- ----------------------------
DROP TABLE IF EXISTS `market_activity`;
CREATE TABLE `market_activity` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(128) DEFAULT NULL COMMENT '活动名称',
  `TYPE` int(4) DEFAULT NULL COMMENT '活动类型',
  `ACTIVITY_STATUS` int(4) DEFAULT NULL COMMENT '活动状态',
  `BEGIN_DATA` date DEFAULT NULL COMMENT '开始日期',
  `END_DATA` date DEFAULT NULL COMMENT '结束日期',
  `PREDICT_COST` float(10,0) DEFAULT NULL COMMENT '预计成本',
  `REALITY_COST` float(10,0) DEFAULT NULL COMMENT '实际成本',
  `TIMES` int(4) DEFAULT NULL COMMENT '活动次数',
  `EXPECT_EFFECT` varchar(256) DEFAULT NULL COMMENT '预期效果',
  `EXPECT_SUCCESS_RATE` float(6,0) DEFAULT NULL COMMENT '期望成功率',
  `STATUS` int(4) DEFAULT NULL COMMENT '审批状态',
  `SPONSOR` int(11) DEFAULT NULL COMMENT '发起者',
  `BOSSHEAD` int(11) DEFAULT NULL COMMENT '负责人',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '备注',
  `CREATER` int(11) DEFAULT NULL COMMENT '创建者',
  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `MODIFIER` int(11) DEFAULT NULL COMMENT '最后修改者',
  `MODIFIED_TIME` datetime DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of market_activity
-- ----------------------------

-- ----------------------------
-- Table structure for `memoir`
-- ----------------------------
DROP TABLE IF EXISTS `memoir`;
CREATE TABLE `memoir` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TYPE` int(11) DEFAULT NULL,
  `MODULE_ID` int(11) DEFAULT NULL,
  `DEPARTMENT_ID` int(11) DEFAULT NULL,
  `EMPLOYEE_ID` int(11) DEFAULT NULL,
  `SUMMARY` varchar(1024) DEFAULT NULL COMMENT '纪要内容',
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of memoir
-- ----------------------------

-- ----------------------------
-- Table structure for `memoir_user`
-- ----------------------------
DROP TABLE IF EXISTS `memoir_user`;
CREATE TABLE `memoir_user` (
  `ID` int(11) NOT NULL,
  `MEMOIR_ID` int(11) DEFAULT NULL COMMENT '纪要ID',
  `USER_ID` int(11) DEFAULT NULL COMMENT '人员ID',
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of memoir_user
-- ----------------------------

-- ----------------------------
-- Table structure for `msg_user`
-- ----------------------------
DROP TABLE IF EXISTS `msg_user`;
CREATE TABLE `msg_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MSG_ID` int(11) DEFAULT NULL,
  `USER_ID` int(11) DEFAULT NULL,
  `STATUS` int(11) DEFAULT '0' COMMENT '已/未读 1已读 0未读',
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of msg_user
-- ----------------------------

-- ----------------------------
-- Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(255) DEFAULT NULL,
  `CONTENT` varchar(255) DEFAULT NULL,
  `SENT_TIME` datetime DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PRODUCT_ID` int(11) DEFAULT NULL,
  `ACCOUNT_ID` int(11) DEFAULT NULL,
  `NO` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `INVESTMENT_WAY` int(11) DEFAULT NULL COMMENT '投资方式',
  `PURCHASE_MONEY` float(10,0) DEFAULT NULL COMMENT '购买金额',
  `EARNING_RATE` float(10,0) DEFAULT NULL COMMENT '收益率',
  `ADVANCE_REDEEM_RATE` float(10,0) DEFAULT NULL COMMENT '提前赎回率',
  `REDEEM_FORMULA` varchar(128) DEFAULT NULL COMMENT '赎回公式',
  `SALES_PERSON` int(11) DEFAULT NULL,
  `SALES_MANAGER` int(11) DEFAULT NULL,
  `SALES_MAJORDOMO` int(11) DEFAULT NULL,
  `ORDER_END_TIME` datetime DEFAULT NULL,
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROJECT_ID` int(11) DEFAULT NULL,
  `NAME` varchar(128) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `START_SELL_MONEY` float(10,0) DEFAULT NULL,
  `MIN_ERNING_RATE` float(10,0) DEFAULT NULL,
  `MAX_ERNING_RATE` float(10,0) DEFAULT NULL,
  `EXPECT_PROFIT` float(10,0) DEFAULT NULL,
  `SALE_LIMIT` int(11) DEFAULT NULL,
  `SALE_UNIT` int(11) DEFAULT NULL,
  `SALE_BEGIN_TIME` datetime DEFAULT NULL,
  `SALE_END_TIME` datetime DEFAULT NULL,
  `ADVANCE_REDEEM_RATE` float(10,0) DEFAULT NULL COMMENT '提前赎回率',
  `ADVANCE_REDEEM_FORMULA` varchar(216) DEFAULT NULL COMMENT '提前赎回公式',
  `IS_EFFECT` char(1) DEFAULT NULL,
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------

-- ----------------------------
-- Table structure for `project`
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SUPPLIER_ID` int(11) DEFAULT NULL,
  `NO` varchar(64) DEFAULT NULL COMMENT '项目编号',
  `NAME` varchar(128) DEFAULT NULL,
  `FINANCE_LIMIT` float(10,0) DEFAULT NULL COMMENT '融资额度',
  `BEGIN_TIME` datetime DEFAULT NULL,
  `BEFORE_FINANCE_CYCLE` int(11) DEFAULT NULL COMMENT '融资前周期(天)',
  `FINANCE_CYCLE` int(11) DEFAULT NULL COMMENT '融资周期',
  `OPEN_TIME` datetime DEFAULT NULL,
  `DENDLINE_TIME` datetime DEFAULT NULL,
  `EARNING_RATE` float(10,0) DEFAULT NULL COMMENT '收益率',
  `ADVANCE_REDEEM_RATE` float(10,0) DEFAULT NULL COMMENT '提前赎回率',
  `PAY_TYPE` int(11) DEFAULT NULL,
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project
-- ----------------------------

-- ----------------------------
-- Table structure for `sales_target`
-- ----------------------------
DROP TABLE IF EXISTS `sales_target`;
CREATE TABLE `sales_target` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) DEFAULT NULL COMMENT '机构id',
  `BARGAIN_MONEY` float(10,0) DEFAULT NULL COMMENT '目标成交金额',
  `UNIT` int(11) DEFAULT NULL COMMENT '1年份 2 月份 3季度',
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sales_target
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_component`
-- ----------------------------
DROP TABLE IF EXISTS `sm_component`;
CREATE TABLE `sm_component` (
  `COM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `COM_NO` varchar(32) DEFAULT NULL,
  `COM_NAME` varchar(64) DEFAULT NULL,
  `COM_URL` varchar(64) DEFAULT NULL COMMENT '组件调用入口',
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`COM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_component
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `sm_dictionary`;
CREATE TABLE `sm_dictionary` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KEY` varchar(64) DEFAULT NULL,
  `VALUE` varchar(64) DEFAULT NULL,
  `PARENT_ID` int(11) DEFAULT NULL,
  `FULLNAME` varchar(64) DEFAULT NULL,
  `SIMPLENAME` varchar(64) DEFAULT NULL,
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_dictionary
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_function`
-- ----------------------------
DROP TABLE IF EXISTS `sm_function`;
CREATE TABLE `sm_function` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MENU_ID` int(11) DEFAULT NULL,
  `FUNC_CODE` varchar(32) DEFAULT NULL,
  `FUNC_NAME` varchar(64) DEFAULT NULL,
  `FUNC_URL` varchar(64) DEFAULT NULL COMMENT '功能调用入口',
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_function
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sm_menu`;
CREATE TABLE `sm_menu` (
  `ID` int(11) NOT NULL,
  `NO` varchar(32) DEFAULT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `PARENT_MENU_ID` int(11) DEFAULT NULL,
  `MENU_URL` varchar(64) DEFAULT NULL,
  `IS_ACTIVE` char(1) DEFAULT '1' COMMENT '是否启用 1启用0禁用',
  `ORDER` int(11) DEFAULT NULL,
  `MUNE_SEQ` int(11) DEFAULT NULL,
  `MENU_LEVEL` int(11) DEFAULT NULL,
  `OPEN_TYPE` int(11) DEFAULT NULL,
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_menu
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_org`
-- ----------------------------
DROP TABLE IF EXISTS `sm_org`;
CREATE TABLE `sm_org` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NO` varchar(32) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `PARENT_ORG_ID` int(11) DEFAULT NULL,
  `SHORT_NAME` varchar(64) DEFAULT NULL COMMENT '机构简称',
  `FULL_NAME` varchar(128) DEFAULT NULL COMMENT '机构全称',
  `ADDRESS` varchar(512) DEFAULT NULL,
  `ZIP_CODE` varchar(32) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `WEB_SITE` varchar(64) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `ORDER` int(11) DEFAULT NULL COMMENT '排列顺序',
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_org
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_position`
-- ----------------------------
DROP TABLE IF EXISTS `sm_position`;
CREATE TABLE `sm_position` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NO` varchar(32) DEFAULT NULL,
  `NAME` varchar(64) DEFAULT NULL,
  `PARENT_POS_ID` int(11) DEFAULT NULL COMMENT '上级岗位ID',
  `PARTY_ID` int(11) DEFAULT NULL COMMENT '隶属组织ID',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '排列顺序',
  `STATUS` int(11) DEFAULT NULL,
  `REMARK` varchar(215) DEFAULT NULL,
  `CREATEOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_position
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role`;
CREATE TABLE `sm_role` (
  `ROLE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `NO` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `REMARK` varchar(255) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_role
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_role_com`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role_com`;
CREATE TABLE `sm_role_com` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ROLE_ID` int(11) DEFAULT NULL,
  `COM_ID` int(11) DEFAULT NULL COMMENT '组件ID',
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_role_com
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_role_func`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role_func`;
CREATE TABLE `sm_role_func` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ROLE_ID` int(11) DEFAULT NULL,
  `FUNC_ID` int(11) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_role_func
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_trace_log`
-- ----------------------------
DROP TABLE IF EXISTS `sm_trace_log`;
CREATE TABLE `sm_trace_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LOG_NAME` varchar(64) DEFAULT NULL,
  `LOG_TIME` datetime DEFAULT NULL,
  `LOG_LEVEL` int(11) DEFAULT NULL,
  `MESSAGE` text,
  `USER_ID` int(11) DEFAULT NULL,
  `USER_NAME` varchar(64) DEFAULT NULL,
  `FUN_NAME` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_trace_log
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user`;
CREATE TABLE `sm_user` (
  `USER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `LOGIN_NAME` varchar(32) DEFAULT NULL,
  `PASSWORD` varchar(64) DEFAULT NULL,
  `NO` varchar(32) DEFAULT NULL,
  `USER_NAME` varchar(32) DEFAULT NULL,
  `ORDER` int(11) DEFAULT NULL COMMENT '排列顺序',
  `IS_ACTIVE` char(1) DEFAULT NULL,
  `JOB_SITUATION` int(11) DEFAULT NULL COMMENT '在岗情况',
  `SEX` char(1) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  `MOBILE` varchar(32) DEFAULT NULL COMMENT '手机号码',
  `EMAIL` varchar(32) DEFAULT NULL,
  `QQ` varchar(16) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `JOB_NAME` varchar(64) DEFAULT NULL,
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_user
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user_com`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_com`;
CREATE TABLE `sm_user_com` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL,
  `COM_ID` int(11) DEFAULT NULL,
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_user_com
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user_func`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_func`;
CREATE TABLE `sm_user_func` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL,
  `FUNC_ID` int(11) DEFAULT NULL,
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_user_func
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user_org`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_org`;
CREATE TABLE `sm_user_org` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL,
  `ORG_ID` int(11) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_user_org
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user_position`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_position`;
CREATE TABLE `sm_user_position` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL,
  `POS_ID` int(11) DEFAULT NULL,
  `CREATEOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_user_position
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_role`;
CREATE TABLE `sm_user_role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL,
  `ROLE_ID` int(11) DEFAULT NULL,
  `IS_ACTIVE` char(255) DEFAULT '1' COMMENT '是否启用 1启用 0禁用',
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_user_role
-- ----------------------------

-- ----------------------------
-- Table structure for `supplier`
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NMAE` varchar(64) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL COMMENT '供应商分类',
  `PHONE` varchar(32) DEFAULT NULL,
  `MOBILE` varchar(32) DEFAULT NULL,
  `FAX` varchar(32) DEFAULT NULL,
  `PROVINCE` int(11) DEFAULT NULL,
  `CITY` int(11) DEFAULT NULL,
  `COUNTY` int(11) DEFAULT NULL,
  `ADDRESS` varchar(512) DEFAULT NULL,
  `REMARK` varchar(512) DEFAULT NULL,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of supplier
-- ----------------------------

-- ----------------------------
-- Table structure for `sysmessage`
-- ----------------------------
DROP TABLE IF EXISTS `sysmessage`;
CREATE TABLE `sysmessage` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(64) DEFAULT NULL,
  `CONTENT` text,
  `CREATOR` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `MODIFIER` int(11) DEFAULT NULL,
  `MODIFIED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysmessage
-- ----------------------------
