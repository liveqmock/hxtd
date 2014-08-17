<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>线索编辑页</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail_a.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
<script type="text/javascript">${applicationScope.VC_PCAS}</script>
<script type="text/javascript">
var sourceMarketActivity = ${isMarketActivity};
$(function(){
	$("#saveAndAdd").click(function(){
		var $form = $("#form");
		if($("#source").val()!=sourceMarketActivity){
			$("#txt_marketActivity").removeClass("required");
		}
		if($form.valid()){
			RcmsAjax.ajax($form.attr("action"),function(result){
				setTimeout(function(){
					window.location.replace("${ctx}/customer/lead/toAddPage.do")
				},500);
			},null,$form.formSerialize());
		}
		return false;
	});
	$("#save").click(function(){
		var $form = $("#form");
		if($("#source").val()!=sourceMarketActivity){
			$("#txt_marketActivity").removeClass("required");
		}
		if($form.valid()){
			RcmsAjax.ajax($form.attr("action"),function(result){
				//redirect
				var id = result.result.result;
				setTimeout(function(){
					window.location.replace("${ctx}/customer/lead/toViewPage.do?id="+id)
				},500);
			},null,$form.formSerialize());
		}
		return false;
	});
	//获得省市县代码，加载三级联动
	var province = '${lead.province.id}';
	var city = '${lead.city.id}';
	var county = '${lead.county.id}';
	//修改为根据ID选择组件，之前用name选择组件当name中出现“.”时有问题
	new PCAS("province","city","county",province,city,county);
	
	showMarketActivity(${lead.source.id});
	
	$("#source").change(function(){
		showMarketActivity($(this).val())
	});
});
function showMarketActivity(value){
	if(value==sourceMarketActivity){
		$(".marketActivity").show();
	}else{
		$(".marketActivity").hide();
	}
}
function searchData(action){ //搜索弹出框
	var url, title;
	switch(action){
		case "owner":
			url = "${ctx}/system/user/toSearchUserPage.docomp";
			title = "所有者";
			break;
		case "marketActivity":
			url = "${ctx}/market/marketactivity/toSearchMarketActivityPage.docomp";
			title = "市场活动";
			break;
	}
	jsUtil.dialogIframe(url, title, 800, 465, 
		function(){ // 确定回调
			var $userObj = $('.bor_e28d1f', window.frames["dialogIframe"].document);
			if($userObj.length > 0){
				$("#txt_" + action).val($userObj.find("td:eq(0)").text());
				$("#hide_" + action +"_id").val($userObj.attr("id"));
			}
		}
	);
}
function clearInputVal(obj){ //清除
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
		<div class="ie_head">
			<h1 class="f14 fbnone mt10 ml10 fl">
				线索详情信息
			</h1>
			<ul class="fr id_table1 mt10 ml10">
			</ul>
		</div>
	</div>
	<input type="hidden" name="id" value="${lead.id}" />
	<div class="ml35 mr35 bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">
			基本信息
		</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>线索名：
				</td>
				<td align="left">
					<input type="text" name="name" value="${lead.name }"
						class="text_input3 required" />
				</td>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>所有者：
				</td>
				<td align="left">
					<input type="text" id="txt_owner" value="${lead.owner.realName}" onclick="searchData('owner');" 
						class="text_input3 cp required" readonly/>
					<input type="hidden" id="hide_owner_id" name="owner.id" value="${lead.owner.id}"/>
					<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索所有者" onclick="searchData('owner');"></i>
					<i class="dump_btn globle_img block_inline ml5 vm cp empty" title="清除" onclick="clearInputVal(this)"></i>
				</td>
			</tr>
			<tr>
				<td align="right">电话：</td>
				<td align="left"><input type="text" name="phone" value="${lead.phone}" class="text_input3 isPhone"/></td>
				<td align="right">传真：</td>
				<td align="left"><input type="text" name="fax" value="${lead.fax}" class="text_input3 isTel"/></td>
			</tr>
			<tr>
				<td align="right">手机：</td>
				<td align="left"><input type="text" name="mobile" value="${lead.mobile}" class="text_input3 isMobile"/></td>
				<td align="right">邮箱：</td>
				<td align="left"><input type="text" name="email" value="${lead.email}" class="text_input3 email"/></td>
			</tr>
			<tr>
				<td align="right">公司名：</td>
				<td align="left"><input type="text" name="company" value="${lead.company}" class="text_input3"/></td>
				<td align="right"><span class="w_red">*&nbsp;</span>卡类型：</td>
				<td align="left">
					<select name="cardType.id" class="select1 pr requiredSelect">
						<option value="-1">--无--</option>
						<c:forEach items="${cardType}" var="s">
							<option value="${s.id}" <c:if test="${s.id==lead.cardType.id}">selected</c:if>>
								${s.key}
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right"><span class="w_red">*&nbsp;</span>行业：</td>
				<td align="left">
					<select name="industry.id" class="select1 pr requiredSelect">
						<option value="-1">--无--</option>
						<c:forEach items="${industry}" var="s">
							<option value="${s.id}" <c:if test="${s.id==lead.industry.id}">selected</c:if>>
								${s.key}
							</option>
						</c:forEach>
					</select>
				</td>
				<td align="right">卡号码：</td>
				<td align="left"><input type="text" name="cardNum" value="${lead.cardNum}" class="text_input3 {maxlength:22}"/></td>
			</tr>
			<tr>
				<td align="right">部门：</td>
				<td align="left"><input type="text" name="department" value="${lead.department}" class="text_input3"/></td>
				<td align="right"><span class="w_red">*&nbsp;</span>线索状态：</td>
				<td align="left">
					<select name="status.id" class="select1 pr requiredSelect">
						<option value="-1">--无--</option>
						<c:forEach items="${status}" var="s">
							<option value="${s.id}" <c:if test="${s.id==lead.status.id}">selected</c:if>>
								${s.key}
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">职位：</td>
				<td align="left"><input type="text" name="position" value="${lead.position}" class="text_input3"/></td>
				<td align="right"><span class="w_red">*&nbsp;</span>线索来源：</td>
				<td align="left">
					<select name="source.id" id="source" class="select1 pr required">
						<option value="">--无--</option>
						<c:forEach items="${source}" var="s">
							<option value="${s.id}" <c:if test="${s.id==lead.source.id}">selected</c:if>>
								${s.key}
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">邮编：</td>
				<td align="left"><input type="text" name="postCode" value="${lead.postCode}" class="text_input3 isZipCode"/></td>
				<td align="right" class="marketActivity"><span class="w_red">*&nbsp;</span>市场活动</td>
				<td align="left" class="marketActivity">
					<input type="text" name="txt_m" id="txt_marketActivity" value="${lead.marketActivity.name}" class="text_input3 cp required" 
						onclick="searchData('marketActivity');" readonly/>
					<input type="hidden" id="hide_marketActivity_id" name="marketActivity.id" value="${lead.marketActivity.id }"/>
					<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索市场活动" onclick="searchData('marketActivity');"></i>
					<i class="dump_btn globle_img block_inline ml5 vm cp empty" title="清除" onclick="clearInputVal(this)"></i>
				</td>
			</tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10">
			地址信息
		</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td width="15%" align="right">
					省份：
				</td>
				<td align="left">
					<select id="province" name="province.id" class="select1"></select>
				</td>
				<td width="15%" align="right">
					城市：
				</td>
				<td align="left">
					<select id="city" name="city.id" class="select1"></select>
				</td>
			</tr>
			<tr>
				<td align="right">
					区县：
				</td>
				<td align="left">
					<select id="county" name="county.id" class="select1"></select>
				</td>
				<td align="right">
					详细地址：
				</td>
				<td align="left">
					<input name="address" type="text" value="${lead.address}"
						class="text_input3" />
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
				<td align="left" width="85%" valign="top">
					<textarea name="remark" class="remarks_input1">${lead.remark}</textarea>
				</td>
			</tr>

		</table>
		<div class=" h40"></div>
	</div>
	<div class="cb block h40 margin0 mt10" style="width: 350px;">
		<ul class="id_table1 cb">
			<li>
				<a href="javascript:;" id="save" class="block c_white lh25 mr10"><b
					class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">保&nbsp&nbsp存</b> </a></a>
			</li>
			<li>
				<a href="javascript:;" id="saveAndAdd"
					class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">保存并新建</b> </a>
			</li>
			<li>
				<a href="${ctx}/customer/lead/toQueryPage.do"
					class="block c_white lh25"><b class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">取&nbsp&nbsp消</b> </a>
			</li>
		</ul>
	</div>
</div>
</form>
</body>
</html>