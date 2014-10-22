package com.baihui.hxtd.soa.common.controller;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.persistence.SearchFilter;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.FieldInfoParser;
import com.baihui.hxtd.soa.base.InitApplicationConstant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ReflectionUtils;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.base.utils.report.ChartModel;
import com.baihui.hxtd.soa.common.entity.Module;
import com.baihui.hxtd.soa.common.entity.ModuleField;
import com.baihui.hxtd.soa.common.entity.Report;
import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.common.service.ModuleService;
import com.baihui.hxtd.soa.common.service.ModuleTypeService;
import com.baihui.hxtd.soa.common.service.ModuleUtil;
import com.baihui.hxtd.soa.common.service.ReportService;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.BusinessResult;
import com.baihui.hxtd.soa.util.CommonCalendar;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonProcessingException;

/**
 * 报表控制类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
@Controller
@RequestMapping("/common/report")
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_ORG, Constant.VS_DATASHIFT,
        Constant.VS_MENUS, Constant.VS_ROLES, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
public class ReportController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private ReportService reportService;

    @Resource
    private ModuleService moduleService;

    @Resource
    private ModuleTypeService moduleTypeService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private CommonService commonService;

    @RequestMapping("/toQueryPage")
    public String toQueryPage(HibernatePage<Report> page, ModelMap modelMap) {

        page.setHibernateOrderBy("modifiedTime");
        page.setHibernateOrder("desc");
        modelMap.addAttribute("page", page);

        Long moduleTypeId = dictionaryService.getIdByValue(DictionaryConstant.MODULE_TYPE_REPORT);
        List<Long> moduleIds = moduleTypeService.findModuleIdByTypeId(moduleTypeId);
        List<Module> modules = ReflectionUtils.findNameValueMatched(InitApplicationConstant.MODULES, "id", moduleIds);
        modelMap.addAttribute("modules", modules);
        modelMap.addAttribute("types", dictionaryService.findChildren(DictionaryConstant.REPORT_CHART));

        return "/common/report/list";
    }


    @RequestMapping(value = "/toQueryPage.comp")
    public String toQuerySimplePage(HibernatePage<Report> page, ModelMap modelMap) {

        page.setHibernateOrderBy("modifiedTime");
        page.setHibernateOrder("desc");
        modelMap.addAttribute("page", page);

        Long moduleTypeId = dictionaryService.getIdByValue(DictionaryConstant.MODULE_TYPE_REPORT);
        List<Long> moduleIds = moduleTypeService.findModuleIdByTypeId(moduleTypeId);
        List<Module> modules = ReflectionUtils.findNameValueMatched(InitApplicationConstant.MODULES, "id", moduleIds);
        modelMap.addAttribute("modules", modules);
        modelMap.addAttribute("types", dictionaryService.findChildren(DictionaryConstant.REPORT_CHART));

        return "/common/report/listcomp";
    }

    @ResponseBody
    @RequestMapping("/query.do")
    public String query(HttpServletRequest request, HibernatePage<Report> page, ModelMap modelMap) throws NoSuchFieldException, JsonProcessingException {
        logger.info("查询");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.trimValue(searchParams);
        logger.debug("查询条件数目“{}”", searchParams.size());

        logger.info("查询分页列表信息");
        DataShift dataShift = (DataShift) modelMap.get(Constant.VS_DATASHIFT);
        page = reportService.findPage(searchParams, page, dataShift.renameUserFieldName("creator"));
        List<Report> result = reportService.nameToDesc(page.getResult());
        logger.debug("列表信息数目“{}”", result.size());

        logger.info("转换为TDO格式");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setResult(page);

        return HibernateAwareObjectMapper.DEFAULT.writeValueAsString(jsonDto);
    }


    /**
     * 存储表单初始化数据
     */
    public void detail(ModelMap modelMap) {
        logger.info("存储表单初始化数据");


        //查询并存储所属模块
        Long moduleTypeId = dictionaryService.getIdByValue(DictionaryConstant.MODULE_TYPE_REPORT);
        List<Long> moduleId = moduleTypeService.findModuleIdByTypeId(moduleTypeId);
        List<Module> modules = commonService.findByIds(InitApplicationConstant.MODULES, moduleId);
        modelMap.addAttribute("modules", modules);
        logger.debug("所属模块数目“{}”", modules.size());

        //查询并存图表类型
        List<Dictionary> charts = dictionaryService.findChildren(DictionaryConstant.REPORT_CHART);
        modelMap.addAttribute("charts", charts);
        logger.debug("图表类型数目“{}”", charts.size());
        modelMap.addAttribute("CHART_PIE", DictionaryConstant.REPORT_CHART_PIE);

        //查询并存储聚合类型
        List<Dictionary> aggregates = dictionaryService.findChildren(DictionaryConstant.REPORT_AGGREGATE);
        modelMap.addAttribute("aggregates", aggregates);
        logger.debug("聚合类型数目“{}”", aggregates.size());
    }

    /**
     * 转至新增页面
     */
    @RequestMapping(value = "/toAddPage.do", method = RequestMethod.GET)
    public String toAddPage(ModelMap modelMap) {
        logger.info("转至新增页面");

        detail(modelMap);

        logger.info("存储表单默认值");

        return "/common/report/edit";
    }

    /**
     * 查找分组类型通过模块主键编号和字段名称
     */
    @ResponseBody
    @RequestMapping("/findGroupType.docomp")
    public String findGroupType(Long moduleId, String fieldName) {
        logger.info("查找分组类型通过模块主键编号和字段名称");
        logger.debug("模块ID=“{}”，字段名称=“{}”", moduleId, fieldName);

        Field[] fields = InitApplicationConstant.findModuleById(moduleId).getFields();
        Class type = ReflectionUtils.getEntityFieldType(ModuleUtil.findFieldByName(fields, fieldName));
        List<Dictionary> groupTypes = reportService.findGroupType(type);

        JsonDto jsonDto = new JsonDto();
        jsonDto.setResult(new BusinessResult<List<Dictionary>>(groupTypes));
        String result = jsonDto.toString();
        logger.debug("result={}", result);
        return result;
    }

    /**
     * 新增
     */
    @ResponseBody
    @RequestMapping(value = "/add.do", method = RequestMethod.POST)
    public String add(Report report, ModelMap modelMap) {
        logger.info("新增");
        logger.debug("名称=“{}”", report.getName());

        logger.info("添加服务端属性值");
        report.setCreator((User) modelMap.get(Constant.VS_USER));
        report.setModifier(report.getCreator());

        AuditLog auditLog = new AuditLog(EnumModule.REPORT.getModuleName(), report.getName(), EnumOperationType.ADD.getOperationType(), report.getCreator());
        reportService.add(report, auditLog);

        return JsonDto.add(report.getId()).toString();
    }

    @RequestMapping(value = "/toViewPage.do", method = RequestMethod.GET)
    public String toViewPage(Long id, ModelMap modelMap) {
        logger.info("转至查看页面");

        Report report = reportService.get(id);
        report = reportService.nameToDesc(report);
        modelMap.addAttribute("report", report);

        logger.info("存储表单初默认值");

        return "/common/report/view";
    }

    /**
     * 转至修改报表页面
     */
    @RequestMapping(value = "/toModifyPage.do", method = RequestMethod.GET)
    public String toModifyPage(Long id, ModelMap modelMap) {
        logger.info("转至修改页面");
        logger.debug("主键编号“{}”", id);

        detail(modelMap);

        Report report = reportService.get(id);
        modelMap.addAttribute("report", report);
        modelMap.addAttribute("fieldModules", moduleService.findModuleAndAssociation(report.getModule().getId()));
        Field[] fields = InitApplicationConstant.findModuleById(report.getModule().getId()).getFields();
        if (StringUtils.isNotBlank(report.getxFieldName())) {
            Class type = ReflectionUtils.getEntityFieldType(ModuleUtil.findFieldByName(fields, report.getxFieldName()));
            modelMap.addAttribute("xGroupTypes", reportService.findGroupType(type));
        }

        if (StringUtils.isNotBlank(report.getzFieldName())) {
            Class type = ReflectionUtils.getEntityFieldType(ModuleUtil.findFieldByName(fields, report.getzFieldName()));
            modelMap.addAttribute("zGroupTypes", reportService.findGroupType(type));
        }

        logger.info("存储表单默认值");

        return "/common/report/edit";
    }

    /**
     * 修改报表
     */
    @ResponseBody
    @RequestMapping(value = "/modify.do", method = RequestMethod.POST)
    public String modify(Report report, ModelMap modelMap) {
        logger.info("修改报表");

        if (commonService.isInitialized(Report.class, report.getId())) {
            return new JsonDto("系统初始化数据不允许修改！").toString();
        }

        User user = (User) modelMap.get(Constant.VS_USER);
        AuditLog auditLog = new AuditLog(EnumModule.REPORT.getModuleName(), report.getName(), EnumOperationType.MODIFY.getOperationType(), user);
        report.setModifier(user);
        reportService.modify(report, auditLog);

        return JsonDto.modify(report.getId()).toString();
    }

    /**
     * 删除报表
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public String delete(Long[] id, @ModelAttribute(Constant.VS_USER_ID) Long sessionId) {
        logger.info("删除报表");

        if (commonService.isInitialized(Report.class, id)) {
            return new JsonDto("系统初始化数据不允许删除！").toString();
        }

        logger.info("检查是否包含当前报表");
        if (ArrayUtils.contains(id, sessionId)) {
            return new JsonDto("不允许删除当前操作报表").toString();
        }


        return JsonDto.delete(id).toString();
    }

    /**
     * 转至生成报表页面
     */
    @RequestMapping("/toGeneratePage")
    public String toGeneratePage(Long id, ModelMap modelMap) {
        logger.info("转至生成报表页面");

        Report report = reportService.get(id);
        modelMap.addAttribute("report", report);

        //查询并存储查询条件
        //所属模块时间类型字段
        modelMap.addAttribute("moduleFields", findModuleFields(report));
        modelMap.addAttribute("timeTypes", CommonCalendar.generateDateRange());

        return "/common/report/report";
    }

    public List<ModuleField> findModuleFields(Report report) {
        List<ModuleField> moduleFields = new ArrayList<ModuleField>();

        Module sourceModule = report.getModule();
        sourceModule = ReflectionUtils.findNameValueMatched(InitApplicationConstant.MODULES, "id", sourceModule.getId());
        Field[] fields = sourceModule.getFields();

        //x轴字段
        Field xAxisField = ModuleUtil.findFieldByName(fields, report.getxFieldName());
        if (ReflectionUtils.getEntityFieldType(xAxisField).equals(Date.class)) {
            moduleFields.add(FieldInfoParser.toModuleField(xAxisField));
            return moduleFields;
        }

        //z轴字段
        if (report.getzFieldName() != null) {
            Field zAxisField = ModuleUtil.findFieldByName(fields, report.getzFieldName());
            if (ReflectionUtils.getEntityFieldType(zAxisField).equals(Date.class)) {
                moduleFields.add(FieldInfoParser.toModuleField(zAxisField));
                return moduleFields;
            }
        }

        //所有时间类型字段
        List<Field> dateTypeFields = ReflectionUtils.findNameValueMatcheds(Arrays.asList(fields), "type", Date.class);
        moduleFields.addAll(FieldInfoParser.toModuleField(dateTypeFields.toArray(new Field[]{})));

        return moduleFields;
    }


    /**
     * 转至生成报表页面
     */
    @ResponseBody
    @RequestMapping("/generate")
    public String generate(Long id, HttpServletRequest request) throws NoSuchFieldException {
        logger.info("生成报表");
        logger.debug("报表主键编号={}", id);

        //获取report
        Report report = reportService.get(id);

        String timeType = request.getParameter("timeType");
        report.setTimeType(StringUtils.isNotBlank(timeType) ? Integer.parseInt(timeType) : Calendar.MONTH);
        Module module = InitApplicationConstant.findModuleById(report.getModule().getId());
        report.setModule(module);

        //获取查询条件
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.trimValue(searchParams);
        List<Field> dateTypeFields = ReflectionUtils.findNameValueMatcheds(Arrays.asList(module.getFields()), "type", Date.class);
        Search.toRangeDate(searchParams, ReflectionUtils.invokeGetterMethod(dateTypeFields, "name").toArray(new String[]{}));
        Map<String, SearchFilter> filters = Search.parse(searchParams);

        //生成报表
        ChartModel chart = reportService.generate(report, filters.values());

        JsonDto jsonDto = new JsonDto();
        BusinessResult<ChartModel> businessResult = new BusinessResult<ChartModel>(chart);
        jsonDto.setResult(businessResult);
        String result = jsonDto.toString();
        logger.debug("chart={}", result);

        return result;
    }


    /**
     * 转至生成报表页面
     */
    @ResponseBody
    @RequestMapping(value = "/reportWorkbanch.comp")
    public String generateWorkbanch(Long id, HttpServletRequest request) throws NoSuchFieldException {
        logger.info("生成报表");
        logger.debug("报表主键编号={}", id);
        //获取report
        Report report = reportService.get(id);
        Module module = InitApplicationConstant.findModuleById(report.getModule().getId());
        report.setModule(module);

        //添加时间类型
        String timeType = request.getParameter("timeType");
        if (StringUtils.isBlank(timeType)) {
            report.setTimeType(Calendar.DAY_OF_MONTH);
        } else {
            report.setTimeType(Integer.parseInt(timeType));
        }

        //获取查询条件
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.trimValue(searchParams);
        List<Field> dateTypeFields = ReflectionUtils.findNameValueMatcheds(Arrays.asList(module.getFields()), "type", Date.class);
        Search.toRangeDate(searchParams, ReflectionUtils.invokeGetterMethod(dateTypeFields, "name").toArray(new String[]{}));
        Map<String, SearchFilter> filters = Search.parse(searchParams);

        //生成报表
        ChartModel chart = reportService.generate(report, filters.values());
        return chart == null ? null : chart.getChart();
    }
}
