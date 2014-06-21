<%--
  用户明细页
  User: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户详细信息</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/detail.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>

    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/validator.js"></script>


    <script type="text/javascript">
        $(function () {
            jsUtil.bindSave();
            jsUtil.organizationTree({
                data:${organizationTree},
                selectedId: ${user.organization.id},
                click: function (event, treeId, treeNode) {
                    $(".organization").val(treeNode.name);
                    $("[name=organization\\.id]").val(treeNode.id);
                }
            });
        });

    </script>

</head>
<body>
<div>
    <div class="cb"></div>
    <div class="ml35 mr35">
        <div class="fl" style="width:20%">
            <div class="mt20 block cb cb mr20">
                <b class="ba"></b>
                <b class="bb"></b>
                <b class="bc"></b>
                <b class="bd"></b>

                <div class="fl table_blueheadc fl w">
                    <h1 class="f14 c_white lh40 ml10 fl">组织结构</h1>
                    <img width="108" height="50" class="fl" src="${ctx}/static/images/snowflake.png">
                    <a class="c_white f14 fr mt10 fb mr10" href="javascript:;">&lt;&lt;</a>
                </div>
            </div>
            <div class="cb mb20 mr20 bor_636363" style=" height:495px;">
                <ul id="organizationTree" class="ztree"></ul>
            </div>
        </div>

        <div class="fr" style="width:80%">
            <div class=" mt20 block cb cb">
                <b class="b1"></b>
                <b class="b2"></b>
                <b class="b3"></b>
                <b class="b4"></b>

                <div class="ie_head">
                    <h1 class="f14 fbnone mt10 ml10 fl">用户详情信息</h1>
                    <c:if test="${VM_ALL!=null}">
                        <div class="message">${VM_ALL}</div>
                    </c:if>
                </div>
            </div>
            <form name="user" action="${ctx}${VR_FUNCTION.url}" method="post">
                <div class="bg_c_blue cb">
                    <input type="hidden" name="id" value="${user.id}"/>

                    <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
                    <table class="cb id_table3 w95b bg_c_white margin0 mt10">
                        <tr style="display: none">
                            <td align="right" width="15%">编号：</td>
                            <td align="left"><input type="text" name="code" value="${user.code}" class="text_input3"/></td>
                            <td align="right" width="15%"></td>
                            <td align="left"></td>
                        </tr>
                        <tr>
                            <td align="right" width="15%">用户名：</td>
                            <td align="left"><input type="text" class="{required:true} text_input3" name="name" value="${user.name}"/></td>
                            <td align="right" width="15%">密码：</td>
                            <td align="left"><input type="password" class="{required:true} text_input3" name="password" value="${user.password}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="15%">管理员：</td>
                            <td align="left">
                                <label><input type="radio" name="isManager" value="1" ${user.isManager?"checked":""} ${VS_USER.isManager?"":"disabled"}>是</label>
                                <label><input type="radio" name="isManager" value="0" ${!user.isManager?"checked":""} >否</label>
                            </td>
                            <td align="right" width="15%">激活：</td>
                            <td align="left">
                                <label><input type="radio" name="isActive" value="1" ${user.isActive?"checked":""}>是</label>
                                <label><input type="radio" name="isActive" value="0" ${!user.isActive?"checked":""}>否</label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="15%">真实姓名：</td>
                            <td align="left"><input type="text" name="realName" value="${user.realName}" class="text_input3"/></td>
                            <td align="right" width="15%">性别：</td>
                            <td align="left">
                                <c:forEach items="${sexs}" var="item">
                                    <label><input type="radio" name="sex" value="${item.id}" ${item.id==user.sex.id?"checked":""}>${item.key}</label>
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="15%">手机：</td>
                            <td align="left"><input type="text" name="phone" value="${user.phone}" class="text_input3"/></td>
                            <td align="right" width="15%">电话：</td>
                            <td align="left"><input type="text" name="mobile" value="${user.mobile}" class="text_input3"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="15%">邮箱：</td>
                            <td align="left"><input type="text" name="email" value="${user.email}" class="text_input3"/></td>
                            <td align="right" width="15%">QQ号：</td>
                            <td align="left"><input type="text" name="qq" value="${user.qq}" class="text_input3"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="15%">职位：</td>
                            <td align="left"><input type="text" name="jobName" value="${user.jobName}" class="text_input3"/></td>
                            <td align="right" width="15%">在岗情况：</td>
                            <td align="left">
                                <div class="pr">
                                    <select name="jobSituation.id" class="{required:true} select1 pr">
                                        <option value="">--无--</option>
                                        <c:forEach items="${jobsituations}" var="item">
                                            <option value="${item.id}" ${item.value==user.jobSituation.value?"selected":""}>${item.key}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="15%">组织：</td>
                            <td align="left">
                                <input type="text" class="organization {required:true,messages:{required:'（*必填）'}} text_input3" value="${user.organization.name}" forselector="[name=organization\.id]" readonly>
                                <input type="hidden" name="organization.id" value="${user.organization.id}">
                            </td>
                            <%--//TODO 序号暂不处理--%>
                            <td align="right" width="15%"><%--序号：--%></td>
                            <td align="left"><input type="hidden" name="order" value="${user.order}"/></td>
                        </tr>
                    </table>
                    <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
                    <table class="cb id_table4 w95b bg_c_white margin0 mt10">
                        <tr>
                            <td align="right" width="15%" valign="top">备注：</td>
                            <td align="left" width="85%"><textarea class="remarks_input1" name="remark">${user.remark}</textarea></td>
                        </tr>
                        <tr style="display: none">
                            <td class="tar bghui pr10">创建人：</td>
                            <td align="left">${user.creator.realName}<input type="hidden" name="creator.id" value="${creator.id}"></td>
                            <td class="tar bghui pr10">创建时间：</td>
                            <fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss" var="createTime"/>
                            <td align="left">${createTime}<input type="hidden" name="createTime" value="${createTime}"></td>
                        </tr>
                        <tr style="display: none">
                            <td class="tar bghui pr10">修改人：</td>
                            <td align="left">${user.modifier.realName}<input type="hidden" name="modifier.id" value="${user.modifier.id}"></td>
                            <td class="tar bghui pr10">修改时间：</td>
                            <fmt:formatDate value="${user.modifiedTime}" pattern="yyyy-MM-dd HH:mm" var="modifyTime"/>
                            <td align="left">${modifyTime}<input type="hidden" name="modifiedTime" value="${modifyTime}"></td>
                        </tr>
                    </table>
                    <div class=" h40"></div>
                </div>
                <div class="cb block h40 margin0 mt10" style="width:350px;">
                    <ul class="id_table1 cb">
                        <c:if test="${VS_HAS_FUNCTIONS.userModify}">
                            <li><a href="javascript:void(0)" redirecturi="/system/user/toViewPage.do?id=%s" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;存</b></a></li>
                            <c:if test="${VS_HAS_FUNCTIONS.userAdd}">
                                <li><a href="javascript:void(0)" redirecturi="/system/user/toAddPage.do" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保存并新增</b></a></li>
                            </c:if>
                        </c:if>
                        <li><a href="${ctx}/system/user/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取消</b></a></li>
                    </ul>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>