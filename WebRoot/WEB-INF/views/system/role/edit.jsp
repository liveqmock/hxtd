<%--
  角色明细页
  Role: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>角色编辑</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/detail.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/validator.js"></script>

    <script>$(function () {jsUtil.bindSave().renderRequired();});</script>
</head>

<body>
<div>
    <form action="${ctx}${VR_FUNCTION.url}" method="POST">
        <div class="ml35 mr35 mt20 block cb cb">
            <b class="b1"></b>
            <b class="b2"></b>
            <b class="b3"></b>
            <b class="b4"></b>

            <div class="ie_head">
                <h1 class="f14 fbnone mt10 ml10 fl">角色详细信息</h1>
                <c:if test="${VM_BUSINESS!=null}">
                    <div class="message">${VM_BUSINESS}</div>
                </c:if>
            </div>
        </div>

        <div class="ml35 mr35 bg_c_blue cb">
            <input type="hidden" name="id" value="${role.id}"/>

            <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
            <table class="cb id_table3 w95b bg_c_white margin0 mt10">
                <tr style="display: none">
                    <td align="right" width="15%">编号：</td>
                    <td align="left"><input type="text" name="code" value="${role.code}" class="text_input3"/></td>
                    <td align="right" width="15%"></td>
                    <td align="left"></td>
                </tr>
                <tr>
                    <td align="right" width="15%">角色名：</td>
                    <td align="left"><input type="text" class="{required:true,maxlength:16,unique:['Role','${role.name}']} text_input3" name="name" value="${role.name}"/></td>
                    <td align="right" width="15%">类型：</td>
                    <td align="left">
                        <div class="pr">
                            <select name="type.id" class="{required:true} select1 pr">
                                <option value="1">--无--</option>
                                <c:forEach items="${types}" var="item">
                                    <option value="${item.id}" ${item.value==role.type.value?"selected":""}>${item.key}</option>
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
                    <td align="left" width="85%">
                        <textarea name="remark" class="{maxlength:255} remarks_input1">${role.remark }</textarea>
                    </td>
                </tr>
                <tr style="display: none">
                    <td class="tar bghui pr10">创建人：</td>
                    <td class="bghb pl10">${role.creator.realName}</td>
                    <td class="tar bghui pr10">创建时间：</td>
                    <fmt:formatDate value="${role.createdTime}" pattern="yyyy-MM-dd HH:mm:ss" var="createdTime"/>
                    <td class="bghb pl10">${createdTime}</td>
                </tr>
                <tr style="display: none">
                    <td class="tar bghui pr10">修改人：</td>
                    <td class="bghb pl10">${role.modifier.realName}</td>
                    <td class="tar bghui pr10">修改时间：</td>
                    <fmt:formatDate value="${role.modifiedTime}" pattern="yyyy-MM-dd HH:mm" var="modifyTime"/>
                    <td class="bghb pl10">${modifyTime}</td>
                </tr>
            </table>
            <div class=" h40"></div>
        </div>
        <div class="cb block h40 margin0 mt10" style="width:350px;">
            <ul class="id_table1 cb">
                <c:if test="${VS_HAS_FUNCTIONS.roleModify}">
                    <li><a href="javascript:void(0)" redirecturi="/system/role/toViewPage.do?id=%s" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b></a></li>
                    <c:if test="${VS_HAS_FUNCTIONS.roleAdd}">
                        <li><a href="javascript:void(0)" redirecturi="/system/role/toAddPage.do" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保存并新增</b></a></li>
                    </c:if>
                </c:if>
                <li><a href="${ctx}/system/role/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取消</b></a></li>
            </ul>
        </div>
    </form>
</div>
</body>
</html>