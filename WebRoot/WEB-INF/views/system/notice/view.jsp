<%--
    查看公告详情页
  Role: huizijing
  Date:2014/6/4
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>公告详情</title>
    <link href="${ctx}/static/css/stressing/detail.css" rel="stylesheet" type="text/css" />
</head>
<body>
   <div class="cb"></div>
   <div class="ml35 mr35 mt20 block cb cb">
    <b class="table_headl globle_img block fl"></b>
    <div class="fl table_headc fl w99b">
	<h1 class="f14 fbnone mt10 ml10 fl">公告详细信息</h1>
    <ul class="fr id_table1 mt10 ml10">
    	<li><c:if test="${VS_HAS_FUNCTIONS.noticeModify}"><a href="${ctx }/system/notice/toViewPage.do?id=${param.id}&type=edit" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">编&nbsp;&nbsp;辑</b></a></c:if></li>
    	<li><a href="${ctx }/system/notice/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 deletesome">返&nbsp;&nbsp;回</b></a></li>
    </ul>
	</div>
        <b class="table_headr globle_img block fl"></b>
   </div>
    
<div class="ml35 mr35 bg_c_blue cb">
<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
<table class="cb id_table3 w95b bg_c_white margin0 mt10">
        <tr>
            <td align="right" width="15%">公告名称：</td>
            <td align="left">${notice.title}</td>
        </tr>
        <tr>
            <td align="right" width="15%" valign="top">公告内容：</td>
            <td align="left"  width="85%" valign="top">
            <div class="w85b">
             ${notice.content }
            </div>
            </td>
        </tr>
        <tr>
            <td align="right" width="15%">发送时间：</td>
            <td align="left">${notice.sentTime}</td>
        </tr>
         <tr>
           <td align="right" width="15%">过期时间：</td>
            <td align="left">${notice.deadTime}</td>
        </tr>
    </table>
    <div class=" h40"></div>
</div>
</body>
</html>