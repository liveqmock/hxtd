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
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/> 
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
			<h1 class="f14 fbnone mt10 ml10 fl">项目详情信息</h1>
			<ul class="fr id_table1 mt10 ml10">
				<li>
					<a href="${ctx }/project/project/toModifyPage.do?id=${project.id}" class="pl35 c_white f14 lh25 cp block fr">
						<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b>
					</a>
				</li>
				<li>
					<a href="${ctx }/project/project/toQueryPage.do" class="pl10 c_white f14 lh25 cp block fr mr10">
						<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b>
					</a>
				</li>
			</ul>
		</div>
	</div>
	<div class="ml35 mr35 bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%">项目名称：</td>
				<td align="left">${project.name}</td>
				<td align="right" width="15%">项目编号：</td>
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
				<td align="left">${project.er }%</td>
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
		<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
		<table class="cb id_table6 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%" valign="top">备注：</td>
				<td align="left" width="85%" valign="top"><div class="w85b">${project.remark}</div></td>
			</tr>
		</table>
		<c:if test="${VS_HAS_FUNCTIONS.productQuery}">
			<h1 class="f14 fbnone ml40 mt10">产品</h1>
			<div class="w95b  bg_c_white margin0 mt10"><br/>
				<b class="w90b f_line2 block margin0"></b>
				<table class="cb id_table2 w90b margin0 mt10 mb10">
					<tbody>
						<tr>
							<th width="10%">产品名称</th>
							<th width="10%">产品编号</th>
							<th width="10%">出售金额（万）</th>
							<th width="10%">收益率（%）</th>
							<th width="10%">开始时间</th>
							<th width="10%">截止时间</th>
							<th width="10%">赎回赔率（%）</th>
							<th width="10%">赎回公式</th>
						</tr>
					</tbody>
					<tbody class="list">
					<c:forEach items="${products}" var="c">
						<tr>
							 <td>
				                  <c:choose>
				                      <c:when test="${VS_HAS_FUNCTIONS.productView}">
				                      	<a href="${ctx}/project/product/toViewPage.do?id=${c.id}" class="toviewpage">${c.name}</a>
				                      </c:when>
				                      <c:otherwise>${c.name }</c:otherwise>
				                  </c:choose>
				              </td>
				              <td>${c.code }</td>
				              <td>${c.sellMoney }</td>
							  <td>${c.rate }</td>
				              <td><fmt:formatDate value="${c.saleBeginTime}" pattern="yyyy-MM-dd"/></td>
				              <td><fmt:formatDate value="${c.saleEndTime}" pattern="yyyy-MM-dd"/></td>
				              <td>${c.redeemRate }</td>
				              <td>${c.redeemFormula }</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<div class="h40"></div>
			</div>
		</c:if>
		<tag:attachment id="${project.id}" view="${VS_HAS_FUNCTIONS.projectAttView}" query="${VS_HAS_FUNCTIONS.projectAttQuery}" 
			upload="${VS_HAS_FUNCTIONS.projectUpload}" down="${VS_HAS_FUNCTIONS.projectDown}" 
			deleteFlag="${VS_HAS_FUNCTIONS.projectAttDelete}" module="project"></tag:attachment>
		<div class=" h40"></div>
	</div>
</div>
</body>
</html>
