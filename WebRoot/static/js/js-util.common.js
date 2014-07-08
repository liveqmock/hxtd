window.jsUtil = window.jsUtil || {};

/**
 * 表格对象
 * -html结构
 * <div> 表格容器
 *  <form> 查询条件
 *      <div>查询</div> 查询按钮
 *      <div>重置</div> 重置按钮
 *      <div>高级搜索</div> 高级搜索
 *  </form>
 *  <div> 操作栏
 *      <div>删除</div>
 *  </div>
 *  <div></div> 浮动表头
 *  <div> 数据列表
 *      <div></div> 表头
 *      <div></div> 排序模板
 *      <div></div> 内容
 *      <div></div> 内容模板
 *  </div>
 *  <div></div> 分页栏
 *  <div></div> 分页栏模板
 * </div>
 * 示例使用div标签，具体标签不限定，赋予相应的选择器
 *
 * @constructor
 */
function Grid() {}

Grid.defaults = {
    containerSelector: ".listcontainer",
    //表单
    formSelector: "form",
    formPageNoSelector: "[name=hibernatePageNo]",
    formPageSizeSelector: "[name=hibernatePageSize]",
    formPageOrderBySelector: "[name=hibernateOrderBy]",
    formPageOrderSelector: "[name=hibernateOrder]",
    submitSelector: ".submit",
    resetSelector: ".reset",
    moreSelector: ".more",
    moreContentSelector: ".more-content",
    //操作栏
    operatebarSelector: ".operatebar",
    deleteSomeSelector: ".deletesome",
    exportSelector: ".export",
    operatebarRefreshSelector: ".refresh",
    exportFiledSelector: "[name^=search]",
    //内容列表
    gridName: "grid",
    gridSelector: ".grid",
    gridForForm: "forform",//表格扩展属性，对应的表单
    gridFormAction: "formaction",//表格扩展属性，对应表单的action属性
    gridForPagination: "forpagination",//表格扩展属性，对应的分页栏
    headerSelector: ".header",
    checkAllSelector: ".checkall",
    resultSelector: ".list",
    resultTemplateId: "template-tbody",
    checkItemSelector: ".checkitem",
    operateSelector: ".operate",
    onDelete: function (ids) {},//删除回调函数，参数=删除数据的主键编号
    deleteOneSelector: ".delete",
    disableButtonClass: ["allbtnno_l", "allbtnno_r"],
    enableButtonClass: ["allbtn_l", "allbtn_r"],
    moveSelector: ".move",
    authorizationSelector: ".authorization",
    resetPasswordSelector: ".resetpassword",
    enableSelector: ".enable",
    disableSelector: ".disable",
    //排序
    sortableSelector: ".sortable",
    orderBySelector: ".orderby",
    orderSelector: ".order",
    sortAscUnselectedClass: "sort_btm",
    sortAscSelectedClass: "sort_btm_orange",
    sortDescUnselectedClass: "sort_top",
    sortDescSelectedClass: "sort_top_orange",
    sortableTemplateId: "template-sort",
    //分页
    paginationActive: true,//是否启用分页
    paginationCountLimit: 1,//分页的最低限制条数
    paginationbarSelector: ".pagination",
    paginationTemplateId: "template-pagination",
    paginationParamSelector: ".pagination-param",
    paginationSizeShow: true,
    sizeSelector: ".page-size",
    toPageSelector: ".pagenobar",
    firstSelector: ".page-first",
    preSelector: ".page-pre",
    noSelector: ".page-no",
    anyoneSelector: ".page-anyone",
    nextSelector: ".page-next",
    lastSelector: ".page-last",
    refreshSelector: ".page-rel",
    totalPagesSelector: ".page-totalpages"
}

