<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>工作台编辑</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
<link rel="stylesheet" type="text/css" href="styles.css">
-->
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail_a.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript">
var urlMap = urlMap||{};
urlMap['lead']='/customer/lead/query.do';
urlMap['customer']='/customer/customer/query.do';
urlMap['contact']='/customer/contact/query.do';
urlMap['supplier']='/project/supplier/query.do';
urlMap['project']='/project/project/query.do';
urlMap['product']='/project/product/query.do';
urlMap['order']='/order/order/query.do';
urlMap['notice']='/system/notice/query.do';
urlMap['message']='/system/message/query.do';
urlMap['report']='/common/report/reportWorkbanch.comp';
$(function(){
	$("#saveAndAdd").click(function(){
		var $form = $("#form");
		if($form.valid()){
			var params = getParam();
			RcmsAjax.ajax($form.attr("action"),function(result){
				setTimeout(function(){
					window.location.replace("${ctx}/workbanch/toAddPage.do")
				},500);
			},null,$form.formSerialize()+"&params="+params);
		}
		return false;
	});
	$("#save").click(function(){
		var $form = $("#form");
		if($form.valid()){
			var params = getParam();
			RcmsAjax.ajax($form.attr("action"),function(result){
				//redirect
				var id = result.result.result;
				setTimeout(function(){
					window.location.replace("${ctx}/workbanch/toQueryPage.do")
				},500);
			},null,$form.formSerialize()+"&params="+params);
		}
		return false;
	});
	$("#module").change(function(){
		var $this = $(this);
		var module = $this.val();
		$(".param").hide();
		if(module!=""){
			if ( module == "message" || module == "notice" ){
				$("#param").hide();
				$(".createrTimeTd").hide();
			}else{
				$("#param").show();
			}
			$("#url").val(urlMap[module]);
			$("#type").val("list");
			$("#report").hide();
			if(module=="report"){
				$("#type").val("report");
				$("#report").show();
				$("#param").hide();
			}
		}else{
			$("#type").val('');
			$("#url").val('');
			$("#param").hide();
			$('#report').hide();
		}
		$("."+module).show();
	});
});
function loadIframe(){
	getReportList();
}

function getReportList(){
	jsUtil.dialogIframe("${ctx}/common/report/toQueryPage.comp", "报表列表", 900, 570,
		function(){ // 确定回调
			var $reportObj = $(".bor_e28d1f", window.frames["dialogIframe"].document);
			if($reportObj.length > 0){
				var nameAndValue = $reportObj.find("td:eq(0)").text();
				// 名称:用户报表1
				$("#reportName").val(nameAndValue.substring(nameAndValue.indexOf(':')+1));
				$("#reportId").val($reportObj.attr("id"));
			}
	});
}

function clearInputVal(obj){ //清除
	$(obj).prevAll("input").val('');
}

