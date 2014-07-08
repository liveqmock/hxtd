<%--
  生成报表页
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

    <script type="text/javascript" src="${ctx}/static/component/open-flash-chart-2/js/json/json2.js"></script>
    <script type="text/javascript" src="${ctx}/static/component/open-flash-chart-2/js/swfobject.js"></script>


    <script type="text/javascript">

        swfobject.embedSWF("${ctx}/static/component/open-flash-chart-2/open-flash-chart.swf", "my_chart", "350", "200", "9.0.0");

        //当拿到数据后程序调用的方法
        function ofc_ready() {

        }

        //程序自动调用，方法名不能改变，获取图表数据
        function open_flash_chart_data() {
            return JSON.stringify(data);
        }

        function findSWF(movieName) {
            if (navigator.appName.indexOf("Microsoft") != -1) {
                return window[movieName];
            } else {
                return document[movieName];
            }
        }

        var data = {
            /* 图表标题 */
            "title": {
                "text": "标题",
                "style": "{font-size: 20px; color:#0000ff; font-family: Verdana; text-align: center;}"
            },

            /* X轴标题 */
            "x_legend": {
                "text": "X轴标题",
                "style": "{font-size: 12px; color:#736AFF;}"
            },

            /* Y轴标题 */
            "y_legend": {
                "text": "Y轴标题",
                "style": "{color: #736AFF; font-size: 12px;}"
            },

            "is_decimal_separator_comma": 1, /* (0/1)，是否用逗号替换小数点 */
            "is_fixed_num_decimals_forced": 1, /* (0/1)，是否强制小数点后面的位数 */
            "num_decimals": 3, /* 精度，即小数点后面的位数，需要配合上面参数一起使用 */
            "is_thousand_separator_disabled": 0, /* (0/1)，是否使用千位分隔符 */

            "x_axis": {
                "stroke": 1, /* X轴的粗细 */
                "tick_height": 10, /* X轴刻度的长度 */
                "colour": "#d000d0", /* 颜色 */
                "grid_colour": "#00ff00", /* 网格线的颜色 */
                "offset": 1, /* (0/1), 是否根据数据图形和标签的宽度进行延展 */
                "3d": 0, /* 显示3D */
                "steps": 0.5, /* 刻度间隔 */
                /*"min": 0,
                 "max": 8,*/
                "labels": {
                    "labels": ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月",
                        {"text": "九月", "visible": true, "colour": "ff0000", "rotate": -60}
                    ]
                }
            },

            "y_axis": {
                "stroke": 4,
                "tick_length": 3,
                "colour": "#d000d0",
                "grid_colour": "#00ff00",
                "offset": 0,
                "max": 20,
                "steps": 2
            },

            "elements": [
                {
                    "type": "bar", /* 可选值有bar，line，pie等 */
                    "alpha": 0.5,
                    "colour": "#9933CC",
                    "text": "图例一",
                    "font-size": 10,
                    "values": [9, 6, 7, 9, 5, 7, 6, 9,
                        {
                            "bottom": 0,
                            "top": 7,
                            "colour": "#A03030",
                            "tip": "#top#<br>hello<br>#val#",
                            "on-click": "#"
                        }
                    ]
                },
                {
                    "type": "bar",
                    "alpha": 0.5,
                    "colour": "#CC9933",
                    "text": "图例二",
                    "font-size": 10,
                    "values": [6, 7, 9, 5, 7, 6, 9, 7, 3]
                }
            ],
            "tooltip": {
                "shadow": false, /* 提示框影子 */
                "stroke": 2, /* 边框粗细 */
                "rounded": 1, /* 边角圆滑程度 */
                "colour": "#00d000", /* 边框颜色 */
                "background": "#d0d0ff", /* 背景颜色 */
                "title": "{font-size: 18px; color: #000000; font-weight:bold;}", /* 标题样式 */
                "body": "{font-size: 10px; color: #000000;}"      /* 本体样式 */
            }
        };

    </script>
</head>
<body>
<div id="my_chart">

</div>
<div class="listcontainer">

    <form action="${ctx}/system/role/query.do" onsubmit="return false;">
        <table class="fl mt5 w">
            <tr>
                <td class="f14" align="right" width="6%">报表名称：</td>
                <td class="f14" align="left" width="16%"><input type="text" name="search_LIKE_name" value="${name}" class="text_input1"/></td>
                <td width="12%">
                    <a href="javascript:void(0)" class="a_underline block_inline fr w_blue mt5 reset">清除</a>
                    <a href="javascript:void(0)" class="block_inline c_white lh25 fr mr10 submit"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b></a>
                </td>
                <td class="f14" align="right" width="6%"></td>
                <td class="f14" align="left" width="16%"></td>
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
                    <th style="width:10%" class="sortable orderby" orderby="name">报表名称</th>
                    <th style="width:10%">备注</th>
                    <th style="width:10%">创建者</th>
                    <th style="width:10%">创建时间</th>
                    <th style="width:10%">修改者</th>
                    <th style="width:10%">最后修改时间</th>
                    <th style="width:10%">操作</th>
                </tr>
                {#foreach $T.result as row}
                <tr class="row {#cycle values=['bg_c_blue','']}">
                    <td><input type="checkbox" class="checkitem" value="{$T.row.id}"/></td>
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
                    <td align="center">
                        <c:if test="${VS_HAS_FUNCTIONS.roleView}">
                            <a href="${ctx}/system/role/toViewPage.do?id={$T.row.id}" class=" block_inline s_detail_btn globle_img ml10" title="详情"></a>
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.roleModify}">
                            {#if !$T.row.isInitialized}
                            <a href="${ctx}/system/role/toModifyPage.do?id={$T.row.id}" class=" block_inline s_edit_btn globle_img ml10" title="编辑"></a>
                            {#/if}
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.roleDelete}">
                            {#if !$T.row.isInitialized}
                            <a href="javascript:void(0)" uri="${ctx}/system/role/delete.do?id={$T.row.id}" class=" block_inline s_dump_btn globle_img ml10 delete" title="删除"></a>
                            {#/if}
                        </c:if>
                        <c:if test="${VS_HAS_FUNCTIONS.roleAuthorization}">
                            <a href="${ctx}/system/role/toAuthorizationPage.do?id={$T.row.id}" class=" block_inline h_shouquan globle_img ml10 authorization" title="授权"></a>
                        </c:if>
                    </td>
                    {#/for}
            </textarea>
        </table>
    </div>
</div>

</body>
</html>