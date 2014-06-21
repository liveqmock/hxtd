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
USE hxtd;
SET FOREIGN_KEY_CHECKS = 0;
-- ----------------------------
-- Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `ACCOUNT_OWNER` INT(11) DEFAULT NULL,
  `NAME`          VARCHAR(64) DEFAULT NULL,
  `TYPE`          INT(11) DEFAULT NULL
  COMMENT '客户类型',
  `SOURCE`        VARCHAR(256) DEFAULT NULL,
  `RISK_GRADE`    INT(11) DEFAULT NULL
  COMMENT '风险等级',
  `CARD_TYPE`     INT(11) DEFAULT NULL,
  `CARD_NUM`      VARCHAR(64) DEFAULT NULL,
  `PHONE`         VARCHAR(32) DEFAULT NULL,
  `MOBILE`        VARCHAR(32) DEFAULT NULL,
  `POST_CODE`     VARCHAR(16) DEFAULT NULL,
  `FAX`           VARCHAR(16) DEFAULT NULL,
  `COMPANY`       VARCHAR(64) DEFAULT NULL,
  `OPEN_BANK`     VARCHAR(64) DEFAULT NULL,
  `BANK_NAME`     VARCHAR(64) DEFAULT NULL,
  `BANK_ACCOUNT`  VARCHAR(64) DEFAULT NULL,
  `OWNERSHIP`     VARCHAR(64) DEFAULT NULL
  COMMENT '所有权',
  `INDUSTRY`      VARCHAR(64) DEFAULT NULL
  COMMENT '行业',
  `PROVINCE`      INT(11) DEFAULT NULL,
  `CITY`          INT(11) DEFAULT NULL,
  `COUNTY`        INT(11) DEFAULT NULL,
  `ADDRESS`       VARCHAR(255) DEFAULT NULL,
  `REMARK`        VARCHAR(512) DEFAULT NULL
  COMMENT '备注',
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ACCOUNT_OWNER` (`ACCOUNT_OWNER`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`ACCOUNT_OWNER`) REFERENCES `sm_user` (`USER_ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of account
-- ----------------------------

-- ----------------------------
-- Table structure for `contact`
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `TYPE`          INT(11) DEFAULT NULL,
  `SUPPLIER_ID`   INT(11) DEFAULT NULL,
  `OWNER`         INT(11) DEFAULT NULL,
  `ANME`          VARCHAR(64) DEFAULT NULL
  COMMENT '联系人姓名',
  `DEPARTMENT`    VARCHAR(32) DEFAULT NULL,
  `POSITION`      VARCHAR(32) DEFAULT NULL,
  `PHONE`         VARCHAR(32) DEFAULT NULL,
  `MOBILE`        VARCHAR(23) DEFAULT NULL,
  `EMAIL`         VARCHAR(32) DEFAULT NULL,
  `FAX`           VARCHAR(32) DEFAULT NULL,
  `POST_CODE`     VARCHAR(32) DEFAULT NULL,
  `PROVINCE`      INT(11) DEFAULT NULL,
  `CITY`          INT(11) DEFAULT NULL,
  `COUNTY`        INT(11) DEFAULT NULL,
  `ADDRESS`       VARCHAR(512) DEFAULT NULL,
  `REMARK`        VARCHAR(512) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of contact
-- ----------------------------

-- ----------------------------
-- Table structure for `contract`
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `ORDER_ID`      INT(11) DEFAULT NULL,
  `ACCOUNT_ID`    INT(11) DEFAULT NULL,
  `NAME`          VARCHAR(128) DEFAULT NULL,
  `CODE`          VARCHAR(32) DEFAULT NULL,
  `TYPE`          INT(11) DEFAULT NULL,
  `GATHER_CODE`   VARCHAR(128) DEFAULT NULL
  COMMENT '收款书编号',
  `REDEEM_TYPE`   INT(11) DEFAULT NULL
  COMMENT '赎回方式',
  `CONTENT`       TEXT,
  `SIGN_TIME`     DATETIME DEFAULT NULL,
  `EFFECT_TIME`   DATETIME DEFAULT NULL,
  `BEREFT_TIME`   DATETIME DEFAULT NULL,
  `REMARK`        VARCHAR(512) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of contract
-- ----------------------------

