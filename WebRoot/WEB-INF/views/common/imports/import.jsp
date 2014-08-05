<%--
  系统导入页
  User: xiaoli.luo
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
			.over{display: none;position: absolute;top: 0;left: 0;width: 100%;height: 100%;background-color: #f5f5f5;opacity:0.5;z-index: 1000;}
			.layout{display: none;position: absolute;top: 40%;left: 40%;width: 20%;height: 20%;z-index: 1001;text-align:center;}
		</style>
		
		
		
		<script type="text/javascript">
			var moduleId;
			var $att;
			buttonAdd = "${ctx}/static/images/tan_btn1.png";
			buttonNoneAdd = "${ctx}/static/images/tan_btn1none.png";
			$(function() {
				//将模板的四个div设置为不可见
				$("#leadTemplate").css("display","none");
				$("#customerTemplate").css("display","none");
				$("#contactTemplate").css("display","none");
				$("#supplierTemplate").css("display","none");
				$("#recyclebinTemplate").css("display","none");
				
				
				//设置模块默认值
				var module = "${moduleName}";
				if(module!="" && module!=null){
					$("#moduleName").css("display","none");
					if("${moduleName}" == "lead"){//导入线索
						$("#moduleInput").text("线索");
						$("#moduleName").attr("value","${moduleName}");
						$("#leadTemplate").show();
					}else if("${moduleName}" == "contact"){//导入联系人
						$("#moduleInput").text("联系人");
						$("#moduleName").attr("value","${moduleName}");
						$("#contactTemplate").css("display","block");
					}else if("${moduleName}" == "customer"){//导入客户
						$("#moduleInput").text("客户");
						$("#moduleName").attr("value","${moduleName}");
						$("#customerTemplate").css("display","block");
					}else if("${moduleName}" == "supplier"){//导入供应商
						$("#moduleInput").text("供应商");
						$("#moduleName").attr("value","${moduleName}");
						$("#supplierTemplate").css("display","block");
					}else if("${moduleName}" == "recyclebin"){//导入回收站
						$("#moduleInput").text("回收站");
						$("#moduleName").attr("value","${moduleName}");
						$("#recyclebinTemplate").css("display","block");
					}else{
						$("#moduleName").css("display","block");//从设置导入
						$("#leadTemplate").css("display","block");
						$("#customerTemplate").css("display","block");
						$("#contactTemplate").css("display","block");
						$("#supplierTemplate").css("display","block");
						$("#recyclebinTemplate").css("display","block");
					}
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
			
				var url = jsUtil.getRootPath() + "/" + module + "/imports/import.do";
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
					//'uploadLimit' : 1,//最多上传文件数量(每次刷新url只允许上传一次)
					'queueSizeLimit' : 1,// 允许同时上传的个数(每次上传的文件个数,最多是一个)
					'fileSizeLimit' : '5MB',//上传文件大小限制
					'removeTimeout' : 1,//上传完成后多久删除队列中的进度条
					'successTimeout' : 60*60,//表示文件上传完成后等待服务器相应的时间.超过改时间,那么将认为上传成功
	 				'multi' : false,//是否允许多文件上传
					'method' : "post",
					'swf' : jsUtil.getRootPath() + '/static/css/uploadify.swf',
					'uploader' : url+";jsessionid=${pageContext.session.id}",//url跳转后台处理的请求   //注:使用uploader插件上传文件时报http错误的时候,需要加上这句话
					'onFallback':function(){
						jsUtil.alert("您的flash版本不兼容，请尝试其他版本！");
					},
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
						//文件开始上传之前记录上传时间
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
						//文件上传完成记录时间
						//文件上传完成以后，将"浏览"按钮恢复颜色（注意：这个浏览按钮的id是自动生成的，通过页面查看元素就可得到）
			           	 $('#file-button').css({"background-image" : "url(" + buttonAdd + ")"});
			           	 $att.uploadify('disable', false);
			           	 //上传完成以后关闭蒙版
						hideLoading();
		            },	
					'onUploadSuccess' : function(file, data, response) {//在每一个文件上传成功后触发
						//data:从服务器返回回来
						//response:响应成功true,响应失败false
						if(response == true){
							var returnData = eval("(" + data + ")").message;
							if (returnData.indexOf(";") > 0) {
								var messages = returnData.split(";");
								if(messages.length==2){
									//导入失败提示信息
									$("#importResult").html(messages[0]);
									$("#repeatData").html(messages[1]);
								}else{
									//结束正常流程
									$("#importResult").html(messages[0]);
									$("#repeatData").html(messages[1]);
									$("#invalidFormatData").html(messages[2]);
									$("#databaseUpdateData").html(messages[3]);
									$("#databaseNew").html(messages[4]);
									$("#time").html("本次导入用时:"+messages[5]);
								}
							} else {
								$("#importResult").html(returnData);
							}
						}else{
							$("#importResult").html("文件解析异常,请重新导入!");
						}
						//上传完成以后关闭蒙版
						hideLoading();
					}
				});
				//点击上传按钮前校验是否有需要上传的文件
				$("#upload").click(function(){
					var num = $att.data('uploadify').queueData.queueLength;
					if(num>0){
						upload();
					}else{
						showMsg({successFlag:false,message:'上传队列中不存在文件，请检查！'});
						setTimeout(_hide(),RcmsAjax.global.showTime);
						hideLoading();
					}
				});
			});
			
			function upload() {
				//
				if (checkType()) {
					jsUtil.confirm("请确认您上传文件的类型正确。",function(){
						//添加蒙版
						showLoading();
						//文件上传期间，将"浏览"按钮置灰（注意：这个浏览按钮的id是自动生成的，通过页面查看元素就可得到）
						$att.uploadify('disable', true)
						$('#file-button').css( {
							"background-image" : "url(" + buttonNoneAdd + ")"
						});
						//上传队列中的所有的文件
						$att.uploadify('upload', '*');
						//将导入信息清空
						//$("#fileName").html("");
						//$("#fileSize").html("");
						//$("#fileType").html("");
						$("#importResult").html("");
						$("#repeatData").html("");
						$("#invalidFormatData").html("");
						$("#databaseUpdateData").html("");
						$("#databaseNew").html("");
					});
				}
			}
			
			//校验是否选择上传文件类型
			function checkType() {
				//模块内容不能为空校验
				var moduleName = $("#moduleName option:selected").val();
				//重复数据标识列不能为空校验
				var checkWayCheckbox = $("input[name=checkWay]:checked");
				if (moduleName == "") {
					showMsg({successFlag:false,message:'请选择一个模块名称！'});
					setTimeout(_hide(),RcmsAjax.global.showTime);
					$("#repeatData").text("请选择一个模块名称");
					hideLoading();
					return false;
				} else {
					if (checkWayCheckbox.length == 0) {
						showMsg({successFlag:false,message:'请至少选择一个重复数据标识列！'});
						setTimeout(_hide(),RcmsAjax.global.showTime);
						$("#repeatData").text("请至少选择一个重复数据标识列！");
						hideLoading();
						return false;
					}else {
						$("#repeatData").text("");
						return true;
					}
				}
			}
			
			function showLoading(){
				$('#over').show();
				$('#layout').show();
			}
			
			function hideLoading(){
				$('#over').hide();
				$('#layout').hide();
			}
			function stop(){
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
				<div class="ie_head" style="height:30px;">
					<h1 class="f14 fbnone mt10 ml10 fl">导入数据</h1>
				</div>
			</div>
			<form action="${ctx}/common/imports/import.do" method="POST" id="importForm" enctype="multipart/form-data">
				<div class="ml35 mr35 bg_c_blue cb">
					<div style="width: 50%;" class="fl">
						<table class="margin0 pt20 w85b" >
							<tr class=" lh40">
								<td width="20%" align="right" class="f12">模块：</td>
								<td>
									<select class="select2 f12" id="moduleName" name="moduleName">
										<option value="" checked>请选择</option>
										<!-- 添加权限校验 -->
										<c:if test="${VS_HAS_FUNCTIONS.leadAdd}">
											<option value="lead">线索</option>
										</c:if>
										<c:if test="${VS_HAS_FUNCTIONS.customerAdd}">
											<option value="customer">客户</option>
										</c:if>
										<c:if test="${VS_HAS_FUNCTIONS.contactAdd}">
											<option value="contact">联系人</option>
										</c:if>
										<c:if test="${VS_HAS_FUNCTIONS.supplierAdd}">
											<option value="supplier">供应商</option>
										</c:if>
										<c:if test="${VS_HAS_FUNCTIONS.recycleAdd}">
											<option value="recyclebin">回收站</option>
										</c:if>
									</select>
									
									<label class="f12" id="moduleInput"></label>
								</td>
							</tr>
							<tr class=" lh40">
								<td align="right" class="f12">选择文件：</td>
								<td>
									<div class="vm f12"><input type="file" id="file" name="file" size="28" /></div>
								</td>
							</tr>
							<tr class=" lh40">
								<td align="right" class="f12">重复记录：</td>
								<td  class="f12">
									<input type="radio" name="duplicateType" value="jump" />
									跳过&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="duplicateType" value="cover" />
									覆盖&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="duplicateType" value="merge" checked />
									合并
								</td>
							</tr>
							<tr class=" lh40">
								<td align="right" class="f12">重复数据标识列：</td>
								<td class="f12">
									<input type="checkbox" name="checkWay" value="mobile" checked />
									手机&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="checkWay" value="email" />
									邮箱&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
						</table>
						<div class="w240 margin0 cb h40">
							<c:if test="${VS_HAS_FUNCTIONS.userImport}">
								<a href="javascript:;" id="upload" class="block c_white lh25 mr10 fl">
									<b class="allbtn_l block fl" id="upload"></b> 
									<b class="allbtn_r pr13 block fl w_auto f14">导&nbsp;&nbsp;入</b> 
								</a>
								<%--<a href="javascript:$('file').uploadify('cancel');" id="reset" class="block c_white lh25 mr10 fr">
									<b class="allbtn_l block fl"></b>
									<b class="allbtn_r pr13 block fl w_auto f14">重&nbsp;&nbsp;置</b> 
								</a>
							--%></c:if>
						</div>
						<div class="bg_c_white w85b margin0 mt20"
							style="height: 274px; overflow-y: auto; margin-top:0px;">
							<ul class="p10 lh30">
								<li><font color="red"  class="f14">导入信息:</font></li>
								<li>
									<div class="f14" id="fileName"></div>
									<div class="f14" id="fileSize"></div>
									<div class="f14" id="fileType"></div>
								</li>
								<li><div class="f14" id="time"></div></li>
								<li><div class="f14" id="importResult"></div></li>
								<li><div id="repeatData"  class="w_red f14"></div></li>
								<li><div id="invalidFormatData"  class="w_red f14"></div></li>
								<li><div id="databaseUpdateData"  class="f14"></div></li>
								<li><div id="databaseNew" class="f14"></div></li>
							</ul>
						</div>
						
					</div>
					<div class="fl mt20 p10 divright"
						style="background: url(${ctx}/static/images/divrbg.png) no-repeat;	width: 465px;height: 460px; padding-left:35px; ">
						<div>
							<p class="lh25" style="color:#828181; font-size:14px;">导入事项：</p>
							<ul class=" " style="color:#828181;width:440px;">
								<li class="f12">
									1. <font style="color:red;">请严格参考模板文件。模板中各列顺序不可更改。</font>模板文件在"导入事项"底部。
								</li>
								<li class="f12">2. 导入功能支持的模块：线索，客户，联系人，供应商。</li>
								<li class="f12">3. excel文件格式为.xlsx或.xls文件。</li>
								<li class="f12">4. 每次导入数据量不得超过1000条，文件大小不得超过2M。</li>
								<li class="f12">5. 重复记录：您可以根据您的需求，选择遇到重复数据时，您希望如何处理。
								
								<li class="f12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;->跳过：保留原数据；</li>
								<li class="f12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;->覆盖：保留新数据；</li>
								<li class="f12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;->合并：将原数据和新数据合并，合并原则是以新数据为主，新数据值为空，则取原数据值。</li>
								<li class="f12">6. 重复数据标识列：如何判断您要导入的数据与数据库中已有数据重复。可选项是：按手机和按邮箱。默认按手机的方式。</li>
								
								<li class="f12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;->手机：以手机号判断数据是否重复；</li>
								<li class="f12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;->邮箱：以邮箱判断数据是否重复；</li>
								<li class="f12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;->手机和邮箱：以手机,邮箱同时满足的方式判断数据是否重复.</li>
								<li class="f12">7. 重复数据标识列：如何判断您要导入的数据与数据库中已有数据重复。可选项是：按手机和按邮箱。默认按手机的方式。</li>
								<li class="f12">8. 重复数据标识列：如何判断您要导入的数据与数据库中已有数据重复。可选项是：按手机和按邮箱。默认按手机的方式。</li>
								<li class="f12">9. 重复数据标识列：如何判断您要导入的数据与数据库中已有数据重复。可选项是：按手机和按邮箱。默认按手机的方式。</li>
								<li class="f12">10. 重复数据标识列：如何判断您要导入的数据与数据库中已有数据重复。可选项是：按手机和按邮箱。默认按手机的方式。</li>
							</ul>
						</div>
						<div class=" cb" style="height:60px; ">
							<p class="f14" style="font-weight:bold;">
								<p class="fl">模板：</p>
								<label id="leadTemplate" class="fl">
									<c:if test="${VS_HAS_FUNCTIONS.leadAdd}">
										<a href="${ctx}/static/template/import/${templateLead}">${templateLead}</a>&nbsp;&nbsp;
									</c:if>
								</label>
								<label id="customerTemplate" class="fl">
									<c:if test="${VS_HAS_FUNCTIONS.customerAdd}">
										<a href="${ctx}/static/template/import/${templateCustomer}">${templateCustomer}</a>&nbsp;&nbsp;
									</c:if>
								</label>
								<label id="contactTemplate" class="fl">
									<c:if test="${VS_HAS_FUNCTIONS.contactAdd}">
										<a href="${ctx}/static/template/import/${templateContact}">${templateContact}</a>&nbsp;&nbsp;
									</c:if>
								</label>
								<label id="supplierTemplate" class="fl">
									<c:if test="${VS_HAS_FUNCTIONS.supplierAdd}">
										<a href="${ctx}/static/template/import/${templateSupplier}">${templateSupplier}</a>&nbsp;&nbsp;
									</c:if>
								</label>
								<label id="recyclebinTemplate" class="fl">
									<c:if test="${VS_HAS_FUNCTIONS.recycleAdd}">
										<a href="${ctx}/static/template/import/${templateRecycleBin}">${templateRecycleBin}</a>&nbsp;&nbsp;
									</c:if>
								</label>
							</p>
							<p style="color: red;font-weight:bold;" class="f14 cb">
								1.请先下载模板，并在此基础上进行修改。<br />
								2.下载方式,单击右键,选择"目标另存为"即可保存文件。<br />
							</p>
						</div>
					</div>
					
					<div class="w240 margin0 cb h40 mt40">
					</div>
					<div>
						<ul>
							<li><div id="over" class="over"></div></li>
							<li><div id="layout" class="layout"><img src="${ctx}/static/images/loading.gif" /></div></li>
						</ul>
					</div>
					
				</div>
			</form>
		</div>
	</body>
</html>