<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title></title>
<link rel="stylesheet" href="${ctx}/static/css/css.css" type="text/css"></link>
<link rel="stylesheet" href="${ctx}/static/css/themes/base/jquery.ui.all.css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/commonAjax.js"></script>
<style type="text/css">
	input.error { border: 1px solid red }
	label.error { padding-left: 18px; color: red; }
	img { cursor:pointer; }
	textarea{ resize:none; width:90%; height:100px; border:1px solid #e0e0e0; margin:5px 0px }
</style>
<script type="text/javascript">
$(function(){//初始化 
	$("#form").validate({
		rules: {
			summary: { required: true }
		},
		messages: {
			summary: { required: "*必填"}
		}
	});
	jsUtil.datepicker("#time");//日历
});
function submitRemoir(){//提交表单
	if($("#form").valid()){
		var moduleType =$("#moduleType", parent.document).val();
		var moduleId = $("#moduleId", parent.document).val();
		RcmsAjax.ajax(form.action, null, null, $("form").serialize() + "&moduleType=" + moduleType + "&moduleId=" + moduleId);
		return true;
	}else{
		return false;
	}
}
//function searchData(action){//搜索弹出框
//	var url, title;
//	if(action == "users"){
//		url = "${ctx}/system/user/toQueryPage.comp";
//		title = "参与者";
//	}
//	jsUtil.dialogIframe(url, title, 800, 465, function(){//确定回调
//		var ckObj = $(":checked", window.frames["dialogIframe"].document);
//		if(ckObj.length > 0){
//			$("#txt_" + action).val(ckObj.parent().next().text());
//			$("#hide_" + action +"_id").val(ckObj.val());
//		}
//	});
//}
//function clearInputVal(obj){//清除
//	$(obj).prevAll("input").val('');
//}
</script>
</head>
<body>
<form id="form" action="${ctx}${VR_FUNCTION.url}" method="post">
<div class="">
	<input type="hidden" name="id" value="${memoir.id}"/>
	<table style="width:100%;" class="table140421">
		<!--<tr>
			<td class="tar bghui pr10">参与沟通人员：</td>
			<td class="bghb pl10">
				<input name="txt_users" type="text" value=""/>
				<img src="${ctx}/static/images/search.png" alt="" title="搜索人员" onclick="searchData('users');"/>
				<img src="${ctx}/static/images/clear.png" alt="" title="清除" onclick="clearInputVal(this);"/>
				<input type="hidden" name="" id="hide_users_id"/>
			</td>
		</tr>
		 -->
		<tr>
			<td width="20%" class="tar bghui pr10">联系纪要：</td>
			<td width="80%" class="bghb pl10 fwb color0">
				<textarea name="summary" >${memoir.summary}</textarea>
			</td>
		</tr>
		<tr>
			<td class="tar bghui pr10">下次联系时间：</td>
			<td class="bghb pl10 color1 fwb">
				<input id="time" name="nextContactTime" type="text" value="${memoir.nextContactTime}" readonly="readonly"/>
			</td>
		</tr>
		<tr>
			<td class="tar bghui pr10">下次联系要点：</td>
			<td class="bghb pl10">
				<textarea name="nextContactPoints" >${memoir.nextContactPoints}</textarea>
			</td>
		</tr>
		<tr>
			<td class="tar bghui pr10">备注：</td>
			<td class="bghb pl10">
				<textarea name="remark" >${contact.remark}</textarea>
			</td>
		</tr>
	</table>
</div>
</form>
</body>
</html>
