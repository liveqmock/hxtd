<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>添加工作台</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
<link rel="stylesheet" type="text/css" href="styles.css">
-->
<link href="${ctx }/static/css/public/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx }/static/css/public/reset.css" rel="stylesheet" type="text/css" />
<link href="${ctx }/static/css/recommend/detail_a.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/static/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#type").change(function(){
		var $this = $(this);
		switch($this.val()){
			case "list":
				var $param = $("#param");
				$("#paramText").text("时间参数：");
				$param.html("");
				$('<option value="today">今日</option>').appendTo($param);
				$('<option value="week">本周</option>').appendTo($param);
				$('<option value="month">本月</option>').appendTo($param);
				break;
			case "bb":
				var $param = $("#param");
				$("#paramText").text("报表：");
				$param.html("");
				break;
		}
	});
});
</script>
</head>
<body>
	<div>
		<table class="id_tantable2 w  pr10 pl10">
			<tr>
				<td align="right" width="15%">类型：</td>
				<td align="left" width="35%">
				<select class="select2" id="type">
					<option value="list">列表</option>
					<option value="bb">报表</option>
				</select>
				</td>
				<td align="right" width="15%">模块：</td>
				<td align="left" width="35%">
				<select class="select2">
					<option value="lead">线索</option>
					<option value="customer">客户</option>
					<option value="contact">联系人</option>
					<option value="supplier">供应商</option>
					<option value="project">项目</option>
					<option value="product">产品</option>
					<option value="order">订单</option>
				</select>
				</td>
			</tr>
			<tr>
				<td align="right">宽度：</td>
				<td align="left">
				<select class="select2">
					<option value="49%">1/2</option>
					<option value="99%">2/2</option>
				</select>
				</td>
				<td align="right" id="paramText">时间参数：</td>
				<td align="left">
				<select class="select2" id="param">
					<option value="today">今日</option>
					<option value="week">本周</option>
					<option value="month">本月</option>
				</select>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
