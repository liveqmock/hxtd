<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>报表组件</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="${ctx}/static/css/public/common.css?v=${now}" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css?v=${now}" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail_a.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.custom.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/api/api.string.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.form.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/commonAjax.js?v=${now}"></script>
<script type="text/javascript">
$(function () {
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
			$("#dialogConfirm", parent.document).trigger("click");
		}
	});
});
</script>
</head>
<body>
<div class="listcontainer">
	<div class="margin0">
		<form action="${ctx}/common/report/query.do" onsubmit="return false;">
    	<input type="hidden" name="organizationId" value="${orgId}"/>
		<div>
			<table class="w pr10 pl10">
				<tr>
				  <td class="f14" align="right" width="10%">报表名称：</td>
				  <td class="f14" align="left" width="16%"><input type="text" class="text_input1" name="search_LIKE_name" /></td>
				  <td>
				  	<a href="javascript:;" class="reset block dump_btn globle_img fr mr10"></a>
				  	<a href="javascript:;" class="block c_white lh25 fr mr10 submit">
				  		<b class="allbtn_l block fl"></b>
				  		<b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b>
				  	</a>
				  </td>
				  <td class="f14"></td>
    			  <td class="f14"></td>
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
						<table class="w" >
							<tr><td>名称:{$T.row.name}</td></tr>
							<tr><td>模块:{$T.row.module.desc}</td></tr>
							<tr><td>类型:{$T.row.chart.key}</td></tr>
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
