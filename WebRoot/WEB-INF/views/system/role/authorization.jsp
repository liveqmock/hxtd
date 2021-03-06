<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>角色授权</title>
<link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
<link href="${ctx}/static/css/recommend/empower.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<style type="text/css">
	.id_ul4{ height: auto !important;}
	.id_ul4:hover{ color:#000000 !important;}
	.id_ul4 li{ float:left; width:10%; margin-top:5px; margin-bottom:5px;}
	.id_ul4 li a{ height:25px;line-height:25px; color:#222; text-align:center; padding-left:10px; padding-right:10px;}
	.id_ul4{ width:86.2%;}
	.odd{ color:red; }
</style>
<script type="text/javascript">
$(function () {
    jsUtil.bindSave();

    //选中/反选
    var $menu2 = $("a.menu2");
    $C.prototype.constructor.toggleClass = function(jqele, selected){
    	jqele.toggle(function(){
    		if($(this).hasClass(selected)){
    			$(this).removeClass(selected);
    		} else {
    			$(this).addClass(selected);
    		}
    	}, function(){
    		if($(this).hasClass(selected)){
    			$(this).removeClass(selected);
    		} else {
    			$(this).addClass(selected);
    		}
    	});
    	return this;
    }
    $C.prototype.constructor.toggleBoolean = function (jqele, name) {
        jqele.toggle(function () {
        	if(Boolean($(this).attr(name))){
        		$(this).attr(name, false);
        	}else{
        		$(this).attr(name, true);
        	}
        }, function(){
        	if(Boolean($(this).attr(name))){
        		$(this).attr(name, false);
        	}else{
        		$(this).attr(name, true);
        	}
        });
        return this;
    }
    $C.toggleClass($menu2, "allright2");
    $C.toggleBoolean($menu2, "checked");
    $C.bindCheckAll($menu2, "div.menu2", ".function:checkbox");

    var $menu1 = $("a.menu1");
    $C.toggleClass($menu1, "allright");
    $C.toggleBoolean($menu1, "checked");
    $C.bindCheckAll($menu1, "div.menus1", "a.menu2", "click");
    $C.bindCheckAll($menu1, "div.menu1", ".function:checkbox");
    $C.tab();
    
    $(".orange").hover(function(){
    	$(this).toggleClass("c_orange");
    });
    $(".menus1 :checkbox").click(function(){
		checkModule();
	});
	$("a.menu2").click(function(){
		var $menus1 = $(this).parent(".menu2").parent(".menus1"),
			$a = $menus1.find("a.menu1");
		if($menus1.find("input:not(:checked)").size()==0){
			$a.addClass("allright").attr("checked", "checked");
		}else{
			$a.removeClass("allright").removeAttr("checked");
		}
	});
	checkModule();
});
function checkModule(){
	$(".menus1").each(function(){ //模块
		var $this = $(this), $a = $this.find("a.menu1");
		if($this.find("input:not(:checked)").size() == 0){
			$a.addClass("allright").attr("checked", "checked");
		}else{
			$a.removeClass("allright").removeAttr("checked");
		}
	});
	$(".menus1 > .menu2").each(function(){ //子模块
		var $this = $(this), $a = $this.find("a.menu2");
		if($this.find("input:not(:checked)").size() == 0){
			$a.addClass("allright2").attr("checked", "checked");
		}else{
			$a.removeClass("allright2").removeAttr("checked");
		}
	});
}
</script>
</head>
<body>

<form action="${ctx}${VR_FUNCTION.url}" method="post">
    <input type="hidden" name="id" value="${param.id}">
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
                                <li style="line-height:20px;text-align:left;">
                                    <label class="orange">
                                        <input type="checkbox" name="functionId" value="${item.id}" 
										class="${item.privilegeLevel.id==17?"":"function"}"
                                        <c:if test="${item.privilegeLevel.id==17}">disabled='disabled' checked=checked</c:if>
                                        ${fn:contains(authorizationFunctions,item)?"checked='checked'":""}>
                                        <i class="${fn:indexOf(item.name, '删除')>-1||fn:indexOf(item.name, '导入')>-1||fn:indexOf(item.name, '导出')>-1?"odd":""}">
                                        ${item.name}</i>
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
	                            <li style="line-height:20px;text-align:left;">
	                                <label class="orange">
                                    <input type="checkbox" name="functionId" value="${item.id}" 
									class="${item.privilegeLevel.id==17?"":"function"}"
                                    <c:if test="${item.privilegeLevel.id==17}">disabled='disabled' checked=checked</c:if>
                                    ${fn:contains(authorizationFunctions,item)?"checked='checked'":""}>
                                    <i class="${fn:indexOf(item.name, '删除')>-1||fn:indexOf(item.name, '导入')>-1||fn:indexOf(item.name, '导出')>-1?"odd":""}">
                                        ${item.name}</i>
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
		                <li style="line-height:20px;text-align:left;width:14%">
		                    <label class="box size81 orange">
			                        <input type="checkbox" name="componentId" value="${item.id}" 
									class="${item.privilegeLevel.id==17?"":"function"}"
			                        <c:if test="${item.privilegeLevel.id==17}">disabled='disabled' checked=checked</c:if>
			                        ${fn:contains(authorizationComponents,item)?"checked=checked":""}>
									<i class="${fn:indexOf(item.name, '删除')>-1||fn:indexOf(item.name, '导入')>-1||fn:indexOf(item.name, '导出')>-1?"odd":""}">
                                        ${item.name}</i>
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
                <a href="${ctx}/system/role/toQueryPage.do" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b></a>
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