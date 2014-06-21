/**ztree的自定义扩展*/
(function () {

    function Ztree() {}

    $.extend(Ztree, {
        isClickSelf: function (ztree, treeNode) {
            return $.inArray(treeNode, ztree.getSelectedNodes()) > -1;
        }
    });

})(jQuery);