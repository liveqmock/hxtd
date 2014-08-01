<%--
  工作台描述：工作台管理列表页
  User: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>工作台列表</title>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript" src="${ctx}/static/component/open-flash-chart-2/js/json/json2.js"></script>
<script type="text/javascript" src="${ctx}/static/component/open-flash-chart-2/js/swfobject.js"></script>
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
	grid = new Grid().init({paginationActive:false});
});
</script>
</head>
<body>
<div class="listcontainer">
	<form id="form" action="${ctx}/workbanch/query.do"
		onsubmit="return false;">
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
					<li>
						<a href="javascript:;" uri="${ctx}/workbanch/delete.do"
							class="deletesome block c_white lh25"><b
							class="allbtn_l block fl"></b><b
							class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b>
						</a>
					</li>
					<li>
						<a href="${ctx}/workbanch/toAddPage.do"
							class="block c_white lh25 ml10"><b
							class="allbtn_l block fl"></b><b
							class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b>
						</a>
					</li>
				<li>
					<a href="javascript:;" class="refresh block c_white lh25 ml10"><b
						class="allbtn_l block fl"></b><b
						class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b>
					</a>
				</li>
			</ul>
		</div>
	</div>

	<!-- 浮动表头html开始 -->
	<div id="title" style="display: none;z-index: 1; background-color: #f5f5f6;"
		class="mr35">
		<table class="cb id_table2 w">
			<tr>
				<th width="3%">
					<input type="checkbox" name="" id="id" class="checkall" />
				</th>
				<th>
					标题
				</th>
				<th>
					类型
				</th>
				<th>
					创建时间
				</th>
				<th>
					修改时间
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
					<th width="3%">
						<input type="checkbox" name="" id="id" class="checkall" />
					</th>
					<th>
						标题
					</th>
					<th>
						类型
					</th>
					<th>
						创建时间
					</th>
					<th>
						修改时间
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
                  {$T.row.title}
              </td>
              <td>{$T.row.type=='list'?'列表':'报表'}</td>
              <td>{$T.row.createdTime}</td>
              <td>{$T.row.modifiedTime}</td>
              <td width="68">
                         <a href="javascript:void(0)"
							uri="${ctx}/workbanch/delete.do?id={$T.row.id}"
							title="删除"
							class="delete block_inline s_dump_btn globle_img ml10"></a>
              </td>
          </tr>
          {#/for}
      </textarea>
	</div>
</div>
</body>
</html>
