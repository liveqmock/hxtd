<%--
  功能描述：供应商详情
  User: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>供应商详情</title>
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
				供应商详情信息
			</h1>
			<ul class="fr id_table1 mt10 ml10">
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
					供应商名：
				</td>
				<td align="left">
					${com.name }
				</td>
				<td align="right" width="15%">
					所有者：
				</td>
				<td align="left">
					${com.owner.realName }
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					供应商类型：
				</td>
				<td align="left">
					${com.type.key}
				</td>
				<td align="right">
					电话：
				</td>
				<td align="left">
					${com.phone}
				</td>
				
			</tr>
			<tr>
				<td align="right">
					手机：
				</td>
				<td align="left">
					${com.mobile}
				</td>
				<td align="right">
					邮箱：
				</td>
				<td align="left">
					${com.email}
				</td>
			</tr>
			<tr>
				<td align="right">
					传真：
				</td>
				<td align="left">
					${com.fax }
				</td>
				<td align="right">
					法人：
				</td>
				<td align="left">
					${com.corporation }
				</td>
			</tr>
			<tr>
				<td align="right">
					证件类型：
				</td>
				<td align="left">
					${com.cardType.key }
				</td>
				<td align="right">
					证件号码：
				</td>
				<td align="left">
					${com.cardNum }
				</td>
			</tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10">
			地址信息
		</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%">
					地区：
				</td>
				<td align="left">
					${com.province.name}&nbsp;${com.city.name}&nbsp;${com.county.name}&nbsp;
				</td>
				<td align="right" width="15%">
					详细地址：
				</td>
				<td align="left">
					${com.address }
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