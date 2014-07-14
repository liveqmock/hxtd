SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `attachment`
-- ----------------------------
DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `MODULE_ID` int(4) NOT NULL DEFAULT '0' COMMENT '����ģ��ID',
  `RECORD_ID` int(4) NOT NULL DEFAULT '0' COMMENT '����ģ���ڼ�¼��ID',
  `TYPE_DICT` int(4) NOT NULL DEFAULT '0' COMMENT '��������',
  `NAME` varchar(64) NOT NULL DEFAULT '',
  `ADDRESS` varchar(512) NOT NULL DEFAULT '' COMMENT '�洢��ַ',
  `IS_DELETED` smallint(6) NOT NULL DEFAULT '0',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_DICTIONARY_ID` (`RECORD_ID`),
  KEY `INDEX_TYPE` (`TYPE_DICT`),
  KEY `INDEX_CREATE_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODULE` (`MODULE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='������';

-- ----------------------------
-- Table structure for `contact`
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '�ͻ�ID',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '��ϵ������',
  `OWNER` int(11) DEFAULT NULL COMMENT '��ϵ��������',
  `ACCOUNT_ID` int(11) DEFAULT NULL COMMENT '��ϵ������',
  `SUPPLIER_ID` int(11) DEFAULT NULL COMMENT '��Ӧ��ID/�ͻ�ID',
  `SOURCE_DIC` int(11) DEFAULT NULL COMMENT '������Դ',
  `DEPARTMENT` varchar(32) DEFAULT '' COMMENT '����',
  `POSITION` varchar(32) DEFAULT '' COMMENT 'ְλ',
  `PHONE` varchar(32) DEFAULT '' COMMENT '�绰',
  `MOBILE` varchar(23) DEFAULT '' COMMENT '�ֻ�',
  `EMAIL` varchar(32) DEFAULT '' COMMENT '����',
  `FAX` varchar(32) DEFAULT '' COMMENT '����',
  `POST_CODE` varchar(32) DEFAULT '' COMMENT '�ʱ�',
  `PROVINCE` int(11) DEFAULT NULL COMMENT '���ڵأ�ʡ��',
  `CITY` int(11) DEFAULT NULL COMMENT '���ڵأ��У�',
  `COUNTY` int(11) DEFAULT NULL COMMENT '���ڵأ��أ�',
  `ADDRESS` varchar(512) DEFAULT '' COMMENT '��ϸ��ַ',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT 'ɾ�����',
  `REMARK` text COMMENT '��ע',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '�޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_TYPE` (`ACCOUNT_ID`) USING BTREE,
  KEY `INDEX_OWNER` (`OWNER`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_MOBILE` (`MOBILE`),
  KEY `INDEX_PHONE` (`PHONE`),
  KEY `INDEX_SUPPLIER_ID` (`SUPPLIER_ID`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`) USING BTREE,
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��ϵ��';

-- ----------------------------
-- Records of contact
-- ----------------------------

