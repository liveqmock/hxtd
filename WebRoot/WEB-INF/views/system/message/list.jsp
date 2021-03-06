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
<title>系统消息列表</title>
<link href="${ctx}/static/css/stressing/empower.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript">
$(function () {
	//加载时间控件
	jsUtil.datepicker(".time");
 
    //var grid = new Grid().init().bindExport();
    new Grid().init({gridName: "send", gridSelector: ".send", resultTemplateId: "send-template"});
    new Grid().init({gridName: "accept", gridSelector: ".accept", resultTemplateId: "accept-template"});
    $C.tab({onSelected: function (event, title, panel) {
                 $("[name=hibernatePageNo]").val(1);
            },
            defaultSelected: window.location.href.indexOf("send") > -1 ? 1 : 0
        }
    );
});
</script>
</head>
<body>
<div class=" listcontainer">
<form id="form" action="${ctx}/system/message/query.do" onsubmit="return false;">
    <table class="fl mt10 w">
        <tr>
            <td class="f14 namewidth1" align="right">消息名称：</td>
            <td class="f14 namewidth2" align="left">
                <input type="text" maxlength="30" id="typeId" class="text_input1" name="search_LIKE_message.title" value="${userMessage.message.title}"/>
            </td>
            <td class="f14 namewidth1" align="right">时间：</td>
            <td class="f14 namewidth2" align="left">
                <div class="vm">
                    <input class="text_input2 input_close globle_img time" name="search_GTE_createdTime" type="text" readonly/>-<input 
                           class="text_input2 input_close globle_img time" name="search_LTE_createdTime" type="text" readonly/>
                </div>
            </td>
            <td width="namewidth3">
                <a href="javascript:;" class="c_222 block cp fr ml10 globle_img mt8 mr20 "></a>
                <a href="javascript:void(0);" class="a_underline block_inline fr w_blue mt5 reset" >清除</a>
                <a href="javascript:void(0);" class="block_inline c_white lh25 fr mr10 submit"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b></a>
    		</td>
            <td class="f14 namewidth1" align="right"></td>
            <td class="f14 namewidth2" align="left"></td>
            <input type="hidden" name="hh" value=${hh}/>
            <tags:paginationparams page="${page}"/>
        </tr>
    </table>
</form>
<div class="cb"></div>
<div class="ml35 mr35">
    <ul class="fl id_table3 w block cb mt10 tab-titles" style="border-bottom:5px solid #626262; height:32px;" fortabpanels>
        <li class="tab-title" fortabpanel="#tabs-recived" id="recived">
            <b class="h_tabbtn_l w25 block fl"></b>
            <b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">接收消息</b>
        </li>
        <li class="tab-title" fortabpanel="#tabs-send" id="send">
            <b class="h_tabbtn_l w25 block fl"></b>
            <b class="h_tabbtn_r  pr25 w_auto f14 block fr lh32 cp id_nav pr">已发消息</b>
        </li>
        <ul class="fr id_table1  ml10">
            <li>
                <c:if test="${VS_HAS_FUNCTIONS.messageDelete}">
                    <a href="javascript:void(0)" uri="${ctx}/system/message/delete.do" class="block c_white lh25 fr mr10  deletesome">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14 ">删&nbsp;&nbsp;除</b></a>
                </c:if>
            </li>
            <li><c:if test="${VS_HAS_FUNCTIONS.messageAdd}">
                <a href="${ctx}/system/message/toAddPage.do" class="block c_white lh25 mr10">
                    <b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b></a></c:if></li>
            <li>
                <a href="javascript:;" class="refresh block c_white lh25 fr mr10">
                    <b class="allbtn_l block fl"></b>
                    <b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b>
                </a>
            </li>
        </ul>
    </ul>
