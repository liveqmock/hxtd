<%--
  功能描述：产品情
  User: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>产品详情</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="${ctx}/static/css/public/common.css?v=${now}" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css?v=${now}" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/> 
</head>
<body>
<div>
	<div class="cb"></div>
	<div class="ml35 mr35 mt20 block cb cb">
		<b class="b1"></b>
		<b class="b2"></b>
		<b class="b3"></b>
		<b class="b4"></b>
		<div class="ie_head">
			<h1 class="f14 fbnone mt10 ml10 fl">
				产品信息
			</h1>
			<ul class="fr id_table1 mt10 ml10">
			</ul>
		</div>
	</div>
	<div class="ml35 mr35 bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td width="15%" align="right">产品名称：</td>
				<td align="left">${product.name}</td>
				<td width="15%" align="right">产品编号：</td>
				<td align="left">${product.code}</td>
			</tr>
			<tr>
				<td align="right">产品类型：</td>
				<td align="left">${product.type.key}</td>
				<td align="right">所属项目：</td>
				<td align="left">${product.project.name}</td>
			</tr>
			<tr>
				<td align="right">出售金额（万）：</td>
				<td align="left"><fmt:formatNumber value="${product.sellMoney}" pattern="###,##0.00" var="sellMoney"/>${sellMoney}</td>
				<td align="right">收益率（%）：</td>
				<td align="left">${product.rate}%</td>
			</tr>
			<tr>
				<td align="right">预期收益（万）：</td>
				<td align="left"><fmt:formatNumber value="${product.expectProfit}" pattern="###,##0.00" var="expectProfit"/>${expectProfit}</td>
				<td align="right">销售期限：</td>
				<td align="left">${product.saleLimit}${product.saleUnit.key}</td>
			</tr>
			<tr>
				<td align="right">销售开始日期：</td>
				<td align="left"><fmt:formatDate value="${product.saleBeginTime}" pattern="yyyy-MM-dd" var="saleBeginTime"/>${saleBeginTime}</td>
				<td align="right">赎回赔率（%）：</td>
				<td align="left">${product.redeemRate}</td>
			</tr>
			<tr>
				<td align="right">销售结束日期：</td>
				<td align="left"><fmt:formatDate value="${product.saleEndTime}" pattern="yyyy-MM-dd" var="saleEndTime"/>${saleEndTime}</td>
				<td align="right">赎回公式：</td>
				<td align="left">${product.redeemFormula}</td>
			</tr>
			</table>
		<div class="h40"></div>
	</div>
	<div class="cb block h40 margin0 mt10" style="width: 350px;">
		<ul class="id_table1 cb">
		</ul>
	</div>
</div>
</body>
</html>
