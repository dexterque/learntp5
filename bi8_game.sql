/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : bi8_game

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 09/01/2019 09:09:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bonus
-- ----------------------------
DROP TABLE IF EXISTS `bonus`;
CREATE TABLE `bonus`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jid` int(11) NULL DEFAULT 0 COMMENT '期数id',
  `uid` int(11) NULL DEFAULT 0 COMMENT '用户id',
  `bonus` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '奖励金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bonus
-- ----------------------------
INSERT INTO `bonus` VALUES (1, 1, 1, '278.85');
INSERT INTO `bonus` VALUES (2, 1, 6, '0');
INSERT INTO `bonus` VALUES (3, 1, 8, '1589.25');
INSERT INTO `bonus` VALUES (4, 1, 9, '0');
INSERT INTO `bonus` VALUES (5, 1, 5, '0');

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `signed_stime` tinyint(1) NULL DEFAULT NULL,
  `signed_etime` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, NULL, NULL);

-- ----------------------------
-- Table structure for crap
-- ----------------------------
DROP TABLE IF EXISTS `crap`;
CREATE TABLE `crap`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jid` int(11) NULL DEFAULT 0 COMMENT '期数id',
  `uid` int(11) NULL DEFAULT 0 COMMENT '用户id',
  `crap_time` int(10) NULL DEFAULT 0 COMMENT '投注时间',
  `crap_money` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '投注金额',
  `crap_type` enum('small_single','small_double','big_double','big_single','small','big','single','double') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '投注类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of crap
-- ----------------------------
INSERT INTO `crap` VALUES (1, 1, 1, 1542879993, '143', 'single');
INSERT INTO `crap` VALUES (3, 1, 6, 1542880032, '501', 'small_double');
INSERT INTO `crap` VALUES (4, 1, 8, 1542880033, '815', 'big');
INSERT INTO `crap` VALUES (5, 1, 9, 1542880033, '634', 'double');
INSERT INTO `crap` VALUES (6, 1, 5, 1542880034, '875', 'small_single');

