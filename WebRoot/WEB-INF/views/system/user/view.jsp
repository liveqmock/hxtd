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
    <title>用户详情</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/detail.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>

    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>

    <script type="text/javascript">
        $(function () {
            jsUtil.organizationTree({
                data:${organizationTree},
                selectedId: ${user.organization.id}
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
                    <%--<a class="c_white f14 fr mt10 fb mr10" href="javascript:;">&lt;&lt;</a>--%>
                </div>
            </div>
            <div class="cb mb20 mr20 bor_636363" style=" height:495px;">
                <ul id="organizationTree" class="ztree"></ul>
            </div>
        </div>

        <div class="fr " style="width:80%">
            <div class=" mt20 block cb cb">
                <b class="b1"></b>
                <b class="b2"></b>
                <b class="b3"></b>
                <b class="b4"></b>

                <div class="ie_head">
                    <h1 class="f14 fbnone mt10 ml10 fl">用户详情信息</h1>
                    <ul class="fr id_table1 mt10 ml10">
                        <c:if test="${VS_HAS_FUNCTIONS.userModify}">
                            <li><a href="${ctx }/system/user/toModifyPage.do?id=${user.id}" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">编&nbsp;&nbsp;辑</b></a></li>
                        </c:if>
                        <li><a href="javascript:history.back(-1);" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b></a></li>
                    </ul>
                </div>
            <div class="bg_c_blue cb">
                <input type="hidden" name="id" value="${user.id}"/>

                <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
                <table class="cb id_table3 w95b bg_c_white margin0 mt10">
                    
                    <tr>
                        <td align="right" width="15%">用户名：</td>
                        <td align="left">${user.name}</td>
                        <td align="right" width="15%">密码：</td>
                        <td align="left">******</td>
                    </tr>
                    <tr>
                        <td align="right" width="15%">管理员：</td>
                        <td align="left">${user.isManager?"是":"否"}</td>
                        <td align="right" width="15%">启用：</td>
                        <td align="left">${user.isActive?"是":"否"}</td>
                    </tr>
                    <tr>
                        <td align="right" width="15%">真实姓名：</td>
                        <td align="left">${user.realName}</td>
                        <td align="right" width="15%">性别：</td>
                        <td align="left">${user.sex.key}</td>
                    </tr>
                    <tr>
                        <td align="right" width="15%">手机：</td>
                        <td align="left">${user.phone}</td>
                        <td align="right" width="15%">电话：</td>
                        <td align="left">${user.mobile}</td>
                    </tr>
                    <tr>
                        <td align="right" width="15%">邮箱：</td>
                        <td align="left">${user.email}</td>
                        <td align="right" width="15%">QQ号：</td>
                        <td align="left">${user.qq}</td>
                    </tr>
                    <tr>
                        <td align="right" width="15%">职位：</td>
                        <td align="left">${user.jobName}</td>
                        <td align="right" width="15%">在岗情况：</td>
                        <td align="left">${user.jobSituation.key}</td>
                    </tr>
                    <tr>
                        <td align="right" width="15%">组织：</td>
                        <td align="left">${user.organization.name}</td>
                        
                    </tr>
                </table>
                <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
                <table class="cb id_table6 w95b bg_c_white margin0 mt10">
                    <tr>
                        <td align="right" width="15%" valign="top">备注：</td>
                        <td align="left" width="85%" valign="top">
                            <div class="w85b">${user.remark}</div>
                        </td>
                    </tr>
                    <tr style="display: none">
                        <td class="tar bghui pr10">创建人：</td>
                        <td align="left">${user.creator.realName}<input type="hidden" name="creator.id" value="${creator.id}"></td>
                        <td class="tar bghui pr10">创建时间：</td>
                        <fmt:formatDate value="${user.createdTime}" pattern="yyyy-MM-dd HH:mm:ss" var="createdTime"/>
                        <td align="left">${createdTime}<input type="hidden" name="createdTime" value="${createdTime}"></td>
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
        </div>
    </div>
</div>

</body>
</html>