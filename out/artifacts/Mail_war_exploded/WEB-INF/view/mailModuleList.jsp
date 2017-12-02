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
<input type="hidden" value=""  id="deleteId"/>
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
