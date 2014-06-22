<%--
  系统消息列表页
  role: huizijing
  Date:2014/6/4
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>系统消息列表页</title>
    <link href="${ctx}/static/css/stressing/empower.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
    <script type="text/javascript">
      
        function formReset() {
            $("#form")[0].reset();
            $("#typeId").removeAttr("value");
        }
         //加载时间控件
            jsUtil.datepicker(".time");
            
        $(function() {
            var grid = new Grid().init().bindExport();
        });
        
        //给刷新按钮绑定重新加载的事件
        $(function (){
            $("#reload").click(load);
        });
            
    </script>
</head>
<body>
<div class=" listcontainer">
    <%--//TODO 关于查询条件值在SQL中转义--%>
    <form id="form" action="${ctx}/system/message/query.do" onsubmit="return false;">
        <table class="fl mt5 w">
        <tr>
        <td class="f14" align="right" width="7%">消息名称：</td>
        <td class="f14" align="left" width="13%" ><input type="text" id="typeId" name="search_LIKE_message.title" value="${userMessage.message.title}"/></td>
              <input type="hidden" name="type" value="${type}">
         <td class="f14" align="right" width="7%">接收时间：</td>
         <td class="f14" align="left" width="18%">
         <div class="pr vm"><a href="javascript:;" title="清空" class="pa time_closenone1"onclick="javascript:$(this).nextAll().eq(1).val('');"></a>
         <a href="javascript:;" title="清空" class="pa time_closenone2" onclick="javascript:$(this).nextAll().eq(1).val('');"></a>
         <input class="text_input2 input_close globle_img time" name="search_GTE_createdTime" type="text" />-<input class="text_input2 input_close globle_img time" name="search_LTE_createdTime" type="text" />
         </div>
         </td>      
         <td width="15%">
	<a class="reset block dump_btn globle_img fr mr35" href="javascript:formReset()"></a>
	 <a href="javascript:void(0)" class="block c_white lh25 fr mr10 submit">
	<b class="allbtn_l block fl"></b>
	<b class="allbtn_r pr13 block fl w_auto f14">
	
	查&nbsp;&nbsp;询</b></a>
	 
	</td>
	     <td class="f14" align="right" width="7%"></td>
         <td class="f14" align="left" width="13%"></td>
         <td class="f14" align="right" width="7%"></td>
         <td class="f14" align="left" width="13%"></td>
        <tags:paginationparams page="${page}"/>
        </tr>
    </table>
    </form>
<!--查询条件结束-->
<div class="cb"></div>
<!--列表开始-->

    <div class="ml35 mr35 mt20 block cb cb">
    </div>
    
    <div class="ml35 mr35">
      
  <ul class="fl id_table3 w block cb mt10" style="border-bottom:5px solid #626262; height:32px;">
<li>
<b class="h_tabbtn_l w25 block fl"></b>
<b class="h_tabbtn_r c_white pr25 w_auto f14 block fr lh32 cp id_nav pr">接收信息 </b>
</li>
<li><a href="${ctx}/system/message/toQueryPage.do?type=send">

<b class="h_tabpitchbtn_l w25 block fl"></b>
<b class="h_tabpitchbtn_r c_222 pr25 w_auto f14 block fr lh32 cp id_nav pr">已发信息 </b></a>
</li>
 <ul class="fr id_table1  ml10">
<li>  <c:if test="${VS_HAS_FUNCTIONS.messageDelete}">
<a href="javascript:void(0)" uri="${ctx}/system/message/delete.do"  class="block c_white lh25 fr mr10  deletesome">
<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14 ">删&nbsp;&nbsp;除</b></a></c:if></li>
<li> <c:if test="${VS_HAS_FUNCTIONS.messageAdd}">
<a href="${ctx}/system/message/toAddPage.do"  class="block c_white lh25 mr10">
<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b></a></c:if></li>
 <li><a href="javascript:void(0)" id="reload" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b></a> </li>
<li><a href="javascript:void(0)" uri="${ctx}/system/message/export.do?TYPE=pagination&ty=recived" class="block c_white lh25 mr10 export"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">导&nbsp;&nbsp;出</b></a></li>
</ul>	
</ul>

      
        
<div id="title" style="display: none;background-color: #f5f5f6;" class=" ml35 mr35">
					<table  class="cb id_table2 w">
					<tr >
                <th width="5%"><input type="checkbox" class="checkall"/></th>
                <th width="34%">系统消息名称</th>
                <th width="19%">发送者</th>
                <th width="19%" class="sortable orderby" orderby="createdTime">接收时间</th>
                <th width="19%">接收者</th>
                
                <th align="center" width="12%">操作</th>
                     </tr>
                       </table>
</div>
        <table class="cb id_table2 w pr35">
            <tr id="recordDiv">
                <th width="5%"><input type="checkbox" class="checkall"/>&nbsp;&nbsp;&nbsp;&nbsp;</th>
                <th width="34%">系统消息名称</th>
                <th width="19%">发送者</th>
                <th width="19%" class="sortable orderby" orderby="createdTime">接收时间</th>
                <th width="19%">接收者</th>
                
                <th align="center" width="12%">操作</th>
            </tr>
            <tbody class="list"></tbody>
        </table>
         <div class="cb ml35 mt20 h40 pagination"></div>

        <textarea id="template-tbody" class="template template-tbody">
            {#foreach $T.result as row}
            <tr class="{$T.row$index%2==1?'':'bg_c_blue w'}">
                <td >
                <input type="checkbox" name="id" class="checkitem" value="{$T.row.id}"/>
                <i class="{$T.row.status?'have_read globle_img block_inline':'no_read globle_img block_inline'}"></i>
                </td>
             <td align="left">
                   <c:choose>
                		<c:when test="${VS_HAS_FUNCTIONS.messageView}">
                			<a   href="${ctx}/system/message/toViewPage.do?id={$T.row.id}&userName={$T.row.message.creater.name}">{$T.row.message.title}</a>
                		</c:when>
                		<c:otherwise>{$T.row.message.title}</c:otherwise>
                	</c:choose>
               </td>
                <td align="left">{$T.row.message.creater.realName}</td>
                <td>{$T.row.createdTime}</td>
                <td>{$T.row.user.realName}</td>
               
                <td align="left">
                        <c:if test="${VS_HAS_FUNCTIONS.messageView}">
                            <a href="${ctx}/system/message/toViewPage.do?id={$T.row.id}"title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
                        </c:if>    
                        <c:if test="${VS_HAS_FUNCTIONS.messageModify}">
                            <a href="${ctx}/system/message/toViewPage.do?id={$T.row.id}&type=edit" title="回复" class=" block_inline s_reply globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.messageDelete}">
                            <a href="javascript:void(0)" class=" block_inline s_dump_btn globle_img ml10 delete" title="删除" uri="${ctx}/system/message/delete.do?id={$T.row.id}"></a>
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