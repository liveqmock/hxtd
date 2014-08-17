<%--
  附件列表页
  autor: huizijing
  Date:2014/6/12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>附件列表</title>
    <link href="${ctx}/static/css/stressing/list1.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">${VS_JS_GLOBALINFO}${VR_JS_GLOBALINFO}</script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
	<!-- 浮动表头js -->
	<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
    <script type="text/javascript">
        $(function () {
            new Grid().init();
        });
         //加载时间控件
         jsUtil.datepicker(".time");
    </script>
    <script type="text/javascript">
     function formReset() {
            $("#form")[0].reset();
            $("#typeId").removeAttr("value");
        }
    </script>
	</head>
<body>
<div class=" listcontainer">
    <%--//TODO 关于查询条件值在SQL中转义--%>
    <form id="form" action="${ctx}/common/attach/query.do" onsubmit="return false;">
      <table class="fl mt5 w">
       <tags:paginationparams page="${page}"/> 
      <tr>
      <td class="f14" align="right" width="6%">附件名称：</td>
      <td class="f14" align="left" width="16%">
      <input id="typeId" type="text" name="search_LIKE_name" value="${name}"/>
      </td>
      <td class="f14" align="right" width="6%">上传时间：</td>
      <td class="f14" align="left"width="16%" >
      <div class="vm">
      <input class="text_input2 input_close globle_img time" name="search_GTE_createdTime" type="text" />-<input class="text_input2 input_close globle_img time" name="search_LTE_createdTime" type="text" />
      </div>
      </td>  
      <td width="11%">
      <a href="javascript:;" class="reset a_underline fr w_blue mt5">清除</a>
     <a href="javascript:;" class="block c_white lh25 fr ml10">
    				<b class="allbtn_l block fl"></b>
    				<b class="allbtn_r pr13 block fl w_auto f14 submit">查&nbsp;&nbsp;询</b>
    			</a>
	 
	</td>
      <td class="f14" align="right" width="6%"></td>
        <td class="f14" align="left" width="16%" ></td>
        <td class="f14" align="right" width="6%"></td>
        <td class="f14" align="left" width="16%" ></td>
        
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
         <li>   <c:if test="${VS_HAS_FUNCTIONS.attachmentDelete}">
         <a href="javascript:void(0)" uri="${ctx}/common/attachment/delete.do" class="block c_white lh25 fr mr10  deletesome">
         <b class="allbtn_l block fl "></b>
         <b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b></a> </c:if></li>
         <li>   <c:if test="${VS_HAS_FUNCTIONS.attachmentAdd}"><a href="${ctx}/common/attachment/toAddPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b></a></c:if></li>
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

<div id="title" style="display: none;background-color: #f5f5f6;" class=" ml35 mr35">
			<table  class="cb id_table2 w">
				<tr>
				<th width="2%" ><!-- <input type="checkbox" class="checkall"/> --></th>
                <th width="16%"  class="sortable orderby" orderby="name">附件名</th>
                <th width="28%" >存储地址</th>
                <th width="8%" >上传者</th>
                <th width="8%">修改者</th>
                <th width="12%"  class="sortable orderby" orderby="createdTime">上传时间</th>
                <th width="12%" class="sortable orderby" orderby="modifiedTime">修改时间</th>
                <th width="6%" align="center">操作</th>
				</tr>
			</table>
</div>

    <div class="ml35 mr35">
        <table class="cb id_table2 w pr35">
            <tr id="recordDiv">
                <th width="2%" ><!-- <input type="checkbox" class="checkall"/> --></th>
                <th width="16%"  class="sortable orderby" orderby="name">附件名</th>
                <th width="28%" >存储地址</th>
                <th width="8%" >上传者</th>
                <th width="8%">修改者</th>
                <th width="12%"  class="sortable orderby" orderby="createdTime">上传时间</th>
                <th width="12%" class="sortable orderby" orderby="modifiedTime">修改时间</th>
                <th width="6%" align="center">操作</th>
            </tr>
            <tbody class="list"></tbody>
        </table>
         <div class="cb ml35 mt20 h40 pagination"></div>

        <textarea id="template-tbody" class="template template-tbody">
            {#foreach $T.result as row}
            <tr class="{$T.row$index%2==1?'':'bg_c_blue w'}">
                <td align="center">
                <!-- <input type="checkbox" class="checkitem" value="{$T.row.id}"/> -->
                </td>
                
                <td ><a href="${ctx}/common/attach/toViewPage.do?id={$T.row.id}"> {$T.row.name}</a></td>
                 
                <td >{$T.row.address}</td>
                <td>{$T.row.creator.name}</td>
                <td>{$T.row.modifier.name}</td>
                <td >{$T.row.createdTime}</td>
                <td >{$T.row.modifiedTime}</td>
                <td align="center">
                    <ul>
                    <li><a href="${ctx}/common/attach/toViewPage.do?id={$T.row.id}" title="详情"class="block_inline s_detail_btn globle_img ml10"></a></li>
                        
                        <c:if test="${VS_HAS_FUNCTIONS.attachmentView}">
                            <li><a href="${ctx}/common/attach/toViewPage.do?id={$T.row.id}"><img src="${ctx}/static/images/tallssed.png" alt=""/></a></li>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.attachModify}">
                            <li><a href="${ctx}/common/attachment/toModifyPage.do?id={$T.row.id}"><img src="${ctx}/static/images/editimged.png" alt=""/></a></li>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.attachDelete}">
                            <li><a href="javascript:void(0)" class="delete" uri="${ctx}/common/attachment/delete.do?id={$T.row.id}"><img src="${ctx}/static/images/deleteimged.png" alt=""/></a></li>
                        </c:if>
                    </ul>
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