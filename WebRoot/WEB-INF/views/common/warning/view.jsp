<%--
  预警详情页
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
    <link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
    <link href="${ctx}/static/css/stressing/empower.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>

    <script type="text/javascript" src="${ctx}/static/component/open-flash-chart-2/js/json/json2.js"></script>
    <script type="text/javascript" src="${ctx}/static/component/open-flash-chart-2/js/swfobject.js"></script>

    <script type="text/javascript">

        var charts = {
            "weekChart": JSON.stringify(${weekChart.chart==null?"":weekChart.chart}),
            "monthChart": JSON.stringify(${monthChart.chart==null?"":monthChart.chart})
        };

        function open_flash_chart_data() {
            return charts.weekChart || charts.monthChart;
        }

        function findSWF(movieName) {
            if (navigator.appName.indexOf("Microsoft") != -1) {
                return window[movieName];
            } else {
                return document[movieName];
            }
        }

        charts.weekChart && swfobject.embedSWF("${ctx}/static/component/open-flash-chart-2/open-flash-chart.swf", "weekChart", "100%", "200", "9.0.0");
        charts.monthChart && swfobject.embedSWF("${ctx}/static/component/open-flash-chart-2/open-flash-chart.swf", "monthChart", "100%", "200", "9.0.0");

        $(function () {
            $C.tab({onSelected: function (event, title, panel) {
                var movieName = panel.attr("data-chart");
                var object = findSWF(movieName);
                object && setTimeout(function () {object.load(charts[movieName])}, 100);
            }});
        });
    </script>
</head>
<body>
<div class=" listcontainer">
    <div class="cb"></div>
    <div class="ml35 mr35">
        <ul class="fl id_table3 w block cb mt10 tab-titles" style="border-bottom:5px solid #626262; height:32px;">
            <li class="tab-title" fortabpanel="#weekChartPanel">
                <b class="h_tabbtn_l w25 block fl"></b>
                <b class="h_tabbtn_r pr25 w_auto f14 block fr lh32 cp id_nav pr">一周内</b>
            </li>
            <li class="tab-title" fortabpanel="#monthChartPanel">
                <b class="h_tabbtn_l w25 block fl"></b>
                <b class="h_tabbtn_r  pr25 w_auto f14 block fr lh32 cp id_nav pr">一月内</b>
            </li>
        </ul>
        <div class="w cb tab-panels">
            <div id="weekChartPanel" class="tab-panel bg_c_blue" data-chart="weekChart">
                <h1 class="f14 fbnone tc pt10">表格数据</h1>
                <table class="cb id_tantable2 w90b bg_c_white margin0 mt10 mb10">
                    <c:choose>
                        <c:when test="${weekChart.chartTable==null}">
                            <tr>
                                <td align='center'>
                                    <div class='allnone'></div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td class="bg_c_d3d3d3 fb">
                                    <div class="fl mt20">${weekChart.chartTable.yAxisTitle}</div>
                                    <div class="fr">${weekChart.chartTable.xAxisTitle}</div>
                                </td>
                                <c:forEach items="${weekChart.chartTable.xAxisHeader}" var="item">
                                    <td class="fb"><a href="${ctx}/order/order/toViewPage.do?TYPE=code&code=${item}" target="_blank">${item}</a></td>
                                </c:forEach>
                                <td class="fb">总计</td>
                            </tr>
                            <c:forEach items="${weekChart.chartTable.rows}" var="row" varStatus="status">
                                <c:set var="rowTotal" value="0"/>
                                <tr class="row">
                                    <td class="fb">${weekChart.chartTable.yAxisHeader[status.index]}</td>
                                    <c:forEach items="${row}" var="cell">
                                        <c:set var="rowTotal" value="${rowTotal+cell}"/>
                                        <td>${cell}</td>
                                    </c:forEach>
                                    <td>${rowTotal}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </table>

                <h1 class="f14 fbnone tc">图表信息</h1>

                <div class="cb id_table4 w90b margin0 p10 mt10 mb10" style="text-align: center">
                    <div id="weekChart">
                        <div class='allnone'></div>
                    </div>
                </div>
            </div>
            <div id="monthChartPanel" class="tab-panel bg_c_blue" data-chart="monthChart">
                <h1 class="f14 fbnone tc pt10">表格数据</h1>
                <table class="cb id_tantable2 w90b bg_c_white margin0 mt10 mb10">
                    <c:choose>
                        <c:when test="${monthChart.chartTable==null}">
                            <tr>
                                <td align='center'>
                                    <div class='allnone'></div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td class="bg_c_d3d3d3 fb">
                                    <div class="fl mt20">${monthChart.chartTable.yAxisTitle}</div>
                                    <div class="fr">${monthChart.chartTable.xAxisTitle}</div>
                                </td>
                                <c:forEach items="${monthChart.chartTable.xAxisHeader}" var="item">
                                    <td class="fb"><a href="${ctx}/order/order/toViewPage.do?TYPE=code&code=${item}" target="_blank">${item}</a></td>
                                </c:forEach>
                                <td class="fb">总计</td>
                            </tr>
                            <c:forEach items="${monthChart.chartTable.rows}" var="row" varStatus="status">
                                <c:set var="rowTotal" value="0"/>
                                <tr class="row">
                                    <td class="fb">${monthChart.chartTable.yAxisHeader[status.index]}</td>
                                    <c:forEach items="${row}" var="cell">
                                        <c:set var="rowTotal" value="${rowTotal+cell}"/>
                                        <td>${cell}</td>
                                    </c:forEach>
                                    <td>${rowTotal}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose></table>

                <h1 class="f14 fbnone tc">图表信息</h1>

                <div class="cb id_table4 w90b margin0 p10 mt10 mb10" style="text-align: center">
                    <div id="monthChart">
                        <div class='allnone'></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>