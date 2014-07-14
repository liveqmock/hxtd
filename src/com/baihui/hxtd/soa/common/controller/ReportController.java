package com.baihui.hxtd.soa.common.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.InitApplicationConstant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ReflectionUtils;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.base.utils.report.Chart;
import com.baihui.hxtd.soa.common.entity.Module;
import com.baihui.hxtd.soa.common.entity.ModuleField;
import com.baihui.hxtd.soa.common.entity.Report;
import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.common.service.ModuleService;
import com.baihui.hxtd.soa.common.service.ModuleTypeService;
import com.baihui.hxtd.soa.common.service.ReportService;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.BusinessResult;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springside.modules.persistence.SearchFilter;
import org.springside.modules.web.Servlets;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
        modelMap.addAttribute("charts", dictionaryService.findChildren(DictionaryConstant.REPORT_CHART));

        return "/common/report/list";
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
        logger.debug("列表信息数目“{}”", page.getResult().size());

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

        Field[] fields = moduleService.findById(moduleId).getFields();
        Class type = moduleService.getFieldType(moduleService.findFieldByName(fields, fieldName));
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

    /**
     * 转至查看用户页面
     * 1.从用户列表页点击详情
     * 2.从个人设置->账号信息点击进入，此时id=session.user.id
     */
    @RequestMapping(value = "/toViewPage.do", method = RequestMethod.GET)
    public String toViewPage(Long id, ModelMap modelMap) {
        logger.info("转至查看页面");

        Report report = reportService.get(id);
        modelMap.addAttribute("report", report);

        logger.info("存储表单初默认值");

        return "/common/report/view";
    }

    /**
     * 转至修改用户页面
     */
    @RequestMapping(value = "/toModifyPage.do", method = RequestMethod.GET)
    public String toModifyPage(Long id, ModelMap modelMap) {
        logger.info("转至修改页面");
        logger.debug("主键编号“{}”", id);

        detail(modelMap);

        Report report = reportService.get(id);
        modelMap.addAttribute("report", report);
        modelMap.addAttribute("fieldModules", moduleService.findModuleAndAssociation(report.getModule().getId()));
        Field[] fields = moduleService.findById(report.getModule().getId()).getFields();
        if (StringUtils.isNotBlank(report.getxFieldName())) {
            Class type = moduleService.getFieldType(moduleService.findFieldByName(fields, report.getxFieldName()));
            modelMap.addAttribute("xGroupTypes", reportService.findGroupType(type));
        }

        if (StringUtils.isNotBlank(report.getzFieldName())) {
            Class type = moduleService.getFieldType(moduleService.findFieldByName(fields, report.getzFieldName()));
            modelMap.addAttribute("zGroupTypes", reportService.findGroupType(type));
        }

        logger.info("存储表单默认值");

        return "/common/report/edit";
    }

    /**
     * 修改用户
     */
    @ResponseBody
    @RequestMapping(value = "/modify.do", method = RequestMethod.POST)
    public String modify(Report report, ModelMap modelMap) {
        logger.info("修改用户");

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
     * 删除用户
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public String delete(Long[] id, @ModelAttribute(Constant.VS_USER_ID) Long sessionId) {
        logger.info("删除用户");

        if (commonService.isInitialized(User.class, id)) {
            return new JsonDto("系统初始化数据不允许删除！").toString();
        }

        logger.info("检查是否包含当前用户");
        if (ArrayUtils.contains(id, sessionId)) {
            return new JsonDto("不允许删除当前操作用户").toString();
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
        Module sourceModule = report.getModule();
        sourceModule = ReflectionUtils.findNameValueMatched(InitApplicationConstant.MODULES, "id", sourceModule.getId());
        Field[] fields = sourceModule.getFields();
        List<Field> dateTypeFields = ReflectionUtils.findNameValueMatcheds(Arrays.asList(fields), "type", Date.class);
        List<ModuleField> moduleFields = moduleService.toModuleField(dateTypeFields.toArray(new Field[]{}));
        modelMap.addAttribute("moduleFields", moduleFields);

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        modelMap.addAttribute("time", format.format(new Date()));

        return "/common/report/report";
    }


    /**
     * 转至生成报表页面
     */
    @ResponseBody
    @RequestMapping("/generate")
    public String generate(Long id, HttpServletRequest request) throws NoSuchFieldException {
        logger.info("生成报表");

        logger.debug("报表主键编号={}", id);
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Map<String, SearchFilter> filters = Search.parse(searchParams);

        Report report = reportService.get(id);
        report.setModule(moduleService.findById(report.getModule().getId()));

        Chart chart = reportService.generate(report, filters);
        JsonDto jsonDto = new JsonDto();
        BusinessResult<Chart> businessResult = new BusinessResult<Chart>(chart);
        jsonDto.setResult(businessResult);

        String result = jsonDto.toString();
        logger.debug("chart={}", result);

        return result;
    }


}
