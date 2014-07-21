<%--
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
		<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css" />
		<link rel="stylesheet" href="${ctx}/static/css/import.css" type="text/css" />
		<link rel="stylesheet" href="${ctx}/static/css/uploadify.css" type="text/css" />

		<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
		<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
		<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
		<script type="text/javascript" src="${ctx}/static/js/js-util.js?v=1"></script>
		<script type="text/javascript" src="${ctx}/static/js/jquery.uploadify.min.js"></script>
		<script type="text/javascript" src="${ctx}/static/js/commonAjax.js"></script>
		<style type="text/css">
			.uploadify-button {
				background-color: transparent;
				border: none;
				padding: 0;
			}
			
			.uploadify:hover .uploadify-button {
				background-color: transparent;
			}
		</style>
		
		
		
		<script type="text/javascript">
			var moduleId;
			var $att;
			buttonAdd = "${ctx}/static/images/tan_btn1.png";
			buttonNoneAdd = "${ctx}/static/images/tan_btn1none.png";
			$(function() {
				//设置模块默认值
				var module = "${moduleName}";
				if(module!="" && module!=null){
					$("#moduleName").attr("value", module);
				}
				
				$("#moduleName").change(function(){
					$("#fileName").html("");
					$("#fileSize").html("");
					$("#fileType").html("");
					$("#importResult").html("");
					$("#repeatData").html("");
					$("#invalidFormatData").html("");
					$("#databaseUpdateData").html("");
					$("#databaseNew").html("");
					//$('#file').uploadify('cancel', 'SWFUpload_0_0');
					
				})
				
				//重置按钮事件
				$("#reset").click(function(){
				   $("#importForm")[0].reset();
				   //如果有未上传的文件，也清除
				   //$('#file').uploadify('cancel', 'SWFUpload_0_0')
			    });
				//定义变量,获取模块名称
				var moduleName = $("#moduleName").val();
				$("#moduleName").change(function() {
					moduleName = $("#moduleName").val();
				});
			
				var url = jsUtil.getRootPath() + "/common/imports/import.do";
				$att = $("#file");
				$att.uploadify( {
					'auto' : false,//是否自动上传
					'fileTypeDesc' : '文件格式',
					'fileTypeExts' : '*.xls;*.xlsx',////控制可上传文件的扩展名，启用本项时需同时声明fileDesc
					'fileObjName' : 'file',//文件对象名称.用于在服务器端获取文件.
					'buttonImage' : buttonAdd,//上传文件的图片
					'width' : 80,
					'height' : 27,
					'simUploadLimit': 5,
					'uploadLimit' : 1,//最多上传文件数量
					'queueSizeLimit' : 1,// 允许同时上传的个数
					'fileSizeLimit' : '5MB',//上传文件大小限制
					'removeTimeout' : 1,//上传完成后多久删除队列中的进度条
					'successTimeout' : 60*15,//表示文件上传完成后等待服务器相应的时间.超过改时间,那么将认为上传成功
	 				'multi' : false,//是否允许多文件上传
					'method' : "post",
					'swf' : jsUtil.getRootPath() + '/static/css/uploadify.swf',
					'uploader' : url,//后台处理的请求
					'onSelect':function(file){//选择文件后触发
						var fileSize = 0;
						if (file.size > 1024 * 1024){
							fileSize = (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + 'MB';
						}else{
							fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB';
					    }
						$("#fileName").html("文件名："+file.name);
						$("#fileSize").html("文件大小："+fileSize);
						$("#fileType").html("文件类型："+file.type);
					},
					'onUploadStart' : function(file) {//在一个文件开始上传之前触发
						var _moduleName = $("#moduleName option:selected").text();
			
						//校验重复记录处理方式
						var _duplicateType = $(
							"input:radio[name='duplicateType'][checked]").val();
							//获取被选中的个数
							var _checkWaysSize = $("input:checked[name='checkWay']").size();
							var _checkWays = new Array();
							$("input[name='checkWay']:checked").each(function() {
								_checkWays.push(this.value);
							});
							$att.uploadify("settings", "formData", {//传递参数到后台
								'duplicateType' : _duplicateType,
								'checkWay' : _checkWays,
								'moduleName' : moduleName
							}
						)
					},
					'onQueueComplete': function(){
						//文件上传完成以后，将"浏览"按钮恢复颜色（注意：这个浏览按钮的id是自动生成的，通过页面查看元素就可得到）
			           	 $('#file-button').css({"background-image" : "url(" + buttonAdd + ")"});
			           	 $att.uploadify('disable', false);
		            },	
					'onUploadSuccess' : function(file, data, response) {//在每一个文件上传成功后触发
						//data:从服务器返回回来
						//response:响应成功true,响应失败false
						if(response == true){
							var returnData = eval("(" + data + ")").message;
							if (returnData.indexOf(";") > 0) {
								var messages = returnData.split(";");
								if(messages.length==2){
									$("#importResult").html(messages[0]);
									$("#repeatData").html(messages[1]);
								}else{
									$("#importResult").html(messages[0]);
									$("#repeatData").html(messages[1]);
									$("#invalidFormatData").html(messages[2]);
									$("#databaseUpdateData").html(messages[3]);
									$("#databaseNew").html(messages[4]);
								}
							} else {
								$("#importResult").html(returnData);
							}
						}else{
							$("#importResult").html("文件解析异常,请重新导入!");
						}
					}
				});
			});
			
			function upload() {
				if (checkType()) {
					//文件上传期间，将"浏览"按钮置灰（注意：这个浏览按钮的id是自动生成的，通过页面查看元素就可得到）
					$att.uploadify('disable', true)
					$('#file-button').css( {
						"background-image" : "url(" + buttonNoneAdd + ")"
					});
					//上传队列中的所有的文件
					$att.uploadify('upload', '*');
				}
			}
			
			//校验是否选择上传文件类型
			function checkType() {
				var moduleName = $("#moduleName option:selected").text();
				if (moduleName == "") {
					$("#errorMsg").text("请选择一个上传文件类型");
					return false;
				} else {
					$("#errorMsg").text("");
					return true;
				}
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
				<div class="ie_head"><h1 class="f14 fbnone mt10 ml10 fl">导入数据</h1></div>
			</div>
			<form action="${ctx}/common/imports/import.do" method="POST" id="importForm" enctype="multipart/form-data">
				<div class="ml35 mr35 bg_c_blue cb">
					<div style="width: 50%;" class="fl">
						<table class="margin0 pt20">
							<tr class=" lh40">
								<td width="40%" align="right">文件类型：</td>
								<td>
									<select class="select2" id="moduleName" name="moduleName">
										<option value="">请选择</option>
										<%--<c:forEach var="item" items="${enumModules}">--%>
											<option value="lead">线索</option>
											<option value="customer">客户</option>
											<option value="contact">联系人</option>
											<option value="supplier">供应商</option>
											<%--<option value="${item.moduleName}">
												${item.moduleChineseName}
											</option>
										</c:forEach>--%>
									</select>
									<label id="errorMsg" class="w_red"></label>
								</td>
							</tr>
							<tr class=" lh40">
								<td align="right">选择导入的文件：</td>
								<td>
									<div class="vm"><input type="file" id="file" name="file" size="28" /></div>
								</td>
							</tr>
							<tr class=" lh40">
								<td align="right">重复记录：</td>
								<td>
									<input type="radio" name="duplicateType" value="jump" />
									跳过&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="duplicateType" value="conver" />
									覆盖&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="duplicateType" value="merge" checked />
									合并
								</td>
							</tr>
							<tr class=" lh40">
								<td align="right">重复数据标识列：</td>
								<td>
									<input type="checkbox" name="checkWay" value="mobile" checked />
									手机&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="checkWay" value="email" />
									邮箱&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
						</table>
						<div class="bg_c_white w50b margin0 mt20"
							style="height: 220px; overflow-y: auto;">
							<ul class="p10 lh30">
								<li><font color="red">导入信息:</font></li>
								<li>
									<div id="fileName"></div>
									<div id="fileSize"></div>
									<div id="fileType"></div>
								</li>
								<li><div id="importResult"></div></li>
								<li><div id="repeatData"></div></li>
								<li><div id="invalidFormatData"></div></li>
								<li><div id="databaseUpdateData"></div></li>
								<li><div id="databaseNew"></div></li>
							</ul>
						</div>
						<div class=" w50b margin0 mt20" style="height: 120px; overflow-y: auto;">
							<p class="mt40">
								模板：
								<a href="${ctx}/static/template/import/${templateLead}">${templateLead}</a>&nbsp;&nbsp;
								<a href="${ctx}/static/template/import/${templateCustomer}">${templateCustomer}</a>&nbsp;&nbsp;
								<a href="${ctx}/static/template/import/${templateContact}">${templateContact}</a>&nbsp;&nbsp;
								<a href="${ctx}/static/template/import/${templateSupplier}">${templateSupplier}</a>&nbsp;&nbsp;
							</p>
							<p style="color: red;">
								1.请先下载模板，并在此基础上进行修改。<br />
								2.管理员、启用、性别都是“是否”类型的数据。<br />
							</p>
						</div>
					</div>
					<div class="fl mt20 p10 divright"
						style="background: url(${ctx}/static/images/divrbg.png) no-repeat;	width: 445px;height: 494px; padding:40px; ">
						<div>
							<p class="lh25" style="color:#828181; font-size:16px;">导入事项：</p>
							<ul class="lh25 " style="color:#828181;">
								<li class="f14">
									1. 请严格参考模板文件。模板文件在导入页面的左下角。
								</li>
								<li class="f14">2. 导入功能支持的模块有：线索，客户，联系人，供应商。</li>
								<li class="f14">3. excel文件格式为.xlsx或.xls文件。</li>
								<li class="f14">4. 每次导入数据量不得超过10000条，文件大小不得超过5M。</li>
								<li class="f14">5. 导入数据时需要选择导入类型，重复记录，重复数据标识列。重复记录默认是合并，重复数据标识列默认是手机。</li>
								<li class="f14">6. 重复记录：您可以根据您的需求，选择遇到重复数据时，您希望如何处理。
								
								<li class="f14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;->跳过：保留原数据；</li>
								<li class="f14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;->覆盖：保留新数据；</li>
								<li class="f14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;->合并：将原数据和新数据合并，合并原则是以新数据为主，新数据值为空，则取原数据值。</li>
								<li class="f14">7. 重复数据标识列：如何判断您要导入的数据与数据库中已有数据重复。可选项是：按手机和按邮箱。默认按手机的方式。</li>
								<li class="f14">8. 导入完成以后，会给出导入信息提示。您可根据提示，重新导入失败的数据。</li>
							</ul>
						</div>
					</div>
					<div class="w240 margin0 cb h40 mt20">
						<c:if test="${VS_HAS_FUNCTIONS.userImport}">
							<a href="javascript:upload()" class="block c_white lh25 mr10 fl">
								<b class="allbtn_l block fl"></b> 
								<b class="allbtn_r pr13 block fl w_auto f14">导&nbsp;&nbsp;入</b> 
							</a>
							<a href="javascript:$('file').uploadify('cancel');" id="reset" class="block c_white lh25 mr10 fr">
								<b class="allbtn_l block fl"></b>
								<b class="allbtn_r pr13 block fl w_auto f14">重&nbsp;&nbsp;置</b> 
							</a>
						</c:if>
					</div>
				</div>
			</form>
		</div>
	</body>
</html>