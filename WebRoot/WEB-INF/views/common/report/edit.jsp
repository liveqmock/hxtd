<%--
  报表明细页
  report: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>报表编辑</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/list1.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-json.2.4.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>

    <script>
        $(function () {
            jsUtil.bindSave().renderRequired();

            var form = $("form");
            var module = form.find("[name=module\\.id]");
            module.change(function () {
                RcmsAjax.ajaxNoMsg("${ctx}/common/module/findModuleFields.docomp", function (data) {
                    var fields = data.result.result;
                    xFieldName.setTemplateElement("template-fields").processTemplate(fields);
                    yFieldName.setTemplateElement("template-fields").processTemplate(fields);
                    zFieldName.setTemplateElement("template-fields").processTemplate(fields);
                }, null, $.param({id: this.value}));
            });

            var chartType = form.find("[name=chart\\.id]");
            var zAxis = form.find(".zAxis");
            chartType.change(function () {
                var option = $(this).children(":selected");
                var value = option.attr("data-value");
                if (value == "${CHART_PIE}") {
                    zAxis.hide();
                } else {
                    zAxis.show();
                }
            });

            var groupTypeChange = function (groupType) {
                return function () {
                    var $this = $(this);
                    if (!$this.val()) {
                        groupType.empty();
                        return this;
                    }
                    var option = $this.find("option:selected");
                    var params = {moduleId: option.parent().attr("data-id"), fieldName: option.val()};
                    RcmsAjax.ajaxNoMsg("${ctx}/common/report/findGroupType.docomp", function (data) {
                        var items = data.result.result;
                        groupType.setTemplateElement("template-group").processTemplate(items);
                    }, null, $.param(params));
                };
            };

            var xGroupType = form.find("[name=xGroupType\\.id]");
            var xFieldName = form.find("[name=xFieldName]");
            xFieldName.change(groupTypeChange(xGroupType));

            var yFieldName = form.find("[name=yFieldName]");
            var yAggregateType = form.find("[name=yAggregateType\\.id]");

            var zGroupType = form.find("[name=zGroupType\\.id]");
            var zFieldName = form.find("[name=zFieldName]");
            zFieldName.change(groupTypeChange(zGroupType));

        });
    </script>
</head>

