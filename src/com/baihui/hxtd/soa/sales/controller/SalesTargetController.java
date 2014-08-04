package com.baihui.hxtd.soa.sales.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.common.controller.CommonController;
import com.baihui.hxtd.soa.order.service.OrderService;
import com.baihui.hxtd.soa.sales.entity.SalesTarget;
import com.baihui.hxtd.soa.sales.service.SalesTargetService;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import org.apache.commons.lang3.Range;
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
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping(value = "/sales/salesTarget")
@SessionAttributes(value = {Constant.VS_DATASHIFT, Constant.VS_USER})
public class SalesTargetController extends CommonController<SalesTarget> {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    private SalesTargetService salesTargetService;

    @Resource
    private OrderService orderService;


    /**
     * @param @param  page
     * @param @return 参数类型
     * @return ModelAndView    返回类型
     * @throws IOException
     * @throws JsonMappingException
     * @throws JsonGenerationException
     * @throws NoSuchFieldException    query(分页查询)
     * @throws
     * @Title: query
     */
    @RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
    @ResponseBody
    public void query(HibernatePage<SalesTarget> page,
                      HttpServletRequest request, ModelMap model, PrintWriter out) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException {
        logger.info("SalesTargetController.query查询销售目标列表");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(
                request, "search_");
        Search.clearBlankValue(searchParams);
        Search.trimValue(searchParams);
        Search.toRangeDate(searchParams, "modifiedTime");
        Search.toRangeDate(searchParams, "createdTime");
        logger.info("添加默认的查询条件");
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
        page = salesTargetService.findPage(searchParams, dataShift, page);
        JsonDto json = new JsonDto();
        json.setResult(page);
        HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
    }

    /**
     * toQueryPage(跳转列表页)
     *
     * @param @param
     * @param @return 参数类型
     * @return ModelAndView    返回类型
     * @throws
     * @Title: toQueryPage
     */
    @RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(ModelMap model) throws NoSuchFieldException {
        logger.info("转至查询页面");
        logger.info("存储表单默认值");
        HibernatePage<SalesTarget> page = new HibernatePage<SalesTarget>().order(HibernatePage.DESC).orderBy("modifiedTime");
        model.addAttribute("page", page);
        return "/sales/salesTarget/list";
    }

    /**
     * view(查询单个销售目标信息)
     *
     * @param @param  type
     * @param @param  id
     * @param @param  model
     * @param @return 参数类型
     * @return String    返回类型
     * @throws
     * @Title: view
     */
    @RequestMapping(value = "/toViewPage.do")
    public String view(@RequestParam(required = false) String type,
                       @RequestParam(required = false) Long id,
                       Model model) {
        logger.info("SalesTargetController.view查询销售目标");
        SalesTarget com = salesTargetService.get(id);
        model.addAttribute("salesTarget", com);

        Range<Date> timeRange = Range.between(com.getBeginTime(), com.getEndTime());
        String chart = orderService.statisFinished(com.getOwner(), timeRange);
        model.addAttribute("chart", chart);
        Object[] numbers = orderService.statisFinishedCountMoney(com.getOwner(), timeRange);
        model.addAttribute("finishedCount", numbers[0]);
        model.addAttribute("finishedMoney", numbers[1] == null ? 0 : numbers[1]);


        return "/sales/salesTarget/view";
    }

    @RequestMapping(value = "/view.comp", params = "type=time")
    public String view(Model model) {
        logger.info("SalesTargetController.view时间段生成控件");
        return "/sales/salesTarget/view_time";
    }


    /**
     * toAddPage(跳转新增页面)
     *
     * @param @param  type
     * @param @param  id
     * @param @param  model
     * @param @return 参数类型
     * @return String    返回类型
     * @throws
     * @Title: view
     */
    @RequestMapping(value = "/toAddPage.do")
    public String toAddPage(Model model) {
        logger.info("SalesTargetController.view查询销售目标");
        String funcUrl = "/sales/salesTarget/add.do";
        setDefaultDict(model);
        model.addAttribute("funcUrl", funcUrl);
        return "/sales/salesTarget/edit";
    }