Grid.prototype = {
    /**初始化对象*/
    init: function (options) {
        this.options = $.extend({}, Grid.defaults, options);
        this.setElements();
        this.initUi();
        this.loadGrid();
        return this;
    },
    /**设置公用元素*/
    setElements: function () {
        var options = this.options;
        this.container = $(options.containerSelector);
        this.container.length == 0 && (this.container = $("body"));

        this.form = this.container.find(options.formSelector);
        this.form.length == 0 && (this.form = $(options.formSelector));
        this.action = this.form.attr("action");
        this.paginationData = {};
        if (this.options.paginationActive) {
            this.formPageSize = $(options.formPageSizeSelector, this.form);
            this.formPageNo = $(options.formPageNoSelector, this.form);
            this.formPageOrderBy = $(options.formPageOrderBySelector, this.form);
            this.formPageOrder = $(options.formPageOrderSelector, this.form);
            $.extend(this.paginationData, {
                hibernatePageSize: this.formPageSize.val(),
                hibernatePageNo: this.formPageNo.val(),
                hibernateOrderBy: this.formPageOrderBy.val(),
                hibernateOrder: this.formPageOrder.val()
            });
        }
        this.btnQuery = this.form.find(options.submitSelector);
        this.btnReset = this.form.find(options.resetSelector);
        this.btnMore = this.form.find(options.moreSelector);
        this.moreContent = this.form.find(options.moreContentSelector);

        this.operatebar = this.container.find(options.operatebarSelector);
        this.operatebar.length == 0 && (this.operatebar = this.container);
        this.btnDeleteSome = this.operatebar.find(options.deleteSomeSelector);
        this.btnRefresh = this.operatebar.find(options.operatebarRefreshSelector);
        this.btnExport = this.operatebar.find(options.exportSelector);

        this.grid = this.container.find(options.gridSelector);
        this.grid.length == 0 && (this.grid = this.container.find("table:last"));

        var forform = this.grid.attr(options.gridForForm);
        forform && (this.form = this.container.find(forform));
        var formaction = this.grid.attr(options.gridFormAction);
        formaction && (this.action = formaction);

        this.header = this.grid.find(options.headerSelector);
        this.header.length == 0 && (this.header = this.grid.find("tr:has(th):first"));
        this.btnCheckAll = this.header.find(options.checkAllSelector);
        this.sortCells = this.header.find(options.sortableSelector);
        this.result = this.grid.find(options.resultSelector);
        this.btnDeleteOne = this.result.find(options.deleteOneSelector);
        this.btnEnable = this.result.find(options.enableSelector);
        this.btnDisable = this.result.find(options.disableSelector);
        this.btnResetPassword = this.result.find(options.resetPasswordSelector);
        this.btnMove = this.result.find(options.moveSelector);

        this.paginationbar = this.container.find(options.paginationbarSelector);
        var forpagination = this.grid.attr(options.gridForPagination);
        forpagination && (this.paginationbar = this.container.find(forpagination));

        return this;
    },
    /**初始化界面*/
    initUi: function () {
        this.bindQuery();
        this.bindReset();
        this.bindMore();
        this.bindDeleteSome();
        this.bindRefresh();
        this.bindCheckAll();
        this.initFloatHeader();
        this.renderSort();
        this.bindSort();
        this.setPagination();
        this.enterShortcut();
        return this;
    },
    /**绑定查询事件*/
    bindQuery: function () {
        var _this = this;
        var click = function () {_this.grid.is(":visible") && _this.loadGridWithDisable({button: $(this)});};
        this.btnQuery.click(click).data(this.gridName + "click", click);
        return this;
    },
    /**enter键快捷功能
     * 1.一般情况，查询表单
     * 2.光标在分页栏第一节文本框时，转至某一页
     * @returns {Grid}
     */
    enterShortcut: function () {
        var _this = this;
        $(document).keydown(function (e) {
            var key = (e.keyCode) || (e.which) || (e.charCode);
            if (key == 13) {
                if (_this.pageNo && _this.pageNo[0] == e.srcElement) {
                    _this.pageAnyOne.trigger("click");
                } else {
                    _this.btnQuery.trigger("click");
                }
            }
        });
        return this;
    },
    /**绑定重置事件*/
    bindReset: function () {
        var _this = this;
        this.btnReset.removeClass("block dump_btn globle_img fr").addClass("a_underline fr w_blue mt5").text("清除");
        this.btnReset.click(function () {_this.form[0].reset();});
        return this;
    },
    /**绑定更多的事件*/
    bindMore: function () {
        var _this = this;

        $C.selectByClass(this.btnMore, "packup", "develop");
        this.btnMore.attr("展开");
        this.moreContent.hide();
        this.btnMore.toggle(function () {
            $C.unselectByClass(_this.btnMore, "packup", "develop");
            _this.btnMore.attr("收缩");
            _this.moreContent.show();
        }, function () {
            $C.selectByClass(_this.btnMore, "packup", "develop");
            _this.btnMore.attr("展开");
            _this.moreContent.hide();
        });
        return this;
    },
    /**绑定删除一些事件*/
    bindDeleteSome: function () {
        var _this = this;
        var click = function () {
            if (_this.grid.is(":hidden")) {
                return;
            }
            var ids = $(_this.options.checkItemSelector + ":checked", _this.result);
            if (ids.length == 0) {
                jsUtil.alert("请选择一条或多条数据！");
                return this;
            }

            var $this = $(this);
            jsUtil.confirm("确定要删除吗？", function () {
                var values = [];
                ids.each(function () {values.push(this.value);});
                _this.disableButton($this);
                RcmsAjax.ajax($this.attr("uri"), function () {
                    _this.options.onDelete.call(_this, (values));
                    _this.loadGrid();
                }, function () {_this.enableButton($this)}, $.param({id: values }, true));
            });
        };

        this.btnDeleteSome.click(click).data(this.gridName + "click", click);
        return this;
    },
    /**绑定刷新*/
    bindRefresh: function () {
        var _this = this;
        var click = function () {
            if (_this.result.is(":visible")) {
                _this.paginationData.hibernatePageNo = 1;
                _this.loadGridWithDisable({button: $(this)});
            }
        };
        this.btnRefresh.click(click).data(this.gridName + "click", click);
        return this;
    },
    /**绑定重置密码事件*/
    bindResetPassword: function () {
        var _this = this;
        var checkItemSelector = this.options.checkItemSelector;
        this.result.find(this.options.resetPasswordSelector).click(function () {
            var $this = $(this);
            var uri = $this.attr("uri");
            var idValue = $.URL.jsonParamsByUrl(uri).id;
            var ids = $(checkItemSelector + ":checked", _this.result);
            if (!idValue) {
                if (ids.length == 0) {
                    jsUtil.alert("请选择一条或多条数据！");
                    return this;
                }
            }

            jsUtil.confirm("确定要重置密码吗？", function () {
                if (!idValue) {
                    var values = [];
                    ids.each(function () {values.push(this.value);});
                    idValue = $.param({id: values});
                } else {
                    idValue = undefined;
                }
                RcmsAjax.ajax(uri, null, null, idValue, true);
            });
        });
        return this;
    },
    /**绑定启用事件*/
    bindEnable: function () {
        var _this = this;
        var checkItemSelector = this.options.checkItemSelector;
        this.result.find(this.options.enableSelector).click(function () {
            var $this = $(this);
            var uri = $this.attr("uri");
            var idValue = $.URL.jsonParamsByUrl(uri).id;
            if (!idValue) {
                var ids = $(checkItemSelector + ":checked", _this.result);
                if (ids.length == 0) {
                    jsUtil.alert("请选择一条或多条数据！");
                    return this;
                }

                var values = [];
                ids.each(function () {values.push(this.value);});
                idValue = $.param({id: values});
            } else {
                idValue = undefined;
            }

            RcmsAjax.ajax(uri, function () {setTimeout(function () {_this.loadGrid();}, 500);}, null, idValue);
        });
        return this;
    },
    /**绑定禁用事件*/
    bindDisable: function () {
        var _this = this;
        var checkItemSelector = this.options.checkItemSelector;
        this.result.find(this.options.disableSelector).click(function () {
            var $this = $(this);
            var uri = $this.attr("uri");
            var idValue = $.URL.jsonParamsByUrl(uri).id;
            if (!idValue) {
                var ids = $(checkItemSelector + ":checked", _this.result);
                if (ids.length == 0) {
                    jsUtil.alert("请选择一条或多条数据！");
                    return this;
                }

                var values = [];
                ids.each(function () {values.push(this.value);});
                idValue = $.param({id: values});
            } else {
                idValue = undefined;
            }

            RcmsAjax.ajax(uri, function () {setTimeout(function () {_this.loadGrid();}, 500);}, null, idValue);
        });
        return this;
    },
    /**绑定导出*/
    bindExport: function () {
        var _this = this;
        this.btnExport.click(function () {
            var exportButton = $(this);
            var jqIds = _this.result.find(_this.options.checkItemSelector + ":checked");
            if (jqIds.length == 0) {
                jsUtil.alert("请选择一条或多条需要导出的数据！");
                return;
            }
            var url = exportButton.attr("uri");
            url = url.replace("pagination", "selected");
            window.open($.URL.appendParams(url, $.param({id: $C.vals(jqIds)}, true)), "_blank");

            /*
             jsUtil.confirm("最多导出符合条件的前3000条数据", function () {
             var params = {};
             _this.form.find(_this.options.exportFiledSelector).each(function () {
             var $this = $(this);
             params[$this.attr("name")] = $.map($this.fieldValue(), function (value) {return encodeURI(value);});
             });
             window.open($.URL.appendParams(exportButton.attr("uri"), $.param(params, true)), "_self");
             });
             */
        });
        return this;
    },
    /**浮动表头*/
    initFloatHeader: function () {

        var _this = this;
        this.cloneFloatHeader();
        this.floatSortCells = this.floatHeader.find(this.options.sortableSelector);
        this.renderSort(this.floatSortCells).bindSort(this.floatSortCells, this.sortCells);

        $(window).scroll(function () {
            if (_this.header.is(":visible")) {
                RcmsFloatTitle.toggle(undefined, _this.header, _this.floatHeader);
            }
        });

        return this;
    },
    /**
     * 创建浮动表头
     * 1.从当前表头克隆出浮动表头
     * 2.页面已存在浮动表头，不创建
     */
    cloneFloatHeader: function () {
        this.floatHeader = $('<div style="display: none;background-color: #f5f5f6;" class="mr35 z1"></div>');
        this.grid.before(this.floatHeader);
        var emptyTable = this.grid.clone().empty();
        this.floatHeader.append(emptyTable);
        var headerClone = this.header.clone();
        emptyTable.append(headerClone);
        headerClone.find(this.options.checkAllSelector).remove();
        return this;
    },
    /**绑定选择所有事件*/
    bindCheckAll: function () {
        var _this = this;
        this.btnCheckAll.click(function () {_this.result.find(_this.options.checkItemSelector).attr("checked", this.checked);});
        this.result.find(this.options.checkItemSelector).live("click", function (e) {
            _this.btnCheckAll.attr("checked", _this.result.find(_this.options.checkItemSelector + ":not(:checked)").length == 0);
            e.stopPropagation();
        });
        return this;
    },
    /**重置选择所有*/
    resetCheckAll: function () {
        $(this.options.checkAllSelector, this.container).attr("checked", false);
        $(this.options.checkItemSelector, this.container).attr("checked", false);
        return this;
    },
    /**渲染排序*/
    renderSort: function (sortCells) {
        var _this = this;
        sortCells = sortCells || this.sortCells;
        sortCells.each(function () {
            var sortCell = $(this);
            var orderBy = sortCell.attr("orderby");
            var orderByValue = _this.paginationData.hibernateOrderBy;
            var orderValue = _this.paginationData.hibernateOrder;
            var data = {
                name: sortCell.text(),
                ascClass: (orderByValue == orderBy && orderValue == "asc") ? _this.options.sortAscSelectedClass : _this.options.sortAscUnselectedClass,
                descClass: (orderByValue == orderBy && orderValue == "desc") ? _this.options.sortDescSelectedClass : _this.options.sortDescUnselectedClass
            };
            sortCell.setTemplateElement(_this.options.sortableTemplateId).processTemplate(data);
        });
        return this;
    },
    /**绑定排序事件*/
    bindSort: function (sortCells, matchedSortCells) {
        var _this = this;
        sortCells = sortCells || this.sortCells;
        matchedSortCells = matchedSortCells || this.floatSortCells;
        sortCells.find(this.options.orderSelector).click(function () {
            var order = $(this);
            var sortCell = order.parents(_this.options.orderBySelector);
            var fieldName = sortCell.attr("orderby");
            var orderValue = order.attr("order");
            var floatOrder = matchedSortCells.filter("[orderby={}]".format(fieldName)).find("[order={}]".format(orderValue));
            _this.selectedSort(order, sortCells).selectedSort(floatOrder, matchedSortCells);
            _this.paginationData.hibernateOrderBy = fieldName;
            _this.paginationData.hibernateOrder = orderValue;
            _this.loadGrid();
        });
        return this;
    },
    /**排序不选中*/
    unselectedSort: function (jqele) {
        var order = jqele.attr("order");
        if (order == "asc") {
            jqele.removeClass(this.options.sortAscSelectedClass).addClass(this.options.sortAscUnselectedClass);
        } else if (order == "desc") {
            jqele.removeClass(this.options.sortDescSelectedClass).addClass(this.options.sortDescUnselectedClass);
        }
        return this;
    },
    /**排序选中*/
    selectedSort: function (target, container) {
        container = container || this.container;
        var order = target.attr("order");
        this.unselectedSort($("." + this.options.sortAscSelectedClass + ",." + this.options.sortDescSelectedClass, container));
        if (order == "asc") {
            target.removeClass(this.options.sortAscUnselectedClass).addClass(this.options.sortAscSelectedClass);
        } else if (order == "desc") {
            target.removeClass(this.options.sortDescUnselectedClass).addClass(this.options.sortDescSelectedClass);
        }
        return this;
    },
    /**取消操作单元格行选中*/
    cancelRowChecked: function () {
        var btnOperates = this.result.find(this.options.operateSelector);
        btnOperates.length == 0 && (btnOperates = this.result.find("tr").find("td a"));
        btnOperates.bind("click", function (event) {event.stopPropagation();});
        return this;
    },
    /**绑定删除一个事件*/
    bindDeleteOne: function () {
        var _this = this;
        this.result.find(this.options.deleteOneSelector).click(function () {
            var $this = $(this);
            jsUtil.confirm("确定要删除吗？", function () {
                var url = $this.attr("uri");
                RcmsAjax.ajax(url, function () {
                    _this.options.onDelete.call(this, [$.URL.jsonParamsByUrl(url).id]);
                    setTimeout(function () {_this.loadGrid();}, 500);
                });
            });
        });
        return this;
    },
    /**绑定移动事件*/
    bindMove: function () {
        this.result.find(this.options.moveSelector).click(function () {
            var $this = $(this);
            var url = $this.attr("uri");
            var redirectUri = $this.attr("redirecturi");
            RcmsAjax.ajax(url, function () {
                setTimeout(function () {window.open(redirectUri, "_self")}, 500);
            });
        });
        return this;
    },
    /**设置分页*/
    setPagination: function () {
        if (this.options.paginationActive) {
            var _this = this;
            $(this.grid).bind("pagination", function (event, page) {
                var result = page.result || page.list;
                if (result.length >= _this.options.paginationCountLimit) {
                    _this.renderPagination(page);
                    _this.bindPagination();
                }
            });
        }
        return this;
    },
    /**清除表格内容*/
    clearPagination: function () {
        this.paginationbar.empty();
        return this;
    },
    /**渲染分页*/
    renderPagination: function (data) {
        var options = this.options;
        data.paginationSizeShow = this.options.paginationSizeShow;
        this.paginationData = data;
        this.paginationbar.setTemplateElement(options.paginationTemplateId).processTemplate(data);
        this.pageSize = $(options.sizeSelector, this.paginationbar);
        this.pageFirst = $(options.firstSelector, this.paginationbar);
        this.pagePre = $(options.preSelector, this.paginationbar);
        this.pageAnyOne = $(options.anyoneSelector, this.paginationbar);
        this.pageNext = $(options.nextSelector, this.paginationbar);
        this.pageLast = $(options.lastSelector, this.paginationbar);
        this.totalPage = $(options.totalPagesSelector, this.paginationbar);
        this.pageNo = $(options.noSelector, this.paginationbar);
        this.totalPageValue = parseInt(this.totalPage.text());
        this.pageNoValue = parseInt(this.pageNo.attr("pageno"));
        this.pageRefresh = $(options.refreshSelector, this.paginationbar);
        return this;
    },
    /**绑定分页事件*/
    bindPagination: function () {
        var _this = this;

        var data = this.paginationData;

        this.pageSize.bind("change", function () {
            data.hibernatePageSize = this.value;
            data.hibernatePageNo = 1;
            _this.loadGrid();
        });
        this.pageFirst.bind("click", function () {
            if (data.hibernatePageNo > 1) {
                data.hibernatePageNo = 1;
                _this.loadGrid();
            }
        });
        this.pagePre.bind("click", function () {
            if (data.hibernatePageNo > 1) {
                data.hibernatePageNo--;
                _this.loadGrid();
            }
        });
        this.pageAnyOne.bind("click", function () {
            var pageNoInput = parseInt(_this.pageNo.val());
            if (data.hibernatePageNo > 0 && pageNoInput <= data.totalPages) {
                data.hibernatePageNo = pageNoInput;
                _this.loadGrid();
            }
        });
        this.pageNext.bind("click", function () {
            if (data.hibernatePageNo < data.totalPages) {
                data.hibernatePageNo++;
                _this.loadGrid();
            }
        });
        this.pageLast.bind("click", function () {
            if (data.hibernatePageNo < data.totalPages) {
                data.hibernatePageNo = data.totalPages;
                _this.loadGrid();
            }
        });

        this.pageRefresh.bind("click", function () {
            _this.loadGrid();
        });

        return this;
    },
    /**加载表格*/
    loadGrid: function (options) {
        var _this = this;

        this.clearGrid().clearPagination();

        var params = this.form.find(":not({})".format(this.options.paginationParamSelector)).fieldSerialize();
        if (this.options.paginationActive) {
            var pageParamNames = ["hibernatePageNo", "hibernatePageSize", "hibernateOrderBy", "hibernateOrder"];
            params += "&" + $.param($C.filter($C.clone(this.paginationData, pageParamNames)));
        }

        options = $.extend(true, {
            ajaxArgs: [this.action, function (result) {
                var page = result.result;
                _this.resetCheckAll();
                _this.renderList(page);
                $(_this.grid).trigger("pagination", [page]);
            }, null, params]
        }, options);
        RcmsAjax.ajax.apply(RcmsAjax, options.ajaxArgs);
        return this;
    },
    /**加载表格附带禁用按钮功能*/
    loadGridWithDisable: function (options) {
        var _this = this;
        options = $.extend(true, {button: null, ajaxArgs: []}, options);

        this.disableButton(options.button);

        var _completeCallback = options.ajaxArgs[2];
        var completeCallback = function () {
            _this.enableButton(options.button);
            _completeCallback && _completeCallback.apply(this, arguments);
        };
        options.ajaxArgs[2] = completeCallback;

        return this.loadGrid(options);
    },
    /**禁用按钮*/
    disableButton: function (button, enableClass, disableClass, gridName) {
        var enableButtonClass = enableClass || this.options.enableButtonClass;
        var disableButtonClass = disableClass || this.options.disableButtonClass;
        gridName = gridName || this.gridName;
        for (var i = 0; i < disableButtonClass.length; i++) {
            button.children().eq(i).removeClass(enableButtonClass[i]).addClass(disableButtonClass[i]);
        }
        button.unbind("click", button.data(gridName + "click"));
        return this;
    },
    /**启用按钮*/
    enableButton: function (button, enableClass, disableClass, gridName) {
        var enableButtonClass = enableClass || this.options.enableButtonClass;
        var disableButtonClass = disableClass || this.options.disableButtonClass;
        gridName = gridName || this.gridName;
        for (var i = 0; i < disableButtonClass.length; i++) {
            button.children().eq(i).removeClass(disableButtonClass[i]).addClass(enableButtonClass[i]);
        }
        button.bind("click", button.data(gridName + "click"));
        return this;
    },
    /**清除表格内容*/
    clearGrid: function () {
        this.result.empty();
        return this;
    },
    /**含有数据*/
    hasData: function (data) {
        var result = data.result || data.list;
        return result && result.length > 0;
    },
    /**渲染列表*/
    renderList: function (data) {
        var options = this.options;
        if (!this.hasData(data)) {
            var resultTemplate = "<tr><td colspan='{$T.colspan}' align='center'><div class='allnone'></div></td></tr>";
            var data = {colspan: this.header.children().length};
            this.result.setTemplate(resultTemplate).processTemplate(data);
        } else {
            this.result.setTemplateElement(options.resultTemplateId).processTemplate(data);
        }
        this.bindDeleteOne();
        this.bindEnable();
        this.bindDisable();
        this.bindResetPassword();
        this.bindMove();
        this.cancelRowChecked();
        return this;
    },
    /**绑定提交
     * 1.uri 提交到服务端的uri
     * 2.redirecturi 转发|重定向的uri
     * 2.1.不指定redirecturi，以open方式在本页面打开，提供给导出、下载等使用
     * 2.2.指定redirecuri，以表单提交方式发生请求，进行页面跳转
     * @returns {Grid}
     */
    bindSubmit: function () {
        var _this = this;
        $(this.options.submitSelector).each(function () {
            $(this).click(function () {
                var $this = $(this);
                var submitAction = $this.attr("uri");
                var redirectUri = $this.attr("redirecturi");

                if (redirectUri) {
                    _this.form.attr("action", $.URL.appendParams(submitAction, "redirectUri=" + encodeURI(redirectUri)));
                    if (!_this.form.valid || _this.form.valid()) {
                        _this.form.submit();
                    }
                } else {
                    window.open($.URL.appendParams(submitAction, _this.form.formSerialize()), "_self");
                }
            });
        });
        return this;
    }
}

