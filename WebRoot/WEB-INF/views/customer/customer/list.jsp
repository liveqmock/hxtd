<%--
  功能描述：客户管理列表页
  User: huizijing
  Date:2014/5/24
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>客户列表</title>
<link href="${ctx}/static/css/stressing/detail.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/api/api.date.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
<script type="text/javascript">${applicationScope.VC_PCAS}</script>
<script type="text/javascript">
$(function () {
	new PCAS("province","city","county"); // 省/市/县
	jsUtil.datepicker(".time"); // 加载时间控件
	grid = new Grid().init().bindExport(); // 首次加载数据
	
	$("#modifyOwner").click(function(){ // 更改所有者
		var box = $("input(name=id):checked");
		if(box.length==0){
			jsUtil.alert("请选择数据");
			return false;
		}
		var url, title;
		url = "${ctx}/system/user/toQueryPage.comp";
		title = "所有者";
		jsUtil.dialogIframe(url, title, 800, 465, convOwner);
	});
 	$("#delete").click(function () { // 给删除按钮绑定时间
			var boxs = $("input(name=id):checked");
			var param = $.param(boxs);
			if (boxs.length == 0) {
				jsUtil.alert("请选择数据");
				return false;
			}
			jsUtil.confirm('危险操作，确定要批量删除？', function () {
				RcmsAjax.ajax("${ctx}/customer/customer/delete.do",load,null,param);
			}, '警告');
		});
	});
	function convOwner(){
		var $userObj = $(".bor_e28d1f", window.frames["dialogIframe"].document);
		if($userObj.length > 0){
			var boxs = $("input(name=id):checked");
			var param = $.param(boxs)+"&ownerId=" + $userObj.attr("id");
			RcmsAjax.ajax(jsUtil.getRootPath() + '/customer/customer/modify.do?type=modifyOwner', function(){
				setTimeout(function () {load();}, 500);
				}, null, param);
		}
	}
	function load() { // 加载数据的方法
		grid.loadGrid();
	}
	function formReset() { // 表单重置
		$("#form")[0].reset();
		$("#cname").removeAttr("value");
	}
</script>
</head>
 <body>
