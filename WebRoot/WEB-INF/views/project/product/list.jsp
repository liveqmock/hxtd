<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>产品</title>
<link href="${ctx}/static/css/recommend/detail.css?v=1" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/css/application.css?v=1" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript">
$(function(){
	jsUtil.twoOrMoreRestrictDate('.time', 'max', 0); // 绑定日历
	jsUtil.twoOrMoreRestrictDate('.saletime', 'max', null); //绑定销售日历 
	new Grid().init().bindExport(); // 生成Grid
});
</script>
</head>
<body>
<div class="listcontainer">
    <form id="form" action="${ctx}/project/product/query.do" onsubmit="return false;">
    <table class="fl mt5 w">
    	<tr>
    		<td class="f14 namewidth1" align="right">产品名称：</td>
    		<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_name"/></td>
    		<td class="f14 namewidth1" align="right">产品编号：</td>
    		<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_code"/></td>
    		<td class="f14 namewidth1" align="right">出售金额：</td>
    		<td class="f14 namewidth2" align="left">
    			<div class="pr vm">
	    			<input class="text_input2" name="search_GTE_sellMoney" type="text"/>-<input class="text_input2" 
	    				name="search_LTE_sellMoney" type="text"/>
    			</div>
    		</td>
    		<td width="namewidth3">
    			<a href="javascript:;" class="c_222 block cp fr ml10 packup globle_img mt8 mr20 more" title="展开"></a>
    			<a href="javascript:;" class="reset a_underline fr w_blue mt5">清除</a>
    			<a href="javascript:;" class="block c_white lh25 fr mr10 submit">
    				<b class="allbtn_l block fl"></b>
    				<b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b>
    			</a>
    		</td>
    	</tr>
    	<tr class="more-content">
    		<td class="f14 namewidth1" align="right">销售日期：</td>
    		<td class="f14 namewidth2" align="left">
    			<div class="vm">
	    			<input class="text_input2 input_close globle_img saletime" name="search_GTE_saleBeginTime" 
	    				type="text" readonly/>-<input class="text_input2 input_close globle_img saletime" name="search_LTE_saleEndTime" 
	    				type="text" readonly/>
    			</div>
    		</td>
    		<td class="f14 namewidth1" align="right">创建时间：</td>
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
				<c:if test="${VS_HAS_FUNCTIONS.productDelete}">
					<li>					
						<a href="javascript:;" class="block c_white lh25 mr10 deletesome" uri="${ctx}/project/product/delete.do">
							<b class="allbtn_l block fl"></b>
							<b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b>
						</a>
					</li>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.productAdd}">
					<li>
						<a href="${ctx}/project/product/toAddPage.do" class="block c_white lh25 mr10">
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
				<li>
					<a href="javascript:;" uri="${ctx}/project/product/export.do?TYPE=selected" 
						class="leading_out block_inline mr10 export" title="导出"></a>
				</li>
			</ul>
		</div>
	</div>
	<div class="ml35 mr35">
	<div id="title" style="display: none;background-color: #f5f5f6;" class="mr35">
		<table class="cb id_table2 w">
			<tr>
				<th width="2%"><input type="checkbox" class="checkall"/></th>
			    <th width="14%">产品编号</th>
			    <th width="8%">产品名称</th>
			    <th width="10%">所属项目</th>
			    <th width="10%">出售金额</th>
			    <th width="8%">收益率%</th>
			    <th width="8%">销售期限</th>
			    <th width="12%" class="sortable orderby" orderby="saleBeginTime">销售开始日期</th>
			    <th width="12%" class="sortable orderby" orderby="saleEndTime">销售结束日期</th>
			    <th width="6%">创建者</th>
			    <th width="10%">操作</th>
			</tr>
		</table>
	</div>
	<table class="cb id_table2 w pr35">
		<tr id="recordDiv">
			<th width="2%"><input type="checkbox" class="checkall"/></th>
		    <th width="14%">产品编号</th>
		    <th width="8%">产品名称</th>
		    <th width="10%">所属项目</th>
		    <th width="10%">出售金额</th>
		    <th width="8%">收益率%</th>
		    <th width="8%">销售期限</th>
		    <th width="12%" class="sortable orderby" orderby="saleBeginTime">销售开始日期</th>
		    <th width="12%" class="sortable orderby" orderby="saleEndTime">销售结束日期</th>
		    <th width="6%">创建者</th>
		    <th width="10%">操作</th>
		</tr>
		<tbody class="list"></tbody>
	</table>
	<div class="cb ml35 mt20 h40 pagination"></div>
	<textarea id="template-tbody" class="template template-tbody">
	    {#foreach $T.result as row}
	    <tr class="{$T.row$index%2==1?'':'bg_c_blue'} w">
	        <td><input type="checkbox" class="checkitem" value="{$T.row.id}"/></td>
	        <td>{$T.row.code}</td>
	        <td>
	            <c:choose>
	                <c:when test="${VS_HAS_FUNCTIONS.productView}"><a href="${ctx}/project/product/toViewPage.do?id={$T.row.id}" 
	                	class="toviewpage">{$T.row.name}</a></c:when>
	                <c:otherwise>{$T.row.name}</c:otherwise>
	            </c:choose>
	        </td>
	        <td>{$T.row.project.name}</td>
	        <td align="right">{jsUtil.formatDiff($T.row.sellMoney, 2)}</td>
	        <td>{$T.row.minRate}%~{$T.row.maxRate}%</td>
	        <td>{$T.row.saleLimit}{$T.row.saleUnit.key}</td>
	        <td>{$T.row.saleBeginTime}</td>
	        <td>{$T.row.saleEndTime}</td>
	        <td>{$T.row.creator.realName}</td>
	        <td>
              <c:if test="${VS_HAS_FUNCTIONS.productView}">
                  <a href="${ctx}/project/product/toViewPage.do?id={$T.row.id}" 
                  	class="block_inline s_detail_btn globle_img ml10" title="详情"></a>
              </c:if>
              <c:if test="${VS_HAS_FUNCTIONS.productModify}">
                  <a href="${ctx}/project/product/toModifyPage.do?id={$T.row.id}" 
                  	class="block_inline s_edit_btn globle_img ml10" title="编辑"></a>
              </c:if>
              <c:if test="${VS_HAS_FUNCTIONS.productDelete}">
                  <a href="javascript:;" uri="${ctx}/project/product/delete.do?id={$T.row.id}" 
                  	class="block_inline s_dump_btn globle_img ml10 delete" title="删除"></a>
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
