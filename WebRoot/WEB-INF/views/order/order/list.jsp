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
<title>线索列表</title>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
<script type="text/javascript">${applicationScope.VC_PCAS}</script>
<script type="text/javascript">
$(function() {
	jsUtil.datepicker(".time");//加载时间控件
	/**
	 * table中的复选框全选/全不选
	 * @memberOf {TypeName} 
	 */
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
			<form id="form" action="${ctx}/order/order/query.do"
				onsubmit="return false;">
				<table class="fl mt5 w">
					<tr>
						<td class="f14 namewidth1" align="right" >
							线索名称：
						</td>
						<td class="f14 namewidth2" align="left" >
							<input type="text" class="text_input1" name="search_LIKE_name"
								id="name" value="" />
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
						
					</tr>
					<tr class="more-content">
						
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
						<c:if test="${VS_HAS_FUNCTIONS.orderDelete}">
							<li>
								<a href="javascript:;" uri="${ctx}/order/order/delete.do"
									class="deletesome block c_white lh25"><b
									class="allbtn_l block fl"></b><b
									class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b> </a>
							</li>
						</c:if>
						<c:if test="${VS_HAS_FUNCTIONS.orderAdd}">
							<li>
								<a href="${ctx}/order/order/toAddPage.do"
									class="block c_white lh25 ml10"><b
									class="allbtn_l block fl"></b><b
									class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b> </a>
							</li>
						</c:if>
						<li>
							<a href="javascript:;" class="submit block c_white lh25 ml10"><b
								class="allbtn_l block fl"></b><b
								class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b> </a>
						</li>
					</ul>
					<ul class="fr id_table1 mt10 ml10">
					<c:if test="${VS_HAS_FUNCTIONS.orderExport}">
								<li>
									<a href="javascript:void(0)"
										uri="${ctx}/order/order/export.do?TYPE=pagination"
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
							订单编号
						</th>
						<th>
							客户
						</th>
						<th>
							金额
						</th>
						<th>
							产品
						</th>
						<th width="4%">
							状态
						</th>
						<th>
							所有者
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
							订单编号
						</th>
						<th>
							客户
						</th>
						<th>
							金额
						</th>
						<th>
							产品
						</th>
						<th width="4%">
							状态
						</th>
						<th>
							所有者
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
                        <c:when test="${VS_HAS_FUNCTIONS.orderView}">
									<a href="${ctx}/order/order/toViewPage.do?id={$T.row.id}"
										class="toviewpage">{$T.row.code}</a>
								</c:when>
                        <c:otherwise>{$T.row.code}</c:otherwise>
                    </c:choose>
                </td>
                <td>{$T.row.customer.name}</td>
                <td>{$T.row.purchaseMoney}</td>
                <td>{$T.row.product.name}</td>
                <td>{$T.row.status.key}</td>
                <td>{$T.row.owner.realName}</td>
                <td>{$T.row.creator.realName}</td>
                <td>{$T.row.createdTime}</td>
                <td>{$T.row.modifier.realName}</td>
                <td>{$T.row.modifiedTime}</td>
                <td align="center">
                        <c:if test="${VS_HAS_FUNCTIONS.orderView}">
                            <a
									href="${ctx}/order/order/toViewPage.do?id={$T.row.id}"
									title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.orderModify}">
                            <a
									href="${ctx}/order/order/toModifyPage.do?id={$T.row.id}"
									title="编辑" class=" block_inline s_edit_btn globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.orderDelete}">
                            <a href="javascript:void(0)"
									uri="${ctx}/order/order/delete.do?id={$T.row.id}" title="删除"
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
