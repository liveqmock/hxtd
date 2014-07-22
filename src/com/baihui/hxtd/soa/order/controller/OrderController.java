package com.baihui.hxtd.soa.order.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.common.controller.CommonController;
import com.baihui.hxtd.soa.common.entity.WFNode;
import com.baihui.hxtd.soa.common.service.WFNodeService;
import com.baihui.hxtd.soa.order.entity.Order;
import com.baihui.hxtd.soa.order.service.OrderService;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 功能描述：订单模块controller
 *
 * @author ruisong.luan
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.order.controller.OrderController.java
 * @date 2014-6-30 下午05:49:46
 * @since (该版本支持的 JDK 版本) ： 1.6
 */
@Controller
@RequestMapping(value = "/order/order")
@SessionAttributes(value = {Constant.VS_USER, Constant.VS_DATASHIFT})
public class OrderController extends CommonController<Order> {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private OrderService orderService;
    @Resource
    private DictionaryService dictionaryService;

    /**
     * 查询线索列表(从功能按钮跳转)
     *
     * @param page
     * @param request
     * @return
     * @throws NoSuchFieldException
     */
    @ResponseBody
    @RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
    public String query(HibernatePage<Order> page, HttpServletRequest request, ModelMap model) throws NoSuchFieldException {

        logger.info("OrderController.query查询线索列表");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(
                request, "search_");
        Search.clearBlankValue(searchParams);
        Search.toRangeDate(searchParams, "modifiedTime");
        Search.toRangeDate(searchParams, "createdTime");
        logger.info("添加默认的查询条件");
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
        page = orderService.findPage(searchParams, dataShift, page);
        JsonDto json = new JsonDto();
        json.setResult(page);
        return json.toString();
    }

    /**
     * toQueryPage(从菜单跳转,跳转线索列表页)
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(Model model) {
        logger.info("OrderController.toQueryPage跳转线索列表页");
        model.addAttribute("page", new HibernatePage<Order>().order("desc").orderBy("modifiedTime"));
        return "/order/order/list";
    }

    /**
     * 查看或编辑线索
     *
     * @param type
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/toViewPage.do")
    public String view(@RequestParam(required = false) String type,
                       @RequestParam(required = false) Long id, Model model) {
        logger.info("OrderController.view查询组件");
        String returnStr = "/order/order/view";
        Order order = orderService.get(id);
        model.addAttribute("order", order);
        return returnStr;
    }


    @ResponseBody
    @RequestMapping(value = "/modify.do", produces = "text/text;charset=UTF-8")
    public String modify(Order order,
                         HttpServletRequest request) {
        logger.info("OrderController.modify修改线索信息");
        User u = (User) request.getSession().getAttribute(Constant.VS_USER);
        logger.info("获得当前操作用户{}", u.getName());
        order.setModifier(u);
        order.setCreator(u);
        AuditLog auditLog = new AuditLog(EnumModule.ORDER.getModuleName(),
                order.getId(), order.getCode(), EnumOperationType.MODIFY.getOperationType(), u);
        orderService.modify(order, auditLog);
        JsonDto json = JsonDto.modify(order.getId());
        return json.toString();
    }


    @RequestMapping(value = "/toModifyPage.do")
    public String toModifyPage(Model model, Long id) {
        logger.info("OrderController.toModifyPage修改线索所有者信息");
        String funcUrl = "/order/order/modify.do";
        model.addAttribute("funcUrl", funcUrl);
        Order order = orderService.get(id);
        model.addAttribute("order", order);
        setDefaultDict(model);
        return "/order/order/edit";
    }

    /**
     * delete(删除线索)
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do", produces = "text/text;charset=UTF-8")
    public String delete(ModelMap modelMap, Long[] id) {
        logger.info("OrderController.delete删除线索");
        User user = (User) modelMap.get(Constant.VS_USER);
        AuditLog[] auditLogArr = new AuditLog[id.length];
        for (int i = 0; i < id.length; i++) {
            auditLogArr[i] = new AuditLog(EnumModule.ORDER.getModuleName(),
                    id[i], orderService.get(id[i]).getCode(), EnumOperationType.DELETE.getOperationType(), user);
        }
        orderService.delete(id, auditLogArr);
        JsonDto json = JsonDto.delete(id);
        return json.toString();
    }

    /**
     * view(跳转到新增页面)
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/toAddPage.do")
    public String toAddPage(ModelMap model) {
        logger.info("OrderController.toAddPage新建线索");
        String funcUrl = "/order/order/add.do";
        model.addAttribute("funcUrl", funcUrl);
        Order order = new Order();
        order.setOwner((User) model.get(Constant.VS_USER));
        model.addAttribute("order", order);
        model.addAttribute("investmentWay", dictionaryService.findChildren("060101"));
        model.addAttribute("status", dictionaryService.findChildren("060102"));
        return "/order/order/edit";
    }

    private void setDefaultDict(Model model) {
        model.addAttribute("investmentWay", dictionaryService.findChildren("060101"));
        model.addAttribute("status", dictionaryService.findChildren("060102"));
    }


    /**
     * add(保存：新建)
     *
     * @param order
     * @param request
     * @param type
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/add.do", produces = "text/text;charset=UTF-8")
    public String add(Order order, HttpServletRequest request) {
        logger.info("ComponentController.query查询组件列表");
        //临时代码，时间类型应从数据库中取
        User u = (User) request.getSession().getAttribute(Constant.VS_USER);
        logger.info("ComponentController.query 获得当前操作的用户{}", u.getName());
        order.setCreator(u);
        order.setModifier(u);
        AuditLog auditLog = new AuditLog(EnumModule.ORDER.getModuleName(),
                order.getId(), order.getCode(), EnumOperationType.ADD.getOperationType(), u);
        orderService.add(order, auditLog);
        JsonDto json = JsonDto.add(order.getId());
        return json.toString();
    }


    /**
     * 导出分页数据
     * 1.在分页列表上根据当前条件进行导出
     */
    @RequestMapping(value = "/export.do", params = "TYPE=pagination")
    public void exportPagination(HttpServletRequest request, ModelMap model, HttpServletResponse response) throws NoSuchFieldException, IOException {
        logger.info("导出excel文件");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.decodeValue(searchParams);
        Search.toRangeDate(searchParams, "createdTime");
        logger.debug("查询条件数目“{}”", searchParams.size());
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
        List<Order> orders = orderService.export(searchParams, dataShift);
        logger.debug("列表信息数目“{}”", orders.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "order", orders).write(response.getOutputStream());
    }

