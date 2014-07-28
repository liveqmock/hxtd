<%--
  功能描述：供应商详情
  User: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
				<li>
					<a class=" pl35 c_white f14 lh25 cp block fr"
						href="${ctx }/project/supplier/toModifyPage.do?&id=${com.id}"><b
						class="allbtn_l block fl"></b><b
						class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b> </a>
				</li>
				<li>
					<a class="  pl10 c_white f14 lh25 cp block fr mr10"
						href="${ctx }/project/supplier/toQueryPage.do"><b
						class="allbtn_l block fl"></b><b
						class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b> </a>
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
						${com.remark }
					</div>
				</td>
			</tr>

		</table>
		<c:if test="${VS_HAS_FUNCTIONS.projectQuery}">
			<h1 class="f14 fbnone ml40 mt10">项目</h1>
			<div class="w95b  bg_c_white margin0 mt10">
				<br>
				<b class="w90b f_line2 block margin0"></b>
				<table class="cb id_table2 w90b margin0 mt10 mb10">
					<tbody>
						<tr>
							<th width="10%">
								项目名
							</th>
							<th width="10%">
								项目编号
							</th>
							<th width="10%">
								融资额度
							</th>
							<th width="10%">
								周期（天）
							</th>
							<th width="10%">
								开始时间
							</th>
							<th width="10%">
								截止时间
							</th>
							<th width="10%">
								开放期
							</th>
							<th width="10%">
								收益率（%）
							</th>
							<th width="10%">
								赎回率（%）
							</th>
						</tr>
					</tbody>
					<tbody  class="list">
						<c:forEach items="${projects}" var="c">
							<tr>
								 <td>
					                  <c:choose>
					                      <c:when test="${VS_HAS_FUNCTIONS.projectView}">
												<a href="${ctx}/project/project/toViewPage.do?id=${c.id}"
													class="toviewpage">${c.name }</a>
											</c:when>
					                      <c:otherwise>${c.name }</c:otherwise>
					                  </c:choose>
					              </td>
					              <td>${c.code }</td>
					              <td>${c.financeLimit }</td>
								  <td>${c.financeCycle }</td>
					              <td><fmt:formatDate value="${c.beginTime}" pattern="yyyy-MM-dd"/></td>
					              <td><fmt:formatDate value="${c.dendlineTime}" pattern="yyyy-MM-dd"/></td>
					              <td><fmt:formatDate value="${c.openTime}" pattern="yyyy-MM-dd"/></td>
					              <td>${c.er }</td>
								  <td>${c.aer }</td>	
							</tr>
						</c:forEach>
						
					</tbody>
				</table>
				<div class=" h40"></div>
			</div>
		</c:if>
		
		
		<c:if test="${VS_HAS_FUNCTIONS.projectQuery}">
			<h1 class="f14 fbnone ml40 mt10">联系人</h1>
			<div class="w95b  bg_c_white margin0 mt10">
				<br>
				<b class="w90b f_line2 block margin0"></b>
				<table class="cb id_table2 w90b margin0 mt10 mb10">
					<tbody>
						<tr>
							<th width="10%">
								姓名
							</th>
							<th width="15%">
								电话
							</th>
							<th width="15%">
								手机
							</th>
							<th width="15%">
								邮箱
							</th>
							<th width="15%">
								传真
							</th>
							<th width="15%">
								部门
							</th>
							<th width="15%">
								职位
							</th>
						</tr>
					</tbody>
					<tbody  class="list">
						<c:forEach items="${contacts}" var="c">
							<tr>
								<td>
				                  <c:choose>
				                      <c:when test="${VS_HAS_FUNCTIONS.contactView}">
											<a href="${ctx}/customer/contact/toViewPage.do?id=${c.id}"
												class="toviewpage">${c.name }</a>
										</c:when>
				                      <c:otherwise>${c.name }</c:otherwise>
				                  </c:choose>
				             	</td>
								<td>${c.phone }</td>
								<td>${c.mobile }</td>
								<td>${c.email }</td>
								<td>${c.fax }</td>
								<td>${c.department }</td>
								<td>${c.position }</td>
							</tr>
						</c:forEach>
						
					</tbody>
				</table>
				<div class=" h40"></div>
			</div>
		</c:if>
				<!-- 附件组件调用开始  -->
		<tag:attachment 
		view="${VS_HAS_FUNCTIONS.supplierAttView}" 
		upload="${VS_HAS_FUNCTIONS.supplierUpload}" 
		query="${VS_HAS_FUNCTIONS.supplierAttQuery}" 
		down="${VS_HAS_FUNCTIONS.supplierDown}"
		deleteFlag="${VS_HAS_FUNCTIONS.supplierAttDelete}" 
		module="supplier"
		id="${com.id}"></tag:attachment>
		<!-- 附件组件调用结束  -->
		<div class=" h40"></div>
	</div>
	<div class="cb block h40 margin0 mt10" style="width: 350px;">
		<ul class="id_table1 cb">
		</ul>
	</div>
</div>
</body>
</html>
