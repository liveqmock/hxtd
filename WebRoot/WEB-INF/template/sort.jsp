<%--
  排序
  User: xiayouxue
  Date:2014/5/28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<textarea id="template-sort" class="template template-sort">
    <span>{$T.name}</span>
    <span class="margin0 block_inline ml5 vm">
        <a href="javascript:void(0)" class="globle_img block order {$T.ascClass}" order="asc" title="升序"></a>
        <a href="javascript:void(0)" class="globle_img block mt3 order {$T.descClass}" order="desc" title="降序"></a>
    </span>
</textarea>