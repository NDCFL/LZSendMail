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
        <div class="col-sm-3">
            <div class="ibox float-e-margins">
                <div class="ibox-content mailbox-content">
                    <div class="file-manager">
                        <a class="btn btn-block btn-primary compose-mail" href="mail_compose.html">写信</a>
                        <div class="space-25"></div>
                        <h5>文件夹</h5>
                        <ul class="folder-list m-b-md" style="padding: 0">
                            <li>
                                <a href="mailbox.html"> <i class="fa fa-inbox "></i> 收件箱 <span class="label label-warning pull-right">16</span>
                                </a>
                            </li>
                            <li>
                                <a href="mailbox.html"> <i class="fa fa-envelope-o"></i> 发信</a>
                            </li>
                            <li>
                                <a href="mailbox.html"> <i class="fa fa-certificate"></i> 重要</a>
                            </li>
                            <li>
                                <a href="mailbox.html"> <i class="fa fa-file-text-o"></i> 草稿 <span class="label label-danger pull-right">2</span>
                                </a>
                            </li>
                            <li>
                                <a href="mailbox.html"> <i class="fa fa-trash-o"></i> 垃圾箱</a>
                            </li>
                        </ul>
                        <h5>分类</h5>
                        <ul class="category-list" style="padding: 0">
                            <li>
                                <a href="mail_compose.html#"> <i class="fa fa-circle text-navy"></i> 工作</a>
                            </li>
                            <li>
                                <a href="mail_compose.html#"> <i class="fa fa-circle text-danger"></i> 文档</a>
                            </li>
                            <li>
                                <a href="mail_compose.html#"> <i class="fa fa-circle text-primary"></i> 社交</a>
                            </li>
                            <li>
                                <a href="mail_compose.html#"> <i class="fa fa-circle text-info"></i> 广告</a>
                            </li>
                            <li>
                                <a href="mail_compose.html#"> <i class="fa fa-circle text-warning"></i> 客户端</a>
                            </li>
                        </ul>

                        <h5 class="tag-title">标签</h5>
                        <ul class="tag-list" style="padding: 0">
                            <li><a href="mail_compose.html"><i class="fa fa-tag"></i> 朋友</a>
                            </li>
                            <li><a href="mail_compose.html"><i class="fa fa-tag"></i> 工作</a>
                            </li>
                            <li><a href="mail_compose.html"><i class="fa fa-tag"></i> 家庭</a>
                            </li>
                            <li><a href="mail_compose.html"><i class="fa fa-tag"></i> 孩子</a>
                            </li>
                            <li><a href="mail_compose.html"><i class="fa fa-tag"></i> 假期</a>
                            </li>
                            <li><a href="mail_compose.html"><i class="fa fa-tag"></i> 音乐</a>
                            </li>
                            <li><a href="mail_compose.html"><i class="fa fa-tag"></i> 照片</a>
                            </li>
                            <li><a href="mail_compose.html"><i class="fa fa-tag"></i> 电影</a>
                            </li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-9 animated fadeInRight">
            <div class="mail-box-header">
                <div class="pull-right tooltip-demo">
                    <a href="mailbox.html" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="存为草稿"><i class="fa fa-pencil"></i> 存为草稿</a>
                    <a href="mailbox.html" class="btn btn-danger btn-sm" data-toggle="tooltip" data-placement="top" title="放弃"><i class="fa fa-times"></i> 放弃</a>
                </div>
                <h2>
                    写信
                </h2>
            </div>
            <div class="mail-box">
                <div class="mail-body">
                    <form class="form-horizontal" method="post" id="form" onsubmit="update();">
                        <input type="hidden" name="id" id="id" value="${mailModule.id}">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">主题：</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="title" value="${mailModule.title}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">内容：</label>
                            <div  class="col-sm-10">
                                <textarea style="height:400px"  id="editor" name="content">${mailModule.content}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">原附件地址：</label>
                            <div class="col-sm-10">
                                <textarea type="text" class="form-control" >${mailModule.accessoryPath}</textarea>
                            </div>
                        </div>
                        <div class="mail-attachment">
                            <p>
                                <span><i class="fa fa-paperclip"></i> 附件 - </span>
                                <a onclick="upFiles();">上传附件</a>
                            </p>
                        </div>
                        <textarea id="file"  name="accessoryPath" style="display: none">${mailModule.accessoryPath}</textarea>
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
<textarea id="uploadFile"  style="display: none"></textarea>
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
    _editor.ready(function () {
        _editor.hide();
        _editor.addListener('afterUpfile', function (t, arg) {
            console.log(arg.length);
            var pathVal="";
            for(var i=0;i<arg.length;i++){
                pathVal+=arg[i].url+";";
            }
            $("#file").html( pathVal);
        })
    });
</script>
<script>
    function update(){
        $.post(
            "<%=path%>/mailModule/mailModuleUpdateSave",
            $("#form").serialize(),
            function(data){
              if(data.message=="修改成功!"){
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