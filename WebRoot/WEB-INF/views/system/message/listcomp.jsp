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
<script type="text/javascript">
function onCheck(e, treeId, treeNode) {
	var names, ids, zTree = $.fn.zTree.getZTreeObj("treeDemo"),
	nodes = zTree.getCheckedNodes(), node;
	for(var i=0; i<nodes.length; i++){
		node = nodes[i];
		node.url="${ctx}/system/user/toQueryUser.comp?orgId="+node.id;
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
				enable: true
				
			}
		},
		async: { 
			enable: true, 
			url:"${ctx}/system/user/toQueryUser.comp", 
			autoParam:["id", "name"]},
		callback: {
			onCheck: onCheck
		}
	};
	$.fn.zTree.init($("#treeDemo"), setting, ${json});
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