<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>菜单列表页</title>
<link rel="stylesheet" href="${ctx}/static/css/css.css" type="text/css"></link>
<link rel="stylesheet" href="${ctx}/static/component/zTree_v3/css/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${ctx}/static/component/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
<script type="text/javascript">
function onCheck(e, treeId, treeNode) {
	$("#hide_name").val(treeNode.name);
	$("#hide_id").val(treeNode.id);
};
$(document).ready(function(){
		window.ztree = jsUtil.menuTree({
                data:${menuTree==null?"[]":menuTree},
                selectedId: "${parentId}",
                ztreeOptions: {
                    callback: {
                        onClick: onCheck
                    }
                }
            });
});
</script>
</head>

<body>
<div class="content_wrap" style="height:360px; overflow:hidden; overflow-y:auto;">
	<div class="zTreeDemoBackground left">
		<ul id="menuTree" class="ztree"></ul>
	</div>
	<input type="hidden" id="hide_name"/>
	<input type="hidden" id="hide_id"/>
</div> 
</body>
</html>