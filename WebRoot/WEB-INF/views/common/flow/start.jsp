<%--
  启动流程
  User: xiayouxue
  Date:2014/7/27
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript">
$(function(){
	$(".flow").each(function(i,val){
		var $this=$(this);
		if(i==0&&$this.val()==null){
			$this.addClass("requiredSelect");
			$this.append("<option>&nbsp;</option>");
		}
	});
})
</script>
<div class="flow-dialog dialog-start hidden" title="启动流程">
    <h1 class="w90b margin0 fbnone f12 pt20 block">选择各个流程环节的审批人：</h1>
    <b class="w90b f_line2 block margin0"></b>

    <form name="${VR_FUNCTION.code}" action="${ctx}${VR_FUNCTION.url}" method="post" class="form-start">
        <%--<input type="hidden" name="executeRecord.module.id" value="${entity.module.id}"/>--%>
        <input type="hidden" name="executeRecord.recordId" value="${entity.id}"/>
        <input type="hidden" name="executeRecord.flowNode.id" value="${entity.flowNode.id}"/>
        <input type="hidden" name="executeRecord.flowNode.type" value="${entity.flowNode.type}"/>
        <input type="hidden" name="executeRecord.flowNode.flow.id" value="${entity.flowNode.flow.id}"/>
        <input type="hidden" name="executeRecord.flowNode.flow.value" value="${entity.flowNode.flow.value}"/>

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
                        <c:if test="${flowNode.type!=endNodeType}">
                            <select id="" name="${name}.approver.id" class="select3 pr flow">
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
