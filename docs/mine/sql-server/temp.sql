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

# INSERT INTO hxtd.sm_function (ID, MENU_ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, PRIVILEGE_LEVEL_ID, IS_DELETED, PARENT_ID, IS_INITIALIZED)
# VALUES (090002, 09, '090002', '新增', '/common/report/add.do', '', 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0', 1060103, 0, NULL, 1);
# INSERT INTO hxtd.sm_function (ID, MENU_ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, PRIVILEGE_LEVEL_ID, IS_DELETED, PARENT_ID, IS_INITIALIZED)
# VALUES (090003, 09, '090003', '查看', '/common/report/view.do', '', 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0', 1060103, 0, NULL, 1);
# INSERT INTO hxtd.sm_function (ID, MENU_ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, PRIVILEGE_LEVEL_ID, IS_DELETED, PARENT_ID, IS_INITIALIZED)
# VALUES (090004, 09, '090004', '修改', '/common/report/modify.do', '', 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0', 1060103, 0, NULL, 1);
# INSERT INTO hxtd.sm_function (ID, MENU_ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, PRIVILEGE_LEVEL_ID, IS_DELETED, PARENT_ID, IS_INITIALIZED)
# VALUES (090005, 09, '090005', '删除', '/common/report/delete.do', '', 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0', 1060103, 0, NULL, 1);
# INSERT INTO hxtd.sm_function (ID, MENU_ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, PRIVILEGE_LEVEL_ID, IS_DELETED, PARENT_ID, IS_INITIALIZED)
# VALUES (090006, 09, '090006', '生成报表', '/common/report/generate.do', '', 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0', 1060103, 0, NULL, 1);

# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (990101, '模块类型', '990101', NULL, 1, 0, 'module_type', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
#
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (99010101, '报表', '99010101', 990101, 2, 0, 'module_type', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);

# INSERT INTO hxtd.sm_component (ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME,PRIVILEGE_LEVEL_ID)
# VALUES (990110, '990110', '查找模块字段', '/common/module/findModuleFields.docomp', '查找模块字段通过模块主键编号', 1, '2014-01-01 00:00:00.0', 1, '2014-01-01 00:00:00.0',1060102);


# INSERT INTO hxtd.sm_component (ID, CODE, NAME, URL, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, PRIVILEGE_LEVEL_ID)
# VALUES (090001, '090001', '查找分组类型', '/common/report/findGroupType.docomp', '查找分组类型通过模块名称和字段名称', 1, '2014-01-01 00:00:00.0', 1, '2014-01-01 00:00:00.0', 1060102);


# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (9000101, '报表分组', '09000101', NULL, 1, 0, 'report_group', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
#
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (900010101, '日期', '0900010101', 9000101, 2, 0, 'report_group_time', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
#
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (90001010101, '年', '090001010101', 900010101, 3, 0, 'report_group_time', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (90001010102, '月', '090001010102', 900010101, 3, 0, 'report_group_time', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (90001010103, '日', '090001010103', 900010101, 3, 0, 'report_group_time', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (90001010104, '时', '090001010104', 900010101, 3, 0, 'report_group_time', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (90001010105, '分', '090001010105', 900010101, 3, 0, 'report_group_time', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (90001010106, '秒', '090001010106', 900010101, 3, 0, 'report_group_time', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);

# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (900010199, '其他', '0900010199', 9000101, 2, 0, 'report_group_else', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
#
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (90001019901, '最细化', '0900010199', 900010199, 3, 0, 'report_group_else_mostdetail', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);


# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (9000201, '报表聚合类型', '09000201', NULL, 1, 0, 'report_aggregate', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (900020101, '总计', '0900020101', 9000201, 2, 0, 'report_aggregate', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (900020102, '求和', '0900020102', 9000201, 2, 0, 'report_aggregate', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (900020103, '平均', '0900020103', 9000201, 2, 0, 'report_aggregate', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (900020104, '最大', '0900020104', 9000201, 2, 0, 'report_aggregate', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (900020105, '最小', '0900020105', 9000201, 2, 0, 'report_aggregate', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);


# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (90003, '报表图表类型', '090003', NULL, 1, 0, 'report_chart', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (9000301, '饼状图', '09000301', 90003, 2, 0, 'report_chart', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (9000302, '柱状图', '09000302', 90003, 2, 0, 'report_chart', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (9000303, '折线图', '09000303', 90003, 2, 0, 'report_chart', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);

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
