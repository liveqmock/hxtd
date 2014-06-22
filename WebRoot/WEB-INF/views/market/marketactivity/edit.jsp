<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>市场活动信息</title>
<link href="${ctx}/static/css/recommend/detail.css?v=1" type="text/css" rel="stylesheet"></link>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.datepicker.js?v=1"></script>
<script type="text/javascript">
$(function(){
	$(".add").click(function(){// 表单验证
		if($("#form").valid()){
			form.action = form.action + "?redirectUri=" + encodeURI($(this).attr("redirecturi"));
			form.submit();
		}
		return false;
	});
	var dates=$("#start,#end");// 日历设置
	dates.datepicker({
		closeText : '关闭',
		prevText : '&#x3c;上月',
		nextText : '下月&#x3e;',
		currentText : '今天',
		monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月' ],
		monthNamesShort : [ '一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '十二' ],
		dayNames : [ '星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六' ],
		dayNamesShort : [ '周日', '周一', '周二', '周三', '周四', '周五', '周六' ],
		dayNamesMin : [ '日', '一', '二', '三', '四', '五', '六' ],
		weekHeader : '周',
		dateFormat : 'yy-mm-dd',
		firstDay : 1,
		isRTL : false,
		showMonthAfterYear : true,
		yearSuffix : '年',
		minDate: 0,
	    onSelect: function(selectedDate){
	       var option = this.id == "start" ? "minDate" : "maxDate";
	       dates.not(this).datepicker("option", option, selectedDate);
	    }
	});
	$(".clear").click(function(){// 清除
		$(this).prevAll("input").val('');
	});
});
function searchData(action){//搜索弹出框
	jsUtil.dialogIframe("${ctx}/system/user/toQueryPage.comp", "发起者", 800, 465, function(){// 确定回调
		var $ckObj = $(":checked", window.frames["dialogIframe"].document);
		if($ckObj.length > 0){
			$("#txt_" + action).val($ckObj.parent().next().text());
			$("#hide_" + action +"_id").val($ckObj.val());
		}
	});
}
</script>
</head>
<body>
<form id="form" action="${ctx}${VR_FUNCTION.url}" method="post">
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
				<input name="sponsorname" type="text" value="${activity.sponsor.realName}" readonly="readonly" class="text_input3"/>
				<input type="hidden" name="sponsor.id"/>
			</td>
			<td width="15%" align="right">类型：</td>
			<td align="left">
				<select name="dic.id" class="select1 pr">
					<option value="">--无--</option>
					<c:forEach items="${dicType}" var="dic">
						<option value="${dic.id}" ${dic.id==activity.dic.id?"selected":""}>${dic.key}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right"><span class="w_red">*&nbsp;</span>活动名称：</td>
			<td align="left"><input name="name" type="text" value="${activity.name}" class="text_input3 required"/></td>
			<td align="right">状态：</td>
			<td align="left">
				<select name="status.id" class="select1 pr">
					<option value="">--无--</option>
					<c:forEach items="${dicStatus}" var="dic">
						<option value="${dic.id}" ${dic.id==activity.status.id?"selected":""}>${dic.key}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">开始日期：</td>
			<td align="left">
				<fmt:formatDate value="${activity.beginDate}" pattern="yyyy-MM-dd" var="beginDate"/>
				<a href="javascript:;" class="pa time_closenone1"></a>
				<input type="text" id="start" name="beginDate" value="${beginDate}" readonly="readonly" class="text_input3 input_close1"/>
			</td>
			<td align="right">预计成本：</td>
			<td align="left"><input name="predictCost" type="text" value="${activity.predictCost }" class="text_input3 amount"/></td>
		</tr>
		<tr>
			<td align="right">结束日期：</td>
			<td align="left">
				<fmt:formatDate value="${activity.endDate}" pattern="yyyy-MM-dd" var="endDate"/>
				<a href="javascript:;" class="pa time_closenone1"></a>
				<input type="text" id="end" name="endDate" value="${endDate}" readonly="readonly" class="text_input3 input_close1"/>
			</td>
			<td align="right">实际成本：</td>
			<td align="left"><input type="text" name="realityCost" value="${activity.realityCost }" class="text_input3 amount"/></td>
		</tr>
		<tr>
			<td align="right">预期效果：</td>
			<td align="left"><input name="expectEffect" type="text" value="${activity.expectEffect }" class="text_input3"/></td>
			<td align="right">活动次数：</td>
			<td align="left"><input name="times" type="text" value="${activity.times }" class="text_input3 digits"/></td>
		</tr>
		<tr>
			<td align="right">期望成功率%：</td>
			<td align="left"><input type="text" name="expectSuccessRate" value="${activity.expectSuccessRate }" 
				class="text_input3 amount"/></td>
			<td align="right"><span class="w_red">*&nbsp;</span>负责人：</td>
			<td align="left">
				<input type="text" id="txt_boss" name="bossname" value="${activity.bossHead.name }" readonly="readonly"
					 class="text_input3 required"/>
				<input type="hidden"id="hide_boss_id" name="bossHead.id" value="${activity.bossHead.id }"/>
				<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索责任人" onclick="searchData('boss');"></i>
				<i class="dump_btn globle_img block_inline ml5 vm cp clear" title="清除"></i>
			</td>
		</tr>
		</table>
		<h1 class="f14 fbnone ml40 pt10">描述信息</h1>
		<table class="cb id_table4 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%" valign="top">备注：</td>
				<td align="left" width="85%" valign="top"><textarea name="remark" class="remarks_input1"
					style="resize: none;">${activity.remark}</textarea></td>
			</tr>
		</table>
	<div class="h40"></div>
</div>
<c:if test="${VS_HAS_FUNCTIONS.marketactivityModify}">
<div class="cb block h40 margin0 mt10" style="width:350px;">
	<ul class="id_table1 cb">
		<li>
			<a href="javascript;" class="block c_white lh25 ml10 add" redirecturi="/market/marketactivity/toViewPage.do?id=%s">
				<b class="allbtn_l block fl"></b>
				<b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b>
			</a>
		</li>
		<c:if test="${VS_HAS_FUNCTIONS.marketactivityAdd}">
		<li>
			<a href="javascript;" class="block c_white lh25 ml10 add" redirecturi="/market/marketactivity/toAddPage.do">
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
