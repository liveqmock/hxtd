<%--
  功能描述：订单详情
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
    <title>${VR_FUNCTION.name}</title>
    <link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/css/recommend/detail_a.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script type="text/javascript">
        $(function () {

            var approveButton = $(".button${VR_FUNCTION.code}");
            var approveDialog = $(".dialog${VR_FUNCTION.code}");
            var approveForm = $(".form${VR_FUNCTION.code}");
            approveButton.click(function () {approveDialog.dialog("open");});

            var dialogOptions = {
                "060108": {
                    autoOpen: false,
                    modal: false,
                    width: 500,
                    buttons: {
                        "确定": function () {
                            RcmsAjax.ajax(approveForm.attr("action"), function (result) {
                                setTimeout(function () {
                                    approveDialog.dialog("close");
                                    window.open("${ctx}/order/order/toViewPage.do?id=${order.id}", "_self");
                                }, 500);
                            }, null, approveForm.formSerialize());
                        },
                        "关闭": function () {
                            $(this).dialog("close");
                        }
                    }},
                "060109": {
                    autoOpen: false,
                    modal: false,
                    width: 500,
                    buttons: {
                        "确定": function () {
                            RcmsAjax.ajax(approveForm.attr("action"), function (result) {
                                setTimeout(function () {
                                    approveDialog.dialog("close");
                                    window.open("${ctx}/order/order/toViewPage.do?id=${order.id}", "_self");
                                }, 500);
                            }, null, approveForm.formSerialize());
                        },
                        "关闭": function () {
                            $(this).dialog("close");
                        }
                    }}
            };

            approveDialog.dialog(dialogOptions["${VR_FUNCTION.code}"]);

        });
        function printDIV(printarea) {
            var head = "<html><head><title></title></head><body>";//先生成头部
            var foot = "</body></html>";//生成尾部
            var newstr = document.all.item(printarea).innerHTML;//获取指定打印区域
            var oldstr = document.body.innerHTML;//获得原本页面的代码
            document.body.innerHTML = newstr;//购建新的网页
            window.print();//打印刚才新建的网页
            document.body.innerHTML = oldstr;//将网页还原
            return false;
        }
    </script>
</head>
<body>
<c:set var="orderApprove" value="${orderStartApprove||orderExecuteApprove}"/>
<div>
<div class="cb"></div>
<div class="ml35 mr35 mt10 block cb cb">
    <b class="b1"></b>
    <b class="b2"></b>
    <b class="b3"></b>
    <b class="b4"></b>

    <div class="ie_head">
        <h1 class="f14 fbnone mt10 ml10 fl">${orderView?"订单详情信息":(orderApprove?"订单审核信息":"？？？？（未预计的功能）")}</h1>
        <ul class="fr id_table1 mt10 ml10">
            <li>
                <a class="pl10 c_white f14 lh25 cp block fr" href="javascript:;" onclick="printDIV('printBody')">
                    <b class="allbtn_l block fl"></b>
                    <b class="allbtn_r pr13 block fl w_auto f14">打&nbsp;&nbsp;印</b>
                </a>
            </li>
            <c:if test="${orderView&&VS_HAS_FUNCTIONS.orderModify}">
                <li>
                    <a class="pl10 c_white f14 lh25 cp block fr" href="${ctx }/order/order/toModifyPage.do?id=${order.id}">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b>
                    </a>
                </li>
            </c:if>
            <c:if test="${orderApprove}">
                <li>
                    <a href="javascript:void(0);" class="pl10 c_white f14 lh25 cp block fr button${VR_FUNCTION.code}">
                        <b class="allbtn_l block fl"></b>
                        <b class="allbtn_r pr13 block fl w_auto f14">${VR_FUNCTION.name}</b>
                    </a>
                </li>
            </c:if>
            <li>
                <a class="pl10 c_white f14 lh25 cp block fr mr10"
                   href="${ctx }/order/order/toQueryPage.do"><b
                        class="allbtn_l block fl"></b><b
                        class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b>
                </a>
            </li>
        </ul>
    </div>
