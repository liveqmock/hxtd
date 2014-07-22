<%--
  功能描述：订单详情
  User: xiaoli.luo
  Date:2014/5/19
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>订单详情</title>
    <link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/css/recommend/detail_a.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script type="text/javascript">
        $(function () {

            <c:if test="${orderStartApprove || orderExecuteApprove}">
            jsUtil.bindSave();
            </c:if>
            $(".sendApprove").click(function () {
                jsUtil.dialogIframe('${ctx}/common/approve/toSendPage.doself', '发送', 500, 300);
                DIALOG.dialog('option', 'buttons', {
                    "确定": function () {
                        //if(act == "view") {
                        //	DIALOG.dialog("close");
                        //} else {
                        //	$("#dialogIframe")[0].contentWindow.submitForm();
                        //}
                    },
                    "关闭": function () {
                        DIALOG.dialog("close");
                    }
                });
            });
        });
    </script>
</head>
<body>
<div>
    <input name="RecordsId" type="hidden" value="${order.id}"/>

    <div class="cb"></div>
    <div class="ml35 mr35 mt20 block cb cb">
        <b class="b1"></b>
        <b class="b2"></b>
        <b class="b3"></b>
        <b class="b4"></b>

        <div class="ie_head">
            <h1 class="f14 fbnone mt10 ml10 fl">订单详情信息</h1>
            <ul class="fr id_table1 mt10 ml10">
                <li>
                    <a class="pl10 c_white f14 lh25 cp block fr sendApprove" href="javascript:;">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14">发送</b>
                    </a>
                </li>
                <li>
                    <a class="pl10 c_white f14 lh25 cp block fr" href="javascript:;" onclick="window.print()">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14">打&nbsp;&nbsp;印</b>
                    </a>
                </li>
                <c:if test="${VS_HAS_FUNCTIONS.orderModify}">
                    <li>
                        <a class="pl10 c_white f14 lh25 cp block fr" href="${ctx }/order/order/toModifyPage.do?id=${order.id}">
                            <b class="allbtn_l block fl"></b>
                            <b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b>
                        </a>
                    </li>
                </c:if>
                <li>
                    <a class="pl10 c_white f14 lh25 cp block fr mr10"
                       href="${ctx }/order/order/toQueryPage.do"><b
                            class="allbtn_l block fl"></b><b
                            class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="ml35 mr35 bg_c_blue cb">
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
                <%--<td align="left">${order.product.name }</td>--%>
                <td align="right">客户：</td>
                <td align="left">${order.customer.name }</td>
            </tr>
            <tr>
                <td align="right">订单状态：</td>
                <td align="left">${order.status.name}</td>
                <td align="right">投资方式：</td>
                <td align="left">${order.investmentWay.key}</td>
            </tr>
            <tr>
                <td align="right">购买金额：</td>
                <td align="left">${order.purchaseMoney}</td>
                <td align="right">收益率：</td>
                <td align="left">${order.earningRate}%</td>
            </tr>
            <tr>
                <td align="right">赎回率：</td>
                <td align="left">${order.arr }%</td>
                <td align="right">赎回公式：</td>
                <td align="left">${order.redeemFormula }</td>
            </tr>
            <tr>
                <td align="right" width="15%">销售主管：</td>
                <td align="left">${order.salesManager.name }</td>
                <td align="right" width="15%">销售总监：</td>
                <td align="left">${order.salesMajordomo.name }</td>
            </tr>
            <tr>
                <td align="right">结束时间：</td>
                <td align="left"><fmt:formatDate value="${order.orderEndTime }" pattern="yyyy-MM-dd" var="endTime"/>${endTime }</td>
            </tr>
        </table>
        <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
        <table class="cb id_table4 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%" valign="top">备注：</td>
                <td align="left" width="85%" valign="top">
                    <div class="w85b">${order.remark }</div>
                </td>
            </tr>
        </table>
        <form action="${ctx}${VR_FUNCTION.url}" method="post">
            <input type="hidden" name="id" value="${order.id}"/>
            <tag:approve flowNodes="${flowNodes}" historyRecords="${historyRecords}"/>
            <c:if test="${orderStartApprove || orderExecuteApprove}">
                <div class="cb block h40 margin0 mt10" style="width: 350px;">
                    <ul class="id_table1 cb">
                        <li><a href="javascript:void(0)" redirecturi="/order/order/toQueryPage.do" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">启动审批</b></a></li>
                    </ul>
                </div>
            </c:if>
        </form>
        <div class="h40"></div>
    </div>
</div>
</body>
</html>
