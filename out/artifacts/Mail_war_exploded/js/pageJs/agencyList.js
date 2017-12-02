
//生成用户数据
$('#mytab').bootstrapTable({
    method: 'post',
    contentType: "application/x-www-form-urlencoded",//必须要有！！！！
    url:"/agency/agencyList",//要请求数据的文件路径
    toolbar: '#toolbar',//指定工具栏
    striped: true, //是否显示行间隔色
    dataField: "res",
    sortable: true, //是否启用排序 sortOrder: "ID asc",
    sortOrder: "ID asc",
    pagination:true,//是否分页
    queryParamsType:'limit',//查询参数组织方式
    queryParams:queryParams,//请求服务器时所传的参数
    sidePagination:'server',//指定服务器端分页
    pageNumber: 1, //初始化加载第一页，默认第一页
    pageSize:10,//单页记录数
    pageList:[10,20,30,40,50,60,70,80,90,100],//分页步进值
    showRefresh:true,//刷新按钮
    showColumns:true,
    clickToSelect: true,//是否启用点击选中行
    toolbarAlign:'right',//工具栏对齐方式
    buttonsAlign:'right',//按钮对齐方式
    toolbar:'#toolbar',//指定工作栏
    uniqueId: "id",                     //每一行的唯一标识，一般为主键列
    showExport: true,
    exportDataType: 'all',
    columns:[
        {
            title:'全选',
            field:'select',
            //复选框
            checkbox:true,
            width:25,
            align:'center',
            valign:'middle'
        },
        {
            title:'所属公司',
            field:'companyName',
            align:'center',
            sortable:true
        },
        {
            title:'负责人',
            field:'leader',
            align:'center',
            sortable:true
        }
        ,
        {
            title:'经销商邮箱',
            field:'emailAcc',
            align:'center',
            sortable:true
        }
        ,
        {
            title:'客户分类ID',
            field:'type',
            align:'center',
            sortable:true
        }
        ,
        {
            title:'操作',
            align:'center',
            field:'',
            formatter: function (value, row, index) {
                var e = '<a title="编辑" href="javascript:void(0);" id="agency"  data-toggle="modal" data-id="\'' + row.id + '\'" data-target="#webupdate" onclick="return edit(\'' + row.id + '\')"><i class="glyphicon glyphicon-pencil" alt="修改" style="color:green"></i></a> ';
                var d = '<a title="删除" href="javascript:void(0);" onclick="del('+row.id+','+row.status+')"><i class="glyphicon glyphicon-trash" alt="删除" style="color:red"></i></a> ';
                var f='';
                if(row.status==1){
                    f = '<a title="激活" href="javascript:void(0);" onclick="updatestatus('+row.id+','+0+')"><i class="glyphicon glyphicon-ok-sign" style="color:green"></i></a> ';
                }else if(row.status==0){
                    f = '<a title="冻结" href="javascript:void(0);" onclick="updatestatus('+row.id+','+1+')"><i class="glyphicon glyphicon-remove-sign"  style="color:red"></i></a> ';
                }
                return e+d;
            }
        }
    ],
    locale:'zh-CN',//中文支持,
    responseHandler:function(res){
        if (res) {
            return {
                "res" : res.rows,
                "total" : res.total
            };
        } else {
            return {
                "rows" : [],
                "total" : 0
            };
        }
    }
})

