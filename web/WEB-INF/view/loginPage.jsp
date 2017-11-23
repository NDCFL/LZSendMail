<%--
  Created by IntelliJ IDEA.
  User: chenfeilong
  Date: 2017/10/26
  Time: 18:22
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
    <title>丽珠邮件系统后台登录</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
    <!--[if lt IE 8]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <script>if(window.top !== window.self){ window.top.location = window.location;}</script>
</head>
<body class="gray-bg">
<div class="middle-box text-center loginscreen  animated fadeInDown">
    <div>
        <div>
            <h1 class="logo-name">lz</h1>
        </div>
        <form class="m-t" role="form" id="form" action="<%=path%>/user/main" >
            <div class="form-group">
                <input type="text" class="form-control" id="loginAcc" name="loginAcc" placeholder="请输入账号" required="">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" id="loginPassword" name="loginPassword" placeholder="请输入登录密码" required="">
            </div>
            <button type="submit" id="" class="btn btn-primary block full-width m-b">登 录</button>
            <p class="text-muted text-center"> <a href="login.html#"><small>忘记密码了？</small></a>
            </p>
        </form>
    </div>
</div>
<jsp:include page="comment/modulejs.jsp"></jsp:include>
</body>
<script type="text/javascript">
    $(function () {
        $('form').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                loginAcc: {
                    message: '登录账号验证失败',
                    validators: {
                        notEmpty: {
                            message: '登录账号不能为空'
                        },
                        threshold: 6,
                        remote: {
                            url: '<%=path%>/user/checkAcc',
                            message: '账号不存在',
                            delay :  2000,
                            type: 'POST'
                        }
                    }
                },
                loginPassword: {
                    message: '密码验证失败',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
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
                            url: "<%=path%>/user/checkPassword",
                            data: function (validator) {
                                return {
                                    loginAcc: $("#loginAcc").val(),
                                    loginPassword: $("#loginPassword").val()
                                };

                            },
                            message: '密码输入错误！',
                            delay: 1000
                        }

                    }
                }
            }
        })
    }).on('success.form.bv', function(e) {//点击提交之后
        e.preventDefault();
        location.href="<%=path%>/user/main";
    });
</script>
<script>
    function check(){
        $.post(
            "<%=path%>/admin/login",
            $("#form").serialise(),
            function(data){
                alert(data.code);
//                if(data.message=="登录成功"){
//                    return true;
//                }else{
//                    return false;
//                }

            }
        );
    }

</script>
</html>