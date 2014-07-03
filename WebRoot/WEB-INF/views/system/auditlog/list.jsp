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
				  //选中/反选
	            var $menu2 = $("a.menu2");
	            $C.toggleClass($menu2, "allright2", "allnoright2");
	            $C.toggleBoolean($menu2, "checked");
	            $C.bindCheckAll($menu2, "div.menu2", ".function:checkbox");
	
	            var $menu1 = $("a.menu1");
	            $C.toggleClass($menu1, "allright", "allnoright");
	            $C.toggleBoolean($menu1, "checked");
	            $C.bindCheckAll($menu1, "div.menus1", "a.menu2", "click");
	
	           
	            $C.tab({onSelected:function(event,title,panel){
	            	formReSet();
	            	$("[name=hibernatePageNo]").val(1);
	            	var m = title.attr("name");
	            	var id = title.attr("id");
	            	$("#moduleName").val(m);
	            	$("#tab-div div div").attr("name","tabs-"+id);
	            	onLoad();
	            }})
			});
			function onLoad(){
				grid.loadGrid();
			}
			function formReSet(){
				$("#form")[0].reset();
			}
			function searchData(action){//搜索条件-操作人
				jsUtil.dialogIframe("${ctx}/system/user/toQueryPage.comp", "发起者", 800, 465, function(){// 确定回调
					var $ckObj = $(":checked", window.frames["dialogIframe"].document);
					if($ckObj.length > 0){
						$("#txt_" + action).val($ckObj.parent().next().text());
						$("#hide_" + action +"_id").val($ckObj.val());
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
				<div class="w">
					<!--查询条件开始-->
					<form id="form" action="${ctx}/system/auditlog/query.do" onsubmit="return false;">
						<!-- 默认,首次加载显示市场活动的审计日志 -->
						<input type="hidden" name="search_EQ_moduleName" id="moduleName" class="select2" value="市场活动"/>
						<table class="fl mt5 w">
							<tr>
								<td class="f14 namewidth1" align="right">操作人：</td>
								<td class="f14 namewidth2" align="left">
									<input type="text" id="txt_operator" readonly="readonly" class="text_input1"/>
									<input type="text" id="hide_operator_id" name="search_EQ_operator.id" class="text_input1 none"/>
									<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索操作人" onclick="searchData('operator');"></i>
								</td>
								<td class="f14 namewidth1" align="right">操作类型：</td>
								<td class="f14 namewidth2" align="left">
									<div class="pr">
										<select name="search_EQ_type.id" class="select2">
											<option value="">全部</option>
											<c:forEach var="item" items="${types}"> 
												<option value="${item.id}">${item.key}</option>
											</c:forEach>
										</select>
									</div>
								</td>
								<td class="f14 namewidth1" align="right">
									操作时间：
								</td>
								<td class="f14 namewidth2" align="left">
									<div class="vm">
										<input class="text_input2 input_close globle_img time"
											name="search_GTE_operateTime" type="text" 
											readonly />-<input 
											class="text_input2 input_close globle_img time"
											name="search_LTE_operateTime" type="text" readonly />
									</div>
								</td>
								<td width="namewidth3">
									<div class="c_222 block cp fr ml10  mt8 mr20" title=""></div>
									<a class="a_underline block_inline fr w_blue mt5 reset" href="javascript:formReset()">清除</a>
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
					
					
					
					<!-- tab页签开始 -->
					<ul class="fl id_table3 w block cb mt10 tab-titles" style="border-bottom: 5px solid #626262; height: 32px;" fortabpanels id="tab-module">
						<li class="tab-title" fortabpanel="#tabs-market" id="market" name="市场活动">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">市场活动</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-lead" id="lead" name="线索">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">线索</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-contact" id="contact" name="联系人">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">联系人</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-customer" id="customer" name="客户">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">客户</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-supplier" id="supplier" name="供应商">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">供应商</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-project" id="project" name="项目">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">项目</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-product" id="product" name="产品">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">产品</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-order" id="order" name="订单">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">订单</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-user" id="user" name="用户">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">用户</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-order" id="order" name="角色">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">角色</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-menu" id="menu" name="菜单">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">菜单</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-function" id="function" name="功能">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">功能</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-component" id="component" name="组件">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">组件</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-organization" id="organization" name="组织机构">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">组织机构</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-message" id="message" name="系统消息">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">消息</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-notice" id="notice" name="系统公告">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">公告</b>
						</li>
					</ul>

					<div class="cb"></div>
					<!-- tab页签结束 -->
					<!-- 浮动表头html开始 -->
					<div id="title" style="display: none; background-color: #f5f5f6;" class="mr35">
						<table class="cb id_table2 w">
							<tr>
								<th width="10%">操作人</th>
								<th width="9%">操作类型</th>
								<th width="9%">记录ID</th>
								<th width="9%">记录名称</th>
								<th width="11%" class="sortable orderby" orderby="operateTime">
									<span>操作时间</span>
								</th>
							</tr>
						</table>
					</div>
					<!-- 浮动表头html结束 -->
					<!--列表开始-->
					<table class="cb id_table2 w tablesorter">
						<tr id="recordDiv">
							<th width="10%">操作人</th>
							<th width="9%">操作类型</th>
							<th width="9%">记录ID</th>
							<th width="9%">记录名称</th>
							<th width="11%" class="sortable orderby" orderby="operateTime">
								<span>操作时间</span>
							</th>
						</tr>
						<tbody id="tbody" class="list"></tbody>
					</table>
					<div class="pagination cb ml35 mt20 h40 "></div>
					<div class="margin0 ml35 mr35" id="tab-div">
	        			<div class="w cb tab-panels">
	        				<div id="tabs-market" class="tab-panel">
				                <ul class="w">
				                    <textarea id="template-tbody" class="template template-tbody">
							          {#foreach $T.result as row}
							          <tr class="{$T.row$index%2==1?'':'bg_c_blue'} row w">
							              <td>{$T.row.operator.realName}</td>
							              <td>{$T.row.type.key}</td>
							              <td>{$T.row.recordId}</td>
							              <td>{$T.row.recordName}</td>
							              <td>{$T.row.operateTime}</td>
							          </tr>
							          {#/for} 
							      	</textarea>
				                </ul>
				            </div>
	        			</div>
        			</div>
					<%@include file="/WEB-INF/template/sort.jsp"%>
					<%@include file="/WEB-INF/template/pagination.jsp"%>
				</div>
				
			</div>
			<!--列表结束-->
		</div>
	</body>
</html>



					