<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>联系人编辑</title>
<link href="${ctx}/static/css/recommend/detail.css?v=1" type="text/css" rel="stylesheet"></link>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/pacs.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js?v=1"></script>
<script type="text/javascript">${applicationScope.VC_PCAS}</script>
<script type="text/javascript">
$(function(){
	jsUtil.bindSave(".add", "form"); //提交表单
	new PCAS("province","city","county",'${contact.province.id}','${contact.city.id}','${contact.county.id}'); //绑定省市县
	$(".empty").click(function(){ //清除
		$(this).prevAll("input").val('');
	});
	$("#contactType").change(function(){
		$("#txt_customer").removeClass("required");
		$("#txt_supplier").removeClass("required");
		$(".customer").hide();
		$(".supplier").hide();
		var val = $(this).val();
		if(val == "customer"){
			$(".customer").show();
			$("#txt_customer").addClass("required");
		} else {
			$(".supplier").show();
			$("#txt_supplier").addClass("required");
		}
	});
	$("#contactType").val("${contact.supplier.name != null ? 'supplier' : 'customer'}").change();
	jQuery.validator.addMethod("check", function() { //自定义验证
    	return $(".isPhone").val().length > 0 || $(".isMobile").val().length > 0;
    }, "电话和手机必须一个有值！");
});
function searchData(action){ //搜索弹出框
	var url, title;
	if(action == "owner"){
		url = "${ctx}/system/user/toQueryPage.comp";
		title = "所有者";
	}else if(action == "customer"){
		url = "${ctx}/customer/customer/toQueryPage.comp";
		title = "客户";
	}else if(action == "supplier"){
		url = "${ctx}/project/supplier/toQueryPage.comp";
		title = "供应商";
	}
	jsUtil.dialogIframe(url, title, 800, 465, 
		function(){ //确定回调
			var $userObj = $('.bor_e28d1f', window.frames["dialogIframe"].document);
			if($userObj.length > 0){
				$("#txt_" + action).val($userObj.find("td:eq(0)").text());
				$("#hide_" + action +"_id").val($userObj.attr("id"));
			}
	});
}
</script>
</head>
<body>
<form id="form" action="${ctx}${VR_FUNCTION.url}" method="post">
<div class="ml35 mr35 mt20 block cb cb">
	<b class="b1"></b>
	<b class="b2"></b>
	<b class="b3"></b>
	<b class="b4"></b>
	<div class="ie_head">
		<h1 class="f14 fbnone mt10 ml10 fl">编辑联系人</h1>
		<input type="hidden" name="id" value="${contact.id}"/>
	</div>
