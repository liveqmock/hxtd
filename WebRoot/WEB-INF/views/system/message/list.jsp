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
<link href="${ctx}/static/css/stressing/empower.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script src="${ctx}/static/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<link href="${ctx}/static/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">
  function formReset() {
      $("#form")[0].reset();
      $("#typeId").removeAttr("value");
  }
  //加载时间控件
  jsUtil.datepicker(".time");

  $(function () {
      new Grid().init({containerSelector: ".accept"});
      new Grid().init({containerSelector: ".send"});
  });
</script>
</head>
<body>
<div class=" listcontainer">
<form id="form" action="${ctx}/system/message/query.do" onsubmit="return false;">
    <table class="fl mt5 w">
        <tr>
            <td class="f14" align="right" width="7%">消息名称：</td>
            <td class="f14" align="left" width="13%">
                <input type="text" id="typeId" name="search_LIKE_message.title" value="${userMessage.message.title}"/></td>
            <input type="hidden" name="type" value="${type}"></input>
            <td class="f14" align="right" width="7%">接收时间：</td>
            <td class="f14" align="left" width="18%">
                <div class="pr vm"><a href="javascript:;" class="pa time_closenone1"></a>
                    <a href="javascript:;" class="pa time_closenone2"></a>
                    <input class="text_input2 input_close globle_img time" name="search_GTE_createdTime" type="text"/>-<input class="text_input2 input_close globle_img time" name="search_LTE_createdTime" type="text"/>
                </div>
            </td>
            <td width="15%">
                <a class="reset block dump_btn globle_img fr mr35" href="javascript:formReset()"></a>
                <a href="javascript:void(0)" class="block c_white lh25 fr mr10 submit">
                    <b class="allbtn_l block fl"></b>
                    <b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b></a>
            </td>
            <td class="f14" align="right" width="7%"></td>
            <td class="f14" align="left" width="13%"></td>
            <td class="f14" align="right" width="7%"></td>
            <td class="f14" align="left" width="13%"></td>
            <tags:paginationparams page="${page}"/>
        </tr>
    </table>
</form>
<div class="cb"></div>
<div class="ml35 mr35 mt20 block cb cb"></div>
<div id="TabbedPanels1" class="TabbedPanels">
<ul class="fl id_table3 w block cb mt10" style="border-bottom: 5px solid #626262; height: 32px;">
    <li class="id_table3li2" tabindex="0">
        <b class="h_tabbtn_l w25 block fl"></b>
        <b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">接收信息 </b></li>
    <li class="id_table3li">
        <a href="${ctx}/system/message/toQueryPage.do?type=send">
            <b class="h_tabbtn_l w25 block fl"></b>
            <b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">已发信息 </b></a>
    </li>
