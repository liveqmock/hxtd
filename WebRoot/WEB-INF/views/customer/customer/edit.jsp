<%--
  功能描述：编辑客户
  User: xiaoli.luo
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>客户编辑页</title>
<style type="text/css">
	input.error { border: 1px solid red }
	label.error { padding-left: 18px; color: red; }
</style>
<link href="${ctx}/static/css/stressing/detail.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
   <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
  
<script type="text/javascript">
$(function(){
	$("#save").click(function(){
		if($("#form").valid()){
			$("#form").submit();
		}
	});
	$("#saveAndAdd").click(function(){
		$("#form").attr("action",$("#form").attr("action")+"?type=add");
		if($("#form").valid()){
			$("#form").submit();
		}
	});
	
	
	//获得省市县代码，加载三级联动
	var province = '${customer.province.id}';
	var city = '${customer.city.id}';
	var county = '${customer.county.id}';
	//修改为根据ID选择组件，之前用name选择组件当name中出现“.”时有问题
	new PCAS("province","city","county",province,city,county);
});
</script>
<script type="text/javascript"> 

    function searchData(action){//搜索弹出框
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
	jsUtil.dialogIframe(url, title, 800, 465, function(){//确定回调
		var ckObj = $(":checked", window.frames["dialogIframe"].document);
		if(ckObj.length > 0){
			$("#txt_" + action).val(ckObj.parent().next().text());
			$("#hide_" + action +"_id").val(ckObj.val());
		}
	});
}

function clearInputVal(obj){//清除
	$(obj).prevAll("input").val('');
}
        </script> 

