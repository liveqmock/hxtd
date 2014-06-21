(function ($) {
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