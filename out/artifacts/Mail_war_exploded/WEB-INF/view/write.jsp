<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-11-24
  Time: 10:31
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
    <title>H+ 后台主题UI框架 - 写信</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-sm-9 animated fadeInRight">
            <div class="mail-box-header">
                <div class="pull-right tooltip-demo">
                    <a href="mailbox.html" class="btn btn-danger btn-sm" data-toggle="tooltip" data-placement="top" title="放弃"><i class="fa fa-times"></i> 放弃</a>
                </div>
                <h2>
                    写信
                </h2>
            </div>
            <div class="mail-box">
                <div class="mail-body">
                    <form class="form-horizontal" method="post" id="form" onsubmit="add();">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">主题：</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="title" value="">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">内容：</label>
                            <div  class="col-sm-10">
                                <textarea style="height:400px"  id="editor" name="content"></textarea>
                            </div>
                        </div>
                        <div class="mail-attachment">
                            <p>
                                <span><i class="fa fa-paperclip"></i> 附件 - </span>
                                <a onclick="upFiles();">上传附件</a>
                            </p>
                            <div id="fileinfo">

                            </div>
                        </div>
                        <textarea id="file" style="display: none" name="accessoryPath"></textarea>
                        <div class="mail-body text-right tooltip-demo">
                            <button type="submit" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="Send"><i class="fa fa-reply"></i> 提交审核</button>
                            <button type="button" href="mailbox.html" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Discard email"><i class="fa fa-times"></i> 放弃</button>
                            <button type="button" href="mailbox.html" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Move to draft folder"><i class="fa fa-pencil"></i> 存为草稿</button>
                        </div>
                    </form>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>
<textarea id="uploadFile" style="display: block" onchange="getFileInfo();"></textarea>
<jsp:include page="comment/modulejs.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="<%=path%>/js/webuploader.min.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=path%>/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=path%>/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="<%=path%>/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="application/javascript">
    var ue = UE.getEditor('editor');
</script>
<script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
</body>
<script type="text/javascript">
    var _editor = UE.getEditor("uploadFile",{
        initialFrameWidth:800,
        initialFrameHeight:300,
    });

    //弹出文件上传的对话框
    function upFiles() {
        var myFiles = _editor.getDialog("attachment");
        myFiles.open();

    }
    function getFileInfo() {
        $("#fileinfo").html(_editor.getContent());
        $("#file").html( _editor.getContent());
    }
    setInterval("getFileInfo()","500");
</script>
<script>
    function add(){
        $.post(
            "<%=path%>/mailModule/mailModuleAddSave",
            $("#form").serialize(),
            function(data){
                if(data.message=="新增成功!"){
                    layer.msg(data.message, {icon:1,time:1000});
                    location.href="<%=path%>/mailModule/mailModulePage";
                    return;
                }else{
                    layer.msg(data.message, {icon:2,time:1000});
                    return ;
                }
            },
            "json"
        );
    }
</script>
</html>