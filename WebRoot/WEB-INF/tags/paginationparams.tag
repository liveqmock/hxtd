<%@tag pageEncoding="UTF-8" %>
<%@ attribute name="page" type="com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage" required="true" %>
<input type="hidden" name="hibernatePageNo" value="${page.hibernatePageNo}"/>
<input type="hidden" name="hibernatePageSize" value="${page.hibernatePageSize}"/>
<input type="hidden" name="hibernateOrderBy" value="${page.hibernateOrderBy}"/>
<input type="hidden" name="hibernateOrder" value="${page.hibernateOrder}"/>

