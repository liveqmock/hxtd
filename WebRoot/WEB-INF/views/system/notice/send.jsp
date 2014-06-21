<%--
  公告明细页
  Role: huizijing
  Date:2014/6/4
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>公告详细信息</title>
    <link rel="stylesheet" href="${ctx}/static/css/css.css" type="text/css"></link>
    <link href="${ctx}/static/css/stressing/detail_a.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
    <script>$(function () {jsUtil.bindSave();});</script>
    
<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
<script type="text/javascript"> 
$(function(){//初始化 
	$("#form").validate({
		rules: {
			name: { required: true }
		},
		messages: {
			name: { required: "*请输入用户名"}
		}
	});
	$(".add").click(function(){
		if($("#form").valid()){
			form.action = form.action + "?redirectUri=" + encodeURI($(this).attr("redirecturi"));
			form.submit();
		}
		return false;
	});
});

function clearInputVal(obj){//清除
	$(obj).prevAll("input").val('');
}
        </script> 
</head>
<body>
<form name="form" action="${ctx }${funcUrl}" method="POST">
    <div class="content">
        <div class="ct_title">
            <span class="fl ttname">公告详细信息</span>

            <div class="clear"></div>
        </div>
        <div class="baocun">
            <c:if test="${VM_ALL!=null}">
                <div class="message">${VM_ALL}</div>
            </c:if>

            <div class="clear"></div>
        </div>
        
        <div>
        <table style="width:100%;" class="table140421">
            <tr style="display:none;">
                <td width="30%"></td>
                <td width="20%"></td>
                <td width="30%"></td>
                <td width="20%"></td>
            </tr>
            <tr>
                <td colspan="2" class="pl20 color6 fwb bdn">基本信息：</td>
                <input type="hidden" name="id" value="${notice.id}"/>
            </tr>

            <tr>
                <td >公告标题：</td>
                <td ><input type="text" class="{required:true,messages:{required:'（*必填）'}}" name="title" value="${notice.title}"/></td>
                
            </tr>
            <tr>
            <td >公告内容：</td>
                <td >
                    
                    <textarea name="content" style="width:90%;height:300px;border:1px solid #e0e0e0; margin:5px 0px">${notice.content }</textarea>
                   
               </td>
           </tr>
           <tr>
           <td>组织机构</td>
           <td><select>
           <option>华兴控股</option>
           <option>董事会</option>
           <option>三级委员会</option>
           <option>技术管理中心</option>
           <option>企划营销中心</option>
           <option>技术管理中心</option>
           </select></td>
           </tr>
        </table>
        </div>
        <div class="baocun mb40">
		<a href="javascript:form.submit()">立即发送</a>
		<a href="javascript:history.back(-1)">取消</a>
		<div class="clear"></div>
	    </div>
    </div>
</form>
</body>
</html>