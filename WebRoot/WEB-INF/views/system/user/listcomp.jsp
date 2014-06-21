<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>用户列表页</title>
<link rel="stylesheet" href="${ctx}/static/css/css.css" type="text/css"></link>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.tmpl.js"></script>
<script type="text/javascript">
$(function(){
	$(".list").empty();
	$("#userTemplates").tmpl(${jsondata}.result.result).appendTo('#lst');
	$(".list tr").live({
		click: function(){
			var $ck = $(this).find(":radio"), ck = $ck.get(0);
			$ck.attr("checked", !ck.checked);
		},
		dblclick: function(){
			$(this).find(":radio").attr("checked", true);//防止click影响
			$(".ui-button", parent.document).eq(1).trigger("click");
		}
	});
	$(".list :radio").live("click", function(e){
		e.stopPropagation();//jquery 阻止冒泡事件
	});
});
</script>
</head>
<body>
<form name="user" action="${ctx}/system/user/query.do" onsubmit="return false;">
    <div class="search" style="margin: 0px">
        <dl class="menu3">
            <dd>
                <ul>
                    <li class="w100">用户名称：</li>
                    <li class="liw"><input type="text" name="search_LIKE_name" value="${name}"/></li>
                    <div class="clear"></div>
                </ul>
                <div class="clear"></div>
                <div class="sea_btn" style="float: right;">
                    <a href="javascript:void(0)" class="fl chaxun submit">查询</a>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
            </dd>
        </dl>
    </div>
</form>
   <table cellspacing="0" class="tablesorter">
       <tr>
           <td width="10%"></td>
           <td width="25%">真实姓名</td>
           <td width="25%">用户名</td>
           <td width="20%">性别</td>
           <td width="20%">激活</td>
       </tr>
   </table>
   <div style="height: 270px; overflow: hidden; overflow-y:auto; background: #fff">
   <table cellspacing="0" class="tablesorter">
        <!-- 列表模板 -->
        <script id="userTemplates" type="text/x-jquery-tmpl">
			<tr>
        		<td width="10%"><input name="ck" type="radio" value="${'${'}id}"/></td>
        		<td width="25%">${'${'}realName}</td>
				<td width="25%">${'${'}name}</td>
        		<td width="20%">${'${'}sex.key}</td>
        		<td width="20%">${'${'}isActive?"是":"否"}</td>
    		</tr>
    	</script>
        <tbody id="lst" class="list"></tbody>
   </table>
   </div>
</body>
</html>