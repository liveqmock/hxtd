<%--
  角色明细页
  Role: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>角色详细信息</title>
    <link href="${ctx}/static/css/recommend/detail.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div>
    <div class="cb"></div>
    <div class="ml35 mr35 mt20 block cb cb">
        <b class="table_headl globle_img block fl"></b>

        <div class="fl table_headc fl w99b">
            <h1 class="f14 fbnone mt10 ml10 fl">角色详细信息</h1>
            <ul class="fr id_table1 mt10 ml10">
                <c:if test="${VS_HAS_FUNCTIONS.roleModify}">
                    <li><a href="${ctx}/system/role/toModifyPage.do?id=${param.id}" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;辑</b></a></li>
                </c:if>
                <li><a href="${ctx}/system/role/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">返&nbsp;回</b></a></li>
            </ul>
        </div>

        <b class="table_headr globle_img block fl"></b>
    </div>

    <div class="ml35 mr35 bg_c_blue cb">
        <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%">角色名：</td>
                <td align="left">${role.name}</td>
                <td align="right" width="15%">类型：</td>
                <td align="left">${role.type.key}</td>
            </tr>
        </table>
        <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
        <table class="cb id_table4 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%" valign="top">备注：</td>
                <td align="left" width="85%" valign="top">
                    <div class="w85b">${role.remark}</div>
                </td>
            </tr>
        </table>
        <div class=" h40"></div>
    </div>
</div>
</body>
</html>