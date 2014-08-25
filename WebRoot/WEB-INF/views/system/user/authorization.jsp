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
	.id_ul4:hover{ color:#000000 !important;}
	.menu2 .id_ul4 li{ float:left; width:10%; margin-top:5px; margin-bottom:5px; line-height:20px; }
	.menu2 .id_ul4 li a{ height:25px; line-height:25px; color:#222; text-align:center; padding-left:10px; padding-right:10px; }
	.id_ul4{ width:86.2%; }
	.odd{ color:red; }
</style>
<script type="text/javascript">
$(function () {
	$('input[name="roleId"]:checked').each(function(){ //初始化的时候请求勾选的角色，并绑定角色的功能
		var $this = $(this), roleId = $this.val();
		RcmsAjax.ajaxNoMsg("${ctx}/system/user/toAuthorizationPage.do?TYPE=show&roleId=" + roleId, 
			function (result) {
				$this.data("functionIds", result.message);
	    	    selectId(result.message, true, roleId);
			}
		);
	});
    $(".role").click(function(){ //ajax请求，返回每个被选中的角色的功能
    	var $this = $(this), flag = $this.attr("checked"), functionIds = $this.data("functionIds");
    	if(!functionIds) {
    		RcmsAjax.ajaxNoMsg("${ctx}/system/user/toAuthorizationPage.do?TYPE=show&roleId=" + $this.val(), 
    		    function(result){
    				$this.data("functionIds", result.message);
    				var ids = result.message;
   	    			selectId(ids, flag, $this.val());
    			}
    		);
    	} else {
    		selectId(functionIds, flag, $this.val());
    	}
    });
    jsUtil.bindSave();
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
	$C.bindCheckAll($menu1, "div.menu1", ".function:checkbox");
	$C.bindCheckAll($menu1, "div.menus1", "a.menu2", "click");
	
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
	var t=$("#fly").offset().top; //角色列表浮动
	var w=$(".roleUl").width();
	$(window).scroll(function () {
	   	if($(document).scrollTop() == 0){
	   		$("#fly").css('top', t);
	   		$("#fly").css('width', w);
	   		$("#fly").css('position', 'static');
	   		$("#h1Css").addClass("pt10");
	   		$("#h1Css").addClass("mt20");
	   	} else{
	   		$("#fly").css('position', 'fixed');
	   		$("#fly").css('top', 0);
	   		$("#fly").css('width', w);
	   		$("#h1Css").removeClass("mt20");
	   	}
	});
	checkModule();
});
function selectId(ids,flag,roleId){
	var allId=ids.split('|');
	var funIds=allId[0].split(',');
	var comIds=allId[1].split(',');
	if(flag){
		$('input[name="functionId"]').each(function(){
			if($.inArray($(this).val(),funIds) > 0){
				if(!$(this).attr("checked")){
				    $(this).attr("checked",true);
				}
			}
		});
		$('input[name="componentId"]').each(function(){
			if($.inArray($(this).val(),comIds) > 0){
				if(!$(this).attr("checked")){
					$(this).attr("checked",true);
				}
			}
		});
     	} else {
     		var checkeds = "";
     		var funs = "";
     		var coms = "";
     		$('input[name="roleId"]:checked').each(function(){
     			checkeds = $(this).data("functionIds") + checkeds;
		});
  		var all = checkeds.split('|');
  		for(var i = 0;i < all.length; i++){
  			if(i%2 == 0){
  				funs = funs + all[i];
  			} else{
  				coms = coms + all[i];
  			}
  		}
		$('input[name="functionId"]').each(function(){
			if($.inArray($(this).val(),funs.split(','))<0&&!$(this).attr("disabled")){
				$(this).attr("checked",false);
			}
		});
		$('input[name="componentId"]').each(function(){
			if($.inArray($(this).val(),coms.split(','))<0&&!$(this).attr("disabled")){
				$(this).attr("checked",false);
			}
		});
	}
	checkModule();
}
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
<form name="user" action="${ctx}${VR_FUNCTION.url}" method="post">
    <input type="hidden" name="id" value="${param.id}">
    <div id="fly" class="right_fbg bg_c_f3f3f3 ml35 mr35 brall5">
    	<h1 id="h1Css" class="f14 ml20 mt20 pt10">角色列表</h1>
            <div class="menus1">
                <div class="clearfix w menu1">
	                	<ul class="mb10 cb roleUl" style="overflow:hidden;">
		                    <c:forEach items="${allRoles}" var="item" varStatus="status">
		                        <li class="fl" style="width:14%;">
		                            <label class="box size51" style="vertical-align:top;">
		                                <input type="checkbox" name="roleId" value="${item.id}" class="role" 
		                                ${fn:contains(authorizationRoles,item)?"checked":""} 
		                                ${fn:contains(organizationInheritRoles,item)?" checked disabled=disabled":""}"/>
		                                ${item.name}
		                            </label>
		                        </li>
		                    </c:forEach>
	                	</ul>
                </div>
            </div>
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
                        <i class="vm block fl mt15 ml10 tr">${item.name}</i>
                        <ul class="id_ul4 fr mt10">
                            <c:forEach items="${allFunctions[item.id]}" var="item">
                                <li style="text-align:left;">
                                    <label class="box size51 orange ${fn:contains(allAuthorizationFunctions,item)?" inherit-function":""}">
                                        <input type="checkbox" name="functionId" value="${item.id}"
                                        ${fn:contains(authorizationFunctions,item)?" checked=checked":""}
                                        class="${item.privilegeLevel.id==17?"":"function"}"
                                        <c:if test="${item.privilegeLevel.id==17}">disabled='disabled' checked=checked</c:if>
                                        >
                                        <i>${item.name}</i>
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
	                                <label class="box size51 orange ${fn:contains(allAuthorizationFunctions,item)?" inherit-function":""}">
	                                    <input ${fn:contains(authorizationFunctions,item)?" checked='checked'":""}  
	                                    <c:if test="${item.privilegeLevel.id==17}">disabled='disabled' checked=checked</c:if>
	                                    type="checkbox" name="functionId" value="${item.id}" 
	                                    class="${item.privilegeLevel.id==17?"":"function"}" >
	                                    <i class="${fn:indexOf(item.name, '删除')>-1||fn:indexOf(item.name, '导入')>-1||fn:indexOf(item.name, '导出')>-1?"odd":""}">${item.name}</i>
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
	                <a href="javascript:void(0)" class="fl mt5 mb5 ml5 allnoright block menu menu1"></a>
            			<ul class="id_ul4 fl">
            			<c:forEach items="${allComponents}" var="item" varStatus="status">
			                <li style="line-height:20px;text-align:left;width:14%;">
			                <label class="box size81 orange ${fn:contains(allAuthorizationComponents,item)?" inherit-component":""}" style="vertical-align:top;">
                        	<input type="checkbox" name="componentId" 
							class="${item.privilegeLevel.id==17?"":"function"}"
							 value="${item.id}" 
                        	<c:if test="${item.privilegeLevel.id==17}">disabled='disabled' checked=checked</c:if>
                        	${fn:contains(authorizationComponents,item)?" checked='checked'":""}>
							<i class="${fn:indexOf(item.name, '删除')>-1?"odd":""}">${item.name}</i>
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