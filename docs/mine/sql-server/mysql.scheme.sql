/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2014/4/25 16:22:17                           */
/*==============================================================*/

CREATE DATABASE if not exists hxtd DEFAULT CHARACTER SET utf8;

USE hxtd;
# SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
# MySQL禁用恢复外键约束

DROP TABLE IF EXISTS T_SYS_COMPONENT;

DROP TABLE IF EXISTS T_SYS_FUNC;

DROP TABLE IF EXISTS T_SYS_MENU;

DROP TABLE IF EXISTS T_SYS_ROLE;

DROP TABLE IF EXISTS T_SYS_ROLECOMPONENT;

DROP TABLE IF EXISTS T_SYS_ROLEFUNC;

DROP TABLE IF EXISTS T_SYS_ROLEFUNCPRIVI2;

DROP TABLE IF EXISTS T_SYS_USER;

DROP TABLE IF EXISTS T_SYS_USERCOMPONENT;

DROP TABLE IF EXISTS T_SYS_USERFUNC;

DROP TABLE IF EXISTS T_SYS_USERROLE;

/*==============================================================*/
/* Table: T_SYS_COMPONENT                                       */
/*==============================================================*/
CREATE TABLE T_SYS_COMPONENT
(
  id   INT NOT NULL,
  name VARCHAR(32),
  url  VARCHAR(32),
  PRIMARY KEY (id)
);

ALTER TABLE T_SYS_COMPONENT COMMENT '�����';

/*==============================================================*/
/* Table: T_SYS_FUNC                                            */
/*==============================================================*/
CREATE TABLE T_SYS_FUNC
(
  id     INT NOT NULL,
  name   VARCHAR(32),
  url    VARCHAR(32),
  menuid INT,
  PRIMARY KEY (id)
);

ALTER TABLE T_SYS_FUNC COMMENT '���ܱ�';

/*==============================================================*/
/* Table: T_SYS_MENU                                            */
/*==============================================================*/
CREATE TABLE T_SYS_MENU
(
  id       INT NOT NULL,
  name     VARCHAR(32),
  url      VARCHAR(32),
  type     INT,
  serial   INT,
  parentid INT,
  PRIMARY KEY (id)
);

ALTER TABLE T_SYS_MENU COMMENT '�˵���';

/*==============================================================*/
/* Table: T_SYS_ROLE                                            */
/*==============================================================*/
CREATE TABLE T_SYS_ROLE
(
  id   INT NOT NULL,
  name VARCHAR(32),
  PRIMARY KEY (id)
);

ALTER TABLE T_SYS_ROLE COMMENT '��ɫ��';

/*==============================================================*/
/* Table: T_SYS_ROLECOMPONENT                                   */
/*==============================================================*/
CREATE TABLE T_SYS_ROLECOMPONENT
(
  roleid INT NOT NULL,
  menuid INT NOT NULL,
  PRIMARY KEY (roleid, menuid)
);

ALTER TABLE T_SYS_ROLECOMPONENT COMMENT '��ɫ�����';

/*==============================================================*/
/* Table: T_SYS_ROLEFUNC                                        */
/*==============================================================*/
CREATE TABLE T_SYS_ROLEFUNC
(
  roleid INT NOT NULL,
  funcid INT NOT NULL,
  PRIMARY KEY (funcid, roleid)
);

ALTER TABLE T_SYS_ROLEFUNC COMMENT '��ɫ���ܱ�';

/*==============================================================*/
/* Table: T_SYS_ROLEFUNCPRIVI2                                  */
/*==============================================================*/
CREATE TABLE T_SYS_ROLEFUNCPRIVI2
(
  funcpriviid INT NOT NULL,
  menuid      INT NOT NULL,
  PRIMARY KEY (funcpriviid, menuid)
);

ALTER TABLE T_SYS_ROLEFUNCPRIVI2 COMMENT '��ɫ����Ȩ�ޱ�';

