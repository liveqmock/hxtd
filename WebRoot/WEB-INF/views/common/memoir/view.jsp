<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>联系人信息</title>
    <link rel="stylesheet" href="${ctx}/static/css/css.css" type="text/css"></link>
</head>
<body>
<div class="">
	<table style="width:100%;" class="table140421">
		<!--<tr>
			<td class="tar bghui pr10">参与沟通人员：</td>
			<td class="bghb pl10"></td>
		</tr>
		 -->
		<tr>
			<td width="20%" class="tar bghui pr10">联系纪要：</td>
			<td width="80%" class="bghb pl10">${memoir.summary}</td>
		</tr>
		<tr>
			<td class="tar bghui pr10">下次联系时间：</td>
			<td class="bghb pl10">${memoir.nextContactTime}</td>
		</tr>
		<tr>
			<td class="tar bghui pr10">下次联系要点：</td>
			<td class="bghb pl10">${memoir.nextContactPoints}</td>
		</tr>
		<tr>
			<td class="tar bghui pr10">备注：</td>
			<td class="bghb pl10">${contact.remark}</td>
		</tr>
	</table>
</div>
</body>
</html>