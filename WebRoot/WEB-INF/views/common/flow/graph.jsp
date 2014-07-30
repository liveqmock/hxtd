<%--
  流程图谱
  User: xiayouxue
  Date:2014/7/27
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--流程图谱--%>
<div class="fr pt20  bg_c_blue mb20" style="width:21%">
    <%--历史记录--%>
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
    <%--跳过环节--%>
    <c:forEach items="${skipFlowNodes}" var="flowNode">
        <ul class="margin0 block bor_336699 brall5 p10 bg_c_d3d3d3" style="max-width:200px;">
            <li>${flowNode.name}：<span>${flowNode.approver.realName}</span></li>
        </ul>
        <div class="bigjiantoux globle_img margin0"></div>
    </c:forEach>
    <%--当前环节--%>
    <ul class="margin0 block bor_336699 brall5 p10 bg_c_fed8a7" style="max-width:200px;">
        <li>${currentFlowNode.name}<c:if test="${currentFlowNode.type!=endFlowNode}">：<span>${currentFlowNode.approver.realName}</span></c:if></li>
    </ul>
    <%--预定环节--%>
    <c:forEach items="${reserveFlowNodes}" var="flowNode">
        <div class="bigjiantoux globle_img margin0"></div>
        <ul class="margin0 block bor_336699 brall5 p10 bg_c_d3d3d3" style="max-width:200px;">
            <li>${flowNode.name}<c:if test="${flowNode.type!=endFlowNode}">：<span>${flowNode.approver.realName}</span></c:if></li>
        </ul>
    </c:forEach>
</div>