/*==============================================================*/
/* Table: T_SYS_USER                                            */
/*==============================================================*/
CREATE TABLE T_SYS_USER
(
  ID       INT NOT NULL,
  name     VARCHAR(32),
  password VARCHAR(32),
  status   INT,
  PRIMARY KEY (ID)
);

ALTER TABLE T_SYS_USER COMMENT '�û���';

/*==============================================================*/
/* Table: T_SYS_USERCOMPONENT                                   */
/*==============================================================*/
CREATE TABLE T_SYS_USERCOMPONENT
(
  userid    INT NOT NULL,
  component INT NOT NULL,
  PRIMARY KEY (userid, component)
);

ALTER TABLE T_SYS_USERCOMPONENT COMMENT '�û������';

/*==============================================================*/
/* Table: T_SYS_USERFUNC                                        */
/*==============================================================*/
CREATE TABLE T_SYS_USERFUNC
(
  userid INT NOT NULL,
  funcid INT NOT NULL,
  PRIMARY KEY (userid, funcid)
);

ALTER TABLE T_SYS_USERFUNC COMMENT '�û����ܱ�';

/*==============================================================*/
/* Table: T_SYS_USERROLE                                        */
/*==============================================================*/
CREATE TABLE T_SYS_USERROLE
(
  userid INT NOT NULL,
  roleid INT NOT NULL,
  PRIMARY KEY (userid, roleid)
);

ALTER TABLE T_SYS_USERROLE COMMENT '�û���ɫ��';

ALTER TABLE T_SYS_FUNC ADD CONSTRAINT FK_FUNC_MENUID FOREIGN KEY (menuid)
REFERENCES T_SYS_MENU (id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE T_SYS_ROLECOMPONENT ADD CONSTRAINT FK_ROLECOMPONENT_COMPONENTID FOREIGN KEY (menuid)
REFERENCES T_SYS_COMPONENT (id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE T_SYS_ROLECOMPONENT ADD CONSTRAINT FK_ROLECOMPONENT_ROLEID FOREIGN KEY (roleid)
REFERENCES T_SYS_ROLE (id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE T_SYS_ROLEFUNC ADD CONSTRAINT FK_ROLEFUNC_FUNCID FOREIGN KEY (funcid)
REFERENCES T_SYS_FUNC (id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE T_SYS_ROLEFUNC ADD CONSTRAINT FK_ROLEFUNC_ROLEID FOREIGN KEY (roleid)
REFERENCES T_SYS_ROLE (id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE T_SYS_ROLEFUNCPRIVI2 ADD CONSTRAINT FK_FUNCPRIVIMENU_FUNCPRIVIID FOREIGN KEY (funcpriviid)
REFERENCES T_SYS_FUNC (id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE T_SYS_ROLEFUNCPRIVI2 ADD CONSTRAINT FK_FUNCPRIVIMENU_MENUID FOREIGN KEY (menuid)
REFERENCES T_SYS_MENU (id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE T_SYS_USERCOMPONENT ADD CONSTRAINT FK_USERCOMPONENT_COMPONENTID FOREIGN KEY (component)
REFERENCES T_SYS_COMPONENT (id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE T_SYS_USERCOMPONENT ADD CONSTRAINT FK_USERCOMPONENT_USERID FOREIGN KEY (userid)
REFERENCES T_SYS_USER (ID)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE T_SYS_USERFUNC ADD CONSTRAINT FK_USERFUNC_FUNCID FOREIGN KEY (funcid)
REFERENCES T_SYS_FUNC (id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE T_SYS_USERFUNC ADD CONSTRAINT FK_USERFUNC_USERID FOREIGN KEY (userid)
REFERENCES T_SYS_USER (ID)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE T_SYS_USERROLE ADD CONSTRAINT FK_USERROLE_ROLEID FOREIGN KEY (roleid)
REFERENCES T_SYS_ROLE (id)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;
ALTER TABLE T_SYS_USERROLE ADD CONSTRAINT FK_USERROLE_USERID FOREIGN KEY (userid)
REFERENCES T_SYS_USER (ID)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

# SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
