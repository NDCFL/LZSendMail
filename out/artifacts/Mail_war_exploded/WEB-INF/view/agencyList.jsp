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
    <title>经销商列表</title>
    <jsp:include page="comment/modulecss.jsp"></jsp:include>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5>经销商列表</h5>
        </div>
        <div class="ibox-content">
            <div class="panel panel-default">
                <div class="panel-heading">
                    经销商列表
                </div>
                <table id="mytab" name="mytab" class="table table-hover"></table>
                <div id="toolbar" class="btn-group pull-right" style="margin-right: 20px;">
                    <button id="btn_delete" onclick="deleteMany();" type="button" class="btn btn-default" style="display: block;">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true" ></span>批量删除
                    </button>
                    <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal" data-target="#webAdd">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true" ></span>新增
                    </button>
                    <button id="btn_daoru" type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true" ></span>导入数据
                    </button>
                    <a id="load"  href="<%=path%>/upload/agency.xlsx" class="btn btn-success">下载模板</a>
                </div>
            </div>
        </div>
    </div>
</div>
<%--网站数据的新增--%>
<!-- 模态框（Modal） -->
<div class="modal fade" id="webAdd" tabindex="-1" role="dialog" aria-labelledby="webAddLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="webAddTitle">
                    新增经销商
                </h4>
            </div>
            <form class="form-horizontal" method="post" id="formadd">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">所属公司：</label>
                        <div class="col-sm-8">
                            <input  name="companyName" id="companyName1" minlength="2" maxlength="20" type="text" class="form-control" required="" aria-required="true">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">负责人：</label>
                        <div class="col-sm-8">
                            <input  name="leader" id="leader1" minlength="2" maxlength="20" type="text" class="form-control" required="" aria-required="true">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">经销商邮箱：</label>
                        <div class="col-sm-8">
                            <input  name="emailAcc" id="emailAcc1" minlength="2" maxlength="20" type="email" class="form-control" required="" aria-required="true">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">客户分类ID：</label>
                        <div class="col-sm-8">
                            <input  name="type" id="type1" minlength="2" maxlength="20" type="email" class="form-control"  required="" aria-required="true">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" id="add" class="btn btn-primary" >
                        确认新增
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="webupdate" tabindex="-1" role="dialog" aria-labelledby="webAddLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="webAddTitle1">
                    修改经销商
                </h4>
            </div>
            <form class="form-horizontal" method="post" id="formupdate">
                <input type="hidden" name="id" id="id" />
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">所属公司：</label>
                        <div class="col-sm-8">
                            <input  name="companyName" id="companyName" minlength="2" maxlength="20" type="text" class="form-control" required="" aria-required="true">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">负责人：</label>
                        <div class="col-sm-8">
                            <input  name="leader" id="leader" minlength="2" maxlength="20" type="text"   class="form-control" required="" aria-required="true">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">经销商邮箱：</label>
                        <div class="col-sm-8">
                            <input  name="emailAcc" id="emailAcc" minlength="2" maxlength="20" type="email" class="form-control"  required="" aria-required="true">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">客户分类ID：</label>
                        <div class="col-sm-8">
                            <input  name="type" id="type" minlength="2" maxlength="20" type="email" class="form-control"  required="" aria-required="true">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" id="updateAgency" class="btn btn-primary">
                        确认修改
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<input type="hidden" value=""  id="deleteId"/>
<%--网站新增结束--%>
<%--经销商的修改--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    导入数据
                </h4>
            </div>
            <form class="form-horizontal" id="updateform" >
                <input type="hidden" id="path" name="path" value=""/>
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
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" id="update" class="btn btn-primary" data-dismiss="modal">
                        确认导入
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<input type="hidden" id="deleteId" value=""  />
<%--经销商的修改--%>
<jsp:include page="comment/modulejs.jsp"></jsp:include>
<script src="<%=path%>/js/pageJs/agencyList.js"></script>
<script type="text/javascript" src="<%=path%>/layui/layui.all.js" charset="utf-8"></script>
</body>
<%--<script>--%>
    <%--$(function () {--%>
        <%--alert("asdflsfa");--%>
        <%--layer.msg('已发布', {icon:1,time:1000});--%>
        <%--layer.msg('已发布', {icon:2,time:1000});--%>
        <%--layer.msg('已发布', {icon:3,time:1000});--%>
        <%--layer.msg('已发布', {icon:4,time:1000});--%>
        <%--layer.msg('已发布', {icon:5,time:1000});--%>
        <%--layer.msg('已发布', {icon:6,time:1000});--%>
        <%--layer.msg('已发布', {icon:7,time:1000});--%>
        <%----%>
    <%--});--%>

<%--</script>--%>
<script>
    layui.use('upload', function(){
        var files="";
        var $ = layui.jquery
            ,upload = layui.upload;
        //多文件列表示例
        var demoListView = $('#demoList')
            ,uploadListIns = upload.render({
            elem: '#testList'
            ,url: '/agency/upload'
            ,accept: 'file'
            ,exts: 'xls|xlsx'
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
                            "<%=path%>/agency/delete",
                            {
                                "path":$("#"+index).val()
                            },function (data) {
                                if(data.message.indexOf("成功")){
                                    layer.msg(data.message, {icon:1,time:1000});
                                }else{
                                    layer.msg(data.message, {icon:2,time:1000});
                                }
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
                tds.eq(3).html('<button class="layui-btn layui-btn-mini layui-btn-danger demo-delete">删除</button>'); //显示重传
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
<script>
    $("#update").click(function(){
        var path = "";
        $("input[name='file']").each(function(){
            if($(this).val()!=""){
                path +=$(this).val()+";";
            }
        });
        $("#path").val(path);
        $.post(
            "/agency/daoru",
            $("#updateform").serialize(),
            function(data){
                if(data.message=="导入成功!"){
                    layer.msg(data.message, {icon:1,time:1000});
                    refush();
                }else{
                    layer.msg(data.message, {icon:2,time:1000});
                    refush();
                }
            },"json"
        );
    });
</script>
</html>
