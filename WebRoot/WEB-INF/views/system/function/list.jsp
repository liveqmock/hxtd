<%--
  功能描述：功能管理列表页
  User: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>功能列表</title>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/static/css/recommend/empower.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
<!-- 浮动表头js -->
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript">
$(function(){
	$("#id").click(function(){
		if(this.checked){
		 	$("input:checkbox").attr("checked", true);
		}else{
			$("input:checkbox").removeAttr("checked");
		}
	});
	$(".list :checkbox").live("click", function(e){
		$(".checkall").attr("checked", $(".list :checkbox:not(:checked)").length == 0);
		e.stopPropagation();//jquery 阻止冒泡事件
	});
	
	$.fn.zTree.init($("#tree"), {data: {
						simpleData: {
						enable:true,
						idKey: "id",
						pIdKey: "pId",
						rootPId: ""
						}
					},
					callback: {
								beforeClick: function(treeId, treeNode) {
									var zTree = $.fn.zTree.getZTreeObj("tree");
									if (treeNode.isParent) {
											zTree.expandNode(treeNode);
											return false;
									} else {
											$("#menu_id").val(treeNode.id);
											load();
											return true;
									}}}
    },${tree});
	$("#reload").click(load);
	grid = new Grid().init();
	//folatHead()
});

