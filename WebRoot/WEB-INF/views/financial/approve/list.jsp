<%--
  财务审批列表页
  approve: xiayouxue
  Date:2014/7/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>${VR_LAST_MENU.name}</title>

    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>

    <script type="text/javascript">
        $(function () {
            new Grid().init();
        });
    </script>
</head>
<body>
<div class="listcontainer">

    <form action="${ctx}/financial/approve/query.do" onsubmit="return false;">
        <table class="fl mt5 w">
            <tr>
                <td class="f14" align="right" width="6%">所属模块：</td>
                <td class="f14" align="left" width="16%">
                    <div class="pr">
                        <select name="search_EQ_module.id" class="select2 pr">
                            <option value="">全部</option>
                            <c:forEach items="${modules}" var="item">
                                <option value="${item.id}">${item.desc}</option>
                            </c:forEach>
                        </select>
                    </div>
                </td>
                <td class="f14" align="right" width="6%">流程：</td>
                <td class="f14" align="left" width="16%">
                    <div class="pr">
                        <select name="search_EQ_chart.id" class="select2 pr">
                            <option value="">全部</option>
                            <c:forEach items="${flows}" var="item">
                                <option value="${item.id}">${item.key}</option>
                            </c:forEach>
                        </select>
                    </div>
                </td>
                <td width="12%">
                    <a href="javascript:void(0)" class="a_underline block_inline fr w_blue mt5 reset">清除</a>
                    <a href="javascript:void(0)" class="block_inline c_white lh25 fr mr10 submit"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b></a>
                </td>
                <td class="f14" align="right" width="6%"></td>
                <td class="f14" align="left" width="16%"></td>
            </tr>
        </table>
        <tags:paginationparams page="${page}"/>
    </form>
    <div class="cb"></div>

    <div class="ml35 mr35 mt20 block cb cb">
        <b class="b1"></b>
        <b class="b2"></b>
        <b class="b3"></b>
        <b class="b4"></b>

        <div class="ie_head">
            <ul class="fl id_table1 mt10 ml10">
                <c:if test="${VS_HAS_FUNCTIONS.financialApproveQuery}">
                    <li><a href="javascript:void(0)" class="block c_white lh25 mr10 refresh"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b> </a></li>
                </c:if>
            </ul>
        </div>
    </div>

    <div class="ml35 mr35">
        <table class="cb id_table2 w pr35">
            <tr>
                <th style="width:2%"><input type="checkbox" class="checkall"/></th>
                <th style="width:10%">流程</th>
                <th style="width:10%">所属模块</th>
                <th style="width:10%">记录描述</th>
                <th style="width:10%">创建时间</th>
                <th style="width:15%">操作</th>
            </tr>
            <%@include file="/WEB-INF/template/sort.jsp" %>
            <tbody class="list"></tbody>
            <textarea id="template-tbody" class="template template-tbody">
                {#foreach $T.result as row}
                <tr class="row {#cycle values=['bg_c_blue','']}">
                    <td><input type="checkbox" class="checkitem" value="{$T.row.id}"/></td>
                    <td>{$T.row.flowNode.flow.key}</td>
                    <td>{$T.row.module.desc}</td>
                    <td>{$T.row.flowBusiness.code||$T.row.flowBusiness.name}</td>
                    <td>{$T.row.flowBusiness.createdTime}</td>
                    <td align="center">
                        <c:if test="${VS_HAS_FUNCTIONS.financialApproveApprove}">
                            <a href="${ctx}{$T.row.module.url}/toExecuteApprovePage.do?id={$T.row.recordId}&redirectURI=/financial/approve/toQueryPage.do" class="block_inline s_goapprove globle_img ml10" title="执行审批"></a>
                        </c:if>
                    </td>
                    {#/for}
            </textarea>
        </table>
        <div class="cb ml35 mt20 h40 pagination"></div>
        <%@include file="/WEB-INF/template/pagination.jsp" %>
    </div>
</div>
</div>
<div class="cb"></div>
</div>

</body>
</html>