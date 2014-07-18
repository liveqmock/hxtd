<%--
  功能描述：编辑销售目标
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
<title>销售目标编辑</title>
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
					window.location.replace("${ctx}/sales/salesTarget/toAddPage.do")
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
					window.location.replace("${ctx}/sales/salesTarget/toViewPage.do?id="+id)
				},500);
			},null,$form.formSerialize());
		}
		return false;
	});
	var zNode = ${orgTree};
	jsUtil.easyTree.init(zNode,childFun);
	$("#menuText").click(function(){
		jsUtil.easyTree.show("#menuText");
	});
});
function childFun(treeNode){
	$("#org").val(treeNode.name);
	$("#orgId").val(treeNode.id);
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
				销售目标详情信息
			</h1>
			<ul class="fr id_table1 mt10 ml10">
			</ul>
		</div>
	</div>
	<input type="hidden" name="id" value="${salesTarget.id}" />
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
						value="${salesTarget.title}" class="text_input3 required" />
				</td>
				<td align="right"  width="15%">
					<span class="w_red">*&nbsp;</span>组织机构：
				</td>
				<td align="left">
					<input type="text" id="org" class="text_input3 required" 
					onclick="jsUtil.easyTree.show('#org')" readonly
					value="${salesTarget.org.name}"/>					
					<input type="hidden" id="orgId" name="org.id"
					value="${salesTarget.org.id}"/>
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>目标成交额（万）：
				</td>
				<td align="left">
				<input type="text" name="bargainMoney"
						value="${salesTarget.bargainMoney}" class="text_input3 required" />
				</td>
				<td align="right">
					<span class="w_red">*&nbsp;</span>时间周期：
				</td>
				<td align="left">
					<select name="unitDic.id"
						class="select1 pr requiredSelect">
						<option value="-1">
							请选择${salesTarget.unitDic.id}
						</option>
						<c:forEach items="${unit}" var="s">
							<option value="${s.id}"
								<c:if test="${s.id==salesTarget.unitDic.id}">
									selected
								</c:if>
								>${s.key}
							</option>
						</c:forEach>
					</select>
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

