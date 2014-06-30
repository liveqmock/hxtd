<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>联系纪要</title>
<link rel="stylesheet" href="${ctx}/static/css/public/common.css?v=1" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css?v=1" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css?v=1" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/themes/base/jquery.ui.all.css?v=1" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.core.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/commonAjax.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.datepicker.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>
<script type="text/javascript">
$(function(){
	jsUtil.datepickerNotNow("#time");
});
function submitForm(){
	if($("#form").valid()){
		var moduleType =$("#moduleType", parent.document).val();
		var moduleId = $("#moduleId", parent.document).val();
		RcmsAjax.ajaxNoMsg(form.action, callback, null, 
			$("form").serialize() + "&moduleType=" + moduleType + "&moduleId=" + moduleId);
	}
}
function callback(obj){
	if(obj.successFlag){
		parent.DIALOG.dialog("close");
		parent.grid.loadGrid();
	}
}
</script>
</head>
<body>
<form id="form" action="${ctx}${VR_FUNCTION.url}" method="post">
  <input type="hidden" name="id" value="${memoir.id}"/>
  <div class="margin0">
    <div>
      <table class="id_tantable1 w pr10 pl10">
      	<tr class="h50">
          <td width="25%" align="right"><i class="mt3 block">下次联系时间：</i></td>
          <td>
          	<div class="vm">
              <input id="time" name="nextContactTime" class="text_input2 input_close2 globle_img" 
              	type="text" value="${memoir.nextContactTime}" readonly/>
            </div>
          </td>
        </tr>
        <tr class="h80">
          <td align="right"><i class="mt3 block">下次联系要点：</i></td>
          <td><textarea name="nextContactPoints" class="remarks_input3">${memoir.nextContactPoints}</textarea></td>
        </tr>
        <tr class="h80">
          <td align="right"><i class="mt3 block">联系纪要：</i></td>
          <td><textarea name="summary" class="remarks_input3 required">${memoir.summary}</textarea></td>
        </tr>
        <tr class="h80">
          <td align="right"><i class="mt3 block">备注：</i></td>
          <td><textarea name="remark" class="remarks_input3">${contact.remark}</textarea></td>
        </tr>
      </table>
    </div>
  </div>
</form>
</body>
</html>
