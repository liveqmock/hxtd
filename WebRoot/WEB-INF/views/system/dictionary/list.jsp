<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>字典维护</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
<link href="${ctx}/static/css/application.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
<script type="text/javascript">
$(function () {
    new Grid().init({LayoutBy: false, gridName: "parent"}); //生成Gird
});
function showChildNode(obj) {
    var parentId = obj.id, lstSelector = ".div_" + parentId, $childLst = $(lstSelector);
    $childLst.toggle();
    if ($childLst.is(":visible") && $childLst.find("li").length == 0) {
        new Grid().init({
            containerSelector: lstSelector,
            activeFlowHeader: false,
            paginationActive: false,
            gridName: "child",
            gridSelector: '.children-grid',
            resultTemplateId: 'template-child'
        });
    }
    $(obj).toggleClass("s_putaway");
}
</script>
</head>
<body>
<div class="listcontainer">
    <form id="form" action="${ctx}/system/dictionary/query.do" onsubmit="return false;">
        <table class="fl mt10 w">
            <tr>
                <td class="f14 namewidth1" align="right">字典类型：</td>
                <td class="f14 namewidth2" align="left">
                    <select name="search_EQ_parent.id" class="select2">
                        <option value="">全部</option>
                        <c:forEach var="item" items="${types}">
                            <option value="${item.id}">${item.key}</option>
                        </c:forEach>
                    </select>
                </td>
                <td class="f14 namewidth1" align="right">字典名称：</td>
                <td class="f14 namewidth2" align="left"><input type="text" class="text_input1" name="search_LIKE_key"/></td>
                <td width="namewidth3">
                    <a href="javascript:;" class="reset a_underline fr w_blue mt5">清除</a>
                    <a href="javascript:;" class="block c_white lh25 fr mr10">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14 submit">查&nbsp;&nbsp;询</b>
                    </a>
                </td>
                <td></td>
                <td></td>
            </tr>
        </table>
        <tags:paginationparams page="${page}"/>
    </form>
    <div class="cb"></div>
    <div class="ml35 mr35 mt10 block cb cb">
        <b class="b1"></b>
        <b class="b2"></b>
        <b class="b3"></b>
        <b class="b4"></b>
        <div class="ie_head">
            <ul class="fl id_table1 mt10 ml10">
                <c:if test="${VS_HAS_FUNCTIONS.dictionaryDelete}">
                    <li>
                        <a href="javascript:;" class="block c_white lh25 mr10 deletesome">
                            <b class="allbtn_l block fl"></b>
                            <b class="allbtn_r pr13 block fl w_auto f14" uri="${ctx}/system/dictionary/delete.do">删&nbsp;&nbsp;除</b>
                        </a>
                    </li>
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.dictionaryAdd}">
                    <li>
                        <a href="${ctx}/system/dictionary/toAddPage.do" class="block c_white mr10 lh25">
                            <b class="allbtn_l block fl"></b>
                            <b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b>
                        </a>
                    </li>
                </c:if>
                <li>
                    <a href="javascript:;" class="block c_white lh25 mr10 refresh">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="ml35 mr35">
        <div class="grid w">
            <ul class="cb id_ul5 w vm header">
                <li style="width:4%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="checkall"/></li>
                <li style="width:16%">字典名称</li>
                <li style="width:16%">字典值</li>
                <li style="width:16%">字典类型</li>
                <li style="width:16%" class="sortable orderby" orderby="createdTime">创建时间</li>
                <li style="width:17%" class="sortable orderby" orderby="modifiedTime">最后修改时间</li>
                <li style="width:12%">操作</li>
            </ul>
            <div class="list"></div>
        </div>
        <div class="cb ml35 mt20 h40 pagination"></div>
        <textarea id="template-tbody" class="template template-tbody">
            {#foreach $T.result as row}
            <ul class="cb id_ul4 w {$T.row$index%2==1?'':'bg_c_blue'} vm">
                <li style="width:4%">
                    <i id="{$T.row.id}" class="s_open globle_img block_inline cp" onclick="showChildNode(this);"></i>
                    <input type="checkbox" class="checkitem" value="{$T.row.id}"/>
                </li>
                <li style="width:16%">
                    <c:choose>
                        <c:when test="${VS_HAS_FUNCTIONS.dictionaryView}">
                            <a class="toviewpage" href="${ctx}/system/dictionary/toViewPage.do?id={$T.row.id}">{$T.row.key}</a>
                        </c:when>
                        <c:otherwise>{$T.row.key}</c:otherwise>
                    </c:choose>
                </li>
                <li style="width:16%">{$T.row.value}</li>
                <li style="width:16%">{$T.row.type==null?'&nbsp;':$T.row.type}</li>
                <li style="width:16%">{$T.row.createdTime}</li>
                <li style="width:17%">{$T.row.modifiedTime}</li>
                <li style="width:12%">&nbsp;
                    <c:if test="${VS_HAS_FUNCTIONS.dictionaryView}">
                        <a href="${ctx}/system/dictionary/toViewPage.do?id={$T.row.id}"
                           class="block_inline s_detail_btn globle_img ml10" title="详情"></a>
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.dictionaryModify}">
                        {#if !$T.row.isInitialized}
                        <a href="${ctx}/system/dictionary/toModifyPage.do?id={$T.row.id}"
                           class="block_inline s_edit_btn globle_img ml10" title="编辑"></a>
                        {#/if}
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.dictionaryDelete}">
                        {#if !$T.row.isInitialized}
                        <a href="javascript:;" class="block_inline s_dump_btn globle_img ml10 delete"
                           uri="${ctx}/system/dictionary/delete.do?id={$T.row.id}" title="删除"></a>
                        {#/if}
                    </c:if>
                </li>
            </ul>
            <div class="div_{$T.row.id}" style="display:none">
                <form action="${ctx}/system/dictionary/query.do?TYPE=childlst&parentId={$T.row.id}" onsubmit="return false;"></form>
                <div class="children-grid">
                    <div class="list"></div>
                </div>
            </div>
            {#/for}
        </textarea>
        <%@include file="/WEB-INF/template/sort.jsp" %>
        <%@include file="/WEB-INF/template/pagination.jsp" %>
    </div>
    <textarea id="template-child" class="template template-tbody">
        {#foreach $T.result as row}
        <ul class="cb id_ul4 ml40 margin0 bg_c_d3d3d3 vm">
            <li style="width:4%"><input type="checkbox" class="checkitem" value="{$T.row.id}"/></li>
            <li style="width:16%">
                <c:choose>
                    <c:when test="${VS_HAS_FUNCTIONS.dictionaryView}">
                        <a class="toviewpage" href="${ctx}/system/dictionary/toViewPage.do?id={$T.row.id}">{$T.row.key}</a>
                    </c:when>
                    <c:otherwise>{$T.row.key}</c:otherwise>
                </c:choose>
            </li>
            <li style="width:16%">{$T.row.value}</li>
            <li style="width:16%">{$T.row.type==null?'&nbsp;':$T.row.type}</li>
            <li style="width:16%">{$T.row.createdTime}</li>
            <li style="width:17%">{$T.row.modifiedTime}</li>
            <li style="width:12%">
                <c:if test="${VS_HAS_FUNCTIONS.dictionaryView}">
                    <a href="${ctx}/system/dictionary/toViewPage.do?id={$T.row.id}"
                       class="block_inline s_detail_btn globle_img ml10" title="详情"></a>
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.dictionaryModify}">
                    {#if !$T.row.isInitialized}
                    <a href="${ctx}/system/dictionary/toModifyPage.do?id={$T.row.id}"
                       class="block_inline s_edit_btn globle_img ml10" title="编辑"></a>
                    {#/if}
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.dictionaryDelete}">
                    {#if !$T.row.isInitialized}
                    <a href="javascript:;" class="block_inline s_dump_btn globle_img ml10 delete"
                       uri="${ctx}/system/dictionary/delete.do?id={$T.row.id}" title="删除"></a>
                    {#/if}
                </c:if>
            </li>
        </ul>
        {#/for}
    </textarea>
</div>
</body>
</html>