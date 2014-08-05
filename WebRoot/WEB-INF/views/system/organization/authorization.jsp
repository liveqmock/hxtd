<%--
  组织授权页
  User: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>组织授权</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/empower.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
	<style type="text/css">
    	.id_ul4{ height: auto !important;}
    	.id_ul4 li{ float:left; width:16%; margin-top:5px; margin-bottom:5px;}
		.id_ul4 li a{ height:25px;line-height:25px; color:#222; text-align:center; padding-left:10px; padding-right:10px;}
		.id_ul4{ width:86.2%;}
    </style>
    <script type="text/javascript">
        $(function () {
            jsUtil.bindSave();
            
            //选中/反选
            var $menu1 = $("a.menu1");
            $C.toggleClass($menu1, "allright", "allnoright");
            $C.toggleBoolean($menu1, "checked");
            $C.bindCheckAll($menu1, "div.menu1", ".role:checkbox");
            $C.bindCheckAll($menu1, "div.menus1", "a.menu2", "click");
            $C.tab();
        });
    </script>
</head>
<body>

<form name="authorization" action="${ctx}${VR_FUNCTION.url}" method="get">
    <input type="hidden" name="id" value="${param.id}">
    <div class="margin0 ml35 mr35">
		<!-- 角色-->
         <div class="right_fbg bg_c_f3f3f3 ml35 mr35 brall5">
         <h1 class="f14 ml20 mt20 pt10">角色列表</h1>
            <div class="menus1">
                <div class="clearfix w menu1">
	                	<ul class="mb10 cb" style="overflow:hidden;">
		                    <c:forEach items="${allRoles}" var="item" varStatus="status">
		                        <li class="fl" style="width:16%;">
		                            <label class="box size81">
								        <input type="checkbox" name="roleId" value="${item.id}" class="role" 
								        ${fn:contains(authorizationRoles,item)?"checked=checked":""}>${item.name}
								    </label>
		                        </li>
		                    </c:forEach>
	                	</ul>
                </div>
            </div>
            <div class="pt10"></div>
		</div>
        <div class="h40"></div>
        <div class="cb block h40 margin0 mt10" style="width:350px;">
            <ul class="id_table1 cb">
                <c:if test="${VS_HAS_FUNCTIONS.roleAuthorization}">
                    <li><a href="javascript:void(0)" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;存</b></a></li>
                </c:if>
                <li><a href="${ctx}/system/organization/toQueryPage.do?index=${index}" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取消</b></a></li>
            </ul>
        </div>
    </div>
</form>
<div class="cb"></div>
</body>
</html>