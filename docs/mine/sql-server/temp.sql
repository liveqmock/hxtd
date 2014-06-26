# update hxtd.sm_user set is_deleted=0
# update hxtd.sm_menu set is_deleted=0


# INSERT INTO hxtd.sm_org (ID, CODE, TYPE, PARENT_ORG_ID, SHORT_NAME, FULL_NAME, ADDRESS, ZIP_CODE, PHONE, EMAIL, WEB_SITE, STATUS, `ORDER`, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_LEAF, LEVEL) VALUES (103, '010300', 1030101, 1, '技术管理中心', '华兴控股', '北京市海淀区', '100000', '1862008324', '1429457@163.com', 'http://hxtd.crm.com', null, 1030000, '', 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:03.0', 0, 2);


# update sm_function set url = null where url='';
# CREATE UNIQUE INDEX INDEX_URL ON hxtd.sm_function ( URL );

# select url,count(*) as count from sm_function group by url having count>1;

INSERT INTO user_message ( MESSAGE_ID, USER_ID, STATUS, IS_DELETED, TYPE, CREATED_TIME)
  select MESSAGE_ID, USER_ID, STATUS, IS_DELETED, TYPE, CREATED_TIME from user_message;