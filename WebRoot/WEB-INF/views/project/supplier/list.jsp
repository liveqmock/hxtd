<%--
  供应商描述：供应商管理列表页
  supplier: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>供应商列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<!-- 浮动表头js -->
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript">
        $(function () {
            //加载时间控件
            jsUtil.datepicker(".time");
            //全选/全不选
            $("#id").click(function () {
                if (this.checked) {
                    $("input:checkbox").attr("checked", true);
                } else {
                    $("input:checkbox").removeAttr("checked");
                }
            });
            $(".list :checkbox").live("click", function (e) {
                $(".checkall").attr("checked", $(".list :checkbox:not(:checked)").length == 0);
                e.stopPropagation();//jquery 阻止冒泡事件
            });
            //给刷新按钮绑定重新加载的事件
            $("#reload").click(load);
            //首次加载数据
            grid = new Grid().init();
        });
        //加载数据的方法
        function load() {
            //$("#id").removeAttr("checked");
            //jsUtil.page.loadData('050101',result2html);
            grid.loadGrid();
        }
        function formReset() {
            $("#form")[0].reset();
        }
    </script>
</head>
<body>
<div class="listcontainer">
	<form id="form" action="${ctx}/project/supplier/query.do" onsubmit="return false;">
    <table class="fl mt5 w">
  	<tr>
    <td class="f14" align="right" width="7%">供应商名：</td>
    <td class="f14" align="left" width="13%"><input type="text" class="text_input1" name="search_LIKE_name" value="" /></td>
    <td class="f14" align="right" width="7%">修改时间：</td>
    <td class="f14" align="left" width="18%">
    			<div class="pr vm">
	    			<a href="javascript:;" class="pa time_closenone1" onclick="javascript:$(this).nextAll().eq(1).val('');"></a>
	    			<a href="javascript:;" class="pa time_closenone2" onclick="javascript:$(this).nextAll().eq(1).val('');"></a>
	    			<input class="text_input2 input_close globle_img time" name="search_GTE_modifiedTime" type="text" readonly/>
	    			-<input class="text_input2 input_close globle_img time" name="search_LTE_modifiedTime" type="text" readonly/>
    			</div>
    </td>
    <td class="f14" align="right" width="7%">供应商类型：</td>
    <td class="f14" align="left" width="13%">
    <select name="search_EQ_type.id" class="select2">
    	<option value="">--全部--</option>
    	<c:forEach items="${dict}" var="d">
    		<option value="${d.id}">${d.key}</option>
    	</c:forEach>
    </select>
    </td>
    <td width="15%" >
    <a href="javascript:void(0)" class="ml35 block c_white lh25 submit"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp&nbsp询</b></a>
    <a href="javascript:formReset()" class="reset block dump_btn globle_img fl ml10"></a>
    </td>
    <td class="f14" align="right" width="7%"></td>
						<td class="f14" align="left" width="13%"></td>
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
	<c:if test="${VS_HAS_FUNCTIONS.supplierDelete}">
	<li>
	<a href="javascript:void(0)" uri="${ctx}/project/supplier/delete.do"  class="block c_white lh25 deletesome"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b></a>
	</li>
	</c:if>
	<c:if test="${VS_HAS_FUNCTIONS.supplierAdd}">
	<li>
	<a href="${ctx}/project/supplier/toAddPage.do" class="block c_white lh25 ml10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b></a>
	</li>
	</c:if>
	<li>
	<a href="javascript:void(0)"  class="submit block c_white lh25 ml10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b></a>
	</li>
	</ul>
	</div>
	</div>
	<div id="title" style="display: none;background-color: #f5f5f6;" class=" ml35 mr35">
					<table  class="cb id_table2 w">
							<tr>
					<th><input type="checkbox"  id="id" class="checkall"/></th>
                <th>供应商名</th>
                <th>供应商类型</th>
                <th>电话</th>
                <th>手机</th>
                <th>传真</th>
                <th width="15%" class="sortable orderby" orderby="createdTime">创建时间 </th>
                <th>创建者</th>
                <th width="15%" class="sortable orderby" orderby="modifiedTime">修改时间</th>
                <th>修改者</th>
                <th width="15%">操作</th>  
</tr>
					</table>
				</div>
    <div class="content ml35 mr35">
        <table class="tablesorter cb id_table2 w pr35">
            <thead>
            <tr id="recordDiv">
                <th><input type="checkbox"  id="id" class="checkall"/></th>
                <th>供应商名</th>
                <th>供应商类型</th>
                <th>电话</th>
                <th>手机</th>
                <th>传真</th>
                <th width="15%" class="sortable orderby" orderby="createdTime">创建时间 </th>
                <th>创建者</th>
                <th width="15%" class="sortable orderby" orderby="modifiedTime">修改时间</th>
                <th>修改者</th>
                <th width="15%">操作</th>
            </tr>
            </thead>
            <tbody class="list"></tbody>
        </table>
        <div class="pagination  cb ml35 mt20 h40 "></div>
        <textarea id="template-tbody" class="template template-tbody">
            {#foreach $T.result as row}
            <tr class="{$T.row$index%2==1?'':'bg_c_blue'} row w">
                <td><input type="checkbox" name="id" class="checkitem" value="{$T.row.id}"/></td>
                <td>
                    <c:choose>
                        <c:when test="${VS_HAS_FUNCTIONS.supplierView}"><a href="${ctx}/project/supplier/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.name}</a></c:when>
                        <c:otherwise>{$T.row.name}</c:otherwise>
                    </c:choose>
                </td>
                <td>{$T.row.type.key}</td>
                <td>{$T.row.phone}</td>
                <td>{$T.row.mobile}</td>
                <td>{$T.row.fax}</td>
                <td>{$T.row.createdTime}</td>
                <td>{$T.row.creator.realName}</td>
                <td>{$T.row.modifiedTime}</td>
                <td>{$T.row.modifier.realName}</td>
                <td align="center">
                        <c:if test="${VS_HAS_FUNCTIONS.supplierView}">
                            <a href="${ctx}/project/supplier/toViewPage.do?id={$T.row.id}" title="详情" class=" s_detail_btn block_inline  globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.supplierModify}">
                          <a href="${ctx}/project/supplier/toModifyPage.do?id={$T.row.id}" title="编辑" class=" block_inline s_edit_btn globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.supplierDelete}">
                            <a href="javascript:void(0)" uri="${ctx}/project/supplier/delete.do?id={$T.row.id}" title="删除" class=" block_inline s_dump_btn globle_img ml10 delete"></a>
                        </c:if>
                        <div class="clear"></div>
                </td>
            </tr>
            {#/for} 
        </textarea>
        <%@include file="/WEB-INF/template/sort.jsp" %>
        <%@include file="/WEB-INF/template/pagination.jsp" %>
        <div id="tableFoot"></div>
    </div>
</div>
</body>
</html>
