<%--
  角色列表页
  role: xiayouxue
  Date:2014/5/7
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

    <form action="${ctx}/system/role/query.do" onsubmit="return false;">
        <table class="fl mt5 w">
            <tr>
                <td class="f14 namewidth1" align="right">角色名称：</td>
                <td class="f14 namewidth2" align="left"><input type="text" name="search_LIKE_name" value="${name}" class="text_input1"/></td>
                <td width="namewidth3">
    			<a href="javascript:;" class="c_222 block cp fr ml10 packup  mt8 mr20 more" title="展开"></a>
    			<a href="javascript:;" class="reset a_underline fr w_blue mt5">清除</a>
    			<a href="javascript:;" class="block c_white lh25 fr mr10 submit">
    				<b class="allbtn_l block fl"></b>
    				<b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b>
    			</a>
    			</td>
                <td class="f14 namewidth1" align="right"></td>
                <td class="f14 namewidth2" align="left"></td>
                <td class="f14 namewidth1" align="right"></td>
                <td class="f14 namewidth2" align="left"></td>
                
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
                <c:if test="${VS_HAS_FUNCTIONS.roleDelete}">
                    <li><a href="javascript:void(0)" uri="${ctx}/system/role/delete.do" class="block c_white lh25 deletesome mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;除</b></a></li>
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.roleAdd}">
                    <li><a href="${ctx}/system/role/toAddPage.do" class="block c_white lh25 add mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;增</b></a></li>
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.roleQuery}">
                    <li><a href="javascript:void(0)" class="block c_white lh25 mr10 refresh"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b> </a></li>
                </c:if>
            </ul>
        </div>
    </div>

    <div class="ml35 mr35">
        <table class="cb id_table2 w pr35">
            <tr>
                <th style="width:2%"><input type="checkbox" class="checkall"/></th>
                <th style="width:10%" class="sortable orderby" orderby="code">编码</th>
                <th style="width:10%" class="sortable orderby" orderby="name">角色名称</th>
                <th style="width:10%">备注</th>
                <th style="width:10%">创建者</th>
                <th style="width:10%">创建时间</th>
                <th style="width:10%">修改者</th>
                <th style="width:10%">最后修改时间</th>
                <th style="width:10%">操作</th>
            </tr>
            <%@include file="/WEB-INF/template/sort.jsp" %>
            <tbody class="list"></tbody>
            <textarea id="template-tbody" class="template template-tbody">
                {#foreach $T.result as row}
                <tr class="row {#cycle values=['bg_c_blue','']}">
                    <td><input type="checkbox" class="checkitem" value="{$T.row.id}"/></td>
                    <td>{$T.row.code}</td>
                    <td>
                        <c:choose>
                            <c:when test="${VS_HAS_FUNCTIONS.roleView}"><a href="${ctx}/system/role/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.name}</a></c:when>
                            <c:otherwise>{$T.row.name}</c:otherwise>
                        </c:choose>
                    </td>
                    <td>{$T.row.remark}</td>
                    <td>{$T.row.creator.realName}</td>
                    <td>{$T.row.createdTime}</td>
                    <td>{$T.row.modifier.realName}</td>
                    <td>{$T.row.modifiedTime}</td>
                    <td align="left">
                        <c:if test="${VS_HAS_FUNCTIONS.roleView}">
                            <a href="${ctx}/system/role/toViewPage.do?id={$T.row.id}" class=" block_inline s_detail_btn globle_img ml10" title="详情"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.roleModify}">
                            {#if !$T.row.isInitialized}
                            <a href="${ctx}/system/role/toModifyPage.do?id={$T.row.id}" class=" block_inline s_edit_btn globle_img ml10" title="编辑"></a>
                            {#/if}
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.roleAuthorization}">
                            <a href="${ctx}/system/role/toAuthorizationPage.do?id={$T.row.id}" class=" block_inline h_shouquan globle_img ml10 authorization" title="授权"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.roleDelete}">
                            {#if !$T.row.isInitialized}
                            <a href="javascript:void(0)" uri="${ctx}/system/role/delete.do?id={$T.row.id}" class=" block_inline s_dump_btn globle_img ml10 delete" title="删除"></a>
                            {#/if}
                        </c:if>
                    </td>
                    {#/for}
            </textarea>
        </table>
    </div>
    <div class="cb ml35 mt20 h40 pagination"></div>
    <%@include file="/WEB-INF/template/pagination.jsp" %>
</div>

</body>
</html>