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
		<link rel="stylesheet" href="${ctx}/static/css/application.css"
			type="text/css" />
		<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css"
			type="text/css" />
		<script type="text/javascript"
			src="${ctx}/static/js/jquery-json.2.4.js">
</script>
		<script type="text/javascript"
			src="${ctx}/static/js/jquery-jtemplates.js">
</script>
		<script type="text/javascript"
			src="${ctx}/static/js/js-util.common.js">
</script>
		<script type="text/javascript"
			src="${ctx}/static/js/scrollTitle.js?v=1">
</script>
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
	/**
	 * 单击更改所有者按钮时执行
	 */

	$("#modifyOwner").click(function() {

		var box = $("input(name=id):checked");
		if (box.length == 0) {
			jsUtil.alert("请选择数据");
			return false;
		}
		var url, title;
		url = "${ctx}/system/user/toQueryPage.comp";
		title = "所有者";
		jsUtil.dialogIframe(url, title, 800, 465, convOwner);
	});
	//给刷新按钮绑定重新加载的事件
	$("#reload").click(load);
	//首次加载数据
	grid = new Grid().init().bindExport();
	
});
function convOwner() {
	var ckObj = $(":checked", window.frames["dialogIframe"].document);
	if (ckObj.length > 0) {
		var boxs = $("input(name=id):checked");
		var param = $.param(boxs) + "&ownerId=" + ckObj.val();
		RcmsAjax.ajax(jsUtil.getRootPath() + '/customer/lead/modifyOwner.do',
				function() {
					load();
				}, null, param);
	}
}
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
function childFun(node) {//树菜单子节点点击时事件
	$("#source").text(node.name);
	$("#sourceId").val(node.id);
}
function reset() {
	$("#form")[0].reset();
}
</script>
	</head>
	<body>
		<div class="listcontainer">
			<form id="form" action="${ctx}/customer/lead/query.do"
				onsubmit="return false;">
				<table class="fl mt5 w">
					<tr>
						<td class="f14" align="right" width="7%">
							线索名称：
						</td>
						<td class="f14" align="left" width="13%">
							<input type="text" class="text_input1" name="search_LIKE_name"
								id="name" value="" />
						</td>
						<td class="f14" align="right" width="7%">修改时间：</td>
    <td class="f14" align="left" width="18%">
    			<div class="pr vm">
	    			<a href="javascript:;" class="pa time_closenone1" onclick="javascript:$(this).nextAll().eq(1).val('');"></a>
	    			<a href="javascript:;" class="pa time_closenone2" onclick="javascript:$(this).nextAll().eq(1).val('');"></a>
	    			<input class="text_input2 input_close globle_img time" name="search_GTE_modifiedTime" type="text" readonly/>
	    			-<input class="text_input2 input_close globle_img time" name="search_LTE_modifiedTime" type="text" readonly/>
    			</div>
    </td>
						<td class="f14" align="right" width="7%">
							线索来源：
						</td>
						<td class="f14" align="left" width="13%">
							<select name="search_EQ_source.id" class="select2">
								<option value="">
									--全部--
								</option>
								<c:forEach items="${dict}" var="d">
									<option value="${d.id}">
										${d.key}
									</option>
								</c:forEach>
							</select>
						</td>
						<td width="15%">
							<a href="javascript:void(0)"
								class="ml35 block c_white lh25 submit"><b
								class="allbtn_l block fl"></b><b
								class="allbtn_r pr13 block fl w_auto f14">查&nbsp&nbsp询</b>
							</a>
							<a href="javascript:formReset()"
								class="reset block dump_btn globle_img fl ml10"></a>
						</td>
						<td class="f14" align="right" width="7%"></td>
						<td class="f14" align="left" width="13%"></td>
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
						<c:if test="${VS_HAS_FUNCTIONS.leadDelete}">
							<li>
								<a href="javascript:;" uri="${ctx}/customer/lead/delete.do"
									class="deletesome block c_white lh25"><b
									class="allbtn_l block fl"></b><b
									class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b>
								</a>
							</li>
						</c:if>
						<c:if test="${VS_HAS_FUNCTIONS.leadAdd}">
							<li>
								<a href="${ctx}/customer/lead/toAddPage.do"
									class="block c_white lh25 ml10"><b
									class="allbtn_l block fl"></b><b
									class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b>
								</a>
							</li>
						</c:if>
						<li>
							<a href="javascript:;" class="submit block c_white lh25 ml10"><b
								class="allbtn_l block fl"></b><b
								class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b>
							</a>
						</li>
						<li>
							<a href="javascript:void(0)" id="modifyOwner"
								class="block c_white lh25 ml10"><b class="allbtn_l block fl"></b><b
								class="allbtn_r pr13 block fl w_auto f14">更改所有者</b>
							</a>
						</li>
						<li>
							<a href="javascript:void(0)"
								uri="${ctx}/customer/lead/export.do?TYPE=pagination"
								class="block c_white ml10 lh25 mr10 export">
								<b class="allbtn_l block fl"></b>
								<b class="allbtn_r pr13 block fl w_auto f14">导&nbsp;出</b>
							</a>
						</li>
						<!--<a href="javascript:void(0)" id="transfer" class="blue_btn">转换</a>
		<a href="javascript:void(0)" id="import" class="blue_btn">导入</a>
		<a href="javascript:void(0)" id="export" class="blue_btn">导出</a>
		<a href="javascript:void(0)" id="print" class="blue_btn">打印</a>
		 -->
					</ul>
				</div>
			</div>
			<div id="title" style="display: none; background-color: #f5f5f6;"
				class=" ml35 mr35">
				<table class="cb id_table2 w">
					<tr>
						<th>
							<input type="checkbox" name="" class="checkall" id="id" />
						</th>
						<th>
							线索名称
						</th>
						<th>
							所有者
						</th>
						<th>
							公司
						</th>
						<th>
							来源
						</th>
						<th>
							银行卡类型
						</th>
						<th>
							状态
						</th>
						<th width="12%" class="sortable orderby" orderby="createdTime">
							创建时间
						</th>
						<th width="4%">
							创建者
						</th>
						<th width="12%" class="sortable orderby" orderby="modifiedTime">
							修改时间
						</th>
						<th width="4%">
							修改者
						</th>
						<th width="12%" align="center">
							操作
						</th>
					</tr>
				</table>
			</div>
			<div class="ml35 mr35 content">
				<table class="cb id_table2 w  tablesorter" id="table">
					<tr id="recordDiv">
						<th>
							<input type="checkbox" name="" class="checkall" id="id" />
						</th>
						<th>
							线索名称
						</th>
						<th>
							所有者
						</th>
						<th>
							公司
						</th>
						<th>
							来源
						</th>
						<th>
							银行卡类型
						</th>
						<th>
							状态
						</th>
						<th width="12%" class="sortable orderby" orderby="createdTime">
							创建时间
						</th>
						<th width="4%">
							创建者
						</th>
						<th width="12%" class="sortable orderby" orderby="modifiedTime">
							修改时间
						</th>
						<th width="4%">
							修改者
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
                        <c:when test="${VS_HAS_FUNCTIONS.leadView}">
									<a href="${ctx}/customer/lead/toViewPage.do?id={$T.row.id}"
										class="toviewpage">{$T.row.name}</a>
								</c:when>
                        <c:otherwise>{$T.row.name}</c:otherwise>
                    </c:choose>
                </td>
                <td>{$T.row.owner.realName}</td>
                <td>{$T.row.company}</td>
                <td>{$T.row.source.key}</td>
                <td>{$T.row.cardType.key}</td>
                <td>{$T.row.status.key}</td>
                <td>{$T.row.createdTime}</td>
                <td>{$T.row.creator.realName}</td>
                <td>{$T.row.modifiedTime}</td>
                <td>{$T.row.modifier.realName}</td>
                <td align="center">
                        <c:if test="${VS_HAS_FUNCTIONS.leadView}">
                            <a
									href="${ctx}/customer/lead/toViewPage.do?id={$T.row.id}"
									title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.leadModify}">
                            <a
									href="${ctx}/customer/lead/toModifyPage.do?id={$T.row.id}"
									title="编辑" class=" block_inline s_edit_btn globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.leadDelete}">
                            <a href="javascript:void(0)"
									uri="${ctx}/customer/lead/delete.do?id={$T.row.id}" title="删除"
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
