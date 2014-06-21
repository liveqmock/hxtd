<%@tag pageEncoding="UTF-8"%>
<%@ attribute name="module" type="java.lang.String" required="true"%>
<%@ attribute name="id" type="java.lang.Long" required="true"%>
<%@ attribute name="query" type="java.lang.Boolean" required="true"%>
<%@ attribute name="upload" type="java.lang.Boolean" required="true"%>
<%@ attribute name="view" type="java.lang.Boolean" required="true"%>
<%@ attribute name="down" type="java.lang.Boolean" required="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript" src="${ctx}/static/js/attachment.js">
</script>
<script type="text/javascript">
	attachment.init({id:${id},view:${view},down:${down},module:"${module}"});
	$(function(){
		attachment.query();
	})
</script>

<c:if test="${query}">
<input type="hidden" id="id" value="${id}"/>
<div class="fr mt20">
<h1 class="f14 fbnone mb10">附件列表</h1>
<div class=" bg_c_white w470 d_bgw">
<c:if test="${upload}">
	<a href="javascript:attachment.upload()">上传附件</a>
</c:if>
<h1 class="cb pt20 pl10 fbnone">已上传：</h1>
<table class="cb fbnone w440 margin0 pt10 bg_c_f3f3f3 mt20 id_table2">
<tr class="fbnone">
<th width="33%">名称</th>
<th width="33%">类型</th>
<th width="33%">操作</th>
</tr>
<tbody id="attBody"></tbody>
</table>
</div>
</div>
</c:if>