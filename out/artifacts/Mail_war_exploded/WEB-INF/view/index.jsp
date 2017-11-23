<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>丽珠邮件系统</title>
    <!--[if lt IE 8]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <link href="<%=path%>/css/bootstrap.min.css?v=3.3.5" rel="stylesheet">
    <link href="<%=path%>/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="<%=path%>/css/animate.min.css" rel="stylesheet">
    <link href="<%=path%>/css/style.min.css?v=4.0.0" rel="stylesheet">
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<div id="wrapper">
    <!--左侧导航开始-->
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="nav-close"><i class="fa fa-times-circle"></i>
        </div>
        <div class="sidebar-collapse">
            <ul class="nav" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element">
                        <span><img alt="image" class="img-circle" src="<%=path%>/img/face.gif" style="width:80px;height:80px" /></span>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                                <span class="text-muted text-xs block">${userVo.loginAcc}<b class="caret"></b></span>
                                </span>
                        </a>
                        <ul class="dropdown-menu animated fadeInRight m-t-xs">
                            <li>
                                <a class="J_menuItem" href="<%=path%>/user/myInfoPage">个人资料</a>
                            </li>
                            <li>
                                <a class="J_menuItem" href="<%=path%>/user/updatePassword">修改密码</a>
                            </li>
                            <li class="divider"></li>
                            <li><a href="<%=path%>/user/exit">安全退出</a>
                            </li>
                        </ul>
                    </div>
                    <div class="logo-element">lz
                    </div>
                </li>
                <li>
                    <a href="#">
                        <i class="fa fa-home"></i>
                        <span class="nav-label">我的资料</span>
                        <span class="fa arrow"></span>
                    </a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a class="J_menuItem" href="<%=path%>/user/myInfoPage" data-index="0">修改资料</a>
                        </li>
                        <li>
                            <a class="J_menuItem" href="<%=path%>/user/updatePassword" data-index="0">修改密码</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="mailbox.html"><i class="fa fa-envelope"></i> <span class="nav-label">信箱 </span><span class="label label-warning pull-right">16</span></a>
                    <ul class="nav nav-second-level">
                        <li><a class="J_menuItem" href="mailbox.html">收件箱</a>
                        </li>
                        <li><a class="J_menuItem" href="mail_detail.html">查看邮件</a>
                        </li>
                        <li><a class="J_menuItem" href="mail_compose.html">写信</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#"><i class="fa fa-edit"></i> <span class="nav-label">表单</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li><a class="J_menuItem" href="form_basic.html">基本表单</a>
                        </li>
                        <li><a class="J_menuItem" href="form_validate.html">表单验证</a>
                        </li>
                        <li><a class="J_menuItem" href="form_advanced.html">高级插件</a>
                        </li>
                        <li><a class="J_menuItem" href="form_wizard.html">表单向导</a>
                        </li>
                        <li>
                            <a href="#">文件上传 <span class="fa arrow"></span></a>
                            <ul class="nav nav-third-level">
                                <li><a class="J_menuItem" href="form_webuploader.html">百度WebUploader</a>
                                </li>
                                <li><a class="J_menuItem" href="form_file_upload.html">DropzoneJS</a>
                                </li>
                                <li><a class="J_menuItem" href="form_avatar.html">头像裁剪上传</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">编辑器 <span class="fa arrow"></span></a>
                            <ul class="nav nav-third-level">
                                <li><a class="J_menuItem" href="form_editors.html">富文本编辑器</a>
                                </li>
                                <li><a class="J_menuItem" href="form_simditor.html">simditor</a>
                                </li>
                                <li><a class="J_menuItem" href="form_markdown.html">MarkDown编辑器</a>
                                </li>
                                <li><a class="J_menuItem" href="code_editor.html">代码编辑器</a>
                                </li>
                            </ul>
                        </li>
                        <li><a class="J_menuItem" href="suggest.html">搜索自动补全</a>
                        </li>
                        <li><a class="J_menuItem" href="layerdate.html">日期选择器layerDate</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    <!--左侧导航结束-->
    <!--右侧部分开始-->
    <div id="page-wrapper" class="gray-bg dashbard-1">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                    <form role="search" class="navbar-form-custom" method="post" action="search_results.html">
                        <div class="form-group">
                            <input type="text" placeholder="请输入您需要查找的内容 …" class="form-control" name="top-search" id="top-search">
                        </div>
                    </form>
                </div>
            </nav>
        </div>
        <div class="row content-tabs">
            <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
            </button>
            <nav class="page-tabs J_menuTabs">
                <div class="page-tabs-content">
                    <a href="javascript:;" class="active J_menuTab" data-id="index_v1.html">首页</a>
                </div>
            </nav>
            <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
            </button>
            <div class="btn-group roll-nav roll-right">
                <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span>
                </button>
            </div>
            <a href="login.html" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
        </div>
        <div class="row J_mainContent" id="content-main">
            <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="<%=path%>/user/myInfoPage" frameborder="0" data-id="index_v2.html" seamless></iframe>
        </div>
        <div class="footer">
            <div class="pull-right">&copy; 2017 <a href="javascript:void(0);" target="_blank">丽珠试剂</a>
            </div>
        </div>
    </div>
</div>
<script src="<%=path%>/js/jquery.min.js?v=2.1.4"></script>
<script src="<%=path%>/js/bootstrap.min.js?v=3.3.5"></script>
<script src="<%=path%>/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="<%=path%>/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="<%=path%>/js/plugins/layer/layer.min.js"></script>
<script src="<%=path%>/js/hplus.min.js?v=4.0.0"></script>
<script type="text/javascript" src="<%=path%>/js/contabs.min.js"></script>
<script src="<%=path%>/js/plugins/pace/pace.min.js"></script>
</body>

</html>