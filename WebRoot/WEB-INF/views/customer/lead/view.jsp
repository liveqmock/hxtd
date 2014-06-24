<%--
  功能描述：线索详情
  User: xiaoli.luo
  Date:2014/5/19
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>线索详情</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail_a.css" type="text/css"/>
</head>
<body>
<div>
	<div class="cb"></div>
	<!--列表开始-->
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
						href="${ctx }/customer/lead/toModifyPage.do?id=${lead.id}"><b
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
					线索名：
				</td>
				<td align="left">
					${lead.name }
				</td>
				<td align="right" width="15%">
					所有者：
				</td>
				<td align="left">
					${lead.owner.name }
				</td>
			</tr>
			<tr>
				<td align="right">
					电话：
				</td>
				<td align="left">
					${lead.phone }
				</td>
				<td align="right">
					手机：
				</td>
				<td align="left">
					${lead.mobile }
				</td>
			</tr>
			<tr>
				<td align="right">
					公司名：
				</td>
				<td align="left">
					${lead.company }
				</td>
				<td align="right">
					部门：
				</td>
				<td align="left">
					${lead.department }
				</td>
			</tr>
			<tr>
				<td align="right">
					职位：
				</td>
				<td align="left">
					${lead.position }
				</td>
				<td align="right">
					传真：
				</td>
				<td align="left">
					${lead.fax }
				</td>
			</tr>
			<tr>
				<td align="right">
					线索来源：
				</td>
				<td align="left">
					${lead.source.key }
				</td>
				<td align="right">
					邮箱：
				</td>
				<td align="left">
					${lead.email }
				</td>
			</tr>
			<tr>
				<td align="right">
					证件类型：
				</td>
				<td align="left">
					${lead.cardType.key }
				</td>
				<td align="right">
					线索状态：
				</td>
				<td align="left">
					${lead.status.key }
				</td>
			</tr>
			<tr>
				<td align="right">
					证件号码：
				</td>
				<td align="left">
					${lead.cardNum }
				</td>
				<td align="right">
					行业：
				</td>
				<td align="left">
					${lead.industry.key }
				</td>
			</tr>
			<tr>
				<td align="right">
					邮编：
				</td>
				<td align="left">
					${lead.postCode }
				</td>
				<td align="right">
					地区：
				</td>
				<td align="left">
					${lead.province.name}&nbsp;${lead.city.name}&nbsp;${lead.county.name}&nbsp;
				</td>
			</tr>
			<tr>
				<td align="right">
					详细地址：
				</td>
				<td align="left">
					${lead.address }
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
						${lead.remark }
					</div>
				</td>
			</tr>

		</table>
		
		<tag:attachment 
		view="${VS_HAS_FUNCTIONS.leadAttView}" 
		upload="${VS_HAS_FUNCTIONS.leadUpload}" 
		query="${VS_HAS_FUNCTIONS.leadAttQuery}" 
		down="${VS_HAS_FUNCTIONS.leadDown}" 
		module="lead"
		id="${lead.id}">
		</tag:attachment>
		
		<tag:memoir view="true" edit="true" query="true" delete="true" 
		moduleType="lead" moduleId="${lead.id}"></tag:memoir>
		<div class=" h40"></div>
	</div>
</div>
</body>
</html>
