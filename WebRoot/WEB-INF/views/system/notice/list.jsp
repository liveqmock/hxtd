<%--
     公告列表页
  role: huizijing
  Date:2014/6/3
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>公告列表页</title>
    <link href="${ctx}/static/css/stressing/detail.css" rel="stylesheet" type="text/css" />
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
<div class=" listcontainer">
    <form id="form" action="${ctx}/system/notice/query.do" onsubmit="return false;">
      <table class="fl mt5 w">
       <tr>   
		<td class="f14 namewidth1" align="right">公告名称：</td>
		<td class="f14 namewidth2" align="left"><input type="text" class="text_input1" id="typeId" name="search_LIKE_title" value="${title}"/></td>
		<td class="f14 namewidth1" align="right">有效期：</td>
		<td class="f14 namewidth2" align="left">
		    <select name="type" class="select2">
		    <option value="all">全部</option>
		    <option >已发公告</option>
		    <option value="unsend">未发公告</option>
		    </select>
		</td>
		<td class="f14 namewidth1" align="right">发送时间：</td>
		<td class="f14 namewidth2" align="left">
		<div class="vm">
		<input class="text_input2 input_close globle_img time" name="search_GTE_sentTime" type="text" readonly/>-<input class="text_input2 input_close globle_img time" name="search_LTE_sentTime" type="text" readonly/>
		</div>
		</td>
		<td width="namewidth3">
		      <a href="javascript:void(0);" class="c_222 block cp fr ml10 packup globle_img mt8 mr20 more" title="展开"></a>
		      <a href="javascript:void(0);" class="a_underline block_inline fr w_blue mt5 reset" >清除</a>
		      <a href="javascript:void(0);" class="block_inline c_white lh25 fr mr10 submit"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b></a>
		</td>
	        <tags:paginationparams page="${page}"/>
	    </tr>  
	   </table>
	</form>
    <!--查询条件结束-->
<div class="cb"></div>
<!--列表开始-->
<div class="ml35 mr35 mt20 block cb cb">
<b class="table_headl globle_img block fl"></b>
	<div class="fl table_headc fl w99b">
		<div class="ie_head">
			<ul class="fl id_table1 mt10 ml10">
				<c:if test="${VS_HAS_FUNCTIONS.noticeDelete}">
				<li>
					<a href="javascript:;" uri="${ctx}/system/notice/delete.do" class="block c_white lh25 mr10 deletesome">
					<b class="allbtn_l block fl"></b>
					<b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b>
					</a>
				</li>
				</c:if>
				<c:if test="${VS_HAS_FUNCTIONS.noticeAdd}">
				<li>
					<a href="${ctx}/system/notice/toAddPage.do" class="block c_white lh25 add mr10">
					<b class="allbtn_l block fl"></b>
					<b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b>
					</a>
				</li>
				</c:if>
				<li>
					<a href="javascript:;" class="refresh block c_white lh25 fr mr10">
					<b class="allbtn_l block fl"></b>
					<b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b>
					</a>
				</li>
			</ul>
		</div>
	</div>
<b class="table_headr globle_img block fl"></b>
</div>
<!-- 浮动表头开始 -->
<div id="title" style="display: none;background-color: #f5f5f6;" class=" ml35 mr35">
	<table class="cb id_table2 w">
		<tr>
           <th align="center" width="5%" ><input type="checkbox" class="checkall"/></th>
           <th width="20%" class="sortable orderby" orderby="title">公告名称</th>
           <th width="15%">创建者</th>
           <th width="15%" class="sortable orderby" orderby="sentTime">发送时间</th>
           <th width="15%" class="sortable orderby" orderby="createdTime">创建时间</th>
           <th width="15%"class="sortable orderby" orderby="deadTime">过期时间</th>
           <th align="center" width="15%">操作</th>
        </tr>
    </table>
</div>
<!-- 浮动表头结束 -->
    <div class="ml35 mr35" > 
        <table id="table" class="cb id_table2 w pr35">
            <tr id="recordDiv">
                <th align="center" width="5%" ><input type="checkbox" class="checkall"/></th>
                <th width="20%" class="sortable orderby" orderby="title">公告名称</th>
                <th width="15%">创建者</th>
                <th width="15%" class="sortable orderby" orderby="sentTime">发送时间</th>
                <th width="15%" class="sortable orderby" orderby="createdTime">创建时间</th>
                <th width="15%"class="sortable orderby" orderby="deadTime">过期时间</th>
                <th align="center" width="15%">操作</th>
            </tr>
            <tbody id="tbody" class="list"></tbody>
        </table>
        <div class="cb ml35 mt20 h40 pagination"></div>
        <textarea id="template-tbody" class="template template-tbody">
            {#foreach $T.result as row}
            <tr class="{$T.row$index%2==1?'':'bg_c_blue w'}">
                <td align="center"><input type="checkbox" name="id" class="checkitem" value="{$T.row.id}"/></td>
                <td >
	<c:choose>
		<c:when test="${VS_HAS_FUNCTIONS.noticeView}">
			<a href="${ctx}/system/notice/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.title}
				<div class="none w240">
					<div class="w240 pr">
						<i class="block globle_img pa tan_leftjian"></i>
						<b class="bb1"></b>
						<b class="bb2"></b>
						<b class="bb3"></b>
						<b class="bb4"></b>
						<b class="bb5"></b>
						<b class="bb5"></b>
						<b class="bb5"></b>
						<b class="bb5"></b>
						<span class="block" style="background-color:#f5f5f6; 
								 width:238px; height:100%; border-left:1px solid #666666; border-right:1px solid #666666;">
						<span class=" block ml10 mr10">
						<h1>名称：</h1>
						<p class="fbnone">{$T.row.title}</p>
						<h1>内容：</h1>
						<p class="fbnone">{$T.row.content}</p>
						<h1>发送时间：</h1>
						<p class="fbnone"> {$T.row.sentTime}</p>
						<p></p>
						</span>
						</span>
						<b class="bb6"></b>
						<b class="bb6"></b>
						<b class="bb6"></b>
						<b class="bb6"></b>
						<b class="bb7"></b>
						<b class="bb8"></b>
						<b class="bb9"></b>
						<b class="bb0"></b>
					</div>
				</div>
			</a>
		</c:when>
		<c:otherwise>{$T.row.title}</c:otherwise>
	</c:choose>
                </td>
                <td>{$T.row.creater.realName}</td>
                <td >{$T.row.sentTime} </td>
                <td >{$T.row.createdTime}</td>
                <td >{$T.row.deadTime}</td>
                <td align="center">
                        <c:if test="${VS_HAS_FUNCTIONS.noticeView}">
                        <a href="${ctx}/system/notice/toViewPage.do?id={$T.row.id}" title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.noticeModify}">
                         <a href="${ctx}/system/notice/toViewPage.do?id={$T.row.id}&type=edit" title="编辑" class=" block_inline s_edit_btn globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.noticeDelete}">
                         <a href="javascript:void(0)"  uri="${ctx}/system/notice/delete.do?id={$T.row.id}" title="删除"class=" block_inline s_dump_btn globle_img ml10 delete"></a>
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