<%--
  用户明细页
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
    <title>用户授权</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/empower.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script type="text/javascript">
        $(function () {
            jsUtil.bindSave();

            //选中/反选
            var $menu2 = $("a.menu2");
            $C.toggleClass($menu2, "allright2", "allnoright2");
            $C.toggleBoolean($menu2, "checked");
            $C.bindCheckAll($menu2, "div.menu2", ".function:checkbox");

            var $menu1 = $("a.menu1");
            $C.toggleClass($menu1, "allright", "allnoright");
            $C.toggleBoolean($menu1, "checked");
            $C.bindCheckAll($menu1, "div.menu1", ".function:checkbox");
            $C.bindCheckAll($menu1, "div.menus1", "a.menu2", "click");

            $C.tab();
        });
    </script>
</head>
<body>

<div class="ml35 mr35 mt10 block cb cb">
    <b class="b1"></b>
    <b class="b2"></b>
    <b class="b3"></b>
    <b class="b4"></b>

    <div class="ie_head">
        <h1 class="f14 fbnone mt10 ml10 fl">用户授权信息</h1>
        <c:if test="${VM_BUSINESS!=null}">
            <div class="message">${VM_BUSINESS}</div>
        </c:if>
    </div>

    <ul class="fl id_table3 w block cb mt10 tab-titles" style="border-bottom:5px solid #626262; height:32px;" fortabpanels>
        <li class="tab-title" fortabpanel="#tabs-role">
            <b class="h_tabbtn_l w25 block fl"></b>
            <b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">角色</b>
        </li>
        <li class="tab-title" fortabpanel="#tabs-function">
            <b class="h_tabbtn_l w25 block fl"></b>
            <b class="h_tabbtn_r  pr25 w_auto f14 block fr lh32 cp id_nav pr">功能</b>
        </li>
        <li class="tab-title" fortabpanel="#tabs-component">
            <b class="h_tabbtn_l w25 block fl"></b>
            <b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">组件</b>
        </li>
    </ul>
</div>


<form name="user" action="${ctx}${VR_FUNCTION.url}" method="post">
    <input type="hidden" name="id" value="${param.id}">

    <div class="margin0 ml35 mr35">
        <div class="w cb tab-panels">
         <div id="tabs-role" class="tab-panel">
            <div class="menus1">
                <div class="clearfix bg_c_blue w menu1">
	                    <a href="javascript:void(0)" class="fl mt5 mb5 ml5 allright block menu menu1"></a>
	                	<ul class="id_ul4 fr mt10">
		                    <c:forEach items="${allRoles}" var="item" varStatus="status">
		                        <li class="fl" style="width:16%;">
		                            <label class="box size81 ${fn:contains(organizationInheritRoles,item)?" inherit-role":""}">
		                                <input type="checkbox" name="roleId" value="${item.id}" class="function" ${fn:contains(authorizationRoles,item)?"checked":""}/>${item.name}
		                            </label>
		                        </li>
		                    </c:forEach>
	                	</ul>
                </div>
            </div>
        </div>

            <div id="tabs-function" class="tab-panel">
                <c:forEach items="${allMenus}" var="item" varStatus="status">
                <c:choose>
                <c:when test="${item.level==1}">
                    <div class="menus1">
                    <div class="clearfix bg_c_blue w menu1">
                        <a href="javascript:void(0)" class="fl mt5 mb5 ml5 allright block menu menu1"></a>
                        <i class="vm block fl mt15 ml10">${item.name}</i>
                        <ul class="id_ul4 fr mt10 ">
                            <c:forEach items="${allFunctions[item.id]}" var="item">
                                <li>
                                    <label class="box size51 ${fn:contains(allAuthorizationFunctions,item)?" inherit-function":""}">
                                        <input type="checkbox" name="functionId" value="${item.id}" class="function" ${fn:contains(authorizationFunctions,item)?"checked":""}>${item.name}
                                    </label>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <c:if test="${status.last||allMenus[status.index+1].level==1}"></div></c:if>
                </c:when>
                <c:when test="${item.level==2}">
                <div class="clearfix w menu2">
                    <a href="javascript:void(0)" class="fl mt3 mb5 ml40 allright2 block menu menu2"></a>
                    <i class="vm block fl mt5 ml10 tr">${item.name}</i>
	                    <ul class="id_ul4 fr">
	                        <c:forEach items="${allFunctions[item.id]}" var="item">
	                            <li>
	                                <label class="box size51 ${fn:contains(allAuthorizationFunctions,item)?" inherit-function":""}">
	                                    <input type="checkbox" name="functionId" value="${item.id}" class="function" ${fn:contains(authorizationFunctions,item)?"checked":""}>${item.name}
	                                </label>
	                            </li>
	                        </c:forEach>
	                    </ul>
                </div>
                <c:if test="${status.last||allMenus[status.index+1].level==1}">
             </div>
            </c:if>
            </c:when>
            </c:choose>
            </c:forEach>
        </div>

        <div id="tabs-component" class="tab-panel">
        	<div class="menus1">
                <div class="clearfix bg_c_blue w menu1">
	                <a href="javascript:void(0)" class="fl mt5 mb5 ml5 allright block menu menu1"></a>
            			<ul class="id_ul4 fr">
            			<c:forEach items="${allComponents}" var="item" varStatus="status">
			                <li style="width:16%" class="fl">
			                    <label class="box size51 ${fn:contains(allAuthorizationComponents,item)?" inherit-component":""}">
			                        <input type="checkbox" name="componentId" value="${item.id}" class="function" ${fn:contains(authorizationComponents,item)?"checked":""}>${item.name}
			                    </label>
			                </li>
            			</c:forEach>
            			</ul>
               </div>
            </div>
        </div>

        <div class="h40"></div>
        <div class="cb block h40 margin0 mt10" style="width:350px;">
            <ul class="id_table1 cb">
                <c:if test="${VS_HAS_FUNCTIONS.userAuthorization}">
                    <li><a href="javascript:void(0)" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b></a></li>
                </c:if>
                <li><a href="javascript:history.back(-1);" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取消</b></a></li>
            </ul>
        </div>
    </div>
    </div>
</form>
<div class="cb"></div>

</body>
</html>