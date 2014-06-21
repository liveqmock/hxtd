<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>数据字典列表页</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
<link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript">
$(function () {
    new Grid().init().bindAuthorization();
});
</script>
</head>
<body>
<div class="listcontainer">
    <form id="form" action="${ctx}/system/dictionary/query.do" onsubmit="return false;">
    <table class="fl mt5 w">
    	<tr>
    		<td class="f14" align="right" width="7%">字典类型：</td>
    		<td class="f14" align="left"  width="13%">
	    		<select name="search_EQ_type" class="select2">
					<option value="">全部</option>
					<c:forEach var="item" items="${types}">
					<option value="${item}">${item}</option>
		   			</c:forEach>
				</select>
    		</td>
    		<td width="15%">
    			<a href="javascript:;" class="reset block dump_btn globle_img fr ml10"></a>
    			<a href="javascript:;" class="block c_white lh25 fr ml10">
    				<b class="allbtn_l block fl"></b>
    				<b class="allbtn_r pr13 block fl w_auto f14 submit">查&nbsp;&nbsp;询</b>
    			</a>
    		</td>
    		<td class="f14" align="right" width="7%"></td>
    		<td class="f14" align="right" width="18%"></td>
    		<td class="f14" align="right" width="7%"></td>
    		<td class="f14" align="right" width="13%"></td>
    		<td class="f14" align="right" width="7%"></td>
    		<td class="f14" align="right" width="13%"></td>
    	</tr>
    </table>
    <div class="cb"></div>
    <tags:paginationparams page="${page}"></tags:paginationparams>
    </form>
    <div class="ml35 mr35 mt20 block cb cb">
		<b class="b1"></b>
		<b class="b2"></b>
		<b class="b3"></b>
		<b class="b4"></b>
		<div class="ie_head">
			<ul class="fl id_table1 mt10 ml10">
				<c:if test="${VS_HAS_FUNCTIONS.dictionaryDelete}">
					<li>
						<a href="javascript:;" class="block c_white lh25 mr10 deletesome">
							<b class="allbtn_l block fl"></b>
							<b class="allbtn_r pr13 block fl w_auto f14" uri="${ctx}/system/dictionary/delete.do">删&nbsp;&nbsp;除</b>
						</a>
					</li>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.dictionaryAdd}">
					<li>
						<a href="${ctx}/system/dictionary/toAddPage.do" class="block c_white lh25">
							<b class="allbtn_l block fl"></b>
							<b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b>
						</a>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
	<div class="ml35 mr35">
	<div id="title" style="display: none;background-color: #f5f5f6;" class="mr35">
		<table class="cb id_table2 w">
			<tr>
				<th width="4%"><input type="checkbox" class="checkall"/></th>
			    <th>字典名称</th>
			    <th>字典值</th>
			    <th>字典类型</th>
			    <th class="sortable orderby" orderby="createdTime">创建时间</th>
			    <th class="sortable orderby" orderby="modifiedTime">最后修改时间</th>
			    <th>操作</th>
			</tr>
		</table>
	</div>
	<table class="cb id_table2 w pr35">
		<tr id="recordDiv">
			<th width="4%"><input type="checkbox" class="checkall"/></th>
		    <th>字典名称</th>
		    <th>字典值</th>
		    <th>字典类型</th>
		    <th class="sortable orderby" orderby="createdTime">创建时间</th>
		    <th class="sortable orderby" orderby="modifiedTime">最后修改时间</th>
		    <th>操作</th>
		</tr>
		<tbody class="list"></tbody>
	</table>
	<div class="cb ml35 mt20 h40 pagination"></div>
	<textarea id="template-tbody" class="template template-tbody">
	    {#foreach $T.result as row}
	    <tr class="{$T.row$index%2==1?'':'bg_c_blue'} w">
           <td><input type="checkbox" class="checkitem" value="{$T.row.id}"/></td>
           <td>
           	<c:choose>
           		<c:when test="${VS_HAS_FUNCTIONS.dictionaryView}">
           			<a class="toviewpage" href="${ctx}/system/dictionary/toViewPage.do?id={$T.row.id}">{$T.row.key}</a>
           		</c:when>
           		<c:otherwise>{$T.row.key}</c:otherwise>
           	</c:choose>
           </td>
           <td>{$T.row.value}</td>
		   <td>{$T.row.type==null?'':$T.row.type}</td>
           <td>{$T.row.createdTime}</td>
           <td>{$T.row.modifiedTime}</td>
           <td>
             <c:if test="${VS_HAS_FUNCTIONS.dictionaryView}">
                 <a href="${ctx}/system/dictionary/toViewPage.do?id={$T.row.id}" class="block_inline s_detail_btn globle_img ml10" title="详情"></a>
             </c:if>
             <c:if test="${VS_HAS_FUNCTIONS.dictionaryModify}">
                 <a href="${ctx}/system/dictionary/toModifyPage.do?id={$T.row.id}" class="block_inline s_edit_btn globle_img ml10" title="编辑"></a>
             </c:if>
             <c:if test="${VS_HAS_FUNCTIONS.dictionaryDelete}">
                 <a href="javascript:void(0);" class="block_inline s_dump_btn globle_img ml10 delete" uri="${ctx}/system/dictionary/delete.do?id={$T.row.id}" title="删除"></a>
             </c:if>
           </td>
	    </tr>
	    {#/for} 
	</textarea>
	<%@include file="/WEB-INF/template/sort.jsp" %>
	<%@include file="/WEB-INF/template/pagination.jsp" %>
	</div>
</div>
</body>
</html>