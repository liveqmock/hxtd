<%--
  菜单编辑页
  User: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>菜单详情信息</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/detail.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/api/api.string.js"></script>
    <link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>


    <script type="text/javascript">
        $(function () {
            jsUtil.bindSave();
            jsUtil.bindCheckAll(".functioncheckall", ".functioncheckitem");
            jsUtil.renderRequiredFromInput();

            function Menu() {}

            Menu.prototype = {
                init: function () {
                    this.setElements();
                    this.initUi();
                    return this;
                },
                setElements: function () {
                    this.functions = $(".functioncheckall");
                    this.trigger = $("[name=trigger\\.id]");
                    return this;
                },
                initUi: function () {
                    this.setTrigger();
                    return this;
                },
                setTrigger: function () {
                    var _this = this;
                    this.functions.click(function () {
                        var $this = $(this);
                        if ($this.attr("checked")) {
                            _this.trigger.append("<option value='{}'>{}</option>".format($this.val(), $this.parent().text()));
                        } else {
                            _this.trigger.children("[value={}]".format($this.val())).remove();
                        }
                    });
                    return this;
                }
            }

            new Menu().init();
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
                <h1 class="f14 fbnone mt10 ml10 fl">菜单详情信息</h1>
                <c:if test="${VM_ALL!=null}">
                    <div class="message">${VM_ALL}</div>
                </c:if>
            </div>
        </div>

        <div class="ml35 mr35 bg_c_blue cb">
            <input type="hidden" name="id" value="${menu.id}"/>

            <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
            <table class="cb id_table3 w95b bg_c_white margin0 mt10">
                <tr style="display: none">
                    <td align="right" width="15%">编号：</td>
                    <td align="left"><input type="text" name="code" value="${menu.code}" class="text_input3"/></td>
                    <td align="right" width="15%">序号：</td>
                    <td align="left"><input type="text" name="order" value="${menu.order}" class="text_input3"/></td>
                </tr>
                <tr>
                    <td align="right" width="15%">名称：</td>
                    <td align="left"><input type="text" name="name" class="{required:true} text_input3" value="${menu.name}"/></td>
                    <td align="right" width="15%" class="required">调用入口：</td>
                    <td align="left"><input type="text" name="url" class="{required:true} text_input3" value="${menu.url}"/></td>
                </tr>
                <tr>
                    <td align="right" width="15%">显示位置：</td>
                    <td align="left">
                        <div class="pr">
                            <select name="showLocation.id" class="{required:true} select1 pr">
                                <option value="">--无--</option>
                                <c:forEach items="${showLocations}" var="item">
                                    <option value="${item.id}" ${item.id==menu.showLocation.id?"selected":""}>${item.key}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                    <td align="right" width="15%">打开方式：</td>
                    <td align="left">
                        <div class="pr">
                            <select name="openType.id" class="{required:true} select1 pr">
                                <option value="">--无--</option>
                                <c:forEach items="${openTypes}" var="item">
                                    <option value="${item.id}" ${item.id==menu.openType.id?"selected":""}>${item.key}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                </tr>
                <%--//TODO 关于复选框的必填验证--%>
                <tr>
                    <td align="right" width="15%">包含功能：</td>
                    <td align="left">
                        <c:if test="${menuAdd}">
                            <div class="{required:true}">
                                    <%--<input class="{required:'[name^=functions]'}" >--%>
                                <c:forEach items="${functions}" var="item" varStatus="status">
                                    <label class="functioncheck">
                                        <c:set var="checked" value="${fn:contains(menu.functions,item)?'checked':''}"/>
                                        <input type="checkbox" name="functions[${status.index}].id" value="${item.id}" class="checkitem functioncheckall" ${checked}>${item.name}
                                    </label>
                                </c:forEach>
                            </div>
                        </c:if>
                        <c:if test="${menuModify}">
                            <c:forEach items="${menu.functions}" var="item" varStatus="status">${item.name}&nbsp;&nbsp;</c:forEach>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="15%">触发功能：</td>
                    <td align="left">
                        <div class="pr">
                            <select name="trigger.id" class="{required:true} select1 pr">
                                <option value="">--无--</option>
                                <c:forEach items="${menu.functions}" var="item" varStatus="status">
                                    <option value="${item.id}" ${item.id==menu.trigger.id?"selected":""}>${item.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                    <td align="right" width="15%">激活：</td>
                    <td align="left">
                        <label><input type="radio" name="isActive" value="1" ${menu.isActive?"checked":""}>是</label>
                        <label><input type="radio" name="isActive" value="0" ${!menu.isActive?"checked":""}>否</label>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="15%">上级菜单：</td>
                    <td align="left">
                        <input type="text" value="${menu.parent.name}" class="text_input3" readonly>
                        <c:if test="${menu.parent!=null}">
                            <input type="hidden" name="parent.id" value="${menu.parent.id}">
                        </c:if>
                        <input type="hidden" name="level" value="${menu.level}"/>
                        <input type="hidden" name="isLeaf" value="${menu.isLeaf}"/>
                    </td>
                    <td align="right" width="15%"></td>
                    <td align="left"></td>
                </tr>
            </table>
            <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
            <table class="cb id_table4 w95b bg_c_white margin0 mt10">
                <tr>
                    <td align="right" width="15%" valign="top">备注：</td>
                    <td align="left" width="85%">
                        <textarea name="remark" class="remarks_input1">${menu.remark}</textarea>
                    </td>
                </tr>
            </table>
            <div class=" h40"></div>
        </div>
        <div class="cb block h40 margin0 mt10" style="width:350px;">
            <ul class="id_table1 cb">
                <c:if test="${VS_HAS_FUNCTIONS.menuModify}">
                    <li><a href="javascript:void(0)" redirecturi="/system/menu/toViewPage.do?id=%s" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;存</b></a></li>
                    <c:if test="${VS_HAS_FUNCTIONS.menuAdd}">
                        <li><a href="javascript:void(0)" redirecturi="/system/menu/toAddPage.do" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保存并新增</b></a></li>
                    </c:if>
                </c:if>
                <li><a href="${ctx}/system/menu/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取消</b></a></li>
            </ul>
        </div>
    </form>
</div>
</body>
</html>