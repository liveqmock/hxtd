<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>产品</title>
<link href="${ctx}/static/css/recommend/detail.css?v=1" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.datepicker.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js?v=1"></script>
<script type="text/javascript">
$(function(){
	jsUtil.bindSave(".add", "form"); // 提交表单
	jsUtil.formatMoney(".money"); //设置千分位
	var $dates = $("#start,#end"); // 日历设置
	$dates.datepicker({
		closeText : '关闭',
		minDate: 0,
	    onSelect: function(selectedDate){
	       var option = this.id == "start" ? "minDate" : "maxDate";
	       $dates.not(this).datepicker("option", option, selectedDate);
	    }
	});
	$(".empty").click(function(){ // 清除
		$(this).prevAll("input").val('');
	});
});
function searchData(action){ // 搜索
	jsUtil.dialogIframe("${ctx}/project/project/toQueryPage.comp", "项目列表", 800, 465, 
		function(){ // 确定回调
			var $userObj = $(".bor_e28d1f", window.frames["dialogIframe"].document);
			if($userObj.length > 0){
				$("#txt_" + action).val($userObj.find("td:eq(0)").text());
				$("#hide_" + action +"_id").val($userObj.attr("id"));
			}
	});
}
</script>
</head>
<body>
<form action="${ctx}${VR_FUNCTION.url}" method="post">
<div class="ml35 mr35 mt20 block cb cb">
	<b class="b1"></b>
	<b class="b2"></b>
	<b class="b3"></b>
	<b class="b4"></b>
	<div class="ie_head">
		<h1 class="f14 fbnone mt10 ml10 fl">编辑产品信息</h1>
		<input type="hidden" name="id" value="${product.id}"/>
	</div>
</div>
<div class="ml35 mr35 bg_c_blue cb">
	<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
	<table class="cb id_table3 w95b bg_c_white margin0 mt10">
		<tr>
			<td width="15%" align="right"><span class="w_red">*&nbsp;</span>产品名称：</td>
			<td align="left"><input name="name" type="text" value="${product.name}" class="text_input3 required"/></td>
			<td width="15%" align="right"><span class="w_red">*&nbsp;</span>产品编号：</td>
			<td align="left"><input name="code" type="text" value="${product.code}" class="text_input3"/></td>
		</tr>
		<tr>
			<td align="right">产品类型：</td>
			<td align="left">
				<select name="type.id" class="select1">
				 	<option value="">--无--</option>
				 	<c:forEach items="${dicType}" var="d">
				 		<option value="${d.id}" 
				 		<c:if test="${d.id==product.type.id}">
				 			selected
				 		</c:if>
				 		>${d.key}</option>
				 	</c:forEach>
				 </select>
			</td>
			<td align="right"><span class="w_red">*&nbsp;</span>所属项目：</td>
			<td align="left">
				<input type="text" id="txt_project" name="projectname" value="${product.project.name}" readonly 
					class="text_input3 required cp" onclick="searchData('project');"/>
				<input type="hidden"id="hide_project_id" name="project.id" value="${product.project.id}"/>
				<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索项目" onclick="searchData('project');"></i>
				<i class="dump_btn globle_img block_inline ml5 vm cp empty" title="清除"></i>
			</td>
		</tr>
		<tr>
			<td align="right"><span class="w_red">*&nbsp;</span>出售金额：</td>
			<td align="left">
				<fmt:formatNumber value="${product.sellMoney}" pattern="###,##0.00" var="sellMoney"/>
				<input type="text" value="${sellMoney}" class="text_input3 right required money" style="ime-mode:disabled"/>
				<input type="hidden" name="sellMoney" value="${product.sellMoney}"/>
			</td>
			<td align="right">收益率(%)：</td>
			<td align="left">
				<input name="minRate" type="text" value="${product.minRate}" class="text_input3 right"/>
				<!--~&nbsp;<input name="maxRate" type="text" value="${product.maxRate}" class="text_input4 right"/> -->
			</td>
		</tr>
		<tr>
			<td align="right">预期收益：</td>
			<td align="left">
				<fmt:formatNumber value="${product.expectProfit}" pattern="###,##0.00" var="expectProfit"/>
				<input type="text" value="${expectProfit}" class="right text_input3 money" style="ime-mode:disabled"/>
				<input type="hidden" name="expectProfit" value="${product.expectProfit}"/>
			</td>
			<td align="right">销售期限：</td>
			<td align="left">
				<input name="saleLimit" type="text" value="${product.saleLimit}" class="right text_input4"/>
				&nbsp;/&nbsp;<select name="saleUnit.id" class="select3" style="width: 130px;">
				 	<c:forEach items="${dicUnit}" var="d">
				 		<option value="${d.id}" 
				 		<c:if test="${d.id==product.saleUnit.id}">
				 			selected
				 		</c:if>
				 		>${d.key}</option>
				 	</c:forEach>
				 </select>
			</td>
		</tr>
		<tr>
			<td align="right"><span class="w_red">*&nbsp;</span>销售开始日期：</td>
			<td align="left">
				<a href="javascript:;" class="pa time_closenone1"></a>
				<fmt:formatDate value="${product.saleBeginTime}" pattern="yyyy-MM-dd" var="saleBeginTime"/>
				<input id="start" name="saleBeginTime" type="text" value="${saleBeginTime}" 
					class="text_input3 input_close1 required" readonly/>
			</td>
			<td align="right">赎回赔率(%)：</td>
			<td align="left"><input name="redeemRate" type="text" value="${product.redeemRate}" class="right text_input3 amount"/></td>
		</tr>
		<tr>
			<td align="right"><span class="w_red">*&nbsp;</span>销售结束日期：</td>
			<td align="left">
				<a href="javascript:;" class="pa time_closenone1"></a>
				<fmt:formatDate value="${product.saleEndTime}" pattern="yyyy-MM-dd" var="saleEndTime"/>
				<input id="end" name="saleEndTime" type="text" value="${saleEndTime}" readonly 
					class="text_input3 input_close1 required"/>
			</td>
			<td align="right">赎回公式：</td>
			<td align="left"><input name="redeemFormula" type="text" value="${product.redeemFormula}" class="text_input3"/></td>
		</tr>
	</table>
	<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
	<table class="cb id_table4 w95b bg_c_white margin0 mt10">
		<tr>
			<td align="right" width="15%" valign="top">备注：</td>
			<td align="left" width="85%" valign="top"><textarea name="remark" 
				class="remarks_input1" style="resize: none;">${product.remark}</textarea></td>
		</tr>
	</table>
	<div class="h40"></div>
</div>
<c:if test="${VS_HAS_FUNCTIONS.productModify}">
<div class="cb block h40 margin0 mt10" style="width:350px;">
	<ul class="id_table1 cb">
		<li>
			<a href="javascript:;" class="block c_white lh25 mr10 add" redirecturi="/project/product/toViewPage.do?id=%s">
				<b class="allbtn_l block fl"></b>
				<b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b>
			</a>
		</li>
		<c:if test="${VS_HAS_FUNCTIONS.productAdd}">
		<li>
			<a href="javascript:;" class="block c_white lh25 mr10 add" redirecturi="/project/product/toAddPage.do">
				<b class="allbtn_l block fl"></b>
				<b class="allbtn_r pr13 block fl w_auto f14">保存并新增</b>
			</a>
		</li>
		</c:if>
		<li>
			<a href="${ctx}/project/product/toQueryPage.do" class="block c_white lh25">
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