<div class="w cb tab-panels">
    <!--接收消息-->
    <div id="tabs-recived" class="tab-panel ">
        <table class="cb id_table2 w pr35 accept" forform="form" formaction="${ctx}/system/message/query.do?type=recived" forpagination="#tabs-recived .pagination">
           <tr class="header">
              <th width="5%"><input type="checkbox" class="checkall"/>&nbsp;&nbsp;&nbsp;&nbsp;</th>
              <th width="24%">系统消息名称</th>
              <th width="19%">发送者</th>
              <th width="19%" class="sortable orderby" orderby="createdTime">接收时间</th>
              <th width="19%">接收者</th>
              <th align="center" width="12%">操作</th>
           </tr>
           <tbody class="list"></tbody>
        </table>
        <div class="cb ml35 mt20 h40 pagination"></div>
        <textarea id="accept-template" class="template template-tbody">
            {#foreach $T.result as row}
            <tr class="{$T.row$index%2==1?'':'bg_c_blue w'}">
                <td>
                    <input type="checkbox" name="id" class="checkitem" value="{$T.row.id}"/>
                    <i class="{$T.row.status?'have_read globle_img block_inline':'no_read globle_img block_inline'}"></i>
                </td>
                <td align="left">
                    <c:choose>
                        <c:when test="${VS_HAS_FUNCTIONS.messageView}">
                        <div class="pr">
							<a href="${ctx}/system/message/toViewPage.do?id={$T.row.id}">{$T.row.message.title.decodeHTML()}</a>
                                <span class="none w240" id="test1">     
									<i class="block globle_img pa tan_leftjian"></i>
									<b class="bb1"></b>
									<b class="bb2"></b>
									<b class="bb3"></b>
									<b class="bb4"></b>
									<b class="bb5"></b>
									<b class="bb5"></b>
									<div style="background-color:#fff;width:238px; height:100%; border-left:1px solid #666666; border-right:1px solid #666666;">
									<h1>名称：</h1>
									<p class="fbnone">{$T.row.message.title.decodeHTML()}</p>
									<h1>内容：</h1>
									<p class="fbnone">{$T.row.message.content.decodeHTML()} </p>
									<h1>接收时间：</h1>
									<p class="fbnone"> {$T.row.createdTime}</p>
									</div>
									<b class="bb6"></b>
									<b class="bb6"></b>
									<b class="bb6"></b>
									<b class="bb6"></b>
									<b class="bb7"></b>
									<b class="bb8"></b>
									<b class="bb9"></b>
									<b class="bb0"></b>
                                </span>
                            </div>
                        </c:when>
                        <c:otherwise>{$T.row.message.title}</c:otherwise>
                    </c:choose>
                </td>
                <td>
		 			<c:choose>
		            <c:when test="${userMessage.message.creator.id==null}">系统发送</c:when>
		            <c:otherwise>${userMessage.message.creator.realName}</c:otherwise>
		            </c:choose>	
				</td>
                <td>{$T.row.createdTime}</td>
                <td>{$T.row.user.realName}</td>
                <td align="left">
                    <c:if test="${VS_HAS_FUNCTIONS.messageView}">
                        <a href="${ctx}/system/message/toViewPage.do?id={$T.row.id}" title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
                    </c:if>
                    <c:choose>
		            <c:when test="${userMessage.message.creator.createdTime==null}"></c:when>
		            <c:otherwise>
					<c:if test="${VS_HAS_FUNCTIONS.messageModify}">
                        <a href="${ctx}/system/message/toViewPage.do?id={$T.row.id}&type=edit" title="回复" class=" block_inline s_reply globle_img ml10"></a>
                    </c:if>
					</c:otherwise>
		            </c:choose>	
                    
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
    <!--已发消息-->
    <div id="tabs-send" class="tab-panel ">
        <table class="cb id_table2 w pr35 send" forform="form" formaction="${ctx}/system/message/query.do?type=send" forpagination="#tabs-send .pagination">
            <tr class="header">
                <th width="5%">
                    <input type="checkbox" class="checkall"/>
                </th>
                <th width="24%">
                   	 系统消息名称
                </th>
                <th width="19%">
                  	  发送者
                </th>
                <th width="19%" class="sortable orderby" orderby="createdTime">
                   	 发送时间
                </th>
                <th width="19%">
                   	 接收者
                </th>
                <th align="center" width="12%">
                  	  操作
                </th>
            </tr>
            <tbody class="list"></tbody>
        </table>
        <div class="cb ml35 mt20 h40 pagination"></div>
        <textarea id="send-template" class="template template-tbody">
            {#foreach $T.result as row}
            <tr class="{$T.row$index%2==1?'':'bg_c_blue'}">
                <td align="center">
                    <input type="checkbox" name="id" class="checkitem" value="{$T.row.id}"/></td>
                <td>
                    <c:choose>
                    <c:when test="${VS_HAS_FUNCTIONS.messageView}">
                        <div class="pr">
                        	<a href="${ctx}/system/message/toViewPage.do?id={$T.row.id}">{$T.row.message.title.decodeHTML()}</a>
							<span class="none w240" id="test1">     
								<i class="block globle_img pa tan_leftjian"></i>
								<b class="bb1"></b>
								<b class="bb2"></b>
								<b class="bb3"></b>
								<b class="bb4"></b>
								<b class="bb5"></b>
								<b class="bb5"></b>
								<div style="background-color:#fff;width:238px; height:100%; border-left:1px solid #666666; border-right:1px solid #666666;">
								<h1>名称：</h1>
								<p class="fbnone">{$T.row.message.title.decodeHTML()}</p>
								<h1>内容：</h1>
								<p class="fbnone">{$T.row.message.content.decodeHTML()} </p>
								<h1>发送时间：</h1>
								<p class="fbnone"> {$T.row.createdTime}</p>
								</div>
								<b class="bb6"></b>
								<b class="bb6"></b>
								<b class="bb6"></b>
								<b class="bb6"></b>
								<b class="bb7"></b>
								<b class="bb8"></b>
								<b class="bb9"></b>
								<b class="bb0"></b>
							</span>
                          </div>
                        </c:when>
                        <c:otherwise>{$T.row.message.title}</c:otherwise>
                        </c:choose>
                        　              </td>
                <td>{$T.row.message.creator.realName}</td>
                <td>{$T.row.createdTime}</td>
                <td>{$T.row.user.realName}</td>
                <td align="center">
                    <c:if test="${VS_HAS_FUNCTIONS.messageView}">
                        <a href="${ctx}/system/message/toViewPage.do?id={$T.row.id}" title="详情" class=" block_inline s_detail_btn globle_img  ml10"></a>
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.messageModify}">
                        <a href="${ctx}/system/message/toViewPage.do?id={$T.row.id}&type=add" title="再次发送" class=" block_inline s_reply globle_img ml10"></a>
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
</div>
</div>
</body>
</html>