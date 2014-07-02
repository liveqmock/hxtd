<%--
  功能描述：客户详情
  User: huizijing
  Date:2014/5/24
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>客户详情</title>
<link href="${ctx}/static/css/stressing/detail.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<div class="cb"></div>
	<div class="ml35 mr35 mt20 block cb cb">
		<b class="table_headl globle_img block fl"></b>
		<div class="fl table_headc fl w99b">
			<h1 class="f14 fbnone mt10 ml10 fl">客户详细信息</h1>
		    <ul class="fr id_table1 mt10 ml10">
				<li>
					<a href="${ctx}/customer/customer/toViewPage.do?type=edit&id=${customer.id}" class="block c_white lh25 mr10">
						<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b>
					</a>
				</li>
				<li>
					<a href="${ctx}/customer/customer/toQueryPage.do" class="block c_white lh25 mr10">
						<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b>
					</a>
				</li>
			</ul>
		</div>
		<b class="table_headr globle_img block fl"></b>
	</div>
	<div class="ml35 mr35 bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%">客户所有者：</td>
				<td align="left">${customer.owner.realName}</td>
				<td align="right" width="15%">客户名：</td>
				<td align="left">${customer.name}</td>
			</tr>
			<tr>
				<td align="right" width="15%">客户类型：</td>
				<td align="left">
					<c:choose>
					<c:when test="${customer.type.id=='040301'}"></c:when>
					<c:otherwise>${customer.type.key}</c:otherwise>
					</c:choose>
				</td>
				<td align="right" width="15%">客户来源：</td>
				<td align="left">
					<c:choose>
						<c:when test="${customer.source.id=='040301'}"></c:when>
						<c:otherwise>${customer.source.key}</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">风险等级：</td>
				<td align="left">
					<c:choose>
						<c:when test="${customer.riskGrade.id=='040304'}"></c:when>
						<c:otherwise>${customer.riskGrade.key}</c:otherwise>
					</c:choose>
				</td>
				<td align="right" width="15%">证件类型：</td>
				<td align="left">
					<c:choose>
						<c:when test="${customer.cardType.id=='040303'}"></c:when>
						<c:otherwise>${customer.cardType.key}</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">证件号：</td>
				<td align="left">${customer.cardNum}</td>
				<td align="right" width="15%">电话：</td>
				<td align="left">${customer.phone}</td>
			</tr>
			<tr>
				<td align="right" width="15%">手机：</td>
				<td align="left">${customer.mobile}</td>
				<td align="right" width="15%">邮编：</td>
				<td align="left">${customer.postCode}</td>
			</tr>
			<tr>
				<td align="right" width="15%">传真：</td>
				<td align="left">${customer.fax }</td>
				<td align="right" width="15%">公司：</td>
				<td align="left">${customer.company}</td>
			</tr>
			<tr>
				<td align="right" width="15%">开户银行：</td>
				<td align="left">
					<c:choose>
						<c:when test="${customer.openBank.id=='040307'}"></c:when>
						<c:otherwise>${customer.openBank.key}</c:otherwise>
					</c:choose>
				</td>
				<td align="right" width="15%">银行户名：</td>
				<td align="left">${customer.bankName}</td>
			</tr>
			<tr>
				<td align="right" width="15%">账号：</td>
				<td align="left">${customer.bankAccount}</td>
				<td align="right" width="15%">所有权：</td>
				<td align="left">
					<c:choose>
						<c:when test="${customer.ownerShip.id=='040306'}"></c:when>
						<c:otherwise>${customer.ownerShip.key}</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">行业：</td>
				<td align="left">${customer.industry.key}</td>
				<td align="right" width="15%">邮箱：</td>
				<td align="left">${customer.email}</td>
			</tr>
			<tr>
			    <td align="right" width="15%">创建时间：</td>
				<td align="left">${customer.createdTime}</td>
				<td align="right" width="15%">创建者:</td>
				<td align="left">${customer.creator.name}</td>
			</tr>
			<tr>
				<td align="right" width="15%">修改时间：</td>
				<td align="left">${customer.modifiedTime}</td>
				<td align="right" width="15%">修改者:</td>
				<td align="left">${customer.modifier.name}</td>
			</tr>
			</table>
			<h1 class="f14 fbnone ml40 pt10">地址信息</h1>
			<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
			    <td align="right" width="15%">省:</td>
				<td align="left">${customer.province.name}</td>
				<td align="right" width="15%">市：</td>
				<td align="left">${customer.city.name}</td>
			</tr>
			<tr>
			    <td align="right" width="15%">县:</td>
				<td align="left">${customer.county.name}</td>
				<td align="right" width="15%">详细地址：</td>
				<td align="left">${customer.address}</td>
			</tr>
			</table>
			<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
			<table class="cb id_table4 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%" valign="top">备注：</td>
				<td align="left" width="85%" valign="top">
				<div class="w85b">${customer.remark}</div>
				</td>
			</tr>
		</table> 
		<tag:attachment view="${VS_HAS_FUNCTIONS.customerAttView}" upload="${VS_HAS_FUNCTIONS.customerUpload}" 
			module="customer" query="${VS_HAS_FUNCTIONS.customerAttQuery}" down="${VS_HAS_FUNCTIONS.customerDown}" 
			deleteFlag="true" id="${costomer.id}"></tag:attachment>
		<tag:memoir view="true" edit="true" query="true" delete="true" moduleType="customer" moduleId="${customer.id}"></tag:memoir>
		<div class="h40"></div>
    </div>
</body>
</html>
