
//生成用户数据
$('#mytab').bootstrapTable({
    method: 'post',
    contentType: "application/x-www-form-urlencoded",//必须要有！！！！
    url:"/user/userList",//要请求数据的文件路径
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
            title:'用户账号',
            field:'loginAcc',
            align:'center',
            sortable:true
        },
        {
            title:'服务器邮箱',
            field:'email',
            align:'center',
            sortable:true
        }
        ,
        {
            title:'服务器IP',
            field:'serverHost',
            align:'center',
            sortable:true
        }
        ,
        {
            title:'服务器端口',
            field:'serverPort',
            align:'center',
            sortable:true
        }
        ,
        {
            title:'用户状态',
            field:'status',
            align:'center',
            formatter: function (value, row, index) {
                if(value==0){
                    //表示激活状态
                    return '<i class="btn btn-primary">激活</i>';
                }else{
                    //表示激活状态
                    return '<i class="btn btn-danger">冻结</i>';
                }
            }
        }
        ,
        {
            title:'操作',
            align:'center',
            field:'',
            formatter: function (value, row, index) {
                var e = '<a title="编辑" href="javascript:void(0);" id="user"  data-toggle="modal" data-id="\'' + row.id + '\'" data-target="#myModal" onclick="return edit(\'' + row.id + '\')"><i class="glyphicon glyphicon-pencil" alt="修改" style="color:green"></i></a> ';
                var d = '<a title="删除" href="javascript:void(0);" onclick="del('+row.id+','+row.status+')"><i class="glyphicon glyphicon-trash" alt="删除" style="color:red"></i></a> ';
                var g = '<a title="重置密码" href="javascript:void(0);" onclick="resetPwd('+row.id+','+row.status+')" ><i class="glyphicon glyphicon-pencil" alt="重置密码" style="color:green"></i></a> ';
                var f='';
                if(row.status==1){
                    f = '<a title="激活" href="javascript:void(0);" onclick="updatestatus('+row.id+','+0+')"><i class="glyphicon glyphicon-ok-sign" style="color:green"></i></a> ';
                }else if(row.status==0){
                    f = '<a title="冻结" href="javascript:void(0);" onclick="updatestatus('+row.id+','+1+')"><i class="glyphicon glyphicon-remove-sign"  style="color:red"></i></a> ';
                }

                return g+d+f;
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
function del(userid,status){
    if(status==0){
        layer.msg("删除失败，已经激活的不允许删除!",{icon:2,time:1000});
        return;
    }
    layer.confirm('确认要删除吗？',function(index){
        $.ajax({
            type: 'POST',
            url: '/user/deleteUser/'+userid,
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
    $.post("/user/findUser/"+name,
        function(data){
            $("#updateform").autofill(data);
        },
        "json"
    );
}
function resetPwd(id,status){
    layer.confirm('确认要重置该用户的密码吗？',function(index){
        $.post("/user/resetPwd/"+id,
            function(data){
                if(data.message.indexOf("成功")){
                    layer.msg(data.message,{icon:1,time:2000});
                }else{
                    layer.msg(data.message,{icon:2,time:1000});
                }
                refush();
            },
            "json"
        );
    });
}
function updatestatus(id,status){
    $.post("/user/updateStatus/"+id+"/"+status,
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
$('#search_btn').click(function(){
    $('#mytab').bootstrapTable('refresh', {url: '/user/userList'});
})
function refush(){
    $('#mytab').bootstrapTable('refresh', {url: '/user/userList'});
}
$("#update").click(function(){
    $.post(
        "/user/userUpdateSave",
        $("#updateform").serialize(),
        function(data){
            if(data.message=="修改成功!"){
                layer.msg(data.message, {icon:1,time:1000});
                refush();
            }else{
                layer.msg(data.message, {icon:1,time:1000});
                refush();
            }
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
    layer.confirm('确认要执行批量删除用户信息数据吗？',function(index){
        $.post(
            "/user/deleteManyUser",
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
