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

# INSERT INTO hxtd.sm_function (ID, MENU_ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, PRIVILEGE_LEVEL_ID, IS_DELETED, PARENT_ID, IS_INITIALIZED)
# VALUES (090001, 09, '090001', '查询', '/common/report/query.do', '', 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0', 1060103, 0, NULL, 1);

INSERT INTO hxtd.sm_function (ID, MENU_ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, PRIVILEGE_LEVEL_ID, IS_DELETED, PARENT_ID, IS_INITIALIZED)
VALUES (090002, 09, '090002', '新增', '/common/report/add.do', '', 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0', 1060103, 0, NULL, 1);
INSERT INTO hxtd.sm_function (ID, MENU_ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, PRIVILEGE_LEVEL_ID, IS_DELETED, PARENT_ID, IS_INITIALIZED)
VALUES (090003, 09, '090003', '查看', '/common/report/view.do', '', 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0', 1060103, 0, NULL, 1);
INSERT INTO hxtd.sm_function (ID, MENU_ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, PRIVILEGE_LEVEL_ID, IS_DELETED, PARENT_ID, IS_INITIALIZED)
VALUES (090004, 09, '090004', '修改', '/common/report/modify.do', '', 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0', 1060103, 0, NULL, 1);
INSERT INTO hxtd.sm_function (ID, MENU_ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, PRIVILEGE_LEVEL_ID, IS_DELETED, PARENT_ID, IS_INITIALIZED)
VALUES (090005, 09, '090005', '删除', '/common/report/delete.do', '', 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0', 1060103, 0, NULL, 1);
INSERT INTO hxtd.sm_function (ID, MENU_ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, PRIVILEGE_LEVEL_ID, IS_DELETED, PARENT_ID, IS_INITIALIZED)
VALUES (090006, 09, '090006', '生成报表', '/common/report/generate.do', '', 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0', 1060103, 0, NULL, 1);

