/*
MySQL Data Transfer
Source Host: localhost
Source Database: hxtd
Target Host: localhost
Target Database: hxtd
Date: 2014/7/25 22:33:35
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for sm_module
-- ----------------------------
CREATE TABLE `sm_module` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(32) NOT NULL COMMENT '名称',
  `DESC` varchar(32) NOT NULL COMMENT '述描',
  `ENTITY_CLASS` varchar(256) NOT NULL COMMENT '关联实体类',
  `URL` varchar(64) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='模块表';

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `sm_module` VALUES ('1', 'marketActivity', '市场活动', 'com.baihui.hxtd.soa.market.entity.MarketActivity', '/market/marketActivity');
INSERT INTO `sm_module` VALUES ('2', 'lead', '线索', 'com.baihui.hxtd.soa.customer.entity.Lead', '/customer/lead');
INSERT INTO `sm_module` VALUES ('3', 'contact', '联系人', 'com.baihui.hxtd.soa.customer.entity.Contact', '/customer/contact');
INSERT INTO `sm_module` VALUES ('4', 'customer', '客户', 'com.baihui.hxtd.soa.customer.entity.Customer', '/customer/customer');
INSERT INTO `sm_module` VALUES ('5', 'supplier', '供应商', 'com.baihui.hxtd.soa.project.entity.Supplier', '/project/supplier');
INSERT INTO `sm_module` VALUES ('6', 'project', '项目', 'com.baihui.hxtd.soa.project.entity.Project', '/project/project');
INSERT INTO `sm_module` VALUES ('7', 'product', '产品', 'com.baihui.hxtd.soa.project.entity.Product', '/project/product');
INSERT INTO `sm_module` VALUES ('8', 'order', '订单', 'com.baihui.hxtd.soa.order.entity.Order', '/order/order');
INSERT INTO `sm_module` VALUES ('9', 'user', '用户', 'com.baihui.hxtd.soa.system.entity.User', '/system/user');
INSERT INTO `sm_module` VALUES ('10', 'role', '角色', 'com.baihui.hxtd.soa.system.entity.Role', '/system/role');
INSERT INTO `sm_module` VALUES ('11', 'menu', '菜单', 'com.baihui.hxtd.soa.system.entity.Menu', '/system/menu');
INSERT INTO `sm_module` VALUES ('12', 'function', '功能', 'com.baihui.hxtd.soa.system.entity.Function', '/system/function');
INSERT INTO `sm_module` VALUES ('13', 'component', '组件', 'com.baihui.hxtd.soa.system.entity.Component', '/system/component');
INSERT INTO `sm_module` VALUES ('14', 'organization', '组织', 'com.baihui.hxtd.soa.system.entity.Organization', '/system/organization');
INSERT INTO `sm_module` VALUES ('15', 'userMessage', '系统消息', 'com.baihui.hxtd.soa.system.entity.UserMessage', '/system/userMessage');
INSERT INTO `sm_module` VALUES ('16', 'notice', '系统公告', 'com.baihui.hxtd.soa.system.entity.Notice', '/system/notice');
INSERT INTO `sm_module` VALUES ('17', 'dictionary', '字典', 'com.baihui.hxtd.soa.system.entity.Dictionary', '/system/dictionary');
INSERT INTO `sm_module` VALUES ('18', 'auditLog', '审计日志', 'com.baihui.hxtd.soa.system.entity.AuditLog', '/system/auditLog');
INSERT INTO `sm_module` VALUES ('19', 'recycleBin', '回收站', 'com.baihui.hxtd.soa.system.entity.RecycleBin', '/system/recycleBin');
INSERT INTO `sm_module` VALUES ('20', 'attachment', '附件', 'com.baihui.hxtd.soa.common.entity.Attachment', '/common/attachment');
INSERT INTO `sm_module` VALUES ('21', 'memoir', '联系人纪要', 'com.baihui.hxtd.soa.common.entity.Memoir', '/common/memoir');
