/*
t_user
t_role
t_userrole
t_privi
t_roleprivi
t_resource
t_operate
t_priviresourceoperate
t_menu
*/
# CREATE DATABASE mine DEFAULT CHARACTER SET utf8;


USE hxtd;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
# MySQL禁用恢复外键约束

DELETE FROM sys_menu;
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (1, "系统管理", null, 10000, null);
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (11, "菜单管理", "/system/menu", 10100, 1);
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (12, "用户管理", "/system/user", 10200, 1);
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (13, "角色管理", "/system/role", 10300, 1);
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (14, "权限管理", "/system/privi", 10400, 1);
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (2, "工作台", null, 20000, null);
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (3, "市场营销", null, 30000, null);
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (4, "客户管理", null, 40000, null);
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (5, "项目管理", null, 50000, null);
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (6, "订单管理", null, 60000, null);
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (7, "财务管理", null, 70000, null);
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (8, "销售管理", null, 80000, null);
INSERT INTO sys_menu (id, name, url, order, parentid) VALUES (9, "报表管理", null, 90000, null);

DELETE FROM sys_user;
INSERT INTO sys_user (id, name, plainpassword, password, salt, status) VALUES (1, "admin", "admin", "3d21594ecaab373d9853587e81428747e0275c9b", "03c9afe9d84b3161", "enabled");
INSERT INTO sys_user (id, name, plainpassword, password, salt, status) VALUES (2, "user", "user", "3e302766a48612803ea80f4ad2a06bfe36e33b1f", "639a4655c1cf1b66", "enabled");

DELETE FROM sys_role;
INSERT INTO sys_role (id, name) VALUES (1, "admin");
INSERT INTO sys_role (id, name) VALUES (2, "user");

DELETE FROM sys_userrole;
INSERT INTO sys_userrole (userid, roleid) VALUES (1, 1);
INSERT INTO sys_userrole (userid, roleid) VALUES (2, 2);

DELETE FROM sys_privi;
INSERT INTO sys_privi (id, name, shiro) VALUES (1, "menu query", "menu:query");
INSERT INTO sys_privi (id, name, shiro) VALUES (2, "menu create", "menu:create");
INSERT INTO sys_privi (id, name, shiro) VALUES (3, "menu view", "menu:view");
INSERT INTO sys_privi (id, name, shiro) VALUES (4, "menu update", "menu:update");
INSERT INTO sys_privi (id, name, shiro) VALUES (5, "menu delete", "menu:delete");

INSERT INTO sys_privi (id, name, shiro) VALUES (6, "user query", "user:query");
INSERT INTO sys_privi (id, name, shiro) VALUES (7, "user create", "user:create");
INSERT INTO sys_privi (id, name, shiro) VALUES (8, "user view", "user:view");
INSERT INTO sys_privi (id, name, shiro) VALUES (9, "user update", "user:update");
INSERT INTO sys_privi (id, name, shiro) VALUES (10, "user delete", "user:delete");

INSERT INTO sys_privi (id, name, shiro) VALUES (11, "role query", "role:query");
INSERT INTO sys_privi (id, name, shiro) VALUES (12, "role create", "role:create");
INSERT INTO sys_privi (id, name, shiro) VALUES (13, "role view", "role:view");
INSERT INTO sys_privi (id, name, shiro) VALUES (14, "role update", "role:update");
INSERT INTO sys_privi (id, name, shiro) VALUES (15, "role delete", "role:delete");

INSERT INTO sys_privi (id, name, shiro) VALUES (16, "privi query", "privi:query");
INSERT INTO sys_privi (id, name, shiro) VALUES (17, "privi create", "privi:create");
INSERT INTO sys_privi (id, name, shiro) VALUES (18, "privi view", "privi:view");
INSERT INTO sys_privi (id, name, shiro) VALUES (19, "privi update", "privi:update");
INSERT INTO sys_privi (id, name, shiro) VALUES (20, "privi delete", "privi:delete");

DELETE FROM sys_roleprivi;
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 1);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 2);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 3);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 4);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 5);

INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 6);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 7);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 8);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 9);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 10);

INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 11);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 12);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 13);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 14);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 15);

INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 16);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 17);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 18);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 19);
INSERT INTO sys_roleprivi (roleid, priviid) VALUES (1, 20);

INSERT INTO sys_roleprivi (roleid, priviid) VALUES (2, 1);

DELETE FROM sys_privimenu;
INSERT INTO sys_privimenu (priviid, menuid) VALUES (1, 2);
INSERT INTO sys_privimenu (priviid, menuid) VALUES (6, 3);
INSERT INTO sys_privimenu (priviid, menuid) VALUES (11, 4);
INSERT INTO sys_privimenu (priviid, menuid) VALUES (16, 5);



SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;

# DELETE FROM sys_priviro;
# DELETE FROM sys_resource;
# DELETE FROM sys_operate;

# INSERT INTO sys_resource (name) VALUES ("resource list");
# INSERT INTO sys_resource (name) VALUES ("resource manage");
#
# INSERT INTO sys_operate (name) VALUES ("query");
# INSERT INTO sys_operate (name) VALUES ("create");
# INSERT INTO sys_operate (name) VALUES ("update");
# INSERT INTO sys_operate (name) VALUES ("delete");

# INSERT INTO sys_priviro (priviid, resourceid, operateid) VALUES (1, 1, 1);
# INSERT INTO sys_priviro (priviid, resourceid, operateid) VALUES (2, 2, 2);
# INSERT INTO sys_priviro (priviid, resourceid, operateid) VALUES (3, 2, 3);
# INSERT INTO sys_priviro (priviid, resourceid, operateid) VALUES (4, 2, 4);