/**删除数据后同步左侧树回调函数*/
Grid.deleteSynTree = function (ztree, jqele) {
    return function (ids) {
        if (!ids || ids.length == 0) {
            return true;
        }

        var node;
        for (var i = 0; i < ids.length; i++) {
            node = ztree.getNodeByParam("id", ids[i]);
            ztree.removeNode(node);
        }

        if (node && node.pId) {
            node = ztree.getNodeByParam("id", node.pId);
        } else {
            node = ztree.getNodes()[0];
        }

        ztree.selectNode(node);
        jqele.val(node.id);

        return true;
    };
}

jsUtil.bindSave = function (submitselector, formselector) {
    submitselector = submitselector || ".submit";
    formselector = formselector || "form";
    var $form = $(formselector);
    var action = $form.attr("action");
    var click = function () {
        var $this = $(this);
        var submitAction = action;
        var redirectUri = $this.attr("redirecturi");
        if (!$form.valid || ($form.valid && $form.valid())) {
            Grid.prototype.disableButton($this, Grid.defaults.enableButtonClass, Grid.defaults.disableButtonClass, "");
            RcmsAjax.ajax(submitAction, function (result) {
                if (redirectUri) {
                    redirectUri = redirectUri.replace("%s", "{}");
                    setTimeout(function () {window.open(window.ctx + redirectUri.format(result.result.result), "_self");}, 500);
                }
            }, function () {
                setTimeout(function () {Grid.prototype.enableButton($this, Grid.defaults.enableButtonClass, Grid.defaults.disableButtonClass, "")}, 800);
            }, $form.formSerialize());
        } else {
            return false;
        }
    };
    $(submitselector).click(click).data("click", click);
    return this;
}

