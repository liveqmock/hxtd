<%--
  功能描述：编辑合同
  User: huizijing
  Date:2014/7/15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>合同编辑</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
	<link rel="stylesheet" href="${ctx}/static/css/recommend/detail_a.css" type="text/css"/>
	<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/htmlbox/htmlbox.colors.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/htmlbox/htmlbox.styles.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/htmlbox/htmlbox.syntax.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/htmlbox/xhtml.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/htmlbox/htmlbox.full.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#saveAndAdd").click(function(){
				var $form = $("#form");
				if($form.valid()){
					RcmsAjax.ajax($form.attr("action"),function(result){
						setTimeout(function(){
							window.location.replace("${ctx}/order/contract/toAddPage.do")
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
							window.location.replace("${ctx}/order/contract/toViewPage.do?id="+id)
						},500);
					},null,$form.formSerialize());
				}
				return false;
			});
			jsUtil.datepickerNotNow(".time");
		});
		function searchData(action){//搜索弹出框
			var url, title;
			if(action == "order"){
				url = "${ctx}/order/order/toQueryPage.comp?type=relation";
				title = "订单";
			}
			jsUtil.dialogIframe(url, title, 800, 465, function(){//确定回调
				var $userObj = $(".bor_e28d1f", window.frames["dialogIframe"].document);
					if($userObj.length > 0){
						$("#txt_" + action).val($userObj.find("td:eq(0)").text());
						$("#hide_" + action +"_id").val($userObj.attr("id"));
						$("#txt_customerName").val($userObj.find("td:eq(1)").text());//客户名称默认是订单的客户名称
						$("#txt_customerId").val($userObj.find("td:eq(2)").text());
						$("#txt_purchaseMoney").val($userObj.find("td:eq(3)").text());
						
					}
				$("#txt_contract").val($("#txt_order").val());//合同编号默认为订单编号
			});
		}
		function clearInputVal(){//清除
			$("#txt_order").val('');
			$("#txt_customerName").val('');
		    $("#txt_customerId").val('');
		    $("#txt_purchaseMoney").val('');
		    $("#txt_contract").val('');
		}
	</script>