</div>
<div class="ml35 mr35 bg_c_blue cb">
	<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
	<table class="cb id_table3 w95b bg_c_white margin0 mt10">
		<tr>
			<td width="15%" align="right"><span class="w_red">*&nbsp;</span>联系人所有者：</td>
			<td align="left">
				<input id="txt_owner" type="text" value="${contact.owner.realName}" class="text_input3 cp" readonly 
					onclick="searchData('owner');"/>
				<input id="hide_owner_id" type="hidden" name="owner.id" value="${contact.owner.id}"/>
				<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索所有者" onclick="searchData('owner');"></i>
				<i class="dump_btn globle_img block_inline ml5 vm cp empty" title="清除"></i>
			</td>
			<td width="15%" align="right">线索来源：</td>
			<td align="left">
				<select name="source.id" class="select1">
					<option value="">--无--</option>
					<c:forEach items="${dict}" var="dic">
						<option value="${dic.id}" ${contact.source.id==dic.id?"selected":""}>${dic.key}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right"><span class="w_red">*&nbsp;</span>联系人名：</td>
			<td align="left"><input name="name" type="text" value="${contact.name}" class="text_input3 required" maxlength="10"/></td>
			<td align="right">联系人类型：</td>
			<td align="left">
				<select id="contactType" name="contactType" class="select1">
					<option value="customer">客户</option>
					<option value="supplier">供应商</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">电话：</td>
			<td align="left"><input name="phone" type="text" value="${contact.phone}" class="text_input3 isPhone check"/></td>
			<td align="right" class="customer"><span class="w_red">*&nbsp;</span>客户名：</td>
			<td align="left" class="customer">
				<input id="txt_customer" type="text" value="${contact.customer.name}" readonly class="text_input3 cp required" 
					onclick="searchData('customer');"/>
				<input id="hide_customer_id" name="customer.id" type="hidden" value="${contact.customer.id}"/>
				<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索客户" onclick="searchData('customer');"></i>
				<i class="dump_btn globle_img block_inline ml5 vm cp empty" title="清除"></i>
			</td>
			<td align="right" class="supplier" style="display:none;"><span class="w_red">*&nbsp;</span>供应商名：</td>
			<td align="left" class="supplier" style="display:none;">
				<input id="txt_supplier" type="text" value="${contact.supplier.name}" readonly class="text_input3 cp required" 
					onclick="searchData('supplier');"/>
				<input id="hide_supplier_id" name="supplier.id" type="hidden" value="${contact.supplier.id}"/>
				<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索供应商" onclick="searchData('supplier');"></i>
				<i class="dump_btn globle_img block_inline ml5 vm cp empty" title="清除"></i>
			</td>
		</tr>
		<tr>
			<td align="right">手机：</td>
			<td align="left"><input name="mobile" type="text" value="${contact.mobile}" class="text_input3 isMobile check"/></td>
			<td align="right">邮箱：</td>
			<td align="left"><input type="text" name="email" value="${contact.email}" class="text_input3 email"/></td>
		</tr>
		<tr>
			<td align="right">部门：</td>
			<td align="left"><input name="department" type="text" value="${contact.department}" class="text_input3"/></td>
			<td align="right">传真：</td>
			<td align="left"><input type="text" name="fax" value="${contact.fax}" class="text_input3 isTel"/></td>
		</tr>
		<tr>
			<td align="right">职位：</td>
			<td align="left"><input type="text" name="position" value="${contact.position}" class="text_input3" maxlength="30"/></td>
			<td align="right">邮编：</td>
			<td align="left"><input name="postCode" type="text" value="${contact.postCode}" class="text_input3 isZipCode"/></td>
		</tr>
	</table>
	<h1 class="f14 fbnone ml40 pt10">地址信息</h1>
	<table class="cb id_table3 w95b bg_c_white margin0 mt10">
		<tr>
			<td width="15%" align="right">省份：</td>
			<td align="left"><select id="province" name="province.id" class="select1"></select></td>
			<td width="15%" align="right">城市：</td>
			<td align="left"><select id="city" name="city.id" class="select1"></select></td>
		</tr>
		<tr>
			<td align="right">区县：</td>
			<td align="left"><select id="county" name="county.id" class="select1"></select></td>
			<td align="right">详细地址：</td>
			<td align="left"><input name="address" type="text" value="${contact.address}" class="text_input3" maxlength="50"/></td>
		</tr>
	</table>
	<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
	<table class="cb id_table4 w95b bg_c_white margin0 mt10">
		<tr>
			<td align="right" width="15%" valign="top">备注：</td>
			<td align="left" width="85%" valign="top"><textarea name="remark" class="remarks_input1" maxlength="500">${contact.remark}</textarea></td>
		</tr>
	</table>
	<div class="h40"></div>
</div>
<c:if test="${VS_HAS_FUNCTIONS.contactModify}">
<div class="cb block h40 margin0 mt10" style="width:350px;">
	<ul class="id_table1 cb">
		<li>
			<a href="javascript:;" class="block c_white lh25 mr10 add" redirecturi="/customer/contact/toViewPage.do?id=%s">
				<b class="allbtn_l block fl"></b>
				<b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b>
			</a>
		</li>
		<c:if test="${VS_HAS_FUNCTIONS.contactAdd}">
		<li>
			<a href="javascript:;" class="block c_white lh25 mr10 add" redirecturi="/customer/contact/toAddPage.do">
				<b class="allbtn_l block fl"></b>
				<b class="allbtn_r pr13 block fl w_auto f14">保存并新增</b>
			</a>
		</li>
		</c:if>
		<li>
			<a href="${ctx}/customer/contact/toQueryPage.do" class="block c_white lh25 mr10">
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
