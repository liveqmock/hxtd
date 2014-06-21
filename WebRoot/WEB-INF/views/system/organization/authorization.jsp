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
    <title>组织授权信息</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/detail.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>

    <script type="text/javascript" src="${ctx}/static/js/jquery.nested.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>

    <script type="text/javascript">
        $(function () {
            $("div.authorization").tabs();
            $(".role,.component").nested({minWidth: 20});
            jsUtil.bindSave()
        });
    </script>
</head>
<body>
<div>
    <div class="ml35 mr35 mt20 block cb cb">
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
    </div>

    <form name="authorization" action="${ctx}${VR_FUNCTION.url}" method="get">
        <input type="hidden" name="id" value="${param.id}">

        <div class="ml35 mr35 bg_c_blue cb">
            <div class="authorization">
                <ul>
                    <li><a href="#tabs-role">角色</a></li>
                </ul>
                <div id="tabs-role" class="role">
                    <c:forEach items="${allRoles}" var="item" varStatus="status">
                        <label class="box size81">
                            <input type="checkbox" name="roleId" value="${item.id}" ${fn:contains(authorizationRoles,item)?"checked":""}>${item.name}
                        </label>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="cb block h40 margin0 mt10" style="width:350px;">
            <ul class="id_table1 cb">

                <c:if test="${VS_HAS_FUNCTIONS.organizationAuthorization}">
                    <li><a href="javascript:void(0)" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;存</b></a></li>
                </c:if>
                <li><a href="${ctx}/system/organization/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取消</b></a></li>
            </ul>
        </div>
    </form>
</div>
</body>
</html>