function load(){
	grid.loadGrid();
}
function formReset(){
	$("#form")[0].reset();
}
</script>
	</head>
	<body>
		<div class="margin0 ml35 mr35">
			<!---左侧-->
			<div class="fl" style="width: 20%">
				<div class="mt20 block cb cb mr20">
					<b class="ba"></b>
					<b class="bb"></b>
					<b class="bc"></b>
					<b class="bd"></b>
					<div class="fl table_blueheadc fl w">
						<h1 class="f14 c_white lh40 ml10 fl">
							菜单信息
						</h1>
						<img width="108" height="50" class="fl" src="${ctx }/static/images/snowflake.png">
					</div>
				</div>
				<div class="cb mb20 mr20 bor_636363" style=" height:495px;">
					<ul id="tree" class="ztree"></ul>
				</div>
			</div>

			<div class="listcontainer fr" style="width: 80%;">
				<form id="form" action="${ctx}/system/function/query.do"
					onsubmit="return false;">
					<table class="fl mt10 w">
						<tr>
							<td class="f14" align="right" width="6%">
								功能编号：
							</td>
							<td class="f14" align="left" width="16%">
								<input type="text" name="search_LIKE_code" id="code"
									class="text_input1" value="" />
							</td>
							<td class="f14" align="right" width="6%">
								功能名：
							</td>
							<td class="f14" align="left" width="16%">
								<input type="text" name="search_LIKE_name" id="name"
									class="text_input1" value="" />
							</td>
							<td class="f14" align="right" width="6%">
								调用入口：
							</td>
							<td class="f14" align="left" width="16%">
								<input type="text" name="search_LIKE_url" id="url"
									class="text_input1" value="" />
								<input type="hidden" id="menu_id" name="search_EQ_menu.id" />
							</td>
							<td width="8%">
								<a href="javascript:void(0)"
									class=" block c_white lh25 submit"><b
									class="allbtn_l block fl"></b><b
									class="allbtn_r pr13 block fl w_auto f14">查&nbsp&nbsp询</b>
								</a>
								<a href="javascript:formReset()"
									class="reset block dump_btn globle_img fl ml10"></a>
							</td>
						</tr>
						<tags:paginationparams page="${page}"></tags:paginationparams>
					</table>
				</form>
				<!--查询条件结束-->
				<div class="cb"></div>

				<div class="mt10 block cb cb">
					<b class="b1"></b>
					<b class="b2"></b>
					<b class="b3"></b>
					<b class="b4"></b>
					<div class="ie_head">
						<ul class="fl id_table1 mt10 ml10">
							<c:if test="${VS_HAS_FUNCTIONS.functionDelete}">
								<li>
									<a href="javascript:;" uri="${ctx}/system/function/delete.do"
										class="block c_white lh25 deletesome"><b
										class="allbtn_l block fl"></b><b
										class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b> </a>
								</li>
							</c:if>
							<c:if test="${VS_HAS_FUNCTIONS.functionAdd}">
								<li>
									<a href="${ctx}/system/function/toAddPage.do"
										class="block c_white lh25 ml10"><b
										class="allbtn_l block fl"></b><b
										class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b> </a>
								</li>
							</c:if>
							<li>
								<a href="javascript:void(0)"
									class="refresh block c_white lh25 ml10"><b
									class="allbtn_l block fl"></b><b
									class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b> </a>
							</li>

						</ul>
					</div>
				</div>
				<!-- 浮动表头html开始 -->
				<div id="title" style="display: none;z-index: 1; background-color: #f5f5f6;"
					class="mr35">
					<table class="cb id_table2 w">
						<tr>
							<th width="4%">
							<input type="checkbox" name="" id="id" class="checkall" />
							</th>
							<th width="10%">
								功能名
							</th>
							<th width="7%">
								功能编号
							</th>
							<th width="10%">
								归属菜单
							</th>
							<th width="16%">
								功能调用入口
							</th>
							<th width="13%" class="sortable orderby" orderby="createdTime">
								创建时间
							</th>
							<th width="7%">
								创建者
							</th>
							<th width="13%" class="sortable orderby" orderby="modifiedTime">
								修改时间
							</th>
							<th width="7%">
								修改者
							</th>
							<th width="12%">
								操作
							</th>
						</tr>
					</table>
				</div>
				<!-- 浮动表头html结束 -->
				<table class="cb id_table2 w tablesorter">
					<tr id="recordDiv">
						<th width="4%">
							<input type="checkbox" name="" id="id" class="checkall" />
						</th>
						<th width="10%">
							功能名
						</th>
						<th width="7%">
							功能编号
						</th>
						<th width="10%">
							归属菜单
						</th>
						<th width="16%">
							功能调用入口
						</th>
						<th width="13%" class="sortable orderby" orderby="createdTime">
							创建时间
						</th>
						<th width="7%">
							创建者
						</th>
						<th width="13%" class="sortable orderby" orderby="modifiedTime">
							修改时间
						</th>
						<th width="7%">
							修改者
						</th>
						<th width="12%">
							操作
						</th>
					</tr>
					<tbody id="tbody" class="list"></tbody>
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
                        <c:when test="${VS_HAS_FUNCTIONS.functionView}">
									<a href="${ctx}/system/function/toViewPage.do?id={$T.row.id}"
										class="toviewpage">{$T.row.name}</a>
								</c:when>
                        <c:otherwise>{$T.row.name}</c:otherwise>
                    </c:choose>
                </td>
                <td>{$T.row.code}</td>
                <td>{$T.row.menu.name}</td>
                <td>{$T.row.url}</td>
                <td>{$T.row.createdTime}</td>
                <td>{$T.row.creator.realName}</td>
                <td>{$T.row.modifiedTime}</td>
                <td>{$T.row.modifier.realName}</td>
                <td>
                        <c:if test="${VS_HAS_FUNCTIONS.functionView}">
                            <a
									href="${ctx}/system/function/toViewPage.do?id={$T.row.id}"
									title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.functionModify}">
                            {#if !$T.row.isInitialized}
                            <a
									href="${ctx}/system/function/toModifyPage.do?id={$T.row.id}"
									title="编辑" class=" block_inline s_edit_btn globle_img ml10"></a>
                            {#/if}
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.functionDelete}">
                            {#if !$T.row.isInitialized}
                            <a href="javascript:void(0)"
									uri="${ctx}/system/function/delete.do?id={$T.row.id}"
									title="删除"
									class="delete block_inline s_dump_btn globle_img ml10"></a>
                            {#/if}
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
