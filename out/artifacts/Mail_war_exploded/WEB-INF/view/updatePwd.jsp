<%--
  Created by IntelliJ IDEA.
  User: chenfeilong
  Date: 2017/10/28
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改密码</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>修改密码 <small>丽珠试剂版权所有</small></h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a class="dropdown-toggle" data-toggle="dropdown" href="form_basic.html#">
                            <i class="fa fa-wrench"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li><a href="form_basic.html#">选项1</a>
                            </li>
                            <li><a href="form_basic.html#">选项2</a>
                            </li>
                        </ul>
                        <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content">
                    <form method="post" id="form" role="form" class="form-horizontal">
                        <input type="hidden" class="form-control" value="${id}" name="id">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">登录账号</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" readonly="readonly" id="loginAcc"  required value="${userVo.loginAcc}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">登录旧密码</label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" placeholder="请输入登录旧密码"  required  name="oldpwd">
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">登录新密码</label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" placeholder="请输入登录新密码" id="newPwd"  required name="newPwd" >
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">确认登录密码</label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" placeholder="请输入确认登录密码" required name="qnew" >
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <div class="col-sm-4 col-sm-offset-2">
                                <button class="btn btn-primary"  type="submit">修改</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="comment/modulejs.jsp"></jsp:include>

<script>
    $(function() {
        refush();
    });
</script>
<script>
    function refush(){
        $.post("<%=path%>/user/myInfo",
            function (data) {
                $("#form").autofill(data);
            },
            "json"
        );
    }
</script>
<script>
    $('#form1').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            newEmailPwd: {
                message: '服务器邮箱登录新密码验证失败',
                validators: {
                    notEmpty: {
                        message: '服务器邮箱登录新密码不能为空'
                    },
                    stringLength: {
                        min: 6,
                        max: 18,
                        message: '服务器邮箱登录新密码长度必须在6到18位之间'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: '密码只能包含大写、小写、数字和下划线'
                    }

                }
            },
            emailPwd: {
                message: '服务器邮箱登录确认密码验证失败',
                validators: {
                    notEmpty: {
                        message: '服务器邮箱登录确认密码不能为空'
                    },
                    stringLength: {
                        min: 6,
                        max: 18,
                        message: '服务器邮箱登录确认密码长度必须在6到18位之间'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: '服务器邮箱登录确认密码只能包含大写、小写、数字和下划线'
                    },
                    identical: {
                        field: 'newEmailPwd',
                        message: '服务器邮箱登录确认密码和确认密码不一致'
                    }

                }
            }
        }
    }).on('success.form.bv', function(e) {//点击提交之后
        e.preventDefault();
        $.post(
            "<%=path%>/user/updateEmilPwd",
            {
                "newEmailPwd":$("#newEmailPwd").val()
            },
            function(data) {
                if(data.message=="修改服务器邮箱登录密码成功!"){
                    layer.msg(data.message, {icon:1,time:1000});
                }else{
                    layer.msg(data.message, {icon:2,time:1000});
                }
            },
            "json"
        );
    });
</script>
<script>
    $('#form').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            oldpwd: {
                message: '旧密码验证失败',
                validators: {
                    notEmpty: {
                        message: '旧密码不能为空'
                    },
                    stringLength: {
                        min: 6,
                        max: 18,
                        message: '密码长度必须在6到18位之间'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: '密码只能包含大写、小写、数字和下划线'
                    },
                    threshold: 6,
                    remote: {
                        url: '/user/checkPwd',
                        message: '旧密码输入错误!',
                        delay: 2000,
                        type: 'POST'
                    }

                }
            },
            newPwd: {
                message: '新密码验证失败',
                validators: {
                    notEmpty: {
                        message: '新密码不能为空'
                    },
                    stringLength: {
                        min: 6,
                        max: 18,
                        message: '新密码长度必须在6到18位之间'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: '密码只能包含大写、小写、数字和下划线'
                    }

                }
            },
            qnew: {
                message: '确认密码验证失败',
                validators: {
                    notEmpty: {
                        message: '确认密码不能为空'
                    },
                    stringLength: {
                        min: 6,
                        max: 18,
                        message: '确认密码长度必须在6到18位之间'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: '密码只能包含大写、小写、数字和下划线'
                    },
                    identical: {
                        field: 'newPwd',
                        message: '新密码和确认密码不一致'
                    }

                }
            }
        }
    }).on('success.form.bv', function(e) {//点击提交之后
        e.preventDefault();
        $.post(
            "<%=path%>/user/updatePwd",
            {
                "newPwd":$("#newPwd").val()
            },
            function(data) {
                if(data.message=="修改登录密码成功!"){
                    layer.msg(data.message, {icon:1,time:1000});
                }else{
                    layer.msg(data.message, {icon:2,time:1000});
                }
            },
            "json"
        );
    });
</script>
</body>
</html>