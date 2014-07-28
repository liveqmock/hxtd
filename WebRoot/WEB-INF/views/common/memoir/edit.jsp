<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	jsUtil.SingleLimitDate('#time', 'min', 0); // 日历
});
function submitForm(){ // 提交表单
	if($("#form").valid()){
		var moduleType =$("#moduleType", parent.document).val();
		var moduleId = $("#moduleId", parent.document).val();
		RcmsAjax.ajax(form.action, function(obj){
				if(obj.successFlag){
					setTimeout(function(){
						parent.DIALOG.dialog("close");
						parent.grid.loadGrid();
					}, 500);
				}
			}, 
			null, 
			$("form").serialize() + "&moduleType=" + moduleType + "&moduleId=" + moduleId
		);
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
          	  <fmt:formatDate value="${memoir.nextContactTime}" pattern="yyyy-MM-dd" var="nextContactTime"/>
              <input id="time" name="nextContactTime" class="text_input2 input_close2 globle_img" 
              	type="text" value="${nextContactTime}" readonly/>
            </div>
          </td>
        </tr>
        <tr class="h80">
          <td align="right"><i class="mt3 block">下次联系要点：</i></td>
          <td><textarea name="nextContactPoints" class="remarks_input3" maxlength="500">${memoir.nextContactPoints}</textarea></td>
        </tr>
        <tr class="h80">
          <td align="right"><i class="mt3 block"><span class="w_red">*&nbsp;</span>联系纪要：</i></td>
          <td><textarea name="summary" class="remarks_input3 required" maxlength="500">${memoir.summary}</textarea></td>
        </tr>
        <tr class="h80">
          <td align="right"><i class="mt3 block">备注：</i></td>
          <td><textarea name="remark" class="remarks_input3" maxlength="500">${memoir.remark}</textarea></td>
        </tr>
      </table>
    </div>
  </div>
</form>
</body>
</html>
