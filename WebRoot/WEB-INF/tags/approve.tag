<%@tag pageEncoding="UTF-8" %>
<%@ attribute name="reserveExecuteRecoreds" type="java.util.List" required="true" %>
<%@ attribute name="historyRecords" type="java.util.List" required="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<h1 class="f14 fbnone ml40 mt10">订单审批</h1>

<div class="w95b bg_c_white margin0 mt10">
    <h1 class="w90b margin0 fbnone f12 pt20 block">审批流程：</h1>
    <b class="w90b f_line2 block margin0"></b>
    <table class="cb id_table2 w90b margin0 mt10 mb10">
        <tr>
            <th>审批名称</th>
            <th>审批人</th>
            <th>操作</th>
        </tr>
        <tbody class="list">
        <c:forEach items="${reserveExecuteRecoreds}" var="flowNode" varStatus="status">
            <tr class="bg_c_blue">
                <td>${flowNode.name}<input type="hidden" name="reserveExecuteRecoreds[${status.index}].id" value="${flowNode.id}"></td>
                <td>
                    <select name="reserveExecuteRecoreds[${status.index}].approver.id" class="select3 pr">
                        <c:forEach items="${flowNode.approvers}" var="approver">
                            <option value="${approver.id}" ${approver.id==flowNode.approver.id?"selected":""}>${approver.realName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td><a href="javascript:void(0);" class="block_inline s_approve globle_img ml10" title="保存"></a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <h1 class="w90b margin0 fbnone f12 pt20 block">审批记录：</h1>
    <b class="w90b f_line2 block margin0"></b>
    <table class="cb id_table2 w90b margin0 mt10 mb10">
        <tr>
            <th>审批名称</th>
            <th>机构名称</th>
            <th>审批人</th>
            <th>状态</th>
            <th>备注</th>
        </tr>
        <tbody class="list">
        <c:forEach items="${historyRecords}" var="historyRecord">
            <tr class="bg_c_blue">
                <td>${historyRecord.flowNode.name}</td>
                <td></td>
                <td>${historyRecord.approver.realName}</td>
                <td>${historyRecord.isPassed?"通过":"未通过"}</td>
                <td>${historyRecord.reason}</td>
            </tr>
        </c:forEach>
        <tr>
            <td>投资经理</td>
            <td>市场营销部</td>
            <td>投资经理A1</td>
            <td>未通过</td>
            <td>购买金额不对</td>
        </tr>
        </tbody>
    </table>
</div>