<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>联系人</title>
<link href="${ctx}/static/css/recommend/detail.css?v=1" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/css/application.css?v=1" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/pacs.js?v=1"></script>
<script type="text/javascript">${applicationScope.VC_PCAS}</script>
<script type="text/javascript">
$(function(){
	jsUtil.datepicker(".time"); //加载日历 
	new PCAS("province","city","county"); //加载省市县 
	new Grid().init().bindExport(); //生成Grid
});
</script>
</head>
<body>
<div class="listcontainer">
    <form id="form" action="${ctx}/customer/contact/query.do" onsubmit="return false;">
    <table class="fl mt5 w">
    	<tr>
    		<td class="f14 namewidth1" align="right">联系人：</td>
    		<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_name"/></td>
    		<td class="f14 namewidth1" align="right">手机：</td>
    		<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_mobile"/></td>
    		<td class="f14 namewidth1" align="right">电话：</td>
    		<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_phone"/></td>
    		<td width="namewidth3">
    			<a href="javascript:;" class="c_222 block cp fr ml10 packup globle_img mt8 mr20 more" title="展开"></a>
    			<a href="javascript:;" class="reset a_underline fr w_blue mt5">清除</a>
    			<a href="javascript:;" class="block c_white lh25 fr mr10">
    				<b class="allbtn_l block fl"></b>
    				<b class="allbtn_r pr13 block fl w_auto f14 submit">查&nbsp;&nbsp;询</b>
    			</a>
    		</td>
    	</tr>
    	<tr class="more-content">
    		<td class="f14 namewidth1" align="right">邮箱：</td>
    		<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_email"/></td>
    		<td class="f14 namewidth1" align="right">省份：</td>
    		<td class="f14 namewidth2" align="left"><select id="province" name="search_EQ_province.id" class="select2"></select></td>
    		<td class="f14 namewidth1" align="right">城市：</td>
    		<td class="f14 namewidth2" align="left"><select id="city" name="search_EQ_city.id" class="select2"></select></td>
    		<td></td>
    	</tr>
    	<tr class="more-content">
    		<td class="f14 namewidth1" align="right">区县：</td>
    		<td class="f14 namewidth2" align="left"><select id="county" name="search_EQ_county.id" class="select2"></select></td>
    		<td class="f14 namewiwwdth1" align="right">创建时间：</td>
    		<td class="f14 namewidth2" align="left">
    			<div class="vm">
	    			<input class="text_input2 input_close globle_img time" name="search_GTE_createdTime" 
	    				type="text" readonly/>-<input class="text_input2 input_close globle_img time" name="search_LTE_createdTime" 
	    				type="text" readonly/>
    			</div>
    		</td>
    		<td class="f14 namewidth1" align="right">修改时间：</td>
    		<td class="f14 namewidth2" align="left">
    			<div class="vm">
	    			<input class="text_input2 input_close globle_img time" name="search_GTE_modifiedTime" 
	    				type="text" readonly/>-<input class="text_input2 input_close globle_img time" name="search_LTE_modifiedTime" 
	    				type="text" readonly/>
    			</div>
    		</td>
    		<td></td>
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
				<c:if test="${VS_HAS_FUNCTIONS.contactDelete}">
					<li>
						<a href="javascript:;" class="block c_white lh25 mr10 deletesome" uri="${ctx}/customer/contact/delete.do">
							<b class="allbtn_l block fl"></b>
							<b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b>
						</a>
					</li>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.contactAdd}">
					<li>
						<a href="${ctx}/customer/contact/toAddPage.do" class="block c_white lh25 mr10">
							<b class="allbtn_l block fl"></b>
							<b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b>
						</a>
					</li>
				</c:if>
				<li>
					<a href="javascript:;" class="block c_white lh25 mr10 refresh">
						<b class="allbtn_l block fl"></b>
						<b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b>
					</a>
				</li>
			</ul>
			<ul class="fr id_table1 mt10 mr10">
				<c:if test="${VS_HAS_FUNCTIONS.contactImport}">
					<li>
						<a href="${ctx}/contact/imports/toImportPage.do?module=contact"
									class="leading_in globle_img block_inline mr10" title="导入"></a>
					</li>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.leadExport}">
					<li>
						<a href="javascript:;" uri="${ctx}/customer/contact/export.do?TYPE=selected" 
							class="leading_out block_inline mr10 export" title="导出"></a>
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
			    <th width="8%">联系人</th>
			    <th width="10%">电话</th>
			    <th width="10%">手机</th>
			    <th width="12%">邮箱</th>
			    <th width="15%" class="sortable orderby" orderby="createdTime">创建时间</th>
			    <th width="15%" class="sortable orderby" orderby="modifiedTime">最后修改时间</th>
			    <th width="16%">操作</th>
			</tr>
		</table>
	</div>
	<table class="cb id_table2 w pr35">
		<tr id="recordDiv">
			<th width="4%"><input type="checkbox" class="checkall"/></th>
		    <th width="8%">联系人</th>
		    <th width="10%">电话</th>
		    <th width="10%">手机</th>
		    <th width="12%">邮箱</th>
		    <th width="15%" class="sortable orderby" orderby="createdTime">创建时间</th>
		    <th width="15%" class="sortable orderby" orderby="modifiedTime">最后修改时间</th>
		    <th width="16%">操作</th>
		</tr>
		<tbody class="list"></tbody>
	</table>
	<div class="cb ml35 mt20 h40 pagination"></div>
	<textarea id="template-tbody" class="template template-tbody">
	    {#foreach $T.result as row}
	    <tr class="{$T.row$index%2==1?'':'bg_c_blue'} w row">
           <td><input type="checkbox" class="checkitem" value="{$T.row.id}"/></td>
           <td>
           	<c:choose>
           		<c:when test="${VS_HAS_FUNCTIONS.contactView}">
           			<a class="toviewpage" href="${ctx}/customer/contact/toViewPage.do?id={$T.row.id}">{$T.row.name}</a>
           		</c:when>
           		<c:otherwise>{$T.row.name}</c:otherwise>
           	</c:choose>
           </td>
           <td>{$T.row.phone}</td>
           <td>{$T.row.mobile}</td>
           <td>{$T.row.email}</td>
		   <td>{$T.row.createdTime}</td>
           <td>{$T.row.modifiedTime}</td>
           <td>
             <c:if test="${VS_HAS_FUNCTIONS.contactView}">
                 <a href="${ctx}/customer/contact/toViewPage.do?id={$T.row.id}" 
                 	class="block_inline s_detail_btn globle_img ml10" title="详情"></a>
             </c:if>
             <c:if test="${VS_HAS_FUNCTIONS.contactModify}">
                 <a href="${ctx}/customer/contact/toModifyPage.do?id={$T.row.id}" 
                 	class="block_inline s_edit_btn globle_img ml10" title="编辑"></a>
             </c:if>
             <c:if test="${VS_HAS_FUNCTIONS.contactDelete}">
                 <a href="javascript:void(0);" class="block_inline s_dump_btn globle_img ml10 delete" 
                 	uri="${ctx}/customer/contact/delete.do?id={$T.row.id}" title="删除"></a>
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
