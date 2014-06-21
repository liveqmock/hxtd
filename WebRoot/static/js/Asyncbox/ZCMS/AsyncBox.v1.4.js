/*
* AsyncBox v1.4 jQuery.Plugin
* Date : 2011-5-10
* Blog : http://wuxinxi007.cnblog.com
*/
var asyncbox = {
    //标题栏图标
    Icon: true,
    //静止定位
    Fixed: false,
    //动画效果
    Flash: false,
    //自动重设位置
    autoReset: false,
    //遮挡 select (ie6)
    inFrame: true,
    //初始索引值
    zIndex: 1999,
    //自适应最小宽度
    minWidth: 330,
    //自适应最大宽度
    maxWidth: 700,
    //拖动器
    Move: {
        //启用
        Enable: true,
        //限制在可视范围内
        Limit: true,
        //克隆
        Clone: true
    },
    //遮罩层
    Cover: {
        //透明度
        opacity: 0.1,
        //背景颜色
        background: '#000'
    },
    //加载器
    Wait: {
        //启用
        Enable: true,
        //提示文本
        text: '加载中...'
    },
    //按钮文本
    Language: {
        //action 值 ok
        OK: '确　定',
        //action 值 no
        NO: '　否　',
        //action 值 yes
        YES: '　是　',
        //action 值 cancel
        CANCEL: '取　消',
        //action 值 close
        CLOSE: '关闭'
    }
};
(function (a) {
    function R(b, c, d) {
        var e = n("asynctips_" + c);
        e ? n("asynctips_" + c + "_content").innerHTML = b : (a("body").append(['<div id="asynctips_', c, '" class="asynctips">', '<table border="0" cellspacing="0" cellpadding="0">', "<tr>", '<td class="asynctips_left"></td>', '<td class="asynctips_', c, '"><span></span></td>', '<td class="asynctips_middle" id="asynctips_' + c + '_content">', b, "</td>", '<td class="asynctips_right"></td>', "</tr>", "</table>", "</div>"].join("")), e = n("asynctips_" + c)),
        Q(e),
        setTimeout(function () {
            a(e).animate({
                top: o().top,
                opacity: 0
            },
            function () {
                a(this).remove()
            })
        },
        d || 1500)
    }
    function Q(a) {
        var b = o(),
        d = b.height * .382 - a.offsetHeight / 2,
        e = b.left + (b.width - a.offsetWidth) / 2;
        a.style.top = b.top + d + "px",
        a.style.left = e + "px",
        c.Fixed && N(a)
    }
    function P(b, c, d, f) {
        var g = e + f,
        h = {
            id: g,
            icon: g,
            title: c,
            content: b,
            layout: e + "auto",
            callback: d
        };
        if (f == "alert" || "success" || "error") h.btnsbar = a.btn.OK;
        switch (f) {
            case "confirm":
                h.btnsbar = a.btn.OKCANCEL;
                break;
            case "warning":
                h.btnsbar = a.btn.YESNOCANCEL
        }
        q(h)
    }
    function O(b, c, d) {
        return a.grep(b,
        function (a) {
            return d ? a[d] != c : a != c
        })
    }
    function N(a) {
        l.fixed(a, o())
    }
    function J(b) {
        var c = new Object;
        c.id = b.id,
        c.top = b.top,
        c.right = b.right,
        c.bottom = b.bottom,
        c.left = b.left,
        c.flash = b.flash,
        k.push(c),
        k.length > 0 && !f && (a(window).bind("resize", M), f = !0)
    }
    function I(a) {
        H(a, null, !1),
        c.autoReset && a.autoReset && J(a),
        m && c.Fixed && N(n(a.id))
    }
    function H(a, b, d) {
        var e = b || o();
        if (e.x > e.width || e.y > e.height) e = o();
        var f = a.id,
        g = n(f),
        h = g.style,
        i = g.offsetHeight > e.height / 2 ? (e.height - g.offsetHeight) / 2 : e.height * .382 - g.offsetHeight / 2,
        j = pt = !m && c.Fixed ? i : e.top + i,
        k = e.width - g.offsetWidth,
        l = pl = !m && c.Fixed ? k / 2 : e.left + k / 2; !m && c.Fixed ? (a.top >= 0 && (j = a.top), a.right >= 0 && (l = k - a.right), a.bottom >= 0 && (j = e.height - g.offsetHeight - a.bottom), a.left >= 0 && (l = a.left)) : (a.top >= 0 && (j = e.top + a.top), a.right >= 0 && (l = e.left + k - a.right), a.bottom >= 0 && (j = e.top + e.height - g.offsetHeight - a.bottom), a.left >= 0 && (l = e.left + a.left)),
        j = j <= 0 ? 0 : j,
        l = l <= 0 ? 0 : l,
        d ? y(g, {
            top: j,
            left: l
        }) : (h.top = j + "px", h.left = l + "px")
    }
    function G(b) {
        var d = b.id,
        f = n(d),
        g = f.style,
        h = o();
        if (b.pageMode || b.htmlMode) {
            b.width != "auto" && (g.width = b.width + "px"),
            b.height != "auto" && (g.height = b.height + "px");
            var i = a("#" + d + "_content");
            b.width > 0 && b.htmlMode && i.width(b.width - a("#" + d + "_left").outerWidth() - a("#" + d + "_right").outerWidth()),
            b.height > 0 && i.height(b.height - a("#" + d + "_header").outerHeight() - a("#" + d + "_tipsbar").outerHeight() - a("#" + d + "_btnsbar").outerHeight() - a("#" + d + "_bottom").outerHeight()),
            F(b)
        } else f.offsetWidth < c.minWidth && !b.inputMode ? (f.className = e + "normal", g.width = c.minWidth + "px") : f.offsetWidth > c.maxWidth && (f.className = e + "normal", g.width = c.maxWidth + "px"),
        f.offsetHeight > h.height && a.size(b.id, f.offsetWidth, h.height);
        g.width = f.offsetWidth + "px"
    }
    function F(b) {
        c.Wait.Enable && b.pageMode && a("#" + b.id + "_content").one("load",
        function () {
            a("#" + b.id + "_wait").remove()
        })
    }
    function E(a) {
        G(a),
        I(a),
        c.Fixed && N(n(a.id))
    }
    function D(b) {
        var c = n(b),
        d = a.iframe(b);
        if (c) {
            c.src = "about:blank";
            try {
                d.doc.write(""),
                d.doc.clear(),
                d.doc.close()
            } catch (e) { }
        }
    }
    function C(a) {
        var c = n(a);
        if (j.length > 0) for (b in j) if (b = a) c.innerHTML = "",
        j = O(j, a),
        j.length == 0 && (j = [])
    }
    function B(b) {
        var c,
        d = a.btn.CLOSE.concat(b.btnsbar);
        a.each(d,function (d, e) {
            a("#" + b.id + "_" + e.action).click(function (d) {
                this.disabled = !0,
                b.inputMode ? c = b.callback(e.action, n(b.id + "_Text").value) : b.pageMode ? c = b.callback(e.action, a.box(b.id), a.returnValue) : b.htmlMode ? c = b.callback(e.action, a.returnValue) : c = b.callback(e.action);
                if (typeof c == "undefined" || c) b.pageMode && b.closeType != "hide" && D(b.id + "_content"),
                a.close(b.id, b.closeType);
                this.disabled = !1,
                d.preventDefault()
            })
        })
    }
    function A(b) {
        b.inputMode ? a("#" + b.id + "_Text").focus().select() : a("#" + b.id + "_Focus").focus().remove()
    }
    function z(b) {
        if (b.btnsbar) {
            var c = [];
            a.each(b.btnsbar,
            function (a, d) {
                c.push('<a id="', b.id, "_", d.action, '"class="', e, 'btn"', m ? 'href="javascript:void(0)"' : "", "><span>&nbsp;", d.text, "&nbsp;</span></a>")
            });
            return c.join("")
        }
    }
    function y(b, d) {
        a(b).animate(d, 300,
        function () {
            m && c.Fixed && N(b)
        })
    }
    function x(b) {
        var d = b.pageMode || b.htmlMode ? "b_m_m" : "a_m_m",
        f = b.pageMode || b.htmlMode ? "b_btnsbar_m" : "a_btnsbar_m",
        g = "";
        b.data && (typeof b.data == "string" ? g = "?" + b.data : g = "?" + a.param(b.data));
        return [c.inFrame && b.pageMode || b.htmlMode ? '<!--[if IE 6]><iframe class="' + e + 'select"></iframe><![endif]-->' : "", b.inputMode ? "" : '<input id="' + b.id + '_Focus" type="button" style="position:absolute;z-index:-5">', '<table class="' + e + 'table" border="0" cellspacing="0" cellpadding="0">', "<tbody>", "<tr>", '<td class="b_t_l" id="' + b.id + '_left"></td>', '<td class="b_t_m" id="' + b.id + '_header">', '<div class="' + e + 'title">', "<ul>", c.Icon ? '<li class="' + e + 'title_icon"></li>' : "", '<li class="' + e + 'title_tips"><strong>', b.title, "&nbsp;</strong></li>", '<li style="padding-left:30px">', '<a id="' + b.id + '_close" class="' + e + 'close" href="javascript:void(0)" title="' + c.Language.CLOSE + '">' + c.Language.CLOSE + "</a>", "</li>", "</ul>", "</div>", "</td>", '<td class="b_t_r" id="' + b.id + '_right"></td>', "</tr>", b.tipsbar ? '<tr><td class="b_tipsbar_l"></td><td class="b_tipsbar_m" id="' + b.id + '_tipsbar" valign="top">' + '<div class="b_tipsbar_layout"><ul><li class="b_tipsbar_title">' + b.tipsbar.title + "</li>" + '<li class="b_tipsbar_content">' + b.tipsbar.content + '</li></ul></div></td><td class="b_tipsbar_r"></td></tr>' : "", "<tr>", '<td class="b_m_l"></td>', '<td class="' + d + '">', b.pageMode ? "" : b.inputMode ? '<div class="' + e + 'prompt">' + "<ul>" + "<li>" + b.inputMode.tips + "</li>" + "<li>" + (b.textType == "text" ? '<input type="text" id="' + b.id + '_Text" value="' + b.inputMode.content + '" size="60" />' : "") + (b.textType == "textarea" ? '<textarea cols="60" rows="10" id="' + b.id + '_Text">' + b.inputMode.content + "</textarea>" : "") + (b.textType == "password" ? '<input type="password" id="' + b.id + '_Text" value="' + b.inputMode.content + '" size="40" />' : "") + "</li>" + "</ul>" + "</div>" : b.htmlMode ? '<div id="' + b.id + '_content" style="overflow:' + (b.scrolling == "yes" || b.scrolling == "auto" ? "auto" : "hidden") + '">' + b.html + "</div>" : '<div id="' + b.id + '_content" style="overflow:hidden;overflow-y:auto"><div class="' + b.icon + '"><span></span>' + b.content + "</div</div>", b.pageMode ? '<iframe frameborder="0" id="' + b.id + '_content" name="' + b.id + '_content" width="100%" src="' + b.url + g + '" scrolling="' + b.scrolling + '"></iframe>' : "", "</td>", '<td class="b_m_r"></td>', "</tr>", b.btnsbar ? '<tr><td class="b_btnsbar_l"></td><td class="' + f + '" id="' + b.id + '_btnsbar">' + '<div class="' + e + 'btn_layout">' + z(b) + '</div></td><td class="b_btnsbar_r"></td></tr>' : "", "<tr>", '<td class="b_b_l"></td>', '<td id="' + b.id + '_bottom" class="b_b_m"></td>', '<td class="b_b_r"></td>', "</tr>", "</tbody>", "</table>", c.Wait.Enable && b.pageMode ? '<div class="' + e + 'wait" id="' + b.id + '_wait"><span></span>' + c.Wait.text + "</div>" : ""].join("")
    }
    function w(b) {
        b.modal && (h.push(c.zIndex), i.push(b.id), a.cover(!0, c.zIndex))
    }
    function v(a, b) {
        var d = n(e + "focus"),
        f = d.style;
        a ? a.pageMode && !c.Move.Clone && b && (f.display = "block") : f.display = "none"
    }
    function u(b) {
        function A() {
            v(!1),
            c.Move.Clone && (c.Flash ? y(g, {
                top: el.offsetTop,
                left: el.offsetLeft
            }) : (h.top = el.offsetTop + "px", h.left = el.offsetLeft + "px"), x.display = "none"),
            m && c.Fixed && N(g),
            el.releaseCapture ? (el.releaseCapture(), el.onmousemove = null, el.onmouseup = null) : a(d).unbind("mousemove", z).unbind("mouseup", A)
        }
        function z(a) {
            t = a.clientX - r,
            u = a.clientY - s,
            c.Move.Limit && (t <= l ? t = l : t >= q && (t = q), u <= k ? u = k : u >= p && (u = p)),
            els.top = u + "px",
            els.left = t + "px"
        }
        var f = b.id,
        g = el = n(f),
        h = els = el.style,
        i,
        j,
        k,
        l,
        p,
        q,
        r,
        s,
        t,
        u,
        w = n(e + "clone"),
        x = w.style;
        a("#" + f + "_header").mousedown(function (e) {
            e.which == 1 && e.target.tagName != "A" && (i = o(), v(b, !0), el = g, els = g.style, j = {
                top: el.offsetTop,
                left: el.offsetLeft,
                width: el.offsetWidth,
                height: el.offsetHeight
            },
            c.Move.Clone && (!m && c.Fixed && (x.position = "fixed"), x.top = j.top + "px", x.left = j.left + "px", x.width = j.width - 2 + "px", x.height = j.height - 2 + "px", x.display = "block", el = w, els = w.style), r = e.clientX - j.left, s = e.clientY - j.top, c.Move.Limit && (!m && c.Fixed ? (k = l = 0, p = i.height - j.height, q = i.width - j.width) : (k = i.top, l = i.left, p = i.height + k - j.height, q = i.width + l - j.width)), el.setCapture ? (el.setCapture(), el.onmousemove = function (a) {
                z(a || event)
            },
            el.onmouseup = A) : a(d).bind("mousemove", z).bind("mouseup", A), e.preventDefault())
        })
    }
    function t(b) {
        if (r()) {
            var d = b.id,
            e = n(d);
            e ? (w(b), e.style.zIndex = c.zIndex++, e.style.visibility = "visible") : (j.push(b.id), w(b), a("body").append("<div id=" + d + " class=" + b.layout + ' style="top:0;z-index:' + c.zIndex++ + '">' + x(b) + "</div>"), E(b), A(b), B(b), a("#" + d).mousedown(function (a) {
                a.which == 1 && (this.style.zIndex = c.zIndex++)
            }), c.Move.Enable && b.drag && u(b))
        }
    }
    function r() {
        var a = document.getElementsByTagName("script"),
        b = !1;
        for (s in a) {
            var c,
            d = a[s].src;
            if (d) {
                c = d.toLowerCase().substring(d.lastIndexOf("/") + 1);
                if (b = c.indexOf("asyncbox") >= 0 ? !0 : !1) break
            }
        }
        return b
    }
    function q(b) {
        t(a.extend({
            title: "AsyncBox",
            content: "",
            top: -1,
            right: -1,
            bottom: -1,
            left: -1,
            width: "auto",
            height: "auto",
            layout: e + "auto",
            tipsbar: !1,
            btnsbar: !1,
            pageMode: !1,
            htmlMode: !1,
            inputMode: !1,
            drag: !0,
            flash: !0,
            modal: !0,
            autoReset: !0,
            scrolling: "no",
            callback: function () { }
        },
        b))
    }
    function p() {
        a("body").append(['<div id="' + e + 'cover" unselectable="on" style="opacity:', c.Cover.opacity, ";filter:alpha(opacity=", c.Cover.opacity * 100, ");background:", c.Cover.background, '">', "<div><iframe></iframe></div><div></div>", '<div id="' + e + 'clone"></div>', '<div id="' + e + 'focus"></div>', '<div id="' + e + 'load"><div><span></span></div></div>'].join(""))
    }
    function o() {
        var a = d.body,
        b = d.documentElement;
        return {
            x: Math.max(a.scrollWidth, b.clientWidth),
            y: Math.max(a.scrollHeight, b.clientHeight),
            top: Math.max(b.scrollTop, a.scrollTop),
            left: Math.max(b.scrollLeft, a.scrollLeft),
            width: b.clientWidth,
            height: b.clientHeight
        }
    }
    function n(a) {
        return d.getElementById(a)
    }
    var c = asyncbox,
    d = document,
    e = "asyncbox_",
    f = !1,
    g = !1,
    h = [],
    i = [],
    j = [],
    k = [],
    l,
    m = !!window.ActiveXObject && !window.XMLHttpRequest;
    a(function () {
        p(),
        c.Fixed && (m && a("body").css("backgroundAttachment") !== "fixed" && a("html").css({
            backgroundImage: "url(about:blank)",
            backgroundAttachment: "fixed"
        }), l = l)
    }),
    l = {
        fixed: m ?
        function (a, b) {
            var c = a.style,
            d = "document.documentElement",
            e = a.offsetTop - b.top,
            f = a.offsetLeft - b.left;
            this.absolute(a),
            c.setExpression("top", "eval(" + d + ".scrollTop + " + e + ') + "px"'),
            c.setExpression("left", "eval(" + d + ".scrollLeft + " + f + ') + "px"')
        } : function (a) {
            a.style.position = "fixed"
        },
        absolute: m ?
        function (a) {
            var b = a.style;
            b.position = "absolute",
            b.removeExpression("left"),
            b.removeExpression("top")
        } : function (a) {
            a.style.position = "absolute"
        }
    };
    var K,
    L,
    M = function () {
        K && clearTimeout(K),
        f && (L = o(), K = setTimeout(function () {
            a.each(k,
            function (a) {
                var b = {},
                d = k[a];
                b.id = d.id,
                b.top = d.top,
                b.left = d.left,
                b.right = d.right,
                b.bottom = d.bottom,
                c.Flash && d.flash ? H(b, L, !0) : H(b, L, !1)
            }),
            clearTimeout(K)
        },
        100))
    };
    a.btn = {
        OK: [{
            text: c.Language.OK,
            action: "ok"
        }],
        NO: [{
            text: c.Language.NO,
            action: "no"
        }],
        YES: [{
            text: c.Language.YES,
            action: "yes"
        }],
        CLOSE: [{
            title: c.Language.CLOSE,
            action: "close"
        }],
        CANCEL: [{
            text: c.Language.CANCEL,
            action: "cancel"
        }]
    },
    a.btn.OKCANCEL = a.btn.OK.concat(a.btn.CANCEL),
    a.btn.YESNO = a.btn.YES.concat(a.btn.NO),
    a.btn.YESNOCANCEL = a.btn.YES.concat(a.btn.NO).concat(a.btn.CANCEL),
    a.cover = function (b, d) {
        var f = a("#" + e + "cover"),
        i = n(e + "cover").style;
        b ? (g = b, i.zIndex = d || c.zIndex, c.Flash ? f.fadeTo(500, c.Cover.opacity) : f.show()) : (g = b, c.Flash ? f.fadeOut(300) : f.hide(), h = [])
    },
    a.close = function (c, d) {
        var e = n(c);
        if (e) {
            e.style.visibility = "hidden",
            d != "hide" && (j.length > 0 && C(c), k.length > 0 && (k = O(k, c, "id")), a("#" + c).remove()),
            f && k.length == 0 && (a(window).unbind("resize", M), f = !1, k = []);
            if (g) for (b in i) i[b] == c && (i = O(i, c), h.length > 1 && i.length != 0 ? (h.pop(), a.cover(!0, h[h.length - 1])) : a.cover(!1))
        }
    },
    a.size = function (a, b, d) {
        var e = n(a);
        if (e && e.offsetWidth != b || e.offsetHeight != d) {
            var f = {
                id: e.id,
                width: b,
                height: d,
                pageMode: !0,
                htmlMode: !0
            };
            G(f),
            I(f),
            m && c.Fixed && N(e)
        }
    },
    a.iframe = function (a) {
        return n(a).contentWindow
    },
    a.box = function (b) {
        return a.iframe(b + "_content")
    },
    a.reload = function (b, c) {
        var d = n(b + "_content");
        try {
            d.src = c || a.box(b).location.href
        } catch (e) {
            d.src = d.src
        }
    },
    a.asyncbox = function (a) {
        var b = n(a);
        return b && b.style.visibility != "hidden" && b.style.display != "none" ? !0 : !1
    },
    a.alert = c.alert = function (a, b, c) {
        P(a, b, c, "alert")
    },
    a.confirm = c.confirm = function (a, b, c) {
        P(a, b, c, "confirm")
    },
    a.prompt = c.prompt = function (b, c, d, f, g) {
        var h = {
            id: e + "prompt",
            title: b,
            inputMode: {
                tips: c || "",
                content: d || ""
            },
            textType: f,
            btnsbar: a.btn.OKCANCEL,
            callback: g
        };
        q(h)
    },
    a.open = c.open = function (a) {
        a.id = a.id || e + c.zIndex,
        a.url ? a.pageMode = !0 : a.html && (a.htmlMode = !0),
        a.width && (a.layout = e + "normal"),
        q(a)
    },
    a.success = c.success = function (a, b, c) {
        P(a, b, c, "success")
    },
    a.warning = c.success = function (a, b, c) {
        P(a, b, c, "warning")
    },
    a.error = c.error = function (a, b, c) {
        P(a, b, c, "error")
    },
    a.tips = c.tips = function (a, b, c) {
        R(a, b || "alert", c)
    }
})(jQuery)