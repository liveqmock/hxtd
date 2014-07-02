<%--
  菜单管理
  menu: xiayouxue
  Date:2014/6/16
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>${VR_LAST_MENU.name}</title>

    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/css/recommend/empower.css" type="text/css"/>

    <link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>

    <script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>

    <script type="text/javascript">
        $(function () {

            var grid = new Grid().init({paginationActive: false, onDelete: Grid.deleteSynTree(window.ztree, $("[name=id]"))});

            window.ztree = jsUtil.menuTree({
                data:${menuTree==null?"[]":menuTree},
                selectedId: "${parentId}",
                ztreeOptions: {
//                    edit: {
//                        enable: true,
//                        showRemoveBtn: false,
//                        showRenameBtn: false
//                    },
                    callback: {
                        beforeClick: $.Ztree.switchSelected(function () {
                            $("[name=id]").val("");
                            var $add = $(".add");
                            $add.attr("href", $add.attr("href").split("=").shift() + "=");
                        }),
                        onClick: function (event, treeId, treeNode) {
                            $("[name=id]").val(treeNode.id);
                            var $add = $(".add");
                            $add.attr("href", $add.attr("href").split("=").shift() + "=" + treeNode.id);
                            grid.loadGrid();
                        }
                        /* ,
                         beforeDrop: function (treeId, treeNodes, targetNode, moveType) {
                         var isBrother = treeNodes[0].parentTId == targetNode.parentTId;
                         if (!isBrother) {
                         jsUtil.alert("只能在同级节点之间移动，不能跨越上级节点！");
                         }
                         return  isBrother;
                         },
                         onDrop: function (event, treeId, treeNodes, targetNode, moveType) {
                         var $id = $("[name=id]");
                         RcmsAjax.ajax("${ctx}/system/menu/move.doself", function () {
                         $id.val(targetNode.pId);
                         grid.loadGrid();
                         }, null, $.param({sourceId: treeNodes[0].id, targetId: targetNode.id, moveType: moveType}));
                         }*/
                    }
                }
            });
        });
    </script>
</head>
<body>
<div class="listcontainer">
    <div class="margin0 ml35 mr35">
        <div class="fl treepanel" style="width:20%">
            <div class="mt20 block cb cb mr20">
                <b class="ba"></b>
                <b class="bb"></b>
                <b class="bc"></b>
                <b class="bd"></b>

                <div class="fl table_blueheadc fl w">
                    <h1 class="f14 c_white lh40 ml10 fl">菜单结构</h1>
                    <img width="108" height="50" class="fl" src="${ctx}/static/images/snowflake.png">
                    <%--<a class="c_white f14 fr mt10 fb mr10" href="javascript:;">&lt;&lt;</a>--%>
                </div>
            </div>
            <div class="cb mb20 mr20 bor_636363" style=" height:495px;">
                <ul id="menuTree" class="ztree"></ul>
            </div>
        </div>

        <div class="fr" style="width:80%;">
            <form action="${ctx}/system/menu/query.do" onsubmit="return false;">
                <input type="hidden" name="id" value="${parentId}"/>
            </form>
            <div class="cb"></div>

            <div class="mt20 block cb cb">
                <b class="b1"></b>
                <b class="b2"></b>
                <b class="b3"></b>
                <b class="b4"></b>

                <div class="ie_head">
                    <ul class="fl id_table1 mt10 ml10">
                        <c:if test="${VS_HAS_FUNCTIONS.menuDelete}">
                            <li><a href="javascript:void(0)" uri="${ctx}/system/menu/delete.do" class="block c_white lh25 deletesome mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b></a></li>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.menuAdd}">
                            <li><a href="${ctx}/system/menu/toAddPage.do?parentId=${parentId}" class="block c_white lh25 add mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b></a></li>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.menuQuery}">
                            <li><a href="javascript:void(0)" class="block c_white lh25 mr10 refresh"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b> </a></li>
                        </c:if>
                    </ul>
                </div>
            </div>

            <div>
                <table class="cb id_table2 w pr35">
                    <thead>
                    <tr>
                        <th style="width: 2%"><input type="checkbox" class="checkall"/></th>
                        <th style="width: 10%">菜单名称</th>
                        <th style="width: 20%">调用入口</th>
                        <th style="width: 10%">上级菜单</th>
                        <th style="width: 5%">级别</th>
                        <th style="width: 10%">包含下级</th>
                        <th style="width: 5%">启用</th>
                        <th style="width: 10%">默认显示</th>
                        <th style="width: 10%">显示位置</th>
                        <th style="width: 10%">序号</th>
                        <th style="width: 15%">操作</th>
                    </tr>
                    </thead>
                    <%@include file="/WEB-INF/template/sort.jsp" %>
                    <tbody class="list"></tbody>
                    <textarea id="template-tbody" class="template template-tbody">
                        {#if $T.list.length>0}
                        {#foreach $T.list as row}
                        <tr class="row {#cycle values=['bg_c_blue','']}">
                            <td><input type="checkbox" class="checkitem" value="{$T.row.id}"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${VS_HAS_FUNCTIONS.menuView}"><a href="${ctx}/system/menu/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.name}</a></c:when>
                                    <c:otherwise>{$T.row.name}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>{$T.row.url}</td>
                            <td>{$T.row.parent.name}</td>
                            <td style="text-align: right">{$T.row.level}</td>
                            <td>{$T.row.isLeaf?"否":"是"}</td>
                            <td>{$T.row.isActive?"是":"否"}</td>
                            <td>{$T.row.defaultShow?"是":"否"}</td>
                            <td>{$T.row.showLocation.key}</td>
                            <td style="text-align: right">{$T.row.order}</td>
                            <td>
                                <c:if test="${VS_HAS_FUNCTIONS.menuView}">
                                    <a href="${ctx}/system/menu/toViewPage.do?id={$T.row.id}" class=" block_inline s_detail_btn  globle_img ml10" title="详情"></a>
                                </c:if>
                                <c:if test="${VS_HAS_FUNCTIONS.menuModify}">
                                    {#if !$T.row.isInitialized}
                                    <a href="${ctx}/system/menu/toModifyPage.do?id={$T.row.id}" class=" block_inline s_edit_btn globle_img ml10" title="编辑"></a>
                                    {#/if}
                                    {#if !$T.row$first}
                                    <a href="javascript:void(0)" uri="${ctx}/system/menu/move.doself?sourceId={$T.row.id}&targetId={$T.list[$T.row$index-1].id}" class="block_inline s_toup globle_img ml10 move" title="上移"></a>
                                    {#/if}
                                    {#if !$T.row$last}
                                    <a href="javascript:void(0)" uri="${ctx}/system/menu/move.doself?sourceId={$T.row.id}&targetId={$T.list[$T.row$index+1].id}" class="block_inline s_todown globle_img ml10 move" title="下移"></a>
                                    {#/if}
                                </c:if>
                                <c:if test="${VS_HAS_FUNCTIONS.menuDelete}">
                                    {#if !$T.row.isInitialized}
                                    <a href="javascript:void(0)" uri="${ctx}/system/menu/delete.do?id={$T.row.id}" class=" block_inline s_dump_btn  globle_img ml10 delete" title="删除"></a>
                                    {#/if}
                                </c:if>
                            </td>
                        </tr>
                        {#/for}
                        {#else}
                        <tr class="row">
                            <td colspan="10">没有符合条件的数据</td>
                        </tr>
                        {#/if}
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