/*
Navicat MySQL Data Transfer

Source Server         : 192.168.111.141
Source Server Version : 50517
Source Host           : 192.168.111.141:3306
Source Database       : hxtd-lihua

Target Server Type    : MYSQL
Target Server Version : 50517
File Encoding         : 65001

Date: 2014-08-29 19:30:55
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `attachment`
-- ----------------------------
DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
`ID`  int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`MODULE_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '关联模块ID' ,
`RECORD_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '关联模块内记录的ID' ,
`TYPE_DICT`  int(4) NOT NULL DEFAULT 0 COMMENT '附件类型' ,
`NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '附件原名' ,
`ADDRESS`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '存储地址' ,
`IS_DELETED`  smallint(6) NOT NULL DEFAULT 0 ,
`CREATOR_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '创建人ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '修改人ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='附件表'
AUTO_INCREMENT=35

;

-- ----------------------------
-- Table structure for `contact`
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '客户ID' ,
`NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '联系人姓名' ,
`OWNER`  int(11) NULL DEFAULT NULL COMMENT '联系人所有者' ,
`ACCOUNT_ID`  int(11) NULL DEFAULT NULL COMMENT '联系人类型' ,
`SUPPLIER_ID`  int(11) NULL DEFAULT NULL COMMENT '供应商ID/客户ID' ,
`SOURCE_DIC`  int(11) NULL DEFAULT NULL COMMENT '线索来源' ,
`DEPARTMENT`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门' ,
`POSITION`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '职位' ,
`PHONE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '电话' ,
`MOBILE`  varchar(23) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机' ,
`EMAIL`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '邮箱' ,
`FAX`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '传真' ,
`POST_CODE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '邮编' ,
`PROVINCE`  int(11) NULL DEFAULT NULL COMMENT '所在地（省）' ,
`CITY`  int(11) NULL DEFAULT NULL COMMENT '所在地（市）' ,
`COUNTY`  int(11) NULL DEFAULT NULL COMMENT '所在地（县）' ,
`ADDRESS`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '详细地址' ,
`IS_DELETED`  int(11) NULL DEFAULT 0 COMMENT '删除标记' ,
`REMARK`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='联系人'
AUTO_INCREMENT=8

;

-- ----------------------------
-- Table structure for `contract`
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '合同ID' ,
`NAME`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '合同名称' ,
`CODE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '合同编号' ,
`TYPE_DIC`  int(11) NULL DEFAULT 0 COMMENT '合同类型' ,
`CONTENT`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '合同内容' ,
`PURCHASE_MONEY`  decimal(10,2) NOT NULL COMMENT '合同金额' ,
`ORDER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '订单ID' ,
`ACCOUNT_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '客户ID' ,
`REDEEM_TYPE_DIC`  int(11) NOT NULL DEFAULT 0 COMMENT '赎回方式' ,
`SIGN_TIME`  datetime NOT NULL COMMENT '签订时间' ,
`EFFECT_TIME`  datetime NOT NULL COMMENT '生效时间' ,
`BEREFT_TIME`  datetime NOT NULL COMMENT '失效时间' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注' ,
`IS_DELETED`  int(11) NULL DEFAULT 0 COMMENT '标记删除' ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='合同表'
AUTO_INCREMENT=3

;

-- ----------------------------
-- Table structure for `customer`
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '客户ID' ,
`OWNER`  int(11) NOT NULL DEFAULT 0 COMMENT '客户所有者' ,
`NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '客户姓名' ,
`TYPE_DIC`  int(11) NULL DEFAULT NULL COMMENT '客户类型' ,
`SOURCE_DIC`  int(11) NOT NULL DEFAULT 0 COMMENT '客户来源' ,
`RISK_GRADE_DIC`  int(11) NULL DEFAULT NULL COMMENT '风险等级' ,
`CARD_TYPE_DIC`  int(11) NULL DEFAULT NULL COMMENT '证件类型' ,
`CARD_NUM`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '证件号码' ,
`PHONE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '电话' ,
`MOBILE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机' ,
`DEPT`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所在部门' ,
`JOB`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务名称' ,
`EMAIL`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱' ,
`FAX`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '传真' ,
`POST_CODE`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '邮编' ,
`COMPANY`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '公司' ,
`INDUSTRY_DIC`  int(64) NOT NULL DEFAULT 0 COMMENT '行业' ,
`OWNERSHIP_DIC`  int(64) NULL DEFAULT NULL COMMENT '所有权' ,
`OPEN_BANK_DIC`  int(11) NULL DEFAULT NULL COMMENT '开户行' ,
`BANK_NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '银行户名' ,
`BANK_ACCOUNT`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '账号' ,
`PROVINCE`  int(64) NULL DEFAULT 0 COMMENT '所在地（省）' ,
`CITY`  int(64) NULL DEFAULT 0 COMMENT '所在地（市）' ,
`COUNTY`  int(64) NULL DEFAULT 0 COMMENT '所在地（县）' ,
`FAMILY_ADDR`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭地址' ,
`ADDRESS`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '详细地址' ,
`CONTRIBUTION_TYPE`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出资方式' ,
`CONTRIBUTION_SCALE`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出资规模' ,
`APPOINTMENT`  int(255) NULL DEFAULT 0 COMMENT '邀约人' ,
`FINANCIAL_ADVISOR`  int(255) NULL DEFAULT 0 COMMENT '理财顾问' ,
`FINANCIAL_MANAGER`  int(255) NULL DEFAULT 0 COMMENT '理财经理' ,
`FINANCIAL_DIRECTOR`  int(255) NULL DEFAULT 0 COMMENT '理财总监' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注' ,
`IS_DELETED`  tinyint(6) NOT NULL DEFAULT 0 COMMENT '是否被删除' ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='客户表'
AUTO_INCREMENT=9

;

-- ----------------------------
-- Table structure for `import_log`
-- ----------------------------
DROP TABLE IF EXISTS `import_log`;
CREATE TABLE `import_log` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '导入日志表ID' ,
`START_TIME`  datetime NOT NULL COMMENT '导入数据开始时间' ,
`END_TIME`  datetime NOT NULL COMMENT '导入数据结束时间' ,
`STATUS`  int(2) NOT NULL DEFAULT 0 COMMENT '导入状态：0 正在导入 1 导入结束 默认为0' ,
`DESCRIPTION`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='导入日志'
AUTO_INCREMENT=1

;

-- ----------------------------
-- Table structure for `lead`
-- ----------------------------
DROP TABLE IF EXISTS `lead`;
CREATE TABLE `lead` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '线索ID ' ,
`OWNER`  int(11) NOT NULL DEFAULT 0 COMMENT '线索所有者' ,
`COMPANY`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '公司名称' ,
`NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '线索名称' ,
`DEPARTMENT`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '部门' ,
`POSITION`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '职位' ,
`EMAIL`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱' ,
`PHONE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '电话' ,
`FAX`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '传真' ,
`MOBILE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机' ,
`SOURCE`  int(11) NOT NULL DEFAULT 0 COMMENT '线索来源' ,
`STATUS`  int(11) NOT NULL DEFAULT 0 COMMENT '线索状态' ,
`MARKET_ACTIVITY_ID`  int(4) NULL DEFAULT NULL COMMENT '关联市场活动' ,
`CARD_TYPE`  int(11) NOT NULL DEFAULT 0 COMMENT '证件类型' ,
`CARD_NUM`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '证件号码' ,
`INDUSTRY`  int(11) NOT NULL DEFAULT 0 COMMENT '行业' ,
`POST_CODE`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮编' ,
`PROVINCE`  int(11) NULL DEFAULT 0 COMMENT '省份' ,
`CITY`  int(11) NULL DEFAULT 0 COMMENT '城市' ,
`COUNTY`  int(11) NULL DEFAULT 0 COMMENT '区/县' ,
`ADDRESS`  varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '详细地址' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注' ,
`IS_DELETED`  int(11) NULL DEFAULT 0 ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='线索'
AUTO_INCREMENT=6

;

-- ----------------------------
-- Table structure for `market_activity`
-- ----------------------------
DROP TABLE IF EXISTS `market_activity`;
CREATE TABLE `market_activity` (
`ID`  int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`NAME`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '活动名称' ,
`TYPE_DIC`  int(4) NULL DEFAULT NULL COMMENT '活动类型' ,
`STATUS_DIC`  int(4) NULL DEFAULT NULL COMMENT '活动状态' ,
`BEGIN_DATE`  datetime NOT NULL COMMENT '开始日期' ,
`END_DATE`  datetime NULL DEFAULT NULL COMMENT '结束日期' ,
`PREDICT_COST`  decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '预计成本' ,
`REALITY_COST`  decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '实际成本' ,
`TIMES`  int(4) NOT NULL DEFAULT 0 COMMENT '活动次数' ,
`EXPECT_EFFECT`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '预期效果' ,
`EXPECT_SUCCESS_RATE`  float(6,2) NULL DEFAULT 0.00 COMMENT '期望成功率' ,
`SPONSOR`  int(11) NOT NULL DEFAULT 0 COMMENT '发起者' ,
`BOSSHEAD`  int(11) NOT NULL DEFAULT 0 COMMENT '负责人' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注' ,
`IS_SEND`  int(1) NOT NULL DEFAULT 0 COMMENT '是否已发提醒信息' ,
`IS_DELETED`  int(11) NULL DEFAULT 0 COMMENT '删除标记' ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间' ,
`FLOW_NODE_ID`  int(11) NULL DEFAULT NULL ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='市场活动'
AUTO_INCREMENT=13

;

-- ----------------------------
-- Table structure for `memoir`
-- ----------------------------
DROP TABLE IF EXISTS `memoir`;
CREATE TABLE `memoir` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '纪要ID' ,
`MODULE_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '关联模块ID' ,
`RECORD_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '关联模块内记录的ID' ,
`ORG_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '组织ID' ,
`USER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '用户ID' ,
`SUMMARY`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '纪要内容' ,
`NEXTCONTACTTIME`  datetime NULL DEFAULT NULL COMMENT '下次联系时间' ,
`NEXTCONTACTPOINTS`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '下次联系要点' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注' ,
`IS_DELETED`  int(11) NULL DEFAULT 0 COMMENT '标记删除' ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='沟通纪要'
AUTO_INCREMENT=5

;

-- ----------------------------
-- Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
`ID`  int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`TITLE`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标题' ,
`CONTENT`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容' ,
`SENT_TIME`  datetime NOT NULL COMMENT '发送时间' ,
`DEAD_TIME`  datetime NOT NULL COMMENT '过期时间' ,
`IS_DELETED`  tinyint(6) NOT NULL DEFAULT 0 COMMENT '是否被删除' ,
`CREATOR_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='系统公告表'
AUTO_INCREMENT=3

;

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
`ID`  int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`PRODUCT_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '产品ID' ,
`CUSTOMER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '客户ID' ,
`CODE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单编号' ,
`STATUS`  int(11) NULL DEFAULT NULL ,
`INVESTMENT_WAY`  int(4) NOT NULL DEFAULT 0 COMMENT '投资方式' ,
`PURCHASE_MONEY`  decimal(10,2) NOT NULL COMMENT '购买金额' ,
`EARNING_RATE`  decimal(10,2) NOT NULL COMMENT '收益率' ,
`ADVANCE_REDEEM_RATE`  decimal(10,2) NOT NULL COMMENT '提前赎回率' ,
`REDEEM_FORMULA`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '赎回公式' ,
`OWNER`  int(4) NOT NULL DEFAULT 0 COMMENT '销售人员' ,
`SALES_MANAGER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '销售经理' ,
`SALES_MAJORDOMO_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '销售总监' ,
`ORDER_END_TIME`  date NOT NULL COMMENT '订单结束时间(日期格式)' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注' ,
`IS_DELETED`  int(4) NULL DEFAULT 0 COMMENT '删除标识' ,
`CREATOR_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
`PAY_MONEY`  decimal(10,0) NULL DEFAULT 0 COMMENT '支付金额' ,
`PAY_STATUS`  int(4) NULL DEFAULT 0 COMMENT '付款状态' ,
`ORDER_STATUS`  int(4) NULL DEFAULT NULL COMMENT '订单状态' ,
`EFFECTIVE_TIME`  date NULL DEFAULT NULL COMMENT '生效时间(日期格式)' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='订单表'
AUTO_INCREMENT=29

;

-- ----------------------------
-- Table structure for `payments`
-- ----------------------------
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`NAME`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账款名称' ,
`CUSTOMER_ID`  int(11) NOT NULL COMMENT '客户' ,
`ORDER_ID`  int(11) NOT NULL COMMENT '订单' ,
`FUND`  decimal(10,2) NOT NULL COMMENT '账款' ,
`STATUS`  int(11) NOT NULL COMMENT '收款状态' ,
`ACTUAL`  decimal(10,2) NULL DEFAULT NULL COMMENT '实际付款' ,
`OPERATE_TIME`  datetime NOT NULL COMMENT '操作时间' ,
`OWNER_ID`  int(11) NOT NULL COMMENT '操作者' ,
`OPEN_BANK_DIC`  int(11) NULL DEFAULT NULL COMMENT '开户行' ,
`BANK_NAME`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '银行户名' ,
`BANK_ACCOUNT`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`PAY_TYPE_DIC`  int(11) NULL DEFAULT NULL COMMENT '支付方式' ,
`CREATOR_ID`  int(11) NOT NULL COMMENT '创建者' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL COMMENT ' 修改者' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
`IS_DELETED`  int(11) NOT NULL COMMENT '删除标识' ,
`REMARK`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='付款表'
AUTO_INCREMENT=24

;

-- ----------------------------
-- Table structure for `pro_city_area`
-- ----------------------------
DROP TABLE IF EXISTS `pro_city_area`;
CREATE TABLE `pro_city_area` (
`ID`  int(4) NOT NULL COMMENT '主键ID' ,
`NAME`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称' ,
`PID`  int(4) NULL DEFAULT NULL COMMENT '父级ID' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='省市县三级联动表'

;

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
`ID`  int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`NAME`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '产品名称' ,
`CODE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '产品编号' ,
`PROJECT_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '项目ID' ,
`TYPE_DIC`  int(4) NULL DEFAULT 0 COMMENT '类型' ,
`START_SELL_MONEY`  decimal(10,2) NULL DEFAULT 0.00 COMMENT '出售金额' ,
`ERNING_RATE`  decimal(10,2) NULL DEFAULT 0.00 COMMENT '利率' ,
`EXPECT_PROFIT`  decimal(10,2) NULL DEFAULT 0.00 COMMENT '预期收益' ,
`SALE_LIMIT`  int(4) NULL DEFAULT 0 COMMENT '销售期限' ,
`SALE_UNIT_DIC`  int(4) NULL DEFAULT 0 COMMENT '销售单位' ,
`SALE_BEGIN_TIME`  datetime NULL DEFAULT NULL COMMENT '销售开始日期' ,
`SALE_END_TIME`  datetime NULL DEFAULT NULL COMMENT '销售结束日期' ,
`ADVANCE_REDEEM_RATE`  decimal(10,2) NULL DEFAULT NULL COMMENT '提前赎回率' ,
`ADVANCE_REDEEM_FORMULA`  varchar(216) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提前赎回公式' ,
`IS_EFFECT`  char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否有效' ,
`IS_DELETED`  int(11) NULL DEFAULT 0 COMMENT '标记删除' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注' ,
`CREATOR_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='产品表'
AUTO_INCREMENT=5

;

-- ----------------------------
-- Table structure for `project`
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
`ID`  int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`SUPPLIER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '供应商ID' ,
`CODE`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '项目编号' ,
`NAME`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '项目名称' ,
`FINANCE_LIMIT`  decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '融资额度' ,
`BEGIN_TIME`  datetime NOT NULL COMMENT '开始时间' ,
`BEFORE_FINANCE_CYCLE`  int(4) NOT NULL DEFAULT 0 COMMENT '融资前周期(天)' ,
`FINANCE_CYCLE`  int(4) NOT NULL DEFAULT 0 COMMENT '融资周期' ,
`OPEN_TIME`  datetime NOT NULL COMMENT '开放期' ,
`DENDLINE_TIME`  datetime NOT NULL COMMENT '截止时间' ,
`EARNING_RATE`  float(10,0) NOT NULL DEFAULT 0 COMMENT '收益率' ,
`ADVANCE_REDEEM_RATE`  float(10,0) NOT NULL DEFAULT 0 COMMENT '提前赎回率' ,
`PAY_TYPE`  int(11) NOT NULL DEFAULT 0 COMMENT '支付方式' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注' ,
`IS_DELETED`  int(11) NULL DEFAULT 0 ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最终修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='项目表'
AUTO_INCREMENT=2

;

-- ----------------------------
-- Table structure for `qrtz_blob_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
`TRIGGER_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`TRIGGER_GROUP`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`BLOB_DATA`  blob NULL DEFAULT NULL ,
PRIMARY KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`),
FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `qrtz_calendars`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
`CALENDAR_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`CALENDAR`  blob NOT NULL ,
PRIMARY KEY (`CALENDAR_NAME`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `qrtz_cron_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
`TRIGGER_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`TRIGGER_GROUP`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`CRON_EXPRESSION`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`TIME_ZONE_ID`  varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`),
FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `qrtz_fired_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
`ENTRY_ID`  varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`TRIGGER_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`TRIGGER_GROUP`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`IS_VOLATILE`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`INSTANCE_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`FIRED_TIME`  bigint(13) NOT NULL ,
`PRIORITY`  int(11) NOT NULL ,
`STATE`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`JOB_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`JOB_GROUP`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`IS_STATEFUL`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`REQUESTS_RECOVERY`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`ENTRY_ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `qrtz_job_details`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
`JOB_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`JOB_GROUP`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`DESCRIPTION`  varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`JOB_CLASS_NAME`  varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`IS_DURABLE`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`IS_VOLATILE`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`IS_STATEFUL`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`REQUESTS_RECOVERY`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`JOB_DATA`  blob NULL DEFAULT NULL ,
PRIMARY KEY (`JOB_NAME`, `JOB_GROUP`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `qrtz_job_listeners`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_listeners`;
CREATE TABLE `qrtz_job_listeners` (
`JOB_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`JOB_GROUP`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`JOB_LISTENER`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`JOB_NAME`, `JOB_GROUP`, `JOB_LISTENER`),
FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `qrtz_locks`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
`LOCK_NAME`  varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`LOCK_NAME`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `qrtz_paused_trigger_grps`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
`TRIGGER_GROUP`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`TRIGGER_GROUP`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `qrtz_scheduler_state`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
`INSTANCE_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`LAST_CHECKIN_TIME`  bigint(13) NOT NULL ,
`CHECKIN_INTERVAL`  bigint(13) NOT NULL ,
PRIMARY KEY (`INSTANCE_NAME`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `qrtz_simple_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
`TRIGGER_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`TRIGGER_GROUP`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`REPEAT_COUNT`  bigint(7) NOT NULL ,
`REPEAT_INTERVAL`  bigint(12) NOT NULL ,
`TIMES_TRIGGERED`  bigint(10) NOT NULL ,
PRIMARY KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`),
FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `qrtz_trigger_listeners`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_trigger_listeners`;
CREATE TABLE `qrtz_trigger_listeners` (
`TRIGGER_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`TRIGGER_GROUP`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`TRIGGER_LISTENER`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_LISTENER`),
FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `qrtz_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
`TRIGGER_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`TRIGGER_GROUP`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`JOB_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`JOB_GROUP`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`IS_VOLATILE`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`DESCRIPTION`  varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`NEXT_FIRE_TIME`  bigint(13) NULL DEFAULT NULL ,
`PREV_FIRE_TIME`  bigint(13) NULL DEFAULT NULL ,
`PRIORITY`  int(11) NULL DEFAULT NULL ,
`TRIGGER_STATE`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`TRIGGER_TYPE`  varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`START_TIME`  bigint(13) NOT NULL ,
`END_TIME`  bigint(13) NULL DEFAULT NULL ,
`CALENDAR_NAME`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`MISFIRE_INSTR`  smallint(2) NULL DEFAULT NULL ,
`JOB_DATA`  blob NULL DEFAULT NULL ,
PRIMARY KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`),
FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `receivables`
-- ----------------------------
DROP TABLE IF EXISTS `receivables`;
CREATE TABLE `receivables` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`NAME`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账款名称' ,
`CUSTOMER_ID`  int(11) NOT NULL COMMENT '客户' ,
`ORDER_ID`  int(11) NOT NULL COMMENT '订单' ,
`FUND`  decimal(10,2) NOT NULL COMMENT '账款' ,
`STATUS`  int(11) NOT NULL COMMENT '收款状态' ,
`ACTUAL`  decimal(10,2) NULL DEFAULT NULL COMMENT '实际付款' ,
`OPERATE_TIME`  datetime NOT NULL COMMENT '操作时间' ,
`OWNER_ID`  int(11) NOT NULL COMMENT '收款者' ,
`CREATOR_ID`  int(11) NOT NULL COMMENT '创建者' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL COMMENT ' 修改者' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
`IS_DELETED`  int(11) NOT NULL COMMENT '删除标识' ,
`REMARK`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='账款表'
AUTO_INCREMENT=8

;

-- ----------------------------
-- Table structure for `report`
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`CODE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '代码值' ,
`NAME`  varchar(62) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表名' ,
`MODULE_ID`  int(11) NOT NULL COMMENT '所属模块主键编号' ,
`X_FIELD_NAME`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'X轴字段名' ,
`X_TYPE_ID`  int(11) NOT NULL COMMENT 'X轴分组类型' ,
`Y_FIELD_NAME`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Y轴字段名' ,
`Y_TYPE_ID`  int(11) NOT NULL COMMENT 'Y轴分组类型' ,
`Z_FIELD_NAME`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Z轴字段名' ,
`Z_TYPE_ID`  int(11) NULL DEFAULT NULL COMMENT 'Z轴分组类型' ,
`CHART_ID`  int(11) NOT NULL COMMENT '图表类型' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
`CREATOR_ID`  int(11) NOT NULL COMMENT '创建者主键编号' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL COMMENT '修改者主键编号' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间' ,
`IS_DELETED`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '否是被删除' ,
`IS_INITIALIZED`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '否是初始化数据' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='报表表'
AUTO_INCREMENT=5

;

-- ----------------------------
-- Table structure for `sales_target`
-- ----------------------------
DROP TABLE IF EXISTS `sales_target`;
CREATE TABLE `sales_target` (
`ID`  int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`OWNER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '目标制定人' ,
`BARGAIN_MONEY`  decimal(10,4) NULL DEFAULT NULL COMMENT '目标成交金额' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
`CREATOR_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间' ,
`BEGIN_TIME`  datetime NULL DEFAULT NULL COMMENT '开始时间' ,
`END_TIME`  datetime NULL DEFAULT NULL COMMENT '结束时间' ,
`IS_DELETED`  int(4) NULL DEFAULT NULL COMMENT '删除标志' ,
`TIME_STR`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用于储存时间段展现模式' ,
`TITLE`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='销售目标表'
AUTO_INCREMENT=8

;

-- ----------------------------
-- Table structure for `sm_audit_log`
-- ----------------------------
DROP TABLE IF EXISTS `sm_audit_log`;
CREATE TABLE `sm_audit_log` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`MODULE_NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '模块名称' ,
`RECORD_ID`  int(11) NULL DEFAULT 0 COMMENT '记录ID' ,
`RECORD_NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '记录名称' ,
`TYPE`  int(11) NOT NULL DEFAULT 0 COMMENT '操作类型' ,
`REMARK`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '操作者ID' ,
`CREATED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='审计日志表'
AUTO_INCREMENT=543

;

-- ----------------------------
-- Table structure for `sm_component`
-- ----------------------------
DROP TABLE IF EXISTS `sm_component`;
CREATE TABLE `sm_component` (
`ID`  int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`CODE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '组件编号' ,
`NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '组件名称' ,
`URL`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '组件调用入口' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注' ,
`PRIVILEGE_LEVEL_ID`  int(11) NOT NULL COMMENT '权限级别' ,
`IS_DELETED`  int(11) NULL DEFAULT 0 COMMENT '删除标志' ,
`IS_INITIALIZED`  tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否初始化数据' ,
`CREATOR_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='组件表'
AUTO_INCREMENT=23

;

-- ----------------------------
-- Table structure for `sm_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `sm_dictionary`;
CREATE TABLE `sm_dictionary` (
`ID`  bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键' ,
`KEY`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '显示值' ,
`VALUE`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '字典值' ,
`PARENT_ID`  int(11) NULL DEFAULT 0 COMMENT '父id' ,
`LEVEL`  int(11) NULL DEFAULT NULL COMMENT '深度' ,
`ORDER`  int(11) NULL DEFAULT NULL COMMENT '顺序' ,
`TYPE`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典类型' ,
`IS_ACTIVE`  int(11) NULL DEFAULT 1 COMMENT '是否启用' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注' ,
`IS_DELETED`  int(11) NULL DEFAULT 0 COMMENT '标记删除' ,
`IS_INITIALIZED`  tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否初始化数据' ,
`CREATOR_ID`  int(10) UNSIGNED NULL DEFAULT 0 COMMENT '创建者' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NULL DEFAULT 0 COMMENT '修改者' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='数据字典表'
AUTO_INCREMENT=347

;

-- ----------------------------
-- Table structure for `sm_function`
-- ----------------------------
DROP TABLE IF EXISTS `sm_function`;
CREATE TABLE `sm_function` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`MENU_ID`  int(11) NULL DEFAULT NULL COMMENT '关联菜单' ,
`CODE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '功能编号' ,
`NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '功能名称' ,
`URL`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调用入口' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注' ,
`IS_DELETED`  int(11) NULL DEFAULT 0 COMMENT '删除标志' ,
`PRIVILEGE_LEVEL_ID`  int(11) NULL DEFAULT 0 COMMENT ' 权限级别' ,
`PARENT_ID`  int(11) NULL DEFAULT NULL COMMENT '父功能' ,
`IS_INITIALIZED`  tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否初始化数据' ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='功能表'
AUTO_INCREMENT=330

;

-- ----------------------------
-- Table structure for `sm_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sm_menu`;
CREATE TABLE `sm_menu` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键号编' ,
`NAME`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称' ,
`URL`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接地址' ,
`SHOW_LOCATION_TYPE`  int(11) NULL DEFAULT NULL COMMENT '显示位置' ,
`DEFAULT_SHOW`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '默认显示' ,
`TRIGGER_ID`  int(11) NULL DEFAULT NULL COMMENT '触发功能' ,
`IS_ACTIVE`  tinyint(1) NOT NULL COMMENT '是否激活的' ,
`LEVEL`  int(11) NOT NULL COMMENT '级别' ,
`IS_LEAF`  tinyint(1) NOT NULL COMMENT '叶子节点' ,
`PARENT_MENU_ID`  int(11) NULL DEFAULT NULL COMMENT '上级菜单' ,
`ORDER`  int(11) NOT NULL COMMENT '序号' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
`IS_DELETED`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '否是被删除' ,
`IS_INITIALIZED`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否初始化数据' ,
`CREATOR_ID`  int(11) NOT NULL COMMENT '建创者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='菜单表'
AUTO_INCREMENT=50

;

-- ----------------------------
-- Table structure for `sm_message`
-- ----------------------------
DROP TABLE IF EXISTS `sm_message`;
CREATE TABLE `sm_message` (
`ID`  int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`TITLE`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`CONTENT`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容' ,
`CREATOR_ID`  int(4) NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`IS_DELETED`  tinyint(6) NOT NULL DEFAULT 0 COMMENT '是否被删除' ,
`MODIFIER_ID`  int(4) NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='系统消息'
AUTO_INCREMENT=62

;

-- ----------------------------
-- Table structure for `sm_module`
-- ----------------------------
DROP TABLE IF EXISTS `sm_module`;
CREATE TABLE `sm_module` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`NAME`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称' ,
`DESC`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '述描' ,
`ENTITY_CLASS`  varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关联实体类' ,
`URL`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='模块表'
AUTO_INCREMENT=22

;

-- ----------------------------
-- Table structure for `sm_module_type`
-- ----------------------------
DROP TABLE IF EXISTS `sm_module_type`;
CREATE TABLE `sm_module_type` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键编号' ,
`TYPE_ID`  int(11) NOT NULL COMMENT '类型编号' ,
`MODULE_ID`  int(11) NOT NULL COMMENT '模块编号' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='模块类型表\r\n注意：类型编号和模块编号为联合的唯一列\r\n'
AUTO_INCREMENT=23

;

-- ----------------------------
-- Table structure for `sm_org`
-- ----------------------------
DROP TABLE IF EXISTS `sm_org`;
CREATE TABLE `sm_org` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '键主编号' ,
`SHORT_NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '机构简称' ,
`FULL_NAME`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '构机全称' ,
`TYPE`  int(11) NOT NULL COMMENT '类型 1公司 2部门 3组' ,
`PHONE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码' ,
`EMAIL`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱' ,
`ADDRESS`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址' ,
`ZIP_CODE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮政编码' ,
`WEB_SITE`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '站点' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
`LEVEL`  int(11) NOT NULL COMMENT '别级' ,
`IS_LEAF`  tinyint(1) NOT NULL COMMENT '叶子节点' ,
`PARENT_ORG_ID`  int(11) NULL DEFAULT NULL COMMENT '上级组织主键编号' ,
`ORDER`  int(11) NOT NULL COMMENT '序号' ,
`IS_DELETED`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否被删除' ,
`IS_INITIALIZED`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '否是初始化数据' ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='机构表'
AUTO_INCREMENT=111

;

-- ----------------------------
-- Table structure for `sm_org_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_org_role`;
CREATE TABLE `sm_org_role` (
`ORG_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '组织ID' ,
`ROLE_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '角色ID' ,
PRIMARY KEY (`ORG_ID`, `ROLE_ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='织组角色关联表'

;

-- ----------------------------
-- Table structure for `sm_position`
-- ----------------------------
DROP TABLE IF EXISTS `sm_position`;
CREATE TABLE `sm_position` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`CODE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '岗位编号' ,
`NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '岗位名称' ,
`PARENT_POS_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '上级岗位ID' ,
`PARTY_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '隶属组织ID' ,
`SORT_NO`  int(11) NOT NULL DEFAULT 0 COMMENT '排列顺序' ,
`STATUS`  int(11) NOT NULL DEFAULT 0 COMMENT '岗位状态' ,
`REMARK`  varchar(215) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注' ,
`CREATEOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '修改时间' ,
`MODIFIER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '最后修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='岗位表'
AUTO_INCREMENT=1

;

-- ----------------------------
-- Table structure for `sm_recyclebin`
-- ----------------------------
DROP TABLE IF EXISTS `sm_recyclebin`;
CREATE TABLE `sm_recyclebin` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`MODULE_NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '模块名称' ,
`RECORD_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '记录ID' ,
`RECORD_NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '记录名' ,
`REMARK`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '操作者' ,
`CREATED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='回收站表'
AUTO_INCREMENT=54

;

-- ----------------------------
-- Table structure for `sm_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role`;
CREATE TABLE `sm_role` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`CODE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色代码' ,
`NAME`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名' ,
`TYPE`  int(11) NOT NULL DEFAULT 0 COMMENT '角色类型' ,
`REMARK`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注' ,
`IS_DELETED`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否被删除' ,
`IS_INITIALIZED`  int(11) NOT NULL DEFAULT 0 COMMENT '是否是初始化数据' ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL COMMENT '修改者' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='角色表'
AUTO_INCREMENT=13

;

-- ----------------------------
-- Table structure for `sm_role_com`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role_com`;
CREATE TABLE `sm_role_com` (
`ROLE_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '角色ID' ,
`COM_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '组件ID' ,
PRIMARY KEY (`ROLE_ID`, `COM_ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='角色组件表'

;

-- ----------------------------
-- Table structure for `sm_role_func`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role_func`;
CREATE TABLE `sm_role_func` (
`ROLE_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '角色ID' ,
`FUNC_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '功能ID' ,
PRIMARY KEY (`ROLE_ID`, `FUNC_ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='角色功能表'

;

-- ----------------------------
-- Table structure for `sm_user`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user`;
CREATE TABLE `sm_user` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键编号' ,
`LOGIN_NAME`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录名' ,
`PASSWORD`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码' ,
`USER_NAME`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '真实姓名' ,
`SEX_ID`  int(11) NOT NULL COMMENT '性别' ,
`PHONE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码' ,
`MOBILE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码' ,
`EMAIL`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱' ,
`QQ`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'QQ' ,
`JOB_NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职位' ,
`JOB_SITUATION_ID`  int(11) NOT NULL COMMENT '职位状态' ,
`IS_MANAGER`  int(11) NOT NULL COMMENT '否是管理员' ,
`IS_ACTIVE`  char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '是否启用 1启用 0禁用' ,
`ORGANIZATION_ID`  int(11) NOT NULL COMMENT '属所组织' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
`STORE_STATUS_ID`  int(11) NOT NULL COMMENT '数据存储状态' ,
`IS_DELETED`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '否是被删除' ,
`IS_INITIALIZED`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否初始化数据' ,
`CREATOR_ID`  int(11) NOT NULL COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='用户表'
AUTO_INCREMENT=37

;

-- ----------------------------
-- Table structure for `sm_user_com`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_com`;
CREATE TABLE `sm_user_com` (
`USER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '用户ID' ,
`COM_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '组件ID' ,
PRIMARY KEY (`USER_ID`, `COM_ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='用户组件表'

;

-- ----------------------------
-- Table structure for `sm_user_func`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_func`;
CREATE TABLE `sm_user_func` (
`USER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '用户ID' ,
`FUNC_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '功能ID' ,
PRIMARY KEY (`USER_ID`, `FUNC_ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='用户，功能 对应关系表'

;

-- ----------------------------
-- Table structure for `sm_user_org`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_org`;
CREATE TABLE `sm_user_org` (
`USER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '用户ID' ,
`ORG_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '机构ID' ,
PRIMARY KEY (`USER_ID`, `ORG_ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='用户机构表'

;

-- ----------------------------
-- Table structure for `sm_user_position`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_position`;
CREATE TABLE `sm_user_position` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`USER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '用户ID' ,
`POS_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '岗位ID' ,
`CREATOR_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='用户岗位关联表'
AUTO_INCREMENT=1

;

-- ----------------------------
-- Table structure for `sm_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_role`;
CREATE TABLE `sm_user_role` (
`USER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '用户ID' ,
`ROLE_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '角色ID' ,
PRIMARY KEY (`USER_ID`, `ROLE_ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='用户角色关联表'

;

-- ----------------------------
-- Table structure for `sm_workbanch`
-- ----------------------------
DROP TABLE IF EXISTS `sm_workbanch`;
CREATE TABLE `sm_workbanch` (
`ID`  int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`URL`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`TITLE`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标题' ,
`MODULE`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '模块' ,
`TYPE`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型' ,
`WIDTH`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '宽度' ,
`PARAMS`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数' ,
`TIME_PARAM`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '时间参数' ,
`OWNER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '所有者' ,
`ORDER_INDEX`  int(4) NOT NULL DEFAULT 0 COMMENT '排序标识' ,
`IS_DELETED`  int(4) NOT NULL DEFAULT 0 COMMENT '删除标识' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='工作台'
AUTO_INCREMENT=12

;

-- ----------------------------
-- Table structure for `supplier`
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
`ID`  int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`NAME`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '供应商名' ,
`TYPE`  int(4) NOT NULL DEFAULT 0 COMMENT '供应商分类' ,
`CORPORATION`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '法人代表' ,
`OWNER`  int(11) NOT NULL DEFAULT 0 COMMENT '所有者' ,
`PHONE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '电话' ,
`MOBILE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机' ,
`CARD_NUM`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '证件号码' ,
`CARD_TYPE`  int(11) NULL DEFAULT NULL COMMENT '证件类型' ,
`FAX`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '传真' ,
`PROVINCE`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省份' ,
`CITY`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '城市' ,
`COUNTY`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区/县' ,
`EMAIL`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱' ,
`ADDRESS`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '详细地址' ,
`REMARK`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注' ,
`IS_DELETED`  int(11) NULL DEFAULT 0 ,
`CREATOR_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '创建者ID' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(4) NOT NULL DEFAULT 0 COMMENT '修改者ID' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='供应商'
AUTO_INCREMENT=3

;

-- ----------------------------
-- Table structure for `user_message`
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`MESSAGE_ID`  int(11) NOT NULL COMMENT '所发消息' ,
`USER_ID`  int(11) NOT NULL COMMENT '所发用户' ,
`STATUS`  int(11) NOT NULL COMMENT '读取状态' ,
`TYPE`  smallint(6) NOT NULL COMMENT '消息类型，发消息true或接收消息false' ,
`IS_DELETED`  tinyint(6) NOT NULL DEFAULT 0 COMMENT '是否被删除' ,
`CREATED_TIME`  datetime NOT NULL COMMENT '发送时间' ,
`MODIFIED_TIME`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='系统消息与用户关联表'
AUTO_INCREMENT=91

;

-- ----------------------------
-- Table structure for `wf_node`
-- ----------------------------
DROP TABLE IF EXISTS `wf_node`;
CREATE TABLE `wf_node` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID' ,
`CODE`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号' ,
`NAME`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称' ,
`FLOW_ID`  int(11) NOT NULL COMMENT '流程ID' ,
`ROLE_ID`  int(11) NULL DEFAULT NULL COMMENT '对应的执行角色ID' ,
`TYPE_ID`  int(11) NOT NULL COMMENT '流程环节类型，开始：1、业务：2、结束：3' ,
`ORDER`  int(11) NOT NULL ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='流程节点表'
AUTO_INCREMENT=17

;

-- ----------------------------
-- Table structure for `wf_task`
-- ----------------------------
DROP TABLE IF EXISTS `wf_task`;
CREATE TABLE `wf_task` (
`ID`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键' ,
`NODE_ID`  int(11) NOT NULL COMMENT '流程环节ID' ,
`MODULE_ID`  int(11) NOT NULL COMMENT '模块ID' ,
`RECORD_ID`  int(11) NOT NULL COMMENT '关联记录ID' ,
`ORG_ID`  int(11) NULL DEFAULT NULL COMMENT '机构ID' ,
`APPROVER_ID`  int(11) NULL DEFAULT NULL ,
`IS_PASSED`  tinyint(4) NULL DEFAULT NULL COMMENT '否是通过' ,
`APPROVE_TIME`  datetime NULL DEFAULT NULL COMMENT '审批时间' ,
`REJECT_REASON`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退回原因' ,
`CREATOR_ID`  int(11) NULL DEFAULT NULL COMMENT '创建者' ,
`CREATED_TIME`  datetime NULL DEFAULT NULL COMMENT '创建时间' ,
`MODIFIER_ID`  int(11) NULL DEFAULT NULL COMMENT '最后修改者' ,
`MODIFIED_TIME`  timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='流程任务表'
AUTO_INCREMENT=422

;

-- ----------------------------
-- Indexes structure for table `attachment`
-- ----------------------------
CREATE INDEX `INDEX_MODIFIED_TIME` ON `attachment`(`MODIFIED_TIME`) USING BTREE ;
CREATE INDEX `INDEX_DICTIONARY_ID` ON `attachment`(`RECORD_ID`) USING BTREE ;
CREATE INDEX `INDEX_TYPE` ON `attachment`(`TYPE_DICT`) USING BTREE ;
CREATE INDEX `INDEX_CREATE_ID` ON `attachment`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `attachment`(`MODIFIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODULE` ON `attachment`(`MODULE_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `attachment`
-- ----------------------------
ALTER TABLE `attachment` AUTO_INCREMENT=35;

-- ----------------------------
-- Indexes structure for table `contact`
-- ----------------------------
CREATE INDEX `INDEX_TYPE` ON `contact`(`ACCOUNT_ID`) USING BTREE ;
CREATE INDEX `INDEX_OWNER` ON `contact`(`OWNER`) USING BTREE ;
CREATE INDEX `INDEX_NAME` ON `contact`(`NAME`) USING BTREE ;
CREATE INDEX `INDEX_MOBILE` ON `contact`(`MOBILE`) USING BTREE ;
CREATE INDEX `INDEX_PHONE` ON `contact`(`PHONE`) USING BTREE ;
CREATE INDEX `INDEX_SUPPLIER_ID` ON `contact`(`SUPPLIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `contact`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `contact`(`MODIFIER_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `contact`
-- ----------------------------
ALTER TABLE `contact` AUTO_INCREMENT=8;

-- ----------------------------
-- Indexes structure for table `contract`
-- ----------------------------
CREATE UNIQUE INDEX `INDEX_CODE` ON `contract`(`CODE`) USING BTREE ;
CREATE INDEX `INDEX_ORDER_ID` ON `contract`(`ORDER_ID`) USING BTREE ;
CREATE INDEX `INDEX_ACCOUNT_ID` ON `contract`(`ACCOUNT_ID`) USING BTREE ;
CREATE INDEX `INDEX_TYPE` ON `contract`(`TYPE_DIC`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `contract`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `contract`(`MODIFIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIED_TIME` ON `contract`(`MODIFIED_TIME`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `contract`
-- ----------------------------
ALTER TABLE `contract` AUTO_INCREMENT=3;

-- ----------------------------
-- Indexes structure for table `customer`
-- ----------------------------
CREATE INDEX `INDEX_ACCOUNT_OWNER` ON `customer`(`OWNER`) USING BTREE ;
CREATE INDEX `INDEX_PHONE` ON `customer`(`PHONE`) USING BTREE ;
CREATE INDEX `INDEX_MOBILE` ON `customer`(`MOBILE`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIED_TIME` ON `customer`(`MODIFIED_TIME`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `customer`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `customer`(`MODIFIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_TYPE` ON `customer`(`TYPE_DIC`) USING BTREE ;
CREATE INDEX `INDEX_PROVINCE` ON `customer`(`PROVINCE`) USING BTREE ;
CREATE INDEX `INDEX_CITY` ON `customer`(`CITY`) USING BTREE ;
CREATE INDEX `INDEX_COUNTY` ON `customer`(`COUNTY`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `customer`
-- ----------------------------
ALTER TABLE `customer` AUTO_INCREMENT=9;

-- ----------------------------
-- Indexes structure for table `import_log`
-- ----------------------------
CREATE INDEX `INDEX_IMPORT_LOG_ID` ON `import_log`(`ID`) USING BTREE ;
CREATE INDEX `INDEX_STATUS` ON `import_log`(`STATUS`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `import_log`
-- ----------------------------
ALTER TABLE `import_log` AUTO_INCREMENT=1;

-- ----------------------------
-- Indexes structure for table `lead`
-- ----------------------------
CREATE INDEX `INDEX_OWNER` ON `lead`(`OWNER`) USING BTREE ;
CREATE INDEX `INDEX_NAME` ON `lead`(`NAME`) USING BTREE ;
CREATE INDEX `INDEX_PHONE` ON `lead`(`PHONE`) USING BTREE ;
CREATE INDEX `INDEX_MOBILE` ON `lead`(`MOBILE`) USING BTREE ;
CREATE INDEX `INDEX_STATUS` ON `lead`(`STATUS`) USING BTREE ;
CREATE INDEX `INDEX_CREATER_ID` ON `lead`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `lead`(`MODIFIER_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `lead`
-- ----------------------------
ALTER TABLE `lead` AUTO_INCREMENT=6;

-- ----------------------------
-- Indexes structure for table `market_activity`
-- ----------------------------
CREATE INDEX `INDEX_ACTIVITY_STATUS` ON `market_activity`(`STATUS_DIC`) USING BTREE ;
CREATE INDEX `INDEX-CREATOR_ID` ON `market_activity`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIED_TIME` ON `market_activity`(`MODIFIED_TIME`) USING BTREE ;
CREATE INDEX `INDEX-MODIFIER_ID` ON `market_activity`(`MODIFIER_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `market_activity`
-- ----------------------------
ALTER TABLE `market_activity` AUTO_INCREMENT=13;

-- ----------------------------
-- Indexes structure for table `memoir`
-- ----------------------------
CREATE INDEX `INDEX_ID` ON `memoir`(`ID`) USING BTREE ;
CREATE INDEX `INDEX_TYPE` ON `memoir`(`MODULE_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODULE_ID` ON `memoir`(`RECORD_ID`) USING BTREE ;
CREATE INDEX `INDEX_EMPLOYEE_ID` ON `memoir`(`USER_ID`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `memoir`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `memoir`(`MODIFIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIED_TIME` ON `memoir`(`MODIFIED_TIME`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `memoir`
-- ----------------------------
ALTER TABLE `memoir` AUTO_INCREMENT=5;

-- ----------------------------
-- Indexes structure for table `notice`
-- ----------------------------
CREATE INDEX `INDEX_MODIFIED_TIME` ON `notice`(`MODIFIED_TIME`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `notice`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `notice`(`MODIFIER_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `notice`
-- ----------------------------
ALTER TABLE `notice` AUTO_INCREMENT=3;

-- ----------------------------
-- Indexes structure for table `order`
-- ----------------------------
CREATE UNIQUE INDEX `INDEX_CODE` ON `order`(`CODE`) USING BTREE ;
CREATE INDEX `INDEX_PRODUCT_ID` ON `order`(`PRODUCT_ID`) USING BTREE ;
CREATE INDEX `INDEX_ACCOUNT_ID` ON `order`(`CUSTOMER_ID`) USING BTREE ;
CREATE INDEX `INDEX_SALES_PERSON_ID` ON `order`(`OWNER`) USING BTREE ;
CREATE INDEX `INDEX_SALES_MANAGER_ID` ON `order`(`SALES_MANAGER_ID`) USING BTREE ;
CREATE INDEX `INDEX_SALES_MAJORDOMO_ID` ON `order`(`SALES_MAJORDOMO_ID`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `order`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `order`(`MODIFIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIED_TIME` ON `order`(`MODIFIED_TIME`) USING BTREE ;
CREATE INDEX `INDEX_ORDER_END_TIME` ON `order`(`ORDER_END_TIME`) USING BTREE ;
CREATE INDEX `INDEX_PAY_STATUS` ON `order`(`PAY_STATUS`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `order`
-- ----------------------------
ALTER TABLE `order` AUTO_INCREMENT=29;

-- ----------------------------
-- Indexes structure for table `payments`
-- ----------------------------
CREATE INDEX `INDEX_NAME` ON `payments`(`NAME`) USING BTREE ;
CREATE INDEX `INDEX_FUND` ON `payments`(`FUND`) USING BTREE ;
CREATE INDEX `INDEX_ACTUAL` ON `payments`(`ACTUAL`) USING BTREE ;
CREATE INDEX `INDEX_OPERATE_TIME` ON `payments`(`OPERATE_TIME`) USING BTREE ;
CREATE INDEX `INDEX_STATUS` ON `payments`(`STATUS`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `payments`
-- ----------------------------
ALTER TABLE `payments` AUTO_INCREMENT=24;

-- ----------------------------
-- Indexes structure for table `pro_city_area`
-- ----------------------------
CREATE INDEX `INDEX_PID` ON `pro_city_area`(`PID`) USING BTREE ;

-- ----------------------------
-- Indexes structure for table `product`
-- ----------------------------
CREATE UNIQUE INDEX `INDEX_CODE` ON `product`(`CODE`) USING BTREE ;
CREATE INDEX `INDEX_PROJECT_ID` ON `product`(`PROJECT_ID`) USING BTREE ;
CREATE INDEX `INDEX_NAME` ON `product`(`NAME`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `product`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `product`(`MODIFIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIED_TIME` ON `product`(`MODIFIED_TIME`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `product`
-- ----------------------------
ALTER TABLE `product` AUTO_INCREMENT=5;

-- ----------------------------
-- Indexes structure for table `project`
-- ----------------------------
CREATE UNIQUE INDEX `INDEX_CODE` ON `project`(`CODE`) USING BTREE ;
CREATE INDEX `INDEX_SUPPLIER_ID` ON `project`(`SUPPLIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_NAME` ON `project`(`NAME`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `project`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `project`(`MODIFIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIED_TIME` ON `project`(`MODIFIED_TIME`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `project`
-- ----------------------------
ALTER TABLE `project` AUTO_INCREMENT=2;

-- ----------------------------
-- Indexes structure for table `qrtz_triggers`
-- ----------------------------
CREATE INDEX `JOB_NAME` ON `qrtz_triggers`(`JOB_NAME`, `JOB_GROUP`) USING BTREE ;

-- ----------------------------
-- Indexes structure for table `receivables`
-- ----------------------------
CREATE INDEX `INDEX_STATUS` ON `receivables`(`STATUS`) USING BTREE ;
CREATE INDEX `INDEX_FUND` ON `receivables`(`FUND`) USING BTREE ;
CREATE INDEX `INDEX_ACTUAL` ON `receivables`(`ACTUAL`) USING BTREE ;
CREATE INDEX `INDEX_OPERATE_TIME` ON `receivables`(`OPERATE_TIME`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `receivables`
-- ----------------------------
ALTER TABLE `receivables` AUTO_INCREMENT=8;

-- ----------------------------
-- Auto increment value for `report`
-- ----------------------------
ALTER TABLE `report` AUTO_INCREMENT=5;

-- ----------------------------
-- Indexes structure for table `sales_target`
-- ----------------------------
CREATE INDEX `INDEX_ORG_ID` ON `sales_target`(`OWNER_ID`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `sales_target`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `sales_target`(`MODIFIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIED_TIME` ON `sales_target`(`MODIFIED_TIME`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sales_target`
-- ----------------------------
ALTER TABLE `sales_target` AUTO_INCREMENT=8;

-- ----------------------------
-- Indexes structure for table `sm_audit_log`
-- ----------------------------
CREATE INDEX `INDEX_USER_ID` ON `sm_audit_log`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODULE_NAME` ON `sm_audit_log`(`MODULE_NAME`) USING BTREE ;
CREATE INDEX `INDEX_TYPE` ON `sm_audit_log`(`TYPE`) USING BTREE ;
CREATE INDEX `INDEX_CREATED_TIME` ON `sm_audit_log`(`CREATED_TIME`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_audit_log`
-- ----------------------------
ALTER TABLE `sm_audit_log` AUTO_INCREMENT=543;

-- ----------------------------
-- Indexes structure for table `sm_component`
-- ----------------------------
CREATE UNIQUE INDEX `INDEX_CODE` ON `sm_component`(`CODE`) USING BTREE ;
CREATE INDEX `INDEX_NAME` ON `sm_component`(`NAME`) USING BTREE ;
CREATE INDEX `INDEX_URL` ON `sm_component`(`URL`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIED_TIME` ON `sm_component`(`MODIFIED_TIME`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `sm_component`(`MODIFIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `sm_component`(`CREATOR_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_component`
-- ----------------------------
ALTER TABLE `sm_component` AUTO_INCREMENT=23;

-- ----------------------------
-- Auto increment value for `sm_dictionary`
-- ----------------------------
ALTER TABLE `sm_dictionary` AUTO_INCREMENT=347;

-- ----------------------------
-- Indexes structure for table `sm_function`
-- ----------------------------
CREATE UNIQUE INDEX `INDEX_URL` ON `sm_function`(`URL`) USING BTREE ;
CREATE INDEX `INDEX_MENU_ID` ON `sm_function`(`MENU_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIED_TIME` ON `sm_function`(`MODIFIED_TIME`) USING BTREE ;
CREATE INDEX `INDEX_CODE` ON `sm_function`(`CODE`) USING BTREE ;
CREATE INDEX `INDEX_NAME` ON `sm_function`(`NAME`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `sm_function`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `sm_function`(`MODIFIER_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_function`
-- ----------------------------
ALTER TABLE `sm_function` AUTO_INCREMENT=330;

-- ----------------------------
-- Indexes structure for table `sm_menu`
-- ----------------------------
CREATE UNIQUE INDEX `INDEX_NAME` ON `sm_menu`(`NAME`) USING BTREE ;
CREATE INDEX `INDEX_CREAOR_ID` ON `sm_menu`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `sm_menu`(`MODIFIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_ORDER` ON `sm_menu`(`ORDER`) USING BTREE ;
CREATE INDEX `INDEX_URL` ON `sm_menu`(`URL`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_menu`
-- ----------------------------
ALTER TABLE `sm_menu` AUTO_INCREMENT=50;

-- ----------------------------
-- Indexes structure for table `sm_message`
-- ----------------------------
CREATE INDEX `INDEX_MODIFIED_TIME` ON `sm_message`(`MODIFIED_TIME`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `sm_message`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `sm_message`(`MODIFIER_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_message`
-- ----------------------------
ALTER TABLE `sm_message` AUTO_INCREMENT=62;

-- ----------------------------
-- Indexes structure for table `sm_module`
-- ----------------------------
CREATE UNIQUE INDEX `INDEX_URL` ON `sm_module`(`URL`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_module`
-- ----------------------------
ALTER TABLE `sm_module` AUTO_INCREMENT=22;

-- ----------------------------
-- Indexes structure for table `sm_module_type`
-- ----------------------------
CREATE UNIQUE INDEX `INDEX_TYPE_ID_MODULE_ID` ON `sm_module_type`(`TYPE_ID`, `MODULE_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_module_type`
-- ----------------------------
ALTER TABLE `sm_module_type` AUTO_INCREMENT=23;

-- ----------------------------
-- Indexes structure for table `sm_org`
-- ----------------------------
CREATE INDEX `INDEX_CREATOR_ID` ON `sm_org`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `sm_org`(`MODIFIER_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_org`
-- ----------------------------
ALTER TABLE `sm_org` AUTO_INCREMENT=111;

-- ----------------------------
-- Indexes structure for table `sm_org_role`
-- ----------------------------
CREATE INDEX `INDEX_ORG_ID` ON `sm_org_role`(`ORG_ID`) USING BTREE ;
CREATE INDEX `INDEX_ROLE_ID` ON `sm_org_role`(`ROLE_ID`) USING BTREE ;

-- ----------------------------
-- Indexes structure for table `sm_position`
-- ----------------------------
CREATE INDEX `INDEX_NO` ON `sm_position`(`CODE`) USING BTREE ;
CREATE INDEX `INDEX_NAME` ON `sm_position`(`NAME`) USING BTREE ;
CREATE INDEX `INDEX_CREATEOR_ID` ON `sm_position`(`CREATEOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `sm_position`(`MODIFIER_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_position`
-- ----------------------------
ALTER TABLE `sm_position` AUTO_INCREMENT=1;

-- ----------------------------
-- Indexes structure for table `sm_recyclebin`
-- ----------------------------
CREATE INDEX `INDEX_USER_ID` ON `sm_recyclebin`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODULE_NAME` ON `sm_recyclebin`(`MODULE_NAME`) USING BTREE ;
CREATE INDEX `INDEX_CREATED_TIME` ON `sm_recyclebin`(`CREATED_TIME`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_recyclebin`
-- ----------------------------
ALTER TABLE `sm_recyclebin` AUTO_INCREMENT=54;

-- ----------------------------
-- Indexes structure for table `sm_role`
-- ----------------------------
CREATE UNIQUE INDEX `INDEX_NAME` ON `sm_role`(`NAME`) USING BTREE ;
CREATE UNIQUE INDEX `INDEX_CODE` ON `sm_role`(`CODE`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `sm_role`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `sm_role`(`MODIFIER_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_role`
-- ----------------------------
ALTER TABLE `sm_role` AUTO_INCREMENT=13;

-- ----------------------------
-- Indexes structure for table `sm_role_func`
-- ----------------------------
CREATE INDEX `INDEX_ROLE_ID` ON `sm_role_func`(`ROLE_ID`) USING BTREE ;
CREATE INDEX `INDEX_FUNC_ID` ON `sm_role_func`(`FUNC_ID`) USING BTREE ;

-- ----------------------------
-- Indexes structure for table `sm_user`
-- ----------------------------
CREATE UNIQUE INDEX `INDEX_LOGIN_NAME` ON `sm_user`(`LOGIN_NAME`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `sm_user`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `sm_user`(`MODIFIER_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_user`
-- ----------------------------
ALTER TABLE `sm_user` AUTO_INCREMENT=37;

-- ----------------------------
-- Indexes structure for table `sm_user_com`
-- ----------------------------
CREATE INDEX `INDEX_USER_ID` ON `sm_user_com`(`USER_ID`) USING BTREE ;
CREATE INDEX `INDEX_COM_ID` ON `sm_user_com`(`COM_ID`) USING BTREE ;

-- ----------------------------
-- Indexes structure for table `sm_user_func`
-- ----------------------------
CREATE INDEX `INDEX_USER_ID` ON `sm_user_func`(`USER_ID`) USING BTREE ;
CREATE INDEX `INDEX_FUNC_ID` ON `sm_user_func`(`FUNC_ID`) USING BTREE ;

-- ----------------------------
-- Indexes structure for table `sm_user_org`
-- ----------------------------
CREATE INDEX `INDEX_USER_ID` ON `sm_user_org`(`USER_ID`) USING BTREE ;
CREATE INDEX `INDEX_ORG_ID` ON `sm_user_org`(`ORG_ID`) USING BTREE ;

-- ----------------------------
-- Indexes structure for table `sm_user_position`
-- ----------------------------
CREATE INDEX `INDEX-USER_ID` ON `sm_user_position`(`USER_ID`) USING BTREE ;
CREATE INDEX `INDEX_POS_ID` ON `sm_user_position`(`POS_ID`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `sm_user_position`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `sm_user_position`(`MODIFIER_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIED_TIME` ON `sm_user_position`(`MODIFIED_TIME`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_user_position`
-- ----------------------------
ALTER TABLE `sm_user_position` AUTO_INCREMENT=1;

-- ----------------------------
-- Indexes structure for table `sm_user_role`
-- ----------------------------
CREATE INDEX `INDEX_ROLE_ID` ON `sm_user_role`(`ROLE_ID`) USING BTREE ;
CREATE INDEX `INDEX_USER_ID` ON `sm_user_role`(`USER_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sm_workbanch`
-- ----------------------------
ALTER TABLE `sm_workbanch` AUTO_INCREMENT=12;

-- ----------------------------
-- Indexes structure for table `supplier`
-- ----------------------------
CREATE INDEX `INDEX_MODIFIED_TIME` ON `supplier`(`MODIFIED_TIME`) USING BTREE ;
CREATE INDEX `INDEX_NAME` ON `supplier`(`NAME`) USING BTREE ;
CREATE INDEX `INDEX_TYPE` ON `supplier`(`TYPE`) USING BTREE ;
CREATE INDEX `INDEX_CREATOR_ID` ON `supplier`(`CREATOR_ID`) USING BTREE ;
CREATE INDEX `INDEX_MODIFIER_ID` ON `supplier`(`MODIFIER_ID`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `supplier`
-- ----------------------------
ALTER TABLE `supplier` AUTO_INCREMENT=3;

-- ----------------------------
-- Indexes structure for table `user_message`
-- ----------------------------
CREATE INDEX `INDEX_ID` ON `user_message`(`ID`) USING BTREE ;
CREATE INDEX `INDEX_MESSAGE_ID` ON `user_message`(`MESSAGE_ID`) USING BTREE ;
CREATE INDEX `INDEX_USER_ID` ON `user_message`(`USER_ID`) USING BTREE ;
CREATE INDEX `INDEX_STATUS` ON `user_message`(`STATUS`) USING BTREE ;
CREATE INDEX `INDEX_TYPE` ON `user_message`(`TYPE`) USING BTREE ;
CREATE INDEX `INDEX_CREATED_TIME` ON `user_message`(`CREATED_TIME`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `user_message`
-- ----------------------------
ALTER TABLE `user_message` AUTO_INCREMENT=91;

-- ----------------------------
-- Indexes structure for table `wf_node`
-- ----------------------------
CREATE UNIQUE INDEX `INDEX_CODE` ON `wf_node`(`CODE`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `wf_node`
-- ----------------------------
ALTER TABLE `wf_node` AUTO_INCREMENT=17;

-- ----------------------------
-- Auto increment value for `wf_task`
-- ----------------------------
ALTER TABLE `wf_task` AUTO_INCREMENT=422;
