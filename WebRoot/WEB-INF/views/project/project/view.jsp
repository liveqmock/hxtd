<%--
  功能描述：项目详情
  User: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>项目详情</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">   
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
				线索详情信息
			</h1>
			<ul class="fr id_table1 mt10 ml10">
				<li>
					<a class=" pl35 c_white f14 lh25 cp block fr"
						href="${ctx }/project/project/toModifyPage.do?id=${com.id}"><b
						class="allbtn_l block fl"></b><b
						class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b>
					</a>
				</li>
				<li>
					<a class=" pl10 c_white f14 lh25 cp block fr mr10"
						href="javascript:history.go(-1)"><b
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
					项目名：
				</td>
				<td align="left">
					${project.name }
				</td>
				<td align="right" width="15%">
					项目编号：
				</td>
				<td align="left">
					${project.code }
				</td>
			</tr>

			<tr>
				<td align="right">
					融资额度：
				</td>
				<td align="left">
					${project.financeLimit }
				</td>
				<td align="right">
					开始时间：
				</td>
				<td align="left">
					<fmt:formatDate value="${project.beginTime }"
						pattern="yyyy-MM-dd" var="beginTime" />
					${beginTime }
				</td>
			</tr>

			<tr>
				<td align="right">
					融资前周期(天)：
				</td>
				<td align="left">
					${project.beforeFinanceCycle }
				</td>
				<td align="right">
					截止时间：
				</td>
				<td align="left">
					<fmt:formatDate value="${project.dendlineTime}"
						pattern="yyyy-MM-dd" var="dendlineTime" />
					${dendlineTime}
				</td>
			</tr>

			<tr>
				<td align="right">
					融资周期：
				</td>
				<td align="left">
					${project.financeCycle }
				</td>
				<td align="right">
					收益率：
				</td>
				<td align="left">
					${project.er }%
				</td>
			</tr>

			<tr>
				<td align="right">
					支付方式：
				</td>
				<td align="left">
					${project.payType }
				</td>
				<td align="right">
					提前赎回率：
				</td>
				<td align="left">
					${project.aer }%
				</td>
			</tr>

			<tr>
				<td align="right">
					供应商：
				</td>
				<td align="left">
					${project.supplier.name }
				</td>
				<td align="right">
					开放时间：
				</td>
				<td align="left">
					<fmt:formatDate value="${project.openTime}" pattern="yyyy-MM-dd"
						var="openTime" />
					${openTime}
				</td>
			</tr>

		</table>
		<h1 class="f14 fbnone ml40 pt10">
			描述信息
		</h1>
		<table class="cb id_table4 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%" valign="top">
					备注：
				</td>
				<td align="left" width="85%" valign="top">
					<div class="w85b">
						${project.remark }
					</div>
				</td>
			</tr>

		</table>
		<div class=" h40"></div>
	</div>
	<div class="cb block h40 margin0 mt10" style="width: 350px;">
		<ul class="id_table1 cb">
		</ul>
	</div>
</div>
</body>
</html>
