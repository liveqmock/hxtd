<%--
  功能描述：销售目标详情
  User: xiaoli.luo
  Date:2014/5/19
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>销售目标详情</title>
    <link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script type="text/javascript" src="${ctx}/static/component/open-flash-chart-2/js/json/json2.js"></script>
    <script type="text/javascript" src="${ctx}/static/component/open-flash-chart-2/js/swfobject.js"></script>

    <script type="text/javascript">
        function open_flash_chart_data() {
            return JSON.stringify(${chart});
        }

        swfobject.embedSWF("${ctx}/static/component/open-flash-chart-2/open-flash-chart.swf", "chart", "100%", "200", "9.0.0");
    </script>
</head>
<body>
<div>
    <div class="cb"></div>
    <div class="ml35 mr35 mt20 block cb cb">
        <b class="b1"></b>
        <b class="b2"></b>
        <b class="b3"></b>
        <b class="b4"></b>

        <div class="ie_head">
            <h1 class="f14 fbnone mt10 ml10 fl">销售目标详情信息</h1>
            <ul class="fr id_table1 mt10 ml10">
                <c:if test="${VS_HAS_FUNCTIONS.salesTargetModify}">
                    <li>
                        <a class=" pl10 c_white f14 lh25 cp block fr" href="${ctx }/sales/salesTarget/toModifyPage.do?id=${salesTarget.id}">
                            <b class="allbtn_l block fl"></b>
                            <b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b>
                        </a>
                    </li>
                </c:if>
                <li>
                    <a class=" pl10 c_white f14 lh25 cp block fr mr10"
                       href="${ctx }/sales/salesTarget/toQueryPage.do"><b
                            class="allbtn_l block fl"></b><b
                            class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="ml35 mr35 bg_c_blue cb">
        <h1 class="f14 fbnone ml40 pt10">
            基本信息
        </h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%">标题：</td>
                <td align="left">${salesTarget.title}</td>
                <td align="right" width="15%">目标人员：</td>
                <td align="left">${salesTarget.owner.realName }</td>
            </tr>
            <tr>
                <td align="right">目标成交额（万）：</td>
                <td align="left">${salesTarget.bargainMoney}</td>
                <td align="right">时间周期：</td>
                <td align="left">${salesTarget.timeStr }</td>
            </tr>
        </table>
        <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
        <table class="cb id_table4 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%" valign="top">备注：</td>
                <td align="left" width="85%" valign="top">
                    <div class="w85b">${salesTarget.remark }</div>
                </td>
            </tr>
        </table>
        <h1 class="f14 fbnone ml40 pt10">完成订单数</h1>
        <table class="cb id_table4 w95b bg_c_white margin0 mt10">
            <tr>
                <td id="chart"></td>
            </tr>
        </table>
        <h1 class="f14 fbnone ml40 pt10">统计数值</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%">实际金额（万）：</td>
                <td align="left">${finishedMoney}</td>
                <td align="right" width="15%">目标金额（万）：</td>
                <td align="left">${salesTarget.bargainMoney}</td>
            </tr>
            <tr>
                <td align="right">完成百分比（%）：</td>
                <td align="left" width="15%"><fmt:formatNumber value="${100*finishedMoney/salesTarget.bargainMoney}" pattern="#0.00"/></td>
                <td align="right">成交订单数：</td>
                <td align="left" width="15%">${finishedCount}</td>
            </tr>
        </table>
        <div class="h40"></div>
    </div>
</div>
</body>
</html>
