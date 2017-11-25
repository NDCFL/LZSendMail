<%--
  Created by IntelliJ IDEA.
  User: chenfeilong
  Date: 2017/10/19
  Time: 13:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>邮件模板列表</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5>邮件模板列表</h5>
        </div>
        <div class="ibox-content">
            <div class="panel panel-default">
                <div class="panel-heading">
                    邮件模板列表
                </div>
                <table id="mytab" name="mytab" class="table table-hover"></table>
                <div id="toolbar" class="btn-group pull-right" style="margin-right: 20px;">
                    <button id="btn_delete" onclick="deleteMany();" type="button" class="btn btn-default" style="display: block;">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true" ></span>批量删除
                    </button>
                    <button id="btn_add" type="button" class="btn btn-default" >
                        <span class="glyphicon glyphicon-plus" aria-hidden="true" ></span>新增
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<%--网站数据的新增--%>
<!-- 模态框（Modal） -->
<div class="modal fade" id="webAdd" tabindex="-1" role="dialog" aria-labelledby="webAddLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="webAddTitle">
                    新增邮件模板
                </h4>
            </div>
            <form class="form-horizontal" method="get">
                <div class="form-group">
                    <label class="col-sm-2 control-label">发送到：</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" value="i@zi-han.net">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">主题：</label>

                    <div class="col-sm-10">
                        <input type="text" class="form-control" value="">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">内容：</label>
                    <div  class="col-sm-10">
                        <textarea style="height:400px"  id="editor" ></textarea>
                    </div>
                </div>
                <div class="mail-attachment">
                    <p>
                        <span><i class="fa fa-paperclip"></i> 附件 - </span>
                        <a onclick="upFiles();">上传附件</a>
                    </p>
                </div>
                <textarea id="file" style="display: none"></textarea>
            </form>
        </div><!-- /.modal-content -->
        <div class="mail-body text-right tooltip-demo">
            <a href="mailbox.html" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="Send"><i class="fa fa-reply"></i> 提交审核</a>
            <a href="mailbox.html" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Discard email"><i class="fa fa-times"></i> 放弃</a>
            <a href="mailbox.html" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Move to draft folder"><i class="fa fa-pencil"></i> 存为草稿</a>
        </div>
        <div class="clearfix"></div>
    </div><!-- /.modal -->
</div>
<input type="hidden" value=""  id="deleteId"/>
<%--网站新增结束--%>
<%--邮件模板的修改--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    邮件模板的修改
                </h4>
            </div>
            <form class="form-horizontal" id="updateform" action="<%=path%>/mailModule/">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">所属公司：</label>
                        <div class="col-sm-8">
                            <input  name="companyName" id="companyName" minlength="2" maxlength="20" type="text" class="form-control" required="required" aria-required="true">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">负责人：</label>
                        <div class="col-sm-8">
                            <input  name="leader" id="leader" minlength="2" maxlength="20" type="text" class="form-control"  required="required" aria-required="true">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">邮件模板邮箱：</label>
                        <div class="col-sm-8">
                            <input  name="emailAcc" id="emailAcc" minlength="2" maxlength="20" type="email" class="form-control" required="required" aria-required="true">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" id="update" class="btn btn-primary" data-dismiss="modal">
                        确认修改
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<%--邮件模板的修改--%>
<jsp:include page="comment/modulejs.jsp"></jsp:include>
<script src="<%=path%>/js/pageJs/mailModuleList.js"></script>
</body>
<%--<script>--%>
    <%--$(function () {--%>
        <%--alert("asdflsfa");--%>
        <%--layer.msg('已发布', {icon:1,time:1000});--%>
        <%--layer.msg('已发布', {icon:2,time:1000});--%>
        <%--layer.msg('已发布', {icon:3,time:1000});--%>
        <%--layer.msg('已发布', {icon:4,time:1000});--%>
        <%--layer.msg('已发布', {icon:5,time:1000});--%>
        <%--layer.msg('已发布', {icon:6,time:1000});--%>
        <%--layer.msg('已发布', {icon:7,time:1000});--%>
        <%----%>
    <%--});--%>

<%--</script>--%>
<script>
    $("#btn_add").click(function(){
        location.href="<%=path%>/mailModule/addMail";
    });

</script>
</html>
