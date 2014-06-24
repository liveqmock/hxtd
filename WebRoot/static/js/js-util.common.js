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
 * -支持多个表格
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
    //操作栏
    operatebarSelector: ".operatebar",
    deleteSomeSelector: ".deletesome",
    authorizationSelector: ".authorization",
    resetPasswordSelector: ".resetpassword",
    enableSelector: ".enable",
    disableSelector: ".disable",
    exportSelector: ".export",
    exportFiledSelector: "[name^=search]",
    //内容列表
    gridSelector: ".grid",
    headerSelector: ".header",
    checkAllSelector: ".checkall",
    resultSelector: ".list",
    resultTemplateId: "template-tbody",
    checkItemSelector: ".checkitem",
    onDelete: function (ids) {},
    deleteOneSelector: ".delete",
    disableButtonClass: ["allbtnno_l", "allbtnno_r"],
    enableButtonClass: ["allbtn_l", "allbtn_r"],
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
    paginationSelector: ".paginationbar",
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

        this.btnQuery = this.form.find(options.submitSelector);
        this.btnReset = this.form.find(options.resetSelector);
        this.formPageOrderBy = $(options.formPageOrderBySelector, this.form);
        this.formPageOrder = $(options.formPageOrderSelector, this.form);

        this.operatebar = this.container.find(options.operatebarSelector);
        this.operatebar.length == 0 && (this.operatebar = this.container);

        this.btnDeleteSome = this.operatebar.find(options.deleteSomeSelector);
        this.btnEnable = this.operatebar.find(options.enableSelector);
        this.btnDisable = this.operatebar.find(options.disableSelector);
        this.btnResetPassword = this.operatebar.find(options.resetPasswordSelector);
        this.btnExport = this.operatebar.find(options.exportSelector);

        this.grid = this.container.find(options.gridSelector);
        this.grid.length == 0 && (this.grid = this.container.find("table"));
        var forform = this.grid.attr("forform");
        forform && (this.form = this.container.find(forform));
        var formaction = this.grid.attr("formaction");
        formaction && (this.action = formaction);

        this.header = this.grid.find(options.headerSelector);
        this.header.length == 0 && (this.header = this.grid.find("tr:first"));
        this.sorts = this.header.find(options.sortableSelector);
        this.result = this.grid.find(options.resultSelector);
        this.deleteOne = this.grid.find(options.deleteOneSelector);

        this.paginationbar = this.container.find(options.paginationbarSelector);
        var forpagination = this.grid.attr("forpagination");
        forpagination && (this.paginationbar = this.container.find(forpagination));

        return this;
    },
    /**初始化界面*/
    initUi: function () {
        this.bindQuery();
        this.bindReset();
        this.bindDeleteSome();
        this.bindCheckAll();
        this.floatHeader();
        this.renderSort();
        this.bindSort();
        this.bindDeleteOne();
        this.setPagination();
        return this;
    },
    /**绑定查询事件*/
    bindQuery: function () {
        var _this = this;
        var click = function () {_this.loadGridWithDisable({button: $(this)});};
        this.btnQuery.click(click).data("click", click);
        return this;
    },
    /**绑定重置事件*/
    bindReset: function () {
        var _this = this;
        this.btnReset.click(function () {_this.form[0].reset();});
        return this;
    },
    /**绑定删除一些事件*/
    bindDeleteSome: function () {
        var _this = this;
        var click = function () {
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
                    _this.loadGridWithDisable({button: $this});
                }, null, $.param({id: values }, true));
            });
        };

        this.btnDeleteSome.click(click).data("click", click);
        return this;
    },
    /**绑定授权事件*/
    bindAuthorization: function () {
        var _this = this;
        var checkItemSelector = this.options.checkItemSelector;
        $(this.options.authorizationSelector, this.opebar).click(function () {
            var ids = $(checkItemSelector + ":checked", _this.container);
            if (ids.length != 1) {
                jsUtil.alert("请选择一条且仅限一条数据！");
                return this;
            }
            var $this = $(this);
            window.open($this.attr("uri") + "?id=" + ids.val(), "_self");
        });
        return this;
    },
    /**绑定重置密码事件*/
    bindResetPassword: function () {
        var checkItemSelector = this.options.checkItemSelector;
        var container = this.container;
        this.btnResetPassword.click(function () {
            var ids = $(checkItemSelector + ":checked", container);
            if (ids.length == 0) {
                jsUtil.alert("请选择一条或多条数据！");
                return this;
            }

            var $this = $(this);
            jsUtil.confirm("确定要重置密码吗？", function () {
                var values = [];
                ids.each(function () {values.push(this.value);});
                RcmsAjax.ajax($this.attr("uri"), null, null, $.param({id: values }, true));
            });
        });
        return this;
    },
    /**绑定启用事件*/
    bindEnable: function () {
        var _this = this;
        var checkItemSelector = this.options.checkItemSelector;
        var container = this.container;
        this.btnEnable.click(function () {
            var ids = $(checkItemSelector + ":checked", container);
            if (ids.length == 0) {
                jsUtil.alert("请选择一条或多条数据！");
                return this;
            }

            var $this = $(this);
            var values = [];
            ids.each(function () {values.push(this.value);});
            RcmsAjax.ajax($this.attr("uri"), function () {
                _this.resetCheckAll();
                ids.parents(".row").find(".isactive").each(function () {$(this).text("是");});
            }, null, $.param({id: values }, true));
        })
        return this;
    },
    /**绑定禁用事件*/
    bindDisable: function () {
        var _this = this;
        var checkItemSelector = this.options.checkItemSelector;
        var container = this.container;
        this.btnDisable.click(function () {
            var ids = $(checkItemSelector + ":checked", container);
            if (ids.length == 0) {
                jsUtil.alert("请选择一条或多条数据！");
                return this;
            }

            var $this = $(this);
            var values = [];
            ids.each(function () {values.push(this.value);});
            RcmsAjax.ajax($this.attr("uri"), function () {
                _this.resetCheckAll();
                ids.parents(".row").find(".isactive").each(function () {$(this).text("否");});
            }, null, $.param({id: values }, true));
        });
        return this;
    },
    /**绑定导出*/
    bindExport: function () {
        var _this = this;
        this.btnExport.click(function () {
            var exportButton = $(this);
            jsUtil.confirm("最多导出符合条件的前3000条数据", function () {
                var params = {};
                _this.form.find(_this.options.exportFiledSelector).each(function () {
                    var $this = $(this);
                    params[$this.attr("name")] = $.map($this.fieldValue(), function (value) {return encodeURI(value);});
                });
                window.open($.URL.appendParams(exportButton.attr("uri"), $.param(params, true)), "_self");
            });
        });
        return this;
    },
    /**浮动表头*/
    floatHeader: function () {
        if (window.RcmsFloatTitle && $("#title").length == 0) {
            var floatHeader = $('<div id="title" style="display: none;background-color: #f5f5f6;" class="mr35"></div>');
            this.grid.before(floatHeader);
            var emptyTable = this.grid.clone().empty();
            floatHeader.append(emptyTable);
            emptyTable.append(this.header.clone());
            this.header.attr("id", "recordDiv");
            RcmsFloatTitle.init();
        }
        return this;
    },
    /**绑定选择所有事件*/
    bindCheckAll: function () {
        var checkItemSelector = this.options.checkItemSelector;
        var checkAllSelector = this.options.checkAllSelector;
        var container = this.container;
        $(checkAllSelector, container).click(function () {$(checkItemSelector, container).attr("checked", this.checked);});
        $(checkItemSelector).live("click", function (e) {
            $(checkAllSelector, container).attr("checked", $(checkItemSelector + ":not(:checked)", container).length == 0);
            e.stopPropagation();//jquery 阻止冒泡事件
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
    renderSort: function () {
        var _this = this;
        this.sorts.each(function () {
            var $this = $(this);
            var orderBy = $this.attr("orderby");
            var orderByValue = _this.formPageOrderBy.val();
            var orderValue = _this.formPageOrder.val();
            var data = {
                name: $this.text(),
                ascClass: (orderByValue == orderBy && orderValue == "asc") ? _this.options.sortAscSelectedClass : _this.options.sortAscUnselectedClass,
                descClass: (orderByValue == orderBy && orderValue == "desc") ? _this.options.sortDescSelectedClass : _this.options.sortDescUnselectedClass
            };
            $this.setTemplateElement(_this.options.sortableTemplateId).processTemplate(data);
        });
        return this;
    },
    /**绑定排序事件*/
    bindSort: function () {
        var _this = this;
        this.sorts.find(this.options.orderSelector).click(function () {
            var $this = $(this);
            _this.selectedSort($this);
            _this.formPageOrderBy.val($this.parents(_this.options.orderBySelector).attr("orderby"));
            _this.formPageOrder.val($this.attr("order"));
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
    selectedSort: function (jqele) {
        var order = jqele.attr("order");
        this.unselectedSort($("." + this.options.sortAscSelectedClass + ",." + this.options.sortDescSelectedClass, this.container));
        if (order == "asc") {
            jqele.removeClass(this.options.sortAscUnselectedClass);
            jqele.addClass(this.options.sortAscSelectedClass);
        } else if (order == "desc") {
            jqele.removeClass(this.options.sortDescUnselectedClass);
            jqele.addClass(this.options.sortDescSelectedClass);
        }
        return this;
    },
    /**绑定删除一个事件*/
    bindDeleteOne: function () {
        var _this = this;
        this.deleteOne.live("click", function () {
            var $this = $(this);
            jsUtil.confirm("确定要删除吗？", function () {
                var url = $this.attr("uri");
                RcmsAjax.ajax(url, function () {
                    _this.options.onDelete.call(this, [$.URL.jsonParamsByUrl(url).id]);
                    _this.loadGrid();
                });
            });
        });
        return this;
    },
    /**设置分页*/
    setPagination: function () {
        if (this.options.paginationActive) {
            var _this = this;
            $(this.container).bind("pagination", function (event, page) {
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
        this.paginationbar.setTemplateElement(options.paginationTemplateId).processTemplate(data);
        this.totalPages = parseInt($(options.totalPagesSelector, this.paginationbar).text());
        this.pageNo = parseInt($(options.noSelector, this.paginationbar).attr("pageno"));
        return this;
    },
    /**绑定分页事件*/
    bindPagination: function () {
        var options = this.options;

        var pagination = this.paginationbar;

        var form = this.form;
        var formPageSize = $(options.formPageSizeSelector, form);
        var formPageNo = $(options.formPageNoSelector, form);

        var pageNo = this.pageNo;
        var totalPages = this.totalPages;

        var _this = this;
        $(options.sizeSelector, pagination).bind("change", function () {
            formPageSize.val(this.value);
            formPageNo.val(1);
            _this.loadGrid();
        });
        $(options.firstSelector, pagination).bind("click", function () {
            if (pageNo > 1) {
                formPageNo.val(1);
                _this.loadGrid();
            }
        });
        $(options.preSelector, pagination).bind("click", function () {
            if (pageNo > 1) {
                formPageNo.val(pageNo - 1);
                _this.loadGrid();
            }
        });
        $(options.anyoneSelector, pagination).bind("click", function () {
            var pageNoInput = parseInt($(options.noSelector, pagination).val());
            if (pageNo > 0 && pageNoInput <= totalPages) {
                formPageNo.val(pageNoInput);
                _this.loadGrid();
            }
        });
        $(options.nextSelector, pagination).bind("click", function () {
            if (pageNo < totalPages) {
                formPageNo.val(pageNo + 1);
                _this.loadGrid();
            }
        });
        $(options.lastSelector, pagination).bind("click", function () {
            if (pageNo < totalPages) {
                formPageNo.val(totalPages);
                _this.loadGrid();
            }
        });

        $(options.refreshSelector, pagination).bind("click", function () {_this.loadGrid()});

        return this;
    },
    /**加载表格*/
    loadGrid: function (options) {
        var _this = this;
        this.clearGrid().clearPagination();
        options = $.extend(true, {
            ajaxArgs: [this.action, function (result) {
                var page = result.result;
                _this.resetCheckAll();
                _this.renderList(page);
                $(_this.container).trigger("pagination", [page]);
            }, null, this.form.formSerialize()]
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
    disableButton: function (button) {
        var disableButtonClass = this.options.disableButtonClass;
        var enableButtonClass = this.options.enableButtonClass;
        for (var i = 0; i < disableButtonClass.length; i++) {
            button.children().eq(i).removeClass(enableButtonClass[i]).addClass(disableButtonClass[i]);
        }
        button.unbind("click", button.data("click"));
        return this;
    },
    /**启用按钮*/
    enableButton: function (button) {
        var disableButtonClass = this.options.disableButtonClass;
        var enableButtonClass = this.options.enableButtonClass;
        for (var i = 0; i < disableButtonClass.length; i++) {
            button.children().eq(i).removeClass(disableButtonClass[i]).addClass(enableButtonClass[i]);
        }
        button.bind("click", button.data("click"));
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
            var resultTemplate = "<tr><td colspan='{$T.colspan}' align='center'><b>没有符合条件的数据</b></td></tr>";
            var data = {colspan: this.header.children().length};
            this.result.setTemplate(resultTemplate).processTemplate(data);
        } else {
            this.result.setTemplateElement(options.resultTemplateId).processTemplate(data);
        }
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

/**绑定选择所有事件*/
jsUtil.bindCheckAll = function (allselector, oneselector, containerselector) {
    allselector = allselector || ".checkall";
    oneselector = oneselector || ".checkitem";
    containerselector = containerselector || "body";
    $(allselector, containerselector).click(function () {$(oneselector, containerselector).attr("checked", this.checked);});
    //TODO 注意这是一个live函数，并不是在加载数据列表之后才调用的
    $(oneselector, containerselector).live("click", function (e) {
        $(allselector, containerselector).attr("checked", $(oneselector + ":not(:checked)", containerselector).length == 0);
        e.stopPropagation();//jquery 阻止冒泡事件
    });
    return this;
}

jsUtil.bindEachCheckAll = function (containerselector, allselector, oneselector) {
    if (oneselector == undefined) {
        oneselector = allselector;
        allselector = containerselector;
    }
    containerselector = containerselector || "body";
    allselector = allselector || ".checkall";
    oneselector = oneselector || ".checkitem";
    $(containerselector).each(function () {
        var $this = $(this);
        $(allselector, $this).click(function () {$(oneselector, $this).attr("checked", this.checked);});
        $(oneselector, $this).live("click", function (e) {
            $(allselector, $this).attr("checked", $(oneselector + ":not(:checked)", $this).length == 0);
        });
    });
    return this;
}

/**重置选择所有*/
jsUtil.resetCheckAll = function (allselector) {
    allselector = allselector || ".checkall";
    $(allselector).attr("checked", false);
    return this;
}

/**绑定授权事件*/
jsUtil.bindAuthorization = function (authorizationselector, oneselector) {
    authorizationselector = authorizationselector || ".authorization";
    oneselector = oneselector || ".checkitem";
    $(authorizationselector).click(function () {
        var ids = $(oneselector + ":checked");
        if (ids.length != 1) {
            jsUtil.alert("请选择一条且仅限一条数据！");
            return this;
        }
        var $this = $(this);
        var href = $this.data("href");
        if (!href) {
            href = $this.attr("href");
            $this.data("href", href);
            $this.attr("href", "javascript:void(0)");
        }

        var url = $this.attr("uri");
        url = url || href;
        window.open(url + "?id=" + ids.val(), "_self");
    });
    return this;
}

/**绑定删除一些事件*/
jsUtil.bindDeleteSome = function (deleteallselector, oneselector) {
    deleteallselector = deleteallselector || ".deleteall";
    oneselector = oneselector || ".checkitem";
    $(deleteallselector).click(function () {
        var ids = $(oneselector + ":checked");
        if (ids.length == 0) {
            jsUtil.alert("请选择一条或多条数据！");
            return this;
        }

        var $this = $(this);
        var href = $this.data("href");
        if (!href) {
            href = $this.attr("href");
            $this.data("href", href);
            $this.attr("href", "javascript:void(0)");
        }

        var url = $this.attr("uri");
        url = url || href;

        jsUtil.confirm("确定要删除吗？", function () {
            var values = [];
            ids.each(function () {values.push(this.value);});
            RcmsAjax.ajax(url, function () {jsUtil.loadGrid();}, null, $.param({id: values }, true));
        });
    });
    return this;
}

/**绑定删除一个事件*/
jsUtil.bindDeleteOne = function (rowselector) {
    rowselector = rowselector || ".delete";
    //TODO 注意这是一个live函数，并不是在加载数据列表之后才调用的
    $(rowselector).live("click", function () {
        var $this = $(this);
        var href = $this.data("href");
        if (!href) {
            href = $this.attr("href");
            $this.data("href", href);
            $this.attr("href", "javascript:void(0)");
        }

        var url = $this.attr("uri");
        url = url || href;
        jsUtil.confirm("确定要删除吗？", function () {
            RcmsAjax.ajax(url, function () {jsUtil.loadGrid();});
        });
    });
    return this;
}


/**绑定查询事件*/
jsUtil.bindQuery = function (options) {
    var defaults = {
        submitSelector: ".submit"
    };
    options = $.extend({}, defaults, options);

    $(options.submitSelector).click(function () {jsUtil.loadGrid(options).resetCheckAll();});

    return this;
}

jsUtil.bindSave = function (submitselector, formselector) {
    submitselector = submitselector || ".submit";
    formselector = formselector || "form";
    var $form = $(formselector);
    var action = $form.attr("action");
    $(submitselector).click(function () {
        var submitAction = action;
        var redirectUri = $(this).attr("redirecturi");

//        if (redirectUri) {
//            submitAction += "?redirectUri=" + encodeURI(redirectUri);
//        }
//        $form.attr("action", submitAction);

        if ($form.valid()) {
            RcmsAjax.ajax(submitAction, function (result) {
                if (redirectUri) {
                    redirectUri = redirectUri.replace("%s", "{}");
                    setTimeout(function () {window.open(window.ctx + redirectUri.format(result.result.result), "_self");}, 500);
                }
            }, null, $form.formSerialize());
        } else {
            return false;
        }
    });
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



