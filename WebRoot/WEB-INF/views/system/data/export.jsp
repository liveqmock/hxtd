<%--
  数据导出页
  User: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>数据导出页</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>
    <script>
        $(function () {
            $("[name=module]").trigger("change");
            jsUtil.bindSubmit();
        });
    </script>
</head>
<body>
<div style="min-height:750px;">
    <div class="cb"></div>
    <div class="ml35 mr35 mt20 block cb cb">
        <b class="b1"></b>
        <b class="b2"></b>
        <b class="b3"></b>
        <b class="b4"></b>

        <div class="ie_head">
            <h1 class="f14 fbnone mt10 ml10 fl">导出数据</h1>
        </div>
    </div>

    <form action="${ctx}${VR_FUNCTION.url}" method="post">
        <div class="ml35 mr35 bg_c_blue cb h590">
            <div style="width:50%;" class="margin0">
                <p class="pt20">此页面帮助您以xls格式导出此帐号中的数据(最多3000条记录)。</p>

                <p class=" mt45 fl">请选择导出模块：</p>
                <select name="module" onchange="$('.submit').attr('uri',this.value)" class="select3 mt40">
                    <c:forEach items="${functions}" var="item">
                        <option value="${ctx}${item.url}?TYPE=limit">${item.name}</option>
                    </c:forEach>
                </select>

                <div class="w240 margin0 mt60">
                    <a href="javascript:void(0)" class="block c_white lh25 mr10 fl submit" redirecturi="/setting/data/toExportPage.do"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">导&nbsp;&nbsp;出</b></a>
                    <a class="block c_white lh25 mr10 fr" href="javascript:history.back();"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b></a>
                </div>
            </div>
            <div class=" h40"></div>
        </div>
    </form>

</div>

</body>
</html>