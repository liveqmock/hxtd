/*
 * jquery.portlet 1.3.1
 *
 * Copyright (c) 2012~2013
 *   咖啡兔 (http://www.kafeitu.me)
 *
 * Dual licensed under the GPL (http://www.gnu.org/licenses/gpl.html)
 * and MIT (http://www.opensource.org/licenses/mit-license.php) licenses.
 *
 * Demo: http://www.kafeitu.me/demo/jquery-ui-portlet
 * Github: https://github.com/henryyan/jquery-ui-portlet
 */
(function($, m) {
    $.widget("ui.portlet", {
        options: {
            columns: [],
            sortable: true,
            singleView: true,
            removeItem: null,
            filterRepeat: false,
            columnWidth: 300,
            events: {
                drag: {
                    start: null,
                    stop: null,
                    over: null
                }
            }
        },
        _create: function() {
            this.element.addClass("ui-portlet");
            var f = this;
            var g = f.element;
            var o = f.options;
            if (!o.columns || o.columns.length == 0) {
                $('<div/>', {
                    width: o.columnWidth
                }).addClass('ui-portlet-column').appendTo(g)
            }
            $.each(o.columns, 
            function(d, c) {
                var e = $('<div/>', {
                    width: c.width
                }).addClass('ui-portlet-column').appendTo(g);
                $.each(c.portlets, 
                function(a, b) {
                    f._createSinglePortlet(f, g, e, 'last', b)
                })
            });
            f._initEvents();
            if (o.singleView === true) {
                f._regSingleView()
            }
            f._sortable(o.sortable)
        },
        _createSinglePortlet: function(b, c, d, e, f) {
            var o = b.options;
            if (o.filterRepeat === true) {
                if (f.attrs.id) {
                    if ($('#' + f.attrs.id).length > 0) {
                        if ($.isFunction(o.handleRepeat)) {
                            var g = o.handleRepeat.call(c, d, f);
                            if (g === false) {
                                return
                            }
                        } else {
                            return
                        }
                    }
                }
            }
            if ($.isFunction(f.beforeCreate)) {
                var g = f.beforeCreate.call(c, e);
                if (!g) {
                    return
                }
            }
            var h = $('<div/>').addClass('ui-portlet-item ui-widget ui-widget-content ui-helper-clearfix ui-corner-all').data('option', f);
            if (e === 'last') {
                h.appendTo(d)
            } else {
                if (e.x === 'last') {
                    h.insertAfter($(d).find('.ui-portlet-item:last'))
                } else {
                    h.insertBefore($(d).find('.ui-portlet-item').eq(e.x))
                }
            }
            if (f.attrs) {
                h.attr(f.attrs)
            }
            var i = $('<div/>', {
                'class': 'ui-portlet-header ui-widget-header ui-corner-all',
                html: function() {
                    if ($.isFunction(f.title)) {
                        return f.title
                    }
                    if (f.icon) {
                        return "<span class='" + f.icon + "'></span>" + f.title
                    } else {
                        return f.title
                    }
                }
            }).appendTo(h);
            if (f.icon) {
                i.prepend("<span class='ui-portlet-header-icon ui-icon " + f.icon + "'></span>")
            }
            i.prepend("<a href='#' class='ui-corner-all ui-portlet-event'><span class='ui-icon ui-icon-refresh ui-portlet-refresh'></span></a>");
            i.prepend("<a href='#' class='ui-corner-all ui-portlet-event'><span class='ui-icon ui-icon-minusthick ui-portlet-toggle'></span></a>");
            i.prepend("<a href='#' class='ui-corner-all ui-portlet-event'><span class='ui-icon ui-icon-closethick ui-portlet-close'></span></a>");
            var j = $('<div/>', {
                'class': 'ui-portlet-content'
            }).appendTo(h);
            if (f.content.style) {
                $(j).css(f.content.style)
            }
            if (f.content.attrs) {
                $.each(f.content.attrs, 
                function(k, v) {
                    var a = j.attr(k);
                    if (a) {
                        if (k == 'style' && v.substr(v.length - 1) != ';') {
                            a += ';'
                        }
                        if (k == 'class') {
                            a += ' '
                        }
                        a += v
                    }
                    j.attr(k, a)
                })
            }
            b._content.call(c, h, f, 
            function(a) {
                b._loadScripts(f.scripts, 
                function() {
                    if ($.isFunction(f.afterLoadContent)) {
                        f.afterLoadContent.call(h, h.find('.ui-portlet-content'))
                    }
                })
            });
            if ($.isFunction(f.afterCreated)) {
                f.afterCreated.call(c)
            }
            return h
        },
        _setOption: function(a, b) {
            var c = this.element;
            var o = this.options;
            if (this.options[a]) {
                this.options[a] = b
            }
            switch (a) {
            case "sortable":
                this._sortable(b);
                break;
            case "add":
                this._addSingle(b);
                break;
            case "remove":
                $(b, c).find('.ui-portlet-close').trigger('click');
                break;
            case "filterRepeat":
                if (b == null || b == m) {
                    return o.filterRepeat
                } else {
                    o.filterRepeat = b;
                    break
                }
            }
        },
        index: function(a, b) {
            var c = this.element;
            var d = {};
            $('.ui-portlet-column').each(function(i, v) {
                $('.ui-portlet-item', this).each(function(j, a) {
                    var b = $(this).attr('id');
                    d[b] = {
                        x: i,
                        y: j
                    }
                })
            });
            return d
        },
        _regSingleView: function() {
            var c = this.element;
            $(c).find('.ui-portlet-header').dblclick(function() {
                var a = $(this).parents('.ui-portlet-item');
                var p = a.data('option');
                if (a.hasClass('ui-portlet-single-view')) {
                    $(c).find('.ui-portlet-item').show();
                    a.removeClass('ui-portlet-single-view').animate({
                        width: a.data('width'),
                        height: 'auto'
                    }).css({
                        position: 'static'
                    }).removeData('width').removeData('height');
                    if (p.singleView) {
                        if ($.isFunction(p.singleView.recovery)) {
                            p.singleView.recovery.call(a, p)
                        }
                    }
                } else {
                    $(c).find('.ui-portlet-item').hide();
                    a.show().addClass('ui-portlet-single-view').data({
                        width: a.width(),
                        height: a.height()
                    }).css({
                        position: 'absolute',
                        left: 0,
                        top: 0
                    });
                    var b = {};
                    if (p.singleView) {
                        if (p.singleView.width) {
                            if ($.isFunction(p.singleView.width)) {
                                b.width = p.singleView.width.call(a, p)
                            } else {
                                b.width = p.singleView.width
                            }
                        }
                        if (p.singleView.height) {
                            if ($.isFunction(p.singleView.height)) {
                                b.height = p.singleView.height.call(a, p)
                            } else {
                                b.height = p.singleView.height
                            }
                        }
                    } else {
                        b.width = $(c).width() + 14
                    }
                    a.animate({
                        width: b.width,
                        height: b.height
                    });
                    if (p.singleView && $.isFunction(p.singleView.enable)) {
                        p.singleView.enable.call(a, p)
                    }
                }
            })
        },
        _loadScripts: function(b, c) {
            if (b) {
                $.each(b, 
                function() {
                    var a = $('head').remove('#loadScript');
                    $("<script>" + "</script>").attr({
                        src: this,
                        type: 'text/javascript',
                        id: 'loadScript'
                    }).appendTo(a)
                })
            }
            if ($.isFunction(c)) {
                c()
            }
        },
        _sortable: function(c) {
            var o = this.options;
            var d = $(".ui-portlet-column", this.element).sortable({
                connectWith: ".ui-portlet-column",
                start: function(a, b) {
                    if ($.isFunction(o.events.drag.start)) {
                        o.events.drag.start.call(b.item[0], a, b)
                    }
                },
                stop: function(a, b) {
                    if ($.isFunction(o.events.drag.stop)) {
                        o.events.drag.stop.call(b.item[0], a, b)
                    }
                },
                over: function(a, b) {
                    if ($.isFunction(o.events.drag.over)) {
                        o.events.drag.over.call(b.item[0], a, b)
                    }
                }
            });
            if (c === true) {
                $(this.element).find('.ui-portlet-header').css('cursor', 'move');
                d.sortable('enable');
                $(".ui-portlet-content", this.element).draggable({
                    start: function(e, a) {
                        return false
                    }
                })
            } else {
                $(this.element).find('.ui-portlet-header').css('cursor', 'default');
                d.sortable('disable')
            }
        },
        _addSingle: function(a) {
            var b = this;
            var c = b.element;
            var o = this.options;
            var d = a;
            var e;
            if ($('.ui-portlet-column', c).eq(d.position.y).length > 0) {
                e = $('.ui-portlet-column', c).eq(d.position.y)
            } else {
                e = $('.ui-portlet-column', c).eq(0)
            }
            console.log(e);
            var f = b._createSinglePortlet(b, c, e, a.position, a.portlet);
            b._initEvents(f);
            if (o.singleView === true) {
                b._regSingleView()
            }
            b._sortable(o.sortable)
        },
        _initEvents: function(d) {
            var e = this;
            var f = d || this.element;
            var g = $(".ui-portlet-toggle", f).click(function(a, b) {
                var c = $(this).parents(".ui-portlet-item:first").find(".ui-portlet-content");
                b = b || 'toggle';
                if (b == 'toggle') {
                    c.slideToggle();
                    $(this).toggleClass("ui-icon-minusthick").toggleClass("ui-icon-plusthick")
                } else if (b == 'hide') {
                    c.slideUp();
                    $(this).removeClass("ui-icon-minusthick").addClass("ui-icon-plusthick")
                } else if (b == 'show') {
                    c.slideDown();
                    $(this).removeClass("ui-icon-plusthick").addClass("ui-icon-minusthick")
                }
            }).dblclick(function(a) {
                a.stopPropagation()
            });
            var h = $(".ui-portlet-refresh", f).click(function(a) {
                e.refresh.call(e, a)
            }).dblclick(function(a) {
                a.stopPropagation()
            });
            var i = $(".ui-portlet-close", f).click(function(a) {
                e._destoryItem.call(e, a)
            }).dblclick(function(a) {
                a.stopPropagation()
            });
            this._hoverable(g.parent());
            this._hoverable(h.parent())
        },
        _hoverable: function(a) {
            $(a).hover(function() {
                $(this).addClass('ui-state-hover')
            },
            function() {
                $(this).removeClass('ui-state-hover')
            })
        },
        _destoryItem: function(a) {
            var o = this.options;
            var b = $(a.target).parents('.ui-portlet-item');
            var c = b.data('option');
            if ($.isFunction(c.beforeRemove)) {
                var d = c.beforeRemove();
                if (!d) {
                    return
                }
            }
            b.remove();
            if ($.isFunction(o.removeItem)) {
                o.removeItem()
            }
        },
        refresh: function(b) {
            var o = this.options;
            var c = $(b.target).parents('.ui-portlet');
            var d = $(b.target).parents('.ui-portlet-item');
            var e = d.data('option');
            var f = d.find('.ui-portlet-content');
            var g = d.parents('.ui-portlet');
            if ($.isFunction(e.beforeRefresh)) {
                e.beforeRefresh.call(g, e)
            }
            this._content.call(c, d, e, 
            function(a) {
                if ($.isFunction(e.afterRefresh)) {
                    e.afterRefresh.call(g, a, e)
                }
            });
            this._loadScripts(e.scripts)
        },
        _content: function(e, f, g) {
            var o = this.options;
            var h = this;
            var i = f.content.type;
            var j = null;
            var k = e.find('.ui-portlet-content');
            if ($.isFunction(f.content.beforeShow)) {
                f.content.beforeShow.call(this, f.content.text)
            }
            if (i == 'text') {
                j = f.content.text;
                if ($.isFunction(j)) {
                    j = j(h, e, f)
                }
                if ($.isFunction(g)) {
                    g.call(h, j)
                }
                k.html(j);
                _callAfterShow(f.content.text)
            } else if (i == 'ajax') {
                var l = f.content.dataType || 'html';
                $.ajax({
                    url: f.content.url,
                    dataType: l,
                    beforeSend: function() {
                        $(k).html('Loading...')
                    },
                    success: function(a, b, c) {
                        if (l == 'html') {
                            j = a;
                            $(k).html(a)
                        } else if (l == 'json') {
                            if ($.isFunction(f.content.formatter)) {
                                j = f.content.formatter(o, f, a);
                                $(k).html(j)
                            }
                        }
                        _callAfterShow(j);
                        if ($.isFunction(g)) {
                            g.call(h, a)
                        }
                    },
                    error: function(a, b, c) {
                        var d = "<span style='padding:0.2em' class='ui-state-error ui-corner-all'>Load Error...</span>";
                        $(k).html(d);
                        if ($.isFunction(f.content.error)) {
                            f.content.error.call(k, a, b, c)
                        }
                    }
                })
            }
            function _callAfterShow(a) {
                if ($.isFunction(f.content.afterShow)) {
                    f.content.afterShow.call(h, a)
                }
            }
        },
        toggle: function(a, b) {
            var c = this.element;
            $('#' + a + ' .ui-portlet-toggle', c).trigger('click', [b || 'toggle'])
        },
        toggleAll: function(a) {
            var b = this.element;
            $('.ui-portlet-toggle', b).trigger('click', [a || 'toggle'])
        },
        destroy: function() {
            this.element.removeClass("ui-portlet").text("");
            $.Widget.prototype.destroy.call(this);
            return this
        }
    })
})(jQuery);
//eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('(6($,m){$.1b("2.5",{E:{19:[],K:P,r:P,1v:W,13:1D,1V:2q,L:{J:{10:W,1n:W,1o:W}}},2L:6(){7.u.G("2-5");4 f=7;4 g=f.u;4 o=f.E;3(!o.19||o.19.1m==0){$(\'<Y/>\',{s:o.1V}).G(\'2-5-I\').S(g)}$.N(o.19,6(d,c){4 e=$(\'<Y/>\',{s:c.s}).G(\'2-5-I\').S(g);$.N(c.2R,6(a,b){f.1C(f,g,e,\'1k\',b)})});f.1K();3(o.r===P){f.1J()}f.1h(o.K)},1C:6(b,c,d,e,f){4 o=b.E;3(o.13===P){3(f.V.17){3($(\'#\'+f.V.17).1m>0){3($.9(o.27)){4 g=o.27.n(c,d,f);3(g===1D){D}}t{D}}}}3($.9(f.2b)){4 g=f.2b.n(c,e);3(!g){D}}4 h=$(\'<Y/>\').G(\'2-5-w 2-1b 2-1b-8 2-2v-2z 2-R-M\').T(\'1f\',f);3(e===\'1k\'){h.S(d)}t{3(e.x===\'1k\'){h.2x($(d).A(\'.2-5-w:1k\'))}t{h.2G($(d).A(\'.2-5-w\').18(e.x))}}3(f.V){h.16(f.V)}4 i=$(\'<Y/>\',{\'B\':\'2-5-U 2-1b-U 2-R-M\',H:6(){3($.9(f.1a)){D f.1a}3(f.q){D"<C B=\'"+f.q+"\'></C>"+f.1a}t{D f.1a}}}).S(h);3(f.q){i.1d("<C B=\'2-5-U-q 2-q "+f.q+"\'></C>")}i.1d("<a 1I=\'#\' B=\'2-R-M 2-5-1A\'><C B=\'2-q 2-q-Z 2-5-Z\'></C></a>");i.1d("<a 1I=\'#\' B=\'2-R-M 2-5-1A\'><C B=\'2-q 2-q-1e 2-5-F\'></C></a>");i.1d("<a 1I=\'#\' B=\'2-R-M 2-5-1A\'><C B=\'2-q 2-q-2E 2-5-1w\'></C></a>");4 j=$(\'<Y/>\',{\'B\':\'2-5-8\'}).S(h);3(f.8.1g){$(j).12(f.8.1g)}3(f.8.V){$.N(f.8.V,6(k,v){4 a=j.16(k);3(a){3(k==\'1g\'&&v.2W(v.1m-1)!=\';\'){a+=\';\'}3(k==\'B\'){a+=\' \'}a+=v}j.16(k,a)})}b.1q.n(c,h,f,6(a){b.1r(f.21,6(){3($.9(f.1M)){f.1M.n(h,h.A(\'.2-5-8\'))}})});3($.9(f.1Z)){f.1Z.n(c)}D h},2g:6(a,b){4 c=7.u;4 o=7.E;3(7.E[a]){7.E[a]=b}2p(a){1i"K":7.1h(b);1j;1i"2u":7.1X(b);1j;1i"1y":$(b,c).A(\'.2-5-1w\').1z(\'X\');1j;1i"13":3(b==W||b==m){D o.13}t{o.13=b;1j}}},2A:6(a,b){4 c=7.u;4 d={};$(\'.2-5-I\').N(6(i,v){$(\'.2-5-w\',7).N(6(j,a){4 b=$(7).16(\'17\');d[b]={x:i,y:j}})});D d},1J:6(){4 c=7.u;$(c).A(\'.2-5-U\').1l(6(){4 a=$(7).O(\'.2-5-w\');4 p=a.T(\'1f\');3(a.2T(\'2-5-1E-1B\')){$(c).A(\'.2-5-w\').1F();a.11(\'2-5-1E-1B\').1U({s:a.T(\'s\'),z:\'2w\'}).12({15:\'2y\'}).1R(\'s\').1R(\'z\');3(p.r){3($.9(p.r.20)){p.r.20.n(a,p)}}}t{$(c).A(\'.2-5-w\').1N();a.1F().G(\'2-5-1E-1B\').T({s:a.s(),z:a.z()}).12({15:\'2B\',2C:0,2D:0});4 b={};3(p.r){3(p.r.s){3($.9(p.r.s)){b.s=p.r.s.n(a,p)}t{b.s=p.r.s}}3(p.r.z){3($.9(p.r.z)){b.z=p.r.z.n(a,p)}t{b.z=p.r.z}}}t{b.s=$(c).s()+14}a.1U({s:b.s,z:b.z});3(p.r&&$.9(p.r.1L)){p.r.1L.n(a,p)}}})},1r:6(b,c){3(b){$.N(b,6(){4 a=$(\'2F\').1y(\'#1O\');$("<1P>"+"</1P>").16({2M:7,1Q:\'Q/2e\',17:\'1O\'}).S(a)})}3($.9(c)){c()}},1h:6(c){4 o=7.E;4 d=$(".2-5-I",7.u).K({2f:".2-5-I",10:6(a,b){3($.9(o.L.J.10)){o.L.J.10.n(b.w[0],a,b)}},1n:6(a,b){3($.9(o.L.J.1n)){o.L.J.1n.n(b.w[0],a,b)}},1o:6(a,b){3($.9(o.L.J.1o)){o.L.J.1o.n(b.w[0],a,b)}}});3(c===P){$(7.u).A(\'.2-5-U\').12(\'1S\',\'2h\');d.K(\'1L\');$(".2-5-8",7.u).2i({10:6(e,a){D 1D}})}t{$(7.u).A(\'.2-5-U\').12(\'1S\',\'2j\');d.K(\'2k\')}},1X:6(a){4 b=7;4 c=b.u;4 o=7.E;4 d=a;4 e;3($(\'.2-5-I\',c).18(d.15.y).1m>0){e=$(\'.2-5-I\',c).18(d.15.y)}t{e=$(\'.2-5-I\',c).18(0)}2l.2m(e);4 f=b.1C(b,c,e,a.15,a.5);b.1K(f);3(o.r===P){b.1J()}b.1h(o.K)},1K:6(d){4 e=7;4 f=d||7.u;4 g=$(".2-5-F",f).X(6(a,b){4 c=$(7).O(".2-5-w:2n").A(".2-5-8");b=b||\'F\';3(b==\'F\'){c.2o();$(7).1T("2-q-1e").1T("2-q-1H")}t 3(b==\'1N\'){c.2r();$(7).11("2-q-1e").G("2-q-1H")}t 3(b==\'1F\'){c.2s();$(7).11("2-q-1H").G("2-q-1e")}}).1l(6(a){a.1G()});4 h=$(".2-5-Z",f).X(6(a){e.Z.n(e,a)}).1l(6(a){a.1G()});4 i=$(".2-5-1w",f).X(6(a){e.1W.n(e,a)}).1l(6(a){a.1G()});7.1x(g.1Y());7.1x(h.1Y())},1x:6(a){$(a).1u(6(){$(7).G(\'2-1t-1u\')},6(){$(7).11(\'2-1t-1u\')})},1W:6(a){4 o=7.E;4 b=$(a.1s).O(\'.2-5-w\');4 c=b.T(\'1f\');3($.9(c.22)){4 d=c.22();3(!d){D}}b.1y();3($.9(o.1v)){o.1v()}},Z:6(b){4 o=7.E;4 c=$(b.1s).O(\'.2-5\');4 d=$(b.1s).O(\'.2-5-w\');4 e=d.T(\'1f\');4 f=d.A(\'.2-5-8\');4 g=d.O(\'.2-5\');3($.9(e.23)){e.23.n(g,e)}7.1q.n(c,d,e,6(a){3($.9(e.24)){e.24.n(g,a,e)}});7.1r(e.21)},1q:6(e,f,g){4 o=7.E;4 h=7;4 i=f.8.1Q;4 j=W;4 k=e.A(\'.2-5-8\');3($.9(f.8.25)){f.8.25.n(7,f.8.Q)}3(i==\'Q\'){j=f.8.Q;3($.9(j)){j=j(h,e,f)}3($.9(g)){g.n(h,j)}k.H(j);1p(f.8.Q)}t 3(i==\'26\'){4 l=f.8.28||\'H\';$.26({29:f.8.29,28:l,2H:6(){$(k).H(\'2I...\')},2J:6(a,b,c){3(l==\'H\'){j=a;$(k).H(a)}t 3(l==\'2K\'){3($.9(f.8.2a)){j=f.8.2a(o,f,a);$(k).H(j)}}1p(j);3($.9(g)){g.n(h,a)}},1c:6(a,b,c){4 d="<C 1g=\'2N:0.2O\' B=\'2-1t-1c 2-R-M\'>2P 2Q...</C>";$(k).H(d);3($.9(f.8.1c)){f.8.1c.n(k,a,b,c)}}})}6 1p(a){3($.9(f.8.2c)){f.8.2c.n(h,a)}}},F:6(a,b){4 c=7.u;$(\'#\'+a+\' .2-5-F\',c).1z(\'X\',[b||\'F\'])},2S:6(a){4 b=7.u;$(\'.2-5-F\',b).1z(\'X\',[a||\'F\'])},2d:6(){7.u.11("2-5").Q("");$.2U.2V.2d.n(7);D 7}})})(2t);',62,183,'||ui|if|var|portlet|function|this|content|isFunction||||||||||||||call|||icon|singleView|width|else|element||item|||height|find|class|span|return|options|toggle|addClass|html|column|drag|sortable|events|all|each|parents|true|text|corner|appendTo|data|header|attrs|null|click|div|refresh|start|removeClass|css|filterRepeat||position|attr|id|eq|columns|title|widget|error|prepend|minusthick|option|style|_sortable|case|break|last|dblclick|length|stop|over|_callAfterShow|_content|_loadScripts|target|state|hover|removeItem|close|_hoverable|remove|trigger|event|view|_createSinglePortlet|false|single|show|stopPropagation|plusthick|href|_regSingleView|_initEvents|enable|afterLoadContent|hide|loadScript|script|type|removeData|cursor|toggleClass|animate|columnWidth|_destoryItem|_addSingle|parent|afterCreated|recovery|scripts|beforeRemove|beforeRefresh|afterRefresh|beforeShow|ajax|handleRepeat|dataType|url|formatter|beforeCreate|afterShow|destroy|javascript|connectWith|_setOption|move|draggable|default|disable|console|log|first|slideToggle|switch|300|slideUp|slideDown|jQuery|add|helper|auto|insertAfter|static|clearfix|index|absolute|left|top|closethick|head|insertBefore|beforeSend|Loading|success|json|_create|src|padding|2em|Load|Error|portlets|toggleAll|hasClass|Widget|prototype|substr'.split('|'),0,{}))