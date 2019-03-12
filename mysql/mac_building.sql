/*
 Navicat Premium Data Transfer

 Source Server         : PHPStudy
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : mac_building

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 12/03/2019 11:51:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for rea_building
-- ----------------------------
DROP TABLE IF EXISTS `rea_building`;
CREATE TABLE `rea_building`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '楼盘ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '楼盘名字',
  `city_id` int(11) NOT NULL COMMENT '所属城市ID',
  `area_id` int(11) NOT NULL COMMENT '城市下级区域ID',
  `banner` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '宣传图片',
  `opening_time` date NOT NULL COMMENT '开售时间',
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细地址(不包括省市区)',
  `coor` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '经纬度坐标(经度，纬度)',
  `average_price` int(10) NOT NULL COMMENT '平均价格',
  `project_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '链家的项目名字',
  `build_id` bigint(30) NOT NULL COMMENT '链家的楼盘ID',
  `min_frame_area` int(11) NOT NULL COMMENT '最小建筑面积',
  `max_frame_area` int(11) NOT NULL COMMENT '最大建筑面积',
  `house_type` int(11) NOT NULL COMMENT '住宅类型(一对多)',
  `decoration` int(11) NOT NULL COMMENT '楼盘装修进度',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `build_id`(`build_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '楼盘列表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of rea_building
-- ----------------------------
INSERT INTO `rea_building` VALUES (1, '卓越蔚蓝松湖', 441900, 23009044, 'http://image1.ljcdn.com/newhouse-user-image/c5ffdb34e6760f1c76b2697354c7290a.jpg!m_fill,w_750,h_562,l_rorate_logo', '2018-12-17', '横东路', '113.956463,23.007698', 12500, 'zyggbjiqg', 5420036948817191, 94, 112, 0, 0);

-- ----------------------------
-- Table structure for rea_building_decoration
-- ----------------------------
DROP TABLE IF EXISTS `rea_building_decoration`;
CREATE TABLE `rea_building_decoration`  (
  `build_id` int(11) NOT NULL COMMENT '房子ID',
  `decoration_id` int(11) NOT NULL COMMENT '房子装修类型',
  PRIMARY KEY (`build_id`, `decoration_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for rea_building_house_type
-- ----------------------------
DROP TABLE IF EXISTS `rea_building_house_type`;
CREATE TABLE `rea_building_house_type`  (
  `build_id` int(11) NOT NULL COMMENT '房子ID',
  `house_type_id` int(11) NOT NULL COMMENT '房子类型ID',
  PRIMARY KEY (`build_id`, `house_type_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for rea_building_tags
-- ----------------------------
DROP TABLE IF EXISTS `rea_building_tags`;
CREATE TABLE `rea_building_tags`  (
  `tags_id` int(11) NOT NULL COMMENT '对应标签的ID',
  `build_id` int(11) NOT NULL COMMENT '对应楼盘的ID',
  PRIMARY KEY (`tags_id`, `build_id`) USING BTREE,
  INDEX `building-id`(`build_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for rea_decoration
-- ----------------------------
DROP TABLE IF EXISTS `rea_decoration`;
CREATE TABLE `rea_decoration`  (
  `id` int(11) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房子装修类型标签',
  `color` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房子装修类型标签颜色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rea_frame
-- ----------------------------
DROP TABLE IF EXISTS `rea_frame`;
CREATE TABLE `rea_frame`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '户型ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户型名字',
  `project_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对应的楼盘项目名字',
  `building_id` bigint(30) NOT NULL COMMENT '对应的楼盘ID',
  `bedroom_count` int(6) NULL DEFAULT NULL COMMENT '睡房数量',
  `parlor_count` int(6) NULL DEFAULT NULL COMMENT '客厅数量',
  `cookroom_count` int(6) NULL DEFAULT NULL COMMENT '厨房数量',
  `build_area` int(6) NULL DEFAULT NULL COMMENT '建筑面积',
  `toilet_count` int(6) NULL DEFAULT NULL COMMENT '卫生间数量',
  `price` bigint(20) NULL DEFAULT NULL COMMENT '价格（元）',
  `image_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户型图',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `building-id`(`building_id`) USING BTREE,
  CONSTRAINT `building-id` FOREIGN KEY (`building_id`) REFERENCES `rea_building` (`build_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '户型表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for rea_house_type
-- ----------------------------
DROP TABLE IF EXISTS `rea_house_type`;
CREATE TABLE `rea_house_type`  (
  `id` int(11) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房子类型',
  `color` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房子类型的标签颜色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rea_region
-- ----------------------------
DROP TABLE IF EXISTS `rea_region`;
CREATE TABLE `rea_region`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '区域ID',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区域名字',
  `fullspell` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拼音',
  `level` int(3) NULL DEFAULT NULL COMMENT '区域级别',
  `district_id` int(11) NULL DEFAULT NULL COMMENT '链家区域ID',
  `latitude` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '纬度',
  `longitude` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '经度',
  `parent_level` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '区域父级ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `lavel-parent_level`(`level`, `parent_level`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2849 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '区域表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of rea_region
-- ----------------------------
INSERT INTO `rea_region` VALUES (2445, '上海', 'shanghai', 1, 310000, '31.249161710015', '121.48789948569', '');
INSERT INTO `rea_region` VALUES (2446, '静安', 'jingan', 2, 310106, '31.23632', '121.45609', '2445');
INSERT INTO `rea_region` VALUES (2447, '徐汇', 'xuhui', 2, 310104, '31.175099050243', '121.44511349965', '2445');
INSERT INTO `rea_region` VALUES (2448, '黄浦', 'huangpu', 2, 310101, '31.220653367568', '121.4885866714', '2445');
INSERT INTO `rea_region` VALUES (2449, '长宁', 'changning', 2, 310105, '31.211508734277', '121.38792330882', '2445');
INSERT INTO `rea_region` VALUES (2450, '普陀', 'putuo', 2, 310107, '31.256755712078', '121.40750324592', '2445');
INSERT INTO `rea_region` VALUES (2451, '浦东', 'pudong', 2, 310115, '31.208001618509', '121.60653130552', '2445');
INSERT INTO `rea_region` VALUES (2452, '宝山', 'baoshan', 2, 310113, '31.369477510376', '121.42883034102', '2445');
INSERT INTO `rea_region` VALUES (2453, '闸北', 'zhabei', 2, 310108, '31.287034341884', '121.45176790104', '2445');
INSERT INTO `rea_region` VALUES (2454, '虹口', 'hongkou', 2, 310109, '31.28334662119', '121.48951226634', '2445');
INSERT INTO `rea_region` VALUES (2455, '杨浦', 'yangpu', 2, 310110, '31.294892964018', '121.53592027961', '2445');
INSERT INTO `rea_region` VALUES (2456, '闵行', 'minhang', 2, 310112, '31.091185835136', '121.40817118429', '2445');
INSERT INTO `rea_region` VALUES (2457, '嘉定', 'jiading', 2, 310114, '31.318139102222', '121.28505364959', '2445');
INSERT INTO `rea_region` VALUES (2458, '松江', 'songjiang', 2, 310117, '31.045701557755', '121.26515460671', '2445');
INSERT INTO `rea_region` VALUES (2459, '青浦', 'qingpu', 2, 310118, '31.196892111558', '121.21689957293', '2445');
INSERT INTO `rea_region` VALUES (2460, '奉贤', 'fengxian', 2, 310120, '30.891886284874', '121.56846112969', '2445');
INSERT INTO `rea_region` VALUES (2461, '金山', 'jinshan', 2, 310116, '30.75156837062', '121.32638856456', '2445');
INSERT INTO `rea_region` VALUES (2462, '崇明', 'chongming', 2, 310230, '31.614064208901', '121.57680883592', '2445');
INSERT INTO `rea_region` VALUES (2463, '上海周边', 'shanghaizhoubian', 2, 310333, '31.201273342247', '120.9564152546', '2445');
INSERT INTO `rea_region` VALUES (2464, '海外', 'haiwai', 2, 23009002, '-26.513376', '136.418842', '2445');
INSERT INTO `rea_region` VALUES (2465, '东莞', 'dongguan', 1, 441900, '23.043023815368', '113.76343399076', '');
INSERT INTO `rea_region` VALUES (2466, '莞城区', 'wanchengqu', 2, 23008872, '23.044805', '113.755925', '2465');
INSERT INTO `rea_region` VALUES (2467, '东城区', 'dongchengqu', 2, 23008873, '23.02365', '113.792533', '2465');
INSERT INTO `rea_region` VALUES (2468, '南城区', 'nanchengqu', 2, 23008874, '23.027095', '113.758269', '2465');
INSERT INTO `rea_region` VALUES (2469, '万江区', 'wanjiangqu', 2, 23008875, '23.038658', '113.722822', '2465');
INSERT INTO `rea_region` VALUES (2470, '虎门镇', 'humenzhen3', 2, 23009017, '22.82369', '113.682917', '2465');
INSERT INTO `rea_region` VALUES (2471, '长安镇', 'changanzhen1', 2, 23009020, '22.826039', '113.808411', '2465');
INSERT INTO `rea_region` VALUES (2472, '寮步镇', 'liaobuzhen1', 2, 23009021, '23.001118', '113.859632', '2465');
INSERT INTO `rea_region` VALUES (2473, '高埗镇', 'gaobuzhen1', 2, 23009027, '23.09749', '113.751763', '2465');
INSERT INTO `rea_region` VALUES (2474, '石碣镇', 'shijiezhen1', 2, 23009028, '23.110454', '113.814267', '2465');
INSERT INTO `rea_region` VALUES (2475, '石龙镇', 'shilongzhen', 2, 23009029, '23.114875', '113.87766', '2465');
INSERT INTO `rea_region` VALUES (2476, '茶山镇', 'chashanzhen', 2, 23009030, '23.08233', '113.874508', '2465');
INSERT INTO `rea_region` VALUES (2477, '石排镇', 'shipaizhen', 2, 23009031, '23.094714', '113.945528', '2465');
INSERT INTO `rea_region` VALUES (2478, '中堂镇', 'zhongtangzhen', 2, 23009032, '23.117417', '113.703407', '2465');
INSERT INTO `rea_region` VALUES (2479, '望牛墩镇', 'wangniudunzhen', 2, 23009033, '23.064301', '113.663594', '2465');
INSERT INTO `rea_region` VALUES (2480, '麻涌镇', 'machongzhen', 2, 23009034, '23.058391', '113.585469', '2465');
INSERT INTO `rea_region` VALUES (2481, '道滘镇', 'daojiaozhen', 2, 23009035, '23.0099', '113.682198', '2465');
INSERT INTO `rea_region` VALUES (2482, '洪梅镇', 'hongmeizhen', 2, 23009036, '22.9948', '113.616525', '2465');
INSERT INTO `rea_region` VALUES (2483, '沙田镇', 'shatianzhen', 2, 23009037, '22.881097', '113.622775', '2465');
INSERT INTO `rea_region` VALUES (2484, '厚街镇', 'houjiezhen2', 2, 23009038, '22.931897', '113.694496', '2465');
INSERT INTO `rea_region` VALUES (2485, '大岭山镇', 'dalingshanzhen1', 2, 23009039, '22.906', '113.847855', '2465');
INSERT INTO `rea_region` VALUES (2486, '企石镇', 'qishizhen', 2, 23009040, '23.076171', '114.030498', '2465');
INSERT INTO `rea_region` VALUES (2487, '桥头镇', 'qiaotouzhen', 2, 23009041, '23.016411', '114.107514', '2465');
INSERT INTO `rea_region` VALUES (2488, '横沥镇', 'henglizhen', 2, 23009042, '23.024494', '113.971284', '2465');
INSERT INTO `rea_region` VALUES (2489, '常平镇', 'changpingzhen', 2, 23009043, '22.972772', '114.024992', '2465');
INSERT INTO `rea_region` VALUES (2490, '东坑镇', 'dongkengzhen', 2, 23009044, '23.010183', '113.926701', '2465');
INSERT INTO `rea_region` VALUES (2491, '大朗镇', 'dalangzhen', 2, 23009045, '22.955843', '113.939699', '2465');
INSERT INTO `rea_region` VALUES (2492, '黄江镇', 'huangjiangzhen', 2, 23009046, '22.917859', '114.011338', '2465');
INSERT INTO `rea_region` VALUES (2493, '谢岗镇', 'xiegangzhen', 2, 23009047, '22.967981', '114.155354', '2465');
INSERT INTO `rea_region` VALUES (2494, '樟木头镇', 'zhangmutouzhen', 2, 23009048, '22.92113', '114.088897', '2465');
INSERT INTO `rea_region` VALUES (2495, '塘厦镇', 'tangxiazhen', 2, 23009049, '22.812955', '114.076518', '2465');
INSERT INTO `rea_region` VALUES (2496, '清溪镇', 'qingxizhen', 2, 23009050, '22.849462', '114.169655', '2465');
INSERT INTO `rea_region` VALUES (2497, '凤岗镇', 'fenggangzhen', 2, 23009051, '22.750808', '114.153809', '2465');
INSERT INTO `rea_region` VALUES (2498, '松山湖', 'songshanhu', 2, 23009105, '22.906408', '113.889599', '2465');
INSERT INTO `rea_region` VALUES (2499, '中山', 'zhongshan', 1, 442000, '22.545177514513', '113.4220600208', '');
INSERT INTO `rea_region` VALUES (2500, '五桂山', 'wuguishan', 2, 23009079, '22.486189', '113.418296', '2499');
INSERT INTO `rea_region` VALUES (2501, '火炬', 'huoju', 2, 23009080, '22.543998', '113.49485', '2499');
INSERT INTO `rea_region` VALUES (2502, '港口镇', 'gangkouzhen', 2, 23009081, '22.579943', '113.395596', '2499');
INSERT INTO `rea_region` VALUES (2503, '东区', 'dongqu', 2, 23009083, '22.514984', '113.409443', '2499');
INSERT INTO `rea_region` VALUES (2504, '西区', 'xiqu', 2, 23009084, '22.547632', '113.364079', '2499');
INSERT INTO `rea_region` VALUES (2505, '石岐区', 'shiqiqu', 2, 23009091, '22.539609', '113.390417', '2499');
INSERT INTO `rea_region` VALUES (2506, '南区', 'nanqu', 2, 23009092, '22.488618', '113.358249', '2499');
INSERT INTO `rea_region` VALUES (2507, '沙溪镇', 'shaxizhen', 2, 23009093, '22.507372', '113.353677', '2499');
INSERT INTO `rea_region` VALUES (2508, '东凤镇', 'dongfengzhen', 2, 23009130, '22.700686', '113.273763', '2499');
INSERT INTO `rea_region` VALUES (2509, '南朗镇', 'nanlangzhen', 2, 23009131, '22.495084', '113.559209', '2499');
INSERT INTO `rea_region` VALUES (2510, '阜沙镇', 'fushazhen', 2, 23009132, '22.673878', '113.356048', '2499');
INSERT INTO `rea_region` VALUES (2511, '东升镇', 'dongshengzhen1', 2, 23009133, '22.62695', '113.296077', '2499');
INSERT INTO `rea_region` VALUES (2512, '横栏镇', 'henglanzhen', 2, 23009134, '22.562518', '113.241352', '2499');
INSERT INTO `rea_region` VALUES (2513, '大涌镇', 'dayongzhen', 2, 23009139, '22.471174', '113.290759', '2499');
INSERT INTO `rea_region` VALUES (2514, '板芙镇', 'banfuzhen', 2, 23009141, '22.401222', '113.324284', '2499');
INSERT INTO `rea_region` VALUES (2515, '小榄镇', 'xiaolanzhen', 2, 23009142, '22.665274', '113.243652', '2499');
INSERT INTO `rea_region` VALUES (2516, '古镇镇', 'guzhenzhen', 2, 23009143, '22.640593', '113.203695', '2499');
INSERT INTO `rea_region` VALUES (2517, '坦洲镇', 'tanzhouzhen', 2, 23009144, '22.262015', '113.472468', '2499');
INSERT INTO `rea_region` VALUES (2518, '三乡镇', 'sanxiangzhen', 2, 23009145, '22.365665', '113.443004', '2499');
INSERT INTO `rea_region` VALUES (2519, '神湾镇', 'shenwanzhen', 2, 23009146, '22.308968', '113.36884', '2499');
INSERT INTO `rea_region` VALUES (2520, '三角镇', 'sanjiaozhen', 2, 23009147, '22.682414', '113.435818', '2499');
INSERT INTO `rea_region` VALUES (2521, '黄圃镇', 'huangpuzhen', 2, 23009148, '22.717223', '113.345735', '2499');
INSERT INTO `rea_region` VALUES (2522, '民众镇', 'minzhongzhen', 2, 23009149, '22.632787', '113.537578', '2499');
INSERT INTO `rea_region` VALUES (2523, '南头镇', 'nantouzhen', 2, 23009150, '22.723506', '113.298332', '2499');
INSERT INTO `rea_region` VALUES (2524, '佛山', 'foshan', 1, 440600, '23.035094840514', '113.13402563539', '');
INSERT INTO `rea_region` VALUES (2525, '高明', 'gaoming1', 2, 23009009, '22.913258', '112.878348', '2524');
INSERT INTO `rea_region` VALUES (2526, '三水', 'sanshui1', 2, 23009008, '23.167325', '112.889267', '2524');
INSERT INTO `rea_region` VALUES (2527, '禅城', 'chancheng', 2, 23009003, '23.014652', '113.128019', '2524');
INSERT INTO `rea_region` VALUES (2528, '南海', 'nanhai', 2, 23009006, '22.998449', '112.951362', '2524');
INSERT INTO `rea_region` VALUES (2529, '顺德', 'shunde', 2, 23009007, '22.810548', '113.299999', '2524');
INSERT INTO `rea_region` VALUES (2530, '保亭', 'baoting', 1, 469029, '18.597592346267', '109.65611337969', '');
INSERT INTO `rea_region` VALUES (2531, '保亭黎族苗族自治县', 'baotinglizumiaozuzizhixian', 2, 23009245, '18.640879', '109.703289', '2530');
INSERT INTO `rea_region` VALUES (2532, '北京', 'beijing', 1, 110000, '39.92998577808', '116.39564503788', '');
INSERT INTO `rea_region` VALUES (2533, '东城', 'dongcheng', 2, 23008614, '39.918649000289', '116.42447316303', '2532');
INSERT INTO `rea_region` VALUES (2534, '西城', 'xicheng', 2, 23008626, '39.910041817755', '116.36960374452', '2532');
INSERT INTO `rea_region` VALUES (2535, '朝阳', 'chaoyang', 2, 23008613, '39.941870226449', '116.51560779421', '2532');
INSERT INTO `rea_region` VALUES (2536, '海淀', 'haidian', 2, 23008618, '39.988146111109', '116.31928440197', '2532');
INSERT INTO `rea_region` VALUES (2537, '丰台', 'fengtai', 2, 23008617, '39.856482924451', '116.2745350184', '2532');
INSERT INTO `rea_region` VALUES (2538, '石景山', 'shijingshan', 2, 23008623, '39.927380788933', '116.1881220088', '2532');
INSERT INTO `rea_region` VALUES (2539, '通州', 'tongzhou', 2, 23008625, '39.899697215983', '116.66910860993', '2532');
INSERT INTO `rea_region` VALUES (2540, '昌平', 'changping', 2, 23008611, '40.2254152452', '116.23936485567', '2532');
INSERT INTO `rea_region` VALUES (2541, '大兴', 'daxing', 2, 23008615, '39.732475753738', '116.35616519116', '2532');
INSERT INTO `rea_region` VALUES (2542, '亦庄开发区', 'yizhuangkaifaqu', 2, 23008629, '39.787661925087', '116.51437283867', '2532');
INSERT INTO `rea_region` VALUES (2543, '顺义', 'shunyi', 2, 23008624, '40.143652317363', '116.65925154446', '2532');
INSERT INTO `rea_region` VALUES (2544, '房山', 'fangshan', 2, 23008616, '39.729988560946', '116.1380205325', '2532');
INSERT INTO `rea_region` VALUES (2545, '门头沟', 'mentougou', 2, 23008620, '39.914751032922', '116.11693954783', '2532');
INSERT INTO `rea_region` VALUES (2546, '平谷', 'pinggu', 2, 23008622, '40.149397302875', '117.12371117513', '2532');
INSERT INTO `rea_region` VALUES (2547, '怀柔', 'huairou', 2, 23008619, '40.347397522906', '116.65006125307', '2532');
INSERT INTO `rea_region` VALUES (2548, '密云', 'miyun', 2, 23008621, '40.391839887884', '116.85485407577', '2532');
INSERT INTO `rea_region` VALUES (2549, '延庆', 'yanqing', 2, 23008628, '40.461932306287', '115.98166187113', '2532');
INSERT INTO `rea_region` VALUES (2550, '南京', 'nanjing', 1, 320100, '32.057235501806', '118.77807440803', '');
INSERT INTO `rea_region` VALUES (2551, '鼓楼', 'gulou', 2, 320106, '32.063510440383', '118.76712445708', '2550');
INSERT INTO `rea_region` VALUES (2552, '建邺', 'jianye', 2, 320105, '31.987732311205', '118.71758438551', '2550');
INSERT INTO `rea_region` VALUES (2553, '秦淮', 'qinhuai', 2, 320104, '32.017657184107', '118.81742157658', '2550');
INSERT INTO `rea_region` VALUES (2554, '玄武', 'xuanwu', 2, 320102, '32.079095551281', '118.82018505399', '2550');
INSERT INTO `rea_region` VALUES (2555, '雨花台', 'yuhuatai', 2, 320114, '31.938022046084', '118.6791749356', '2550');
INSERT INTO `rea_region` VALUES (2556, '栖霞', 'qixia', 2, 320113, '32.137173822125', '118.90480004898', '2550');
INSERT INTO `rea_region` VALUES (2557, '江宁', 'jiangning', 2, 320115, '31.938963935068', '118.84892081893', '2550');
INSERT INTO `rea_region` VALUES (2558, '浦口', 'pukou', 2, 320111, '32.021814559402', '118.55923958717', '2550');
INSERT INTO `rea_region` VALUES (2559, '六合', 'liuhe', 2, 320116, '32.229681990578', '118.7571075914', '2550');
INSERT INTO `rea_region` VALUES (2560, '溧水', 'lishui', 2, 320124, '31.668838119113', '119.04639672187', '2550');
INSERT INTO `rea_region` VALUES (2561, '高淳', 'gaochun', 2, 320125, '31.335421625319', '118.89315170665', '2550');
INSERT INTO `rea_region` VALUES (2562, '句容', 'jurong', 2, 23009136, '31.937079', '119.182322', '2550');
INSERT INTO `rea_region` VALUES (2563, '金坛市', 'jintanshi', 2, 23009301, '31.733281', '119.521331', '2550');
INSERT INTO `rea_region` VALUES (2564, '来安县', 'laianxian', 2, 23010121, '32.446721', '118.485437', '2550');
INSERT INTO `rea_region` VALUES (2565, '溧阳市', 'liyangshi', 2, 23009303, '31.473467', '119.342532', '2550');
INSERT INTO `rea_region` VALUES (2566, '和县', 'hexian', 2, 23009290, '31.775555', '118.319328', '2550');
INSERT INTO `rea_region` VALUES (2567, '南谯区', 'nanqiaoqu', 2, 23010124, '32.293508', '118.222125', '2550');
INSERT INTO `rea_region` VALUES (2568, '厦门', 'xiamen', 1, 350200, '24.489230612469', '118.10388604566', '');
INSERT INTO `rea_region` VALUES (2569, '思明', 'siming', 2, 23008796, '24.47065190452', '118.1393913471', '2568');
INSERT INTO `rea_region` VALUES (2570, '湖里', 'huli', 2, 23008797, '24.525833676087', '118.15175593927', '2568');
INSERT INTO `rea_region` VALUES (2571, '海沧', 'haicang', 2, 23008801, '24.485396900759', '118.02685339467', '2568');
INSERT INTO `rea_region` VALUES (2572, '集美', 'jimei', 2, 23008800, '24.6092532161', '118.06694828967', '2568');
INSERT INTO `rea_region` VALUES (2573, '翔安', 'xiangan', 2, 23008798, '24.585324730648', '118.25897329591', '2568');
INSERT INTO `rea_region` VALUES (2574, '同安', 'tongan', 2, 23008799, '24.681034604534', '118.14115522293', '2568');
INSERT INTO `rea_region` VALUES (2575, '漳州', 'zhangzhou', 2, 350600, '24.517065', '117.676205', '2568');
INSERT INTO `rea_region` VALUES (2576, '大理', 'dali', 1, 532900, '25.693966622473', '100.21920895422', '');
INSERT INTO `rea_region` VALUES (2577, '大理市', 'dalishi', 2, 23009201, '25.633731', '100.255333', '2576');
INSERT INTO `rea_region` VALUES (2578, '祥云县', 'xiangyunxian', 2, 23009202, '25.481703', '100.555726', '2576');
INSERT INTO `rea_region` VALUES (2579, '宾川县', 'binchuanxian', 2, 23009203, '25.853213', '100.572111', '2576');
INSERT INTO `rea_region` VALUES (2580, '弥渡县', 'miduxian', 2, 23009204, '25.353253', '100.484149', '2576');
INSERT INTO `rea_region` VALUES (2581, '永平县', 'yongpingxian', 2, 23009205, '25.46448', '99.543012', '2576');
INSERT INTO `rea_region` VALUES (2582, '云龙县', 'yunlongxian', 2, 23009206, '25.889623', '99.407332', '2576');
INSERT INTO `rea_region` VALUES (2583, '洱源县', 'eryuanxian', 2, 23009207, '26.113557', '99.962701', '2576');
INSERT INTO `rea_region` VALUES (2584, '剑川县', 'jianchuanxian', 2, 23009208, '26.542025', '99.913833', '2576');
INSERT INTO `rea_region` VALUES (2585, '鹤庆县', 'heqingxian', 2, 23009209, '26.566328', '100.195542', '2576');
INSERT INTO `rea_region` VALUES (2586, '漾濞彝族自治县', 'yangbiyizuzizhixian', 2, 23009210, '25.67568', '99.967875', '2576');
INSERT INTO `rea_region` VALUES (2587, '巍山彝族回族自治县', 'weishanyizuhuizuzizhixian', 2, 23009211, '25.247152', '100.252458', '2576');
INSERT INTO `rea_region` VALUES (2588, '南涧彝族自治县', 'nanjianyizuzizhixian', 2, 23009212, '25.035193', '100.503696', '2576');
INSERT INTO `rea_region` VALUES (2589, '大连', 'dalian', 1, 210200, '38.948709938304', '121.59347778144', '');
INSERT INTO `rea_region` VALUES (2590, '高新园区', 'gaoxinyuanqu', 2, 990004, '38.8667', '121.511539', '2589');
INSERT INTO `rea_region` VALUES (2591, '甘井子', 'ganjingzi', 2, 210211, '38.979358179579', '121.54780309221', '2589');
INSERT INTO `rea_region` VALUES (2592, '中山', 'zhongshan', 2, 210202, '38.908756825125', '121.67646599348', '2589');
INSERT INTO `rea_region` VALUES (2593, '沙河口', 'shahekou', 2, 210204, '38.90836', '121.582329', '2589');
INSERT INTO `rea_region` VALUES (2594, '西岗', 'xigang', 2, 210203, '38.912815914798', '121.62559942012', '2589');
INSERT INTO `rea_region` VALUES (2595, '开发区', 'kaifaqudl', 2, 990006, '39.063740935325', '121.82054111743', '2589');
INSERT INTO `rea_region` VALUES (2596, '金州', 'jinzhou', 2, 210213, '39.10415', '121.7312', '2589');
INSERT INTO `rea_region` VALUES (2597, '旅顺口', 'lvshunkou', 2, 210212, '38.869375175759', '121.3075736477', '2589');
INSERT INTO `rea_region` VALUES (2598, '普兰店', 'pulandian', 2, 210282, '39.634169657055', '122.31705884576', '2589');
INSERT INTO `rea_region` VALUES (2599, '瓦房店', 'wafangdian', 2, 210281, '39.68868782453', '121.72260003993', '2589');
INSERT INTO `rea_region` VALUES (2600, '庄河', 'zhuanghe', 2, 210283, '39.829522720082', '123.01831579154', '2589');
INSERT INTO `rea_region` VALUES (2601, '长海', 'changhai', 2, 210224, '39.303034807273', '122.85511396976', '2589');
INSERT INTO `rea_region` VALUES (2602, '天津', 'tianjin', 1, 120000, '39.14392990331', '117.21081309155', '');
INSERT INTO `rea_region` VALUES (2603, '宝坻', 'baodi', 2, 120215, '39.622722267926', '117.4299209767', '2602');
INSERT INTO `rea_region` VALUES (2604, '滨海新区', 'binhaixinqu', 2, 120116, '38.840975105883', '117.50075576209', '2602');
INSERT INTO `rea_region` VALUES (2605, '静海', 'jinghai', 2, 120223, '38.858805028736', '116.98631498864', '2602');
INSERT INTO `rea_region` VALUES (2606, '蓟州', 'jizhou', 2, 120225, '40.043115303704', '117.41688265107', '2602');
INSERT INTO `rea_region` VALUES (2607, '宁河', 'ninghe', 2, 120221, '39.336088820341', '117.65965203384', '2602');
INSERT INTO `rea_region` VALUES (2608, '武清', 'wuqing', 2, 120114, '39.412681669173', '117.06129760462', '2602');
INSERT INTO `rea_region` VALUES (2609, '和平', 'heping', 2, 120101, '39.125367088453', '117.20323116971', '2602');
INSERT INTO `rea_region` VALUES (2610, '南开', 'nankai', 2, 120104, '39.119719237959', '117.16081563706', '2602');
INSERT INTO `rea_region` VALUES (2611, '河西', 'hexi', 2, 120103, '39.086002426511', '117.23797243771', '2602');
INSERT INTO `rea_region` VALUES (2612, '河北', 'hebei', 2, 120105, '39.168129856964', '117.22418509892', '2602');
INSERT INTO `rea_region` VALUES (2613, '河东', 'hedong', 2, 120102, '39.127587773803', '117.2568165191', '2602');
INSERT INTO `rea_region` VALUES (2614, '红桥', 'hongqiao', 2, 120106, '39.170896623818', '117.16052678584', '2602');
INSERT INTO `rea_region` VALUES (2615, '西青', 'xiqing', 2, 120111, '39.030868169696', '117.14262209052', '2602');
INSERT INTO `rea_region` VALUES (2616, '北辰', 'beichen', 2, 120113, '39.250492559506', '117.16394402219', '2602');
INSERT INTO `rea_region` VALUES (2617, '东丽', 'dongli', 2, 120110, '39.14255081862', '117.42868436422', '2602');
INSERT INTO `rea_region` VALUES (2618, '津南', 'jinnan', 2, 120112, '38.96938763002', '117.42515625581', '2602');
INSERT INTO `rea_region` VALUES (2619, '塘沽', 'tanggu', 2, 120107, '39.047160374839', '117.62580809109', '2602');
INSERT INTO `rea_region` VALUES (2620, '开发区', 'kaifaqutj', 2, 120119, '39.060690540288', '117.71583697295', '2602');
INSERT INTO `rea_region` VALUES (2621, '海河教育园区', 'haihejiaoyuyuanqu', 2, 23011847, '39.006307', '117.356394', '2602');
INSERT INTO `rea_region` VALUES (2622, '中山', 'zhongshan', 1, 442000, '22.545177514513', '113.4220600208', '');
INSERT INTO `rea_region` VALUES (2623, '五桂山', 'wuguishan', 2, 23009079, '22.486189', '113.418296', '2622');
INSERT INTO `rea_region` VALUES (2624, '火炬', 'huoju', 2, 23009080, '22.543998', '113.49485', '2622');
INSERT INTO `rea_region` VALUES (2625, '港口镇', 'gangkouzhen', 2, 23009081, '22.579943', '113.395596', '2622');
INSERT INTO `rea_region` VALUES (2626, '东区', 'dongqu', 2, 23009083, '22.514984', '113.409443', '2622');
INSERT INTO `rea_region` VALUES (2627, '西区', 'xiqu', 2, 23009084, '22.547632', '113.364079', '2622');
INSERT INTO `rea_region` VALUES (2628, '石岐区', 'shiqiqu', 2, 23009091, '22.539609', '113.390417', '2622');
INSERT INTO `rea_region` VALUES (2629, '南区', 'nanqu', 2, 23009092, '22.488618', '113.358249', '2622');
INSERT INTO `rea_region` VALUES (2630, '沙溪镇', 'shaxizhen', 2, 23009093, '22.507372', '113.353677', '2622');
INSERT INTO `rea_region` VALUES (2631, '东凤镇', 'dongfengzhen', 2, 23009130, '22.700686', '113.273763', '2622');
INSERT INTO `rea_region` VALUES (2632, '南朗镇', 'nanlangzhen', 2, 23009131, '22.495084', '113.559209', '2622');
INSERT INTO `rea_region` VALUES (2633, '阜沙镇', 'fushazhen', 2, 23009132, '22.673878', '113.356048', '2622');
INSERT INTO `rea_region` VALUES (2634, '东升镇', 'dongshengzhen1', 2, 23009133, '22.62695', '113.296077', '2622');
INSERT INTO `rea_region` VALUES (2635, '横栏镇', 'henglanzhen', 2, 23009134, '22.562518', '113.241352', '2622');
INSERT INTO `rea_region` VALUES (2636, '大涌镇', 'dayongzhen', 2, 23009139, '22.471174', '113.290759', '2622');
INSERT INTO `rea_region` VALUES (2637, '板芙镇', 'banfuzhen', 2, 23009141, '22.401222', '113.324284', '2622');
INSERT INTO `rea_region` VALUES (2638, '小榄镇', 'xiaolanzhen', 2, 23009142, '22.665274', '113.243652', '2622');
INSERT INTO `rea_region` VALUES (2639, '古镇镇', 'guzhenzhen', 2, 23009143, '22.640593', '113.203695', '2622');
INSERT INTO `rea_region` VALUES (2640, '坦洲镇', 'tanzhouzhen', 2, 23009144, '22.262015', '113.472468', '2622');
INSERT INTO `rea_region` VALUES (2641, '三乡镇', 'sanxiangzhen', 2, 23009145, '22.365665', '113.443004', '2622');
INSERT INTO `rea_region` VALUES (2642, '神湾镇', 'shenwanzhen', 2, 23009146, '22.308968', '113.36884', '2622');
INSERT INTO `rea_region` VALUES (2643, '三角镇', 'sanjiaozhen', 2, 23009147, '22.682414', '113.435818', '2622');
INSERT INTO `rea_region` VALUES (2644, '黄圃镇', 'huangpuzhen', 2, 23009148, '22.717223', '113.345735', '2622');
INSERT INTO `rea_region` VALUES (2645, '民众镇', 'minzhongzhen', 2, 23009149, '22.632787', '113.537578', '2622');
INSERT INTO `rea_region` VALUES (2646, '南头镇', 'nantouzhen', 2, 23009150, '22.723506', '113.298332', '2622');
INSERT INTO `rea_region` VALUES (2647, '张家口', 'zhangjiakou', 1, 130700, '40.811188491103', '114.89378153033', '');
INSERT INTO `rea_region` VALUES (2648, '怀来县', 'huailaixian', 2, 23009025, '40.423331', '115.524416', '2647');
INSERT INTO `rea_region` VALUES (2649, '崇礼县', 'chonglixian', 2, 23009075, '40.980425', '115.289258', '2647');
INSERT INTO `rea_region` VALUES (2650, '下花园', 'xiahuayuan', 2, 23009298, '40.564601', '115.303496', '2647');
INSERT INTO `rea_region` VALUES (2651, '涿鹿县', 'zhuoluxian', 2, 23011482, '40.252819', '115.251321', '2647');
INSERT INTO `rea_region` VALUES (2652, '尚义县', 'shangyixian', 2, 23011483, '41.096757', '114.187728', '2647');
INSERT INTO `rea_region` VALUES (2653, '康保县', 'kangbaoxian', 2, 23011484, '41.763971', '114.600517', '2647');
INSERT INTO `rea_region` VALUES (2654, '蔚县', 'weixian3', 2, 23011485, '39.908336', '114.738497', '2647');
INSERT INTO `rea_region` VALUES (2655, '怀安县', 'huaianxian', 2, 23011486, '40.570119', '114.537276', '2647');
INSERT INTO `rea_region` VALUES (2656, '宣化区', 'xuanhuaqu', 2, 23011487, '40.609565', '115.047801', '2647');
INSERT INTO `rea_region` VALUES (2657, '万全区', 'wanquanqu', 2, 23011488, '40.816058', '114.694803', '2647');
INSERT INTO `rea_region` VALUES (2658, '张北县', 'zhangbeixian', 2, 23011489, '41.219293', '114.728148', '2647');
INSERT INTO `rea_region` VALUES (2659, '赤城县', 'chichengxian', 2, 23011490, '40.892018', '115.881429', '2647');
INSERT INTO `rea_region` VALUES (2660, '沽源县', 'guyuanxian', 2, 23011491, '41.605368', '115.713553', '2647');
INSERT INTO `rea_region` VALUES (2661, '崇礼区', 'chongliqu1', 2, 23011492, '38.710929', '118.275952', '2647');
INSERT INTO `rea_region` VALUES (2662, '阳原县', 'yangyuanxian', 2, 23011493, '40.151423', '114.428042', '2647');
INSERT INTO `rea_region` VALUES (2663, '桥东区', 'qiaodongqu3', 2, 23011770, '40.783727', '114.926494', '2647');
INSERT INTO `rea_region` VALUES (2664, '桥西区', 'qiaoxiqu3', 2, 23011771, '40.826104', '114.868428', '2647');
INSERT INTO `rea_region` VALUES (2665, '惠州', 'huizhou', 1, 441300, '23.113539852408', '114.41065807997', '');
INSERT INTO `rea_region` VALUES (2666, '惠城', 'huicheng', 2, 23008867, '23.112686126674', '114.43031907212', '2665');
INSERT INTO `rea_region` VALUES (2667, '惠阳', 'huiyang', 2, 23008868, '22.795834479843', '114.46775598664', '2665');
INSERT INTO `rea_region` VALUES (2668, '大亚湾', 'dayawan', 2, 23009113, '22.745994', '114.576859', '2665');
INSERT INTO `rea_region` VALUES (2669, '惠东', 'huidong', 2, 23008869, '22.983713938801', '114.76514197763', '2665');
INSERT INTO `rea_region` VALUES (2670, '博罗', 'boluo', 2, 23008870, '23.300611496146', '114.28094261008', '2665');
INSERT INTO `rea_region` VALUES (2671, '龙门', 'longmen', 2, 23008871, '23.645206502337', '114.33194711807', '2665');
INSERT INTO `rea_region` VALUES (2672, '成都', 'chengdu', 1, 510100, '30.67994284542', '104.0679234633', '');
INSERT INTO `rea_region` VALUES (2673, '锦江', 'jinjiang', 2, 510104, '30.631792930153', '104.11184377687', '2672');
INSERT INTO `rea_region` VALUES (2674, '青羊', 'qingyang', 2, 510105, '30.673705549865', '104.0250546995', '2672');
INSERT INTO `rea_region` VALUES (2675, '武侯', 'wuhou', 2, 510107, '30.642962853222', '104.03881939208', '2672');
INSERT INTO `rea_region` VALUES (2676, '高新', 'gaoxin7', 2, 990002, '30.598387243821', '104.07241906727', '2672');
INSERT INTO `rea_region` VALUES (2677, '成华', 'chenghua', 2, 510108, '30.676802057756', '104.13204104996', '2672');
INSERT INTO `rea_region` VALUES (2678, '金牛', 'jinniu', 2, 510106, '30.711579640801', '104.05502980433', '2672');
INSERT INTO `rea_region` VALUES (2679, '天府新区', 'tianfuxinqu', 2, 23008850, '30.437881', '104.097087', '2672');
INSERT INTO `rea_region` VALUES (2680, '高新西', 'gaoxinxi1', 2, 23009121, '30.755203', '103.938985', '2672');
INSERT INTO `rea_region` VALUES (2681, '双流', 'shuangliu', 2, 510122, '30.612969442112', '103.86652978345', '2672');
INSERT INTO `rea_region` VALUES (2682, '温江', 'wenjiang', 2, 510115, '30.698727210531', '103.8435535959', '2672');
INSERT INTO `rea_region` VALUES (2683, '郫都', 'pidou', 2, 510124, '30.814910311649', '103.88837671014', '2672');
INSERT INTO `rea_region` VALUES (2684, '龙泉驿', 'longquanyi', 2, 510112, '30.562024', '104.274566', '2672');
INSERT INTO `rea_region` VALUES (2685, '新都', 'xindou', 2, 510114, '30.829559374266', '104.18365673628', '2672');
INSERT INTO `rea_region` VALUES (2686, '青白江', 'qingbaijiang', 2, 510113, '30.89086103135', '104.25837555123', '2672');
INSERT INTO `rea_region` VALUES (2687, '金堂', 'jintang', 2, 510121, '30.848866733153', '104.44088205092', '2672');
INSERT INTO `rea_region` VALUES (2688, '大邑', 'dayi', 2, 510129, '30.584676026793', '103.53282520685', '2672');
INSERT INTO `rea_region` VALUES (2689, '蒲江', 'pujiang', 2, 510131, '30.217163122131', '103.5273368506', '2672');
INSERT INTO `rea_region` VALUES (2690, '新津', 'xinjin', 2, 510132, '30.429740117917', '103.82333452219', '2672');
INSERT INTO `rea_region` VALUES (2691, '彭州', 'pengzhou', 2, 510182, '30.986135924006', '103.95404267391', '2672');
INSERT INTO `rea_region` VALUES (2692, '邛崃', 'qionglai', 2, 510183, '30.413746128559', '103.47056768494', '2672');
INSERT INTO `rea_region` VALUES (2693, '崇州', 'chongzhou1', 2, 510184, '30.635336', '103.679411', '2672');
INSERT INTO `rea_region` VALUES (2694, '都江堰', 'doujiangyan', 2, 510181, '30.995080063356', '103.63305299972', '2672');
INSERT INTO `rea_region` VALUES (2695, '简阳', 'jianyang', 2, 23009119, '30.258073', '104.253495', '2672');
INSERT INTO `rea_region` VALUES (2696, '天府新区南区', 'tianfuxinqunanqu', 2, 23009222, '30.255423', '104.061542', '2672');
INSERT INTO `rea_region` VALUES (2697, '德阳', 'deyang', 2, 510600, '31.13114', '104.402398', '2672');
INSERT INTO `rea_region` VALUES (2698, '乐山', 'leshan', 2, 511100, '29.600958', '103.760824', '2672');
INSERT INTO `rea_region` VALUES (2699, '眉山', 'meishan', 2, 511400, '30.061115', '103.84143', '2672');
INSERT INTO `rea_region` VALUES (2700, '资阳', 'ziyang', 2, 512000, '30.132191', '104.63593', '2672');
INSERT INTO `rea_region` VALUES (2701, '昆明', 'kunming', 1, 530100, '25.049153100453', '102.71460113878', '');
INSERT INTO `rea_region` VALUES (2702, '五华', 'wuhua', 2, 23008833, '25.153764', '102.663304', '2701');
INSERT INTO `rea_region` VALUES (2703, '盘龙', 'panlong', 2, 23008834, '25.147982537869', '102.78401709125', '2701');
INSERT INTO `rea_region` VALUES (2704, '官渡', 'guandu', 2, 23008835, '25.061951441468', '102.89793433482', '2701');
INSERT INTO `rea_region` VALUES (2705, '西山', 'xishan23', 2, 23008836, '25.001759648632', '102.62775965873', '2701');
INSERT INTO `rea_region` VALUES (2706, '呈贡', 'chenggong', 2, 23008837, '24.866784329967', '102.85047463703', '2701');
INSERT INTO `rea_region` VALUES (2707, '安宁', 'anning', 2, 23009180, '24.922144', '102.485433', '2701');
INSERT INTO `rea_region` VALUES (2708, '晋宁', 'jinning', 2, 23009172, '24.675935', '102.598908', '2701');
INSERT INTO `rea_region` VALUES (2709, '东川', 'dongchuan', 2, 23009174, '26.081454', '103.23189', '2701');
INSERT INTO `rea_region` VALUES (2710, '嵩明', 'songming', 2, 23009173, '25.341906', '103.047125', '2701');
INSERT INTO `rea_region` VALUES (2711, '富民', 'fumin', 2, 23009175, '25.224749', '102.504047', '2701');
INSERT INTO `rea_region` VALUES (2712, '宜良', 'yiliang', 2, 23009176, '24.911133', '103.138537', '2701');
INSERT INTO `rea_region` VALUES (2713, '石林', 'shilin', 2, 23009177, '24.762127', '103.239722', '2701');
INSERT INTO `rea_region` VALUES (2714, '寻甸', 'xundian', 2, 23009178, '25.553783', '103.308354', '2701');
INSERT INTO `rea_region` VALUES (2715, '禄劝', 'luquan1', 2, 23009179, '25.55176', '102.431966', '2701');
INSERT INTO `rea_region` VALUES (2716, '杭州', 'hangzhou', 1, 330100, '30.259244461536', '120.21937541572', '');
INSERT INTO `rea_region` VALUES (2717, '西湖', 'xihu', 2, 330106, '30.220783135528', '120.09103889901', '2716');
INSERT INTO `rea_region` VALUES (2718, '下城', 'xiacheng', 2, 330103, '30.31447215142', '120.18092484803', '2716');
INSERT INTO `rea_region` VALUES (2719, '江干', 'jianggan', 2, 330104, '30.312669856448', '120.2953630072', '2716');
INSERT INTO `rea_region` VALUES (2720, '拱墅', 'gongshu', 2, 330105, '30.339871583945', '120.15668488207', '2716');
INSERT INTO `rea_region` VALUES (2721, '上城', 'shangcheng', 2, 330102, '30.23891930114', '120.18653681537', '2716');
INSERT INTO `rea_region` VALUES (2722, '滨江', 'binjiang', 2, 330108, '30.183248703692', '120.19588368658', '2716');
INSERT INTO `rea_region` VALUES (2723, '余杭', 'yuhang', 2, 330110, '30.383399310373', '119.99408348806', '2716');
INSERT INTO `rea_region` VALUES (2724, '萧山', 'xiaoshan', 2, 330109, '30.183821424941', '120.32398656421', '2716');
INSERT INTO `rea_region` VALUES (2725, '桐庐', 'tonglu1', 2, 330122, '29.823123711145', '119.57233090595', '2716');
INSERT INTO `rea_region` VALUES (2726, '淳安', 'chunan1', 2, 330127, '29.578301261467', '118.85993133698', '2716');
INSERT INTO `rea_region` VALUES (2727, '建德', 'jiande', 2, 330182, '29.466518768417', '119.41238522976', '2716');
INSERT INTO `rea_region` VALUES (2728, '富阳', 'fuyang', 2, 330183, '30.002478203695', '119.89187879631', '2716');
INSERT INTO `rea_region` VALUES (2729, '临安', 'linan', 2, 330185, '30.221297712255', '119.33476743608', '2716');
INSERT INTO `rea_region` VALUES (2730, '海宁市', 'hainingshi', 2, 23009015, '30.517543', '120.686591', '2716');
INSERT INTO `rea_region` VALUES (2731, '下沙', 'xiasha', 2, 23009161, '30.262815', '120.373558', '2716');
INSERT INTO `rea_region` VALUES (2732, '大江东', 'dajiangdong1', 2, 23011852, '30.331915', '120.550686', '2716');
INSERT INTO `rea_region` VALUES (2733, '宁波', 'ningbo', 2, 330200, '29.885259', '121.579006', '2716');
INSERT INTO `rea_region` VALUES (2734, '嘉兴', 'jiaxing', 2, 330400, '30.773992', '120.760428', '2716');
INSERT INTO `rea_region` VALUES (2735, '湖州', 'huzhou', 2, 330500, '30.877925', '120.137243', '2716');
INSERT INTO `rea_region` VALUES (2736, '绍兴', 'shaoxing', 2, 330600, '30.002365', '120.592467', '2716');
INSERT INTO `rea_region` VALUES (2737, '舟山', 'zhoushan', 2, 330900, '30.03601', '122.169872', '2716');
INSERT INTO `rea_region` VALUES (2738, '沈阳', 'shenyang', 1, 210100, '41.808644783516', '123.43279092161', '');
INSERT INTO `rea_region` VALUES (2739, '大东', 'dadong', 2, 23008746, '41.822862699837', '123.48904470015', '2738');
INSERT INTO `rea_region` VALUES (2740, '和平', 'heping1', 2, 23008741, '41.784395915758', '123.41705262459', '2738');
INSERT INTO `rea_region` VALUES (2741, '皇姑', 'huanggu', 2, 23008742, '41.837076964269', '123.42526873733', '2738');
INSERT INTO `rea_region` VALUES (2742, '浑南', 'hunnan', 2, 23008747, '41.780719154249', '123.55945243218', '2738');
INSERT INTO `rea_region` VALUES (2743, '沈河', 'shenhe', 2, 23008744, '41.798630020631', '123.45254121065', '2738');
INSERT INTO `rea_region` VALUES (2744, '铁西', 'tiexi', 2, 23008743, '41.80572251916', '123.3592702248', '2738');
INSERT INTO `rea_region` VALUES (2745, '于洪', 'yuhong', 2, 23008745, '41.80772253758', '123.25618145297', '2738');
INSERT INTO `rea_region` VALUES (2746, '苏家屯', 'sujiatun', 2, 23009090, '41.57411', '123.401316', '2738');
INSERT INTO `rea_region` VALUES (2747, '沈北新区', 'shenbeixinqu', 2, 23009100, '42.031828', '123.512849', '2738');
INSERT INTO `rea_region` VALUES (2748, '法库县', 'fakuxian', 2, 23011042, '42.444713', '123.311107', '2738');
INSERT INTO `rea_region` VALUES (2749, '新民市', 'xinminshi', 2, 23011043, '42.006287', '122.894868', '2738');
INSERT INTO `rea_region` VALUES (2750, '康平县', 'kangpingxian', 2, 23011044, '42.74165', '123.350202', '2738');
INSERT INTO `rea_region` VALUES (2751, '辽中区', 'liaozhongqu', 2, 23011045, '41.614864', '122.871872', '2738');
INSERT INTO `rea_region` VALUES (2752, '抚顺', 'fushun', 2, 210400, '41.877304', '123.92982', '2738');
INSERT INTO `rea_region` VALUES (2753, '营口', 'yingkou', 2, 210800, '40.668651', '122.233391', '2738');
INSERT INTO `rea_region` VALUES (2754, '济南', 'jinan', 1, 370101, '36.682784727161', '117.02496706629', '');
INSERT INTO `rea_region` VALUES (2755, '历下', 'lixia', 2, 23008844, '36.656525054967', '117.10227195137', '2754');
INSERT INTO `rea_region` VALUES (2756, '市中', 'shizhong', 2, 23008845, '36.60495344718', '116.99906095125', '2754');
INSERT INTO `rea_region` VALUES (2757, '天桥', 'tianqiao', 2, 23008847, '36.713694362217', '116.99428238241', '2754');
INSERT INTO `rea_region` VALUES (2758, '历城', 'licheng', 2, 23008848, '36.693919454537', '117.22360812369', '2754');
INSERT INTO `rea_region` VALUES (2759, '槐荫', 'huaiyin', 2, 23008846, '36.66689431613', '116.93117241672', '2754');
INSERT INTO `rea_region` VALUES (2760, '高新', 'gaoxin', 2, 23008898, '36.692522274848', '117.13136683406', '2754');
INSERT INTO `rea_region` VALUES (2761, '长清', 'changqing', 2, 23008849, '36.543161707145', '116.78137953557', '2754');
INSERT INTO `rea_region` VALUES (2762, '章丘', 'zhangqiu1', 2, 23008878, '36.707305457435', '117.54142280741', '2754');
INSERT INTO `rea_region` VALUES (2763, '济阳', 'jiyang', 2, 23008956, '36.983609', '117.184717', '2754');
INSERT INTO `rea_region` VALUES (2764, '商河', 'shanghe', 2, 23008957, '37.299386', '117.157301', '2754');
INSERT INTO `rea_region` VALUES (2765, '平阴', 'pingyin', 2, 23009089, '36.294965', '116.462789', '2754');
INSERT INTO `rea_region` VALUES (2766, '泰安', 'ta', 2, 370900, '36.188078', '117.089415', '2754');
INSERT INTO `rea_region` VALUES (2767, '莱芜', 'lw', 2, 371200, '36.233654', '117.684667', '2754');
INSERT INTO `rea_region` VALUES (2768, '德州', 'dezhou', 2, 371400, '37.460826', '116.328161', '2754');
INSERT INTO `rea_region` VALUES (2769, '深圳', 'shenzhen', 1, 440300, '22.546053546205', '114.02597365732', '');
INSERT INTO `rea_region` VALUES (2770, '福田区', 'futianqu', 2, 23008674, '22.547546404654', '114.05878900681', '2769');
INSERT INTO `rea_region` VALUES (2771, '南山区', 'nanshanqu', 2, 23008679, '22.532859206473', '113.94289459583', '2769');
INSERT INTO `rea_region` VALUES (2772, '龙岗区', 'longgangqu', 2, 23008676, '22.663330039461', '114.21332952038', '2769');
INSERT INTO `rea_region` VALUES (2773, '宝安区', 'baoanqu', 2, 23008672, '22.681136030508', '113.84655466218', '2769');
INSERT INTO `rea_region` VALUES (2774, '罗湖区', 'luohuqu', 2, 23008678, '22.575045859153', '114.15682582743', '2769');
INSERT INTO `rea_region` VALUES (2775, '龙华区', 'longhuaqu', 2, 23008677, '22.696156637449', '114.02530031632', '2769');
INSERT INTO `rea_region` VALUES (2776, '盐田区', 'yantianqu', 2, 23008681, '22.59429535479', '114.27492890661', '2769');
INSERT INTO `rea_region` VALUES (2777, '光明区', 'guangmingqu', 2, 23008675, '22.764270119616', '113.92292024907', '2769');
INSERT INTO `rea_region` VALUES (2778, '坪山区', 'pingshanqu', 2, 23008680, '22.691224851524', '114.36695722009', '2769');
INSERT INTO `rea_region` VALUES (2779, '大鹏新区', 'dapengxinqu', 2, 23008673, '22.606415517155', '114.48375261825', '2769');
INSERT INTO `rea_region` VALUES (2780, '惠州', 'huizhou', 2, 441300, '23.118805', '114.422691', '2769');
INSERT INTO `rea_region` VALUES (2781, '东莞', 'dongguan', 2, 441900, '23.003846', '113.752482', '2769');
INSERT INTO `rea_region` VALUES (2782, '珠海', 'zhuhai', 1, 440400, '22.256914646126', '113.56244702619', '');
INSERT INTO `rea_region` VALUES (2783, '香洲区', 'xiangzhouqu', 2, 23009082, '22.274787', '113.55104', '2782');
INSERT INTO `rea_region` VALUES (2784, '金湾区', 'jinwanqu', 2, 23009261, '22.153302', '113.369632', '2782');
INSERT INTO `rea_region` VALUES (2785, '斗门区', 'doumenqu', 2, 23009264, '22.201062', '113.282874', '2782');
INSERT INTO `rea_region` VALUES (2786, '苏州', 'suzhou', 1, 320500, '31.317987367952', '120.61990711549', '');
INSERT INTO `rea_region` VALUES (2787, '高新', 'gaoxin1', 2, 23008664, '31.348491', '120.478654', '2786');
INSERT INTO `rea_region` VALUES (2788, '姑苏', 'gusu', 2, 23008663, '31.319868', '120.615484', '2786');
INSERT INTO `rea_region` VALUES (2789, '相城', 'xiangcheng', 2, 23008666, '31.447926', '120.64423', '2786');
INSERT INTO `rea_region` VALUES (2790, '吴江', 'wujiang', 2, 23008667, '31.11827', '120.685624', '2786');
INSERT INTO `rea_region` VALUES (2791, '常熟', 'changshu', 2, 23008668, '31.668039913277', '120.76951863665', '2786');
INSERT INTO `rea_region` VALUES (2792, '张家港', 'zhangjiagang', 2, 23008669, '31.88243251128', '120.59967243955', '2786');
INSERT INTO `rea_region` VALUES (2793, '昆山', 'kunshan', 2, 23008670, '31.372496278655', '120.98968928274', '2786');
INSERT INTO `rea_region` VALUES (2794, '太仓', 'taicang', 2, 23008671, '31.542471757028', '121.13636472593', '2786');
INSERT INTO `rea_region` VALUES (2795, '吴中', 'wuzhong', 2, 23008665, '31.250988', '120.638193', '2786');
INSERT INTO `rea_region` VALUES (2796, '工业园区', 'gongyeyuan', 2, 23008818, '31.323817', '120.744265', '2786');
INSERT INTO `rea_region` VALUES (2797, '重庆', 'chongqing', 1, 500000, '29.544606108886', '106.53063501341', '');
INSERT INTO `rea_region` VALUES (2798, '江北', 'jiangbei', 2, 23008771, '29.609274106037', '106.58434286245', '2797');
INSERT INTO `rea_region` VALUES (2799, '渝北', 'yubei', 2, 23008778, '29.72054031152', '106.64032491774', '2797');
INSERT INTO `rea_region` VALUES (2800, '渝中', 'yuzhong', 2, 23008770, '29.555856570777', '106.57920003179', '2797');
INSERT INTO `rea_region` VALUES (2801, '沙坪坝', 'shapingba', 2, 23008775, '29.566765864557', '106.45879917519', '2797');
INSERT INTO `rea_region` VALUES (2802, '九龙坡', 'jiulongpo', 2, 23008774, '29.505275913633', '106.52110545148', '2797');
INSERT INTO `rea_region` VALUES (2803, '南岸', 'nanan', 2, 23008772, '29.502743327202', '106.65470686407', '2797');
INSERT INTO `rea_region` VALUES (2804, '大渡口', 'dadukou', 2, 23008773, '29.487665315669', '106.49242423858', '2797');
INSERT INTO `rea_region` VALUES (2805, '巴南', 'banan', 2, 23008776, '29.405327249927', '106.54955519057', '2797');
INSERT INTO `rea_region` VALUES (2806, '北碚', 'beibei', 2, 23008777, '29.808286900194', '106.4057081261', '2797');
INSERT INTO `rea_region` VALUES (2807, '大足', 'dazu', 2, 500225, '29.709247757858', '105.73152341382', '2797');
INSERT INTO `rea_region` VALUES (2808, '武隆县', 'wulongxian', 2, 500232, '29.332790917327', '107.77273438559', '2797');
INSERT INTO `rea_region` VALUES (2809, '石柱', 'shizhu', 2, 500240, '30.002657904553', '108.12479695452', '2797');
INSERT INTO `rea_region` VALUES (2810, '涪陵', 'fuling', 2, 500102, '29.705012246165', '107.40078319127', '2797');
INSERT INTO `rea_region` VALUES (2811, '綦江', 'qijiang', 2, 500118, '29.160816', '106.801078', '2797');
INSERT INTO `rea_region` VALUES (2812, '长寿', 'changshou1', 2, 500115, '29.860768913508', '107.09189907474', '2797');
INSERT INTO `rea_region` VALUES (2813, '江津', 'jiangjing', 2, 500116, '29.292052045036', '106.2693284563', '2797');
INSERT INTO `rea_region` VALUES (2814, '合川', 'hechuang', 2, 500120, '29.974654698169', '106.28643847782', '2797');
INSERT INTO `rea_region` VALUES (2815, '南川', 'nanchuang', 2, 500119, '29.158654825681', '107.11044591649', '2797');
INSERT INTO `rea_region` VALUES (2816, '璧山', 'bishan', 2, 500117, '29.593117156045', '106.23752393875', '2797');
INSERT INTO `rea_region` VALUES (2817, '铜梁', 'tongliang', 2, 500121, '29.847747648456', '106.06595693553', '2797');
INSERT INTO `rea_region` VALUES (2818, '潼南', 'tongnan', 2, 500123, '30.194136354654', '105.85063711375', '2797');
INSERT INTO `rea_region` VALUES (2819, '万州', 'wanzhou', 2, 500101, '30.808663167035', '108.41866138283', '2797');
INSERT INTO `rea_region` VALUES (2820, '梁平', 'liangping', 2, 500122, '30.675564763075', '107.8148119135', '2797');
INSERT INTO `rea_region` VALUES (2821, '云阳', 'yunyang', 2, 500124, '30.933066491478', '108.70846977074', '2797');
INSERT INTO `rea_region` VALUES (2822, '黔江', 'qianjiang', 2, 500114, '29.535943518199', '108.78148137453', '2797');
INSERT INTO `rea_region` VALUES (2823, '双桥 ', 'shuangqiao1', 2, 500111, '29.493100522912', '105.78126515211', '2797');
INSERT INTO `rea_region` VALUES (2824, '永川', 'yongchuan', 2, 23009000, '29.368745', '105.932807', '2797');
INSERT INTO `rea_region` VALUES (2825, '丰都', 'fengdu1', 2, 23009026, '29.842036', '107.935812', '2797');
INSERT INTO `rea_region` VALUES (2826, '秀山土家族苗族自治县', 'xiushantujiazumiaozuzizhixian', 2, 23011521, '28.507967', '109.024825', '2797');
INSERT INTO `rea_region` VALUES (2827, '忠县', 'zhongxian', 2, 23011522, '30.352481', '107.885917', '2797');
INSERT INTO `rea_region` VALUES (2828, '巫山县', 'wushanxian1', 2, 23011523, '31.096043', '109.907895', '2797');
INSERT INTO `rea_region` VALUES (2829, '荣昌区', 'rongchangqu', 2, 23011524, '29.439237', '105.571882', '2797');
INSERT INTO `rea_region` VALUES (2830, '奉节县', 'fengjiexian', 2, 23011525, '31.067342', '109.446813', '2797');
INSERT INTO `rea_region` VALUES (2831, '开州区', 'kaizhouqu', 2, 23011526, '31.172205', '108.37287', '2797');
INSERT INTO `rea_region` VALUES (2832, '垫江县', 'dianjiangxian', 2, 23011527, '30.289134', '107.42081', '2797');
INSERT INTO `rea_region` VALUES (2833, '酉阳土家族苗族自治县', 'youyangtujiazumiaozuzizhixian', 2, 23011528, '28.89829', '108.71782', '2797');
INSERT INTO `rea_region` VALUES (2834, '彭水苗族土家族自治县', 'pengshuimiaozutujiazuzizhixian', 2, 23011529, '29.346593', '108.277434', '2797');
INSERT INTO `rea_region` VALUES (2835, '巫溪县', 'wuxixian', 2, 23011530, '31.472294', '109.46176', '2797');
INSERT INTO `rea_region` VALUES (2836, '城口县', 'chengkouxian', 2, 23011531, '31.927474', '108.686774', '2797');
INSERT INTO `rea_region` VALUES (2837, '遵义', 'zunyi', 2, 520300, '27.699961', '106.93126', '2797');
INSERT INTO `rea_region` VALUES (2838, '长沙', 'changsha', 1, 430100, '28.213478230853', '112.97935278765', '');
INSERT INTO `rea_region` VALUES (2839, '望城', 'wangcheng', 2, 430122, '28.348230447162', '112.83103399848', '2838');
INSERT INTO `rea_region` VALUES (2840, '宁乡', 'ningxiang', 2, 430124, '28.265858179243', '112.56051584741', '2838');
INSERT INTO `rea_region` VALUES (2841, '浏阳', 'liuyang', 2, 430181, '28.156763419896', '113.6389305618', '2838');
INSERT INTO `rea_region` VALUES (2842, '长沙县', 'changshaxian', 2, 23008769, '28.344361', '113.185774', '2838');
INSERT INTO `rea_region` VALUES (2843, '雨花', 'yuhua', 2, 23008764, '28.142950332727', '113.03841198713', '2838');
INSERT INTO `rea_region` VALUES (2844, '岳麓', 'yuelu', 2, 23008766, '28.214734385981', '112.91593944807', '2838');
INSERT INTO `rea_region` VALUES (2845, '天心', 'tianxin', 2, 23008765, '28.120806598893', '112.98267522764', '2838');
INSERT INTO `rea_region` VALUES (2846, '开福', 'kaifu', 2, 23008768, '28.249488586449', '112.9991134596', '2838');
INSERT INTO `rea_region` VALUES (2847, '芙蓉', 'furong', 2, 23008767, '28.205890447462', '113.04865619743', '2838');
INSERT INTO `rea_region` VALUES (2848, '湘潭', 'xiangtan', 2, 430300, '27.837383', '112.94885', '2838');

-- ----------------------------
-- Table structure for rea_tags
-- ----------------------------
DROP TABLE IF EXISTS `rea_tags`;
CREATE TABLE `rea_tags`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `tags` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '对应值',
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '对应名字',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 34555 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rea_tags
-- ----------------------------
INSERT INTO `rea_tags` VALUES (1, 'is_discount', '优惠楼盘');
INSERT INTO `rea_tags` VALUES (2, 'has_car', '免费停车');
INSERT INTO `rea_tags` VALUES (3, 'is_band', '品牌房企');
INSERT INTO `rea_tags` VALUES (4, 'is_subway_house', '近地铁');
INSERT INTO `rea_tags` VALUES (5, 'small_frame', '小户型');
INSERT INTO `rea_tags` VALUES (6, 'ready_house', '现房');
INSERT INTO `rea_tags` VALUES (7, 'lowDensity', '密度低');
INSERT INTO `rea_tags` VALUES (8, 'is_has_garden', '花园洋房');
INSERT INTO `rea_tags` VALUES (9, 'is_parking_spaces', '车位充足');

SET FOREIGN_KEY_CHECKS = 1;
