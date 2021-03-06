<%@ page import="java.util.Date" %>
<%--
  首页
  User: xiayouxue
  Date:2014/4/25
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <title>华兴控股</title>
    <link href="${ctx}/css/css.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/css/jquery-ui-1.10.2.custom.min.css"/>
    <link rel="stylesheet" href="${ctx}/css/jquery.portlet.min.css?v=1.3.1"/>
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
    <script src="${ctx}/js/jquery-ui-1.10.2.custom.min.js" type="text/javascript"></script>
    <script src="${ctx}/js/jquery.portlet.pack.js?v=1.3.1"></script>
    <script>
        //初始化
        var def = "1";
        function mover(object) {
            //主菜单
            var mm = document.getElementById("m_" + object);
            mm.className = "m_li_a";
            //初始主菜单先隐藏效果
            if (def != 0) {
                var mdef = document.getElementById("m_" + def);
                mdef.className = "m_li";
            }
            //子菜单
            var ss = document.getElementById("s_" + object);
            ss.style.display = "block";
            //初始子菜单先隐藏效果
            if (def != 0) {
                var sdef = document.getElementById("s_" + def);
                sdef.style.display = "none";
            }
        }

        function mout(object) {
            //主菜单
            var mm = document.getElementById("m_" + object);
            mm.className = "m_li";
            //初始主菜单还原效果
            if (def != 0) {
                var mdef = document.getElementById("m_" + def);
                mdef.className = "m_li_a";
            }
            //子菜单
            var ss = document.getElementById("s_" + object);
            ss.style.display = "none";
            //初始子菜单还原效果
            if (def != 0) {
                var sdef = document.getElementById("s_" + def);
                sdef.style.display = "block";
            }
        }
    </script>
</head>
<body>
<div class="top">
    <div class="fl logo"><a href="#"><img src="images/logo.png" alt=""/></a></div>
    <div class="wrap">
        <div class="user_mes">
            <span>今天是<fmt:formatDate value="<%=new Date()%>" pattern="MM月DD日"/>，欢迎您 老板（总经理）</span>
            <a href="${ctx}/system/index" class="frie">设置</a>
        </div>
        <div class="menu">

            <div id="menu">
                <ul class="nav">

                    <li id="m_1" class='m_li_a'><a href="javascript:void(0)">工作台</a></li>

                    <li id="m_2" class='m_li' onmouseover='mover(2);' onmouseout='mout(2);'><a href="#">市场营销</a></li>

                    <li id="m_3" class='m_li' onmouseover='mover(3);' onmouseout='mout(3);'><a href="#">客户管理</a></li>

                    <li id="m_4" class='m_li' onmouseover='mover(4);' onmouseout='mout(4);'><a href="#">项目管理</a></li>

                    <li id="m_5" class='m_li' onmouseover='mover(5);' onmouseout='mout(5);'><a href="#">订单管理</a></li>

                    <li id="m_6" class='m_li' onmouseover='mover(6);' onmouseout='mout(6);'><a href="#">财务管理</a></li>

                    <li id="m_7" class='m_li' onmouseover='mover(7);' onmouseout='mout(7);'><a href="#">销售管理</a></li>

                    <li id="m_8" class='m_li' onmouseover='mover(8);' onmouseout='mout(8);'><a href="#">报表管理</a></li>

                    <li id="m_9" class='m_li' onmouseover='mover(9);' onmouseout='mout(9);'><a href="#">销售管理</a></li>

                </ul>
            </div>
            <div>
                <ul class="smenu">
                    <li style="padding-left:29px;" id="s_1" class='s_li_a'>
                        <ul style="display:none;" class="second_nav">
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                        </ul>
                    </li>
                    <li style="padding-left:93px;" id="s_2" class='s_li' onmouseover='mover(2);' onmouseout='mout(2);'>
                        <ul class="second_nav">
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                        </ul>
                    </li>
                    <li style="padding-left:187px;" id="s_3" class='s_li' onmouseover='mover(3);' onmouseout='mout(3);'>
                        <ul class="second_nav">
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                        </ul>
                    </li>
                    <li style="padding-left:281px;" id="s_4" class='s_li' onmouseover='mover(4);' onmouseout='mout(4);'>
                        <ul class="second_nav">
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                        </ul>
                    </li>
                    <li style="padding-left:375px;" id="s_5" class='s_li' onmouseover='mover(5);' onmouseout='mout(5);'>
                        <ul class="second_nav">
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                        </ul>
                    </li>
                    <li style="padding-left:469px;" id="s_6" class='s_li' onmouseover='mover(6);' onmouseout='mout(6);'>
                        <ul class="second_nav">
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                        </ul>
                    </li>
                    <li style="padding-left:563px;" id="s_7" class='s_li' onmouseover='mover(7);' onmouseout='mout(7);'>
                        <ul class="second_nav">
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                        </ul>
                    </li>
                    <li style="padding-left:657px;" id="s_8" class='s_li' onmouseover='mover(8);' onmouseout='mout(8);'>
                        <ul class="second_nav">
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                        </ul>
                    </li>
                    <li style="padding-left:748px;" id="s_9" class='s_li' onmouseover='mover(9);' onmouseout='mout(9);'>
                        <ul class="second_nav lastnav">
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                            <li><a href="lby.html">市场营销</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<div class="clear"></div>
<div class="broad">
    <div class="fl nav_title"><span class="curve">当前位置：工作台 > </span></div>
    <div class="fr arrow">
        <script language="javascript">
            <!--
            function showmenu() {
                menu1.style.visibility = "visible";
            }
            function hidmenu() {
                menu1.style.visibility = "hidden";
            }
            document.onclick = hidmenu;
            -->
        </script>
        <a href="javascript:showmenu()" class="adds"><img src="images/adds.png" alt=""/></a>

        <div id="menu1">
            <a href="#">新增客户</a>
            <a href="#">新增联系人</a>
            <a href="#">新增联系记录</a>
            <a href="#">新增销售机会</a>
            <a href="#">新增报价单</a>
            <a href="#">新增合同订单</a>
            <a href="#">新增进货单</a>
        </div>
        <div class="tm"><a href=""><img src="images/talls.png" alt=""/></a><a href=""><img src="images/malls.png"
                                                                                           alt=""/></a></div>
    </div>