</ul>
<div class="TabbedPanelsContentGroup">
    <div class="TabbedPanelsContent accept" forform="form" formaction="${ctx}/system/message/query.do?type=recived">
        <div class="ml35 mr35">

            <div id="title" style="display: none;background-color: #f5f5f6;" class=" ml35 mr35">
                <table class="cb id_table2 w">
                    <tr>
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
                    <td>
                        <input type="checkbox" name="id" class="checkitem" value="{$T.row.id}"/>
                    </td>
                    <td align="left">
                        <c:choose>
                            <c:when test="${VS_HAS_FUNCTIONS.messageView}">
                                <a href="${ctx}/system/message/toViewPage.do?id={$T.row.id}&userName={$T.row.message.creater.name}">{$T.row.message.title}
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
        <span class="block" style="background-color:#f5f5f6; width:238px; height:100%; border-left:1px solid #666666; border-right:1px solid #666666;">
        <span class=" block ml10 mr10">
        <h1>标题：</h1>
        <p class="fbnone">{$T.row.message.title}</p>
        <h1>内容：</h1>
        <p class="fbnone">{$T.row.message.content}</p>
        
        <h1>接收时间：</h1>
       <p class="fbnone"> {$T.row.createdTime}</p>
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
                                            <b class="bb0"></b></div>
                                    </div>
                                </a>
                            </c:when>
                            <c:otherwise>{$T.row.message.title}</c:otherwise>
                        </c:choose>
                    </td>
                    <td align="left">{$T.row.message.creater.realName}</td>
                    <td>{$T.row.createdTime}</td>
                    <td>{$T.row.user.realName}</td>
                    <td align="left">
                        <c:if test="${VS_HAS_FUNCTIONS.messageView}">
                            <a href="${ctx}/system/message/toViewPage.do?id={$T.row.id}" title="详情" class=" block_inline s_detail_btn globle_img ml10"></a>
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
    <div class="TabbedPanelsContent send" forform="form" formaction="${ctx}/system/message/query.do">

        <div id="title" style="display: none; background-color: #f5f5f6;"
					class=" ml35 mr35">
					<table class="cb id_table2 w">
						<tr>
							<th align="left" width="7%">
								<input type="checkbox" class="checkall" />
							</th>
							<th width="34%">
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
					</table>
				</div>
				<table class="cb id_table2 w pr35">
					<tr id="recordDiv">
						<th width="5%">
							<input type="checkbox" class="checkall" />
						</th>
						<th width="34%">
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

				<textarea id="template-tbody" class="template template-tbody">
            {#foreach $T.result as row}
            <tr class="{$T.row$index%2==1?'':'bg_c_blue'}">
                <td align="center">
							<input type="checkbox" name="id" class="checkitem"
								value="{$T.row.id}" />
						</td>
             <td>
                   <c:choose>
                		<c:when test="${VS_HAS_FUNCTIONS.messageView}">
                                <a class="toviewpage"  href="${ctx}/system/message/toViewPage.do?id={$T.row.id}&userName={$T.row.message.creater.realName}">{$T.row.message.title}
        <div class="none w240">
        <b class="bb1"></b>
        <b class="bb2"></b>
        <b class="bb3"></b>
        <b class="bb4"></b>
        <b class="bb5"></b>
        <b class="bb5"></b>
        <b class="bb5"></b>
        <b class="bb5"></b>
        <span class="block" style="background-color:#f5f5f6; width:238px; height:100%; border-left:1px solid #666666; border-right:1px solid #666666;">
        <span class=" block ml10 mr10">
        <h1>标题：</h1>
        <p class="fbnone">{$T.row.message.title}</p>
        <h1>内容：</h1>
        <p class="fbnone">{$T.row.message.content}</p>
        <h1>发送时间：</h1>
        <p class="fbnone"> {$T.row.createdTime}</p>
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
                                </a>
                		</c:when>
                		<c:otherwise>{$T.row.message.title}</c:otherwise>
                	</c:choose>
               </td>
                <td>{$T.row.message.creater.realName}</td>
                <td>{$T.row.createdTime}</td>
                <td>{$T.row.user.realName}</td>
                <td align="center">
                    
                        <c:if test="${VS_HAS_FUNCTIONS.messageView}">
                            <a
									href="${ctx}/system/message/toViewPage.do?id={$T.row.id}"
									title="详情" class=" block_inline s_detail_btn globle_img  ml10"></a>
                        </c:if>    
                        <c:if test="${VS_HAS_FUNCTIONS.messageModify}">
                            <a
									href="${ctx}/system/message/toViewPage.do?id={$T.row.id}&type=add"
									title="再次发送" class=" block_inline s_reply globle_img ml10"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.messageDelete}">
                            <a href="javascript:void(0)"
									class=" block_inline s_dump_btn globle_img ml10 delete"
									title="删除" uri="${ctx}/system/message/delete.do?id={$T.row.id}"></a>
                        </c:if>
                   
                </td>
            </tr>
            {#/for}
        </textarea>
				<%@include file="/WEB-INF/template/sort.jsp"%>
				<%@include file="/WEB-INF/template/pagination.jsp"%>
    </div>
</div>
</div>
<script type="text/javascript">
    <!--
    var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
    //-->
</script>
</div>
</body>
</html>