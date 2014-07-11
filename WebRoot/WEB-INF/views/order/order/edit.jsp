<%--
  功能描述：编辑订单
  User: xiaoli.luo
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>订单编辑</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
<link rel="stylesheet" type="text/css" href="styles.css">
-->
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail_a.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript">
$(function(){
	$("#saveAndAdd").click(function(){
		var $form = $("#form");
		if($form.valid()){
			RcmsAjax.ajax($form.attr("action"),function(result){
				setTimeout(function(){
					window.location.replace("${ctx}/order/order/toAddPage.do")
				},500);
			},null,$form.formSerialize());
		}
		return false;
	});
	$("#save").click(function(){
		var $form = $("#form");
		if($form.valid()){
			RcmsAjax.ajax($form.attr("action"),function(result){
				//redirect
				var id = result.result.result;
				setTimeout(function(){
					window.location.replace("${ctx}/order/order/toViewPage.do?id="+id)
				},500);
			},null,$form.formSerialize());
		}
		return false;
	});
	jsUtil.datepickerNotNow(".time");
});
function searchData(action){//搜索弹出框
	var url, title;
	if(action == "owner"||action == "salesManager"||action == "salesMajordomo"){
		url = "${ctx}/system/user/toQueryPage.comp";
		title = "所有者";
	}else if(action == "customer"){
		url = "${ctx}/customer/customer/toQueryPage.comp";
		title = "客户";
	}else if(action == "product"){
		url = "${ctx}/project/product/toQueryPage.comp";
		title = "产品";
	}
	jsUtil.dialogIframe(url, title, 800, 465, function(){//确定回调
		var $userObj = $(".bor_e28d1f", window.frames["dialogIframe"].document);
			if($userObj.length > 0){
				$("#txt_" + action).val($userObj.find("td:eq(0)").text());
				$("#hide_" + action +"_id").val($userObj.attr("id"));
			}
	});
}
function clearInputVal(obj){//清除
	$(obj).prevAll("input").val('');
}
</script>
</head>
<body>
<form id="form" action="${ctx }${funcUrl}" method="post">
<div>
	<!--请在此处使用iframe--->
	<!--查询条件开始-->

	<!--查询条件结束-->
	<div class="cb"></div>
	<!--列表开始-->
	<div class="ml35 mr35 mt20 block cb cb">
		<b class="b1"></b>
		<b class="b2"></b>
		<b class="b3"></b>
		<b class="b4"></b>
		<div class="ie_head">
			<h1 class="f14 fbnone mt10 ml10 fl">
				订单详情信息
			</h1>
			<ul class="fr id_table1 mt10 ml10">
			</ul>
		</div>
	</div>
	<input type="hidden" name="id" value="${order.id}" />
	<div class="ml35 mr35 bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">
			基本信息
		</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%">
					订单编号：
				</td>
				<td align="left">
				<input type="text" name="code"
						value="${order.code}" class="text_input3" />
				</td>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>所有者：
				</td>
				<td align="left">
					<input type="text" id="txt_owner" value="${order.owner.name }"
						class="text_input3 cp required" readonly 
						onclick="searchData('owner');" />
					<input type="hidden" id="hide_owner_id" name="owner.id"
						value="${order.owner.id }" />
					<i class="s_inquiry globle_img block_inline ml5 vm cp"
						title="搜索所有者" onclick="searchData('owner');"></i>
					<i class="dump_btn globle_img block_inline ml5 vm cp empty"
						title="清除"></i>
				</td>
			</tr>
			<tr>
				<td align="right">
					<span class="w_red">*&nbsp;</span>产品：
				</td>
				<td align="left">
					<input type="text" value="${order.product.name }"
						class="text_input3 cp required" id="txt_product" 
						onclick="searchData('product');" 
						readonly/>
					<input type="hidden" value="${order.product.id}"
						id="hide_product_id" name="product.id" />
					<i class="s_inquiry globle_img block_inline ml5 vm cp"
						title="搜索产品" onclick="searchData('product');"></i>
					<i class="dump_btn globle_img block_inline ml5 vm cp empty"
						title="清除"></i>
				</td>
				<td align="right">
					<span class="w_red">*&nbsp;</span>客户：
				</td>
				<td align="left">
					<input type="text" id="txt_customer"
						value="${order.customer.name }" 
						class="text_input3 cp required" readonly
						 onclick="searchData('customer');"/>
					<input type="hidden" value="${order.customer.id}"
						id="hide_customer_id" name="customer.id" />
					<i class="s_inquiry globle_img block_inline ml5 vm cp"
						title="搜索客户" onclick="searchData('customer');"></i>
					<i class="dump_btn globle_img block_inline ml5 vm cp empty"
						title="清除"></i>
				</td>
			</tr>
			<tr>
				<td align="right">
					<span class="w_red">*&nbsp;</span>订单状态：
				</td>
				<td align="left">
					<select name="status.id" class="select1 pr requiredSelect">
						<option value="-1">
							--无--
						</option>
						<c:forEach items="${status}" var="s">
							<option value="${s.id}"
								<c:if test="${s.id==order.status.id}">selected</c:if>>
								${s.key}
							</option>
						</c:forEach>
					</select>
				</td>
				<td align="right">
					<span class="w_red">*&nbsp;</span>投资方式：
				</td>
				<td align="left">
					<select name="investmentWay.id"
						class="select1 pr requiredSelect">
						<option value="-1">
							--无--
						</option>
						<c:forEach items="${investmentWay}" var="s">
							<option value="${s.id}"
								<c:if test="${s.id==order.investmentWay.id}">selected</c:if>>
								${s.key}
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">
					<span class="w_red">*&nbsp;</span>购买金额（万）：
				</td>
				<td align="left">
					<input type="text" name="purchaseMoney"
						value="${order.purchaseMoney}" class="text_input3 number" />
				</td>
				<td align="right">
					<span class="w_red">*&nbsp;</span>收益率（%）：
				</td>
				<td align="left">
					<input type="text" name="earningRate"
						value="${order.earningRate}" class="text_input3 number" />
				</td>

			</tr>
			<tr>
				<td align="right">
					<span class="w_red">*&nbsp;</span>赎回率（%）：
				</td>
				<td align="left">
					<input type="text" name="arr" value="${order.arr }"
						class="text_input3 number" />
				</td>
				<td align="right">
					<span class="w_red">*&nbsp;</span>赎回公式：
				</td>
				<td align="left">
					<input type="text" name="redeemFormula"
						value="${order.redeemFormula }" class="text_input3" />
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>销售主管：
				</td>
				<td align="left">
					<input type="text" id="txt_salesManager"
						value="${order.salesManager.name }"
						class="text_input3 cp required" readonly 
						onclick="searchData('salesManager');"/>
					<input type="hidden" id="hide_salesManager_id"
						name="salesManager.id" value="${order.salesManager.id }" />
					<i class="s_inquiry globle_img block_inline ml5 vm cp"
						title="搜索所有者" onclick="searchData('salesManager');"></i>
					<i class="dump_btn globle_img block_inline ml5 vm cp empty"
						title="清除"></i>
				</td>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>销售总监：
				</td>
				<td align="left">
					<input type="text" id="txt_salesMajordomo"
						value="${order.salesMajordomo.name }"
						class="text_input3 cp required" readonly
						onclick="searchData('salesMajordomo');" />
					<input type="hidden" id="hide_salesMajordomo_id"
						name="salesMajordomo.id" value="${order.owner.id }" />
					<i class="s_inquiry globle_img block_inline ml5 vm cp"
						title="搜索所有者" onclick="searchData('salesMajordomo');"></i>
					<i class="dump_btn globle_img block_inline ml5 vm cp empty"
						title="清除"></i>
				</td>
			</tr>
			<tr>
				<td align="right">
					<span class="w_red">*&nbsp;</span>结束时间：
				</td>
				<td align="left">
				<fmt:formatDate value="${order.orderEndTime }"
						pattern="yyyy-MM-dd" var="endTime" />
						<a href="javascript:;" class="pa time_closenone1"></a>
					<input type="text" name="orderEndTime" value="${endTime }"
						class="text_input3 input_close1 time required" readonly />
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
				<td align="left" width="85%">
					<textarea name="remark" class="remarks_input1">${order.remark}</textarea>
				</td>
			</tr>

		</table>
		<div class=" h40"></div>
	</div>
	<div class="cb block h40 margin0 mt10" style="width: 350px;">
		<ul class="id_table1 cb">
			<li>
				<a href="javascript:;" id="save" class="block c_white lh25 mr35"><b
					class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">保&nbsp&nbsp存</b> </a></a>
			</li>
			<li>
				<a href="javascript:;" id="saveAndAdd"
					class="block c_white lh25 mr35"><b class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">保存并新建</b> </a>
			</li>
			<li>
				<a href="${ctx}/order/order/toQueryPage.do"
					class="block c_white lh25"><b class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">取&nbsp&nbsp消</b> </a>
			</li>
		</ul>
	</div>
</div>
</form>
</body>
</html>

