<%--
    用户修改密码
  User: huizijing
  Date:2014/6/30
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>修改密码</title>
    <link href="${ctx}/static/css/stressing/detail.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.form.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/commonAjax.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
	<script type="text/javascript">
			$(function(){
			$("#save").click(function(){
				var $form = $("#form");
				if($form.valid()){
					RcmsAjax.ajax($form.attr("action"),function(result){
						//redirect
						//var id = result.result.result;
						setTimeout(function(){
							window.location.replace("${ctx}/system/user/toViewPage.do")
						},500);
					},null,$form.formSerialize());
				}
				return false;
			});
		});
	
	</script>
	<script type="text/javascript">
		$(document).ready(function(){
			
			//重置按钮事件
			$("#reset").click(function(){
			   $("#repwd").val("");
			   $("#oldpwd").val("");
			   $("#newpwd").val("");
		   });
			
			//验证与原密码是否相同
			$("#oldpwd").blur(function(){
				var oldpwd = $("#oldpwd").val();
				RcmsAjax.ajax("${ctx}/system/user/checkPwd?oldpwd="+oldpwd,function(data){
					if(data.successFlag){
					    	$("#pwd").html("");
					    }else{
					    	$("#pwd").html("密码不一致");
					    }
				});
			});
			
			//验证两次密码是否一致
			$("#repwd").blur(function(){
				var newpwd = $("#newpwd").val();
				var repwd = $("#repwd").val();
				if(newpwd!=repwd){
					$("#diff").html("密码不一致");
					$("#repwd").focus();
					$('#repwd').val("");  
				}else{
					$('#diff').html(""); 
				}
			});
		});
	   
	</script>
</head>
  
  <body>
  
  <div style="min-height:750px;">
    <div class="cb"></div>
    <div class="ml35 mr35 mt10 block cb cb">
       <b class="b1"></b>
       <b class="b2"></b>
       <b class="b3"></b>
       <b class="b4"></b>
        <div class="ie_head" >
            <h1 class="f14 fbnone mt10 ml10 fl">密码修改</h1>    
        </div>    
    </div>   
    <div class="ml35 mr35 bg_c_blue cb h590">
    <div  style="width:50%;" class="margin0">
       <form id="form" action="${ctx}${funcUrl}" method="post" onsubmit="return checkForm();">
        <table class=" pt20">
        <tr class=" lh40">
        <input type="hidden" name="id" value="${user.id}"/>
        <td width="25%" align="right">请输入旧密码：</td>
        <td>
        <input type="password" id="oldpwd" name="oldPwd" class="text_input1 required"/>
        <span id="pwd" class="w_red"></span>
        </td>
        </tr>
         <tr class=" lh40">
        <td align="right">请输入新密码：</td>
        <td><input type="password" id="newpwd" name="newPwd" class="text_input1 required"/>
        </td>
        </tr>
         <tr class=" lh40">
        <td align="right">请再输入一次新密码：</td>
        <td>
        <input type="password" id="repwd" name="password" class="text_input1 required"/><span id="diff" class="w_red"></span>
        
        </td>
        </tr>
        </table>
        <div class="w240 margin0 mt60">
	        <a class="block c_white lh25 mr10 fl" href="javascript:;" id="reset">
	        <b class="allbtn_l block fl"></b>
	        <b class="allbtn_r pr13 block fl w_auto f14">重&nbsp;&nbsp;置</b>
	        </a>
	        <a class="block c_white lh25 mr10 fr" href="javascript:;"id="save">
	        <b class="allbtn_l block fl"></b>
	        <b class="allbtn_r pr13 block fl w_auto f14">提&nbsp;&nbsp;交</b>
	        </a>
        </div>
       </form>
    </div>
        <div class="h40"></div>
    </div>
  </div>
  </body>
</html>
