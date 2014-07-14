package com.baihui.hxtd.soa.system.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.BidiMap;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.MD5;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.base.utils.mapper.JsonMapper;
import com.baihui.hxtd.soa.base.utils.ztree.TreeNodeConverter;
import com.baihui.hxtd.soa.common.controller.CommonController;
import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Function;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.ComponentService;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.system.service.FunctionService;
import com.baihui.hxtd.soa.system.service.OrganizationService;
import com.baihui.hxtd.soa.system.service.RoleService;
import com.baihui.hxtd.soa.system.service.UserService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonProcessingException;

/**
 * 用户控制器
 *
 * @author xiayouxue
 * @date 2014/5/7
 */
@Controller
@RequestMapping(value = "/system/user")
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_ORG, Constant.VS_DATASHIFT,
        Constant.VS_MENUS, Constant.VS_ROLES, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
public class UserController extends CommonController<User> {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    //    @Value("${system.user.type}")
    private String typeValue = "010401";
    //    @Value("${system.user.type.manager}")
//    private String typeManagerValue = "01040101";
    //    @Value("${system.user.type.normal}")
//    private String typeNormalValue = "01040102";
    //    @Value("${system.user.jobsituation}")
    private String jobsituationValue = "010403";
    //    @Value("${system.user.jobsituation.on}")
    private String jobsituationOnValue = "01040301";

    @Resource
    private UserService userService;

    @Resource
    private CommonService commonService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private RoleService roleService;

    @Resource
    private FunctionService functionService;

    @Resource
    private ComponentService componentService;

    @Resource
    private OrganizationService organizationService;

    @Resource
    private MD5 md5;

    /**
     * 转至查询用户页面
     */
    @RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(HibernatePage<User> page, ModelMap model) {
        logger.info("转至查询页面");

        logger.info("存储表单初始化数据");
        Organization organization = (Organization) model.get(Constant.VS_ORG);
        List<Organization> organizations = organizationService.findChildrenById(organization.getId());
        organizations.add(organization);
        String organizationTree = JsonMapper.nonEmptyMapper().toJson(TreeNodeConverter.convert(organizations));
        model.addAttribute("organizationTree", organizationTree);

        logger.info("存储表单默认值");
        model.addAttribute("organizationId", organization.getId());
        model.addAttribute("organizationOrder", organization.getOrder());
        logger.debug("组织主键编号“{}”", organization.getId());

        page.setHibernateOrderBy("createdTime");
        page.setHibernateOrder("desc");
        model.addAttribute("userPage", page);

        return "/system/user/list";
    }