jsUtil.bindSubmit = function (submitselector, formselector) {
    submitselector = submitselector || ".submit";
    formselector = formselector || "form";

    var $form = $(formselector);
    $(submitselector).click(function () {

        var $this = $(this);
        var submitAction = $this.attr("uri");
        var redirectUri = $this.attr("redirecturi");

        if (redirectUri) {
            $form.attr("action", $.URL.appendParams(submitAction, "redirectUri=" + encodeURI(redirectUri)));
            if (!$form.valid || $form.valid()) {
                $form.submit();
            }
        } else {
            window.open($.URL.appendParams(submitAction, $form.formSerialize()), "_self");
        }
    });
    return this;

}

/**
 * 组织树对话框单选控件
 * 1.单选
 * 2.全部异步加载，根节点为当前用户所属组织
 * 3.支持显示在页面的描述名和隐藏上传至服务端的主键编号，通过targetselector的扩展属性forselector指定
 * 4.支持重置
 * 4.默认选中
 * //TODO 自动展开到选中节点
 * //TODO 暂不支持定位
 * //TODO 一个都不选中的情况
 */
jsUtil.organizationTreeDialog = function (targetselector, dialogselector, treeselector) {
    targetselector = targetselector || "input.organization";
    dialogselector = dialogselector || ".organization-tree";
    treeselector = treeselector || "#organization-tree";

    //存储相关元素
    var target = $(targetselector);
    var targetfor = $(target.attr("forselector"));
    var dialog = $(dialogselector);
    var tree = $(treeselector);

    //存储原始值
    var targetval = target.val();
    var targetforval = targetfor.val();

    //绑定单击事件
    target.click(function () {dialog.dialog("open");}).attr("readonly", true);
//    var positon = target.offset();
    //初始化对话框插件
    dialog.dialog({
//        appendTo: targetselector, //TODO 关于appendTo无效的问题
        autoOpen: false,
//        position: [positon.left, positon.top],//TODO 定位不准确
        buttons: {
            "确定": function () {
                var nodes = ztree.getCheckedNodes();
                if (nodes.length == 1) {
                    var node = nodes[0];
                    target.val(node.name);
                    targetfor.val(node.id);
                }
                $(this).dialog("close");
            },
            "重置": function () {
                target.val(targetval);
                targetfor.val(targetforval);

                if (targetforval) {
                    var defaultNode = ztree.getNodeByParam("id", targetforval);
                    ztree.checkNode(defaultNode, true);
                } else {
                    var checkedNodes = ztree.getCheckedNodes();
                    if (checkedNodes && checkedNodes.length == 1) {
                        ztree.checkNode(checkedNodes[0], false);
                    }
                }

                $(this).dialog("close");
            },
            "关闭": function () {
                $(this).dialog("close");
            }
        }});

    //初始化zTree对象
    var ztree = $.fn.zTree.init(tree, {
        async: {
            enable: true,
            url: window.ctx + "/system/organization/query.do?TYPE=children",
            autoParam: ["id"]
        },
        check: {
            enable: true,
            chkStyle: "radio",
            radioType: "all"
        },
        callback: {
            onAsyncSuccess: function (event, treeId, treeNode, msg) {
                var selectNode = ztree.getNodeByParam("id", targetfor.val(), treeNode);
                ztree.checkNode(selectNode);
            }
        }
    });

    return this;
}