-- ----------------------------
-- Table structure for `contract`
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '��ͬID',
  `NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '��ͬ����',
  `CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '��ͬ���',
  `TYPE_DIC` int(11) NOT NULL DEFAULT '0' COMMENT '��ͬ����',
  `CONTENT` text NOT NULL COMMENT '��ͬ����',
  `ORDER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '����ID',
  `ACCOUNT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�ͻ�ID',
  `REDEEM_TYPE_DIC` int(11) NOT NULL DEFAULT '0' COMMENT '��ط�ʽ',
  `SIGN_TIME` datetime NOT NULL COMMENT 'ǩ��ʱ��',
  `EFFECT_TIME` datetime NOT NULL COMMENT '��Чʱ��',
  `BEREFT_TIME` datetime NOT NULL COMMENT 'ʧЧʱ��',
  `REMARK` varchar(512) DEFAULT '' COMMENT '��ע',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '���ɾ��',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '�޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ORDER_ID` (`ORDER_ID`),
  KEY `INDEX_ACCOUNT_ID` (`ACCOUNT_ID`),
  KEY `INDEX_TYPE` (`TYPE_DIC`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��ͬ��';

-- ----------------------------
-- Table structure for `customer`
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '�ͻ�ID',
  `OWNER` int(11) NOT NULL DEFAULT '0' COMMENT '�ͻ�������',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '�ͻ�����',
  `TYPE_DIC` int(11) DEFAULT NULL COMMENT '�ͻ�����',
  `SOURCE_DIC` int(11) NOT NULL DEFAULT '0' COMMENT '�ͻ���Դ',
  `RISK_GRADE_DIC` int(11) DEFAULT NULL COMMENT '���յȼ�',
  `CARD_TYPE_DIC` int(11) DEFAULT NULL COMMENT '֤������',
  `CARD_NUM` varchar(64) DEFAULT '' COMMENT '֤������',
  `PHONE` varchar(32) NOT NULL DEFAULT '' COMMENT '�绰',
  `MOBILE` varchar(32) NOT NULL DEFAULT '' COMMENT '�ֻ�',
  `DEPT` varchar(255) DEFAULT NULL COMMENT '���ڲ���',
  `JOB` varchar(255) DEFAULT NULL COMMENT 'ְ������',
  `EMAIL` varchar(255) NOT NULL DEFAULT '' COMMENT '����',
  `FAX` varchar(16) DEFAULT '' COMMENT '����',
  `POST_CODE` varchar(16) DEFAULT '' COMMENT '�ʱ�',
  `COMPANY` varchar(64) NOT NULL DEFAULT '' COMMENT '��˾',
  `INDUSTRY_DIC` int(64) NOT NULL DEFAULT '0' COMMENT '��ҵ',
  `OWNERSHIP_DIC` int(64) DEFAULT NULL COMMENT '����Ȩ',
  `OPEN_BANK_DIC` int(11) DEFAULT NULL COMMENT '������',
  `BANK_NAME` varchar(64) DEFAULT '' COMMENT '���л���',
  `BANK_ACCOUNT` varchar(64) DEFAULT '' COMMENT '�˺�',
  `PROVINCE` int(64) DEFAULT '0' COMMENT '���ڵأ�ʡ��',
  `CITY` int(64) DEFAULT '0' COMMENT '���ڵأ��У�',
  `COUNTY` int(64) DEFAULT '0' COMMENT '���ڵأ��أ�',
  `FAMILY_ADDR` varchar(255) DEFAULT NULL COMMENT '��ͥ��ַ',
  `ADDRESS` varchar(255) DEFAULT '' COMMENT '��ϸ��ַ',
  `CONTRIBUTION_TYPE` varchar(255) DEFAULT NULL COMMENT '���ʷ�ʽ',
  `CONTRIBUTION_SCALE` varchar(255) DEFAULT NULL COMMENT '���ʹ�ģ',
  `APPOINTMENT` varchar(255) DEFAULT NULL COMMENT '��Լ��',
  `FINANCIAL_ADVISOR` varchar(255) DEFAULT NULL COMMENT '��ƹ���',
  `FINANCIAL_MANAGER` varchar(255) DEFAULT NULL COMMENT '��ƾ���',
  `FINANCIAL_DIRECTOR` varchar(255) DEFAULT NULL COMMENT '����ܼ�',
  `REMARK` varchar(512) DEFAULT '' COMMENT '��ע',
  `IS_DELETED` tinyint(6) NOT NULL DEFAULT '0' COMMENT '�Ƿ�ɾ��',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ACCOUNT_OWNER` (`OWNER`) USING BTREE,
  KEY `INDEX_PHONE` (`PHONE`),
  KEY `INDEX_MOBILE` (`MOBILE`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_TYPE` (`TYPE_DIC`),
  KEY `INDEX_PROVINCE` (`PROVINCE`),
  KEY `INDEX_CITY` (`CITY`),
  KEY `INDEX_COUNTY` (`COUNTY`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='�ͻ���';

-- ----------------------------
-- Table structure for `import_log`
-- ----------------------------
DROP TABLE IF EXISTS `import_log`;
CREATE TABLE `import_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '������־��ID',
  `START_TIME` datetime NOT NULL COMMENT '�������ݿ�ʼʱ��',
  `END_TIME` datetime NOT NULL COMMENT '�������ݽ���ʱ��',
  `STATUS` int(2) NOT NULL DEFAULT '0' COMMENT '����״̬��0 ���ڵ��� 1 ������� Ĭ��Ϊ0',
  `DESCRIPTION` varchar(512) DEFAULT NULL COMMENT '����',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '�޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_IMPORT_LOG_ID` (`ID`),
  KEY `INDEX_STATUS` (`STATUS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='������־';

-- ----------------------------
-- Table structure for `lead`
-- ----------------------------
DROP TABLE IF EXISTS `lead`;
CREATE TABLE `lead` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '����ID ',
  `OWNER` int(11) NOT NULL DEFAULT '0' COMMENT '����������',
  `COMPANY` varchar(64) NOT NULL DEFAULT '' COMMENT '��˾����',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '��������',
  `DEPARTMENT` varchar(64) NOT NULL DEFAULT '' COMMENT '����',
  `POSITION` varchar(64) NOT NULL DEFAULT '' COMMENT 'ְλ',
  `EMAIL` varchar(64) NOT NULL DEFAULT '' COMMENT '����',
  `PHONE` varchar(32) NOT NULL DEFAULT '' COMMENT '�绰',
  `FAX` varchar(32) NOT NULL DEFAULT '' COMMENT '����',
  `MOBILE` varchar(32) NOT NULL DEFAULT '' COMMENT '�ֻ�',
  `SOURCE` int(11) NOT NULL DEFAULT '0' COMMENT '������Դ',
  `STATUS` int(11) NOT NULL DEFAULT '0' COMMENT '����״̬',
  `CARD_TYPE` int(11) NOT NULL DEFAULT '0' COMMENT '֤������',
  `CARD_NUM` varchar(64) NOT NULL DEFAULT '' COMMENT '֤������',
  `INDUSTRY` int(11) NOT NULL DEFAULT '0' COMMENT '��ҵ',
  `POST_CODE` varchar(16) NOT NULL DEFAULT '' COMMENT '�ʱ�',
  `PROVINCE` int(11) DEFAULT '0' COMMENT 'ʡ��',
  `CITY` int(11) DEFAULT '0' COMMENT '����',
  `COUNTY` int(11) DEFAULT '0' COMMENT '��/��',
  `ADDRESS` varchar(256) NOT NULL DEFAULT '' COMMENT '��ϸ��ַ',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '��ע',
  `IS_DELETED` int(11) DEFAULT '0',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '�޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_OWNER` (`OWNER`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_PHONE` (`PHONE`),
  KEY `INDEX_MOBILE` (`MOBILE`),
  KEY `INDEX_STATUS` (`STATUS`),
  KEY `INDEX_CREATER_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='����';

-- ----------------------------
-- Table structure for `market_activity`
-- ----------------------------
DROP TABLE IF EXISTS `market_activity`;
CREATE TABLE `market_activity` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '�����',
  `TYPE_DIC` int(4) DEFAULT NULL COMMENT '�����',
  `STATUS_DIC` int(4) DEFAULT NULL COMMENT '�״̬',
  `BEGIN_DATE` datetime NOT NULL COMMENT '��ʼ����',
  `END_DATE` datetime NOT NULL COMMENT '��������',
  `PREDICT_COST` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT 'Ԥ�Ƴɱ�',
  `REALITY_COST` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT 'ʵ�ʳɱ�',
  `TIMES` int(4) NOT NULL DEFAULT '0' COMMENT '�����',
  `EXPECT_EFFECT` varchar(256) DEFAULT '' COMMENT 'Ԥ��Ч��',
  `EXPECT_SUCCESS_RATE` float(6,2) DEFAULT '0.00' COMMENT '�����ɹ���',
  `SPONSOR` int(11) NOT NULL DEFAULT '0' COMMENT '������',
  `BOSSHEAD` int(11) NOT NULL DEFAULT '0' COMMENT '������',
  `REMARK` varchar(512) DEFAULT '' COMMENT '��ע',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT 'ɾ�����',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '�޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ACTIVITY_STATUS` (`STATUS_DIC`),
  KEY `INDEX-CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX-MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�г��';

-- ----------------------------
-- Table structure for `memoir`
-- ----------------------------
DROP TABLE IF EXISTS `memoir`;
CREATE TABLE `memoir` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '��ҪID',
  `MODULE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '����ģ��ID',
  `RECORD_ID` int(11) NOT NULL DEFAULT '0' COMMENT '����ģ���ڼ�¼��ID',
  `ORG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '��֯ID',
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�û�ID',
  `SUMMARY` varchar(1024) DEFAULT '' COMMENT '��Ҫ����',
  `NEXTCONTACTTIME` datetime DEFAULT NULL COMMENT '�´���ϵʱ��',
  `NEXTCONTACTPOINTS` varchar(1024) DEFAULT NULL COMMENT '�´���ϵҪ��',
  `REMARK` varchar(512) DEFAULT '' COMMENT '��ע',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '���ɾ��',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '�޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ID` (`ID`),
  KEY `INDEX_TYPE` (`MODULE_ID`),
  KEY `INDEX_MODULE_ID` (`RECORD_ID`),
  KEY `INDEX_EMPLOYEE_ID` (`USER_ID`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��ͨ��Ҫ';

-- ----------------------------
-- Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `ID` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `TITLE` varchar(255) NOT NULL DEFAULT '' COMMENT '����',
  `CONTENT` text NOT NULL COMMENT '����',
  `SENT_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `DEAD_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `IS_DELETED` tinyint(6) NOT NULL DEFAULT '0' COMMENT '�Ƿ�ɾ��',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='ϵͳ�����';

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `PRODUCT_ID` int(4) NOT NULL DEFAULT '0' COMMENT '��ƷID',
  `CUSTOMER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '�ͻ�ID',
  `CODE` varchar(32) NOT NULL COMMENT '�������',
  `STATUS` int(4) NOT NULL DEFAULT '0' COMMENT '����״̬',
  `INVESTMENT_WAY` int(4) NOT NULL DEFAULT '0' COMMENT 'Ͷ�ʷ�ʽ',
  `PURCHASE_MONEY` decimal(10,4) NOT NULL COMMENT '������',
  `EARNING_RATE` float(10,0) NOT NULL COMMENT '������',
  `ADVANCE_REDEEM_RATE` float(10,0) NOT NULL COMMENT '��ǰ�����',
  `REDEEM_FORMULA` varchar(128) NOT NULL COMMENT '��ع�ʽ',
  `OWNER` int(4) NOT NULL DEFAULT '0' COMMENT '������Ա',
  `SALES_MANAGER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '���۾���',
  `SALES_MAJORDOMO_ID` int(4) NOT NULL DEFAULT '0' COMMENT '�����ܼ�',
  `ORDER_END_TIME` datetime NOT NULL COMMENT '��������ʱ��',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '��ע',
  `IS_DELETED` int(4) DEFAULT '0' COMMENT 'ɾ����ʶ',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`),
  KEY `INDEX_PRODUCT_ID` (`PRODUCT_ID`),
  KEY `INDEX_ACCOUNT_ID` (`CUSTOMER_ID`),
  KEY `INDEX_SALES_PERSON_ID` (`OWNER`),
  KEY `INDEX_SALES_MANAGER_ID` (`SALES_MANAGER_ID`),
  KEY `INDEX_SALES_MAJORDOMO_ID` (`SALES_MAJORDOMO_ID`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='������';

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '��Ʒ����',
  `CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '��Ʒ���',
  `PROJECT_ID` int(4) NOT NULL DEFAULT '0' COMMENT '��ĿID',
  `TYPE_DIC` int(4) DEFAULT '0' COMMENT '����',
  `START_SELL_MONEY` decimal(10,4) DEFAULT '0.0000' COMMENT '���۽��',
  `ERNING_RATE` decimal(10,4) DEFAULT '0.0000' COMMENT '��С����',
  `EXPECT_PROFIT` decimal(10,4) DEFAULT '0.0000' COMMENT 'Ԥ������',
  `SALE_LIMIT` int(4) DEFAULT '0' COMMENT '��������',
  `SALE_UNIT_DIC` int(4) DEFAULT '0' COMMENT '���۵�λ',
  `SALE_BEGIN_TIME` datetime DEFAULT NULL COMMENT '���ۿ�ʼ����',
  `SALE_END_TIME` datetime DEFAULT NULL COMMENT '���۽�������',
  `ADVANCE_REDEEM_RATE` decimal(10,4) DEFAULT NULL COMMENT '��ǰ�����',
  `ADVANCE_REDEEM_FORMULA` varchar(216) DEFAULT '' COMMENT '��ǰ��ع�ʽ',
  `IS_EFFECT` char(1) DEFAULT '1' COMMENT '�Ƿ���Ч',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '���ɾ��',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '��ע',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`),
  KEY `INDEX_PROJECT_ID` (`PROJECT_ID`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��Ʒ��';

-- ----------------------------
-- Table structure for `project`
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `SUPPLIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '��Ӧ��ID',
  `CODE` varchar(64) NOT NULL DEFAULT '' COMMENT '��Ŀ���',
  `NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '��Ŀ����',
  `FINANCE_LIMIT` float(10,0) NOT NULL DEFAULT '0' COMMENT '���ʶ��',
  `BEGIN_TIME` datetime NOT NULL COMMENT '��ʼʱ��',
  `BEFORE_FINANCE_CYCLE` int(4) NOT NULL DEFAULT '0' COMMENT '����ǰ����(��)',
  `FINANCE_CYCLE` int(4) NOT NULL DEFAULT '0' COMMENT '��������',
  `OPEN_TIME` datetime NOT NULL COMMENT '������',
  `DENDLINE_TIME` datetime NOT NULL COMMENT '��ֹʱ��',
  `EARNING_RATE` float(10,0) NOT NULL DEFAULT '0' COMMENT '������',
  `ADVANCE_REDEEM_RATE` float(10,0) NOT NULL DEFAULT '0' COMMENT '��ǰ�����',
  `PAY_TYPE` int(11) NOT NULL DEFAULT '0' COMMENT '֧����ʽ',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '��ע',
  `IS_DELETED` int(11) DEFAULT '0',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '�����޸�ʱ��',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`) USING BTREE,
  KEY `INDEX_SUPPLIER_ID` (`SUPPLIER_ID`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��Ŀ��';

-- ----------------------------
-- Table structure for `pro_city_area`
-- ----------------------------
DROP TABLE IF EXISTS `pro_city_area`;
CREATE TABLE `pro_city_area` (
  `ID` int(4) NOT NULL COMMENT '����ID',
  `NAME` varchar(32) NOT NULL COMMENT '����',
  `PID` int(4) DEFAULT NULL COMMENT '����ID',
  PRIMARY KEY (`ID`),
  KEY `INDEX_PID` (`PID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ʡ��������������';

-- ----------------------------
-- Table structure for `report`
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `CODE` varchar(32) NOT NULL COMMENT '����ֵ',
  `NAME` varchar(62) NOT NULL COMMENT '������',
  `MODULE_ID` int(11) NOT NULL COMMENT '����ģ���������',
  `X_FIELD_NAME` varchar(32) NOT NULL COMMENT 'X���ֶ���',
  `X_TYPE_ID` int(11) NOT NULL COMMENT 'X���������',
  `Y_FIELD_NAME` varchar(32) NOT NULL COMMENT 'Y���ֶ���',
  `Y_TYPE_ID` int(11) NOT NULL COMMENT 'Y���������',
  `Z_FIELD_NAME` varchar(32) DEFAULT NULL COMMENT 'Z���ֶ���',
  `Z_TYPE_ID` int(11) DEFAULT NULL COMMENT 'Z���������',
  `CHART_ID` int(11) NOT NULL COMMENT 'ͼ������',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '��ע',
  `CREATOR_ID` int(11) NOT NULL COMMENT '�������������',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL COMMENT '�޸����������',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '�޸�ʱ��',
  `IS_DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '���Ǳ�ɾ��',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '���ǳ�ʼ������',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='�����';

-- ----------------------------
-- Table structure for `sales_target`
-- ----------------------------
DROP TABLE IF EXISTS `sales_target`;
CREATE TABLE `sales_target` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `ORG_ID` int(4) NOT NULL DEFAULT '0' COMMENT '����id',
  `BARGAIN_MONEY` decimal(10,4) DEFAULT NULL COMMENT 'Ŀ��ɽ����',
  `UNIT_DIC` int(4) DEFAULT '0' COMMENT '1��� 2�·� 3����',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '��ע',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '�޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ORG_ID` (`ORG_ID`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='����Ŀ���';

-- ----------------------------
-- Table structure for `sm_audit_log`
-- ----------------------------
DROP TABLE IF EXISTS `sm_audit_log`;
CREATE TABLE `sm_audit_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `MODULE_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT 'ģ������',
  `RECORD_ID` int(11) DEFAULT '0' COMMENT '��¼ID',
  `RECORD_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '��¼����',
  `TYPE` int(11) NOT NULL DEFAULT '0' COMMENT '��������',
  `REMARK` varchar(64) DEFAULT NULL COMMENT '��ע',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_USER_ID` (`CREATOR_ID`),
  KEY `INDEX_MODULE_NAME` (`MODULE_NAME`) USING BTREE,
  KEY `INDEX_TYPE` (`TYPE`),
  KEY `INDEX_CREATED_TIME` (`CREATED_TIME`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='�����־��';

-- ----------------------------
-- Table structure for `sm_component`
-- ----------------------------
DROP TABLE IF EXISTS `sm_component`;
CREATE TABLE `sm_component` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '������',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '�������',
  `URL` varchar(64) NOT NULL DEFAULT '' COMMENT '����������',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '��ע',
  `PRIVILEGE_LEVEL_ID` int(11) NOT NULL COMMENT 'Ȩ�޼���',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT 'ɾ����־',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '1' COMMENT '�Ƿ��ʼ������',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_CODE` (`CODE`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_URL` (`URL`) USING BTREE,
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=990111 DEFAULT CHARSET=utf8 COMMENT='�����';

-- ----------------------------
-- Table structure for `sm_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `sm_dictionary`;
CREATE TABLE `sm_dictionary` (
  `ID` bigint(20) NOT NULL DEFAULT '0',
  `KEY` varchar(64) NOT NULL DEFAULT '',
  `VALUE` varchar(64) NOT NULL DEFAULT '',
  `PARENT_ID` int(11) DEFAULT '0',
  `LEVEL` int(11) DEFAULT NULL,
  `ORDER` int(11) DEFAULT NULL,
  `TYPE` varchar(64) DEFAULT NULL,
  `IS_ACTIVE` int(11) DEFAULT '1',
  `REMARK` varchar(512) NOT NULL DEFAULT '',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT '���ɾ��',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '1',
  `CREATOR_ID` int(10) unsigned DEFAULT '0',
  `CREATED_TIME` datetime NOT NULL,
  `MODIFIER_ID` int(11) DEFAULT '0',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�����ֵ��';

-- ----------------------------
-- Table structure for `sm_function`
-- ----------------------------
DROP TABLE IF EXISTS `sm_function`;
CREATE TABLE `sm_function` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `MENU_ID` int(11) DEFAULT NULL COMMENT '�����˵�',
  `CODE` varchar(32) DEFAULT NULL COMMENT '���ܱ��',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '��������',
  `URL` varchar(64) DEFAULT NULL COMMENT '�������',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '��ע',
  `IS_DELETED` int(11) DEFAULT '0' COMMENT 'ɾ����־',
  `PRIVILEGE_LEVEL_ID` int(11) DEFAULT '0' COMMENT ' Ȩ�޼���',
  `PARENT_ID` int(11) DEFAULT NULL COMMENT '������',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '1' COMMENT '�Ƿ��ʼ������',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '�޸�ʱ��',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_URL` (`URL`),
  KEY `INDEX_MENU_ID` (`MENU_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_CODE` (`CODE`) USING BTREE,
  KEY `INDEX_NAME` (`NAME`) USING BTREE,
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=140111 DEFAULT CHARSET=utf8 COMMENT='���ܱ�';

-- ----------------------------
-- Table structure for `sm_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sm_menu`;
CREATE TABLE `sm_menu` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '�����ű�',
  `NAME` varchar(32) NOT NULL COMMENT '�˵�����',
  `URL` varchar(64) DEFAULT NULL COMMENT '���ӵ�ַ',
  `SHOW_LOCATION_TYPE` int(11) DEFAULT NULL COMMENT '��ʾλ��',
  `DEFAULT_SHOW` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Ĭ����ʾ',
  `TRIGGER_ID` int(11) DEFAULT NULL COMMENT '��������',
  `IS_ACTIVE` tinyint(1) NOT NULL COMMENT '�Ƿ񼤻��',
  `LEVEL` int(11) NOT NULL COMMENT '����',
  `IS_LEAF` tinyint(1) NOT NULL COMMENT 'Ҷ�ӽڵ�',
  `PARENT_MENU_ID` int(11) DEFAULT NULL COMMENT '�ϼ��˵�',
  `ORDER` int(11) NOT NULL COMMENT '���',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '��ע',
  `IS_DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '���Ǳ�ɾ��',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '�Ƿ��ʼ������',
  `CREATOR_ID` int(11) NOT NULL COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_CREAOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_ORDER` (`ORDER`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='�˵���';

-- ----------------------------
-- Table structure for `sm_module`
-- ----------------------------
DROP TABLE IF EXISTS `sm_module`;
CREATE TABLE `sm_module` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `NAME` varchar(32) NOT NULL COMMENT '����',
  `DESC` varchar(32) NOT NULL COMMENT '����',
  `ENTITY_CLASS` varchar(256) NOT NULL COMMENT '����ʵ����',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='ģ���';


-- ----------------------------
-- Table structure for `sm_module_type`
-- ----------------------------
DROP TABLE IF EXISTS `sm_module_type`;
CREATE TABLE `sm_module_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '�������',
  `TYPE_ID` int(11) NOT NULL COMMENT '���ͱ��',
  `MODULE_ID` int(11) NOT NULL COMMENT 'ģ����',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_TYPE_ID_MODULE_ID` (`TYPE_ID`,`MODULE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='ģ�����ͱ�\r\nע�⣺���ͱ�ź�ģ����Ϊ���ϵ�Ψһ��\r\n';

-- ----------------------------
-- Table structure for `sm_org`
-- ----------------------------
DROP TABLE IF EXISTS `sm_org`;
CREATE TABLE `sm_org` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '�������',
  `SHORT_NAME` varchar(64) NOT NULL COMMENT '�������',
  `FULL_NAME` varchar(128) NOT NULL COMMENT '����ȫ��',
  `TYPE` int(11) NOT NULL COMMENT '���� 1��˾ 2���� 3��',
  `PHONE` varchar(32) DEFAULT NULL COMMENT '�ֻ�����',
  `EMAIL` varchar(32) DEFAULT NULL COMMENT '����',
  `ADDRESS` varchar(512) DEFAULT NULL COMMENT '��ַ',
  `ZIP_CODE` varchar(32) DEFAULT NULL COMMENT '��������',
  `WEB_SITE` varchar(64) DEFAULT NULL COMMENT 'վ��',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '��ע',
  `LEVEL` int(11) NOT NULL COMMENT '��',
  `IS_LEAF` tinyint(1) NOT NULL COMMENT 'Ҷ�ӽڵ�',
  `PARENT_ORG_ID` int(11) DEFAULT NULL COMMENT '�ϼ���֯�������',
  `ORDER` int(11) NOT NULL COMMENT '���',
  `IS_DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '�Ƿ�ɾ��',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '���ǳ�ʼ������',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_FULL_NAME` (`FULL_NAME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_SHORT_NAME` (`SHORT_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='������';

-- ----------------------------
-- Table structure for `sm_org_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_org_role`;
CREATE TABLE `sm_org_role` (
  `ORG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '��֯ID',
  `ROLE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '��ɫID',
  PRIMARY KEY (`ORG_ID`,`ROLE_ID`),
  KEY `INDEX_ORG_ID` (`ORG_ID`),
  KEY `INDEX_ROLE_ID` (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='֯���ɫ������';


-- ----------------------------
-- Table structure for `sm_position`
-- ----------------------------
DROP TABLE IF EXISTS `sm_position`;
CREATE TABLE `sm_position` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '��λ���',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '��λ����',
  `PARENT_POS_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�ϼ���λID',
  `PARTY_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������֯ID',
  `SORT_NO` int(11) NOT NULL DEFAULT '0' COMMENT '����˳��',
  `STATUS` int(11) NOT NULL DEFAULT '0' COMMENT '��λ״̬',
  `REMARK` varchar(215) NOT NULL DEFAULT '' COMMENT '��ע',
  `CREATEOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '�޸�ʱ��',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '����޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_NO` (`CODE`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_CREATEOR_ID` (`CREATEOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��λ��';

-- ----------------------------
-- Table structure for `sm_recyclebin`
-- ----------------------------
DROP TABLE IF EXISTS `sm_recyclebin`;
CREATE TABLE `sm_recyclebin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `MODULE_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT 'ģ������',
  `RECORD_ID` int(11) NOT NULL DEFAULT '0' COMMENT '��¼ID',
  `RECORD_NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '��¼��',
  `REMARK` varchar(64) DEFAULT NULL COMMENT '��ע',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_USER_ID` (`CREATOR_ID`),
  KEY `INDEX_MODULE_NAME` (`MODULE_NAME`) USING BTREE,
  KEY `INDEX_CREATED_TIME` (`CREATED_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='����վ��';

-- ----------------------------
-- Table structure for `sm_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role`;
CREATE TABLE `sm_role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `CODE` varchar(32) DEFAULT NULL COMMENT '��ɫ����',
  `NAME` varchar(16) DEFAULT NULL COMMENT '��ɫ��',
  `TYPE` int(11) NOT NULL DEFAULT '0' COMMENT '��ɫ����',
  `REMARK` varchar(255) NOT NULL DEFAULT '' COMMENT '��ע',
  `IS_DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '�Ƿ�ɾ��',
  `IS_INITIALIZED` int(11) NOT NULL DEFAULT '0' COMMENT '�Ƿ��ǳ�ʼ������',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL COMMENT '�޸���',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_NAME` (`NAME`),
  UNIQUE KEY `INDEX_CODE` (`CODE`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='��ɫ��';

-- ----------------------------
-- Table structure for `sm_role_com`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role_com`;
CREATE TABLE `sm_role_com` (
  `ROLE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '��ɫID',
  `COM_ID` int(11) NOT NULL DEFAULT '0' COMMENT '���ID',
  PRIMARY KEY (`ROLE_ID`,`COM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��ɫ�����';

-- ----------------------------
-- Table structure for `sm_role_func`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role_func`;
CREATE TABLE `sm_role_func` (
  `ROLE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '��ɫID',
  `FUNC_ID` int(11) NOT NULL DEFAULT '0' COMMENT '����ID',
  PRIMARY KEY (`ROLE_ID`,`FUNC_ID`),
  KEY `INDEX_ROLE_ID` (`ROLE_ID`),
  KEY `INDEX_FUNC_ID` (`FUNC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��ɫ���ܱ�';

-- ----------------------------
-- Table structure for `sm_user`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user`;
CREATE TABLE `sm_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '�������',
  `LOGIN_NAME` varchar(32) NOT NULL COMMENT '��¼��',
  `PASSWORD` varchar(64) NOT NULL COMMENT '����',
  `USER_NAME` varchar(32) NOT NULL COMMENT '��ʵ����',
  `SEX_ID` int(11) NOT NULL COMMENT '�Ա�',
  `PHONE` varchar(32) DEFAULT NULL COMMENT '�绰����',
  `MOBILE` varchar(32) DEFAULT NULL COMMENT '�ֻ�����',
  `EMAIL` varchar(32) DEFAULT NULL COMMENT '����',
  `QQ` varchar(16) DEFAULT NULL COMMENT 'QQ',
  `JOB_NAME` varchar(64) DEFAULT NULL COMMENT 'ְλ',
  `JOB_SITUATION_ID` int(11) NOT NULL COMMENT 'ְλ״̬',
  `IS_MANAGER` int(11) NOT NULL COMMENT '���ǹ���Ա',
  `IS_ACTIVE` char(1) NOT NULL DEFAULT '1' COMMENT '�Ƿ����� 1���� 0����',
  `ORGANIZATION_ID` int(11) NOT NULL COMMENT '������֯',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '��ע',
  `STORE_STATUS_ID` int(11) NOT NULL COMMENT '���ݴ洢״̬',
  `IS_DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '���Ǳ�ɾ��',
  `IS_INITIALIZED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '�Ƿ��ʼ������',
  `CREATOR_ID` int(11) NOT NULL COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_LOGIN_NAME` (`LOGIN_NAME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='�û���';

-- ----------------------------
-- Table structure for `sm_user_com`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_com`;
CREATE TABLE `sm_user_com` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�û�ID',
  `COM_ID` int(11) NOT NULL DEFAULT '0' COMMENT '���ID',
  PRIMARY KEY (`USER_ID`,`COM_ID`),
  KEY `INDEX_USER_ID` (`USER_ID`),
  KEY `INDEX_COM_ID` (`COM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�û������';

-- ----------------------------
-- Table structure for `sm_user_func`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_func`;
CREATE TABLE `sm_user_func` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�û�ID',
  `FUNC_ID` int(11) NOT NULL DEFAULT '0' COMMENT '����ID',
  PRIMARY KEY (`USER_ID`,`FUNC_ID`),
  KEY `INDEX_USER_ID` (`USER_ID`),
  KEY `INDEX_FUNC_ID` (`FUNC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�û������� ��Ӧ��ϵ��';

-- ----------------------------
-- Table structure for `sm_user_org`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_org`;
CREATE TABLE `sm_user_org` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�û�ID',
  `ORG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '����ID',
  PRIMARY KEY (`USER_ID`,`ORG_ID`),
  KEY `INDEX_USER_ID` (`USER_ID`),
  KEY `INDEX_ORG_ID` (`ORG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�û�������';

-- ----------------------------
-- Table structure for `sm_user_position`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_position`;
CREATE TABLE `sm_user_position` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�û�ID',
  `POS_ID` int(11) NOT NULL DEFAULT '0' COMMENT '��λID',
  `CREATOR_ID` int(11) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX-USER_ID` (`USER_ID`),
  KEY `INDEX_POS_ID` (`POS_ID`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�û���λ������';

-- ----------------------------
-- Table structure for `sm_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_role`;
CREATE TABLE `sm_user_role` (
  `USER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '�û�ID',
  `ROLE_ID` int(4) NOT NULL DEFAULT '0' COMMENT '��ɫID',
  PRIMARY KEY (`USER_ID`,`ROLE_ID`),
  KEY `INDEX_ROLE_ID` (`ROLE_ID`) USING BTREE,
  KEY `INDEX_USER_ID` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�û���ɫ������';

-- ----------------------------
-- Table structure for `sm_workbanch`
-- ----------------------------
DROP TABLE IF EXISTS `sm_workbanch`;
CREATE TABLE `sm_workbanch` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `URL` varchar(64) NOT NULL,
  `TITLE` varchar(64) NOT NULL DEFAULT '' COMMENT '����',
  `MODULE` varchar(64) NOT NULL DEFAULT '' COMMENT 'ģ��',
  `TYPE` varchar(64) NOT NULL DEFAULT '' COMMENT '����',
  `WIDTH` varchar(64) NOT NULL DEFAULT '' COMMENT '���',
  `PARAMS` varchar(64) NOT NULL DEFAULT '' COMMENT '����',
  `OWNER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '������',
  `ORDER_INDEX` int(4) NOT NULL DEFAULT '0' COMMENT '�����ʶ',
  `IS_DELETED` int(4) NOT NULL DEFAULT '0' COMMENT 'ɾ����ʶ',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '�޸�ʱ��',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='����̨';

-- ----------------------------
-- Table structure for `supplier`
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `NAME` varchar(64) NOT NULL DEFAULT '' COMMENT '��Ӧ����',
  `TYPE` int(4) NOT NULL DEFAULT '0' COMMENT '��Ӧ�̷���',
  `CORPORATION` varchar(64) NOT NULL DEFAULT '' COMMENT '���˴���',
  `OWNER` int(11) NOT NULL DEFAULT '0' COMMENT '������',
  `PHONE` varchar(32) NOT NULL DEFAULT '' COMMENT '�绰',
  `MOBILE` varchar(32) NOT NULL DEFAULT '' COMMENT '�ֻ�',
  `CARD_NUM` varchar(64) NOT NULL DEFAULT '' COMMENT '֤������',
  `CARD_TYPE` int(11) DEFAULT NULL COMMENT '֤������',
  `FAX` varchar(32) NOT NULL DEFAULT '' COMMENT '����',
  `PROVINCE` varchar(32) DEFAULT NULL COMMENT 'ʡ��',
  `CITY` varchar(32) DEFAULT NULL COMMENT '����',
  `COUNTY` varchar(32) DEFAULT NULL COMMENT '��/��',
  `EMAIL` varchar(32) NOT NULL DEFAULT '' COMMENT '����',
  `ADDRESS` varchar(512) NOT NULL DEFAULT '' COMMENT '��ϸ��ַ',
  `REMARK` varchar(512) NOT NULL DEFAULT '' COMMENT '��ע',
  `IS_DELETED` int(11) DEFAULT '0',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '�޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_NAME` (`NAME`),
  KEY `INDEX_TYPE` (`TYPE`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='��Ӧ��';

-- ----------------------------
-- Table structure for `sysmessage`
-- ----------------------------
DROP TABLE IF EXISTS `sysmessage`;
CREATE TABLE `sysmessage` (
  `ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `TITLE` varchar(64) NOT NULL DEFAULT '' COMMENT '����',
  `CONTENT` text NOT NULL COMMENT '����',
  `CREATOR_ID` int(4) NOT NULL DEFAULT '0' COMMENT '������ID',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `IS_DELETED` tinyint(6) NOT NULL DEFAULT '0' COMMENT '�Ƿ�ɾ��',
  `MODIFIER_ID` int(4) NOT NULL DEFAULT '0' COMMENT '�޸���ID',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '�޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_MODIFIED_TIME` (`MODIFIED_TIME`),
  KEY `INDEX_CREATOR_ID` (`CREATOR_ID`),
  KEY `INDEX_MODIFIER_ID` (`MODIFIER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ϵͳ��Ϣ';

-- ----------------------------
-- Table structure for `user_message`
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `MESSAGE_ID` int(11) NOT NULL COMMENT '������Ϣ',
  `USER_ID` int(11) NOT NULL COMMENT '�����û�',
  `STATUS` int(11) NOT NULL COMMENT '��ȡ״̬',
  `TYPE` smallint(6) NOT NULL COMMENT '��Ϣ���ͣ�����Ϣtrue�������Ϣfalse',
  `IS_DELETED` tinyint(6) NOT NULL DEFAULT '0' COMMENT '�Ƿ�ɾ��',
  `CREATED_TIME` datetime NOT NULL COMMENT '����ʱ��',
  `MODIFIED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',
  PRIMARY KEY (`ID`),
  KEY `INDEX_ID` (`ID`),
  KEY `INDEX_MESSAGE_ID` (`MESSAGE_ID`),
  KEY `INDEX_USER_ID` (`USER_ID`),
  KEY `INDEX_STATUS` (`STATUS`),
  KEY `INDEX_TYPE` (`TYPE`),
  KEY `INDEX_CREATED_TIME` (`CREATED_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ϵͳ��Ϣ���û�������';