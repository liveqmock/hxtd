<%--<%--
  系统导入页
  User: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
	<head>
		<title>导入页</title>
		<link rel="stylesheet" href="${ctx}/static/css/application.css"
			type="text/css" />
		<link rel="stylesheet" href="${ctx}/static/css/import.css"
			type="text/css" />
		<link rel="stylesheet" href="${ctx}/static/css/uploadify.css"
			type="text/css"></link>

		<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"> </script>
		<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"> </script>
		<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"> </script>
		<script type="text/javascript" src="${ctx}/static/js/js-util.js?v=1"></script>
		<script type="text/javascript" src="${ctx}/static/js/jquery.uploadify.min.js"> </script>
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
$(function() {
	//jsUtil.bindSave();
	//定义变量,获取模块名称
	var moduleName = $("#moduleName").val();
	$("#moduleName").change(function() {
		moduleName = $("#moduleName").val();
	});


	var url = jsUtil.getRootPath()+"/common/imports/import.do";
	$att = $("#file");
	$att.uploadify( {
		auto : false,//是否自动上传
		fileTypeDesc : '文件格式',
		fileTypeExts : '*.xls;*.xlsx',////控制可上传文件的扩展名，启用本项时需同时声明fileDesc
		fileObjName : 'file',//文件对象名称.用于在服务器端获取文件.
		'buttonImage' : buttonAdd,//上传文件的图片
		'width' : 80,
		'height' : 27,
		'uploadLimit':2,//最多上传文件数量
		'queueSizeLimit' : 1,// 允许同时上传的个数
		'fileSizeLimit':'5MB',//上传文件大小限制
		removeTimeout : 1,//上传完成后多久删除队列中的进度条
		successTimeout : 30,//表示文件上传完成后等待服务器相应的时间.超过改时间,那么将认为上传成功
		'multi':true,//是否允许多文件上传
		'method' : "post",
		//onUploadSuccess:attachment.success,
		'swf' : jsUtil.getRootPath() + '/static/css/uploadify.swf',
		'uploader' :  url ,//后台处理的请求  
		'onUploadStart' : function(file) {
			var _moduleName = $("#moduleName option:selected").text();
			
			//校验重复记录处理方式
			var _duplicateType = $("input:radio[name='duplicateType'][checked]").val();
			
			//获取被选中的个数
			var _checkWaysSize = $("input:checked[name='checkWay']").size();
			var _checkWays = new Array();
			$("input[name='checkWay']:checked").each(function(){
				_checkWays.push(this.value);
			});
			$att.uploadify("settings", "formData", {
				'duplicateType' : _duplicateType,
				'checkWay':_checkWays,
				'moduleName':moduleName
			})
		},
		'onUploadSuccess':function(file, data, response){//在每一个文件上传成功后触发
			//data:从服务器返回回来
			//response:响应成功true,响应失败false
			var returnData = eval("("+data+")").message;
			if(returnData.indexOf(";")>0){
				var messages = returnData.split(";");
				$("#importResult").html(messages[0]);
				$("#repeatData").html(messages[1]);
				$("#invalidFormatData").html(messages[2]);
				$("#databaseUpdateData").html(messages[3]);
				$("#databaseNew").html(messages[4]);
			}else{
				$("#importResult").html(returnData);
			}
		}
		
	});
});

function upload() {
	if (checkType()) {
		//上传有效
		$att.uploadify('disable', true)
		$('#att-button').css( { "background-image" : "url(" + buttonNoneAdd + ")" });
		//上传队列中的所有的文件
		$att.uploadify('upload', '*');
	}
}

