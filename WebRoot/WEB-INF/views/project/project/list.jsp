<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>项目列表</title>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1">
</script>
<script type="text/javascript">
$(function() {
	jsUtil.datepicker(".time"); //加载时间控件
	$("#id").click(function() { //全选/全不选
		if (this.checked) {
			$("input:checkbox").attr("checked", true);
		} else {
			$("input:checkbox").removeAttr("checked");
		}
	});
	$(".list :checkbox").live("click", function(e) {
		$(".checkall").attr("checked", $(".list :checkbox:not(:checked)").length == 0);
		e.stopPropagation(); //jquery 阻止冒泡事件
	});
	var grid = new Grid().init().bindExport(); //首次加载数据
	$("#reload").click(function(){grid.loadGrid();}); //给刷新按钮绑定重新加载的事件
});
function showSupplier(id){ //查看供应商信息
	jsUtil.dialogIframe("${ctx}/project/supplier/toViewPage.comp?id=" + id, "供应商信息", 800, 520);
}
</script>
</head>
<body>
<div class="listcontainer">
<form id="form" action="${ctx}/project/project/query.do" onsubmit="return false;">
<table class="fl mt5 w">
	<tr>
		<td class="f14 namewidth1" align="right">项目名称：</td>
		<td class="f14 namewidth2" align="left"><input type="text" name="search_LIKE_name" class="text_input1"/></td>
		<td class="f14 namewidth1" align="right">项目编号：</td>
		<td class="f14 namewidth2" align="left"><input type="text" name="search_LIKE_code" class="text_input1"/></td>
		<td class="f14 namewidth1" align="right">供应商：</td>
		<td class="f14 namewidth2" align="left"><input type="text" name="search_LIKE_supplier.name" class="text_input1"/></td>
		<td class="namewidth3">
			<a class="c_222 block cp fr ml10 globle_img mt8 mr20 more" title="展开"></a>
			<a href="javascript:;" class="a_underline block_inline fr w_blue mt5 reset">清除</a>
			<a href="javascript:;" class="block_inline c_white lh25 fr mr10 submit">
				<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b>
			</a>
		</td>
	</tr>
	<tr class="more-content">
		<td class="f14 namewidth1" align="right">融资额度：</td>
		<td class="f14 namewidth2" align="left">
			<input type="text" name="search_GTE_financeLimit" 
				class="text_input2"/>-<input type="text" name="search_LTE_financeLimit" class="text_input2"/>
		</td>
		<td class="f14 namewidth1" align="right">融资周期：</td>
		<td class="f14 namewidth2" align="left">
			<input type="text" name="search_GTE_financeCycle" 
				class="text_input2"/>-<input type="text" name="search_LTE_financeCycle" class="text_input2"/>
		</td>
		<td class="f14 namewidth1" align="right">
			收益率%：
		</td>
		<td class="f14 namewidth2" align="left">
			<input type="text" name="search_GTE_er" class="text_input2"/>-<input type="text" name="search_LTE_er" class="text_input2"/>
		</td>
	</tr>
	<tr class="more-content">
		<td class="f14 namewidth1" align="right">支付方式：</td>
		<td class="f14 namewidth2" align="left">
			<select name="search_EQ_payType" class="select2">
				<option value="">全部</option>
				<c:forEach items="${payType}" var="p">
					<option value="${p.id}">${p.key}</option>
				</c:forEach>
			</select>
		</td>
		<td class="f14 namewidth1" align="right">赎回率%：</td>
		<td class="f14 namewidth2" align="left">
			<input type="text" name="search_GTE_aer" class="text_input2"/>-<input class="text_input2" name="search_LTE_aer" type="text"/>
		</td>
		<td class="f14 namewidth1" align="right">开放时间：</td>
		<td class="f14 namewidth2" align="left" >
			<input type="text" name="search_GTE_beginTime" class="text_input2 input_close globle_img time"/>-<input 
				 type="text" name="search_LTE_beginTime" class="text_input2 input_close globle_img time"/>
		</td>
	</tr>
	<tr class="more-content">
		<td class="f14 namewidth1" align="right">创建时间：</td>
		<td class="f14 namewidth2" align="left">
			<input type="text" name="search_GTE_createdTime" class="text_input2 input_close globle_img time"/>-<input 
				type="text" name="search_LTE_createdTime" class="text_input2 input_close globle_img time"/>
		</td>
		<td class="f14 namewidth1" align="right">修改时间：</td>
		<td class="f14" align="left">
			<input type="text" name="search_GTE_modifiedTime" class="text_input2 input_close globle_img time"/>-<input 
				type="text" name="search_LTE_modifiedTime" class="text_input2 input_close globle_img time"/>
		</td>
	</tr>
