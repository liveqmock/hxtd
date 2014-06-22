<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>市场活动信息</title>
<link href="${ctx}/static/css/recommend/detail.css?v=1" type="text/css" rel="stylesheet"></link>
</head>
<body>
<div class="ml35 mr35 mt20 block cb cb">
	<b class="b1"></b>
	<b class="b2"></b>
	<b class="b3"></b>
	<b class="b4"></b>
	<div class="ie_head">
		<h1 class="f14 fbnone mt10 ml10 fl">市场活动详情信息</h1>
		<ul class="fr id_table1 mt10 ml10">
			<li>
			<c:if test="${VS_HAS_FUNCTIONS.marketactivityModify}">
				<a href="${ctx}/market/marketactivity/toModifyPage.do?id=${activity.id}" class="block c_white lh25 mr10">
					<b class="allbtn_l block fl"></b>
					<b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b>
				</a>
			</c:if>
			</li>
			<li>
				<a href="${ctx}/market/marketactivity/toQueryPage.do" class="block c_white lh25 mr10">
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
			<td width="15%" align="right">活动所有者：</td>
			<td align="left">${activity.sponsor.name}</td>
			<td width="15%" align="right">类型：</td>
			<td align="left">${activity.dic.key}</td>
		</tr>
		<tr>
			<td align="right">活动名称：</td>
			<td align="left">${activity.name}</td>
			<td align="right">状态：</td>
			<td align="left">${activity.status.key}</td>
		</tr>
		<tr>
			<td align="right">开始日期：</td>
			<td align="left">
				<fmt:formatDate value="${activity.beginDate}" pattern="yyyy-MM-dd" var="beginDate"/>${beginDate}
			</td>
			<td align="right">预计成本：</td>
			<td align="left">${activity.predictCost}</td>
		</tr>
		<tr>
			<td align="right">结束日期：</td>
			<td align="left">
				<fmt:formatDate value="${activity.endDate}" pattern="yyyy-MM-dd" var="endDate"/>${endDate}
			</td>
			<td align="right">实际成本：</td>
			<td align="left">${activity.realityCost}</td>
		</tr>
		<tr>
			<td align="right">预期效果：</td>
			<td align="left">${activity.expectEffect}</td>
			<td align="right">活动次数：</td>
			<td align="left">${activity.times}</td>
		</tr>
		<tr>
			<td align="right">期望成功率%：</td>
			<td align="left">${activity.expectSuccessRate}</td>
			<td align="right">负责人：</td>
			<td align="left">${activity.bossHead.name}</td>
		</tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
		<table class="cb id_table4 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%" valign="top">备注：</td>
				<td align="left" valign="top"><div class="w85b">${activity.remark}</div></td>
			</tr>
		</table>
	<div class="h40"></div>
</div>
</body>
</html>