jsUtil.organizationTree = function (options) {

    var defaults = {
        treeId: "organizationTree",
        data: null,
        selectedId: null,
        click: null
    };
    options = $.extend(defaults, options);

    var ztree = $.fn.zTree.init($("#" + options.treeId), {
        data: {
            simpleData: {
                enable: true
            }
        },
        async: {
            enable: true,
            url: window.ctx + "/system/organization/query.do?TYPE=children",
            autoParam: ["id"]
        },
        callback: {
            onClick: options.click
        }
    }, options.data);

    if (options.selectedId) {
        var treeNode = ztree.getNodeByParam("id", options.selectedId);
        ztree.selectNode(treeNode);
    }

    return ztree;
}


jsUtil.menuTree = function (options) {

    var defaults = {
        treeId: "menuTree",
        data: null,
        selectedId: null,
        ztreeOptions: {
            data: {
                simpleData: {
                    enable: true
                }
            }
        }
    };
    options = $.extend(true, defaults, options);

    for (var i = 0; i < options.data.length; i++) {
        delete options.data[i].url;
    }

    var ztree = $.fn.zTree.init($("#" + options.treeId), options.ztreeOptions, options.data);

    if (options.selectedId) {
        var treeNode = ztree.getNodeByParam("id", options.selectedId);
        ztree.selectNode(treeNode);
    }

    return ztree;
}

jsUtil.requiredDefaults = {
    elementSelector: "td.required",
    requiredElementClass: "w_red"
};

/**渲染必填样式*/
jsUtil.renderRequired = function (options) {
    this.renderRequiredFormTd(options);
    this.renderRequiredFromInput(options);
    return this;
}

/**渲染必填样式*/
jsUtil.renderRequiredFormTd = function (options) {
    options = $.extend({}, jsUtil.requiredDefaults, options);
    $(options.elementSelector).each(function () {
        var $td = $(this);
        if ($td.find("." + options.requiredElementClass).length == 0) {
            $td.prepend('<span class="{}">*&nbsp;</span>'.format(options.requiredElementClass));
        }
    });
    return this;
}

/**渲染必填样式*/
jsUtil.renderRequiredFromInput = function (options) {
    options = $.extend({}, jsUtil.requiredDefaults, options);
    $(":input").each(function () {
        var $this = $(this);
        if ($this.hasClass("required") || ($this.metadata && $this.metadata().required)) {
            var prev = $this.parents("td").prev("td");
            if (prev.find("." + options.requiredElementClass).length == 0) {
                prev.prepend('<span class="{}">*&nbsp;</span>'.format(options.requiredElementClass));
            }
        }
    });
    return this;
}



