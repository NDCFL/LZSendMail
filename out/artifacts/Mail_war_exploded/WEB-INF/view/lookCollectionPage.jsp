<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-11-24
  Time: 10:28
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
    <title>丽珠邮件系统查看邮件</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
    <form id="form">
        <div class="row">
            <div class="col-sm-12 animated fadeInRight">
                <div class="mail-box-header">
                    <div class="pull-right tooltip-demo">
                        <c:if test="${email.status==0}">
                            <a href="<%=path%>/mail/sendPage/${email.id}" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="回复"><i class="fa fa-reply"></i> 回复</a>
                            <a class="btn btn-sm btn-white" onclick="update(${email.id});"><i class="glyphicon glyphicon-ok" style="color:green"></i> 审核</a>
                        </c:if>
                    </div>
                    <h2>
                        ${email.title}
                        <input type="hidden" name="title" value="${email.title}">
                    </h2>
                    <div class="mail-tools tooltip-demo m-t-md">
                        <h5>
                            <span class="pull-right font-noraml"><fmt:formatDate value="${email.createTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate></span>
                            <span class="font-noraml">发件人： </span>${email.srcsend}<br/>
                            <span class="font-noraml">收件人： </span>${email.endsend}
                            <input type="hidden" name="touser" value="${email.endsend}">
                            <input type="hidden" name="type" value="-1">
                        </h5>
                    </div>
                </div>
                <div class="mail-box">
                    <div class="mail-body">
                        ${email.content}
                        <textarea style="display: none" name="content">${email.content}</textarea>
                    </div>
                    <c:if test="${not empty email.fileName}">
                    <div class="mail-attachment">
                        <p>
                            <span><i class="fa fa-paperclip"></i> ${email.size} 个附件 - </span>
                        </p>
                            <c:forEach items="${email.fileName}" var="f">
                                <div class="attachment">
                                    <div class="file-box">
                                        <div class="file">
                                            <input type="hidden" value="/${f}">
                                            <a href="<%=path%>/${f}">
                                                <span class="corner"></span>
                                                <div class="icon">
                                                    <i class="fa fa-file"></i>
                                                </div>
                                                <div class="file-name">
                                                    ${f}
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                            </c:forEach>
                            <div class="clearfix"></div>
                        </div>
                    </div></c:if>
                    <div class="mail-body text-right tooltip-demo">
                        <c:if test="${email.status==0}">
                            <a class="btn btn-sm btn-white" href="<%=path%>/mail/sendPage/${email.id}"><i class="fa fa-reply"></i> 回复</a>
                            <a class="btn btn-sm btn-white" onclick="update(${email.id});"><i class="glyphicon glyphicon-ok" style="color:green"></i> 审核</a>
                        </c:if>
                     </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <textarea id="updateFile"  style="display: none" name="accessoryPath"></textarea>
    </form>
</div>
<jsp:include page="comment/modulejs.jsp"></jsp:include>
<script type="text/javascript" src="<%=path%>/layui/layui.all.js"></script>
<script>
    function update(id) {
        layer.alert('',{
            icon:1,title:'审核确认',content:'您确定要审核这封邮件吗？',closeBtn:1},function(index){
            $.post(
                "<%=path%>/mail/update/"+id,
                function(data){
                    if(data.message=="审核通过!"){
                        layer.msg(data.message, {icon:1,time:1000});
                        var path = "";
                        $(".attachment input ").each(function(){
                            if($(this).val()!=""){
                                path +=$(this).val()+";";
                            }
                        });
                        $("#updateFile").html(path);
                        $.post(
                            "<%=path%>/mail/send",
                            $("#form").serialize(),
                            function(data) {
                                if(data.message.indexOf("成功")>0) {
                                    layer.confirm('邮件发送提醒', {icon: 1, title:data.message}, function(index){
                                        location.href = "/email/lookCollection/" + id;
                                        layer.close(index);
                                    });
                                }
                                else
                                    layer.msg(data.message, {icon:2,time:1000});
                            },
                            "json"
                        );
                    }
                },"json"
            );
            layer.close(index);
        });

    }
</script>
</body>
</html>
