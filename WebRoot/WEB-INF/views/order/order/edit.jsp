<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>订单编辑</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript">
$(function () {
	jsUtil.datepickerNotNow(".time"); //时间日历
    $("#saveAndAdd").click(function () {
        var $form = $("#form");
        if ($form.valid()) {
            RcmsAjax.ajax($form.attr("action"), function (result) {
                setTimeout(function () {
                    window.location.replace("${ctx}/order/order/toAddPage.do")
                }, 500);
            }, null, $form.formSerialize());
        }
        return false;
    });
    $("#save").click(function () {
        var $form = $("#form");
        if ($form.valid()) {
            RcmsAjax.ajax($form.attr("action"), function (result) {
                setTimeout(function () {
                    window.location.replace("${ctx}/order/order/toViewPage.do?id=" + result.result.result)
                }, 500);
            }, null, $form.formSerialize());
        }
        return false;
    });
});
function searchData(action) { //搜索组件弹出框
    var url, title, height = 420;
    if (action == "owner") {
    	title = "所有者";
        url = "${ctx}/system/user/toSearchUserPage.docomp";
    } else if (action == "salesManager") {
        title = "投资经理";
        url = "${ctx}/system/user/toSearchUserPage.docomp?roleCode=ORG_00005";
    } else if (action == "salesMajordomo") {
        title = "投资总监";
        url = "${ctx}/system/user/toSearchUserPage.docomp?roleCode=ORG_00004";
    }
    else if (action == "customer") {
    	title = "客户";
        url = "${ctx}/customer/customer/toSearchCustomerPage.docomp";
    } else if (action == "product") {
    	title = "产品";
        height = 500;
        url = "${ctx}/project/product/toSearchProductPage.docomp";
    }
    jsUtil.dialogIframe(url, title, 800, height, function () {
        var $obj = $(".bor_e28d1f", window.frames["dialogIframe"].document);
        if ($obj.length > 0) {
            $("#txt_" + action).val($obj.find("td:eq(0)").text());
            $("#hide_" + action + "_id").val($obj.attr("id"));
            if (action == "product") {
            	// 起售金额
                var txt = $obj.find("td:eq(1)").text();
            	txt = txt.substring(txt.indexOf(':') + 1);
                $("#productSellMoney").val(txt);
                $("#purchaseMoney").val(txt);
                // 利率
                txt = $obj.find("td:eq(2)").text();
                $("#earningRate").val(txt.substring(txt.indexOf(':') + 1).replace("%", ""));
                // 赎回公式
                txt = $obj.find("td:eq(3)").text();
                $("#redeemFormula").val(txt.substring(txt.indexOf(':') + 1));
            }
        }
    });
}
function clearInputVal(obj) {//清除
    $(obj).prevAll("input").val('');
}
</script>
</head>
<body>
<form id="form" action="${ctx }${funcUrl}" method="post">
    <input type="hidden" name="flowNode.id" value="${order.flowNode.id}">
    <input type="hidden" name="flowNode.type" value="${order.flowNode.type}">
    <div class="ml35 mr35 mt20 block cb cb">
        <b class="b1"></b><b class="b2"></b><b class="b3"></b><b class="b4"></b>
        <div class="ie_head"><h1 class="f14 fbnone mt10 ml10 fl">订单详情信息</h1>
            <ul class="fr id_table1 mt10 ml10"></ul>
        </div>
    </div>
    <input type="hidden" name="id" value="${order.id}"/>
    <div class="ml35 mr35 bg_c_blue cb">
        <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%"><span class="w_red">*&nbsp;</span>订单编号：</td>
                <td align="left"><input type="text" name="code" value="${order.code}" class="text_input3 required {unique:['Order','${order.code}']}" maxlength="30"/></td>
                <td align="right" width="15%"><span class="w_red">*&nbsp;</span>所有者：</td>
                <td align="left">
                    <input type="text" id="txt_owner" name="name_owner" value="${order.owner.realName}" class="text_input3 cp required" 
                    	onclick="searchData('owner');" readonly/>
                    <input type="hidden" id="hide_owner_id" name="owner.id" value="${order.owner.id }"/>
                    <i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索所有者" onclick="searchData('owner');"></i>
                    <i class="dump_btn globle_img block_inline ml5 vm cp empty" onclick="clearInputVal(this)" title="清除"></i>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="w_red">*&nbsp;</span>产品：</td>
                <td align="left">
                    <input type="text" id="txt_product" name="name_product" value="${order.product.name}" class="text_input3 cp required" 
                    	onclick="searchData('product');" readonly/>
                    <input type="hidden" value="${order.product.id}" id="hide_product_id" name="product.id"/>
                    <i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索产品" onclick="searchData('product');"></i>
                    <i class="dump_btn globle_img block_inline ml5 vm cp empty" onclick="clearInputVal(this);" title="清除"></i>
                </td>
                <td align="right"><span class="w_red">*&nbsp;</span>投资方式：</td>
                <td align="left">
                    <select name="investmentWay.id"
                            class="select1 pr requiredSelect">
                        <option value="-1">--无--</option>
                        <c:forEach items="${investmentWay}" var="s">
                            <option value="${s.id}" <c:if test="${s.id==order.investmentWay.id}">selected</c:if>>${s.key}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
            	<td align="right"><span class="w_red">*&nbsp;</span>客户：</td>
                <td align="left">
                    <input type="text" id="txt_customer" name="name_customer" value="${order.customer.name}" class="text_input3 cp required" 
                    	onclick="searchData('customer');" readonly/>
                    <input type="hidden" value="${order.customer.id}" id="hide_customer_id" name="customer.id"/>
                    <i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索客户" onclick="searchData('customer');"></i>
                    <i class="dump_btn globle_img block_inline ml5 vm cp empty" onclick="clearInputVal(this)" title="清除"></i>
                </td>
                <td align="right"><span class="w_red">*&nbsp;</span>生效时间：</td>
                <td align="left">
                    <fmt:formatDate value="${order.effectiveTime}" pattern="yyyy-MM-dd" var="effectiveTime"/>
                    <input type="text" name="effectiveTime" value="${effectiveTime}" class="text_input3 input_close1 time required" readonly/>
                </td>
            </tr>
            <tr>
            	<td align="right"><span class="w_red">*&nbsp;</span>购买金额（万）：</td>
                <td align="left">
                    <input type="text" name="purchaseMoney" id="purchaseMoney" value="${order.purchaseMoney}" class="text_input3 number required"/>
                    <input type="hidden" id="productSellMoney" name="productSellMoney"/>
                </td>
                <td align="right"><span class="w_red">*&nbsp;</span>结束时间：</td>
                <td align="left">
                    <fmt:formatDate value="${order.orderEndTime}" pattern="yyyy-MM-dd" var="endTime"/>
                    <input type="text" name="orderEndTime" value="${endTime}" class="text_input3 input_close1 time required" readonly/>
                </td>
            </tr>
            <tr>
            	<td align="right"><span class="w_red">*&nbsp;</span>收益率（%）：</td>
                <td align="left"><input type="text" name="earningRate" id="earningRate" readonly value="${order.earningRate}" class="text_input3 number required"/></td>
                <td align="right"><span class="w_red">*&nbsp;</span>投资经理：</td>
                <td align="left">
                    <input type="text" id="txt_salesManager" value="${order.salesManager.realName}" name="name_salesManager" class="text_input3 cp required" 
                    	onclick="searchData('salesManager');" readonly/>
                    <input type="hidden" id="hide_salesManager_id" name="salesManager.id" value="${order.salesManager.id}"/>
                    <i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索所有者" onclick="searchData('salesManager');"></i>
                    <i class="dump_btn globle_img block_inline ml5 vm cp empty" onclick="clearInputVal(this)" title="清除"></i>
                </td>
            </tr>
            <tr>
            	<td align="right"><span class="w_red">*&nbsp;</span>赎回赔率（%）：</td>
                <td align="left"><input type="text" name="arr" value="${order.arr}" class="text_input3 number required" maxlength="5"/></td>
            	<td align="right"><span class="w_red">*&nbsp;</span>投资总监：</td>
                <td align="left">
                    <input type="text" id="txt_salesMajordomo" value="${order.salesMajordomo.realName}" name="name_salesMajordomo" 
                    	class="text_input3 cp required" onclick="searchData('salesMajordomo');" readonly/>
                    <input type="hidden" id="hide_salesMajordomo_id" name="salesMajordomo.id" value="${order.owner.id}"/>
                    <i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索所有者" onclick="searchData('salesMajordomo');"></i>
                    <i class="dump_btn globle_img block_inline ml5 vm cp empty" onclick="clearInputVal(this)" title="清除"></i>
                </td>
            </tr>
            <tr>
            	<td align="right"><span class="w_red">*&nbsp;</span>赎回公式：</td>
                <td align="left"><input type="text" name="redeemFormula" id="redeemFormula" value="${order.redeemFormula}" class="text_input3 required" readonly/></td>
                <td align="right"></td>
                <td align="left"></td>
            </tr>
        </table>
        <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
        <table class="cb id_table4 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%" valign="top">备注：</td>
                <td align="left" width="85%" valign="top">
                	<textarea name="remark" class="remarks_input1" maxlength="500">${order.remark}</textarea>
                </td>
            </tr>
        </table>
        <div class="h40"></div>
    </div>
    <div class="cb block h40 margin0 mt10" style="width:350px;">
        <ul class="id_table1 cb">
            <c:if test="${VS_HAS_FUNCTIONS.orderAdd||VS_HAS_FUNCTIONS.orderModify}">
                <li>
                    <a href="javascript:;" id="save" class="block c_white lh25 mr10">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b>
                    </a>
                </li>
            </c:if>
            <c:if test="${VS_HAS_FUNCTIONS.orderAdd}">
                <li>
                    <a href="javascript:;" id="saveAndAdd" class="block c_white lh25 mr10">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14">保存并新建</b>
                    </a>
                </li>
            </c:if>
            <li>
                <a href="${ctx}/order/order/toQueryPage.do" class="block c_white lh25">
                    <b class="allbtn_l block fl"></b>
                    <b class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b>
                </a>
            </li>
        </ul>
    </div>
</form>
</body>
</html>