<%--
     回收站列表页
  author: huizijing
  Date:2014/7/8
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>回收站</title>
<link href="${ctx}/static/css/application.css?v=1" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/css/stressing/empower.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/css/recommend/list1.css?v=1" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/api/api.date.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript">
$(function() {
	jsUtil.datepicker(".time");//加载时间控件
	grid = new Grid().init().bindExport();
	
	//绑定还原按钮
	$("#recoveryData").click(function(){
		if($(":checkbox:checked").length == 0){
			jsUtil.alert("请选择要恢复的数据");
			return false;
		}
		jsUtil.confirm("确定要恢复数据吗?",function(){
			var ckAry = [];
			$("#tbody :checkbox:checked").each(function(){
				ckAry.push(this.value);
			});
            RcmsAjax.ajax("${ctx}/system/recyclebin/recovery.do",onLoad, null, $.param({id: ckAry }, true));
		});
	});
});
function onLoad(){
	setTimeout(function () {grid.loadGrid();}, 500);
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
	<body style="min-width: 1100px;">
		<div style="ml35 mr35 mt10 block cb cb">
		<b class="b1"></b>
	    <b class="b2"></b>
	    <b class="b3"></b>
	    <b class="b4"></b>
			<div class="listcontainer">
					<!--查询条件开始-->
					<form id="form" action="${ctx}/system/recyclebin/query.do"
						onsubmit="return false;">
						<table class="fl mt5 w">
							<tr>
								<td class="f14 namewidth1" align="right">
									操作人：
								</td>
								<td class="f14 namewidth2" align="left">
									<input type="text" id="txt_creator" readonly="readonly"
										class="text_input1" />
									<input type="text" id="hide_creator_id"
										name="search_EQ_creator.id" class="text_input1 none" />
									<i class="s_inquiry globle_img block_inline ml5 vm cp"
										title="搜索操作人" onclick="searchData('creator');"></i>
								</td>
								<td class="f14 namewidth1" align="right">
									模块名称：
								</td>
								<td class="f14 namewidth2" align="left">
									<div class="pr">
										<select name="search_EQ_moduleName" class="select2">
											<option value="">
												全部
											</option>
											<c:forEach var="item" items="${moduleNames}">
												<option value="${item.moduleName}">
													${item.moduleChineseName}
												</option>
											</c:forEach>
										</select>
									</div>
								</td>
								<td class="f14 namewidth1" align="right">操作时间：</td>
								<td class="f14 namewidth2" align="left">
									<div class="vm">
										<input class="text_input2 input_close globle_img time"
											name="search_GTE_createdTime" type="text" readonly />
										-
										<input class="text_input2 input_close globle_img time"
											name="search_LTE_createdTime" type="text" readonly />
									</div>
								</td>
								<td width="namewidth3">
									<a class="c_222 block cp fr ml10  mt8 mr20 " ></a>
									<a href="javascript:void(0)" class="a_underline block_inline fr w_blue mt5 reset">清除</a>
									<a href="javascript:void(0)" class="block_inline c_white lh25 fr mr10 submit">
										<b class="allbtn_l block fl"></b>
										<b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b> 
									</a>
								</td>

							</tr>
						</table>
						<tags:paginationparams page="${page}" />
					</form>
					<!--查询条件结束-->
					<div class="ml35 mr35 mt20 block cb cb">
						<b class="b1"></b>
					    <b class="b2"></b>
					    <b class="b3"></b>
					    <b class="b4"></b>
						<div class="ie_head">
							<ul class="fl id_table1 mt10 ml10">
								<li>
								<c:if test="${VS_HAS_FUNCTIONS.recycleRecovery}">
									<a class="block c_white lh25 mr10" href="javascript:;" id="recoveryData" uri="${ctx}/system/recyclebin/recovery.do?entityName=MarketActivity">
										<b class="allbtn_l block fl"></b>
										<b class="allbtn_r pr13 block fl w_auto f14">还&nbsp;&nbsp;原</b>
									</a>
								</c:if>
								</li>
		                		<li>
		                		<c:if test="${VS_HAS_FUNCTIONS.recycleDelete}">
		                			<a class="block c_white lh25 mr10 deletesome" id="deleteData" href="javascript:;"  uri="${ctx}/system/recyclebin/delete.do">
		                				<b class="allbtn_l block fl"></b>
		                				<b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b>
		                			</a>
		                		</c:if>
		                		</li>
		                	</ul>
			   				<ul class="fr id_table1 mt10 ml10">
								<c:if test="${VS_HAS_FUNCTIONS.recycleExport}">
									<li>
										<a href="javascript:;" uri="${ctx}/system/recyclebin/export.do?TYPE=selected" 
											class="leading_out globle_img block_inline mr10 export" title="导出"></a>
									</li>
								</c:if>
							</ul>
	                	</div>
                	</div>
					<div class="cb"></div>
					<!-- tab页签结束 -->
					<!-- 浮动表头html开始 -->
					<div class="ml35 mr35">
					<div id="title" style="display: none; background-color: #f5f5f6;" class="mr35">
						<table class="cb id_table2 w">
							<tr>
								<th width="10%"><input type="checkbox" class="checkall"/></th>
								<th width="16%">模块名称</th>
								<th width="16%">记录名称</th>
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
							<th width="10%"><input type="checkbox" class="checkall"/></th>
							<th width="16%">模块名称</th>
							<th width="16%">记录名称</th>
							<th width="16%">操作人</th>
							<th width="16%" class="sortable orderby" orderby="createdTime">
								<span>操作时间</span>
							</th>
							<th width="16%">备注</th>
						</tr>
						<tbody id="tbody" class="list"></tbody>
					</table>
					<div class="pagination cb ml35 mt20 h40 "></div>
                    <textarea id="template-tbody" class="template template-tbody">
			          {#foreach $T.result as row}
			          <tr class="{$T.row$index%2==1?'':'bg_c_blue'} row w">
			          	  <td><input type="checkbox" class="checkitem" name="id" value="{$T.row.id}"/></td>
			         	  <td>{$T.row.moduleName}</td>
			         	  <td>{$T.row.recordName}</td>
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



					