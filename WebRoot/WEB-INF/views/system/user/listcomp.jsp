<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>用户组件列表</title>
<link rel="stylesheet" href="${ctx}/static/css/public/common.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
<link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.custom.js"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/static/js/api/api.string.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.js"></script>
<script type="text/javascript" src="${ctx}/static/js/commonAjax.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript">
$(function(){
	new Grid().init({ paginationSizeShow:false, paginationCountLimit:13 });
	$(".list .module").live({
		click: function(){
			$(".module").removeAttr("style");
			$(this).css({"border":"1px solid #e28d1f"});
			$(".module").removeClass("bor_e28d1f");
			$(this).addClass("bor_e28d1f");
		},
		dblclick: function(){
			$(this).addClass("bor_e28d1f");
			$(".ui-button", parent.document).eq(1).trigger("click");
		}
	});
});
</script>
</head>
<body>
<div class="listcontainer">
	<div class="margin0">
		<form action="${ctx}/system/user/query.do" onsubmit="return false;">
    	<input type="hidden" name="organizationId" value="${orgId}"/>
		<div>
			<table class="w pr10 pl10">
				<tr>
				  <td class="f14" align="right" width="10%">用户名称：</td>
				  <td class="f14" align="left" width="55%"><input type="text" class="text_input1" name="search_LIKE_realName" /></td>
				  <td width="30%">
				  	<a href="javascript:;"class="a_underline fr w_blue mt5 reset">清除</a>
				  	<a href="javascript:;" class="block c_white lh25 fr mr10 submit">
				  		<b class="allbtn_l block fl"></b>
				  		<b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b>
				  	</a>
				  </td>
				</tr>
			</table>
		</div>
    	<tags:paginationparams page="${page}"></tags:paginationparams>
		</form>
		<div style="height: 300px; overflow: hidden; overflow-y:auto;" class="grid">
			<ul class="id_tantable1 w list"></ul>
			<div class="cb ml35 pt20 h40 pagination"></div>
			<textarea id="template-tbody" class="template template-tbody">
			    {#foreach $T.result as row}
				<li>
					<div class="module" id="{$T.row.id}">
						<table class="w">
							<tr>
								<td align="right">用户名：</td>
								<td>{$T.row.realName}</td>
							</tr>
							<tr>
								<td align="right">部门：</td>
								<td>{$T.row.organization.name}</td>
							</tr>
						</table>
					</div>
				</li>
			    {#/for} 
			</textarea>
			<%@include file="/WEB-INF/template/sort.jsp" %>
			<%@include file="/WEB-INF/template/pagination.jsp" %>
		</div>
	</div>
</div>
</body>
</html>