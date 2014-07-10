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
    <title>${VR_LAST_MENU.name}</title>
    <link href="${ctx}/static/css/stressing/empower.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>

    <script type="text/javascript">
        $(function () {
            var ztree = jsUtil.organizationTree({
                data:${organizationTree==null?"[]":organizationTree},
                selectedId: "${id}",
                click: function (event, treeId, treeNode) {
                    $("[name=id]").val(treeNode.id);
                    $("[name=organizationId]").val(treeNode.id);
                    var $add = $(".add");
                    $add.attr("href", $add.attr("href").split("=").shift() + "=" + treeNode.id);
                    gridUser.paginationData.hibernatePageNo = 1;
                    gridUser.loadGrid();
                    gridOrg.paginationData.hibernatePageNo = 1;
                    gridOrg.loadGrid();
                    gridOrgdetail.loadGrid();
                    var url = "<a href='${ctx }/system/organization/toModifyPage.do?id=" + treeNode.id + "' class=\"block c_white lh25 mr10\"><b class=\"allbtn_l block fl\"></b><b class=\"allbtn_r pr13 block fl w_auto f14\">编&nbsp;&nbsp;辑</b></a>";
                    $("#modify").html(url);
                }
            });

            window.gridUser = new Grid().init({onDelete: Grid.deleteSynTree(ztree, $("[name=id]")), gridName: "user", gridSelector: ".user", resultTemplateId: "user-template"}).bindExport();
            window.gridOrg = new Grid().init({onDelete: Grid.deleteSynTree(ztree, $("[name=organizationId]")), gridName: "org", gridSelector: ".org", resultTemplateId: "org-template"});
            window.gridOrgdetail = new Grid().init({gridName: "orgdetail", gridSelector: ".orgdetail", resultTemplateId: "orgdetail-template"});
            $C.tab({onSelected: function (event, title, panel) {
                $("[name=hibernatePageNo]").val(1);
            }
            });
        });
    </script>
</head>
<body>
<div class="listcontainer">
<div class="margin0 ml35 mr35">
<div class="fl" style="width:20%">
    <div class="mt10 block cb cb mr20">
        <b class="ba"></b>
        <b class="bb"></b>
        <b class="bc"></b>
        <b class="bd"></b>

        <div class="fl table_blueheadc fl w">
            <h1 class="f14 c_white lh40 ml10 fl">组织机构</h1>
            <img width="108" height="50" class="fl" src="${ctx}/static/images/snowflake.png">
            <%--<a class="c_white f14 fr mt10 fb mr10" href="javascript:;">&lt;&lt;</a>--%>
        </div>
    </div>
    <div class="cb mb20 mr20 bor_636363" style=" height:495px;overflow-y:auto;">
        <ul id="organizationTree" class="ztree"></ul>
    </div>
</div>
<div class="fr" style="width:80%;">
<ul class="fl id_table3 w block cb mt10 tab-titles" style="border-bottom:5px solid #626262; height:32px;" fortabpanels>
    <li class="tab-title" fortabpanel="#tabs-user" id="user">
        <b class="h_tabbtn_l w25 block fl"></b>
        <b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">用户列表</b>
    </li>
    <li class="tab-title" fortabpanel="#tabs-org" id="org">
        <b class="h_tabbtn_l w25 block fl"></b>
        <b class="h_tabbtn_r  pr25 w_auto f14 block fr lh32 cp id_nav pr">组织列表</b>
    </li>
    <li class="tab-title" fortabpanel="#tabs-orgdetail" id="orgdetail">
        <b class="h_tabbtn_l w25 block fl"></b>
        <b class="h_tabbtn_r  pr25 w_auto f14 block fr lh32 cp id_nav pr">组织详情</b>
    </li>