-- ----------------------------
-- Table structure for `lead`
-- ----------------------------
DROP TABLE IF EXISTS `lead`;
CREATE TABLE `lead` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT COMMENT '线索ID ',
  `OWNER`         INT(11) DEFAULT NULL
  COMMENT '线索所有者',
  `COMPANY`       VARCHAR(64) DEFAULT NULL
  COMMENT '公司名称',
  `NAME`          VARCHAR(64) DEFAULT NULL
  COMMENT '姓名',
  `DEPARTMENT`    VARCHAR(64) DEFAULT NULL
  COMMENT '部门',
  `POSITION`      VARCHAR(64) DEFAULT NULL
  COMMENT '职位',
  `EMAIL`         VARCHAR(64) DEFAULT NULL
  COMMENT '邮箱',
  `PHONE`         VARCHAR(32) DEFAULT NULL
  COMMENT '电话',
  `FAX`           VARCHAR(32) DEFAULT NULL
  COMMENT '传真',
  `MOBILE`        VARCHAR(32) DEFAULT NULL
  COMMENT '手机',
  `SOURCE`        VARCHAR(256) DEFAULT NULL
  COMMENT '线索来源',
  `STATUS`        INT(11) DEFAULT NULL
  COMMENT '线索状态',
  `TYPE`          INT(11) DEFAULT NULL
  COMMENT '证件类型',
  `CARD_NUM`      VARCHAR(64) DEFAULT NULL
  COMMENT '证件号码',
  `INDUSTRY`      VARCHAR(64) DEFAULT NULL
  COMMENT '行业',
  `POST_CODE`     VARCHAR(16) DEFAULT NULL
  COMMENT '邮编',
  `ADDRESS`       VARCHAR(256) DEFAULT NULL
  COMMENT '详细地址',
  `REMARK`        VARCHAR(512) DEFAULT NULL
  COMMENT '备注',
  `CREATER`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of lead
-- ----------------------------

