<%--
  组织列表页
  role: xiayouxue
  Date:2014/5/7
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>组织列表页</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/css/recommend/empower.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>

    <script type="text/javascript">
        $(function () {
            var ztree = jsUtil.organizationTree({
                data:${organizationTree},
                click: function (event, treeId, treeNode) {
                    $("[name=id]").val(treeNode.id);
                    grid.loadGrid();
                }
            });

            window.grid = new Grid().init({deleteCallback: Grid.deleteSynTree(ztree, $("[name=id]"))}).bindAuthorization();
        })
    </script>
</head>
<body>
<div class="listcontainer">
    <div class="margin0 ml35 mr35">
        <div class="fl" style="width:20%">
            <div class="mt20 block cb cb mr20">
                <b class="ba"></b>
                <b class="bb"></b>
                <b class="bc"></b>
                <b class="bd"></b>

                <div class="fl table_blueheadc fl w">
                    <h1 class="f14 c_white lh40 ml10 fl">组织机构</h1>
                    <img width="108" height="50" class="fl" src="${ctx}/static/images/snowflake.png">
                    <a class="c_white f14 fr mt10 fb mr10" href="javascript:;">&lt;&lt;</a>
                </div>
            </div>
            <div class="cb mb20 mr20 bor_636363" style=" height:495px;">
                <ul id="organizationTree" class="ztree"></ul>
            </div>
        </div>

        <div class="fr" style="width:80%;">
            <form action="${ctx}/system/organization/query.do" onsubmit="return false;">
                <input type="hidden" name="id" value="${id}"/>
                <tags:paginationparams page="${page}"/>
            </form>
            <div class="cb"></div>

            <div class="mt20 block cb cb">
                <b class="b1"></b>
                <b class="b2"></b>
                <b class="b3"></b>
                <b class="b4"></b>

                <div class="ie_head">
                    <ul class="fl id_table1 mt10 ml10">
                        <c:if test="${VS_HAS_FUNCTIONS.organizationDelete}">
                            <li><a href="javascript:void(0)" uri="${ctx}/system/organization/delete.do" class="block c_white lh25 deletesome mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;除</b></a></li>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.organizationAdd}">
                            <li><a href="${ctx}/system/organization/toAddPage.do" class="block c_white lh25 add mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;增</b></a></li>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.organizationAuthorization}">
                            <li><a href="javascript:void(0)" uri="${ctx}/system/organization/toAuthorizationPage.do" class="block c_white lh25 authorization mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">授&nbsp;权</b></a></li>
                        </c:if>
                    </ul>
                </div>
            </div>

            <div>
                <table class="cb id_table2 w pr35">
                    <tr>
                        <th style="width: 2%"><input type="checkbox" class="checkall"/></th>
                        <th style="width: 10%">名称</th>
                        <th style="width: 5%">类型</th>
                        <th style="width: 5%" class="sortable orderby" orderby="level">级别</th>
                        <th style="width: 10%">上级组织</th>
                        <th style="width: 10%">含有下级组织</th>
                        <th style="width: 10%">电话</th>
                        <th style="width: 15%">网址</th>
                        <th style="width: 5%" class="sortable orderby" orderby="order">序号</th>
                        <th style="width: 15%">操作</th>
                    </tr>
                    <%@include file="/WEB-INF/template/sort.jsp" %>
                    <tbody class="list"></tbody>
                    <textarea id="template-tbody" class="template template-tbody">
                        {#foreach $T.result as row}
                        <tr class="row {#cycle values=['','bg_c_blue']}">
                            <td><input type="checkbox" class="checkitem" value="{$T.row.id}"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${VS_HAS_FUNCTIONS.organizationView}"><a href="${ctx}/system/organization/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.name}</a></c:when>
                                    <c:otherwise>{$T.row.name}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>{$T.row.type.key}</td>
                            <td style="text-align: right">{$T.row.level}</td>
                            <td>{$T.row.parent.name}</td>
                            <td>{$T.row.isLeaf?"否":"是"}</td>
                            <td style="text-align: right">{$T.row.phone}</td>
                            <td><a href="{$T.row.webSite}">{$T.row.webSite}</a></td>
                            <td style="text-align: right">{$T.row.order}</td>
                            <td align="center">
                                <c:if test="${VS_HAS_FUNCTIONS.organizationView}">
                                    <a href="${ctx}/system/organization/toViewPage.do?id={$T.row.id}" class="block_inline s_detail_btn globle_img ml10" title="详情"></a>
                                </c:if>
                                <c:if test="${VS_HAS_FUNCTIONS.organizationModify}">
                                    <a href="${ctx}/system/organization/toModifyPage.do?id={$T.row.id}" class="block_inline s_edit_btn globle_img ml10" title="编辑"></a>
                                </c:if>
                                <c:if test="${VS_HAS_FUNCTIONS.organizationDelete}">
                                    <a href="javascript:void(0)" uri="${ctx}/system/organization/delete.do?id={$T.row.id}" class="block_inline s_dump_btn globle_img ml10 delete" title="删除"></a>
                                </c:if>
                            </td>
                        </tr>
                        {#/for}
                    </textarea>
                </table>
            </div>
            <div class="cb ml35 mt20 h40 pagination"></div>
            <%@include file="/WEB-INF/template/pagination.jsp" %>
        </div>
    </div>
    <div class="cb"></div>
</div>
</body>
</html>