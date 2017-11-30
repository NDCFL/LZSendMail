<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>丽珠邮件系统- 写信</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-sm-12 animated fadeInRight">
            <div class="mail-box-header">
                <h2>
                    写信
                </h2>
            </div>
            <div class="mail-box">
                <div class="mail-body">
                    <form class="form-horizontal" method="post" id="form" >
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
                        <textarea id="updateFile" style="display: none" name="updateFile"></textarea>
                        <div class="mail-attachment">
                            <p>
                                <span><i class="fa fa-paperclip"></i>附件列表(仅支持<b style="color:green;font-size: large">xls|xlsx|txt|doc|docs</b>)的格式文件</span>
                            </p>
                            <div class="attachment" >
                                <c:if test="${listFile!=null}">
                                    <c:forEach items="${listFile}" var="l" varStatus="lf">
                                        <div class="file-box" id="${lf.index}">
                                            <input type="hidden" value="${l}">
                                            <div class="file">
                                                <a href="<%=path%>/upload/${l}">
                                                    <span class="corner"></span>
                                                    <div class="icon">
                                                        <i class="fa fa-file"></i>
                                                    </div>
                                                    <div class="file-name">
                                                            ${l}
                                                    </div>
                                                </a>
                                            </div>
                                            <a onclick="$(this).parent('div').remove()" style="color:red;">删除附件</a>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="layui-upload-list">
                            <table class="layui-table">
                                <thead>
                                <tr><th>文件名</th>
                                    <th>大小</th>
                                    <th>状态</th>
                                    <th>操作</th>
                                </tr></thead>
                                <tbody id="demoList"></tbody>
                            </table>
                        </div>
                        <button type="button" class="layui-btn layui-btn-radius" id="testList">选择附件</button>
                        <button type="button"  class="layui-btn layui-btn-normal layui-btn-radius" id="testListAction">开始上传</button>
                        <div class="mail-body text-right tooltip-demo">
                            <button type="button" onclick="update();" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title=""><i class="fa fa fa-save"></i> 提交修改</button>
                        </div>
                    </form>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>
<textarea id="uploadFile"  style="display: none" onchange="getFileInfo();">${mailModule.accessoryPath}</textarea>
<jsp:include page="comment/modulejs.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="<%=path%>/js/webuploader.min.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=path%>/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=path%>/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="<%=path%>/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="application/javascript">
    var ue = UE.getEditor('editor');
</script>
<script type="text/javascript" src="<%=path%>/layui/layui.all.js" charset="utf-8"></script>
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
    function update(){
        var path = "";
        $(".attachment input ").each(function(){
            if($(this).val()!=""){
                path +=$(this).val()+";";
            }
        });
        var path1 = "";
        $("input[name='file']").each(function(){
            if($(this).val()!=""){
                path1 +=$(this).val()+";";
            }
        });
        $("#updateFile").html(path+path1);
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
<script>
    layui.use('upload', function(){
        var files="";
        var $ = layui.jquery
            ,upload = layui.upload;
        //多文件列表示例
        var demoListView = $('#demoList')
            ,uploadListIns = upload.render({
            elem: '#testList'
            ,url: '/mailModule/upload'
            ,accept: 'file'
            ,exts: 'xls|xlsx|txt|doc|docs'
            ,multiple: true
            ,auto: false
            ,bindAction: '#testListAction'
            ,choose: function(obj){
                files= obj.pushFile(); //将每次选择的文件追加到文件队列
                //读取本地文件
                obj.preview(function(index, file, result){
                    var tr = $(['<tr id="upload-'+ index +'">'
                        ,'<td>'+ file.name +'</td>'
                        ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
                        ,'<td>等待上传</td>'
                        ,'<td>'
                        ,'<button class="layui-btn layui-btn-mini demo-reload layui-hide">重传</button>'
                        ,'<button class="layui-btn layui-btn-mini layui-btn-danger demo-delete">删除</button>'
                        ,'</td>'
                        ,'</tr>'].join(''));

                    //单个重传
                    tr.find('.demo-reload').on('click', function(){
                        obj.upload(index, file);
                    });

                    //删除
                    tr.find('.demo-delete').on('click', function(){
                        delete files[index]; //删除对应的文件
                        tr.remove();
                    });

                    demoListView.append(tr);
                });
            }
            ,done: function(res, index, upload){
                if(res.code == 0){ //上传成功
                    var tr = demoListView.find('tr#upload-'+ index)
                        ,tds = tr.children();
                    tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                    tds.eq(3).html('<button class="layui-btn layui-btn-mini layui-btn-danger demo-delete">删除</button><input type="hidden" name="file" id="'+index+'" value="'+res.data.src+'"/>'); //清空操作
                    //删除
                    tr.find('.demo-delete').on('click', function(){
                        $.post(
                            "<%=path%>/mailModule/delete",
                            {
                                "path":$("#"+index).val()
                            },function (data) {
                                alert(data.message);
                            },"json"
                        );
                        delete files[index]; //删除对应的文件
                        tr.remove();
                    });
                    return;
                }
                this.error(index, upload);
            }
            ,error: function(index, upload){
                var tr = demoListView.find('tr#upload-'+ index)
                    ,tds = tr.children();
                tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
                tds.eq(3).html('<button class="layui-btn layui-btn-mini demo-reload">重传</button><button class="layui-btn layui-btn-mini layui-btn-danger demo-delete">删除</button>'); //显示重传
                //单个重传
                tr.find('.demo-reload').on('click', function(){
                    upload(index, file);
                });
                //删除
                tr.find('.demo-delete').on('click', function(){
                    delete files[index]; //删除对应的文件
                    tr.remove();
                });
            }
        });
    });
</script>
</html>