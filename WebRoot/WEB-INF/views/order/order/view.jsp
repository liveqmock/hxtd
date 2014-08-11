<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>${VR_FUNCTION.name}</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail_a.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<c:set var="orderApprove" value="${orderStartApprove||orderExecuteApprove}"/>
<script type="text/javascript">
$(function () {
    <c:if test="${orderApprove}">
    //审批后重定向至详情页
    var redirectURI = "${ctx}/order/order/toViewPage.do?id=${entity.id}";
    if ("${param.returnURI}") {redirectURI += "&returnURI=${param.returnURI}";}
    window.flow = new jsUtil.Flow().init({operateType: "${orderStartApprove?"start":"execute"}", redirectURI: redirectURI});
    </c:if>
    
});
function printDIV(printarea) {
    var head = "<html><head><title></title></head><body>";//先生成头部
    var foot = "</body></html>";//生成尾部
    var newstr = document.all.item(printarea).innerHTML;//获取指定打印区域
    var oldstr = document.body.innerHTML;//获得原本页面的代码
    document.body.innerHTML = newstr;//购建新的网页
    window.print();//打印刚才新建的网页
    document.body.innerHTML = oldstr;//将网页还原
    return false;
}
function redemption(id) {
    jsUtil.dialogIframe("${ctx}/order/order/redemption.comp?id=" + id, "赎回信息", 600, 240, function () {
        RcmsAjax.ajax("${ctx}/order/order/redemption.do?id=" + id, function () {
        });
    });
}
function normalRedemption(id){
	
}
</script>
</head>
<body>
<div>
    <div class="cb"></div>
    <div class="ml35 mr35 mt10 block cb cb">
        <b class="b1"></b>
        <b class="b2"></b>
        <b class="b3"></b>
        <b class="b4"></b>
        <div class="ie_head">
            <h1 class="f14 fbnone mt10 ml10 fl">${orderView?"订单详情信息":(orderApprove?"订单审核信息":"？？？？（未预计的功能）")}</h1>
            <ul class="fr id_table1 mt10 ml10">
                <li>
                    <a class="pl10 c_white f14 lh25 cp block fr" href="javascript:;" onclick="printDIV('printBody')">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14">打&nbsp;&nbsp;印</b>
                    </a>
                </li>
                <c:if test="${orderView&&VS_HAS_FUNCTIONS.orderRedemption}">
                <li>
                <c:if test="${flag}">
                    <a class="pl10 c_white f14 lh25 cp block fr" href="javascript:;" onclick="redemption(${order.id})">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14">提前赎回</b>
                    </a>
                </c:if>
                </li>
                </c:if>
                <c:if test="${orderView&&VS_HAS_FUNCTIONS.orderRedemption}">
                <li>
                    <a class="pl10 c_white f14 lh25 cp block fr" href="javascript:;" onclick="normalRedemption(${order.id})">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14">到期赎回</b>
                    </a>
                </li>
                </c:if>
                <c:if test="${orderView&&VS_HAS_FUNCTIONS.orderModify&&order.flowNode.type==startNodeType}">
                    <li>
                        <a class="pl10 c_white f14 lh25 cp block fr" href="${ctx }/order/order/toModifyPage.do?id=${order.id}">
                            <b class="allbtn_l block fl"></b>
                            <b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b>
                        </a>
                    </li>
                </c:if>
                <c:if test="${orderApprove}">
                    <li>
                        <a href="javascript:void(0);" class="pl10 c_white f14 lh25 cp block fr flow-operate">
                            <b class="allbtn_l block fl"></b>
                            <b class="allbtn_r pr13 block fl w_auto f14">${VR_FUNCTION.name}</b>
                        </a>
                    </li>
                </c:if>
                <%--财务审批时，跳转回财务审批列表页，通过参数returnURI实现--%>
                <li><a class="pl10 c_white f14 lh25 cp block fr mr10" href="${ctx}${param.returnURI==null?'/order/order/toQueryPage.do':param.returnURI}"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b></a></li>
            </ul>
        </div>
    </div>
    <div class="ml35 mr35 bg_c_blue" style="overflow:hidden">
        <div class="fl " style="width:78%" id="printBody">
            <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
            <table class="cb id_table3 w95b bg_c_white margin0 mt10">
                <tr>
                    <td align="right" width="15%">订单编号：</td>
                    <td align="left">${order.code}</td>
                    <td align="right" width="15%">所有者：</td>
                    <td align="left">${order.owner.name }</td>
                </tr>
                <tr>
                    <td align="right">产品：</td>
                    <td align="left">${order.product.name }</td>
                    <td align="right">客户：</td>
                    <td align="left">${order.customer.name }</td>
                </tr>
                <tr>
                    <td align="right">审批环节：</td>
                    <td align="left">${order.flowNode.type==endNodeType?"":"待"}${order.flowNode.name}</td>
                    <td align="right">投资方式：</td>
                    <td align="left">${order.investmentWay.key}</td>
                </tr>
                <tr>
                    <td align="right">购买金额（万）：</td>
                    <td align="left">${order.purchaseMoney}</td>
                    <td align="right">收益率（%）：</td>
                    <td align="left">${order.earningRate}%</td>
                </tr>
                <tr>
                    <td align="right">赎回赔率（%）：</td>
                    <td align="left">${order.arr }%</td>
                    <td align="right">赎回公式：</td>
                    <td align="left">${order.redeemFormula }</td>
                </tr>
                <tr>
                    <td align="right" width="15%">投资经理：</td>
                    <td align="left">${order.salesManager.realName }</td>
                    <td align="right" width="15%">投资总监：</td>
                    <td align="left">${order.salesMajordomo.realName }</td>
                </tr>
                <tr>
                    <td align="right">结束时间：</td>
                    <td align="left"><fmt:formatDate value="${order.orderEndTime }" pattern="yyyy-MM-dd" var="endTime"/><span id="endTime">${endTime }</span></td>
                </tr>
            </table>
            <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
            <table class="cb id_table6 w95b bg_c_white margin0 mt10">
                <tr>
                    <td align="right" width="15%" valign="top">备注：</td>
                    <td align="left" width="85%" valign="top">
                        <div class="w85b">${order.remark }</div>
                    </td>
                </tr>
            </table>
        </div>

        <%--流程图谱--%>
        <%@include file="../../common/flow/graph.jsp" %>

        <%--启动审批--%>
        <c:if test="${orderStartApprove}">
            <%@include file="../../common/flow/start.jsp" %>
        </c:if>
        <%--执行审批--%>
        <c:if test="${orderExecuteApprove}">
            <%@include file="../../common/flow/execute.jsp" %>
        </c:if>

        <div class="h40"></div>
    </div>
</div>
</body>
</html>
