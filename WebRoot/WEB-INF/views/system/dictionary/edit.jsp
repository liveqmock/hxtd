<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>字典信息</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"></link>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<style type="text/css">
	input.error { border: 1px solid red }
	label.error { padding-left: 18px; color: red; }
</style>
<script type="text/javascript">
$(function(){
	$("#form").validate({
		rules: {
			key: { required: true },
			value: { required: true },
		},
		messages: {
			key: { required: "*请输入字典名称"},
			value: { required: "*请输入字典值"},
		}
	});
	$(".add").click(function(){
		if($("#form").valid()){
			form.action = form.action + "?redirectUri=" + encodeURI($(this).attr("redirecturi"));
			form.submit();
		}
		return false;
	});
	$("#pName").focus(function(){//tree
		jsUtil.easyTree.show('#pName');
	});;
	jsUtil.easyTree.init(${dict}, function(node){
		$("#pName").val(node.name);
		$("#pId").val(node.id);
		$("#dicType").val(node.typename);
		jsUtil.easyTree.hide();
	});
	$("#dicType").change(function(){
		if(this.value == '0'){
			$("#pName").val('');
			$("#pId").val('');
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
			<td width="15%" align="right">字典名称：</td>
			<td align="left"><input type="text" name="key" value="${dictionary.key}" class="text_input3"/></td>
			<td width="15%" align="right">字典值：</td>
			<td align="left"><input type="text" name="value" value="${dictionary.value}" class="text_input3" readonly/></td>
		</tr>
		<tr>
			<td align="right">所属字典：</td>
			<td align="left">
				<input type="text" name="parent.name" id="pName" value="${dictionary.parent.name}" readonly="readonly" class="text_input3"/>
				<input type="hidden" name="parent.id" id="pId" value="${dictionary.parent.id}"/>
			</td>
			<td align="right">字典类型：</td>
			<td align="left">
				<select name="type" id="dicType" class="select1 pr">
                		<option value="0">--无--</option>
                		<c:forEach var="item" items="${types}">
                			<option value="${item}">${item}</option>
                		</c:forEach>
                	</select>
				<input type="hidden" id="typeName" name="typename" value="${dictionary.type}"/>
			</td>
		</tr>
		<tr>
			<td align="right">是否启用：</td>
			<td align="left">
				<select name="isActive" class="select1 pr">
               		<option value="1" ${dictionary.isActive==1?'selected':''}>是</option>
               		<option value="0" ${dictionary.isActive==0?'selected':''}>否</option>
               	</select>
			</td>
			<td align="right">排序：</td>
			<td align="left"><input type="text" name="order" value="${dictionary.order}" class="text_input3"/></td>
		</tr>
	</table>
	<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
	<table class="cb id_table4 w95b bg_c_white margin0 mt10">
		<tr>
			<td align="right" width="15%">备注：</td>
			<td align="left" width="85%"><textarea name="remark" class="remarks_input1" style="resize: none;">${dictionary.remark}</textarea></td>
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