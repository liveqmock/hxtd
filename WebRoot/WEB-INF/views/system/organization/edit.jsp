<%--
  组织编辑页
  User: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>组织详细信息</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/detail.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/validator.js"></script>

    <script type="text/javascript">$(function () {jsUtil.organizationTreeDialog().bindSave();});</script>

</head>
<body>
<div>
    <form action="${ctx}${VR_FUNCTION.url}" method="post">
        <div class="cb"></div>
        <div class="ml35 mr35 mt20 block cb cb">
            <b class="table_headl globle_img block fl"></b>

            <div class="fl table_headc fl w99b">
                <h1 class="f14 fbnone mt10 ml10 fl">组织详细信息</h1>
                <c:if test="${VM_BUSINESS!=null}">
                    <div class="message">${VM_BUSINESS}</div>
                </c:if>
            </div>
            <b class="table_headr globle_img block fl"></b>
        </div>

        <div class="ml35 mr35 bg_c_blue cb">
            <input type="hidden" name="id" value="${organization.id}"/>

            <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
            <table class="cb id_table3 w95b bg_c_white margin0 mt10">
                <tr style="display: none">
                    <td align="right" width="15%">编号：</td>
                    <td align="left"><input type="text" name="code" value="${organization.code}" class="text_input3"/></td>
                    <td align="right" width="15%">序号：</td>
                    <td align="left"><input type="text" name="order" value="${organization.order}" class="text_input3"/></td>
                </tr>
                <tr>
                    <td align="right" width="15%">名称：</td>
                    <td align="left"><input type="text" name="name" class="{required:true,maxlength:64} text_input3" value="${organization.name}"/></td>
                    <td align="right" width="15%">全名：</td>
                    <td align="left"><input type="text" name="fullName" class="{required:true,maxlength:128} text_input3" value="${organization.fullName}"/></td>
                </tr>
                <tr>
                    <td align="right" width="15%">类型：</td>
                    <td align="left">
                        <div class="pr">
                            <select name="type.id" class="{required:true} select1 pr">
                                <option value="">--无--</option>
                                <c:forEach items="${typeValues}" var="item">
                                    <option value="${item.id}" ${item.value==organization.type.value?"selected":""}>${item.key}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                    <td align="right" width="15%">上级组织：</td>
                    <td align="left">
                        <input type="text" value="${organization.parent.name}" forselector="[name=parent\.id]" class="organization text_input3 ${organizationAdd?"required":""}">
                        <input type="hidden" name="parent.id" value="${organization.parent.id}">
                        <input type="hidden" name="isLeaf" value="${organization.isLeaf}">
                        <input type="hidden" name="level" value="${organization.level}">

                        <div class="organization-tree" title="组织选择">
                            <ul id="organization-tree" class="ztree"></ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="15%">电话：</td>
                    <td align="left"><input type="text" name="phone" value="${organization.phone}" class="{isMobile:true} text_input3"/></td>
                    <td align="right" width="15%">邮箱：</td>
                    <td align="left"><input type="text" name="email" class="{email:true} text_input3" value="${organization.email}"/></td>
                </tr>
                <tr>
                    <td align="right" width="15%">地址：</td>
                    <td align="left"><input type="text" name="address" value="${organization.address}" class="{maxlength:512} text_input3"/></td>
                    <td align="right" width="15%">邮政编码：</td>
                    <td align="left"><input type="text" name="zipCode" value="${organization.zipCode}" class="{isZipCode:true} text_input3"/></td>
                </tr>
                <tr>
                    <td align="right" width="15%">网址：</td>
                    <td align="left"><input type="text" name="webSite" class="{url:true,maxlength:64} text_input3" value="${organization.webSite}"/></td>
                    <td align="right" width="15%"></td>
                    <td align="left"></td>
                </tr>
            </table>
            <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
            <table class="cb id_table4 w95b bg_c_white margin0 mt10">
                <tr>
                    <td align="right" width="15%" valign="top">备注：</td>
                    <td align="left" width="85%">
                        <textarea name="remark" class="{maxlength:512} remarks_input1">${organization.remark}</textarea>
                    </td>
                </tr>
            </table>
            <div class=" h40"></div>
        </div>
        <div class="cb block h40 margin0 mt10" style="width:350px;">
            <ul class="id_table1 cb">
                <c:if test="${VS_HAS_FUNCTIONS.organizationModify}">
                    <li><a href="javascript:void(0)" redirecturi="/system/organization/toViewPage.do?id=%s" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;存</b></a></li>
                    <c:if test="${VS_HAS_FUNCTIONS.organizationAdd}">
                        <li><a href="javascript:void(0)" redirecturi="/system/organization/toAddPage.do" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保存并新增</b></a></li>
                    </c:if>
                </c:if>
                <li><a href="${ctx}/system/organization/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取消</b></a></li>
            </ul>
        </div>
    </form>
</div>
</body>
</html>