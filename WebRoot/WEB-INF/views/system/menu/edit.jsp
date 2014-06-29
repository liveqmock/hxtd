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
    <title>菜单编辑</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/detail.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>


    <script type="text/javascript">
        $(function () {

            jsUtil.renderRequired();
            jsUtil.bindSave();

            var ztree = jsUtil.menuTree({
                data:${menuTree==null?"[]":menuTree},
                selectedId: "${menuAdd?menu.parent.id:menu.id}",
                ztreeOptions: {
                    callback: {
                        beforeClick: function (treeId, treeNode) {
                            var isClickSelf = $.Ztree.isClickSelf(ztree, treeNode);
                            treeNode.isClickSelf = isClickSelf;

                            if (Boolean("${menuModify}")) {
                                return !isClickSelf;
                            } else {
                                if (treeNode.level != 0) {
                                    jsUtil.alert("请选择一级菜单！仅限新增一级菜单和二级菜单，不允许在二级菜单下新增子菜单");
                                    return false;
                                }
                            }
                        },
                        onClick: function (event, treeId, treeNode) {
                            if (Boolean("${menuModify}")) {
                                window.open("${ctx}/system/menu/toModifyPage.do?id=" + treeNode.id, "_self");
                                return this;
                            }

                            $.Ztree.setValue(ztree, treeNode, "[name=parent\\.id]", "[name=parent\\.name]");
                        }
                    }
                }
            });

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
        })
        ;
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
                    <h1 class="f14 c_white lh40 ml10 fl">${menuAdd?"上级菜单":"菜单结构"}</h1>
                    <img width="108" height="50" class="fl" src="${ctx}/static/images/snowflake.png">
                    <%--<a class="c_white f14 fr mt10 fb mr10" href="javascript:;">&lt;&lt;</a>--%>
                </div>
            </div>
            <div class="cb mb20 mr20 bor_636363" style=" height:495px;">
                <ul id="menuTree" class="ztree"></ul>
            </div>
        </div>

        <div class="fr" style="width:80%">
            <form action="${ctx}${VR_FUNCTION.url}" method="post">
                <div class="mt20 block cb cb">
                    <b class="b1"></b>
                    <b class="b2"></b>
                    <b class="b3"></b>
                    <b class="b4"></b>

                    <div class="ie_head">
                        <h1 class="f14 fbnone mt10 ml10 fl">菜单详情信息</h1>
                        <c:if test="${VM_BUSINESS!=null}">
                            <div class="message">${VM_BUSINESS}</div>
                        </c:if>
                    </div>
                </div>

                <div class="bg_c_blue cb">
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
                            <td align="right" width="15%">菜单名称：</td>
                            <td align="left"><input type="text" name="name" class="{required:true,unique:['Menu','${menu.name}']} text_input3" value="${menu.name}"/></td>
                            <td align="right" width="15%" class="required">调用入口：</td>
                            <td align="left"><input type="text" name="url" class="{required:true,ruleUrl:true,unique:['Menu','${menu.url}']} text_input3" value="${menu.url}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="15%" class="required">启用：</td>
                            <td align="left">
                                <label><input type="radio" name="isActive" value="1" ${menu.isActive==true?"checked":""}>是</label>
                                <label><input type="radio" name="isActive" value="0" ${menu.isActive==false?"checked":""}>否</label>
                            </td>
                            <td align="right" width="15%" class="required">默认显示：</td>
                            <td align="left">
                                <label><input type="radio" name="defaultShow" value="1" ${menu.defaultShow==true?"checked":""}>是</label>
                                <label><input type="radio" name="defaultShow" value="0" ${menu.defaultShow==false?"checked":""}>否</label>
                            </td>
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
                        </tr>
                        <%--//TODO 关于复选框的必填验证--%>
                        <tr>
                            <td align="right" width="15%" class="required">包含功能：</td>
                            <td align="left" colspan="3">
                                <c:if test="${menuAdd}">
                                    <div>
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
                            <td align="right" width="15%">执行功能：</td>
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
                            <td align="right" width="15%">上级菜单：</td>
                            <td align="left">
                                <c:if test="${menuAdd||(menuModify&&menu.parent.id!=null)}">
                                    <input type="text" name="parent.name" value="${menu.parent.name}" class="text_input3" readonly>
                                    <input type="hidden" name="parent.id" value="${menu.parent.id}">
                                </c:if>
                                <input type="hidden" name="level" value="${menu.level}"/>
                                <input type="hidden" name="isLeaf" value="${menu.isLeaf}"/>
                            </td>
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
    </div>
</body>
</html>