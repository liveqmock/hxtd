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
    <script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>

    <script type="text/javascript" src="${ctx}/static/component/open-flash-chart-2/js/json/json2.js"></script>
    <script type="text/javascript" src="${ctx}/static/component/open-flash-chart-2/js/swfobject.js"></script>


    <script type="text/javascript">


        //当拿到数据后程序调用的方法
        function ofc_ready() {}

        //程序自动调用，方法名不能改变，获取图表数据
        function open_flash_chart_data() {
            window.chartGraph1 = {
                "title": {
                    "text": "Many data lines",
                    "style": "{font-size: 20px; color:#0000ff; font-family: Verdana; text-align: center;}"
                },
                "elements": [
                    {
                        "type": "bar",
                        "alpha": 0.5,
                        "colour": "#9933CC",
                        "text": "Page views",
                        "font-size": 10,
                        "values": [9, 6, 7, 9, 5, 7, 6, 9, 7]
                    },
                    {
                        "type": "bar",
                        "alpha": 0.5,
                        "colour": "#CC9933",
                        "text": "Page views 2",
                        "font-size": 10,
                        "values": [6, 7, 9, 5, 7, 6, 9, 7, 3]
                    }
                ],
                "x_axis": {
                    "stroke": 1,
                    "tick_height": 10,
                    "colour": "#d000d0",
                    "grid_colour": "#00ff00",
                    "labels": ["January", "February", "March", "April", "May", "June", "July", "August", "Spetember"]
                },
                "y_axis": {
                    "stroke": 4,
                    "tick_length": 3,
                    "colour": "#d000d0",
                    "grid_colour": "#00ff00",
                    "offset": 0,
                    "max": 20,
                    "steps": 5
                }
            };
            window.chartGraph2 = {
                "title": {"text": "每月不同性别用户注册量", "style": "{font-size: 20px; color:#0000ff; font-family: Verdana; text-align: center;}"},
                "elements": [
                    {"type": "bar", "alpha": 0.5, "colour": "#d000d0", "text": "男", "values": [1, 0, 4], "font-size": 10},
                    {"type": "bar", "alpha": 0.5, "colour": "#CC9933", "text": "女", "values": [0, 0, 1], "font-size": 10}
                ],
               /* "tooltip": {"shadow": false, "stroke": 2, "rounded": 1, "colour": "#00d000", "backgournd": null,
                    "title": "{font-size: 18px; color: #000000; font-weight:bold;}", "body": "{font-size: 10px; color: #000000;}"},
                "x_legend": {"text": "创建时间", "style": "{font-size: 12px; color:#736AFF;}"},
                "y_legend": {"text": null, "style": "{color: #736AFF; font-size: 12px;}"},
                "is_decimal_separator_comma": false, "is_fixed_num_decimals_forced": true, "num_decimals": 3, "is_thousand_separator_disabled": true,*/
                "x_axis": {"stroke": 1, "colour": "#d000d0", "offset": 0, "labels":  [5, 6, 7], "tick_height": 10, "tick_length": null, "grid_colour": "#00ff00", "3d": false},
                "y_axis": {"stroke": 4, "colour": "#d000d0", "offset": false, "steps": 10.0, "min": 1, "max": 100, "tick_height": null, "tick_length": 3, "grid_colour": "#00ff00", "3d": null}};
            return JSON.stringify(window.chartGraph);
        }


        $(function () {
            jsUtil.twoOrMoreRestrictDate('.time', 'max', 0); //创建、修改时间
            var chartTable = $(".list");
            var grid = new Grid().init({renderList: function (data) {
                data = data.result;
                chartTable.setTemplateElement("template-charttable").processTemplate(data.chartTable);

                if (data.chartGraphs) {
                    window.chartGraph = data.chartGraphs[0];
                    swfobject.embedSWF("${ctx}/static/component/open-flash-chart-2/open-flash-chart.swf", "chart", "350", "200", "9.0.0");
                }

            }});
            var form = $("form");
            var fieldName = form.find("[name=fieldName]");
            var min = form.find("[data-name=search_GTE_]");
            var max = form.find("[data-name=search_LTE_]");
            fieldName.change(function () {
                min.attr("name", min.attr("data-name") + this.value);
                max.attr("name", max.attr("data-name") + this.value)
            }).change();
        });
    </script>
</head>
<body>
<%--<div id="my_chart"></div>--%>
<div class="listcontainer">
    <form action="${ctx}/common/report/generate.do" onsubmit="return false;">
        <input type="hidden" name="id" value="${report.id}">
        <table class="fl mt5 w">
            <tr>
                <td class="f14" align="right" width="6%">列：</td>
                <td class="f14" align="left" width="16%">
                    <div class="pr">
                        <select name="fieldName" class="select2 pr">
                            <c:forEach items="${moduleFields}" var="item">
                                <option value="${item.name}" label="${item.desc}">${item.desc}</option>
                            </c:forEach>
                        </select>
                    </div>
                </td>
                <td class="f14" align="right" width="6%">日期范围：</td>
                <td class="f14" align="left" width="16%">
                    <div class="pr">
                        <select class="select2 pr">
                            <option value="">自定义</option>
                        </select>
                    </div>
                </td>
                <td class="f14" align="right" width="6%">起止时间：</td>
                <td class="f14" align="left" width="16%">
                    <div class="vm">
                        <input type="text" data-name="search_GTE_" value="${time}" class="text_input2 input_close globle_img untime time" readonly/>
                        -
                        <input type="text" data-name="search_LTE_" value="${time}" class="text_input2 input_close globle_img untime time" readonly/>
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

    <div class="ml35 mr35">
        <table class="cb id_table2 w pr35">
            <tbody class="list"></tbody>
            <textarea id="template-charttable" class="template template-charttable">
                {#if Boolean($T.yAxisHeader)==false}
                <tr>
                    {#foreach $T.xAxisHeader as row}
                    <th>{$T.row}</th>
                    {#/for}
                </tr>
                <tr class="row {#cycle values=['bg_c_blue','']}">
                    {#foreach $T.rows as cell}
                    <td>{$T.cell}</td>
                    {#/for}
                </tr>
                {#else}
                <tr>
                    <th></th>
                    {#foreach $T.xAxisHeader as row}
                    <th>{$T.row}</th>
                    {#/for}
                </tr>
                {#foreach $T.rows as row}
                <tr class="row {#cycle values=['bg_c_blue','']}">
                    <td>{$T.yAxisHeader[$T.row$index]}</td>
                    {#foreach $T.row as cell}
                    <td>{$T.cell}</td>
                    {#/for}
                </tr>
                {#/for}
                {#/if}
            </textarea>
        </table>
        <div id="chart">

        </div>
    </div>
</div>

</body>
</html>