<%--
  功能描述：编辑组件
  User: ruisong.luan
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>功能详情</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
<link rel="stylesheet" type="text/css" href="styles.css">
-->
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript">
$(function(){
	//$("#form").valid();
	$("#saveAndAdd").click(function(){
		var $form = $("#form");
		if($form.valid()){
			RcmsAjax.ajax($form.attr("action"),function(result){
				setTimeout(function(){
					window.location.replace("${ctx}/system/function/toAddPage.do")
				},500);
			},null,$form.formSerialize());
		}
		return false;
	});
	$("#save").click(function(){
		var $form = $("#form");
		if($form.valid()){
			RcmsAjax.ajax($form.attr("action"),function(result){
				//redirect
				var id = result.result.result;
				setTimeout(function(){
					window.location.replace("${ctx}/system/function/toViewPage.do?id="+id)
				},500);
			},null,$form.formSerialize());
		}
		return false;
	});
	
	jsUtil.renderRequiredFromInput();
});
</script>
<script type="text/javascript">
var zNode = ${zNode};
$(function(){
	jsUtil.easyTree.init(zNode,childFun);
	$("#menuText").click(function(){
		jsUtil.easyTree.show("#menuText");
	});
	$("#save").click(function(){
		if($("#form").valid()){
			$("#form").submit();
		}
	});
	$("#saveAndAdd").click(function(){
		$("#form").attr("action",$("#form").attr("action")+"?type=add");
		if($("#form").valid()){
			$("#form").submit();
		}
	});
});
function childFun(treeNode){
	$("#menuText").val(treeNode.name);
	$("#menuId").val(treeNode.id);
}
</script>
</head>
  
<body>
<form id="form" action="${ctx }${funcUrl}" method="post">
<div><!--请在此处使用iframe--->
    <!--查询条件开始-->

    <!--查询条件结束-->
    <div class="cb"></div>
    <!--列表开始-->
    <div class="ml35 mr35 mt20 block cb cb">
       <b class="b1"></b>
       <b class="b2"></b>
       <b class="b3"></b>
       <b class="b4"></b>
        <div class="ie_head" >
            <h1 class="f14 fbnone mt10 ml10 fl">功能详情信息</h1>
            <ul class="fr id_table1 mt10 ml10">
            </ul>
        </div>    
    </div> 
    <input name="id" value="${func.id}" type="hidden"/>
    <div class="ml35 mr35 bg_c_blue cb">
        <h1 class="f14 fbnone ml40 pt10">基本信息</h1>
        <table class="cb id_table3 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%">功能名：</td>
                <td align="left"><input type="text" name="name" value="${func.name }" class="text_input3 required"/></td>
                <td align="right" width="15%">功能编号：</td>
                <td align="left"><input type="text" name="code" value="${func.code }" class="text_input3 required"/></td>
            </tr>
            <tr>
                <td align="right">调用入口：</td>
                <td align="left"><input type="text" name="url" value="${func.url }" class="text_input3 required"/></td>
                <td align="right">归属菜单：</td>
                <td align="left">
                <input type="text" id="menuText"  value="${func.menu.name }" class="text_input3" readonly/>
                <input name="menu.id" id="menuId" value="${func.menu.id }" type="hidden"/>
                </td>
            </tr>
            <tr>
                <td align="right">权限级别：</td>
                <td align="left">
					<select name="privilegeLevel.id" class="select1 pr required">
						<option value="">
							--请选择--
						</option>
						<c:forEach items="${level}" var="d">
							<option value="${d.id}"
								<c:if test="${d.id==func.privilegeLevel.id}">
             						selected
             				</c:if>
             				>${d.key}</option>
						</c:forEach>
					</select>
				</td>
            </tr>
        </table>
        <h1 class="f14 fbnone ml40 pt10">描述信息</h1>
        <table class="cb id_table4 w95b bg_c_white margin0 mt10">
            <tr>
                <td align="right" width="15%" valign="top">备注：</td>
                <td align="left" width="85%"><textarea name="remark"  class="remarks_input1">${func.remark}</textarea></td>
            </tr>
        </table>
        <div class=" h40"></div>
    </div>
    <div class="cb block h40 margin0 mt10" style="width:350px;">
        <ul class="id_table1 cb">
            <li><a href="javascript:;" id="save" class="block c_white lh25 mr35"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保&nbsp&nbsp存</b></a></a></li>
            <li><a href="javascript:;" id="saveAndAdd" class="block c_white lh25 mr35"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">保存并新建</b></a></li>
            <li><a href="${ctx}/system/function/toQueryPage.do"  class="block c_white lh25"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取&nbsp&nbsp消</b></a></li>
        </ul>
    </div>
</div>
</form>
  </body>
</html>
