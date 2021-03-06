<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>项目详情</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="${ctx}/static/css/public/common.css?v=${now}" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css?v=${now}" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/> 
</head>
<body>
<div>
	<div class="cb"></div>
	<div class="block cb cb">
		<b class="b1"></b>
		<b class="b2"></b>
		<b class="b3"></b>
		<b class="b4"></b>
		<div class="ie_head"><h1 class="f14 fbnone mt10 ml10 fl">项目详情信息</h1></div>
	</div>
	<div class="bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right">项目名称：</td>
				<td align="left">${project.name}</td>
				<td align="right">项目编号：</td>
				<td align="left">${project.code}</td>
			</tr>
			<tr>
				<td align="right">融资额度（万）：</td>
				<td align="left">${project.financeLimit}</td>
				<td align="right">开始时间：</td>
				<td align="left"><fmt:formatDate value="${project.beginTime}" pattern="yyyy-MM-dd" var="beginTime"/>${beginTime}</td>
			</tr>
			<tr>
				<td align="right">融资前周期（天）：</td>
				<td align="left">${project.beforeFinanceCycle}</td>
				<td align="right">截止时间：</td>
				<td align="left"><fmt:formatDate value="${project.dendlineTime}" pattern="yyyy-MM-dd" var="dendlineTime"/>${dendlineTime}</td>
			</tr>
			<tr>
				<td align="right">融资周期（天）：</td>
				<td align="left">${project.financeCycle}</td>
				<td align="right">收益率（%）：</td>
				<td align="left">${project.er}%</td>
			</tr>
			<tr>
				<td align="right">支付方式：</td>
				<td align="left">${project.payType.key}</td>
				<td align="right">赎回赔率（%）：</td>
				<td align="left">${project.aer}%</td>
			</tr>
			<tr>
				<td align="right">供应商：</td>
				<td align="left">${project.supplier.name}</td>
				<td align="right">开放时间：</td>
				<td align="left"><fmt:formatDate value="${project.openTime}" pattern="yyyy-MM-dd" var="openTime"/>${openTime}</td>
			</tr>
		</table>
		<div class="h40"></div>
	</div>
</div>
</body>
</html>
