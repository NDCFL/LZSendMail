create database lzsendmail;
use lzsendmail;
create table t_agency (
  id bigint identity(1,1) PRIMARY KEY   ,-- '经销商的编号',
  companyName varchar(20) DEFAULT NULL ,-- '经销商所属公司名称',
  leader varchar(20) NOT NULL ,-- '经销商负责人',
  emailAcc varchar(20) NOT NULL ,-- '经销商邮箱',
) ;
INSERT INTO T_AGENCY VALUES ('丽珠试剂有限公司', 'LIZ', 'LZ.QQ.COM');
INSERT INTO T_AGENCY VALUES ('丽珠试剂', 'LIZHUSHIJI', 'LIZHUSHIJI@QQ.COM');
INSERT INTO T_AGENCY VALUES ('TEST', 'TEST', 'TESE@11.COM');
INSERT INTO T_AGENCY VALUES ('里', '水电费', '111@QQ.COM');

CREATE TABLE t_file (
  id bigint NOT NULL identity(1,1) primary key ,-- '文件上传记录id',
  name varchar(255) NOT NULL ,-- '文件名称',
  path varchar(255) NOT NULL,
  userId BIGINT NOT NULL,
  createTime datetime DEFAULT CURRENT_TIMESTAMP
) ;
INSERT INTO t_file VALUES ( 'TypeService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:07:09');
INSERT INTO t_file VALUES ( 'BaseService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:09:14');
INSERT INTO t_file VALUES ( 'AgencyService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:09:14');
INSERT INTO t_file VALUES ( 'UserService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:09:42');
INSERT INTO t_file VALUES ( 'TypeService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:09:42');
INSERT INTO t_file VALUES ( 'MailModuleService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:09:42');
INSERT INTO t_file VALUES ( 'MailModuleService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:11:38');
INSERT INTO t_file VALUES ( 'EmailService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:11:38');
INSERT INTO t_file VALUES ( 'FileService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:11:38');
INSERT INTO t_file VALUES ( 'FileService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:15:09');
INSERT INTO t_file VALUES ( 'MailModuleService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:15:09');
INSERT INTO t_file VALUES ( 'TypeService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:17:26');
INSERT INTO t_file VALUES ( 'TypeService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:17:36');
INSERT INTO t_file VALUES ( 'MailModuleService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:17:36');
INSERT INTO t_file VALUES ( 'FileService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:17:36');
INSERT INTO t_file VALUES ( 'MailModuleService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:19:08');
INSERT INTO t_file VALUES ( 'TypeService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:19:08');
INSERT INTO t_file VALUES ( 'UserService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:19:08');
INSERT INTO t_file VALUES ( 'BaseService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:21:18');
INSERT INTO t_file VALUES ( 'AgencyService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:21:18');
INSERT INTO t_file VALUES ( 'EmailService.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:21:18');
INSERT INTO t_file VALUES ( 'UserVo.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:23:03');
INSERT INTO t_file VALUES ( 'MailModuleVo.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:23:03');
INSERT INTO t_file VALUES ( 'TypeVo.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:23:03');
INSERT INTO t_file VALUES ( 'AgencyVo.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:23:24');
INSERT INTO t_file VALUES ( 'EmailVo.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:23:24');
INSERT INTO t_file VALUES ( 'FileUpVo.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:32:09');
INSERT INTO t_file VALUES ( 'File.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:32:09');
INSERT INTO t_file VALUES ( 'FileVo.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:34:21');
INSERT INTO t_file VALUES ( 'FileUpVo.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:36:40');
INSERT INTO t_file VALUES ( 'EmailServiceImpl.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:37:43');
INSERT INTO t_file VALUES ( 'MailModuleServiceImpl.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:37:43');
INSERT INTO t_file VALUES ( 'TypeServiceImpl.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:39:27');
INSERT INTO t_file VALUES ( 'ReciveMail.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:39:34');
INSERT INTO t_file VALUES ( 'TypeServiceImpl.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:39:34');
INSERT INTO t_file VALUES ( 'MailAuthenticator.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:55:50');
INSERT INTO t_file VALUES ( 'Mail.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 15:58:35');
INSERT INTO t_file VALUES ( 'Mail.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 16:06:09');
INSERT INTO t_file VALUES ( 'UEditorFilter.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 16:11:11');
INSERT INTO t_file VALUES ( 'MailModuleDAO.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 16:15:41');
INSERT INTO t_file VALUES ( 'FileDAO.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 16:18:18');
INSERT INTO t_file VALUES ( 'EmailDAO.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 16:20:22');
INSERT INTO t_file VALUES ( 'UserDAO.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 16:20:37');
INSERT INTO t_file VALUES ( 'AgencyDAO.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 16:23:57');
INSERT INTO t_file VALUES ( 'TypeDAO.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-28 16:26:29');
INSERT INTO t_file VALUES ( 'EmailDAO.java', '/upload/1511507099521034100.xlsx', '1', '2017-11-29 09:00:51');
INSERT INTO t_file VALUES ( '软件开发部工作日志【陈飞龙】【20171122】.xlsx', '/upload/软件开发部工作日志【陈飞龙】【20171122】.xlsx', '1', '2017-11-29 09:57:37');
INSERT INTO t_file VALUES ( '软件开发部工作日志【陈飞龙】【20171122】.xlsx', '/upload/软件开发部工作日志【陈飞龙】【20171122】.xlsx', '1', '2017-11-29 10:39:30');
INSERT INTO t_file VALUES ( '软件开发部工作日志【陈飞龙】【20171122】.xlsx', '/upload/软件开发部工作日志【陈飞龙】【20171122】.xlsx', '1', '2017-11-29 10:55:59');
INSERT INTO t_file VALUES ( '软件开发部工作模板（部门成员20171121）.xlsx', '/upload/软件开发部工作模板（部门成员20171121）.xlsx', '1', '2017-11-29 11:01:24');
INSERT INTO t_file VALUES ( '软件开发部工作模板（部门成员20171121）.xlsx', '/upload/软件开发部工作模板（部门成员20171121）.xlsx', '1', '2017-11-29 11:03:01');
INSERT INTO t_file VALUES ( '软件开发部工作模板（部门成员20171121）.xlsx', '/upload/软件开发部工作模板（部门成员20171121）.xlsx', '1', '2017-11-29 14:50:42');
INSERT INTO t_file VALUES ( '软件开发部工作模板（部门成员20171121）.xlsx', '/upload/软件开发部工作模板（部门成员20171121）.xlsx', '1', '2017-11-29 14:52:53');
INSERT INTO t_file VALUES ( '软件开发部工作日志【陈飞龙】【20171122】.xlsx', '/upload/软件开发部工作日志【陈飞龙】【20171122】.xlsx', '1', '2017-11-29 15:14:40');

