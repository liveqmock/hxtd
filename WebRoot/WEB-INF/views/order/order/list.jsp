<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>订单列表</title>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
<script type="text/javascript">${applicationScope.VC_PCAS}</script>
<script type="text/javascript">
$(function () {
    jsUtil.datepicker(".time");//加载时间控件
    jsUtil.datepickerNotNow(".time1");
    window.grid = new Grid().init().bindExport();
});

function getProduct(id) {
    jsUtil.dialogIframe("${ctx}/project/product/toViewPage.comp?id=" + id, "产品信息", 800, 440);
}
function getCustomer(id) {
    jsUtil.dialogIframe("${ctx}/customer/customer/toViewPage.comp?id=" + id, "客户信息", 800, 650);
}
</script>
</head>
<body>
<div class="listcontainer">
    <form id="form" action="${ctx}/order/order/query.do" onsubmit="return false;">
        <table class="fl mt10 w">
            <tr>
                <td class="f14 namewidth1" align="right">订单编号：</td>
                <td class="f14 namewidth2" align="left">
                    <input type="text" class="text_input1" name="search_LIKE_code"/>
                </td>
                <td class="f14 namewidth1" align="right">产品名：</td>
                <td class="f14 namewidth2" align="left">
                    <input type="text" class="text_input1" name="search_LIKE_product.name"/>
                </td>
                <td class="f14 namewidth1" align="right">客户名：</td>
                <td class="f14 namewidth2" align="left">
                    <input type="text" class="text_input1" name="search_LIKE_customer.name"/>
                </td>
                <td class="namewidth3">
                    <a class="c_222 block cp fr ml10 globle_img mt8 mr20 more" title="展开"></a>
                    <a href="javascript:void(0)" class="a_underline block_inline fr w_blue mt5 reset">清除</a>
                    <a href="javascript:void(0)" class="block_inline c_white lh25 fr mr10 submit"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b> </a>
                </td>
            </tr>
            <tr class="more-content">
                <td class="f14 namewidth1" align="right">购买金额（万）：</td>
                <td class="f14 namewidth2" align="left"><input type="text" class="text_input2" name="search_GTE_purchaseMoney"/>-<input type="text" class="text_input2" name="search_LTE_purchaseMoney"/>
                </td>
                <td class="f14 namewidth1" align="right">收益率（%）：</td>
                <td class="f14 namewidth2" align="left">
                    <div class="pr vm">
                        <input class="text_input2" name="search_GTE_earningRate" type="text" readonly/>-<input class="text_input2" name="search_LTE_earningRate" type="text" readonly/>
                    </div>
                </td>
                <td class="f14 namewidth1" align="right">赎回赔率（%）：</td>
                <td class="f14 namewidth2" align="left">
                    <div class="pr vm">
                        <input class="text_input2" name="search_GTE_arr" type="text" readonly/>-<input class="text_input2" name="search_LTE_arr" type="text" readonly/>
                    </div>
                </td>
            </tr>
            <tr class="more-content">
                <td class="f14 namewidth1" align="right">结束时间：</td>
                <td class="f14 namewidth2" align="left">
                    <div class="pr vm">
                        <a href="javascript:void(0)" class="pa time_closenone1"></a>
                        <a href="javascript:void(0)" class="pa time_closenone2"></a>
                        <input class="text_input2 input_close globle_img time1" name="search_GTE_endTime" type="text" readonly/>-<input class="text_input2 input_close globle_img time1" name="search_LTE_endTime" type="text" readonly/>
                    </div>
                </td>
                <td class="f14 namewidth1" align="right">创建时间：</td>
                <td class="f14 namewidth2" align="left">
                    <div class="pr vm">
                        <a href="javascript:void(0)" class="pa time_closenone1"></a>
                        <a href="javascript:void(0)" class="pa time_closenone2"></a>
                        <input class="text_input2 input_close globle_img time" name="search_GTE_createdTime" type="text" readonly/>-<input class="text_input2 input_close globle_img time" name="search_LTE_createdTime" type="text" readonly/>
                    </div>
                </td>
                <td class="f14 namewidth1" align="right">修改时间：</td>
                <td class="f14 namewidth2" align="left">
                    <div class="pr vm">
                        <a href="javascript:void(0)" class="pa time_closenone1"></a>
                        <a href="javascript:void(0)" class="pa time_closenone2"></a>
                        <input class="text_input2 input_close globle_img time" name="search_GTE_modifiedTime" type="text" readonly/>-<input class="text_input2 input_close globle_img time" name="search_LTE_modifiedTime" type="text" readonly/>
                    </div>
                </td>
            </tr>
        </table>
        <tags:paginationparams page="${page}"/>
    </form>
    <!--查询条件结束-->
    <div class="cb"></div>
    <div class="ml35 mr35 mt10 block cb cb">
        <b class="b1"></b>
        <b class="b2"></b>
        <b class="b3"></b>
        <b class="b4"></b>
        <div class="ie_head">
            <ul class="fl id_table1 mt10 ml10">
                <c:if test="${VS_HAS_FUNCTIONS.orderDelete}">
                    <li><a href="javascript:void(0)" uri="${ctx}/order/order/delete.do" class="deletesome block c_white lh25"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b> </a></li>
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.orderAdd}">
                    <li><a href="${ctx}/order/order/toAddPage.do" class="block c_white lh25 ml10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b> </a></li>
                </c:if>
                <li><a href="javascript:void(0)" class="refresh block c_white lh25 ml10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b> </a></li>
            </ul>
            <ul class="fr id_table1 mt10 ml10">
                <c:if test="${VS_HAS_FUNCTIONS.orderExport}">
                    <li><a href="javascript:void(0)" uri="${ctx}/order/order/export.do?TYPE=selected" class="leading_out globle_img block_inline mr10 export" title="导出"></a></li>
                </c:if>
            </ul>
        </div>
    </div>
    <div class="ml35 mr35 content">
        <table class="cb id_table2 w tablesorter" id="table">
            <tr id="recordDiv">
                <th width="3%"><input type="checkbox" class="checkall" id="id"/></th>
                <th width="8%">订单编号</th>
                <th width="4%">客户</th>
                <th width="6%">金额（万）</th>
                <th width="7%">产品</th>
                <th width="8%">审批环节</th>
                <th width="7%">订单状态</th>
                <th width="5%">财务状态</th>
                <th width="4%">所有者</th>
                <th width="7%" class="sortable orderby" orderby="effectiveTime">生效时间</th>
                <th width="7%" class="sortable orderby" orderby="orderEndTime">结束时间</th>
                <th width="10%" class="sortable orderby" orderby="modifiedTime">最后修改时间</th>
                <th width="13%" align="center">操作</th>
            </tr>
            <tbody class="list"></tbody>
        </table>
        <div class="pagination cb ml35 mt20 h40 "></div>
        <textarea id="template-tbody" class="template template-tbody">
            {#foreach $T.result as row}
            <tr class="{$T.row$index%2==1?'':'bg_c_blue'} row w">
                <td><input type="checkbox" name="id" class="checkitem" value="{$T.row.id}"/></td>
                <td>
                    <c:choose>
                        <c:when test="${VS_HAS_FUNCTIONS.orderView}">
                            <a href="${ctx}/order/order/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.code}</a>
                        </c:when>
                        <c:otherwise>{$T.row.code}</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${VS_HAS_FUNCTIONS.customerView}">
                            <a href="javascript:getCustomer({$T.row.customer.id})" class="toviewpage">{$T.row.customer.name}</a>
                        </c:when>
                        <c:otherwise>{$T.row.customer.name}</c:otherwise>
                    </c:choose>
                </td>
                <td>{$T.row.purchaseMoney}</td>
                <td>
                    <c:choose>
                        <c:when test="${VS_HAS_FUNCTIONS.productView}">
                            <a href="javascript:getProduct({$T.row.product.id})" class="toviewpage">{$T.row.product.name}</a>
                        </c:when>
                        <c:otherwise>{$T.row.product.name}</c:otherwise>
                    </c:choose>
                </td>
                <td>{$T.row.flowNode.type==${endNodeType}?"":"待"}{$T.row.flowNode.name}</td>
                <td>{$T.row.orderStatus.key}</td>
                <td 
                 {#if $T.row.payStatus.key=='未收款'} style="color:red;"{#/if}
                >{$T.row.payStatus.key}</td>
                <td>{$T.row.owner.realName}</td>
                <td>{$T.row.effectiveTime}</td>
                <td>{$T.row.orderEndTime}</td>
                <td>{$T.row.modifiedTime}</td>
                <td align="left">
                    <c:if test="${VS_HAS_FUNCTIONS.orderView}">
                        <a href="${ctx}/order/order/toViewPage.do?id={$T.row.id}" title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.orderModify}">
                        {#if $T.row.flowNode.type==${startNodeType}}
                        <a href="${ctx}/order/order/toModifyPage.do?id={$T.row.id}" title="编辑" class=" block_inline s_edit_btn globle_img ml10"></a>
                        {#/if}
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.orderDelete}">
                        <a href="javascript:void(0)" uri="${ctx}/order/order/delete.do?id={$T.row.id}" title="删除" class="delete  block_inline s_dump_btn globle_img ml10"></a>
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.orderAdd}">
                        <a href="${ctx}/order/order/toAddPage.do?type=second&id={$T.row.id}" title="再次购买" class="block_inline s_buy globle_img ml10"></a>
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.orderStartApprove}">
                        {#if $T.row.flowNode.type==${startNodeType}&&$T.row.owner.id==${VS_USER.id}}
                        <a href="${ctx}/order/order/toStartApprovePage.do?id={$T.row.id}" title="启动审批" class="block_inline s_onapprove globle_img ml10"></a>
                        {#/if}
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.orderExecuteApprove}">
                        {#if $T.row.flowNode.type==${businessNodeType}&&$T.row.flowNode.executeFlowNode}
                        <a href="${ctx}/order/order/toExecuteApprovePage.do?id={$T.row.id}&flowNodeId={$T.row.flowNode.executeFlowNode.id}" title="进行审批" class="block_inline s_goapprove globle_img ml10"></a>
                        {#/if}
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.orderInvalid}">
                    {#if $T.row.orderStatus.value=='07010103'}
                    	<a href="javascript:void(0);" uri="${ctx}/order/order/toInvalid.do?id={$T.row.id}&type=company" class="block_inline ml10 globle_img s_cancel block_inline disable" title="订单公司作废"></a>
                    	<a href="javascript:void(0);" uri="${ctx}/order/order/toInvalid.do?id={$T.row.id}&type=customer" class="globle_img ml10 s_cancelorder block_inline disable" title="订单客户作废"></a>
              		{#/if}
              		</c:if>
                </td>
            </tr>
            {#/for}
        </textarea>
        <%@include file="/WEB-INF/template/sort.jsp" %>
        <%@include file="/WEB-INF/template/pagination.jsp" %>
    </div>
</div>
</body>
</html>
