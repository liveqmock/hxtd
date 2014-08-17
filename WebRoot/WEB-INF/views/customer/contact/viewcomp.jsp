<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>联系人详情</title>
<link rel="stylesheet" href="${ctx}/static/css/public/common.css?v=${now}" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css?v=${now}" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/> 
</head>
<body>
<div class="ml35 mr35 bg_c_blue cb">
	<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
	<table class="cb id_table3 w95b bg_c_white margin0 mt10">
		<tr>
			<td width="15%" align="right">联系人所有者：</td>
			<td align="left">${contact.owner.realName}</td>
			<td width="15%" align="right">线索来源：</td>
			<td align="left">${contact.source.key}</td>
		</tr>
		<tr>
			<td align="right">联系人名：</td>
			<td align="left">${contact.name}</td>
			<td align="right">客户名：</td>
			<td align="left">${contact.customer.name}</td>
		</tr>
		<tr>
			<td align="right">电话：</td>
			<td align="left">${contact.phone}</td>
			<td align="right">供应商名：</td>
			<td align="left">${contact.supplier.name}</td>
		</tr>
		<tr>
			<td align="right">手机：</td>
			<td align="left">${contact.mobile}</td>
			<td align="right">邮箱：</td>
			<td align="left">${contact.email}</td>
		</tr>
		<tr>
			<td align="right">部门：</td>
			<td align="left">${contact.department}</td>
			<td align="right">传真：</td>
			<td align="left">${contact.fax}</td>
		</tr>
		<tr>
			<td align="right">职位：</td>
			<td align="left">${contact.position}</td>
			<td align="right">邮编：</td>
			<td align="left">${contact.postCode}</td>
		</tr>
	</table>
	<h1 class="f14 fbnone ml40 pt10">地址信息</h1>
	<table class="cb id_table3 w95b bg_c_white margin0 mt10">
		<tr>
			<td width="15%" align="right">省份：</td>
			<td align="left">${contact.province.name}</td>
			<td width="15%" align="right">城市：</td>
			<td align="left">${contact.city.name}</td>
		</tr>
		<tr>
			<td align="right">区县：</td>
			<td align="left">${contact.county.name}</td>
			<td align="right">详细地址：</td>
			<td align="left">${contact.address}</td>
		</tr>
	</table>
	<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
	<table class="cb id_table6 w95b bg_c_white margin0 mt10">
		<tr>
			<td align="right" width="15%" valign="top">备注：</td>
			<td align="left" valign="top"><div class="w85b">${contact.remark}</div></td>
		</tr>
	</table>
	<div class="h40"></div>
</div>
</body>
</html>