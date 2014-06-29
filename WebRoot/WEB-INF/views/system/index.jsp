<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>设置</title>
    <link href="${ctx}/static/css/stressing/system.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div style="min-height:750px;">
    <div class="cb"></div>
    <table class="id_table1">
        <c:set var="newlineColumnCount" value="${3}"/>
        <c:set var="columnCount" value="${0}"/>
        <tr>
            <c:forEach items="${VS_SETPAGE_MENUS}" var="menu" varStatus="status">
            <c:set var="closeMenu" value="${status.last||VS_SETPAGE_MENUS[status.index+1].level==1}"/>
            <c:set var="isNewline" value="${columnCount%newlineColumnCount==0}"/>

            <c:choose>
            <c:when test="${menu.level==1}">
            <td>
                <div class="module">
                    <div class="fl ml20">
                        <h1 class="c_orange f24 fbnone">${menu.name}</h1>
                        <c:if test="${!closeMenu}">
                        <dl class="w240 id_dl1">
                            </c:if>
                            <c:set var="columnCount" value="${columnCount+1}"/>

                            </c:when>

                            <c:when test="${menu.level==2}">
                                <dd><a href="${ctx}${menu.url}">${menu.name}</a></dd>
                                <c:if test="${!closeMenu}">
                                    <dd>|</dd>
                                </c:if>

                            </c:when>
                            </c:choose>

                            <c:if test="${closeMenu}">
                        </dl>
                    </div>
                    <div class="fr mr20  setting-icon${fn:substring(menu.code,0,2)} globle_img"></div>
                </div>
            </td>
            <c:if test="${isNewline}">
        </tr>
        <tr>
            </c:if>
            </c:if>

            </c:forEach>
        </tr>
    </table>

</div>
</body>
</html>