    /**
     * toModifyPage(跳转修改页面)
     *
     * @param @param  id
     * @param @param  model
     * @param @return 参数类型
     * @return String    返回类型
     * @throws
     * @Title: toModifyPage
     */
    @RequestMapping(value = "/toModifyPage.do")
    public String toModifyPage(@RequestParam(required = false) Long id,
                               Model model) {
        logger.info("SalesTargetController.toModifyPage查询销售目标");
        String funcUrl = "/sales/salesTarget/modify.do";
        SalesTarget com = salesTargetService.get(id);
        setDefaultDict(model);
        model.addAttribute("salesTarget", com);
        model.addAttribute("funcUrl", funcUrl);
        return "/sales/salesTarget/edit";
    }

    @RequestMapping(value = "/toAddPage.do", params = "type=second")
    public String addSecond(@RequestParam(required = false) Long id,
                            Model model) {
        logger.info("SalesTargetController.toModifyPage查询销售目标");
        String funcUrl = "/sales/salesTarget/add.do";
        SalesTarget com = salesTargetService.get(id);
        setDefaultDict(model);
        com.setId(null);
        com.setOwner(null);
        model.addAttribute("salesTarget", com);
        model.addAttribute("funcUrl", funcUrl);
        return "/sales/salesTarget/edit";
    }


    private void setDefaultDict(Model model) {
    }

    /**
     * modify(保存：修改)
     *
     * @return String    返回类型
     */
    @ResponseBody
    @RequestMapping(value = "/modify.do", produces = "text/text;charset=UTF-8")
    public String modify(SalesTarget salesTarget, String type, HttpServletRequest request, ModelMap modelMap) {
        logger.info("SalesTargetController.modify修改销售目标信息");
        User user = (User) modelMap.get(Constant.VS_USER);
        logger.info("获得当前操作用户{}", user.getRealName());
        salesTarget.setModifier(user);
        AuditLog auditLog = new AuditLog(EnumModule.SALESTARGET.getModuleName(),
                salesTarget.getId(), salesTarget.getTitle(), EnumOperationType.MODIFY.getOperationType(), user);
        salesTargetService.modify(salesTarget, auditLog);
        JsonDto json = JsonDto.modify(salesTarget.getId());
        salesTarget.setModifier(user);
        return json.toString();
    }

    /**
     * add(保存：新建)
     */
    @ResponseBody
    @RequestMapping(value = "/add.do", produces = "text/text;charset=UTF-8")
    public String add(SalesTarget salesTarget, String ownerIds, HttpServletRequest request, ModelMap modelMap) {
        logger.info("SalesTargetController.query查询销售目标列表");
        //临时代码，时间类型应从数据库中取
        User user = (User) modelMap.get(Constant.VS_USER);
        logger.info("SalesTargetController.query 获得当前操作的用户{}", user.getRealName());
        salesTarget.setCreator(user);
        salesTarget.setModifier(user);
        String[] owners = ownerIds.split(",");
        AuditLog[] auditLogArr = new AuditLog[owners.length];
        for (int i = 0; i < owners.length; i++) {
            auditLogArr[i] = new AuditLog(EnumModule.SALESTARGET.getModuleName(),
                    null, salesTarget.getTitle(), EnumOperationType.ADD.getOperationType(), user);
        }
        salesTargetService.add(salesTarget, owners, auditLogArr);
        JsonDto json = JsonDto.add(salesTarget.getId());
        return json.toString();
    }

    /**
     * (保存：新建)
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do", produces = "text/text;charset=UTF-8")
    public String delete(ModelMap modelMap, Long[] id) {
        logger.info("SalesTargetController.delete删除销售目标");
        User user = (User) modelMap.get(Constant.VS_USER);
        AuditLog[] auditLogArr = new AuditLog[id.length];
        for (int i = 0; i < id.length; i++) {
            auditLogArr[i] = new AuditLog(EnumModule.SALESTARGET.getModuleName(),
                    id[i], salesTargetService.get(id[i]).getTitle(), EnumOperationType.DELETE.getOperationType(), user);
        }
        salesTargetService.delete(id, auditLogArr);
        return JsonDto.delete(id).toString();
    }
}
