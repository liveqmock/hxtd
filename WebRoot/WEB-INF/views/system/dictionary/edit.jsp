<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>字典管理</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"></link>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js?v=1"></script>
<script type="text/javascript">
$(function(){
	jsUtil.bindSave(".add", "form"); //提交表单
	$("#dicType").change(function(){ //改变字典类型
		if(this.value == ''){
			$("#typeName").val('');
		}else{
			$("#typeName").val($(this).find("option:selected").text());
		}
	});
});
</script>
</head>
<body>
<form id="form" action="${ctx}${VR_FUNCTION.url}" method="POST">
<div class="ml35 mr35 mt20 block cb cb">
	<b class="b1"></b>
	<b class="b2"></b>
	<b class="b3"></b>
	<b class="b4"></b>
	<div class="ie_head">
		<h1 class="f14 fbnone mt10 ml10 fl">编辑字典信息</h1>
		<input type="hidden" name="id" value="${dictionary.id}"/>
	</div>
</div>
<div class="ml35 mr35 bg_c_blue cb">
	<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
	<table class="cb id_table3 w95b bg_c_white margin0 mt10">
		<tr>
			<td width="15%" align="right"><span class="w_red">*&nbsp;</span>字典名称：</td>
			<td align="left">
				<input type="text" name="key" value="${dictionary.key}" 
					class="text_input3 required {unique:['Dictionary','${fn:replace(dictionary.key,"'","\\'")}']}" maxlength="30"/>
			</td>
			<td width="15%" align="right"><span class="w_red">*&nbsp;</span>字典值：</td>
			<td align="left">
				<input type="text" name="value" value="${dictionary.value}" 
					class="text_input3 required {unique:['Dictionary','${dictionary.value}']}" maxlength="30"/>
			</td>
		</tr>
		<tr>
			<td align="right">字典类型：</td>
			<td align="left">
				<select name="parent.id" id="dicType" class="select1 pr">
               		<option value="">--无--</option>
               		<c:forEach var="item" items="${types}">
               			<option value="${item.id}" <c:if test="${item.key==dictionary.type}">selected</c:if>>${item.key}</option>
               		</c:forEach>
               	</select>
				<input type="hidden" id="typeName" name="type" value="${dictionary.type}"/>
			</td>
			<td align="right">排序：</td>
			<td align="left"><input type="text" name="order" value="${dictionary.order}" class="text_input3 digits" maxlength="10"/></td>
		</tr>
	</table>
	<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
	<table class="cb id_table4 w95b bg_c_white margin0 mt10">
		<tr>
			<td align="right" width="15%" valign="top">备注：</td>
			<td align="left" width="85%" valign="top"><textarea name="remark" class="remarks_input1" maxlength="500">${dictionary.remark}</textarea></td>
		</tr>
	</table>
	<div class="h40"></div>
</div>
<c:if test="${VS_HAS_FUNCTIONS.dictionaryModify}">
<div class="cb block h40 margin0 mt10" style="width:350px;">
	<ul class="id_table1 cb">
		<li>
			<a href="javascript:;" class="block c_white lh25 mr10 add" redirecturi="/system/dictionary/toViewPage.do?id=%s">
				<b class="allbtn_l block fl"></b>
				<b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b>
			</a>
		</li>
		<c:if test="${VS_HAS_FUNCTIONS.dictionaryModify}">
		<li>
			<a href="javascript:;" class="block c_white lh25 mr10 add" redirecturi="/system/dictionary/toAddPage.do">
				<b class="allbtn_l block fl"></b>
				<b class="allbtn_r pr13 block fl w_auto f14">保存并新增</b>
			</a>
		</li>
		</c:if>
		<li>
			<a href="${ctx}/system/dictionary/toQueryPage.do" class="block c_white lh25">
				<b class="allbtn_l block fl"></b>
				<b class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b>
			</a>
		</li>
	</ul>
</div>
</c:if>
</form>
</body>
</html>