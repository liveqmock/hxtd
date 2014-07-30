<%--
  执行流程
  User: xiayouxue
  Date:2014/7/27
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="flow-dialog dialog-execute hidden" title="执行审批">
    <h1 class="w90b margin0 fbnone f12 pt20 block">填写审批意见：</h1>
    <b class="w90b f_line2 block margin0"></b>

    <form action="${ctx}${VR_FUNCTION.url}" method="post" class="form-execute">
        <input type="hidden" name="currentFlowNode.id" value="${entity.flowNode.id}"/>
        <input type="hidden" name="currentFlowNode.name" value="${entity.flowNode.name}"/>
        <input type="hidden" name="currentFlowNode.type" value="${entity.flowNode.type}"/>
        <input type="hidden" name="currentFlowNode.flow.id" value="${entity.flowNode.flow.id}"/>
        <input type="hidden" name="currentFlowNode.flow.value" value="${entity.flowNode.flow.value}"/>

        <input type="hidden" name="nextFlowNode.id" value="${nextFlowNode.id}"/>
        <input type="hidden" name="nextFlowNode.name" value="${nextFlowNode.name}"/>
        <input type="hidden" name="nextFlowNode.type" value="${nextFlowNode.type}"/>
        <input type="hidden" name="nextFlowNode.flow.id" value="${nextFlowNode.flow.id}"/>
        <input type="hidden" name="nextFlowNode.flow.value" value="${nextFlowNode.flow.value}"/>

        <%--<input type="hidden" name="executeRecord.module.id" value="${entity.module.id}"/>--%>
        <input type="hidden" name="executeRecord.recordId" value="${entity.id}"/>
        <input type="hidden" name="executeRecord.flowNode.id" value="${currentFlowNode.id}"/>
        <input type="hidden" name="executeRecord.flowNode.name" value="${currentFlowNode.name}"/>
        <input type="hidden" name="executeRecord.flowNode.type" value="${currentFlowNode.type}"/>
        <input type="hidden" name="executeRecord.flowNode.flow.id" value="${currentFlowNode.flow.id}"/>
        <input type="hidden" name="executeRecord.flowNode.flow.value" value="${currentFlowNode.flow.value}"/>

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
            <c:if test="${nextFlowNode.type!=endNodeType}">
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