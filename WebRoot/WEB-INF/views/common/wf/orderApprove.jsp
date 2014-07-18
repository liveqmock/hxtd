<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>订单审批</title>
<link rel="stylesheet" href="${ctx}/static/css/public/common.css?v=1" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css?v=1" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css?v=1" type="text/css"/>
</head>
<body>
<form action="${ctx}${VR_FUNCTION.url}" method="post">
<div class="margin0">
	<div>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td width="30%" align="right"><i class="mt3 block">当前节点操作：</i></td>
				<td class="pl10">
					<input name="rd_func" type="radio" value='1' checked="checked"/>同意
					<input name="rd_func" type="radio" value='0'/>退回
				</td>
			</tr>
			<tr>
				<td align="right">下一节点名称：</td>
				<td class="pl10">投资经理审批</td>
			</tr>
			<tr>
				<td align="right"><i class="mt3 block">审批参与者：</i></td>
				<td class="pl10">
					<select class="select3 pr">
						<option>李华</option>
						<option>张三</option>
						<option>李华</option>
						<option>张三</option>
						<option>李华</option>
						<option>张三</option>
					</select>
				</td>
			</tr>
			<tr style="display:none;">
				<td align="right" valign="top">退回原因：</td>
				<td class="pl10">
					<textarea class="remarks_input3" style="height:100px;">退回</textarea>
				</td>
			</tr>
		</table>
	</div>
</div>
</form>
</body>
</html>