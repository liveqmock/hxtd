<%--
     回收站列表页
  author: xiaoli.luo
  Date:2014/6/4
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
	            	//每次选中tab页,清空查询条件
	            	formReSet();
	            	//每次选中tab页,将分页条页面置为1
	            	$("[name=hibernatePageNo]").val(1);
	            	
	            	var m = title.attr("name");
	            	var id = title.attr("id");
	            	//给隐藏的input复制
	            	$("#moduleName").val(m);
	            	//点击tab页,展示div
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
			<div class="margin0 ml35 mr35 listcontainer">
				<div class="w">
					<!--查询条件开始-->
					<form class="formclass" id="form" action="${ctx}/system/recyclebin/query.do" onsubmit="return false;">
						<!-- 默认,首次加载显示市场活动的回收站 -->
						<input type="hidden" name="type" id="moduleName" class="select2" value="MarketActivity"/>
						<table class="fl mt5 w">
							<tr>
								<td class="f14" align="right" width="6%">记录名称：</td>
								<td class="f14" align="left" width="16%">
									<input type="text" name="recordName" class="text_input1"/>
								</td>
								<td class="f14" align="right" width="6%">删除者：</td>
								<%--<td class="f14" align="left" width="16%">
									<input type="text" class="text_input1" id="operator" name="search_LIKE_operator.id" />
								</td>
								--%><td class="f14" align="left" width="16%">
									<input type="text" id="txt_modifier" readonly="readonly" class="text_input1"/>
									<input type="text" id="hide_modifier_id" name="deletorId" class="text_input1 none"/>
									<i class="s_inquiry globle_img block_inline ml5 vm cp" title="搜索操作人" onclick="searchData('modifier');"></i>
								</td>
								
								<td class="f14" align="right" width="7%">
									删除时间：
								</td>
								<td class="f14" align="left" width="18%">
									<div class="vm">
										<input class="text_input2 input_close globle_img time"
											name="GTE_modifiedTime" type="text" 
											readonly />-<input 
											class="text_input2 input_close globle_img time"
											name="modifiedTime" type="text" readonly />
									</div>
								</td>
								<td width="8%">
									<a href="javascript:void(0)" class=" block c_white lh25 submit">
										<b class="allbtn_l block fl"></b>
										<b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b>
									</a>
									<a class="reset block a_underline fr w_blue mt5" href="javascript:formReset()">清除</a>
								</td>
								<td class="f14" align="right" width="6%"></td>
								<td class="f14" align="left" width="4%"></td>
								
							</tr>
						</table>
						<tags:paginationparams page="${page}" />
					</form>
					<!--查询条件结束-->
					
					<!-- tab页签开始 -->
					<ul class="fl id_table3 w block cb mt10 tab-titles" style="border-bottom: 5px solid #626262; height: 32px;" fortabpanels id="tab-module">
						<li class="tab-title" fortabpanel="#tabs-market" id="market" name="MarketActivity">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">市场活动</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-lead" id="lead" name="Lead">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">线索</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-contact" id="contact" name="Contact">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">联系人</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-customer" id="customer" name="Customer">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">客户</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-supplier" id="supplier" name="Supplier">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">供应商</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-project" id="project" name="Project">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">项目</b>
						</li>
						<li class="tab-title" fortabpanel="#tabs-product" id="product" name="Product">
							<b class="h_tabbtn_l w25 block fl"></b>
							<b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">产品</b>
						</li>
					</ul>

					<div class="cb"></div>
					<!-- tab页签结束 -->
					<!-- 浮动表头html开始 -->
					<div id="title" style="display: none; background-color: #f5f5f6;" class="mr35">
						<table class="cb id_table2 w">
							<tr>
								<th width="4%"><input type="checkbox" class="checkall"/></th>
								<th width="10%">记录名称</th>
								<th width="9%">删除人</th>
								<th width="11%" class="sortable orderby" orderby="operateTime">
									<span>删除时间</span>
								</th>
							</tr>
						</table>
					</div>
					<!-- 浮动表头html结束 -->
					<!--列表开始-->
					<table class="cb id_table2 w tablesorter">
						<tr id="recordDiv">
							<th width="4%"><input type="checkbox" class="checkall"/></th>
							<th width="10%">记录名称</th>
							<th width="9%">删除者</th>
							<th width="11%" class="sortable orderby" orderby="operateTime">
								<span>删除时间</span>
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
							          	  <td><input type="checkbox" class="checkitem" value="{$T.row.id}"/></td>
							              <td>{$T.row.name}</td>
							              <td>{$T.row.modifier.realName}</td>
							              <td>{$T.row.modifiedTime}</td>
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



					