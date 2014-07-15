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
            return JSON.stringify(window.chartGraph);
        }

        $(function () {
            jsUtil.twoOrMoreRestrictDate('.time', 'max', 0); //创建、修改时间

            var form = $("form");
            var fieldName = form.find("[name=fieldName]");
            var min = form.find("[data-name=search_GTE_]");
            var max = form.find("[data-name=search_LTE_]");
            fieldName.change(function () {
                min.attr("name", min.attr("data-name") + this.value);
                max.attr("name", max.attr("data-name") + this.value)
            }).change();

            var chartTable = $(".list");
            new Grid().init({renderList: function (data) {
                data = data.result;
                chartTable.setTemplateElement("template-charttable").processTemplate(data.chartTable);

                if (data.chart) {
                    window.chartGraph = $.parseJSON(data.chart);
                    swfobject.embedSWF("${ctx}/static/component/open-flash-chart-2/open-flash-chart.swf", "chart", "350", "200", "9.0.0");
                }
            }});
        });
    </script>
</head>
<body>
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

    <div class="ml35 mr35 mt10 block cb cb">
        <b class="b1"></b>
        <b class="b2"></b>
        <b class="b3"></b>
        <b class="b4"></b>

        <div class="ie_head">
            <h1 class="f14 fbnone mt10 ml10 fl">${report.name}</h1>
            <%--
            <ul class="fr id_table1 mt10 ml10">
                <li><a href="javascript:;" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b></a></li>
                <li><a href="javascript:;" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保存并新增</b></a></li>
                <li><a href="javascript:;" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b></a></li>
            </ul>
            --%>
        </div>
    </div>

    <div class="ml35 mr35 bg_c_blue cb">
        <h1 class="f14 fbnone tc pt10">表格数据</h1>
        <table class="cb id_tantable2 w70b bg_c_white margin0 mt10 mb10">
            <tbody class="list"></tbody>
        </table>
        <textarea id="template-charttable" class="template template-charttable">
            <tr>
                <td class="bg_c_d3d3d3 fb">
                    <div class="fl mt20">{$T.yAxisTitle}</div>
                    <div class="fr">{$T.xAxisTitle}</div>
                </td>
                {#foreach $T.xAxisHeader as row}
                <td class="fb">{$T.row}</td>
                {#/for}
            </tr>
            {#foreach $T.rows as row}
            <tr class="row {#cycle values=['bg_c_f3f3f3','']}">
                <td class="fb">{$T.yAxisHeader[$T.row$index]}</td>
                {#foreach $T.row as cell}
                <td>{$T.cell}</td>
                {#/for}
            </tr>
            {#/for}
        </textarea>

        <h1 class="f14 fbnone tc">图表信息</h1>

        <div class="cb id_table4 w50b margin0 p10 mt10 mb10" style="text-align: center">
            <div id="chart"></div>
        </div>

        <div class="h40"></div>
    </div>

    <div class="cb block h40 margin0 mt10" style="width:257px;">
        <ul class="id_table1 cb">
            <li><a href="javascript:;" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b></a></li>
            <li><a href="javascript:;" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保存并新增</b></a></li>
            <li><a href="javascript:;" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b></a></li>
        </ul>
    </div>

</div>

</body>
</html>