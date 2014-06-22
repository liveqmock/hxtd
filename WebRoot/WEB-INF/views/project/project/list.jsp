<%--
  项目描述：项目管理列表页
  project: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>项目列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1">
</script>
<script type="text/javascript">
$(function() {
	//加载时间控件
	jsUtil.datepicker(".time");
	//全选/全不选
	$("#id").click(function() {
		if (this.checked) {
			$("input:checkbox").attr("checked", true);
		} else {
			$("input:checkbox").removeAttr("checked");
		}
	});
	$(".list :checkbox").live(
			"click",
			function(e) {
				$(".checkall").attr("checked",
						$(".list :checkbox:not(:checked)").length == 0);
				e.stopPropagation();//jquery 阻止冒泡事件
			});
	//给刷新按钮绑定重新加载的事件
	$("#reload").click(load);
	//首次加载数据
	grid = new Grid().init();
});
//树菜单子节点点击时事件
//加载数据的方法
function load() {
	//$("#id").removeAttr("checked");
	//jsUtil.page.loadData('050101',result2html);
	grid.loadGrid();
}
function formReset() {
	$("#form")[0].reset();
	$("#typeId").removeAttr("value");
}
</script>
</head>
<body>
<div class="listcontainer">
<form id="form" action="${ctx}/project/project/query.do" onsubmit="return false;">
		<table class="fl mt5 w">
			<tr>
				<td class="f14" align="right" width="6%">
					项目名：
				</td>
				<td class="f14" align="left" width="16%">
					<input type="text" name="search_LIKE_name" id="name"
						class="text_input1" value="" />
				</td>
				<td class="f14" align="right" width="6%">
					项目编号：
				</td>
				<td class="f14" align="left" width="16%">
					<input type="text" name="search_LIKE_code" id="name"
						class="text_input1" value="" />
				</td>
				<td class="f14" align="right" width="6%">
					供应商：
				</td>
				<td class="f14" align="left" width="16%">
					<input type="text" name="search_LIKE_supplier.name" id="name"
						class="text_input1" value="" />
				</td>
				<td class="f14" align="right" width="6%">
					支付方式：
				</td>
				<td class="f14" align="left" width="16%">
					<input type="text" name="search_LIKE_payType" id="name"
						class="text_input1" value="" />
				</td>
				<td width="8%">
					<a href="javascript:void(0)" class="block c_white lh25 submit"><b
						class="allbtn_l block fl"></b><b
						class="allbtn_r pr13 block fl w_auto f14">查&nbsp&nbsp询</b> </a>
					<a href="javascript:formReset()"
						class="reset block dump_btn globle_img fl ml10"></a>
				</td>
			</tr>
			<tr>
				<td class="f14" align="right" width="6%">
					融资额度：
				</td>
				<td class="f14" align="left" width="16%">
					<input class="text_input2" name="search_GTE_financeLimit"
						type="text" />
					-
					<input class="text_input2" name="search_LTE_financeLimit"
						type="text" />
				</td>
				<td class="f14" align="right" width="6%">
					融资周期：
				</td>
				<td class="f14" align="left" width="16%">
					<input class="text_input2" name="search_GTE_financeCycle"
						type="text" />
					-
					<input class="text_input2" name="search_LTE_financeCycle"
						type="text" />
				</td>
				<td class="f14" align="right" width="6%">
					收益率%：
				</td>
				<td class="f14" align="left" width="16%">
					<input class="text_input2" name="search_GTE_er" type="text" />
					-
					<input class="text_input2" name="search_LTE_er" type="text" />
				</td>
				<td class="f14" align="right" width="6%">
					赎回率%：
				</td>
				<td class="f14" align="left" width="16%">
					<input class="text_input2" name="search_GTE_aer" type="text" />
					-
					<input class="text_input2" name="search_LTE_aer" type="text" />
				</td>
			</tr>
			<tr>
				<td class="f14" align="right" width="6%">
					开放时间：
				</td>
				<td class="f14" align="left" width="16%">
					<input class="text_input2 input_close globle_img time"
						name="search_GTE_beginTime" type="text" />
					-
					<input class="text_input2 input_close globle_img time"
						name="search_LTE_beginTime" type="text" />
				</td>
				<td class="f14" align="right" width="6%">
					创建时间：
				</td>
				<td class="f14" align="left" width="16%">
					<input class="text_input2 input_close globle_img time"
						name="search_GTE_createdTime" type="text" />
					-
					<input class="text_input2 input_close globle_img time"
						name="search_LTE_createdTime" type="text" />
				</td>
				<td class="f14" align="right" width="6%">
					修改时间：
				</td>
				<td class="f14" align="left" width="16%">
					<input class="text_input2 input_close globle_img time"
						name="search_GTE_modifiedTime" type="text" />
					-
					<input class="text_input2 input_close globle_img time"
						name="search_LTE_modifiedTime" type="text" />
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
				<c:if test="${VS_HAS_FUNCTIONS.projectDelete}">
					<li>
						<a href="javascript:;" uri="${ctx}/project/project/delete.do"
							class="block c_white lh25 deletesome"><b
							class="allbtn_l block fl"></b><b
							class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b> </a>
					</li>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.projectAdd}">
					<li>
						<a href="${ctx}/project/project/toAddPage.do"
							class="block c_white lh25 ml10"><b
							class="allbtn_l block fl"></b><b
							class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b> </a>
					</li>
				</c:if>
				<li>
					<a href="javascript:void(0)"
						class="submit block c_white lh25 ml10"><b
						class="allbtn_l block fl"></b><b
						class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b> </a>
				</li>
			</ul>
		</div>
	</div>
	<div id="title" style="display: none; background-color: #f5f5f6;"
		class=" ml35 mr35">
		<table class="cb id_table2 w">
			<tr>
				<td width="2%">
					<input type="checkbox" id="id" class="checkall" />
				</td>
				<th width="10%">
					项目名
				</th>
				<th width="5%">
					项目编号
				</th>
				<th>
					供应商
				</th>
				<th>
					融资额度
				</th>
				<th class="sortable orderby" orderby="createdTime">
					创建时间
				</th>
				<th width="10%">
					创建者
				</th>
				<th class="sortable orderby" orderby="modifiedTime">
					修改时间
				</th>
				<th>
					修改者
				</th>
				<th width="15%">
					操作
				</th>
			</tr>
		</table>
	</div>

	<div class="ml35 mr35">
		<table class="cb id_table2 w pr35" cellspacing="1"
			class="tablesorter" id="table">
			<tr id="recordDiv">
				<td width="2%">
					<input type="checkbox" id="id" class="checkall" />
				</td>
				<th width="10%">
					项目名
				</th>
				<th width="5%">
					项目编号
				</th>
				<th>
					供应商
				</th>
				<th>
					融资额度
				</th>
				<th class="sortable orderby" orderby="createdTime">
					创建时间
				</th>
				<th width="10%">
					创建者
				</th>
				<th class="sortable orderby" orderby="modifiedTime">
					修改时间
				</th>
				<th>
					修改者
				</th>
				<th width="15%">
					操作
				</th>
			</tr>
			<tbody class="list"></tbody>
		</table>
		<div class="pagination  cb ml35 mt20 h40 "></div>
		<textarea id="template-tbody" class="template template-tbody">
          {#foreach $T.result as row}
          <tr class="{$T.row$index%2==1?'':'bg_c_blue'} row w">
              <td>
					<input type="checkbox" name="id" class="checkitem"
						value="{$T.row.id}" />
				</td>
              <td>
                  <c:choose>
                      <c:when test="${VS_HAS_FUNCTIONS.projectView}">
							<a href="${ctx}/project/project/toViewPage.do?id={$T.row.id}"
								class="toviewpage">{$T.row.name}</a>
						</c:when>
                      <c:otherwise>{$T.row.name}</c:otherwise>
                  </c:choose>
              </td>
              <td>{$T.row.code}</td>
              <td>{$T.row.supplier.name}</td>
              <td>{$T.row.financeLimit}</td>
              <td>{$T.row.createdTime}</td>
              <td>{$T.row.creator.realName}</td>
              <td>{$T.row.modifiedTime}</td>
              <td>{$T.row.modifier.realName}</td>
              <td>
                      <c:if test="${VS_HAS_FUNCTIONS.projectView}">
                        <a
							href="${ctx}/project/project/toViewPage.do?id={$T.row.id}"
							title="详情" class="block_inline s_detail_btn globle_img ml10"></a>
                      </c:if>
                      <c:if test="${VS_HAS_FUNCTIONS.projectModify}">
                        <a
							href="${ctx}/project/project/toModifyPage.do?id={$T.row.id}"
							title="编辑" class="block_inline s_edit_btn globle_img ml10"></a>
                      </c:if>
                      <c:if test="${VS_HAS_FUNCTIONS.projectDelete}">
                        <a href="javascript:void(0)"
							uri="${ctx}/project/project/delete.do?id={$T.row.id}"
							title="删除"
							class="delete  block_inline s_dump_btn globle_img ml10"></a>
                      </c:if>
              </td>
          </tr>
          {#/for} 
      </textarea>
		<%@include file="/WEB-INF/template/sort.jsp"%>
		<%@include file="/WEB-INF/template/pagination.jsp"%>
		<div id="tableFoot"></div>
	</div>
</div>
</body>
</html>
