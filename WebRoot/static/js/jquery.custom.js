(function ($) {

    /**jQuery的自定义扩展*/
    $.Custom = function () {}
    $.extend($.Custom, {
        vals: function (jqele) {
            var vals = [];
            for (var i = 0; i < jqele.length; i++) {
                vals.push(jqele.eq(i).val());
            }
            return vals;
        },
        /**
         * 克隆json对象
         * @param json json对象
         * @param filterAttrs 可选的过滤属性
         * @returns {{}}
         */
        clone: function (json, filterAttrs) {
            var clone = {};
            if (filterAttrs) {
                for (var i = 0; i < filterAttrs.length; i++) {
                    var attr = filterAttrs[i];
                    clone[ attr] = json[attr];
                }
            } else {
                for (var attr in json) {
                    clone[attr] = json[attr];
                }
            }
            return clone;
        },
        /**
         * 过滤json对象
         * 1.清除值为0、-0、null、""、false、undefined 或 NaN的属性
         * @param json
         * @returns {*}
         */
        filter: function (json) {
            for (var attr in json) {
                if (!json[attr]) {
                    delete json[attr];
                }
            }
            return json;
        },
        /**查找数组属性值*/
        findArrayAttr: function (array, attr) {
            var attrs = [];
            for (var i = 0; i < array.length; i++) {
                attrs.push(array[i][attr]);
            }
            return attrs;
        },
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
            _this.unselectByClass(jqele, selected, unselected);
            jqele.toggle(function () {_this.selectByClass($(this), selected, unselected);}, function () {_this.selectByClass($(this), unselected, selected);});
            return this;
        },
        /**
         * 选项卡
         * -.html结构
         * <div> 选项卡容器
         *     <ul fortabpanels> 选项卡标题容器
         *        <li fortabpanel></li> 选项卡标题
         *        <li fortabpanel></li> 选项卡标题
         *     </ul>
         *     <div> 选项卡内容面板容器
         *        <div></div> 选项卡内容面板
         *        <div></div> 选项卡内容面板
         *     </div>
         * </div>
         * 结构中标记仅供参考，实际上通过选择器获取对应元素，可以替换
         * -.支持多个选项卡
         * -.支持拆分的标题和内容面板（不在同一个容器内），通过fortabpanels指定
         * -.初始化默认选中
         * -.选中事件
         * @param options
         * @returns {$.Custom}
         */
        tab: function (options) {
            var _this = this;

            options = $.extend({
                tabContainerSelector: ".tab", //选项卡容器选择器
                tabTitlesSelector: ".tab-titles",//选项卡标题容器选择器
                tabTitleSelector: ".tab-title",//选项卡标题选择器
                titleSelectedClass: "id_table3li",//选项卡标题选中样式
                titleUnselectedClass: "id_table3li2",//选项卡标题未选中样式
                tabPanelsSelector: ".tab-panels",//选项卡内容面板容器选择器
                tabPanelSelector: ".tab-panel",//选项卡内容面板选择器
                panelSelectedClass: "selected",//内容面板选中样式
                panelUnselectedClass: "unselected", //内容面板选中未选中样式
                extfortabpanels: "fortabpanels",//指定标题容器对应的内容面板容器选择器
                extfortabpanel: "fortabpanel",//指定标题对应的内容面板选择器
                onSelected: function (event, title, panel) {},//选中触发事件
                defaultSelected: 0,//默认选中的标题。指定标题的索引|选择器，false不默认选中
                "": ""//无效参数，便于增加属性
            }, options);

            //使用each，支持多个选项卡，支持拆分的标题和内容面板（不在同一个容器内）
            var tabContainer = $(options.tabContainerSelector);
            tabContainer.length == 0 && (tabContainer = $(options.tabTitlesSelector));
            tabContainer.each(function () {
                var $this = $(this);
                //初始化元素
                var titleContainer = $(options.tabTitlesSelector, $this);
                titleContainer.length == 0 && (titleContainer = $this);
                var panelContainerSelector = titleContainer.attr(options.extfortabpanels);
                panelContainerSelector == "" && (panelContainerSelector = options.tabPanelsSelector);
                var panelContainer = $(panelContainerSelector);
                panelContainer.length == 0 && (panelContainer = $(options.tabPanelsSelector, $this));
                var titles = titleContainer.find(options.tabTitleSelector);
                var panels = panelContainer.find(options.tabPanelSelector);

                //使用扩展属性
                var eachOptions = $.extend({}, options, {
                    titleSelectedClass: titleContainer.attr("selectedclass"),
                    titleUnselectedClass: titleContainer.attr("unselectedclass"),
                    panelSelectedClass: panelContainer.attr("selectedclass"),
                    panelUnselectedClass: panelContainer.attr("unselectedclass")
                });

                //绑定扩展事件
                titles.bind("selected", eachOptions.onSelected);

                //绑定默认事件
                titles.click(function () {
                    var title = $(this);
                    var panel = $(title.attr(eachOptions.extfortabpanel), eachOptions.tabPanelsSelector);
                    _this.cancleSelectByClass(eachOptions.tabTitlesSelector, eachOptions.titleSelectedClass, eachOptions.titleUnselectedClass);
                    _this.selectByClass(title, eachOptions.titleSelectedClass, eachOptions.titleUnselectedClass);
                    _this.cancleSelectByClass(eachOptions.tabPanelsSelector, eachOptions.panelSelectedClass, eachOptions.panelUnselectedClass);
                    _this.selectByClass(panel, eachOptions.panelSelectedClass, eachOptions.panelUnselectedClass);
                    title.trigger("selected", [title, panel]);
                });

                //初始化样式
                _this.unselectByClass(titles.filter(":not(.{})".format(eachOptions.titleSelectedClass)), eachOptions.titleSelectedClass, eachOptions.titleUnselectedClass);
                _this.unselectByClass(panels.filter(":not(.{})".format(eachOptions.panelSelectedClass)), eachOptions.panelSelectedClass, eachOptions.panelUnselectedClass);

                //默认选中
                if ($.isNumeric(eachOptions.defaultSelected)) {
                    titles.eq(eachOptions.defaultSelected).trigger("click");
                } else if (eachOptions.defaultSelected instanceof String) {
                    titles.filter(eachOptions.defaultSelected).trigger("click");
                }
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
                isClickSelf && (ztree.cancelSelectedNode() || (callback && callback.apply(this, [ztree, treeNode])));
                return !isClickSelf;
            };
        },
        /**设置值*/
        setValue: function (ztree, treeNode, nameSelector, idSelector) {
            nameSelector = nameSelector || "[name$=name]";
            var id = "", name = "";
            if (!treeNode.isClickSelf) {
                id = treeNode.id;
                name = treeNode.name;
            } else {
                ztree.cancelSelectedNode(treeNode);
            }

            var jqName = $(nameSelector).val(id);
            idSelector = idSelector || jqName.attr("forid");
            $(idSelector).val(name);
        }
    });


})(jQuery);