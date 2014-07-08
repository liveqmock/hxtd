<%--
  功能描述
  User: xiayouxue
  Date:2014/5/5
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<script src="${ctx}/static/js/jquery.sortable.js" type="text/javascript"></script>
<script src="${ctx}/static/js/workbanch.js" type="text/javascript"></script>
<script>
$(function(){
	$('.gbin1-list').sortable().bind('sortupdate', function() {
		$('#msg').html('position changed').fadeIn(200).delay(1000).fadeOut(200);
	});
   	$(".gbin1-list li").each(function(){
   		var $this = $(this);
   		var url = $this.attr("uri")
   		var module = $this.attr("module")
   		if(url){
   			RcmsAjax.ajaxNoMsg(url,function(result){
	   			$this.find('>div:last').append(workbanch.result2Html(result,module));
	   		},null,{});
   		}
   	})
});
</script>
</head>
<body>
<div style="margin:20px;">
	<ul class="gbin1-list">
		<li style="width: 49%" uri="${ctx}/project/supplier/query.do" module="supplier">
				<div class="block cb cb">
					<b class="ba"></b>
					<b class="bb"></b>
					<b class="bc"></b>
					<b class="bd"></b>
					<div class="fl table_blueheadc fl w" style="height: 40px;">
						<h1 class="f14 c_white lh40 ml10 fl">
							 title
						</h1>
						<img width="80" height="40" class="fl ml80" src="${ctx }/static/images/snowflake.png"/>
						
						<div class="fr mr10 mt10">
							<a href="javascript:;" class=" block_inline g_small globle_img ml10"></a>
							<a href="javascript:;" class=" block_inline g_new globle_img ml10"></a>
							<a href="javascript:;" class=" block_inline g_close globle_img ml10"></a>
						</div>
					</div>
				</div>
				<div class="cb mb20 bor_636363 content" style=" ">
					
				</div>
		</li>
		<li style="width: 49%" uri="${ctx}/project/supplier/query.do" module="supplier">
				<div class="block cb cb">
					<b class="ba"></b>
					<b class="bb"></b>
					<b class="bc"></b>
					<b class="bd"></b>
					<div class="fl table_blueheadc fl w" style="height: 40px;">
						<h1 class="f14 c_white lh40 ml10 fl">
							 title
						</h1>
						<img width="80" height="40" class="fl ml80" src="${ctx }/static/images/snowflake.png"/>
						
						<div class="fr mr10 mt10">
							<a href="javascript:;" class=" block_inline g_small globle_img ml10"></a>
							<a href="javascript:;" class=" block_inline g_new globle_img ml10"></a>
							<a href="javascript:;" class=" block_inline g_close globle_img ml10"></a>
						</div>
					</div>
				</div>
				<div class="cb mb20 bor_636363 content" style=" ">
					
				</div>
		</li>
		<li style="width: 49%" uri="${ctx}/project/supplier/query.do" module="supplier">
				<div class="block cb cb">
					<b class="ba"></b>
					<b class="bb"></b>
					<b class="bc"></b>
					<b class="bd"></b>
					<div class="fl table_blueheadc fl w" style="height: 40px;">
						<h1 class="f14 c_white lh40 ml10 fl">
							 title
						</h1>
						<img width="80" height="40" class="fl ml80" src="${ctx }/static/images/snowflake.png"/>
						
						<div class="fr mr10 mt10">
							<a href="javascript:;" class=" block_inline g_small globle_img ml10"></a>
							<a href="javascript:;" class=" block_inline g_new globle_img ml10"></a>
							<a href="javascript:;" class=" block_inline g_close globle_img ml10"></a>
						</div>
					</div>
				</div>
				<div class="cb mb20 bor_636363 content" style=" ">
					
				</div>
		</li>
		<li style="width: 49%" uri="${ctx}/project/supplier/query.do" module="supplier">
				<div class="block cb cb">
					<b class="ba"></b>
					<b class="bb"></b>
					<b class="bc"></b>
					<b class="bd"></b>
					<div class="fl table_blueheadc fl w" style="height: 40px;">
						<h1 class="f14 c_white lh40 ml10 fl">
							 title
						</h1>
						<img width="80" height="40" class="fl ml80" src="${ctx }/static/images/snowflake.png"/>
						
						<div class="fr option_l mr10 mt10">
							<a href="javascript:;" class=" block_inline g_small globle_img ml10"></a>
							<a href="javascript:;" class=" block_inline g_new globle_img ml10"></a>
							<a href="javascript:;" class=" block_inline g_close globle_img ml10"></a>
						</div>
					</div>
				</div>
				<div class="cb mb20 bor_636363 content" style=" ">
					
				</div>
		</li>
	</ul>
</div>
</body>
</html>