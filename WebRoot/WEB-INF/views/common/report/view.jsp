<%--
  报表明细页
  report: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>报表详情</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/list1.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>

</head>

<body>
<div>
    <div class="cb"></div>
    <div class="ml35 mr35 mt20 block cb cb">
        <b class="table_headl globle_img block fl"></b>

        <div class="fl table_headc fl w99b">
            <h1 class="f14 fbnone mt10 ml10 fl">报表详细信息</h1>
            <ul class="fr id_table1 mt10 ml10">
                <c:if test="${VS_HAS_FUNCTIONS.reportModify&&!report.isInitialized}">
                    <li><a href="${ctx}/common/report/toModifyPage.do?id=${report.id}" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b></a></li>
                </c:if>
                <li><a href="${ctx}/common/report/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b></a></li>
            </ul>
        </div>

        <b class="table_headr globle_img block fl"></b>
    </div>

    <div class="ml35 mr35 bg_c_blue cb">
        <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%">编号：</td>
                <td align="left">${report.code}</td>
                <td align="right" width="15%">名称：</td>
                <td align="left">${report.name}</td>
            </tr>
            <tr>
                <td align="right" width="15%">所属模块：</td>
                <td align="left">${report.module.desc}</td>
                <td align="right" width="15%">图表类型：</td>
                <td align="left">${report.chart.key}</td>
            </tr>
            <tr>
                <td align="right" width="15%">X轴字段名：</td>
                <td align="left">${report.xFieldName}</td>
                <td align="right" width="15%">X轴分组类型：</td>
                <td align="left">${report.xGroupType.key}</td>
            </tr>
            <tr>
                <td align="right" width="15%">Y轴字段名：</td>
                <td align="left">${report.yFieldName} </td>
                <td align="right" width="15%">Y轴聚合类型：</td>
                <td align="left">${report.yAggregateType.key}</td>
            </tr>
            <tr>
                <td align="right" width="15%">Z轴字段名：</td>
                <td align="left">${report.zFieldName}</td>
                <td align="right" width="15%">Z轴分组类型：</td>
                <td align="left">${report.zGroupType.key}</td>
            </tr>
        </table>
        <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
        <table class="cb id_table4 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%" valign="top">备注：</td>
                <td align="left" width="85%" valign="top">
                    <div class="w85b">${report.remark}</div>
                </td>
            </tr>
        </table>
        <div class=" h40"></div>
    </div>
</div>
</body>
</html>