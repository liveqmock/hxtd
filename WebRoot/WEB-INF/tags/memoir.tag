<%@tag pageEncoding="UTF-8"%>
<%@ attribute name="moduleId" type="java.lang.Long" required="true"%>
<%@ attribute name="moduleType" type="java.lang.String" required="true"%>
<%@ attribute name="query" type="java.lang.Boolean" required="true"%>
<%@ attribute name="delete" type="java.lang.Boolean" required="true"%>
<%@ attribute name="view" type="java.lang.Boolean" required="true"%>
<%@ attribute name="edit" type="java.lang.Boolean" required="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript">
$(function(){
	new Grid().init({ containerSelector: '.memoircontainer' });
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
<div class="memoircontainer w95b bg_c_white margin0 mt10">
	<form action="${ctx}/common/memoir/query.do" onsubmit="return false;">
		<input type="hidden" name="moduleId" value="${moduleId}"/>
		<input type="hidden" name="moduleType" value="${moduleType}"/>
		<c:choose>
			<c:when test="${page}">
				<tags:paginationparams page="${page}"></tags:paginationparams>
			</c:when>
			<c:otherwise>
				<input type="hidden" value="0" name="hibernatePageNo"/>
				<input type="hidden" value="10" name="hibernatePageSize"/>
				<input type="hidden" value="modifiedTime" name="hibernateOrderBy"/>
				<input type="hidden" value="desc" name="hibernateOrder"/>
			</c:otherwise>
		</c:choose>
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
             <c:if test="${query}">
                 <a class="block_inline s_detail_btn globle_img ml10" onclick="iframeRemoir('view',{$T.row.id});" title="详情"></a>
             </c:if>
             <c:if test="${edit}">
                 <a class="block_inline s_edit_btn globle_img ml10" onclick="iframeRemoir('edit',{$T.row.id});" title="编辑"></a>
             </c:if>
             <c:if test="${delete}">
                 <a href="javascript:;" class="block_inline s_dump_btn globle_img ml10 delete" uri="${ctx}/common/memoir/delete.do?id={$T.row.id}" title="删除"></a>
             </c:if>
           </td>
	    </tr>
	    {#/for} 
	</textarea>
	<textarea id="template-sort" class="template template-sort">
    <span>{$T.name}</span>
    <span class="margin0 block_inline ml5 vm">
        <a href="javascript:void(0)" class="globle_img block order {$T.descClass}" order="desc"></a>
        <a href="javascript:void(0)" class="globle_img block mt3 order {$T.ascClass}" order="asc"></a>
    </span>
	</textarea>
	<textarea id="template-pagination" class="template template-pagination">
    <ul class="id_ul1 block  fl cb paginationbar" forform="{$T.formSelector}">
        <li class="mt3">每页条数</li>
        <li>
            <select class="page-size" forformfield="{$T.pageSizeSelector}">
                {#foreach [10,20,50,100] as pageSize}
                <option value="{$T.pageSize}"
                {$T.hibernatePageSize==$T.pageSize?"selected":""}>{$T.pageSize}</option>
                {#/for}
            </select>
        </li>
        <li class="mt3 cp"><a class="page-first">首页</a></li>
        <li><a href="javascript:void(0)" class="block prev globle_img page-pre" title="上一页"></a></li>
        <li class="pr">
            <input type="text" class="pa fenye_ipt_text page-no" pageno="{$T.hibernatePageNo}" value="{$T.hibernatePageNo}"/>
            <a href="javascript:void(0)" class="fenye_go globle_img block page-anyone"></a>
        </li>
        <li class="mt3">共<label class="page-totalpages">{$T.totalPages}</label>页</li>
        <li><a href="javascript:void(0)" class="next globle_img block page-next" title="下一页"></a></li>
        <li class="mt3 cp"><a class="page-last">末页</a></li>
        <li><a href="javascript:void(0)" class="fenye_break globle_img block page-rel" title="刷新"></a></li>
    </ul>
    <p class="fr mr35">显示{$T.startRow}到{Math.min($T.endRow,$T.totalCount)}条，共{$T.totalCount}条</p>
	</textarea>
</div>