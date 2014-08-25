<%--
     查看系统消息明细页
  Role: huizijing
  Date:2014/6/4
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>系统消息详细信息</title>
<link href="${ctx}/static/css/stressing/list1.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="cb"></div>
    <div class="ml35 mr35 mt20 block cb cb">
    <b class="table_headl globle_img block fl"></b>
    <div class="fl table_headc fl w99b">
	<h1 class="f14 fbnone mt10 ml10 fl">系统消息查看</h1>
        <ul class="fr id_table1 mt10 ml10">
        <c:choose>
        <c:when test="${userMessage.type}">
           <li>
           <c:if test="${VS_HAS_FUNCTIONS.messageModify}">
           <a href="${ctx }/system/message/toViewPage.do?id=${param.id}&type=add" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">再次发送</b></a>
           </c:if>
           </li>
           <li><a href="${ctx }/system/message/toQueryPage.do?type=send" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">返&nbsp;&nbsp;回</b></a></li>
        </c:when>
        <c:otherwise>
            <li><c:if test="${VS_HAS_FUNCTIONS.messageModify}">
            <a href="${ctx }/system/message/toViewPage.do?id=${param.id}&type=edit" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">回&nbsp;&nbsp;复</b></a></c:if></li>
            <li>
            <a href="${ctx }/system/message/toQueryPage.do?type=reviced" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">返&nbsp;&nbsp;回</b></a></li>
        </c:otherwise>
        </c:choose>
        </ul>
    </div>  
	<b class="table_headr globle_img block fl"></b>
 </div>
   <div class="ml35 mr35 bg_c_blue cb">
   		<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10">
        <tr>
            <td align="right" width="15%">系统消息名称：</td>
            <td align="left">${userMessage.message.title}</td>
        </tr>
        <tr>
            <td align="right" width="15%" valign="top">系统消息内容：</td>
            <td align="left" width="85%" valign="top">
            <div class="w85b">
            <pre> ${userMessage.message.content }</pre>
            </div>
            </td>
        </tr>
        <tr>
            <td align="right" width="15%">发送者：</td>
            <td align="left">
            <c:choose>
            <c:when test="${userMessage.message.creator.id==null}">系统发送</c:when>
            <c:otherwise>${userMessage.message.creator.realName}</c:otherwise>
            </c:choose>
            </td>
        </tr>
        <tr>
        <td align="right" width="15%">发送时间：</td>
            <td align="left">
            <fmt:formatDate value="${userMessage.createdTime }" pattern="yyyy-MM-dd hh:mm:ss" var="createdTime"/>${createdTime }
            </td>
        </tr>
    </table>
	<div class=" h40"></div>
   </div>
</body>
</html>