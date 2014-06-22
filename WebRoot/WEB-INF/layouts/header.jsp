<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!--菜单开始-->
<div class="h_head_bg pr">
    <p class="tr mr15 pt20">
        今天是<fmt:formatDate value="${VR_DATE}" pattern="MM月dd日"/>，欢迎您${VS_USER.realName}
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
                        <span class="pa none z1">
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
                         </span>
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
                    <c:when test="${item.trigger==null}"><span class="c_orange">${item.name}</span></c:when>
                    <c:otherwise><a href="${ctx}${item.trigger.url}" class="c_orange">${item.name}</a> </c:otherwise>
                </c:choose>
                ${status.last?"":">"}
            </c:forEach>
            <c:if test="${VR_TITLE_LAST_MENU.trigger!=VR_TITLE_FUNCTION}">
                > <a href="${ctx}${VR_TITLE_FUNCTION.url}?${VR_PARAMS}" class="c_orange">${VR_TITLE_FUNCTION.name}</a>
            </c:if>
        </p>
    </c:if>
    <ul class="fr mr35 mt3">
        <li class="head_add globle_img fl mr15">&nbsp;</li>
        <li class="head_system globle_img fl mr15">&nbsp;</li>
        <li class="head_news globle_img fl mr10">&nbsp;</li>
    </ul>
</div>
<!--当前页及功能条结束-->
<div id="point4Ajax" style="padding:5px;position: fixed;z-index:101;top:40%;left:0;border-radius:4px;-moz-border-radius:4px;-webkit-border-radius:4px;-o-border-radius:4px; display:block;"></div>