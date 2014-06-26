<%--
  功能描述：编辑供应商
  User: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>供应商详情</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
<link rel="stylesheet" type="text/css" href="styles.css">
-->
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail_a.css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css"/>
<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript">${applicationScope.VC_PCAS}</script>
<script type="text/javascript">
$(function(){
	$("#saveAndAdd").click(function(){
		var $form = $("#form");
		if($form.valid()){
			RcmsAjax.ajax($form.attr("action"),function(result){
				setTimeout(function(){
					window.location.replace("${ctx}/project/supplier/toAddPage.do")
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
					window.location.replace("${ctx}/project/supplier/toViewPage.do?id="+id)
				},500);
			},null,$form.formSerialize());
		}
		return false;
	});
	
	//jsUtil.renderRequiredFromInput();
	//获得省市县代码，加载三级联动
	var province = '${com.province.id}';
	var city = '${com.city.id}';
	var county = '${com.county.id}';
	//修改为根据ID选择组件，之前用name选择组件当name中出现“.”时有问题
	new PCAS("province","city","county",province,city,county);
	
});
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
			$("#hide_" + action ).val(ckObj.val());
		}
	});
}
</script>
</head>
<body>
<form id="form" action="${ctx }${funcUrl}" method="post">
<div>
	<div class="cb"></div>
	<!--列表开始-->
	<div class="ml35 mr35 mt20 block cb cb">
		<b class="b1"></b>
		<b class="b2"></b>
		<b class="b3"></b>
		<b class="b4"></b>
		<div class="ie_head">
			<h1 class="f14 fbnone mt10 ml10 fl">
				供应商详情信息
			</h1>
			<ul class="fr id_table1 mt10 ml10">
			</ul>
		</div>
	</div>
	<div class="ml35 mr35 bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">
			基本信息
		</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>供应商名：
				</td>
				<td align="left">
					<input type="text" name="name" value="${com.name}"
						class="text_input3 required">
				</td>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>所有者：
				</td>
				<td align="left">
					<input type="text" id="txt_owner" value="${com.owner.realName}"
						class="text_input3 required" onclick="searchData('owner')" readonly>
					<input type="hidden" id="hide_owner" name="owner.id" value="${com.owner.id}"/>
				</td>
			</tr>

			<tr>	
				
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>供应商类型：
				</td>
				<td align="left">
					<select name="type.id" class="select1 pr requiredSelect">
						<option value="-1">
							--请选择--
						</option>
						<c:forEach items="${dict}" var="d">
							<option value="${d.id}"
								<c:if test="${d.id==com.type.id}">
             				selected
             			</c:if>>
								${d.key}
							</option>
						</c:forEach>
					</select>
				</td>
			
				<td align="right">
					电话：
				</td>
				<td align="left">
					<input type="text" name="phone" value="${com.phone}"
						class="text_input3 isPhone">
				</td>
			</tr>
			<tr>
				<td align="right">
					手机：
				</td>
				<td align="left">
					<input type="text" name="mobile" value="${com.mobile}"
						class="text_input3 isMobile">
				</td>
			

			
				<td align="right">
					传真：
				</td>
				<td align="left">
					<input type="text" name="fax" value="${com.fax}"
						class="text_input3 isTel">
				</td>
			</tr>
			<tr>
				<td align="right">
					供应商邮箱：
				</td>
				<td align="left">
					<input type="text" name="email" value="${com.email}"
						class="text_input3 email">
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
					<input name="address" type="text" value="${com.address}"
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
				<td align="left" width="85%">
					<textarea name="remark" class="remarks_input1">${com.remark}</textarea>
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
					class="allbtn_r pr13 block fl w_auto f14">保&nbsp&nbsp存</b>
				</a></a>
			</li>
			<li>
				<a href="javascript:;" id="saveAndAdd"
					class="block c_white lh25 mr35"><b class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">保存并新建</b>
				</a>
			</li>
			<li>
				<a href="${ctx}/project/supplier/toQueryPage.do"
					class="block c_white lh25"><b class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">取&nbsp&nbsp消</b>
				</a>
			</li>
		</ul>
	</div>
</div>
</form>
</body>
</html>
