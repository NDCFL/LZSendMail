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
    <title>发件箱列表</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5>发件箱列表</h5>
        </div>
        <div class="ibox-content">
            <div class="panel panel-default">
                <div class="panel-heading">
                    发件箱列表
                </div>
                <table id="mytab" name="mytab" class="table table-hover"></table>
                <div id="toolbar" class="btn-group pull-right" style="margin-right: 20px;">
                    <button id="btn_delete" onclick="deleteMany();" type="button" class="btn btn-default" style="display: block;">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true" ></span>批量删除
                    </button>
                    <a  onclick="location.href='<%=path%>/mail/sendPage'"  class="J_menuItem btn btn-default" >
                        <span class="glyphicon glyphicon-plus" aria-hidden="true" ></span>写信
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" value=""  id="deleteId"/>
<jsp:include page="comment/modulejs.jsp"></jsp:include>
<script>
    var status ="0,1";
</script>
<script src="<%=path%>/js/pageJs/emailList.js"></script>
</body>
</html>
