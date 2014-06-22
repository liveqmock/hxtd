<%--
  功能描述：组件管理列表页
  User: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>功能列表</title>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript">
$(function() {
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
	$("#reload").click(load);
	grid = new Grid().init();
});
function load() {
	//$("#id").removeAttr("checked");
	//jsUtil.page.loadData('010701',result2html);
	grid.loadGrid();
}
function formReset() {
	$("#form")[0].reset();
}
</script>
</head>
<body>
<div class="listcontainer">
	<form id="form" action="${ctx}/system/component/query.do"
		onsubmit="return false;">
		<table class="fl mt5 w">
			<tr>
				<td class="f14" align="right" width="6%">
					组件编号：
				</td>
				<td class="f14" align="left" width="16%">
					<input type="text" name="search_LIKE_code" id="code"
						class="text_input1" value="" />
				</td>
				<td class="f14" align="right" width="6%">
					组件名：
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
				</td>
				<td width="8%">
					<a href="javascript:void(0)"
						class=" block c_white lh25 submit">
						<b class="allbtn_l block fl"></b>
						<b class="allbtn_r pr13 block fl w_auto f14">查&nbsp&nbsp询</b>
					</a>
					<a href="javascript:formReset()"
						class="reset block dump_btn globle_img fl ml10"></a>
				</td>
				<td class="f14" align="right" width="6%">
				</td>
				<td class="f14" align="left" width="16%">
				</td>
			</tr>
		</table>
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
				<c:if test="${VS_HAS_FUNCTIONS.componentDelete}">
					<li>
						<a href="javascript:;" uri="${ctx}/system/component/delete.do"
							class="deletesome block c_white lh25"><b
							class="allbtn_l block fl"></b><b
							class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b>
						</a>
					</li>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.componentAdd}">
					<li>
						<a href="${ctx}/system/component/toAddPage.do"
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
			</ul>
		</div>
	</div>

	<!-- 浮动表头html开始 -->
	<div id="title" style="display: none; background-color: #f5f5f6;"
		class="mr35">
		<table class="cb id_table2 w">
			<tr>
				<th>
					<input type="checkbox" name="" id="id" class="checkall" />
				</th>
				<th>
					组件名
				</th>
				<th>
					编号
				</th>
				<th width="18%">
					调用入口
				</th>
				<th>
					权限级别
				</th>
				<th class="sortable orderby" orderby="createdTime">
					创建时间
				</th>
				<th>
					创建者
				</th>
				<th class="sortable orderby" orderby="modifiedTime">
					修改时间
				</th>
				<th>
					修改者
				</th>
				<th>
					操作
				</th>
			</tr>
		</table>
	</div>
	<!-- 浮动表头html结束 -->
	<div class="ml35 mr35 content">
		<table cellspacing="1" class="tablesorter cb id_table2 w pr35"
			id="table">
			<thead>
				<tr>
					<th>
						<input type="checkbox" name="" id="id" class="checkall" />
					</th>
					<th>
						组件名
					</th>
					<th>
						编号
					</th>
					<th width="18%">
						调用入口
					</th>
					<th>
						权限级别
					</th>
					<th class="sortable orderby" orderby="createdTime">
						创建时间
					</th>
					<th>
						创建者
					</th>
					<th class="sortable orderby" orderby="modifiedTime">
						修改时间
					</th>
					<th>
						修改者
					</th>
					<th>
						操作
					</th>
				</tr>
			</thead>
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
                      <c:when test="${VS_HAS_FUNCTIONS.componentView}">
							<a href="${ctx}/system/component/toViewPage.do?id={$T.row.id}"
								class="toviewpage">{$T.row.name}</a>
						</c:when>
                      <c:otherwise>{$T.row.name}</c:otherwise>
                  </c:choose>
              </td>
              <td>{$T.row.code}</td>
              <td>{$T.row.url}</td>
              <td>{$T.row.privilegeLevel.key}</td>
              <td>{$T.row.createdTime}</td>
              <td>{$T.row.creator.realName}</td>
              <td>{$T.row.modifiedTime}</td>
              <td>{$T.row.modifier.realName}</td>
              <td width="68">
                      <c:if test="${VS_HAS_FUNCTIONS.componentView}">
                         <a
							href="${ctx}/system/component/toViewPage.do?id={$T.row.id}"
							title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
                      </c:if>
                      <c:if test="${VS_HAS_FUNCTIONS.componentModify}">
                         <a
							href="${ctx}/system/component/toModifyPage.do?id={$T.row.id}"
							title="编辑" class=" block_inline s_edit_btn globle_img ml10"></a>
                      </c:if>
                      <c:if test="${VS_HAS_FUNCTIONS.componentDelete}">
                         <a href="javascript:void(0)"
							uri="${ctx}/system/component/delete.do?id={$T.row.id}"
							title="删除"
							class="delete block_inline s_dump_btn globle_img ml10"></a>
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
