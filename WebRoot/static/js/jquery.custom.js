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
        }
    });


})(jQuery);