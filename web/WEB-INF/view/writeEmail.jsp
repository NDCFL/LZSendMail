<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-11-24
  Time: 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发邮件</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-sm-3">
            <div class="ibox float-e-margins">
                <div class="ibox-content mailbox-content">
                    <div class="file-manager">
                        <a class="btn btn-block btn-primary compose-mail">写 信</a>
                        <div class="space-25"></div>
                        <h5>邮件模版</h5>
                        <ul class="category-list" style="padding: 0">
                            <c:forEach items="${mailmod}" var="o">
                                <li>
                                    <a href="javascript:setMod(${o.id})"> <i class="fa fa-circle text-primary"></i> ${o.title}</a>
                                    <div style="display: none;"><div id="mtitle${o.id}">${o.title}</div>
                                        <div id="mcontent${o.id}">${o.content}</div>
                                        <div id="maccessoryPath${o.id}">${o.accessoryPath}</div>
                                        <div id="csend${o.id}">${o.csend}</div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        <h5 class="tag-title">经销商分类</h5>
                        <ul class="tag-list" style="padding: 0">
                            <c:forEach items="${tlist}" var="o">
                                <li><a href="javascript:setType('${o.email}')"><i class="fa fa-tag"></i> ${o.typename}</a>
                                </li>
                            </c:forEach>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-9 animated fadeInRight">
            <div class="mail-box">
                <div class="mail-body">
                    <form class="form-horizontal" method="post" id="form" onsubmit="return add();">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">收信人：</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="touser" value="${emailVo.srcsend}" id="touser">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">抄送人：</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" name="csend" value="${emailVo.csend}" id="csend">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">主题：</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="title" id="title" value="${emailVo.title}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">内容：</label>
                            <div  class="col-sm-10">
                                <textarea style="height:400px"  id="editor" name="content">${emailVo.content}</textarea>
                            </div>
                        </div>
                        <textarea id="updateFile" style="display: none" name="accessoryPath"></textarea>
                        <div class="mail-attachment">
                            <p>
                                <span><i class="fa fa-paperclip"></i> 附件 - (仅支持<b style="color:green;font-size: large">xls|xlsx|txt|doc|docx</b>)的格式文件</span>
                            </p>
                            <div class="attachment" id="info">

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
                        </div>
                        <div class="mail-body text-right tooltip-demo">
                            <button type="button"  class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="根据模版自动获取数据生成邮件"><i class="fa fa-save"></i> 自动生成</button>
                            <button type="button" onclick="add();" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="send email"><i class="fa fa-send"></i> 立即发送</button>
                        </div>
                </form>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
</div>
</div>
<script src="<%=path%>/js/jquery.min.js?v=2.1.4"></script>
<script src="<%=path%>/js/bootstrap.min.js?v=3.3.5"></script>
<script src="<%=path%>/js/plugins/validate/jquery.validate.min.js"></script>
<script src="<%=path%>/js/plugins/validate/messages_zh.min.js"></script>
<script src="<%=path%>/js/plugins/layer/layer.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=path%>/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=path%>/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="<%=path%>/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="application/javascript">
    var ue = UE.getEditor('editor');
</script>
<script type="text/javascript" src="<%=path%>/layui/layui.all.js" charset="utf-8"></script>
</body>
<script type="text/javascript">

    function setType(email) {
        var touser = $("#touser").val();
        if(touser==""){
            if(touser.indexOf(email)!=-1){
                layer.msg("所选经销商类别已存在!", {icon:2,time:1000});
            }else{
                $("#touser").val(email);
            }
        }else{
            if(touser.indexOf(email)!=-1){
                layer.msg("所选经销商类别已存在!", {icon:2,time:1000});
            }else {
                $("#touser").val(touser + ";" + email);
            }
        }

    }
    function setMod(id){
        $("#title").val($("#mtitle"+id).html());
        $("#csend").val($("#csend"+id).html());
        ue.setContent($("#mcontent"+id).html());
        var srcInfo = $("#maccessoryPath"+id).html();
        var srcPathInfo = new Array();
        var endPathInfo = new Array();
        srcPathInfo = srcInfo.split(";");
        for(var i=0;i<srcPathInfo.length;i++){
            if(srcPathInfo[i]!=""){
                endPathInfo[i] = srcPathInfo[i].substring(srcPathInfo[i].lastIndexOf("/")+1,srcPathInfo[i].length);
            }
        }
        var infoHtml ='';
        for(var j=0;j<endPathInfo.length;j++){
            if(endPathInfo[j]!=""){
                if(endPathInfo[j].substring(endPathInfo[j].indexOf(".")+1,endPathInfo[j].length)=="xls" || endPathInfo[j].substring(endPathInfo[j].indexOf(".")+1,endPathInfo[j].length)=="xlsx"){
                    infoHtml+='<div class="file-box" id="'+endPathInfo[j]+'"><input type="hidden" value="/upload/'+endPathInfo[j]+'"/><div class="file"><a href="<%=path%>/upload/'+endPathInfo[j]+'"><span class="corner"></span><div class="icon"><i class="fa fa-file-excel-o" style="color:#0c804e"></i></div><div class="file-name">'+endPathInfo[j]+'</div></a></div><a onclick="javascript:if(confirm(\'删除确认\')){$(this).parent(\'div\').remove();}else{return false;}" style="color:red;">删除附件</a></div>';
                }else if(endPathInfo[j].substring(endPathInfo[j].indexOf(".")+1,endPathInfo[j].length)=="doc" || endPathInfo[j].substring(endPathInfo[j].indexOf(".")+1,endPathInfo[j].length)=="docs"){
                    infoHtml+='<div class="file-box" id="'+endPathInfo[j]+'"><input type="hidden" value="/upload/'+endPathInfo[j]+'"/><div class="file"><a href="<%=path%>/upload/'+endPathInfo[j]+'"><span class="corner"></span><div class="icon"><i class="fa fa-file-word-o" style="color:#0df1e9"></i></div><div class="file-name">'+endPathInfo[j]+'</div></a></div><a onclick="javascript:if(confirm(\'删除确认\')){$(this).parent(\'div\').remove();}else{return false;}" style="color:red;">删除附件</a></div>';
                }else{
                    infoHtml+='<div class="file-box" id="'+endPathInfo[j]+'"><input type="hidden" value="/upload/'+endPathInfo[j]+'"/><div class="file"><a href="<%=path%>/upload/'+endPathInfo[j]+'"><span class="corner"></span><div class="icon"><i class="fa fa-file-text-o" style="color:#1357ff"></i></div><div class="file-name">'+endPathInfo[j]+'</div></a></div><a onclick="javascript:if(confirm(\'删除确认\')){$(this).parent(\'div\').remove();}else{return false;}" style="color:red;">删除附件</a></div>';
                }
            }
        }
        infoHtml+="<div class=\"clearfix\"></div>";
        $("#info").html(infoHtml);
    }
    function add(){
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
            "<%=path%>/mail/send",
            $("#form").serialize(),
            function(data) {
                if(data.message.indexOf("成功")>0)
                    layer.msg(data.message, {icon:1,time:1000});
                else
                    layer.msg(data.message, {icon:2,time:1000});
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
            ,exts: 'xls|xlsx|txt|doc|docx'
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