</head>
<body>
<form id="form" action="${ctx }${funcUrl}" method="post">
	<input type="hidden" name="id" value="${contract.id}"/>
	<div class="cb"></div>
	<!--列表开始-->
	<div class="ml35 mr35 mt20 block cb cb">
		<b class="b1"></b>
		<b class="b2"></b>
		<b class="b3"></b>
		<b class="b4"></b>
		<div class="ie_head">
			<h1 class="f14 fbnone mt10 ml10 fl">
				合同详情信息
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
					<span class="w_red">*&nbsp;</span>订单编号：
				</td>
				<td align="left">
				<input type="text" id="txt_order"
					value="${contract.order.code }" 
					class="text_input3 cp required" readonly
					 onclick="searchData('order');"/>
				<input type="hidden" value="${contract.order.id}"
					id="hide_order_id" name="order.id" />
				<i class="s_inquiry globle_img block_inline ml5 vm cp"
					title="搜索订单" onclick="searchData('order');"></i>
				<i class="dump_btn globle_img block_inline ml5 vm cp empty" onclick="clearInputVal()"
					title="清除"></i>
				</td>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>合同编号：
				</td>
				<td align="left">
				<input type="text" name="code" id="txt_contract"
						value="${contract.code}" class="{required:true,maxlength:30,unique:['Contract','${contract.code}']} text_input3" />
				</td>
			</tr>
			<tr>
				<!-- <td align="right" width="15%">
					合同类型：
				</td>
				<td align="left">
					<select name="type.id" class="select1 pr">
						<option value="">
							--无--
						</option>
						<c:forEach items="${type}" var="type">
							<option value="${type.id}"
								<c:if test="${type.id==contract.type.id}">selected</c:if>>
								${type.key}
							</option>
						</c:forEach>
					</select>
				</td> -->
				<td align="right">
					<span class="w_red">*&nbsp;</span>客户：
				</td>
				<td align="left">
					<input type="text" id="txt_customerName"
						value="${contract.customer.name }" 
						class="text_input3 cp required" readonly/>
					<input type="hidden" id="txt_customerId" name="customer.id"
					value="${contract.customer.id }" 
					class="text_input3 cp required" readonly/>
				
				</td>
				<td align="right">
					<span class="w_red">*&nbsp;</span>合同金额（万）：
				</td>
				<td align="left">
					<input id="txt_purchaseMoney" type="text" name="purchaseMoney" value="${contract.purchaseMoney}" class="text_input3 number required" />
				</td>
			</tr>
			<tr>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>合同名称：
				</td>
				<td align="left">
				<input type="text" name="name" maxlength="30" 
						value="${contract.name}" class="text_input3 required" />
				</td>
				<td align="right">
					<span class="w_red">*&nbsp;</span>赎回方式：
				</td>
				<td align="left">
					<select name="redeemType.id"
						class="select1 pr requiredSelect">
						<option value="-1">
							--无--
						</option>
						<c:forEach items="${redeemType}" var="redeemType">
							<option value="${redeemType.id}"
								<c:if test="${redeemType.id==contract.redeemType.id}">selected</c:if>>
								${redeemType.key}
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">
					<span class="w_red">*&nbsp;</span>签订时间：
				</td>
				<td align="left">
					<fmt:formatDate value="${contract.signTime}" pattern="yyyy-MM-dd" var="signTime" />
					<a href="javascript:;" class="pa time_closenone1"></a>
					<input type="text" name="signTime" value="${signTime }" class="text_input3 input_close1 time required" readonly />
				</td>
				<td align="right">
					<span class="w_red">*&nbsp;</span>生效时间：
				</td>
				<td align="left">
					<fmt:formatDate value="${contract.effectTime}" pattern="yyyy-MM-dd" var="effectTime" />
					<a href="javascript:;" class="pa time_closenone1"></a>
					<input type="text" name="effectTime" value="${effectTime}" class="text_input3 input_close1 time required" readonly />
				</td>
			</tr>
			<tr>
				<td align="right">
					<span class="w_red">*&nbsp;</span>失效时间：
				</td>
				<td align="left">
				    <fmt:formatDate value="${contract.bereftTime}" pattern="yyyy-MM-dd" var="bereftTime" />
					<a href="javascript:;" class="pa time_closenone1"></a>
					<input type="text" name="bereftTime" value="${bereftTime}" class="text_input3 input_close1 time required" readonly />
				</td>
			</tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10">
			合同内容
		</h1>
		<div class="cb  w95b bg_c_white margin0 mt10">
					<div class="margin0 w70b pt10">
						<textarea id="ha" name="content" maxlength=10000 class="remarks_input1">${contract.content}</textarea>
						<script  type="text/javascript">
							$("#ha").css("width","100%").htmlbox({
							    toolbars:[
								    [
									"separator","cut","copy","paste",
									"separator","undo","redo",
									"separator","bold","italic","underline","strike","sup","sub",
									"separator","justify","left","center","right",
									"separator","ol","ul","indent","outdent",
									"separator","link","unlink","image"
									
									],
									[
									"separator","code",
							        "separator","formats","fontsize","fontfamily",
									"separator","fontcolor","highlight",
									],
									[
									"separator","removeformat","striptags","hr","paragraph",
									"separator","quote","syntax"
									]
								],
								skin:"blue"
							});
						</script>
					</div>
					<div style="width:100px; height:10px;"></div>
		</div> 
		<h1 class="f14 fbnone ml40 pt10">
			描述信息
		</h1>
		<table class="cb id_table4 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%" valign="top">
					备注：
				</td>
				<td align="left" width="85%">
					<textarea name="remark" class="remarks_input1">${contract.remark}</textarea>
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
					class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b> </a></a>
			</li>
			<li>
				<a href="javascript:;" id="saveAndAdd"
					class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">保存并新建</b> </a>
			</li>
			<li>
				<a href="${ctx}/order/contract/toQueryPage.do"
					class="block c_white lh25"><b class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b> </a>
			</li>
		</ul>
	</div>
</form>
</body>
</html>

