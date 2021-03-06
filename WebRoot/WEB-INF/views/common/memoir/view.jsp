<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>联系人信息</title>
<link rel="stylesheet" href="${ctx}/static/css/public/common.css?v=1" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css?v=1" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css?v=1" type="text/css"/>
</head>
<body>
<div class="margin0">
    <div>
      <table class="id_tantable1 w pr10 pl10">
        <tr class="h50">
          <td align="right" valign="top" width="20%">联系纪要：</td>
          <td valign="top">${memoir.summary}</td>
        </tr>
        <tr class="h50">
          <td align="right" valign="top">下次联系时间：</td>
          <td valign="top">
          	<fmt:formatDate value="${memoir.nextContactTime}" pattern="yyyy-MM-dd" var="nextContactTime"/>${nextContactTime}
          </td>
        </tr>
        <tr class="h50">
          <td align="right" valign="top">下次联系要点：</td>
          <td valign="top">${memoir.nextContactPoints}</td>
        </tr>
        <tr class="h50">
          <td align="right" valign="top">备注：</td>
          <td valign="top">${memoir.remark}</td>
        </tr>
      </table>
    </div>
  </div>
</body>
</html>