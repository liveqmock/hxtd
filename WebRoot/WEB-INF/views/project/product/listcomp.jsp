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
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
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
<style>
.module1{height: 80px;background:url(${ctx}/static/images/System_bg.png) repeat-x; border: 1px solid #c2c2c2;margin: 5px 5px 0 0; padding:5px; width:90%;}
</style>
<script type="text/javascript">
$(function(){
	new Grid().init();
	$(".list .module1").live({
		click: function(){
			$(".module1").removeAttr("style");
			$(this).css({"border":"1px solid #e28d1f"});
			$(".module1").removeClass("bor_e28d1f");
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
		<form action="${ctx}/project/product/searchProduct.docomp" onsubmit="return false;">
    	<input type="hidden" name="search_GT_saleEndTime" value="${saleEndTime}"/>
		<div>
			<table class="w pr10 pl10">
				<tr>
				  <td class="f14" align="right" width="10%">产品编号：</td>
				  <td class="f14" align="left" width="30%"><input type="text" class="text_input1" name="search_LIKE_code" /></td>
				  <td class="f14" align="right" width="10%">产品名称：</td>
				  <td class="f14" align="left" width="30%"><input type="text" class="text_input1" name="search_LIKE_name" /></td>
				  <td width="20%">
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
					<div class="module1" id="{$T.row.id}">
						<table class="w">
							<tr>
								<td>{$T.row.name}</td>
							</tr>
							<tr>
								<td>起售金额（万）:{$T.row.sellMoney}</td>
							</tr>
							<tr>
								<td>利率:{$T.row.rate}%</td>
							</tr>
							<tr>
								<td>赎回公式:{$T.row.redeemFormula}</td>
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