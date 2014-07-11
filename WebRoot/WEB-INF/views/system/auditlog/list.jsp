<%--
     审计日志列表页
  author: xiaoli.luo
  Date:2014/6/4
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
	<head>
		<title>审计日志</title>
		<link href="${ctx}/static/css/application.css?v=1" rel="stylesheet" type="text/css" />
		<link href="${ctx}/static/css/stressing/empower.css" rel="stylesheet" type="text/css" />
		<link href="${ctx}/static/css/recommend/detail.css?v=1" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js?v=1"></script>
		<script type="text/javascript" src="${ctx}/static/js/js-util.common.js?v=1"></script>
		<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
		<script type="text/javascript">
			$(function() {
				jsUtil.datepicker(".time");//加载时间控件
				grid = new Grid().init();
				
				$(".empty").click(function(){ // 清除
				$(this).prevAll("input").val('');
				});
			});
			function onLoad(){
				grid.loadGrid();
			}
			function formReSet(){
				$("#form")[0].reset();
			}
			function searchData(action){//搜索条件-操作人
				jsUtil.dialogIframe("${ctx}/system/user/toQueryPage.comp", "操作人", 800, 465, function(){// 确定回调
					var $ckObj = $(".bor_e28d1f", window.frames["dialogIframe"].document);
					if($ckObj.length > 0){
						$("#txt_" + action).val($ckObj.find("td:eq(0)").text());
						$("#hide_" + action +"_id").val($ckObj.attr("id"));
					}
				});
			}
			
		</script>
	</head>
	<body>
		<div style="ml35 mr35 mt10 block cb cb">
			<b class="b1"></b>
		    <b class="b2"></b>
		    <b class="b3"></b>
		    <b class="b4"></b>
			<div class="listcontainer">
			<!--查询条件开始-->
			<form id="form" action="${ctx}/system/auditlog/query.do" onsubmit="return false;">
				<table class="fl mt5 w">
					<tr>
						<td class="f14 namewidth1" align="right">操作人：</td>
						<td class="f14 namewidth2" align="left">
							<input type="text" id="txt_creator" readonly="readonly"
								class="text_input1" />
							<input type="text" id="hide_creator_id" name="search_EQ_creator.id" class="text_input1 none" />
							<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索操作人" onclick="searchData('creator');"></i>
							<i class="dump_btn globle_img block_inline ml5 vm cp empty" title="清除"></i>
						</td>
						<td class="f14 namewidth1" align="right">操作类型：</td>
						<td class="f14 namewidth2" align="left">
							<div class="pr">
								<select name="search_EQ_type" class="select2">
									<option value="">全部</option>
									<c:forEach var="item" items="${operationTypes}">
										<option value="${item.key}">
										${item.value}
										</option>
									</c:forEach>
								</select>
							</div>
						</td>
						<td class="f14 namewidth1" align="right">模块名称：</td>
						<td class="f14 namewidth2" align="left">
							<div class="pr">
								<select name="search_EQ_moduleName" class="select2">
									<option value="">
										全部
									</option>
									<c:forEach var="item" items="${moduleNames}">
										<option value="${item.key}">
											${item.value}
										</option>
									</c:forEach>
								</select>
							</div>
						</td>
						<td width="namewidth3">
							<a class="c_222 block cp fr ml10 globle_img mt8 mr20 more" title="展开"></a>
							<a href="javascript:void(0)" class="a_underline block_inline fr w_blue mt5 reset">清除</a>
							<a href="javascript:void(0)" class="block_inline c_white lh25 fr mr10 submit">
								<b class="allbtn_l block fl"></b>
								<b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b> 
							</a>
						</td>
					</tr>
					<tr class="more-content">
						<td class="f14 namewidth1" align="right">操作时间：</td>
						<td class="f14 namewidth2" align="left">
							<div class="vm">
								<input class="text_input2 input_close globle_img time"
									name="search_GTE_createdTime" type="text" readonly />-<input class="text_input2 input_close globle_img time"
									name="search_LTE_createdTime" type="text" readonly />
							</div>
						</td>
					</tr>
				</table>
				<tags:paginationparams page="${page}" />
			</form>
			<!--查询条件结束-->
			<div class="cb"></div>
			<div class="ml35 mr35 mt10 block cb cb">
		       <b class="b1"></b>
		       <b class="b2"></b>
		       <b class="b3"></b>
		       <b class="b4"></b>
		        <div class="ie_head" >
		            <ul class="fl id_table1 mt10 ml10">
		            <h1 class="f14 fbnone">审计日志列表</h1>
		            </ul>
		            <ul class="fr id_table1 mt10 mr10">
		            </ul>
		        </div>    
		    </div> 
			<div class="ml35 mr35">
			<!-- 浮动表头html开始 -->
			<div id="title" style="display: none; background-color: #f5f5f6;" class="mr35">
			<table class="cb id_table2 w">
				<tr>
					<th width="16%">模块名称</th>
					<th width="16%">记录名称</th>
					<th width="16%">操作类型</th>
					<th width="16%">操作人</th>
					<th width="16%" class="sortable orderby" orderby="createdTime">
						<span>操作时间</span>
					</th>
					<th width="16%">备注</th>
				</tr>
			</table>
			</div>
			<!-- 浮动表头html结束 -->
			<!--列表开始-->
			<table class="cb id_table2 w tablesorter">
				<tr id="recordDiv">
					<th width="16%">模块名称</th>
					<th width="16%">记录名称</th>
					<th width="16%">操作类型</th>
					<th width="16%">操作人</th>
					<th width="16%" class="sortable orderby" orderby="createdTime">
						<span>操作时间</span>
					</th>
					<th width="16%">备注</th>
				</tr>
				<tbody id="tbody" class="list"></tbody>
			</table>
				<div class="cb ml35 mt20 h40 pagination"></div>
                   <textarea id="template-tbody" class="template template-tbody">
		          {#foreach $T.result as row}
		          <tr class="{$T.row$index%2==1?'':'bg_c_blue'} row w">
		         	  <td>{$T.row.moduleName}</td>
		         	  <td>{$T.row.recordName}</td>
		              <td>
		              {#if $T.row.type==1}增加{#/if}
		              {#if $T.row.type==2}修改{#/if}
		              {#if $T.row.type==3}逻辑删除{#/if}
		              {#if $T.row.type==4}删除{#/if}
		              {#if $T.row.type==5}导入{#/if}
		              {#if $T.row.type==6}导出{#/if}
		              {#if $T.row.type==7}授权{#/if}
		              {#if $T.row.type==8}重置密码{#/if}
		              {#if $T.row.type==9}启用用户{#/if}
		              {#if $T.row.type==10}禁用用户{#/if}
		              {#if $T.row.type==11}修改密码{#/if}
		              {#if $T.row.type==12}物理删除{#/if}
		              {#if $T.row.type==13}恢复数据{#/if}
		              {#if $T.row.type==14}线索转客户{#/if}
		              </td>
		              <td>{$T.row.creator.realName}</td>
		              <td>{$T.row.createdTime}</td>
		              <td>{$T.row.remark}</td>
		          </tr>
		          {#/for} 
				</textarea>
			<%@include file="/WEB-INF/template/sort.jsp"%>
			<%@include file="/WEB-INF/template/pagination.jsp"%>
			</div>
			</div>
		</div>
	</body>
</html>



					