<body>
<div>
    <form action="${ctx}${VR_FUNCTION.url}" method="post">
        <div class="ml35 mr35 mt20 block cb cb">
            <b class="b1"></b>
            <b class="b2"></b>
            <b class="b3"></b>
            <b class="b4"></b>

            <div class="ie_head">
                <h1 class="f14 fbnone mt10 ml10 fl">报表详细信息</h1>
                <c:if test="${VM_BUSINESS!=null}">
                    <div class="message">${VM_BUSINESS}</div>
                </c:if>
            </div>
        </div>

        <div class="ml35 mr35 bg_c_blue cb">
            <textarea id="template-fields" class="template template-fields">
                <option value="">--无--</option>
                {#foreach $T as module}
                <optgroup label="{$T.module.desc}" data-id="{$T.module.id}">
                    {#foreach $T.module.moduleFields as field}
                    <option value="{$T.field.name}" label="{$T.field.desc}">{$T.field.desc}</option>
                    {#/for}
                </optgroup>
                {#/for}
            </textarea>

            <textarea id="template-group" class="template template-group">
                <option value="">--无--</option>
                {#foreach $T as item}
                <option value="{$T.item.id}" label="{$T.item.key}">{$T.item.key}</option>
                {#/for}
            </textarea>

            <input type="hidden" name="id" value="${report.id}"/>

            <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
            <table class="cb id_table3 w95b bg_c_white margin0 mt10">
                <tr>
                    <td align="right" width="15%">编号：</td>
                    <td align="left"><input type="text" name="code" value="${report.code}" class="{required:true,maxlength:32,unique:['Report','${fn:replace(report.code,"'","\\'")}']} text_input3"/></td>
                    <td align="right" width="15%">名称：</td>
                    <td align="left"><input type="text" name="name" value="${report.name}" class="{required:true,maxlength:64,unique:['Report','${fn:replace(report.name,"'","\\'")}']} text_input3"/></td>
                </tr>
                <tr>
                    <td align="right" width="15%">所属模块：</td>
                    <td align="left">
                        <div class="pr">
                            <select name="module.id" class="{required:true} select1 pr">
                                <option value="">--无--</option>
                                <c:forEach items="${modules}" var="item">
                                    <option value="${item.id}" ${item.id==report.module.id?"selected":""}>${item.desc}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                    <td align="right" width="15%">图表类型：</td>
                    <td align="left">
                        <div class="pr">
                            <select name="chart.id" class="{required:true} select1 pr">
                                <option value="">--无--</option>
                                <c:forEach items="${charts}" var="item">
                                    <option value="${item.id}" ${item.id==report.chart.id?"selected":""} data-value="${item.value}">${item.key}</option>
                                </c:forEach>
                            </select>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="15%">X轴字段名：</td>
                    <td align="left">
                        <div class="pr">
                            <select name="xFieldName" class="{required:true} select1 pr">
                                <option value="">--无--</option>
                                <c:forEach items="${fieldModules}" var="fieldModule">
                                    <optgroup label="${fieldModule.desc}" data-id="${fieldModule.id}">
                                        <c:forEach items="${fieldModule.moduleFields}" var="field">
                                            <option value="${field.name}" label="${field.desc}" ${field.name==report.xFieldName?"selected":""}>${field.desc}</option>
                                        </c:forEach>
                                    </optgroup>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                    <td align="right" width="15%">X轴分组类型：</td>
                    <td align="left">
                        <div class="pr">
                            <select name="xGroupType.id" class="{required:true} select1 pr">
                                <option value="">--无--</option>
                                <c:forEach items="${xGroupTypes}" var="item">
                                    <option value="${item.id}" label="${item.key}" ${item.id==report.xGroupType.id?"selected":""}>${item.key}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="15%">Y轴字段名：</td>
                    <td align="left">
                        <div class="pr">
                            <select name="yFieldName" class="{required:true} select1 pr">
                                <option value="">--无--</option>
                                <c:forEach items="${fieldModules}" var="fieldModule">
                                    <optgroup label="${fieldModule.desc}" data-id="${fieldModule.id}">
                                        <c:forEach items="${fieldModule.moduleFields}" var="field">
                                            <option value="${field.name}" label="${field.desc}" data-name="${field.name}" ${field.name==report.yFieldName?"selected":""}>${field.desc}</option>
                                        </c:forEach>
                                    </optgroup>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                    <td align="right" width="15%">Y轴聚合类型：</td>
                    <td align="left">
                        <div class="pr">
                            <select name="yAggregateType.id" class="{required:true} select1 pr">
                                <option value="">--无--</option>
                                <c:forEach items="${aggregates}" var="item">
                                    <option value="${item.id}" ${item.id==report.yAggregateType.id?"selected":""}>${item.key}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr class="zAxis">
                    <td align="right" width="15%">Z轴字段名：</td>
                    <td align="left">
                        <div class="pr">
                            <select id="zFieldName" name="zFieldName" class="select1 pr">
                                <option value="">--无--</option>
                                <c:forEach items="${fieldModules}" var="fieldModule">
                                    <optgroup label="${fieldModule.desc}" data-id="${fieldModule.id}">
                                        <c:forEach items="${fieldModule.moduleFields}" var="field">
                                            <c:set var="fieldName" value="${field.name}"/>
                                            <option value="${fieldName}" label="${field.desc}" data-name="${field.name}" ${fieldName==report.zFieldName?"selected":""}>${field.desc}</option>
                                        </c:forEach>
                                    </optgroup>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                    <td align="right" width="15%">Z轴分组类型：</td>
                    <td align="left">
                        <div class="pr">
                            <select name="zGroupType.id" class="select1 pr">
                                <option value="">--无--</option>
                                <c:forEach items="${zGroupTypes}" var="item">
                                    <option value="${item.id}" label="${item.key}" ${item.id==report.zGroupType.id?"selected":""}>${item.key}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                </tr>
            </table>
            <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
            <table class="cb id_table4 w95b bg_c_white margin0 mt10">
                <tr>
                    <td align="right" width="15%" valign="top">备注：</td>
                    <td align="left" width="85%" valign="top">
                        <textarea name="remark" class="{maxlength:255} remarks_input1">${report.remark }</textarea>
                    </td>
                </tr>
                <tr style="display: none">
                    <td class="tar bghui pr10">创建人：</td>
                    <td class="bghb pl10">${report.creator.realName}</td>
                    <td class="tar bghui pr10">创建时间：</td>
                    <fmt:formatDate value="${report.createdTime}" pattern="yyyy-MM-dd HH:mm:ss" var="createdTime"/>
                    <td class="bghb pl10">${createdTime}</td>
                </tr>
                <tr style="display: none">
                    <td class="tar bghui pr10">修改人：</td>
                    <td class="bghb pl10">${report.modifier.realName}</td>
                    <td class="tar bghui pr10">修改时间：</td>
                    <fmt:formatDate value="${report.modifiedTime}" pattern="yyyy-MM-dd HH:mm" var="modifyTime"/>
                    <td class="bghb pl10">${modifyTime}</td>
                </tr>
            </table>
            <div class=" h40"></div>
        </div>
        <div class="cb block h40 margin0 mt10" style="width:350px;">
            <ul class="id_table1 cb">
                <c:if test="${VS_HAS_FUNCTIONS.reportModify}">
                    <li><a href="javascript:void(0)" redirecturi="/common/report/toViewPage.do?id=%s" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b></a></li>
                    <c:if test="${VS_HAS_FUNCTIONS.reportAdd}">
                        <li><a href="javascript:void(0)" redirecturi="/common/report/toAddPage.do" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保存并新增</b></a></li>
                    </c:if>
                </c:if>
                <li><a href="${ctx}/common/report/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取消</b></a></li>
            </ul>
        </div>
    </form>
</div>
</body>
</html>