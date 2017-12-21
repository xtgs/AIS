/*
 Navicat MySQL Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50710
 Source Host           : localhost
 Source Database       : ais

 Target Server Type    : MySQL
 Target Server Version : 50710
 File Encoding         : utf-8

 Date: 12/21/2017 17:26:17 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `charge`
-- ----------------------------
DROP TABLE IF EXISTS `charge`;
CREATE TABLE `charge` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `pid` varchar(255) NOT NULL,
  `uid` varchar(255) NOT NULL,
  `iid` int(11) DEFAULT NULL,
  `original_price` decimal(10,2) DEFAULT '0.00',
  `discount` decimal(10,2) DEFAULT '10.00',
  `real_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `isdel` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `after_balance` decimal(10,2) NOT NULL,
  `trade_type` varchar(255) NOT NULL DEFAULT '1' COMMENT '交易类型，1位收费，2为充值',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=100002 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `charge`
-- ----------------------------
BEGIN;
INSERT INTO `charge` VALUES ('1', '1234567890', 'u170811002', null, null, null, '10.00', '0', null, '2017-12-19 15:17:01', '10.00', '1'), ('2', '1234567890', 'u170811002', null, null, null, '5.00', '0', null, '2017-12-19 23:10:11', '55.00', '1'), ('3', '1234567890', 'u170811002', null, null, null, '1.02', '0', null, '2017-12-19 23:13:40', '54.00', '1'), ('4', '1234567890', 'u170811002', null, null, null, '1.11', '0', null, '2017-12-19 23:14:49', '52.85', '1'), ('5', '111', 'u171107025', null, null, null, '2.30', '0', null, '2017-12-20 00:08:39', '97.70', '1'), ('6', '1234567890', 'u170811002', null, null, null, '2.00', '0', null, '2017-12-20 16:09:39', '50.85', '1'), ('100000', '111', 'u170811002', null, null, null, '20.00', '0', null, '2017-12-20 23:22:24', '88.70', '1'), ('100001', '1', 'u170811002', null, null, null, '2.00', '0', null, '2017-12-21 17:20:22', '12.00', '1');
COMMIT;

-- ----------------------------
--  Table structure for `codemap`
-- ----------------------------
DROP TABLE IF EXISTS `codemap`;
CREATE TABLE `codemap` (
  `codeid` varchar(20) NOT NULL COMMENT '字典的id',
  `codename` varchar(100) DEFAULT NULL COMMENT '字典的名称',
  `codevalue` varchar(10) NOT NULL COMMENT '字典id对应的值',
  `codetext` varchar(255) DEFAULT NULL COMMENT '字典值对应的文本',
  PRIMARY KEY (`codeid`,`codevalue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `codemap`
-- ----------------------------
BEGIN;
INSERT INTO `codemap` VALUES ('gender', '性别', '1', '男'), ('gender', '性别', '2', '女'), ('usertype', '后台用户类型', '1', '医师'), ('usertype', '后台用户类型', '2', '管理员'), ('usertype', '后台用户类型', '3', '主任');
COMMIT;

-- ----------------------------
--  Table structure for `item`
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `iid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `patient`
-- ----------------------------
DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient` (
  `pid` int(11) NOT NULL,
  `card_id` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `birthday` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `isdel` varchar(255) NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `create_date` datetime NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `patient`
-- ----------------------------
BEGIN;
INSERT INTO `patient` VALUES ('0', '123456199212120000', 'aa', '1992-12-12', '12345678901', '2', '0', '1015.11', '2017-12-12 14:52:27', null), ('1', '333333199912120000', '1', '1999-12-12', '1', '2', '0', '12.00', '2017-12-12 15:14:01', null), ('2', '2', '2', '', '2', '1', '1', '11.00', '2017-12-12 15:15:58', null), ('111', '111', '111', null, '111', '2', '0', '90.70', '2017-12-12 14:42:46', '111'), ('1234567890', '370983199109091234', '王小王', '2017-11-06', '12345678901', '1', '0', '61.85', '2017-11-15 10:23:19', 'a'), ('2134567890', '2', 'b', '1991-08-14', 'b', 'b', '0', '3.00', '2017-12-12 16:37:40', null);
COMMIT;

-- ----------------------------
--  Table structure for `sequence`
-- ----------------------------
DROP TABLE IF EXISTS `sequence`;
CREATE TABLE `sequence` (
  `seq_name` varchar(50) NOT NULL COMMENT '序列名称',
  `current_val` int(5) unsigned NOT NULL COMMENT '序列当前值',
  `increment_val` int(1) NOT NULL DEFAULT '1' COMMENT '序列默认不长',
  `max_val` int(6) NOT NULL COMMENT '当前序列的最大值，current_val达到最大值时，会从0再开始',
  PRIMARY KEY (`seq_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自动生成序列的表';

-- ----------------------------
--  Records of `sequence`
-- ----------------------------
BEGIN;
INSERT INTO `sequence` VALUES ('user_seq', '25', '1', '1000');
COMMIT;

-- ----------------------------
--  Table structure for `topup`
-- ----------------------------
DROP TABLE IF EXISTS `topup`;
CREATE TABLE `topup` (
  `tip` int(255) NOT NULL AUTO_INCREMENT,
  `pid` varchar(255) NOT NULL,
  `uid` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `isdel` varchar(255) NOT NULL,
  `after_balance` decimal(10,2) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `trade_type` varchar(255) NOT NULL DEFAULT '2' COMMENT '交易类型，1为收费，2为充值',
  PRIMARY KEY (`tip`)
) ENGINE=InnoDB AUTO_INCREMENT=200002 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `topup`
-- ----------------------------
BEGIN;
INSERT INTO `topup` VALUES ('1', '0', 'u170811002', '10.00', '0', '10.00', null, '2017-12-20 16:15:43', '2'), ('2', '1', 'u170811002', '1.00', '0', '11.00', null, '2017-12-20 16:20:47', '2'), ('3', '2134567890', 'u170811002', '2.00', '0', '3.00', null, '2017-12-20 16:23:26', '2'), ('4', '1', 'u170811002', '3.00', '0', '14.00', null, '2017-12-20 16:24:07', '2'), ('200000', '111', 'u170811002', '2.00', '0', '91.00', null, '2017-12-20 23:37:21', '2'), ('200001', '0', 'u170811002', '1.00', '0', '1015.11', null, '2017-12-20 23:40:48', '2');
COMMIT;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` varchar(10) NOT NULL COMMENT '主键。后台用户ID，分为两种身份，普通用户和管理员。生成规则：u+年+月+日+3位数字。例如：u170312001',
  `name` varchar(100) DEFAULT NULL COMMENT '用户姓名',
  `mphone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `password` varchar(50) DEFAULT NULL COMMENT '密码，密文存储。加密规则为：md5(uid+明文password)',
  `gender` varchar(1) DEFAULT NULL COMMENT '性别。1:男，2:女',
  `type` varchar(1) DEFAULT NULL COMMENT '人员类型。1:普通用户，2:管理员。',
  `loginname` varchar(100) DEFAULT NULL COMMENT '登录系统时的账户名称',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注信息',
  `isdel` varchar(1) DEFAULT '0' COMMENT '用户是否为已删除状态。1:已删除，0:正常状态。',
  `createdate` datetime DEFAULT NULL COMMENT '用户创建时间',
  `ugroup` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `card_id` varchar(255) DEFAULT NULL,
  `telphone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `index_loginname` (`loginname`) USING BTREE COMMENT '登录名唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台用户信息表。注意，type字段用于区分 当前用户是普通用户还是管理员。';

-- ----------------------------
--  Records of `user`
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('u170811002', 'admin', '17615850889', 'be039136a8b962cf0cbd3769a226f658', '1', '2', 'admin', '', '0', '2017-08-11 13:14:40', null, null, null, null), ('u170811003', '马领', '18625262395', 'ac163fedea89e83db335e0c3b572477a', '1', '1', 'maling', '', '0', '2017-08-11 13:27:22', null, null, null, null), ('u170811004', '陈琳', '11111112222', '478b39b2d75a831116c376d446c6b370', '2', '1', 'chenlin', '', '0', '2017-08-11 13:40:21', '网络客服组', '调控中心', null, null), ('u170816007', '郑海杰', '18769796133', 'c9f740067cd4d8f43ff364b8d51f2351', '1', '1', 'zhenghaijie', '', '0', '2017-08-16 23:13:32', null, null, null, null), ('u171019008', '李明', '15066652086', 'f73c4eeec6e9d1d061ce20b709ca20c6', '1', '3', 'liming', '', '0', '2017-10-19 11:17:56', '网络客服组', '调控中心', null, null), ('u171019009', '张欣', '18653178922', '8fdfc30081db9097eb88d9216938b548', '1', '3', 'zhangxin', '', '0', '2017-10-19 11:21:17', null, null, null, null), ('u171019010', '黄长江', '13506402261', '48121c172497bbccd099f03e5f4f9d37', '1', '3', 'huangchangjiang', '', '0', '2017-10-19 11:22:05', '网络客服组', '调控中心', null, null), ('u171019011', '孟鑫', '15550007616', 'a4dc8043bd9212c0f50445e8ede94d5c', '1', '1', 'mengxin', '', '0', '2017-10-19 11:23:00', '网络客服组', '调控中心', null, null), ('u171019012', '武书军', '18769758207', '2c1b8ad27cbd7effdb597e2bbc4c1e20', '1', '3', 'wushujun', '', '0', '2017-10-19 11:23:58', '网络客服组', '调控中心', null, null), ('u171019013', '郭小燕', '15806659262', 'cbdece3465503d8d53a8705c7d0bc59b', '1', '3', 'guoxiaoyan', '', '0', '2017-10-19 11:24:39', '网络客服组', '调控中心', null, null), ('u171019014', '王丞远', '13505310632', 'dc27dd7b4bec970e5c8e5f8c08578f32', '1', '3', 'wangchengyuan', '', '0', '2017-10-19 11:26:10', '调控组', '调控中心', null, null), ('u171019015', '王惠剑', null, 'e07712355e71de4f5a2629fd661998f2', '1', '1', null, '', '1', '2017-10-19 11:30:57', '网络客服组', '调控中心', null, null), ('u171020019', 'test', null, 'ce10f711aaf460eadb53dd45ba8f2f72', '1', '3', null, '', '1', '2017-10-20 17:09:18', 'aa', 'aaa', null, null), ('u171024022', 'a', null, '5625918b544a68a8912511788684af2f', '1', '1', null, '', '1', '2017-10-24 11:58:33', 'a', '运检中心', null, null), ('u171025023', '杨冠群', '12345678901', '5b279d969dd98f3b827934f9e3d9afa1', '1', '1', 'yangguanqun', '', '0', '2017-10-25 22:38:56', '', '调控中心', null, null), ('u171026024', 'b', null, '8dc2e7537d4cf69088ca8541c89d0bea', '1', '1', null, '', '1', '2017-10-26 09:34:54', 'b', 'b', null, null), ('u171107025', '王惠剑', '17615850889', '459d63ae80c4db3052c10f6ee767b40d', '1', '1', 'wanghuijian', '', '0', '2017-11-07 14:34:58', '网络客服组', '调控中心', null, null);
COMMIT;

-- ----------------------------
--  Function structure for `currval`
-- ----------------------------
DROP FUNCTION IF EXISTS `currval`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `currval`(v_seq_name VARCHAR(50)) RETURNS int(11)
begin     
    declare value integer;       
    set value = 0;       
    select current_val into value  from sequence where seq_name = v_seq_name; 
   return value; 
end
 ;;
delimiter ;

-- ----------------------------
--  Function structure for `getcodetxt`
-- ----------------------------
DROP FUNCTION IF EXISTS `getcodetxt`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getcodetxt`(p_codeid VARCHAR(20),p_codevalue varchar(10)) RETURNS varchar(255) CHARSET utf8
begin     
    declare value varchar(255);
    set value = '';       
    select codetext into value  from codemap where codeid = p_codeid and codevalue = p_codevalue; 
   return value; 
end
 ;;
delimiter ;

-- ----------------------------
--  Function structure for `getcodetxt_copy`
-- ----------------------------
DROP FUNCTION IF EXISTS `getcodetxt_copy`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getcodetxt_copy`(p_codeid VARCHAR(20),p_codevalue varchar(10)) RETURNS varchar(255) CHARSET utf8
begin     
    declare value varchar(255);
    set value = '';       
    select codetext into value  from codemap where codeid = p_codeid and codevalue = p_codevalue; 
   return value; 
end
 ;;
delimiter ;

-- ----------------------------
--  Function structure for `nextval`
-- ----------------------------
DROP FUNCTION IF EXISTS `nextval`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `nextval`(v_seq_name VARCHAR(50)) RETURNS int(11)
begin
    update sequence set current_val = (current_val + increment_val) % max_val  where seq_name = v_seq_name;
    return currval(v_seq_name);
end
 ;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