    @ResponseBody
    @RequestMapping(value = "/query.do")
    public String query(HttpServletRequest request, Long organizationId, HibernatePage<User> page, ModelMap modelMap) throws NoSuchFieldException, JsonProcessingException {
        logger.info("查询用户信息");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.trimValue(searchParams);
        Search.toRangeDate(searchParams, "modifiedTime");
        logger.debug("查询条件数目“{}”", searchParams.size());

        logger.info("查询分页列表信息");
        page = userService.findPage(searchParams, page, (User) modelMap.get(Constant.VS_USER), organizationId);
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
    public void detail(ModelMap model) {
        logger.info("存储表单初始化数据");

        List<Dictionary> sexs = dictionaryService.findChildren("0001");
        model.addAttribute("sexs", sexs);
        logger.debug("性别数目“{}”", sexs.size());

        List<Dictionary> types = dictionaryService.findChildren(typeValue);
        model.addAttribute("types", types);
        logger.debug("类型数目“{}”", types.size());

        List<Dictionary> jobsituation = dictionaryService.findChildren(jobsituationValue);
        model.addAttribute("jobsituations", jobsituation);
        logger.debug("工作状态数目“{}”", jobsituation.size());

        Organization organization = (Organization) model.get(Constant.VS_ORG);
        List<Organization> organizations = organizationService.findChildrenById(organization.getId());
        organizations.add(0, organization);
        model.addAttribute("organizationTree", JsonMapper.nonEmptyMapper().toJson(TreeNodeConverter.convert(organizations)));
        logger.debug("组织数目“{}”", organizations.size());
    }

    /**
     * 转至新增用户页面
     */
    @RequestMapping(value = "/toAddPage.do", method = RequestMethod.GET)
    public String toAddPage(Long organizationId, ModelMap model) {
        logger.info("转至新增用户页面");

        detail(model);

        logger.info("存储表单默认值");
        User defaultUser = new User();
        defaultUser.setSex(new Dictionary(dictionaryService.getIdByValue(DictionaryConstant.PUBLIC_SEX_MAN)));
        defaultUser.setIsManager(false);
        defaultUser.setIsActive(true);
        defaultUser.setOrganization(organizationService.getByOrder(organizationId));
        model.addAttribute("user", defaultUser);
        logger.debug("用户“{}”", defaultUser);

        return "/system/user/edit";
    }

    /**
     * 新增用户
     */
    @ResponseBody
    @RequestMapping(value = "/add.do", method = RequestMethod.POST)
    public String add(User user, ModelMap modelMap) {
        logger.info("新增用户");
        logger.debug("用户名“{}”", user.getName());

        logger.info("添加服务端属性值");
        User sessionUser = (User) modelMap.get(Constant.VS_USER);
        user.setCreator(sessionUser);
        logger.debug("创建用户为当前用户“{}”", sessionUser.getName());
        user.setModifier(user.getCreator());
        logger.debug("修改用户为当前用户“{}”", sessionUser.getName());

        AuditLog auditLog = new AuditLog(EnumModule.USER.getModuleName(),
                user.getId(), user.getRealName(), EnumOperationType.ADD.getOperationType(), sessionUser);
        userService.add(user, auditLog);

        return JsonDto.add(user.getId()).toString();
    }

    /**
     * 转至查看用户页面
     * 1.从用户列表页点击详情
     * 2.从个人设置->账号信息点击进入，此时id=session.user.id
     */
    @RequestMapping(value = "/toViewPage.do", method = RequestMethod.GET)
    public String toViewPage(Long id, ModelMap model) {
        logger.info("转至查看用户页面");

        //默认为当前用户主键编号
        if (id == null) {
            id = ((User) model.get(Constant.VS_USER)).getId();
        }
        User user = userService.getById(id);

        logger.info("存储表单初始化值");
        Organization organization = (Organization) model.get(Constant.VS_ORG);
        List<Organization> organizations = organizationService.findSector(organization.getOrder(), user.getOrganization().getOrder());
        model.addAttribute("organizationTree", JsonMapper.nonEmptyMapper().toJson(TreeNodeConverter.convert(organizations)));

        logger.info("存储表单初默认值");
        model.addAttribute("user", user);

        return "/system/user/view";
    }

    /**
     * 转至修改用户页面
     */
    @RequestMapping(value = "/toModifyPage.do", method = RequestMethod.GET)
    public String toModifyPage(Long id, ModelMap model) {
        logger.info("转至修改用户页面");
        logger.debug("用户主键编号“{}”", id);
        User user = userService.getById(id);

        detail(model);

        logger.info("存储表单默认值");
        model.addAttribute("user", user);
        logger.debug("用户“{}”", user.getName());

        return "/system/user/edit";
    }

    /**
     * 修改用户
     */
    @ResponseBody
    @RequestMapping(value = "/modify.do", method = RequestMethod.POST)
    public String modify(User user, ModelMap modelMap) {
        logger.info("修改用户");

        if (commonService.isInitialized(User.class, user.getId())) {
            return new JsonDto("系统初始化数据不允许修改！").toString();
        }

        logger.info("添加服务端属性值");
        User sessionUser = (User) modelMap.get(Constant.VS_USER);
        user.setModifier(sessionUser);
        logger.debug("修改用户为当前用户“{}”", sessionUser.getName());

        AuditLog auditLog = new AuditLog(EnumModule.USER.getModuleName(),
                user.getId(), user.getRealName(), EnumOperationType.MODIFY.getOperationType(), sessionUser);
        userService.modify(user, auditLog);

        return JsonDto.modify(user.getId()).toString();
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
        User sessionUser = (User) userService.getById(sessionId);

        AuditLog[] auditLogArr = new AuditLog[id.length];
        for (int i = 0; i < id.length; i++) {
            auditLogArr[i] = new AuditLog(EnumModule.USER.getModuleName(),
                    id[i], userService.getNameById(id[i]), EnumOperationType.DELETE.getOperationType(), sessionUser);
        }
        userService.delete(id, auditLogArr);

        return JsonDto.delete(id).toString();
    }

    /**
     * 转至授权页面
     * 仅能分配个人权限范围内的角色、功能和组件
     * 1.角色
     * 1.1.已授权
     * 1.2.未授权
     * 2.功能
     * 2.1.已授权
     * 2.2.未授权
     * 3.组件
     * 3.1.已授权
     * 3.2.未授权
     */
    @SuppressWarnings("unchecked")
	@RequestMapping(value = "/toAuthorizationPage.do", method = RequestMethod.GET)
    public String toAuthorizationPage(Long id, ModelMap model) {
        logger.info("转至授权页面");

        logger.info("存储表单初始化数据");
        User user = (User) model.get(Constant.VS_USER);
        model.addAttribute("allRoles", roleService.findValid(user));
        model.addAttribute("allMenus", model.get(Constant.VS_MENUS));
        List<Function> functions = (List<Function>) model.get(Constant.VS_FUNCTIONS);
        model.addAttribute("allFunctions", functionService.groupByMenuId(functions));
        model.addAttribute("allComponents", model.get(Constant.VS_COMPONENTS));

        logger.info("存储表单默认值");
        model.addAttribute("organizationInheritRoles", roleService.findOrganizationInherit(id));
        model.addAttribute("authorizationRoles", roleService.findAuthorization(id));
        model.addAttribute("allAuthorizationFunctions", functionService.findReferAuthorization(id));
        model.addAttribute("authorizationFunctions", functionService.findUserAuthorization(id));
        model.addAttribute("allAuthorizationComponents", componentService.findReferAuthorization(id));
        model.addAttribute("authorizationComponents", componentService.findUserAuthorization(id));
        model.addAttribute("id", id);
        return "/system/user/authorization";
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
                                @RequestParam(value = "roleId", required = false) Long[] roleIds,
                                @RequestParam(value = "functionId", required = false) Long[] functionIds,
                                @RequestParam(value = "componentId", required = false) Long[] componentIds,
                                HttpServletRequest request) {
        logger.info("授权");
        User u = (User) request.getSession().getAttribute(Constant.VS_USER);
        AuditLog auditLog = new AuditLog(EnumModule.USER.getModuleName(),
                null == id ? u.getId() : id, null == id ? u.getRealName() : userService.getById(id).getRealName(), EnumOperationType.AUTHORIZATION.getOperationType(), u, "用户授权");
        userService.authorization(null == id ? u.getId():id, roleIds, functionIds, componentIds, auditLog);
        return new JsonDto(id, "授权成功").toString();
    }

    /**
     * 重置密码
     */
    @ResponseBody
    @RequestMapping(value = "/resetPassword.do")
    public String resetPassword(Long[] id, HttpServletRequest request) {
        logger.info("重置密码");

        User user = (User) request.getSession().getAttribute(Constant.VS_USER);
        AuditLog[] auditLogArr = new AuditLog[id.length];
        for (int i = 0; i < id.length; i++) {
            auditLogArr[i] = new AuditLog(EnumModule.USER.getModuleName(),
                    id[i], userService.getNameById(id[i]), EnumOperationType.RESETPASSWORD.getOperationType(), user, "重置密码");
        }
        userService.resetPasswordByIds(id, auditLogArr);

        JsonDto jsonDto = new JsonDto("重置密码成功");
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
    }

    /**
     * 启用用户
     */
    @ResponseBody
    @RequestMapping(value = "/enable.do")
    public String enable(Long[] id, HttpServletRequest request) {
        logger.info("启用用户");

        User user = (User) request.getSession().getAttribute(Constant.VS_USER);
        AuditLog[] auditLogArr = new AuditLog[id.length];
        for (int i = 0; i < id.length; i++) {
            auditLogArr[i] = new AuditLog(EnumModule.USER.getModuleName(),
                    id[i], userService.getNameById(id[i]), EnumOperationType.ENABLE.getOperationType(), user, "启用用户");
        }
        userService.modifyIsActiveByIds(id, true, auditLogArr);

        JsonDto jsonDto = new JsonDto("启用成功");
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
    }

    /**
     * 禁用用户
     */
    @ResponseBody
    @RequestMapping(value = "/disable.do")
    public String disable(Long[] id, HttpServletRequest request) {
        logger.info("禁用用户");

        User user = (User) request.getSession().getAttribute(Constant.VS_USER);
        AuditLog[] auditLogArr = new AuditLog[id.length];
        for (int i = 0; i < id.length; i++) {
            auditLogArr[i] = new AuditLog(EnumModule.USER.getModuleName(),
                    id[i], userService.getNameById(id[i]), EnumOperationType.DISABLE.getOperationType(), user, "禁用用户");
        }
        userService.modifyIsActiveByIds(id, false, auditLogArr);

        JsonDto jsonDto = new JsonDto("禁用成功");
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
    }


    @RequestMapping(value = "/toImportPage.do")
    public String toImportPage(ModelMap model) throws NoSuchFieldException {
        model.addAttribute("templateName", "user.xls");
        return "/system/user/import";
    }

    @SuppressWarnings("unchecked")
	@RequestMapping(value = "/import.do")
    public String imports(MultipartFile file, HttpSession session,
                          @RequestParam(defaultValue = "/system/user/toQueryPage.do") String redirectUri,
                          @ModelAttribute(Constant.VS_USER) User sessionUser,
                          @ModelAttribute(Constant.VS_ORG) Organization organization,
                          ModelMap modelMap,
                          RedirectAttributes model) throws IOException, InvalidFormatException {

        logger.info("导入excel文件");

        logger.info("检查文件是否为空");
        if (file.getSize() == 0) {
            modelMap.addAttribute(Constant.VM_BUSINESS, "未选择导入文件");
            return "forward:/system/user/toImportPage.do";
        }

        logger.info("检查文件扩展名");
        String extension = FilenameUtils.getExtension(file.getOriginalFilename());
        if (!"xls,xlsx".contains(extension)) {
            modelMap.addAttribute(Constant.VM_BUSINESS, "不支持的文件类型");
            return "forward:/system/user/toImportPage.do";
        }

        logger.info("根据excel文件解析出对象集合");
        ServletContext servletContext = session.getServletContext();
        Map<String, BidiMap> descNames = (Map<String, BidiMap>) servletContext.getAttribute(Constant.VC_DESCNAMES);

        Workbook workbook = ImportExport.create(file.getInputStream());
        List<User> users = ImportExport.imports(workbook, descNames.get("user"), User.class);

        logger.info("设置默认的属性值");
        Dictionary jobsituation = dictionaryService.getByValue(jobsituationOnValue);
        for (User user : users) {
            user.setCreator(sessionUser);
            user.setModifier(sessionUser);
            user.setOrganization(organization);
            user.setJobSituation(jobsituation);
        }
        logger.debug("导入信息“{}”", HibernateAwareObjectMapper.DEFAULT.writeValueAsString(users));
        logger.debug("对象集合数目“{}”", users.size());

        //userService.addList(users, sessionUser);

        logger.info("添加操作提示");
        model.addFlashAttribute(Constant.VM_BUSINESS, "导入成功");

        logger.info("重定向至“{}”", redirectUri);
        return "redirect:" + redirectUri;
    }

    /**
     * 带条件导出
     * 1.在分页列表上根据当前条件进行导出
     */
    @RequestMapping(value = "/export.do", params = "TYPE=pagination")
    public void exportCondition(HttpServletRequest request, Long organizationId, ModelMap modelMap, HttpServletResponse response) throws NoSuchFieldException, IOException {
        logger.info("导出excel文件");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.decodeValue(searchParams);
        logger.debug("查询条件数目“{}”", searchParams.size());

        logger.info("获取对象集合");
        if (organizationId == null) {
            organizationId = (Long) modelMap.get(Constant.VS_ORG_ID);
        }
        List<User> users = userService.find(searchParams, organizationId);
        logger.debug("列表信息数目“{}”", users.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "user", users).write(response.getOutputStream());
    }

    /**
     * 导出限制数据
     * 1.指定最大条数的
     */
    @RequestMapping(value = "/export.do", params = "TYPE=limit")
    public void exportLimit(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        logger.info("导出excel文件");

        List<User> users = userService.find((Long) modelMap.get(Constant.VS_ORG_ID));
        logger.debug("列表信息数目“{}”", users.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "user", users).write(response.getOutputStream());
    }


    /**
     * toOwnerLstPage(跳转至所有者组件列表界面)
     *
     * @param page  分页设置
     * @param model ModelMap
     * @return String 用户组件视图
     */
    @RequestMapping(value = "/toQueryPage.comp")
    public String toOwnerLstPage(
            HibernatePage<User> page,
            ModelMap model) {
        page.setHibernatePageSize(12);// 设置每页显示12个用户
        model.addAttribute("page", page);
        model.addAttribute("orgId", model.get(Constant.VS_ORG_ID));

        return "/system/user/listcomp";
    }


    /**
     * 弹出组织结构树
     *
     * @param model
     * @param request
     * @return json
     * @throws NoSuchFieldException
     * @author huizijing
     * @since 2014-6-17
     */
    @RequestMapping(value = "/toQueryUser.comp")
    public String toOwnerOrgTree(ModelMap model, HttpServletRequest request) throws NoSuchFieldException {
        List<Organization> orgList = organizationService.getOrgAndUsers();
        User u = (User) request.getSession().getAttribute(Constant.VS_USER);
        StringBuffer sb = new StringBuffer("[");
        Long oldOrgId = 0l;
        for (int i = 0; i < orgList.size(); i++) {
            Organization org = orgList.get(i);
            if (org.getId() == oldOrgId) {
                continue;
            }

            sb.append(String.format("{id:-%s, name:\"%s\", pId:-%s, type:\"%s\"},", new Object[]{
            		org.getId(),
                    org.getName(),
                    org.getParent() == null ? "0" : org.getParent().getId(),
                    "org"
            }));
            for (User user : org.getOwners()) {//用户
                sb.append(String.format("{id:%s, name:\"%s\", pId:-%s, type:\"%s\",chkDisabled:%s},", new Object[]{
                        user.getId(),
                        user.getRealName(),
                        org.getId(),
                        "user",
                        user.getId() == u.getId() ? true : false
                }));
            }
            oldOrgId = org.getId();
        }
        sb.toString().substring(0, sb.toString().length() - 2);
        sb.append("]");
        model.addAttribute("json", sb.toString());
        return "/system/message/listcomp";
    }

    /**
     * 修改密码跳转页
     *
     * @author huizijing
     * @since 2014-6-30
     */
    @RequestMapping(value = "/toModifyPasswordPage.do")
    public String toModifyPwd(User user, ModelMap model, HttpServletRequest request) {
        logger.info("转至修改密码页面");
        user = (User) request.getSession().getAttribute(Constant.VS_USER);
        String funcUrl = "/system/user/modifyPassword.do";
        model.addAttribute("user", user);
        model.addAttribute("funcUrl", funcUrl);
        logger.debug("用户“{}”", user.getName());
        return "/system/user/password";
    }

    /**
     * 修改密码
     *
     * @author huizijing
     * @since 2014-6-30
     */
    @ResponseBody
    @RequestMapping(value = "/modifyPassword.do")
    public String modifyPwd(String password, Long id,HttpServletRequest request) {

    	User u = (User) request.getSession().getAttribute(Constant.VS_USER);
        AuditLog auditLog = new AuditLog(EnumModule.USER.getModuleName(), 
        		u.getId(), u.getRealName(), EnumOperationType.MODIFYPASSWORD.getOperationType(), u,"用户修改密码");
    	userService.modifyPasswordById(id, password,auditLog);
        JsonDto jsonDto = new JsonDto("修改密码成功");
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
    }

    @ResponseBody
    @RequestMapping(value = "/checkPwd")
    public String checkPwd(String oldpwd, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute(Constant.VS_USER);
        JsonDto jsonDto = new JsonDto();
        if (md5.getMD5ofStr(oldpwd).equals(user.getPassword())) {
            jsonDto.setMessage("");
        } else {
            jsonDto.setMessage("原密码不正确");
        }
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
    }

}
