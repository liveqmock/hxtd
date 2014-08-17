<%--
  功能描述：产品情
  User: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>赎回</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="${ctx}/static/css/public/common.css?v=${now}" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css?v=${now}" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/> 
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var money = $("#purchaseMoney").text()*10000;
	var redeemFormula = $("#redeemFormula").text();
	var earningRate=$("#earningRate").text();
	if(redeemFormula.indexOf("x")<0){
		$("#payMoney").val("赎回公式不包含本金“x”，请检查");
	}else{
		try{
			if($("#type").val()=='normal'){
				money = money*earningRate/100+money;//到期赎回
			}else{
				money = eval(redeemFormula.replace("x",money));//提前赎回
			}
		}catch (e){
			money = "赎回公式错误";
		}
		$("#payMoney").val(money/10000);
	}
	
	$("#payMoney").blur(function(){
		var $payMoney=$("#payMoney").val();
		if(isNaN($payMoney)){
			$("#error").html("输入正确的金额");
		}else{
			$("#error").html("");
		}
	});
});

</script>
</head>
<body>
<div>
	<div class="cb"></div>
	<div class="ml35 mr35 bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">赎回信息</h1>
		<input type="hidden" id="type" value="${type}" />
		<table class="cb id_table3 w95b bg_c_white margin0 mt10 redeem">
			<tr>
				<td width="25%" align="right">购买金额（万）：</td>
				<td align="left" id="purchaseMoney">${order.purchaseMoney}</td>
				<td align="right">收益率（%）：</td>
				<td align="left" id="earningRate">${order.earningRate}</td>
			</tr>
			<tr>
				<td width="25%" align="right">提前赎回率（%）：</td>
				<td align="left">${order.arr}</td>
				<td align="right">赎回公式：</td>
				<td align="left" id="redeemFormula">${order.redeemFormula}</td>
			</tr>
			<tr>
				<td align="right"><span class="w_red">*&nbsp;</span>应付金额（万）：</td>
				<td align="left"> <input type="text" id="payMoney"/></td>
				<td align="right"><span style=" color: red" id="error"></span></td>
				<td align="left"></td>
			</tr>
			</table>
		<div class="h40"></div>
	</div>
	<div class="cb block h40 margin0 mt10" style="width: 350px;">
		<ul class="id_table1 cb">
		</ul>
	</div>
</div>
</body>
</html>
