<%--
  功能描述：付款管理列表页
  User: jason
  Date:2014/7/27
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>应付款列表页</title>
    <link href="${ctx}/static/css/stressing/list1.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/css/stressing/empower.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
    <script type="text/javascript">
        $(function () {
        	//加载时间控件
            jsUtil.datepicker(".time");
            var grid = new Grid().init().bindExport();
        });
        
    </script>
</head>
<body>
	<div class="listcontainer">
		<form id="form" action="${ctx}/financial/payments/query.do" onsubmit="return false;">
		<table class="fl mt5 w">
			<tr>
				<td class="f14 namewidth1" align="right" >
					订单编号：
				</td>
				<td class="f14 namewidth2" align="left" >
					<input type="text" class="text_input1" name="search_LIKE_order.code"/>
				</td>
				<td class="f14 namewidth1" align="right" >
					客户名称：
				</td>
				<td class="f14 namewidth2" align="left" >
					<input type="text" class="text_input1" name="search_LIKE_customer.name" />
				</td>
				<td class="f14 namewidth1" align="right" >
					付款状态：
				</td>
				<td class="f14 namewidth2" align="left" >
					<select name="search_EQ_status" class="select2">
						<option value="">
							--全部--
						</option>
						<option value="0">未付款</option>
						<option value="1">已付款</option>
					</select>
				</td>
				<td class="namewidth3">
					<a class="c_222 block cp fr ml10 globle_img mt8 mr20 more"
						title="展开"></a>
					<a href="javascript:void(0)"
						class="a_underline block_inline fr w_blue mt5 reset">清除</a>
					<a href="javascript:void(0)"
						class="block_inline c_white lh25 fr mr10 submit"><b
						class="allbtn_l block fl"></b><b
						class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b> </a>
				</td>
			</tr>
			<tr class="more-content">
				<td class="f14 namewidth1" align="right">应付款金额（万）：</td>
	    		<td class="f14 namewidth2" align="left">
	    			<div class="pr vm">
		    			<input class="text_input2 number" name="search_GTE_fund" type="text"/>-<input class="number text_input2" 
		    				name="search_LTE_fund" type="text"/>
	    			</div>
	    		</td>
	    		<td class="f14 namewidth1" align="right">实际付款金额（万）：</td>
	    		<td class="f14 namewidth2" align="left">
	    			<div class="pr vm">
		    			<input class="text_input2 number" name="search_GTE_actual" type="text"/>-<input class="text_input2 number" 
		    				name="search_LTE_actual" type="text"/>
	    			</div>
	    		</td>
	    		<td class="f14 namewidth1" align="right" >
					付款日期：
				</td>
				<td class="f14 namewidth2" align="left" >
					<div class="pr vm">
						<a href="javascript:;" class="pa time_closenone1"></a>
						<a href="javascript:;" class="pa time_closenone2"></a>
						<input class="text_input2 input_close globle_img time"
							name="search_GTE_operateTime" type="text" 
							readonly />-<input 
							class="text_input2 input_close globle_img time"
							name="search_LTE_operateTime" type="text" readonly />
					</div>
				</td>
			</tr>
		</table>
		<tags:paginationparams page="${page}"></tags:paginationparams>
	</form>
	<!--查询条件结束-->
	<div class="cb"></div>

	<div class="ml35 mr35 mt20 block cb cb">
		<b class="b1"></b>
		<b class="b2"></b>
		<b class="b3"></b>
		<b class="b4"></b>
		<div class="ie_head">
			<ul class="fl id_table1 mt10 ml10">
				<c:if test="${VS_HAS_FUNCTIONS.financialPaymentsDelete}">
					<li>
						<a href="javascript:;" uri="${ctx}/financial/financialPayments/delete.do"
							class="deletesome block c_white lh25"><b
							class="allbtn_l block fl"></b><b
							class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b> </a>
					</li>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.financialPaymentsAdd}">
					<li>
						<a href="${ctx}/financial/payments/toAddPage.do"
							class="block c_white lh25 ml10"><b
							class="allbtn_l block fl"></b><b
							class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b> </a>
					</li>
				</c:if>
				<li>
					<a href="javascript:;" class="refresh block c_white lh25 ml10"><b
						class="allbtn_l block fl"></b><b
						class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b> </a>
				</li>
			</ul>

				</div>
	</div>
	<div id="title" style="display: none;z-index: 1; background-color: #f5f5f6;"
		class=" ml35 mr35">
		<table class="cb id_table2 w ">
			<tr>
				<th width="3%">
					<input type="checkbox" name="" class="checkall" id="id" />
				</th>
				<th width="9%">
					付款名称
				</th>
				<th width="6%">
					客户名称
				</th>
				<th width="10%">
					应付款金额（万）
				</th>
				<th width="10%">
					实际付款金额（万）
				</th>
				<th width="6%">
					付款状态
				</th>
				<th width="6%">
					付款人
				</th>
				<th width="10%" class="sortable orderby" orderby="operateTime">
					付款时间
				</th>
				<th width="6%">
					创建者
				</th>
				<th width="10%" class="sortable orderby" orderby="createdTime">
					创建时间
				</th>
				<th width="6%">
					修改者
				</th>
				<th width="10%" class="sortable orderby" orderby="modifiedTime">
					修改时间
				</th>
				<th width="10%" align="center">
					操作
				</th>
			</tr>
		</table>
	</div>
	<div class="ml35 mr35 content">
		<table class="cb id_table2 w   tablesorter" id="table">
			<tr id="recordDiv">
				<th width="3%">
					<input type="checkbox" name="" class="checkall" id="id" />
				</th>
				<th width="9%">
					付款名称
				</th>
				<th width="6%">
					客户名称
				</th>
				<th width="10%">
					应付款金额（万）
				</th>
				<th width="10%">
					实际付款金额（万）
				</th>
				<th width="6%">
					付款状态
				</th>
				<th width="6%">
					付款人
				</th>
				<th width="10%" class="sortable orderby" orderby="operateTime">
					付款时间
				</th>
				<th width="6%">
					创建者
				</th>
				<th width="10%" class="sortable orderby" orderby="createdTime">
					创建时间
				</th>
				<th width="6%">
					修改者
				</th>
				<th width="10%" class="sortable orderby" orderby="modifiedTime">
					修改时间
				</th>
				<th width="10%" align="center">
					操作
				</th>
			</tr>
			<tbody class="list"></tbody>
		</table>
		<div class="pagination cb ml35 mt20 h40 "></div>
		<textarea id="template-tbody" class="template template-tbody">
          {#foreach $T.result as row}
          <tr class="{$T.row$index%2==1?'':'bg_c_blue'} row w">
				<td>
					<input type="checkbox" name="id" class="checkitem"
						value="{$T.row.id}" />
				</td>
				<td>
				<c:choose>
				<c:when test="${VS_HAS_FUNCTIONS.financialPaymentsView}">
				<a href="${ctx}/financial/payments/toViewPage.do?id={$T.row.id}"
				class="toviewpage">{$T.row.name}</a>
				</c:when>
				<c:otherwise>{$T.row.name}</c:otherwise>
				</c:choose>
				</td>
				<td>{$T.row.customer.name}</td>
				<td align="right">{$T.row.fund}</td>
				<td align="right">{$T.row.actual}</td>
				<td>
				{$T.row.status?'已付款':'未付款'}
				</td>
				<td>{$T.row.owner.realName}</td>
				<td>{$T.row.operateTime}</td>
				<td>{$T.row.creator.realName}</td>
				<td>{$T.row.createdTime}</td>
				<td>{$T.row.modifier.realName}</td>
				<td>{$T.row.modifiedTime}</td>
              <td align="center">
                      <c:if test="${VS_HAS_FUNCTIONS.financialPaymentsView}">
                          <a
							href="${ctx}/financial/payments/toViewPage.do?id={$T.row.id}"
							title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
                      </c:if>
                      <c:if test="${VS_HAS_FUNCTIONS.financialPaymentsModify}">
                          <a
							href="${ctx}/financial/payments/toModifyPage.do?id={$T.row.id}"
							title="编辑" class=" block_inline s_edit_btn globle_img ml10"></a>
                      </c:if>
                      <c:if test="${VS_HAS_FUNCTIONS.financialPaymentsDelete}">
                          <a href="javascript:void(0)"
							uri="${ctx}/financial/payments/delete.do?id={$T.row.id}" title="删除"
							class="delete  block_inline s_dump_btn globle_img ml10"></a>
                      </c:if>
              </td>
          </tr>
          {#/for}
      </textarea>
		<%@include file="/WEB-INF/template/sort.jsp"%>
		<%@include file="/WEB-INF/template/pagination.jsp"%>
		</div>
	</div>
</body>
</html>
