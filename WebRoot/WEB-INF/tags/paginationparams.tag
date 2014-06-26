<%@tag pageEncoding="UTF-8" %>
<%@ attribute name="page" type="com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage" required="true" %>
<input type="hidden" name="hibernatePageNo" value="${page.hibernatePageNo}" class="pagination-param"/>
<input type="hidden" name="hibernatePageSize" value="${page.hibernatePageSize}" class="pagination-param"/>
<input type="hidden" name="hibernateOrderBy" value="${page.hibernateOrderBy}" class="pagination-param"/>
<input type="hidden" name="hibernateOrder" value="${page.hibernateOrder}" class="pagination-param"/>

