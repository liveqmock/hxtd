<%--
  菜单详情页
  User: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>菜单详情</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/detail.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>

    <script>
        $(function () {
            jsUtil.bindSave();
            jsUtil.bindCheckAll(".functioncheckall", ".functioncheckitem");
            jsUtil.renderRequired();
            jsUtil.menuTree({
                data:${menuTree==null?"[]":menuTree},
                selectedId: "${menu.id}",
                ztreeOptions: {
                    callback: {
                        onClick: function (event, treeId, treeNode) {
                            window.open("${ctx}/system/menu/toViewPage.do?id=" + treeNode.id, "_self");
                        }
                    }
                }
            });
        })
    </script>
</head>
<body>
<div>
    <div class="cb"></div>
    <div class="ml35 mr35">
        <div class="fl" style="width:20%">
            <div class="mt20 block cb cb mr20">
                <b class="ba"></b>
                <b class="bb"></b>
                <b class="bc"></b>
                <b class="bd"></b>

                <div class="fl table_blueheadc fl w">
                    <h1 class="f14 c_white lh40 ml10 fl">${menuAdd?"上级菜单":"菜单结构"}</h1>
                    <img width="108" height="50" class="fl" src="${ctx}/static/images/snowflake.png">
                    <a class="c_white f14 fr mt10 fb mr10" href="javascript:;">&lt;&lt;</a>
                </div>
            </div>
            <div class="cb mb20 mr20 bor_636363" style=" height:495px;">
                <ul id="menuTree" class="ztree"></ul>
            </div>
        </div>

        <div class="fr" style="width:80%">
            <div class="mt20 block cb cb">
                <b class="b1"></b>
                <b class="b2"></b>
                <b class="b3"></b>
                <b class="b4"></b>

                <div class="ie_head">
                    <h1 class="f14 fbnone mt10 ml10 fl">菜单详情信息</h1>
                    <ul class="fr id_table1 mt10 ml10">
                        <c:if test="${VS_HAS_FUNCTIONS.menuModify}">
                            <li><a href="${ctx }/system/menu/toModifyPage.do?id=${param.id}" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;辑</b></a></li>
                        </c:if>
                        <li><a href="${ctx}/system/menu/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">返&nbsp;回</b></a></li>
                    </ul>
                    <c:if test="${VM_BUSINESS!=null}">
                        <div class="message">${VM_BUSINESS}</div>
                    </c:if>
                </div>
            </div>
            <div class="  bg_c_blue cb">
                <input type="hidden" name="id" value="${menu.id}"/>

                <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
                <table class="cb id_table3 w95b bg_c_white margin0 mt10">
                    <tr style="display: none">
                        <td align="right" width="15%">编号：</td>
                        <td align="left"><input type="text" name="code" value="${menu.code}" class="text_input3"/></td>
                        <td align="right" width="15%">序号：</td>
                        <td align="left"><input type="text" name="order" value="${menu.order}" class="text_input3"/></td>
                    </tr>
                    <tr>
                        <td align="right" width="15%">菜单名称：</td>
                        <td align="left">${menu.name}</td>
                        <td align="right" width="15%">调用入口：</td>
                        <td align="left">${menu.url}</td>
                    </tr>
                    <tr>
                        <td align="right" width="15%">启用：</td>
                        <td align="left">${menu.isActive?"是":"否"}</td>
                        <td align="right" width="15%">默认显示：</td>
                        <td align="left">${menu.defaultShow?"是":"否"}</td>
                    </tr>
                    <tr>
                        <td align="right" width="15%">显示位置：</td>
                        <td align="left">${menu.showLocation.key}</td>
                    </tr>
                    <tr>
                        <td align="right" width="15%">包含功能：</td>
                        <td align="left" colspan="3">
                            <c:forEach items="${menu.functions}" var="item" varStatus="status">${item.name}&nbsp;&nbsp;</c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="15%">执行功能：</td>
                        <td align="left">${menu.trigger.name}</td>
                        <td align="right" width="15%">上级菜单：</td>
                        <td align="left">${menu.parent.name}</td>
                    </tr>
                </table>
                <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
                <table class="cb id_table4 w95b bg_c_white margin0 mt10">
                    <tr>
                        <td align="right" width="15%" valign="top">备注：</td>
                        <td align="left" width="85%" valign="top">
                            <div class="w85b">${menu.remark}</div>
                        </td>
                    </tr>
                </table>
                <div class=" h40"></div>
            </div>
        </div>
    </div>
</body>
</html>