/*
Navicat MySQL Data Transfer

Source Server         : 0m3ga.net
Source Server Version : 50087
Source Host           : 0m3ga.net:3306
Source Database       : fg42tuzx_perper

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2010-01-31 19:09:03
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `achievements`
-- ----------------------------
DROP TABLE IF EXISTS `achievements`;
CREATE TABLE `achievements` (
  `ID` text NOT NULL,
  `GMod Racer: Record Breaker` int(11) NOT NULL,
  `GMod Racer: Speed Demon` int(11) NOT NULL,
  `GMod Racer: Road Rage` int(11) NOT NULL,
  `GMod Racer: Destruction Derby` int(11) NOT NULL,
  `GMod Racer: Rolling the Rick` int(11) NOT NULL,
  `GMod Racer: Bomber` int(11) NOT NULL,
  `GMod Racer: Black Worshiper` int(11) NOT NULL,
  `Murder: Cold Blood` int(11) NOT NULL,
  `Murder: Framed` int(11) NOT NULL,
  `Murder: No Rest for the Wicked` int(11) NOT NULL,
  `Murder: Short Round` int(11) NOT NULL,
  `Murder: Wanna Be Cop` int(11) NOT NULL,
  `Murder: Ninja` int(11) NOT NULL,
  `Murder: Sharp Shooter` int(11) NOT NULL,
  `Murder: Last Stand` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for `admin_times`
-- ----------------------------
DROP TABLE IF EXISTS `admin_times`;
CREATE TABLE `admin_times` (
  `STEAMID` text NOT NULL,
  `NAME` text NOT NULL,
  `SERVER` text NOT NULL,
  `TIME` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of admin_times
-- ----------------------------

-- ----------------------------
-- Table structure for `bans`
-- ----------------------------
DROP TABLE IF EXISTS `bans`;
CREATE TABLE `bans` (
  `ID` char(100) character set latin1 NOT NULL,
  `NAME` char(100) character set latin1 NOT NULL,
  `UNBAN` int(100) NOT NULL default '0',
  `BANNER` char(100) character set latin1 default NULL,
  `REASON` char(100) character set latin1 default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bans
-- ----------------------------

-- ----------------------------
-- Table structure for `global_chat`
-- ----------------------------
DROP TABLE IF EXISTS `global_chat`;
CREATE TABLE `global_chat` (
  `server_id` text,
  `user_name` text,
  `message` text,
  `num` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1850 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of global_chat
-- ----------------------------

-- ----------------------------
-- Table structure for `logs`
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `TYPE` text,
  `TIME` text,
  `INFO` text,
  `ADMIN` text,
  `OPTIONAL` text,
  `SERVER` text
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of logs
-- ----------------------------

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `ID` char(50) NOT NULL,
  `NAME` char(50) NOT NULL,
  `RANK` int(11) NOT NULL default '5',
  PRIMARY KEY  (`NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of users
-- ----------------------------