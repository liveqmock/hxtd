<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<title>华兴控股-登录</title>
<link href="${ctx}/static/css/stressing/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	// 登陆
	$('#loginBtn').click(function(){
		submitForm();
		return false;
	});
	
	$(document).keydown(function(e){
		var key = (e.keyCode) || (e.which) || (e.charCode);
     	if (key == 13)	{
        	submitForm();
        	return false;
     	}
	});
});

function submitForm(){
	if(checkLoginForm()){
		$('#loginForm').attr('action', '${ctx}/login.doself');
		$('#loginForm').attr('method', 'post');
	    $('#flag').val('login');
	    $('#loginForm').submit();
	}
}

// check表单(只做了长度的check)
function checkLoginForm(){
	var $loginIdVal = $('#loginId').val();
	if($loginIdVal == null || $loginIdVal == ''){
		$('#loginId').focus();
		$('#loginId').val('请输入用户名');
		return false;
	}else if($loginIdVal.length>30){
		$('#loginId').focus();
		$('#loginId').val('用户名长度不能超过30个字符');
		return false;
	}else if($loginIdVal.length<3){
		$('#loginId').focus();
		$('#loginId').val('用户名长度不能少于3个字符');
		return false;
	}
	
	var $pwdVal = $('#password').val();
	if($pwdVal == null || $pwdVal == ''){
		$('#password').focus();
		$('#msg').html('请输入密码');
		return false;
	}else if($pwdVal.length>20){
		$('#password').focus();
		$('#msg').html('密码长度不能超过20个字符');
		return false;
	}else if($pwdVal.length<3){
		$('#password').focus();
		$('#msg').html('密码长度不能少于3个字符');
		return false;
	}
	$('#msg').html('');
	return true;
}
</script>
</head>

<body class="big_bg" style="min-width: 1100px;">
<%--<img src="${ctx}/static/images/big_gb.jpg" class="pa big_img" />
--%><div class="slogin_white fl mt22b">
<img src="${ctx}/static/images/big_logo.png" width="162" height="50" class=" mt60 ml80"/>
</div>
<div class="big_whtie fr mt8b mr80">
<h1 class="f36 fb mt95 tc">华兴控股CRM系统</h1>
<form action="" method="post" id="loginForm">
<table class="id_table1 margin0 mt60">
<tr>
<td>用户名：</td>
<td><div class="user_bg globle_img"><input type="text" id="loginId" name="name" class="bdnone ml40 mt10 w215 bgnone"  value="${user.name}"/></div></td>
</tr>
<tr>
<td>密码：</td>
<td><div class="password_bg globle_img"><input type="password" id="password" maxlength=30 name="password" class="bdnone ml40 mt10 w215 bgnone" value="${user.password}"/></div></td>
</tr>
</table>
</form>
<div class="c_red tc" id="msg">${VM_ERROR}</div>
<a href="javascript:void(0);" id="loginBtn" class="block c_white lh25 mr10 fr mr80 " ><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">登&nbsp;&nbsp;录</b></a>

</div>
<div class="margin0 w500 h80"><p class="foot_login tc pt20 lh32 margin0">版权所有©华兴控股集团 地址：北京市朝阳区建国门外大街永安东里8号华彬中心7层<br />联系电话：010-85288488</p></div>
</body>
</html>