</ul>
<div class="cb"></div>
<div class="w cb tab-panels">
<!-- 用户 -->
<div id="tabs-user" class="tab-panel">
    <form action="${ctx}/system/user/query.do" onsubmit="return false;">
        <input type="hidden" name="organizationId" value="${id}"/>
        <table class="fl mt5 w">
            <tr class="header">
                <td class="f14" align="right" width="6%">用户名称：</td>
                <td class="f14" align="left" width="16%"><input type="text" name="search_LIKE_name" value="${name}" class="text_input1"/></td>
                <td class="f14" align="right" width="6%">真实姓名：</td>
                <td class="f14" align="left" width="16%"><input type="text" name="search_LIKE_realName" value="${realName}" class="text_input1"/></td>
                <td class="f14" align="right" width="6%">启用：</td>
                <td class="f14" align="left" width="16%">
                    <div class="pr">
                        <select name="search_EQ_isActive" class="select2 pr">
                            <option value="">全部</option>
                            <option value="1" ${isActive==true?"selected":""}>是</option>
                            <option value="0" ${isActive==false?"selected":""}>否</option>
                        </select>
                    </div>
                </td>
                <td width="8%">
                    <a href="javascript:void(0)" class="reset block dump_btn globle_img fr"></a>
                    <a href="javascript:void(0)" class="block c_white lh25 fr mr10 submit"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b></a>
                </td>
            </tr>
        </table>
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
                <li><a href="javascript:void(0)" uri="${ctx}/system/user/delete.do" class="block c_white lh25 deletesome mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b></a></li>
                <c:if test="${VS_HAS_FUNCTIONS.userDelete}">
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.userAdd}">
                    <li><a href="${ctx}/system/user/toAddPage.do?organizationId=${organizationId}" class="block c_white lh25 add mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b></a></li>
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.userQuery}">
                    <li><a href="javascript:void(0)" class="block c_white lh25 mr10 refresh"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b> </a></li>
                </c:if>
            </ul>
            <ul class="fr id_table1 mt10 ml10">
                <c:if test="${VS_HAS_FUNCTIONS.userImport}">
                    <li><a href="${ctx}/system/user/toImportPage.do" class="leading_in globle_img block_inline mr10" title="导入"></a></li>
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.userExport}">
                    <li><a href="javascript:void(0)" uri="${ctx}/system/user/export.do?TYPE=selected" class="leading_out globle_img block_inline mr10 export" title="导出"></a></li>
                </c:if>
            </ul>
        </div>
    </div>
    <table class="cb id_table2 w pr35 user" forform="form" formaction="${ctx}/system/user/query.do" forpagination="#tabs-user .pagination">
        <tr class="header">
            <th style="width:4%"><input type="checkbox" class="checkall"/></th>
            <th style="width:10%" class="sortable orderby" orderby="name">用户名</th>
            <th style="width:5%">管理员</th>
            <th style="width:10%" class="sortable orderby" orderby="isActive">启用</th>
            <th style="width:10%">组织</th>
            <th style="width:10%">真实姓名</th>
            <th style="width:5%">性别</th>
            <th style="width:10%">联系电话</th>
            <th style="width:10%">职位</th>
            <th style="width:20%">操作</th>
        </tr>
        <%@include file="/WEB-INF/template/sort.jsp" %>
        <tbody class="list"></tbody>
        <textarea id="user-template" class="template template-tbody">
            {#foreach $T.result as row}
            <tr class="row {#cycle values=['bg_c_blue','']}">
                <td><input type="checkbox" class="checkitem" value="{$T.row.id}"/></td>
                <td>
                    <c:choose>
                        <c:when test="${VS_HAS_FUNCTIONS.userView}"><a href="${ctx}/system/user/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.name}</a></c:when>
                        <c:otherwise>{$T.row.name}</c:otherwise>
                    </c:choose>
                </td>
                <td>{$T.row.isManager?"是":"否"}</td>
                <td class="isactive">{$T.row.isActive?"是":"否"}</td>
                <td>{$T.row.organization.name}</td>
                <td>{$T.row.realName}</td>
                <td>{$T.row.sex.key}</td>
                <td>{$T.row.phone}</td>
                <td>{$T.row.jobName}</td>
                <td style="text-align: left">
                    <c:if test="${VS_HAS_FUNCTIONS.userView}">
                        <a href="${ctx}/system/user/toViewPage.do?id={$T.row.id}" class=" block_inline s_detail_btn  globle_img ml10" title="详情"></a>
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.userModify}">
                        {#if !$T.row.isInitialized}
                        <a href="${ctx}/system/user/toModifyPage.do?id={$T.row.id}" class=" block_inline s_edit_btn globle_img ml10" title="编辑"></a>
                        {#/if}
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.userEnable}">
                        {#if !$T.row.isInitialized&&!$T.row.isActive}
                        <a href="javascript:void(0)" uri="${ctx}/system/user/enable.do?id={$T.row.id}" class="globle_img h_on block_inline enable" title="启用"></a>
                        {#/if}
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.userDisable}">
                        {#if !$T.row.isInitialized&&$T.row.isActive}
                        <a href="javascript:void(0)" uri="${ctx}/system/user/disable.do?id={$T.row.id}" class="globle_img h_off block_inline disable" title="禁用"></a>
                        {#/if}
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.userAuthorization}">
                        <a href="${ctx}/system/user/toAuthorizationPage.do?id={$T.row.id}" class=" block_inline h_shouquan globle_img ml10 authorization" title="授权"></a>
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.userResetPassword}">
                        <a href="javascript:void(0)" uri="${ctx}/system/user/resetPassword.do?id={$T.row.id}" class=" block_inline h_xiupass globle_img ml10 resetpassword" title="重置密码"></a>
                    </c:if>
                    <c:if test="${VS_HAS_FUNCTIONS.userDelete}">
                        {#if !$T.row.isInitialized}
                        <a href="javascript:void(0)" uri="${ctx}/system/user/delete.do?id={$T.row.id}" class=" block_inline s_dump_btn  globle_img ml10 delete" title="删除"></a>
                        {#/if}
                    </c:if>
                </td>
            </tr>
            {#/for}
        </textarea>
    </table>
    <div class="cb ml35 mt20 h40 pagination"></div>
    <%@include file="/WEB-INF/template/pagination.jsp" %>
</div>
<!-- 组织 -->
<div id="tabs-org" class="tab-panel">
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
                    <li><a href="javascript:void(0)" uri="${ctx}/system/organization/delete.do" class="block c_white lh25 deletesome mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b></a></li>
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.organizationAdd}">
                    <li><a href="${ctx}/system/organization/toAddPage.do" class="block c_white lh25 add mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;&nbsp;增</b></a></li>
                </c:if>
                <c:if test="${VS_HAS_FUNCTIONS.organizationQuery}">
                    <li><a href="javascript:void(0)" class="block c_white lh25 mr10 refresh"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">刷&nbsp;&nbsp;新</b> </a></li>
                </c:if>
            </ul>
        </div>
    </div>
    <div>
        <table class="cb id_table2 w pr35 org" forform="form" formaction="${ctx}/system/organization/query.do" forpagination="#tabs-org .pagination">
            <tr class="header">
                <th style="width: 4%"><input type="checkbox" class="checkall"/></th>
                <th style="width: 12%">名称</th>
                <th style="width: 8%">类型</th>
                <th style="width: 8%" class="sortable orderby" orderby="level">级别</th>
                <th style="width: 8%">上级组织</th>
                <th style="width: 12%">含有下级组织</th>
                <th style="width: 12%">电话</th>
                <th style="width: 16%">网址</th>
                <th style="width: 10%" class="sortable orderby" orderby="order">序号</th>
                <th style="width: 16%">操作</th>
            </tr>
            <%@include file="/WEB-INF/template/sort.jsp" %>
            <tbody class="list"></tbody>
            <textarea id="org-template" class="template template-tbody">
                {#foreach $T.result as row}
                <tr class="row {#cycle values=['bg_c_blue','']}">
                    <td><input type="checkbox" class="checkitem" value="{$T.row.id}"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${VS_HAS_FUNCTIONS.organizationView}"><a href="${ctx}/system/organization/toViewPage.do?id={$T.row.id}" class="toviewpage">{$T.row.name}</a></c:when>
                            <c:otherwise>{$T.row.name}</c:otherwise>
                        </c:choose>
                    </td>
                    <td>{$T.row.type.key}</td>
                    <td>{$T.row.level}</td>
                    <td>{$T.row.parent.name}</td>
                    <td>{$T.row.isLeaf?"否":"是"}</td>
                    <td>{$T.row.phone}</td>
                    <td><a href="{$T.row.webSite}">{$T.row.webSite}</a></td>
                    <td>{$T.row.order}</td>
                    <td style="text-align: left">
                        <c:if test="${VS_HAS_FUNCTIONS.organizationView}">
                            <a href="${ctx}/system/organization/toViewPage.do?id={$T.row.id}" class="block_inline s_detail_btn globle_img ml10" title="详情"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.organizationModify}">
                            {#if !$T.row.isInitialized}
                            <a href="${ctx}/system/organization/toModifyPage.do?id={$T.row.id}" class="block_inline s_edit_btn globle_img ml10" title="编辑"></a>
                            {#/if}
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.organizationAuthorization}">
                            <a href="${ctx}/system/organization/toAuthorizationPage.do?id={$T.row.id}" class=" block_inline h_shouquan globle_img ml10 authorization" title="授权"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.organizationDelete}">
                            {#if !$T.row.isInitialized}
                            <a href="javascript:void(0)" uri="${ctx}/system/organization/delete.do?id={$T.row.id}" class="block_inline s_dump_btn globle_img ml10 delete" title="删除"></a>
                            {#/if}
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
<!-- 组织明细 -->
<div id="tabs-orgdetail" class="tab-panel">
    <div class="ml35 mr35 mt20 block cb cb">
    	<b class="b1"></b>
        <b class="b2"></b>
        <b class="b3"></b>
        <b class="b4"></b>
        <b class="table_headl globle_img block fl"></b>
        <div class="ie_head">
            <h1 class="f14 fbnone mt10 ml10 fl">组织详细信息</h1>
            <ul class="fr id_table1 mt10 ml10">
                <c:if test="${VS_HAS_FUNCTIONS.organizationModify}">
                    <li id="modify"><a href="${ctx }/system/organization/toModifyPage.do?id=${id}" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b></a></li>
                </c:if>
                
            </ul>
        </div>
    </div>
    <div class="ml35 mr35 bg_c_blue cb">
        <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10 orgdetail" forform="form" formaction="${ctx}/system/organization/query.do" forpagination="#tabs-orgdetail .pagination">
            <tbody class="list"></tbody>
            <textarea id="orgdetail-template" class="template template-tbody">
                {#foreach $T.result as row count=1}
                <tr>
                    <td align="right" width="15%">名称：</td>
                    <td align="left">{$T.row.name}</td>
                    <td align="right" width="15%">全名：</td>
                    <td align="left">{$T.row.fullName}</td>
                </tr>
                <tr>
                    <td align="right" width="15%">类型：</td>
                    <td align="left">{$T.row.type.key}</td>
                    <td align="right" width="15%">上级组织：</td>
                    <td align="left">{$T.row.parent.name}</td>
                </tr>
                <tr>
                    <td align="right" width="15%">电话：</td>
                    <td align="left">{$T.row.phone}</td>
                    <td align="right" width="15%">邮箱：</td>
                    <td align="left">{$T.row.email}</td>
                </tr>
                <tr>
                    <td align="right" width="15%">地址：</td>
                    <td align="left">{$T.row.address}</td>
                    <td align="right" width="15%">邮政编码：</td>
                    <td align="left">{$T.row.zipCode}</td>
                </tr>
                <tr>
                    <td align="right" width="15%">网址：</td>
                    <td align="left">{$T.row.webSite}</td>
                    <td align="right" width="15%"></td>
                    <td align="left"></td>
                </tr>
                {#/for}
            </textarea>
        </table>
        <h1 class="f14 fbnone ml40 pt10">详细信息</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10 orgdetail" forform="form" formaction="${ctx}/system/organization/query.do" forpagination="#tabs-orgdetail .pagination">
                <tr>
                    <td align="right" width="15%" valign="top">备注：</td>
                    <td align="left" width="85%" valign="top">
                        <div class="w85b"></div>
                    </td>
                </tr>
        </table>
        
        <div class=" h40"></div>
    </div>
</div>
</div>
</div>
<div class="cb"></div>
</div>
</body>
</html>