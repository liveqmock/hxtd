<%--
    系统消息编辑
  Role: huizijing
  Date:2014/6/4
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>系统消息编辑</title>
	<link href="${ctx}/static/css/stressing/detail.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
	<script type="text/javascript"> 
		$(function(){
			$("#saveAndAdd").click(function(){
				var $form = $("#form");
				if($form.valid()){
					RcmsAjax.ajax($form.attr("action"),function(result){
						setTimeout(function(){
							window.location.replace("${ctx}/system/message/toAddPage.do")
						},500);
					},null,$form.formSerialize());
				}
				return false;
			});
			$("#save").click(function(){
				var $form = $("#form");
				if($form.valid()){
					RcmsAjax.ajax($form.attr("action"),function(result){
						//redirect
						var id = result.result.result;
						setTimeout(function(){
							window.location.replace("${ctx}/system/message/toQueryPage.do?type=send")
						},500);
					},null,$form.formSerialize());
				}
				return false;
			});
			
			$(".empty").click(function(){ // 清除
			$(this).prevAll("input").val('');
		});
		});
		
		//搜索弹出框
		function searchData(action){
			var url, title;
			if(action == "org"){
				url = "${ctx}/system/user/toQueryUser.comp";
				title = "组织";
			}
			jsUtil.dialogIframe(url, title, 400, 500, function(){//确定回调
				var userNames = $("#hide_usernames", window.frames["dialogIframe"].document).val();
				$("#txt_owner").val(userNames);
				var ids = $("#hide_userids", window.frames["dialogIframe"].document).val();
				$("#hide_owner_id").val(ids);
			});
		};
		
	</script> 
</head>
<body>
<form id="form" action="${ctx }${funcUrl}" method="POST">
	<div class="ml35 mr35 mt20 block cb cb">
			<b class="table_headl globle_img block fl"></b>
			<div class="fl table_headc fl w99b">
				<h1 class="f14 fbnone mt10 ml10 fl">系统消息编辑</h1>
			</div>
			<b class="table_headr globle_img block fl"></b>
			<div class="clear"></div>
	</div>
	<div class="ml35 mr35 bg_c_blue cb">
	<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
	<table class="cb id_table3 w95b bg_c_white margin0 mt10">      
    <tr>
	    <td align="right" width="15%"><span class="w_red">*&nbsp;</span>系统消息标题：</td>
	    <td align="left">
	    	<input type="text" class="text_input3 required" name="title" maxLength="20" value="${userMessage.message.title}"/>
	    </td>
    </tr>
    <tr>
		<td align="right" width="15%" ><span class="w_red">*&nbsp;</span>系统消息内容：</td>
		<td align="left" valign="top" width="85%">
			<textarea name="content" maxLength="500" class="remarks_input1 required" style="resize: none;">${userMessage.message.content}</textarea>
		</td>
    </tr>
    <tr>
	    <td align="right" width="15%"><span class="w_red">*&nbsp;</span>消息发至用户：</td>
	    <td align="left">
			<input readonly id="txt_owner" class="text_input3 required" type="text" />
			<input id="hide_owner_id" name="userId" type="hidden" />
			<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索所有者" onclick="searchData('org');"></i>
			<i class="dump_btn globle_img block_inline ml5 vm cp empty" title="清除"></i>
		</td>
    </tr>
    </table>
	<div class=" h40"></div>
	</div>
	<div class="cb block h40 margin0 mt10" style="width:350px;">
		<ul class="id_table1 cb">
		<li><a id="save" href="javascript:;" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">发&nbsp;&nbsp;送</b></a></li>
		<li><a id="saveAndAdd" href="javascript:;"class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">发送并新建</b></a></li>
		<li><a href="${ctx}/system/message/toQueryPage.do?type=send"class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">取&nbsp;&nbsp;消</b></a></li>
		</ul>
	<div class="clear"></div>
	</div>
</form>
</body>
</html>