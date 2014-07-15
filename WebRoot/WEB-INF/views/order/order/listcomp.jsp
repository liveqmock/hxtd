<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>订单组件列表</title>
<link rel="stylesheet" href="${ctx}/static/css/public/common.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
<link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.custom.js"></script>
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
		<form action="${ctx}/order/order/query.do" onsubmit="return false;">
		<div>
			<table class="w pr10 pl10">
				<tr>
				  <td class="f14" align="right" width="10%">订单编号：</td>
				  <td class="f14" align="left" width="16%"><input type="text" class="text_input1" name="search_LIKE_code" /></td>
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
						<table class="w mt10">
							<tr><td>{$T.row.code}</td></tr>
							<tr><td>{$T.row.customer.name}</td></tr>
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