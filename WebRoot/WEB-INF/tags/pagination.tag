<%@tag pageEncoding="UTF-8" %>
<%@ attribute name="url" type="java.lang.String" required="true" %>
<%@ attribute name="page" type="com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage" required="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<table cellspacing="1" class="tablesorter">
    <tr>
        <td>
             <div class="fl">
                 每页条数
                 <select name="pageSize">
                     <c:forEach begin="1" end="10" var="count">
                         <option value="${count*10}" ${page.hibernatePageSize==count*10?"selected":""}>${count*10}</option>
                     </c:forEach>
                 </select>
             </div>
            <div class="clear"></div>
            <ul class="fynew">
                <li>|</li>
                <li>
                    <a href="${ctx}${url}?pageNo=1&orderBy=${page.hibernateOrderBy}&order=${page.hibernateOrder}&${searchParams}" class="page-first">
                        <img src="${ctx}/static/images/lbtn.png" alt=""/>
                    </a>
                </li>
                <li>
                    <c:choose>
                        <c:when test="${page.hasPre}">
                            <a href="${ctx}${url}?pageNo=${page.hibernatePageNo-1}&orderBy=${page.hibernateOrderBy}&order=${page.hibernateOrder}&${searchParams}" class="page-pre">
                                <img src="${ctx}/static/images/llbtn.png" alt=""/>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void(0)">
                                <img src="${ctx}/static/images/llbtn.png" alt=""/>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </li>
                <li>|</li>
                <li>第<input type="text" name="pageNo" value="${page.hibernatePageNo}" class="page-current"/>页 共${page.totalPages}页
                </li>
                <li>|</li>
                <li>
                    <c:choose>
                        <c:when test="${page.hasPre}">
                            <a href="${ctx}${url}?pageNo=${page.hibernatePageNo+1}&orderBy=${page.hibernateOrderBy}&order=${page.hibernateOrder}&${searchParams}" class="page-next">
                                <img src="${ctx}/static/images/rbtn.png" alt=""/>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void(0)">
                                <img src="${ctx}/static/images/rbtn.png" alt=""/>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </li>
                <li>
                    <a href="${ctx}${url}?pageNo=${page.totalPages}&orderBy=${page.hibernateOrderBy}&order=${page.hibernateOrder}&${searchParams}" class="page-last">
                        <img src="${ctx}/static/images/rrbtn.png" alt=""/>
                    </a>
                </li>
                <li>|</li>
                <li>
                    <a href="${ctx}${url}?pageNo=${page.hibernatePageNo}&orderBy=${page.hibernateOrderBy}&order=${page.hibernateOrder}&${searchParams}">
                        <img src="${ctx}/static/images/gengxi.png" alt=""/>
                    </a>
                </li>
            </ul>
            <div class="fr" style="margin-right:10px;">显示${page.startRow}到${page.endRow}，共${page.totalCount}记录</div>
        </td>
    </tr>
</table>