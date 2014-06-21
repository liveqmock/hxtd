<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>upload</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.uploadify.min.js"></script>
<link rel="stylesheet" href="${ctx}/static/css/uploadify.css" type="text/css"></link>
<script type="text/javascript">
var moduleId;
$(function(){
	var url = parent.uploadURL;
	moduleId = $("#id",parent.document).val();
	$('#att').uploadify({
			auto:false,
			fileTypeExts:'*.jpg;*.png;*.gif',
			fileObjName:'file',
			fileTypeDesc:'文件格式有误',
			fileSizeLimit:"5MB",
			buttonText:"浏览...",
			hideButton:true,
			width:80,
			height:20,
			//onUploadSuccess:attachment.success,
			'swf'      : jsUtil.getRootPath()+'/static/css/uploadify.swf',
			'uploader' : url,
			'onUploadStart': function (file) {  
				 var dictId=$("#dict").val();
				 var data = moduleId+","+dictId;
                 $('#att').uploadify("settings", "formData", { 'data': data});
             }
	});
});
function upload(){
	var dict = $("#dict").val();
	if(dict==""){
		$("#type").text("请选择一个类型");	
	}else{
		$("#type").text("");	
		$('#att').uploadify('upload');
	}
}
function stop(){
	$('#att').uploadify('stop');
}
</script>
</head>
	<body>
		<div style="height: 460px; overflow: hidden; overflow-y: auto;">
			<div style="margin-bottom: 20px;">
				<a class="swfupload"
					href="javascript:upload()">上传</a>|
				<a class="swfupload"
					href="javascript:stop()">取消上传</a>
				附件类型：
				<select id="dict">
					<option value="">请选择</option>
					<c:forEach items="${dict}" var="d">
						<option value="${d.id}">${d.key}</option>
					</c:forEach>
				</select>
				<label style="color: red;" id="type"></label>
			</div>
			<input type="file" id="att" />
		</div>
	</body>
</html>
