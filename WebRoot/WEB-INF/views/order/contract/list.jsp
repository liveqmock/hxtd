<%--
     合同列表页
  role: huizijing
  Date:2014/7/15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>合同列表页</title>
<link href="${ctx}/static/css/stressing/list1.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/css/stressing/empower.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript">
$(function () {
    jsUtil.datepicker(".time");
    var grid = new Grid().init().bindExport();
});
</script>
</head>
<body>
<div class=" listcontainer">
    <form id="form" action="${ctx}/order/contract/query.do" onsubmit="return false;">
      <table class="fl mt10 w">
       <tr>   
			<td class="f14 namewidth1" align="right">合同编号：</td>
			<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_code" maxlength="30"/></td>
			<td class="f14 namewidth1" align="right">订单编号：</td>
			<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_order.code" maxlength="30"/></td>
			<td class="f14 namewidth1" align="right">合同名称：</td>
			<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_name" maxlength="30"/></td>
			<td width="namewidth3">
    			<a href="javascript:;" class="c_222 block cp fr ml10 packup globle_img mt8 mr20 more" title="展开"></a>
    			<a href="javascript:;" class="reset a_underline fr w_blue mt5">清除</a>
    			<a href="javascript:;" class="block c_white lh25 fr mr10 submit">
    				<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b>
    			</a>
    		</td>
    	</tr>
		<tr class="more-content">
			<td class="f14 namewidth1" align="right">签订时间：</td>
			<td class="f14 namewidth2" align="left">
				<div class="vm">
					<input name="search_GTE_signTime" type="text" class="text_input2 input_close globle_img time" readonly/>-<input type="text" 
						name="search_LTE_signTime" class="text_input2 input_close globle_img time" readonly/>
				</div>
			</td>
			<td class="f14 namewidth1" align="right">生效时间：</td>
			<td class="f14 namewidth2" align="left">
				<div class="vm">
					<input type="text" name="search_GTE_effectTime" class="text_input2 input_close globle_img time" readonly/>-<input type="text" 
						name="search_LTE_effectTime" class="text_input2 input_close globle_img time" readonly/>
				</div>
			</td>
			<td class="f14 namewidth1" align="right">失效时间：</td>
			<td class="f14 namewidth2" align="left">
				<div class="vm">
					<input name="search_GTE_bereftTime" type="text" class="text_input2 input_close globle_img time" readonly/>-<input type="text" 
						name="search_LTE_bereftTime" class="text_input2 input_close globle_img time" readonly/>
				</div>
			</td>
		</tr> 
	   </table>
	   <tags:paginationparams page="${page}"/>
	</form>
    <!--查询条件结束-->
	<div class="cb"></div>
	<!--列表开始-->
	<div class="ml35 mr35 mt10 block cb cb">
		<b class="table_headl globle_img block fl"></b>
		<div class="fl table_headc fl w99b">
			<div class="ie_head">
				<ul class="fl id_table1 mt10 ml10">
					<c:if test="${VS_HAS_FUNCTIONS.contractDelete}">
					<li>
						<a href="javascript:;" uri="${ctx}/order/contract/delete.do" class="block c_white lh25 mr10 deletesome">
							<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b>
						</a>
					</li>
					</c:if>
					<c:if test="${VS_HAS_FUNCTIONS.contractAdd}">
					<li>
						<a href="${ctx}/order/contract/toAddPage.do" class="block c_white lh25 add mr10">
							<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b>
						</a>
					</li>
					</c:if>
					<li>
						<a href="javascript:;" class="refresh block c_white lh25 fr mr10">
							<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b>
						</a>
					</li>
				</ul>
				<ul class="fr id_table1 mt10 ml10">
					<li>
						<a href="javascript:;" uri="${ctx}/order/contract/export.do?TYPE=selected" 
							class="leading_out globle_img block_inline mr10 export" title="导出"></a>
					</li>
				</ul>
			</div>
		</div>
		<b class="table_headr globle_img block fl"></b>
	</div>
	<!-- 浮动表头开始 -->
	<div id="title" style="display: none;background-color: #f5f5f6;" class=" ml35 mr35">
		<table class="cb id_table2 w">
			<tr>
	           <th align="center" width="5%" ><input type="checkbox" class="checkall"/></th>
	                <th align="center" width="4%" ><input type="checkbox" class="checkall"/></th>
	                <th width="10%" class="sortable orderby" orderby="title">合同编号</th>
	                <th width="10%" class="sortable orderby" orderby="title">订单编号</th>
	                <th width="10%">合同名称</th>
	                <th width="7%">合同金额（万）</th>
	                <th width="7%">客户</th>
	                <th width="7%">赎回方式</th>
	                <th width="5%">创建者</th>
	                <th width="9%" class="sortable orderby" orderby="signTime">签订时间</th>
	                <th width="9%" class="sortable orderby" orderby="effectTime">生效时间</th>
	                <th width="9%" class="sortable orderby" orderby="bereftTime">失效时间</th>
	                <th align="center" width="12%">操作</th>
	        </tr>
	    </table>
	</div>
	<!-- 浮动表头结束 -->
    <div class="ml35 mr35" > 
        <table id="table" class="cb id_table2 w pr35">
            <tr id="recordDiv">
                <th align="center" width="4%" ><input type="checkbox" class="checkall"/></th>
                <th width="11%" class="sortable orderby" orderby="code">合同编号</th>
                <th width="11%" >订单编号</th>
                <th width="10%">合同名称</th>
                <th width="7%">合同金额(万)</th>
                <th width="7%">客户</th>
                <th width="7%">赎回方式</th>
                <th width="5%">创建者</th>
                <th width="9%" class="sortable orderby" orderby="signTime">签订时间</th>
                <th width="9%" class="sortable orderby" orderby="effectTime">生效时间</th>
                <th width="9%" class="sortable orderby" orderby="bereftTime">失效时间</th>
                <th align="center" width="11%">操作</th>
            </tr>
            <tbody id="tbody" class="list"></tbody>
        </table>
        <div class="cb ml35 mt20 h40 pagination"></div>
        <textarea id="template-tbody" class="template template-tbody">
            {#foreach $T.result as row}
            <tr class="{$T.row$index%2==1?'':'bg_c_blue w'}">
                <td align="center"><input type="checkbox" name="id" class="checkitem" value="{$T.row.id}"/></td>
                <td >
				<c:choose>
					<c:when test="${VS_HAS_FUNCTIONS.contractView}">
					 <a href="${ctx}/order/contract/toViewPage.do?id={$T.row.id}">{$T.row.code}</a>
					</c:when>
					<c:otherwise>{$T.row.code}</c:otherwise>
				</c:choose>
                </td>
                <td>{$T.row.order.code}</td>
                <td>{$T.row.name}</td>
                <td align="right">{$T.row.purchaseMoney}</td>
                <td>{$T.row.customer.name}</td>
                <td>{$T.row.redeemType.key}</td>
                <td>{$T.row.creator.realName}</td>
                <td>{$T.row.signTime}</td>
                <td>{$T.row.effectTime}</td>
                <td>{$T.row.bereftTime}</td>
                <td align="center">
	                <c:if test="${VS_HAS_FUNCTIONS.contractView}">
	                <a href="${ctx}/order/contract/toViewPage.do?id={$T.row.id}" title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
	                </c:if>
	                <c:if test="${VS_HAS_FUNCTIONS.contractModify}">
	                 <a href="${ctx}/order/contract/toModifyPage.do?id={$T.row.id}" title="编辑" class=" block_inline s_edit_btn globle_img ml10"></a>
	                </c:if>
	                <c:if test="${VS_HAS_FUNCTIONS.orderView}">
	                <a href="${ctx}/order/order/toViewPage.do?id={$T.row.order.id}" title="订单详情" class=" block_inline s_contract globle_img ml10"></a>
	                </c:if>
	                <c:if test="${VS_HAS_FUNCTIONS.contractDelete}">
	                 <a href="javascript:;"  uri="${ctx}/order/contract/delete.do?id={$T.row.id}" title="删除"class=" block_inline s_dump_btn globle_img ml10 delete"></a>
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