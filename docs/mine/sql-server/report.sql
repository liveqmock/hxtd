/*
MySQL Data Transfer
Source Host: 192.168.111.141
Source Database: hxtd
Target Host: 192.168.111.141
Target Database: hxtd
Date: 2014/7/8 14:23:06
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for report
-- ----------------------------
CREATE TABLE `report` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(32) NOT NULL COMMENT '代码值',
  `NAME` varchar(62) NOT NULL COMMENT '报表名',
  `MODULE_ID` int(11) NOT NULL COMMENT '所属模块主键编号',
  `X_FIELD_NAME` varchar(32) NOT NULL COMMENT 'X_FIELD_NAME',
  `X_TYPE_ID` int(11) NOT NULL COMMENT 'X轴分组类型',
  `Y_FIELD_NAME` varchar(32) NOT NULL COMMENT 'Y轴字段名',
  `Y_TYPE_ID` int(11) NOT NULL COMMENT 'Y轴分组类型',
  `Z_FIELD_NAME` varchar(32) NOT NULL COMMENT 'Z轴字段名',
  `Z_TYPE_ID` int(11) NOT NULL COMMENT 'Z轴分组类型',
  `REMARK` varchar(512) NOT NULL,
   `CREATOR_ID` int(11) NOT NULL COMMENT '创建者主键编号',
  `CREATED_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFIER_ID` int(11) NOT NULL COMMENT '修改者主键编号',,
  `MODIFIED_TIME` timestamp NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报表表';

-- ----------------------------
-- Records 
-- ----------------------------