    /**
     * toCustomerLstPage(跳转至订单组件列表界面)
     *
     * @author huizijing
     */
    @RequestMapping(value = "/toQueryPage.comp")
    public String toCustomerLstPage(HibernatePage<Order> page,
                                    HttpServletRequest request, Model model) throws NoSuchFieldException {
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);

        if (page == null) {
            page = new HibernatePage<Order>(12);
        }
        model.addAttribute("page", page);
        return "/order/order/listcomp";
    }

    /**
     * 查询没有被合同关联的订单
     *
     * @param searchParams
     * @param dataShift
     * @param page
     * @return
     * @throws NoSuchFieldException
     * @author huizijing
     */
    @ResponseBody
    @RequestMapping(value = "/queryList.do", produces = "text/text;charset=UTF-8")
    public String queryList(HibernatePage<Order> page,//
                            HttpServletRequest request, ModelMap model) throws NoSuchFieldException {

        logger.info("OrderController.query查询订单列表");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(
                request, "search_");
        Search.clearBlankValue(searchParams);
        Search.toRangeDate(searchParams, "modifiedTime");
        Search.toRangeDate(searchParams, "createdTime");
        logger.info("添加默认的查询条件");
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
        page = orderService.findListPage(searchParams, dataShift, page);
        JsonDto json = new JsonDto();
        json.setResult(page);
        return json.toString();
    }


    @Resource
    private WFNodeService wfNodeService;


    /** 跳转启动审批页面 */
    @RequestMapping("/toStartApprovePage.do")
    public String toStartApprovePage(Long id, ModelMap modelMap) {
        //存储订单
        Order order = orderService.get(id);
        //存储审批流程
//        List<WFNode> nodes = wfNodeService.findByModuleId("");


        return "/order/order/view";
    }

    /** 启动审批 */
    @ResponseBody
    @RequestMapping("/startApprove.do")
    public String startApprove(Long id, ModelMap modelMap) {

        return "/order/order/view";
    }

    /** 跳转执行审批页面 */
    @RequestMapping("/toExecuteApprovePage.do")
    public String toExecuteApprovePage(Long id, ModelMap modelMap) {

        return "/order/order/view";
    }

    /** 执行审批 */
    @ResponseBody
    @RequestMapping("/executeApprove.do")
    public String executeApprove(Long id, ModelMap modelMap) {

        return "/order/order/view";
    }

}
