<%--
  附件明细页
  Role: xiayouxue
  Date:2014/5/8
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
<link href="${ctx}/static/css/stressing/list1.css" rel="stylesheet" type="text/css" />

    <title>附件详细信息</title>
</head>
<body>
<div >
<div class="cb"></div>
    <div class="ml35 mr35 mt20 block cb cb">
      <b class="table_headl globle_img block fl"></b>
       <div class="fl table_headc fl w99b">
	   <h1 class="f14 fbnone mt10 ml10 fl">附件详细信息</h1>
        <ul class="fr id_table1 mt10 ml10">
		<li><a href="javascript:history.back()" class="block c_white lh25 mr10"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">返&nbsp;&nbsp;回</b></a>
        </li>
		</ul>
		</div>
        <b class="table_headr globle_img block fl"></b>
    </div>
   
    <div class="ml35 mr35 bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">基本信息</h1>
    <table class="cb id_table3 w95b bg_c_white margin0 mt10">
     
        <tr>
            <td align="right" width="15%">附件名：</td>
            <td align="left">${attachment.name}</td>
            <td align="right" width="15%">存储地址：</td>
            <td align="left">${attachment.address}</td>
        </tr>
        <tr>
            <td align="right" width="15%">上传者：</td>
            <td align="left">${attachment.creator.name}</td>
             <td align="right" width="15%">上传时间：</td>
            <td align="left" >${attachment.createdTime }</td>
        </tr>
      <!--   <tr>
            <td colspan="4" class="pl20 color6 fwb bdn">描述信息：</td>
        </tr> -->
        <tr>
           
            <td align="right" width="15%">修改者：</td>
            <td align="left" >${attachment.modifier.name}</td>
            <td align="right" width="15%">修改时间：</td>
            <td align="left">${attachment.modifiedTime }</td>
        </tr>
    </table>
	<div class=" h40"></div>
    </div>
    
</div>
</body>
</html>