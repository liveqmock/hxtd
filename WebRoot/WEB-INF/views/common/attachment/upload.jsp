<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>upload</title>
<link rel="stylesheet" href="${ctx}/static/css/public/common.css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css"/>
<link rel="stylesheet" href="${ctx}/static/css/uploadify.css" type="text/css"></link>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.uploadify.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/commonAjax.js"></script>
<style type="text/css">
	.uploadify-button { background-color: transparent; border: none; padding: 0;}
	.uploadify:hover .uploadify-button { background-color: transparent; }
</style>
<script type="text/javascript">
var moduleId;
var $att;
buttonAdd="${ctx}/static/images/tan_btn1.png";
buttonNoneAdd="${ctx}/static/images/tan_btn1none.png";
$(function(){
	var url = parent.uploadURL;
	/**
	 * 获得纪录的id.
	 * $("#id", parent.document)分析
	 * @param {Object} file
	 */
	moduleId = $("#id", parent.document).val();
	 
	$att=$("#att");
	$att.uploadify({
		auto: false,
		fileTypeExts: '*.jpg;*.png;*.gif',
		fileObjName: 'file',
		fileTypeDesc: '文件格式',
		fileSizeLimit: "5MB",
		buttonImage: buttonAdd,
		simUploadLimit: 5,
		removeTimeout: 1,
		successTimeout: 1,
		width: 80,
		height: 27,
		'method' : "post",
		//onUploadSuccess:attachment.success,
		'swf'      : jsUtil.getRootPath()+'/static/css/uploadify.swf',
		'uploader' : url+";jsessionid=${pageContext.session.id}",
		'onUploadStart': function (file) {
			 var dictId = $("#dict").val();
			 var data = moduleId + "," + dictId;
                $att.uploadify("settings", "formData", { 'data': data});
            },
            'onUploadSuccess' : parent.attachment.query,
            'onQueueComplete': function(){
           	 $('#att-button').css({"background-image" : "url(" + buttonAdd + ")"});
           	 $att.uploadify('disable', false);
            }
	});
	$("#upload").click(function(){
		var num = $att.data('uploadify').queueData.queueLength;
		if(num>0){
			upload();
		}else{
			/**
			 * todo
			 * 修改没有汉化的提示信息,修改方式如下
			 */
			showMsg({successFlag:false,message:'上传队列中不存在文件，请检查！'});
			setTimeout(_hide(),RcmsAjax.global.showTime);
		}
	});
});
function upload(){
	if(checkType()){
		$att.uploadify('disable', true)
		$('#att-button').css({"background-image" : "url(" + buttonNoneAdd + ")"});
		$att.uploadify('upload', '*');
	}
}
function checkType(){
	var dict = $("#dict").val();
	if(dict==""){
		$("#type").text("请选择一个类型");
		return false;
	}else{
		$("#type").text("");
		return true;
	}
}
function stop(){
	$att.uploadify('stop');
}
</script>
</head>
	<body>
		<div style="height: 460px; overflow: hidden; overflow-y: auto;">
			<div style="margin-bottom: 20px;">
				<div class="fl">
					<h1 class="fl f12 fbnone block mt3">
						附件类型：
					</h1>
					<select id="dict" class="select3">
						<option value="">
							请选择
						</option>
						<c:forEach items="${dict}" var="d">
							<option value="${d.id}">
								${d.key}
							</option>
						</c:forEach>
					</select>
					<label id="type" class="w_red"></label>
				</div>
				
				<div class="fr">
					<li class="fl">
						<a id="upload" class="block c_white lh25 ml10" href="javascript:;">
							<b class="allbtn_l block fl"></b> <b
							class="allbtn_r pr13 block fl w_auto f14">开始上传</b> </a>
					</li>
					<%--<li class="fl">
					<a class="block c_white lh25 ml10" href="javascript:stop()"> <b
						class="allbtn_l block fl"></b> <b
						class="allbtn_r pr13 block fl w_auto f14">取消上传</b>
					</a>
					</li>--%>
				</div>
				<br/><br/>
				<div class="cb">
					<input type="file" id="att" />
				</div>
			</div>
		</div>
	</body>
</html>
