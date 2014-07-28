<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>字典管理</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"></link>
</head>
<body>
<div class="ml35 mr35 mt20 block cb cb">
	<b class="b1"></b>
	<b class="b2"></b>
	<b class="b3"></b>
	<b class="b4"></b>
	<div class="ie_head">
		<h1 class="f14 fbnone mt10 ml10 fl">字典详情信息</h1>
		<ul class="fr id_table1 mt10 ml10">
			<li>
			<c:if test="${VS_HAS_FUNCTIONS.dictionaryModify}">
				<a href="${ctx}/system/dictionary/toModifyPage.do?id=${dictionary.id}" class="block c_white lh25 mr10">
					<b class="allbtn_l block fl"></b>
					<b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b>
				</a>
			</c:if>
			</li>
			<li>
				<a href="${ctx}/system/dictionary/toQueryPage.do" class="block c_white lh25 mr10">
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
			<td width="15%" align="right">字典名称：</td>
			<td align="left">${dictionary.key}</td>
			<td width="15%" align="right">字典值：</td>
			<td align="left">${dictionary.value}</td>
		</tr>
		<tr>
			<td align="right">所属字典：</td>
			<td align="left">${dictionary.parent.name}</td>
			<td align="right">字典类型：</td>
			<td align="left">${dictionary.type}</td>
		</tr>
		<tr>
			<td align="right">是否启用：</td>
			<td align="left">${dictionary.isActive==1?'是':'否'}</td>
			<td align="right">排序：</td>
			<td align="left">${dictionary.order}</td>
		</tr>
	</table>
	<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
	<table class="cb id_table6 w95b bg_c_white margin0 mt10">
		<tr>
			<td align="right" width="15%" valign="top">备注：</td>
			<td align="left" valign="top"><div class="w85b">${dictionary.remark}</div></td>
		</tr>
	</table>
	<div class="h40"></div>
</div>
</body>
</html>