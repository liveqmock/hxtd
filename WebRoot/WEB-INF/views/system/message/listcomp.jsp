<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>组织结构树</title>
<link rel="stylesheet" href="${ctx}/static/css/css.css" type="text/css"></link>
<link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script> 
<script type="text/javascript">
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
	};
	
	$(function(){  
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
}  
     
});
</script>
</head>
<body>
<div class="content_wrap" style="height:360px; overflow:hidden; overflow-y:auto;">
	<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
	<input type="hidden" id="hide_usernames"/>
	<input type="hidden" id="hide_userids"/>
</div> 
</body>
</html>