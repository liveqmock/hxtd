<%@tag pageEncoding="UTF-8"%>
<%@ attribute name="module" type="java.lang.String" required="true"%>
<%@ attribute name="id" type="java.lang.Long" required="true"%>
<%@ attribute name="query" type="java.lang.Boolean" required="true"%>
<%@ attribute name="upload" type="java.lang.Boolean" required="true"%>
<%@ attribute name="view" type="java.lang.Boolean" required="true"%>
<%@ attribute name="down" type="java.lang.Boolean" required="true"%>
<%@ attribute name="deleteFlag" type="java.lang.Boolean" required="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript" src="${ctx}/static/js/attachment.js">
</script>
<script type="text/javascript">
	attachment.init({id:${id},view:${view},down:${down},deleteF:${deleteFlag},module:"${module}"});
	$(function(){
		attachment.query();
	})
</script>
<input id="id" type="hidden" value="${id}">
<c:if test="${query}">
<h1 class="f14 fbnone ml40 mt10">附件列表</h1>
<div class="w95b  bg_c_white margin0 mt10">
	<br />
	<h1 class="w70b margin0 fbnone f12 mt10 block">
		已上传：
		<c:if test="${upload}">
		<a href="javascript:attachment.upload();" class="block c_white lh25 fr mt-15 mr60 "> <b
			class="allbtn_l block fl"></b><b
			class="allbtn_r pr13 block fl w_auto f14">上传附件</b></a>
		</c:if>
	</h1>
	<b class="w70b f_line2 block margin0"></b>

	<table class="cb id_table2 w70b margin0 mt10 mb10">
		<tr>
			<th width="25%">
				附件名称
			</th>
			<th width="25%">
				类型
			</th>
			<th width="25%">
				上传时间
			</th>
			<th width="25%">
				操作
			</th>
		</tr>
		<tbody id="attBody" class="list"></tbody>
	</table>
	<div class=" h40"></div>
</div>
</c:if>