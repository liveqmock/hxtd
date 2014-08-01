<%--
  组织明细页
  User: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>组织详情</title>
    <link href="${ctx}/static/css/recommend/list1.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div>
    <div class="cb"></div>
    <div class="ml35 mr35 mt20 block cb cb">
        <b class="table_headl globle_img block fl"></b>

        <div class="fl table_headc fl w99b">
            <h1 class="f14 fbnone mt10 ml10 fl">组织详细信息</h1>
            <ul class="fr id_table1 mt10 ml10">
                <c:if test="${VS_HAS_FUNCTIONS.organizationModify}">
                    <li><a href="${ctx }/system/organization/toModifyPage.do?id=${organization.id}&index=_1" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b></a></li>
                </c:if>
                <li><a href="${ctx}/system/organization/toQueryPage.do?index=_1" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b></a></li>
            </ul>
        </div>
        <b class="table_headr globle_img block fl"></b>
    </div>

    <div class="ml35 mr35 bg_c_blue cb">
        <input type="hidden" name="id" value="${organization.id}"/>

        <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%">名称：</td>
                <td align="left">${organization.name}</td>
                <td align="right" width="15%">全名：</td>
                <td align="left">${organization.fullName}</td>
            </tr>
            <tr>
                <td align="right" width="15%">类型：</td>
                <td align="left">${organization.type.key}</td>
                <td align="right" width="15%">上级组织：</td>
                <td align="left">${organization.parent.name}</td>
            </tr>
            <tr>
                <td align="right" width="15%">电话：</td>
                <td align="left">${organization.phone}</td>
                <td align="right" width="15%">邮箱：</td>
                <td align="left">${organization.email}</td>
            </tr>
            <tr>
                <td align="right" width="15%">地址：</td>
                <td align="left">${organization.address}</td>
                <td align="right" width="15%">邮政编码：</td>
                <td align="left">${organization.zipCode}</td>
            </tr>
            <tr>
                <td align="right" width="15%">网址：</td>
                <td align="left">${organization.webSite}</td>
                <td align="right" width="15%"></td>
                <td align="left"></td>
            </tr>
        </table>
        <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
        <table class="cb id_table6 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%" valign="top">备注：</td>
                <td align="left" width="85%" valign="top">
                    <div class="w85b">${organization.remark}</div>
                </td>
            </tr>
        </table>
        <div class=" h40"></div>
    </div>
</div>
</body>
</html>