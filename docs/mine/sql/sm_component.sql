/*
MySQL Data Transfer
Source Host: 192.168.111.141
Source Database: hxtd
Target Host: 192.168.111.141
Target Database: hxtd
Date: 2014/6/24 18:10:43
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for sm_component
-- ----------------------------
CREATE TABLE `sm_component` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '组件编号',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '组件名称',
  `URL` varchar(64) NOT NULL DEFAULT '' COMMENT '组件调用入口',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `PRIVILEGE_LEVEL_ID` int(11) NOT NULL,
  `IS_DELETED` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_URL` (`URL`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=110207 DEFAULT CHARSET=utf8 COMMENT='组件表';

-- ----------------------------
-- Table structure for sm_dictionary
-- ----------------------------
CREATE TABLE `sm_dictionary` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KEY` varchar(64) NOT NULL DEFAULT '',
  `VALUE` varchar(64) NOT NULL DEFAULT '',
  `PARENT_ID` int(11) DEFAULT '0',
  `LEVEL` int(11) DEFAULT NULL,
  `ORDER` int(11) DEFAULT NULL,
  `TYPE` varchar(64) DEFAULT NULL,
  `IS_ACTIVE` int(11) DEFAULT '1',
  `REMARK` varchar(512) NOT NULL DEFAULT '',
  `CREATOR_ID` int(10) unsigned DEFAULT '0',
  `CREATED_TIME` datetime NOT NULL,
  `MODIFIER_ID` int(11) DEFAULT '0',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '标记删除',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11010217 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sm_function
-- ----------------------------
CREATE TABLE `sm_function` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `MENU_ID` int(11) DEFAULT NULL,
  `CODE` varchar(32) NOT NULL DEFAULT '0' COMMENT '功能编号',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '功能名称',
  `URL` varchar(64) DEFAULT NULL,
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `PRIVILEGE_LEVEL_ID` int(11) DEFAULT '0',
  `IS_DELETED` int(11) DEFAULT '0',
  `PARENT_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_URL` (`URL`),
  KEY `INDEX_MENU_ID` (`MENU_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_CODE` (`CODE`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=100403 DEFAULT CHARSET=utf8 COMMENT='功能表';

-- ----------------------------
-- Table structure for sm_menu
-- ----------------------------
CREATE TABLE `sm_menu` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `CODE` varchar(32) DEFAULT '',
  `NAME` varchar(32) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `PARENT_MENU_ID` int(11) DEFAULT NULL,
  `URL` varchar(64) DEFAULT '' COMMENT '链接地址',
  `IS_ACTIVE` char(1) NOT NULL DEFAULT '1' COMMENT '是否启用 1启用0禁用',
  `ORDER` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `SEQ` int(11) NOT NULL DEFAULT '0' COMMENT '菜单队列',
  `LEVEL` int(11) NOT NULL DEFAULT '0' COMMENT '等级',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `CREATOR_ID` int(11) DEFAULT NULL,
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `SHOW_LOCATION_ID` int(11) DEFAULT NULL,
  `TRIGGER_ID` int(11) DEFAULT NULL COMMENT '触发菜单执行哪个功能',
  `IS_LEAF` tinyint(1) NOT NULL,
  `IS_DELETED` tinyint(1) NOT NULL DEFAULT '0',
  `DEFAULT_SHOW` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `INDEX_NO` (`CODE`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_CREAOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Table structure for sm_org
-- ----------------------------
CREATE TABLE `sm_org` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(32) NOT NULL,
  `TYPE` int(11) NOT NULL DEFAULT '0' COMMENT '类型 1公司 2部门 3组',
  `PARENT_ORG_ID` int(11) DEFAULT NULL,
  `SHORT_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '机构简称',
  `FULL_NAME` varchar(128) DEFAULT NULL,
  `ADDRESS` varchar(512) NOT NULL DEFAULT '' COMMENT '地址',
  `ZIP_CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '邮政编码',
  `PHONE` varchar(32) NOT NULL COMMENT '手机号码',
  `EMAIL` varchar(32) NOT NULL DEFAULT '' COMMENT '邮箱',
  `WEB_SITE` varchar(64) NOT NULL DEFAULT '' COMMENT '站点',
  `STATUS` int(11) DEFAULT NULL,
  `ORDER` int(11) NOT NULL DEFAULT '0' COMMENT '排列顺序',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` datetime NOT NULL COMMENT '最后修改时间',
  `IS_LEAF` tinyint(1) NOT NULL,
  `LEVEL` int(11) DEFAULT NULL,
  `IS_DELETED` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_FULL_NAME` (`FULL_NAME`),
  KEY `INDEX_NO` (`CODE`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_SHORT_NAME` (`SHORT_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=10321 DEFAULT CHARSET=utf8 COMMENT='机构表';

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
-- Table structure for sm_role
-- ----------------------------
CREATE TABLE `sm_role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `CODE` varchar(32) DEFAULT NULL,
  `NAME` varchar(16) DEFAULT NULL,
  `TYPE` int(11) NOT NULL DEFAULT '0' COMMENT '角色类型',
  `REMARK` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) DEFAULT NULL,
  `MODIFIED_TIME` timestamp NULL DEFAULT NULL,
  `IS_DELETED` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_NAME` (`NAME`),
  UNIQUE KEY `INDEX_CODE` (`CODE`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=45588 DEFAULT CHARSET=utf8 COMMENT='角色表';

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
-- Table structure for sm_trace_log
-- ----------------------------
CREATE TABLE `sm_trace_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `MODULE_NAME` varchar(64) DEFAULT '' COMMENT '日志名称',
  `OPERATE_TIME` datetime DEFAULT NULL COMMENT '操作时间',
  `TYPE` int(11) DEFAULT '0' COMMENT '操作类型',
  `OPERATOR` varchar(32) DEFAULT '0' COMMENT '用户ID',
  `RECORD_ID` varchar(64) NOT NULL DEFAULT '' COMMENT '日志内容',
  `RECORD_NAME` varchar(64) DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `INDEX_NAME` (`MODULE_NAME`),
  KEY `INDEX_USER_ID` (`OPERATOR`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='日志表';

-- ----------------------------
-- Table structure for sm_user
-- ----------------------------
CREATE TABLE `sm_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `LOGIN_NAME` varchar(32) NOT NULL DEFAULT '' COMMENT '登录名',
  `PASSWORD` varchar(64) NOT NULL DEFAULT '' COMMENT '密码',
  `CODE` varchar(32) DEFAULT '',
  `USER_NAME` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `ORDER` int(11) DEFAULT NULL,
  `IS_ACTIVE` char(1) NOT NULL DEFAULT '1' COMMENT '是否启用 1启用 0禁用',
  `JOB_SITUATION` int(11) DEFAULT NULL,
  `SEX_ID` int(11) DEFAULT NULL,
  `PHONE` varchar(32) NOT NULL DEFAULT '' COMMENT '电话号码',
  `MOBILE` varchar(32) NOT NULL DEFAULT '' COMMENT '手机号码',
  `EMAIL` varchar(32) NOT NULL DEFAULT '' COMMENT '邮箱',
  `QQ` varchar(16) NOT NULL DEFAULT '',
  `IS_MANAGER` int(11) NOT NULL,
  `JOB_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '职位',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) DEFAULT NULL,
  `MODIFIED_TIME` timestamp NULL DEFAULT NULL,
  `STORE_STATUS` int(11) DEFAULT NULL COMMENT '数据存储状态：1.最新的；2.延迟的',
  `ORGANIZATION_ID` int(11) NOT NULL,
  `IS_DELETED` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_LOGIN_NAME` (`LOGIN_NAME`),
  KEY `INDEX_NO` (`CODE`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=26644 DEFAULT CHARSET=utf8 COMMENT='用户表';

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
-- Table structure for supplier
-- ----------------------------
CREATE TABLE `supplier` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '供应商名',
  `TYPE` int(4) NOT NULL DEFAULT '0' COMMENT '供应商分类',
  `PHONE` varchar(32) NOT NULL DEFAULT '' COMMENT '电话',
  `MOBILE` varchar(32) NOT NULL DEFAULT '' COMMENT '手机',
  `FAX` varchar(32) NOT NULL DEFAULT '' COMMENT '传真',
  `PROVINCE` varchar(32) DEFAULT '0' COMMENT '省份',
  `CITY` varchar(32) DEFAULT '0' COMMENT '城市',
  `COUNTY` varchar(32) DEFAULT '0' COMMENT '区/县',
  `EMAIL` varchar(32) NOT NULL DEFAULT '' COMMENT '邮箱',
  `ADDRESS` varchar(512) NOT NULL DEFAULT '' COMMENT '详细地址',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `IS_DELETED` int(11) DEFAULT '0',
  `OWNER` int(11) NOT NULL DEFAULT '0' COMMENT '所有者',
  PRIMARY KEY (`ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_TYPE` (`TYPE`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='供应商';

-- ----------------------------
-- Table structure for sysmessage
-- ----------------------------
CREATE TABLE `sysmessage` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `TITLE` varchar(64) NOT NULL DEFAULT '' COMMENT '标题',
  `CONTENT` text NOT NULL COMMENT '内容',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `IS_DELETED` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 COMMENT='系统消息';

-- ----------------------------
-- Table structure for user_message
-- ----------------------------
CREATE TABLE `user_message` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MESSAGE_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `STATUS` int(11) NOT NULL,
  `IS_DELETED` int(6) NOT NULL DEFAULT '0',
  `TYPE` smallint(6) NOT NULL COMMENT '发送true或接收信息false',
  `CREATED_TIME` datetime NOT NULL,
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `sm_component` VALUES ('1', '001', '省市区三级联动', '/common/pcas/getChildren.docomp', '请问士大夫', '1', '2014-06-17 00:00:00', '1', '2014-06-19 14:57:12', '1060101', '1');
INSERT INTO `sm_component` VALUES ('2', '003', '查询组件联系纪要', '/common/memoir/query.do', '查询组件联系纪要', '1', '2014-06-19 00:00:00', '1', '2014-06-19 00:00:00', '1060103', '0');
INSERT INTO `sm_component` VALUES ('3', '002', '新增联系纪要', '/common/memoir/add.docomp', '新增联系纪要', '1', '2014-06-19 00:00:00', '1', '2014-06-19 00:00:00', '1060103', '0');
INSERT INTO `sm_component` VALUES ('4', '004', '编辑联系纪要', '/common/memoir/modify.docomp', '查看联系纪要', '1', '2014-05-30 16:09:57', '1', '2014-06-19 14:57:00', '1060103', '0');
INSERT INTO `sm_component` VALUES ('5', '005', '查看联系纪要', '/common/memoir/view.docomp', '查看联系纪要', '1', '2014-05-30 16:11:08', '1', '2014-06-19 15:00:29', '1060103', '1');
INSERT INTO `sm_component` VALUES ('6', '006', '省市区三级联动获取根', '/common/pcas/getRoot.docomp', '', '1', '2014-06-04 00:00:00', '1', '2014-06-10 14:47:26', '1060101', '0');
INSERT INTO `sm_component` VALUES ('101', '000101', '唯一性验证', '/common/common/unique.docomp', '', '1', '2014-01-01 00:00:00', '1', '2014-06-20 17:45:33', '1060101', '0');
INSERT INTO `sm_component` VALUES ('110204', '007', '项目列表组件', '/project/project/toQueryPage.comp', '项目列表组件', '1', '2014-06-10 00:00:00', '1', '2014-06-10 00:00:00', '1060101', '0');
INSERT INTO `sm_component` VALUES ('110205', '1222', '无法认同', '爱仕达f', ' 等方式', '1', '2014-06-14 00:00:00', '1', '2014-06-19 14:57:05', '1060101', '0');
INSERT INTO `sm_component` VALUES ('110206', '0200', '线索名称', '/workbanch/toViewPage.do', 'FDASF', '1', '2014-06-19 00:00:00', '1', '2014-06-19 00:00:00', '1060101', '0');
INSERT INTO `sm_dictionary` VALUES ('1', '打开方式', '01', '1030101', null, '0', '显示位置', '1', '', '1', '2014-06-06 13:32:39', '1', '2014-06-25 10:31:51', '1');
INSERT INTO `sm_dictionary` VALUES ('2', '显示位置', '02', null, null, null, null, '1', '', '1', '2014-06-06 13:34:20', '1', '2014-06-19 14:23:56', '0');
INSERT INTO `sm_dictionary` VALUES ('3', '机构类型', '03', null, null, null, null, '1', '', '1', '2014-06-06 13:35:25', '1', '2014-06-06 13:36:14', '0');
INSERT INTO `sm_dictionary` VALUES ('10201', '打开方式', '010201', null, null, '0', null, '1', '用户菜单打开方式', '1', '2014-05-26 00:00:00', '1', '2014-06-19 14:24:06', '0');
INSERT INTO `sm_dictionary` VALUES ('10202', '显示位置', '010202', null, '0', '0', null, '1', '菜单显示位置', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02', '0');
INSERT INTO `sm_dictionary` VALUES ('10301', '类型', '010301', null, '0', '0', null, '1', '组织类型', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02', '1');
INSERT INTO `sm_dictionary` VALUES ('10401', '类型', '010401', null, '0', '0', null, '1', '用户类型', null, '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02', '0');
INSERT INTO `sm_dictionary` VALUES ('10403', '工作状态', '010403', null, '0', '0', null, '1', '用户工作状态', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '1');
INSERT INTO `sm_dictionary` VALUES ('10404', '数据存储状态', '010404', null, '0', '0', null, '1', '用户数据存储状态', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('10501', '角色类型', '010501', null, '0', '0', null, '1', '角色类型', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('10601', '权限级别', '010601', null, '0', '0', null, '1', '功能权限级别', '1', '2014-05-26 00:00:00', '1', '2014-06-04 10:59:39', '0');
INSERT INTO `sm_dictionary` VALUES ('30101', '活动类型', '030101', null, '0', '0', null, '1', '', '1', '2014-05-27 10:50:08', '1', '2014-05-27 10:50:08', '0');
INSERT INTO `sm_dictionary` VALUES ('30102', '活动状态', '030102', null, '0', '0', null, '1', '', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52', '0');
INSERT INTO `sm_dictionary` VALUES ('40101', '线索来源', '040101', null, '0', '0', null, '1', '线索来源', '1', '2014-05-29 10:10:48', '1', '2014-05-29 10:10:38', '0');
INSERT INTO `sm_dictionary` VALUES ('40102', '线索状态', '040102', null, '0', '0', null, '1', '线索状态', '1', '2014-05-29 10:12:27', '1', '2014-05-29 10:12:16', '0');
INSERT INTO `sm_dictionary` VALUES ('40103', '银行卡类型', '040103', null, '0', '0', null, '1', '证件类型', '1', '2014-05-29 10:13:42', '1', '2014-06-05 16:38:25', '0');
INSERT INTO `sm_dictionary` VALUES ('40104', '行业', '040104', null, '0', '0', null, '1', '行业', '1', '2014-05-29 10:14:48', '1', '2014-05-29 10:16:08', '0');
INSERT INTO `sm_dictionary` VALUES ('40301', '客户类型', '040301', null, '0', '0', null, '1', '客户类型', '1', '2014-05-27 15:20:19', '1', '2014-05-28 12:36:53', '0');
INSERT INTO `sm_dictionary` VALUES ('40302', '客户来源', '040302', null, '0', '0', null, '1', '客户来源', '1', '2014-05-27 17:16:45', '1', '2014-05-27 17:34:23', '0');
INSERT INTO `sm_dictionary` VALUES ('40303', '证件类型', '040303', null, '0', '0', null, '1', '证件类型', '1', '2014-05-27 17:39:55', '1', '2014-05-27 17:40:02', '0');
INSERT INTO `sm_dictionary` VALUES ('40304', '风险等级', '040304', null, '0', '0', null, '1', '风险等级', '1', '2014-05-27 17:48:08', '1', '2014-05-27 17:48:20', '0');
INSERT INTO `sm_dictionary` VALUES ('40305', '行业', '040305', null, '0', '0', null, '1', '行业', '1', '2014-05-27 18:00:00', '1', '2014-05-27 18:00:07', '0');
INSERT INTO `sm_dictionary` VALUES ('40306', '所有权', '040306', null, '0', '0', null, '1', '所有权', '1', '2014-05-27 18:05:37', '1', '2014-05-27 18:05:43', '0');
INSERT INTO `sm_dictionary` VALUES ('40307', '开户行', '040307', null, '0', '0', null, '1', '开户行', '1', '2014-05-27 18:29:45', '1', '2014-05-27 18:29:50', '0');
INSERT INTO `sm_dictionary` VALUES ('50101', '供应商类型', '050101', null, '0', '0', null, '1', '供应商类型', '1', '2014-05-26 00:00:00', '1', '2014-05-29 10:10:02', '0');
INSERT INTO `sm_dictionary` VALUES ('100401', '操作类型', '100401', '0', '0', '0', null, '1', '操作类型', '1', '2014-06-23 18:36:54', '1', '2014-06-23 18:37:07', '0');
INSERT INTO `sm_dictionary` VALUES ('110101', '关联模块', '110101', null, '0', '0', null, '1', '附件关联模块', '1', '2014-05-27 10:29:14', '1', '2014-05-27 10:29:21', '0');
INSERT INTO `sm_dictionary` VALUES ('110102', '附件类型', '110102', null, '0', '0', null, '1', '附件类型', '1', '2014-05-27 10:29:53', '1', '2014-05-27 10:29:50', '0');
INSERT INTO `sm_dictionary` VALUES ('1020101', '常规的', '01020101', '10201', '0', '0', '菜单打开方式', '1', '用户菜单打开方式', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02', '0');
INSERT INTO `sm_dictionary` VALUES ('1020201', '标题栏右侧', '01020201', '10202', '0', '0', '显示位置', '1', '菜单显示位置', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02', '0');
INSERT INTO `sm_dictionary` VALUES ('1020202', '菜单栏', '01020202', '10202', '0', '0', '显示位置', '1', '菜单显示位置', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02', '0');
INSERT INTO `sm_dictionary` VALUES ('1030101', '公司', '01030101', '10301', '0', '0', '机构类型', '1', '组织类型', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02', '0');
INSERT INTO `sm_dictionary` VALUES ('1030102', '部门', '01030102', '10301', '0', '0', '机构类型', '1', '组织类型', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02', '0');
INSERT INTO `sm_dictionary` VALUES ('1030103', '组', '01030103', '10301', '0', '0', '机构类型', '1', '组织类型', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:02', '0');
INSERT INTO `sm_dictionary` VALUES ('1040101', '管理员', '01040101', '10401', '0', '0', '用户类型', '1', '用户类型', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('1040102', '常规人员', '01040102', '10401', '0', '0', '用户类型', '1', '用户类型', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('1040301', '在岗', '01040301', '10403', '0', '0', '在岗状态', '1', '用户工作状态', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('1040302', '离岗', '01040302', '10403', '0', '0', '在岗状态', '1', '用户工作状态', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('1040401', '最新的', '01040401', '10404', '0', '0', '数据存储状态', '1', '用户数据存储状态', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('1040402', '延迟的', '01040402', '10404', '0', '0', '数据存储状态', '1', '用户数据存储状态', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('1050101', '常规的', '01050101', '10501', '0', '0', '角色类型', '1', '角色类型', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('1060101', '公共', '01060101', '10601', '0', '0', '权限级别', '1', '功能权限级别', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('1060102', '身份认证', '01060102', '10601', '0', '0', '权限级别', '1', '功能权限级别', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('1060103', '权限认证', '01060103', '10601', '0', '0', '权限级别', '1', '功能权限级别', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('3010101', '交易会', '03010101', '30101', '0', '0', '活动类型', '1', '', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58', '0');
INSERT INTO `sm_dictionary` VALUES ('3010102', 'Web研讨', '03010102', '30101', '0', '0', '活动类型', '1', '', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58', '0');
INSERT INTO `sm_dictionary` VALUES ('3010103', '公开媒体', '03010103', '30101', '0', '0', '活动类型', '1', '', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58', '0');
INSERT INTO `sm_dictionary` VALUES ('3010104', '合作伙伴', '03010104', '30101', '0', '0', '活动类型', '1', '', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58', '0');
INSERT INTO `sm_dictionary` VALUES ('3010105', '广告', '03010105', '30101', '0', '0', '活动类型', '1', '', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58', '0');
INSERT INTO `sm_dictionary` VALUES ('3010106', '电子市场', '03010106', '30101', '0', '0', '活动类型', '1', '', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58', '0');
INSERT INTO `sm_dictionary` VALUES ('3010107', '邮箱', '03010107', '30101', '0', '0', '活动类型', '1', '', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58', '0');
INSERT INTO `sm_dictionary` VALUES ('3010108', '其它', '03010108', '30101', '0', '0', '活动类型', '1', '', '1', '2014-05-27 10:53:58', '1', '2014-05-27 10:53:58', '0');
INSERT INTO `sm_dictionary` VALUES ('3010201', '计划中', '03010201', '30102', '0', '0', '活动状态', '1', '', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52', '0');
INSERT INTO `sm_dictionary` VALUES ('3010202', '激活', '03010202', '30102', '0', '0', '活动状态', '1', '', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52', '0');
INSERT INTO `sm_dictionary` VALUES ('3010203', '休眠', '03010203', '30102', '0', '0', '活动状态', '1', '', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52', '0');
INSERT INTO `sm_dictionary` VALUES ('3010204', '完成', '03010204', '30102', '0', '0', '活动状态', '1', '', '1', '2014-05-27 10:56:52', '1', '2014-05-27 10:56:52', '0');
INSERT INTO `sm_dictionary` VALUES ('4010101', '市场活动获得', '04010101', '40101', '0', '0', '线索来源', '1', '市场活动获得', '1', '2014-05-29 10:11:36', '1', '2014-05-29 10:15:46', '0');
INSERT INTO `sm_dictionary` VALUES ('4010201', '待跟进', '04010201', '40102', '0', '0', '线索状态', '1', '待跟进', '1', '2014-05-29 10:12:54', '1', '2014-05-29 10:15:49', '0');
INSERT INTO `sm_dictionary` VALUES ('4010301', '借记卡', '04010301', '40103', '0', '0', '银行卡类型', '1', '借记卡', '1', '2014-05-29 10:14:10', '1', '2014-05-29 11:17:02', '0');
INSERT INTO `sm_dictionary` VALUES ('4010402', '金融业', '04010402', '40104', '0', '0', '行业', '1', '金融业', '1', '2014-05-29 10:15:38', '1', '2014-05-29 10:15:27', '0');
INSERT INTO `sm_dictionary` VALUES ('4030101', '普通客户', '04030101', '40301', '0', '0', '客户类型', '1', '普通客户', '1', '2014-05-27 15:21:24', '1', '2014-05-27 15:21:24', '0');
INSERT INTO `sm_dictionary` VALUES ('4030102', '非普通客户', '04030102', '40301', '0', '0', '客户类型', '1', '非普通客户', '1', '2014-05-27 15:22:02', '1', '2014-05-27 15:22:01', '0');
INSERT INTO `sm_dictionary` VALUES ('4030201', '电话来访', '04030201', '40302', '0', '0', '客户来源', '1', '电话来访', '1', '2014-05-27 17:18:10', '1', '2014-05-28 14:04:26', '0');
INSERT INTO `sm_dictionary` VALUES ('4030202', '老客户', '04030202', '40302', '0', '0', '客户来源', '1', '老客户', '1', '2014-05-27 17:19:28', '1', '2014-05-28 14:04:29', '0');
INSERT INTO `sm_dictionary` VALUES ('4030203', '客户介绍', '04030203', '40302', '0', '0', '客户来源', '1', '客户介绍', '1', '2014-05-27 17:20:22', '1', '2014-05-29 17:01:06', '0');
INSERT INTO `sm_dictionary` VALUES ('4030204', '独立开发', '04030204', '40302', '0', '0', '客户来源', '1', '独立开发', '1', '2014-05-27 17:21:27', '1', '2014-05-29 17:01:07', '0');
INSERT INTO `sm_dictionary` VALUES ('4030205', '媒体宣传', '04030205', '40302', '0', '0', '客户来源', '1', '媒体宣传', '1', '2014-05-27 17:22:25', '1', '2014-05-29 17:01:08', '0');
INSERT INTO `sm_dictionary` VALUES ('4030301', '身份证', '04030301', '40303', '0', '0', '证件类型', '1', '身份证', '1', '2014-05-27 17:41:26', '1', '2014-05-28 14:05:00', '0');
INSERT INTO `sm_dictionary` VALUES ('4030302', '工作证', '04030302', '40303', '0', '0', '证件类型', '1', '工作证', '1', '2014-05-27 17:42:26', '1', '2014-05-28 14:05:04', '0');
INSERT INTO `sm_dictionary` VALUES ('4030303', '其他', '04030303', '40303', '0', '0', '证件类型', '1', '其他', '1', '2014-05-27 17:43:09', '1', '2014-05-28 14:05:08', '0');
INSERT INTO `sm_dictionary` VALUES ('4030401', '一级', '04030401', '40304', '0', '0', '风险等级', '1', '一级', '1', '2014-05-27 17:49:01', '1', '2014-05-28 14:05:17', '0');
INSERT INTO `sm_dictionary` VALUES ('4030402', '二级', '04030402', '40304', '0', '0', '风险等级', '1', '二级', '2', '2014-05-27 17:49:32', '1', '2014-05-28 14:05:31', '0');
INSERT INTO `sm_dictionary` VALUES ('4030501', '金融', '04030501', '40305', '0', '0', '行业', '1', '金融', '1', '2014-05-27 18:00:44', '1', '2014-05-28 14:05:26', '0');
INSERT INTO `sm_dictionary` VALUES ('4030601', '国有', '04030601', '40306', '0', '0', '行业', '1', '国有', '1', '2014-05-27 18:06:39', '1', '2014-05-28 14:05:23', '0');
INSERT INTO `sm_dictionary` VALUES ('4030602', '私营', '04030602', '40306', '0', '0', '行业', '1', '私营', '1', '2014-05-29 14:01:39', '1', '2014-05-29 14:01:47', '0');
INSERT INTO `sm_dictionary` VALUES ('4030701', '农行', '04030701', '40307', '0', '0', '行业', '1', '农行', '1', '2014-05-27 18:30:35', '1', '2014-05-28 14:05:20', '0');
INSERT INTO `sm_dictionary` VALUES ('5010101', '普通供应商', '01050101', '50101', '0', '0', '供应商类型', '1', '供应商类型', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0');
INSERT INTO `sm_dictionary` VALUES ('5010102', '非普通供应商', '05010102', '50101', '0', '0', '供应商类型', '1', '供应商类型', '1', '2014-05-26 00:00:00', '1', '2014-05-27 14:20:17', '0');
INSERT INTO `sm_dictionary` VALUES ('10040101', '新增', '10040101', '100401', '0', '0', '操作类型', '1', '新增', '1', '2014-06-23 18:38:02', '1', '2014-06-23 18:38:16', '0');
INSERT INTO `sm_dictionary` VALUES ('10040102', '修改', '10040102', '100401', '0', '0', '操作类型', '1', '修改', '1', '2014-06-23 18:39:20', '1', '2014-06-23 18:39:31', '0');
INSERT INTO `sm_dictionary` VALUES ('10040103', '删除', '10040103', '100401', '0', '0', '操作类型', '1', '删除', '1', '2014-06-23 18:39:59', '1', '2014-06-23 18:40:08', '0');
INSERT INTO `sm_dictionary` VALUES ('10040104', '全部', '10040104', '100401', '0', '0', '操作类型', '1', '全部', '1', '2014-06-23 18:40:55', '1', '2014-06-23 18:41:00', '0');
INSERT INTO `sm_dictionary` VALUES ('11010101', '供应商', '11010101', '110101', '0', '0', '模块类型', '1', '供应商模块', '1', '2014-05-27 10:30:55', '1', '2014-05-27 10:30:52', '0');
INSERT INTO `sm_dictionary` VALUES ('11010102', '客户', '11010102', '110101', '0', '0', '模块类型', '1', '客户模块', '1', '2014-05-28 13:21:01', '1', '2014-05-28 13:20:54', '0');
INSERT INTO `sm_dictionary` VALUES ('11010103', '线索', '11010103', '110101', '0', '0', '模块类型', '1', '线索模块', '1', '2014-05-28 13:21:37', '1', '2014-05-28 13:21:30', '0');
INSERT INTO `sm_dictionary` VALUES ('11010104', '联系人', '11010104', '110101', '0', '0', '模块类型', '1', '联系人模块', '1', '2014-05-28 13:22:06', '1', '2014-05-28 13:21:59', '0');
INSERT INTO `sm_dictionary` VALUES ('11010201', '身份证', '11010201', '110102', '0', '0', '附件类型', '1', '身份证', '1', '2014-05-27 10:31:38', '1', '2014-05-27 10:32:31', '0');
INSERT INTO `sm_dictionary` VALUES ('11010202', '营业执照', '11010202', '110102', '0', '0', '附件类型', '1', '营业执照', '1', '2014-05-27 10:32:26', '1', '2014-05-27 10:32:24', '0');
INSERT INTO `sm_dictionary` VALUES ('11010206', '用户类型', '04', null, null, null, null, '1', '', '1', '2014-06-06 13:36:46', '1', '2014-06-06 13:37:12', '0');
INSERT INTO `sm_dictionary` VALUES ('11010207', '在岗状态', '05', null, null, null, null, '1', '', '1', '2014-06-06 13:37:12', '1', '2014-06-06 13:37:39', '0');
INSERT INTO `sm_dictionary` VALUES ('11010208', '产品类型', '06', null, null, null, null, '1', '', '1', '2014-06-09 16:24:46', '1', '2014-06-09 17:17:31', '0');
INSERT INTO `sm_dictionary` VALUES ('11010209', '期限单位', '07', null, null, null, null, '1', '', '1', '2014-06-09 16:45:47', '1', '2014-06-09 17:17:41', '0');
INSERT INTO `sm_dictionary` VALUES ('11010210', '年', 'year', null, null, null, '期限单位', '1', '', '1', '2014-06-09 16:51:09', '1', '2014-06-09 17:16:21', '0');
INSERT INTO `sm_dictionary` VALUES ('11010211', '月', 'month', null, null, null, '期限单位', '1', '', '1', '2014-06-09 17:17:16', '1', '2014-06-09 17:16:49', '0');
INSERT INTO `sm_dictionary` VALUES ('11010212', '日', 'day', null, null, null, '期限单位', '1', '', '1', '2014-06-09 17:17:32', '1', '2014-06-09 17:17:06', '0');
INSERT INTO `sm_dictionary` VALUES ('11010213', '面向大客户', 'dkh', null, null, null, '产品类型', '1', '', '1', '2014-06-09 17:19:51', '1', '2014-06-09 17:19:25', '0');
INSERT INTO `sm_dictionary` VALUES ('11010214', '性别', '0001', null, null, null, null, '1', '', '1', '2014-06-10 10:52:46', '1', '2014-06-10 10:59:15', '0');
INSERT INTO `sm_dictionary` VALUES ('11010215', '男', '000101', '11010214', null, null, '性别', '1', '', '1', '2014-06-10 10:53:12', '1', '2014-06-10 10:59:48', '0');
INSERT INTO `sm_dictionary` VALUES ('11010216', '女', '000102', '11010214', null, null, '性别', '1', '', '1', '2014-06-10 11:00:36', '1', '2014-06-10 11:00:10', '0');
INSERT INTO `sm_function` VALUES ('1', null, '000001', '查询', '/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-03 15:43:28', '1060101', '0', null);
INSERT INTO `sm_function` VALUES ('2', null, '000002', '新增', '/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-03 15:43:30', '1060101', '0', null);
INSERT INTO `sm_function` VALUES ('3', null, '000003', '详情', '/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060101', '0', null);
INSERT INTO `sm_function` VALUES ('4', null, '000004', '编辑', '/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('5', null, '000005', '删除', '/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('6', null, '000006', '导出', '/export.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('22', '402', '2', '联系纪要查询', '/common/memoir/query.do', '', '1', '2014-05-29 15:03:40', '1', '2014-05-30 10:36:13', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('23', '402', '3', '联系纪要新增', '/common/memoir/add.do', '', '1', '2014-05-30 10:02:38', '1', '2014-05-30 10:38:49', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('24', '402', '4', '联系纪要编辑', '/common/memoir/modify.do', '', '1', '2014-05-30 16:07:58', '1', '2014-05-30 16:09:16', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('25', '402', '5', '联系纪要删除', '/common/memoir/delete.do', '', '1', '2014-05-30 16:08:47', '1', '2014-05-30 16:09:14', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('26', '402', '6', '附件查询', '/contact/attachment/query.do', '', '1', '2014-06-12 15:46:21', '1', '2014-06-24 15:27:48', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('27', '402', '7', '附件预览', '/contact/attachment/view.do', '', '1', '2014-06-12 15:46:21', '1', '2014-06-24 15:29:10', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('28', '402', '8', '附件上传', '/contact/attachment/upload.do', '', '1', '2014-06-24 15:31:05', '1', '2014-06-24 15:31:23', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('29', '402', '9', '附件下载', '/contact/attachment/download.do', '', '1', '2014-06-24 15:32:06', '1', '2014-06-24 15:32:22', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('1001', '10', '010001', '详情', '/system/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-23 11:25:48', '1060101', '0', null);
INSERT INTO `sm_function` VALUES ('10101', '101', '010101', '查询', '/system/dictionary/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10102', '101', '010102', '新增', '/system/dictionary/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10103', '101', '010103', '详情', '/system/dictionary/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10104', '101', '010104', '编辑', '/system/dictionary/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10105', '101', '010105', '删除', '/system/dictionary/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10201', '102', '010301', '查询', '/system/organization/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-30 17:36:39', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10202', '102', '010302', '新增', '/system/organization/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-30 17:36:42', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10203', '102', '010303', '详情', '/system/organization/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10204', '102', '010304', '编辑', '/system/organization/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10205', '102', '010305', '删除', '/system/organization/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-30 17:36:56', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10206', '102', '010306', '授权', '/system/organization/authorization.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-30 17:37:00', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10207', '102', '010307', '移动', '/system/organization/move.doself', '', '1', '2014-05-26 00:00:00', '1', '2014-05-30 17:37:03', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10301', '103', '010201', '查询', '/system/menu/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-30 17:37:09', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10302', '103', '010202', '新增', '/system/menu/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-30 17:37:13', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10303', '103', '010203', '详情', '/system/menu/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10304', '103', '010204', '编辑', '/system/menu/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10305', '103', '010205', '删除', '/system/menu/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-30 17:37:22', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10306', '103', '010206', '移动', '/system/menu/move.doself', '', '1', '2014-05-26 00:00:00', '1', '2014-06-20 21:26:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10401', '104', '010401', '查询', '/system/user/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10402', '104', '010402', '新增', '/system/user/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10403', '104', '010403', '详情', '/system/user/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10404', '104', '010404', '编辑', '/system/user/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10405', '104', '010405', '删除', '/system/user/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10406', '104', '010406', '授权', '/system/user/authorization.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10407', '104', '010407', '重置密码', '/system/user/resetPassword.do', '', '1', '2014-05-31 00:00:00', '1', '2014-05-31 06:39:39', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10408', '104', '010408', '启用', '/system/user/enable.do', '', '1', '2014-05-31 00:00:00', '1', '2014-05-31 06:39:39', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10409', '104', '010409', '禁用', '/system/user/disable.do', '', '1', '2014-05-31 00:00:00', '1', '2014-05-31 06:39:39', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10410', '104', '010410', '登录', '/login.doself', '', '1', '2014-05-31 00:00:00', '1', '2014-06-05 14:29:10', '1060101', '0', null);
INSERT INTO `sm_function` VALUES ('10411', '104', '010411', '注销', '/logout.doself', '', '1', '2014-05-31 00:00:00', '1', '2014-06-05 14:29:13', '1060101', '0', null);
INSERT INTO `sm_function` VALUES ('10412', '104', '010412', '导入', '/system/user/import.do', '', '1', '2014-05-31 00:00:00', '1', '2014-06-05 14:29:01', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10413', '104', '010413', '用户导出', '/system/user/export.do', '', '1', '2014-05-31 00:00:00', '1', '2014-06-13 18:40:58', '1060103', '0', '6');
INSERT INTO `sm_function` VALUES ('10501', '105', '010501', '查询', '/system/role/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10502', '105', '010502', '新增', '/system/role/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10503', '105', '010503', '详情', '/system/role/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10504', '105', '010504', '编辑', '/system/role/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10505', '105', '010505', '删除', '/system/role/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10506', '105', '010506', '授权', '/system/role/authorization.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10601', '106', '010601', '查询', '/system/function/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10602', '106', '010602', '新增', '/system/function/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10603', '106', '010603', '详情', '/system/function/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10604', '106', '010604', '编辑', '/system/function/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10605', '106', '010605', '删除', '/system/function/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10606', '106', '010606', '首页', '/system/function/index.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10701', '107', '010701', '查询', '/system/component/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10702', '107', '010702', '新增', '/system/component/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10703', '107', '010703', '详情', '/system/component/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10704', '107', '010704', '编辑', '/system/component/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10705', '107', '010705', '删除', '/system/component/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10706', '107', '010706', '首页', '/system/component/index.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10801', '108', '010801', '查询', '/system/notice/query.do', '', '1', '2014-05-31 00:00:00', '1', '2014-05-31 06:39:39', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10802', '108', '010802', '新增', '/system/notice/add.do', '', '1', '2014-05-31 00:00:00', '1', '2014-05-31 06:39:39', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10803', '108', '010803', '详情', '/system/notice/view.do', '', '1', '2014-05-31 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10804', '108', '010804', '编辑', '/system/notice/modify.do', '', '1', '2014-05-31 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10805', '108', '010805', '删除', '/system/notice/delete.do', '', '1', '2014-05-31 00:00:00', '1', '2014-05-31 06:39:39', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10806', '108', '010806', '导入', '/system/notice/import.do', '', '1', '2014-06-18 19:47:57', '1', '2014-06-18 19:48:01', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10807', '108', '010807', '导出', '/system/notice/export.do', '', '1', '2014-06-18 19:50:14', '1', '2014-06-19 11:45:19', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10901', '109', '010901', '查询', '/system/message/query.do', '', '1', '2014-05-31 00:00:00', '1', '2014-05-31 06:39:39', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10902', '109', '010902', '新增', '/system/message/add.do', '', '1', '2014-05-31 00:00:00', '1', '2014-05-31 06:39:39', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10903', '109', '010903', '详情', '/system/message/view.do', '', '1', '2014-05-31 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10904', '109', '010904', '编辑', '/system/message/modify.do', '', '1', '2014-05-31 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10905', '109', '010905', '删除', '/system/message/delete.do', '', '1', '2014-05-31 00:00:00', '1', '2014-05-31 06:39:39', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('10906', '109', '010906', '系统消息导出', '/system/message/export.do', '', '1', '2014-06-19 11:40:13', '1', '2014-06-19 12:46:17', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('20001', '2', '020001', '详情', '/workbanch/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-23 11:24:44', '1060101', '0', null);
INSERT INTO `sm_function` VALUES ('30101', '301', '030101', '查询', '/market/marketactivity/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-27 09:49:10', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('30102', '301', '030102', '新增', '/market/marketactivity/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-27 09:49:13', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('30103', '301', '030103', '详情', '/market/marketactivity/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('30104', '301', '030104', '编辑', '/market/marketactivity/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('30105', '301', '030105', '删除', '/market/marketactivity/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-27 09:49:30', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40101', '401', '040101', '查询', '/customer/lead/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40102', '401', '040102', '新增', '/customer/lead/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40103', '401', '040103', '详情', '/customer/lead/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40104', '401', '040104', '编辑', '/customer/lead/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40105', '401', '040105', '删除', '/customer/lead/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40106', '401', '040106', '修改所有者', '/customer/lead/modifyOwner.do', '', '1', '2014-06-04 10:01:11', '1', '2014-06-04 10:01:15', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40107', '401', '040107', '导出', '/customer/lead/export.do', '', '1', '2014-06-18 20:31:35', '1', '2014-06-18 20:30:43', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40108', '401', '040108', '附件列表', '/lead/attachment/query.do', '', '1', '2014-06-22 16:34:33', '1', '2014-06-24 18:10:47', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40109', '401', '040109', '附件上传', '/lead/attachment/upload.do', '', '1', '2014-06-22 16:35:39', '1', '2014-06-24 18:10:48', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40110', '401', '040110', '附件预览', '/lead/attachment/view.comp', '', '1', '2014-06-22 16:37:16', '1', '2014-06-24 18:10:50', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40111', '401', '40111', '附件下载', '/lead/attachment/download.do', '', '1', '2014-06-22 16:38:30', '1', '2014-06-22 16:38:34', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40201', '402', '040201', '查询', '/customer/contact/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40202', '402', '040202', '新增', '/customer/contact/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40203', '402', '040203', '详情', '/customer/contact/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40204', '402', '040204', '编辑', '/customer/contact/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40205', '402', '040205', '删除', '/customer/contact/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40301', '403', '040301', '查询', '/customer/customer/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40302', '403', '040302', '新增', '/customer/customer/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40303', '403', '040303', '详情', '/customer/customer/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40304', '403', '040304', '编辑', '/customer/customer/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40305', '403', '040305', '删除', '/customer/customer/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40306', '403', '040306', '客户导出', '/customer/customer/export.do', '', '1', '2014-06-18 20:54:48', '1', '2014-06-18 20:55:11', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40307', '403', '040307', '附件上传', '/customer/attachment/query.do', '', '1', '2014-06-22 16:34:33', '1', '2014-06-22 16:34:39', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40308', '403', '040308', '附件上传', '/customer/attachment/upload.do', '', '1', '2014-06-22 16:35:39', '1', '2014-06-22 16:35:44', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40309', '403', '040309', '附件预览', '/customer/attachment/view.comp', '', '1', '2014-06-22 16:37:16', '1', '2014-06-22 16:37:20', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('40310', '403', '040311', '附件下载', '/customer/attachment/download.do', '', '1', '2014-06-22 16:38:30', '1', '2014-06-22 16:38:34', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50101', '501', '050101', '查询', '/project/supplier/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50102', '501', '050102', '新增', '/project/supplier/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50103', '501', '050103', '详情', '/project/supplier/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50104', '501', '050104', '编辑', '/project/supplier/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50105', '501', '050105', '删除', '/project/supplier/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50106', '501', '050106', '附件查询', '/supplier/attachment/query.do', '', '1', '2014-05-27 10:14:03', '1', '2014-05-27 10:14:50', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50107', '501', '050107', '附件上传', '/supplier/attachment/upload.do', '地方官', '1', '2014-05-27 14:06:48', '1', '2014-06-20 14:22:52', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50108', '501', '050108', '附件预览', '/supplier/attachment/view.comp', '', '1', '2014-05-27 10:16:13', '1', '2014-05-27 10:16:28', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50109', '501', '050109', '附件下载', '/supplier/attachment/download.do', '', '1', '2014-05-27 10:17:17', '1', '2014-05-27 10:17:31', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50110', '501', '050110', '导出', '/project/supplier/export.do', '', '1', '2014-06-19 14:48:13', '1', '2014-06-19 14:47:17', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50201', '502', '050201', '查询', '/project/project/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-08 11:08:55', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50202', '502', '050202', '新增', '/project/project/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-08 11:09:07', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50203', '502', '050203', '详情', '/project/project/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50204', '502', '050204', '编辑', '/project/project/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50205', '502', '050205', '删除', '/project/project/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-08 11:09:23', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50301', '503', '050301', '查询', '/project/product/query.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-08 16:31:32', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50302', '503', '050302', '新增', '/project/product/add.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-08 16:31:35', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50303', '503', '050303', '详情', '/project/product/view.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:29', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50304', '503', '050304', '编辑', '/project/product/modify.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-18 11:04:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('50305', '503', '050305', '删除', '/project/product/delete.do', '', '1', '2014-05-26 00:00:00', '1', '2014-06-08 16:31:45', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('60101', '601', '060101', '查询', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('60102', '601', '060102', '新增', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:01:25', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('60103', '601', '060103', '详情', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:01:28', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('60104', '601', '060104', '编辑', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('60105', '601', '060105', '删除', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('60201', '602', '060201', '查询', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:01:13', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('60202', '602', '060202', '新增', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('60203', '602', '060203', '详情', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('60204', '602', '060204', '编辑', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('60205', '602', '060205', '删除', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('70101', '701', '070101', '查询', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('70102', '701', '070102', '新增', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('70103', '701', '070103', '详情', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('70104', '701', '070104', '编辑', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('70105', '701', '070105', '删除', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('70201', '702', '070201', '查询', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('70202', '702', '070202', '新增', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('70203', '702', '070203', '详情', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('70204', '702', '070204', '编辑', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('70205', '702', '070205', '删除', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('80101', '801', '070101', '查询', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('80102', '801', '070102', '新增', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('80103', '801', '070103', '详情', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '1', null);
INSERT INTO `sm_function` VALUES ('80104', '801', '070104', '编辑', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '1', null);
INSERT INTO `sm_function` VALUES ('80105', '801', '070105', '删除', null, '', '1', '2014-05-26 00:00:00', '1', '2014-06-19 15:52:54', '1060103', '1', null);
INSERT INTO `sm_function` VALUES ('100001', '10', '100001', '导出', '/system/data/export.do', '', '1', '2014-05-31 00:00:00', '1', '2014-06-19 15:55:37', '1060103', '0', null);
INSERT INTO `sm_function` VALUES ('100401', '1004', '100401', '查询', '/setting/auditlog/query.do', '', '1', '2014-06-22 16:47:52', '1', '2014-06-22 16:47:03', '1060103', '0', null);
INSERT INTO `sm_menu` VALUES ('1', '0100', '系统管理', null, null, '1', '100000', '0', '1', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', null, '0', '0', '0');
INSERT INTO `sm_menu` VALUES ('2', '0200', '工作台', null, '/workbanch/toViewPage.do', '1', '20000', '0', '1', '', '1', '2014-05-26 00:00:00', '1', '2014-06-24 16:42:47', '1020202', '20001', '1', '0', '1');
INSERT INTO `sm_menu` VALUES ('3', '0300', '市场营销', null, null, '1', '30000', '0', '1', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', null, '0', '0', '0');
INSERT INTO `sm_menu` VALUES ('4', '0400', '客户管理', null, null, '1', '40000', '0', '1', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', null, '0', '0', '0');
INSERT INTO `sm_menu` VALUES ('5', '0500', '项目管理', null, null, '1', '50000', '0', '1', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', null, '0', '0', '0');
INSERT INTO `sm_menu` VALUES ('6', '0600', '订单管理', null, null, '1', '60000', '0', '1', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1020202', null, '0', '0', '0');
INSERT INTO `sm_menu` VALUES ('7', '0700', '财务管理', null, null, '1', '70000', '0', '1', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1020202', null, '0', '0', '0');
INSERT INTO `sm_menu` VALUES ('8', '0800', '销售管理', null, null, '1', '80000', '0', '1', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1020202', null, '0', '0', '0');
INSERT INTO `sm_menu` VALUES ('9', '0900', '报表管理', null, '/report/toViewPage.do', '1', '90000', '0', '1', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1020202', '90001', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('10', '1000', '设置', null, '/system/toViewPage.do', '1', '110000', '0', '1', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020201', '1001', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('101', '0101', '字典管理', '1', '/system/dictionary/toQueryPage.do', '1', '100100', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '10101', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('102', '0102', '组织管理', '1', '/system/organization/toQueryPage.do', '1', '100300', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '10201', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('103', '0103', '菜单管理', '1', '/system/menu/toQueryPage.do', '1', '100200', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '10301', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('104', '0104', '用户管理', '1', '/system/user/toQueryPage.do', '1', '100400', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '10401', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('105', '0105', '角色管理', '1', '/system/role/toQueryPage.do', '1', '100500', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '10501', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('106', '0106', '功能管理', '1', '/system/function/toQueryPage.do', '1', '100700', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '10601', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('107', '0107', '组件管理', '1', '/system/component/toQueryPage.do', '1', '100600', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '10701', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('108', '0108', '系统公告', '1', '/system/notice/toQueryPage.do', '1', '100900', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '10801', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('109', '0109', '系统消息', '1', '/system/message/toQueryPage.do', '1', '100800', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '10901', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('301', '0301', '市场活动', '3', '/market/marketactivity/toQueryPage.do', '1', '30100', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '30101', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('401', '0401', '线索', '4', '/customer/lead/toQueryPage.do', '1', '40100', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '40101', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('402', '0402', '联系人', '4', '/customer/contact/toQueryPage.do', '1', '40200', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '40201', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('403', '0403', '客户', '4', '/customer/customer/toQueryPage.do', '1', '40300', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '40301', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('501', '0501', '供应商', '5', '/project/supplier/toQueryPage.do', '1', '50100', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:04', '1020202', '50101', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('502', '0502', '项目', '5', '/project/project/toQueryPage.do', '1', '50200', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1020202', '50201', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('503', '0503', '产品', '5', null, '1', '50300', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1020202', '50301', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('601', '0601', '订单', '6', null, '1', '60100', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1020202', '60101', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('602', '0602', '合同', '6', null, '1', '60200', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1020202', '60102', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('701', '0701', '财务审批', '7', null, '1', '70100', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1020202', '70101', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('702', '0702', '财务款项', '7', null, '1', '70200', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1020202', '70201', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('801', '0801', '销售目标', '8', null, '1', '80100', '0', '2', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:05', '1020202', '80101', '1', '0', '0');
INSERT INTO `sm_menu` VALUES ('1004', '1004', '审计日志', '1', '/setting/auditlog/toQueryPage.do', '1', '110100', '0', '2', '', '1', '2014-06-22 16:41:41', '1', '2014-06-22 16:41:05', '1020202', '100401', '1', '0', '0');
INSERT INTO `sm_org` VALUES ('1', '010000', '1030101', null, '华兴控股', '华兴控股', '北京市海淀区', '100000', '18620088324', '1429457@163.com', 'http://hxtd.crm.com', null, '1000000', '', '1', '2014-05-26 00:00:00', '1', '2014-06-24 17:04:15', '0', '1', '0');
INSERT INTO `sm_org` VALUES ('101', '010100', '1030101', null, '董事会', '董事会', '北京市海淀区', '100000', '18620088324', '1429457@163.com', 'http://hxtd.crm.com', null, '1010000', '', '1', '2014-05-26 00:00:00', '1', '2014-06-24 17:05:44', '1', '2', '0');
INSERT INTO `sm_org` VALUES ('102', '010200', '1030101', '1', '三级委员会', null, '北京市海淀区', '100000', '1862008324', '1429457@163.com', 'http://hxtd.crm.com', null, '1020000', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '1', '2', '0');
INSERT INTO `sm_org` VALUES ('103', '010300', '1030101', '1', '技术管理中心', null, '北京市海淀区', '100000', '1862008324', '1429457@163.com', 'http://hxtd.crm.com', null, '1030000', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '0', '2', '0');
INSERT INTO `sm_org` VALUES ('10301', '010302', '1030101', '103', '企划营销中心', null, '北京市海淀区', '100000', '1862008324', '1429457@163.com', 'http://hxtd.crm.com', null, '1030200', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '1', '3', '0');
INSERT INTO `sm_org_role` VALUES ('103', '4');
INSERT INTO `sm_org_role` VALUES ('10301', '5');
INSERT INTO `sm_org_role` VALUES ('10302', '45587');
INSERT INTO `sm_org_role` VALUES ('10307', '45576');
INSERT INTO `sm_org_role` VALUES ('10307', '45577');
INSERT INTO `sm_org_role` VALUES ('10316', '4');
INSERT INTO `sm_org_role` VALUES ('10317', '45579');
INSERT INTO `sm_org_role` VALUES ('10317', '45580');
INSERT INTO `sm_org_role` VALUES ('10317', '45581');
INSERT INTO `sm_org_role` VALUES ('10320', '45585');
INSERT INTO `sm_role` VALUES ('1', '1', '管理员', '1050101', '管理员', '1', '2014-06-19 13:49:31', '1', '2014-06-19 13:49:31', '0');
INSERT INTO `sm_role` VALUES ('2', '2', '数据管理员', '1050101', '数据管理员', '1', '2014-06-19 13:49:31', '1', '2014-06-19 13:49:31', '0');
INSERT INTO `sm_role` VALUES ('3', '3', '技术管理中心', '1050101', '技术管理中心', '1', '2014-06-19 13:49:31', '1', '2014-06-19 13:49:31', '0');
INSERT INTO `sm_role` VALUES ('4', '4', '企划营销中心', '1050101', '企划营销中心', '1', '2014-06-19 13:49:31', '1', '2014-06-19 13:49:31', '0');
INSERT INTO `sm_role_com` VALUES ('2', '73');
INSERT INTO `sm_role_com` VALUES ('26', '40');
INSERT INTO `sm_role_com` VALUES ('26', '48');
INSERT INTO `sm_trace_log` VALUES ('1', '联系人', '2014-06-23 15:32:15', '10040103', 'admin', '100010', '测试');
INSERT INTO `sm_trace_log` VALUES ('2', '客户', '2014-06-23 19:20:37', '10040102', 'admin', '100011', '测试内容');
INSERT INTO `sm_trace_log` VALUES ('3', '线索', '2014-06-24 14:12:25', '10040101', 'admin', '100012', '审计日志');
INSERT INTO `sm_trace_log` VALUES ('4', '产品', '2014-06-24 14:13:11', '10040101', 'admin', '100013', '审计日志');
INSERT INTO `sm_trace_log` VALUES ('5', '项目', '2014-06-24 14:13:35', '10040101', 'admin', '100014', '审计日志');
INSERT INTO `sm_trace_log` VALUES ('6', '订单', '2014-06-24 14:14:04', '10040101', 'admin', '100015', '订单');
INSERT INTO `sm_trace_log` VALUES ('7', '供应商', '2014-06-24 14:14:26', '10040101', 'admin', '100016', '供应商');
INSERT INTO `sm_trace_log` VALUES ('8', '产品', '2014-06-24 14:18:19', '10040101', 'admin', '100017', '');
INSERT INTO `sm_trace_log` VALUES ('9', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('10', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('11', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('12', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('13', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('14', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('15', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('16', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('17', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('18', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('19', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('20', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('21', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('22', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('23', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('24', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('25', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('26', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('27', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('28', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('29', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('30', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('31', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('32', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('33', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('34', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('35', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('36', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('37', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('38', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('39', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('40', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('41', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('42', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_trace_log` VALUES ('43', '产品', '2014-06-24 14:14:04', '10040101', 'admin', '100017', '产品');
INSERT INTO `sm_user` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '', '管理员', '1', '1', '1040301', '11010215', '18620088324', '0000000000', '00000000@gmail.com', '000000000', '1', '工程师', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '1040401', '1', '0');
INSERT INTO `sm_user` VALUES ('2', 'majingliang', 'e10adc3949ba59abbe56e057f20f883e', '', '马敬亮', '2', '1', '1040301', '11010215', '18620088324', '0000000000', '00000000@gmail.com', '000000000', '0', '工程师', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:03', '1040402', '101', '0');
INSERT INTO `sm_user` VALUES ('3', 'lihua', 'e10adc3949ba59abbe56e057f20f883e', '', '李华', '3', '1', '1040301', '11010215', '18620088324', '0000000000', '00000000@gmail.com', '000000000', '0', '工程师', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 00:00:00', '1040402', '103', '0');
INSERT INTO `sm_user` VALUES ('4', 'luanruisong', 'e10adc3949ba59abbe56e057f20f883e', '', '栾瑞松', '4', '1', '1040301', '11010215', '18620088324', '0000000000', '00000000@gmail.com', '000000000', '0', '工程师', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 00:00:00', '1040402', '10301', '0');
INSERT INTO `sm_user` VALUES ('26643', 'test', 'e10adc3949ba59abbe56e057f20f883e', '', '测试', '1', '1', '1040301', '11010215', '', '', '', '', '0', '', '', '1', '2014-06-24 17:06:54', '1', '2014-06-24 17:06:54', '278786', '1', '0');
INSERT INTO `sm_user_com` VALUES ('7', '81');
INSERT INTO `sm_user_func` VALUES ('1', '22');
INSERT INTO `sm_user_func` VALUES ('1', '23');
INSERT INTO `sm_user_func` VALUES ('1', '24');
INSERT INTO `sm_user_func` VALUES ('1', '25');
INSERT INTO `sm_user_func` VALUES ('1', '26');
INSERT INTO `sm_user_func` VALUES ('1', '27');
INSERT INTO `sm_user_func` VALUES ('1', '10103');
INSERT INTO `sm_user_func` VALUES ('1', '10203');
INSERT INTO `sm_user_func` VALUES ('1', '20001');
INSERT INTO `sm_user_func` VALUES ('1', '30101');
INSERT INTO `sm_user_func` VALUES ('1', '30102');
INSERT INTO `sm_user_func` VALUES ('1', '30103');
INSERT INTO `sm_user_func` VALUES ('1', '30104');
INSERT INTO `sm_user_func` VALUES ('1', '30105');
INSERT INTO `sm_user_func` VALUES ('1', '40101');
INSERT INTO `sm_user_func` VALUES ('1', '40102');
INSERT INTO `sm_user_func` VALUES ('1', '40103');
INSERT INTO `sm_user_func` VALUES ('1', '40104');
INSERT INTO `sm_user_func` VALUES ('1', '40105');
INSERT INTO `sm_user_func` VALUES ('1', '40106');
INSERT INTO `sm_user_func` VALUES ('1', '40107');
INSERT INTO `sm_user_func` VALUES ('1', '40201');
INSERT INTO `sm_user_func` VALUES ('1', '40202');
INSERT INTO `sm_user_func` VALUES ('1', '40203');
INSERT INTO `sm_user_func` VALUES ('1', '40204');
INSERT INTO `sm_user_func` VALUES ('1', '40205');
INSERT INTO `sm_user_func` VALUES ('1', '40301');
INSERT INTO `sm_user_func` VALUES ('1', '40302');
INSERT INTO `sm_user_func` VALUES ('1', '40303');
INSERT INTO `sm_user_func` VALUES ('1', '40304');
INSERT INTO `sm_user_func` VALUES ('1', '40305');
INSERT INTO `sm_user_func` VALUES ('1', '40306');
INSERT INTO `sm_user_func` VALUES ('1', '40307');
INSERT INTO `sm_user_func` VALUES ('1', '40308');
INSERT INTO `sm_user_func` VALUES ('1', '40309');
INSERT INTO `sm_user_func` VALUES ('1', '40310');
INSERT INTO `sm_user_func` VALUES ('1', '70102');
INSERT INTO `sm_user_func` VALUES ('1', '70202');
INSERT INTO `sm_user_func` VALUES ('4', '40101');
INSERT INTO `sm_user_func` VALUES ('4', '40103');
INSERT INTO `sm_user_func` VALUES ('7', '20001');
INSERT INTO `sm_user_func` VALUES ('36', '10201');
INSERT INTO `sm_user_func` VALUES ('36', '10202');
INSERT INTO `sm_user_func` VALUES ('36', '10203');
INSERT INTO `sm_user_func` VALUES ('36', '10204');
INSERT INTO `sm_user_func` VALUES ('36', '10205');
INSERT INTO `sm_user_func` VALUES ('36', '10206');
INSERT INTO `sm_user_func` VALUES ('36', '10207');
INSERT INTO `sm_user_func` VALUES ('36', '10301');
INSERT INTO `sm_user_func` VALUES ('36', '10302');
INSERT INTO `sm_user_func` VALUES ('36', '10303');
INSERT INTO `sm_user_func` VALUES ('36', '10304');
INSERT INTO `sm_user_func` VALUES ('36', '10305');
INSERT INTO `sm_user_func` VALUES ('36', '10306');
INSERT INTO `sm_user_func` VALUES ('36', '10401');
INSERT INTO `sm_user_func` VALUES ('36', '10402');
INSERT INTO `sm_user_func` VALUES ('36', '10403');
INSERT INTO `sm_user_func` VALUES ('36', '10404');
INSERT INTO `sm_user_func` VALUES ('36', '10405');
INSERT INTO `sm_user_func` VALUES ('36', '10407');
INSERT INTO `sm_user_func` VALUES ('36', '10408');
INSERT INTO `sm_user_func` VALUES ('36', '10409');
INSERT INTO `sm_user_func` VALUES ('36', '10410');
INSERT INTO `sm_user_func` VALUES ('36', '10411');
INSERT INTO `sm_user_func` VALUES ('36', '10412');
INSERT INTO `sm_user_func` VALUES ('36', '10413');
INSERT INTO `sm_user_func` VALUES ('36', '10601');
INSERT INTO `sm_user_func` VALUES ('36', '10602');
INSERT INTO `sm_user_func` VALUES ('36', '10603');
INSERT INTO `sm_user_func` VALUES ('36', '10604');
INSERT INTO `sm_user_func` VALUES ('36', '10605');
INSERT INTO `sm_user_func` VALUES ('36', '50102');
INSERT INTO `sm_user_func` VALUES ('36', '50103');
INSERT INTO `sm_user_func` VALUES ('36', '50104');
INSERT INTO `sm_user_func` VALUES ('36', '50105');
INSERT INTO `sm_user_func` VALUES ('36', '50106');
INSERT INTO `sm_user_func` VALUES ('36', '50107');
INSERT INTO `sm_user_func` VALUES ('36', '50108');
INSERT INTO `sm_user_func` VALUES ('36', '50109');
INSERT INTO `sm_user_func` VALUES ('9472', '20001');
INSERT INTO `sm_user_func` VALUES ('9472', '30101');
INSERT INTO `sm_user_func` VALUES ('9472', '30102');
INSERT INTO `sm_user_func` VALUES ('9472', '30103');
INSERT INTO `sm_user_func` VALUES ('9472', '30104');
INSERT INTO `sm_user_func` VALUES ('9472', '30105');
INSERT INTO `sm_user_org` VALUES ('1', '1');
INSERT INTO `sm_user_org` VALUES ('2', '1');
INSERT INTO `sm_user_org` VALUES ('3', '1');
INSERT INTO `sm_user_org` VALUES ('4', '1');
INSERT INTO `sm_user_org` VALUES ('5', '1');
INSERT INTO `sm_user_role` VALUES ('1', '1');
INSERT INTO `sm_user_role` VALUES ('1', '2');
INSERT INTO `sm_user_role` VALUES ('4', '3');
INSERT INTO `supplier` VALUES ('2', '张小飞', '5010101', '', '', '', '130000', '130400', '130432', '', '', '', '1', '2014-06-22 14:39:25', '1', '2014-06-23 16:01:13', '0', '1');
INSERT INTO `sysmessage` VALUES ('59', '21', '212', '1', '2014-06-11 17:44:45', '1', '2014-06-11 17:44:45', '0');
INSERT INTO `sysmessage` VALUES ('60', '21', '                    212\r\n', '1', '2014-06-11 19:45:34', '1', '2014-06-11 19:45:34', '0');
INSERT INTO `sysmessage` VALUES ('61', '21', '                    212\r\n', '1', '2014-06-11 19:45:35', '1', '2014-06-11 19:45:35', '0');
INSERT INTO `sysmessage` VALUES ('62', '21', '                                        212\r\n\r\n', '1', '2014-06-11 19:46:34', '1', '2014-06-11 19:46:34', '0');
INSERT INTO `sysmessage` VALUES ('63', '333', '                    \r\n333', '1', '2014-06-11 19:49:17', '1', '2014-06-11 19:49:17', '0');
INSERT INTO `sysmessage` VALUES ('64', '22', '                    \r\nerer', '3', '2014-06-12 09:22:29', '3', '2014-06-12 09:22:29', '0');
INSERT INTO `sysmessage` VALUES ('65', '6-12', '                    gfgfg\r\ngdfgd\r\ngdfg\r\nd', '1', '2014-06-12 16:36:06', '1', '2014-06-12 16:36:06', '0');
INSERT INTO `sysmessage` VALUES ('66', '21', '                    212\r\n', '1', '2014-06-12 16:36:34', '1', '2014-06-12 16:36:34', '0');
INSERT INTO `sysmessage` VALUES ('67', 'f ', '     \r\ndsdf\r\nfsdf\r\nfsdf\r\nfsdf\r\nfdsf\r\nfsdf\r\nfdsf\r\ndsfd\r\nsfd\r\nsf          ', '1', '2014-06-12 16:46:41', '1', '2014-06-12 16:46:41', '0');
INSERT INTO `sysmessage` VALUES ('68', 'CRM API', '                    \r\nss\r\ns\r\ns\r\ns\r\ns\r\ns\r\ns\r\nsdsfdsfdgfdgfdhfdh', '1', '2014-06-12 16:57:00', '1', '2014-06-12 16:57:00', '0');
INSERT INTO `sysmessage` VALUES ('69', 'huifu22', '           hdjs\r\ndas\r\ndas\r\ndas\r\ndas\r\ndas         ', '4', '2014-06-12 16:58:26', '4', '2014-06-12 16:58:26', '0');
INSERT INTO `sysmessage` VALUES ('70', '', '                    ', '1', '2014-06-13 15:46:46', '1', '2014-06-13 15:46:46', '0');
INSERT INTO `sysmessage` VALUES ('71', 'cvd', '                    易于使用和集成：百会API可以使用PHP和Java开发并集成至任何类型的应用环境，能节省大量的时间和精力并消除了复杂部署的风险。\r\n延伸您应用程序和服务的价值及范围：通过将集成的百会应用程序的功能和优势融合到自己已经提供的服务中，合作伙伴可以提升其服务价值，并可能增加收入及用户。\r\n数据可以本地存储而应用程序通过“云”来访问：这一概念是本计划的最大好处之一。许多用户希望利用云计算的好处，却倾向于将他们的文件存储在自己或合作伙伴的服务器上。\r\n协作与生产力：许多人想在线协作却不喜欢打开附件、共享文件和管理他们的文件版本。通过百会的整合，用户可以在浏览器中打开桌面文件，邀请参与者通过协作方式编辑和保存文档的一个单一拷贝。集成的聊聊（Baihui Chat）服务允许用户在共同编辑文件或使用其它任何服务时实时协作。\r\n', '1', '2014-06-13 16:31:01', '1', '2014-06-13 16:31:01', '0');
INSERT INTO `sysmessage` VALUES ('72', '灌灌灌灌', '哈哈哈哈哈                    ', '1', '2014-06-17 13:28:16', '1', '2014-06-17 13:28:16', '0');
INSERT INTO `sysmessage` VALUES ('73', '的污染', '            78791\r\n45        ', '1', '2014-06-17 14:08:53', '1', '2014-06-17 14:08:53', '0');
INSERT INTO `sysmessage` VALUES ('74', '', '                    ', '1', '2014-06-17 14:22:07', '1', '2014-06-17 14:22:07', '0');
INSERT INTO `sysmessage` VALUES ('75', '李克强访英首日：英方赠“礼”签证便利化', '  \r\n央广网伦敦6月17日消息（记者冯悦）李克强总理16日开始英国之行，英方当日宣布将放宽对中国游客和商务人士的签证限制，简化中国个人旅行者网签申请程序，而且英国正与其他欧洲国家谈判，希望允许中国旅行者通过单一程序申请英国和申根国家签证。此前，签证难办一直困扰赴英中国民众。', '1', '2014-06-17 21:06:24', '1', '2014-06-17 21:06:24', '0');
INSERT INTO `sysmessage` VALUES ('76', '李克强访英首日：英方赠“礼”签证便利化', '  \r\n央广网伦敦6月17日消息（记者冯悦）李克强总理16日开始英国之行，英方当日宣布将放宽对中国游客和商务人士的签证限制，简化中国个人旅行者网签申请程序，而且英国正与其他欧洲国家谈判，希望允许中国旅行者通过单一程序申请英国和申根国家签证。此前，签证难办一直困扰赴英中国民众。', '1', '2014-06-17 21:06:24', '1', '2014-06-17 21:06:24', '0');
INSERT INTO `sysmessage` VALUES ('77', '“中国梦”主题新创作歌曲', '  “中国梦”主题新创作歌曲\r\n“中国梦”主题新创作歌曲\r\n“中国梦”主题新创作歌曲\r\n“中国梦”主题新创作歌曲\r\n“中国梦”主题新创作歌曲\r\n“中国梦”主题新创作歌曲\r\n“中国梦”主题新创作歌曲                  \r\n', '1', '2014-06-17 21:08:41', '1', '2014-06-17 21:08:41', '0');
INSERT INTO `sysmessage` VALUES ('78', '“中国梦”主题新创作歌曲', '  “中国梦”主题新创作歌曲\r\n“中国梦”主题新创作歌曲\r\n“中国梦”主题新创作歌曲\r\n“中国梦”主题新创作歌曲\r\n“中国梦”主题新创作歌曲\r\n“中国梦”主题新创作歌曲\r\n“中国梦”主题新创作歌曲                  \r\n', '1', '2014-06-17 21:08:41', '1', '2014-06-17 21:08:41', '0');
INSERT INTO `sysmessage` VALUES ('79', 'wwwww', '                    \r\nwww', '1', '2014-06-17 21:13:05', '1', '2014-06-17 21:13:05', '0');
INSERT INTO `sysmessage` VALUES ('80', '', '                    \r\n', '1', '2014-06-18 11:21:34', '1', '2014-06-18 11:21:34', '0');
INSERT INTO `sysmessage` VALUES ('81', '', '                    \r\n', '1', '2014-06-18 11:23:03', '1', '2014-06-18 11:23:03', '0');
INSERT INTO `sysmessage` VALUES ('82', '', '                    \r\n', '1', '2014-06-18 11:31:59', '1', '2014-06-18 11:31:59', '0');
INSERT INTO `sysmessage` VALUES ('83', '', '                    \r\n', '1', '2014-06-18 11:32:23', '1', '2014-06-18 11:32:23', '0');
INSERT INTO `sysmessage` VALUES ('84', '', '                    \r\n', '1', '2014-06-18 11:32:38', '1', '2014-06-18 11:32:38', '0');
INSERT INTO `sysmessage` VALUES ('85', '', '                    \r\n', '1', '2014-06-18 11:32:38', '1', '2014-06-18 11:32:38', '0');
INSERT INTO `sysmessage` VALUES ('86', '', '                    \r\n', '1', '2014-06-18 12:01:42', '1', '2014-06-18 12:01:42', '0');
INSERT INTO `sysmessage` VALUES ('87', '', '                    \r\n', '1', '2014-06-18 12:23:17', '1', '2014-06-18 12:23:17', '0');
INSERT INTO `sysmessage` VALUES ('88', '强大微', '                    \r\nxcsc', '1', '2014-06-18 12:25:55', '1', '2014-06-18 12:25:55', '0');
INSERT INTO `sysmessage` VALUES ('89', '', '                    \r\n', '1', '2014-06-18 12:34:05', '1', '2014-06-18 12:34:05', '0');
INSERT INTO `sysmessage` VALUES ('90', '', '                    \r\n', '1', '2014-06-18 12:34:13', '1', '2014-06-18 12:34:13', '0');
INSERT INTO `sysmessage` VALUES ('91', '', '                    \r\n', '1', '2014-06-18 12:38:00', '1', '2014-06-18 12:38:00', '0');
INSERT INTO `sysmessage` VALUES ('92', '', '                    \r\n', '1', '2014-06-18 12:38:57', '1', '2014-06-18 12:38:57', '0');
INSERT INTO `sysmessage` VALUES ('93', 'asd', '                    \r\nasd', '1', '2014-06-18 12:53:30', '1', '2014-06-18 12:53:30', '0');
INSERT INTO `sysmessage` VALUES ('94', '的污染', '                    \r\n', '1', '2014-06-18 12:54:01', '1', '2014-06-18 12:54:01', '0');
INSERT INTO `sysmessage` VALUES ('95', '', '                    \r\n', '1', '2014-06-18 12:54:12', '1', '2014-06-18 12:54:12', '0');
INSERT INTO `sysmessage` VALUES ('96', '', '                    \r\n', '1', '2014-06-18 12:54:38', '1', '2014-06-18 12:54:38', '0');
INSERT INTO `sysmessage` VALUES ('97', '的污染', '                   wqw', '1', '2014-06-18 12:55:12', '1', '2014-06-18 12:55:12', '0');
INSERT INTO `sysmessage` VALUES ('98', 'CRM API', '                    \r\n2122', '1', '2014-06-18 12:56:38', '1', '2014-06-18 12:56:38', '0');
INSERT INTO `sysmessage` VALUES ('99', '', '                    \r\n', '1', '2014-06-18 12:58:55', '1', '2014-06-18 12:58:55', '0');
INSERT INTO `sysmessage` VALUES ('100', '', '                    \r\n', '1', '2014-06-18 12:59:20', '1', '2014-06-18 12:59:20', '0');
INSERT INTO `sysmessage` VALUES ('101', 'CRM API', '                    \r\n1\r\n2\r\n3\r\n4\r\n5\r\n6', '1', '2014-06-18 13:00:41', '1', '2014-06-18 13:00:41', '0');
INSERT INTO `sysmessage` VALUES ('102', 'gr23', '                    \r\n4242', '1', '2014-06-18 13:00:57', '1', '2014-06-18 13:00:57', '0');
INSERT INTO `sysmessage` VALUES ('103', '千万级的手机库存消化', '5月酷派成国内4G手机市场份额第一，但\r\n出货量或仅百万级，随着下半年4G终端群狼争食，\r\n市场份额将被快速稀释，领先注定是昙花一现，千万级的手机库存消化将成其首要难题。                    ', '1', '2014-06-19 14:56:22', '1', '2014-06-19 14:56:22', '0');
INSERT INTO `sysmessage` VALUES ('104', 'gfafd', 'fasfd', '1', '2014-06-19 15:11:23', '1', '2014-06-19 15:11:23', '0');
INSERT INTO `sysmessage` VALUES ('105', '', '                    fasdfas', '1', '2014-06-19 15:11:32', '1', '2014-06-19 15:11:32', '0');
INSERT INTO `user_message` VALUES ('58', '59', '1', '1', '0', '1', '2014-06-11 17:44:45', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('59', '59', '1', '1', '0', '0', '2014-06-11 17:44:45', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('60', '61', '38', '1', '0', '1', '2014-06-11 19:45:35', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('61', '61', '38', '1', '0', '0', '2014-06-11 19:45:35', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('62', '60', '38', '1', '0', '1', '2014-06-11 19:45:35', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('63', '60', '38', '0', '0', '0', '2014-06-11 19:45:35', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('64', '61', '39', '1', '0', '1', '2014-06-11 19:45:35', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('65', '61', '39', '0', '0', '0', '2014-06-11 19:45:35', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('66', '60', '39', '1', '0', '1', '2014-06-11 19:45:35', '2014-06-24 15:45:45');
INSERT INTO `user_message` VALUES ('67', '60', '39', '0', '0', '0', '2014-06-11 19:45:35', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('68', '62', '5', '1', '0', '1', '2014-06-11 19:46:34', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('69', '62', '5', '0', '1', '0', '2014-06-11 19:46:34', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('70', '62', '4', '1', '0', '1', '2014-06-11 19:46:34', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('71', '62', '4', '0', '1', '0', '2014-06-11 19:46:34', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('72', '63', '3', '1', '1', '1', '2014-06-11 19:49:17', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('73', '63', '3', '1', '0', '0', '2014-06-11 19:49:17', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('74', '64', '38', '0', '0', '1', '2014-06-12 09:22:29', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('75', '64', '38', '0', '0', '0', '2014-06-12 09:22:29', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('76', '64', '1', '1', '0', '1', '2014-06-12 09:22:29', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('77', '64', '1', '1', '0', '0', '2014-06-12 09:22:29', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('78', '65', '3', '0', '1', '1', '2014-06-12 16:36:07', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('79', '65', '3', '0', '0', '0', '2014-06-12 16:36:07', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('80', '66', '39', '1', '0', '1', '2014-06-12 16:36:34', '2014-06-24 14:57:34');
INSERT INTO `user_message` VALUES ('81', '66', '39', '0', '0', '0', '2014-06-12 16:36:34', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('82', '67', '1', '1', '0', '1', '2014-06-12 16:46:41', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('83', '67', '1', '1', '0', '0', '2014-06-12 16:46:41', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('84', '68', '3', '1', '0', '1', '2014-06-12 16:57:00', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('85', '68', '3', '0', '0', '0', '2014-06-12 16:57:00', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('86', '68', '4', '1', '0', '1', '2014-06-12 16:57:00', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('87', '68', '4', '1', '0', '0', '2014-06-12 16:57:00', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('88', '68', '43', '1', '1', '1', '2014-06-12 16:57:00', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('89', '68', '43', '0', '0', '0', '2014-06-12 16:57:00', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('90', '69', '1', '0', '0', '1', '2014-06-12 16:58:26', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('91', '69', '1', '1', '0', '0', '2014-06-12 16:58:26', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('92', '70', '4', '1', '1', '1', '2014-06-13 15:46:46', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('93', '70', '4', '0', '0', '0', '2014-06-13 15:46:47', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('94', '71', '4', '1', '0', '1', '2014-06-13 16:31:01', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('95', '71', '4', '0', '0', '0', '2014-06-13 16:31:01', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('96', '72', '4', '1', '0', '1', '2014-06-17 13:28:16', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('97', '72', '4', '0', '0', '0', '2014-06-17 13:28:16', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('98', '73', '4', '1', '0', '1', '2014-06-17 14:08:53', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('99', '73', '4', '0', '0', '0', '2014-06-17 14:08:53', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('100', '74', '4', '1', '1', '1', '2014-06-17 14:22:08', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('101', '74', '4', '0', '0', '0', '2014-06-17 14:22:08', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('102', '75', '3', '1', '0', '1', '2014-06-17 21:06:24', '2014-06-24 11:02:45');
INSERT INTO `user_message` VALUES ('103', '75', '3', '0', '0', '0', '2014-06-17 21:06:24', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('104', '76', '3', '1', '0', '1', '2014-06-17 21:06:24', '2014-06-24 09:42:07');
INSERT INTO `user_message` VALUES ('105', '76', '3', '0', '0', '0', '2014-06-17 21:06:24', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('106', '75', '39', '0', '1', '1', '2014-06-17 21:06:24', '2014-06-23 20:52:30');
INSERT INTO `user_message` VALUES ('107', '76', '39', '0', '1', '1', '2014-06-17 21:06:24', '2014-06-23 20:52:25');
INSERT INTO `user_message` VALUES ('108', '75', '39', '0', '0', '0', '2014-06-17 21:06:24', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('109', '76', '39', '0', '0', '0', '2014-06-17 21:06:24', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('110', '75', '6', '0', '1', '1', '2014-06-17 21:06:25', '2014-06-23 20:52:35');
INSERT INTO `user_message` VALUES ('111', '75', '6', '0', '0', '0', '2014-06-17 21:06:25', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('112', '76', '6', '0', '1', '1', '2014-06-17 21:06:25', '2014-06-23 20:47:38');
INSERT INTO `user_message` VALUES ('113', '76', '6', '0', '0', '0', '2014-06-17 21:06:25', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('114', '75', '5', '1', '0', '1', '2014-06-17 21:06:25', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('115', '75', '5', '0', '0', '0', '2014-06-17 21:06:25', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('116', '76', '5', '1', '0', '1', '2014-06-17 21:06:25', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('117', '76', '5', '0', '0', '0', '2014-06-17 21:06:25', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('118', '75', '1', '0', '1', '1', '2014-06-17 21:06:25', '2014-06-23 20:47:46');
INSERT INTO `user_message` VALUES ('119', '75', '1', '1', '0', '0', '2014-06-17 21:06:25', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('120', '76', '1', '1', '0', '1', '2014-06-17 21:06:25', '2014-06-24 11:04:40');
INSERT INTO `user_message` VALUES ('121', '76', '1', '0', '1', '0', '2014-06-17 21:06:25', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('122', '75', '38', '0', '0', '1', '2014-06-17 21:06:25', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('123', '75', '38', '0', '0', '0', '2014-06-17 21:06:25', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('124', '76', '38', '0', '0', '1', '2014-06-17 21:06:25', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('125', '76', '38', '0', '0', '0', '2014-06-17 21:06:25', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('126', '75', '2', '1', '0', '1', '2014-06-17 21:06:26', '2014-06-24 11:02:27');
INSERT INTO `user_message` VALUES ('127', '75', '2', '0', '0', '0', '2014-06-17 21:06:26', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('128', '76', '2', '1', '0', '1', '2014-06-17 21:06:26', '2014-06-24 14:38:22');
INSERT INTO `user_message` VALUES ('129', '76', '2', '0', '0', '0', '2014-06-17 21:06:26', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('130', '75', '4', '1', '0', '1', '2014-06-17 21:06:26', '2014-06-24 09:32:50');
INSERT INTO `user_message` VALUES ('131', '75', '4', '0', '0', '0', '2014-06-17 21:06:26', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('132', '76', '4', '1', '1', '1', '2014-06-17 21:06:26', '2014-06-24 17:29:06');
INSERT INTO `user_message` VALUES ('133', '76', '4', '0', '0', '0', '2014-06-17 21:06:26', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('134', '75', '43', '1', '0', '1', '2014-06-17 21:06:26', '2014-06-24 14:57:14');
INSERT INTO `user_message` VALUES ('135', '75', '43', '0', '0', '0', '2014-06-17 21:06:26', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('136', '76', '43', '1', '0', '1', '2014-06-17 21:06:26', '2014-06-24 14:38:05');
INSERT INTO `user_message` VALUES ('137', '76', '43', '0', '0', '0', '2014-06-17 21:06:26', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('138', '78', '1', '0', '1', '1', '2014-06-17 21:08:41', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('139', '77', '1', '1', '0', '1', '2014-06-17 21:08:41', '2014-06-24 15:22:23');
INSERT INTO `user_message` VALUES ('140', '78', '1', '1', '0', '0', '2014-06-17 21:08:41', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('141', '77', '1', '0', '1', '0', '2014-06-17 21:08:41', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('142', '79', '1', '1', '0', '1', '2014-06-17 21:13:27', '2014-06-24 16:08:59');
INSERT INTO `user_message` VALUES ('143', '79', '1', '1', '0', '0', '2014-06-17 21:13:28', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('144', '88', '38', '0', '0', '1', '2014-06-18 12:25:55', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('145', '88', '38', '0', '0', '0', '2014-06-18 12:25:55', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('146', '93', '38', '0', '0', '1', '2014-06-18 12:53:30', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('147', '93', '38', '0', '0', '0', '2014-06-18 12:53:30', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('148', '96', '4', '0', '1', '1', '2014-06-18 12:54:38', '2014-06-23 20:48:08');
INSERT INTO `user_message` VALUES ('149', '96', '4', '0', '0', '0', '2014-06-18 12:54:38', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('150', '97', '6', '0', '1', '1', '2014-06-18 12:55:13', '2014-06-23 20:48:04');
INSERT INTO `user_message` VALUES ('151', '97', '6', '0', '0', '0', '2014-06-18 12:55:13', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('152', '98', '38', '0', '1', '1', '2014-06-18 12:56:38', '2014-06-23 20:48:00');
INSERT INTO `user_message` VALUES ('153', '98', '38', '0', '0', '0', '2014-06-18 12:56:38', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('154', '101', '3', '1', '0', '1', '2014-06-18 13:00:41', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('155', '101', '3', '0', '0', '0', '2014-06-18 13:00:41', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('156', '102', '1', '0', '1', '1', '2014-06-18 13:00:57', '2014-06-23 20:47:56');
INSERT INTO `user_message` VALUES ('157', '102', '1', '1', '0', '0', '2014-06-18 13:00:57', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('158', '103', '1', '1', '0', '1', '2014-06-19 14:56:22', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('159', '103', '1', '1', '0', '0', '2014-06-19 14:56:22', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('160', '104', '1', '0', '1', '1', '2014-06-19 15:11:23', '2014-06-23 20:47:51');
INSERT INTO `user_message` VALUES ('161', '104', '1', '1', '0', '0', '2014-06-19 15:11:23', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('162', '105', '1', '1', '0', '1', '2014-06-19 15:11:32', '2014-06-23 20:47:13');
INSERT INTO `user_message` VALUES ('163', '105', '1', '1', '0', '0', '2014-06-19 15:11:32', '2014-06-23 20:47:13');
