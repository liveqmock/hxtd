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
<style>
.hid{display: none;} label.error{padding-left:18px;color:red;}.error{border-color:red;}
</style>
<script type="text/javascript">
var urlMap = urlMap||{};
urlMap['lead']='/customer/lead/query.do';
urlMap['customer']='/customer/customer/query.do';
urlMap['contact']='/customer/contact/query.do';
urlMap['supplier']='/project/supplier/query.do';
urlMap['project']='/project/project/query.do';
urlMap['product']='/project/product/query.do';
urlMap['order']='/order/order/query.do';
$(function(){
	$("#type").change(function(){
		var $this = $(this);
		switch($this.val()){
			case "list":
				$(".list").show();
				$(".report").hide();
				break;
			case "report":
				$(".list").hide();
				$(".report").show();
				break;
			default:
				$(".list").hide();
				$(".report").hide();
				break;
		}
	});
	$("#module").change(function(){
		var $this = $(this);
		$("#moduleHide").val($this.val());
		$("#url").val(urlMap[$this.val()]);
	});
	$("#report").change(function(){
		var $this = $(this);
		$("#url").val("/common/report/reportWorkbanch.comp?id="+$this.val());
		$("#moduleHide").val("report");
	});
});
</script>
</head>
<body>
<form id="listForm" method="post" action="#">
	<div>
		<table class="id_tantable2 w  pr10 pl10">
			<tr>
				<td align="right" width="15%"><span class="w_red">*&nbsp;</span>类型：</td>
				<td align="left" width="35%">
				<select class="select2 required" id="type" name="type">
					<option value="">请选择</option>
					<option value="list">列表</option>
					<option value="report">报表</option>
				</select>
				</td>
				<td align="right" width="15%">宽度：</td>
				<td align="left" width="35%">
				<select class="select2" id="width" name="width">
					<option value="49">50%</option>
					<option value="99">100%</option>
				</select>
				</td>
			</tr>
			<tr>
				<td align="right" width="15%"><span class="w_red">*&nbsp;</span>标题：</td>
				<td align="left" width="35%">
				<input type="text" class="text_input1 required" name="title" id="title"/>
				</td>
			</tr>
			<tr class="list hid">
				<td align="right"><span class="w_red">*&nbsp;</span>模块：</td>
				<td align="left">
				<select class="select2 required" id="module">
					<option value="">请选择</option>
					<option value="lead">线索</option>
					<option value="customer">客户</option>
					<option value="contact">联系人</option>
					<option value="supplier">供应商</option>
					<option value="project">项目</option>
					<option value="product">产品</option>
					<option value="order">订单</option>
				</select>
				<input type="hidden" name="module" id="moduleHide"/>
				<input type="hidden" name="url" id="url"/>
				</td>
				<td align="right" id="paramText">创建时间：</td>
				<td align="left">
				<select class="select2" id="params" name="params">
					<option value="">请选择</option>
					<option value="today">今日</option>
					<option value="week">一周内</option>
					<option value="month">一月内</option>
				</select>
				</td>
			</tr>
			
			<tr class="report hid">
				<td align="right" width="15%"><span class="w_red">*&nbsp;</span>报表：</td>
				<td align="left" width="35%">
				<select class="select2 required" id="report">
					<option>请选择</option>
					<c:forEach items="${reports}" var="r">
						<option value="${r.id}">${r.name}</option>
					</c:forEach>
				</select>
				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
