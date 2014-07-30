# 新增功能，启动审批、执行审批
# INSERT INTO `sm_function` (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('15', '030107', '启动审批', '/market/marketactivity/startApprove.do', '', '0', '1060102', null, '1', '1', '2014-07-17 15:33:54', '1', '2014-07-17 16:43:42');
# INSERT INTO `sm_function` (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME) VALUES ('15', '030108', '执行审批', '/market/marketactivity/executeApprove.do', '', '0', '1060102', null, '1', '1', '2014-07-17 15:33:54', '1', '2014-07-17 16:43:42');

# update sm_function set menu_id=15 where `code` in ('030107','030108');
# 流程类型 新增“非金额市场活动审批”，并更新“市场活动审批”->“金额市场活动审批”
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, `VALUE`, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME)
# VALUES (99020102, '市场活动（金额）', '99020102', 990201, 2, 2, 'flow_type', 1, '', 0, 1, 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0');
# INSERT INTO hxtd.sm_dictionary (ID, `KEY`, `VALUE`, PARENT_ID, LEVEL, `ORDER`, TYPE, IS_ACTIVE, REMARK, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME)
# VALUES (99020103, '市场活动（非金额）', '99020103', 990201, 2, 3, 'flow_type', 1, '', 0, 1, 1, '2014-06-06 13:32:39.0', 1, '2014-06-25 10:31:51.0');
# UPDATE hxtd.sm_dictionary
# SET `value` = '市场活动（金额）'
# WHERE `value` = '99020102';


#新增流程环节“市场活动（金额）”
# DELETE FROM hxtd.wf_node
# WHERE FLOW_ID = 99020102;
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID, `ORDER`) VALUES ('030101', '开始', 99020102, NULL, 1, 1);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID, `ORDER`) VALUES ('030102', '投资总监审核', 99020102, 9, 2, 2);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID, `ORDER`) VALUES ('030103', '总裁审核', 99020102, 6, 2, 3);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID, `ORDER`) VALUES ('030104', '财务审核', 99020102, 8, 2, 4);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID, `ORDER`) VALUES ('030105', '结束', 99020102, NULL, 3, 5);

#新增流程环节“市场活动（非金额）”
# DELETE FROM hxtd.wf_node WHERE FLOW_ID = 99020103;
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID, `ORDER`) VALUES ('030111', '开始', 99020103, NULL, 1, 1);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID, `ORDER`) VALUES ('030112', '理财经理审核', 99020103, 11, 2, 2);
# INSERT INTO hxtd.wf_node (CODE, NAME, FLOW_ID, ROLE_ID, TYPE_ID, `ORDER`) VALUES ('030113', '结束', 99020103, NULL, 3, 3);


# 新增流程环节
# ALTER TABLE hxtd.market_activity ADD FLOW_NODE_ID int NOT NULL;

# 初始化市场活动数据
UPDATE hxtd.market_activity
SET flow_node_id = 16
WHERE PREDICT_COST > 0;
UPDATE hxtd.market_activity
SET flow_node_id = 21
WHERE PREDICT_COST = 0;

# 初始化订单数据
UPDATE hxtd.`order`
SET status = 1;

delete from wf_task;