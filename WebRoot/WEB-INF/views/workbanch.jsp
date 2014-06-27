<%--
  功能描述
  User: xiayouxue
  Date:2014/5/5
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>工作台</title>
<style>
.head{font-weight: bold;text-align: center;}
tr{height: 35px;line-height: 35px;text-align: center;}
</style>
<link rel="stylesheet" href="${ctx}/static/css/jquery-ui-1.10.2.custom.min.css"/>
<link rel="stylesheet" href="${ctx}/static/css/jquery.portlet.min.css?v=1.3.1"/>
<script src="${ctx}/static/js/jquery-ui-1.10.2.custom.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/jquery.portlet.pack.js?v=1.3.1" type="text/javascript"></script>
<script>
var date = new Date();
var today = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
var supplierURL = "/project/supplier/toViewPage.do";
var leadURL = "/customer/lead/toViewPage.do";
var customerURL = "/customer/customer/toViewPage.do";
var dateParam = "search_GTE_createdTime="+today+"&search_LTE_createdTime="+today;
function hrefTo(id,moduleURL){
	window.location.href = "${ctx}"+moduleURL+"?id="+id;
}
$(function() {
        $('#portlet-demo').portlet({
            singleView:false,
            columns: [{
                width: '50%',
                portlets: [{
                    title: function() {
                        return '今日供应商  '+today;
                    },
                    content: {
                    	style: {
                            height: 200,
                        },
                        type: 'ajax',
                        dataType: 'json',
                        url: '${ctx}/project/supplier/query.do?'+dateParam,
                        formatter: function(o, pio, data) {
                            var ct = new Array();
                            ct.push("<table width=100%>");
                            ct.push("<thead><tr>",
                            		"<th class='head'>名称</th><th class='head'>类型</th>",
                            		"<th class='head'>电话</th><th class='head'>手机</th>",
                            		"<th class='head'>传真</th><th class='head'>创建者</th>",
                            		"</tr></thead>");
                            ct.push("<tbody class='list'>");
                            $.each(data.result.result, function() {
	                           ct.push("<tr onclick='hrefTo(",this.id,",supplierURL);'>");
                               ct.push("<td>" , this.name , "</td>");
                               ct.push("<td>" , this.type.key , "</td>");
                               ct.push("<td>" , this.phone , "</td>");
                               ct.push("<td>" , this.mobile , "</td>");
                               ct.push("<td>" , this.fax , "</td>");
                               ct.push("<td>" , this.creator.name , "</td>");
	                           ct.push("</tr>");
                            });
                            ct.push("</tbody>");
                            ct.push("</table>");
                            return ct.join("");
                        }
                    }
                },{
                    title: function() {
                        return '今日客户   '+today;
                    },
                    content: {
                    	style: {
                            height: 200
                        },
                        type: 'ajax',
                        dataType: 'json',
                        url: '${ctx}/customer/customer/query.do?'+dateParam,
                        formatter: function(o, pio, data) {
                        	var ct = new Array();
                            ct.push("<table width=100%>");
                            ct.push("<thead><tr>",
                            		"<th class='head'>名称</th><th class='head'>类型</th>",
                            		"<th class='head'>电话</th><th class='head'>手机</th>",
                            		"<th class='head'>传真</th><th class='head'>创建者</th>",
                            		"</tr></thead>");
                            ct.push("<tbody class='list'>");
                            $.each(data.result.result, function() {
	                           ct.push("<tr>");
                               ct.push("<td>",this.name,"</td>");
                               ct.push("<td>",this.type.key,"</td>");
                               ct.push("<td>",this.phone,"</td>");
                               ct.push("<td>",this.mobile,"</td>");
                               ct.push("<td>",this.fax,"</td>");
                               ct.push("<td>",this.creator.name,"</td>");
	                           ct.push("</tr>");
                            });
                            ct.push("</tbody>");
                            ct.push("</table>");
                            return ct.join("");
                        }
                    }
                }]
            },{
                width: '50%',
                portlets: [{
                    title: function() {
                        return '今日线索   '+today;
                    },
                    content: {
                    	style: {
                            height: 200
                        },
                        type: 'ajax',
                        dataType: 'json',
                        url: '${ctx}/customer/lead/query.do?'+dateParam,
                        formatter: function(o, pio, data) {
                            var ct = new Array();
                            ct.push("<table width=100%>");
                            ct.push("<thead><tr>",
                            		"<th class='head'>名称</th><th class='head'>公司</th>",
                            		"<th class='head'>来源</th><th class='head'>状态</th>",
                            		"<th class='head'>卡类型</th><th class='head'>创建者</th>",
                            		"</tr></thead>");
                            ct.push("<tbody class='list'>");
                            $.each(data.result.result, function() {
	                           ct.push("<tr onclick='hrefTo("+this.id+",leadURL);'>");
                               ct.push("<td>" , this.name , "</td>");
                               ct.push("<td>" , this.company , "</td>");
                               ct.push("<td>" , this.source.key , "</td>");
                               ct.push("<td>" , this.status.key , "</td>");
                               ct.push("<td>" , this.cardType.key , "</td>");
                               ct.push("<td>" , this.creator.name , "</td>");
	                           ct.push("</tr>");
                            });
                            ct.push("</tbody>");
                            ct.push("</table>");
                            return ct.join("");
                        }
                    }
                }]
            }]
        });
    });
</script>
</head>
<body>
<div style="margin:20px;">
    <div id="portlet-demo"></div>
</div>
</body>
</html>