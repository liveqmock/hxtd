<%--
  首页
  User: xiayouxue
  Date:2014/4/25
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<fmt:formatDate value="${VR_DATE}" pattern="yyyyMMddhhmmss" var="now"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>华兴控股-<sitemesh:title/></title>
<link rel="stylesheet" href="${ctx}/static/css/public/common.css?v=${now}" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css?v=${now}" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/themes/base/jquery.ui.all.css?v=${now}"/>
<link rel="stylesheet" href="${ctx}/static/css/themes/base/jquery-ui-timepicker-addon.css?v=${now}"/>
<script type="text/javascript" src="${ctx}/static/js/api/api.string.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.form.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.core.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.widget.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.mouse.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.draggable.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.position.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.resizable.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.button.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.dialog.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.effect.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.effect-blind.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.tabs.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.custom.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.datepicker.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery-ui-timepicker-addon.js?v=${now}"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>
<script type="text/javascript">${VS_JS_GLOBALINFO};
${VR_JS_GLOBALINFO};</script>

<script type="text/javascript" src="${ctx}/static/js/js-util.js?v=1"></script>
<script type="text/javascript" src="${ctx}/static/js/commonAjax.js?v=${now}"></script>
<script>
    $(function () {//table tr 双击查看
        $(".list tr").live({
            click: function () {
                var $ck = $(this).find(":checkbox"), ck = $ck.get(0);
                if (undefined != ck) {
                    $ck.attr("checked", !ck.checked);
                    $(".checkall").attr("checked", $(".list :checkbox:not(:checked)").length == 0);
                }
            }
        });
    });
</script>
<sitemesh:head/>
</head>
<body style="min-width: 1100px;">
<%@include file="/WEB-INF/layouts/header.jsp" %>
<sitemesh:body/>
<!-- footer -->
<div class="cb h40"></div>
<div class="foot_bg h40 footposition">
    <b class="f_line block"></b>

    <p class="tc mt10 mb5">版权所有©华兴控股集团 地址：北京市朝阳区建国门外大街永安东里8号华彬中心7层 电话：010-85288488</p>
</div>

</body>
</html>