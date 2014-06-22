<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>项目列表组件页</title>
<link rel="stylesheet" href="${ctx}/static/css/public/common.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
<link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.js"></script>
<script type="text/javascript" src="${ctx}/static/js/commonAjax.js"></script>
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
	<table class="fl mt5 w">
    	<tr>
    		<td class="f14" align="right" width="12%">项目名称：</td>
    		<td class="f14" align="left" width="16%"><input type="text" name="search_LIKE_name" value="${name}" class="text_input1"/></td>
    		<td>
    			<a href="javascript:;" class="reset block dump_btn globle_img fr ml10"></a>
    			<a href="javascript:;" class="block c_white lh25 fr ml10 submit">
    				<b class="allbtn_l block fl"></b>
    				<b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b>
    			</a>
    		</td>
    		<td class="f14" align="right"></td>
    		<td class="f14" align="left"></td>
    	</tr>
    </table>
    <div class="cb"></div>
    <tags:paginationparams page="${page}"></tags:paginationparams>
	</form>
	<table class="cb id_table2 w pr35">
        <tr>
			<td></td>
			<td>项目名</td>
			<td>项目编号</td>
			<td>供应商</td>
			<td>融资额度</td>
			<td>创建时间 </td>
			<td>创建者</td>
		</tr>
   </table>
   <div style="height: 270px; overflow: hidden; overflow-y:auto; background: #fff">
   <table class="cb id_table2 w pr35">
        <tbody id="lst" class="list"></tbody>
   </table>
   <div class="cb ml35 mt20 h40 pagination"></div>
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