</head>
<body>
<div class="cb"></div>
<form id="form" action="${ctx }${funcUrl}" method="post">
	<div class="ml35 mr35 mt20 block cb cb">
	<b class="table_headl globle_img block fl"></b>
	<div class="fl table_headc fl w99b">
	<h1 class="f14 fbnone mt10 ml10 fl">编辑客户信息</h1>
		<input type="hidden" name="id" value="${customer.id}"/>
	</div>
	<b class="table_headr globle_img block fl"></b>
	</div>
	
	<div class="ml35 mr35 bg_c_blue cb">
	<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
	<table  class="cb id_table3 w95b bg_c_white margin0 mt10">
		<tr>
			<td  align="right" width="15%"><span class="w_red">*&nbsp;</span>客户所有者：</td>
			<td align="left">
			<input class="text_input3 required" id="txt_owner" type="text" value="${customer.owner.name }"/>
			<input id="hide_owner_id" name="owner.id" type="text" value="${customer.owner.id }" style="display:none;"/>
			<img src="${ctx}/static/images/search.png" alt="" title="搜索所有者" onclick="searchData('owner');"/>
			<img src="${ctx}/static/images/clear.png" alt="" title="清除" onclick="clearInputVal(this);"/>
			</td>
			<td  align="right" width="15%"><span class="w_red">*&nbsp;</span>客户类型：</td>
			<td align="left">
				<select name="type.id" class="select1 pr requiredSelect">
				<option value="-1">--无--</option>
					<c:forEach items="${cType}" var="type">
						<option value="${type.id }"
						<c:if test="${customer.type.id==type.id }">
							selected
						</c:if>
						>${type.key }</option>
					</c:forEach>
				</select>
				<!--<input name="" type="text" value="${customer.type.key }"/>
				<input name="type.id" type="text" value="${customer.type.id }" style="display:none;"/>-->
			</td>
		</tr>
		<tr>
			<td  align="right" width="15%"><span class="w_red">*&nbsp;</span>客户名称：</td>
			<td align="left"><input class="text_input3 required" name="name" type="text" value="${customer.name }"/></td>
			<td  align="right" width="15%"><span class="w_red">*&nbsp;</span>客户来源：</td>
			<td align="left">
				<select name="source.id" class="select1 pr requiredSelect">
				<option value="-1">--无--</option>
				<c:forEach items="${source}" var="source">
				<option value="${source.id }"
						<c:if test="${customer.source.id==source.id }">
							selected
						</c:if>
						>${source.key }</option>
				</c:forEach>
					
				</select>
				<!--<input name="" type="text" value="${customer.source.key }"/>
				<input name="source.id" type="text" value="${customer.source.id }" style="display:none;"/> -->
			</td>
		</tr>
		<tr>
			<td  align="right" width="15%">证件类型：</td>
			<td align="left">
			<!-- <input name="cardType" type="text" value="${customer.cardType.key }"/>
				<input name="cardType.id" type="hidden" value="${customer.cardType.id }" style="display:none;"/> -->
				<select name="cardType.id" class="select1 pr">
				<option value="-1">--无--</option>
					<c:forEach items="${cardType}" var="cardType">
				       <option value="${cardType.id }"
						<c:if test="${customer.cardType.id==cardType.id }">
							selected
						</c:if>
						>${cardType.key }</option>
				</c:forEach>
					
				</select>
			</td>
			<td  align="right" width="15%">风险等级：</td>
			<td align="left">
				<!--<input name="" type="text" value="${customer.riskGrade.key }"/>
				<input name="riskGrade.id" type="text" value="${customer.riskGrade.id }" style="display:none;"/>-->
				<select name="riskGrade.id" class="select1 pr">
				<option value="-1">--无--</option>
					<c:forEach items="${riskGrade}" var="riskGrade">
				       <option value="${riskGrade.id }"
						<c:if test="${customer.riskGrade.id==riskGrade.id }">
							selected
						</c:if>
						>${riskGrade.key }</option>
				</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td  align="right" width="15%">证件号：</td>
			<td align="left"><input class="text_input3" name="cardNum" type="text" value="${customer.cardNum }"/></td>
			<td  align="right" width="15%"><span class="w_red">*&nbsp;</span>电话：</td>
			<td align="left"><input class="text_input3 required isPhone" name="phone" type="text" value="${customer.phone }"/></td>
		</tr>
		<tr>
			<td  align="right" width="15%"><span class="w_red">*&nbsp;</span>手机：</td>
			<td align="left"><input class="text_input3 required isMobile" name="mobile" type="text" value="${customer.mobile }"/></td>
			<td  align="right" width="15%">邮编：</td>
			<td align="left"><input class="text_input3" name="postCode" type="text" value="${customer.postCode }"/></td>
		</tr>
		<tr>
			<td  align="right" width="15%"><span class="w_red">*&nbsp;</span>传真：</td>
			<td align="left"><input class="text_input3 required isTel" name="fax" type="text" value="${customer.fax }"/></td>
			<td  align="right" width="15%"><span class="w_red">*&nbsp;</span>公司：</td>
			<td align="left"><input class="text_input3 required" name="company" type="text" value="${customer.company }"/></td>
		</tr>
		<tr>
			<td  align="right" width="15%">开户银行：</td>
			<td align="left">
				<select name="openBank.id" class="select1 pr">
				<option value="-1">--无--</option>
					<c:forEach items="${openBank}" var="openBank">
				       <option value="${openBank.id }"
						<c:if test="${customer.openBank.id==openBank.id }">
							selected
						</c:if>
						>${openBank.key }</option>
				</c:forEach>
				</select>
			</td>
			<!-- <td class="bghb pl10 fwb"><input name="" type="text" value="${customer.openBank.key }"/>
				<input name="openBank.id" type="text" value="${customer.openBank.id }" style="display:none;"/>
			</td> -->
			<td  align="right" width="15%">银行户名：</td>
			<td align="left"><input class="text_input3" name="bankName" type="text" value="${customer.bankName }"/></td>
		</tr>
		<tr>
			<td  align="right" width="15%">账号：</td>
			<td align="left"><input class="text_input3" name="bankAccount" type="text" value="${customer.bankAccount }"/></td>
			<td  align="right" width="15%">所有权：</td>
			<td align="left">
			<select name="ownerShip.id" class="select1 pr ">
				<option value="-1">--无--</option>
					<c:forEach items="${ownerShip}" var="ownerShip">
				       <option value="${ownerShip.id }"
						<c:if test="${customer.ownerShip.id==ownerShip.id }">
							selected
						</c:if>
						>${ownerShip.key }</option>
				</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td  align="right" width="15%"><span class="w_red">*&nbsp;</span>行业：</td>
			<td align="left">
				<!--<input name="" type="text" value="${customer.industry.key }"/>
				<input name="industry.id" type="text" value="${customer.industry.id }" style="display:none;"/>-->
				<select name="industry.id" class="select1 pr requiredSelect ">
				<option value="-1">--无--</option>
					<c:forEach items="${industry}" var="industry">
				       <option value="${industry.id }"
						<c:if test="${customer.industry.id==industry.id }">
							selected
						</c:if>
						>${industry.key }</option>
				</c:forEach>
				</select>
			</td>
			<td  align="right" width="15%"></td>
			<td align="left"></td>
		</tr></table>
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
				<td align="left"><input name="address" type="text" value="${customer.address}" class="text_input3"/></td>
			</tr>
		</table>
		
		<h1   class="f14 fbnone ml40 pt10">描述信息</h1>
		<table  class="cb id_table4 w95b bg_c_white margin0 mt10">
		<tr>
			<td  align="right" width="15%" valign="top">备注：</td>
			<td  align="left" width="85%" valign="top">
				<textarea  name="remark" class="remarks_input1" >${customer.remark }</textarea>
			</td>
		</tr>
	</table>
	<div class=" h40"></div>
	</div>
	
	<div class="cb block h40 margin0 mt10" style="width:350px;">
	<ul class="id_table1 cb">
		<li><a id="save" class="block c_white lh25 mr10" href="javascript:;"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b></a></li>
		<li><a id="saveAndAdd" class="block c_white lh25 mr10" href="javascript:;"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保存并新建</b></a></li>
		<li><a class="block c_white lh25 mr10"  href="${ctx}/customer/customer/toQueryPage.do"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b></a></li>
		<div class="clear"></div>
	</ul>
	</div>
</form>
  </body>
</html>
