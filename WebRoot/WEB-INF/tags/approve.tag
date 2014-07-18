<%@tag pageEncoding="UTF-8"%>
<%@ attribute name="wftype" type="java.lang.String" required="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<h1 class="f14 fbnone ml40 mt10">订单审批</h1>
<div class="w95b bg_c_white margin0 mt10">
	<h1 class="w90b margin0 fbnone f12 pt20 block">审批流程：</h1>
	<b class="w90b f_line2 block margin0"></b>
	<table class="cb id_table2 w90b margin0 mt10 mb10">
		<tr>
			<th>审批名称</th>
			<th>审批级别</th>
			<th>机构名称</th>
			<th>审批人</th>
			<th>操作</th>
		</tr>
		<tbody class="list">
			<tr class="bg_c_blue">
				<td>理财经理</td>
				<td>1</td>
				<td>市场营销部</td>
				<td>
					<select class="select3 pr">
						<option>李华</option>
						<option>张三</option>
					</select >
				</td>
				<td><a href="javascript:;" class="block_inline s_approve globle_img ml10" title="保存"></a></td>
			</tr>
			<tr>
				<td>投资经理</td>
				<td>2</td>
				<td>市场营销部</td>
				<td>
					<select class="select3 pr">
						<option>李华</option>
						<option>张三</option>
					</select>
				</td>
				<td><a href="javascript:;" class="block_inline s_approve globle_img ml10" title="保存"></a></td>
			</tr>
			<tr class="bg_c_blue">
				<td>投资总监</td>
				<td>3</td>
				<td>市场营销部</td>
				<td>
					<select class="select3 pr">
						<option>李华</option>
						<option>张三</option>
					</select>
				</td>
				<td><a href="javascript:;" class="block_inline s_approve globle_img ml10" title="保存"></a></td>
			</tr>
			<tr>
				<td>副总经理</td>
				<td>4</td>
				<td>华兴控股</td>
				<td>
					<select class="select3 pr">
						<option>李华</option>
						<option>张三</option>
					</select>
				</td>
				<td><a href="javascript:;" class="block_inline s_approve globle_img ml10" title="保存"></a></td>
			</tr>
			<tr class="bg_c_blue">
				<td>总裁</td>
				<td>5</td>
				<td>总裁办公室</td>
				<td>
					<select class="select3 pr">
						<option>李华</option>
						<option>张三</option>
					</select>
				</td>
				<td><a href="javascript:;" class="block_inline s_approve globle_img ml10" title="保存"></a></td>
			</tr>
			<tr>
				<td>财务</td>
				<td>6</td>
				<td>财务部</td>
				<td>
					<select class="select3 pr">
						<option>张思雨</option>
						<option>张三</option>
					</select>
				</td>
				<td><a href="javascript:;" class="block_inline s_approve globle_img ml10" title="保存"></a></td>
			</tr>
		</tbody>
	</table>
	<h1 class="w90b margin0 fbnone f12 pt20 block">审批记录：</h1>
	<b class="w90b f_line2 block margin0"></b>
	<table class="cb id_table2 w90b margin0 mt10 mb10">
		<tr>
			<th>审批名称</th>
			<th>机构名称</th>
			<th>审批人</th>
			<th>状态</th>
			<th>备注</th>
		</tr>
		<tbody class="list">
			<tr class="bg_c_blue">
				<td>理财经理</td>
				<td>市场营销部</td>
				<td>理财经理A1</td>
				<td>通过</td>
				<td>已审批</td>
			</tr>
			<tr>
				<td>投资经理</td>
				<td>市场营销部</td>
				<td>投资经理A1</td>
				<td>未通过</td>
				<td>购买金额不对</td>
			</tr>
		</tbody>
	</table>
</div>