<div class=" listcontainer">
	<!--查询条件开始-->
	<form id="form" action="${ctx}/customer/customer/query.do" onsubmit="return false;">
	<table class="fl mt5 w">
		<tr>
			<td class="f14 namewidth1" align="right">客户名称：</td>
			<td class="f14 namewidth2" align="left">
				<input type="text" id="cname" class="text_input1" name="search_LIKE_name" value="${name}" />
			</td>
			<td class="f14 namewidth1" align="right">客户类型：</td>
			<td class="f14 namewidth2" align="left">
				<select name="search_EQ_type.id" class="select2">
			     	<option value="">全部</option>
			     	<c:forEach items="${cType}" var="t">
			     		<option value="${t.id}">${t.key}</option>
			     	</c:forEach>
			    </select>
			</td>
			<td class="f14 namewidth1" align="right">客户来源：</td>
			<td class="f14 namewidth2" align="left">
				<select name="search_EQ_source.id" class="select2">
			     	<option value="">全部</option>
			     	<c:forEach items="${source}" var="s">
			     		<option value="${s.id}">${s.key}</option>
			     	</c:forEach>
			    </select>
			</td>
			<td width="namewidth3">
			      <a href="javascript:;" class="c_222 block cp fr ml10 packup globle_img mt8 mr20 more" title="展开"></a>
		          <a href="javascript:;" class="a_underline block_inline fr w_blue mt5 reset" >清除</a>
		          <a href="javascript:;" class="block_inline c_white lh25 fr mr10 submit">
		          	<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b>
		          </a>
		    </td>
		</tr>
		<tr class="more-content">
			<td class="f14" align="right">手机：</td>
	    	<td class="f14" align="left">
	    		<input class="text_input1"type="text" id="cmobile"  name="search_LIKE_mobile" value="${mobile}" />
			</td>
			<td class="f14" align="right">邮箱：</td>
	    	<td class="f14" align="left">
				<input type="text" class="text_input1"id="cemail"  name="search_LIKE_email" value="${email}" />
			</td>
			<td class="f14" align="right">行业：</td>
			<td class="f14" align="left">
				<select name="search_EQ_industry.id" class="select2">
			     	<option value="">全部</option>
			     	<c:forEach items="${industry}" var="industry">
			     		<option value="${industry.id}">${industry.key}</option>
			     	</c:forEach>
			    </select>
			</td>
			<td></td>
		</tr>
		<tr class="more-content">
			<td class="f14" align="right">省份：</td>
			<td class="f14" align="left" >
				<select id="province" name="search_EQ_province.id" class="select2"></select>
			</td>
			<td class="f14" align="right">城市：</td>
			<td class="f14" align="left" >
				<select id="city" name="search_EQ_city.id" class="select2"></select>
			</td>
			<td class="f14" align="right">区县：</td>
			<td class="f14" align="left">
				<select id="county" name="search_EQ_county.id" class="select2"></select>
			</td>
			<td></td>
		</tr>
		<tr class="more-content">
			<td class="f14" align="right">创建时间：</td>
		    <td class="f14" align="left">
			    <div class="vm">
					<input class="text_input2 input_close globle_img time" name="search_GTE_createdTime" type="text" readonly/>-<input 
			     		class="text_input2 input_close globle_img time" name="search_LTE_createdTime" type="text" readonly/>
			    </div>
		    </td>
			<td class="f14" align="right">修改时间：</td>
	    	<td class="f14" align="left">
			    <div class="vm">
					<input class="text_input2 input_close globle_img time" name="search_GTE_modifiedTime" type="text" />-<input 
						class="text_input2 input_close globle_img time" name="search_LTE_modifiedTime" type="text" />
			    </div>
	    	</td>
	    	<td></td>
	    	<td></td>
		</tr>
	</table>
	<tags:paginationparams page="${page}"></tags:paginationparams>
	</form> 
	<!--查询条件结束-->
	<div class="cb"></div>
	<!--列表开始-->
	<div class="ml35 mr35 mt20 block cb cb">
		<b class="table_headl globle_img block fl"></b>
		<div class="fl table_headc fl w99b">
			<div class="ie_head">
				<ul class="fl id_table1 mt10 ml10">
					<li>
					<c:if test="${VS_HAS_FUNCTIONS.customerDelete}">
						<a href="javascript:void(0);" uri="${ctx}/customer/customer/delete.do" class="block c_white lh25 deletesome mr10">
							<b class="allbtn_l block fl"></b>
							<b class="allbtn_r pr13 block fl w_auto f14 ">删&nbsp;&nbsp;除</b>
						</a>
					</c:if>
					</li>
					<li>
					<c:if test="${VS_HAS_FUNCTIONS.customerAdd}">
						<a href="${ctx}/customer/customer/toAddPage.do" class="block c_white lh25 mr10">
							<b class="allbtn_l block fl"></b>
							<b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b>
						</a>
					</c:if>
					</li>
					<li>
						<a href="javascript:;" id="modifyOwner" class="block c_white lh25 mr10">
							<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">更改所有者</b>
						</a>
					</li>
					<li>
						<a href="javascript:;" class="refresh block c_white lh25 fr mr10">
							<b class="allbtn_l block fl"></b>
							<b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b>
						</a> 
					</li>
				</ul>
				<ul class="fr id_table1 mt10 ml10">
						<c:if test="${VS_HAS_FUNCTIONS.customerImport}">
							<li>
								<a href="${ctx}/customer/imports/toImportPage.do?module=customer"
									class="leading_in globle_img block_inline mr10" title="导入"></a>
							</li>
						</c:if>
						<c:if test="${VS_HAS_FUNCTIONS.customerExport}">
							<li>
								<a href="javascript:;" uri="${ctx}/customer/customer/export.do?TYPE=selected" 
									class="leading_out globle_img block_inline mr10 export" title="导出"></a>
							</li>
						</c:if>
				</ul>
			</div>
		</div>
		<b class="table_headr globle_img block fl"></b>
	</div>
	<div id="title" style="display: none;background-color: #f5f5f6;" class=" ml35 mr35">
		<table class="cb id_table2 w" >
			<tr>
				<th width="4%"><input type="checkbox" id="id" class="checkall"/></th>
				<th width="7%">客户名称 </th>
				<th width="7%">客户所有者</th>
				<th width="7%">客户类型</th>
				<th width="7%">风险等级</th>
				<th width="9%">公司名称</th>
				<th width="9%">手机</th>
				<th width="9%">电话</th>
				<th width="7%">创建者</th>
				<th width="11%" class="sortable orderby" orderby="createdTime">创建时间</th>
				<th width="11%" class="sortable orderby" orderby="modifiedTime">最后修改时间</th>
				<th width="10%" align="center">操作</th>
			</tr>
		</table>
	</div>
    <div class="ml35 mr35" >
        <table class="cb id_table2 w pr35" id="table">
			<tr id="recordDiv"align="left">
				<th width="3%"><input type="checkbox" id="id" class="checkall"/></th>
				<th width="7%">客户名称 </th>
				<th width="7%">客户所有者</th>
				<th width="7%">客户类型</th>
				<th width="7%">风险等级</th>
				<th width="9%">公司名称</th>
				<th width="9%">手机</th>
				<th width="9%">电话</th>
				<th width="7%">创建者</th>
				<th width="11%" class="sortable orderby" orderby="createdTime">创建时间</th>
				<th width="11%" class="sortable orderby" orderby="modifiedTime">最后修改时间</th>
				<th width="10%" align="center">操作</th>
			</tr>
			<tbody id="tbody" class="list"></tbody>
		</table>
        <div class="cb ml35 mt20 h40 pagination"></div>
        <textarea id="template-tbody" class="template template-tbody">
            {#foreach $T.result as row}
            <tr class="{$T.row$index%2==1?'':'bg_c_blue'}">
                <td><input type="checkbox" name="id" class="checkitem" value="{$T.row.id}"/></td>
                <td>
                    <c:choose>
                        <c:when test="${VS_HAS_FUNCTIONS.customerView}">
                        <a href="${ctx}/customer/customer/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.name}</a></c:when>
                        <c:otherwise>{$T.row.name}</c:otherwise>
                    </c:choose>
                </td>
                <td>{$T.row.owner.realName}</td>
                <td>{$T.row.type.key}</td>
                <td>{$T.row.riskGrade.key}</td>
                <td>{$T.row.company}</td>
                <td>{$T.row.mobile}</td>
                <td>{$T.row.phone}</td>
                <td>{$T.row.creator.realName}</td>
                <td>{$T.row.createdTime}</td>
                <td>{$T.row.modifiedTime}</td>
                <td align="center">
                <c:if test="${VS_HAS_FUNCTIONS.customerView}">
                	<a href="${ctx}/customer/customer/toViewPage.do?id={$T.row.id}" title="详情" 
                		class=" block_inline s_detail_btn globle_img ml10"></a>
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.customerModify}">
                	<a href="${ctx}/customer/customer/toViewPage.do?id={$T.row.id}&type=edit" title="编辑" 
                		class=" block_inline s_edit_btn globle_img ml10"></a>
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.customerDelete}">
                	<a href="javascript:void(0)" uri="${ctx}/customer/customer/delete.do?id={$T.row.id}" title="删除" 
                		class=" block_inline s_dump_btn globle_img ml10 delete"></a>
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
