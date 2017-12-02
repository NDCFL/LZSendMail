<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加分类</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
    <link href="<%=path%>/css/plugins/iCheck/custom.css" rel="stylesheet">
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>添加分类 <small>丽珠版权所有</small></h5>
                </div>
                <div class="ibox-content">
                    <form method="get" class="form-horizontal" id="typeAdd">
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">分类名称</label>
                            <div class="col-sm-10">
                                <input type="text" placeholder="请填写分类名称" name="typename" id="typename" class="form-control" required>
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">经销商列表</label>

                            <div class="col-sm-10">
                                <c:forEach items="${agencyList}" var="a">
                                    <label class="checkbox-inline i-checks">
                                        <input type="checkbox" value="${a.id}" name="agency">${a.leader}</label>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <div class="col-sm-4 col-sm-offset-2">
                                <button class="btn btn-primary" type="button" id="bt">确认新增</button>
                                <button class="btn btn-white" type="reset">重置</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="comment/modulejs.jsp"></jsp:include>
<script src="<%=path%>/js/plugins/iCheck/icheck.min.js"></script>
<script>
    $(document).ready(function(){$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})});
</script>
</body>
<script>
    $("#bt").click(function(){
        if($("#typename").val()==""){
            layer.msg('经销商类别不能为空！', {icon:2,time:1000});
            return;
        }
        var chk_value =[];
        var agencyId="";
        $('input[name="agency"]:checked').each(function(){
            chk_value.push($(this).val());
        });
        if(chk_value.length==0){
            layer.msg('你还没有勾选经销商！', {icon:2,time:1000});
            return;
        }
        for(var i=0;i<chk_value.length;i++){
            if(i==(chk_value.length-1)){
                agencyId+=chk_value[i];
            }else{
                agencyId+=chk_value[i]+",";
            }
        }
        $.post(
            "<%=path%>/type/typeAddSave",
            {
                "typename":$("#typename").val(),
                "agentyId":agencyId
            },
            function(data){
                if(data.message=="新增成功!"){
                    layer.msg(data.message, {icon:1,time:1000});
                    location.href="<%=path%>/type/typePage";
                }else{
                    layer.msg(data.message, {icon:2,time:1000});
                }
            },"json"
        );
    });
</script>
</html>