<%--
  Created by IntelliJ IDEA.
  User: aQiu
  Date: 2017/12/1/001
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
</head>
<style>
    .tag-list input{
        width: 70px;
        border: 1px #ccc solid;
        padding: 3px;
    }
</style>
<body>
<div class="col-sm-3">
    <div class="ibox float-e-margins">
        <div class="ibox-content mailbox-content">
            <div class="file-manager">
                <h3>货款担保 变量</h3>
                <ul class="tag-list" style="padding: 0">
                    <li><a><i class="fa fa-tag"></i> 公司号：<input readonly value="&#36;{GSH}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 公司名：<input readonly value="&#36;{GSM}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 担保日期	：<input readonly value="&#36;{GuaranteeTime}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 业务员：<input readonly value="&#36;{DefSale}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 客户：<input readonly value="&#36;{Customer}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 担保金额：<input readonly value="&#36;{GuaranteeMoney}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 担保到日期：<input readonly value="&#36;{GuaranteeDate}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 未回款金额：<input readonly value="&#36;{aOutstanding}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 逾期罚金：<input readonly value="&#36;{LateFine}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 是否结束：<input readonly value="&#36;{iEND}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 创建人：<input readonly value="&#36;{cCreateUser}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 创建时间：<input readonly value="&#36;{cCreateTime}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 变更人：<input readonly value="&#36;{cModifyPerson}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 变更时间：<input readonly value="&#36;{dModifyTime}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 最后逾期日：<input readonly value="&#36;{Lastday}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 事务单号：<input readonly value="&#36;{cBillNo}"></a></li>
                </ul>
                <div class="clearfix"></div>
                <h3>对帐明细 变量</h3>
                <ul class="tag-list" style="padding: 0">
                    <li><a><i class="fa fa-tag"></i> 公司号：<input readonly value="&#36;{GSH}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 公司名：<input readonly value="&#36;{GSM}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 年：<input readonly value="&#36;{iYear}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 月：<input readonly value="&#36;{iMonth}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 期初欠款：<input readonly value="&#36;{qc}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 调整后期初：<input readonly value="&#36;{tzqc}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 客户分类ID：<input readonly value="&#36;{KHFLID}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 客户分类：<input readonly value="&#36;{ctype}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 经销商编码：<input readonly value="&#36;{JXSBM}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 经销商名称：<input readonly value="&#36;{JXSMC}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 客户编码：<input readonly value="&#36;{c1id}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 开票客户：<input readonly value="&#36;{c1}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 发货单号：<input readonly value="&#36;{did}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 发票编号：<input readonly value="&#36;{iid}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 发票日期：<input readonly value="&#36;{itime}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 产品编码：<input readonly value="&#36;{cProductCode}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 产品名称：<input readonly value="&#36;{product}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 产品规格：<input readonly value="&#36;{spec}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 发票数量：<input readonly value="&#36;{inum}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 单价：<input readonly value="&#36;{iprice}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 发票金额：<input readonly value="&#36;{itotal}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 回款客户：<input readonly value="&#36;{c2}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 回款类型：<input readonly value="&#36;{rtype}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 事务单号：<input readonly value="&#36;{SWDH}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 回款日期：<input readonly value="&#36;{rtime}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 回款金额：<input readonly value="&#36;{rtotal}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 底价金额：<input readonly value="&#36;{DiJJE}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 期末余额：<input readonly value="&#36;{qm}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 底价增加合计：<input readonly value="&#36;{sumzj}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 底价减少合计：<input readonly value="&#36;{sumjs}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 公式期末：<input readonly value="&#36;{sumqm}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 差额(取数-公式)：<input readonly value="&#36;{ce}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 发票底价金额：<input readonly value="&#36;{FPDiJJE}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 用户ID：<input readonly value="&#36;{cUserid}"></a></li>
                    <li><a><i class="fa fa-tag"></i> 查询类型：<input readonly value="&#36;{stype}"></a></li>

                </ul>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>
<%
    String path = request.getContextPath();
%>
<script src="<%=path%>/js/jquery.min.js?v=2.1.4"></script>
<script>
    $(document).ready(function(){
        $(".tag-list input").bind('focus',function(){
            $(this).select();
        })
    })
    
</script>
</body>
</html>