</div>
<div class="ml35 mr35 bg_c_blue" style="overflow:hidden">
    <div class="fl " style="width:78%" id="printBody">
        <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%">订单编号：</td>
                <td align="left">${order.code}</td>
                <td align="right" width="15%">所有者：</td>
                <td align="left">${order.owner.name }</td>
            </tr>
            <tr>
                <td align="right">产品：</td>
                <td align="left">${order.product.name }</td>
                <td align="right">客户：</td>
                <td align="left">${order.customer.name }</td>
            </tr>
            <tr>
                <td align="right">订单状态：</td>
                <td align="left">${order.status.name}</td>
                <td align="right">投资方式：</td>
                <td align="left">${order.investmentWay.key}</td>
            </tr>
            <tr>
                <td align="right">购买金额：</td>
                <td align="left">${order.purchaseMoney}</td>
                <td align="right">收益率：</td>
                <td align="left">${order.earningRate}%</td>
            </tr>
            <tr>
                <td align="right">赎回率：</td>
                <td align="left">${order.arr }%</td>
                <td align="right">赎回公式：</td>
                <td align="left">${order.redeemFormula }</td>
            </tr>
            <tr>
                <td align="right" width="15%">销售主管：</td>
                <td align="left">${order.salesManager.name }</td>
                <td align="right" width="15%">销售总监：</td>
                <td align="left">${order.salesMajordomo.name }</td>
            </tr>
            <tr>
                <td align="right">结束时间：</td>
                <td align="left"><fmt:formatDate value="${order.orderEndTime }" pattern="yyyy-MM-dd" var="endTime"/>${endTime }</td>
            </tr>
        </table>
        <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
        <table class="cb id_table4 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%" valign="top">备注：</td>
                <td align="left" width="85%" valign="top">
                    <div class="w85b">${order.remark }</div>
                </td>
            </tr>
        </table>
    </div>

    <%--流程环节--%>
    <div class="fr pt20  bg_c_blue mb20" style="width:21%">
        <c:forEach items="${historyRecords}" var="record" varStatus="status">
            <ul class="margin0 block bor_336699 brall5 p10 bg_c_${record.isPassed?'e8fdf3':'fde8e8'}" style="max-width:200px;">
                <li>流程名称：<span>${record.flowNode.name}</span></li>
                <li>审批人：<span>${record.approver.realName}</span></li>
                <li>审批时间：<span><fmt:formatDate value="${record.approveTime}" pattern="yyyy-MM-dd HH:mm"/> </span></li>
                <li>审批结果：<span>${record.isPassed?"通过":"未通过"}</span></li>
                <li>原因：<span>${record.reason}</span></li>
            </ul>
            <div class="bigjiantou globle_img margin0"></div>
        </c:forEach>
        <c:forEach items="${skipFlowNodes}" var="flowNode">
            <ul class="margin0 block bor_336699 brall5 p10 bg_c_d3d3d3" style="max-width:200px;">
                <li>${flowNode.name}：<span>${flowNode.approver.realName}</span></li>
            </ul>
            <div class="bigjiantoux globle_img margin0"></div>
        </c:forEach>
        <ul class="margin0 block bor_336699 brall5 p10 bg_c_fed8a7" style="max-width:200px;">
            <li>${currentFlowNode.name}<c:if test="${currentFlowNode.type!=endFlowNode}">：<span>${currentFlowNode.approver.realName}</span></c:if></li>
        </ul>
        <c:forEach items="${reserveFlowNodes}" var="flowNode">
            <div class="bigjiantoux globle_img margin0"></div>
            <ul class="margin0 block bor_336699 brall5 p10 bg_c_d3d3d3" style="max-width:200px;">
                <li>${flowNode.name}<c:if test="${flowNode.type!=endFlowNode}">：<span>${flowNode.approver.realName}</span></c:if></li>
            </ul>
        </c:forEach>
    </div>

    <%--启动审批--%>
    <c:if test="${orderStartApprove}">
        <div class="dialog060108 hidden" title="启动审批">
            <h1 class="w90b margin0 fbnone f12 pt20 block">选择各个流程环节的审批人：</h1>
            <b class="w90b f_line2 block margin0"></b>

            <form name="${VR_FUNCTION.code}" action="${ctx}${VR_FUNCTION.url}" method="post" class="form060108">
                <input type="hidden" name="executeRecord.recordId" value="${order.id}"/>
                <input type="hidden" name="executeRecord.flowNode.id" value="${order.status.id}"/>
                <input type="hidden" name="executeRecord.flowNode.type" value="${order.status.type}"/>

                <table class="cb id_table2 w90b margin0 mt10 mb10">
                    <tr>
                        <th>流程环节名称</th>
                        <th>审批人</th>
                    </tr>
                    <tbody class="list">
                    <c:forEach items="${preselectionFlowNodes}" var="flowNode" varStatus="status">
                        <c:set var="name" value="reserveExecuteRecoreds[${status.index}]"/>
                        <tr class="${status.index%2==0?'bg_c_blue':''}">
                            <td style="text-align: left">${flowNode.name}<input type="hidden" name="${name}.flowNode.id" value="${flowNode.id}"></td>
                            <td>
                                <c:if test="${flowNode.type!=endFlowNode}">
                                    <select name="${name}.approver.id" class="select3 pr">
                                        <c:forEach items="${flowNode.approvers}" var="approver">
                                            <option value="${approver.id}" ${approver.id==flowNode.approver.id?"selected":""}>${approver.realName}</option>
                                        </c:forEach>
                                    </select>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </form>
        </div>
    </c:if>

    <%--执行审批--%>
    <c:if test="${orderExecuteApprove}">
        <div class="dialog060109 hidden" title="执行审批">
            <h1 class="w90b margin0 fbnone f12 pt20 block">填写审批意见：</h1>
            <b class="w90b f_line2 block margin0"></b>

            <form name="${VR_FUNCTION.code}" action="${ctx}${VR_FUNCTION.url}" method="post" class="form060109">
                <input type="hidden" name="currentFlowNode.id" value="${order.status.id}"/>
                <input type="hidden" name="currentFlowNode.name" value="${order.status.name}"/>
                <input type="hidden" name="currentFlowNode.type" value="${order.status.type}"/>

                <input type="hidden" name="nextFlowNode.id" value="${nextFlowNode.id}"/>
                <input type="hidden" name="nextFlowNode.type" value="${nextFlowNode.type}"/>

                <input type="hidden" name="executeRecord.recordId" value="${order.id}"/>
                <input type="hidden" name="executeRecord.flowNode.id" value="${currentFlowNode.id}"/>
                <input type="hidden" name="executeRecord.flowNode.name" value="${currentFlowNode.name}"/>
                <input type="hidden" name="executeRecord.flowNode.type" value="${currentFlowNode.type}"/>

                <table class="cb id_table2 w90b margin0 mt10 mb10">
                    <tr>
                        <td width="30%" align="right"><i class="mt3 block">${currentFlowNode.name}：</i></td>
                        <td class="pl10">
                            <label><input type="radio" name="executeRecord.isPassed" value="1" checked="checked"/>同意</label>
                            <label><input type="radio" name="executeRecord.isPassed" value="0"/>退回</label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">下一节点名称：</td>
                        <td class="pl10">${nextFlowNode.name}</td>
                    </tr>
                        <%--结束流程节点不显示参与者--%>
                    <c:if test="${nextFlowNode.type!=endFlowNode}">
                        <tr>
                            <td align="right"><i class="mt3 block">审批参与者：</i></td>
                            <td class="pl10">
                                <select name="nextFlowNode.approver.id" class="select3 pr">
                                    <c:forEach items="${nextFlowNode.approvers}" var="approver">
                                        <option value="${approver.id}" ${approver.id==nextFlowNode.approver.id?"selected":""}>${approver.realName}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td align="right" valign="top">原因：</td>
                        <td class="pl10">
                            <textarea name="executeRecord.reason" class="remarks_input3" style="height:100px;"></textarea>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </c:if>

    <div class="h40"></div>
</div>
</div>
</body>
</html>
