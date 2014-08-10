<%--
  功能描述：线索管理列表页
  User: xiaoli.luo
  Date:2014/5/17
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>销售目标列表</title>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
<script type="text/javascript">${applicationScope.VC_PCAS}</script>
<script type="text/javascript">
$(function() {
	jsUtil.datepicker(".time");//加载时间控件
	jsUtil.datepickerNotNow(".time1");
	$("#id").click(function() {
		if (this.checked) {
			$("input:checkbox").attr("checked", true);
		} else {
			$("input:checkbox").removeAttr("checked");
		}
	});
	
	//首次加载数据
	grid = new Grid().init().bindExport();
});

function load() {
	grid.loadGrid();
}
//复选框点击时事件
function checkOut(box) {
	if (!box.checked) {
		$("#id").removeAttr("checked");
		return false;
	}
	var boxs = $("input[name=id]");
	var flag = true;
	for ( var i = 0; i < boxs.length; i++) {
		if (boxs[i].checked == false) {
			flag = false;
		}
	}
	if (flag) {
		$("#id").attr("checked", true);
	}
}

function reset() {
	$("#form")[0].reset();
	$(".time").val("");
}
</script>
	</head>
	<body>
		<div class="listcontainer">
			<form id="form" action="${ctx}/sales/salesTarget/query.do"
				onsubmit="return false;">
				<table class="fl mt5 w">
					<tr>
						<td class="f14 namewidth1" align="right" >
							标题：
						</td>
						<td class="f14 namewidth2" align="left" >
							<input type="text" class="text_input1" name="search_LIKE_title"
								id="name" value="" />
						</td>
						<td class="f14 namewidth1" align="right" >
							目标人员：
						</td>
						<td class="f14 namewidth2" align="left" >
							<input type="text" class="text_input1" name="search_LIKE_owner.realName"
								id="name" value="" />
						</td>
						<td class="f14 namewidth1" align="right" >
							成交金额（万）：
						</td>
						<td class="f14 namewidth2" align="left" >
							<div class="pr vm">
								<input class="text_input2"
									name="search_GTE_bargainMoney" type="text" 
									/>-<input 
									class="text_input2"
									name="search_LTE_bargainMoney" type="text" />
							</div>
						</td>
						<td class="namewidth3">
							<a class="c_222 block cp fr ml10 globle_img mt8 mr20 more"
								title="展开"></a>
							<a href="javascript:void(0)"
								class="a_underline block_inline fr w_blue mt5 reset">清除</a>
							<a href="javascript:void(0)"
								class="block_inline c_white lh25 fr mr10 submit"><b
								class="allbtn_l block fl"></b><b
								class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b> </a>
						</td>
					</tr>
					<tr class="more-content">
					</tr>
					<tr class="more-content">
						<td class="f14 namewidth1" align="right" >
							创建时间：
						</td>
						<td class="f14 namewidth2" align="left" >
							<div class="pr vm">
								<a href="javascript:;" class="pa time_closenone1"></a>
								<a href="javascript:;" class="pa time_closenone2"></a>
								<input class="text_input2 input_close globle_img time"
									name="search_GTE_createdTime" type="text" 
									readonly />-<input 
									class="text_input2 input_close globle_img time"
									name="search_LTE_createdTime" type="text" readonly />
							</div>
						</td>
						<td class="f14 namewidth1" align="right" >
							修改时间：
						</td>
						<td class="f14 namewidth2" align="left" >
							<div class="pr vm">
								<a href="javascript:;" class="pa time_closenone1"></a>
								<a href="javascript:;" class="pa time_closenone2"></a>
								<input class="text_input2 input_close globle_img time"
									name="search_GTE_modifiedTime" type="text" 
									readonly />-<input 
									class="text_input2 input_close globle_img time"
									name="search_LTE_modifiedTime" type="text" readonly />
							</div>
						</td>
					</tr>
				</table>
				<tags:paginationparams page="${page}"></tags:paginationparams>
			</form>
			<!--查询条件结束-->
			<div class="cb"></div>

			<div class="ml35 mr35 mt20 block cb cb">
				<b class="b1"></b>
				<b class="b2"></b>
				<b class="b3"></b>
				<b class="b4"></b>
				<div class="ie_head">
					<ul class="fl id_table1 mt10 ml10">
						<c:if test="${VS_HAS_FUNCTIONS.salesTargetDelete}">
							<li>
								<a href="javascript:;" uri="${ctx}/sales/salesTarget/delete.do"
									class="deletesome block c_white lh25"><b
									class="allbtn_l block fl"></b><b
									class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b> </a>
							</li>
						</c:if>
						<c:if test="${VS_HAS_FUNCTIONS.salesTargetAdd}">
							<li>
								<a href="${ctx}/sales/salesTarget/toAddPage.do"
									class="block c_white lh25 ml10"><b
									class="allbtn_l block fl"></b><b
									class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b> </a>
							</li>
						</c:if>
						<li>
							<a href="javascript:;" class="refresh block c_white lh25 ml10"><b
								class="allbtn_l block fl"></b><b
								class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b> </a>
						</li>
					</ul>
					<ul class="fr id_table1 mt10 ml10">
					<c:if test="${VS_HAS_FUNCTIONS.salesTargetExport}">
								<li>
									<a href="javascript:void(0)"
										uri="${ctx}/sales/salesTarget/export.do?TYPE=selected"
										class="leading_out globle_img block_inline mr10 export"
										title="导出"></a>
								</li>
					</c:if>
					</ul>
				</div>
			</div>
			<div id="title" style="display: none;z-index: 1; background-color: #f5f5f6;"
				class=" ml35 mr35">
				<table class="cb id_table2 w ">
					<tr id="recordDiv">
						<th>
							<input type="checkbox" name="" class="checkall" id="id" />
						</th>
						<th>
							标题
						</th>
						<th>
							目标人员
						</th>
						<th>
							目标成交额（万）
						</th>
						<th width="4%">
							创建者
						</th>
						<th width="12%" class="sortable orderby" orderby="createdTime">
							创建时间
						</th>
						<th width="4%">
							修改者
						</th>
						<th width="12%" class="sortable orderby" orderby="modifiedTime">
							最后修改时间
						</th>
						<th width="12%" align="center">
							操作
						</th>
					</tr>
				</table>
			</div>
			<div class="ml35 mr35 content">
				<table class="cb id_table2 w   tablesorter" id="table">
					<tr id="recordDiv">
						<th>
							<input type="checkbox" name="" class="checkall" id="id" />
						</th>
						<th>
							标题
						</th>
						<th>
							目标人员
						</th>
						<th>
							目标成交额（万）
						</th>
						<th width="4%">
							创建者
						</th>
						<th width="12%" class="sortable orderby" orderby="createdTime">
							创建时间
						</th>
						<th width="4%">
							修改者
						</th>
						<th width="12%" class="sortable orderby" orderby="modifiedTime">
							最后修改时间
						</th>
						<th width="12%" align="center">
							操作
						</th>
					</tr>
					<tbody class="list"></tbody>
				</table>
				<div class="pagination cb ml35 mt20 h40 "></div>
				<textarea id="template-tbody" class="template template-tbody">
            {#foreach $T.result as row}
            <tr class="{$T.row$index%2==1?'':'bg_c_blue'} row w">
                <td>
							<input type="checkbox" name="id" class="checkitem"
								value="{$T.row.id}" />
						</td>
                <td>
                    <c:choose>
                        <c:when test="${VS_HAS_FUNCTIONS.salesTargetView}">
									<a href="${ctx}/sales/salesTarget/toViewPage.do?id={$T.row.id}"
										class="toviewpage">{$T.row.title}</a>
								</c:when>
                        <c:otherwise>{$T.row.code}</c:otherwise>
                    </c:choose>
                </td>
                <td>{$T.row.owner.realName}</td>
                <td>{$T.row.bargainMoney}</td>
                <td>{$T.row.creator.realName}</td>
                <td>{$T.row.createdTime}</td>
                <td>{$T.row.modifier.realName}</td>
                <td>{$T.row.modifiedTime}</td>
                <td align="center">
                        <c:if test="${VS_HAS_FUNCTIONS.salesTargetView}">
                            <a
									href="${ctx}/sales/salesTarget/toViewPage.do?id={$T.row.id}"
									title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.salesTargetModify}">
                            <a
									href="${ctx}/sales/salesTarget/toModifyPage.do?id={$T.row.id}"
									title="编辑" class=" block_inline s_edit_btn globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.salesTargetAdd}">
                            <a
									href="${ctx}/sales/salesTarget/toAddPage.do?type=second&id={$T.row.id}"
									title="复制目标" class=" block_inline s_copy globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.salesTargetDelete}">
                            <a href="javascript:void(0)"
									uri="${ctx}/sales/salesTarget/delete.do?id={$T.row.id}" title="删除"
									class="delete  block_inline s_dump_btn globle_img ml10"></a>
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
