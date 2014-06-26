<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<link href="${ctx}/static/css/stressing/detail.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
   $(function(){
	   //每个5分钟执行一次定时任务
	   refreshAjax();
	   setInterval(refreshAjax, 10*60*1000);
   });
   
   function refreshAjax(){
	   requestMessageAjax();
	   requestNoticeAjax();
   }
   
   function requestMessageAjax(){
	   RcmsAjax.ajaxNoMsg ("${ctx}/system/message/query.do?search_EQ_status=0&type=recived",function(data){
		   var messageSize = data.result.result.length;
		   if(messageSize>0){
		   		$("#message").removeClass().addClass("head_news1 globle_img fl");
	   		}else{
	   			$("#message").removeClass().addClass("head_news globle_img fl");
	   		}
	   		var messages=eval(data.result.result);
	   		var ss='<li>系统消息：</li>';
	   		var len=messages.length>3?3:messages.length;
	   		for(var i=0;i<len;i++){
	           ss+='<li><a href=\"${ctx}/system/message/toViewPage.do?id='+messages[i].id+'\">'+messages[i].message.title+'</a></li>';
	   		}
	   		$("#messages").html(ss);
	   });
 	};
    function requestNoticeAjax(){
    	RcmsAjax.ajaxNoMsg ("${ctx}/system/notice/query.do",function(data){
			var noticeSize = data.result.result.length;
			if(noticeSize>0){
				$("#notice").removeClass().addClass("head_system1 globle_img fl mr15");
			}else{
				$("#notice").removeClass().addClass("head_system globle_img fl mr15");
			}
			var notices=eval(data.result.result);
			var ss='<ul class=\" block\">';
			if(notices.length>0){
			      ss+='<li><a href=\"${ctx}/system/notice/toViewPage.do?id='+notices[0].id+'\">'+notices[0].title+'</a></li>';
			      ss+='</ul>';
				$("#notices").html(ss);
			}
	   });
 	};
</script>
<!--菜单开始-->
<div class="h_head_bg pr">
    <p class="tr mr15 pt20">
        今天是<fmt:formatDate value="${VR_DATE}" pattern="MM月dd日"/>，欢迎您 ${VS_USER.realName}
        <c:forEach items="${VS_TITLEBAR_FIRST_MENUS}" var="item">
            <a href="${ctx}${item.trigger.url}" class="ml10 w_blue">${item.name}</a>
        </c:forEach>
        <a href="${ctx}/logout.doself" class="ml10 mr35 w_blue">注销</a>
    </p>
    <img src="${ctx}/static/images/logo.png" width="162" height="50" class="fl ml35 mt45 pa at-20"/>
    <ul class="fr mr35 mt20 h_navbtn">
        <c:forEach items="${VS_MENUBAR_FIRST_MENUS}" var="menu" varStatus="status">
            <c:set var="selectedMenuCss" value="${menu==VR_FIRST_MENU?'navpitch':'navbtn'}"/>
            <li>
                <b class="h_${selectedMenuCss}_l h40 w25 block fl"></b>
                <b class="h_${selectedMenuCss}_r c_white pr25 h40 w_auto f14 block fr lh40 cp id_nav pr">
                    <c:choose>
                        <c:when test="${menu.trigger==null}"><a href="javascript:void(0)" class="c_white">${menu.name}</a></c:when>
                        <c:otherwise><a href="${ctx}${menu.trigger.url}" class="c_white">${menu.name}</a></c:otherwise>
                    </c:choose>
                    <c:set var="secoundMenus" value="${VS_MENUBAR_SECOUND_MENUS[menu.id]}"/>
                    <c:if test="${secoundMenus!=null}">
                        <div class="pa none z1">
                            <b class="h_navlist_growt block c_orange f14 tc lh50">${menu.name}</b>
                            <ul class="block c_orange id_grow block">
                                <c:forEach items="${secoundMenus}" var="secoundMenu">
                                    <c:set var="selectedSecoundMenuCss" value="${secoundMenu==VR_LAST_MENU?'select':''}"/>
                                    <li class="cb block tc">
                                        <c:choose>
                                            <c:when test="${secoundMenu.trigger==null}"><a href="javascript:void(0)" class="${selectedSecoundMenuCss}">${secoundMenu.name}</a></c:when>
                                            <c:otherwise><a href="${ctx}${secoundMenu.trigger.url}" class="${selectedSecoundMenuCss}">${secoundMenu.name}</a></c:otherwise>
                                        </c:choose>
                                    </li>
                                </c:forEach>
                                <b class="h_navlist_growb1 block cb"></b>
                            </ul>
                        </div>
                    </c:if>
                </b>
            </li>
        </c:forEach>
    </ul>
