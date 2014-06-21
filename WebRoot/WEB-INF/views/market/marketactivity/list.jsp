<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>市场活动列表</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
<link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript">
$(function(){
	jsUtil.datepicker(".time");
	new Grid().init().bindAuthorization();
});
</script>
</head>
<body>
<div class="listcontainer">
    <form id="form" action="${ctx}/market/marketactivity/query.do" onsubmit="return false;">
    <table class="fl mt5 w">
    	<tr>
    		<td class="f14" align="right" width="7%">活动名称：</td>
    		<td class="f14" align="left"  width="13%"><input type="text" class="text_input1" name="search_LIKE_name"/></td>
    		<td class="f14" align="right" width="7%">活动类型：</td>
    		<td class="f14" align="left" width="13%">
    			<select name="search_EQ_dic.id" class="select2">
					<option value="">全部</option>
					<c:forEach items="${dicType}" var="dic">
						<option value="${dic.id}" >${dic.key}</option>
					</c:forEach>
				</select>
    		</td>
    		<td class="f14" align="right" width="7%">活动状态：</td>
    		<td class="f14" align="left" width="13%">
    			<select name="search_EQ_status.id" class="select2">
					<option value="">全部</option>
					<c:forEach items="${dicStatus}" var="dic">
						<option value="${dic.id}">${dic.key}</option>
					</c:forEach>
				</select>
    		</td>
    		<td class="f14" align="right" width="7%">创建时间：</td>
    		<td class="f14" align="left" width="18%">
    			<div class="pr vm">
	    			<a href="javascript:;" class="pa time_closenone1" onclick="javascript:$(this).nextAll().eq(1).val('');"></a>
	    			<a href="javascript:;" class="pa time_closenone2" onclick="javascript:$(this).nextAll().eq(1).val('');"></a>
	    			<input class="text_input2 input_close globle_img time" name="search_GTE_createdTime" type="text" readonly/>
	    			-<input class="text_input2 input_close globle_img time" name="search_LTE_createdTime" type="text" readonly/>
    			</div>
    		</td>
    		<td width="15%">
    			<a href="javascript:;" class="reset block dump_btn globle_img fr ml10"></a>
    			<a href="javascript:;" class="block c_white lh25 fr ml10 submit">
    				<b class="allbtn_l block fl"></b>
    				<b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b>
    			</a>
    		</td>
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
				<c:if test="${VS_HAS_FUNCTIONS.marketactivityDelete}">
					<li>
						<a href="javascript:;" class="block c_white lh25 mr10 deletesome" uri="${ctx}/market/marketactivity/delete.do">
							<b class="allbtn_l block fl"></b>
							<b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b>
						</a>
					</li>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.marketactivityAdd}">
					<li>
						<a href="${ctx}/market/marketactivity/toAddPage.do" class="block c_white lh25">
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
			    <th width="20%">活动名称</th>
			    <th width="7%">活动类型</th>
			    <th width="7%">活动状态</th>
			    <th width="7%">预算成本</th>
			    <th width="7%">期望成功率%</th>
			    <th width="11%" class="sortable orderby" orderby="beginDate">开始时间</th>
			    <th width="11%" class="sortable orderby" orderby="endDate">结束时间</th>
			    <th width="11%" class="sortable orderby" orderby="createdTime">创建时间</th>
			    <th width="15%" align="center">操作</th>
			</tr>
		</table>
	</div>
	<table class="cb id_table2 w pr35">
		<tr id="recordDiv">
			<th width="4%"><input type="checkbox" class="checkall"/></th>
		    <th width="20%">活动名称</th>
		    <th width="7%">活动类型</th>
		    <th width="7%">活动状态</th>
		    <th width="7%">预算成本</th>
		    <th width="7%">期望成功率%</th>
		    <th width="11%" class="sortable orderby" orderby="beginDate">开始时间</th>
		    <th width="11%" class="sortable orderby" orderby="endDate">结束时间</th>
		    <th width="11%" class="sortable orderby" orderby="createdTime">创建时间</th>
		    <th width="15%" align="center">操作</th>
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
           		<c:when test="${VS_HAS_FUNCTIONS.marketactivityView}">
           			<a class="toviewpage" href="${ctx}/market/marketactivity/toViewPage.do?id={$T.row.id}">{$T.row.name}</a>
           		</c:when>
           		<c:otherwise>{$T.row.name}</c:otherwise>
           	</c:choose>
           </td>
           <td>{$T.row.dic.key}</td>
           <td>{$T.row.status.key}</td>
           <td align="right">{$T.row.predictCost}</td>
           <td align="right">{$T.row.expectSuccessRate}</td>
           <td>{$T.row.beginDate}</td>
           <td>{$T.row.endDate}</td>
           <td>{$T.row.createdTime}</td>
           <td align="center">
             <c:if test="${VS_HAS_FUNCTIONS.marketactivityView}">
                 <a href="${ctx}/market/marketactivity/toViewPage.do?id={$T.row.id}" class="block_inline s_detail_btn globle_img ml10" title="详情"></a>
             </c:if>
             <c:if test="${VS_HAS_FUNCTIONS.marketactivityModify}">
                 <a href="${ctx}/market/marketactivity/toModifyPage.do?id={$T.row.id}" class="block_inline s_edit_btn globle_img ml10" title="编辑"></a>
             </c:if>
             <c:if test="${VS_HAS_FUNCTIONS.marketactivityDelete}">
                 <a href="javascript:void(0);" class="block_inline s_dump_btn globle_img ml10 delete" uri="${ctx}/market/marketactivity/delete.do?id={$T.row.id}" title="删除"></a>
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
