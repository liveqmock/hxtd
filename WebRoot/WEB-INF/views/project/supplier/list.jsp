<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>供应商列表</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css?v=1" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/application.css?v=1" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/pacs.js?v=1"></script>
<script type="text/javascript">${applicationScope.VC_PCAS}</script>
<script type="text/javascript">
$(function () {
    jsUtil.datepicker(".time"); //加载时间控件
    $("#id").click(function () { //全选/全不选
        if (this.checked) {
            $("input:checkbox").attr("checked", true);
        } else {
            $("input:checkbox").removeAttr("checked");
        }
    });
    $(".list :checkbox").live("click", function (e) {
        $(".checkall").attr("checked", $(".list :checkbox:not(:checked)").length == 0);
        e.stopPropagation(); //jquery 阻止冒泡事件
    });
    new PCAS("province","city","county");
    new Grid().init().bindExport(); //首次加载数据
});
</script>
</head>
<body>
<div class="listcontainer">
	<form id="form" action="${ctx}/project/supplier/query.do" onsubmit="return false;">
	<table class="fl mt10 w">
		<tr>
			<td class="f14 namewidth1" align="right">供应商名称：</td>
			<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_name" maxlength="30"/></td>
			<td class="f14 namewidth1" align="right">电话：</td>
			<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_phone" maxlength="20"/></td>
			<td class="f14 namewidth1" align="right">手机：</td>
			<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_mobile" maxlength="11"/></td>
			<td class="namewidth3">
				<a class="c_222 block cp fr ml10 globle_img mt8 mr20 more" title="展开"></a>
				<a href="javascript:;" class="a_underline block_inline fr w_blue mt5 reset">清除</a>
				<a href="javascript:;" class="block_inline c_white lh25 fr mr10 submit">
					<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b>
				</a>
			</td>
		</tr>
		<tr class="more-content">
			<td class="f14 namewidth1" align="right" width="7%">省：</td>
			<td class="f14 namewidth2" align="left" width="13%"><select id="province" name="search_EQ_province.id" class="select2"></select></td>
			<td class="f14 namewidth1" align="right" width="7%">市：</td>
			<td class="f14 namewidth2" align="left" width="13%"><select id="city" name="search_EQ_city.id" class="select2"></select></td>
			<td class="f14 namewidth1" align="right" width="7%">区/县：</td>
			<td class="f14 namewidth2" align="left" width="13%"><select id="county" name="search_EQ_county.id" class="select2"></select></td>
		</tr>
		<tr class="more-content">
			<td class="f14 namewidth1" align="right">供应商类型：</td>
			<td class="f14 namewidth2" align="left">
				<select name="search_EQ_type.id" class="select2">
					<option value="">全部</option>
					<c:forEach items="${dict}" var="d">
						<option value="${d.id}">${d.key}</option>
					</c:forEach>
				</select>
			</td>
			<td class="f14 namewidth1" align="right">创建时间：</td>
			<td class="f14 namewidth2" align="left">
				<div class="pr vm">
					<input type="text" name="search_GTE_createdTime" class="text_input2 input_close globle_img time" 
						readonly/>-<input type="text" name="search_LTE_createdTime" class="text_input2 input_close globle_img time" readonly/>
				</div>
			</td>
			<td class="f14 namewidth1" align="right">修改时间：</td>
			<td class="f14 namewidth2" align="left">
				<div class="pr vm">
					<input type="text" name="search_GTE_modifiedTime" class="text_input2 input_close globle_img time" 
						readonly/>-<input type="text" name="search_LTE_modifiedTime" class="text_input2 input_close globle_img time" readonly/>
				</div>
			</td>
		</tr>
	</table>
	<tags:paginationparams page="${page}"></tags:paginationparams>
	</form>
	<div class="cb"></div>
	<div class="ml35 mr35 mt10 block cb cb">
		<b class="b1"></b>
		<b class="b2"></b>
		<b class="b3"></b>
		<b class="b4"></b>
		<div class="ie_head">
			<ul class="fl id_table1 mt10 ml10">
				<c:if test="${VS_HAS_FUNCTIONS.supplierDelete}">
				<li>
					<a href="javascript:;" uri="${ctx}/project/supplier/delete.do" class="block c_white lh25 deletesome">
						<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b>
					</a>
				</li>
			</c:if>
			<c:if test="${VS_HAS_FUNCTIONS.supplierAdd}">
				<li>
					<a href="${ctx}/project/supplier/toAddPage.do" class="block c_white lh25 ml10">
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
			<c:if test="${VS_HAS_FUNCTIONS.supplierImport}">
				<li>
					<a href="${ctx}/supplier/imports/toImportPage.do?module=supplier" 
						class="leading_in globle_img block_inline mr10" title="导入"></a>
				</li>
			</c:if>
			<c:if test="${VS_HAS_FUNCTIONS.supplierExport}">
				<li>
					<a href="javascript:;" uri="${ctx}/project/supplier/export.do?TYPE=selected" 
						class="leading_out globle_img block_inline mr10 export" title="导出"></a>
				</li>
			</c:if>
			</ul>
		</div>
	</div>
	<div id="title" style="display:none;z-index:1;background-color: #f5f5f6;" class="ml35 mr35">
		<table class="cb id_table2 w">
			<tr>
				<th width="4%"><input type="checkbox" id="id" class="checkall"/></th>
				<th width="7%">所有者</th>
				<th width="15%">供应商名称</th>
				<th width="8%">供应商类型</th>
				<th width="7%">法人代表</th>
				<th>法人电话</th>
				<th>法人手机</th>
				<th>传真</th>
				<th width="11%" class="sortable orderby" orderby="createdTime">创建时间</th>
				<th width="11%" class="sortable orderby" orderby="modifiedTime">修改时间</th>
				<th width="10%">操作</th>
			</tr>
		</table>
	</div>
	<div class="content ml35 mr35">
		<table class="tablesorter cb id_table2 w pr35">
			<thead>
				<tr id="recordDiv">
					<th width="4%"><input type="checkbox" id="id" class="checkall"/></th>
					<th width="7%">所有者</th>
					<th width="15%">供应商名称</th>
					<th width="8%">供应商类型</th>
					<th width="7%">法人代表</th>
					<th>法人电话</th>
					<th>法人手机</th>
					<th>传真</th>
					<th width="11%" class="sortable orderby" orderby="createdTime">创建时间</th>
					<th width="11%" class="sortable orderby" orderby="modifiedTime">修改时间</th>
					<th width="10%">操作</th>
				</tr>
			</thead>
			<tbody class="list"></tbody>
		</table>
		<div class="pagination cb ml35 mt20 h40"></div>
		<textarea id="template-tbody" class="template template-tbody">
	         {#foreach $T.result as row}
	         <tr class="{$T.row$index%2==1?'':'bg_c_blue'} row w">
	             <td><input type="checkbox" name="id" class="checkitem" value="{$T.row.id}"/></td>
	             <td>{$T.row.owner.realName}</td>
	             <td>
	             	<c:choose>
	                    <c:when test="${VS_HAS_FUNCTIONS.supplierView}">
							<a href="${ctx}/project/supplier/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.name}</a>
						</c:when>
	                    <c:otherwise>{$T.row.name}</c:otherwise>
	                </c:choose>
	            </td>
	            <td>{$T.row.type.key}</td>
	            <td>{$T.row.corporation}</td>
	            <td>{$T.row.phone}</td>
	            <td>{$T.row.mobile}</td>
	            <td>{$T.row.fax}</td>
	            <td>{$T.row.createdTime}</td>
	            <td>{$T.row.modifiedTime}</td>
	            <td align="center">
				<c:if test="${VS_HAS_FUNCTIONS.supplierView}">
					<a href="${ctx}/project/supplier/toViewPage.do?id={$T.row.id}" title="详情" class="s_detail_btn block_inline globle_img ml10"></a>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.supplierModify}">
					<a href="${ctx}/project/supplier/toModifyPage.do?id={$T.row.id}" title="编辑" class="block_inline s_edit_btn globle_img ml10"></a>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.supplierDelete}">
					<a href="javascript:;" uri="${ctx}/project/supplier/delete.do?id={$T.row.id}" title="删除" class="block_inline s_dump_btn globle_img ml10 delete"></a>
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
