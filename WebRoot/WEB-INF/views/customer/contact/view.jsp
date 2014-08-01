<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>联系人详情</title>
<link href="${ctx}/static/css/recommend/list1.css?v=1" type="text/css" rel="stylesheet"></link>
</head>
<body>
<div class="ml35 mr35 mt20 block cb cb">
	<b class="b1"></b>
	<b class="b2"></b>
	<b class="b3"></b>
	<b class="b4"></b>
	<div class="ie_head">
		<h1 class="f14 fbnone mt10 ml10 fl">联系人详情信息</h1>
		<input type="hidden" id="hide_id" value="${contact.id}"/>
		<ul class="fr id_table1 mt10 ml10">
			<li>
			<c:if test="${VS_HAS_FUNCTIONS.contactModify}">
				<a href="${ctx}/customer/contact/toModifyPage.do?id=${contact.id}" 
					class="block c_white lh25 mr10">
					<b class="allbtn_l block fl"></b>
					<b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b>
				</a>
			</c:if>
			</li>
			<li>
				<a href="${ctx}/customer/contact/toQueryPage.do" class="block c_white lh25 mr10">
					<b class="allbtn_l block fl"></b>
					<b class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b>
				</a>
			</li>
		</ul>
	</div>
</div>
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
	<tag:attachment view="${VS_HAS_FUNCTIONS.leadAttView}" upload="${VS_HAS_FUNCTIONS.leadUpload}" module="contact"
			query="${VS_HAS_FUNCTIONS.leadAttQuery}" down="${VS_HAS_FUNCTIONS.leadDown}" 
			deleteFlag="${VS_HAS_FUNCTIONS.leadAttDelete}" id="${contact.id}"></tag:attachment>
	<tag:memoir view="true" edit="true" query="true" delete="true" 
		moduleType="contact" moduleId="${contact.id}"></tag:memoir>
	<div class="h40"></div>
</div>
</body>
</html>