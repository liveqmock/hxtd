<%--
  功能描述：线索管理列表页
  User: xiaoli.luo
  Date:2014/5/17
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>线索列表</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css" />
<link href="${ctx}/static/css/application.css?v=1" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/pacs.js"></script>
<script type="text/javascript">${applicationScope.VC_PCAS}</script>
<script type="text/javascript">
$(function() {
	jsUtil.datepicker(".time");//加载时间控件
	$("#modifyOwner").click(function() {
		var box = $("input(name=id):checked");
		if (box.length == 0) {
			jsUtil.alert("请选择数据");
			return false;
		}
		var url, title;
		url = "${ctx}/system/user/toSearchUserPage.docomp";
		title = "所有者";
		jsUtil.dialogIframe(url, title, 800, 420, convOwner);
	});
	new PCAS("province","city","county");
	//首次加载数据
	grid = new Grid().init().bindExport();
});
function converter(id){
	jsUtil.confirm("是否转换为客户",function(){
		RcmsAjax.ajax(jsUtil.getRootPath() + '/customer/lead/leadConverter.do',
				load, null, 'id='+id);
	},"线索转换")
}
function convOwner() {
	var $userObj = $(".bor_e28d1f", window.frames["dialogIframe"].document);
	if($userObj.length > 0){
		var $boxs = $("input(name=id):checked");
		var param = $.param($boxs) + "&ownerId=" + $userObj.attr("id");
		RcmsAjax.ajax(jsUtil.getRootPath() + '/customer/lead/modifyOwner.do', load, null, param);
	}
}
function load() {
	grid.loadGrid();
}
function reset() {
	$("#form")[0].reset();
	$(".time").val("");
}
</script>
</head>
<body>
	<div class="listcontainer">
		<form id="form" action="${ctx}/customer/lead/query.do" onsubmit="return false;">
		<table class="fl mt10 w">
			<tr>
				<td class="f14 namewidth1" align="right">线索名称：</td>
				<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_name" id="name"/></td>
				<td class="f14 namewidth1" align="right">邮箱：</td>
				<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_email" id="name"/></td>
				<td class="f14 namewidth1" align="right">线索来源：</td>
				<td class="f14 namewidth2" align="left" >
					<select name="search_EQ_source.id" class="select2">
						<option value="">全部</option>
						<c:forEach items="${source}" var="d">
							<option value="${d.id}">${d.key}</option>
						</c:forEach>
					</select>
				</td>
				<td class="namewidth3">
					<a class="c_222 block cp fr ml10 globle_img mt8 mr20 more" title="展开"></a>
					<a href="javascript:;" class="a_underline block_inline fr w_blue mt5 reset">清除</a>
					<a href="javascript:;" class="block_inline c_white lh25 fr mr10 submit">
						<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b>
					</a>
				</td>
			</tr>
			<tr class="more-content">
				<td class="f14 namewidth1" align="right">手机：</td>
				<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_mobile" id="name"/></td>
				<td class="f14 namewidth1" align="right">线索状态：</td>
				<td class="f14 namewidth2" align="left" >
					<select name="search_EQ_status.id" class="select2">
						<option value="">全部</option>
						<c:forEach items="${status}" var="d">
							<option value="${d.id}">${d.key}</option>
						</c:forEach>
					</select>
				</td>
				<td class="f14 namewidth1" align="right">行业：</td>
				<td class="f14 namewidth2" align="left" >
					<select name="search_EQ_industry.id" class="select2">
						<option value="">全部</option>
						<c:forEach items="${industry}" var="d">
							<option value="${d.id}">${d.key}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr class="more-content">
				<td class="f14 namewidth1" align="right">省：</td>
				<td class="f14 namewidth2" align="left"><select id="province" name="search_EQ_province.id" class="select2"></select></td>
				<td class="f14 namewidth1" align="right">市：</td>
				<td class="f14 namewidth2" align="left"><select id="city" name="search_EQ_city.id" class="select2"></select></td>
				<td class="f14 namewidth1" align="right">区/县：</td>
				<td class="f14 namewidth2" align="left"><select id="county" name="search_EQ_county.id" class="select2"></select></td>
			</tr>
			<tr class="more-content">
				<td class="f14 namewidth1" align="right">修改时间：</td>
				<td class="f14 namewidth2" align="left">
					<div class="pr vm">
						<input type="text" name="search_GTE_modifiedTime" readonly class="text_input2 input_close globle_img time"/>-<input 
							class="text_input2 input_close globle_img time" name="search_LTE_modifiedTime" type="text" readonly/>
					</div>
				</td>
				<td class="f14 namewidth1" align="right">创建时间：</td>
				<td class="f14 namewidth2" align="left" >
					<div class="pr vm">
						<input type="text" name="search_GTE_createdTime" class="text_input2 input_close globle_img time" readonly/>-<input 
							type="text" name="search_LTE_createdTime" class="text_input2 input_close globle_img time" readonly/>
					</div>
				</td>
			</tr>
		</table>
		<tags:paginationparams page="${page}"></tags:paginationparams>
	</form>
	<div class="cb"></div>
	<div class="ml35 mr35 mt10 block cb cb">
		<b class="b1"></b>
		<b class="b2"></b>
		<b class="b3"></b>
		<b class="b4"></b>
		<div class="ie_head">
			<ul class="fl id_table1 mt10 ml10">
				<c:if test="${VS_HAS_FUNCTIONS.leadDelete}">
					<li>
						<a href="javascript:;" uri="${ctx}/customer/lead/delete.do" class="deletesome block c_white lh25">
							<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b>
						</a>
					</li>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.leadAdd}">
					<li>
						<a href="${ctx}/customer/lead/toAddPage.do" class="block c_white lh25 ml10">
							<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b>
						</a>
					</li>
				</c:if>
				<li>
					<a href="javascript:;" class="refresh block c_white lh25 ml10">
						<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b>
					</a>
				</li>
				<c:if test="${VS_HAS_FUNCTIONS.leadModifyOwner}">
				<li>
					<a href="javascript:void(0)" id="modifyOwner" class="block c_white lh25 ml10">
						<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">更改所有者</b>
					</a>
				</li>
				</c:if>
			</ul>
			<ul class="fr id_table1 mt10 ml10">
				<c:if test="${VS_HAS_FUNCTIONS.leadImport}">
					<li>
						<a href="${ctx}/lead/imports/toImportPage.do?module=lead" class="leading_in globle_img block_inline mr10" title="导入"></a>
					</li>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.leadExport}">
					<li>
						<a href="javascript:;" uri="${ctx}/customer/lead/export.do?TYPE=selected"
							class="leading_out globle_img block_inline mr10 export" title="导出"></a>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
	<div id="title" style="display: none;z-index: 1; background-color: #f5f5f6;"
		class=" ml35 mr35">
		<table class="cb id_table2 w ">
			<tr>
				<th><input type="checkbox" name="" class="checkall" id="id"/></th>
				<th>线索名称</th>
				<th>所有者</th>
				<th>公司</th>
				<th>来源</th>
				<th>银行卡类型</th>
				<th width="4%">状态</th>
				<th width="4%">创建者</th>
				<th width="12%" class="sortable orderby" orderby="createdTime">创建时间</th>
				<th width="4%">修改者</th>
				<th width="12%" class="sortable orderby" orderby="modifiedTime">修改时间</th>
				<th width="12%" align="center">操作</th>
			</tr>
		</table>
	</div>
	<div class="ml35 mr35 content">
		<table class="cb id_table2 w tablesorter" id="table">
			<tr id="recordDiv">
				<th><input type="checkbox" name="" class="checkall" id="id" /></th>
				<th>线索名称</th>
				<th>所有者</th>
				<th>公司</th>
				<th>来源</th>
				<th>银行卡类型</th>
				<th width="4%">状态</th>
				<th width="4%">创建者</th>
				<th width="12%" class="sortable orderby" orderby="createdTime">创建时间</th>
				<th width="4%">修改者</th>
				<th width="12%" class="sortable orderby" orderby="modifiedTime">修改时间</th>
				<th width="12%" align="center">操作</th>
			</tr>
			<tbody class="list"></tbody>
		</table>
		<div class="pagination cb ml35 mt20 h40 "></div>
		<textarea id="template-tbody" class="template template-tbody">
          {#foreach $T.result as row}
          <tr class="{$T.row$index%2==1?'':'bg_c_blue'} row w">
              <td><input type="checkbox" name="id" class="checkitem" value="{$T.row.id}"/></td>
              <td>
                  <c:choose>
                      <c:when test="${VS_HAS_FUNCTIONS.leadView}">
							<a href="${ctx}/customer/lead/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.name}</a>
						</c:when>
                      <c:otherwise>{$T.row.name}</c:otherwise>
                  </c:choose>
              </td>
              <td>{$T.row.owner.realName}</td>
              <td>{$T.row.company}</td>
              <td>{$T.row.source.key}</td>
              <td>{$T.row.cardType.key}</td>
              <td>{$T.row.status.key}</td>
              <td>{$T.row.creator.realName}</td>
              <td>{$T.row.createdTime}</td>
              <td>{$T.row.modifier.realName}</td>
              <td>{$T.row.modifiedTime}</td>
              <td align="center">
                      <c:if test="${VS_HAS_FUNCTIONS.leadView}">
                          <a href="${ctx}/customer/lead/toViewPage.do?id={$T.row.id}" title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
                      </c:if>
                      <c:if test="${VS_HAS_FUNCTIONS.leadModify}">
                          <a href="${ctx}/customer/lead/toModifyPage.do?id={$T.row.id}" title="编辑" class=" block_inline s_edit_btn globle_img ml10"></a>
                      </c:if>
                      <c:if test="${VS_HAS_FUNCTIONS.leadDelete}">
                          <a href="javascript:;" uri="${ctx}/customer/lead/delete.do?id={$T.row.id}" title="删除" class="delete block_inline s_dump_btn globle_img ml10"></a>
                      </c:if>
                      <c:if test="${VS_HAS_FUNCTIONS.leadConverter}">
                        <a href="javascript:;" title="转换为客户" onclick="converter({$T.row.id});" class="block_inline s_change globle_img ml10"></a>
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
