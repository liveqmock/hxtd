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

<div class="ml35 mr35 mt10 block cb cb">
    <b class="b1"></b>
    <b class="b2"></b>
    <b class="b3"></b>
    <b class="b4"></b>

    <div class="ie_head">
        <h1 class="f14 fbnone mt10 ml10 fl">组织授权信息</h1>
        <c:if test="${VM_BUSINESS!=null}">
            <div class="message">${VM_BUSINESS}</div>
        </c:if>
    </div>

    <ul class="fl id_table3 w block cb mt10 tab-titles" style="border-bottom:5px solid #626262; height:32px;">
        <li class="tab-title id_table3li" fortab="#tabs-role">
            <b class="h_tabbtn_l w25 block fl"></b>
            <b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">角色</b>
        </li>
    </ul>
</div>


<form name="authorization" action="${ctx}${VR_FUNCTION.url}" method="get">
    <input type="hidden" name="id" value="${param.id}">

    <div class="margin0 ml35 mr35">
        <div class="w cb tab-panels">
			<div id="tabs-role" class="role w">
				<div class="menus1">
					<div class="clearfix bg_c_blue w menu1">
						<a href="javascript:void(0)" class="fl mt5 mb5 ml5 allright block menu menu1"></a>
						<ul class="id_ul4 fr mt10">
							<c:forEach items="${allRoles}" var="item" varStatus="status">
								<li class="fl" style="width:16%;">
								    <label class="box size81">
								        <input type="checkbox" name="roleId" value="${item.id}" class="role" ${fn:contains(authorizationRoles,item)?"checked":""}>${item.name}
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
                    <c:if test="${VS_HAS_FUNCTIONS.roleAuthorization}">
                        <li><a href="javascript:void(0)" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;存</b></a></li>
                    </c:if>
                    <li><a href="${ctx}/system/organization/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取消</b></a></li>
                </ul>
            </div>
        </div>
    </div>
</form>
<div class="cb"></div>
</body>
</html>