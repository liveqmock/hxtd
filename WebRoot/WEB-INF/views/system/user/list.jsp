<%--
  用户列表页
  User: xiayouxue
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
            var grid = new Grid().init().bindAuthorization().bindResetPassword().bindEnable().bindDisable().bindExport();
            jsUtil.organizationTree({
                data:${organizationTree==null?"[]":organizationTree},
                selectedId: "${organizationId}",
                click: function (event, treeId, treeNode) {
                    $("[name=organizationId]").val(treeNode.id);
                    var $add = $(".add");
                    $add.attr("href", $add.attr("href").split("=").shift() + "=" + treeNode.order);
                    grid.loadGrid();
                }});
        });
    </script>
</head>
<body>
<div>
    <div class="margin0 ml35 mr35">

        <div class="fl" style="width:20%">
            <div class="mt20 block cb cb mr20">
                <b class="ba"></b>
                <b class="bb"></b>
                <b class="bc"></b>
                <b class="bd"></b>

                <div class="fl table_blueheadc fl w">
                    <h1 class="f14 c_white lh40 ml10 fl">组织结构</h1>
                    <img width="108" height="50" class="fl" src="${ctx}/static/images/snowflake.png">
                    <a class="c_white f14 fr mt10 fb mr10" href="javascript:;">&lt;&lt;</a>
                </div>
            </div>
            <div class="cb mb20 mr20 bor_636363" style=" height:495px;">
                <ul id="organizationTree" class="ztree"></ul>
            </div>
        </div>

        <div class="fr" style="width:80%;">
            <form action="${ctx}/system/user/query.do" onsubmit="return false;">
                <input type="hidden" name="organizationId" value="${organizationId}"/>
                <table class="fl mt5 w">
                    <tr>
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
                            <a href="javascript:void(0)" class="reset block dump_btn globle_img fr "></a>
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
                        <c:if test="${VS_HAS_FUNCTIONS.userDelete}">
                            <li><a href="javascript:void(0)" uri="${ctx}/system/user/delete.do" class="block c_white lh25 deletesome mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;除</b></a></li>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.userAdd}">
                            <li><a href="${ctx}/system/user/toAddPage.do?organizationOrder=${organizationOrder}" class="block c_white lh25 add mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">新&nbsp;增</b></a></li>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.userAuthorization}">
                            <li><a href="javascript:void(0)" uri="${ctx}/system/user/toAuthorizationPage.do" class="block c_white lh25 mr10 authorization"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">授&nbsp;权</b></a></li>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.userResetPassword}">
                            <li><a href="javascript:void(0)" uri="${ctx}/system/user/resetPassword.do" class="block c_white lh25 mr10 resetpassword"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">重置密码</b></a></li>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.userEnable}">
                            <%--<li><a href="javascript:void(0)" uri="${ctx}/system/user/enable.do" class="block c_white lh25 mr10 enable"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">启&nbsp;用</b></a></li>--%>
                            <li><a href="javascript:void(0)" uri="${ctx}/system/user/enable.do" class="globle_img h_on block enable"></a></li>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.userDisable}">
                            <%--<li><a href="javascript:void(0)" uri="${ctx}/system/user/disable.do" class="block c_white lh25 mr10 disable"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">禁&nbsp;用</b></a></li>--%>
                            <li><a href="javascript:void(0)" uri="${ctx}/system/user/disable.do" class="globle_img h_off block disable"></a></li>

                        </c:if>
                    </ul>

                    <ul class="fr id_table1 mt10 ml10">
                        <c:if test="${VS_HAS_FUNCTIONS.userImport}">
                            <li><a href="${ctx}/system/user/toImportPage.do" class="leading_in globle_img block_inline mr10" title="导入"></a></li>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.userExport}">
                            <li><a href="javascript:void(0)" uri="${ctx}/system/user/export.do?TYPE=pagination" class="leading_out globle_img block_inline mr10" title="导出"></a></li>
                        </c:if>
                    </ul>
                </div>
            </div>

            <div class="listcontainer" forform="form" foropebar=".ie_head">
                <table class="cb id_table2 w pr35">
                    <tr>
                        <th style="width:2%"><input type="checkbox" class="checkall"/></th>
                        <th style="width:10%" class="sortable orderby" orderby="name">用户名</th>
                        <th style="width:5%">管理员</th>
                        <th style="width:10%" class="sortable orderby" orderby="isActive">启用</th>
                        <th style="width:10%">组织</th>
                        <th style="width:10%">真实姓名</th>
                        <th style="width:5%">性别</th>
                        <th style="width:10%">联系电话</th>
                        <th style="width:10%">工作</th>
                        <th style="width:15%">操作</th>
                    </tr>
                    <%@include file="/WEB-INF/template/sort.jsp" %>
                    <tbody class="list"></tbody>
                    <textarea id="template-tbody" class="template template-tbody">
                        {#foreach $T.result as row}
                        <tr class="row {#cycle values=['','bg_c_blue']}">
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
                            <td style="text-align: right">{$T.row.phone}</td>
                            <td>{$T.row.jobName}</td>
                            <td align="center">
                                <c:if test="${VS_HAS_FUNCTIONS.userView}">
                                    <a href="${ctx}/system/user/toViewPage.do?id={$T.row.id}" class=" block_inline s_detail_btn  globle_img ml10" title="详情"></a>
                                </c:if>
                                <c:if test="${VS_HAS_FUNCTIONS.userModify}">
                                    <a href="${ctx}/system/user/toModifyPage.do?id={$T.row.id}" class=" block_inline s_edit_btn globle_img ml10" title="编辑"></a>
                                </c:if>
                                <c:if test="${VS_HAS_FUNCTIONS.userDelete}">
                                    <a href="javascript:void(0)" uri="${ctx}/system/user/delete.do?id={$T.row.id}" class=" block_inline s_dump_btn  globle_img ml10 delete" title="删除"></a>
                                </c:if>
                            </td>
                        </tr>
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