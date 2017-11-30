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
  content text NOT NULL COMMENT '邮件模板内容',
  accessoryPath TEXT COMMENT '附件的地址',
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
  content TEXT not NULL COMMENT '邮箱的内容',
  accessoryPath VARCHAR(255) NOT NULL COMMENT '邮箱附件的地址',
  createTime DATETIME COMMENT '创建时间',
  emailCode VARCHAR(255) not null,
  status int NOT NULL COMMENT '状态',
  userId long not null
)engine=innodb default charset=utf8;

drop TABLE IF EXISTS t_file;
create table t_file(
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '文件上传记录id',
    name VARCHAR(255) not null COMMENT '文件名称',
    path VARCHAR(255) not null,
    userId long not null,
    createTime DATETIME DEFAULT now()
)engine=innodb default charset=utf8;
truncate table t_file

update t_file set path="/upload/1511507099521034100.xlsx"
select * from t_mailhistory where userId=1 and (title LIKE '%'+'0'+'%' or srcsend LIKE '%'+'0'+'%' or endsend  LIKE '%'+'0'+'%' or content  LIKE '%'+'0'+'%' )
select * from t_mailhistory WHERE ( title like '%软件开发部工作模板%') or content like '%软件开发部工作模板%' or srcsend like '%软件开发部工作模板%' or endsend like '%软件开发部工作模板%'  and status in (2)
select concat('%'+'软件开发部工作模板'+'%');
select count(*) from t_mailhistory WHERE  title like '%'+软件开发部+'%' or content like '%'+软件开发部+'%' or srcsend like '%'+软件开发部+'%' or endsend like '%'+软件开发部+'%'  and status in (2)






