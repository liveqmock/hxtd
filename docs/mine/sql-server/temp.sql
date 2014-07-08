# update hxtd.sm_user set is_deleted=0
# update hxtd.sm_menu set is_deleted=0


# INSERT INTO hxtd.sm_org (ID, CODE, TYPE, PARENT_ORG_ID, SHORT_NAME, FULL_NAME, ADDRESS, ZIP_CODE, PHONE, EMAIL, WEB_SITE, STATUS, `ORDER`, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_LEAF, LEVEL) VALUES (103, '010300', 1030101, 1, '技术管理中心', '华兴控股', '北京市海淀区', '100000', '1862008324', '1429457@163.com', 'http://hxtd.crm.com', null, 1030000, '', 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:03.0', 0, 2);


# update sm_function set url = null where url='';
# CREATE UNIQUE INDEX INDEX_URL ON hxtd.sm_function ( URL );

# select url,count(*) as count from sm_function group by url having count>1;

# INSERT INTO user_message ( MESSAGE_ID, USER_ID, STATUS, IS_DELETED, TYPE, CREATED_TIME)
#   select MESSAGE_ID, USER_ID, STATUS, IS_DELETED, TYPE, CREATED_TIME from user_message;

# 删除系统管理

# 设置功能数据


# 导出删除

# 个人设置

CREATE TABLE hxtd.`sm_audit_log` (
  `ID` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `MODULE_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '日志名称',
  `RECORD_ID` int(11) DEFAULT '0' COMMENT '日志内容',
  `RECORD_NAME` varchar(64) NOT NULL DEFAULT '',
  `TYPE` int(11) NOT NULL DEFAULT '0' COMMENT '操作类型',
  `REMARK` varchar(64) DEFAULT NULL,
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CREATED_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`ID`),
  KEY `INDEX_USER_ID` (`CREATOR_ID`),
  KEY `INDEX_MODULE_NAME` (`MODULE_NAME`) USING BTREE,
  KEY `INDEX_TYPE` (`TYPE`),
  KEY `INDEX_CREATED_TIME` (`CREATED_TIME`)
) ENGINE=InnoDB AUTO_INCREMENT=238 DEFAULT CHARSET=utf8 COMMENT='审计日志表';