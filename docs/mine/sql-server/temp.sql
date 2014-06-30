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

use hxtd;
INSERT INTO `sm_function` VALUES ('110106', '1101', '10406', '授权', '/system/user/authorization.do', '', '1', '2014-05-26 00:00:00', '1', '2014-05-26 19:29:06', '1060103', '0', NULL, '1');
INSERT INTO `sm_function` VALUES ('110107', '1101', '110107', '重置密码', '/system/user/resetPassword.do', '', '1', '2014-05-31 00:00:00', '1', '2014-05-31 06:39:39', '1060103', '0', NULL, '1');
INSERT INTO `sm_function` VALUES ('110108', '1101', '110108', '启用', '/system/user/enable.do', '', '1', '2014-05-31 00:00:00', '1', '2014-05-31 06:39:39', '1060103', '0', NULL, '1');
INSERT INTO `sm_function` VALUES ('110109', '1101', '110109', '禁用', '/system/user/disable.do', '', '1', '2014-05-31 00:00:00', '1', '2014-05-31 06:39:39', '1060103', '0', NULL, '1');
INSERT INTO `sm_function` VALUES ('110110', '1101', '110110', '登录', '/login.doself', '', '1', '2014-05-31 00:00:00', '1', '2014-06-05 14:29:10', '1060101', '0', NULL, '1');
INSERT INTO `sm_function` VALUES ('110111', '1101', '110111', '注销', '/logout.doself', '', '1', '2014-05-31 00:00:00', '1', '2014-06-05 14:29:13', '1060101', '0', NULL, '1');
INSERT INTO `sm_function` VALUES ('110112', '1101', '110112', '导入', '/system/user/import.do', '', '1', '2014-05-31 00:00:00', '1', '2014-06-05 14:29:01', '1060103', '0', NULL, '1');
INSERT INTO `sm_function` VALUES ('110113', '1101', '110113', '用户导出', '/system/user/export.do', '', '1', '2014-05-31 00:00:00', '1', '2014-06-13 18:40:58', '1060103', '0', '6', '1');
