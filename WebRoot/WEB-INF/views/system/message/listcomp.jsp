<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>用户列表页</title>
<link rel="stylesheet" href="${ctx}/static/css/css.css" type="text/css"></link>
 <link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script> 

<SCRIPT type="text/javascript">
function onCheck(e, treeId, treeNode) {
	var names, ids, zTree = $.fn.zTree.getZTreeObj("treeDemo"),
	nodes = zTree.getCheckedNodes(), node;
	for(var i=0; i<nodes.length; i++){
		node = nodes[i];
		if(node.type == 'user'){//判断是用户
			names = (names==undefined? '' : names + ',') + node.name;
			ids = (ids==undefined? '' : ids + ',') + node.id;
		}
	}
	$("#hide_usernames").val(names);
	$("#hide_userids").val(ids);
};
$(document).ready(function(){
	var setting = {
		check: {
			enable: true,
			chkDisabledInherit: true
		},
		data: {
			simpleData: {
				enable: true,
				 pIdKey: 'pId'  //节点数据中保存其父节点唯一标识的属性名称,默认值为pId  
			}
		},
		 async: {  
        enable:true, //设置zTree开启异步加载模式,默认值为false(默认为异步的POST请求)  
        url   :'${ctx}/system/user/toQueryUser.comp'  ,
        autoParam:["id",'pId','name']
         }  
		//callback: {
		//	onCheck: onCheck,
		//	asyncSuccess: zTreeOnAsyncSuccess,//异步加载成功的fun 
        //    asyncError: zTreeOnAsyncError
		//}
	};
	
	//$.fn.zTree.init($("#treeDemo"), setting, ${json});
	$(function(){  
    //开启异步加载后,将第三个参数zNodes填为null后表示根节点也异步加载  
    //由于这里的isSimpleData=true,故异步返回的数据格式应该是下面这种  
    //这是样例报文[{"checked":false,"chkDisabled":false,"id":1,"name":"测试1","open":true,"pid":0,"value":"值value1"},{"checked":false,"chkDisabled":false,"id":2,"name":"test2","open":true,"pid":1,"value":"值value2"},{"checked":false,"chkDisabled":false,"id":3,"name":"test3","open":true,"pid":1,"value":"值value3"},{"checked":true,"chkDisabled":true,"id":4,"name":"test4","open":true,"pid":2,"value":"值value4"},{"checked":false,"chkDisabled":false,"id":5,"name":"test5","open":true,"pid":2,"value":"值value5"}]  
    //如果想对异步返回的数据进行加工,可以在setting.async中配置ajaxDataFilter属性,详见zTree的官方API  
    //注意：显示的树的二级菜单是与异步返回数据有关的,可以修改后台生成数据前针对各菜单元素存放的顺序来查看树的显示效果  
    //注意：但一级菜单始终会显示在第一列的，可以在后台修改二级（乃至三级、四级）菜单的存放顺序  
    $.fn.zTree.init($('#treeDemo'), setting, ${json});  
     }); 
     
     /**  
 * 获取已勾选项编号  
 */  
function getZTreeValue(){  
    var treeObj = $.fn.zTree.getZTreeObj('treeDemo');  
    var nodes = treeObj.getCheckedNodes(true);  
    var checkedIds = '';  
    var checkedValues = '';  
    for(var i=0; i<nodes.length; i++){  
        checkedIds += nodes[i].id + '`';  
        checkedValues += nodes[i].value + '`';  
    }  
    if(checkedIds.length > 0){  
        checkedIds = checkedIds.substring(0, checkedIds.length-1);  
        checkedValues = checkedValues.substring(0, checkedValues.length-1);  
    }  
    alert(checkedIds);  
    alert(checkedValues);  
}  
     
});
</SCRIPT>
</HEAD>

<BODY>
<div class="content_wrap" style="height:360px; overflow:hidden; overflow-y:auto;">
	<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
	<input type="hidden" id="hide_usernames"/>
	<input type="hidden" id="hide_userids"/>
</div> 
</BODY>
</html>