</table>
<tags:paginationparams page="${page}"></tags:paginationparams>
</form>
<div class="cb"></div>
<div class="ml35 mr35 mt20 block cb cb">
	<b class="b1"></b>
	<b class="b2"></b>
	<b class="b3"></b>
	<b class="b4"></b>
	<div class="ie_head">
		<ul class="fl id_table1 mt10 ml10">
			<c:if test="${VS_HAS_FUNCTIONS.projectDelete}">
				<li>
					<a href="javascript:;" uri="${ctx}/project/project/delete.do" class="block c_white lh25 deletesome">
						<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b>
					</a>
				</li>
			</c:if>
			<c:if test="${VS_HAS_FUNCTIONS.projectAdd}">
				<li>
					<a href="${ctx}/project/project/toAddPage.do" class="block c_white lh25 ml10">
						<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b>
					</a>
				</li>
			</c:if>
			<li>
				<a href="javascript:;" class="refresh block c_white lh25 ml10">
					<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b>
				</a>
			</li>
		</ul>
		<ul class="fr id_table1 mt10 ml10">
			<c:if test="${VS_HAS_FUNCTIONS.projectExport}">
				<li>
					<a href="javascript:;" uri="${ctx}/project/project/export.do?TYPE=selected" 
						class="leading_out globle_img block_inline mr10 export" title="导出"></a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
<div id="title" style="display:none;z-index:1;background-color:#f5f5f6;" class="ml35 mr35">
	<table class="cb id_table2 w">
		<tr id="recordDiv">
			<td width="2%"><input type="checkbox" id="id" class="checkall"/></td>
			<th width="12%">项目编号</th>
			<th width="15%">项目名称</th>
			<th width="15%">供应商</th>
			<th>融资额度（万）</th>
			<th>融资周期（天）</th>
			<th width="8%" class="sortable orderby" orderby="beginTime">开始时间</th>
			<th width="8%" class="sortable orderby" orderby="dendlineTime">结束时间</th>
			<th width="8%" class="sortable orderby" orderby="openTime">开放期</th>
			<th width="10%">操作</th>
		</tr>
	</table>
</div>
<div class="ml35 mr35">
	<table class="cb id_table2 w pr35 tablesorter" cellspacing="1" id="table">
		<tr id="recordDiv">
			<td width="2%"><input type="checkbox" id="id" class="checkall"/></td>
			<th width="12%">项目编号</th>
			<th width="15%">项目名称</th>
			<th width="15%">供应商</th>
			<th>融资额度（万）</th>
			<th>融资周期（天）</th>
			<th width="8%" class="sortable orderby" orderby="beginTime">开始时间</th>
			<th width="8%" class="sortable orderby" orderby="dendlineTime">结束时间</th>
			<th width="8%" class="sortable orderby" orderby="openTime">开放期</th>
			<th width="10%">操作</th>
		</tr>
		<tbody class="list"></tbody>
	</table>
	<div class="pagination cb ml35 mt20 h40"></div>
	<textarea id="template-tbody" class="template template-tbody">
	{#foreach $T.result as row}
	<tr class="{$T.row$index%2==1?'':'bg_c_blue'} row w">
		<td><input type="checkbox" name="id" class="checkitem" value="{$T.row.id}"/></td>
		<td>{$T.row.code}</td>
		<td>
			<c:choose>
				<c:when test="${VS_HAS_FUNCTIONS.projectView}">
					<a href="${ctx}/project/project/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.name}</a>
				</c:when>
				<c:otherwise>{$T.row.name}</c:otherwise>
			</c:choose>
		</td>
		<td>
			<c:choose>
				<c:when test="${VS_HAS_FUNCTIONS.supplierView}">
				     <a href="javascript:showSupplier({$T.row.supplier.id});">{$T.row.supplier.name}</a>
				</c:when>
				<c:otherwise>{$T.row.supplier.name}</c:otherwise>
			</c:choose>
		</td>
		<td align="right">{$T.row.financeLimit}</td>
		<td align="right">{$T.row.financeCycle}</td>
		<td>{$T.row.beginTime}</td>
		<td>{$T.row.dendlineTime}</td>
		<td>{$T.row.openTime}</td>
		<td>
			<c:if test="${VS_HAS_FUNCTIONS.projectView}">
				<a href="${ctx}/project/project/toViewPage.do?id={$T.row.id}" class="block_inline s_detail_btn globle_img ml10" title="详情"></a>
			</c:if>
			<c:if test="${VS_HAS_FUNCTIONS.projectModify}">
				<a href="${ctx}/project/project/toModifyPage.do?id={$T.row.id}" class="block_inline s_edit_btn globle_img ml10" title="编辑"></a>
			</c:if>
			<c:if test="${VS_HAS_FUNCTIONS.projectDelete}">
				<a href="javascript:;"uri="${ctx}/project/project/delete.do?id={$T.row.id}" class="delete block_inline s_dump_btn globle_img ml10" title="删除"></a>
			</c:if>
		</td>
	</tr>
	{#/for}
	</textarea>
	<%@include file="/WEB-INF/template/sort.jsp"%>
	<%@include file="/WEB-INF/template/pagination.jsp"%>
</div>
</div>
</body>
</html>
