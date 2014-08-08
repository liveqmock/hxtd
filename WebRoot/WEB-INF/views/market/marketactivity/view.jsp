<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>市场活动详情</title>
    <link href="${ctx}/static/css/recommend/list1.css?v=1" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>

    <script type="text/javascript">
        $(function () {
            <c:if test="${marketactivityStartApprove||marketactivityExecuteApprove}">
            //审批后重定向至详情页
            var redirectURI = "${ctx}/market/marketactivity/toViewPage.do?id=${activity.id}";
            if ("${param.returnURI}") {redirectURI += "&returnURI=${param.returnURI}";}
            window.flow = new jsUtil.Flow().init({operateType: "${marketactivityStartApprove?"start":"execute"}", redirectURI: redirectURI});
            </c:if>
        });
    </script>
</head>
<body>
<div>
    <div class="ml35 mr35 mt20 block cb cb">
        <b class="b1"></b>
        <b class="b2"></b>
        <b class="b3"></b>
        <b class="b4"></b>

        <div class="ie_head">
            <h1 class="f14 fbnone mt10 ml10 fl">市场活动详情信息</h1>
            <ul class="fr id_table1 mt10 ml10">
                <c:if test="${marketactivityView&&VS_HAS_FUNCTIONS.marketactivityModify&&activity.flowNode.type==startNodeType}">
                    <li>
                        <a href="${ctx}/market/marketactivity/toModifyPage.do?id=${activity.id}" class="block c_white lh25 mr10">
                            <b class="allbtn_l block fl"></b>
                            <b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b>
                        </a>
                    </li>
                </c:if>
                <c:if test="${marketactivityStartApprove||marketactivityExecuteApprove}">
                    <li><a href="javascript:void(0);" class="pl10 c_white f14 lh25 cp block fr flow-operate"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">${VR_FUNCTION.name}</b></a></li>
                </c:if>
                <%--财务审批时，跳转回财务审批列表页，通过参数returnURI实现--%>
                <li><a class="pl10 c_white f14 lh25 cp block fr mr10" href="${ctx}${param.returnURI==null?'/market/marketactivity/toQueryPage.do':param.returnURI}"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b></a></li>
            </ul>
        </div>
    </div>

    <div class="ml35 mr35 bg_c_blue" style="overflow:hidden">
        <div class="fl " style="width:78%">
            <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
            <table class="cb id_table3 w95b bg_c_white margin0 mt10">
                <tr>
                    <td width="15%" align="right">活动所有者：</td>
                    <td align="left">${activity.sponsor.realName}</td>
                    <td width="15%" align="right">活动名称：</td>
                    <td align="left">${activity.name}</td>
                </tr>
                <tr>
                    <td align="right">负责人：</td>
                    <td align="left">${activity.bossHead.realName}</td>
                    <td align="right">活动类型：</td>
                    <td align="left">${activity.typeDic.key}</td>
                </tr>
                <tr>
                    <td align="right">开始日期：</td>
                    <td align="left">
                        <fmt:formatDate value="${activity.beginDate}" pattern="yyyy-MM-dd" var="beginDate"/>${beginDate}
                    </td>
                    <td align="right">活动状态：</td>
                    <td align="left">${activity.statusDic.key}</td>
                </tr>
                <tr>
                    <td align="right">结束日期：</td>
                    <td align="left">
                        <fmt:formatDate value="${activity.endDate}" pattern="yyyy-MM-dd" var="endDate"/>${endDate}
                    </td>
                    <td align="right">预计成本（元）：</td>
                    <td align="left"><fmt:formatNumber value="${activity.predictCost}" pattern="###,##0.00" var="predictCost"/>${predictCost}</td>
                </tr>
                <tr>
                    <td align="right">预期效果：</td>
                    <td align="left">${activity.expectEffect}</td>
                    <td align="right">实际成本（元）：</td>
                    <td align="left"><fmt:formatNumber value="${activity.realityCost}" pattern="###,##0.00" var="realityCost"/>${realityCost}</td>
                </tr>
                <tr>
                    <td align="right">期望成功率（%）：</td>
                    <td align="left">${activity.expectSuccessRate}%</td>
                    <td align="right">活动次数：</td>
                    <td align="left">${activity.times}</td>
                </tr>
            </table>
            <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
            <table class="cb id_table6 w95b bg_c_white margin0 mt10">
                <tr>
                    <td align="right" width="15%" valign="top">备注：</td>
                    <td align="left" valign="top">
                        <div class="w85b">${activity.remark}</div>
                    </td>
                </tr>
            </table>
            <div class="h40"></div>
        </div>

        <%--流程图谱--%>
        <%@include file="../../common/flow/graph.jsp" %>
        <%--启动审批--%>
        <c:if test="${marketactivityStartApprove}">
            <%@include file="../../common/flow/start.jsp" %>
        </c:if>
        <%--执行审批--%>
        <c:if test="${marketactivityExecuteApprove}">
            <%@include file="../../common/flow/execute.jsp" %>
        </c:if>
    </div>
</div>

</body>
</html>