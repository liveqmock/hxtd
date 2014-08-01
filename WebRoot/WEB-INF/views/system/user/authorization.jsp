<%--
  用户明细页
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
    <title>用户授权</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <link href="${ctx}/static/css/recommend/empower.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <style type="text/css">
    	.id_ul4{ height: auto !important;}
    	.id_ul4 li{ float:left; width:16%; margin-top:5px; margin-bottom:5px;}
		.id_ul4 li a{ height:25px;line-height:25px; color:#222; text-align:center; padding-left:10px; padding-right:10px;}
		.id_ul4{ width:86.2%;}
    </style>
    <script type="text/javascript">
        $(function () {
            jsUtil.bindSave();
            //选中/反选
            var $menu2 = $("a.menu2");
            $C.toggleClass($menu2, "allright2", "allnoright2");
            $C.toggleBoolean($menu2, "checked");
            $C.bindCheckAll($menu2, "div.menu2", ".function:checkbox");

            var $menu1 = $("a.menu1");
            $C.toggleClass($menu1, "allright", "allnoright");
            $C.toggleBoolean($menu1, "checked");
            $C.bindCheckAll($menu1, "div.menu1", ".function:checkbox");
            $C.bindCheckAll($menu1, "div.menus1", "a.menu2", "click");
            $C.tab();

            $("#data-bind").data("data-bind",[]);

        });
        function show(roleId){
          	RcmsAjax.ajaxNoMsg("${ctx}/system/user/toAuthorizationPage.do?TYPE=show&roleId="+roleId, function (data) {
          	var ids=data.message.split('|');
          	var funIds=ids[0].split(',');
          	var comIds=ids[1].split(',');
			$('input[name="functionId"]').each(function(){
				for(i=0;i<funIds.length;i++){
   					if(funIds[i]==	$(this).val()){
   						if(roleId==$(this).attr("data-id")){
   							$(this).attr("checked",false);
   							$(this).removeAttr("disabled");
   							$(this).attr("data-id","");
   						}else{
   							$(this).attr("checked",true);
   							$(this).removeAttr("disabled");
   							$(this).attr("data-id",roleId);
   						}
   					}
   					}
  					});
			$('input[name="componentId"]').each(function(){
				for(i=0;i<comIds.length;i++){
   					if(funIds[i]==	$(this).val()){
   					if(roleId==$(this).attr("data-id")){
   							$(this).attr("checked",false);
   							$(this).removeAttr("disabled");
   						}else{
   							$(this).attr("checked",true);
   							$(this).attr("data-id",roleId);
   							$(this).removeAttr("disabled");
   						}
   					}
   					}
  					});
			});
            }
    </script>
</head>
<body>
<div id="data-bind">data-bind</div>
<form name="user" action="${ctx}${VR_FUNCTION.url}" method="post">
    <input type="hidden" name="id" value="${param.id}">
         <!-- 角色-->
         <div class="right_fbg bg_c_f3f3f3 ml35 mr35 brall5">
         <h1 class="f14 ml20 mt20 pt10">角色列表</h1>
            <div class="menus1">
                <div class="clearfix w menu1">
	                	<ul class="mb10 cb" style="overflow:hidden;">
		                    <c:forEach items="${allRoles}" var="item" varStatus="status">
		                        <li class="fl" style="width:16%;">
		                            <label class="box size81 ${fn:contains(organizationInheritRoles,item)?" inherit-role":""}">
		                                <input onclick="show(${item.id});" type="checkbox" name="roleId" value="${item.id}" class="function" ${fn:contains(authorizationRoles,item)?"checked":""}/>
		                                ${item.name}
		                            </label>
		                        </li>
		                    </c:forEach>
	                	</ul>
                </div>
            </div>
            <div class="pt10"></div>
		</div>
    <div class="margin0 ml35 mr35">
    <div class="w">
    <!-- 功能 -->
       <div class=" mt10 block cb cb">
       <b class="b1"></b>
       <b class="b2"></b>
       <b class="b3"></b>
       <b class="b4"></b>
       <div class="ie_head" ><h1 class="f14 fbnone mt10 ml10 fl">功能</h1></div>
       </div>
       <div class="bor_999notop">
                <c:forEach items="${allMenus}" var="item" varStatus="status">
                <c:choose>
                <c:when test="${item.level==1}">
                    <div class="menus1">
                    <div class="clearfix bg_c_blue w menu1">
                        <a href="javascript:void(0)" class="fl mt5 mb5 ml5 allnoright block menu menu1"></a>
                        <i class="vm block fl mt15 ml10">${item.name}</i>
                        <ul class="id_ul4 fr mt10 ">
                            <c:forEach items="${allFunctions[item.id]}" var="item">
                                <li>
                                    <label class="box size51 ${fn:contains(allAuthorizationFunctions,item)?" inherit-function":""}">
                                        <input type="checkbox" data-id="" name="functionId" value="${item.id}" class="function" ${fn:contains(authorizationFunctions,item)?"disabled='disabled' checked=checked":""}>
                                        ${item.name}
                                    </label>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <c:if test="${status.last||allMenus[status.index+1].level==1}"></div></c:if>
                </c:when>
                <c:when test="${item.level==2}">
                <div class="clearfix w menu2">
                    <a href="javascript:void(0)" class="fl mt3 mb5 ml40 allnoright2 block menu menu2"></a>
                    <i class="vm block fl mt5 ml10 tr">${item.name}</i>
	                    <ul class="id_ul4 fr">
	                        <c:forEach items="${allFunctions[item.id]}" var="item">
	                            <li>
	                                <label class="box size51 ${fn:contains(allAuthorizationFunctions,item)?" inherit-function":""}">
	                                    <input ${fn:contains(allAuthorizationFunctions,item)?"disabled='disabled' checked='checked'":""} type="checkbox" name="functionId" value="${item.id}" class="function funs" >${item.name}
	                                </label>
	                            </li>
	                        </c:forEach>
	                    </ul>
                </div>
                <c:if test="${status.last||allMenus[status.index+1].level==1}"></div></c:if>
            </c:when>
            </c:choose>
            </c:forEach>
		</div>
        <!-- 组件 -->
			<div class=" mt10 block cb cb">
			<b class="b1"></b>
			<b class="b2"></b>
			<b class="b3"></b>
			<b class="b4"></b>
			<div class="ie_head" >
			<h1 class="f14 fbnone mt10 ml10 fl">组件</h1>
			</div>
			</div>
			<div class="bor_999notop">
        	<div class="menus1">
                <div class="clearfix w  menu1">
	                <a href="javascript:void(0)" class="fl mt5 mb5 ml5 allright block menu menu1"></a>
            			<ul class="id_ul4 fl">
            			<c:forEach items="${allComponents}" var="item" varStatus="status">
			                <li>
			                    <label class="box size51 ${fn:contains(allAuthorizationComponents,item)?" inherit-component":""}">
			                        <input ${fn:contains(allAuthorizationFunctions,item)?"disabled='disabled' checked='checked'":""} data-id="" type="checkbox" name="componentId" value="${item.id}" class="function" >${item.name}
			                    </label>
			                </li>
            			</c:forEach>
            			</ul>
               </div>
            </div>
			</div>
        <div class="cb block h40 margin0 mt10" style="width:350px;">
            <ul class="id_table1 cb">
                <li><a href="javascript:void(0)" class="block c_white lh25 submit mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp;&nbsp;存</b></a></li>
                <li>
                <c:choose>
                <c:when test="${id==null}">
                <a href="${ctx}/system/toViewPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b></a>
                </c:when>
                <c:otherwise>
                <a href="${ctx}/system/organization/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b></a>
                </c:otherwise>
                </c:choose>
                </li>
            </ul>
        </div>
    </div>
</form>
<div class="cb"></div>
</body>
</html>