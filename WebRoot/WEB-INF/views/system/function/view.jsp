<%--
  功能描述：功能详情
  User: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>功能详情</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
<link rel="stylesheet" type="text/css" href="styles.css">
-->
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
</head>
<body>
<div><!--请在此处使用iframe--->
    <div class="cb"></div>
    <!--列表开始-->
    <div class="ml35 mr35 mt20 block cb cb">
       <b class="b1"></b>
       <b class="b2"></b>
       <b class="b3"></b>
       <b class="b4"></b>
        <div class="ie_head" >
            <h1 class="f14 fbnone mt10 ml10 fl">功能详情信息</h1>
            <ul class="fr id_table1 mt10 ml10">
            <li><a class=" pl35 c_white f14 lh25 cp block fr" href="${ctx }/system/function/toModifyPage.do?id=${func.id}"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b></a></li>
            <li><a class=" pl10 c_white f14 lh25 cp block fr mr10" href="${ctx }/system/function/toQueryPage.do"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b></a></li>
           	</ul>
        </div>    
    </div> 
    <div class="ml35 mr35 bg_c_blue cb">
        <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%">功能名：</td>
                <td align="left">${func.name }</td>
                <td align="right" width="15%">功能编号：</td>
                <td align="left">${func.code }</td>
            </tr>
            <tr>
                <td align="right">调用入口：</td>
                <td align="left">${func.url }</td>
                <td align="right">归属菜单：</td>
                <td align="left">${func.menu.name }</td>
            </tr> 
            <tr>
                <td align="right">权限级别：</td>
                <td align="left">${func.privilegeLevel.key }</td>
            </tr>
        </table>
        <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
        <table class="cb id_table4 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%" valign="top">备注：</td>
                <td align="left" width="85%" valign="top">
                <div class="w85b"> ${func.remark }</div>
                </td>

            </tr>

        </table>
        <div class=" h40"></div>
    </div>
    <div class="cb block h40 margin0 mt10" style="width:350px;">
        <ul class="id_table1 cb">
        </ul>
    </div>
</div>
</body>
</html>
