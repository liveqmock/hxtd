package com.baihui.hxtd.soa.system.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.system.entity.*;
import com.baihui.hxtd.soa.system.service.*;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springside.modules.web.Servlets;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 角色控制器
 *
 * @author xiayouxue
 * @date 2014/5/7
 */
@Controller
@RequestMapping(value = "/system/role")
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_DATASHIFT, Constant.VS_ORG,
        Constant.VS_MENUS, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
@SuppressWarnings("unchecked")
public class RoleController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    //    @Value("${system.role.type}")
    private String typeValue = "010501";
    //    @Value("${system.role.type.normal}")
    private String typeNormalValue = "01050101";

    @Resource
    private RoleService roleService;

    @Resource
    private CommonService commonService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private FunctionService functionService;

    @Resource
    private ComponentService componentService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }

    /**
     * 转至查询页面
     */
    @RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(HibernatePage<Role> page, Model model) throws NoSuchFieldException {
        logger.info("转至查询页面");
        logger.info("存储查询条件表单初始化数据");
        logger.info("存储查询条件表单默认值");
        logger.info("存储分页数据");
        model.addAttribute("page", page);

        return "/system/role/list";
    }

    @ResponseBody
    @RequestMapping(value = "/query.do")
    public String query(HttpServletRequest request, HibernatePage<Role> page, ModelMap model) throws NoSuchFieldException, IOException {
        logger.info("查询信息");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        logger.debug("查询条件数目“{}”", searchParams.size());

        logger.info("获取分页数据");
        page = roleService.findPage(searchParams, page, (DataShift) model.get(Constant.VS_DATASHIFT));

        logger.info("以DTO格式返回");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setResult(page);

        return HibernateAwareObjectMapper.DEFAULT.writeValueAsString(jsonDto);
    }

    /**
     * 存储表单初始化数据
     */
    public void detail(ModelMap model) {
        logger.info("存储表单初始化数据");
        List<Dictionary> types = dictionaryService.findChildren(typeValue);
        model.addAttribute("types", types);
        logger.debug("类型数目“{}”", types.size());
    }

    /**
     * 转至新增页面
     */
    @RequestMapping(value = "/toAddPage.do", method = RequestMethod.GET)
    public String toAddPage(ModelMap model) throws CloneNotSupportedException {
        logger.info("转至新增页面");

        detail(model);

        logger.info("存储表单默认值");
        Role role = new Role();
        role.setType(new Dictionary(typeNormalValue));
        model.addAttribute("role", role);
        logger.debug("角色“{}”", role.getName());

        return "/system/role/edit";
    }

    /**
     * 新增
     */
    @ResponseBody
    @RequestMapping(value = "/add.do", method = RequestMethod.POST)
    public String add(Role role, ModelMap modelMap) {
        logger.info("新增");
        logger.debug("名称“{}”", role.getName());
        role.setId(null);

        logger.info("添加服务端属性值");
        User user = (User) modelMap.get(Constant.VS_USER);
        role.setCreator(user);
        logger.debug("创建用户为当前用户“{}”", user.getName());
        role.setModifier(role.getCreator());
        logger.debug("修改用户为当前用户“{}”", user.getName());

        AuditLog auditLog = new AuditLog(EnumModule.ROLE.getModuleName(), role.getId(), role.getName(), EnumOperationType.ADD.getOperationType(), user, "角色增加");
        roleService.add(role, auditLog);

        return JsonDto.add(role.getId()).toString();
    }

    /**
     * 转至查看页面
     */
    @RequestMapping(value = "/toViewPage.do", method = RequestMethod.GET)
    public String toViewPage(Long id, ModelMap model) {
        logger.info("转至查看页面");

        logger.info("存储表单默认值");
        Role role = roleService.getById(id);
        model.addAttribute("role", role);
        logger.debug("角色“{}”", role.getName());

        return "/system/role/view";
    }

    /**
     * 转至修改页面
     */
    @RequestMapping(value = "/toModifyPage.do", method = RequestMethod.GET)
    public String toModifyPage(Long id, ModelMap model) {
        logger.info("转至修改页面");
        logger.debug("主键编号“{}”", id);

        detail(model);

        logger.info("存储表单默认值");
        Role role = roleService.getById(id);
        model.addAttribute("role", role);
        logger.debug("角色“{}”", role.getName());

        return "/system/role/edit";
    }

    /**
     * 修改
     */
    @ResponseBody
    @RequestMapping(value = "/modify.do")
    public String modify(Role role, ModelMap modelMap) {
        logger.info("修改");

        if (commonService.isInitialized(Role.class, role.getId())) {
            return new JsonDto("系统初始化数据不允许修改！").toString();
        }

        logger.info("添加服务端属性值");
        User user = (User) modelMap.get(Constant.VS_USER);
        //修改用户为当前用户
        role.setModifier(user);

        AuditLog auditLog = new AuditLog(EnumModule.ROLE.getModuleName(), role.getId(), role.getName(), EnumOperationType.MODIFY.getOperationType(), user, "角色修改");
        roleService.modify(role, auditLog);

        return JsonDto.modify(role.getId()).toString();
    }

    /**
     * 删除
     * //TODO 关于删除后，跳转回列表页面，保留原查询条件和分页数据
     * //TODO 关于删除的批量操作
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public String delete(Long[] id, ModelMap modelMap) {
        logger.info("删除");

        if (commonService.isInitialized(Role.class, id)) {
            return new JsonDto("系统初始化数据不允许删除！").toString();
        }

        User user = (User) modelMap.get(Constant.VS_USER);
        AuditLog[] auditLogArr = new AuditLog[id.length];
        for (int i = 0; i < id.length; i++) {
            auditLogArr[i] = new AuditLog(EnumModule.ROLE.getModuleName(),
                    id[i], roleService.getNameById(id[i]), EnumOperationType.DELETE.getOperationType(), user, "角色删除");
        }
        roleService.delete(id, auditLogArr);
        return JsonDto.delete(id).toString();
    }

    /**
     * 转至授权页面
     * 仅能分配个人权限范围内的功能和组件
     * 1.功能
     * 1.1.已授权
     * 1.2.未授权
     * 2.组件
     * 2.1.已授权
     * 2.2.未授权
     */
    @RequestMapping(value = "/toAuthorizationPage.do", method = RequestMethod.GET)
    public String toAuthorizationPage(Long id, ModelMap model) throws CloneNotSupportedException {
        logger.info("转至授权页面");

        logger.info("存储表单初始化数据");
        model.addAttribute("allMenus", model.get(Constant.VS_MENUS));
        List<Function> functions = (List<Function>) model.get(Constant.VS_FUNCTIONS);
        model.addAttribute("allFunctions", functionService.groupByMenuId(functions));
        model.addAttribute("allComponents", model.get(Constant.VS_COMPONENTS));

        logger.info("存储表单默认值");
        model.addAttribute("authorizationFunctions", functionService.findRoleAuthorization(id));
        model.addAttribute("authorizationComponents", componentService.findRoleAuthorization(id));

        return "/system/role/authorization";
    }

    /**
     * 授权
     * 1.角色
     * 2.功能
     * 3.组件
     */
    @ResponseBody
    @RequestMapping(value = "/authorization.do")
    public String authorization(Long id,
                                @RequestParam(value = "functionId", required = false) Long[] functionIds,
                                @RequestParam(value = "componentId", required = false) Long[] componentIds,
                                HttpServletRequest request) {
        logger.info("授权");
        User u = (User) request.getSession().getAttribute(Constant.VS_USER);
        AuditLog auditLog = new AuditLog(EnumModule.ROLE.getModuleName(),
                id, roleService.getById(id).getName(), EnumOperationType.AUTHORIZATION.getOperationType(), u, "角色授权");
        roleService.authorization(id, functionIds, componentIds, auditLog);
        return new JsonDto(id, "授权成功").toString();
    }


}
