/**
 * 首字母大写
 */
String.prototype.upperInitial = function () {
    return this.replace(/(^|\s+)\w/g, function (s) {
        return s.toUpperCase();
    });
};

String.prototype.capitalize = String.prototype.upperInitial;
/**
 * 首字母小写
 */
String.prototype.uncapitalize = function () {
    return this.replace(/(^|\s+)\w/g, function (s) {
        return s.toLowerCase();
    });
};

/**
 * 日期格式字符串转换为日期类型
 */
String.prototype.dateParse = function () {
    return new Date(Date.parse(this.replace(/-/g, "/")));
};

/**
 * 去掉首尾空格（包括中文和英文）
 */
String.prototype.trim = function () {
    if (/^([ | ]*)(.*)([ | ]*)$/.test(this)) {
        return RegExp.$2;
    }
    return this;
};

/**
 * 是否以指定字符开始
 * @param pre 前缀
 * @returns boolean
 */
String.prototype.startWith = function (pre) {
    return new RegExp("^(" + pre + ")(.*)").test(this);
};

/**
 * 是否以指定字符结束
 * @param suf 后缀
 * @returns boolean
 */
String.prototype.endWith = function (suf) {
    return new RegExp("(.*)(" + suf + ")$").test(this);
};

(function () {

    /**
     * 格式化字符串
     * 1.支持{}占位符
     * @returns {string}
     */
    String.prototype.format = function () {
        var _args = arguments;
        var i = 0;
        return this.replace(/\{\d*\}/g, function (param) {
            return _args[i++];
        });
    }
})();
