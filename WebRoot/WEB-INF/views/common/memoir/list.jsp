<%--
  功能描述：沟通纪要组件列表页
  User: lihua
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript">
$(function(){
	$("#moduleId").val($("#hide_id").val());
	jsUtil.loadGrid().bindDeleteOne().bindAuthorization().bindQuery().bindPagination().renderSort().bindSort();
	$(".contactrecords").click(function(){
		iframeRemoir('add', '');
	});
});
function iframeRemoir(act, id){
	var url, title;
	if(act == "add"){
		url = '${ctx}/common/memoir/toAddPage.docomp';
		title = '新增联系纪要';
	} else if(act == "edit"){
		url = '${ctx}/common/memoir/toModifyPage.docomp?id=' + id;
		title = '编辑联系纪要';
	} else {
		url = '${ctx}/common/memoir/toViewPage.docomp?id=' + id;
		title = '查看联系纪要';
	}
	jsUtil.dialogIframe(url, title, 800, 515);
	DIALOG.dialog('option','buttons',{
		"确定" : function() {
			if(act == "view") {
				DIALOG.dialog("close");
			} else {
				if($("#dialogIframe")[0].contentWindow.submitRemoir()){
					//jsUtil.loadGrid();
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
 <div class="ct_title">
	<span class="fl ttname">联系纪要</span>
	<div class="clear"></div>
</div>
<div class="" style="background:#f5f5f5;height:42px;padding:0;">
	<div class="fl list_top" >
		<a href="javascript:void(0)" style="" class="green_btn contactrecords">新增</a>
	</div>
	<div class="clear"></div>
</div>
<form action="${ctx}/common/memoir/query.do" onsubmit="return false;">
<input type="hidden" name="moduleId" id="moduleId"/>
<input type="hidden" id="moduleType" name="moduleType" value="11010104"/>
</form>
<div class="" style="border-top:none;">
	<table cellspacing="1" class="tablesorter" id="table">
		<thead>
			<tr>
				<td>联系纪要</td>
				<td>下次联系时间</td>
				<td>下次联系要点</td>
				<td>沟通者</td>
				<td>操作</td>
			</tr>
		</thead>
		<tbody id="tbody" class="list"></tbody>
	</table>
	<div class="pagination"></div>
	<!-- 联系人列表模板 -->
    <textarea id="template-tbody" class="template template-tbody">
        {#foreach $T.result as row}
        <tr>
            <td>{$T.row.summary}</td>
            <td>{$T.row.nextContactTime}</td>
            <td>{$T.row.nextContactPoints}</td>
            <td>{$T.row.employee.name}</td>
            <td width="68">
                <ul>
                    <li><a href="javascript:void(0);"><img src="${ctx}/static/images/tallssed.png" alt="" onclick="iframeRemoir('view',{$T.row.id});"/></a></li>
                    <li><a href="javascript:void(0);"><img src="${ctx}/static/images/editimged.png" alt="" onclick="iframeRemoir('edit',{$T.row.id});"/></a></li>
                    <li><a href="javascript:void(0);"><img src="${ctx}/static/images/deleteimged.png" alt="" class="delete" uri="${ctx}/common/memoir/delete.do?id={$T.row.id}"/></a></li>
                    <div class="clear"></div>
                </ul>
            </td>
        </tr>
        {#/for}
    </textarea>
    <c:if test=""></c:if>
    <%@include file="/WEB-INF/template/sort.jsp" %>
    <%@include file="/WEB-INF/template/pagination.jsp" %>
</div>
 
