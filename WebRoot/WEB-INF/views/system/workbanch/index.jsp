<%--
  User:luanruisong
  Date:2014/5/5
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>工作台</title>
<style>
.gbin1-list{list-style:none;padding:0;margin:0;}
.gbin1-list li{float:left;text-align:center;margin:5px;font-family: arial;padding:0px;}
</style>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/static/css/recommend/empower.css" type="text/css" />
<script src="${ctx}/static/js/workbanch.js" type="text/javascript"></script>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/static/component/open-flash-chart-2/js/json/json2.js"></script>
<script type="text/javascript" src="${ctx}/static/component/open-flash-chart-2/js/swfobject.js"></script>
<script>
$(function(){
	$('.gbin1-list').sortable({
		opacity: 0.5,//拖动的透明度
		revert: true, //缓冲效果
		cursor: 'move', //拖动的时候鼠标样式
		connectWith: ".column",
		scroll: false,
		update:function() {
			workbanch.modifyOrder();
		}
	});
   	workbanch.initList();
   	workbanch.initReport();
});
</script>
</head>
<body>
<div style="margin:20px;overflow:hidden">
	<ul class="gbin1-list">
		<c:forEach items="${list }" var="work" varStatus="s">
			<li id="${work.id }" style="width: ${work.width}"
			uri="${ctx}${work.url}" module="${work.module}"
			type="${work.type}" params="${work.params}">
				<div class="block cb">
					<b class="ba"></b>
					<b class="bb"></b>
					<b class="bc"></b>
					<b class="bd"></b>
					<div class="fl table_blueheadc fl w" style="height: 25px;">
						<h1 class="f14 c_white lh25 ml10 fl">
							 ${work.title}
						</h1>
						<img width="80" height="25" class="fl ml80" src="${ctx }/static/images/snowflake.png"/>

						<div class="fr mr10 mt5">
							<a href="javascript:;" class=" block_inline g_small globle_img ml10 close"></a>
							<a href="javascript:;" class=" block_inline g_new globle_img ml10 refresh"></a>
							<a href="javascript:;" class=" block_inline g_close globle_img ml10 delete"></a>
						</div>
					</div>
				</div>
				<div class="cb mb20 bor_636363 content bg_c_white" style="max-height:260px;min-height:104px;overflow-y:auto;">
						<c:if test="${work.type=='report'}">
							<div id="chart${s.index}">

							</div>
						</c:if>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>
</body>
</html>