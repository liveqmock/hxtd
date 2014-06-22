jQuery.extend(jQuery.validator.messages, {
    required: "必填字段",
    remote: "请修正该字段",
    email: "邮箱格式错误",
    url: "请输入合法的网址",
    date: "请输入合法的日期",
    dateISO: "请输入合法的日期 (ISO).",
    number: "请输入合法的数字",
    digits: "只能输入整数",
    creditcard: "请输入合法的信用卡号",
    equalTo: "请再次输入相同的值",
    accept: "请输入拥有合法后缀名的字符串",
    maxlength: jQuery.validator.format("请输入一个长度最多是 {0} 的字符串"),
    minlength: jQuery.validator.format("请输入一个长度最少是 {0} 的字符串"),
    rangelength: jQuery.validator.format("请输入一个长度介于 {0} 和 {1} 之间的字符串"),
    range: jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
    max: jQuery.validator.format("请输入一个最大为 {0} 的值"),
    min: jQuery.validator.format("请输入一个最小为 {0} 的值")
});
$('head').append('<style type="text/css">input.error{border:1px solid red}label.error {padding-left:18px;color:red;}</style>');
jQuery.validator.addMethod("stringCheck", function (value, element) {
    return this.optional(element) || /^[\u0391-\uFFE5\w]+$/.test(value);
}, "只能包括中文字、英文字母、数字和下划线");
// 中文字两个字节       
jQuery.validator.addMethod("byteRangeLength",
    function (value, element, param) {
        var length = value.length;
        for (var i = 0; i < value.length; i++) {
            if (value.charCodeAt(i) > 127) {
                length++;
            }
        }
        return this.optional(element)
            || (length >= param[0] && length <= param[1]);
    }, "请确保输入的值在3-15个字节之间(一个中文字算2个字节)");
// 身份证号码验证       
jQuery.validator.addMethod("isIdCardNo", function (value, element) {
    return this.optional(element) || isIdCardNo(value);
}, "身份证号码格式错误");

// 手机号码验证       
jQuery.validator.addMethod("isMobile", function (value, element) {
    var length = value.length;
    var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
    return this.optional(element) || (length == 11 && mobile.test(value));
}, "手机号码格式错误");

// 电话号码验证       
jQuery.validator.addMethod("isTel", function (value, element) {
    var tel = /^\d{3,4}-?\d{7,9}$/; //电话号码格式010-12345678
    return this.optional(element) || (tel.test(value));
}, "电话号码格式错误");

// 联系电话(手机/电话皆可)验证   
jQuery.validator.addMethod("isPhone", function (value, element) {
    var length = value.length;
    var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
    var tel = /^\d{3,4}-?\d{7,9}$/;
    return this.optional(element) || (tel.test(value) || mobile.test(value));
}, "联系电话格式错误");

// 邮政编码验证       
jQuery.validator.addMethod("isZipCode", function (value, element) {
    var tel = /^[0-9]{6}$/;
    return this.optional(element) || (tel.test(value));
}, "邮政编码格式错误");

//必选下拉列表验证
jQuery.validator.addMethod("requiredSelect", function (value, element) {
    return this.optional(element) || (parseInt(value) > 0);
}, "必选字段");

/**调用入口*/
jQuery.validator.addMethod("ruleUrl", function (value, element) {
    return this.optional(element) || /^(\/[a-zA-Z]+)+\.(do|doself|docomp)$/.test(value);
}, "请输入规则的调用入口，如：/system/user/add.do");


/**
 * 唯一性验证
 * 1.param=[实体类名,原始值]
 * 修改时，传入原始值，当前值不进行验证
 */
jQuery.validator.addMethod("unique", function (value, element, param) {
    !param instanceof Array && (param = [param]);

    if (param[1] == value.trim()) {
        return true;
    }

    arguments[2] = {
        url: (window.ctx || "/hxtd") + "/common/common/unique.docomp",
        type: "post",
        data: {entityName: param[0], fieldName: element.name, fieldValue: value}
    };

    if (this.optional(element))
        return "dependency-mismatch";

    var previous = _previousValue.call(this, element);
    if (!this.settings.messages[element.name])
        this.settings.messages[element.name] = {};
    previous.originalMessage = this.settings.messages[element.name].unique;
    this.settings.messages[element.name].unique = previous.message;

    param = typeof param == "string" && {url: param} || param;

    if (this.pending[element.name]) {
        return "pending";
    }
    if (previous.old === value) {
        return previous.valid;
    }

    previous.old = value;
    var validator = this;
    this.startRequest(element);
    var data = {};
    data[element.name] = value;
    $.ajax($.extend(true, {
        url: param,
        mode: "abort",
        port: "validate" + element.name,
        dataType: "json",
        data: data,
        success: function (response) {
            validator.settings.messages[element.name].unique = previous.originalMessage;
            var valid = response === true;
            if (valid) {
                var submitted = validator.formSubmitted;
                validator.prepareElement(element);
                validator.formSubmitted = submitted;
                validator.successList.push(element);
                validator.showErrors();
            } else {
                var errors = {};
                var message = response || validator.defaultMessage(element, "unique");
                errors[element.name] = previous.message = $.isFunction(message) ? message(value) : message;
                validator.showErrors(errors);
            }
            previous.valid = valid;
            validator.stopRequest(element, valid);
        }
    }, param));
    return "pending";
}, "该字段值已存在");

function _previousValue(element) {
    return $.data(element, "previousValue") || $.data(element, "previousValue", {
        old: null,
        valid: true,
        message: this.defaultMessage(element, "unique")
    });
}