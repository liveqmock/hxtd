<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>设置订单审批</title>
<link href="${ctx}/static/css/recommend/detail.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div>
<form id="form" action="${ctx}${VR_FUNCTION.url}" method="post">
  <div class="margin0">
    <div>
      <table class="id_tantable1 w pr10 pl10">
      	<tr>
          <td align="right"><i class="mt3 block">审批级别：</i></td>
          <td><select></select></td>
        </tr>
        <tr>
          <td align="right"><i class="mt3 block">审批名称：</i></td>
          <td></td>
        </tr>
        <tr>
          <td align="right"><i class="mt3 block">此级审批人：</i></td>
          <td></td>
        </tr>
      </table>
    </div>
  </div>
</form>
</div>
</body>
</html>