# 预警管理
#在一级菜单“报表管理”下新增“自定义报表”，“报表管理”对应的功能移到“自定义报表”上
INSERT INTO sm_menu (NAME, URL, SHOW_LOCATION_TYPE, DEFAULT_SHOW, TRIGGER_ID, IS_ACTIVE, LEVEL, IS_LEAF, PARENT_MENU_ID, `ORDER`, REMARK, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME)
VALUES ('自定义报表', '/common/report/toQueryPage.do', 1, 0, 111, 1, 2, 1, 8, 90100, '', 0, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-07-27 19:46:56.0');

# 更新父节点-叶子节点属性
UPDATE sm_menu
SET is_leaf = 0, url = NULL, PARENT_MENU_ID = NULL, trigger_id = NULL
WHERE id = 8;

# 更新功能菜单
update sm_function set menu_id=(select id from sm_menu where name='自定义报表') where url like '/common/report/%';

#新增“预警菜单”
INSERT INTO sm_menu (NAME, URL, SHOW_LOCATION_TYPE, DEFAULT_SHOW, TRIGGER_ID, IS_ACTIVE, LEVEL, IS_LEAF, PARENT_MENU_ID, `ORDER`, REMARK, IS_DELETED, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME)
VALUES ('预警管理', '/common/warning/toViewPage.do', 1, 0, NULL, 1, 2, 1, 8, 90200, '', 0, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-07-27 19:46:56.0');

#新增“预警功能”
INSERT INTO sm_function (MENU_ID, CODE, NAME, URL, REMARK, IS_DELETED, PRIVILEGE_LEVEL_ID, PARENT_ID, IS_INITIALIZED, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME)
VALUES ((select id from sm_menu where name='预警管理'), '090203', '查看', '/common/warning/view.do', '', 0, 19, NULL, 1, 1, '2014-05-26 00:00:00.0', 1, '2014-08-07 15:18:27.0');

UPDATE sm_menu
SET trigger_id = (select id from sm_function where code='090203')
WHERE name='预警管理';



