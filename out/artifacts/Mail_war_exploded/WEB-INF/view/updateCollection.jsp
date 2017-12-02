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
    <title>丽珠邮件系统- 模板的修改</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row">
        <jsp:include page="comment/variable.jsp"></jsp:include>
        <div class="col-sm-9 animated fadeInRight">
            <div class="mail-box-header">
                <h2>
                    模板修改
                </h2>
            </div>
            <div class="mail-box">
                <div class="mail-body">
                    <form class="form-horizontal" method="post" id="form" >
                        <input type="hidden" name="id" id="id" value="${mailModule.id}">

                        <div class="form-group">
                            <label class="col-sm-2 control-label">主题：</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="title" name="title" value="${mailModule.title}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">抄送人：</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="csend" name="csend" value="${mailModule.csend}">
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
                                <span><i class="fa fa-paperclip"></i>附件列表(仅支持<b style="color:green;font-size: large">xls|xlsx|txt|doc|docx|xml</b>)的格式文件，xml为模版文件，系统会自动转成Excel文件</span>
                            </p>
                            <div class="attachment" >
                                <c:if test="${listFile!=null}">
                                    <c:forEach items="${listFile}" var="l" varStatus="lf">
                                        <div class="file-box" id="${lf.index}">
                                            <input type="hidden" value="${l}">
                                            <div class="file">
                                                <a href='<%=path%>/upload/<c:if test="${l.substring(l.indexOf('.')+1,l.length())=='xml'}">template/</c:if>${l}'>
                                                    <span class="corner"></span>
                                                    <div class="icon">
                                                        <c:if test="${l.substring(l.indexOf('.')+1,l.length())=='doc' || l.substring(l.indexOf('.')+1,l.length())=='docx'}">
                                                            <i class="fa fa-file-word-o" style="color:#0df1e9"></i>
                                                        </c:if>
                                                        <c:if test="${l.substring(l.indexOf('.')+1,l.length())=='xlsx' ||l.substring(l.indexOf('.')+1,l.length())=='xls'}">
                                                            <i class="fa fa-file-excel-o" style="color:#0c804e"></i>
                                                        </c:if>
                                                        <c:if test="${l.substring(l.indexOf('.')+1,l.length())=='txt' ||l.substring(l.indexOf('.')+1,l.length())=='xml'}">
                                                            <i class="fa fa-file-text-o" style="color:#1357ff"></i>
                                                        </c:if>
                                                    </div>
                                                    <div class="file-name">
                                                            ${l}
                                                    </div>
                                                </a>
                                            </div>
                                            <a onclick="javascript:if(confirm('删除确认')){$(this).parent('div').remove();}else{return false;}" style="color:red;">删除附件</a>
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
<script>
    function update(){
        if($("#title").val()==""){
            layer.msg('模板主题不能为空！', {icon:2,time:1000});
            return;
        }
        if(ue.getContentTxt()==""){
            layer.msg('内容不能为空！', {icon:2,time:1000});
            return;
        }
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
            ,exts: 'xls|xlsx|txt|doc|docx|xml'
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