<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <c:set var="closeMenu" value="${status.last||VS_SETPAGE_MENUS[status.index].level==1}"/>
            <c:choose>
            <c:when test="${menu.level==1}">
            <td>
                <div class="module">
                    <div class="fl ml20">
                        <h1 class="c_orange f24 fbnone">${menu.name}</h1>
                            <%--<c:if test="${status.last||VS_SETPAGE_MENUS[status.index].level==1}">--%>
                    </div>
                    <div class="fr mr20 Personal_settings globle_img"></div>
                </div>
            </td>
                <%--</c:if>--%>

            <c:set var="columnCount" value="${columnCount+1}"/>
            <c:if test="${columnCount%newlineColumnCount==0}">
        </tr>
        <tr>
            </c:if>
            </c:when>

            <c:when test="${menu.level==2}">

            </c:when>
            </c:choose>


            </c:forEach>
        </tr>
    </table>
    <%--<table class="id_table1">
        <tr>
            <td>
                <div class="module">
                    <div class="fl ml20">
                        <h1 class="c_orange f24 fbnone">个人设置</h1>
                        <dl class="w240 id_dl1">
                            <dd><a href="javascript:;">帐号信息</a></dd>
                            <dd>|</dd>
                            <dd><a href="javascript:;">更改密码</a></dd>
                            <dd>|</dd>
                            <dd><a href="javascript:;">自定义工作台</a></dd>
                            <dd>|</dd>
                            <dd><a href="javascript:;">审计日志</a></dd>
                            <dd>|</dd>
                            <dd><a href="javascript:;">系统消息</a></dd>
                            <dd>|</dd>
                            <dd><a href="javascript:;">系统公告</a></dd>
                            <dd>|</dd>
                            <dd><a href="javascript:;">系统操作手册</a></dd>
                        </dl>
                    </div>
                    <div class="fr mr20 Personal_settings globle_img"></div>
                </div>
            </td>
            <td>
                <div class="module">
                    <div class="fl ml20">
                        <h1 class="c_orange f24 fbnone">用户及权限</h1>
                        <dl class="w240 id_dl1">
                            <dd><a href="javascript:;">用户</a></dd>
                            <dd>|</dd>
                            <dd><a href="javascript:;">角色</a></dd>
                            <dd>|</dd>
                            <dd><a href="javascript:;">菜单</a></dd>
                            <dd>|</dd>
                            <dd><a href="javascript:;">功能</a></dd>
                            <dd>|</dd>
                            <dd><a href="javascript:;">组件</a></dd>
                            <dd>|</dd>
                            <dd><a href="javascript:;">权限设置</a></dd>
                        </dl>
                    </div>
                    <div class="fr mr20 Personal_power globle_img"></div>
                </div>
            </td>
            <td>
                <div class="module">
                    <div class="fl ml20">
                        <h1 class="c_orange f24 fbnone">机构设置</h1>
                        <dl class="w240 id_dl1">
                            <dd><a href="javascript;">组织机构</a></dd>
                        </dl>
                    </div>
                    <div class="fr mr20 institution_settings globle_img"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="module">
                    <div class="fl ml20">
                        <h1 class="c_orange f24 fbnone">数据管理</h1>
                        <dl class="w240 id_dl1">
                            <dd><a href="javascript:;">字典维护</a></dd>
                            <dd>|</dd>
                            <dd><a href="javascript:;">导出数据</a></dd>
                            <dd>|</dd>
                            <dd><a href="${ctx}/system/recyclebin/toQueryPage.do">回收站</a></dd>
                        </dl>
                    </div>
                    <div class="fr mr20 data_manage globle_img"></div>
                </div>
            </td>
            <td>
                <div class="module">
                    <div class="fl ml20">
                        <h1 class="c_orange f24 fbnone">开发者空间</h1>
                        <dl class="w240 id_dl1">
                            <dd><a href="javascript:;">CRM API</a></dd>
                        </dl>
                    </div>
                    <div class="fr mr20 develop_space globle_img"></div>
                </div>
            </td>
            <!--<td>
                <div class="module">
                 <div class="fl ml20">
                   <h1 class="c_orange f24 fbnone">模板</h1>
                   <dl class="w240 id_dl1">
                     <dd><a href="javascript;">账号指南</a></dd>
                     <dd>|</dd>
                     <dd><a href="javascript;">姓名格式</a></dd>
                     <dd>|</dd>
                     <dd><a href="javascript;">主题</a></dd>
                     <dd>|</dd>
                     <dd><a href="javascript;">审计日志</a></dd>
                   </dl>
                 </div>
                 <div class="fr mr20 templet globle_img"></div>
               </div>
             </td>
           --></tr>
    </table>--%>
</div>
</body>
</html>
