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
				<td align="right">证件类型：</td>
				<td align="left">${customer.cardType.key}</td>
			</tr>
			<tr>
				<td align="right">公司：</td>
				<td align="left">${customer.company}</td>
				<td align="right">证件号码：</td>
				<td align="left">${customer.cardNum}</td>
			</tr>
			<tr>
				<td align="right">公司性质：</td>
				<td align="left">${customer.ownerShip.key}</td>
				<td align="right">行业：</td>
				<td align="left">${customer.industry.key}</td>
			</tr>
			<tr>
				<td align="right">所在部门：</td>
				<td align="left">${customer.dept}</td>
				<td align="right">职务名称：</td>
				<td align="left">${customer.job}</td>
			</tr>
			<tr>
				<td align="right">出资方式：</td>
				<td align="left">${customer.contributionType}</td>
				<td align="right">邮箱：</td>
				<td align="left">${customer.email}</td>
			</tr>
			<tr>
				<td align="right">出资规模：</td>
				<td align="left">${customer.contributionScale}</td>
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
		<h1 class="f14 fbnone ml40 pt10">账号信息</h1>
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
		<h1 class="f14 fbnone ml40 pt10">地址信息</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
			    <td align="right"  width="15%">省份：</td>
				<td align="left">${customer.province.name}</td>
				<td align="right" width="15%">城市：</td>
				<td align="left">${customer.city.name}</td>
			</tr>
			<tr>
				<td align="right">区县：</td>
				<td align="left">${customer.county.name}</td>
				<td align="right">详细地址：</td>
				<td align="left">${customer.address}</td>
			</tr>
			<tr>
				<td align="right"  width="15%">家庭地址：</td>
				<td align="left">${customer.familyAddr}</td>
				<td align="right"></td>
				<td align="left"></td>
			</tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
		<table class="cb id_table6 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%" valign="top">备注：</td>
				<td align="left" width="85%" valign="top">
				<div class="w85b">${customer.remark}</div>
				</td>
			</tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10">联系人</h1>
		<div class="w95b  bg_c_white margin0 mt10">
		<table class="cb id_table2 w90b margin0 mt10 mb10">
			<tr>
				<th>联系人名称</th>
				<th>职位</th>
				<th>电话</th>
				<th>手机</th>
				<th>创建时间</th>
			</tr>
			<c:forEach items="${contacts}" varStatus="i" var="item" >
			<tr>
				<td>${item.name}</td>
				<td>${item.position}</td>
				<td>${item.phone}</td>
				<td>${item.mobile}</td>
				<td>${item.createdTime}</td>
			</tr>
			</c:forEach>
		</table> 
		</div>
		<tag:memoir view="true" edit="true" query="true" delete="true" moduleType="customer" moduleId="${customer.id}"></tag:memoir>
		<tag:attachment view="${VS_HAS_FUNCTIONS.customerAttView}" upload="${VS_HAS_FUNCTIONS.customerUpload}" 
			module="customer" query="${VS_HAS_FUNCTIONS.customerAttQuery}" down="${VS_HAS_FUNCTIONS.customerDown}" 
			deleteFlag="true" id="${customer.id}"></tag:attachment>
		<div class="h40"></div>
    </div>
</body>
</html>