-- ----------------------------
-- Table structure for t_mailhistory
-- ----------------------------
drop table t_mailhistory
CREATE TABLE t_mailhistory (
  id bigint  identity(1,1) primary key ,-- '邮件分类的编号',
  srcsend varchar(255) NOT NULL ,-- '邮箱的发送者',
  endsend varchar(255) NOT NULL ,-- '邮箱的接受者',
  title varchar(255) NOT NULL ,-- '邮件的标题',
  content text NOT NULL ,-- '邮箱的内容',
  accessoryPath text ,-- '邮箱附件的地址',
  createTime datetime DEFAULT NULL ,-- '创建时间',
  emailCode varchar(255) DEFAULT NULL,
  status int NOT NULL ,-- '状态',
  userId BIGINT NOT NULL
) ;

-- ----------------------------
-- Records of t_mailhistory
-- ----------------------------
INSERT INTO t_mailhistory VALUES ('陈飞龙<xljx_888888@163.com>', '275300091 <275300091@qq.com>', '测试', '测试<div style=\"line-height:1.7;color:#000000;font-size:14px;font-family:Arial\">测试</div><br><br><span title=\"neteasefooter\"><div id=\"netease_mail_footer\"><div style=\"border-top:#CCC 1px solid;padding:10px 5px;font-size:15px;color:#777;line-height:22px\"><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\n &nbsp; &nbsp;</div></div></span>', '微信图片_20171114114844_0000.doc', '2017-11-27 09:58:57', '<79d89446.1f70.15ffb32e552.Coremail.xljx_888888@163.com>', '2', '1');
INSERT INTO t_mailhistory VALUES ('陈飞龙<xljx_888888@163.com>', '275300091 <275300091@qq.com>', '测试发送', '测试发送<div style=\"line-height:1.7;color:#000000;font-size:14px;font-family:Arial\"><b>测试发送</b></div><br><br><span title=\"neteasefooter\"><div id=\"netease_mail_footer\"><div style=\"border-top:#CCC 1px solid;padding:10px 5px;font-size:15px;color:#777;line-height:22px\"><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\n &nbsp; &nbsp;</div></div></span>', '微信图片_20171114114844_0000.doc', '2017-11-27 10:05:28', '<3a80c35b.2178.15ffb38dabb.Coremail.xljx_888888@163.com>', '2', '1');
INSERT INTO t_mailhistory VALUES ('陈飞龙<xljx_888888@163.com>', '275300091 <275300091@qq.com>', '附件测试', '附件测试<div style=\"line-height:1.7;color:#000000;font-size:14px;font-family:Arial\">附件测试</div><br><br><span title=\"neteasefooter\"><div id=\"netease_mail_footer\"><div style=\"border-top:#CCC 1px solid;padding:10px 5px;font-size:15px;color:#777;line-height:22px\"><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\n &nbsp; &nbsp;</div></div></span>', '微信图片_20171114114844_0000.doc', '2017-11-27 10:13:52', '<6e675e8c.23f9.15ffb408d0f.Coremail.xljx_888888@163.com>', '2', '1');
INSERT INTO t_mailhistory VALUES ('陈飞龙<xljx_888888@163.com>', '275300091 <275300091@qq.com>', 'web', 'web<div style=\"line-height:1.7;color:#000000;font-size:14px;font-family:Arial\">web</div><br><br><span title=\"neteasefooter\"><div id=\"netease_mail_footer\"><div style=\"border-top:#CCC 1px solid;padding:10px 5px;font-size:15px;color:#777;line-height:22px\"><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\n &nbsp; &nbsp;</div></div></span>', '微信图片_20171114114844_0000.doc', '2017-11-27 10:42:49', '<719114f9.2d22.15ffb5b0c57.Coremail.xljx_888888@163.com>', '2', '1');
INSERT INTO t_mailhistory VALUES ('陈飞龙<xljx_888888@163.com>', '275300091 <275300091@qq.com>', 'WEB', 'WEB<div style=\"line-height:1.7;color:#000000;font-size:14px;font-family:Arial\">WEB</div><br><br><span title=\"neteasefooter\"><div id=\"netease_mail_footer\"><div style=\"border-top:#CCC 1px solid;padding:10px 5px;font-size:15px;color:#777;line-height:22px\"><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\n &nbsp; &nbsp;</div></div></span>', '微信图片_20171114114844_0000.doc', '2017-11-27 10:46:21', '<1a555d3f.2e50.15ffb5e4b75.Coremail.xljx_888888@163.com>', '2', '1');
INSERT INTO t_mailhistory VALUES ('陈飞龙<xljx_888888@163.com>', '275300091 <275300091@qq.com>', '软件开发部工作模板（部门经理、项目经理20171121）', '邮件接收测试<div style=\"line-height:1.7;color:#000000;font-size:14px;font-family:Arial\">邮件接收测试</div><br><br><span title=\"neteasefooter\"><div id=\"netease_mail_footer\"><div style=\"border-top:#CCC 1px solid;padding:10px 5px;font-size:15px;color:#777;line-height:22px\"><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\n &nbsp; &nbsp;</div></div></span>', '软件开发部工作模板（部门经理、项目经理20171121）.xlsx', '2017-11-27 09:29:49', '<6ec82fe3.1652.15ffb183a30.Coremail.xljx_888888@163.com>', '2', '1');
INSERT INTO t_mailhistory VALUES ('陈飞龙<xljx_888888@163.com>', '275300091 <275300091@qq.com>', '测试', '测试<div style=\"line-height:1.7;color:#000000;font-size:14px;font-family:Arial\">测试</div><br><br><span title=\"neteasefooter\"><div id=\"netease_mail_footer\"><div style=\"border-top:#CCC 1px solid;padding:10px 5px;font-size:15px;color:#777;line-height:22px\"><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\n &nbsp; &nbsp;</div></div></span>', '微信图片_20171114114844_0000.doc', '2017-11-27 09:58:57', '<79d89446.1f70.15ffb32e552.Coremail.xljx_888888@163.com>', '2', '1');
INSERT INTO t_mailhistory VALUES ('陈飞龙<xljx_888888@163.com>', '275300091 <275300091@qq.com>', '测试发送', '测试发送<div style=\"line-height:1.7;color:#000000;font-size:14px;font-family:Arial\"><b>测试发送</b></div><br><br><span title=\"neteasefooter\"><div id=\"netease_mail_footer\"><div style=\"border-top:#CCC 1px solid;padding:10px 5px;font-size:15px;color:#777;line-height:22px\"><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\n &nbsp; &nbsp;</div></div></span>', '微信图片_20171114114844_0000.doc', '2017-11-27 10:05:28', '<3a80c35b.2178.15ffb38dabb.Coremail.xljx_888888@163.com>', '2', '1');
INSERT INTO t_mailhistory VALUES ('陈飞龙<xljx_888888@163.com>', '275300091 <275300091@qq.com>', '附件测试', '附件测试<div style=\"line-height:1.7;color:#000000;font-size:14px;font-family:Arial\">附件测试</div><br><br><span title=\"neteasefooter\"><div id=\"netease_mail_footer\"><div style=\"border-top:#CCC 1px solid;padding:10px 5px;font-size:15px;color:#777;line-height:22px\"><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\n &nbsp; &nbsp;</div></div></span>', '微信图片_20171114114844_0000.doc', '2017-11-27 10:13:52', '<6e675e8c.23f9.15ffb408d0f.Coremail.xljx_888888@163.com>', '2', '1');
INSERT INTO t_mailhistory VALUES ( '陈飞龙<xljx_888888@163.com>', '275300091 <275300091@qq.com>', 'web', 'web<div style=\"line-height:1.7;color:#000000;font-size:14px;font-family:Arial\">web</div><br><br><span title=\"neteasefooter\"><div id=\"netease_mail_footer\"><div style=\"border-top:#CCC 1px solid;padding:10px 5px;font-size:15px;color:#777;line-height:22px\"><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\n &nbsp; &nbsp;</div></div></span>', '微信图片_20171114114844_0000.doc', '2017-11-27 10:42:49', '<719114f9.2d22.15ffb5b0c57.Coremail.xljx_888888@163.com>', '2', '1');
INSERT INTO t_mailhistory VALUES ( '陈飞龙<xljx_888888@163.com>', '275300091 <275300091@qq.com>', 'WEB', 'WEB<div style=\"line-height:1.7;color:#000000;font-size:14px;font-family:Arial\">WEB</div><br><br><span title=\"neteasefooter\"><div id=\"netease_mail_footer\"><div style=\"border-top:#CCC 1px solid;padding:10px 5px;font-size:15px;color:#777;line-height:22px\"><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\n &nbsp; &nbsp;</div></div></span>', '微信图片_20171114114844_0000.doc', '2017-11-27 10:46:21', '<1a555d3f.2e50.15ffb5e4b75.Coremail.xljx_888888@163.com>', '2', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', '1478087747@qq.com', '444444444', '<p>4444444</p>', '/upload/MailAuthenticator.java;', '2017-11-28 15:55:55', '666', '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', '888888888', '<p>888888888</p>', '/upload/Mail.java;', '2017-11-28 16:00:12', '666', '2', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', '33', '<p>333333</p>', '/upload/Mail.java;', '2017-11-28 16:06:17', '666', '2', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', '6666', '<p>6666</p>', '/upload/UEditorFilter.java;', '2017-11-28 16:11:15', '666', '2', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', '888', '<p>8888</p>', '/upload/MailModuleDAO.java;', '2017-11-28 16:15:46', '666', '2', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', '0000000', '<p>00000</p>', '/upload/FileDAO.java;', '2017-11-28 16:18:22', '666', '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', '121312', '<p>3123131</p>', '/upload/UserDAO.java;', '2017-11-28 16:21:18', '666', '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', '77777777', '<p>77777777777</p>', '/upload/AgencyDAO.java;', '2017-11-28 16:24:16', '666', '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', '86564646', '<p>5464564</p>', '/upload/TypeDAO.java;', '2017-11-28 16:26:32', '666', '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', 'asdfaasfd', '<p>asdfa</p>', '', '2017-11-28 16:27:48', '666', '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', 'hsdzfsdfsdfg', '<p>sfgvsgdvfsz</p>', '', '2017-11-28 16:29:32', '666', '0', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', 'tes', '<p>test</p>', 'upload/软件开发部工作日志【陈飞龙】【20171122】.xlsx;', '2017-11-29 11:00:19', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', 'tes', '<p>test</p>', '/upload/软件开发部工作模板（部门成员20171121）.xlsx;', '2017-11-29 11:01:27', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', 'asfasfdasdf', '<p>asfasgadfga</p>', '/upload/软件开发部工作模板（部门成员20171121）.xlsx;', '2017-11-29 11:03:03', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', 'tes', '<p>test</p>', 'upload/软件开发部工作日志【陈飞龙】【20171122】.xlsx;', '2017-11-29 11:07:44', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', 'tes', '<p>test</p>', '', '2017-11-29 14:50:27', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', 'tes', '<p>test</p>', '', '2017-11-29 14:50:45', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', 'xljx_888888@163.com', 'tes', '<p>test</p>', '/upload/软件开发部工作日志【陈飞龙】【20171122】.xlsx;', '2017-11-29 15:08:38', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', '陈飞龙<xljx_888888@163.com>', '测试', '<p>测试</p><p>测试</p><p><br/><br/><p><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\r\n &nbsp; &nbsp;</p></p>', '', '2017-11-29 15:14:11', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', '陈飞龙<xljx_888888@163.com>', '测试', '<p>测试</p><p>测试</p><p><br/><br/><p><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\r\n &nbsp; &nbsp;</p></p>', '/upload/软件开发部工作日志【陈飞龙】【20171122】.xlsx;', '2017-11-29 15:14:43', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', '陈飞龙<xljx_888888@163.com>；clevercfl@139.com', '测试', '<p>测试</p><p>测试</p><p><br/><br/><p><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\r\n &nbsp; &nbsp;</p></p>', '', '2017-11-29 15:29:51', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', '陈飞龙<xljx_888888@163.com>;clevercfl@139.com', '测试111', '<p>测试11</p><p>测试11</p><p><br/><br/><p><a href=\"http://you.163.com/item/manufacturer?tagId=1001000&from=web_ad_jiaobiao\" target=\"_blank\" style=\"color:#3366FF;text-decoration:none\">【网易自营|30天无忧退货】无印良品制造商直供便携拖鞋等好物，限时29元起&gt;&gt;</a>\r\n &nbsp; &nbsp;</p></p>', '', '2017-11-29 15:31:21', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', '275300091@qq.com', '888', '<p>8888</p>', '//upload/MailModuleDAO.java;', '2017-11-29 17:01:35', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', '275300091@qq.com', '0000000', '<p>00000</p>', '//upload/FileDAO.java;', '2017-11-29 17:04:58', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', '275300091@qq.com', '121312', '<p>3123131</p>', '//upload/UserDAO.java;', '2017-11-29 17:05:30', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', '275300091@qq.com', '77777777', '<p>77777777777</p>', '//upload/AgencyDAO.java;', '2017-11-29 17:08:26', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', '275300091@qq.com', '86564646', '<p>5464564</p>', '//upload/TypeDAO.java;', '2017-11-29 17:09:30', null, '1', '1');
INSERT INTO t_mailhistory VALUES ( '275300091@qq.com', '275300091@qq.com', 'asdfaasfd', '<p>asdfa</p>', '', '2017-11-29 17:10:00', null, '1', '1');

-- ----------------------------
-- Table structure for t_mailmodule
-- ----------------------------
DROP TABLE IF EXISTS t_mailmodule;
CREATE TABLE t_mailmodule (
id bigint NOT NULL identity(1,1) primary key ,-- '邮件模板的编号',
title varchar(255) NOT NULL ,-- '邮件模板的标题',
content text NOT NULL ,-- '邮件模板内容',
accessoryPath text ,-- '附件的地址',
userId BIGINT NOT NULL ,-- '用户的id',
createTime DATETIME DEFAULT NULL);

-- ----------------------------
-- Records of t_mailmodule
-- ----------------------------
INSERT INTO t_mailmodule VALUES ('tes', '<p>test</p>', '/upload/软件开发部工作日志【陈飞龙】【20171122】.xlsx;', '1', '2017-11-28');
INSERT INTO t_mailmodule VALUES ('test2', '<p>twst</p>', '/upload/AgencyService.java;/upload/BaseService.java;/upload/EmailService.java;', '1', '2017-11-28');
INSERT INTO t_mailmodule VALUES ('111111', '<p>111111</p>', '/upload/UserVo.java;/upload/AgencyVo.java;/upload/EmailVo.java;;', '1', '2017-11-28');
INSERT INTO t_mailmodule VALUES ('xfgbgxdgh', '<p>dfhshbsd</p>', '', '1', '2017-11-28');
INSERT INTO t_mailmodule VALUES ('fasdfasf', '<p>asdfasfafas</p>', '/upload/EmailDAO.java;', '1', '2017-11-29');
INSERT INTO t_mailmodule VALUES ('asdfasdf00000000', '<p>cv bcvbcvc</p>', '', '1', '2017-11-29');

-- ----------------------------
-- Table structure for t_type
-- ----------------------------
DROP TABLE IF EXISTS t_type;
CREATE TABLE t_type (
  id bigint NOT NULL identity(1,1) primary key ,-- '邮件分类的编号',
  typename varchar(20) NOT NULL ,-- '邮箱分类名称',
  userId BIGINT NOT NULL ,-- '用户编号',
  agentyId varchar(255) NOT NULL ,-- '经销商的id多个经销商用逗号进行分割',
  createTime datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------
-- Records of t_type
-- ----------------------------
INSERT INTO t_type VALUES ('工作', '1', '1,3,4,5', '2017-11-24 18:18:08');
INSERT INTO t_type VALUES ('同事', '1', '1,3', '2017-11-25 10:19:36');
INSERT INTO t_type VALUES ('朋友', '1', '1,3,4', '2017-11-25 10:25:18');
INSERT INTO t_type VALUES ('兄弟', '1', '3,5', '2017-11-25 14:50:31');
INSERT INTO t_type VALUES ('test', '1', '1,5', '2017-11-25 15:51:26');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
CREATE TABLE t_user (
  id bigint NOT NULL identity(1,1) primary key ,-- '用户的编号',
  loginAcc varchar(20) NOT NULL ,-- '用户的账号',
  loginPassword varchar(36) NOT NULL ,-- '登录密码',
  email varchar(20) DEFAULT NULL ,-- '用户邮箱',
  password varchar(36) DEFAULT NULL ,-- '用户邮箱登录密码',
  nickname varchar(20) DEFAULT NULL ,-- '发件昵称',
  serverPort int DEFAULT NULL ,-- '邮箱服务器端口号',
  serverHost varchar(20) DEFAULT NULL ,-- '邮箱服务器',
  inserverPort int DEFAULT NULL ,-- '收件邮箱服务器端口号',
  inserverHost varchar(20) DEFAULT NULL ,-- '收件邮箱服务器',
  status int DEFAULT NULL
);

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO t_user VALUES ('admin', 'lueSGJZetyySpUndWjMBEg==', '275300091@qq.com', 'zwrdfwntpketbjeh', '陈飞龙', '465', 'smtp.qq.com', '465', 'imap.qq.com', '0');












