<%--
  报表列表页
  role: xiayouxue
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

    <form action="${ctx}/common/report/query.do" onsubmit="return false;">
        <table class="fl mt5 w">
            <tr>
                <td class="f14" align="right" width="6%">报表名称：</td>
                <td class="f14" align="left" width="16%"><input type="text" name="search_LIKE_name" value="${name}" class="text_input1"/></td>
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
                <td width="12%">
                    <a href="javascript:void(0)" class="a_underline block_inline fr w_blue mt5 reset">清除</a>
                    <a href="javascript:void(0)" class="block_inline c_white lh25 fr mr10 submit"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b></a>
                </td>
                <td class="f14" align="right" width="6%"></td>
                <td class="f14" align="left" width="16%"></td>
                <td class="f14" align="right" width="6%"></td>
                <td class="f14" align="left" width="16%"></td>
            </tr>
        </table>
        <tags:paginationparams page="${page}"/>
    </form>
    <div class="cb"></div>

    <div class="ml35 mr35">
        <table class="cb id_table2 w pr35">
            <tbody class="list"></tbody>
            <textarea id="template-tbody" class="template template-tbody">
                <tr>
                    <th style="width:2%"><input type="checkbox" class="checkall"/></th>
                    <th style="width:10%" class="sortable orderby" orderby="name">名称</th>
                    <th style="width:10%">所属模块</th>
                    <th style="width:10%">X轴字段名</th>
                    <th style="width:10%">X轴分组类型</th>
                    <th style="width:10%">Z轴字段名</th>
                    <th style="width:10%">Z轴分组类型</th>
                    <th style="width:10%">Y轴字段名</th>
                    <th style="width:10%">Y轴聚合类型</th>
                    <th style="width:10%">操作</th>
                </tr>
                {#foreach $T.result as row}
                <tr class="row {#cycle values=['bg_c_blue','']}">
                    <td><input type="checkbox" class="checkitem" value="{$T.row.id}"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${VS_HAS_FUNCTIONS.reportView}"><a href="${ctx}/common/report/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.name}</a></c:when>
                            <c:otherwise>{$T.row.name}</c:otherwise>
                        </c:choose>
                    </td>
                    <td>{$T.row.module.desc}</td>
                    <td>{$T.row.xFieldName}</td>
                    <td>{$T.row.xGroupType.key}</td>
                    <td>{$T.row.xFieldName}</td>
                    <td>{$T.row.xGroupType.key}</td>
                    <td>{$T.row.zFieldName}</td>
                    <td>{$T.row.zGroupType.key}</td>
                    <td>{$T.row.yFieldName}</td>
                    <td>{$T.row.yGroupType.key}</td>
                    <td align="center">
                        <c:if test="${VS_HAS_FUNCTIONS.reportView}">
                            <a href="${ctx}/common/report/toViewPage.do?id={$T.row.id}" class=" block_inline s_detail_btn globle_img ml10" title="详情"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.reportModify}">
                            {#if !$T.row.isInitialized}
                            <a href="${ctx}/common/report/toModifyPage.do?id={$T.row.id}" class=" block_inline s_edit_btn globle_img ml10" title="编辑"></a>
                            {#/if}
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.reportDelete}">
                            {#if !$T.row.isInitialized}
                            <a href="javascript:void(0)" uri="${ctx}/common/report/delete.do?id={$T.row.id}" class=" block_inline s_dump_btn globle_img ml10 delete" title="删除"></a>
                            {#/if}
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