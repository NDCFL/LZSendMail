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
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
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
                            <span class="font-noraml">收件人： </span>${email.endsend}<br/>
                            <c:if test="${email.csend!='' and email.csend!=null}">
                                <span class="font-noraml">抄送人： </span>${email.csend}
                            </c:if>
                            <input type="hidden" name="touser" value="${email.endsend}">
                            <input type="hidden" name="type" value="-1">
                            <input type="hidden" name="csend" value="${email.csend}">
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
                            <span><i class="fa fa-paperclip"></i>附件详情</span>
                        </p>
                            <c:forEach items="${email.fileName}" var="f">
                                <c:if test="${f!=''}">
                                    <div class="attachment">
                                        <div class="file-box">
                                            <div class="file">
                                                <input type="hidden" value="${f}">
                                                <a href="<%=path%>${f}">
                                                    <span class="corner"></span>
                                                    <div class="icon">
                                                        <c:if test="${f.substring(f.indexOf('.')+1,f.length())=='doc' || f.substring(f.indexOf('.')+1,f.length())=='docx'}">
                                                            <i class="fa fa-file-word-o" style="color:#0df1e9"></i>
                                                        </c:if>
                                                        <c:if test="${f.substring(f.indexOf('.')+1,f.length())=='xlsx' ||f.substring(f.indexOf('.')+1,f.length())=='xls'}">
                                                            <i class="fa fa-file-excel-o" style="color:#0c804e"></i>
                                                        </c:if>
                                                        <c:if test="${f.substring(f.indexOf('.')+1,f.length())=='txt'}">
                                                            <i class="fa fa-file-text-o" style="color:#1357ff"></i>
                                                        </c:if>
                                                        <c:if test="${f.substring(f.indexOf('.')+1,f.length())=='xml'}">
                                                            <i class="fa fa-file-text-o" style="color:#1357ff"></i>
                                                        </c:if>
                                                    </div>
                                                    <div class="file-name">
                                                            ${f.substring(f.lastIndexOf('/')+1)}
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                </c:if>
                            </c:forEach>
                            <div class="clearfix"></div>
                        </div>
                    </div></c:if>
                    <div class="mail-body text-right tooltip-demo">
                        <c:if test="${email.status==0}">
                            <a class="btn btn-sm btn-white" href="<%=path%>/mail/sendPage/${email.id}"><i class="fa fa-reply"></i> 回复</a>
                            <a class="btn btn-sm btn-white" onclick="update();"><i class="glyphicon glyphicon-ok" style="color:green"></i> 审核</a>
                        </c:if>
                     </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <textarea id="updateFile"  style="display: none" name="accessoryPath"></textarea>
        <input type="hidden" id="id" name="id" value="${email.id}" />
    </form>
</div>
<jsp:include page="comment/modulejs.jsp"></jsp:include>
<script type="text/javascript" src="<%=path%>/layui/layui.all.js"></script>
<script>
    function update() {
        layer.alert('',{
            icon:1,title:'审核确认|并发送',content:'您确定要审核这封邮件吗，审核通过即刻发送邮箱？',closeBtn:1},function(index){
            $.post(
                "<%=path%>/mail/send",
                $("#form").serialize(),
                function(data) {
                    if(data.message.indexOf("成功")>0) {
                        layer.alert(data.message, function(){
                            location.href = "/email/lookCollection/" + $("#id").val();
                        });
                    }
                    else
                        layer.msg(data.message, {icon:2,time:1000});
                },
                "json"
            );
            layer.close(index);
        });

    }
</script>
</body>
</html>
