use lzsendmail;
drop table IF EXISTS t_user;
create table t_user(
  id BIGINT PRIMARY KEY  AUTO_INCREMENT COMMENT '用户的编号',
  loginAcc VARCHAR(20) NOT NULL COMMENT '用户的账号',
  loginPassword VARCHAR(36) not NULL COMMENT '登录密码',
  email VARCHAR(20) COMMENT '用户邮箱',
  password VARCHAR(36)  COMMENT '用户邮箱登录密码',
  nickname VARCHAR(20)  COMMENT '发件昵称',
  serverPort int  COMMENT '邮箱服务器端口号',
  serverHost VARCHAR(20)  COMMENT '邮箱服务器',
  inserverPort int  COMMENT '收件邮箱服务器端口号',
  inserverHost VARCHAR(20)  COMMENT '收件邮箱服务器',
  status int COMMENT '用户状态'
)engine=innodb default charset=utf8;
drop table IF EXISTS t_agency;
create table t_agency(
  id BIGINT PRIMARY KEY  AUTO_INCREMENT COMMENT '经销商的编号',
  companyName VARCHAR(20) COMMENT '经销商所属公司名称',
  leader VARCHAR(20) not null COMMENT '经销商负责人',
  emailAcc VARCHAR(20) not NULL  COMMENT '经销商邮箱'
)engine=innodb default charset=utf8;
drop table IF EXISTS t_mailmodule;
create table t_mailmodule(
  id BIGINT PRIMARY KEY  AUTO_INCREMENT COMMENT '邮件模板的编号',
  title VARCHAR(20) NOT NULL COMMENT '邮件模板的标题',
  content TEXT NOT NULL COMMENT '邮件模板内容',
  accessoryPath VARCHAR(20) COMMENT '附件的地址',
  userId long NOT NULL COMMENT '用户的id'
)engine=innodb default charset=utf8;
drop table IF EXISTS t_type;
create table t_type(
  id BIGINT PRIMARY KEY  AUTO_INCREMENT COMMENT '邮件分类的编号',
  typename VARCHAR(20) NOT NULL COMMENT '邮箱分类名称',
  userId long NOT NULL  COMMENT '用户编号',
  agentyId VARCHAR(255) NOT NULL COMMENT '经销商的id多个经销商用逗号进行分割',
  createTime DATETIME NOT NULL  COMMENT '邮箱分类创建的时间'
)engine=innodb default charset=utf8;
drop table IF EXISTS t_mailhistory;
create table t_mailhistory(
  id BIGINT PRIMARY KEY  AUTO_INCREMENT COMMENT '邮件分类的编号',
  srcsend VARCHAR(20) NOT NULL COMMENT '邮箱的发送者',
  endsend VARCHAR(20) NOT NULL COMMENT '邮箱的接受者',
  title VARCHAR(20) NOT NULL COMMENT '邮件的标题',
  COMMENT TEXT not NULL COMMENT '邮箱的内容',
  accessoryPath VARCHAR(255) NOT NULL COMMENT '邮箱附件的地址',
  createTime DATETIME COMMENT '创建时间',
  status int NOT NULL COMMENT '状态'
)engine=innodb default charset=utf8;
