<%--
  功能描述：合同详情
  User: huizijing
  Date:2014/7/15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>合同详情</title>
	<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
	<link rel="stylesheet" href="${ctx}/static/css/recommend/detail_a.css" type="text/css"/>
	<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
	<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
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
			<h1 class="f14 fbnone mt10 ml10 fl">合同详情信息</h1>
			<ul class="fr id_table1 mt10 ml10">
				<c:if test="${VS_HAS_FUNCTIONS.contractModify}">
					<li>
						<a class=" pl10 c_white f14 lh25 cp block fr" href="${ctx }/order/contract/toModifyPage.do?id=${contract.id}">
							<b class="allbtn_l block fl"></b>
							<b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b>
						</a>
					</li>
				</c:if>
				<li>
					<a class=" pl10 c_white f14 lh25 cp block fr mr10"
						href="${ctx }/order/contract/toQueryPage.do"><b
						class="allbtn_l block fl"></b><b
						class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b>
					</a>
				</li>
			</ul>
		</div>
	</div>
	<div class="ml35 mr35 bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">
			基本信息
		</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
			    <td align="right">订单编号：</td>
				<td align="left">${contract.order.code}</td>
				<td align="right" width="15%">合同编号：</td>
				<td align="left">${contract.code}</td>
			</tr>
			<tr>
				<!-- <td align="right">合同类型：</td> 
				<td align="left">${contract.type.key}</td>-->
				<td align="right">客户：</td>
				<td align="left">${contract.customer.name }</td>
				<td align="right">合同金额（万）：</td>
				<td align="left">${contract.purchaseMoney }</td>
			</tr>
			<tr>
				<td align="right" width="15%">合同名称：</td>
				<td align="left">${contract.name }</td>
				<td align="right">赎回方式：</td>
				<td align="left">${contract.redeemType.key}</td>
			</tr>
			<tr>
				<td align="right">签订时间：</td>
				<td align="left">
				<fmt:formatDate value="${contract.signTime}" pattern="yyyy-MM-dd" var="signTime" />
				${signTime }
				</td>
				<td align="right" width="15%">生效时间：</td>
				<td align="left">
					<fmt:formatDate value="${contract.effectTime}" pattern="yyyy-MM-dd" var="effectTime" />
					${effectTime}
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">失效时间：</td>
				<td align="left">
					<fmt:formatDate value="${contract.bereftTime}" pattern="yyyy-MM-dd" var="bereftTime" />
					${bereftTime}
				</td>
			</tr>
		</table>
		  <h1 class="f14 fbnone ml40 pt10">合同内容</h1>
		<table class="cb id_table4 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%" valign="top"></td>
				<td align="left" width="85%" valign="top">
					<div style="overflow-y:auto;word-break:break-all; width:1047px;height:200px;" class="w85b">${contract.content}</div>
				</td>
			</tr>
		</table>
		
		<tag:attachment view="${VS_HAS_FUNCTIONS.contractAttView}" upload="${VS_HAS_FUNCTIONS.contractUpload}" 
			module="contract" query="${VS_HAS_FUNCTIONS.contractAttQuery}" down="${VS_HAS_FUNCTIONS.contractDown}" 
			deleteFlag="true" id="${contract.id}"></tag:attachment>
		<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
		<table class="cb id_table6 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%" valign="top">备注：</td>
				<td align="left" width="85%" valign="top">
					<div class="w85b">${contract.remark }</div>
				</td>
			</tr>
		</table>
		<div class="h40"></div>
	</div>
</div>
</body>
</html>
