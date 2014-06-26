//=====================
// 滚动条对象
//=====================
var RcmsFloatTitle = {
    floatDiv: '',
    height: 0,
    flag: ''
};

//=====================
// 滚动条对象属性
//=====================
RcmsFloatTitle.global = {
    scrollPlus: 'plus',
    scrollMinus: 'minus'
}

/*
$(function () {
    //页面滚动时判断如果表头行滚出窗口，在窗口顶部显示表头行
    if ($("#title")) {
        RcmsFloatTitle.floatDiv = $("#title");
        //设置宽度
        //RcmsFloatTitle.floatDiv.width($("#tbody").width());
    }
    $(window).scroll(function () {
        if (RcmsFloatTitle.floatDiv) {
            RcmsFloatTitle.toggle();
        }
    });
});
*/

RcmsFloatTitle.init = function () {
    //页面滚动时判断如果表头行滚出窗口，在窗口顶部显示表头行
    if ($("#title")) {
        RcmsFloatTitle.floatDiv = $("#title");
        //设置宽度
        //RcmsFloatTitle.floatDiv.width($("#tbody").width());
    }
    $(window).scroll(function () {
        if (RcmsFloatTitle.floatDiv) {
            RcmsFloatTitle.toggle();
        }
    });
}


//=====================
// 根据滚动条切换
//=====================
RcmsFloatTitle.toggle = function (obj, realHeader, floatHeader) {
    realHeader = realHeader || $('#recordDiv');
    if (realHeader.length < 0) {
        return false;
    }
    //var titlePos = $('#recordDiv')[0].offsetTop;
    //老的方式判断出现问题，使用jquery提供的方法
    var titlePos = realHeader.offset().top;
    var topNow = document.body.scrollTop;
    if (topNow == 0) { //解决ie6问题
        topNow = document.documentElement.scrollTop;
    }
    if (obj != undefined && obj.height != undefined && obj.flag != undefined) {
        if (obj.flag == RcmsFloatTitle.global.scrollPlus) {
            titlePos += obj.height;
        } else if (obj.flag == RcmsFloatTitle.global.scrollMinus) {
            titlePos -= obj.height;
        } else {
            titlePos += obj.height;
        }
    }
    if (titlePos < 0) {
        titlePos = 0;
    }
    floatHeader = floatHeader || RcmsFloatTitle.floatDiv;
    if (topNow > titlePos) {
        var flag = false;
        if ($.browser.msie) {
            if ($.browser.version == "6.0") {
                flag = true;
            }
        }
        if (!flag) {
            floatHeader.css('top', 0);
            floatHeader.css('position', 'fixed');
        } else {
            floatHeader.css('top', topNow);
            floatHeader.css('position', 'absolute');
        }
        floatHeader.show();
    } else {
        floatHeader.hide();
    }
}