<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>供应商详情</title>
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
		<div class="ie_head">
			<h1 class="f14 fbnone mt10 ml10 fl">供应商详情信息</h1>
			<ul class="fr id_table1 mt10 ml10"></ul>
		</div>
	</div>
	<div class="bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right">供应商名称：</td>
				<td align="left">${com.name}</td>
				<td align="right">所有者：</td>
				<td align="left">${com.owner.realName}</td>
			</tr>
			<tr>
				<td align="right">供应商类型：</td>
				<td align="left">${com.type.key}</td>
				<td align="right">证件类型：</td>
				<td align="left">${com.cardType.key}</td>
			</tr>
			<tr>
				<td align="right">法人代表：</td>
				<td align="left">${com.corporation}</td>
				<td align="right">证件号码：</td>
				<td align="left">${com.cardNum}</td>
			</tr>
			<tr>
				<td align="right">法人电话：</td>
				<td align="left">${com.phone}</td>
				<td align="right">常用邮箱：</td>
				<td align="left">${com.email}</td>
			</tr>
			<tr>
				<td align="right">法人手机：</td>
				<td align="left">${com.mobile}</td>
				<td align="right">传真：</td>
				<td align="left">${com.fax}</td>
			</tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10">地址信息</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right">省份：</td>
				<td align="left">${com.province.name}</td>
				<td align="right">城市：</td>
				<td align="left">${com.city.name}</td>
			</tr>
			<tr>
				<td align="right">区县：</td>
				<td align="left">${com.county.name}&nbsp;</td>
				<td align="right">详细地址：</td>
				<td align="left">${com.address}</td>
			</tr>
		</table>
		<div class=" h40"></div>
	</div>
</div>
</body>
</html>