//请求服务数据时所传参数
function queryParams(params){
    return{
        //每页多少条数据
        pageSize: this.pageSize,
        //请求第几页
        pageIndex:this.pageNumber
    }
}
function del(agencyid,status){
    if(status==0){
        layer.msg("删除失败，已经激活的不允许删除!",{icon:2,time:1000});
        return;
    }
    layer.confirm('确认要删除吗？',function(index){
        $.ajax({
            type: 'POST',
            url: '/agency/deleteAgency/'+agencyid,
            dataType: 'json',
            success: function(data){
                if(data.message=='删除成功!'){
                    layer.msg(data.message,{icon:1,time:1000});
                }else{
                    layer.msg(data.message,{icon:2,time:1000});
                }
                refush();
            },
            error:function(data) {
                console.log(data.msg);
            },
        });
    });
}
function edit(name){
    $.post("/agency/findAgency/"+name,
        function(data){
            $("#webupdate").autofill(data);
        },
        "json"
    );
}
function updatestatus(id,status){
    $.post("/agency/updateStatus/"+id+"/"+status,
        function(data){
            if(status==0){
                if(data.message=="ok"){
                    layer.msg("已激活",{icon:1,time:1000});
                }else{
                    layer.msg("修改状态失败!",{icon:2,time:1000});
                }
            }else{
                if(data.message=="ok"){
                    layer.msg("已冻结",{icon:2,time:1000});
                }else{
                    layer.msg("修改状态失败!",{icon:2,time:1000});
                }
            }
            refush();
        },
        "json"
    );
}
//查询按钮事件
$('#updateAgency').click(function(){
    if($("#companyName").val()==""){
        layer.msg('所属公司不能为空！', {icon:2,time:1000});
        return;
    }
    if($("#leader").val()==""){
        layer.msg('负责人不能为空！', {icon:2,time:1000});
        return;
    }
    if($("#emailAc1").val()==""){
        layer.msg('经销商账号不能为空！', {icon:2,time:1000});
        return;
    }
    if($("#emailAcc").val().indexOf("@",".")==-1){
        layer.msg("经销商账号格式不正确", {icon:2,time:1500});
        return;
    }
    $.post("/agency/agencyUpdateSave",
        $("#formupdate").serialize(),
        function(data){
            if(data.message.indexOf("成功")){
                layer.msg(data.message,{icon:1,time:1000});
            }else{
                layer.msg(data.message,{icon:2,time:1000});
            }
            $("#webupdate").modal('hide');
            refush();
        },
        "json"
    );
})
//查询按钮事件
$('#search_btn').click(function(){
    $('#mytab').bootstrapTable('refresh', {url: '/agency/agencyList'});
})
function refush(){
    $('#mytab').bootstrapTable('refresh', {url: '/agency/agencyList'});
}

$("#add").click(function(){
    if($("#companyName1").val()==""){
        layer.msg('所属公司不能为空！', {icon:2,time:1000});
        return;
    }
    if($("#leader1").val()==""){
        layer.msg('负责人不能为空！', {icon:2,time:1000});
        return;
    }
    if($("#emailAcc1").val()==""){
        layer.msg('经销商账号不能为空！', {icon:2,time:1000});
        return;
    }
    if($("#emailAcc1").val().indexOf("@",".")==-1){
        layer.msg("经销商账号格式不正确", {icon:2,time:1500});
        return;
    }
    $.post(
        "/agency/agencyAddSave",
        $("#formadd").serialize(),
        function(data){
            if(data.message=="新增成功!"){
                layer.msg(data.message, {icon:1,time:1000});
            }else{
                layer.msg(data.message, {icon:1,time:1000});
            }
            refush();
            $("#webAdd").modal('hide');
            $("#companyName1").val("");
            $("#leader1").val("");
            $("#emailAcc1").val("");
            $("#type1").val("");
        },"json"
    );
});
function deleteMany(){
    var isactivity="";
    var row=$.map($("#mytab").bootstrapTable('getSelections'),function(row){
        if(row.status==0){
            isactivity+=row.status;
        }
        return row.id ;
    });
    if(row==""){
        layer.msg('删除失败，请勾选数据!', {
            icon : 2,
            time : 2000
        });
        return ;
    }
    if(isactivity!=""){
        layer.msg('删除失败，已经激活的不允许删除!', {
            icon : 2,
            time : 2000
        });
        return;

    }
    $("#deleteId").val(row);
    layer.confirm('确认要执行批量删除经销商数据吗？',function(index){
        $.post(
            "/agency/deleteManyAgency",
            {
                "manyId":$("#deleteId").val()
            },
            function(data){
                if(data.message=="删除成功!"){
                    layer.msg(data.message, {icon:1,time:1000});
                    refush();
                }else{
                    layer.msg(data.message, {icon:2,time:1000});
                    refush();
                }
            },"json"
        );
    });
}
