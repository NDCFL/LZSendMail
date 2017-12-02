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
    <title>用户列表</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5>用户列表</h5>
        </div>
        <div class="ibox-content">
            <div class="panel panel-default">
                <div class="panel-heading">
                    用户列表
                </div>
                <table id="mytab" name="mytab" class="table table-hover"></table>
                <div id="toolbar" class="btn-group pull-right" style="margin-right: 20px;">
                    <button id="btn_delete" onclick="deleteMany();" type="button" class="btn btn-default" style="display: block;">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true" ></span>批量删除
                    </button>
                    <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal" data-target="#webAdd">
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
                    新增用户
                </h4>
            </div>
            <form class="form-horizontal" method="post" id="formadd">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户账号：</label>
                        <div class="col-sm-8">
                            <input  name="loginAcc" minlength="2" maxlength="20" type="text" class="form-control" required="" aria-required="true">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户密码：</label>
                        <div class="col-sm-8">
                            <input  name="loginPassword" minlength="2" maxlength="20" type="password" class="form-control" required="" aria-required="true">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="submit" id="add" class="btn btn-primary" >
                        确认新增
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<input type="hidden" value=""  id="deleteId"/>
<%--网站新增结束--%>
<jsp:include page="comment/modulejs.jsp"></jsp:include>
<script src="<%=path%>/js/pageJs/userList.js"></script>
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
    $('#formadd').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            loginAcc: {
                message: '用户登录账号验证失败',
                validators: {
                    notEmpty: {
                        message: '用户登录账号不能为空'
                    },
                    threshold: 6,
                    remote: {
                        url: '<%=path%>/user/checkReg',
                        message: '账号已存在',
                        delay :  2000,
                        type: 'POST'
                    }
                }
            },password: {
                message: '用户登录密码验证失败',
                validators: {
                    notEmpty: {
                        message: '用户登录密码不能为空'
                    },
                    stringLength: {
                        min: 6,
                        max: 18,
                        message: '用户登录密码长度必须在6到18位之间'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: '用户登录密码只能包含大写、小写、数字和下划线'
                    }
                }
            }
        }
    }).on('success.form.bv', function(e) {//点击提交之后
        var $form = $(e.target);
        var bv = $form.data('bootstrapValidator');
        $.post(
            "/user/userAddSave",
            $("#formadd").serialize(),
            function(data){
                if(data.message=="新增成功!"){
                    layer.msg(data.message, {icon:1,time:1000});
                }else{
                    layer.msg(data.message, {icon:1,time:1000});
                }
                refush();
                $("#webAdd").modal('hide');
            },"json"
        );
    });
</script>
</html>