</div>
<div style="margin:20px;">

    <div id="portlet-demo"></div>
</div>
<div class="foot">
    <p>版权所有：</p>
</div>
<script>
    $(function () {
        $('#portlet-demo').portlet({
            sortable: true,
            columns: [
                {
                    width: 620,
                    portlets: [
                        {
                            attrs: {
                                id: 'feeds'
                            },
                            title: function () {
                                var d = new Date();
                                return 'portlet示例：日期(' + (d.getMonth() + 1) + '-' + d.getDate() + '日)' + '（高度：<span class="ui-state-error ui-corner-all">100</span>）';
                            },
                            content: {
                                //设置区域内容属性
                                style: {
                                    height: 100
                                },
                                type: 'text',
                                text: '<ul><li>Feed item 1</li><li>Feed item 2</li></ul>',
                                beforeShow: function (aa) {
                                    //alert('before show, content is: ' + aa);
                                },
                                afterShow: function () {
                                    //alert('after show');
                                }
                            },
                            scripts: ['loaded-by-portlet.js']
                        },
                        {
                            attrs: {
                                id: 'news'
                            },
                            title: function () {
                                return 'portlet示例' + '（高度：<span class="ui-state-error ui-corner-all">100</span>）';
                            },
                            beforeRefresh: function () {
                                alert("before refresh");
                            },
                            afterRefresh: function (data) {
                                //alert("after refresh: " + data);
                            },
                            content: {
                                style: {
                                    height: 100
                                },
                                type: 'text',
                                text: function () {
                                    return $('#newsTemplate').html();
                                    //return $('#newsTemplate ul');
                                }
                            }
                        }
                    ]
                },
                {
                    width: 620,
                    portlets: [
                        {
                            title: function () {
                                return 'portlet示例：动态加载' + '（高度：<span class="ui-state-error ui-corner-all">150</span>）';
                            },
                            content: {
                                style: {
                                    height: 150
                                },
                                type: 'ajax',
                                url: 'ajax.html'
                            }
                        },
                        {
                            title: function () {
                                return 'portlet示例 Json Datas' + '（高度：<span class="ui-state-error ui-corner-all">150</span>）';
                            },
                            content: {
                                style: {
                                    height: 150
                                },
                                type: 'ajax',
                                dataType: 'json',
                                url: 'ajax-fixed-height.json',
                                formatter: function (o, pio, data) {
                                    var ct = "<ul>";
                                    $.each(data, function () {
                                        ct += "<li>" + this.text + "</li>";
                                    });
                                    return ct + "</ul>";
                                }
                            }
                        }
                    ]
                }
            ]
        });
    });
</script>
</body>
</html>