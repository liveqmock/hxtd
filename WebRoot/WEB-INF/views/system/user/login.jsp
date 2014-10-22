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
<script type="text/javascript" src="${ctx}/static/js/api/api.string.js"></script>
<script type="text/javascript">
$(function(){
	$("#loginId").focus();
	$('#loginBtn').click(function(){
		submitForm();
	});
	$(document).keydown(function(e){
		var key = (e.keyCode) || (e.which) || (e.charCode);
     	if (key == 13)	{
        	submitForm();
     	}
	});
});
function submitForm(){
	$('#msg').html('');
	var name = $('#loginId').val(), pwd = $('#password').val();
	if(name.trim().length == 0 || pwd.trim().length == 0){
		$('#msg').html('请输入用户名或密码');
	} else{
		form.submit();
	}
}
</script>
</head>
<body class="big_bg" style="min-width: 1100px;">
	<div class="slogin_white fl mt22b"><img src="${ctx}/static/images/big_logo.png" width="162" height="50" class="mt60 ml80"/></div>
	<div class="big_whtie fr mt8b mr80">
		<h1 class="f36 fb mt95 tc">华兴控股CRM系统</h1>
		<form name="form" action="${ctx}/login.doself" method="post">
			<table class="id_table1 margin0 mt60">
				<tr>
					<td>用户名：</td>
					<td>
					<div class="user_bg globle_img">
						<input type="text" id="loginId" name="name" class="required bdnone ml40 mt10 w215 bgnone""/>
					</div>
					</td>
				</tr>
				<tr>
					<td>密码：</td>
					<td>
					<div class="password_bg globle_img">
						<input type="password" id="password" maxlength=30 name="password" class="required bdnone ml40 mt10 w215 bgnone" />
					</div>
					</td>
				</tr>
			</table>
		</form>
		<div class="c_red tc" id="msg">${VM_ERROR}</div>
		<a href="javascript:void(0);" id="loginBtn" class="block c_white lh25 mr10 fr mr80 " >
			<b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">登&nbsp;&nbsp;录</b>
		</a>
	</div>
	<div class="margin0 w500 h80">
		<p class="foot_login tc pt20 lh32 margin0">版权所有©华兴控股集团 地址：北京市朝阳区建国门外大街永安东里8号华彬中心7层<br />联系电话：010-85288488</p>
	</div>
</body>
</html>
