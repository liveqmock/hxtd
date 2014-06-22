<%--
  系统消息明细页
  Role: huizijing
  Date:2014/6/4
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<link href="${ctx}/static/css/stressing/detail.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
<script type="text/javascript"> 
$(function(){
	$("#save").click(function(){
		if($("#form").valid()){
			$("#form").submit();
		}
	});
	$("#saveAndAdd").click(function(){
		$("#form").attr("action",$("#form").attr("action")+"?type=add");
		if($("#form").valid()){
			$("#form").submit();
		}
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
}

function clearInputVal(obj){//清除
	$(obj).prevAll("input").val('');
}
        </script> 
</head>
<body>
<form id="form" action="${ctx }${funcUrl}" method="POST">
<div >
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
                <input type="text" class="text_input3 required" name="title" value="${userMessage.message.title}"/></td>
            </tr>
            <tr>
            <td align="right" width="15%" ><span class="w_red">*&nbsp;</span>系统消息内容：</td>
                <td align="left">
                    
                    <textarea name="content" class="required" style="width:90%;height:300px;border:1px solid #e0e0e0; margin:5px 0px">${userMessage.message.content}</textarea>
                   
               </td>
           </tr>
           <tr>
            <td align="right" width="15%"><span class="w_red">*&nbsp;</span>消息发至用户：</td>
                <td align="left">
				<input id="txt_owner" class="text_input3 required"type="text" "/>
				<input id="hide_owner_id" name="userId" type="hidden" />
				<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索所有者" onclick="searchData('org');"></i>
				<i class="dump_btn globle_img block_inline ml5 vm cp" title="清除" onclick="clearInputVal(this);"></i>
				</td>
           </tr>
        </table>
		<div class=" h40"></div>
       </div>
        <div class="cb block h40 margin0 mt10" style="width:350px;">
		<ul class="id_table1 cb">
		<li><a id="save" href="javascript:;" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">发&nbsp;&nbsp;送</b></a></li>
		<li><a id="saveAndAdd" href="javascript:;"class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">发送并新建</b></a></li>
		<li><a href="javascript:history.back(-1)"class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">取&nbsp;&nbsp;消</b></a></li>
		</ul>
		<div class="clear"></div>
	    </div>
   
  </div>
</form>
</body>
</html>