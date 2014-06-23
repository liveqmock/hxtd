<%--
     公告明编辑、增加
  Role: huizijing
  Date:2014/6/4
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
<title>公告编辑</title>
<link href="${ctx}/static/css/stressing/detail.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
<script type="text/javascript"> 
	$(function(){//初始化 
    	//加载时间控件
    	 jsUtil.datepickerNotNow(".time");
    	 //验证
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
	});

	function clearInputVal(obj){//清除
		$(obj).prevAll("input").val('');
	}
</script> 
</head>
<body>
<div class="cb"></div>
<form id="form" action="${ctx }${funcUrl}" method="POST">
   <div class="ml35 mr35 mt20 block cb cb">
        <b class="table_headl globle_img block fl"></b>
        <div class="fl table_headc fl w99b">
        <h1 class="f14 fbnone mt10 ml10 fl">公告详细信息</h1>
        </div>
        <b class="table_headr globle_img block fl"></b>
    </div>
    <div class="ml35 mr35 bg_c_blue cb">
      <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%"><span class="w_red">*&nbsp;</span>公告标题：</td>
                <td align="left"><input type="text" class="text_input3 required" name="title" value="${notice.title}"/></td>
            </tr>
            <tr>
            <td align="right" width="15%"><span class="w_red">*&nbsp;</span>公告内容：</td>
            <td align="left">
                 <textarea name="content" class="required" style="width:90%;height:300px;border:1px solid #e0e0e0; margin:5px 0px">${notice.content }</textarea>
            </td>
           </tr>
           <tr>
                <td align="right" width="15%"><span class="w_red">*&nbsp;</span>发布时间：</td>
                <td align="left"><input readonly type="text" class="time required" name="sentTime" value="${sendTime}"/></td>
            </tr>
             <tr>
                <td align="right" width="15%"><span class="w_red">*&nbsp;</span>过期时间：</td>
                <td align="left"><input readonly type="text" class="time required" name="deadTime" value="${deadTime}"/></td>
            </tr>
        </table>
        <div class=" h40"></div>
     </div>
     <div class="cb block h40 margin0 mt10" style="width:350px;">
        <ul class="id_table1 cb">
		<li><a id="save"href="javascript:;"class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">发&nbsp;&nbsp;布</b></a></li>
		<li><a id="saveAndAdd"href="javascript:;"class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 deletesome">发布并新建</b></a></li>
		<li><a href="${ctx}/system/notice/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 deletesome">取&nbsp;&nbsp;消</b></a></li>
	    </ul>
	 </div>
</form>
</body>
</html>