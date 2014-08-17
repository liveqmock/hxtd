<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>市场活动编辑</title>
<link href="${ctx}/static/css/recommend/list1.css?v=1" type="text/css" rel="stylesheet"></link>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js?v=1"></script>
<script type="text/javascript">
$(function () {
    jsUtil.bindSave(".add", "form"); //提交表单
    jsUtil.formatMoney(".money"); //设置千分位
    var dates = $("#start,#end"); //日历设置
    dates.datepicker({
        closeText: '清空',
        minDate: 0,
        onSelect: function (selectedDate) {
            var option = this.id == "start" ? "minDate" : "maxDate";
            dates.not(this).datepicker("option", option, selectedDate);
        }
    }).focus(function () {
        clearDate($(this), true);
    });
    $(".empty").click(function () { //清除
        $(this).prevAll("input").val('');
    });
});
function searchData(action) { //搜索
    jsUtil.dialogIframe("${ctx}/system/user/toSearchUserPage.docomp", "负责人", 800, 420,
    	function () { //确定回调   
	        var $userObj = $(".bor_e28d1f", window.frames["dialogIframe"].document);
	        if ($userObj.length > 0) {
	            console.warn($userObj.find("td:eq(0)").text());
	            $("#txt_" + action).val($userObj.find("td:eq(0)").text());
	            $("#hide_" + action + "_id").val($userObj.attr("id"));
	        }
    	}
    );
}
</script>
</head>
<body>
<form id="form" action="${ctx}${VR_FUNCTION.url}" method="post">
    <input type="hidden" name="flowNode.id" value="${activity.flowNode.id}">
    <input type="hidden" name="flowNode.type" value="${activity.flowNode.type}">
    <div class="ml35 mr35 mt20 block cb cb">
        <b class="b1"></b>
        <b class="b2"></b>
        <b class="b3"></b>
        <b class="b4"></b>
        <div class="ie_head">
            <h1 class="f14 fbnone mt10 ml10 fl">编辑市场活动</h1>
            <input type="hidden" name="id" value="${activity.id}"/>
        </div>
    </div>
    <div class="ml35 mr35 bg_c_blue cb">
        <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10">
            <tr>
                <td width="15%" align="right"><span class="w_red">*&nbsp;</span>活动所有者：</td>
                <td align="left">
                    <input name="sponsorname" type="text" value="${activity.sponsor.realName}" readonly class="text_input3"/>
                    <input type="hidden" name="sponsor.id" value="${activity.sponsor.id}"/>
                </td>
                <td width="15%" align="right"><span class="w_red">*&nbsp;</span>活动名称：</td>
                <td align="left"><input name="name" type="text" value="${activity.name}" class="text_input3 required {unique:['MarketActivity','${activity.name}']}" maxlength="30"/></td>
            </tr>
            <tr>
                <td align="right"><span class="w_red">*&nbsp;</span>负责人：</td>
                <td align="left">
                    <input type="text" id="txt_boss" name="bossname" value="${activity.bossHead.realName}" readonly 
                    	onclick="searchData('boss')" class="text_input3 required cp"/>
                    <input type="hidden" id="hide_boss_id" name="bossHead.id" value="${activity.bossHead.id}"/>
                    <i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索责任人" onclick="searchData('boss');"></i>
                    <i class="dump_btn globle_img block_inline ml5 vm cp empty" title="清除"></i>
                </td>
                <td align="right">活动类型：</td>
                <td align="left">
                    <select name="typeDic.id" class="select1 pr">
                        <option value="">--无--</option>
                        <c:forEach items="${typeDic}" var="dic">
                            <option value="${dic.id}" ${dic.id==activity.typeDic.id?"selected":""}>${dic.key}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right"><span class="w_red">*&nbsp;</span>开始日期：</td>
                <td align="left">
                    <fmt:formatDate value="${activity.beginDate}" pattern="yyyy-MM-dd" var="beginDate"/>
                    <input type="text" id="start" name="beginDate" value="${beginDate}" readonly class="text_input3 input_close1 required"/>
                </td>
                <td align="right">活动状态：</td>
                <td align="left">
                    <select name="statusDic.id" class="select1 pr">
                        <option value="">--无--</option>
                        <c:forEach items="${statusDic}" var="dic">
                            <option value="${dic.id}" ${dic.id==activity.statusDic.id?"selected":""}>${dic.key}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">结束日期：</td>
                <td align="left">
                    <fmt:formatDate value="${activity.endDate}" pattern="yyyy-MM-dd" var="endDate"/>
                    <input type="text" id="end" name="endDate" value="${endDate}" readonly class="text_input3 input_close1"/>
                </td>
                <td align="right">预计成本（元）：</td>
                <td align="left">
                    <fmt:formatNumber value="${activity.predictCost}" pattern="###,##0.00" var="predictCost"/>
                    <input type="text" value="${predictCost}" class="text_input3 money" maxlength="13" style="ime-mode:disabled"/>
                    <input type="hidden" name="predictCost" value="${activity.predictCost}"/>
                </td>
            </tr>
            <tr>
                <td align="right">预期效果：</td>
                <td align="left"><input name="expectEffect" type="text" value="${activity.expectEffect}" class="text_input3" maxlength="30"/></td>
                <td align="right">实际成本（元）：</td>
                <td align="left">
                    <fmt:formatNumber value="${activity.realityCost}" pattern="###,##0.00" var="realityCost"/>
                    <input type="text" value="${realityCost}" class="text_input3 money" maxlength="13" style="ime-mode:disabled"/>
                    <input type="hidden" name="realityCost" value="${activity.realityCost}"/>
                </td>
            </tr>
            <tr>
                <td align="right">期望成功率（%）：</td>
                <td align="left"><input type="text" name="expectSuccessRate" value="${activity.expectSuccessRate}"
                                        class="text_input3 amount" maxlength="5" style="ime-mode:disabled"/></td>
                <td align="right">活动次数：</td>
                <td align="left"><input name="times" type="text" value="${activity.times}" class="text_input3 digits" maxlength="3"/></td>
            </tr>
        </table>
        <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
        <table class="cb id_table4 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%" valign="top">备注：</td>
                <td align="left" width="85%" valign="top"><textarea name="remark" class="remarks_input1" maxlength="500">${activity.remark}</textarea></td>
            </tr>
        </table>
        <div class="h40"></div>
    </div>
    <c:if test="${VS_HAS_FUNCTIONS.marketactivityModify}">
        <div class="cb block h40 margin0 mt10" style="width:350px;">
            <ul class="id_table1 cb">
                <li>
                    <a href="javascript:;" class="block c_white lh25 ml10 add" redirecturi="/market/marketactivity/toViewPage.do?id=%s">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b>
                    </a>
                </li>
                <c:if test="${VS_HAS_FUNCTIONS.marketactivityAdd}">
                    <li>
                        <a href="javascript:;" class="block c_white lh25 ml10 add" redirecturi="/market/marketactivity/toAddPage.do">
                            <b class="allbtn_l block fl"></b>
                            <b class="allbtn_r pr13 block fl w_auto f14">保存并新增</b>
                        </a>
                    </li>
                </c:if>
                <li>
                    <a href="${ctx}/market/marketactivity/toQueryPage.do" class="block c_white lh25 ml10">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14">取消</b>
                    </a>
                </li>
            </ul>
        </div>
    </c:if>
</form>
</body>
</html>
