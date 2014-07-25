<%--
  功能描述：客户情
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
<title>客户详情</title>
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
				客户信息
			</h1>
			<ul class="fr id_table1 mt10 ml10">
			</ul>
		</div>
	</div>
	<div class="ml35 mr35 bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%">客户所有者：</td>
				<td align="left">${customer.owner.realName}</td>
				<td align="right" width="15%">客户来源：</td>
				<td align="left">${customer.source.key}	</td>
			</tr>
			<tr>
				<td align="right">客户名称：</td>
				<td align="left">${customer.name}</td>
				<td align="right">客户类型：</td>
				<td align="left">${customer.type.key}</td>
			</tr>
			<tr>
				<td align="right">电话：</td>
				<td align="left">${customer.phone}</td>
				<td align="right">风险等级：</td>
				<td align="left">${customer.riskGrade.key}</td>
			</tr>
			<tr>
				<td align="right">手机：</td>
				<td align="left">${customer.mobile}</td>
				<td align="right">公司：</td>
				<td align="left">${customer.company}</td>
			</tr>
			<tr>
				<td align="right">邮箱：</td>
				<td align="left">${customer.email}</td>
				<td align="right">传真：</td>
				<td align="left">${customer.fax }</td>
			</tr>
			<tr>
				<td align="right">理财顾问：</td>
				<td align="left">${customer.financialAdvisor.realName}</td>
				<td align="right">邮编：</td>
				<td align="left">${customer.postCode}</td>
			</tr>
			<tr>
				<td align="right">理财经理：</td>
				<td align="left">${customer.financialManager.realName}</td>
				<td align="right">邀约人：</td>
				<td align="left">${customer.appointment.realName}</td>
			</tr>
			<tr>
				<td align="right">理财总监：</td>
				<td align="left">${customer.financialDirector.realName}</td>
				<td align="right"></td>
				<td align="left"></td>
		    </tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10">银行信息</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
			    <td align="right"  width="15%">开户银行：</td>
				<td align="left">${customer.openBank.key}</td>
				<td align="right"  width="15%">银行户名：</td>
				<td align="left">${customer.bankName}</td>
			</tr>
			<tr>
				<td align="right">银行账号：</td>
				<td align="left">${customer.bankAccount}</td>
				<td align="right"></td>
				<td align="left"></td>
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
