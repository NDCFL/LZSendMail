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
    <title>个人资料</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>个人资料 </h5>
                </div>
                <div class="ibox-content">
                    <form method="post" id="form" role="form" class="form-horizontal">
                        <input type="hidden" class="form-control" id="id" name="id">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">发信昵称</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control"  required id="nickname" name="nickname">
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">邮箱账号</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control"  required id="email" name="email">
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">邮箱密码</label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control"  required id="password" name="password">
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">发件邮箱服务器</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" required name="serverHost" id="serverHost">
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">发件邮箱服务器端口</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" required name="serverPort" id="serverPort">
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">收件邮箱服务器</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" required name="inserverHost" id="inserverHost">
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">收件邮箱服务器端口</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" required name="inserverPort" id="inserverPort">
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <div class="col-sm-4 col-sm-offset-2">
                                <button class="btn btn-primary" id="bt" type="button">修改</button>
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
    $("#bt").click(function(){
        $.post(
            "<%=path%>/user/userUpdateSave",
            $("#form").serialize(),
            function(data){
                if(data.message=="修改成功!"){
                    layer.msg(data.message, {icon:1,time:1000});
                }else{
                    layer.msg(data.message, {icon:2,time:1000});
                }
                refush();
            },"json"
        );
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
</body>

</html>