-- ----------------------------
-- Table structure for journal
-- ----------------------------
DROP TABLE IF EXISTS `journal`;
CREATE TABLE `journal`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stime` int(10) NULL DEFAULT 0 COMMENT '开始时间',
  `etime` int(10) NULL DEFAULT 0 COMMENT '结束时间',
  `lottery_number` tinyint(1) NULL DEFAULT -1 COMMENT '中奖号码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of journal
-- ----------------------------
INSERT INTO `journal` VALUES (1, 1542879900, 1542880195, 7);
INSERT INTO `journal` VALUES (2, 1542880500, 1542880795, 7);
INSERT INTO `journal` VALUES (3, 1542880800, 1542881095, 7);
INSERT INTO `journal` VALUES (4, 1542881100, 1542881395, 9);
INSERT INTO `journal` VALUES (5, 1542881400, 1542881695, 5);
INSERT INTO `journal` VALUES (6, 1542881700, 1542881995, 5);
INSERT INTO `journal` VALUES (7, 1542882000, 1542882295, 9);
INSERT INTO `journal` VALUES (8, 1542882300, 1542882595, 7);
INSERT INTO `journal` VALUES (9, 1542882600, 1542882895, -1);

-- ----------------------------
-- Table structure for movesay_coin
-- ----------------------------
DROP TABLE IF EXISTS `movesay_coin`;
CREATE TABLE `movesay_coin`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `img` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `sort` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `fee_bili` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `endtime` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `addtime` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `status` int(4) UNSIGNED NOT NULL DEFAULT 0,
  `dj_zj` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `dj_dk` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `dj_yh` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `dj_mm` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zr_zs` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zr_jz` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zr_dz` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zr_sm` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zc_sm` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zc_fee` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zc_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zc_min` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zc_max` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zc_jz` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zc_zd` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `js_yw` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `js_sm` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `js_qb` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `js_ym` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `js_gw` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `js_lt` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `js_wk` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cs_yf` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cs_sf` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cs_fb` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cs_qk` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cs_zl` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cs_cl` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cs_zm` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cs_nd` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cs_jl` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cs_ts` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cs_bz` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `tp_zs` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `tp_js` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `tp_yy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `tp_qj` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `rqb_dz` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '热钱包地址',
  `lqb_dz` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lqb_md5` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lqb_zcsl` int(11) NOT NULL,
  `last_prize` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '最新成交价',
  `min_fee` decimal(10, 6) NOT NULL DEFAULT 0.000000 COMMENT '最小网络手续费',
  `max_fee` decimal(10, 6) NOT NULL DEFAULT 0.000000 COMMENT '最大手续费',
  `norm_fee` decimal(10, 6) NOT NULL DEFAULT 0.000000 COMMENT '推荐手续费',
  `rqb_mm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '热钱包密码',
  `user_qbmm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户钱包密码',
  `total_amount` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '总金额',
  `is_push` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否开启集市交易（0关闭 1开启）',
  `push_min` int(11) NOT NULL DEFAULT 5 COMMENT 'push最低值',
  `coin_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '币种大致类型',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '智能合约地址',
  `transfer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易函数地址',
  `start_number` int(11) NULL DEFAULT NULL COMMENT '开始高度',
  `end_number` int(11) NULL DEFAULT NULL COMMENT '结束高度',
  `format` int(11) NULL DEFAULT NULL COMMENT '位数',
  `zc_rz_num` int(11) NULL DEFAULT NULL COMMENT '转出照片认证数量',
  `is_push_pay` tinyint(4) NULL DEFAULT 0 COMMENT '是否开启集市交易支付(0关闭 1.开启）',
  `exchange` tinyint(4) NULL DEFAULT NULL COMMENT '比例兑换',
  `is_out` tinyint(4) NULL DEFAULT NULL COMMENT '是否开启场外交易',
  `out_fee` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '场外交易手续费',
  `fid` int(11) NULL DEFAULT NULL COMMENT '比例对应匹配',
  `zc_max_num` int(11) NULL DEFAULT NULL COMMENT '每日转出最大数量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '币种配置表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of movesay_coin
-- ----------------------------
INSERT INTO `movesay_coin` VALUES (1, 'cny', 'rmb', '人民币', 'cny.png', 0, '', 0, 0, 0, '', '0', '', '', '0', '1', '0', '0', '0', '', '0', '', '', '1', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0.00000000, 0.000000, 0.000000, 0.000000, '0', '0', 0.00000000, 0, 5, '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO `movesay_coin` VALUES (2, 'btc', 'qbb', '比特币', '5939451f9140b.png', 0, '100', 0, 0, 1, '47.52.250.74', '23001', 'uadmin', 'padmin', '0', '1', '1', '', '', '0.1', '0', '0', '15', '1', '0.001', 'bitcoin', '<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#FFFFFF;\">\r\n	比特幣（比特幣）的概念最初由中本聰在2009年年提出，根據中本聰的思路設計發布的開源軟件以及建構其上的P2P網絡。比特幣是一種P2P形式的數字貨幣。點對點的傳輸意味著一個去中心化的支付系統。<br />\r\n與大多數貨幣不同，比特幣不依靠特定貨幣機構發行，它依據特定算法，通過大量的計算產生，比特幣經濟使用整個P2P網絡中眾多節點構成的分佈式數據庫來確認並記錄所有的交易行為，並使用密碼學的設計來確保貨幣流通各個環節安全性.P2P的去中心化特性與算法本身可以確保無法通過大量製造比特幣來人為操控幣值。基於密碼學的設計可以使比特幣只能被真實的擁有者轉移或支付。這同樣確保了貨幣所有權與流通交易的匿名性。比特幣與其他虛擬貨幣最大的不同，是其總數量非常有限，具有極強的稀缺性。該貨幣系統曾在4年內只有不超過1050萬個，之後的總數量將被永久限制在2100萬個。<br />\r\n比特幣可以用來兌現，可以兌換成大多數國家的貨幣。使用者可以用比特幣購買一些虛擬物品，比如網絡遊戲當中的衣服，帽子，裝備等，只要有人接受，也可以使用比特幣購買現實生活當中的物品。<br />\r\n</div>\r\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#FFFFFF;\">\r\n	<a target=\"_blank\" href=\"http://baike.baidu.com/view/73493.htm\"></a><a target=\"_blank\" href=\"http://baike.baidu.com/view/54792.htm\"></a>\r\n</div>', 'https://bitcoin.org/en/download', 'https://github.com/bitcoin/bitcoin', 'https://bitcoin.org', 'https://bitcointalk.org', 'https://en.bitcoin.it/wiki/Comparison_of_mining_po', 'Dorian S. Nakamoto', 'SHA-256', '2009/01/09', '600秒/塊', '21000000', '14750000', 'pow', '2016', '50', '虛擬幣始創者，受眾最廣，被信任最高', '確認時間長', '3', '15', '15', '15', '', '', '', 0, 29485.39710343, 0.001000, 0.002000, 0.001000, '0', '0', 91011.99910000, 0, 5, '', '', '', 0, 0, 0, 0, 1, 1, 1, '0.1', NULL, 50);
INSERT INTO `movesay_coin` VALUES (60, 'eth', 'qbb', '以太坊', '5a72d37bd4d6f.png', 0, '100', 0, 0, 1, '47.52.250.74', '8545', '', '', '0', '1', '1', '', '', '0.1', '0', '0', '10000', '1', '', 'Ethereum', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0xc8a6a9221fddeb847109377a788779efee30b67d', '', '', 0, 841.22864800, 0.001000, 0.020000, 0.010000, '123456', '123456', 31318.00010000, 0, 5, '', '', '', 6032274, 6752628, 0, 2, 0, 1, 1, '0.2', NULL, 10);
INSERT INTO `movesay_coin` VALUES (99, 'usdt', 'qbb', '泰达币', '5b55787a483f6.png', 0, '0', 0, 0, 1, '47.52.250.74', '23002', 'admin123', '123456', '0', '1', '1', '', '', '0', '0', '', '10000', '0', '', 'USDT', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 6.60000000, 0.000000, 0.000000, 0.000000, '', '', 100000.00000000, 0, 5, '', '', '', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `movesay_coin` VALUES (101, 'doge', 'qbb', '狗狗币', '5b63f682dcd76.png', 0, '100', 0, 0, 0, '', '', '', '', '0', '1', '1', '', '', '1', '0', '1', '10000', '1', '', 'DogeCoin', '<span style=\"color:#222222;font-family:Arial, &quot;font-size:16px;background-color:#FFFFFF;\">Dogecoin 缘起流行度不亚于国内“土豪”的欧美年度流行语“Doge”。 基于Scrypt 算法 60秒钟快速确认，总量1000亿+。</span>', 'https://dogecoin.com/', 'https://github.com/dogecoin/dogecoin', 'https://dogecoin.com/', 'https://bitcointalk.org/index.php?topic=361813.0', 'https://dogecoin.com/', '', ' Scrypt', ' Scrypt', '60秒/块', '100000000000', '111630000000', 'PoW', '4 hour', '', '', '', '', '', '', '', '', '', '', 0, 0.00000000, 0.010000, 0.100000, 0.010000, '', '', 0.00000000, 0, 5, '', '', '', 0, 0, 0, 100, 0, NULL, NULL, NULL, NULL, 10000);
INSERT INTO `movesay_coin` VALUES (102, 'xrp', 'qbb', '瑞波币', '5b641e627ae8b.png', 0, '100', 0, 0, 0, '', '', '', '', '0', '0', '1', '', '', '0.1', '0', '1', '1000000', '0', '', 'Ripple', '<span style=\"color:#222222;font-family:Arial, &quot;font-size:16px;background-color:#FFFFFF;\">Ripple是一个区中心化的资产传输网络，发行于2013年初，用于解决金融机构以及用户间的资产转换和信任问题。XRP是这个网络上面的基础资产，目前已经成为市值排名前几位的区块链资产。</span>', 'https://gatehub.net/', 'https://github.com/ripple', 'https://ripple.com/', 'https://ripple.com/', 'https://ripple.com/', '', '', '2013', '10秒/块', '100000000000', '100000000000', 'PoW+PoS', '', '', '', '', '', '', '', '', '', '', '', 0, 0.00000000, 0.010000, 0.010000, 0.010000, '', '', 0.00000000, 0, 5, '', '', '', 0, 0, 0, 1000, 0, NULL, NULL, NULL, NULL, 1000000);
INSERT INTO `movesay_coin` VALUES (103, 'sql', 'qbb', '闪企链', '5b7beddddf228.png', 0, '100', 0, 0, 1, '47.75.78.125', '8545', '', '', '0', '1', '10', '', '', '0.1', '0', '1', '1000000', '1', '', 'sql', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0x50f23d00b6e044af2c534935ddf95a126a97b8a1', '', '', 0, 0.00000000, 0.001000, 0.001000, 0.001000, '123456', '', 104914.97500000, 0, 5, '', '', '', 503660, 985202, 0, 100000, 0, NULL, NULL, NULL, NULL, 1000000);
INSERT INTO `movesay_coin` VALUES (104, 'eos', 'qbb', 'EOS', '5b84ff13b865b.png', 0, '100', 0, 0, 0, '', '', 'admin123', '123456', '0', '1', '1', '', '', '0.1', '0', '1', '10000', '1', '', 'EOS', '<span style=\"color:#222222;font-family:Arial, \"font-size:16px;background-color:#FFFFFF;\">EOS.io项目由block.one的CTO Dan Larimer主导，目标是建立一个横向和纵向都高度规模化的区块链操作系统，提供各种必要的功能和超高的处理能力，让开发者可以将注意力集中在业务层。EOS币前5天的ICO成本为0.00326 ETH，按当时市值计算约6.52CNY，在其后的一年中将有另外70%币稀释市场，请务必注意投资风险。</span>', 'https://eos.io/', 'https://github.com/eosio', 'https://eos.io/', 'https://eos.io/chat', 'https://eos.io/', '', '', '2017-07-01', ' -秒/块', '1000000000', '1000000000', '', ' 1', '', '', '', '', '', '', '', '', '', '', 0, 0.00000000, 0.001000, 0.001000, 0.001000, '', '', 0.00000000, 0, 5, '', '', '', 0, 0, 4, 1, 0, NULL, NULL, NULL, NULL, 1000000);
INSERT INTO `movesay_coin` VALUES (105, 'ltc', 'qbb', '莱特币', '5b8501285245e.png', 0, '100', 0, 0, 0, '', '', '', '', '0', '1', '1', '', '', '0.1', '0', '0.01', '1000000', '1', '', 'Litecoin', '<span style=\"color:#222222;font-family:Arial, &quot;font-size:16px;background-color:#FFFFFF;\">第一个基于Scrypt算法的网络数字货币，与Bitcoin相比，他的确认速度快，2.5分钟确认一次，总量为8400万。</span>', 'https://litecoin.org', 'https://github.com/litecoin-project', 'https://litecoin.org/', 'https://forum.litecoin.net/', 'http://litecoin.info/Mining_Pool_Comparison', '', 'Scrypt', '2011-10-07', '150秒/块', ' 84000000', '53165200', 'PoW', '2016 Blocks', '', '', '', '', '', '', '', '', '', '', 0, 366.26115055, 0.001000, 0.001000, 0.001000, '', '', 0.00000000, 0, 5, '', '', '', 0, 0, 4, 1, 0, NULL, NULL, NULL, NULL, 1000000);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int(11) NOT NULL,
  `uid` int(11) NULL DEFAULT 0 COMMENT '用户id',
  `money` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易金额',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（0 失败，1 成功）',
  `create_time` int(10) NULL DEFAULT 0 COMMENT '创建时间',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '说明',
  `operate_type` enum('signed','admin','lottery') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'admin',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sign
-- ----------------------------
DROP TABLE IF EXISTS `sign`;
CREATE TABLE `sign`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT 0 COMMENT '用户id',
  `signed_time` int(10) NULL DEFAULT 0 COMMENT '签到时间',
  `continuous_day` int(11) NULL DEFAULT 0 COMMENT '持续天数',
  `signed_bonus` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '签到奖励',
  `buy_gift` tinyint(1) NULL DEFAULT 0 COMMENT '是否购买礼包 (0 未购买， 1 购买)',
  `gift_bonus` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '礼包奖励',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_asset
-- ----------------------------
DROP TABLE IF EXISTS `user_asset`;
CREATE TABLE `user_asset`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT 0 COMMENT '用户id',
  `balance` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '余额',
  `frozen` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '冻结金额',
  `nick_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '昵称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
