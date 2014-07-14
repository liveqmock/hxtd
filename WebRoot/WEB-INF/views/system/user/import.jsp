<%--
  用户导入页
  User: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户导入页</title>
    <link rel="stylesheet" href="${ctx}/static/css/application.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/js-util.common.js"></script>

    <script type="text/javascript">
        $(function () {jsUtil.bindSave();});
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
            <h1 class="f14 fbnone mt10 ml10 fl">导入数据</h1>
        </div>
    </div>
    <form action="${ctx}${VR_FUNCTION.url}" method="post" enctype="multipart/form-data">
        <div class="ml35 mr35 bg_c_blue cb h590">
            <div style="width:50%;" class="margin0">
                <p class="pt20">请选择导入文件：<input type="file" name="file"/></p>

                <p style="color:red;">
                    1.只能支持.xls文件格式.<br>
                    2.给定文件的第一行将视为字段名。<br/>
                    3.请确认您的文件大小不超过5MB。
                </p>

               <%-- <p class=" mt45">
                    重复数据时：
                    <label><input type="radio" name="repeatOption" value="overwrite"/>覆盖</label>
                    <label><input type="radio" name="repeatOption" value="update"/>更新</label>
                </p>

                <p>
                    请选择日期格式：
                    <select name="dateFormat" class="select3 mt40">
                        <option value="yyyy-MM-dd">yyyy-MM-dd</option>
                        <option value="MM/dd/yyyy">MM/dd/yyyy</option>
                        <option value="dd/MM/yyyy">dd/MM/yyyy</option>
                        <option value="MM-dd-yyyy">MM-dd-yyyy</option>
                        <option value="dd-MM-yyyy">dd-MM-yyyy</option>
                        <option value="MM.dd.yyyy">MM.dd.yyyy</option>
                        <option value="dd.MM.yyyy">dd.MM.yyyy</option>
                    </select>

                    <select name="timeFormat" class="select3 mt40">
                        <option value="HH:mm:ss">HH:mm:ss</option>
                        <option value="HH:mm">HH:mm</option>
                    </select>
                </p>
                &lt;%&ndash;
                <p style="color:red;">
                     1.除指定格式“yyyy-MM-dd HH:mm:ss”以外的任何其它时间日期格式，在导入时都会因无法识别而被忽略。
                 </p>
                 &ndash;%&gt;
--%>
                <p class="mt40">模板：<a href="${ctx}/static/template/import/${templateName}">${templateName}</a></p>

                <p style="color:red;">
                    1.请先下载模板，并在此基础上进行修改。<br/>
                    2.管理员、启用、性别都是“是否”类型的数据。<br/>
                </p>

                <div class="w240 margin0 mt60">
                    <c:if test="${VS_HAS_FUNCTIONS.userImport}">
                        <a href="javascript:void(0)" class="block c_white lh25 mr10 fl submit" redirecturi="/system/user/toQueryPage.do"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">导&nbsp;&nbsp;入</b></a>
                        <a href="javascript:history.back();" class="block c_white lh25 mr10 fr"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">取&nbsp;&nbsp;消</b></a>
                    </c:if>
                </div>
            </div>
            <div class=" h40"></div>
        </div>
    </form>
</div>
</body>
</html>