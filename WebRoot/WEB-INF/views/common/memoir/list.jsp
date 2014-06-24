<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript">
$(function(){
	//$("#moduleId").val($("#hide_id").val());
	alert("XX");
	new Grid().init();
	$(".contactrecords").click(function(){
		iframeRemoir('add', '');
	});
});
function iframeRemoir(act, id){
	var url, title;
	if(act == "add"){
		url = '${ctx}/common/memoir/toAddPage.doself';
		title = '新增联系纪要';
	} else if(act == "edit"){
		url = '${ctx}/common/memoir/toModifyPage.doself?id=' + id;
		title = '编辑联系纪要';
	} else {
		url = '${ctx}/common/memoir/toViewPage.doself?id=' + id;
		title = '查看联系纪要';
	}
	jsUtil.dialogIframe(url, title, 800, 515);
	DIALOG.dialog('option','buttons',{
		"确定" : function() {
			if(act == "view") {
				DIALOG.dialog("close");
			} else {
				if($("#dialogIframe")[0].contentWindow.submitRemoir()){
					$(".page-rel").click();//刷新列表
					DIALOG.dialog("close");
				}
			}
		},
		"关闭" : function() {
			DIALOG.dialog("close");
		}
	});
}
</script>
<h1 class="f14 fbnone ml40">联系纪要</h1>
<div class="listcontainer w95b bg_c_white margin0 mt10">
	<form action="${ctx}/common/memoir/query.do" onsubmit="return false;">
		<input type="hidden" name="moduleId" id="moduleId"/>
		<input type="hidden" id="moduleType" name="moduleType" value="11010104"/>
		<tags:paginationparams page="${page}"></tags:paginationparams>
	</form>
	<table class="cb id_table2 w pr35">
		<tr>
		    <th>联系纪要</th>
		    <th>下次联系时间</th>
		    <th>下次联系要点</th>
		    <th>沟通者</th>
		    <th align="center">操作</th>
		</tr>
		<tbody class="list"></tbody>
	</table>
	<div class="cb ml35 mt20 h40 pagination"></div>
	<textarea id="template-tbody" class="template template-tbody">
	    {#foreach $T.result as row}
	    <tr class="{$T.row$index%2==1?'':'bg_c_blue'} w">
           <td>{$T.row.summary}</td>
           <td>{$T.row.nextContactTime}</td>
           <td>{$T.row.nextContactPoints}</td>
           <td>{$T.row.employee.name}</td>
           <td align="center">
             <c:if test="${VS_HAS_FUNCTIONS.marketactivityView}">
                 <a class="block_inline s_detail_btn globle_img ml10" onclick="iframeRemoir('view',{$T.row.id});" title="详情"></a>
             </c:if>
             <c:if test="${VS_HAS_FUNCTIONS.marketactivityModify}">
                 <a class="block_inline s_edit_btn globle_img ml10" onclick="iframeRemoir('edit',{$T.row.id});" title="编辑"></a>
             </c:if>
             <c:if test="${VS_HAS_FUNCTIONS.marketactivityDelete}">
                 <a href="javascript:;" class="block_inline s_dump_btn globle_img ml10 delete" uri="${ctx}/common/memoir/delete.do?id={$T.row.id}" title="删除"></a>
             </c:if>
           </td>
	    </tr>
	    {#/for} 
	</textarea>
	<%@include file="/WEB-INF/template/sort.jsp" %>
	<%@include file="/WEB-INF/template/pagination.jsp" %>
</div>
