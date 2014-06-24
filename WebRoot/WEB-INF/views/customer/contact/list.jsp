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
	jsUtil.datepicker(".time");// 加载日历 
	new PCAS("province","city","county");// 加载省市县 
	new Grid().init().bindExport();// 生成Grid
	$(".more").click(function(){
		$(this).toggleClass("h_shangla").parents("tr").nextAll().toggle();
	});
});
</script>
</head>
<body>
<div class="listcontainer">
    <form id="form" action="${ctx}/customer/contact/query.do" onsubmit="return false;">
    <table class="fl mt5 w">
    	<tr>
    		<td class="f14" align="right" width="6%">联系人：</td>
    		<td class="f14" align="left" width="16%"><input type="text" class="text_input1" name="search_LIKE_name"/></td>
    		<td class="f14" align="right" width="6%">手机：</td>
    		<td class="f14" align="left" width="16%"><input type="text" class="text_input1" name="search_LIKE_mobile"/></td>
    		<td class="f14" align="right" width="6%">电话：</td>
    		<td class="f14" align="left" width="16%"><input type="text" class="text_input1" name="search_LIKE_phone"/></td>
    		<td class="f14" align="right" width="6%">邮箱：</td>
    		<td class="f14" align="left" width="16%"><input type="text" class="text_input1" name="search_LIKE_email"/></td>
    		<td width="10%">
    			<a class="h_xiala globle_img block fr more" href="javascript:;" title="更多搜索条件"></a>
    			<a href="javascript:;" class="reset block dump_btn globle_img fr ml10"></a>
    			<a href="javascript:;" class="block c_white lh25 fr ml10">
    				<b class="allbtn_l block fl"></b>
    				<b class="allbtn_r pr13 block fl w_auto f14 submit">查&nbsp;&nbsp;询</b>
    			</a>
    		</td>
    	</tr>
    	<tr style="display:none;">
    		<td class="f14" align="right" width="6%">省份：</td>
    		<td class="f14" align="left"  width="16%"><select id="province" name="search_EQ_province.id" class="select2"></select></td>
    		<td class="f14" align="right" width="6%">城市：</td>
    		<td class="f14" align="left" width="16%"><select id="city" name="search_EQ_city.id" class="select2"></select></td>
    		<td class="f14" align="right" width="6%">区县：</td>
    		<td class="f14" align="left" width="16%"><select id="county" name="search_EQ_county.id" class="select2"></select></td>
    		<td class="f14" align="right" width="6%">创建时间：</td>
    		<td class="f14" align="left" width="16%">
    			<div class="pr vm">
	    			<a href="javascript:;" class="pa time_closenone1"></a>
	    			<a href="javascript:;" class="pa time_closenone2"></a>
	    			<input class="text_input2 input_close globle_img time" name="search_GTE_createdTime" 
	    				type="text" readonly/>-<input class="text_input2 input_close globle_img time" name="search_LTE_createdTime" 
	    				type="text" readonly/>
    			</div>
    		</td>
    		<td width="10%"></td>
    	</tr>
    	<tr style="display:none;">
    		<td class="f14" align="right" width="6%">修改时间：</td>
    		<td class="f14" align="left" width="16%">
    			<div class="pr vm">
	    			<a href="javascript:;" class="pa time_closenone1"></a>
	    			<a href="javascript:;" class="pa time_closenone2"></a>
	    			<input class="text_input2 input_close globle_img time" name="search_GTE_modifiedTime" 
	    				type="text" readonly/>-<input class="text_input2 input_close globle_img time" name="search_LTE_modifiedTime" 
	    				type="text" readonly/>
    			</div>
    		</td>
    		<td class="f14" align="right" width="6%"></td>
    		<td class="f14" align="left"  width="16%"></td>
    		<td class="f14" align="right" width="6%"></td>
    		<td class="f14" align="left" width="16%"></td>
    		<td class="f14" align="right" width="6%"></td>
    		<td class="f14" align="left" width="16%"></td>
    		<td width="10%"></td>
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
						<a href="${ctx}/customer/contact/toAddPage.do" class="block c_white lh25" >
							<b class="allbtn_l block fl"></b>
							<b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b>
						</a>
					</li>
				</c:if>
				<li>
					<a href="javascript:;" uri="${ctx}/customer/contact/export.do?TYPE=pagination" 
						class="block c_white ml10 lh25 mr10 export">
						<b class="allbtn_l block fl"></b>
						<b class="allbtn_r pr13 block fl w_auto f14">导&nbsp;出</b>
					</a>
				</li>
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
