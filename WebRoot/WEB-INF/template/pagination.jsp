<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  功能描述
  User: xiayouxue
  Date:2014/5/28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<textarea id="template-pagination" class="template template-pagination">
    <ul class="id_ul1 block  fl cb paginationbar" forform="{$T.formSelector}">
        <li class="mt3">每页条数</li>
        <li>
            <select class="page-size" forformfield="{$T.pageSizeSelector}">
                {#foreach [5,10,20,30,40,50] as pageSize}
                <option value="{$T.pageSize}"
                {$T.hibernatePageSize==$T.pageSize?"selected":""}>{$T.pageSize}</option>
                {#/for}
            </select>
        </li>
        <li class="mt3 cp"><a class="page-first">首页</a></li>
        <li><a href="javascript:void(0)" class="block prev globle_img page-pre" title="上一页"></a></li>
        <li class="pr">
            <input type="text" class="pa fenye_ipt_text page-no" pageno="{$T.hibernatePageNo}" value="{$T.hibernatePageNo}"/>
            <a href="javascript:void(0)" class="fenye_go globle_img block page-anyone"></a>
        </li>
        <li class="mt3">共<label class="page-totalpages">{$T.totalPages}</label>页</li>
        <li><a href="javascript:void(0)" class="next globle_img block page-next" title="下一页"></a></li>
        <li class="mt3 cp"><a class="page-last">末页</a></li>
        <li><a href="javascript:void(0)" class="fenye_break globle_img block page-rel" title="刷新"></a></li>
    </ul>
    <p class="fr mr35">显示{$T.startRow}到{Math.min($T.endRow,$T.totalCount)}条，共{$T.totalCount}条</p>
</textarea>