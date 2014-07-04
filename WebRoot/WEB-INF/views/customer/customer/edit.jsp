<%--
  功能描述：编辑客户
  User: huizijing
  Date:2014/5/24
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>客户编辑页</title>
	<link href="${ctx}/static/css/stressing/detail.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
	<script type="text/javascript">${applicationScope.VC_PCAS}</script>
	<script type="text/javascript">
		$(function(){
			new PCAS("province", "city", "county", '${customer.province.id}', 
				'${customer.city.id}', '${customer.county.id}'); // 修改为根据ID选择组件，之前用name选择组件当name中出现“.”时有问题
			
			//保存按钮事件
			$("#save").click(function(){
				var $form = $("#form");
				if($("#form").valid()){
					RcmsAjax.ajax($form.attr("action"), function(result){
						var id = result.result.result;
						setTimeout(function(){
							window.location.replace("${ctx}/customer/customer/toViewPage.do?id=" + id);
						},500);
					}, null, $form.formSerialize());
				}
				return false;
			});
			$("#saveAndAdd").click(function(){
				var $form = $("#form");
				if($form.valid()){
					RcmsAjax.ajax($form.attr("action"), function(result){
						setTimeout(function(){
							window.location.replace("${ctx}/customer/customer/toAddPage.do");
						},500);
					}, null, $form.formSerialize());
				}
				return false;
			});
		}); 
		
		function searchData(action){ // 搜索
			jsUtil.dialogIframe("${ctx}/system/user/toQueryPage.comp", "负责人", 800, 420, 
				function(){ // 确定回调
					var $userObj = $(".bor_e28d1f", window.frames["dialogIframe"].document);
					if($userObj.length > 0){
						$("#txt_" + action).val($userObj.find("td:eq(0)").text());
						$("#hide_" + action +"_id").val($userObj.attr("id"));
					}
			});
		
		$(".empty").click(function(){ // 清除
				$(this).prevAll("input").val('');
			});
		}
	</script> 
