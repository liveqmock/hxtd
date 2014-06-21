<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>项目列表组件页</title>
<link rel="stylesheet" href="${ctx}/static/css/css.css" type="text/css"></link>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/static/js/commonAjax.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript">
$(function(){
	new Grid().init().bindAuthorization();
});
</script>
</head>
<body>
<div class="listcontainer">
<form action="${ctx}/project/project/query.do" onsubmit="return false;">
    <div class="search" style="margin: 0px">
        <dl class="menu3">
            <dd>
                <ul>
                    <li class="w100">项目名称：</li>
                    <li class="liw"><input type="text" name="search_LIKE_name" value="${name}"/></li>
                    <div class="clear"></div>
                </ul>
                <div class="clear"></div>
                <div class="sea_btn" style="float: right;">
                    <a href="javascript:void(0)" class="fl chaxun submit">查询</a>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
            </dd>
        </dl>
    </div>
</form>
<div class="content" style="margin:20px 0px; border:none; height: 290px; overflow: hidden; overflow-y:auto; background: #fff">
	<table cellspacing="0" class="tablesorter">
		<thead>
			<tr>
				<td></td>
				<td>项目名</td>
				<td>项目编号</td>
				<td>供应商</td>
				<td>融资额度</td>
				<td>创建时间 </td>
				<td>创建者</td>
			</tr>
		</thead>
		<tbody class="list"></tbody>
	</table>
	<div class="pagination"></div>
	<textarea id="template-tbody" class="template template-tbody">
		{#foreach $T.result as row}
		<tr class="row">
			<td><input name="ck" type="radio" value="{$T.row.id}"/></td>
			<td>{$T.row.name}</td>
			<td>{$T.row.code}</td>
			<td>{$T.row.supplier.name}</td>
			<td>{$T.row.financeLimit}</td>
			<td>{$T.row.createdTime}</td>
			<td>{$T.row.creator.name}</td>
		</tr>
	    {#/for} 
	</textarea>
	<%@include file="/WEB-INF/template/sort.jsp" %>
	<%@include file="/WEB-INF/template/pagination.jsp" %>
</div>
</div>
</body>
</html>