<%--
  功能描述：收款详情
  User: huizijing
  Date:2014/7/27
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>收款详情</title>
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
			<h1 class="f14 fbnone mt10 ml10 fl">
				收款详情信息
			</h1>
			<ul class="fr id_table1 mt10 ml10">
				<c:if test="${VS_HAS_FUNCTIONS.financialReceivablesView&&VS_HAS_FUNCTIONS.financialReceivablesModifyFinish}">
				<li>
					<a class=" pl35 c_white f14 lh25 cp block fr"
						href="${ctx }/financial/receivables/toModifyFinishPage.do?id=${receivables.id}"><b
						class="allbtn_l block fl"></b><b
						class="allbtn_r pr13 block fl w_auto f14">收&nbsp;&nbsp;款</b>
					</a>
				</li>
				</c:if>
				<li>
					<a class=" pl10 c_white f14 lh25 cp block fr mr10"
						href="${ctx }/financial/receivables/toQueryPage.do"><b
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
				<td align="right" width="15%">
					收款名：
				</td>
				<td align="left">
					${receivables.name }
				</td>
				<td align="right" width="15%">
					订单编号：
				</td>
				<td align="left">
					${receivables.order.code }
				</td>
			</tr>
			<tr>
				<td align="right">
					客户名称：
				</td>
				<td align="left">
					${receivables.customer.name }
				</td>
				<td align="right">
					应收款金额（万）：
				</td>
				<td align="left">
					${receivables.fund }
				</td>
			</tr>
			<tr>
				<td align="right">
					实际收款金额（万）：
				</td>
				<td align="left">
					${receivables.actual}
				</td>
				<td align="right">
					收款状态：
				</td>
				<td align="left" <c:if test="${!receivables.status }">style="color:red;"</c:if>>
					${receivables.status?'已收款':'未收款'}
				</td>
			</tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10">
			描述信息
		</h1>
		<table class="cb id_table6 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%" valign="top">
					备注：
				</td>
				<td align="left" width="85%" valign="top">
					<div class="w85b">
						${receivables.remark}
					</div>
				</td>
			</tr>
		</table>
		<div class=" h40"></div>
	</div>
</div>
</body>
</html>