</head>
<body>
<form id="form" action="${ctx}${funcUrl}" method="post">
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
	<table class="cb id_table3 w95b bg_c_white margin0 mt10">
		<tr>
			<td  align="right" width="15%"><span class="w_red">*&nbsp;</span>客户所有者：</td>
			<td align="left">
				<input id="txt_owner" type="text" value="${customer.owner.realName}" readonly="readonly" class="text_input3 required"/>
				<input id="hide_owner_id" type="hidden" name="owner.id" value="${customer.owner.id}"/>
				<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索所有者" onclick="searchData('owner');"></i>
				<i class="dump_btn globle_img block_inline ml5 vm cp empty" title="清除"></i>
			</td>
			<td align="right" width="15%">客户类型：</td>
			<td align="left">
				<select name="type.id" class="select1 pr ">
					<option value="040301">--无--</option>
						<c:forEach items="${cType}" var="type">
							<option value="${type.id}"
							<c:if test="${customer.type.id == type.id}">
								selected
							</c:if>
							>${type.key }</option>
						</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right" width="15%"><span class="w_red">*&nbsp;</span>客户名称：</td>
			<td align="left"><input class="text_input3 required" name="name" type="text" value="${customer.name}"/></td>
			<td align="right" width="15%"><span class="w_red">*&nbsp;</span>客户来源：</td>
			<td align="left">
				<select name="source.id" class="select1 pr requiredSelect">
					<option value="-1">--无--</option>
					<c:forEach items="${source}" var="source">
					<option value="${source.id}"
							<c:if test="${customer.source.id == source.id}">
								selected
							</c:if>
							>${source.key}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td  align="right" width="15%">证件类型：</td>
			<td align="left">
				<select name="cardType.id" class="select1 pr">
					<option value="040303">--无--</option>
						<c:forEach items="${cardType}" var="cardType">
					       <option value="${cardType.id}"
							<c:if test="${customer.cardType.id == cardType.id}">
								selected
							</c:if>
							>${cardType.key}</option>
					   </c:forEach>
				</select>
			</td>
			<td align="right" width="15%">风险等级：</td>
			<td align="left">
				<select name="riskGrade.id" class="select1 pr">
					<option value="040304">--无--</option>
						<c:forEach items="${riskGrade}" var="riskGrade">
					       <option value="${riskGrade.id}"
							<c:if test="${customer.riskGrade.id == riskGrade.id}">
								selected
							</c:if>
							>${riskGrade.key}</option>
						</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right" width="15%">证件号：</td>
			<td align="left"><input class="text_input3" name="cardNum" type="text" value="${customer.cardNum}"/></td>
			<td align="right" width="15%"><span class="w_red">*&nbsp;</span>电话：</td>
			<td align="left"><input class="text_input3 required isPhone" name="phone" type="text" value="${customer.phone}"/></td>
		</tr>
		<tr>
			<td align="right" width="15%"><span class="w_red">*&nbsp;</span>手机：</td>
			<td align="left"><input class="text_input3 required isMobile" name="mobile" type="text" value="${customer.mobile}"/></td>
			<td align="right" width="15%">邮编：</td>
			<td align="left"><input class="text_input3" name="postCode" type="text" value="${customer.postCode}"/></td>
		</tr>
		<tr>
			<td align="right" width="15%"><span class="w_red">*&nbsp;</span>传真：</td>
			<td align="left"><input class="text_input3 required isTel" name="fax" type="text" value="${customer.fax}"/></td>
			<td align="right" width="15%"><span class="w_red">*&nbsp;</span>公司：</td>
			<td align="left"><input class="text_input3 required" name="company" type="text" value="${customer.company}"/></td>
		</tr>
		<tr>
			<td  align="right" width="15%">开户银行：</td>
			<td align="left">
				<select name="openBank.id" class="select1 pr">
					<option value="040307">--无--</option>
						<c:forEach items="${openBank}" var="openBank">
					       <option value="${openBank.id }"
							<c:if test="${customer.openBank.id == openBank.id}">
								selected
							</c:if>
							>${openBank.key }</option>
						</c:forEach>
				</select>
			</td>
			<td align="right" width="15%">银行户名：</td>
			<td align="left"><input class="text_input3" name="bankName" type="text" value="${customer.bankName}"/></td>
		</tr>
		<tr>
			<td align="right" width="15%">账号：</td>
			<td align="left"><input class="text_input3" name="bankAccount" type="text" value="${customer.bankAccount}"/></td>
			<td align="right" width="15%">所有权：</td>
			<td align="left">
			<select name="ownerShip.id" class="select1 pr ">
				<option value="040306">--无--</option>
					<c:forEach items="${ownerShip}" var="ownerShip">
				       <option value="${ownerShip.id}"
						<c:if test="${customer.ownerShip.id == ownerShip.id}">
							selected
						</c:if>
						>${ownerShip.key}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right" width="15%"><span class="w_red">*&nbsp;</span>行业：</td>
			<td align="left">
				<select name="industry.id" class="select1 pr requiredSelect ">
					<option value="-1">--无--</option>
						<c:forEach items="${industry}" var="industry">
					       <option value="${industry.id}"
							<c:if test="${customer.industry.id == industry.id}">
								selected
							</c:if>
							>${industry.key}</option>
						</c:forEach>
				</select>
			</td>
			<td align="right" width="15%"><span class="w_red">*&nbsp;</span>邮箱：</td>
			<td align="left">
			<input name="email" type="text" value="${customer.email}" class="text_input3 required"/>
			</td>
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
			<td align="left"><input name="address" type="text" value="${customer.address}" class="text_input3"/></td>
		</tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
		<table class="cb id_table4 w95b bg_c_white margin0 mt10">
		<tr>
			<td align="right" width="15%" valign="top">备注：</td>
			<td align="left" width="85%" valign="top"><textarea name="remark" class="remarks_input1" style="resize: none;">${customer.remark}</textarea></td>
		</tr>
	</table>
	<div class=" h40"></div>
	</div>
	<div class="cb block h40 margin0 mt10" style="width:350px;">
		<ul class="id_table1 cb">
			<li><a id="save" class="block c_white lh25 mr10" href="javascript:;"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b></a></li>
			<li><a id="saveAndAdd" class="block c_white lh25 mr10" href="javascript:;"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保存并新建</b></a></li>
			<li><a class="block c_white lh25 mr10"  href="${ctx}/customer/customer/toQueryPage.do"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b></a></li>
		</ul>
	</div>
</form>
</body>
</html>
