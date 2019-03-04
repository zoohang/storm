/*
Navicat MySQL Data Transfer

Source Server         : 本地连接
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : storm

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-03-05 00:29:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for st_admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `st_admin_menu`;
CREATE TABLE `st_admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父菜单id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '菜单类型;1:有界面可访问菜单,2:无界面可访问菜单,0:只作为菜单',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态;1:显示,0:不显示',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `app` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '应用名',
  `controller` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '控制器名',
  `action` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '操作名称',
  `param` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '额外参数',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '菜单图标',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `parent_id` (`parent_id`),
  KEY `controller` (`controller`)
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8mb4 COMMENT='后台菜单表';

-- ----------------------------
-- Records of st_admin_menu
-- ----------------------------
INSERT INTO `st_admin_menu` VALUES ('1', '0', '0', '1', '20', 'admin', 'Plugin', 'default', '', '插件中心', 'cloud', '插件中心');
INSERT INTO `st_admin_menu` VALUES ('2', '1', '1', '1', '10000', 'admin', 'Hook', 'index', '', '钩子管理', '', '钩子管理');
INSERT INTO `st_admin_menu` VALUES ('3', '2', '1', '0', '10000', 'admin', 'Hook', 'plugins', '', '钩子插件管理', '', '钩子插件管理');
INSERT INTO `st_admin_menu` VALUES ('4', '2', '2', '0', '10000', 'admin', 'Hook', 'pluginListOrder', '', '钩子插件排序', '', '钩子插件排序');
INSERT INTO `st_admin_menu` VALUES ('5', '2', '1', '0', '10000', 'admin', 'Hook', 'sync', '', '同步钩子', '', '同步钩子');
INSERT INTO `st_admin_menu` VALUES ('6', '0', '0', '1', '0', 'admin', 'Setting', 'default', '', '设置', 'cogs', '系统设置入口');
INSERT INTO `st_admin_menu` VALUES ('7', '6', '1', '1', '50', 'admin', 'Link', 'index', '', '友情链接', '', '友情链接管理');
INSERT INTO `st_admin_menu` VALUES ('8', '7', '1', '0', '10000', 'admin', 'Link', 'add', '', '添加友情链接', '', '添加友情链接');
INSERT INTO `st_admin_menu` VALUES ('9', '7', '2', '0', '10000', 'admin', 'Link', 'addPost', '', '添加友情链接提交保存', '', '添加友情链接提交保存');
INSERT INTO `st_admin_menu` VALUES ('10', '7', '1', '0', '10000', 'admin', 'Link', 'edit', '', '编辑友情链接', '', '编辑友情链接');
INSERT INTO `st_admin_menu` VALUES ('11', '7', '2', '0', '10000', 'admin', 'Link', 'editPost', '', '编辑友情链接提交保存', '', '编辑友情链接提交保存');
INSERT INTO `st_admin_menu` VALUES ('12', '7', '2', '0', '10000', 'admin', 'Link', 'delete', '', '删除友情链接', '', '删除友情链接');
INSERT INTO `st_admin_menu` VALUES ('13', '7', '2', '0', '10000', 'admin', 'Link', 'listOrder', '', '友情链接排序', '', '友情链接排序');
INSERT INTO `st_admin_menu` VALUES ('14', '7', '2', '0', '10000', 'admin', 'Link', 'toggle', '', '友情链接显示隐藏', '', '友情链接显示隐藏');
INSERT INTO `st_admin_menu` VALUES ('15', '6', '1', '1', '10', 'admin', 'Mailer', 'index', '', '邮箱配置', '', '邮箱配置');
INSERT INTO `st_admin_menu` VALUES ('16', '15', '2', '0', '10000', 'admin', 'Mailer', 'indexPost', '', '邮箱配置提交保存', '', '邮箱配置提交保存');
INSERT INTO `st_admin_menu` VALUES ('17', '15', '1', '0', '10000', 'admin', 'Mailer', 'template', '', '邮件模板', '', '邮件模板');
INSERT INTO `st_admin_menu` VALUES ('18', '15', '2', '0', '10000', 'admin', 'Mailer', 'templatePost', '', '邮件模板提交', '', '邮件模板提交');
INSERT INTO `st_admin_menu` VALUES ('19', '15', '1', '0', '10000', 'admin', 'Mailer', 'test', '', '邮件发送测试', '', '邮件发送测试');
INSERT INTO `st_admin_menu` VALUES ('20', '6', '1', '0', '10000', 'admin', 'Menu', 'index', '', '后台菜单', '', '后台菜单管理');
INSERT INTO `st_admin_menu` VALUES ('21', '20', '1', '0', '10000', 'admin', 'Menu', 'lists', '', '所有菜单', '', '后台所有菜单列表');
INSERT INTO `st_admin_menu` VALUES ('22', '20', '1', '0', '10000', 'admin', 'Menu', 'add', '', '后台菜单添加', '', '后台菜单添加');
INSERT INTO `st_admin_menu` VALUES ('23', '20', '2', '0', '10000', 'admin', 'Menu', 'addPost', '', '后台菜单添加提交保存', '', '后台菜单添加提交保存');
INSERT INTO `st_admin_menu` VALUES ('24', '20', '1', '0', '10000', 'admin', 'Menu', 'edit', '', '后台菜单编辑', '', '后台菜单编辑');
INSERT INTO `st_admin_menu` VALUES ('25', '20', '2', '0', '10000', 'admin', 'Menu', 'editPost', '', '后台菜单编辑提交保存', '', '后台菜单编辑提交保存');
INSERT INTO `st_admin_menu` VALUES ('26', '20', '2', '0', '10000', 'admin', 'Menu', 'delete', '', '后台菜单删除', '', '后台菜单删除');
INSERT INTO `st_admin_menu` VALUES ('27', '20', '2', '0', '10000', 'admin', 'Menu', 'listOrder', '', '后台菜单排序', '', '后台菜单排序');
INSERT INTO `st_admin_menu` VALUES ('28', '20', '1', '0', '10000', 'admin', 'Menu', 'getActions', '', '导入新后台菜单', '', '导入新后台菜单');
INSERT INTO `st_admin_menu` VALUES ('29', '6', '1', '1', '30', 'admin', 'Nav', 'index', '', '导航管理', '', '导航管理');
INSERT INTO `st_admin_menu` VALUES ('30', '29', '1', '0', '10000', 'admin', 'Nav', 'add', '', '添加导航', '', '添加导航');
INSERT INTO `st_admin_menu` VALUES ('31', '29', '2', '0', '10000', 'admin', 'Nav', 'addPost', '', '添加导航提交保存', '', '添加导航提交保存');
INSERT INTO `st_admin_menu` VALUES ('32', '29', '1', '0', '10000', 'admin', 'Nav', 'edit', '', '编辑导航', '', '编辑导航');
INSERT INTO `st_admin_menu` VALUES ('33', '29', '2', '0', '10000', 'admin', 'Nav', 'editPost', '', '编辑导航提交保存', '', '编辑导航提交保存');
INSERT INTO `st_admin_menu` VALUES ('34', '29', '2', '0', '10000', 'admin', 'Nav', 'delete', '', '删除导航', '', '删除导航');
INSERT INTO `st_admin_menu` VALUES ('35', '29', '1', '0', '10000', 'admin', 'NavMenu', 'index', '', '导航菜单', '', '导航菜单');
INSERT INTO `st_admin_menu` VALUES ('36', '35', '1', '0', '10000', 'admin', 'NavMenu', 'add', '', '添加导航菜单', '', '添加导航菜单');
INSERT INTO `st_admin_menu` VALUES ('37', '35', '2', '0', '10000', 'admin', 'NavMenu', 'addPost', '', '添加导航菜单提交保存', '', '添加导航菜单提交保存');
INSERT INTO `st_admin_menu` VALUES ('38', '35', '1', '0', '10000', 'admin', 'NavMenu', 'edit', '', '编辑导航菜单', '', '编辑导航菜单');
INSERT INTO `st_admin_menu` VALUES ('39', '35', '2', '0', '10000', 'admin', 'NavMenu', 'editPost', '', '编辑导航菜单提交保存', '', '编辑导航菜单提交保存');
INSERT INTO `st_admin_menu` VALUES ('40', '35', '2', '0', '10000', 'admin', 'NavMenu', 'delete', '', '删除导航菜单', '', '删除导航菜单');
INSERT INTO `st_admin_menu` VALUES ('41', '35', '2', '0', '10000', 'admin', 'NavMenu', 'listOrder', '', '导航菜单排序', '', '导航菜单排序');
INSERT INTO `st_admin_menu` VALUES ('42', '1', '1', '1', '10000', 'admin', 'Plugin', 'index', '', '插件列表', '', '插件列表');
INSERT INTO `st_admin_menu` VALUES ('43', '42', '2', '0', '10000', 'admin', 'Plugin', 'toggle', '', '插件启用禁用', '', '插件启用禁用');
INSERT INTO `st_admin_menu` VALUES ('44', '42', '1', '0', '10000', 'admin', 'Plugin', 'setting', '', '插件设置', '', '插件设置');
INSERT INTO `st_admin_menu` VALUES ('45', '42', '2', '0', '10000', 'admin', 'Plugin', 'settingPost', '', '插件设置提交', '', '插件设置提交');
INSERT INTO `st_admin_menu` VALUES ('46', '42', '2', '0', '10000', 'admin', 'Plugin', 'install', '', '插件安装', '', '插件安装');
INSERT INTO `st_admin_menu` VALUES ('47', '42', '2', '0', '10000', 'admin', 'Plugin', 'update', '', '插件更新', '', '插件更新');
INSERT INTO `st_admin_menu` VALUES ('48', '42', '2', '0', '10000', 'admin', 'Plugin', 'uninstall', '', '卸载插件', '', '卸载插件');
INSERT INTO `st_admin_menu` VALUES ('49', '110', '0', '1', '10000', 'admin', 'User', 'default', '', '管理组', '', '管理组');
INSERT INTO `st_admin_menu` VALUES ('50', '49', '1', '1', '10000', 'admin', 'Rbac', 'index', '', '角色管理', '', '角色管理');
INSERT INTO `st_admin_menu` VALUES ('51', '50', '1', '0', '10000', 'admin', 'Rbac', 'roleAdd', '', '添加角色', '', '添加角色');
INSERT INTO `st_admin_menu` VALUES ('52', '50', '2', '0', '10000', 'admin', 'Rbac', 'roleAddPost', '', '添加角色提交', '', '添加角色提交');
INSERT INTO `st_admin_menu` VALUES ('53', '50', '1', '0', '10000', 'admin', 'Rbac', 'roleEdit', '', '编辑角色', '', '编辑角色');
INSERT INTO `st_admin_menu` VALUES ('54', '50', '2', '0', '10000', 'admin', 'Rbac', 'roleEditPost', '', '编辑角色提交', '', '编辑角色提交');
INSERT INTO `st_admin_menu` VALUES ('55', '50', '2', '0', '10000', 'admin', 'Rbac', 'roleDelete', '', '删除角色', '', '删除角色');
INSERT INTO `st_admin_menu` VALUES ('56', '50', '1', '0', '10000', 'admin', 'Rbac', 'authorize', '', '设置角色权限', '', '设置角色权限');
INSERT INTO `st_admin_menu` VALUES ('57', '50', '2', '0', '10000', 'admin', 'Rbac', 'authorizePost', '', '角色授权提交', '', '角色授权提交');
INSERT INTO `st_admin_menu` VALUES ('58', '0', '1', '1', '30', 'admin', 'RecycleBin', 'index', '', '回收站', '', '回收站');
INSERT INTO `st_admin_menu` VALUES ('59', '58', '2', '0', '10000', 'admin', 'RecycleBin', 'restore', '', '回收站还原', '', '回收站还原');
INSERT INTO `st_admin_menu` VALUES ('60', '58', '2', '0', '10000', 'admin', 'RecycleBin', 'delete', '', '回收站彻底删除', '', '回收站彻底删除');
INSERT INTO `st_admin_menu` VALUES ('61', '6', '1', '1', '10000', 'admin', 'Route', 'index', '', 'URL美化', '', 'URL规则管理');
INSERT INTO `st_admin_menu` VALUES ('62', '61', '1', '0', '10000', 'admin', 'Route', 'add', '', '添加路由规则', '', '添加路由规则');
INSERT INTO `st_admin_menu` VALUES ('63', '61', '2', '0', '10000', 'admin', 'Route', 'addPost', '', '添加路由规则提交', '', '添加路由规则提交');
INSERT INTO `st_admin_menu` VALUES ('64', '61', '1', '0', '10000', 'admin', 'Route', 'edit', '', '路由规则编辑', '', '路由规则编辑');
INSERT INTO `st_admin_menu` VALUES ('65', '61', '2', '0', '10000', 'admin', 'Route', 'editPost', '', '路由规则编辑提交', '', '路由规则编辑提交');
INSERT INTO `st_admin_menu` VALUES ('66', '61', '2', '0', '10000', 'admin', 'Route', 'delete', '', '路由规则删除', '', '路由规则删除');
INSERT INTO `st_admin_menu` VALUES ('67', '61', '2', '0', '10000', 'admin', 'Route', 'ban', '', '路由规则禁用', '', '路由规则禁用');
INSERT INTO `st_admin_menu` VALUES ('68', '61', '2', '0', '10000', 'admin', 'Route', 'open', '', '路由规则启用', '', '路由规则启用');
INSERT INTO `st_admin_menu` VALUES ('69', '61', '2', '0', '10000', 'admin', 'Route', 'listOrder', '', '路由规则排序', '', '路由规则排序');
INSERT INTO `st_admin_menu` VALUES ('70', '61', '1', '0', '10000', 'admin', 'Route', 'select', '', '选择URL', '', '选择URL');
INSERT INTO `st_admin_menu` VALUES ('71', '6', '1', '1', '0', 'admin', 'Setting', 'site', '', '网站信息', '', '网站信息');
INSERT INTO `st_admin_menu` VALUES ('72', '71', '2', '0', '10000', 'admin', 'Setting', 'sitePost', '', '网站信息设置提交', '', '网站信息设置提交');
INSERT INTO `st_admin_menu` VALUES ('73', '6', '1', '0', '10000', 'admin', 'Setting', 'password', '', '密码修改', '', '密码修改');
INSERT INTO `st_admin_menu` VALUES ('74', '73', '2', '0', '10000', 'admin', 'Setting', 'passwordPost', '', '密码修改提交', '', '密码修改提交');
INSERT INTO `st_admin_menu` VALUES ('75', '6', '1', '1', '10000', 'admin', 'Setting', 'upload', '', '上传设置', '', '上传设置');
INSERT INTO `st_admin_menu` VALUES ('76', '75', '2', '0', '10000', 'admin', 'Setting', 'uploadPost', '', '上传设置提交', '', '上传设置提交');
INSERT INTO `st_admin_menu` VALUES ('77', '6', '1', '0', '10000', 'admin', 'Setting', 'clearCache', '', '清除缓存', '', '清除缓存');
INSERT INTO `st_admin_menu` VALUES ('78', '183', '1', '1', '40', 'admin', 'Slide', 'index', '', '轮播图管理', '', '轮播图管理');
INSERT INTO `st_admin_menu` VALUES ('79', '78', '1', '0', '10000', 'admin', 'Slide', 'add', '', '添加幻灯片', '', '添加幻灯片');
INSERT INTO `st_admin_menu` VALUES ('80', '78', '2', '0', '10000', 'admin', 'Slide', 'addPost', '', '添加幻灯片提交', '', '添加幻灯片提交');
INSERT INTO `st_admin_menu` VALUES ('81', '78', '1', '0', '10000', 'admin', 'Slide', 'edit', '', '编辑幻灯片', '', '编辑幻灯片');
INSERT INTO `st_admin_menu` VALUES ('82', '78', '2', '0', '10000', 'admin', 'Slide', 'editPost', '', '编辑幻灯片提交', '', '编辑幻灯片提交');
INSERT INTO `st_admin_menu` VALUES ('83', '78', '2', '0', '10000', 'admin', 'Slide', 'delete', '', '删除幻灯片', '', '删除幻灯片');
INSERT INTO `st_admin_menu` VALUES ('84', '78', '1', '0', '10000', 'admin', 'SlideItem', 'index', '', '幻灯片页面列表', '', '幻灯片页面列表');
INSERT INTO `st_admin_menu` VALUES ('85', '84', '1', '0', '10000', 'admin', 'SlideItem', 'add', '', '幻灯片页面添加', '', '幻灯片页面添加');
INSERT INTO `st_admin_menu` VALUES ('86', '84', '2', '0', '10000', 'admin', 'SlideItem', 'addPost', '', '幻灯片页面添加提交', '', '幻灯片页面添加提交');
INSERT INTO `st_admin_menu` VALUES ('87', '84', '1', '0', '10000', 'admin', 'SlideItem', 'edit', '', '幻灯片页面编辑', '', '幻灯片页面编辑');
INSERT INTO `st_admin_menu` VALUES ('88', '84', '2', '0', '10000', 'admin', 'SlideItem', 'editPost', '', '幻灯片页面编辑提交', '', '幻灯片页面编辑提交');
INSERT INTO `st_admin_menu` VALUES ('89', '84', '2', '0', '10000', 'admin', 'SlideItem', 'delete', '', '幻灯片页面删除', '', '幻灯片页面删除');
INSERT INTO `st_admin_menu` VALUES ('90', '84', '2', '0', '10000', 'admin', 'SlideItem', 'ban', '', '幻灯片页面隐藏', '', '幻灯片页面隐藏');
INSERT INTO `st_admin_menu` VALUES ('91', '84', '2', '0', '10000', 'admin', 'SlideItem', 'cancelBan', '', '幻灯片页面显示', '', '幻灯片页面显示');
INSERT INTO `st_admin_menu` VALUES ('92', '84', '2', '0', '10000', 'admin', 'SlideItem', 'listOrder', '', '幻灯片页面排序', '', '幻灯片页面排序');
INSERT INTO `st_admin_menu` VALUES ('93', '6', '1', '1', '10000', 'admin', 'Storage', 'index', '', '文件存储', '', '文件存储');
INSERT INTO `st_admin_menu` VALUES ('94', '93', '2', '0', '10000', 'admin', 'Storage', 'settingPost', '', '文件存储设置提交', '', '文件存储设置提交');
INSERT INTO `st_admin_menu` VALUES ('95', '6', '1', '1', '20', 'admin', 'Theme', 'index', '', '模板管理', '', '模板管理');
INSERT INTO `st_admin_menu` VALUES ('96', '95', '1', '0', '10000', 'admin', 'Theme', 'install', '', '安装模板', '', '安装模板');
INSERT INTO `st_admin_menu` VALUES ('97', '95', '2', '0', '10000', 'admin', 'Theme', 'uninstall', '', '卸载模板', '', '卸载模板');
INSERT INTO `st_admin_menu` VALUES ('98', '95', '2', '0', '10000', 'admin', 'Theme', 'installTheme', '', '模板安装', '', '模板安装');
INSERT INTO `st_admin_menu` VALUES ('99', '95', '2', '0', '10000', 'admin', 'Theme', 'update', '', '模板更新', '', '模板更新');
INSERT INTO `st_admin_menu` VALUES ('100', '95', '2', '0', '10000', 'admin', 'Theme', 'active', '', '启用模板', '', '启用模板');
INSERT INTO `st_admin_menu` VALUES ('101', '95', '1', '0', '10000', 'admin', 'Theme', 'files', '', '模板文件列表', '', '启用模板');
INSERT INTO `st_admin_menu` VALUES ('102', '95', '1', '0', '10000', 'admin', 'Theme', 'fileSetting', '', '模板文件设置', '', '模板文件设置');
INSERT INTO `st_admin_menu` VALUES ('103', '95', '1', '0', '10000', 'admin', 'Theme', 'fileArrayData', '', '模板文件数组数据列表', '', '模板文件数组数据列表');
INSERT INTO `st_admin_menu` VALUES ('104', '95', '2', '0', '10000', 'admin', 'Theme', 'fileArrayDataEdit', '', '模板文件数组数据添加编辑', '', '模板文件数组数据添加编辑');
INSERT INTO `st_admin_menu` VALUES ('105', '95', '2', '0', '10000', 'admin', 'Theme', 'fileArrayDataEditPost', '', '模板文件数组数据添加编辑提交保存', '', '模板文件数组数据添加编辑提交保存');
INSERT INTO `st_admin_menu` VALUES ('106', '95', '2', '0', '10000', 'admin', 'Theme', 'fileArrayDataDelete', '', '模板文件数组数据删除', '', '模板文件数组数据删除');
INSERT INTO `st_admin_menu` VALUES ('107', '95', '2', '0', '10000', 'admin', 'Theme', 'settingPost', '', '模板文件编辑提交保存', '', '模板文件编辑提交保存');
INSERT INTO `st_admin_menu` VALUES ('108', '95', '1', '0', '10000', 'admin', 'Theme', 'dataSource', '', '模板文件设置数据源', '', '模板文件设置数据源');
INSERT INTO `st_admin_menu` VALUES ('109', '95', '1', '0', '10000', 'admin', 'Theme', 'design', '', '模板设计', '', '模板设计');
INSERT INTO `st_admin_menu` VALUES ('110', '0', '0', '1', '10', 'user', 'AdminIndex', 'default', '', '用户管理', 'group', '用户管理');
INSERT INTO `st_admin_menu` VALUES ('111', '49', '1', '1', '10000', 'admin', 'User', 'index', '', '管理员', '', '管理员管理');
INSERT INTO `st_admin_menu` VALUES ('112', '111', '1', '0', '10000', 'admin', 'User', 'add', '', '管理员添加', '', '管理员添加');
INSERT INTO `st_admin_menu` VALUES ('113', '111', '2', '0', '10000', 'admin', 'User', 'addPost', '', '管理员添加提交', '', '管理员添加提交');
INSERT INTO `st_admin_menu` VALUES ('114', '111', '1', '0', '10000', 'admin', 'User', 'edit', '', '管理员编辑', '', '管理员编辑');
INSERT INTO `st_admin_menu` VALUES ('115', '111', '2', '0', '10000', 'admin', 'User', 'editPost', '', '管理员编辑提交', '', '管理员编辑提交');
INSERT INTO `st_admin_menu` VALUES ('116', '111', '1', '0', '10000', 'admin', 'User', 'userInfo', '', '个人信息', '', '管理员个人信息修改');
INSERT INTO `st_admin_menu` VALUES ('117', '111', '2', '0', '10000', 'admin', 'User', 'userInfoPost', '', '管理员个人信息修改提交', '', '管理员个人信息修改提交');
INSERT INTO `st_admin_menu` VALUES ('118', '111', '2', '0', '10000', 'admin', 'User', 'delete', '', '管理员删除', '', '管理员删除');
INSERT INTO `st_admin_menu` VALUES ('119', '111', '2', '0', '10000', 'admin', 'User', 'ban', '', '停用管理员', '', '停用管理员');
INSERT INTO `st_admin_menu` VALUES ('120', '111', '2', '0', '10000', 'admin', 'User', 'cancelBan', '', '启用管理员', '', '启用管理员');
INSERT INTO `st_admin_menu` VALUES ('121', '0', '0', '1', '10000', 'portal', 'AdminIndex', 'default', '', '文章', 'th', '门户管理');
INSERT INTO `st_admin_menu` VALUES ('122', '121', '1', '1', '10000', 'portal', 'AdminArticle', 'index', '', '文章管理', '', '文章列表');
INSERT INTO `st_admin_menu` VALUES ('123', '122', '1', '0', '10000', 'portal', 'AdminArticle', 'add', '', '添加文章', '', '添加文章');
INSERT INTO `st_admin_menu` VALUES ('124', '122', '2', '0', '10000', 'portal', 'AdminArticle', 'addPost', '', '添加文章提交', '', '添加文章提交');
INSERT INTO `st_admin_menu` VALUES ('125', '122', '1', '0', '10000', 'portal', 'AdminArticle', 'edit', '', '编辑文章', '', '编辑文章');
INSERT INTO `st_admin_menu` VALUES ('126', '122', '2', '0', '10000', 'portal', 'AdminArticle', 'editPost', '', '编辑文章提交', '', '编辑文章提交');
INSERT INTO `st_admin_menu` VALUES ('127', '122', '2', '0', '10000', 'portal', 'AdminArticle', 'delete', '', '文章删除', '', '文章删除');
INSERT INTO `st_admin_menu` VALUES ('128', '122', '2', '0', '10000', 'portal', 'AdminArticle', 'publish', '', '文章发布', '', '文章发布');
INSERT INTO `st_admin_menu` VALUES ('129', '122', '2', '0', '10000', 'portal', 'AdminArticle', 'top', '', '文章置顶', '', '文章置顶');
INSERT INTO `st_admin_menu` VALUES ('130', '122', '2', '0', '10000', 'portal', 'AdminArticle', 'recommend', '', '文章推荐', '', '文章推荐');
INSERT INTO `st_admin_menu` VALUES ('131', '122', '2', '0', '10000', 'portal', 'AdminArticle', 'listOrder', '', '文章排序', '', '文章排序');
INSERT INTO `st_admin_menu` VALUES ('132', '121', '1', '1', '10000', 'portal', 'AdminCategory', 'index', '', '分类管理', '', '文章分类列表');
INSERT INTO `st_admin_menu` VALUES ('133', '132', '1', '0', '10000', 'portal', 'AdminCategory', 'add', '', '添加文章分类', '', '添加文章分类');
INSERT INTO `st_admin_menu` VALUES ('134', '132', '2', '0', '10000', 'portal', 'AdminCategory', 'addPost', '', '添加文章分类提交', '', '添加文章分类提交');
INSERT INTO `st_admin_menu` VALUES ('135', '132', '1', '0', '10000', 'portal', 'AdminCategory', 'edit', '', '编辑文章分类', '', '编辑文章分类');
INSERT INTO `st_admin_menu` VALUES ('136', '132', '2', '0', '10000', 'portal', 'AdminCategory', 'editPost', '', '编辑文章分类提交', '', '编辑文章分类提交');
INSERT INTO `st_admin_menu` VALUES ('137', '132', '1', '0', '10000', 'portal', 'AdminCategory', 'select', '', '文章分类选择对话框', '', '文章分类选择对话框');
INSERT INTO `st_admin_menu` VALUES ('138', '132', '2', '0', '10000', 'portal', 'AdminCategory', 'listOrder', '', '文章分类排序', '', '文章分类排序');
INSERT INTO `st_admin_menu` VALUES ('139', '132', '2', '0', '10000', 'portal', 'AdminCategory', 'delete', '', '删除文章分类', '', '删除文章分类');
INSERT INTO `st_admin_menu` VALUES ('140', '121', '1', '1', '10000', 'portal', 'AdminPage', 'index', '', '页面管理', '', '页面管理');
INSERT INTO `st_admin_menu` VALUES ('141', '140', '1', '0', '10000', 'portal', 'AdminPage', 'add', '', '添加页面', '', '添加页面');
INSERT INTO `st_admin_menu` VALUES ('142', '140', '2', '0', '10000', 'portal', 'AdminPage', 'addPost', '', '添加页面提交', '', '添加页面提交');
INSERT INTO `st_admin_menu` VALUES ('143', '140', '1', '0', '10000', 'portal', 'AdminPage', 'edit', '', '编辑页面', '', '编辑页面');
INSERT INTO `st_admin_menu` VALUES ('144', '140', '2', '0', '10000', 'portal', 'AdminPage', 'editPost', '', '编辑页面提交', '', '编辑页面提交');
INSERT INTO `st_admin_menu` VALUES ('145', '140', '2', '0', '10000', 'portal', 'AdminPage', 'delete', '', '删除页面', '', '删除页面');
INSERT INTO `st_admin_menu` VALUES ('146', '121', '1', '1', '10000', 'portal', 'AdminTag', 'index', '', '文章标签', '', '文章标签');
INSERT INTO `st_admin_menu` VALUES ('147', '146', '1', '0', '10000', 'portal', 'AdminTag', 'add', '', '添加文章标签', '', '添加文章标签');
INSERT INTO `st_admin_menu` VALUES ('148', '146', '2', '0', '10000', 'portal', 'AdminTag', 'addPost', '', '添加文章标签提交', '', '添加文章标签提交');
INSERT INTO `st_admin_menu` VALUES ('149', '146', '2', '0', '10000', 'portal', 'AdminTag', 'upStatus', '', '更新标签状态', '', '更新标签状态');
INSERT INTO `st_admin_menu` VALUES ('150', '146', '2', '0', '10000', 'portal', 'AdminTag', 'delete', '', '删除文章标签', '', '删除文章标签');
INSERT INTO `st_admin_menu` VALUES ('151', '0', '1', '1', '40', 'user', 'AdminAsset', 'index', '', '资源管理', 'file', '资源管理列表');
INSERT INTO `st_admin_menu` VALUES ('152', '151', '2', '0', '10000', 'user', 'AdminAsset', 'delete', '', '删除文件', '', '删除文件');
INSERT INTO `st_admin_menu` VALUES ('153', '110', '0', '1', '10000', 'user', 'AdminIndex', 'default1', '', '用户组', '', '用户组');
INSERT INTO `st_admin_menu` VALUES ('154', '153', '1', '1', '10000', 'user', 'AdminIndex', 'index', '', '本站用户', '', '本站用户');
INSERT INTO `st_admin_menu` VALUES ('155', '154', '2', '0', '10000', 'user', 'AdminIndex', 'ban', '', '本站用户拉黑', '', '本站用户拉黑');
INSERT INTO `st_admin_menu` VALUES ('156', '154', '2', '0', '10000', 'user', 'AdminIndex', 'cancelBan', '', '本站用户启用', '', '本站用户启用');
INSERT INTO `st_admin_menu` VALUES ('157', '153', '1', '1', '10000', 'user', 'AdminOauth', 'index', '', '第三方用户', '', '第三方用户');
INSERT INTO `st_admin_menu` VALUES ('158', '157', '2', '0', '10000', 'user', 'AdminOauth', 'delete', '', '删除第三方用户绑定', '', '删除第三方用户绑定');
INSERT INTO `st_admin_menu` VALUES ('159', '6', '1', '1', '10000', 'user', 'AdminUserAction', 'index', '', '用户操作管理', '', '用户操作管理');
INSERT INTO `st_admin_menu` VALUES ('160', '159', '1', '0', '10000', 'user', 'AdminUserAction', 'edit', '', '编辑用户操作', '', '编辑用户操作');
INSERT INTO `st_admin_menu` VALUES ('161', '159', '2', '0', '10000', 'user', 'AdminUserAction', 'editPost', '', '编辑用户操作提交', '', '编辑用户操作提交');
INSERT INTO `st_admin_menu` VALUES ('162', '159', '1', '0', '10000', 'user', 'AdminUserAction', 'sync', '', '同步用户操作', '', '同步用户操作');
INSERT INTO `st_admin_menu` VALUES ('169', '1', '1', '1', '10000', 'plugin/Wxapp', 'AdminIndex', 'index', '', '小程序管理', '', '小程序管理');
INSERT INTO `st_admin_menu` VALUES ('170', '169', '1', '0', '10000', 'plugin/Wxapp', 'AdminWxapp', 'add', '', '添加小程序', '', '添加小程序');
INSERT INTO `st_admin_menu` VALUES ('171', '169', '2', '0', '10000', 'plugin/Wxapp', 'AdminWxapp', 'addPost', '', '添加小程序提交保存', '', '添加小程序提交保存');
INSERT INTO `st_admin_menu` VALUES ('172', '169', '1', '0', '10000', 'plugin/Wxapp', 'AdminWxapp', 'edit', '', '编辑小程序', '', '编辑小程序');
INSERT INTO `st_admin_menu` VALUES ('173', '169', '2', '0', '10000', 'plugin/Wxapp', 'AdminWxapp', 'editPost', '', '编辑小程序提交保存', '', '编辑小程序');
INSERT INTO `st_admin_menu` VALUES ('174', '169', '2', '0', '10000', 'plugin/Wxapp', 'AdminWxapp', 'delete', '', '删除小程序', '', '删除小程序');
INSERT INTO `st_admin_menu` VALUES ('175', '0', '1', '1', '10000', 'admin', 'Exam', 'default', '', '应用', 'book', '');
INSERT INTO `st_admin_menu` VALUES ('176', '175', '1', '1', '2', 'admin', 'Exam', 'index', '', '刷题试卷', '', 'pencil');
INSERT INTO `st_admin_menu` VALUES ('177', '175', '1', '1', '1', 'admin', 'Category', 'index', '', '综合分类', 'book', '');
INSERT INTO `st_admin_menu` VALUES ('178', '175', '1', '1', '3', 'admin', 'Course', 'index', '', '在线课堂', '', '');
INSERT INTO `st_admin_menu` VALUES ('179', '175', '1', '1', '10', 'admin', 'Course', 'teacher', '', '课题讲师列表', '', '');
INSERT INTO `st_admin_menu` VALUES ('180', '185', '1', '1', '10000', 'Admin', 'daka', 'index', '', '打卡', '', '');
INSERT INTO `st_admin_menu` VALUES ('181', '175', '1', '1', '10000', 'admin', 'school', 'index', '', '学校列表', '', '');
INSERT INTO `st_admin_menu` VALUES ('182', '175', '1', '1', '10000', 'admin', 'goods', 'index', '', '商品管理', '', '');
INSERT INTO `st_admin_menu` VALUES ('183', '0', '1', '1', '10000', 'admin', 'recommend', 'default', '', '运营', '', '');
INSERT INTO `st_admin_menu` VALUES ('184', '183', '1', '1', '10000', 'admin', 'recommend', 'index', '', '搜索推荐', '', '');
INSERT INTO `st_admin_menu` VALUES ('185', '0', '1', '1', '10000', 'admin', 'Daka', 'default', '', '打卡', '', '');
INSERT INTO `st_admin_menu` VALUES ('186', '185', '1', '1', '10000', 'admin', 'Daka', 'teacher_daka_list', '', '评图', '', '');

-- ----------------------------
-- Table structure for st_asset
-- ----------------------------
DROP TABLE IF EXISTS `st_asset`;
CREATE TABLE `st_asset` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `file_size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小,单位B',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:可用,0:不可用',
  `download_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `file_key` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件惟一码',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `file_path` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件路径,相对于upload目录,可以为url',
  `file_md5` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件md5值',
  `file_sha1` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `suffix` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名,不包括点',
  `more` text COMMENT '其它详细信息,JSON格式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COMMENT='资源表';

-- ----------------------------
-- Records of st_asset
-- ----------------------------
INSERT INTO `st_asset` VALUES ('75', '1', '867', '1549118293', '1', '0', '52b45ebeeb7899141c39bb82abaeeb57f41568f135c4a7ad9ae75dfc2c2f84fe', 'f51343b9c0b914977570ba2bd6609556.jpg', 'admin/20190202/3c974c460d567e376438ba0bbffe1ac4.jpg', '52b45ebeeb7899141c39bb82abaeeb57', '94ac014ce3505dc8b054d69a57019ae3222a1678', 'jpg', null);
INSERT INTO `st_asset` VALUES ('76', '1', '3550', '1549124666', '1', '0', 'f532842102054655618be69e1bc8b27d265b4de802aaa3aa6d719f01fb51d817', '8528d8fc2ee145a9bdfc6314af382e88.jpg', 'admin/20190203/cda735d84e1f1789369736764f3e91d2.jpg', 'f532842102054655618be69e1bc8b27d', '135e6be9a0387f6edd45977775b1bd5b0812a2e9', 'jpg', null);
INSERT INTO `st_asset` VALUES ('77', '1', '4016', '1549124748', '1', '0', 'd2909dfe5d85ee9f868d937826af100598eeab7f17dd70e73de651d35057216e', '483ec8222b824f868e40a32b32295d07.jpg', 'admin/20190203/fc0116bdbc530e1be12a762d19fdf89f.jpg', 'd2909dfe5d85ee9f868d937826af1005', '430141ef95b2ce08b48f36592d22bde9f8bbdd08', 'jpg', null);
INSERT INTO `st_asset` VALUES ('78', '1', '2896', '1549125173', '1', '0', '94a2841285a67f6102263b1a0c56ab7f93eef0dce924e2ff9921087f964e61ca', '51a1dc1df648122e0502f94cc2a07158.jpg', 'admin/20190203/1054aa221a00ac24f939ca1469a0e02b.jpg', '94a2841285a67f6102263b1a0c56ab7f', '2b85ea97597793547d6b2d6d2bba9fbcf05abb74', 'jpg', null);
INSERT INTO `st_asset` VALUES ('79', '1', '2291', '1549125776', '1', '0', 'c28eb8582dc63998a81c9e6c785b87d90bd700345b7920f43cf621b7c8b80e29', '48b56854b52e7c791bc5048f37bdf4db.jpg', 'default/20190203/ca9b5ab9683337b5514270fbf9b21f3d.jpg', 'c28eb8582dc63998a81c9e6c785b87d9', '8a4778b3eab01d5ac014466a4d1b9ee9b38d8939', 'jpg', null);
INSERT INTO `st_asset` VALUES ('80', '3', '191777', '1550759812', '1', '0', '79522026b797d5f7b778f7e669f98a40a735f8c60c7ded9dc7fde803bfd1e464', '59fce102c9d3b09f3d510cb765d81f89.jpg', 'admin/20190221/15aa57836fbcd0d60613cf5b5bdc9140.jpg', '79522026b797d5f7b778f7e669f98a40', '56a6543dafc032824dc39a227973a144bc0ada84', 'jpg', null);
INSERT INTO `st_asset` VALUES ('81', '3', '214636', '1550759813', '1', '0', '6838104c72b482cc70151a70e78ba0c67d74eb51d5bc0b100e195c7fdb33dcac', 'b6696eeb1703059cf36a292181ae4670.jpg', 'admin/20190221/37baae87277cb793035cfce644103e95.jpg', '6838104c72b482cc70151a70e78ba0c6', '09c625d73163f88a01f26cf8159ea008c83c31cc', 'jpg', null);
INSERT INTO `st_asset` VALUES ('82', '3', '38291', '1550759829', '1', '0', '08fecb7505a91202c338488a10d3f95edd5f84492f8bcb26f069288dfafe6ba6', '1c165819a17e250a4b17f3fcb2266a67.jpg', 'admin/20190221/587828e70e057cff6144c851ddcf513a.jpg', '08fecb7505a91202c338488a10d3f95e', 'ec618a47e9f801ce273c096c2cd19b2824986aee', 'jpg', null);
INSERT INTO `st_asset` VALUES ('83', '3', '13812', '1550759846', '1', '0', '22b440e75f4abd70ecd480672ae908a42039efd48b005c05734ae8a80487aa7d', 'cb1a8729d8fe1acc2a1d16c12259d589.jpg', 'admin/20190221/8565b1c66109950a12003bfce5cb9ddb.jpg', '22b440e75f4abd70ecd480672ae908a4', 'be6fa33f4b4fc56d0ad6590ed551c28ff2b59c22', 'jpg', null);
INSERT INTO `st_asset` VALUES ('84', '3', '60145', '1550765584', '1', '0', 'a005b53ab6a31d2ce6d2e58e9af3950f606c77d705b78dd85bb3946ef86b3bd2', '06c573d6555a4f9e65edd878fd68f66d_1.jpg', 'admin/20190222/409de2975030c03324fc67e913eb7eaa.jpg', 'a005b53ab6a31d2ce6d2e58e9af3950f', '643c3533ed46c23bc4e4633a8189470554b49471', 'jpg', null);
INSERT INTO `st_asset` VALUES ('85', '3', '60145', '1550765668', '1', '0', 'a005b53ab6a31d2ce6d2e58e9af3950f606c77d705b78dd85bb3946ef86b3bd2', '06c573d6555a4f9e65edd878fd68f66d_1.jpg', 'admin/20190222/2a7eab13197288e7ea50f0e9af12d6d5.jpg', 'a005b53ab6a31d2ce6d2e58e9af3950f', '643c3533ed46c23bc4e4633a8189470554b49471', 'jpg', null);
INSERT INTO `st_asset` VALUES ('86', '1', '900', '1550765799', '1', '0', 'f9c0f75e7e1dd6eacd99b0bda00f36d46f62cea124678b8225514ba2c255dce6', 'demo.txt', 'portal/20190222/f8880326896ce6ebd1f7c4a6901cec33.txt', 'f9c0f75e7e1dd6eacd99b0bda00f36d4', '900cdc6431d24d2d96d91106d0c5134b8a832a2c', 'txt', null);
INSERT INTO `st_asset` VALUES ('87', '3', '60145', '1550765852', '1', '0', 'a005b53ab6a31d2ce6d2e58e9af3950f606c77d705b78dd85bb3946ef86b3bd2', '06c573d6555a4f9e65edd878fd68f66d_1.jpg', 'admin/20190222/1280fd685b53ee5bdcb1cb11440bc996.jpg', 'a005b53ab6a31d2ce6d2e58e9af3950f', '643c3533ed46c23bc4e4633a8189470554b49471', 'jpg', null);
INSERT INTO `st_asset` VALUES ('88', '3', '60145', '1550765889', '1', '0', 'a005b53ab6a31d2ce6d2e58e9af3950f606c77d705b78dd85bb3946ef86b3bd2', '06c573d6555a4f9e65edd878fd68f66d_1.jpg', 'admin/20190222/a98edc70eb9b5e18dbd134dccdda9413.jpg', 'a005b53ab6a31d2ce6d2e58e9af3950f', '643c3533ed46c23bc4e4633a8189470554b49471', 'jpg', null);
INSERT INTO `st_asset` VALUES ('89', '3', '100602', '1550765898', '1', '0', 'aca25f5a2cf99009e9f679e0c598ffba5b881147407f9a15463a24c554ea533a', 'cb7deb8e016c45a67b9ab644ed2524f9_1.jpg', 'admin/20190222/4251eea9e4e86d47756c06a79864adc7.jpg', 'aca25f5a2cf99009e9f679e0c598ffba', '260c8fcbd6a8fef66f2ae029c0e9c8798bae904d', 'jpg', null);
INSERT INTO `st_asset` VALUES ('90', '3', '60145', '1550766163', '1', '0', 'a005b53ab6a31d2ce6d2e58e9af3950f606c77d705b78dd85bb3946ef86b3bd2', '06c573d6555a4f9e65edd878fd68f66d_1.jpg', 'admin/20190222/f1e827aad7e9b93dbdd738af660290ca.jpg', 'a005b53ab6a31d2ce6d2e58e9af3950f', '643c3533ed46c23bc4e4633a8189470554b49471', 'jpg', null);
INSERT INTO `st_asset` VALUES ('91', '3', '100602', '1550766167', '1', '0', 'aca25f5a2cf99009e9f679e0c598ffba5b881147407f9a15463a24c554ea533a', 'cb7deb8e016c45a67b9ab644ed2524f9_1.jpg', 'admin/20190222/a0bcbf1bc3d108767f071c0351347ac0.jpg', 'aca25f5a2cf99009e9f679e0c598ffba', '260c8fcbd6a8fef66f2ae029c0e9c8798bae904d', 'jpg', null);
INSERT INTO `st_asset` VALUES ('92', '3', '60145', '1550766253', '1', '0', 'a005b53ab6a31d2ce6d2e58e9af3950f606c77d705b78dd85bb3946ef86b3bd2', '06c573d6555a4f9e65edd878fd68f66d_1.jpg', 'admin/20190222/55c798a132d2278bc01c681690669d89.jpg', 'a005b53ab6a31d2ce6d2e58e9af3950f', '643c3533ed46c23bc4e4633a8189470554b49471', 'jpg', null);
INSERT INTO `st_asset` VALUES ('93', '3', '100602', '1550766253', '1', '0', 'aca25f5a2cf99009e9f679e0c598ffba5b881147407f9a15463a24c554ea533a', 'cb7deb8e016c45a67b9ab644ed2524f9_1.jpg', 'admin/20190222/b3895e7686ac1353b440ba1ae30843bf.jpg', 'aca25f5a2cf99009e9f679e0c598ffba', '260c8fcbd6a8fef66f2ae029c0e9c8798bae904d', 'jpg', null);
INSERT INTO `st_asset` VALUES ('94', '3', '60145', '1550766304', '1', '0', 'a005b53ab6a31d2ce6d2e58e9af3950f606c77d705b78dd85bb3946ef86b3bd2', '06c573d6555a4f9e65edd878fd68f66d_1.jpg', 'admin/20190222/3d2224d4ee7eaf7f615d1da71f7ff472.jpg', 'a005b53ab6a31d2ce6d2e58e9af3950f', '643c3533ed46c23bc4e4633a8189470554b49471', 'jpg', null);
INSERT INTO `st_asset` VALUES ('95', '3', '100602', '1550766304', '1', '0', 'aca25f5a2cf99009e9f679e0c598ffba5b881147407f9a15463a24c554ea533a', 'cb7deb8e016c45a67b9ab644ed2524f9_1.jpg', 'admin/20190222/9e245d9976eb5583f17960a89af82b96.jpg', 'aca25f5a2cf99009e9f679e0c598ffba', '260c8fcbd6a8fef66f2ae029c0e9c8798bae904d', 'jpg', null);
INSERT INTO `st_asset` VALUES ('96', '3', '100602', '1550766347', '1', '0', 'aca25f5a2cf99009e9f679e0c598ffba5b881147407f9a15463a24c554ea533a', 'cb7deb8e016c45a67b9ab644ed2524f9_1.jpg', 'admin/20190222/edcab0ed115f6936bbc5aa561bfc22d3.jpg', 'aca25f5a2cf99009e9f679e0c598ffba', '260c8fcbd6a8fef66f2ae029c0e9c8798bae904d', 'jpg', null);
INSERT INTO `st_asset` VALUES ('97', '3', '38515', '1551018302', '1', '0', '615fb6bd6356fbd7c66a93911c074bfc99f6fae2d9316233d47c4c9f8491b724', '62a526018add58d2ed9becddc2a6841a_1.jpg', 'admin/20190224/bee3409d68d50c98e18d624241d7504a.jpg', '615fb6bd6356fbd7c66a93911c074bfc', 'c89bd63f4148783d15481118652e071e94242499', 'jpg', null);
INSERT INTO `st_asset` VALUES ('98', '3', '52323', '1551018310', '1', '0', '8b4275f67dda392173c37110c0269ff5d6ecdc0b513babab91149098d47a47dc', '7ddca0822818a08c453c5a4279a968e5_1.jpg', 'admin/20190224/c8d62de44fc505a5e0db1f1982ec4461.jpg', '8b4275f67dda392173c37110c0269ff5', '8a1ef494c37a2b4edbdf94e44d85d62f5167a8c5', 'jpg', null);
INSERT INTO `st_asset` VALUES ('99', '3', '38515', '1551019586', '1', '0', '615fb6bd6356fbd7c66a93911c074bfc99f6fae2d9316233d47c4c9f8491b724', '62a526018add58d2ed9becddc2a6841a_1.jpg', 'admin/20190224/867b4e315189bcdbff8f9dadd445cad7.jpg', '615fb6bd6356fbd7c66a93911c074bfc', 'c89bd63f4148783d15481118652e071e94242499', 'jpg', null);
INSERT INTO `st_asset` VALUES ('100', '3', '60145', '1551020281', '1', '0', 'a005b53ab6a31d2ce6d2e58e9af3950f606c77d705b78dd85bb3946ef86b3bd2', '06c573d6555a4f9e65edd878fd68f66d_1.jpg', 'admin/20190224/ee3c52b0d9b34dcc349cac1f886ab8cc.jpg', 'a005b53ab6a31d2ce6d2e58e9af3950f', '643c3533ed46c23bc4e4633a8189470554b49471', 'jpg', null);
INSERT INTO `st_asset` VALUES ('101', '3', '60145', '1551020357', '1', '0', 'a005b53ab6a31d2ce6d2e58e9af3950f606c77d705b78dd85bb3946ef86b3bd2', '06c573d6555a4f9e65edd878fd68f66d_1.jpg', 'admin/20190224/5338ad1117f63f4c96032b155928e5b5.jpg', 'a005b53ab6a31d2ce6d2e58e9af3950f', '643c3533ed46c23bc4e4633a8189470554b49471', 'jpg', null);
INSERT INTO `st_asset` VALUES ('102', '3', '38515', '1551020748', '1', '0', '615fb6bd6356fbd7c66a93911c074bfc99f6fae2d9316233d47c4c9f8491b724', '62a526018add58d2ed9becddc2a6841a_1.jpg', 'admin/20190224/c737ca41d7cd3bc651e8bea571f0b500.jpg', '615fb6bd6356fbd7c66a93911c074bfc', 'c89bd63f4148783d15481118652e071e94242499', 'jpg', null);
INSERT INTO `st_asset` VALUES ('103', '3', '60145', '1551020754', '1', '0', 'a005b53ab6a31d2ce6d2e58e9af3950f606c77d705b78dd85bb3946ef86b3bd2', '06c573d6555a4f9e65edd878fd68f66d_1.jpg', 'admin/20190224/7879616a24261e9d0a7aa727acb60aee.jpg', 'a005b53ab6a31d2ce6d2e58e9af3950f', '643c3533ed46c23bc4e4633a8189470554b49471', 'jpg', null);
INSERT INTO `st_asset` VALUES ('104', '3', '52323', '1551021042', '1', '0', '8b4275f67dda392173c37110c0269ff5d6ecdc0b513babab91149098d47a47dc', '7ddca0822818a08c453c5a4279a968e5_1.jpg', 'admin/20190224/14886cedaa81583bfda0e5d405d0e647.jpg', '8b4275f67dda392173c37110c0269ff5', '8a1ef494c37a2b4edbdf94e44d85d62f5167a8c5', 'jpg', null);
INSERT INTO `st_asset` VALUES ('105', '3', '60145', '1551021043', '1', '0', 'a005b53ab6a31d2ce6d2e58e9af3950f606c77d705b78dd85bb3946ef86b3bd2', '06c573d6555a4f9e65edd878fd68f66d_1.jpg', 'admin/20190224/4c1d9a97315d89dc6fdb5526cc6f3d73.jpg', 'a005b53ab6a31d2ce6d2e58e9af3950f', '643c3533ed46c23bc4e4633a8189470554b49471', 'jpg', null);
INSERT INTO `st_asset` VALUES ('106', '1', '4479', '1551197356', '1', '0', 'c3258116052216699931db020b3c48e9fab5eba5c9a722760ef4ca470181dfc4', '3f7e6a92169817e1bd736895062d7b58.jpg', 'admin/20190227/0b3abebd3819239e1ed9eac7bf1edc23.jpg', 'c3258116052216699931db020b3c48e9', '5ff0282ec7f74cfad3c7ac8f3c4991dbbc70a477', 'jpg', null);
INSERT INTO `st_asset` VALUES ('107', '1', '2687', '1551197372', '1', '0', '0b33f6b154e7ad5d5fd10368a0425a6c8508110812f7a68a1f25c38576413b5a', '50585619906dfedab77792fba4634003.jpg', 'admin/20190227/b10fb582511eb5ac5b37179c90458eb5.jpg', '0b33f6b154e7ad5d5fd10368a0425a6c', '10526afd8354cadb5929694e7ff621c2f0215a29', 'jpg', null);
INSERT INTO `st_asset` VALUES ('108', '1', '2556', '1551197414', '1', '0', '3235b75f72dd5be8dc3723b5e35269176948e6346aaa4581ee2b8d9fc30ac586', '44f732fa77d8f0c25fd2ed5e06c3f161.jpg', 'admin/20190227/1ad018840d3f1f2119a7397f564a0043.jpg', '3235b75f72dd5be8dc3723b5e3526917', 'd9bb0864fb7026093c40d8824109fc98575c6e86', 'jpg', null);
INSERT INTO `st_asset` VALUES ('109', '1', '2788', '1551197426', '1', '0', '5a35327ff067b4a964f3d6f229d658908cc365dca8476840def6183bbc4505ac', '5fc6fdfb6a6e900ffd71e1fabd9562ad.jpg', 'admin/20190227/8aa82b97d4273af4ef3c10a8b9c5e2c9.jpg', '5a35327ff067b4a964f3d6f229d65890', '1901e66bcc42db1fd43837e30dd422aa1ac03df2', 'jpg', null);
INSERT INTO `st_asset` VALUES ('110', '1', '6250', '1551710968', '1', '0', '25c49ee6d5d5e202d1e1bc2560b306ec6c34b813c55b9a6c8829237e2b4d51c5', '0d8fb9388ed02af4b24dff64f9bb187b.jpg', 'admin/20190304/0f2f19076456a2d25a0e34d6e7bf8191.jpg', '25c49ee6d5d5e202d1e1bc2560b306ec', 'e4cf733e88b45769e9c9e863a11e9db25a421edf', 'jpg', null);
INSERT INTO `st_asset` VALUES ('111', '1', '5110', '1551710975', '1', '0', 'f1dc9c62a1c9bb76d453cbb39e1a2b10b06e9a67ddc2f0f5417a40712a7e2fb5', '1ad2479990bfd5848520bd01ba53063d.jpg', 'admin/20190304/009a520e8c1ceb0c8470a13dd7da176a.jpg', 'f1dc9c62a1c9bb76d453cbb39e1a2b10', 'c0c1840c3182907792edf329311d245edc77d3a0', 'jpg', null);
INSERT INTO `st_asset` VALUES ('112', '1', '153551', '1551710994', '1', '0', '09dc11931a923ec0e3285bb3ef8e26eac05e9e984e020107725f570ebca43773', '2c63501adc9a6a7bfe6855dd2eb0f9fd.jpg', 'admin/20190304/1a8bbc43fb93d85faecd48c8a3be80d7.jpg', '09dc11931a923ec0e3285bb3ef8e26ea', '58b9a17f6c57f6ac9ec145eb1a5b9c91699ab354', 'jpg', null);
INSERT INTO `st_asset` VALUES ('113', '1', '11827', '1551711150', '1', '0', 'f0eb97bd24cf9ec059c87479a8412f753ce30ac7da58babc7906da6760f8bc40', '001b35694e3655dfdc21a249a657ab65.jpg', 'admin/20190304/045c3f0857d22767de806549bb01cf24.jpg', 'f0eb97bd24cf9ec059c87479a8412f75', 'c8bcf595db4ef6f2908f9c04601aebae2c41e354', 'jpg', null);
INSERT INTO `st_asset` VALUES ('114', '1', '3684', '1551711159', '1', '0', 'd373ab51c1e3c9a951c0265abc779e3de45462f6c8c3035bab8ae7f82b84bec1', '1a984018b92dc0e0bca0b2c92ab3dc98.jpg', 'admin/20190304/5694605cf3ccbe46c251a3194b13e2fd.jpg', 'd373ab51c1e3c9a951c0265abc779e3d', '8d0a382a1a099afb65cd32bfe171f6977e7272fc', 'jpg', null);
INSERT INTO `st_asset` VALUES ('115', '1', '11827', '1551711358', '1', '0', 'f0eb97bd24cf9ec059c87479a8412f753ce30ac7da58babc7906da6760f8bc40', '001b35694e3655dfdc21a249a657ab65.jpg', 'admin/20190304/faa9ac87b8952fc92645330e8a27e7cc.jpg', 'f0eb97bd24cf9ec059c87479a8412f75', 'c8bcf595db4ef6f2908f9c04601aebae2c41e354', 'jpg', null);

-- ----------------------------
-- Table structure for st_auth_access
-- ----------------------------
DROP TABLE IF EXISTS `st_auth_access`;
CREATE TABLE `st_auth_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL COMMENT '角色',
  `rule_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类,请加应用前缀,如admin_',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`rule_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='权限授权表';

-- ----------------------------
-- Records of st_auth_access
-- ----------------------------
INSERT INTO `st_auth_access` VALUES ('6', '3', 'admin/daka/default', 'admin_url');
INSERT INTO `st_auth_access` VALUES ('7', '3', 'admin/daka/index', 'admin_url');
INSERT INTO `st_auth_access` VALUES ('8', '3', 'admin/daka/teacher_daka_list', 'admin_url');

-- ----------------------------
-- Table structure for st_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `st_auth_rule`;
CREATE TABLE `st_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `app` varchar(40) NOT NULL DEFAULT '' COMMENT '规则所属app',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类，请加应用前缀,如admin_',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `param` varchar(100) NOT NULL DEFAULT '' COMMENT '额外url参数',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则描述',
  `condition` varchar(200) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `module` (`app`,`status`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8mb4 COMMENT='权限规则表';

-- ----------------------------
-- Records of st_auth_rule
-- ----------------------------
INSERT INTO `st_auth_rule` VALUES ('1', '1', 'admin', 'admin_url', 'admin/Hook/index', '', '钩子管理', '');
INSERT INTO `st_auth_rule` VALUES ('2', '1', 'admin', 'admin_url', 'admin/Hook/plugins', '', '钩子插件管理', '');
INSERT INTO `st_auth_rule` VALUES ('3', '1', 'admin', 'admin_url', 'admin/Hook/pluginListOrder', '', '钩子插件排序', '');
INSERT INTO `st_auth_rule` VALUES ('4', '1', 'admin', 'admin_url', 'admin/Hook/sync', '', '同步钩子', '');
INSERT INTO `st_auth_rule` VALUES ('5', '1', 'admin', 'admin_url', 'admin/Link/index', '', '友情链接', '');
INSERT INTO `st_auth_rule` VALUES ('6', '1', 'admin', 'admin_url', 'admin/Link/add', '', '添加友情链接', '');
INSERT INTO `st_auth_rule` VALUES ('7', '1', 'admin', 'admin_url', 'admin/Link/addPost', '', '添加友情链接提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('8', '1', 'admin', 'admin_url', 'admin/Link/edit', '', '编辑友情链接', '');
INSERT INTO `st_auth_rule` VALUES ('9', '1', 'admin', 'admin_url', 'admin/Link/editPost', '', '编辑友情链接提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('10', '1', 'admin', 'admin_url', 'admin/Link/delete', '', '删除友情链接', '');
INSERT INTO `st_auth_rule` VALUES ('11', '1', 'admin', 'admin_url', 'admin/Link/listOrder', '', '友情链接排序', '');
INSERT INTO `st_auth_rule` VALUES ('12', '1', 'admin', 'admin_url', 'admin/Link/toggle', '', '友情链接显示隐藏', '');
INSERT INTO `st_auth_rule` VALUES ('13', '1', 'admin', 'admin_url', 'admin/Mailer/index', '', '邮箱配置', '');
INSERT INTO `st_auth_rule` VALUES ('14', '1', 'admin', 'admin_url', 'admin/Mailer/indexPost', '', '邮箱配置提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('15', '1', 'admin', 'admin_url', 'admin/Mailer/template', '', '邮件模板', '');
INSERT INTO `st_auth_rule` VALUES ('16', '1', 'admin', 'admin_url', 'admin/Mailer/templatePost', '', '邮件模板提交', '');
INSERT INTO `st_auth_rule` VALUES ('17', '1', 'admin', 'admin_url', 'admin/Mailer/test', '', '邮件发送测试', '');
INSERT INTO `st_auth_rule` VALUES ('18', '1', 'admin', 'admin_url', 'admin/Menu/index', '', '后台菜单', '');
INSERT INTO `st_auth_rule` VALUES ('19', '1', 'admin', 'admin_url', 'admin/Menu/lists', '', '所有菜单', '');
INSERT INTO `st_auth_rule` VALUES ('20', '1', 'admin', 'admin_url', 'admin/Menu/add', '', '后台菜单添加', '');
INSERT INTO `st_auth_rule` VALUES ('21', '1', 'admin', 'admin_url', 'admin/Menu/addPost', '', '后台菜单添加提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('22', '1', 'admin', 'admin_url', 'admin/Menu/edit', '', '后台菜单编辑', '');
INSERT INTO `st_auth_rule` VALUES ('23', '1', 'admin', 'admin_url', 'admin/Menu/editPost', '', '后台菜单编辑提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('24', '1', 'admin', 'admin_url', 'admin/Menu/delete', '', '后台菜单删除', '');
INSERT INTO `st_auth_rule` VALUES ('25', '1', 'admin', 'admin_url', 'admin/Menu/listOrder', '', '后台菜单排序', '');
INSERT INTO `st_auth_rule` VALUES ('26', '1', 'admin', 'admin_url', 'admin/Menu/getActions', '', '导入新后台菜单', '');
INSERT INTO `st_auth_rule` VALUES ('27', '1', 'admin', 'admin_url', 'admin/Nav/index', '', '导航管理', '');
INSERT INTO `st_auth_rule` VALUES ('28', '1', 'admin', 'admin_url', 'admin/Nav/add', '', '添加导航', '');
INSERT INTO `st_auth_rule` VALUES ('29', '1', 'admin', 'admin_url', 'admin/Nav/addPost', '', '添加导航提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('30', '1', 'admin', 'admin_url', 'admin/Nav/edit', '', '编辑导航', '');
INSERT INTO `st_auth_rule` VALUES ('31', '1', 'admin', 'admin_url', 'admin/Nav/editPost', '', '编辑导航提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('32', '1', 'admin', 'admin_url', 'admin/Nav/delete', '', '删除导航', '');
INSERT INTO `st_auth_rule` VALUES ('33', '1', 'admin', 'admin_url', 'admin/NavMenu/index', '', '导航菜单', '');
INSERT INTO `st_auth_rule` VALUES ('34', '1', 'admin', 'admin_url', 'admin/NavMenu/add', '', '添加导航菜单', '');
INSERT INTO `st_auth_rule` VALUES ('35', '1', 'admin', 'admin_url', 'admin/NavMenu/addPost', '', '添加导航菜单提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('36', '1', 'admin', 'admin_url', 'admin/NavMenu/edit', '', '编辑导航菜单', '');
INSERT INTO `st_auth_rule` VALUES ('37', '1', 'admin', 'admin_url', 'admin/NavMenu/editPost', '', '编辑导航菜单提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('38', '1', 'admin', 'admin_url', 'admin/NavMenu/delete', '', '删除导航菜单', '');
INSERT INTO `st_auth_rule` VALUES ('39', '1', 'admin', 'admin_url', 'admin/NavMenu/listOrder', '', '导航菜单排序', '');
INSERT INTO `st_auth_rule` VALUES ('40', '1', 'admin', 'admin_url', 'admin/Plugin/default', '', '插件中心', '');
INSERT INTO `st_auth_rule` VALUES ('41', '1', 'admin', 'admin_url', 'admin/Plugin/index', '', '插件列表', '');
INSERT INTO `st_auth_rule` VALUES ('42', '1', 'admin', 'admin_url', 'admin/Plugin/toggle', '', '插件启用禁用', '');
INSERT INTO `st_auth_rule` VALUES ('43', '1', 'admin', 'admin_url', 'admin/Plugin/setting', '', '插件设置', '');
INSERT INTO `st_auth_rule` VALUES ('44', '1', 'admin', 'admin_url', 'admin/Plugin/settingPost', '', '插件设置提交', '');
INSERT INTO `st_auth_rule` VALUES ('45', '1', 'admin', 'admin_url', 'admin/Plugin/install', '', '插件安装', '');
INSERT INTO `st_auth_rule` VALUES ('46', '1', 'admin', 'admin_url', 'admin/Plugin/update', '', '插件更新', '');
INSERT INTO `st_auth_rule` VALUES ('47', '1', 'admin', 'admin_url', 'admin/Plugin/uninstall', '', '卸载插件', '');
INSERT INTO `st_auth_rule` VALUES ('48', '1', 'admin', 'admin_url', 'admin/Rbac/index', '', '角色管理', '');
INSERT INTO `st_auth_rule` VALUES ('49', '1', 'admin', 'admin_url', 'admin/Rbac/roleAdd', '', '添加角色', '');
INSERT INTO `st_auth_rule` VALUES ('50', '1', 'admin', 'admin_url', 'admin/Rbac/roleAddPost', '', '添加角色提交', '');
INSERT INTO `st_auth_rule` VALUES ('51', '1', 'admin', 'admin_url', 'admin/Rbac/roleEdit', '', '编辑角色', '');
INSERT INTO `st_auth_rule` VALUES ('52', '1', 'admin', 'admin_url', 'admin/Rbac/roleEditPost', '', '编辑角色提交', '');
INSERT INTO `st_auth_rule` VALUES ('53', '1', 'admin', 'admin_url', 'admin/Rbac/roleDelete', '', '删除角色', '');
INSERT INTO `st_auth_rule` VALUES ('54', '1', 'admin', 'admin_url', 'admin/Rbac/authorize', '', '设置角色权限', '');
INSERT INTO `st_auth_rule` VALUES ('55', '1', 'admin', 'admin_url', 'admin/Rbac/authorizePost', '', '角色授权提交', '');
INSERT INTO `st_auth_rule` VALUES ('56', '1', 'admin', 'admin_url', 'admin/RecycleBin/index', '', '回收站', '');
INSERT INTO `st_auth_rule` VALUES ('57', '1', 'admin', 'admin_url', 'admin/RecycleBin/restore', '', '回收站还原', '');
INSERT INTO `st_auth_rule` VALUES ('58', '1', 'admin', 'admin_url', 'admin/RecycleBin/delete', '', '回收站彻底删除', '');
INSERT INTO `st_auth_rule` VALUES ('59', '1', 'admin', 'admin_url', 'admin/Route/index', '', 'URL美化', '');
INSERT INTO `st_auth_rule` VALUES ('60', '1', 'admin', 'admin_url', 'admin/Route/add', '', '添加路由规则', '');
INSERT INTO `st_auth_rule` VALUES ('61', '1', 'admin', 'admin_url', 'admin/Route/addPost', '', '添加路由规则提交', '');
INSERT INTO `st_auth_rule` VALUES ('62', '1', 'admin', 'admin_url', 'admin/Route/edit', '', '路由规则编辑', '');
INSERT INTO `st_auth_rule` VALUES ('63', '1', 'admin', 'admin_url', 'admin/Route/editPost', '', '路由规则编辑提交', '');
INSERT INTO `st_auth_rule` VALUES ('64', '1', 'admin', 'admin_url', 'admin/Route/delete', '', '路由规则删除', '');
INSERT INTO `st_auth_rule` VALUES ('65', '1', 'admin', 'admin_url', 'admin/Route/ban', '', '路由规则禁用', '');
INSERT INTO `st_auth_rule` VALUES ('66', '1', 'admin', 'admin_url', 'admin/Route/open', '', '路由规则启用', '');
INSERT INTO `st_auth_rule` VALUES ('67', '1', 'admin', 'admin_url', 'admin/Route/listOrder', '', '路由规则排序', '');
INSERT INTO `st_auth_rule` VALUES ('68', '1', 'admin', 'admin_url', 'admin/Route/select', '', '选择URL', '');
INSERT INTO `st_auth_rule` VALUES ('69', '1', 'admin', 'admin_url', 'admin/Setting/default', '', '设置', '');
INSERT INTO `st_auth_rule` VALUES ('70', '1', 'admin', 'admin_url', 'admin/Setting/site', '', '网站信息', '');
INSERT INTO `st_auth_rule` VALUES ('71', '1', 'admin', 'admin_url', 'admin/Setting/sitePost', '', '网站信息设置提交', '');
INSERT INTO `st_auth_rule` VALUES ('72', '1', 'admin', 'admin_url', 'admin/Setting/password', '', '密码修改', '');
INSERT INTO `st_auth_rule` VALUES ('73', '1', 'admin', 'admin_url', 'admin/Setting/passwordPost', '', '密码修改提交', '');
INSERT INTO `st_auth_rule` VALUES ('74', '1', 'admin', 'admin_url', 'admin/Setting/upload', '', '上传设置', '');
INSERT INTO `st_auth_rule` VALUES ('75', '1', 'admin', 'admin_url', 'admin/Setting/uploadPost', '', '上传设置提交', '');
INSERT INTO `st_auth_rule` VALUES ('76', '1', 'admin', 'admin_url', 'admin/Setting/clearCache', '', '清除缓存', '');
INSERT INTO `st_auth_rule` VALUES ('77', '1', 'admin', 'admin_url', 'admin/Slide/index', '', '轮播图管理', '');
INSERT INTO `st_auth_rule` VALUES ('78', '1', 'admin', 'admin_url', 'admin/Slide/add', '', '添加幻灯片', '');
INSERT INTO `st_auth_rule` VALUES ('79', '1', 'admin', 'admin_url', 'admin/Slide/addPost', '', '添加幻灯片提交', '');
INSERT INTO `st_auth_rule` VALUES ('80', '1', 'admin', 'admin_url', 'admin/Slide/edit', '', '编辑幻灯片', '');
INSERT INTO `st_auth_rule` VALUES ('81', '1', 'admin', 'admin_url', 'admin/Slide/editPost', '', '编辑幻灯片提交', '');
INSERT INTO `st_auth_rule` VALUES ('82', '1', 'admin', 'admin_url', 'admin/Slide/delete', '', '删除幻灯片', '');
INSERT INTO `st_auth_rule` VALUES ('83', '1', 'admin', 'admin_url', 'admin/SlideItem/index', '', '幻灯片页面列表', '');
INSERT INTO `st_auth_rule` VALUES ('84', '1', 'admin', 'admin_url', 'admin/SlideItem/add', '', '幻灯片页面添加', '');
INSERT INTO `st_auth_rule` VALUES ('85', '1', 'admin', 'admin_url', 'admin/SlideItem/addPost', '', '幻灯片页面添加提交', '');
INSERT INTO `st_auth_rule` VALUES ('86', '1', 'admin', 'admin_url', 'admin/SlideItem/edit', '', '幻灯片页面编辑', '');
INSERT INTO `st_auth_rule` VALUES ('87', '1', 'admin', 'admin_url', 'admin/SlideItem/editPost', '', '幻灯片页面编辑提交', '');
INSERT INTO `st_auth_rule` VALUES ('88', '1', 'admin', 'admin_url', 'admin/SlideItem/delete', '', '幻灯片页面删除', '');
INSERT INTO `st_auth_rule` VALUES ('89', '1', 'admin', 'admin_url', 'admin/SlideItem/ban', '', '幻灯片页面隐藏', '');
INSERT INTO `st_auth_rule` VALUES ('90', '1', 'admin', 'admin_url', 'admin/SlideItem/cancelBan', '', '幻灯片页面显示', '');
INSERT INTO `st_auth_rule` VALUES ('91', '1', 'admin', 'admin_url', 'admin/SlideItem/listOrder', '', '幻灯片页面排序', '');
INSERT INTO `st_auth_rule` VALUES ('92', '1', 'admin', 'admin_url', 'admin/Storage/index', '', '文件存储', '');
INSERT INTO `st_auth_rule` VALUES ('93', '1', 'admin', 'admin_url', 'admin/Storage/settingPost', '', '文件存储设置提交', '');
INSERT INTO `st_auth_rule` VALUES ('94', '1', 'admin', 'admin_url', 'admin/Theme/index', '', '模板管理', '');
INSERT INTO `st_auth_rule` VALUES ('95', '1', 'admin', 'admin_url', 'admin/Theme/install', '', '安装模板', '');
INSERT INTO `st_auth_rule` VALUES ('96', '1', 'admin', 'admin_url', 'admin/Theme/uninstall', '', '卸载模板', '');
INSERT INTO `st_auth_rule` VALUES ('97', '1', 'admin', 'admin_url', 'admin/Theme/installTheme', '', '模板安装', '');
INSERT INTO `st_auth_rule` VALUES ('98', '1', 'admin', 'admin_url', 'admin/Theme/update', '', '模板更新', '');
INSERT INTO `st_auth_rule` VALUES ('99', '1', 'admin', 'admin_url', 'admin/Theme/active', '', '启用模板', '');
INSERT INTO `st_auth_rule` VALUES ('100', '1', 'admin', 'admin_url', 'admin/Theme/files', '', '模板文件列表', '');
INSERT INTO `st_auth_rule` VALUES ('101', '1', 'admin', 'admin_url', 'admin/Theme/fileSetting', '', '模板文件设置', '');
INSERT INTO `st_auth_rule` VALUES ('102', '1', 'admin', 'admin_url', 'admin/Theme/fileArrayData', '', '模板文件数组数据列表', '');
INSERT INTO `st_auth_rule` VALUES ('103', '1', 'admin', 'admin_url', 'admin/Theme/fileArrayDataEdit', '', '模板文件数组数据添加编辑', '');
INSERT INTO `st_auth_rule` VALUES ('104', '1', 'admin', 'admin_url', 'admin/Theme/fileArrayDataEditPost', '', '模板文件数组数据添加编辑提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('105', '1', 'admin', 'admin_url', 'admin/Theme/fileArrayDataDelete', '', '模板文件数组数据删除', '');
INSERT INTO `st_auth_rule` VALUES ('106', '1', 'admin', 'admin_url', 'admin/Theme/settingPost', '', '模板文件编辑提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('107', '1', 'admin', 'admin_url', 'admin/Theme/dataSource', '', '模板文件设置数据源', '');
INSERT INTO `st_auth_rule` VALUES ('108', '1', 'admin', 'admin_url', 'admin/Theme/design', '', '模板设计', '');
INSERT INTO `st_auth_rule` VALUES ('109', '1', 'admin', 'admin_url', 'admin/User/default', '', '管理组', '');
INSERT INTO `st_auth_rule` VALUES ('110', '1', 'admin', 'admin_url', 'admin/User/index', '', '管理员', '');
INSERT INTO `st_auth_rule` VALUES ('111', '1', 'admin', 'admin_url', 'admin/User/add', '', '管理员添加', '');
INSERT INTO `st_auth_rule` VALUES ('112', '1', 'admin', 'admin_url', 'admin/User/addPost', '', '管理员添加提交', '');
INSERT INTO `st_auth_rule` VALUES ('113', '1', 'admin', 'admin_url', 'admin/User/edit', '', '管理员编辑', '');
INSERT INTO `st_auth_rule` VALUES ('114', '1', 'admin', 'admin_url', 'admin/User/editPost', '', '管理员编辑提交', '');
INSERT INTO `st_auth_rule` VALUES ('115', '1', 'admin', 'admin_url', 'admin/User/userInfo', '', '个人信息', '');
INSERT INTO `st_auth_rule` VALUES ('116', '1', 'admin', 'admin_url', 'admin/User/userInfoPost', '', '管理员个人信息修改提交', '');
INSERT INTO `st_auth_rule` VALUES ('117', '1', 'admin', 'admin_url', 'admin/User/delete', '', '管理员删除', '');
INSERT INTO `st_auth_rule` VALUES ('118', '1', 'admin', 'admin_url', 'admin/User/ban', '', '停用管理员', '');
INSERT INTO `st_auth_rule` VALUES ('119', '1', 'admin', 'admin_url', 'admin/User/cancelBan', '', '启用管理员', '');
INSERT INTO `st_auth_rule` VALUES ('120', '1', 'portal', 'admin_url', 'portal/AdminArticle/index', '', '文章管理', '');
INSERT INTO `st_auth_rule` VALUES ('121', '1', 'portal', 'admin_url', 'portal/AdminArticle/add', '', '添加文章', '');
INSERT INTO `st_auth_rule` VALUES ('122', '1', 'portal', 'admin_url', 'portal/AdminArticle/addPost', '', '添加文章提交', '');
INSERT INTO `st_auth_rule` VALUES ('123', '1', 'portal', 'admin_url', 'portal/AdminArticle/edit', '', '编辑文章', '');
INSERT INTO `st_auth_rule` VALUES ('124', '1', 'portal', 'admin_url', 'portal/AdminArticle/editPost', '', '编辑文章提交', '');
INSERT INTO `st_auth_rule` VALUES ('125', '1', 'portal', 'admin_url', 'portal/AdminArticle/delete', '', '文章删除', '');
INSERT INTO `st_auth_rule` VALUES ('126', '1', 'portal', 'admin_url', 'portal/AdminArticle/publish', '', '文章发布', '');
INSERT INTO `st_auth_rule` VALUES ('127', '1', 'portal', 'admin_url', 'portal/AdminArticle/top', '', '文章置顶', '');
INSERT INTO `st_auth_rule` VALUES ('128', '1', 'portal', 'admin_url', 'portal/AdminArticle/recommend', '', '文章推荐', '');
INSERT INTO `st_auth_rule` VALUES ('129', '1', 'portal', 'admin_url', 'portal/AdminArticle/listOrder', '', '文章排序', '');
INSERT INTO `st_auth_rule` VALUES ('130', '1', 'portal', 'admin_url', 'portal/AdminCategory/index', '', '分类管理', '');
INSERT INTO `st_auth_rule` VALUES ('131', '1', 'portal', 'admin_url', 'portal/AdminCategory/add', '', '添加文章分类', '');
INSERT INTO `st_auth_rule` VALUES ('132', '1', 'portal', 'admin_url', 'portal/AdminCategory/addPost', '', '添加文章分类提交', '');
INSERT INTO `st_auth_rule` VALUES ('133', '1', 'portal', 'admin_url', 'portal/AdminCategory/edit', '', '编辑文章分类', '');
INSERT INTO `st_auth_rule` VALUES ('134', '1', 'portal', 'admin_url', 'portal/AdminCategory/editPost', '', '编辑文章分类提交', '');
INSERT INTO `st_auth_rule` VALUES ('135', '1', 'portal', 'admin_url', 'portal/AdminCategory/select', '', '文章分类选择对话框', '');
INSERT INTO `st_auth_rule` VALUES ('136', '1', 'portal', 'admin_url', 'portal/AdminCategory/listOrder', '', '文章分类排序', '');
INSERT INTO `st_auth_rule` VALUES ('137', '1', 'portal', 'admin_url', 'portal/AdminCategory/delete', '', '删除文章分类', '');
INSERT INTO `st_auth_rule` VALUES ('138', '1', 'portal', 'admin_url', 'portal/AdminIndex/default', '', '文章', '');
INSERT INTO `st_auth_rule` VALUES ('139', '1', 'portal', 'admin_url', 'portal/AdminPage/index', '', '页面管理', '');
INSERT INTO `st_auth_rule` VALUES ('140', '1', 'portal', 'admin_url', 'portal/AdminPage/add', '', '添加页面', '');
INSERT INTO `st_auth_rule` VALUES ('141', '1', 'portal', 'admin_url', 'portal/AdminPage/addPost', '', '添加页面提交', '');
INSERT INTO `st_auth_rule` VALUES ('142', '1', 'portal', 'admin_url', 'portal/AdminPage/edit', '', '编辑页面', '');
INSERT INTO `st_auth_rule` VALUES ('143', '1', 'portal', 'admin_url', 'portal/AdminPage/editPost', '', '编辑页面提交', '');
INSERT INTO `st_auth_rule` VALUES ('144', '1', 'portal', 'admin_url', 'portal/AdminPage/delete', '', '删除页面', '');
INSERT INTO `st_auth_rule` VALUES ('145', '1', 'portal', 'admin_url', 'portal/AdminTag/index', '', '文章标签', '');
INSERT INTO `st_auth_rule` VALUES ('146', '1', 'portal', 'admin_url', 'portal/AdminTag/add', '', '添加文章标签', '');
INSERT INTO `st_auth_rule` VALUES ('147', '1', 'portal', 'admin_url', 'portal/AdminTag/addPost', '', '添加文章标签提交', '');
INSERT INTO `st_auth_rule` VALUES ('148', '1', 'portal', 'admin_url', 'portal/AdminTag/upStatus', '', '更新标签状态', '');
INSERT INTO `st_auth_rule` VALUES ('149', '1', 'portal', 'admin_url', 'portal/AdminTag/delete', '', '删除文章标签', '');
INSERT INTO `st_auth_rule` VALUES ('150', '1', 'user', 'admin_url', 'user/AdminAsset/index', '', '资源管理', '');
INSERT INTO `st_auth_rule` VALUES ('151', '1', 'user', 'admin_url', 'user/AdminAsset/delete', '', '删除文件', '');
INSERT INTO `st_auth_rule` VALUES ('152', '1', 'user', 'admin_url', 'user/AdminIndex/default', '', '用户管理', '');
INSERT INTO `st_auth_rule` VALUES ('153', '1', 'user', 'admin_url', 'user/AdminIndex/default1', '', '用户组', '');
INSERT INTO `st_auth_rule` VALUES ('154', '1', 'user', 'admin_url', 'user/AdminIndex/index', '', '本站用户', '');
INSERT INTO `st_auth_rule` VALUES ('155', '1', 'user', 'admin_url', 'user/AdminIndex/ban', '', '本站用户拉黑', '');
INSERT INTO `st_auth_rule` VALUES ('156', '1', 'user', 'admin_url', 'user/AdminIndex/cancelBan', '', '本站用户启用', '');
INSERT INTO `st_auth_rule` VALUES ('157', '1', 'user', 'admin_url', 'user/AdminOauth/index', '', '第三方用户', '');
INSERT INTO `st_auth_rule` VALUES ('158', '1', 'user', 'admin_url', 'user/AdminOauth/delete', '', '删除第三方用户绑定', '');
INSERT INTO `st_auth_rule` VALUES ('159', '1', 'user', 'admin_url', 'user/AdminUserAction/index', '', '用户操作管理', '');
INSERT INTO `st_auth_rule` VALUES ('160', '1', 'user', 'admin_url', 'user/AdminUserAction/edit', '', '编辑用户操作', '');
INSERT INTO `st_auth_rule` VALUES ('161', '1', 'user', 'admin_url', 'user/AdminUserAction/editPost', '', '编辑用户操作提交', '');
INSERT INTO `st_auth_rule` VALUES ('162', '1', 'user', 'admin_url', 'user/AdminUserAction/sync', '', '同步用户操作', '');
INSERT INTO `st_auth_rule` VALUES ('169', '1', 'plugin/Wxapp', 'plugin_url', 'plugin/Wxapp/AdminIndex/index', '', '小程序管理', '');
INSERT INTO `st_auth_rule` VALUES ('170', '1', 'plugin/Wxapp', 'plugin_url', 'plugin/Wxapp/AdminWxapp/add', '', '添加小程序', '');
INSERT INTO `st_auth_rule` VALUES ('171', '1', 'plugin/Wxapp', 'plugin_url', 'plugin/Wxapp/AdminWxapp/addPost', '', '添加小程序提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('172', '1', 'plugin/Wxapp', 'plugin_url', 'plugin/Wxapp/AdminWxapp/edit', '', '编辑小程序', '');
INSERT INTO `st_auth_rule` VALUES ('173', '1', 'plugin/Wxapp', 'plugin_url', 'plugin/Wxapp/AdminWxapp/editPost', '', '编辑小程序提交保存', '');
INSERT INTO `st_auth_rule` VALUES ('174', '1', 'plugin/Wxapp', 'plugin_url', 'plugin/Wxapp/AdminWxapp/delete', '', '删除小程序', '');
INSERT INTO `st_auth_rule` VALUES ('175', '1', 'Admin', 'admin_url', 'Admin/Exam/default', '', '应用', '');
INSERT INTO `st_auth_rule` VALUES ('176', '1', 'admin', 'admin_url', 'admin/Exam/index', '', '刷题试卷', '');
INSERT INTO `st_auth_rule` VALUES ('177', '1', 'admin', 'admin_url', 'admin/Category/index', '', '综合分类', '');
INSERT INTO `st_auth_rule` VALUES ('178', '1', 'admin', 'admin_url', 'admin/Course/index', '', '在线课堂', '');
INSERT INTO `st_auth_rule` VALUES ('179', '1', 'admin', 'admin_url', 'admin/Course/teacher', '', '课题讲师列表', '');
INSERT INTO `st_auth_rule` VALUES ('180', '1', 'Admin', 'admin_url', 'Admin/daka/index', '', '打卡', '');
INSERT INTO `st_auth_rule` VALUES ('181', '1', 'admin', 'admin_url', 'admin/school/index', '', '学校列表', '');
INSERT INTO `st_auth_rule` VALUES ('182', '1', 'admin', 'admin_url', 'admin/goods/index', '', '商品管理', '');
INSERT INTO `st_auth_rule` VALUES ('183', '1', 'admin', 'admin_url', 'admin/recommend/default', '', '运营', '');
INSERT INTO `st_auth_rule` VALUES ('184', '1', 'admin', 'admin_url', 'admin/recommend/index', '', '搜索推荐', '');
INSERT INTO `st_auth_rule` VALUES ('185', '1', 'admin', 'admin_url', 'admin/Daka/default', '', '打卡', '');
INSERT INTO `st_auth_rule` VALUES ('186', '1', 'admin', 'admin_url', 'admin/Daka/teacher_daka_list', '', '评图', '');

-- ----------------------------
-- Table structure for st_category
-- ----------------------------
DROP TABLE IF EXISTS `st_category`;
CREATE TABLE `st_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类父id',
  `count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类文章数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `alias` varchar(200) NOT NULL DEFAULT '' COMMENT '别名',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '分类层级关系路径',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '服务类型 1-刷题 2-打卡 3在线课堂 4-线下课堂',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COMMENT='admin服务分类表[]';

-- ----------------------------
-- Records of st_category
-- ----------------------------
INSERT INTO `st_category` VALUES ('5', '0', '0', '1', '0', '10000', '建筑', '', '', '0-5', '1', '{\"thumbnail\":\"\"}');
INSERT INTO `st_category` VALUES ('6', '0', '0', '1', '0', '10000', '规划', '', '', '0-6', '1', '{\"thumbnail\":\"\"}');
INSERT INTO `st_category` VALUES ('7', '0', '0', '1', '0', '10000', '园林', '', '', '0-7', '1', '{\"thumbnail\":\"\"}');
INSERT INTO `st_category` VALUES ('8', '0', '0', '1', '0', '10000', '建筑', '建筑', '建筑', '0-8', '3', '{\"thumbnail\":\"\"}');
INSERT INTO `st_category` VALUES ('9', '0', '0', '1', '0', '10000', '规划', '规划', '规划', '0-9', '3', '{\"thumbnail\":\"\"}');
INSERT INTO `st_category` VALUES ('10', '0', '0', '1', '0', '10000', '园林', '园林', '园林', '0-10', '3', '{\"thumbnail\":\"\"}');
INSERT INTO `st_category` VALUES ('11', '0', '0', '1', '0', '10000', '打卡分类一', '', '打卡分类一 打卡分类一', '0-11', '2', '{\"thumbnail\":\"\"}');
INSERT INTO `st_category` VALUES ('12', '0', '1', '1', '0', '10000', '打卡分类二', '', '打卡分类二打卡分类二', '0-12', '2', '{\"thumbnail\":\"\"}');
INSERT INTO `st_category` VALUES ('13', '11', '5', '1', '0', '10000', '打卡分类一一', '', '打卡分类一一打卡分类一一', '0-11-13', '2', '{\"thumbnail\":\"\"}');
INSERT INTO `st_category` VALUES ('14', '11', '7', '1', '0', '10000', '打卡下班咯', '', '打卡下班咯打卡下班咯', '0-11-14', '2', '{\"thumbnail\":\"\"}');

-- ----------------------------
-- Table structure for st_comment
-- ----------------------------
DROP TABLE IF EXISTS `st_comment`;
CREATE TABLE `st_comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `to_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被评论的用户id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论内容 id',
  `like_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `dislike_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '不喜欢数',
  `floor` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼层数',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:已审核,0:未审核',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论类型；1实名评论',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '评论内容所在表，不带表前缀',
  `full_name` varchar(50) NOT NULL DEFAULT '' COMMENT '评论者昵称',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '评论者邮箱',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  `url` text COMMENT '原文地址',
  `content` text CHARACTER SET utf8mb4 COMMENT '评论内容',
  `more` text CHARACTER SET utf8mb4 COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `table_id_status` (`table_name`,`object_id`,`status`),
  KEY `object_id` (`object_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Records of st_comment
-- ----------------------------

-- ----------------------------
-- Table structure for st_course
-- ----------------------------
DROP TABLE IF EXISTS `st_course`;
CREATE TABLE `st_course` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `ctitle` varchar(256) NOT NULL DEFAULT '' COMMENT '课程名称',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '课程分类id',
  `pname` varchar(128) NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` text COMMENT '课程介绍',
  `content_img` varchar(255) NOT NULL DEFAULT '' COMMENT '课程内容描述图片',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '课程小结数量',
  `collect_num` int(11) NOT NULL DEFAULT '0' COMMENT '收藏数量',
  `join_num` int(11) NOT NULL DEFAULT '0' COMMENT '加入/购买人数',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型 1-视频 2-图文',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '展示图片',
  `recommended` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `is_top` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否置顶',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `create_time` int(10) NOT NULL DEFAULT '0',
  `update_time` int(10) NOT NULL DEFAULT '0',
  `published_time` int(10) NOT NULL DEFAULT '0' COMMENT '发布时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '-1-删除 1-已发布 0-未发布',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT 'goods.goods_id',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='课程表';

-- ----------------------------
-- Records of st_course
-- ----------------------------
INSERT INTO `st_course` VALUES ('5', '222', '9', '规划', '333', '', '0', '0', '0', '1', 'admin/20181107/5948e168d9114ce4ba0e11c983a9c467.jpg', '1', '1', '12', '1542726612', '1547909824', '1544889523', '-1', '19');
INSERT INTO `st_course` VALUES ('6', '222', '9', '规划', '333', '', '0', '0', '0', '1', 'admin/20181107/5948e168d9114ce4ba0e11c983a9c467.jpg', '1', '1', '3', '1542726663', '1547909816', '1544889523', '-1', '18');
INSERT INTO `st_course` VALUES ('7', 'nginx123111', '10', '园林', 'nginx233312', 'admin/20190125/73f5e947413e5bf13487af5ed7c12ac3.png', '0', '0', '1', '1', 'admin/20190125/e156967f4432be813bc242487a03263b.png', '1', '1', '1', '1542727290', '1548397788', '1548084575', '1', '12');
INSERT INTO `st_course` VALUES ('8', 'php56789', '9', '规划', 'php567891', '', '2', '0', '1', '2', 'admin/20181107/f05a104ce593705eace17696bc5a3233.jpg', '1', '1', '22', '1542729348', '1547909834', '1548084575', '1', '20');
INSERT INTO `st_course` VALUES ('9', 'redis高级教程', '10', '园林', '老司机带你飞, redis高级教程', '', '4', '0', '1', '1', 'admin/20190119/9ee1df243c60a34500ae3534cf0448fd.jpg', '0', '0', '10000', '1547908631', '1548212196', '1548084575', '1', '13');

-- ----------------------------
-- Table structure for st_course_item
-- ----------------------------
DROP TABLE IF EXISTS `st_course_item`;
CREATE TABLE `st_course_item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_title` varchar(128) NOT NULL DEFAULT '' COMMENT '课题名称',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT '课程id [course id]',
  `ctitle` varchar(255) NOT NULL DEFAULT '' COMMENT '课程标题',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '章节id 上级id',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '分类层级关系路径',
  `summary` varchar(1024) NOT NULL DEFAULT '' COMMENT '摘要',
  `description` text COMMENT '介绍',
  `source_url` varchar(256) NOT NULL DEFAULT '' COMMENT '资源id',
  `video_id` char(32) NOT NULL DEFAULT '' COMMENT 'video_id',
  `video_url` varchar(256) NOT NULL DEFAULT '' COMMENT '视频播放地址',
  `video_long` int(11) NOT NULL DEFAULT '0' COMMENT '视频时长',
  `video_size` int(11) NOT NULL DEFAULT '0' COMMENT '视频体积大小 kb',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `create_time` int(10) NOT NULL DEFAULT '0',
  `update_time` int(10) NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL DEFAULT '-1' COMMENT '资源类型 0-小节 1-视频 2-图文',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-删除 1-显示',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='课题表';

-- ----------------------------
-- Records of st_course_item
-- ----------------------------
INSERT INTO `st_course_item` VALUES ('1', '第1章 课程介绍', '8', 'php56789', '0', '1', '带领大家初步认识下什么是PhpStorm、以及他的特性、如何获取phpstorm、以及如何安装', '', '', '', '', '0', '0', '10000', '1544024701', '1544025009', '0', '1');
INSERT INTO `st_course_item` VALUES ('2', '第2章 PhpStorm的基本操作', '8', 'php56789', '0', '2', '本章主要介绍下编辑器的工作区、如何导入本地项目到编辑器中，以及字体设置技巧', '', '', '', '', '0', '0', '10000', '1544024785', '0', '0', '1');
INSERT INTO `st_course_item` VALUES ('3', '神秘高手', '8', 'php56789', '1', '1-3', '初识PhpStorm', '&lt;p&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;  赢了？&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    陈果瞬间呆住了。闪出荣耀两个字这是竞技场标志性的获胜符号，意思等同于“K.O”。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    只是，自己这走开回来才多久？40秒？50秒？陈果抬腕看了一下表，绝对不到一分钟。结果呢？刚才自己连输52局的对手被这人不到一分钟就给“荣耀”掉了？&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    陈果甚至忘了冲上去抢回账号，她盼着这人能再打一把让自己好好看看，结果却是看到那人很是熟练地就已经退出了游戏。伸了个懒腰，好像对电脑没太大兴趣似的，左右东张西望了起来。这一扭头，正看到陈果瞪大眼在望着他，连忙解释：“你刚没退游戏，我坐下战斗已经开始了，帮你打赢了，放心吧！”&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “用了多久？”陈果问。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “40多秒吧！”叶秋说。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    陈果张大了嘴，对方却还略带遗憾地说：“手冻僵了，不然的话30秒就够了。”&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    30秒……30秒就能击败自己52局都拿不下一局的对手，这得是什么人啊？&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    难道是嘉世战队的职业高手？陈果突得想起。她知道嘉世俱乐部离她的网吧可不太远。可转念又一想，嘉世战队的人她就能认出来啊！除非这人是那个从不露面的高手叶秋。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    叶秋！一想到这个名字陈果激动了，但想到这个高手向来低调，自己扑上去问的话人多半不会承认，踌躇了一下后，陈果突得想起什么，飞似地跑回了前台。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “C区47号机的客人，登记的什么名字？”陈果问吧台小妹。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “叶修。”小妹说。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “叶修……叶秋吗？果然！”陈果激动了，在她看来这真是此地无银三百两，这样才说明这人就是叶秋，他要真写个叶秋上去，自己反倒不信呢！&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “嘿嘿嘿……”陈果的笑容那叫一个阴险，她已经准备搜刮可以找到的所有东西去找这人签名了。叶秋的签名啊！谁有？谁都没有！&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    正想呢，小妹那却又随口补了一句：“他的身份证都忘这了。”&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “身份证？”陈果听了一怔，这才意识到自己兴奋得糊涂了。网吧登记是要实名制的，肯定要出示身份证，哪有人能用假名登记？&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “身份证呢？我看看。”陈果从小妹手中接过身份证一看，果然实实在在地写着叶修，顿时一阵失望，非常有把这修字改成秋的冲动。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    得知这人并不是自己仰慕已久的低调高手后，虽同样好奇这人的实力，但兴趣却已经一下消了大半了。陈果悻悻地回到C区47号处，把叶修的身份证递了回去：“你身份证忘了拿了。”&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “哦，谢谢。”叶修连忙接回，“你是网吧的？”&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “嗯，我是这老板。”&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “哦？老板，那太好了，我刚在你们这网吧的网页上看到，你们招网管是吗？”叶修问。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “啊……是啊……”陈果没想到这人突然来了这么一句，她正想着怎么让这人和自己切磋一把呢，这样倒是很有借口了。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “我看了，觉得条件我都符合，工作和待遇我也没问题，怎么样？考虑一下吧老板。”叶修说。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “哦，那你还得荣耀单挑赢我才行。”陈果说。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “啥？有这条吗？”叶修翻过身去看。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “不用找了，我新加的。”陈果说。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    叶修一怔，随即也明白过来自己刚才那把赢得太职业，这美女老板是对自己的实力有了好奇。只可惜……叶修苦笑着摇了摇头说：“我赢不了你。”&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “为什么？”陈果一怔。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “因为我没有可以赢你的账号。”叶修说。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “账号……你号几级？什么装备。”陈果问。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 20px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 20px;&quot;&gt;    “没级，没装备。”叶修说。&lt;/span&gt;&lt;/p&gt;', '', '', '', '66', '0', '10000', '0', '1544349206', '2', '1');
INSERT INTO `st_course_item` VALUES ('4', '第一章 被驱逐的高手', '9', 'redis高级教程', '0', '', '“卡卡卡，嗒嗒……”', null, '', '', '', '0', '0', '10000', '1548079338', '1548080143', '0', '1');
INSERT INTO `st_course_item` VALUES ('5', '第二章 C区47号', '9', 'redis高级教程', '0', '', '“切，拽什么拽啊！”', null, '', '', '', '0', '0', '10000', '1548079683', '1548080163', '0', '1');
INSERT INTO `st_course_item` VALUES ('6', '第三章 专职夜班', '9', 'redis高级教程', '0', '', '赢了？', null, '', '', '', '0', '0', '10000', '1548080107', '1548080174', '0', '1');
INSERT INTO `st_course_item` VALUES ('7', '高手高手', '9', '', '4', '', '这样子虐狗不好', null, '', '', '', '0', '0', '10000', '0', '0', '1', '1');
INSERT INTO `st_course_item` VALUES ('8', '青蛙好好吃', '9', '', '5', '', '青蛙好好吃, 哈哈', null, '', '5dd982473c34420e89d9765ce3af5154', 'https://video.fengbaojy.com/customerTrans/cc3180582a5c4fec081ef45ef78264d7/aa5cb06-16870e4bc1e-0004-ace9-db8-39ca7.mp4', '6', '0', '10000', '0', '0', '1', '1');
INSERT INTO `st_course_item` VALUES ('9', '开会了', '9', '', '6', '', '这回是真的开会了', null, '', '594fded6da994c92892b577408437de8', '', '9', '0', '10000', '0', '0', '1', '1');
INSERT INTO `st_course_item` VALUES ('10', '可怕', '9', '', '6', '', '着火了, 黑人', null, '', 'ee1146565bf54f19be5cda159abd9641', '', '11', '0', '10000', '0', '0', '1', '1');
INSERT INTO `st_course_item` VALUES ('11', '蜘蛛洞穴（一）', '8', '', '2', '', '四个家伙很嚣张，鬼鬼祟祟地在一边商量，让叶修这边一个人苦力。好在他们也没完全把叶修当白痴看，计较妥当后四人一拥而上开始帮叶修清怪，一边清一边为他们非常怠工的行为解释一下：“刚才工会有点事，有点不专心了，现在好了。”', '&lt;p&gt;&lt;span style=&quot;font-family: 宋体; font-size: 18px;&quot;&gt; &lt;img src=&quot;https://img.baidu.com/hi/jx2/j_0011.gif&quot;&gt;四个家伙很嚣张，鬼鬼祟祟地在一边商量，让叶修这边一个人苦力。好在他们也没完全把叶修当白痴看，计较妥当后四人一拥而上开始帮叶修清怪，一边清一边为他们非常怠工的行为解释一下：“刚才工会有点事，有点不专心了，现在好了。”&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 18px;&quot;&gt;    “大家加油。”叶修淡淡说了一句，丝毫不见起疑。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 18px;&quot;&gt;    四人心中窃喜，于是这段时间倒是同心协力，四个老手，加叶修一个大高手，这新手副本刷起来就颇有几分碾压的风采了，每个人都杀得甚是痛快，外表来看丝毫不见当中的鬼胎。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 18px;&quot;&gt;    “这家伙的攻击好高啊，发现没有？”田七这边和月中眠却还在小声嘀咕着。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 18px;&quot;&gt;    “好像是，用的那矛是什么装备，我从没见过。”月中眠说。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 18px;&quot;&gt;    “我也不知道，低级战矛没注意过。”田七说。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 18px;&quot;&gt;    “一会弄死这家伙的时候能爆出来就好了。”月中眠说。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 18px;&quot;&gt;    “爆出来能有啥用，攻击再高也是低级货，用不了几天。”田七说。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 18px;&quot;&gt;    “那倒也是。”月中眠点头。&lt;/span&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;br style=&quot;margin: auto; padding: 0px; font-family: 宋体; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-family: 宋体; font-size: 18px;&quot;&gt;    双方互不招惹，和谐合作，格林之森进进出出，效率非常，比较可惜的就是一直没遇到过隐藏BOSS暗夜猫妖。&lt;/span&gt;&lt;/p&gt;', '', '', '', '0', '0', '10000', '0', '0', '2', '1');

-- ----------------------------
-- Table structure for st_course_teacher
-- ----------------------------
DROP TABLE IF EXISTS `st_course_teacher`;
CREATE TABLE `st_course_teacher` (
  `tid` int(11) NOT NULL AUTO_INCREMENT COMMENT '讲师id',
  `tname` varchar(128) NOT NULL DEFAULT '' COMMENT '讲师名称',
  `summary` varchar(256) NOT NULL DEFAULT '' COMMENT '简介',
  `description` text COMMENT '详细介绍',
  `avatar` varchar(256) NOT NULL DEFAULT '' COMMENT '讲师头像url',
  `create_time` int(10) NOT NULL DEFAULT '0',
  `update_time` int(10) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-隐藏 1-展示',
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='在线课程/线下课程 讲师表';

-- ----------------------------
-- Records of st_course_teacher
-- ----------------------------
INSERT INTO `st_course_teacher` VALUES ('1', '张三', '高级工程师', '高级工程师很厉害的', 'admin/20190123/cb2af6bf02cf4caeedec4077ba4a5759.jpg', '0', '0', '1');
INSERT INTO `st_course_teacher` VALUES ('2', '李四', '李四李四', '李四李四李四', 'admin/20190123/24e567e3746d64f6e08eac94ac5bce50.jpg', '0', '0', '1');
INSERT INTO `st_course_teacher` VALUES ('3', '王五', '王五', '王五', 'admin/20190123/03fa15e93a32edee9f42a34909855c10.png', '0', '0', '1');

-- ----------------------------
-- Table structure for st_course_teacher_relation
-- ----------------------------
DROP TABLE IF EXISTS `st_course_teacher_relation`;
CREATE TABLE `st_course_teacher_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT '课程id',
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT '讲师id',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0-删除 1-正常',
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  KEY `tid` (`tid`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COMMENT='讲师_课程关联表';

-- ----------------------------
-- Records of st_course_teacher_relation
-- ----------------------------
INSERT INTO `st_course_teacher_relation` VALUES ('45', '6', '1', '1');
INSERT INTO `st_course_teacher_relation` VALUES ('46', '6', '2', '1');
INSERT INTO `st_course_teacher_relation` VALUES ('47', '5', '1', '1');
INSERT INTO `st_course_teacher_relation` VALUES ('48', '5', '2', '1');
INSERT INTO `st_course_teacher_relation` VALUES ('49', '8', '2', '1');
INSERT INTO `st_course_teacher_relation` VALUES ('52', '9', '1', '1');
INSERT INTO `st_course_teacher_relation` VALUES ('53', '9', '3', '1');
INSERT INTO `st_course_teacher_relation` VALUES ('54', '7', '1', '1');
INSERT INTO `st_course_teacher_relation` VALUES ('55', '7', '2', '1');

-- ----------------------------
-- Table structure for st_daka
-- ----------------------------
DROP TABLE IF EXISTS `st_daka`;
CREATE TABLE `st_daka` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '分类id',
  `category_name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:已发布;0:未发布;',
  `comment_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论状态;1:允许;0:不允许',
  `is_top` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶;1:置顶;0:不置顶',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_hits` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '查看数',
  `post_favorites` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  `post_like` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `comment_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `join_num` int(11) NOT NULL DEFAULT '0' COMMENT '加入/购买人数',
  `daka_num` int(11) NOT NULL DEFAULT '0' COMMENT '打卡/作业提交 次数',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `published_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `end_time` int(10) NOT NULL DEFAULT '0' COMMENT '结束时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `post_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `post_image` varchar(255) NOT NULL DEFAULT '' COMMENT 'post 图片',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `post_content` text COMMENT '文章内容',
  `post_content_filtered` text COMMENT '处理过的文章内容',
  `list_order` int(11) NOT NULL DEFAULT '100' COMMENT '排序值, 越小越靠前',
  `more` text COMMENT '扩展属性,如缩略图;格式为json',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT 'goods.goods_id',
  `teacher_num` int(11) NOT NULL DEFAULT '0' COMMENT '批改作业老师数量',
  `teacher_index` int(11) NOT NULL DEFAULT '0' COMMENT '批改作业老师顺序index',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='portal应用 文章表';

-- ----------------------------
-- Records of st_daka
-- ----------------------------
INSERT INTO `st_daka` VALUES ('1', '13', '打卡分类一一', '0', '1', '1', '1', '1', '0', '0', '0', '0', '0', '1', '2', '1545881537', '1550758574', '1545840000', '1550160000', '0', '中国古典建筑', '', 'admin/20181231/ac835582916a3ea5d7b48dc86b9fb151.jpg', '11111', null, '100', '{\"photos\":[{\"url\":\"admin/20181231/23fae07583e1f129f44cfff322522401.jpg\",\"name\":\"2efeaddb0ff2e61fb47cbb76e954037f.jpg\"}]}', '21', '3', '0');
INSERT INTO `st_daka` VALUES ('2', '14', '打卡下班咯', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1545891764', '1547881841', '0', '1980', '0', '好像下班了', '', 'admin/20181227/6776dee3c6e0de549ad8f33147b6f135.gif', '&lt;p&gt;好想下班&lt;img src=&quot;https://img.baidu.com/hi/jx2/j_0002.gif&quot;&gt;&lt;/p&gt;', null, '100', '{\"photos\":[{\"url\":\"admin/20181227/a0dc4fb9a4517f5b231c6d5cdc2bc80d.gif\",\"name\":\"20180708140354.gif\"},{\"url\":\"admin/20181227/cc9699075e2333d961d4d8c5c3a3ed93.gif\",\"name\":\"89e5bad671d5e05ea81a1703ef34bee4_t.gif\"},{\"url\":\"admin/20181227/b4298c559cb45eb09c18f6c32dbe3c21.gif\",\"name\":\"445bf4d333be46239bd431ff7627176e_t.gif\"}]}', '3', '0', '0');
INSERT INTO `st_daka` VALUES ('3', '14', '打卡下班咯', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1545892203', '1547910058', '0', '1980', '0', '好像下班了', '', 'admin/20181227/6776dee3c6e0de549ad8f33147b6f135.gif', '&lt;p&gt;好想下班&lt;img src=&quot;https://img.baidu.com/hi/jx2/j_0002.gif&quot;&gt;&lt;/p&gt;', null, '100', '{\"photos\":[{\"url\":\"admin/20181227/a0dc4fb9a4517f5b231c6d5cdc2bc80d.gif\",\"name\":\"20180708140354.gif\"},{\"url\":\"admin/20181227/cc9699075e2333d961d4d8c5c3a3ed93.gif\",\"name\":\"89e5bad671d5e05ea81a1703ef34bee4_t.gif\"},{\"url\":\"admin/20181227/b4298c559cb45eb09c18f6c32dbe3c21.gif\",\"name\":\"445bf4d333be46239bd431ff7627176e_t.gif\"}]}', '23', '0', '0');
INSERT INTO `st_daka` VALUES ('4', '13', '打卡分类一一', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1', '0', '1546073876', '1547909899', '1546073820', '1546073820', '0', '23432423432', '', '', '&lt;p&gt;423423423423423432&lt;/p&gt;', null, '100', '\"{\\\"thumbnail\\\":\\\"\\\"}\"', '22', '0', '0');
INSERT INTO `st_daka` VALUES ('5', '13', '打卡分类一一', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1546245627', '1550759912', '0', '0', '0', '第一章', '', 'admin/20190221/8565b1c66109950a12003bfce5cb9ddb.jpg', '\n&lt;p&gt;&lt;img src=&quot;https://img.baidu.com/hi/jx2/j_0003.gif&quot;&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; background-color: rgb(255, 255, 255);\'&gt;    白嘉轩后来引以豪壮的是一生里娶过七房女人。&lt;/span&gt;&lt;br style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; white-space: normal; background-color: rgb(255, 255, 255);\'&gt;&lt;br style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; white-space: normal; background-color: rgb(255, 255, 255);\'&gt;&lt;span style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; background-color: rgb(255, 255, 255);\'&gt;    娶头房媳妇时他刚刚过十六岁生日。那是西原上巩家村大户巩增荣的头生女，比他大两岁。他在完全无知慌乱中度过了新婚之夜，留下了永远羞于向人道及的可笑的傻样，而自己却永生难以忘记。一年后，这个女人死于难产。&lt;/span&gt;&lt;br style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; white-space: normal; background-color: rgb(255, 255, 255);\'&gt;&lt;br style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; white-space: normal; background-color: rgb(255, 255, 255);\'&gt;&lt;span style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; background-color: rgb(255, 255, 255);\'&gt;    第二房娶的是南原庞家村殷实人家庞修瑞的奶干女儿。这女子又正好比他小两岁，模样俊秀眼睛忽灵儿。她完全不知道嫁人是怎么回事，而他此时已谙熟男女之间所有的隐秘。他看着她的羞怯慌乱而想到自己第一次的傻样反倒觉得更富刺激。当他哄唆着把躲躲闪闪而又不敢违坳他的小媳妇裹入身下的时候，他听到了她的不是欢乐而是痛苦的一声哭叫。当他疲惫地歇息下来，才发觉肩膀内侧疼痛钻心，她把他咬烂了。他抚伤惜痛的时候，心里就潮起了对这个娇惯得有点任性的奶干女儿的恼火。正欲发作，她却扳过他的肩膀暗示他再来一次。一当经过男女间的第一次交欢，她就变得没有节制的任性。这个女人从下轿顶着红绸盖巾进入白家门楼到躺进一具薄板棺材抬出这个门楼，时间尚不足一年，是害痨病死的。&lt;/span&gt;&lt;br style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; white-space: normal; background-color: rgb(255, 255, 255);\'&gt;&lt;br style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; white-space: normal; background-color: rgb(255, 255, 255);\'&gt;&lt;span style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; background-color: rgb(255, 255, 255);\'&gt;    第三个女人是北原上樊家寨的一户同样殷实人家的头生女儿，十六岁的身体发育得像二十岁的女人一样丰满成熟，丰腴的肩膀和浑圆的臀部，又有一对大xx子。她要么是早熟，要么是婚前有过男女间的知识，一钻进被窝就把他紧紧搂住，双臂上显示着急迫与贪婪，把丰满鼓胀的xx子毫不羞怯地贴紧他的胸脯。&lt;/span&gt;&lt;br style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; white-space: normal; background-color: rgb(255, 255, 255);\'&gt;&lt;br style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; white-space: normal; background-color: rgb(255, 255, 255);\'&gt;&lt;span style=\'font-family: &quot;Microsoft YaHei&quot;; font-size: 15.3333px; background-color: rgb(255, 255, 255);\'&gt;    当他进入她的身体时，她嗷嗷直叫，却不是痛苦而是沉迷。这个像一团绒球的女人在他怀里缠磨过一年就瘦成了一根干枯的包谷秆子，最后吐血而死了，死了也没搞清是什么病症。&lt;/span&gt;&lt;/p&gt;\n', null, '1', '{\"photos\":[{\"url\":\"https://img.fengbaojy.com/admin/20190221/15aa57836fbcd0d60613cf5b5bdc9140.jpg\",\"name\":\"59fce102c9d3b09f3d510cb765d81f89.jpg\"},{\"url\":\"https://img.fengbaojy.com/admin/20190221/587828e70e057cff6144c851ddcf513a.jpg\",\"name\":\"1c165819a17e250a4b17f3fcb2266a67.jpg\"}]}', '0', '0', '0');
INSERT INTO `st_daka` VALUES ('6', '13', '打卡分类一一', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1546246121', '1547999118', '0', '0', '0', '第二章', '', 'admin/20181231/71aababa309a3ff75716677e802041a9.jpg', '&lt;p&gt;222222222222222222222222&lt;/p&gt;', null, '2', '\"{\\\"audio\\\":\\\"\\\",\\\"video\\\":\\\"\\\",\\\"thumbnail\\\":\\\"admin/20181231/71aababa309a3ff75716677e802041a9.jpg\\\"}\"', '0', '0', '0');
INSERT INTO `st_daka` VALUES ('7', '13', '打卡分类一一', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1546246446', '1547999131', '0', '0', '0', '第三章', '', '', '\n&lt;p&gt;222222222222222222222222&lt;/p&gt;\n&lt;p&gt;3333333333333333333333333333&lt;/p&gt;\n', null, '3', '{\"audio\":\"\",\"video\":\"\",\"thumbnail\":\"\"}', '0', '0', '0');
INSERT INTO `st_daka` VALUES ('8', '14', '打卡下班咯', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1546247015', '1547905009', '1546246920', '1546246920', '0', '今天是2018年最后一天咯', '', 'admin/20181231/5340d43f7b1eecdb25a81e8fe4d15d3b.jpg', '&lt;p&gt;测试获取最后的新增id 获取失败了1&lt;/p&gt;', null, '100', '{\"photos\":[{\"url\":\"admin/20181231/3c12b2c9c864ffd44f7e9ef20918d00d.jpg\",\"name\":\"2f6b374950d828643a98260306c33d14.jpg\"},{\"url\":\"admin/20181231/1e1c27236205ece3163481ccf28f2a31.jpg\",\"name\":\"3d0fd2242cf6c22f60b7d350a1f2af6b.jpg\"}]}', '9', '3', '0');
INSERT INTO `st_daka` VALUES ('9', '14', '打卡下班咯', '8', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1546247456', '1546525410', '1546524095', '0', '0', '第一章', '', 'admin/20181231/2e8406f7a5efb8d0631d849920a09eb1.jpg', '\n&lt;p&gt;第一章第一章&lt;/p&gt;\n&lt;p style=&quot;white-space: normal;&quot;&gt;第一章第一章&lt;/p&gt;\n&lt;p&gt;&lt;br&gt;&lt;/p&gt;\n', null, '2', '{\"files\":[{\"url\":\"admin/20190103/ca0dd15e571ec7b3b48562f1e574a6f5.xlsx\",\"name\":\"技术团队事务跟踪管理-20180914.xlsx\"}]}', '0', '0', '0');
INSERT INTO `st_daka` VALUES ('10', '14', '打卡下班咯', '8', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1546247633', '1546247675', '1546524095', '0', '0', '第二章', '', 'admin/20181231/71aababa309a3ff75716677e802041a9.jpg', '&lt;p&gt;第二章第二章第二章第二章&lt;/p&gt;', null, '3', '{\"audio\":\"\",\"video\":\"\"}', '0', '0', '0');
INSERT INTO `st_daka` VALUES ('11', '14', '打卡下班咯', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '1', '0', '1547882026', '1547882026', '1547881914', '1569772800', '0', '今天周六, 可是我却在加班', '', 'admin/20190119/5ce2bc90a1463efcbae065d39662b597.jpg', '&lt;p&gt;今天周六, 可是我却在加班, 是不是很苦逼&lt;/p&gt;', null, '100', '\"{\\\"photos\\\":[{\\\"url\\\":\\\"admin/20190119/dc9f1707b0b2c397c2fdfda983375b2b.jpg\\\",\\\"name\\\":\\\"00bc38822adb528c70531f6c73e5d5ea.jpg\\\"},{\\\"url\\\":\\\"admin/20190119/60ea8c999b52338733c470aab0241597.jpg\\\",\\\"name\\\":\\\"00c5cab811db0f8e9ae86f2b36337472.jpg\\\"}]}\"', '6', '0', '0');
INSERT INTO `st_daka` VALUES ('12', '14', '打卡下班咯', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1547882253', '1547882253', '1547882117', '1548921300', '0', '1111', '', '', '&lt;p&gt;22222&lt;/p&gt;', null, '100', null, '8', '0', '0');
INSERT INTO `st_daka` VALUES ('13', '13', '打卡分类一一', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '1', '0', '1547905146', '1551710999', '1547905080', '1570216500', '0', '咸鱼的梦想', '', 'admin/20190304/009a520e8c1ceb0c8470a13dd7da176a.jpg', '拉拉啦', null, '100', null, '10', '3', '0');
INSERT INTO `st_daka` VALUES ('14', '12', '打卡分类二', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1551711169', '1551711364', '1551711060', '1554048000', '0', '自动加载自动加载自动加载', 'admin/20190304/faa9ac87b8952fc92645330e8a27e7cc.jpg', 'admin/20190304/5694605cf3ccbe46c251a3194b13e2fd.jpg', '自动加载自动加载自动加载自动加载自动加载', null, '100', null, '24', '3', '0');

-- ----------------------------
-- Table structure for st_daka_homework
-- ----------------------------
DROP TABLE IF EXISTS `st_daka_homework`;
CREATE TABLE `st_daka_homework` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `teacher_id` int(11) NOT NULL DEFAULT '0' COMMENT '老师id',
  `daka_parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '打卡课程id',
  `daka_id` int(11) NOT NULL DEFAULT '0' COMMENT '打卡项目id',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '作业表父id 学生提问为0 老师回复为问题id',
  `images` text COMMENT '图集json',
  `message` text COMMENT '留言,回复',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `dtype` tinyint(1) NOT NULL DEFAULT '0' COMMENT '回复类型 1-用户上传作业 2-老师评图回复',
  `is_answer` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否回复 0-没有 1-已回复',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1-已经提交 2-已经评论',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='打卡-作业提交表';

-- ----------------------------
-- Records of st_daka_homework
-- ----------------------------
INSERT INTO `st_daka_homework` VALUES ('1', '2', '3', '1', '5', '0', '[&quot;users/20190212/wx6da2e823bfb4f0e9.o6zAJs6JS0ZEsQ3n9VzpsDNbHkMk.ylVCcJsRr37C5250fc705fcbfc51b3531844637711bb.png&quot;,&quot;users/20190212/wx6da2e823bfb4f0e9.o6zAJs6JS0ZEsQ3n9VzpsDNbHkMk.p7PHXlotw6rJf9bc0753961ceb59b9964ceb56ab896e.png&quot;]', '第一章', '1551021451', '1551021451', '1', '1', '1');
INSERT INTO `st_daka_homework` VALUES ('2', '2', '3', '1', '6', '0', '[1,2,3]', '111', '1546573345', '1546573345', '1', '0', '1');
INSERT INTO `st_daka_homework` VALUES ('3', '2', '5', '1', '1', '0', '[1,2,3]', '111', '1546573400', '1546573400', '1', '0', '1');
INSERT INTO `st_daka_homework` VALUES ('4', '2', '4', '1', '1', '0', '[1,2,3]', '111', '1546573573', '1546573573', '1', '0', '1');
INSERT INTO `st_daka_homework` VALUES ('5', '2', '4', '1', '7', '0', '[\"1,23,4\"]', '222', '1546598766', '1546598766', '1', '0', '2');
INSERT INTO `st_daka_homework` VALUES ('8', '2', '3', '1', '5', '1', '[&quot;admin\\/20190224\\/14886cedaa81583bfda0e5d405d0e647.jpg&quot;,&quot;admin\\/20190224\\/4c1d9a97315d89dc6fdb5526cc6f3d73.jpg&quot;]', '还行吧 80分111', '1551021438', '1551021451', '2', '0', '1');

-- ----------------------------
-- Table structure for st_daka_teacher_relation
-- ----------------------------
DROP TABLE IF EXISTS `st_daka_teacher_relation`;
CREATE TABLE `st_daka_teacher_relation` (
  `relation_id` int(11) NOT NULL AUTO_INCREMENT,
  `daka_id` int(11) NOT NULL DEFAULT '0' COMMENT '打卡课程id',
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '管理员 老师 id',
  PRIMARY KEY (`relation_id`),
  UNIQUE KEY `dakaId_adminId_unique` (`daka_id`,`admin_id`),
  KEY `daka_id` (`daka_id`),
  KEY `admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COMMENT='打卡课程-后台老师关联表';

-- ----------------------------
-- Records of st_daka_teacher_relation
-- ----------------------------
INSERT INTO `st_daka_teacher_relation` VALUES ('50', '14', '3');
INSERT INTO `st_daka_teacher_relation` VALUES ('49', '14', '4');
INSERT INTO `st_daka_teacher_relation` VALUES ('48', '14', '5');

-- ----------------------------
-- Table structure for st_exam
-- ----------------------------
DROP TABLE IF EXISTS `st_exam`;
CREATE TABLE `st_exam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT '分类id',
  `cname` varchar(10) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '分类名称',
  `property` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性质 1-真题 2-模拟 3-其他',
  `vendor_year` varchar(10) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '来源年代',
  `create_uid` int(11) NOT NULL DEFAULT '0' COMMENT '编辑id',
  `create_name` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '编辑名称',
  `title` varchar(50) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '标题',
  `subtitle` varchar(50) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '小标题',
  `description` text COMMENT '描述',
  `image` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '封面图',
  `use_num` int(11) NOT NULL DEFAULT '0' COMMENT '使用过人数',
  `is_top` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否置顶;1:置顶;0:不置顶',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `published_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(10) NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态;1:已发布;0:未发布;-1:删除',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT 'goods.goods_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='试卷表[刷题]';

-- ----------------------------
-- Records of st_exam
-- ----------------------------
INSERT INTO `st_exam` VALUES ('1', '5', '建筑', '2', '2018', '1', 'admin', '重大和北大都能用到的模拟题', '三年模拟五年高考', '三年模拟五年高考, 你怕不怕?', 'admin/20190203/fc0116bdbc530e1be12a762d19fdf89f.jpg', '2', '1', '1', '1547111567', '1541262925', '1549124765', '1544933425', '1', '23');
INSERT INTO `st_exam` VALUES ('2', '6', '规划', '1', '2008', '1', 'admin', '西南大学&amp;北京大学2009研究生真题', '西南大学2009研究生真题1', '西南大学2009研究生真题211', 'admin/20181107/5948e168d9114ce4ba0e11c983a9c467.jpg', '1', '1', '1', '1547111567', '1541602937', '1547964499', '1544933425', '1', '22');
INSERT INTO `st_exam` VALUES ('14', '5', '建筑', '2', '2011', '1', 'admin', '2008年黄冈密卷高考题', '2008年黄冈密卷高考题', '2008年黄冈密卷高考题\r\n2008年黄冈密卷高考题', '', '1', '0', '0', '1547111567', '1546963893', '1547964488', '0', '1', '21');
INSERT INTO `st_exam` VALUES ('15', '6', '规划', '2', '2018', '1', 'admin', '2008年黄冈密卷高考题111', '2008年黄冈密卷高考题222', '2008年黄冈密卷高考题333\r\n2008年黄冈密卷高考题444', 'admin/20190203/1054aa221a00ac24f939ca1469a0e02b.jpg', '1', '0', '0', '1547111567', '1546964165', '1549125175', '0', '1', '20');

-- ----------------------------
-- Table structure for st_exam_item
-- ----------------------------
DROP TABLE IF EXISTS `st_exam_item`;
CREATE TABLE `st_exam_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` int(11) NOT NULL DEFAULT '0' COMMENT '试卷id',
  `section_id` int(11) NOT NULL DEFAULT '0' COMMENT '章节id',
  `item_title` varchar(200) NOT NULL DEFAULT '题目',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '题目类型 1:选择题,2:填空题,3:论述题',
  `option` text COMMENT '选择题[选项][json]',
  `answer` text COMMENT '参考答案',
  `analysis` text COMMENT '分析',
  `knowledge` text COMMENT '知识点',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '配图',
  `da_image` varchar(255) NOT NULL DEFAULT '' COMMENT '答案配图',
  `create_time` int(10) NOT NULL DEFAULT '0',
  `update_time` int(10) NOT NULL DEFAULT '0',
  `list_order` int(11) NOT NULL DEFAULT '100' COMMENT '排序 排序值越小越靠前',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1-正常 0-隐藏 -1删除',
  PRIMARY KEY (`id`),
  KEY `exam_id_idx` (`exam_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of st_exam_item
-- ----------------------------
INSERT INTO `st_exam_item` VALUES ('1', '1', '1', '啊啊啊', '1', '{\"A\":\"啊啊啊啊啊啊啊啊啊啊啊啊啊啊白斑病白斑病\",\"B\":\"白斑病白斑病吧\",\"C\":\"草草草草草草草草草\",\"D\":\"滴答滴答滴答滴答滴答的\"}', 'D', '反反复复发', '吱吱吱吱吱吱吱吱吱吱吱吱吱吱在', '', '', '1542039232', '1542039232', '1', '1');
INSERT INTO `st_exam_item` VALUES ('2', '1', '2', '啊啊啊1', '1', '{\"A\":\"啊啊啊啊啊啊啊啊啊啊啊啊啊啊白斑病白斑病2\",\"B\":\"白斑病白斑病吧\",\"C\":\"草草草草草草草草草\",\"D\":\"滴答滴答滴答滴答滴答的\"}', 'D', '反反复复发', '吱吱吱吱吱吱吱吱吱吱吱吱吱吱在', '', '', '1542039906', '1542039906', '2', '1');
INSERT INTO `st_exam_item` VALUES ('3', '1', '3', '初识PhpStorm', '2', '{\"A\":\"啊啊啊啊啊啊啊啊啊啊啊啊啊啊白斑病白斑病3\",\"B\":\"白斑病白斑病吧3\",\"C\":\"草草草草草草草草草3\",\"D\":\"滴答滴答滴答滴答滴答的3\"}', 'D', '反反复复发3', '吱吱吱吱吱吱吱吱吱吱吱吱吱吱在3', '', '', '1542039932', '1547461657', '3', '1');
INSERT INTO `st_exam_item` VALUES ('4', '1', '3', '1', '2', '', '1', '1', '1', '', '', '1542113284', '1547461673', '4', '1');
INSERT INTO `st_exam_item` VALUES ('5', '2', '7', 'lunshu1', '3', '', 'lunshu1', 'lunshu1', 'lunshu123', '', '', '1542120943', '1547479245', '1003', '1');
INSERT INTO `st_exam_item` VALUES ('6', '2', '0', '12', '3', '', '1', '1', '1', '', '', '1542122521', '1542122831', '1001', '-1');
INSERT INTO `st_exam_item` VALUES ('7', '2', '5', 'ttt', '2', '', 'ttt1', 'ttttt', 'ttttt', '', '', '1542122953', '1547479210', '100', '1');
INSERT INTO `st_exam_item` VALUES ('8', '2', '5', '44', '2', '', '44', '44', '44', '', '', '1542122986', '1547479203', '100', '1');
INSERT INTO `st_exam_item` VALUES ('9', '2', '6', '1', '2', '', '1', '11', '1', '', '', '1542123030', '1547479227', '100', '1');
INSERT INTO `st_exam_item` VALUES ('10', '2', '7', '2', '3', '', '2', '22', '2', '', '', '1542123141', '1547479235', '100', '1');
INSERT INTO `st_exam_item` VALUES ('11', '1', '4', '111111', '1', '{\"A\":\"1\",\"B\":\"2\",\"C\":\"3\",\"D\":\"4\"}', 'AB', '22', '33', 'admin/20190202/4896f162a83ecb887906ae3ccb86b36c.jpg', '', '1544450805', '1549090626', '5', '1');
INSERT INTO `st_exam_item` VALUES ('12', '15', '9', '化学与人类生产、生活密切相关。下列有关说法不正确的是', '1', '{\"A\":\"可用钢瓶储存液氯或浓硫酸\",\"B\":\"聚乙烯塑料可用来制作食品周转箱\",\"C\":\"PM2.5与呼吸道疾病的形成无关\",\"D\":\"对矿物燃料脱硫脱硝可有效防治酸雨\"}', 'B', '分析', '知识点', 'admin/20190227/8aa82b97d4273af4ef3c10a8b9c5e2c9.jpg', 'admin/20190227/1ad018840d3f1f2119a7397f564a0043.jpg', '1548579226', '1551197585', '100', '1');
INSERT INTO `st_exam_item` VALUES ('13', '15', '9', '下列说就正确的是', '1', '{\"A\":\"甲苯的一氯代物有3种\",\"B\":\"乙烯通入溴的CCl4溶液中，发生加成反应\",\"C\":\"乙醇不能使酸性高锰酸钾溶液褪色\",\"D\":\"可以用NaOH溶被来分离乙酸和乙酸乙酯\"}', 'ABCD', '分析', '知识点', '', '', '1548581827', '1548581827', '100', '1');
INSERT INTO `st_exam_item` VALUES ('14', '15', '9', '基态锌原子的价电子排布式为_______；K、F、Zn的电负性从大到小的顺序为_______。', '2', null, '答案', '分析', '知识点', '', '', '1548582034', '1548583371', '100', '1');
INSERT INTO `st_exam_item` VALUES ('15', '15', '9', 'OF2分子的几何构型为__________，中心原子的杂化类型为__________________。', '2', null, '答案', '分析', '知识点', '', '', '1548582078', '1548583377', '100', '1');
INSERT INTO `st_exam_item` VALUES ('16', '15', '9', '二战后，美苏关系发生了什么变化？（1分）由此形成了怎样的世界格局？（1分）', '3', null, '（1）由合作到对峙。（1分） 两极格局（冷战格局）。（1分）', '分析', '知识点', '', '', '1548582816', '1548583383', '100', '1');
INSERT INTO `st_exam_item` VALUES ('17', '15', '9', '20世纪60年代，西欧国家为谋求共同发展有何重大举措？（1分）这一举措对国际关系带来了什么重要影响？（2分）', '3', null, '成立欧洲共同体。（1分） 冲击了两极格局，多极化趋势出现。（2分）', '分析', '知识点', '', '', '1548582881', '1548583389', '100', '1');
INSERT INTO `st_exam_item` VALUES ('18', '1', '4', '论述配图测试', '3', null, '论述配图测试', '论述配图测试', '论述配图测试', 'admin/20190202/55c3b2b0e2e69856cfe233cfe13aca3f.jpg', '', '1549090303', '1549090303', '100', '1');

-- ----------------------------
-- Table structure for st_exam_school_relation
-- ----------------------------
DROP TABLE IF EXISTS `st_exam_school_relation`;
CREATE TABLE `st_exam_school_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `exam_id` int(11) NOT NULL DEFAULT '0' COMMENT '试卷id(刷题题目id)',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '刷题分类id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COMMENT='学校-刷题-关联表';

-- ----------------------------
-- Records of st_exam_school_relation
-- ----------------------------
INSERT INTO `st_exam_school_relation` VALUES ('26', '1', '14', '5');
INSERT INTO `st_exam_school_relation` VALUES ('27', '2', '14', '5');
INSERT INTO `st_exam_school_relation` VALUES ('28', '2', '2', '6');
INSERT INTO `st_exam_school_relation` VALUES ('29', '3', '2', '6');
INSERT INTO `st_exam_school_relation` VALUES ('34', '1', '1', '5');
INSERT INTO `st_exam_school_relation` VALUES ('35', '3', '1', '5');
INSERT INTO `st_exam_school_relation` VALUES ('36', '2', '15', '6');
INSERT INTO `st_exam_school_relation` VALUES ('37', '3', '15', '6');

-- ----------------------------
-- Table structure for st_exam_section
-- ----------------------------
DROP TABLE IF EXISTS `st_exam_section`;
CREATE TABLE `st_exam_section` (
  `section_id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` int(11) NOT NULL DEFAULT '0' COMMENT 'exam_id',
  `idx` varchar(255) NOT NULL DEFAULT '' COMMENT '序号',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '内容数量',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 0-删除 1-正常',
  `list_order` int(11) NOT NULL DEFAULT '100',
  PRIMARY KEY (`section_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='exam章节表';

-- ----------------------------
-- Records of st_exam_section
-- ----------------------------
INSERT INTO `st_exam_section` VALUES ('1', '1', '第一章', '契', '0', '0', '1547460082', '1', '1001');
INSERT INTO `st_exam_section` VALUES ('2', '1', '第二章', '下山', '0', '0', '1547183060', '1', '1001');
INSERT INTO `st_exam_section` VALUES ('3', '1', '第三章', '拜师', '0', '1547182623', '1547184513', '1', '1003');
INSERT INTO `st_exam_section` VALUES ('4', '1', '第四章', '苦练', '0', '1547182707', '1547184841', '1', '1004');
INSERT INTO `st_exam_section` VALUES ('5', '2', '第一章', '前言', '0', '1547478958', '1547478958', '1', '100');
INSERT INTO `st_exam_section` VALUES ('6', '2', '第二章', '马克思主义', '0', '1547479011', '1547479122', '1', '100');
INSERT INTO `st_exam_section` VALUES ('7', '2', '第三章', '毛泽东思想', '0', '1547479111', '1547479111', '1', '100');
INSERT INTO `st_exam_section` VALUES ('8', '2', '第四章', '邓小平理论', '0', '1547479139', '1547479139', '1', '100');
INSERT INTO `st_exam_section` VALUES ('9', '15', '第一章', '选择', '0', '1548578934', '1548582138', '1', '100');
INSERT INTO `st_exam_section` VALUES ('10', '15', '第二章', '填空', '0', '1548578949', '1548582145', '1', '100');
INSERT INTO `st_exam_section` VALUES ('11', '15', '第三章', '论述', '0', '1548582119', '1551198551', '0', '100');

-- ----------------------------
-- Table structure for st_exam_userlog
-- ----------------------------
DROP TABLE IF EXISTS `st_exam_userlog`;
CREATE TABLE `st_exam_userlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `exam_id` int(11) NOT NULL DEFAULT '0' COMMENT '试卷id',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '题目名称',
  `subtitle` varchar(255) NOT NULL DEFAULT '' COMMENT '副标题',
  `property` tinyint(1) NOT NULL DEFAULT '0' COMMENT '题目类型',
  `create_time` int(10) NOT NULL DEFAULT '0',
  `update_time` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='用户的刷题记录';

-- ----------------------------
-- Records of st_exam_userlog
-- ----------------------------
INSERT INTO `st_exam_userlog` VALUES ('1', '2', '2', '西南大学2009研究生真题', '西南大学2009研究生真题1', '1', '1546527963', '1546527970');
INSERT INTO `st_exam_userlog` VALUES ('2', '2', '1', '重大密卷', '三年模拟五年高考', '1', '1546527993', '1549091492');
INSERT INTO `st_exam_userlog` VALUES ('3', '3', '1', '重大密卷', '三年模拟五年高考', '1', '1546527993', '1547735066');
INSERT INTO `st_exam_userlog` VALUES ('4', '3', '2', '西南大学&amp;北京大学2009研究生真题', '西南大学2009研究生真题1', '1', '1548052791', '1548598378');
INSERT INTO `st_exam_userlog` VALUES ('5', '13', '1', '重大和北大都能用到的模拟题', '三年模拟五年高考', '2', '1548573307', '1548573340');
INSERT INTO `st_exam_userlog` VALUES ('6', '3', '15', '2008年黄冈密卷高考题111', '2008年黄冈密卷高考题222', '2', '1548583314', '1548598260');
INSERT INTO `st_exam_userlog` VALUES ('7', '2', '15', '2008年黄冈密卷高考题111', '2008年黄冈密卷高考题222', '2', '1548599887', '1551198044');

-- ----------------------------
-- Table structure for st_exam_wronglist
-- ----------------------------
DROP TABLE IF EXISTS `st_exam_wronglist`;
CREATE TABLE `st_exam_wronglist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `exam_id` int(11) NOT NULL DEFAULT '0' COMMENT '试卷id',
  `exam_name` varchar(1024) NOT NULL DEFAULT '' COMMENT '试卷名称',
  `exam_item_id` int(11) NOT NULL DEFAULT '0',
  `exam_item_name` varchar(1024) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '题目类型 1-选择题 2-填空题 3-论述题',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1-正常 0-已删除',
  PRIMARY KEY (`id`),
  KEY `item_id` (`exam_item_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='用户-错题表';

-- ----------------------------
-- Records of st_exam_wronglist
-- ----------------------------
INSERT INTO `st_exam_wronglist` VALUES ('2', '3', '15', '2008年黄冈密卷高考题111', '14', '基态锌原子的价电子排布式为_______；K、F、Zn的电负性从大到小的顺序为_______。', '2', '1548583735', '1');
INSERT INTO `st_exam_wronglist` VALUES ('3', '3', '15', '2008年黄冈密卷高考题111', '16', '二战后，美苏关系发生了什么变化？（1分）由此形成了怎样的世界格局？（1分）', '3', '1548583736', '1');
INSERT INTO `st_exam_wronglist` VALUES ('4', '3', '15', '2008年黄冈密卷高考题111', '15', 'OF2分子的几何构型为__________，中心原子的杂化类型为__________________。', '2', '1548583739', '1');
INSERT INTO `st_exam_wronglist` VALUES ('5', '3', '15', '2008年黄冈密卷高考题111', '17', '20世纪60年代，西欧国家为谋求共同发展有何重大举措？（1分）这一举措对国际关系带来了什么重要影响？（2分）', '3', '1548583742', '1');
INSERT INTO `st_exam_wronglist` VALUES ('7', '3', '15', '2008年黄冈密卷高考题111', '13', '下列说就正确的是', '1', '1548592478', '1');
INSERT INTO `st_exam_wronglist` VALUES ('8', '3', '15', '2008年黄冈密卷高考题111', '12', '化学与人类生产、生活密切相关。下列有关说法不正确的是', '1', '1548597121', '1');

-- ----------------------------
-- Table structure for st_feedback
-- ----------------------------
DROP TABLE IF EXISTS `st_feedback`;
CREATE TABLE `st_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1-功能建议 2-课程建议 3-程序错误',
  `content` text COMMENT '内容',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `is_check` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否查看 0-没有 1-已查看',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1-正常 0-已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of st_feedback
-- ----------------------------
INSERT INTO `st_feedback` VALUES ('1', '2', '1', '12312312321', '0', '0', '0', '1');
INSERT INTO `st_feedback` VALUES ('2', '2', '1', '12312312321', '1544945820', '1544945820', '0', '1');
INSERT INTO `st_feedback` VALUES ('3', '2', '3', '程序错误程序错误程序错误程序错误程序错误\n40404040404', '1544946134', '1544946134', '0', '1');
INSERT INTO `st_feedback` VALUES ('4', '2', '3', '程序错误程序错误程序错误程序错误程序错误\n40404040404', '1545058935', '1545058935', '0', '1');

-- ----------------------------
-- Table structure for st_goods
-- ----------------------------
DROP TABLE IF EXISTS `st_goods`;
CREATE TABLE `st_goods` (
  `goods_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL DEFAULT '0',
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `image` varchar(512) NOT NULL DEFAULT '' COMMENT '商品预览图片',
  `cost_price` int(11) NOT NULL DEFAULT '0' COMMENT '原价',
  `price` int(11) NOT NULL DEFAULT '0' COMMENT '销售价',
  `stock` int(11) NOT NULL DEFAULT '-1' COMMENT '库存 -1无限库存 其他为库存数量',
  `goods_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '商品类型 1-刷题 2-打卡 3-在线课堂 4-线下课堂 5-其他 ',
  `create_time` int(10) NOT NULL DEFAULT '0',
  `update_time` int(10) NOT NULL DEFAULT '0',
  `delete_time` int(10) NOT NULL,
  `goods_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 1:已发布;0:未发布;-1:删除',
  PRIMARY KEY (`goods_id`),
  KEY `type` (`goods_type`),
  KEY `id_type` (`goods_id`,`goods_type`),
  KEY `status` (`goods_status`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- ----------------------------
-- Records of st_goods
-- ----------------------------
INSERT INTO `st_goods` VALUES ('3', '14', '好像下班了', 'admin/20181227/6776dee3c6e0de549ad8f33147b6f135.gif', '0', '0', '-1', '2', '1547881664', '1547904576', '0', '1');
INSERT INTO `st_goods` VALUES ('6', '14', '今天周六, 可是我却在加班', 'admin/20190119/5ce2bc90a1463efcbae065d39662b597.jpg', '888', '188', '97', '2', '1547882026', '1547882026', '0', '0');
INSERT INTO `st_goods` VALUES ('8', '14', '1111', '', '333', '222', '111', '2', '1547882253', '1547882253', '0', '0');
INSERT INTO `st_goods` VALUES ('9', '14', '今天是2018年最后一天咯', 'admin/20181231/5340d43f7b1eecdb25a81e8fe4d15d3b.jpg', '99', '89', '-1', '2', '1547905009', '1547905009', '0', '1');
INSERT INTO `st_goods` VALUES ('10', '13', '咸鱼的梦想', 'admin/20190304/009a520e8c1ceb0c8470a13dd7da176a.jpg', '0', '0', '-1', '2', '1547905146', '1551710999', '0', '1');
INSERT INTO `st_goods` VALUES ('12', '10', 'nginx123111', 'admin/20190125/e156967f4432be813bc242487a03263b.png', '128', '68', '-1', '3', '1547906935', '1548397788', '0', '1');
INSERT INTO `st_goods` VALUES ('13', '10', 'redis高级教程', 'admin/20190119/9ee1df243c60a34500ae3534cf0448fd.jpg', '999', '666', '-1', '3', '1547908631', '1548212196', '0', '1');
INSERT INTO `st_goods` VALUES ('14', '7', '园林设计之美', 'portal/20181031/c7cae5f03d3af648e043704ec6f45296.jpg', '298', '198', '98', '1', '1547909089', '1547909662', '0', '1');
INSERT INTO `st_goods` VALUES ('15', '5', '重大和北大都能用到的模拟题', 'admin/20181216/f966c57f8fb54b31b1c8307a6b503273.jpg', '123', '23', '-1', '1', '1547909719', '1547909719', '0', '1');
INSERT INTO `st_goods` VALUES ('16', '6', '西南大学&amp;北京大学2009研究生真题', 'admin/20181107/5948e168d9114ce4ba0e11c983a9c467.jpg', '0', '0', '-1', '1', '1547909772', '1547909772', '0', '1');
INSERT INTO `st_goods` VALUES ('17', '5', '2008年黄冈密卷高考题', '', '0', '0', '-1', '1', '1547909785', '1547909785', '0', '1');
INSERT INTO `st_goods` VALUES ('18', '9', '222', 'admin/20181107/5948e168d9114ce4ba0e11c983a9c467.jpg', '0', '0', '-1', '3', '1547909816', '1547909816', '0', '1');
INSERT INTO `st_goods` VALUES ('19', '9', '222', 'admin/20181107/5948e168d9114ce4ba0e11c983a9c467.jpg', '0', '0', '-1', '3', '1547909824', '1547909824', '0', '1');
INSERT INTO `st_goods` VALUES ('20', '6', '2008年黄冈密卷高考题111', 'admin/20190203/1054aa221a00ac24f939ca1469a0e02b.jpg', '123', '12', '-1', '1', '1547909834', '1549125175', '0', '1');
INSERT INTO `st_goods` VALUES ('21', '13', '中国古典建筑', 'admin/20181231/ac835582916a3ea5d7b48dc86b9fb151.jpg', '0', '0', '-1', '2', '1547909881', '1550758574', '0', '1');
INSERT INTO `st_goods` VALUES ('22', '13', '23432423432', '', '0', '0', '-1', '2', '1547909898', '1547909898', '0', '1');
INSERT INTO `st_goods` VALUES ('23', '5', '重大和北大都能用到的模拟题', 'admin/20190203/fc0116bdbc530e1be12a762d19fdf89f.jpg', '123', '23', '-1', '1', '1547910058', '1549124765', '0', '1');
INSERT INTO `st_goods` VALUES ('24', '12', '自动加载自动加载自动加载', 'admin/20190304/5694605cf3ccbe46c251a3194b13e2fd.jpg', '0', '0', '-1', '2', '1551711169', '1551711364', '0', '1');

-- ----------------------------
-- Table structure for st_hook
-- ----------------------------
DROP TABLE IF EXISTS `st_hook`;
CREATE TABLE `st_hook` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '钩子类型(1:系统钩子;2:应用钩子;3:模板钩子;4:后台模板钩子)',
  `once` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否只允许一个插件运行(0:多个;1:一个)',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `hook` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子',
  `app` varchar(15) NOT NULL DEFAULT '' COMMENT '应用名(只有应用钩子才用)',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COMMENT='系统钩子表';

-- ----------------------------
-- Records of st_hook
-- ----------------------------
INSERT INTO `st_hook` VALUES ('1', '1', '0', '应用初始化', 'app_init', 'cmf', '应用初始化');
INSERT INTO `st_hook` VALUES ('2', '1', '0', '应用开始', 'app_begin', 'cmf', '应用开始');
INSERT INTO `st_hook` VALUES ('3', '1', '0', '模块初始化', 'module_init', 'cmf', '模块初始化');
INSERT INTO `st_hook` VALUES ('4', '1', '0', '控制器开始', 'action_begin', 'cmf', '控制器开始');
INSERT INTO `st_hook` VALUES ('5', '1', '0', '视图输出过滤', 'view_filter', 'cmf', '视图输出过滤');
INSERT INTO `st_hook` VALUES ('6', '1', '0', '应用结束', 'app_end', 'cmf', '应用结束');
INSERT INTO `st_hook` VALUES ('7', '1', '0', '日志write方法', 'log_write', 'cmf', '日志write方法');
INSERT INTO `st_hook` VALUES ('8', '1', '0', '输出结束', 'response_end', 'cmf', '输出结束');
INSERT INTO `st_hook` VALUES ('9', '1', '0', '后台控制器初始化', 'admin_init', 'cmf', '后台控制器初始化');
INSERT INTO `st_hook` VALUES ('10', '1', '0', '前台控制器初始化', 'home_init', 'cmf', '前台控制器初始化');
INSERT INTO `st_hook` VALUES ('11', '1', '1', '发送手机验证码', 'send_mobile_verification_code', 'cmf', '发送手机验证码');
INSERT INTO `st_hook` VALUES ('12', '3', '0', '模板 body标签开始', 'body_start', '', '模板 body标签开始');
INSERT INTO `st_hook` VALUES ('13', '3', '0', '模板 head标签结束前', 'before_head_end', '', '模板 head标签结束前');
INSERT INTO `st_hook` VALUES ('14', '3', '0', '模板底部开始', 'footer_start', '', '模板底部开始');
INSERT INTO `st_hook` VALUES ('15', '3', '0', '模板底部开始之前', 'before_footer', '', '模板底部开始之前');
INSERT INTO `st_hook` VALUES ('16', '3', '0', '模板底部结束之前', 'before_footer_end', '', '模板底部结束之前');
INSERT INTO `st_hook` VALUES ('17', '3', '0', '模板 body 标签结束之前', 'before_body_end', '', '模板 body 标签结束之前');
INSERT INTO `st_hook` VALUES ('18', '3', '0', '模板左边栏开始', 'left_sidebar_start', '', '模板左边栏开始');
INSERT INTO `st_hook` VALUES ('19', '3', '0', '模板左边栏结束之前', 'before_left_sidebar_end', '', '模板左边栏结束之前');
INSERT INTO `st_hook` VALUES ('20', '3', '0', '模板右边栏开始', 'right_sidebar_start', '', '模板右边栏开始');
INSERT INTO `st_hook` VALUES ('21', '3', '0', '模板右边栏结束之前', 'before_right_sidebar_end', '', '模板右边栏结束之前');
INSERT INTO `st_hook` VALUES ('22', '3', '1', '评论区', 'comment', '', '评论区');
INSERT INTO `st_hook` VALUES ('23', '3', '1', '留言区', 'guestbook', '', '留言区');
INSERT INTO `st_hook` VALUES ('24', '2', '0', '后台首页仪表盘', 'admin_dashboard', 'admin', '后台首页仪表盘');
INSERT INTO `st_hook` VALUES ('25', '4', '0', '后台模板 head标签结束前', 'admin_before_head_end', '', '后台模板 head标签结束前');
INSERT INTO `st_hook` VALUES ('26', '4', '0', '后台模板 body 标签结束之前', 'admin_before_body_end', '', '后台模板 body 标签结束之前');
INSERT INTO `st_hook` VALUES ('27', '2', '0', '后台登录页面', 'admin_login', 'admin', '后台登录页面');
INSERT INTO `st_hook` VALUES ('28', '1', '1', '前台模板切换', 'switch_theme', 'cmf', '前台模板切换');
INSERT INTO `st_hook` VALUES ('29', '3', '0', '主要内容之后', 'after_content', '', '主要内容之后');
INSERT INTO `st_hook` VALUES ('30', '2', '0', '文章显示之前', 'portal_before_assign_article', 'portal', '文章显示之前');
INSERT INTO `st_hook` VALUES ('31', '2', '0', '后台文章保存之后', 'portal_admin_after_save_article', 'portal', '后台文章保存之后');
INSERT INTO `st_hook` VALUES ('32', '2', '1', '获取上传界面', 'fetch_upload_view', 'user', '获取上传界面');
INSERT INTO `st_hook` VALUES ('33', '3', '0', '主要内容之前', 'before_content', 'cmf', '主要内容之前');
INSERT INTO `st_hook` VALUES ('34', '1', '0', '日志写入完成', 'log_write_done', 'cmf', '日志写入完成');
INSERT INTO `st_hook` VALUES ('35', '1', '1', '后台模板切换', 'switch_admin_theme', 'cmf', '后台模板切换');
INSERT INTO `st_hook` VALUES ('36', '1', '1', '验证码图片', 'captcha_image', 'cmf', '验证码图片');
INSERT INTO `st_hook` VALUES ('37', '2', '1', '后台模板设计界面', 'admin_theme_design_view', 'admin', '后台模板设计界面');
INSERT INTO `st_hook` VALUES ('38', '2', '1', '后台设置网站信息界面', 'admin_setting_site_view', 'admin', '后台设置网站信息界面');
INSERT INTO `st_hook` VALUES ('39', '2', '1', '后台清除缓存界面', 'admin_setting_clear_cache_view', 'admin', '后台清除缓存界面');
INSERT INTO `st_hook` VALUES ('40', '2', '1', '后台导航管理界面', 'admin_nav_index_view', 'admin', '后台导航管理界面');
INSERT INTO `st_hook` VALUES ('41', '2', '1', '后台友情链接管理界面', 'admin_link_index_view', 'admin', '后台友情链接管理界面');
INSERT INTO `st_hook` VALUES ('42', '2', '1', '后台幻灯片管理界面', 'admin_slide_index_view', 'admin', '后台幻灯片管理界面');
INSERT INTO `st_hook` VALUES ('43', '2', '1', '后台管理员列表界面', 'admin_user_index_view', 'admin', '后台管理员列表界面');
INSERT INTO `st_hook` VALUES ('44', '2', '1', '后台角色管理界面', 'admin_rbac_index_view', 'admin', '后台角色管理界面');
INSERT INTO `st_hook` VALUES ('45', '2', '1', '门户后台文章管理列表界面', 'portal_admin_article_index_view', 'portal', '门户后台文章管理列表界面');
INSERT INTO `st_hook` VALUES ('46', '2', '1', '门户后台文章分类管理列表界面', 'portal_admin_category_index_view', 'portal', '门户后台文章分类管理列表界面');
INSERT INTO `st_hook` VALUES ('47', '2', '1', '门户后台页面管理列表界面', 'portal_admin_page_index_view', 'portal', '门户后台页面管理列表界面');
INSERT INTO `st_hook` VALUES ('48', '2', '1', '门户后台文章标签管理列表界面', 'portal_admin_tag_index_view', 'portal', '门户后台文章标签管理列表界面');
INSERT INTO `st_hook` VALUES ('49', '2', '1', '用户管理本站用户列表界面', 'user_admin_index_view', 'user', '用户管理本站用户列表界面');
INSERT INTO `st_hook` VALUES ('50', '2', '1', '资源管理列表界面', 'user_admin_asset_index_view', 'user', '资源管理列表界面');
INSERT INTO `st_hook` VALUES ('51', '2', '1', '用户管理第三方用户列表界面', 'user_admin_oauth_index_view', 'user', '用户管理第三方用户列表界面');
INSERT INTO `st_hook` VALUES ('52', '2', '1', '后台首页界面', 'admin_index_index_view', 'admin', '后台首页界面');
INSERT INTO `st_hook` VALUES ('53', '2', '1', '后台回收站界面', 'admin_recycle_bin_index_view', 'admin', '后台回收站界面');
INSERT INTO `st_hook` VALUES ('54', '2', '1', '后台菜单管理界面', 'admin_menu_index_view', 'admin', '后台菜单管理界面');
INSERT INTO `st_hook` VALUES ('55', '2', '1', '后台自定义登录是否开启钩子', 'admin_custom_login_open', 'admin', '后台自定义登录是否开启钩子');
INSERT INTO `st_hook` VALUES ('56', '4', '0', '门户后台文章添加编辑界面右侧栏', 'portal_admin_article_edit_view_right_sidebar', 'portal', '门户后台文章添加编辑界面右侧栏');
INSERT INTO `st_hook` VALUES ('57', '4', '0', '门户后台文章添加编辑界面主要内容', 'portal_admin_article_edit_view_main', 'portal', '门户后台文章添加编辑界面主要内容');
INSERT INTO `st_hook` VALUES ('58', '2', '1', '门户后台文章添加界面', 'portal_admin_article_add_view', 'portal', '门户后台文章添加界面');
INSERT INTO `st_hook` VALUES ('59', '2', '1', '门户后台文章编辑界面', 'portal_admin_article_edit_view', 'portal', '门户后台文章编辑界面');
INSERT INTO `st_hook` VALUES ('60', '2', '1', '门户后台文章分类添加界面', 'portal_admin_category_add_view', 'portal', '门户后台文章分类添加界面');
INSERT INTO `st_hook` VALUES ('61', '2', '1', '门户后台文章分类编辑界面', 'portal_admin_category_edit_view', 'portal', '门户后台文章分类编辑界面');
INSERT INTO `st_hook` VALUES ('62', '2', '1', '门户后台页面添加界面', 'portal_admin_page_add_view', 'portal', '门户后台页面添加界面');
INSERT INTO `st_hook` VALUES ('63', '2', '1', '门户后台页面编辑界面', 'portal_admin_page_edit_view', 'portal', '门户后台页面编辑界面');
INSERT INTO `st_hook` VALUES ('64', '2', '1', '后台幻灯片页面列表界面', 'admin_slide_item_index_view', 'admin', '后台幻灯片页面列表界面');
INSERT INTO `st_hook` VALUES ('65', '2', '1', '后台幻灯片页面添加界面', 'admin_slide_item_add_view', 'admin', '后台幻灯片页面添加界面');
INSERT INTO `st_hook` VALUES ('66', '2', '1', '后台幻灯片页面编辑界面', 'admin_slide_item_edit_view', 'admin', '后台幻灯片页面编辑界面');
INSERT INTO `st_hook` VALUES ('67', '2', '1', '后台管理员添加界面', 'admin_user_add_view', 'admin', '后台管理员添加界面');
INSERT INTO `st_hook` VALUES ('68', '2', '1', '后台管理员编辑界面', 'admin_user_edit_view', 'admin', '后台管理员编辑界面');
INSERT INTO `st_hook` VALUES ('69', '2', '1', '后台角色添加界面', 'admin_rbac_role_add_view', 'admin', '后台角色添加界面');
INSERT INTO `st_hook` VALUES ('70', '2', '1', '后台角色编辑界面', 'admin_rbac_role_edit_view', 'admin', '后台角色编辑界面');
INSERT INTO `st_hook` VALUES ('71', '2', '1', '后台角色授权界面', 'admin_rbac_authorize_view', 'admin', '后台角色授权界面');

-- ----------------------------
-- Table structure for st_hook_plugin
-- ----------------------------
DROP TABLE IF EXISTS `st_hook_plugin`;
CREATE TABLE `st_hook_plugin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `hook` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名',
  `plugin` varchar(50) NOT NULL DEFAULT '' COMMENT '插件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='系统钩子插件表';

-- ----------------------------
-- Records of st_hook_plugin
-- ----------------------------
INSERT INTO `st_hook_plugin` VALUES ('2', '10000', '1', 'send_mobile_verification_code', 'MobileCodeDemo');

-- ----------------------------
-- Table structure for st_link
-- ----------------------------
DROP TABLE IF EXISTS `st_link`;
CREATE TABLE `st_link` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:不显示',
  `rating` int(11) NOT NULL DEFAULT '0' COMMENT '友情链接评级',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接描述',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接地址',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '友情链接名称',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '友情链接图标',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `rel` varchar(50) NOT NULL DEFAULT '' COMMENT '链接与网站的关系',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='友情链接表';

-- ----------------------------
-- Records of st_link
-- ----------------------------

-- ----------------------------
-- Table structure for st_nav
-- ----------------------------
DROP TABLE IF EXISTS `st_nav`;
CREATE TABLE `st_nav` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_main` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否为主导航;1:是;0:不是',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '导航位置名称',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='前台导航位置表';

-- ----------------------------
-- Records of st_nav
-- ----------------------------
INSERT INTO `st_nav` VALUES ('1', '1', '主导航', '主导航');
INSERT INTO `st_nav` VALUES ('2', '0', '底部导航', '');

-- ----------------------------
-- Table structure for st_nav_menu
-- ----------------------------
DROP TABLE IF EXISTS `st_nav_menu`;
CREATE TABLE `st_nav_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nav_id` int(11) NOT NULL COMMENT '导航 id',
  `parent_id` int(11) NOT NULL COMMENT '父 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '打开方式',
  `href` varchar(100) NOT NULL DEFAULT '' COMMENT '链接',
  `icon` varchar(20) NOT NULL DEFAULT '' COMMENT '图标',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='前台导航菜单表';

-- ----------------------------
-- Records of st_nav_menu
-- ----------------------------
INSERT INTO `st_nav_menu` VALUES ('1', '1', '0', '1', '0', '首页', '', 'home', '', '0-1');

-- ----------------------------
-- Table structure for st_option
-- ----------------------------
DROP TABLE IF EXISTS `st_option`;
CREATE TABLE `st_option` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `autoload` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否自动加载;1:自动加载;0:不自动加载',
  `option_name` varchar(64) NOT NULL DEFAULT '' COMMENT '配置名',
  `option_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '配置值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='全站配置表';

-- ----------------------------
-- Records of st_option
-- ----------------------------
INSERT INTO `st_option` VALUES ('1', '1', 'site_info', '{\"site_name\":\"\\u98ce\\u66b4\\u624b\\u7ed8\",\"site_seo_title\":\"\\u98ce\\u66b4\\u624b\\u7ed8\",\"site_seo_keywords\":\"\\u98ce\\u66b4\\u624b\\u7ed8\",\"site_seo_description\":\"\\u98ce\\u66b4\\u624b\\u7ed8\"}');
INSERT INTO `st_option` VALUES ('2', '1', 'wxapp_settings', '{\"default\":{\"name\":\"\\u98ce\\u66b4\\u624b\\u7ed8\",\"app_id\":\"aaa\",\"app_secret\":\"bbb\",\"is_default\":\"1\",\"_plugin\":\"wxapp\",\"_controller\":\"admin_wxapp\",\"_action\":\"addpost\"},\"wxapps\":{\"aaa\":{\"name\":\"\\u98ce\\u66b4\\u624b\\u7ed8\",\"app_id\":\"aaa\",\"app_secret\":\"bbb\",\"_plugin\":\"wxapp\",\"_controller\":\"admin_wxapp\",\"_action\":\"addpost\"}}}');
INSERT INTO `st_option` VALUES ('3', '1', 'storage', '{\"storages\":[],\"type\":\"Local\"}');

-- ----------------------------
-- Table structure for st_order
-- ----------------------------
DROP TABLE IF EXISTS `st_order`;
CREATE TABLE `st_order` (
  `order_id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL DEFAULT '' COMMENT '订单号，唯一',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id，同user的id',
  `user_name` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名称',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品id',
  `goods_amount` int(11) NOT NULL DEFAULT '0' COMMENT '商品总价格',
  `pay_fee` int(11) NOT NULL DEFAULT '0' COMMENT '支付费用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '订单生成时间',
  `pay_time` int(11) NOT NULL DEFAULT '0' COMMENT '支付时间',
  `order_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单状态。0，未确认；1，已确认；2，已取消；3，无效；4，退货；',
  `pay_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '支付状态；0，未付款；1，付款中；2，已付款',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_sn` (`order_sn`) USING BTREE,
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- ----------------------------
-- Records of st_order
-- ----------------------------
INSERT INTO `st_order` VALUES ('1', '2019012056101101', '2', '张三1', '9', '0', '0', '0', '1547956200', '1', '2');
INSERT INTO `st_order` VALUES ('6', '2019012049494998', '2', '张三1', '6', '188', '188', '0', '1547957472', '1', '2');
INSERT INTO `st_order` VALUES ('7', '2019012097515410', '2', '张三1', '14', '198', '198', '0', '1547961834', '1', '2');
INSERT INTO `st_order` VALUES ('8', '2019012056101535', '2', '张三1', '23', '23', '23', '0', '1547962056', '1', '2');
INSERT INTO `st_order` VALUES ('9', '2019012010251975', '2', '张三1', '10', '12', '12', '0', '1547962111', '1', '2');
INSERT INTO `st_order` VALUES ('10', '2019012050545751', '2', '张三1', '21', '0', '0', '0', '1547962146', '1', '2');
INSERT INTO `st_order` VALUES ('11', '2019012050991021', '2', '张三1', '22', '0', '0', '0', '1547962210', '1', '2');
INSERT INTO `st_order` VALUES ('12', '2019012097561021', '2', '张三1', '12', '68', '68', '0', '1547962314', '1', '2');
INSERT INTO `st_order` VALUES ('13', '2019012551485797', '2', '张三1', '13', '666', '666', '0', '1548407650', '1', '2');
INSERT INTO `st_order` VALUES ('14', '2019012553525254', '2', '张三1', '20', '12', '12', '0', '1548407733', '1', '2');

-- ----------------------------
-- Table structure for st_plugin
-- ----------------------------
DROP TABLE IF EXISTS `st_plugin`;
CREATE TABLE `st_plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '插件类型;1:网站;8:微信',
  `has_admin` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台管理,0:没有;1:有',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:开启;0:禁用',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '插件标识名,英文字母(惟一)',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件名称',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `hooks` varchar(255) NOT NULL DEFAULT '' COMMENT '实现的钩子;以“,”分隔',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '插件版本号',
  `description` varchar(255) NOT NULL COMMENT '插件描述',
  `config` text COMMENT '插件配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='插件表';

-- ----------------------------
-- Records of st_plugin
-- ----------------------------
INSERT INTO `st_plugin` VALUES ('2', '1', '1', '1', '0', 'Wxapp', '微信小程序', 'http://demo.thinkcmf.com', '', 'ThinkCMF', 'http://www.thinkcmf.com', '1.0', '微信小程序管理工具', '[]');
INSERT INTO `st_plugin` VALUES ('4', '1', '0', '1', '0', 'MobileCodeDemo', '手机验证码演示插件', '', '', 'ThinkCMF', '', '1.0', '手机验证码演示插件', '{\"account_sid\":\"\",\"auth_token\":\"\",\"app_id\":\"\",\"template_id\":\"\",\"expire_minute\":\"30\"}');

-- ----------------------------
-- Table structure for st_portal_category
-- ----------------------------
DROP TABLE IF EXISTS `st_portal_category`;
CREATE TABLE `st_portal_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类父id',
  `post_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类文章数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `alias` varchar(200) NOT NULL DEFAULT '' COMMENT '小标题',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) NOT NULL DEFAULT '',
  `seo_keywords` varchar(255) NOT NULL DEFAULT '',
  `seo_description` varchar(255) NOT NULL DEFAULT '',
  `list_tpl` varchar(50) NOT NULL DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) NOT NULL DEFAULT '' COMMENT '分类文章页模板',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章分类表';

-- ----------------------------
-- Records of st_portal_category
-- ----------------------------
INSERT INTO `st_portal_category` VALUES ('1', '0', '0', '1', '0', '10000', '头条', '', '', '0-1', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('2', '0', '0', '1', '0', '10000', '线下打卡', '', '', '0-2', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('3', '1', '0', '1', '0', '10000', '建筑', '', '', '0-1-3', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('4', '1', '0', '1', '0', '10000', '规划', '', '', '0-1-4', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('5', '1', '0', '1', '0', '10000', '园林', '', '', '0-1-5', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('6', '1', '0', '1', '0', '10000', '环艺', '', '', '0-1-6', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('7', '1', '0', '1', '0', '10000', '工业', '', '', '0-1-7', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('8', '1', '0', '1', '0', '10000', '平面', '', '', '0-1-8', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('9', '2', '0', '1', '0', '10000', '建筑专业', '', '', '0-2-9', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('10', '2', '0', '1', '0', '10000', '城市规划', '', '', '0-2-10', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('11', '2', '0', '1', '0', '10000', '园林景观', '', '', '0-2-11', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('12', '2', '0', '1', '0', '10000', '环境艺术', '', '', '0-2-12', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('13', '2', '0', '1', '0', '10000', '工业设计', '', '', '0-2-13', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('14', '2', '0', '1', '0', '10000', '平面设计', '', '', '0-2-14', '', '', '', '', '', '{\"thumbnail\":\"\"}');
INSERT INTO `st_portal_category` VALUES ('15', '2', '0', '1', '0', '10000', '其他', '', '', '0-2-15', '', '', '', '', '', '{\"thumbnail\":\"\"}');

-- ----------------------------
-- Table structure for st_portal_category_post
-- ----------------------------
DROP TABLE IF EXISTS `st_portal_category_post`;
CREATE TABLE `st_portal_category_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文章id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `term_taxonomy_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='portal应用 分类文章对应表';

-- ----------------------------
-- Records of st_portal_category_post
-- ----------------------------
INSERT INTO `st_portal_category_post` VALUES ('1', '1', '3', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('2', '2', '3', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('3', '3', '3', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('4', '4', '3', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('5', '5', '3', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('6', '6', '3', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('7', '7', '3', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('8', '8', '3', '1', '1');
INSERT INTO `st_portal_category_post` VALUES ('9', '9', '3', '2', '1');
INSERT INTO `st_portal_category_post` VALUES ('10', '10', '3', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('11', '11', '3', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('12', '12', '9', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('13', '13', '9', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('14', '14', '9', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('15', '15', '9', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('16', '16', '9', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('17', '17', '9', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('18', '18', '9', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('19', '19', '9', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('21', '21', '9', '10000', '1');
INSERT INTO `st_portal_category_post` VALUES ('22', '22', '9', '10000', '1');

-- ----------------------------
-- Table structure for st_portal_post
-- ----------------------------
DROP TABLE IF EXISTS `st_portal_post`;
CREATE TABLE `st_portal_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:已发布;0:未发布;',
  `comment_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论状态;1:允许;0:不允许',
  `is_top` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶;1:置顶;0:不置顶',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_hits` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '查看数',
  `post_favorites` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  `post_like` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `comment_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `published_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `post_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `post_content` text COMMENT '文章内容',
  `post_content_filtered` text COMMENT '处理过的文章内容',
  `more` text COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`),
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`),
  KEY `parent_id` (`parent_id`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='portal应用 文章表';

-- ----------------------------
-- Records of st_portal_post
-- ----------------------------
INSERT INTO `st_portal_post` VALUES ('1', '0', '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1548564356', '1548564356', '1548605933', '0', '建筑速写基础入门-详情解析的城市展', '', '上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/961f130aea0538280f6284c57e43b1bf.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/961f130aea0538280f6284c57e43b1bf.png\"}');
INSERT INTO `st_portal_post` VALUES ('2', '0', '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1548564356', '1548568739', '1548605933', '0', '建筑速写基础入门-详情解析的城市展', '', '上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/961f130aea0538280f6284c57e43b1bf.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"audio\":\"\",\"video\":\"\",\"thumbnail\":\"portal\\/20190127\\/961f130aea0538280f6284c57e43b1bf.png\"}');
INSERT INTO `st_portal_post` VALUES ('3', '0', '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1548564356', '1548564356', '1548605933', '0', '建筑速写基础入门-详情解析的城市展', '', '上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/961f130aea0538280f6284c57e43b1bf.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/961f130aea0538280f6284c57e43b1bf.png\"}');
INSERT INTO `st_portal_post` VALUES ('4', '0', '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1548564356', '1548564356', '1548605933', '0', '建筑速写基础入门-详情解析的城市展', '', '上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/961f130aea0538280f6284c57e43b1bf.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/961f130aea0538280f6284c57e43b1bf.png\"}');
INSERT INTO `st_portal_post` VALUES ('5', '0', '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1548564356', '1548564356', '1548605933', '0', '建筑速写基础入门-详情解析的城市展', '', '上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/961f130aea0538280f6284c57e43b1bf.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/961f130aea0538280f6284c57e43b1bf.png\"}');
INSERT INTO `st_portal_post` VALUES ('6', '0', '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1548564356', '1548564356', '1548605933', '0', '建筑速写基础入门-详情解析的城市展', '', '上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/961f130aea0538280f6284c57e43b1bf.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/961f130aea0538280f6284c57e43b1bf.png\"}');
INSERT INTO `st_portal_post` VALUES ('7', '0', '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1548564356', '1548564356', '1548605933', '0', '建筑速写基础入门-详情解析的城市展', '', '上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/961f130aea0538280f6284c57e43b1bf.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/961f130aea0538280f6284c57e43b1bf.png\"}');
INSERT INTO `st_portal_post` VALUES ('8', '0', '1', '1', '1', '1', '1', '0', '1', '0', '0', '0', '0', '1548564356', '1548564356', '1548605933', '0', '建筑速写基础入门-详情解析的城市展', '', '上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/961f130aea0538280f6284c57e43b1bf.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/961f130aea0538280f6284c57e43b1bf.png\"}');
INSERT INTO `st_portal_post` VALUES ('9', '0', '1', '1', '1', '1', '1', '0', '1', '0', '0', '0', '0', '1548564356', '1548564356', '1548605933', '0', '建筑速写基础入门-详情解析的城市展', '', '上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/961f130aea0538280f6284c57e43b1bf.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/961f130aea0538280f6284c57e43b1bf.png\"}');
INSERT INTO `st_portal_post` VALUES ('10', '0', '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1548564356', '1549125787', '1548605880', '0', '建筑速写基础入门-详情解析的城市展', '', '上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/961f130aea0538280f6284c57e43b1bf.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;img src=&quot;https://img.fengbaojy.com/default/20190203/ca9b5ab9683337b5514270fbf9b21f3d.jpg&quot; title=&quot;48b56854b52e7c791bc5048f37bdf4db.jpg&quot; alt=&quot;48b56854b52e7c791bc5048f37bdf4db.jpg&quot;&gt;&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/961f130aea0538280f6284c57e43b1bf.png\"}');
INSERT INTO `st_portal_post` VALUES ('11', '0', '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1548564356', '1548564356', '1548605941', '0', '建筑速写基础入门-详情解析的城市展', '', '上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/961f130aea0538280f6284c57e43b1bf.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/961f130aea0538280f6284c57e43b1bf.png\"}');
INSERT INTO `st_portal_post` VALUES ('12', '0', '1', '1', '1', '1', '1', '0', '0', '2', '0', '0', '0', '1548569565', '1548571436', '1548569280', '0', '西扎新作，隐藏在密林里的混凝土艺术馆', '2018年2月21日 - 2018年4月21', '为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/eb2f839e608b32a906229a934837b983.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/eb2f839e608b32a906229a934837b983.png\"}');
INSERT INTO `st_portal_post` VALUES ('13', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1548569565', '1548569565', '1548569280', '0', '西扎新作，隐藏在密林里的混凝土艺术馆', '2018年2月21日 - 2018年4月21', '为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/eb2f839e608b32a906229a934837b983.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/eb2f839e608b32a906229a934837b983.png\"}');
INSERT INTO `st_portal_post` VALUES ('14', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1548569565', '1548569565', '1548569280', '0', '西扎新作，隐藏在密林里的混凝土艺术馆', '2018年2月21日 - 2018年4月21', '为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/eb2f839e608b32a906229a934837b983.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/eb2f839e608b32a906229a934837b983.png\"}');
INSERT INTO `st_portal_post` VALUES ('15', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1548569565', '1548569565', '1548569280', '0', '西扎新作，隐藏在密林里的混凝土艺术馆', '2018年2月21日 - 2018年4月21', '为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/eb2f839e608b32a906229a934837b983.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/eb2f839e608b32a906229a934837b983.png\"}');
INSERT INTO `st_portal_post` VALUES ('16', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1548569565', '1548569565', '1548569280', '0', '西扎新作，隐藏在密林里的混凝土艺术馆', '2018年2月21日 - 2018年4月21', '为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/eb2f839e608b32a906229a934837b983.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/eb2f839e608b32a906229a934837b983.png\"}');
INSERT INTO `st_portal_post` VALUES ('17', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1548569565', '1548569565', '1548569280', '0', '西扎新作，隐藏在密林里的混凝土艺术馆', '2018年2月21日 - 2018年4月21', '为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/eb2f839e608b32a906229a934837b983.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/eb2f839e608b32a906229a934837b983.png\"}');
INSERT INTO `st_portal_post` VALUES ('18', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1548569565', '1548569565', '1548569280', '0', '西扎新作，隐藏在密林里的混凝土艺术馆', '2018年2月21日 - 2018年4月21', '为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/eb2f839e608b32a906229a934837b983.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/eb2f839e608b32a906229a934837b983.png\"}');
INSERT INTO `st_portal_post` VALUES ('19', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1548569565', '1548569565', '1548569280', '0', '西扎新作，隐藏在密林里的混凝土艺术馆', '2018年2月21日 - 2018年4月21', '为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/eb2f839e608b32a906229a934837b983.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/eb2f839e608b32a906229a934837b983.png\"}');
INSERT INTO `st_portal_post` VALUES ('20', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1548569565', '1548569565', '1548569280', '0', '西扎新作，隐藏在密林里的混凝土艺术馆', '2018年2月21日 - 2018年4月21', '为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/eb2f839e608b32a906229a934837b983.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/eb2f839e608b32a906229a934837b983.png\"}');
INSERT INTO `st_portal_post` VALUES ('21', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1548569565', '1548569565', '1548569280', '0', '西扎新作，隐藏在密林里的混凝土艺术馆', '2018年2月21日 - 2018年4月21', '为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/eb2f839e608b32a906229a934837b983.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/eb2f839e608b32a906229a934837b983.png\"}');
INSERT INTO `st_portal_post` VALUES ('22', '0', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1548569565', '1548569565', '1548569280', '0', '西扎新作，隐藏在密林里的混凝土艺术馆', '2018年2月21日 - 2018年4月21', '为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境', '风暴手绘', 'portal/20190127/eb2f839e608b32a906229a934837b983.png', '\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/p&gt;\n&lt;p&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;&lt;span style=\'color: rgb(14, 23, 38); font-family: &quot;PingFang SC&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;, &quot;Source Han Sans&quot;, &quot;Noto Sans CJK Sc&quot;, &quot;Microsoft YaHei&quot;, &quot;Microsoft Jhenghei&quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);\'&gt;上面是固定格式下面是可以编辑的图文详情建筑是建筑物与构筑物的总称。是人们为了满足社会生活需要，利用所掌握的物质技术手段，并运用一定的科学规律、风水理念和美学法则创造的人工环境。有些分类为了明确表达使用性，会将建筑物与人们不长期占用的非建筑结构物区别，另外有些建筑学者也为了避免混淆，而刻意在其中把外型经过人们具有意识创作出来的建筑物细分为“建筑”（Architecture）。需注意的是，有时建筑物也可能会被扩展到包涵“非建筑构筑物”。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n', null, '{\"thumbnail\":\"portal\\/20190127\\/eb2f839e608b32a906229a934837b983.png\"}');

-- ----------------------------
-- Table structure for st_portal_tag
-- ----------------------------
DROP TABLE IF EXISTS `st_portal_tag`;
CREATE TABLE `st_portal_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标签文章数',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章标签表';

-- ----------------------------
-- Records of st_portal_tag
-- ----------------------------
INSERT INTO `st_portal_tag` VALUES ('1', '1', '0', '0', '2018年2月21日 - 2018年4月');
INSERT INTO `st_portal_tag` VALUES ('2', '1', '0', '0', '2018年2月21日 - 2018年4月');

-- ----------------------------
-- Table structure for st_portal_tag_post
-- ----------------------------
DROP TABLE IF EXISTS `st_portal_tag_post`;
CREATE TABLE `st_portal_tag_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tag_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标签 id',
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文章 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='portal应用 标签文章对应表';

-- ----------------------------
-- Records of st_portal_tag_post
-- ----------------------------
INSERT INTO `st_portal_tag_post` VALUES ('2', '2', '12', '1');

-- ----------------------------
-- Table structure for st_recommend
-- ----------------------------
DROP TABLE IF EXISTS `st_recommend`;
CREATE TABLE `st_recommend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1-搜索关键字',
  `list_order` int(11) NOT NULL DEFAULT '100' COMMENT '排序',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态 0-下线 1-上线 -1删除',
  `more` text COMMENT '其他内容 json',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='推荐表';

-- ----------------------------
-- Records of st_recommend
-- ----------------------------
INSERT INTO `st_recommend` VALUES ('1', '建筑手绘', '', '1', '1', '0', '0', '1', null);
INSERT INTO `st_recommend` VALUES ('2', '商业手绘', '', '1', '1', '0', '1548308829', '1', null);
INSERT INTO `st_recommend` VALUES ('3', '排版', '', '1', '3', '0', '0', '1', null);
INSERT INTO `st_recommend` VALUES ('4', '住宅', '', '1', '4', '0', '0', '0', null);
INSERT INTO `st_recommend` VALUES ('5', '效果图', '', '1', '5', '0', '0', '1', null);
INSERT INTO `st_recommend` VALUES ('6', '公寓', '', '1', '6', '0', '0', '1', null);
INSERT INTO `st_recommend` VALUES ('7', '三体:黑暗森林', '', '1', '7', '0', '0', '0', null);
INSERT INTO `st_recommend` VALUES ('8', '斗罗大陆', '', '1', '100', '1548308853', '1548310279', '-1', null);

-- ----------------------------
-- Table structure for st_recycle_bin
-- ----------------------------
DROP TABLE IF EXISTS `st_recycle_bin`;
CREATE TABLE `st_recycle_bin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) DEFAULT '0' COMMENT '删除内容 id',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `table_name` varchar(60) DEFAULT '' COMMENT '删除内容所在表名',
  `name` varchar(255) DEFAULT '' COMMENT '删除内容名称',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT=' 回收站';

-- ----------------------------
-- Records of st_recycle_bin
-- ----------------------------
INSERT INTO `st_recycle_bin` VALUES ('1', '3', '1542287935', 'portal_category', '建一', '0');
INSERT INTO `st_recycle_bin` VALUES ('2', '1', '1548560981', 'portal_post#page', '测试直接添加页面', '0');
INSERT INTO `st_recycle_bin` VALUES ('3', '5', '1548561554', 'portal_category', '建筑一级', '0');
INSERT INTO `st_recycle_bin` VALUES ('4', '6', '1548561559', 'portal_category', '建筑二级', '0');
INSERT INTO `st_recycle_bin` VALUES ('5', '7', '1548561564', 'portal_category', '小二', '0');

-- ----------------------------
-- Table structure for st_role
-- ----------------------------
DROP TABLE IF EXISTS `st_role`;
CREATE TABLE `st_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父角色ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态;0:禁用;1:正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `list_order` float NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- ----------------------------
-- Records of st_role
-- ----------------------------
INSERT INTO `st_role` VALUES ('1', '0', '1', '1329633709', '1329633709', '0', '超级管理员', '拥有网站最高管理员权限！');
INSERT INTO `st_role` VALUES ('2', '0', '1', '1329633709', '1329633709', '0', '普通管理员', '权限由最高管理员分配！');
INSERT INTO `st_role` VALUES ('3', '0', '1', '0', '0', '0', '评图老师', '打卡模块, 给学生拼图的老师帐户');

-- ----------------------------
-- Table structure for st_role_user
-- ----------------------------
DROP TABLE IF EXISTS `st_role_user`;
CREATE TABLE `st_role_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色 id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';

-- ----------------------------
-- Records of st_role_user
-- ----------------------------
INSERT INTO `st_role_user` VALUES ('1', '3', '3');
INSERT INTO `st_role_user` VALUES ('3', '3', '5');
INSERT INTO `st_role_user` VALUES ('4', '1', '6');
INSERT INTO `st_role_user` VALUES ('5', '3', '4');
INSERT INTO `st_role_user` VALUES ('6', '2', '4');

-- ----------------------------
-- Table structure for st_route
-- ----------------------------
DROP TABLE IF EXISTS `st_route`;
CREATE TABLE `st_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态;1:启用,0:不启用',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'URL规则类型;1:用户自定义;2:别名添加',
  `full_url` varchar(255) NOT NULL DEFAULT '' COMMENT '完整url',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '实际显示的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='url路由表';

-- ----------------------------
-- Records of st_route
-- ----------------------------

-- ----------------------------
-- Table structure for st_school
-- ----------------------------
DROP TABLE IF EXISTS `st_school`;
CREATE TABLE `st_school` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `alias` varchar(200) NOT NULL DEFAULT '' COMMENT '别名',
  `description` text COMMENT '分类描述',
  `image` varchar(200) NOT NULL DEFAULT '' COMMENT '图片',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `delete_time` int(10) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='学校表';

-- ----------------------------
-- Records of st_school
-- ----------------------------
INSERT INTO `st_school` VALUES ('1', '重庆大学', '重大', '重庆大学（Chongqing University），简称重大（CQU），位于中央直辖市重庆，是中共中央直管、教育部直属的副部级全国重点大学，由教育部和重庆市共同建设。重大早在民国时期就是中国最杰出的国立大学之一，建国后以“建筑老八校”闻名。现是国家“双一流”、“211工程”和”985工程”首批重点建设的高水平研究型综合性大学；“卓越大学联盟”、“中俄工科大学联盟”成员高校；入选“2011计划”、“111计划”、“卓越工程师教育培养计划”、“卓越法律人才教育培养计划”、“海外高层次人才引进计划”；设有研究生院和国家大学科技园。\r\n    1929年刘湘创办重庆大学；1935年批准为省立大学；抗战期间和西迁的中央大学合作办学。1942年更名为国立重庆大学，成为有文、理、工、商、法、医6个学院的国立综合性大学，1960年成为全国重点大学。改革开放后，学校大力发展人文、经管、艺术、教育等学科专业。2000年，原重庆大学、重庆建筑大学、重庆建筑高等专科学校三校合并组建成新重庆大学，使得一直以机电、能源、材料、信息、生物、经管等学科优势著称的重庆大学，在建筑、土木、环保等学科方面也处于全国较高水平。\r\n    截至2018年9月，重大设36个学院，本科专业96个，覆盖理、工、经、管、法、文、史、哲、教育、艺术10个学科门类。在校生47000余人，其中研究生19000余人，本科生25000余人，留学生1800余人。校园占地面积5200余亩，有A、B、C、虎溪四个校区，校舍建筑面积近160万平方米。 [1]', 'admin/20190108/67a6f3ac1aebf8894d960b37d91623ba.png', '1', '10000', '0');
INSERT INTO `st_school` VALUES ('2', '西南大学', '西大', '西南大学（Southwest University）简称西大，坐落于重庆市，是中华人民共和国教育部直属高校，由教育部、农业部与重庆市人民政府共建，是“双一流”世界一流学科建设高校，位列国家“211工程” 、“985工程优势学科创新平台”，入选“111计划”、“2011计划”、卓越农林人才教育培养计划、卓越教师培养计划、国家建设高水平大学公派研究生项目，是开办师范生免费教育的7所高校之一，全国自主选拔录取改革试点高校，中国政府奖学金来华留学生接收院校之一，重庆市大学联盟创始学校之一。\r\n西南大学由原教育部直属西南师范大学与原农业部直属西南农业大学于2005年合并而成。原两校毗邻而建，同根同源，均溯源于1906年建立的川东师范学堂。1936年更名为四川省立教育学院。1950年，四川省立教育学院师范、农学相关系科分别与1940年创办的国立女子师范学院、1946年创办的私立相辉文法学院等合并建立西南师范学院、西南农学院。1985年，两校分别更名为西南师范大学、西南农业大学。此后，重庆轻工业职工大学、四川畜牧兽医学院、中国农业科学院柑桔研究所相继并入。 [1-2] \r\n截至2018年12月，学校占地9000余亩，建有北碚校区、荣昌校区、西塔学院；拥有11个学部，3个附属医院，下设36个学院，共有105个本科专业；有22个博士后科研流动站、28个一级学科博士学位授权点、51个一级学科硕士学位授权点；专任教师2968人；在校学生5万余人，其中普通本科生近4万人，硕士、博士研究生11000余人，留学生2000余人。 [1]  [3]', 'admin/20190108/4371be76e8b9136b12c5869382b0ae97.png', '1', '10000', '0');
INSERT INTO `st_school` VALUES ('3', '北京大学', '北大', '北京大学（Peking University），简称“北大”，由中华人民共和国教育部直属，中央直管副部级建制，位列“211工程”、“985工程”、“世界一流大学和一流学科”，入选“基础学科拔尖学生培养试验计划”、“高等学校创新能力提升计划”、“高等学校学科创新引智计划”，为九校联盟、中国大学校长联谊会、京港大学联盟、亚洲大学联盟、东亚研究型大学协会、国际研究型大学联盟、环太平洋大学联盟、东亚四大学论坛、国际公立大学论坛、中俄综合性大学联盟成员。\r\n北京大学创立于1898年维新变法之际，初名京师大学堂，是中国近现代第一所国立综合性大学，创办之初也是国家最高教育行政机关。1912年改为国立北京大学。1937年南迁至长沙，与国立清华大学和私立南开大学组成国立长沙临时大学，1938年迁至昆明，更名为国立西南联合大学。1946年复员返回北平。1952年经全国高校院系调整，成为以文理基础学科为主的综合性大学，并自北京城内沙滩等地迁至现址。2000年与原北京医科大学合并，组建为新的北京大学。\r\n北京大学是新文化运动的中心和五四运动的策源地，最早在中国传播马克思主义和科学、民主思想，是创建中国共产党的重要基地之一。长期以来，北京大学始终与中国和中国人民共命运，与时代和社会同前进，是培养和造就高素质创造性人才的摇篮，恰如蔡元培先生所言：“大学者，囊括大典，网罗众家之学府也……此思想自由之通则，而大学之所以为大也。” [1]', 'admin/20190114/ae9b343d74bb7e64a4da80f1aca16ca7.png', '1', '10000', '0');

-- ----------------------------
-- Table structure for st_slide
-- ----------------------------
DROP TABLE IF EXISTS `st_slide`;
CREATE TABLE `st_slide` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:显示,0不显示',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片分类',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分类备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片表';

-- ----------------------------
-- Records of st_slide
-- ----------------------------
INSERT INTO `st_slide` VALUES ('1', '1', '0', '首页轮播', '');

-- ----------------------------
-- Table structure for st_slide_item
-- ----------------------------
DROP TABLE IF EXISTS `st_slide_item`;
CREATE TABLE `st_slide_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slide_id` int(11) NOT NULL DEFAULT '0' COMMENT '幻灯片id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '幻灯片名称',
  `image` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片图片',
  `url` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片链接',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `description` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '幻灯片描述',
  `content` text CHARACTER SET utf8 COMMENT '幻灯片内容',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `slide_id` (`slide_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片子项表';

-- ----------------------------
-- Records of st_slide_item
-- ----------------------------
INSERT INTO `st_slide_item` VALUES ('1', '1', '1', '10000', '网易考拉活动日', 'admin/20181029/1d71c5aa0ef3407974dcdfb1815bdd11.jpg', 'https://www.163.com', '', '', '', null);

-- ----------------------------
-- Table structure for st_sms
-- ----------------------------
DROP TABLE IF EXISTS `st_sms`;
CREATE TABLE `st_sms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `phone` char(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '手机号',
  `code` char(6) NOT NULL DEFAULT '' COMMENT '验证码',
  `type` tinyint(4) DEFAULT '1' COMMENT '短信类型,1:注册 2:登录',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='手机短信验证码';

-- ----------------------------
-- Records of st_sms
-- ----------------------------
INSERT INTO `st_sms` VALUES ('1', '18581290597', '127.0.0.1', '1334', '1', '1547698037');

-- ----------------------------
-- Table structure for st_theme
-- ----------------------------
DROP TABLE IF EXISTS `st_theme`;
CREATE TABLE `st_theme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后升级时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模板状态,1:正在使用;0:未使用',
  `is_compiled` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为已编译模板',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '主题目录名，用于主题的维一标识',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '主题名称',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '主题版本号',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `author` varchar(20) NOT NULL DEFAULT '' COMMENT '主题作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `lang` varchar(10) NOT NULL DEFAULT '' COMMENT '支持语言',
  `keywords` varchar(50) NOT NULL DEFAULT '' COMMENT '主题关键字',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '主题描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of st_theme
-- ----------------------------
INSERT INTO `st_theme` VALUES ('1', '0', '0', '0', '0', 'simpleboot3', 'simpleboot3', '1.0.2', 'http://demo.thinkcmf.com', '', 'ThinkCMF', 'http://www.thinkcmf.com', 'zh-cn', 'ThinkCMF模板', 'ThinkCMF默认模板');

-- ----------------------------
-- Table structure for st_theme_file
-- ----------------------------
DROP TABLE IF EXISTS `st_theme_file`;
CREATE TABLE `st_theme_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_public` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否公共的模板文件',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '模板名称',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '模板文件名',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作',
  `file` varchar(50) NOT NULL DEFAULT '' COMMENT '模板文件，相对于模板根目录，如Portal/index.html',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '模板文件描述',
  `more` text COMMENT '模板更多配置,用户自己后台设置的',
  `config_more` text COMMENT '模板更多配置,来源模板的配置文件',
  `draft_more` text COMMENT '模板更多配置,用户临时保存的配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of st_theme_file
-- ----------------------------
INSERT INTO `st_theme_file` VALUES ('1', '0', '10', 'simpleboot3', '文章页', 'portal/Article/index', 'portal/article', '文章页模板文件', '{\"vars\":{\"hot_articles_category_id\":{\"title\":\"Hot Articles\\u5206\\u7c7bID\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', '{\"vars\":{\"hot_articles_category_id\":{\"title\":\"Hot Articles\\u5206\\u7c7bID\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', null);
INSERT INTO `st_theme_file` VALUES ('2', '0', '10', 'simpleboot3', '联系我们页', 'portal/Page/index', 'portal/contact', '联系我们页模板文件', '{\"vars\":{\"baidu_map_info_window_text\":{\"title\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57\",\"name\":\"baidu_map_info_window_text\",\"value\":\"ThinkCMF<br\\/><span class=\'\'>\\u5730\\u5740\\uff1a\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def2601\\u53f7<\\/span>\",\"type\":\"text\",\"tip\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57,\\u652f\\u6301\\u7b80\\u5355html\\u4ee3\\u7801\",\"rule\":[]},\"company_location\":{\"title\":\"\\u516c\\u53f8\\u5750\\u6807\",\"value\":\"\",\"type\":\"location\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_cn\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\",\"value\":\"\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def0001\\u53f7\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_en\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"NO.0001 Xie Tu Road, Shanghai China\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"email\":{\"title\":\"\\u516c\\u53f8\\u90ae\\u7bb1\",\"value\":\"catman@thinkcmf.com\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_cn\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\",\"value\":\"021 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_en\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"+8621 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"qq\":{\"title\":\"\\u8054\\u7cfbQQ\",\"value\":\"478519726\",\"type\":\"text\",\"tip\":\"\\u591a\\u4e2a QQ\\u4ee5\\u82f1\\u6587\\u9017\\u53f7\\u9694\\u5f00\",\"rule\":{\"require\":true}}}}', '{\"vars\":{\"baidu_map_info_window_text\":{\"title\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57\",\"name\":\"baidu_map_info_window_text\",\"value\":\"ThinkCMF<br\\/><span class=\'\'>\\u5730\\u5740\\uff1a\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def2601\\u53f7<\\/span>\",\"type\":\"text\",\"tip\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57,\\u652f\\u6301\\u7b80\\u5355html\\u4ee3\\u7801\",\"rule\":[]},\"company_location\":{\"title\":\"\\u516c\\u53f8\\u5750\\u6807\",\"value\":\"\",\"type\":\"location\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_cn\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\",\"value\":\"\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def0001\\u53f7\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_en\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"NO.0001 Xie Tu Road, Shanghai China\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"email\":{\"title\":\"\\u516c\\u53f8\\u90ae\\u7bb1\",\"value\":\"catman@thinkcmf.com\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_cn\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\",\"value\":\"021 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_en\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"+8621 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"qq\":{\"title\":\"\\u8054\\u7cfbQQ\",\"value\":\"478519726\",\"type\":\"text\",\"tip\":\"\\u591a\\u4e2a QQ\\u4ee5\\u82f1\\u6587\\u9017\\u53f7\\u9694\\u5f00\",\"rule\":{\"require\":true}}}}', null);
INSERT INTO `st_theme_file` VALUES ('3', '0', '5', 'simpleboot3', '首页', 'portal/Index/index', 'portal/index', '首页模板文件', '{\"vars\":{\"top_slide\":{\"title\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"admin\\/Slide\\/index\",\"multi\":false},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"tip\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5feb\\u901f\\u4e86\\u89e3ThinkCMF\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u526f\\u6807\\u9898\",\"value\":\"Quickly understand the ThinkCMF\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u526f\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u7279\\u6027\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"MVC\\u5206\\u5c42\\u6a21\\u5f0f\",\"icon\":\"bars\",\"content\":\"\\u4f7f\\u7528MVC\\u5e94\\u7528\\u7a0b\\u5e8f\\u88ab\\u5206\\u6210\\u4e09\\u4e2a\\u6838\\u5fc3\\u90e8\\u4ef6\\uff1a\\u6a21\\u578b\\uff08M\\uff09\\u3001\\u89c6\\u56fe\\uff08V\\uff09\\u3001\\u63a7\\u5236\\u5668\\uff08C\\uff09\\uff0c\\u4ed6\\u4e0d\\u662f\\u4e00\\u4e2a\\u65b0\\u7684\\u6982\\u5ff5\\uff0c\\u53ea\\u662fThinkCMF\\u5c06\\u5176\\u53d1\\u6325\\u5230\\u4e86\\u6781\\u81f4\\u3002\"},{\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"group\",\"content\":\"ThinkCMF\\u5185\\u7f6e\\u4e86\\u7075\\u6d3b\\u7684\\u7528\\u6237\\u7ba1\\u7406\\u65b9\\u5f0f\\uff0c\\u5e76\\u53ef\\u76f4\\u63a5\\u4e0e\\u7b2c\\u4e09\\u65b9\\u7ad9\\u70b9\\u8fdb\\u884c\\u4e92\\u8054\\u4e92\\u901a\\uff0c\\u5982\\u679c\\u4f60\\u613f\\u610f\\u751a\\u81f3\\u53ef\\u4ee5\\u5bf9\\u5355\\u4e2a\\u7528\\u6237\\u6216\\u7fa4\\u4f53\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u8fdb\\u884c\\u8bb0\\u5f55\\u53ca\\u5206\\u4eab\\uff0c\\u4e3a\\u60a8\\u7684\\u8fd0\\u8425\\u51b3\\u7b56\\u63d0\\u4f9b\\u6709\\u6548\\u53c2\\u8003\\u6570\\u636e\\u3002\"},{\"title\":\"\\u4e91\\u7aef\\u90e8\\u7f72\",\"icon\":\"cloud\",\"content\":\"\\u901a\\u8fc7\\u9a71\\u52a8\\u7684\\u65b9\\u5f0f\\u53ef\\u4ee5\\u8f7b\\u677e\\u652f\\u6301\\u4e91\\u5e73\\u53f0\\u7684\\u90e8\\u7f72\\uff0c\\u8ba9\\u4f60\\u7684\\u7f51\\u7ad9\\u65e0\\u7f1d\\u8fc1\\u79fb\\uff0c\\u5185\\u7f6e\\u5df2\\u7ecf\\u652f\\u6301SAE\\u3001BAE\\uff0c\\u6b63\\u5f0f\\u7248\\u5c06\\u5bf9\\u4e91\\u7aef\\u90e8\\u7f72\\u8fdb\\u884c\\u8fdb\\u4e00\\u6b65\\u4f18\\u5316\\u3002\"},{\"title\":\"\\u5b89\\u5168\\u7b56\\u7565\",\"icon\":\"heart\",\"content\":\"\\u63d0\\u4f9b\\u7684\\u7a33\\u5065\\u7684\\u5b89\\u5168\\u7b56\\u7565\\uff0c\\u5305\\u62ec\\u5907\\u4efd\\u6062\\u590d\\uff0c\\u5bb9\\u9519\\uff0c\\u9632\\u6cbb\\u6076\\u610f\\u653b\\u51fb\\u767b\\u9646\\uff0c\\u7f51\\u9875\\u9632\\u7be1\\u6539\\u7b49\\u591a\\u9879\\u5b89\\u5168\\u7ba1\\u7406\\u529f\\u80fd\\uff0c\\u4fdd\\u8bc1\\u7cfb\\u7edf\\u5b89\\u5168\\uff0c\\u53ef\\u9760\\uff0c\\u7a33\\u5b9a\\u7684\\u8fd0\\u884c\\u3002\"},{\"title\":\"\\u5e94\\u7528\\u6a21\\u5757\\u5316\",\"icon\":\"cubes\",\"content\":\"\\u63d0\\u51fa\\u5168\\u65b0\\u7684\\u5e94\\u7528\\u6a21\\u5f0f\\u8fdb\\u884c\\u6269\\u5c55\\uff0c\\u4e0d\\u7ba1\\u662f\\u4f60\\u5f00\\u53d1\\u4e00\\u4e2a\\u5c0f\\u529f\\u80fd\\u8fd8\\u662f\\u4e00\\u4e2a\\u5168\\u65b0\\u7684\\u7ad9\\u70b9\\uff0c\\u5728ThinkCMF\\u4e2d\\u4f60\\u53ea\\u662f\\u589e\\u52a0\\u4e86\\u4e00\\u4e2aAPP\\uff0c\\u6bcf\\u4e2a\\u72ec\\u7acb\\u8fd0\\u884c\\u4e92\\u4e0d\\u5f71\\u54cd\\uff0c\\u4fbf\\u4e8e\\u7075\\u6d3b\\u6269\\u5c55\\u548c\\u4e8c\\u6b21\\u5f00\\u53d1\\u3002\"},{\"title\":\"\\u514d\\u8d39\\u5f00\\u6e90\",\"icon\":\"certificate\",\"content\":\"\\u4ee3\\u7801\\u9075\\u5faaApache2\\u5f00\\u6e90\\u534f\\u8bae\\uff0c\\u514d\\u8d39\\u4f7f\\u7528\\uff0c\\u5bf9\\u5546\\u4e1a\\u7528\\u6237\\u4e5f\\u65e0\\u4efb\\u4f55\\u9650\\u5236\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"text\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"last_news\":{\"title\":\"\\u6700\\u65b0\\u8d44\\u8baf\",\"display\":\"1\",\"vars\":{\"last_news_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', '{\"vars\":{\"top_slide\":{\"title\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"admin\\/Slide\\/index\",\"multi\":false},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"tip\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5feb\\u901f\\u4e86\\u89e3ThinkCMF\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u526f\\u6807\\u9898\",\"value\":\"Quickly understand the ThinkCMF\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u526f\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u7279\\u6027\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"MVC\\u5206\\u5c42\\u6a21\\u5f0f\",\"icon\":\"bars\",\"content\":\"\\u4f7f\\u7528MVC\\u5e94\\u7528\\u7a0b\\u5e8f\\u88ab\\u5206\\u6210\\u4e09\\u4e2a\\u6838\\u5fc3\\u90e8\\u4ef6\\uff1a\\u6a21\\u578b\\uff08M\\uff09\\u3001\\u89c6\\u56fe\\uff08V\\uff09\\u3001\\u63a7\\u5236\\u5668\\uff08C\\uff09\\uff0c\\u4ed6\\u4e0d\\u662f\\u4e00\\u4e2a\\u65b0\\u7684\\u6982\\u5ff5\\uff0c\\u53ea\\u662fThinkCMF\\u5c06\\u5176\\u53d1\\u6325\\u5230\\u4e86\\u6781\\u81f4\\u3002\"},{\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"group\",\"content\":\"ThinkCMF\\u5185\\u7f6e\\u4e86\\u7075\\u6d3b\\u7684\\u7528\\u6237\\u7ba1\\u7406\\u65b9\\u5f0f\\uff0c\\u5e76\\u53ef\\u76f4\\u63a5\\u4e0e\\u7b2c\\u4e09\\u65b9\\u7ad9\\u70b9\\u8fdb\\u884c\\u4e92\\u8054\\u4e92\\u901a\\uff0c\\u5982\\u679c\\u4f60\\u613f\\u610f\\u751a\\u81f3\\u53ef\\u4ee5\\u5bf9\\u5355\\u4e2a\\u7528\\u6237\\u6216\\u7fa4\\u4f53\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u8fdb\\u884c\\u8bb0\\u5f55\\u53ca\\u5206\\u4eab\\uff0c\\u4e3a\\u60a8\\u7684\\u8fd0\\u8425\\u51b3\\u7b56\\u63d0\\u4f9b\\u6709\\u6548\\u53c2\\u8003\\u6570\\u636e\\u3002\"},{\"title\":\"\\u4e91\\u7aef\\u90e8\\u7f72\",\"icon\":\"cloud\",\"content\":\"\\u901a\\u8fc7\\u9a71\\u52a8\\u7684\\u65b9\\u5f0f\\u53ef\\u4ee5\\u8f7b\\u677e\\u652f\\u6301\\u4e91\\u5e73\\u53f0\\u7684\\u90e8\\u7f72\\uff0c\\u8ba9\\u4f60\\u7684\\u7f51\\u7ad9\\u65e0\\u7f1d\\u8fc1\\u79fb\\uff0c\\u5185\\u7f6e\\u5df2\\u7ecf\\u652f\\u6301SAE\\u3001BAE\\uff0c\\u6b63\\u5f0f\\u7248\\u5c06\\u5bf9\\u4e91\\u7aef\\u90e8\\u7f72\\u8fdb\\u884c\\u8fdb\\u4e00\\u6b65\\u4f18\\u5316\\u3002\"},{\"title\":\"\\u5b89\\u5168\\u7b56\\u7565\",\"icon\":\"heart\",\"content\":\"\\u63d0\\u4f9b\\u7684\\u7a33\\u5065\\u7684\\u5b89\\u5168\\u7b56\\u7565\\uff0c\\u5305\\u62ec\\u5907\\u4efd\\u6062\\u590d\\uff0c\\u5bb9\\u9519\\uff0c\\u9632\\u6cbb\\u6076\\u610f\\u653b\\u51fb\\u767b\\u9646\\uff0c\\u7f51\\u9875\\u9632\\u7be1\\u6539\\u7b49\\u591a\\u9879\\u5b89\\u5168\\u7ba1\\u7406\\u529f\\u80fd\\uff0c\\u4fdd\\u8bc1\\u7cfb\\u7edf\\u5b89\\u5168\\uff0c\\u53ef\\u9760\\uff0c\\u7a33\\u5b9a\\u7684\\u8fd0\\u884c\\u3002\"},{\"title\":\"\\u5e94\\u7528\\u6a21\\u5757\\u5316\",\"icon\":\"cubes\",\"content\":\"\\u63d0\\u51fa\\u5168\\u65b0\\u7684\\u5e94\\u7528\\u6a21\\u5f0f\\u8fdb\\u884c\\u6269\\u5c55\\uff0c\\u4e0d\\u7ba1\\u662f\\u4f60\\u5f00\\u53d1\\u4e00\\u4e2a\\u5c0f\\u529f\\u80fd\\u8fd8\\u662f\\u4e00\\u4e2a\\u5168\\u65b0\\u7684\\u7ad9\\u70b9\\uff0c\\u5728ThinkCMF\\u4e2d\\u4f60\\u53ea\\u662f\\u589e\\u52a0\\u4e86\\u4e00\\u4e2aAPP\\uff0c\\u6bcf\\u4e2a\\u72ec\\u7acb\\u8fd0\\u884c\\u4e92\\u4e0d\\u5f71\\u54cd\\uff0c\\u4fbf\\u4e8e\\u7075\\u6d3b\\u6269\\u5c55\\u548c\\u4e8c\\u6b21\\u5f00\\u53d1\\u3002\"},{\"title\":\"\\u514d\\u8d39\\u5f00\\u6e90\",\"icon\":\"certificate\",\"content\":\"\\u4ee3\\u7801\\u9075\\u5faaApache2\\u5f00\\u6e90\\u534f\\u8bae\\uff0c\\u514d\\u8d39\\u4f7f\\u7528\\uff0c\\u5bf9\\u5546\\u4e1a\\u7528\\u6237\\u4e5f\\u65e0\\u4efb\\u4f55\\u9650\\u5236\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"text\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"last_news\":{\"title\":\"\\u6700\\u65b0\\u8d44\\u8baf\",\"display\":\"1\",\"vars\":{\"last_news_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', null);
INSERT INTO `st_theme_file` VALUES ('4', '0', '10', 'simpleboot3', '文章列表页', 'portal/List/index', 'portal/list', '文章列表模板文件', '{\"vars\":[],\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', '{\"vars\":[],\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', null);
INSERT INTO `st_theme_file` VALUES ('5', '0', '10', 'simpleboot3', '单页面', 'portal/Page/index', 'portal/page', '单页面模板文件', '{\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', '{\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', null);
INSERT INTO `st_theme_file` VALUES ('6', '0', '10', 'simpleboot3', '搜索页面', 'portal/search/index', 'portal/search', '搜索模板文件', '{\"vars\":{\"varName1\":{\"title\":\"\\u70ed\\u95e8\\u641c\\u7d22\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\\u8fd9\\u662f\\u4e00\\u4e2atext\",\"rule\":{\"require\":true}}}}', '{\"vars\":{\"varName1\":{\"title\":\"\\u70ed\\u95e8\\u641c\\u7d22\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\\u8fd9\\u662f\\u4e00\\u4e2atext\",\"rule\":{\"require\":true}}}}', null);
INSERT INTO `st_theme_file` VALUES ('7', '1', '0', 'simpleboot3', '模板全局配置', 'public/Config', 'public/config', '模板全局配置文件', '{\"vars\":{\"enable_mobile\":{\"title\":\"\\u624b\\u673a\\u6ce8\\u518c\",\"value\":1,\"type\":\"select\",\"options\":{\"1\":\"\\u5f00\\u542f\",\"0\":\"\\u5173\\u95ed\"},\"tip\":\"\"}}}', '{\"vars\":{\"enable_mobile\":{\"title\":\"\\u624b\\u673a\\u6ce8\\u518c\",\"value\":1,\"type\":\"select\",\"options\":{\"1\":\"\\u5f00\\u542f\",\"0\":\"\\u5173\\u95ed\"},\"tip\":\"\"}}}', null);
INSERT INTO `st_theme_file` VALUES ('8', '1', '1', 'simpleboot3', '导航条', 'public/Nav', 'public/nav', '导航条模板文件', '{\"vars\":{\"company_name\":{\"title\":\"\\u516c\\u53f8\\u540d\\u79f0\",\"name\":\"company_name\",\"value\":\"ThinkCMF\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', '{\"vars\":{\"company_name\":{\"title\":\"\\u516c\\u53f8\\u540d\\u79f0\",\"name\":\"company_name\",\"value\":\"ThinkCMF\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', null);

-- ----------------------------
-- Table structure for st_third_party_user
-- ----------------------------
DROP TABLE IF EXISTS `st_third_party_user`;
CREATE TABLE `st_third_party_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '本站用户id',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'access_token过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '绑定时间',
  `login_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:正常;0:禁用',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `third_party` varchar(20) NOT NULL DEFAULT '' COMMENT '第三方惟一码',
  `app_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方应用 id',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `access_token` varchar(512) NOT NULL DEFAULT '' COMMENT '第三方授权码',
  `openid` varchar(40) NOT NULL DEFAULT '' COMMENT '第三方用户id',
  `union_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方用户多个产品中的惟一 id,(如:微信平台)',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='第三方用户表';

-- ----------------------------
-- Records of st_third_party_user
-- ----------------------------

-- ----------------------------
-- Table structure for st_user
-- ----------------------------
DROP TABLE IF EXISTS `st_user`;
CREATE TABLE `st_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型;1:admin;2:会员',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '性别;0:保密,1:男,2:女',
  `birthday` int(11) NOT NULL DEFAULT '0' COMMENT '生日',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `coin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `user_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态;0:禁用,1:正常,2:未验证',
  `user_login` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码;cmf_password加密',
  `user_nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `user_url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网址',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT '个性签名',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `true_name` varchar(32) NOT NULL DEFAULT '' COMMENT '用户真名',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '中国手机不带国家代码，国际手机号格式为：国家代码-手机号',
  `school` varchar(100) NOT NULL DEFAULT '' COMMENT '学校',
  `speciality` varchar(100) NOT NULL DEFAULT '' COMMENT '专业',
  `grade` varchar(100) NOT NULL DEFAULT '' COMMENT '年级',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `user_login` (`user_login`),
  KEY `user_nickname` (`user_nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- Records of st_user
-- ----------------------------
INSERT INTO `st_user` VALUES ('1', '1', '0', '0', '1547867646', '1', '1', '0.00', '1540307170', '1', 'admin', '###4a86c1e09a02a571683d0ceb112fc2f2', 'admin', '136927705@qq.com', '', 'https://img.myzx.cn/video/mysource/admin/20180713/5b486e7d1778b_100_100.png', '', '127.0.0.1', '', '', '13399878665', '', '', '', '');
INSERT INTO `st_user` VALUES ('2', '2', '1', '0', '1544943873', '1', '8832', '0.00', '1544935602', '1', '', '###4a86c1e09a02a571683d0ceb112fc2f2', '张三1', '12355@qq.com', '', 'avatar/20181216/45718ee0baf9a1666ca9738d32d457f3.jpg', '', '127.0.0.1', '', '张三', '18581290597', '湖北理工大', '计算机', '3年2班', '{\"wx_no\":\"zhuo_yi_hang\",\"dashi\":\"1\",\"enjoy_course\":\"1,3,5\",\"source\":\"2,4\"}');
INSERT INTO `st_user` VALUES ('3', '1', '0', '0', '1551281957', '0', '0', '0.00', '0', '1', '张老师', '###4a86c1e09a02a571683d0ceb112fc2f2', '', 'zhanglaoshi@qq.com', '', 'avatar/20181216/45718ee0baf9a1666ca9738d32d457f3.jpg', '', '127.0.0.1', '', '', '', '', '', '', null);
INSERT INTO `st_user` VALUES ('4', '1', '0', '0', '1550390540', '0', '0', '0.00', '0', '1', '王老师', '###4a86c1e09a02a571683d0ceb112fc2f2', '', 'wanglaoshi@qq.com', '', '', '', '127.0.0.1', '', '', '', '', '', '', null);
INSERT INTO `st_user` VALUES ('5', '1', '0', '0', '0', '0', '0', '0.00', '0', '1', '刘老师', '###4a86c1e09a02a571683d0ceb112fc2f2', '', 'liulaoshi@qq.com', '', '', '', '', '', '', '', '', '', '', null);
INSERT INTO `st_user` VALUES ('6', '1', '0', '0', '0', '0', '0', '0.00', '0', '1', 'fengbao', '###4a86c1e09a02a571683d0ceb112fc2f2', '', 'fengbao@qq.com', '', '', '', '', '', '', '', '', '', '', null);

-- ----------------------------
-- Table structure for st_user_action
-- ----------------------------
DROP TABLE IF EXISTS `st_user_action`;
CREATE TABLE `st_user_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  `reward_number` int(11) NOT NULL DEFAULT '0' COMMENT '奖励次数',
  `cycle_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '周期类型;0:不限;1:按天;2:按小时;3:永久',
  `cycle_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '周期时间值',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `app` varchar(50) NOT NULL DEFAULT '' COMMENT '操作所在应用名或插件名等',
  `url` text COMMENT '执行操作的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户操作表';

-- ----------------------------
-- Records of st_user_action
-- ----------------------------
INSERT INTO `st_user_action` VALUES ('1', '0', '0', '1', '3', '1', '用户登录', 'login', 'user', '');

-- ----------------------------
-- Table structure for st_user_action_log
-- ----------------------------
DROP TABLE IF EXISTS `st_user_action_log`;
CREATE TABLE `st_user_action_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `last_visit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后访问时间',
  `object` varchar(100) NOT NULL DEFAULT '' COMMENT '访问对象的id,格式:不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作名称;格式:应用名+控制器+操作名,也可自己定义格式只要不发生冲突且惟一;',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`user_id`,`object`,`action`),
  KEY `user_object_action_ip` (`user_id`,`object`,`action`,`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='访问记录表';

-- ----------------------------
-- Records of st_user_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for st_user_balance_log
-- ----------------------------
DROP TABLE IF EXISTS `st_user_balance_log`;
CREATE TABLE `st_user_balance_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `change` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更改余额',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更改后余额',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户余额变更日志表';

-- ----------------------------
-- Records of st_user_balance_log
-- ----------------------------

-- ----------------------------
-- Table structure for st_user_coin_log
-- ----------------------------
DROP TABLE IF EXISTS `st_user_coin_log`;
CREATE TABLE `st_user_coin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `change` int(11) NOT NULL DEFAULT '0' COMMENT '更改余额数量',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改后图币',
  `description` varchar(1024) NOT NULL DEFAULT '' COMMENT '描述',
  `remark` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '变更类型 1-消费 2-充值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='用户图币流水日志表';

-- ----------------------------
-- Records of st_user_coin_log
-- ----------------------------
INSERT INTO `st_user_coin_log` VALUES ('1', '2', '1548259774', '200', '10000', '消费', '测试', '1');
INSERT INTO `st_user_coin_log` VALUES ('2', '2', '1548259800', '1000', '9000', '测试消费 -1000', '测试', '1');
INSERT INTO `st_user_coin_log` VALUES ('3', '2', '1548259828', '9000', '0', '测试消费9000', '测试', '1');
INSERT INTO `st_user_coin_log` VALUES ('4', '2', '1548259878', '5000', '5000', '充值500元', '充值', '2');
INSERT INTO `st_user_coin_log` VALUES ('5', '2', '1548407650', '666', '8844', 'redis高级教程', '消费', '1');
INSERT INTO `st_user_coin_log` VALUES ('6', '2', '1548407733', '12', '8832', 'php56789', '消费', '1');

-- ----------------------------
-- Table structure for st_user_favorite
-- ----------------------------
DROP TABLE IF EXISTS `st_user_favorite`;
CREATE TABLE `st_user_favorite` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户 id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏内容的标题',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `url` varchar(255) DEFAULT NULL COMMENT '收藏内容的原文地址，JSON格式',
  `description` text COMMENT '收藏内容的描述',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '收藏实体以前所在表,不带前缀',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏内容原来的主键id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1-刷题 2-打卡 3在线课堂 4-线下课堂',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_object_type_unique` (`user_id`,`object_id`,`type`),
  KEY `uid` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='用户收藏表';

-- ----------------------------
-- Records of st_user_favorite
-- ----------------------------
INSERT INTO `st_user_favorite` VALUES ('1', '2', 'nginx123111', '', 'eyJhY3Rpb24iOiJ2MVwvY291cnNlXC9kZXRhaWwiLCJwYXJhbSI6eyJpZCI6IjkifX0=', 'nginx123111', 'course', '9', '1548168574', '3');
INSERT INTO `st_user_favorite` VALUES ('2', '2', '12312312355555112', '', 'eyJhY3Rpb24iOiJ2MVwvZGFrYVwvZGV0YWlsIiwicGFyYW0iOnsiaWQiOiIxIn19', '12312312355555112', 'daka', '1', '1548168636', '2');
INSERT INTO `st_user_favorite` VALUES ('3', '2', '今天是2018年最后一天咯', '', '{\"action\":\"v1\\/daka\\/detail\",\"param\":{\"id\":\"8\"}}', '今天是2018年最后一天咯', 'daka', '8', '1548170017', '2');

-- ----------------------------
-- Table structure for st_user_like
-- ----------------------------
DROP TABLE IF EXISTS `st_user_like`;
CREATE TABLE `st_user_like` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户 id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '内容原来的主键id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '内容以前所在表,不带前缀',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '内容的原文地址，不带域名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '内容的标题',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `description` text COMMENT '内容的描述',
  PRIMARY KEY (`id`),
  KEY `uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户点赞表';

-- ----------------------------
-- Records of st_user_like
-- ----------------------------

-- ----------------------------
-- Table structure for st_user_login_attempt
-- ----------------------------
DROP TABLE IF EXISTS `st_user_login_attempt`;
CREATE TABLE `st_user_login_attempt` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `login_attempts` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '尝试次数',
  `attempt_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '尝试登录时间',
  `locked_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '锁定时间',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户 ip',
  `account` varchar(100) NOT NULL DEFAULT '' COMMENT '用户账号,手机号,邮箱或用户名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='用户登录尝试表';

-- ----------------------------
-- Records of st_user_login_attempt
-- ----------------------------

-- ----------------------------
-- Table structure for st_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `st_user_score_log`;
CREATE TABLE `st_user_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作积分等奖励日志表';

-- ----------------------------
-- Records of st_user_score_log
-- ----------------------------

-- ----------------------------
-- Table structure for st_user_token
-- ----------------------------
DROP TABLE IF EXISTS `st_user_token`;
CREATE TABLE `st_user_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户id',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT ' 过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `token` varchar(64) NOT NULL DEFAULT '' COMMENT 'token',
  `device_type` varchar(10) NOT NULL DEFAULT '' COMMENT '设备类型;mobile,android,iphone,ipad,web,pc,mac,wxapp',
  PRIMARY KEY (`id`),
  KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='用户客户端登录 token 表';

-- ----------------------------
-- Records of st_user_token
-- ----------------------------
INSERT INTO `st_user_token` VALUES ('1', '1', '1555859193', '1540307193', '3f141ecb3c1504c8d21224d61ec88dba3f141ecb3c1504c8d21224d61ec88dba', 'wxapp');
INSERT INTO `st_user_token` VALUES ('2', '2', '1560487602', '1544935602', '58402d44e82565e3aa3d49605e5bb9c158402d44e82565e3aa3d49605e5bb9c1', 'wxapp');
INSERT INTO `st_user_token` VALUES ('3', '2', '1560495873', '1544943873', '666fe8887dae66e505cf3b371a24b614666fe8887dae66e505cf3b371a24b614', 'web');
INSERT INTO `st_user_token` VALUES ('4', '1', '1563419646', '1547867646', '8ee7fd55d9dcd30f8142331f7c88f4348ee7fd55d9dcd30f8142331f7c88f434', 'web');
INSERT INTO `st_user_token` VALUES ('5', '3', '1565941052', '1550389052', '9ba4260c44a975bcc8d0af6edd1deac89ba4260c44a975bcc8d0af6edd1deac8', 'web');
INSERT INTO `st_user_token` VALUES ('6', '4', '1565941180', '1550389180', '3d8cda7b6db3c58154a10b699e24bdb13d8cda7b6db3c58154a10b699e24bdb1', 'web');

-- ----------------------------
-- Table structure for st_verification_code
-- ----------------------------
DROP TABLE IF EXISTS `st_verification_code`;
CREATE TABLE `st_verification_code` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当天已经发送成功的次数',
  `send_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后发送成功时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码过期时间',
  `code` varchar(8) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '最后发送成功的验证码',
  `account` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '手机号或者邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='手机邮箱数字验证码表';

-- ----------------------------
-- Records of st_verification_code
-- ----------------------------
INSERT INTO `st_verification_code` VALUES ('1', '1', '1544533099', '1544534899', '794006', '13399878665');
INSERT INTO `st_verification_code` VALUES ('2', '1', '1544935591', '1544937391', '849734', '18581290597');

-- ----------------------------
-- Table structure for st_video_vod
-- ----------------------------
DROP TABLE IF EXISTS `st_video_vod`;
CREATE TABLE `st_video_vod` (
  `video_id` char(32) NOT NULL DEFAULT '' COMMENT '视频/资源id',
  `video_url` varchar(255) NOT NULL DEFAULT '' COMMENT '转码后视频播放地址',
  `source_url` varchar(255) NOT NULL DEFAULT '' COMMENT '源文件播放地址',
  `source_raw` text COMMENT '原始数据',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`video_id`),
  UNIQUE KEY `primary_video_id` (`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='阿里云_资源_列表';

-- ----------------------------
-- Records of st_video_vod
-- ----------------------------
INSERT INTO `st_video_vod` VALUES ('1', '', '', null, '5', '0');
INSERT INTO `st_video_vod` VALUES ('594fded6da994c92892b577408437de8', '', 'https://video.fengbaojy.com/customerTrans/cc3180582a5c4fec081ef45ef78264d7/36686a32-16870fc8ff7-0004-ace9-db8-39ca7.mp4', '', '1548083832', '0');
INSERT INTO `st_video_vod` VALUES ('5dd982473c34420e89d9765ce3af5154', 'https://video.fengbaojy.com/5dd982473c34420e89d9765ce3af5154/d1362961539f436aa602199c63308b38-fc2abbe6cd41d485429d865560b27a43-ld.mp4', 'https://video.fengbaojy.com/customerTrans/cc3180582a5c4fec081ef45ef78264d7/aa5cb06-16870e4bc1e-0004-ace9-db8-39ca7.mp4', '', '1548082629', '0');
INSERT INTO `st_video_vod` VALUES ('ee1146565bf54f19be5cda159abd9641', '', 'https://video.fengbaojy.com/customerTrans/cc3180582a5c4fec081ef45ef78264d7/5a86986e-16870fa7297-0004-ace9-db8-39ca7.mp4', '', '1548083740', '0');
