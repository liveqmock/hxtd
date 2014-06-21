<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <title>设置</title>
<link href="${ctx}/static/css/stressing/system.css" rel="stylesheet" type="text/css"/>
</head>

<body>



<div><!--请在此处使用iframe---> 
  <!--查询条件开始--> 
  
  <!--查询条件结束-->
  <div class="cb"></div>
  <!--模块开始-->
  <table class="id_table1">
    <tr>
      <td><div class="module">
          <div class="fl ml20">
            <h1 class="c_orange f24 fbnone">个人设置</h1>
            <dl class="w240 id_dl1">
              <dd><a href="">账号指南</a></dd>
              <dd>|</dd>
              <dd><a href="">姓名格式</a></dd>
              <dd>|</dd>
              <dd><a href="">主题</a></dd>
              <dd>|</dd>
              <dd><a href="">审计日志</a></dd>
            </dl>
          </div>
          <div class="fr mr20 Personal_settings globle_img"></div>
        </div></td>
<td><div class="module">
          <div class="fl ml20">
            <h1 class="c_orange f24 fbnone">用户及权限</h1>
            <dl class="w240 id_dl1">
              <dd><a href="${ctx}/system/menu/toQueryPage.do">菜单</a></dd>
              <dd>|</dd>
              <dd><a href="${ctx}/system/user/toQueryPage.do">用户</a></dd>
              <dd>|</dd>
              <dd><a href="${ctx}/system/role/toQueryPage.do">角色</a></dd>
              <dd>|</dd>
              <dd><a href="">职位</a></dd>
              <dd>|</dd>
              <dd><a href="">组</a></dd>
              <dd>|</dd>
              <dd><a href="${ctx}/system/function/toQueryPage.do">功能管理</a></dd>
              <br/>
              <dd><a href="${ctx}/system/component/toQueryPage.do">组件管理</a></dd>
              <dd>|</dd>
              <dd><a href="">权限管理</a></dd>
            </dl>
          </div>
          <div class="fr mr20 Personal_power globle_img"></div>
        </div></td>
<td><div class="module">
          <div class="fl ml20">
            <h1 class="c_orange f24 fbnone">机构设置</h1>
            <dl class="w240 id_dl1">
               <dd><a href="">公司明细</a></dd>
               <dd>|</dd>
               <dd><a href="">财年</a></dd>
               <dd>|</dd>
               <dd><a href="">工作时间</a></dd>
               <dd>|</dd>
               <dd><a href="">货币</a></dd>
            </dl>
          </div>
          <div class="fr mr20 institution_settings globle_img"></div>
        </div></td>
    </tr>
    <tr>
      <td><div class="module">
          <div class="fl ml20">
            <h1 class="c_orange f24 fbnone">数据管理</h1>
            <dl class="w240 id_dl1">
              <dd><a href="">从其他CRM迁移</a></dd>
              <dd>|</dd>
              <dd><a href="">导入历史</a></dd>
              <dd>|</dd>
              <dd><a href="${ctx}/system/data/toExportPage.do">导出数据</a></dd>
              <dd>|</dd>
              <br/>
              <dd><a href="">存储空间</a></dd>
              <dd>|</dd>
               <dd><a href="">回收站</a></dd>
            </dl>
          </div>
          <div class="fr mr20 data_manage globle_img"></div>
        </div></td>
      <td><div class="module">
          <div class="fl ml20">
            <h1 class="c_orange f24 fbnone">开发者空间</h1>
            <dl class="w240 id_dl1">
              <dd><a href="">开发者API接口设置</a></dd>
            </dl>
          </div>
          <div class="fr mr20 develop_space globle_img"></div>
        </div></td>
     <td><div class="module">
          <div class="fl ml20">
            <h1 class="c_orange f24 fbnone">模板</h1>
            <dl class="w240 id_dl1">
              <dd><a href="">邮件模板</a></dd>
              <dd>|</dd>
              <dd><a href="">库存模板</a></dd>
            </dl>
          </div>
          <div class="fr mr20 templet globle_img"></div>
        </div></td>
    </tr>
  </table>
  
  <!--模块结束--> 
  
</div>

</body>
</html>
