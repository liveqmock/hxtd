# 新增功能，启动审批、执行审批
# INSERT INTO `sm_function` VALUES ('140115', '22', '060108', '启动审批', '/order/order/startApprove.do', '', '0', '1060102', null, '1', '1', '2014-07-17 15:33:54', '1', '2014-07-17 16:43:42');
# INSERT INTO `sm_function` VALUES ('140116', '22', '060109', '执行审批', '/order/order/executeApprove.do', '', '0', '1060102', null, '1', '1', '2014-07-17 15:33:54', '1', '2014-07-17 16:43:42');

#流程类型
# DELETE FROM hxtd.sm_dictionary
# WHERE value LIKE '990201%';
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (990201, '流程类型', '990201', NULL, 1, 0, 'flow_type', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (99020101, '订单审批', '99020101', 990201, 2, 0, 'flow_type', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, VALUE, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
# VALUES (99020102, '订单赎回', '99020102', 990201, 2, 0, 'flow_type', 1, '', 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0', 0);

#流程节点，加开始和结束
# DELETE FROM hxtd.wf_node
# WHERE FLOW_ID = 99020101;
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID) VALUES ('060100', '开始', 99020101, NULL, 1);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID) VALUES ('060101', '理财经理审核', 99020101, 11, 2);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID) VALUES ('060102', '投资经理审核', 99020101, 10, 2);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID) VALUES ('060103', '投资总监审核', 99020101, 9, 2);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID) VALUES ('060104', '副总裁审核', 99020101, 7, 2);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID) VALUES ('060105', '总裁审核', 99020101, 6, 2);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID) VALUES ('060106', '财务审核', 99020101, 8, 2);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID) VALUES ('060107', '结束', 99020101, NULL, 3);

# 测试数据

