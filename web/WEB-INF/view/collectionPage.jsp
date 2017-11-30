<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-11-24
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>丽珠邮箱系统收件箱</title>
   <jsp:include page="comment/modulecss.jsp"></jsp:include>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-sm-12 animated fadeInRight">
            <div class="mail-box-header">
                <form method="get" action="index.html" class="pull-right mail-search">
                    <div class="input-group">
                        <input type="text" class="form-control input-sm" name="search" placeholder="搜索邮件标题，正文等">
                        <div class="input-group-btn">
                            <button type="submit" class="btn btn-sm btn-primary">
                                搜索
                            </button>
                        </div>
                    </div>
                </form>
                <h2>
                    收件箱 (16)
                </h2>
                <div class="mail-tools tooltip-demo m-t-md">
                    <div class="btn-group pull-right">
                        <button class="btn btn-white btn-sm"><i class="fa fa-arrow-left"></i>
                        </button>
                        <button class="btn btn-white btn-sm"><i class="fa fa-arrow-right"></i>
                        </button>

                    </div>
                    <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" title="刷新邮件列表"><i class="fa fa-refresh"></i> 刷新</button>
                    <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="标为已读"><i class="fa fa-eye"></i>
                    </button>
                    <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="标为重要"><i class="fa fa-exclamation"></i>
                    </button>
                    <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="标为垃圾邮件"><i class="fa fa-trash-o"></i>
                    </button>

                </div>
            </div>
            <div class="mail-box">

                <table class="table table-hover table-mail">
                    <tbody>
                    <tr class="unread">
                        <td class="check-mail">
                            <input type="checkbox" class="i-checks">
                        </td>
                        <td class="mail-ontact"><a href="mail_detail.html">支付宝</a>
                        </td>
                        <td class="mail-subject"><a href="mail_detail.html">支付宝提醒</a>
                        </td>
                        <td class=""><i class="fa fa-paperclip"></i>
                        </td>
                        <td class="text-right mail-date">昨天 10:20</td>
                    </tr>
                    <tr class="unread">
                        <td class="check-mail">
                            <input type="checkbox" class="i-checks" checked>
                        </td>
                        <td class="mail-ontact"><a href="mail_detail.html">Amaze UI</a>
                        </td>
                        <td class="mail-subject"><a href="mail_detail.html">Amaze UI Beta2 发布</a>
                        </td>
                        <td class=""></td>
                        <td class="text-right mail-date">上午10:57</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="comment/modulejs.jsp"></script>
</body>

</html>