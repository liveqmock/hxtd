# 初始化测试数据，组织、用户、角色
DELETE FROM hxtd.SM_ORG
WHERE is_initialized = 0;
INSERT INTO hxtd.sm_org (ID, CODE, TYPE, PARENT_ORG_ID, SHORT_NAME, FULL_NAME, ADDRESS, ZIP_CODE, PHONE, EMAIL, WEB_SITE, STATUS, `ORDER`, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_LEAF, LEVEL, IS_INITIALIZED)
VALUES (101, '010100', 1030101, 1, '董事会', NULL, '北京市海淀区', '100000', '1862008324', '1429457@163.com', 'http://hxtd.crm.com', NULL, 1010000, '', 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:03.0', 1, 2, 0);
INSERT INTO hxtd.sm_org (ID, CODE, TYPE, PARENT_ORG_ID, SHORT_NAME, FULL_NAME, ADDRESS, ZIP_CODE, PHONE, EMAIL, WEB_SITE, STATUS, `ORDER`, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_LEAF, LEVEL, IS_INITIALIZED)
VALUES (102, '010200', 1030101, 1, '三级委员会', NULL, '北京市海淀区', '100000', '1862008324', '1429457@163.com', 'http://hxtd.crm.com', NULL, 1020000, '', 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:03.0', 1, 2, 0);
INSERT INTO hxtd.sm_org (ID, CODE, TYPE, PARENT_ORG_ID, SHORT_NAME, FULL_NAME, ADDRESS, ZIP_CODE, PHONE, EMAIL, WEB_SITE, STATUS, `ORDER`, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_LEAF, LEVEL, IS_INITIALIZED)
VALUES (103, '010300', 1030101, 1, '技术管理中心', NULL, '北京市海淀区', '100000', '1862008324', '1429457@163.com', 'http://hxtd.crm.com', NULL, 1030000, '', 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:03.0', 0, 2, 0);
INSERT INTO hxtd.sm_org (ID, CODE, TYPE, PARENT_ORG_ID, SHORT_NAME, FULL_NAME, ADDRESS, ZIP_CODE, PHONE, EMAIL, WEB_SITE, STATUS, `ORDER`, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_LEAF, LEVEL, IS_INITIALIZED)
VALUES (10301, '010302', 1030101, 103, '企划营销中心', NULL, '北京市海淀区', '100000', '1862008324', '1429457@163.com', 'http://hxtd.crm.com', NULL, 1030200, '', 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:03.0', 1, 3, 0);

DELETE FROM hxtd.sm_user
WHERE is_initialized = 0;
INSERT INTO hxtd.sm_user (ID, LOGIN_NAME, PASSWORD, CODE, USER_NAME, `ORDER`, IS_ACTIVE, JOB_SITUATION, SEX_ID, PHONE, MOBILE, EMAIL, QQ, IS_MANAGER, JOB_NAME, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, STORE_STATUS, ORGANIZATION_ID, IS_DELETED, IS_INITIALIZED)
VALUES (2, 'majingliang', 'e10adc3949ba59abbe56e057f20f883e', '', '马敬亮', 2, '1', 1040301, 11010215, '18620088324', '0000000000', '00000000@gmail.com', '000000000', 0, '工程师', '', 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:03.0', 1040402, 101, 0, 0);
INSERT INTO hxtd.sm_user (ID, LOGIN_NAME, PASSWORD, CODE, USER_NAME, `ORDER`, IS_ACTIVE, JOB_SITUATION, SEX_ID, PHONE, MOBILE, EMAIL, QQ, IS_MANAGER, JOB_NAME, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, STORE_STATUS, ORGANIZATION_ID, IS_DELETED, IS_INITIALIZED)
VALUES (3, 'lihua', 'e10adc3949ba59abbe56e057f20f883e', '', '李华', 3, '1', 1040301, 11010215, '18620088324', '0000000000', '00000000@gmail.com', '000000000', 0, '工程师', '', 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 00:00:00.0', 1040402, 103, 0, 0);
INSERT INTO hxtd.sm_user (ID, LOGIN_NAME, PASSWORD, CODE, USER_NAME, `ORDER`, IS_ACTIVE, JOB_SITUATION, SEX_ID, PHONE, MOBILE, EMAIL, QQ, IS_MANAGER, JOB_NAME, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, STORE_STATUS, ORGANIZATION_ID, IS_DELETED, IS_INITIALIZED)
VALUES (4, 'luanruisong', 'e10adc3949ba59abbe56e057f20f883e', '', '栾瑞松', 4, '1', 1040301, 11010215, '18620088324', '0000000000', '00000000@gmail.com', '000000000', 0, '工程师', '', 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 00:00:00.0', 1040402, 10301, 0, 0);

DELETE FROM hxtd.sm_role
WHERE is_initialized = 0;
INSERT INTO hxtd.sm_role (ID, CODE, NAME, TYPE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED, IS_INITIALIZED) VALUES (1, '1', '管理员', 1050101, '管理员', 1, '2014-06-19 13:49:31.0', 1, '2014-06-19 13:49:31.0', 0, 0);
INSERT INTO hxtd.sm_role (ID, CODE, NAME, TYPE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED, IS_INITIALIZED) VALUES (2, '2', '数据管理员', 1050101, '数据管理员', 1, '2014-06-19 13:49:31.0', 1, '2014-06-19 13:49:31.0', 0, 0);
