(function ($) {

    /**jQuery的自定义扩展*/
    $.Custom = function () {}
    $.extend($.Custom, {
        /**选中通过样式*/
        selectByClass: function (jqele, selected, unselected) {
            jqele.addClass(selected).removeClass(unselected);
            return this;
        },
        /**不选中通过样式*/
        unselectByClass: function (jqele, selected, unselected) {
            jqele.addClass(unselected).removeClass(selected);
            return this;
        },
        /**取消选中通过样式*/
        cancleSelectByClass: function (containerSelector, selected, unselected) {
            this.unselectByClass($("." + selected, containerSelector), selected, unselected);
            return this;
        },
        /**触发切换“选中|未选中”样式*/
        toggleClass: function (jqele, selected, unselected) {
            var _this = this;
            _this.selectByClass(jqele, unselected, selected);
            jqele.toggle(function () {_this.selectByClass($(this), selected, unselected);}, function () {_this.selectByClass($(this), unselected, selected);});
            return this;
        },
        /**选项卡*/
        tab: function (options) {
            var _this = this;

            options = $.extend({
                tabContainerSelector: ".tab",
                tabTitlesSelector: ".tab-titles",
                tabTitleSelector: ".tab-title",
                titleSelectedClass: "id_table3li",
                titleUnselectedClass: "id_table3li2",
                tabPanelsSelector: ".tab-panels",
                tabPanelSelector: ".tab-panel",
                panelSelectedClass: "selected",
                panelUnselectedClass: "unselected"
            }, options);

            var titles = $(options.tabTitlesSelector);
            var panels = $(options.tabPanelsSelector);
            options = $.extend(options, {
                titleSelectedClass: titles.attr("selectedclass"),
                titleUnselectedClass: titles.attr("unselectedclass"),
                panelSelectedClass: panels.attr("selectedclass"),
                panelUnselectedClass: panels.attr("unselectedclass")
            });

            titles.find(options.tabTitleSelector).click(function () {
                var $this = $(this);
                _this.cancleSelectByClass(options.tabTitlesSelector, options.titleSelectedClass, options.titleUnselectedClass);
                _this.selectByClass($this, options.titleSelectedClass, options.titleUnselectedClass);
                _this.cancleSelectByClass(options.tabPanelsSelector, options.panelSelectedClass, options.panelUnselectedClass);
                _this.selectByClass($($this.attr("fortab")), options.panelSelectedClass, options.panelUnselectedClass);
            });

            return this;
        },
        /**触发设置Boolean属性的值*/
        toggleBoolean: function (jqele, name) {
            jqele.attr(name, false);
            jqele.toggle(function () {$(this).attr(name, true);}, function () {$(this).attr(name, false);});
            return this;
        },
        /**
         * 设置全选
         * 1.点击全选，复选框项选中
         * 2.点击全选，触发子项中未选中项全选
         */
        bindCheckAll: function (jqele, containerSelector, checkItemSelector, eventType) {
            checkItemSelector = checkItemSelector || ":checkbox";
            jqele.click(function () {
                var $this = $(this);
                var checkItem = $this.parents(containerSelector).find(checkItemSelector);
                if (eventType) {
                    checkItem.filter(Boolean($this.attr("checked")) ? ":not([checked])" : "[checked]").trigger(eventType);
                } else {
                    checkItem.attr("checked", Boolean($this.attr("checked")));
                }
            });
            return this;
        }
    });

    //缩写
    window.$C = $.Custom;

    $.objectClear = function (object) {
        var clears = [];
        for (var attr in object) {
            var value = object[attr];
            if (!value)clears.push(attr);
        }

        for (var i = 0; i < clears.length; i++) {
            delete object[clears[i]];
        }
        return object;
    }

    /**url对象*/
    $.URL = function () {}

    $.extend($.URL, {
        /**是否uri，uri是一个没有参数的url*/
        isUri: function (url) {
            return url.indexOf("?") == -1;
        },
        /**在url后追加参数*/
        appendParams: function (url, params) {
            return !params ? url : (url + (this.isUri(url) ? "?" : "&") + params);
        },
        /**截取参数*/
        substrParams: function (url) {
            var index = url.indexOf("?");
            return index == -1 ? "" : url.substring(index + 1);
        },
        /**将参数转换为json*/
        jsonParams: function (params) {
            var jsonParams = {};
            params = params.split("&");
            for (var i = 0; i < params.length; i++) {
                var parts = params[i].split("=");
                var name = parts[0];
                var value = parts[1];
                var historyValue = jsonParams[name];
                if (historyValue == undefined) {
                    jsonParams[name] = value;
                } else if (historyValue instanceof Array) {
                    jsonParams[name].push(value);
                } else {
                    jsonParams[name] = [historyValue, value];
                }
            }
            return jsonParams;
        },
        /**将参数转换为json通过url*/
        jsonParamsByUrl: function (url) {
            return this.jsonParams(this.substrParams(url));
        }

    });

    $.Ztree = function () {}

    $.extend($.Ztree, {
        /**是否点击当前节点*/
        isClickSelf: function (ztree, treeNode) {
            return $.inArray(treeNode, ztree.getSelectedNodes()) > -1;
        },
        /**切换选中状态*/
        switchSelected: function (callback) {
            var _this = this;
            return function (ztreeId, treeNode) {
                var ztree = $.fn.zTree.getZTreeObj(ztreeId);
                var isClickSelf = _this.isClickSelf(ztree, treeNode);
                isClickSelf && (ztree.cancelSelectedNode() || callback.apply(this, [ztree, treeNode]));
                return !isClickSelf;
            };
        }
    });


})(jQuery);