</div>
<!--当前页及功能条开始-->
<div class="facing mt-5">
    <c:if test="${VR_TITLE_MENUS!=null}">
        <p class="f12 pt5 ml35 fl">当前位置：
            <c:forEach items="${VR_TITLE_MENUS}" var="item" varStatus="status">
                <c:choose>
                    <c:when test="${item.trigger==null}"><span>${item.name}</span></c:when>
                    <c:otherwise><a href="${ctx}${item.trigger.url}">${item.name}</a> </c:otherwise>
                </c:choose>
                ${status.last?"":">"}
            </c:forEach>
            <c:if test="${VR_TITLE_LAST_MENU.trigger!=VR_TITLE_FUNCTION}">
                > <a href="${ctx}${VR_TITLE_FUNCTION.url}?${VR_PARAMS}" class="c_orange">${VR_TITLE_FUNCTION.name}</a>
            </c:if>
        </p>
    </c:if>
    <ul class="fr mr35 mt3 common_id1">
        <li class="head_add globle_img fl mr15">
        	<div class="none w100 div1 pr z1">
        	    <b class="tan_leftjian2 globle_img block pa"></b>
		        <b class="bb1"></b>
		        <b class="bb2"></b>
		        <b class="bb3"></b>
		        <b class="bb4"></b>
		        <b class="bb5"></b>
		        <b class="bb5"></b>
		        <b class="bb5"></b>
		        <b class="bb5"></b>
		        <span class="block">
		        <ul class=" block">
		        	<li><a href="${ctx}/market/marketactivity/toAddPage.do">新增市场活动</a></li>
			        <li><a href="${ctx}/customer/lead/toAddPage.do">新增线索</a></li>
			        <li><a href="${ctx}/customer/contact/toAddPage.do">新增联系人</a></li>
			        <li><a href="${ctx}/customer/customer/toAddPage.do">新增客户</a></li>
			        <li><a href="${ctx}/customer/supplier/toAddPage.do">新增供应商</a></li>
			        <li><a href="${ctx}/customer/project/toAddPage.do">新增项目</a></li>
			        <li><a href="${ctx}/customer/product/toAddPage.do">新增产品</a></li>
			        <li><a href="javascript:;">新增订单</a></li>
			        <li><a href="javascript:;">新增合同</a></li>
		        </ul>
		        </span>
		       <b class="bb6"></b>
		       <b class="bb6"></b>
		       <b class="bb6"></b>
		       <b class="bb6"></b>
		       <b class="bb7"></b>
		       <b class="bb8"></b>
		       <b class="bb9"></b>
		       <b class="bb0"></b>
		    </div>
        </li>
        
        
        	<li class="head_system globle_img fl mr15" id="notice"><a href="${ctx}/system/notice/toQueryPage.do">&nbsp;</a>
        	<div class="none w100 div2 pr">
        	    <b class="tan_leftjian3 globle_img block pa"></b>
		        <b class="bb1"></b>
		        <b class="bb2"></b>
		        <b class="bb3"></b>
		        <b class="bb4"></b>
		        <b class="bb5"></b>
		        <b class="bb5"></b>
		        <b class="bb5"></b>
		        <b class="bb5"></b>
		        <span class="block">
		        <ul class=" block">
		        	<li>公告：</li>
        			<li id="notices"></li>
		        </ul>
		        </span>
		       <b class="bb6"></b>
		       <b class="bb6"></b>
		       <b class="bb6"></b>
		       <b class="bb6"></b>
		       <b class="bb7"></b>
		       <b class="bb8"></b>
		       <b class="bb9"></b>
		       <b class="bb0"></b>
		    </div>
        	
        	</li>
        	<li class="head_news globle_img fl mr10" id="message"><a href="${ctx}/system/message/toQueryPage.do?type=reviced">&nbsp;</a>
        	<div class="none w100 div3 pr">
        	<b class="tan_leftjian4 globle_img block pa"></b>
		        <b class="bb1"></b>
		        <b class="bb2"></b>
		        <b class="bb3"></b>
		        <b class="bb4"></b>
		        <b class="bb5"></b>
		        <b class="bb5"></b>
		        <b class="bb5"></b>
		        <b class="bb5"></b>
		        <span class="block">
		         <ul id="messages" class=" block">
		        	<li>系统消息：</li>
        			<li>您有一条系统消息</li>
        			<li>您有一条系统消息</li>
        			<li>您有一条系统消息</li>
		        </ul> 
		        </span>
		       <b class="bb6"></b>
		       <b class="bb6"></b>
		       <b class="bb6"></b>
		       <b class="bb6"></b>
		       <b class="bb7"></b>
		       <b class="bb8"></b>
		       <b class="bb9"></b>
		       <b class="bb0"></b>
		    </div>
        	</li>
    </ul>
</div>
<!--当前页及功能条结束-->
<div id="point4Ajax" style="padding:5px;position: fixed;z-index:101;top:40%;left:0;border-radius:4px;-moz-border-radius:4px;-webkit-border-radius:4px;-o-border-radius:4px; display:block;"></div>