function getParam(){
	var module = $("#module").val();
	var inputs = $("."+module+" input");
	var param = new Array();
	inputs.each(function(){
		var $this = $(this);
		if($this.val()!=""){
			param.push("'"+$this.attr("paramName")+"':'"+$this.val()+"'");
		}	
	});
	var selects = $("."+module+" select");
	selects.each(function(){
		var $this = $(this);
		if($this.val()!=""){
			param.push("'"+$this.attr("paramName")+"':'"+$this.val()+"'");
		}	
	});
	if(module=="report"){
		$("#url").val($("#url").val()+"?id="+$('#reportId').val());
	}
	return encodeURI("{"+param.join(",")+"}");
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
				工作台详情信息
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
					<span class="w_red">*&nbsp;</span>标题：
				</td>
				<td align="left">
				<input type="text" name="title"
						value="" class="text_input3 required" />
				</td>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>宽度：
				</td>
				<td align="left">
					<select class="select1" name="width" class="select1">
						<option value="49">50%</option>
						<option value="99">100%</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">
					<span class="w_red">*&nbsp;</span>模块：
				</td>
				<td align="left">
					<select class="select1" name="module" id="module" class="select1 required">
						<option value="">请选择</option>
						<c:if test="${VS_HAS_FUNCTIONS.leadQuery}"><option value="lead">线索</option></c:if>
						<c:if test="${VS_HAS_FUNCTIONS.customerQuery}"><option value="customer">客户</option></c:if>
						<c:if test="${VS_HAS_FUNCTIONS.contactQuery}"><option value="contact">联系人</option></c:if>
						<c:if test="${VS_HAS_FUNCTIONS.supplierQuery}"><option value="supplier">供应商</option></c:if>
						<c:if test="${VS_HAS_FUNCTIONS.projectQuery}"><option value="project">项目</option></c:if>
						<c:if test="${VS_HAS_FUNCTIONS.productQuery}"><option value="product">产品</option></c:if>
						<c:if test="${VS_HAS_FUNCTIONS.orderQuery}"><option value="order">订单</option></c:if>
						<c:if test="${VS_HAS_FUNCTIONS.noticeQuery}"><option value="notice">系统公告</option></c:if>
						<c:if test="${VS_HAS_FUNCTIONS.messageView}"><option value="message">系统消息</option></c:if>
						<c:if test="${VS_HAS_FUNCTIONS.reportQuery}"><option value="report">统计图表</option></c:if>
					</select>
					<input type="hidden" name="url" id="url"/>
					<input type="hidden" name="type" id="type"/>
				</td>
				<td align="right" id="paramText" class="createrTimeTd">创建时间：</td>
				<td align="left" class="createrTimeTd">
					<select class="select1" class="select1" id="params" name="timeParam">
						<option value="">请选择</option>
						<option value="today">今日</option>
						<option value="week">一周内</option>
						<option value="month">一月内</option>
					</select>
				</td>
			</tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10 " id="param" style="display: none">
			查询条件
		</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10 param lead" style="display: none">
			<tr>
				<td align="right" width="15%">
					线索名称：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_name" value="" class="text_input3" />
				</td>
				<td align="right" width="15%">
					邮箱：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_email"  value="" class="text_input3" />
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					手机：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_mobile" value="" class="text_input3" />
				</td>
				<td align="right" width="15%">
					所有者：
				</td>
				<td align="left">
					<input type="text"  paramName="search_LIKE_owner.realName" value="" class="text_input3" />
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					线索来源：
				</td>
				<td align="left">
					<select class="select1" paramName="search_EQ_source.id">
						<option value="">请选择</option>
						<c:forEach items="${leadSource}" var="v">
							<option value="${v.id}">${v.key}</option>
						</c:forEach>
					</select>
				</td>
				<td align="right" width="15%">
					行业：
				</td>
				<td align="left">
					<select class="select1" paramName="search_EQ_industry.id">
						<option value="">请选择</option>
						<c:forEach items="${industry}" var="v">
							<option value="${v.id}">${v.key}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		
		<table class="cb id_table3 w95b bg_c_white margin0 mt10 param customer" style="display: none">
			<tr>
				<td align="right" width="15%">
					客户名称：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_name"  value="" class="text_input3" />
				</td>
				<td align="right" width="15%">
					邮箱：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_email" value="" class="text_input3" />
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					手机：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_mobile"  value="" class="text_input3" />
				</td>
				<td align="right" width="15%">
					所有者：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_owner.realName" value="" class="text_input3" />
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					客户来源：
				</td>
				<td align="left">
					<select class="select1" paramName="search_EQ_source.id">
						<option vvalue="">请选择</option>
						<c:forEach items="${customerSource}" var="v">
							<option value="${v.id}">${v.key}</option>
						</c:forEach>
					</select>
				</td>
				<td align="right" width="15%">
					行业：
				</td>
				<td align="left">
					<select class="select1" paramName="search_EQ_industry.id">
						<option value="">请选择</option>
						<c:forEach items="${industry}" var="v">
							<option value="${v.id}">${v.key}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		
		<table class="cb id_table3 w95b bg_c_white margin0 mt10 param contact" style="display: none">
			<tr>
				<td align="right" width="15%">
					联系人名称：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_name" value="" class="text_input3" />
				</td>
				<td align="right" width="15%">
					邮箱：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_email" value="" class="text_input3" />
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					电话：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_phone" value="" class="text_input3" />
				</td>
				<td align="right" width="15%">
					手机：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_mobile" value="" class="text_input3" />
				</td>
			</tr>
		</table>
		
		<table class="cb id_table3 w95b bg_c_white margin0 mt10 param supplier" style="display: none">
			<tr>
				<td align="right" width="15%">
					供应商名称：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_name" value="" class="text_input3" />
				</td>
				<td align="right" width="15%">
					电话：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_phone"  value="" class="text_input3" />
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					手机：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_mobile" value="" class="text_input3" />
				</td>
				<td align="right" width="15%">
					所有者：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_owner.realName" value="" class="text_input3" />
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					 供应商类型：
				</td>
				<td align="left">
					<select class="select1" paramName="search_EQ_type.id">
						<option value="">请选择</option>
						<c:forEach items="${supplierType}" var="v">
							<option value="${v.id}">${v.key}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		
		<table class="cb id_table3 w95b bg_c_white margin0 mt10 param project" style="display: none">
			<tr>
				<td align="right" width="15%">
					项目名：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_name" value="" class="text_input3" />
				</td>
				<td align="right" width="15%">
					供应商名称：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_supplier.name" value="" class="text_input3" />
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					项目编号：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_code" value="" class="text_input3" />
				</td>
				<td align="right" width="15%">
					 支付方式：
				</td>
				<td align="left">
					<select class="select1" paramName="search_EQ_payType.id">
						<option value="">请选择</option>
						<c:forEach items="${payType}" var="v">
							<option value="${v.id}">${v.key}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		
		<table class="cb id_table3 w95b bg_c_white margin0 mt10 param product" style="display: none">
			<tr>
				<td align="right" width="15%">
					产品名称：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_name" value="" class="text_input3" />
				</td>
				<td align="right" width="15%">
					产品编号：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_code"  value="" class="text_input3" />
				</td>
			</tr>
		</table>
		
		<table class="cb id_table3 w95b bg_c_white margin0 mt10 param order" style="display: none">
			<tr>
				<td align="right" width="15%">
					订单编号：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_code" value="" class="text_input3" />
				</td>
				<td align="right" width="15%">
					产品名：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_prodict.name"  value="" class="text_input3" />
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					客户名：
				</td>
				<td align="left">
					<input type="text" paramName="search_LIKE_customer.name" value="" class="text_input3" />
				</td>
			</tr>
		</table>
		
		<div id="report" style="display: none;">
			<h1 class="f14 fbnone ml40 pt10">
				统计图表列表
			</h1>
			<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>选择统计图表：
				</td>
				<td align="left">
					<input type="text" paramName="reportName" id="reportName" value="" class="text_input3" onclick="getReportList();"/>
					<input type="hidden" paramName="reportId" id="reportId" value="" class="text_input3" />
					<i class="s_inquiry globle_img block_inline ml5 vm cp" title="选择统计图表" onclick="getReportList();"></i>
					<i class="dump_btn globle_img block_inline ml5 vm cp empty" title="清除" onclick="clearInputVal(this)"></i>
				</td>
				<td align="right" width="15%">
				</td>
				<td align="left">
				</td>
			</tr>
		</table>
		</div>
		
		
		<h1 class="f14 fbnone ml40 pt10">
			描述信息
		</h1>
		<table class="cb id_table4 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" valign="top" width="15%">
					备注：
				</td>
				<td align="left" width="85%">
					<textarea name="remark" class="remarks_input1 {maxlength:512}">${salesTarget.remark}</textarea>
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
				<a href="${ctx}/sales/salesTarget/toQueryPage.do"
					class="block c_white lh25"><b class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">取&nbsp&nbsp消</b> </a>
			</li>
		</ul>
	</div>
</div>
</form>
</body>
</html>

