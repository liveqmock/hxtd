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
    	.id_ul4:hover{ color:#000000 !important;}
    	.id_ul4 li{ float:left; width:16%; margin-top:5px; margin-bottom:5px;line-height:20px;}
		.id_ul4 li a{ height:25px;line-height:25px; color:#222; text-align:center; padding-left:10px; padding-right:10px;}
		.id_ul4{ width:86.2%;}
    </style>
    <script type="text/javascript">
        $(function () {
    	   //初始化的时候请求勾选的角色，并绑定角色的功能
    	   $('input[name="roleId"]:checked').each(function(){
    		    var $this = $(this);
				var roleId = $this.val();
				RcmsAjax.ajaxNoMsg("${ctx}/system/user/toAuthorizationPage.do?TYPE=show&roleId="+roleId, 
				function (result) {
        	    $this.data("functionIds",result.message);
				});
			});
    	  // $(".role").attr("data-id",result.message);
    	    //ajax请求，返回每个被选中的角色的功能
    	    $(".role").click(function(){
    	    	var $this = $(this);
    	    	var flag = $this.attr("checked");
    	    	var functionIds = $this.data("functionIds");
    	    	if(!functionIds){
    	    		//ajax
    	    		RcmsAjax.ajaxNoMsg("${ctx}/system/user/toAuthorizationPage.do?TYPE=show&roleId="+$this.val(),function(result){
    	    			$this.data("functionIds",result.message);
    	    			var ids=result.message;
        	    		selectId(ids,flag,$this.val());
    	    			});
    	    	}else{
    	    		selectId(functionIds,flag,$this.val());
    	    	}
      		});
    	    
    	    function selectId(ids,flag,roleId){
        		var allId=ids.split('|');
    	    	var funIds=allId[0].split(',');
    	    	var comIds=allId[1].split(',');
				if(flag){
					$('input[name="functionId"]').each(function(){
						if($.inArray($(this).val(),funIds)>0){
							if(!$(this).attr("checked")){
							    $(this).attr("checked",true);
							    }
							}
		  				});
					$('input[name="componentId"]').each(function(){
						if($.inArray($(this).val(),comIds)>0){
							if(!$(this).attr("checked")){
							    $(this).attr("checked",true);
							    }
							}
		  				});
	        	}
				else{
	        		var checkeds="";
	        		var funs="";
	        		var coms="";
	        		$('input[name="roleId"]:checked').each(function(){
	        			checkeds=$(this).data("functionIds")+checkeds;
					});
	        		var all=checkeds.split('|');
	        		for(i=0;i<all.length;i++){
	        			if(i%2==0){funs=funs+all[i]}
	        			else{coms=coms+all[i]}
	        		}
					$('input[name="functionId"]').each(function(){
							if($.inArray($(this).val(),funs.split(','))<0){
								$(this).attr("checked",false);
							}
		  			});
					$('input[name="componentId"]').each(function(){
							if($.inArray($(this).val(),coms.split(','))<0){
								$(this).attr("checked",false);
							}
		  			});
	        	}
    	    }
    	    
    	    
    	    
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
          
            //鼠标移近效果
            $(".orange").mouseenter(function(){
            	$(this).addClass("c_orange");
            }).mouseleave(function(){
            	$(this).removeClass("c_orange");
            });
            
            //角色列表浮动
            var t=$("#fly").offset().top;
            var w=$(".roleUl").width();
            $(window).scroll(function () {
            	if($(document).scrollTop()==0){
            		$("#fly").css('top',t);
            		$("#fly").css('width',w);
            		$("#fly").css('position','static');
            	}else{
            		$("#fly").css('position','fixed');
            		$("#fly").css('left','top');
            		$("#fly").css('top',0);
            		$("#fly").css('width',w);
            	}
        	});
        });
      
    </script>
</head>
<body>
<form name="user" action="${ctx}${VR_FUNCTION.url}" method="post">
    <input type="hidden" name="id" value="${param.id}">
    <div  id="fly" class="right_fbg bg_c_f3f3f3 ml35 mr35 brall5">
    	<h1 class="f14 ml20 mt20 pt10">角色列表</h1>
            <div class="menus1">
                <div class="clearfix w menu1">
	                	<ul class="mb10 cb roleUl" style="overflow:hidden;">
		                    <c:forEach items="${allRoles}" var="item" varStatus="status">
		                        <li class="fl" style="width:16%;">
		                            <label class="box size51 ${fn:contains(organizationInheritRoles,item)?" inherit-role":""}">
		                                <input data-id="" type="checkbox" name="roleId" value="${item.id}" class="role" ${fn:contains(authorizationRoles,item)?"checked":""}/>
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
                        <ul class="id_ul4 fr  ">
                            <c:forEach items="${allFunctions[item.id]}" var="item">
                                <li align="left" style="line-height:20px;">
                                    <label class="box size51 orange ${fn:contains(allAuthorizationFunctions,item)?" inherit-function":""}">
                                        <input type="checkbox" name="functionId" value="${item.id}" data-id=""
                                        class="function" ${fn:contains(authorizationFunctions,item)?" checked=checked":""}>
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
	                            <li align="left" style="line-height:20px;">
	                                <label class="box size51 orange ${fn:contains(allAuthorizationFunctions,item)?" inherit-function":""}">
	                                    <input ${fn:contains(allAuthorizationFunctions,item)?" checked='checked'":""} type="checkbox" name="functionId" value="${item.id}" 
	                                    class="function" data-id="">
	                                    <i>${item.name}</i>
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
			                <li align="left" style="line-height:20px;">
			                <label class="box size81 orange ${fn:contains(allAuthorizationComponents,item)?" inherit-component":""}">
                        	<input type="checkbox" name="componentId" value="${item.id}" ${fn:contains(authorizationComponents,item)?" checked='checked'":""}>${item.name}
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