function checkType() {
	var moduleName = $("#moduleName option:selected").text();
	if (moduleName == "") {
		$("#type").text("请选择一个上传文件类型");
		return false;
	} else {
		$("#type").text("");
		return true;
	}
}
//停止上传
function stop() {
	$att.uploadify('stop');
}
</script>

	</head>
	<body>
		<div>
			<div class="cb"></div>
			<div class="ml35 mr35 mt20 block cb cb">
				<b class="b1"></b>
				<b class="b2"></b>
				<b class="b3"></b>
				<b class="b4"></b>

				<div class="ie_head">
					<h1 class="f14 fbnone mt10 ml10 fl">
						导入数据
					</h1>
				</div>
			</div>


			<form action="${ctx}/common/imports/import.do" method="POST"
				id="importForm" enctype="multipart/form-data">
				<div class="ml35 mr35 bg_c_blue cb">
					<div style="width: 50%;" class="fl">
						<table class="margin0 pt20">
							<tr class=" lh40">
								<td width="40%" align="right">
									文件类型：
								</td>
								<td>
									<select class="select2" id="moduleName" name="moduleName">
									<option value="">请选择</option>
										<c:forEach var="item" items="${enumModules}">
											<option value="${item.moduleName}">
												${item.moduleChineseName}
											</option>
										</c:forEach>
									</select>
									<label id="type" class="w_red"></label>
								</td>
							</tr>
							<tr class=" lh40">
								<td align="right">
									选择导入的文件：
								</td>
								<td>
									<div class="vm">
										<input type="file" id="file" name="file" size="28" />
								</td>
							</tr>
							<tr class=" lh40">
								<td align="right">
									重复记录：
								</td>
								<td>
									<input type="radio" name="duplicateType" value="jump">
									跳过&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="duplicateType" value="conver" />
									覆盖&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="duplicateType" value="merge" checked />
									合并
								</td>
							</tr>
							<tr class=" lh40">
								<td align="right">
									重复数据标识列：
								</td>
								<td>
									<input type="checkbox" name="checkWay" value="mobile" checked>
									手机&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="checkWay" value="email" />
									邮箱&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
							<tr class=" lh40">
								<td align="right"></td>
								<td align="right">
								<%--<a href="javascript:upload()" class="block c_white lh25 mr10 fl" > 
									<b class="allbtn_l block fl"></b> 
									<b class="allbtn_r pr13 block fl w_auto f14">导&nbsp;&nbsp;入</b> 
								</a>
								--%></td>
							</tr>



						</table>

						<div class="bg_c_white w50b margin0 mt20" style="height:220px;overflow-y:auto;">
							<ul class="p10 lh40">
								<li><font color="red">导入信息:</font></li>
								<li>
									<div id="fileName"></div>
									<div id="fileSize"></div>
									<div id="fileType"></div>
									<div id="resultMsg" style="margin-top: 20px;"></div>
								</li>
								<li>
									<div id="importResult"></div>
								</li>
								<li>
									<div id="repeatData"></div>
								</li>
								<li>
									<div id="invalidFormatData"></div>
								</li>
								<li>
									<div id="databaseUpdateData"></div>
								</li>
								<li>
									<div id="databaseNew"></div>
								</li>
								<li>
									<div></div>
								</li>
								<li>
									<div></div>
								</li>
							</ul>
						</div>
						<div class=" w50b margin0 mt20" style="height:100px;overflow-y:auto;">
							<p class="mt40">模板：<a href="${ctx}/static/template/import/${templateName}">${templateName}</a></p>
	
			                <p style="color:red;">
			                    1.请先下载模板，并在此基础上进行修改。<br/>
			                    2.管理员、启用、性别都是“是否”类型的数据。<br/>
			                </p>
		                </div>
					</div>
					<div style="width: 30%;" class=" bor_336699 fl mt20 p10">
						<p class="lh25">
							导入事项：
						</p>
						<p class="lh25">
							数据的风口浪尖是否考虑加速度快了房价地块上浪费塑料袋房价快速的减肥快乐圣诞节
							数据的风口浪尖是否考虑加速度快了房价地块上浪费塑料袋房价快速的减肥快乐圣诞节
						</p>
					</div>
					<div class="w240 margin0 cb h40 mt20" >
						<c:if test="${VS_HAS_FUNCTIONS.userImport}">
							<a href="javascript:upload()" class="block c_white lh25 mr10 fl" > 
									<b class="allbtn_l block fl"></b> 
									<b class="allbtn_r pr13 block fl w_auto f14">导&nbsp;&nbsp;入</b> 
								</a>
							<a href="javascript:$('file').uploadify('cancel');"
								class="block c_white lh25 mr10 fr"><b
								class="allbtn_l block fl"></b><b
								class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b> </a>
						</c:if>
					</div>
				</div>
					
				<div>
					
				</div>
				
		</div>
		</form>
		</div>
	</body>
</html>