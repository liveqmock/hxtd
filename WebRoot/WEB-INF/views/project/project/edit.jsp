<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>供应商详情</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/> 
<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript">
$(function(){
	jsUtil.datepickerNotNow(".time");
	$("#saveAndAdd").click(function(){
		var $form = $("#form");
		if($form.valid()){
			RcmsAjax.ajax($form.attr("action"),function(result){
				setTimeout(function(){
					window.location.replace("${ctx}/project/project/toAddPage.do")
				},500);
			},null,$form.formSerialize());
		}
		return false;
	});
	$("#save").click(function(){
		var $form = $("#form");
		if($form.valid()){
			RcmsAjax.ajax($form.attr("action"),function(result){
				var id = result.result.result;
				setTimeout(function(){
					window.location.replace("${ctx}/project/project/toViewPage.do?id="+id)
				},500);
			},null,$form.formSerialize());
		}
		return false;
	});
	jsUtil.renderRequiredFromInput();
});
function searchData(action){//搜索弹出框
	var url = "${ctx}/project/supplier/toSearchSupplierPage.docomp",
		title = "供应商";
	jsUtil.dialogIframe(url, title, 800, 465, function(){//确定回调
		var $userObj = $(".bor_e28d1f", window.frames["dialogIframe"].document);
			if($userObj.length > 0){
				$("#txt_" + action).val($userObj.find("td:eq(0)").text());
				$("#hide_" + action +"_id").val($userObj.attr("id"));
			}
		}
	);
}
function clearInputVal(obj){//清除
	$(obj).prevAll("input").val('');
}
</script>
</head>
<body>
<form id="form" action="${ctx }${funcUrl}" method="post">
<div>
	<div class="cb"></div>
	<div class="ml35 mr35 mt20 block cb cb">
		<b class="b1"></b>
		<b class="b2"></b>
		<b class="b3"></b>
		<b class="b4"></b>
		<div class="ie_head"><h1 class="f14 fbnone mt10 ml10 fl">项目详情信息</h1><ul class="fr id_table1 mt10 ml10"></ul></div>
	</div>
	<div class="ml35 mr35 bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">基本信息<input type="hidden" name="id" value="${project.id}"/></h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%">项目名称：</td>
				<td align="left"><input type="text" name="name" value="${project.name}" class="text_input3 required"></td>
				<td align="right" width="15%">项目编号：</td>
				<td align="left"><input type="text" name="code" value="${project.code}" class="text_input3 required {unique:['Project','${project.code}']}"></td>
			</tr>
			<tr>
				<td align="right">融资额度（万）：</td>
				<td align="left"><input type="text" name="financeLimit" value="${project.financeLimit}" class="text_input3 number required"></td>
				<td align="right">开始时间：</td>
				<td align="left">
					<fmt:formatDate value="${project.beginTime}" pattern="yyyy-MM-dd" var="beginTime"/>
					<input type="text" value="${beginTime}" name="beginTime" class="time text_input3 input_close1 required" readonly/>
				</td>
			</tr>
			<tr>
				<td align="right">融资前周期（天）：</td>
				<td align="left"><input type="text" name="beforeFinanceCycle" value="${project.beforeFinanceCycle}" class="text_input3 number required"></td>
				<td align="right">截止时间：</td>
				<td align="left">
					<fmt:formatDate value="${project.dendlineTime}" pattern="yyyy-MM-dd" var="dendlineTime"/>
					<input type="text" value="${dendlineTime}" name="dendlineTime" class="time text_input3 input_close1 required" readonly>
				</td>
			</tr>
			<tr>
				<td align="right">融资周期（天）：</td>
				<td align="left"><input type="text" name="financeCycle" value="${project.financeCycle}" class="text_input3 number required"></td>
				<td align="right">收益率（%）：</td>
				<td align="left"><input type="text" name="er" value="${project.er}" class="text_input3 number required"></td>
			</tr>
			<tr>
				<td align="right">支付方式：</td>
				<td align="left">
					<select name="payType.id" class="select1 required">
						<option value="">--无--</option>
						<c:forEach items="${payType}" var="p">
							<option value="${p.id}" <c:if test="${p.id==project.payType.id}">selected</c:if>>${p.key}</option>
						</c:forEach>
					</select>
				</td>
				<td align="right">赎回赔率（%）：</td>
				<td align="left"><input type="text" name="aer" value="${project.aer}" class="text_input3 number required"></td>
			</tr>
			<tr>
				<td align="right">供应商：</td>
				<td align="left">
					<input type="text" id="txt_supplier" value="${project.supplier.name}" 
						class="text_input3 required" onclick="searchData('supplier')" readonly>
					<input type="hidden" name="supplier.id" id="hide_supplier_id" value="${project.supplier.id}"/>
					<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索供应商" onclick="searchData('supplier');"></i>
					<i class="dump_btn globle_img block_inline ml5 vm cp empty" title="清除" onclick="clearInputVal(this)"></i>
				</td>
				<td align="right">开放时间：</td>
				<td align="left">
					<fmt:formatDate value="${project.openTime}" pattern="yyyy-MM-dd" var="openTime"/>
					<input type="text" value="${openTime}" name="openTime" class="text_input3 time input_close1 required" readonly>
				</td>
			</tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
		<table class="cb id_table4 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%" valign="top">备注：</td>
				<td align="left" width="85%" valign="top"><textarea name="remark" class="remarks_input1 {maxlength:512}">${project.remark}</textarea></td>
			</tr>
		</table>
		<div class=" h40"></div>
	</div>
	<div class="cb block h40 margin0 mt10" style="width: 350px;">
		<ul class="id_table1 cb">
			<li>
				<a href="javascript:;" id="save" class="block c_white lh25 mr10">
					<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b>
				</a>
			</li>
			<li>
				<a href="javascript:;" id="saveAndAdd" class="block c_white lh25 mr10">
					<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保存并新建</b>
				</a>
			</li>
			<li>
				<a href="${ctx}/project/project/toQueryPage.do" class="block c_white lh25">
					<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b>
				</a>
			</li>
		</ul>
	</div>
</div>
</form>
</body>
</html>
