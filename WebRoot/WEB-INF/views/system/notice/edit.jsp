<%--
     系统公告编辑
  Role: huizijing
  Date:2014/6/4
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
<title>系统公告编辑</title>
<link href="${ctx}/static/css/stressing/detail.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript"> 
    $(function(){
    	//加载时间控件
    	jsUtil.datepickerAll(".time");
    
		$("#saveAndAdd").click(function(){
			var $form = $("#form");
			if($form.valid()){
				RcmsAjax.ajax($form.attr("action"),function(result){
					setTimeout(function(){
						window.location.replace("${ctx}/system/notice/toAddPage.do")
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
						window.location.replace("${ctx}/system/notice/toViewPage.do?id="+id)
					},500);
				},null,$form.formSerialize());
			}
			return false;
		});
	
		function clearInputVal(obj){//清除
			$(obj).prevAll("input").val('');
		};
	});
</script> 
</head>
<body>
<div class="cb"></div>
<form id="form" action="${ctx}${funcUrl}" method="POST">
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
                <input type="hidden" name="id" value="${notice.id}" />
                <td align="right" width="15%"><span class="w_red">*&nbsp;</span>公告标题：</td>
                <td align="left"><input type="text" maxLength="20" class="text_input3 required" name="title" value="${notice.title}"/></td>
            </tr>
            <tr>
                <td align="right" width="15%" valign="top"><span class="w_red">*&nbsp;</span>公告内容：</td>
                <td align="left" width="85%" valign="top">
                 <textarea name="content" maxLength="500" class="remarks_input1 required" style="resize: none;">${notice.content}</textarea>
                </td>
           </tr>
           <tr>
                <td align="right" width="15%"><span class="w_red">*&nbsp;</span>发布时间：</td>
                <td align="left">
                <div class="pr vm"><a href="javascript:;" class="pa time_closenone1" ></a>
                <a href="javascript:;" class="pa time_closenone2 "></a>
                <input readyonly type="text" class="text_input3 input_close1 globle_img time required" name="sentTime" value="${sendTime}"/>
                </div>
                </td>
            </tr>
             <tr>
                <td align="right" width="15%"><span class="w_red">*&nbsp;</span>过期时间：</td>
                <td align="left">
                <div class="pr vm"><a href="javascript:;" class="pa time_closenone1" ></a>
                <a href="javascript:;" class="pa time_closenone2 "></a>
                <input readyonly type="text" class="text_input3 input_close1 globle_img time required" name="deadTime" value="${deadTime}"/>
                </div>
                </td>
            </tr>
        </table>
        <div class=" h40"></div>
     </div>
     <div class="cb block h40 margin0 mt10" style="width:350px;">
        <ul class="id_table1 cb">
		<li><a id="save" href="javascript:;" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">发&nbsp;&nbsp;布</b></a></li>
		<li><a id="saveAndAdd" href="javascript:;" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">发布并新建</b></a></li>
		<li><a href="${ctx}/system/notice/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">取&nbsp;&nbsp;消</b></a></li>
	    </ul>
	 </div>
</form>
</body>
</html>