-- ----------------------------
-- Table structure for `market_activity`
-- ----------------------------
DROP TABLE IF EXISTS `market_activity`;
CREATE TABLE `market_activity` (
  `ID`                  INT(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME`                VARCHAR(128) DEFAULT NULL
  COMMENT '活动名称',
  `TYPE`                INT(4) DEFAULT NULL
  COMMENT '活动类型',
  `ACTIVITY_STATUS`     INT(4) DEFAULT NULL
  COMMENT '活动状态',
  `BEGIN_DATA`          DATE DEFAULT NULL
  COMMENT '开始日期',
  `END_DATA`            DATE DEFAULT NULL
  COMMENT '结束日期',
  `PREDICT_COST`        FLOAT(10, 0) DEFAULT NULL
  COMMENT '预计成本',
  `REALITY_COST`        FLOAT(10, 0) DEFAULT NULL
  COMMENT '实际成本',
  `TIMES`               INT(4) DEFAULT NULL
  COMMENT '活动次数',
  `EXPECT_EFFECT`       VARCHAR(256) DEFAULT NULL
  COMMENT '预期效果',
  `EXPECT_SUCCESS_RATE` FLOAT(6, 0) DEFAULT NULL
  COMMENT '期望成功率',
  `STATUS`              INT(4) DEFAULT NULL
  COMMENT '审批状态',
  `SPONSOR`             INT(11) DEFAULT NULL
  COMMENT '发起者',
  `BOSSHEAD`            INT(11) DEFAULT NULL
  COMMENT '负责人',
  `REMARK`              VARCHAR(512) DEFAULT NULL
  COMMENT '备注',
  `CREATER`             INT(11) DEFAULT NULL
  COMMENT '创建者',
  `CREATED_TIME`        DATETIME DEFAULT NULL
  COMMENT '创建时间',
  `MODIFIER`            INT(11) DEFAULT NULL
  COMMENT '最后修改者',
  `MODIFIED_TIME`       DATETIME DEFAULT NULL
  COMMENT '最后修改时间',
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of market_activity
-- ----------------------------

-- ----------------------------
-- Table structure for `memoir`
-- ----------------------------
DROP TABLE IF EXISTS `memoir`;
CREATE TABLE `memoir` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `TYPE`          INT(11) DEFAULT NULL,
  `MODULE_ID`     INT(11) DEFAULT NULL,
  `DEPARTMENT_ID` INT(11) DEFAULT NULL,
  `EMPLOYEE_ID`   INT(11) DEFAULT NULL,
  `SUMMARY`       VARCHAR(1024) DEFAULT NULL
  COMMENT '纪要内容',
  `REMARK`        VARCHAR(512) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of memoir
-- ----------------------------

-- ----------------------------
-- Table structure for `memoir_user`
-- ----------------------------
DROP TABLE IF EXISTS `memoir_user`;
CREATE TABLE `memoir_user` (
  `ID`            INT(11) NOT NULL,
  `MEMOIR_ID`     INT(11) DEFAULT NULL
  COMMENT '纪要ID',
  `USER_ID`       INT(11) DEFAULT NULL
  COMMENT '人员ID',
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of memoir_user
-- ----------------------------

-- ----------------------------
-- Table structure for `msg_user`
-- ----------------------------
DROP TABLE IF EXISTS `msg_user`;
CREATE TABLE `msg_user` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `MSG_ID`        INT(11) DEFAULT NULL,
  `USER_ID`       INT(11) DEFAULT NULL,
  `STATUS`        INT(11) DEFAULT '0'
  COMMENT '已/未读 1已读 0未读',
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of msg_user
-- ----------------------------

-- ----------------------------
-- Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `TITLE`         VARCHAR(255) DEFAULT NULL,
  `CONTENT`       VARCHAR(255) DEFAULT NULL,
  `SENT_TIME`     DATETIME DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `ID`                  INT(11) NOT NULL AUTO_INCREMENT,
  `PRODUCT_ID`          INT(11) DEFAULT NULL,
  `ACCOUNT_ID`          INT(11) DEFAULT NULL,
  `NO`                  VARCHAR(32) DEFAULT NULL,
  `STATUS`              INT(11) DEFAULT NULL,
  `INVESTMENT_WAY`      INT(11) DEFAULT NULL
  COMMENT '投资方式',
  `PURCHASE_MONEY`      FLOAT(10, 0) DEFAULT NULL
  COMMENT '购买金额',
  `EARNING_RATE`        FLOAT(10, 0) DEFAULT NULL
  COMMENT '收益率',
  `ADVANCE_REDEEM_RATE` FLOAT(10, 0) DEFAULT NULL
  COMMENT '提前赎回率',
  `REDEEM_FORMULA`      VARCHAR(128) DEFAULT NULL
  COMMENT '赎回公式',
  `SALES_PERSON`        INT(11) DEFAULT NULL,
  `SALES_MANAGER`       INT(11) DEFAULT NULL,
  `SALES_MAJORDOMO`     INT(11) DEFAULT NULL,
  `ORDER_END_TIME`      DATETIME DEFAULT NULL,
  `REMARK`              VARCHAR(512) DEFAULT NULL,
  `CREATOR`             INT(11) DEFAULT NULL,
  `CREATED_TIME`        DATETIME DEFAULT NULL,
  `MODIFIER`            INT(11) DEFAULT NULL,
  `MODIFIED_TIME`       DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `ID`                     INT(11) NOT NULL AUTO_INCREMENT,
  `PROJECT_ID`             INT(11) DEFAULT NULL,
  `NAME`                   VARCHAR(128) DEFAULT NULL,
  `CODE`                   VARCHAR(32) DEFAULT NULL,
  `TYPE`                   INT(11) DEFAULT NULL,
  `START_SELL_MONEY`       FLOAT(10, 0) DEFAULT NULL,
  `MIN_ERNING_RATE`        FLOAT(10, 0) DEFAULT NULL,
  `MAX_ERNING_RATE`        FLOAT(10, 0) DEFAULT NULL,
  `EXPECT_PROFIT`          FLOAT(10, 0) DEFAULT NULL,
  `SALE_LIMIT`             INT(11) DEFAULT NULL,
  `SALE_UNIT`              INT(11) DEFAULT NULL,
  `SALE_BEGIN_TIME`        DATETIME DEFAULT NULL,
  `SALE_END_TIME`          DATETIME DEFAULT NULL,
  `ADVANCE_REDEEM_RATE`    FLOAT(10, 0) DEFAULT NULL
  COMMENT '提前赎回率',
  `ADVANCE_REDEEM_FORMULA` VARCHAR(216) DEFAULT NULL
  COMMENT '提前赎回公式',
  `IS_EFFECT`              CHAR(1) DEFAULT NULL,
  `REMARK`                 VARCHAR(512) DEFAULT NULL,
  `CREATOR`                INT(11) DEFAULT NULL,
  `CREATED_TIME`           DATETIME DEFAULT NULL,
  `MODIFIER`               INT(11) DEFAULT NULL,
  `MODIFIED_TIME`          DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of product
-- ----------------------------

-- ----------------------------
-- Table structure for `project`
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `ID`                   INT(11) NOT NULL AUTO_INCREMENT,
  `SUPPLIER_ID`          INT(11) DEFAULT NULL,
  `NO`                   VARCHAR(64) DEFAULT NULL
  COMMENT '项目编号',
  `NAME`                 VARCHAR(128) DEFAULT NULL,
  `FINANCE_LIMIT`        FLOAT(10, 0) DEFAULT NULL
  COMMENT '融资额度',
  `BEGIN_TIME`           DATETIME DEFAULT NULL,
  `BEFORE_FINANCE_CYCLE` INT(11) DEFAULT NULL
  COMMENT '融资前周期(天)',
  `FINANCE_CYCLE`        INT(11) DEFAULT NULL
  COMMENT '融资周期',
  `OPEN_TIME`            DATETIME DEFAULT NULL,
  `DENDLINE_TIME`        DATETIME DEFAULT NULL,
  `EARNING_RATE`         FLOAT(10, 0) DEFAULT NULL
  COMMENT '收益率',
  `ADVANCE_REDEEM_RATE`  FLOAT(10, 0) DEFAULT NULL
  COMMENT '提前赎回率',
  `PAY_TYPE`             INT(11) DEFAULT NULL,
  `REMARK`               VARCHAR(512) DEFAULT NULL,
  `CREATOR`              INT(11) DEFAULT NULL,
  `CREATED_TIME`         DATETIME DEFAULT NULL,
  `MODIFIER`             INT(11) DEFAULT NULL,
  `MODIFIED_TIME`        DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of project
-- ----------------------------

-- ----------------------------
-- Table structure for `sales_target`
-- ----------------------------
DROP TABLE IF EXISTS `sales_target`;
CREATE TABLE `sales_target` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID`        INT(11) DEFAULT NULL
  COMMENT '机构id',
  `BARGAIN_MONEY` FLOAT(10, 0) DEFAULT NULL
  COMMENT '目标成交金额',
  `UNIT`          INT(11) DEFAULT NULL
  COMMENT '1年份 2 月份 3季度',
  `REMARK`        VARCHAR(512) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sales_target
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_component`
-- ----------------------------
DROP TABLE IF EXISTS `sm_component`;
CREATE TABLE `sm_component` (
  `COM_ID`        INT(11) NOT NULL AUTO_INCREMENT,
  `COM_NO`        VARCHAR(32) DEFAULT NULL,
  `COM_NAME`      VARCHAR(64) DEFAULT NULL,
  `COM_URL`       VARCHAR(64) DEFAULT NULL
  COMMENT '组件调用入口',
  `REMARK`        VARCHAR(512) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`COM_ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_component
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `sm_dictionary`;
CREATE TABLE `sm_dictionary` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `KEY`           VARCHAR(64) DEFAULT NULL,
  `VALUE`         VARCHAR(64) DEFAULT NULL,
  `PARENT_ID`     INT(11) DEFAULT NULL,
  `FULLNAME`      VARCHAR(64) DEFAULT NULL,
  `SIMPLENAME`    VARCHAR(64) DEFAULT NULL,
  `REMARK`        VARCHAR(512) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_dictionary
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_function`
-- ----------------------------
DROP TABLE IF EXISTS `sm_function`;
CREATE TABLE `sm_function` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `MENU_ID`       INT(11) DEFAULT NULL,
  `FUNC_CODE`     VARCHAR(32) DEFAULT NULL,
  `FUNC_NAME`     VARCHAR(64) DEFAULT NULL,
  `FUNC_URL`      VARCHAR(64) DEFAULT NULL
  COMMENT '功能调用入口',
  `REMARK`        VARCHAR(512) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_function
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sm_menu`;
CREATE TABLE `sm_menu` (
  `ID`             INT(11) NOT NULL,
  `NO`             VARCHAR(32) DEFAULT NULL,
  `NAME`           VARCHAR(32) DEFAULT NULL,
  `PARENT_MENU_ID` INT(11) DEFAULT NULL,
  `MENU_URL`       VARCHAR(64) DEFAULT NULL,
  `IS_ACTIVE`      CHAR(1) DEFAULT '1'
  COMMENT '是否启用 1启用0禁用',
  `ORDER`          INT(11) DEFAULT NULL,
  `MUNE_SEQ`       INT(11) DEFAULT NULL,
  `MENU_LEVEL`     INT(11) DEFAULT NULL,
  `OPEN_TYPE`      INT(11) DEFAULT NULL,
  `REMARK`         VARCHAR(512) DEFAULT NULL,
  `CREATOR`        INT(11) DEFAULT NULL,
  `CREATED_TIME`   DATETIME DEFAULT NULL,
  `MODIFIER`       INT(11) DEFAULT NULL,
  `MODIFIED_TIME`  DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_menu
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_org`
-- ----------------------------
DROP TABLE IF EXISTS `sm_org`;
CREATE TABLE `sm_org` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `NO`            VARCHAR(32) DEFAULT NULL,
  `TYPE`          INT(11) DEFAULT NULL,
  `PARENT_ORG_ID` INT(11) DEFAULT NULL,
  `SHORT_NAME`    VARCHAR(64) DEFAULT NULL
  COMMENT '机构简称',
  `FULL_NAME`     VARCHAR(128) DEFAULT NULL
  COMMENT '机构全称',
  `ADDRESS`       VARCHAR(512) DEFAULT NULL,
  `ZIP_CODE`      VARCHAR(32) DEFAULT NULL,
  `PHONE`         VARCHAR(32) DEFAULT NULL,
  `EMAIL`         VARCHAR(32) DEFAULT NULL,
  `WEB_SITE`      VARCHAR(64) DEFAULT NULL,
  `STATUS`        INT(11) DEFAULT NULL,
  `ORDER`         INT(11) DEFAULT NULL
  COMMENT '排列顺序',
  `REMARK`        VARCHAR(512) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_org
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_position`
-- ----------------------------
DROP TABLE IF EXISTS `sm_position`;
CREATE TABLE `sm_position` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `NO`            VARCHAR(32) DEFAULT NULL,
  `NAME`          VARCHAR(64) DEFAULT NULL,
  `PARENT_POS_ID` INT(11) DEFAULT NULL
  COMMENT '上级岗位ID',
  `PARTY_ID`      INT(11) DEFAULT NULL
  COMMENT '隶属组织ID',
  `SORT_NO`       INT(11) DEFAULT NULL
  COMMENT '排列顺序',
  `STATUS`        INT(11) DEFAULT NULL,
  `REMARK`        VARCHAR(215) DEFAULT NULL,
  `CREATEOR`      INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_position
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role`;
CREATE TABLE `sm_role` (
  `ROLE_ID`       INT(11) NOT NULL AUTO_INCREMENT,
  `NO`            VARCHAR(255) DEFAULT NULL,
  `NAME`          VARCHAR(255) DEFAULT NULL,
  `TYPE`          INT(11) DEFAULT NULL,
  `REMARK`        VARCHAR(255) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_role
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_role_com`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role_com`;
CREATE TABLE `sm_role_com` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `ROLE_ID`       INT(11) DEFAULT NULL,
  `COM_ID`        INT(11) DEFAULT NULL
  COMMENT '组件ID',
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_role_com
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_role_func`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role_func`;
CREATE TABLE `sm_role_func` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `ROLE_ID`       INT(11) DEFAULT NULL,
  `FUNC_ID`       INT(11) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_role_func
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_trace_log`
-- ----------------------------
DROP TABLE IF EXISTS `sm_trace_log`;
CREATE TABLE `sm_trace_log` (
  `ID`        INT(11) NOT NULL AUTO_INCREMENT,
  `LOG_NAME`  VARCHAR(64) DEFAULT NULL,
  `LOG_TIME`  DATETIME DEFAULT NULL,
  `LOG_LEVEL` INT(11) DEFAULT NULL,
  `MESSAGE`   TEXT,
  `USER_ID`   INT(11) DEFAULT NULL,
  `USER_NAME` VARCHAR(64) DEFAULT NULL,
  `FUN_NAME`  VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_trace_log
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user`;
CREATE TABLE `sm_user` (
  `USER_ID`       INT(11) NOT NULL AUTO_INCREMENT,
  `LOGIN_NAME`    VARCHAR(32) DEFAULT NULL,
  `PASSWORD`      VARCHAR(64) DEFAULT NULL,
  `NO`            VARCHAR(32) DEFAULT NULL,
  `USER_NAME`     VARCHAR(32) DEFAULT NULL,
  `ORDER`         INT(11) DEFAULT NULL
  COMMENT '排列顺序',
  `IS_ACTIVE`     CHAR(1) DEFAULT NULL,
  `JOB_SITUATION` INT(11) DEFAULT NULL
  COMMENT '在岗情况',
  `SEX`           CHAR(1) DEFAULT NULL,
  `PHONE`         VARCHAR(32) DEFAULT NULL,
  `MOBILE`        VARCHAR(32) DEFAULT NULL
  COMMENT '手机号码',
  `EMAIL`         VARCHAR(32) DEFAULT NULL,
  `QQ`            VARCHAR(16) DEFAULT NULL,
  `TYPE`          INT(11) DEFAULT NULL,
  `JOB_NAME`      VARCHAR(64) DEFAULT NULL,
  `REMARK`        VARCHAR(512) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_user
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user_com`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_com`;
CREATE TABLE `sm_user_com` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `USER_ID`       INT(11) DEFAULT NULL,
  `COM_ID`        INT(11) DEFAULT NULL,
  `REMARK`        VARCHAR(512) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_user_com
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user_func`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_func`;
CREATE TABLE `sm_user_func` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `USER_ID`       INT(11) DEFAULT NULL,
  `FUNC_ID`       INT(11) DEFAULT NULL,
  `REMARK`        VARCHAR(512) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_user_func
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user_org`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_org`;
CREATE TABLE `sm_user_org` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `USER_ID`       INT(11) DEFAULT NULL,
  `ORG_ID`        INT(11) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_user_org
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user_position`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_position`;
CREATE TABLE `sm_user_position` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `USER_ID`       INT(11) DEFAULT NULL,
  `POS_ID`        INT(11) DEFAULT NULL,
  `CREATEOR`      INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_user_position
-- ----------------------------

-- ----------------------------
-- Table structure for `sm_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_role`;
CREATE TABLE `sm_user_role` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `USER_ID`       INT(11) DEFAULT NULL,
  `ROLE_ID`       INT(11) DEFAULT NULL,
  `IS_ACTIVE`     CHAR(255) DEFAULT '1'
  COMMENT '是否启用 1启用 0禁用',
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sm_user_role
-- ----------------------------

-- ----------------------------
-- Table structure for `supplier`
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `NMAE`          VARCHAR(64) DEFAULT NULL,
  `TYPE`          INT(11) DEFAULT NULL
  COMMENT '供应商分类',
  `PHONE`         VARCHAR(32) DEFAULT NULL,
  `MOBILE`        VARCHAR(32) DEFAULT NULL,
  `FAX`           VARCHAR(32) DEFAULT NULL,
  `PROVINCE`      INT(11) DEFAULT NULL,
  `CITY`          INT(11) DEFAULT NULL,
  `COUNTY`        INT(11) DEFAULT NULL,
  `ADDRESS`       VARCHAR(512) DEFAULT NULL,
  `REMARK`        VARCHAR(512) DEFAULT NULL,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of supplier
-- ----------------------------

-- ----------------------------
-- Table structure for `sysmessage`
-- ----------------------------
DROP TABLE IF EXISTS `sysmessage`;
CREATE TABLE `sysmessage` (
  `ID`            INT(11) NOT NULL AUTO_INCREMENT,
  `TITLE`         VARCHAR(64) DEFAULT NULL,
  `CONTENT`       TEXT,
  `CREATOR`       INT(11) DEFAULT NULL,
  `CREATED_TIME`  DATETIME DEFAULT NULL,
  `MODIFIER`      INT(11) DEFAULT NULL,
  `MODIFIED_TIME` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

-- ----------------------------
-- Records of sysmessage
-- ----------------------------