# 用户
DELETE FROM hxtd.sm_user where login_name in('majingliang','lihua','xiayouxue','luoxiaoli','luanruisong','huizijing','lijinghan','renliqun','haohongqin','','','');
INSERT INTO hxtd.sm_user (LOGIN_NAME, PASSWORD, USER_NAME, SEX_ID, PHONE, MOBILE, EMAIL, QQ, JOB_NAME, JOB_SITUATION_ID, IS_MANAGER, IS_ACTIVE, ORGANIZATION_ID, REMARK, STORE_STATUS_ID, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('majingliang', 'e10adc3949ba59abbe56e057f20f883e', '马敬亮', 11010215, null, null, null, null, null, 1040301, 0, '1', (select id from sm_org where `order`=101000000),  '订单审批流程 总裁', 1040401, 0, 1, 1, '2014-07-23 13:54:57.0', 1, '2014-07-23 13:54:57.0');
INSERT INTO hxtd.sm_user (LOGIN_NAME, PASSWORD, USER_NAME, SEX_ID, PHONE, MOBILE, EMAIL, QQ, JOB_NAME, JOB_SITUATION_ID, IS_MANAGER, IS_ACTIVE, ORGANIZATION_ID, REMARK, STORE_STATUS_ID, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('lihua', 'e10adc3949ba59abbe56e057f20f883e', '李华', 11010215, '18620088324', '0000000000', '00000000@gmail.com', '000000000', '工程师', 1040301, 0, '1', (select id from sm_org where `order`=101000000),'订单审批流程 副总裁', 1040401, 0, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:03.0');
INSERT INTO hxtd.sm_user (LOGIN_NAME, PASSWORD, USER_NAME, SEX_ID, PHONE, MOBILE, EMAIL, QQ, JOB_NAME, JOB_SITUATION_ID, IS_MANAGER, IS_ACTIVE, ORGANIZATION_ID, REMARK, STORE_STATUS_ID, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('xiayouxue', 'e10adc3949ba59abbe56e057f20f883e', '夏幼学', 11010215, null, null, null, null, null, 1040301, 0, '1', (select id from sm_org where `order`=101000000), '订单审批流程 副总裁', 1040401, 0, 1, 1, '2014-07-23 13:54:57.0', 1, '2014-07-23 13:54:57.0');
INSERT INTO hxtd.sm_user (LOGIN_NAME, PASSWORD, USER_NAME, SEX_ID, PHONE, MOBILE, EMAIL, QQ, JOB_NAME, JOB_SITUATION_ID, IS_MANAGER, IS_ACTIVE, ORGANIZATION_ID, REMARK, STORE_STATUS_ID, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('luoxiaoli', 'e10adc3949ba59abbe56e057f20f883e', '罗晓丽', 11010215, '18620088324', '0000000000', '00000000@gmail.com', '000000000', '工程师', 1040301, 0, '1', (select id from sm_org where `order`=127030000), '订单审批流程 财务', 1040401, 0, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:03.0');
INSERT INTO hxtd.sm_user (LOGIN_NAME, PASSWORD, USER_NAME, SEX_ID, PHONE, MOBILE, EMAIL, QQ, JOB_NAME, JOB_SITUATION_ID, IS_MANAGER, IS_ACTIVE, ORGANIZATION_ID, REMARK, STORE_STATUS_ID, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('luanruisong', 'e10adc3949ba59abbe56e057f20f883e', '栾瑞松', 11010215, null, null, null, null, null, 1040301, 0, '1', (select id from sm_org where `order`=128070200), '订单审批流程 投资总监', 1040401, 0, 1, 1, '2014-07-23 13:54:57.0', 1, '2014-07-23 13:54:57.0');
INSERT INTO hxtd.sm_user (LOGIN_NAME, PASSWORD, USER_NAME, SEX_ID, PHONE, MOBILE, EMAIL, QQ, JOB_NAME, JOB_SITUATION_ID, IS_MANAGER, IS_ACTIVE, ORGANIZATION_ID, REMARK, STORE_STATUS_ID, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('huizijing', 'e10adc3949ba59abbe56e057f20f883e', '惠子敬', 11010215, '18620088324', '0000000000', '00000000@gmail.com', '000000000', '工程师', 1040301, 0, '1', (select id from sm_org where `order`=128070201), '订单审批流程 投资经理', 1040401, 0, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:03.0');
INSERT INTO hxtd.sm_user (LOGIN_NAME, PASSWORD, USER_NAME, SEX_ID, PHONE, MOBILE, EMAIL, QQ, JOB_NAME, JOB_SITUATION_ID, IS_MANAGER, IS_ACTIVE, ORGANIZATION_ID, REMARK, STORE_STATUS_ID, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('lijinghan', 'e10adc3949ba59abbe56e057f20f883e', '李静含', 11010215, null, null, null, null, null, 1040301, 0, '1', (select id from sm_org where `order`=128070201), '订单审批流程 理财经理', 1040401, 0, 1, 1, '2014-07-23 13:54:57.0', 1, '2014-07-23 13:54:57.0');
INSERT INTO hxtd.sm_user (LOGIN_NAME, PASSWORD, USER_NAME, SEX_ID, PHONE, MOBILE, EMAIL, QQ, JOB_NAME, JOB_SITUATION_ID, IS_MANAGER, IS_ACTIVE, ORGANIZATION_ID, REMARK, STORE_STATUS_ID, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('renliqun', 'e10adc3949ba59abbe56e057f20f883e', '任莉群', 11010215, '18620088324', '0000000000', '00000000@gmail.com', '000000000', '工程师', 1040301, 0, '1', (select id from sm_org where `order`=128070201), '订单审批流程 理财经理', 1040401, 0, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:03.0');
INSERT INTO hxtd.sm_user (LOGIN_NAME, PASSWORD, USER_NAME, SEX_ID, PHONE, MOBILE, EMAIL, QQ, JOB_NAME, JOB_SITUATION_ID, IS_MANAGER, IS_ACTIVE, ORGANIZATION_ID, REMARK, STORE_STATUS_ID, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('haohongqin', 'e10adc3949ba59abbe56e057f20f883e', '郝红琴', 11010215, '18620088324', '0000000000', '00000000@gmail.com', '000000000', '工程师', 1040301, 0, '1', (select id from sm_org where `order`=128070201), '订单审批流程 销售人员', 1040401, 0, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:03.0');

# 新增订单测试角色
# INSERT INTO hxtd.sm_role ( CODE, NAME, TYPE, REMARK, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('ORG_00001', '总裁', 1050101, '总裁', 0, 1, 1, '2014-07-16 17:26:02.0', 1, '2014-07-22 14:27:47.0');
# INSERT INTO hxtd.sm_role ( CODE, NAME, TYPE, REMARK, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('ORG_00002', '副总裁', 1050101, '副总裁', 0, 1, 1, '2014-07-16 17:26:10.0', 1, '2014-07-22 14:27:50.0');
# INSERT INTO hxtd.sm_role ( CODE, NAME, TYPE, REMARK, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('ORG_00003', '财务', 1050101, '财务', 0, 1, 1, '2014-07-16 17:26:10.0', 1, '2014-07-22 14:27:52.0');
# INSERT INTO hxtd.sm_role ( CODE, NAME, TYPE, REMARK, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('ORG_00004', '投资总监', 1050101, '投资总监', 0, 1, 1, '2014-07-16 17:27:07.0', 1, '2014-07-22 14:27:53.0');
# INSERT INTO hxtd.sm_role ( CODE, NAME, TYPE, REMARK, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('ORG_00005', '投资经理', 1050101, '投资经理', 0, 1, 1, '2014-07-16 17:28:34.0', 1, '2014-07-22 14:27:55.0');
# INSERT INTO hxtd.sm_role ( CODE, NAME, TYPE, REMARK, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('ORG_00006', '理财经理', 1050101, '理财经理', 0, 1, 1, '2014-07-16 17:28:40.0', 1, '2014-07-22 14:27:57.0');
# INSERT INTO hxtd.sm_role (CODE, NAME, TYPE, REMARK, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME)VALUES ( 'test', '订单审批流程测试角色', 1050101, '订单审批流程测试角色', 0, 1, 1, '2014-07-18 16:46:09.0', 1, '2014-07-18 16:46:09.0');

# 用户角色关联
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='majingliang'), (select id from sm_role where `code`='ORG_00001'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='lihua'),  (select id from sm_role where `code`='ORG_00002'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='xiayouxue'),  (select id from sm_role where `code`='ORG_00002'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='luoxiaoli'),  (select id from sm_role where `code`='ORG_00003'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='luanruisong'),  (select id from sm_role where `code`='ORG_00004'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='huizijing'),  (select id from sm_role where `code`='ORG_00005'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='lijinghan'),  (select id from sm_role where `code`='ORG_00006'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='renliqun'),  (select id from sm_role where `code`='ORG_00006'));

INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='majingliang'), (select id from sm_role where `code`='2'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='lihua'),  (select id from sm_role where `code`='2'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='xiayouxue'),  (select id from sm_role where `code`='2'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='luoxiaoli'),  (select id from sm_role where `code`='2'));

INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='majingliang'), (select id from sm_role where `code`='test'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='lihua'),  (select id from sm_role where `code`='test'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='xiayouxue'),  (select id from sm_role where `code`='test'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='luoxiaoli'),  (select id from sm_role where `code`='test'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='luanruisong'),  (select id from sm_role where `code`='test'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='huizijing'),  (select id from sm_role where `code`='test'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='lijinghan'),  (select id from sm_role where `code`='test'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='renliqun'),  (select id from sm_role where `code`='test'));
INSERT INTO sm_user_role (USER_ID, ROLE_ID) VALUES ((select id from sm_user where login_name='haohongqin'),  (select id from sm_role where `code`='test'));

# 订单->产品->客户


# 财务管理
# # 菜单 URL
# update sm_menu set url='/financial/approve/query.do' where id=24;
# update sm_menu set url='/financial/funds/query.do' where id=25;
# #功能
# INSERT INTO hxtd.sm_function (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES (24, '080101', '查询', '/financial/approve/query.do', '', 0, 1060103, null, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-06-03 15:43:28.0');
# INSERT INTO hxtd.sm_function (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES (24, '080102', '新增', '/financial/approve/add.do', '', 0, 1060103, null, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-06-03 15:43:30.0');
# INSERT INTO hxtd.sm_function (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES (24, '080103', '详情', '/financial/approve/view.do', '', 0, 1060103, null, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0');
# INSERT INTO hxtd.sm_function (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES (24, '080104', '编辑', '/financial/approve/modify.do', '', 0, 1060103, null, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:45.0');
# INSERT INTO hxtd.sm_function (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES (24, '080105', '删除', '/financial/approve/delete.do', '', 0, 1060103, null, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:05.0');
# INSERT INTO hxtd.sm_function (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES (24, '080106', '进行审批', '/financial/approve/approve.do', '', 0, 1060102, null, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:05.0');
# INSERT INTO hxtd.sm_function (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES (25, '080201', '查询', '/financial/funds/query.do', '', 0, 1060103, null, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-06-03 15:43:28.0');
# INSERT INTO hxtd.sm_function (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES (25, '080202', '新增', '/financial/funds/add.do', '', 0, 1060103, null, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-06-03 15:43:30.0');
# INSERT INTO hxtd.sm_function (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES (25, '080203', '详情', '/financial/funds/view.do', '', 0, 1060103, null, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:29.0');
# INSERT INTO hxtd.sm_function (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES (25, '080204', '编辑', '/financial/funds/modify.do', '', 0, 1060103, null, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-06-18 11:04:45.0');
# INSERT INTO hxtd.sm_function (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES (25, '080205', '删除', '/financial/funds/delete.do', '', 0, 1060103, null, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-05-26 19:29:05.0');
# # 菜单 触发功能
# update sm_menu set trigger_id=(select min(id) from sm_function where code='080101') where id=24;
# update sm_menu set trigger_id=(select min(id) from sm_function where code='080201') where id=25;


# 订单 新增`ORDER`
# ALTER TABLE hxtd.wf_node ADD `ORDER` int NOT NULL;
# update hxtd.wf_node set `ORDER`=id;

#模块 添加请求url
# ALTER TABLE hxtd.sm_module ADD URL VARCHAR(64) NOT NULL;
# ALTER TABLE hxtd.sm_module ADD CONSTRAINT INDEX_URL UNIQUE (URL);
# DELETE FROM hxtd.sm_module;
# INSERT INTO `sm_module` VALUES ('2', 'lead', '线索', 'com.baihui.hxtd.soa.customer.entity.Lead', '/customer/lead');
# INSERT INTO `sm_module` VALUES ('3', 'contact', '联系人', 'com.baihui.hxtd.soa.customer.entity.Contact', '/customer/contact');
# INSERT INTO `sm_module` VALUES ('4', 'customer', '客户', 'com.baihui.hxtd.soa.customer.entity.Customer', '/customer/customer');
# INSERT INTO `sm_module` VALUES ('5', 'supplier', '供应商', 'com.baihui.hxtd.soa.project.entity.Supplier', '/project/supplier');
# INSERT INTO `sm_module` VALUES ('6', 'project', '项目', 'com.baihui.hxtd.soa.project.entity.Project', '/project/project');
# INSERT INTO `sm_module` VALUES ('7', 'product', '产品', 'com.baihui.hxtd.soa.project.entity.Product', '/project/product');
# INSERT INTO `sm_module` VALUES ('8', 'order', '订单', 'com.baihui.hxtd.soa.order.entity.Order', '/order/order');
# INSERT INTO `sm_module` VALUES ('9', 'user', '用户', 'com.baihui.hxtd.soa.system.entity.User', '/system/user');
# INSERT INTO `sm_module` VALUES ('10', 'role', '角色', 'com.baihui.hxtd.soa.system.entity.Role', '/system/role');
# INSERT INTO `sm_module` VALUES ('11', 'menu', '菜单', 'com.baihui.hxtd.soa.system.entity.Menu', '/system/menu');
# INSERT INTO `sm_module` VALUES ('12', 'function', '功能', 'com.baihui.hxtd.soa.system.entity.Function', '/system/function');
# INSERT INTO `sm_module` VALUES ('13', 'component', '组件', 'com.baihui.hxtd.soa.system.entity.Component', '/system/component');
# INSERT INTO `sm_module` VALUES ('14', 'organization', '组织', 'com.baihui.hxtd.soa.system.entity.Organization', '/system/organization');
# INSERT INTO `sm_module` VALUES ('15', 'userMessage', '系统消息', 'com.baihui.hxtd.soa.system.entity.UserMessage', '/system/userMessage');
# INSERT INTO `sm_module` VALUES ('16', 'notice', '系统公告', 'com.baihui.hxtd.soa.system.entity.Notice', '/system/notice');
# INSERT INTO `sm_module` VALUES ('17', 'dictionary', '字典', 'com.baihui.hxtd.soa.system.entity.Dictionary', '/system/dictionary');
# INSERT INTO `sm_module` VALUES ('18', 'auditLog', '审计日志', 'com.baihui.hxtd.soa.system.entity.AuditLog', '/system/auditLog');
# INSERT INTO `sm_module` VALUES ('19', 'recycleBin', '回收站', 'com.baihui.hxtd.soa.system.entity.RecycleBin', '/system/recycleBin');
# INSERT INTO `sm_module` VALUES ('20', 'attachment', '附件', 'com.baihui.hxtd.soa.common.entity.Attachment', '/common/attachment');
# INSERT INTO `sm_module` VALUES ('21', 'memoir', '联系人纪要', 'com.baihui.hxtd.soa.common.entity.Memoir', '/common/memoir');
# 初始化模块数据
