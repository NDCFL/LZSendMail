<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    if(session.getAttribute("userVo")==null){
        response.sendRedirect("/user/login");
        return;
    }
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
        <div class="sidebar-collapse" >
            <ul class="nav" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element" style="text-align: center">
                        <span><img alt="image" class="img-circle" src="<%=path%>/img/face.png" style="width:80px;height:80px" /></span>
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
                <li class="active">
                    <a href="#">
                        <i class="fa fa-home"></i>
                        <span class="nav-label">我的资料</span>
                        <span class="fa arrow"></span>
                    </a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a class="J_menuItem" href="<%=path%>/user/myInfoPage" data-index="0">个人资料</a>
                        </li>
                        <li>
                            <a class="J_menuItem" href="<%=path%>/user/updatePassword" data-index="0">修改密码</a>
                        </li>
                    </ul>
                </li>
                <li class="active">
                    <a href="mailbox.html"><i class="fa fa-envelope"></i> <span class="nav-label">信箱 </span><span class="label label-warning pull-right">16</span></a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a class="J_menuItem" href="<%=path%>/mailModule/mailModulePage">邮件模板</a>
                        </li>
                        <li>
                            <a class="J_menuItem" href="<%=path%>/email/emailPage">收件箱</a>
                        </li>
                        <li><a class="J_menuItem" href="<%=path%>/email/sendMain">发件箱</a>
                        </li>
                        <li><a class="J_menuItem" href="<%=path%>/mail/sendPage">写信</a>
                        </li>
                        <li><a class="J_menuItem" href="<%=path%>/file/filePage">附件管理</a>
                        </li>
                    </ul>
                </li>
                <li class="active">
                    <a href="#"><i class="fa fa-edit"></i> <span class="nav-label">用户管理</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <c:if test="${userVo.loginAcc=='admin'}">
                            <li>
                                <a class="J_menuItem" href="<%=path%>/user/userPage">用户列表</a>
                            </li>
                            <li>
                                <a class="J_menuItem" href="<%=path%>/agency/agencyPage">经销商列表</a>
                            </li>
                        </c:if>
                        <li>
                            <a class="J_menuItem" href="<%=path%>/type/typePage">分类管理</a>
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
                    <a href="javascript:;" class="active J_menuTab" data-id="<%=path%>/user/myInfoPage" title="双击Tab刷新">首页</a>
                </div>
            </nav>
            <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
            </button>
            <div class="btn-group roll-nav roll-right">
                <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span>
                </button>
                <ul role="menu" class="dropdown-menu dropdown-menu-right">
                    <li class="J_tabShowActive"><a>定位当前选项卡</a>
                    </li>
                    <li class="divider"></li>
                    <li class="J_tabCloseAll"><a>关闭全部选项卡</a>
                    </li>
                    <li class="J_tabCloseOther"><a>关闭其他选项卡</a>
                    </li>
                </ul>
            </div>
            <a href="login.html" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
        </div>
        <div class="row J_mainContent" id="content-main">
            <iframe class="J_iframe" name="iframe" width="100%" height="100%" src="<%=path%>/user/myInfoPage" frameborder="0" data-id="<%=path%>/user/myInfoPage" seamless></iframe>
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