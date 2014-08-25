package com.baihui.hxtd.soa.system.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.baihui.hxtd.soa.system.entity.Component;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Function;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.Role;
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
        User user = (User) model.get(Constant.VS_USER);
        model.addAttribute("userId", user.getId());
        logger.debug("组织主键编号“{}”", organization.getId());

        page.setHibernateOrderBy("modifiedTime");
        page.setHibernateOrder(HibernatePage.DESC);
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
        page = userService.findPage(searchParams, page, organizationId);
        logger.debug("列表信息数目“{}”", page.getResult().size());

        logger.info("转换为TDO格式");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setResult(page);

        return jsonDto.toString();
    }
    
    /**
     * 存储表单初始化数据
     */
    public void detail(ModelMap model) {
        logger.info("存储表单初始化数据");

        List<Dictionary> sexs = dictionaryService.findChildren(DictionaryConstant.PUBLIC_SEX);
        model.addAttribute("sexs", sexs);
        logger.debug("性别数目“{}”", sexs.size());

        List<Dictionary> jobsituation = dictionaryService.findChildren(DictionaryConstant.USER_JOBSITUATION);
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
    public String toAddPage(Long organizationId, ModelMap model, String type) {
        logger.info("转至新增用户页面");

        detail(model);

        logger.info("存储表单默认值");
        User defaultUser = new User();
        defaultUser.setSex(new Dictionary(dictionaryService.getIdByValue(DictionaryConstant.PUBLIC_SEX_MAN)));
        defaultUser.setIsManager(false);
        defaultUser.setIsActive(true);
        defaultUser.setOrganization(organizationService.getByOrder(organizationId));
        model.addAttribute("user", defaultUser);
        model.addAttribute("type", type);
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
     * 1.从个人设置->账号信息点击进入，此时id=session.user.id
     */
    @RequestMapping("/toViewSelfPage.do")
    public String toViewSelfPage(ModelMap model) {
        return toViewPage(((User) model.get(Constant.VS_USER)).getId(), model,"");
    }

    /**
     * 转至查看用户页面
     * 1.从用户列表页点击详情
     * 2.从个人设置->账号信息点击进入，此时id=session.user.id
     */
    @RequestMapping(value = "/toViewPage.do", method = RequestMethod.GET)
    public String toViewPage(Long id, ModelMap model, String type) {
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
        model.addAttribute("type", type);
        return "/system/user/view";
    }

    /**
     * 转至修改用户页面
     */
    @RequestMapping(value = "/toModifyPage.do", method = RequestMethod.GET)
    public String toModifyPage(Long id, ModelMap model, String type) {
        logger.info("转至修改用户页面");
        logger.debug("用户主键编号“{}”", id);
        User user = userService.getById(id);
        detail(model);
        logger.info("存储表单默认值");
        model.addAttribute("user", user);
        model.addAttribute("type", type);
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
        //获取用户的角色
        Set<Role> roles=new HashSet<Role>();
        roles.addAll(roleService.findAuthorization(user.getId()));
        user.setRoles(roles);
        //获取用户的功能
        Set<Function> functions=new HashSet<Function>();
        functions.addAll(functionService.findUserAuthorization(user.getId()));
        user.setFunctions(functions);
        //获取用户的组件
        Set<Component> components=new HashSet<Component>();
        components.addAll(componentService.findUserAuthorization(user.getId()));
        user.setComponents(components);
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
        User sessionUser = userService.getById(sessionId);

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
        List<Function> functionList = functionService.findReferAuthorization(id);
        model.addAttribute("allAuthorizationFunctions", functionList);
        model.addAttribute("authorizationFunctions", functionService.findUserAuthorization(id));
        model.addAttribute("allAuthorizationComponents", componentService.findReferAuthorization(id));
        model.addAttribute("authorizationComponents", componentService.findUserAuthorization(id));
        model.addAttribute("id", id);
        return "/system/user/authorization";
    }

    @ResponseBody
    @RequestMapping(value = "/toAuthorizationPage.do", params = "TYPE=show")
    public String toAuthorization(Long roleId) {
        List<Long> funIds = roleService.findFunByRoleId(roleId);
        List<Long> comIds = roleService.findComByRoleId(roleId);
        StringBuffer sb = new StringBuffer(",");
        StringBuffer comsb = new StringBuffer(",");
        for (Long function : funIds) {
            sb.append(function + ",");
        }
        for (Long component : comIds) {
            comsb.append(component + ",");
        }
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setMessage(sb.toString() + "|" + comsb.toString());
        return jsonDto.toString();
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
                                ModelMap model) {
        logger.info("授权");
        User user = (User) model.get(Constant.VS_USER);
        if(user.getId()==id||id==null){
        	return new JsonDto(id, "用户不能给自己授权").toString();
        }
        AuditLog auditLog = new AuditLog(EnumModule.USER.getModuleName(),
                 id, userService.getById(id).getRealName(), EnumOperationType.AUTHORIZATION.getOperationType(), user, "用户授权");
        userService.authorization( id, roleIds, functionIds, componentIds, auditLog);
        return new JsonDto(id, "授权成功").toString();
    }

    /**
     * 重置密码
     */
    @ResponseBody
    @RequestMapping(value = "/resetPassword.do")
    public String resetPassword(Long[] id, ModelMap model) {
        logger.info("重置密码");

        User user = (User) model.get(Constant.VS_USER);
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
    public String enable(Long[] id, ModelMap model) {
        logger.info("启用用户");

        User user = (User) model.get(Constant.VS_USER);
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
    public String disable(Long[] id, ModelMap model) {
        logger.info("禁用用户");

        User user = (User) model.get(Constant.VS_USER);
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
        for (User user : users) {
            user.setCreator(sessionUser);
            user.setModifier(sessionUser);
            user.setOrganization(organization);
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
        String name = "user";
        Workbook workbook = ImportExport.exportExcel(response, servletContext, name, users);
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("Content-Disposition", "attachment; filename=" + name + ".xls");
        workbook.write(response.getOutputStream());
        User user = (User) modelMap.get(Constant.VS_USER);
        commonService.saveAuditlog(ImportExport.Type.limit, name, user, users.size());
    }

    /**
     * 弹出组织结构树，只显示下级组织
     *
     * @param model
     * @return json
     * @throws NoSuchFieldException
     * @author huizijing
     * @since 2014-7-22
     */
    @RequestMapping(value = "/toQueryUser.comp", params = "TYPE=business")
    public String toOwnerOrgTree(ModelMap model) throws NoSuchFieldException {
        //获取当前组织
        Organization organization = (Organization) model.get(Constant.VS_ORG);
        //得到当前组织下的子组织
        List<Organization> orgList = organizationService.findChildren(organization.getId());
        //orgList.add(organization);
        User u = (User) model.get(Constant.VS_USER);
        StringBuffer sb = new StringBuffer("[");
        sb.append("{id:" + u.getId() + ", name:\"" + u.getRealName() + "\", pId:" + 0 + ", type:\"user\"},");
        Long oldOrgId = 0l;
        for (int i = 0; i < orgList.size(); i++) {
            Organization org = orgList.get(i);
            if (org.getId() == oldOrgId || orgList.get(i).getOwners().size() == 0) {
                continue;
            }
            sb.append(String.format("{id:-%s, name:\"%s\", pId:-%s, type:\"%s\"},", new Object[]{
                    org.getId(),
                    org.getName(),
                    org.getParent() == null ? "0" : org.getParent().getId(),
                    "org"
            }));

            for (User user : org.getOwners()) {//用户
            	if(!user.getIsDeleted()){
                sb.append(String.format("{id:%s, name:\"%s\", pId:-%s, type:\"%s\"},", new Object[]{
                        user.getId(),
                        user.getRealName(),
                        org.getId(),
                        "user",
                }));
            	}
            }
            oldOrgId = org.getId();
        }
        //sb.append("{id:"+u.getId()+", name:\""+u.getRealName()+"\", pId:"+-u.getOrganization().getId()+", type:\"user\"},");
        sb.toString().substring(0, sb.toString().length() - 2);
        sb.append("]");
        model.addAttribute("json", sb.toString());
        return "/system/message/listcomp";
    }

    /**
     * 弹出组织结构树,所有的用户
     *
     * @param model
     * @return json
     * @throws NoSuchFieldException
     * @author huizijing
     * @since 2014-6-17
     */
    @RequestMapping(value = "/toQueryUser.comp")
    public String toAllOwnerOrgTree(ModelMap model) throws NoSuchFieldException {
        User u = (User) model.get(Constant.VS_USER);
        List<Organization> orgList = organizationService.getAllOrgAndUsers();
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
            List<User> users=userService.findUserByOrgId(org.getId());
            for (User user : users) {//用户
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
    public String toModifyPwd(ModelMap model) {
        logger.info("转至修改密码页面");
        User user = (User) model.get(Constant.VS_USER);
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
    public String modifyPwd(String password, Long id, ModelMap model) {

        User user = (User) model.get(Constant.VS_USER);
        AuditLog auditLog = new AuditLog(EnumModule.USER.getModuleName(),
                user.getId(), user.getRealName(), EnumOperationType.MODIFYPASSWORD.getOperationType(), user, "用户修改密码");
        userService.modifyPasswordById(id, password, auditLog);
        JsonDto jsonDto = new JsonDto("修改密码成功");
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
    }

    @ResponseBody
    @RequestMapping(value = "/checkPwd")
    public String checkPwd(String oldpwd, ModelMap model) {
        User user = (User) model.get(Constant.VS_USER);
        JsonDto jsonDto = new JsonDto();
        if (md5.getMD5ofStr(oldpwd).equals(user.getPassword())) {
            jsonDto.setMessage("");
        } else {
            jsonDto.setMessage("原密码不正确");
        }
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
    }

    /**
      * toSearchUserLst(请求搜索用户信息列表组件页)
      * @Title: toSearchUserLst
      * @Description: 请求搜索用户信息列表组件页
      * @param page 分页设置
      * @param roleCode 角色代码
      * @param model 模型
      * @return String 用户组件地址
     */
    @RequestMapping(value = "/toSearchUserPage.docomp")
    public String toSearchUserLst(HibernatePage<User> page, String roleCode, ModelMap model) {
        page.setHibernatePageSize(12);// 设置每页显示12个用户
        model.addAttribute("page", page);
        model.addAttribute("orgId", model.get(Constant.VS_ORG_ID));
        model.addAttribute("roleCode", roleCode);
        
        return "/system/user/listcomp";
    }
    /**
      * searchUser(搜索用户信息列表)
      * @Title: searchUser
      * @Description: 搜索用户信息列表，比如：负责人、所有者等
      * @param request HttpServlet请求
      * @param organizationId 组织ID
      * @param page 分页设置
      * @param modelMap 模型
      * @return String Json
      * @throws NoSuchFieldException
     */
    @ResponseBody
    @RequestMapping(value = "/searchUser.docomp")
    public String searchUser(HttpServletRequest request, 
    		Long organizationId, 
    		HibernatePage<User> page, 
    		ModelMap modelMap) throws NoSuchFieldException {
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.trimValue(searchParams);
        
        page = userService.findPage(searchParams, page, organizationId);

        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setResult(page);

        return jsonDto.toString();
    }
    @ResponseBody
    @RequestMapping(value = "/searchUser.docomp", params = "TYPE=role")
    public String queryByRoleCode(HibernatePage<User> page,String roleCode) throws NoSuchFieldException {
        page = userService.findPageByRoleCode(page, roleCode);
        
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setResult(page);
        
        return jsonDto.toString();
    }
}
