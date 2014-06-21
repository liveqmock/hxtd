package com.baihui.hxtd.soa.system.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.base.utils.mapper.JsonMapper;
import com.baihui.hxtd.soa.base.utils.ztree.TreeNodeConverter;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Function;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.*;
import com.baihui.hxtd.soa.util.JsonDto;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

/**
 * 用户控制器
 *
 * @author xiayouxue
 * @date 2014/5/7
 */
@Controller
@RequestMapping(value = "/system/user")
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_ORG_ORDER_MIN, Constant.VS_ORG_ORDER_MAX, Constant.VS_ORG,
        Constant.VS_MENUS, Constant.VS_ROLES, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
@SuppressWarnings("unchecked")
public class UserController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    //    @Value("${system.user.type}")
    private String typeValue = "010401";
    //    @Value("${system.user.type.manager}")
    private String typeManagerValue = "01040101";
    //    @Value("${system.user.type.normal}")
    private String typeNormalValue = "01040102";
    //    @Value("${system.user.jobsituation}")
    private String jobsituationValue = "010403";
    //    @Value("${system.user.jobsituation.on}")
    private String jobsituationOnValue = "01040301";

    @Resource
    private UserService userService;
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

    /**
     * 转至查询用户页面
     */
    @RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(HibernatePage<User> page, ModelMap model) throws NoSuchFieldException {
        logger.info("转至查询页面");

        logger.info("存储表单初始化数据");
        Organization organization = (Organization) model.get(Constant.VS_ORG);
        List<Organization> organizations = organizationService.findChildrenById(organization.getId());
        organizations.add(organization);
        model.addAttribute("organizationTree", JsonMapper.nonEmptyMapper().toJson(TreeNodeConverter.convert(organizations)));

        logger.info("存储表单默认值");
        Long organizationId = (Long) model.get(Constant.VS_ORG_ID);
        model.addAttribute("organizationId", organizationId);
        Long organizationOrder = (Long) model.get(Constant.VS_ORG_ORDER_MIN);
        model.addAttribute("organizationOrder", organizationOrder);
        logger.debug("组织主键编号“{}”", organizationId);

        page.setHibernateOrderBy("modifiedTime");
        page.setHibernateOrder("desc");
        model.addAttribute("page", page);

        return "/system/user/list";
    }

    @RequestMapping(value = "/query.do")
    public void query(HttpServletRequest request, Long organizationId, HibernatePage<User> page, PrintWriter out) throws NoSuchFieldException, IOException {
        logger.info("查询用户信息");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.trimValue(searchParams);
        Search.toRangeDate(searchParams, "createTime");
        logger.debug("查询条件数目“{}”", searchParams.size());

        logger.info("查询分页列表信息");
        page = userService.findPage(searchParams, page, organizationId);
        logger.debug("列表信息数目“{}”", page.getResult().size());


        logger.info("转换为TDO格式");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setMessage("请求数据成功！");
        jsonDto.setResult(page);

        HibernateAwareObjectMapper.DEFAULT.writeValue(out, jsonDto);
    }

    /**
     * 存储表单初始化数据
     */
    public void detail(ModelMap model, Long organizationOrder) {
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

        Long orderMin = (Long) model.get(Constant.VS_ORG_ORDER_MIN);
        List<Organization> organizations = organizationService.findSector(orderMin, organizationOrder);
        model.addAttribute("organizationTree", JsonMapper.nonEmptyMapper().toJson(TreeNodeConverter.convert(organizations)));
    }

    /**
     * 转至新增用户页面
     */
    @RequestMapping(value = "/toAddPage.do", method = RequestMethod.GET)
    public String toAddPage(Long organizationOrder, ModelMap model) {
        logger.info("转至新增用户页面");

        detail(model, organizationOrder);

        logger.info("存储表单默认值");
        User defaultUser = new User();
        defaultUser.setIsManager(false);
        defaultUser.setIsActive(true);
        defaultUser.setOrganization(organizationService.getByOrder(organizationOrder));
        model.addAttribute("user", defaultUser);
        logger.debug("用户“{}”", defaultUser);

        return "/system/user/edit";
    }

    /**
     * 新增用户
     */
    @RequestMapping(value = "/add.do", method = RequestMethod.POST)
    public String add(User user,
                      @RequestParam(defaultValue = "/system/user/toModifyPage.do?id=%s") String redirectUri,
                      @ModelAttribute(Constant.VS_USER_ID) Long userId,
                      RedirectAttributes model) {
        logger.info("新增用户");
        logger.debug("用户名“{}”", user.getName());

        logger.info("添加服务端属性值");
        user.setCreator(new User(userId));
        logger.debug("创建用户为当前用户“{}”", userId);
        user.setModifier(user.getCreator());
        logger.debug("修改用户为当前用户“{}”", userId);

        userService.add(user);

        logger.info("添加操作提示");
        model.addFlashAttribute(Constant.VM_BUSINESS, "新增成功");

        redirectUri = String.format(redirectUri, user.getId());
        logger.info("重定向至“{}”", redirectUri);
        return "redirect:" + redirectUri;
    }

    /**
     * 转至查看用户页面
     */
    @RequestMapping(value = "/toViewPage.do", method = RequestMethod.GET)
    public String toViewPage(Long id, ModelMap model) {
        logger.info("转至查看用户页面");
        logger.info("存储表单默认值");
        User user = userService.getById(id);

        Long orderMin = (Long) model.get(Constant.VS_ORG_ORDER_MIN);
        List<Organization> organizations = organizationService.findSector(orderMin, user.getOrganization().getOrder());
        model.addAttribute("organizationTree", JsonMapper.nonEmptyMapper().toJson(TreeNodeConverter.convert(organizations)));

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

        detail(model, user.getOrganization().getOrder());

        logger.info("存储表单默认值");
        model.addAttribute("user", user);
        logger.debug("用户“{}”", user.getName());

        return "/system/user/edit";
    }

    /**
     * 修改用户
     */
    @RequestMapping(value = "/modify.do", method = RequestMethod.POST)
    public String modify(User user,
                         @RequestParam(defaultValue = "/system/user/toModifyPage.do?id=%s") String redirectUri,
                         @ModelAttribute(Constant.VS_USER_ID) Long userId,
                         RedirectAttributes model) {
        logger.info("修改用户");

        logger.info("添加服务端属性值");
        user.setModifier(new User(userId));
        logger.debug("修改用户为当前用户“{}”", userId);

        userService.modify(user);

        logger.info("添加操作提示");
        model.addFlashAttribute(Constant.VM_BUSINESS, "修改成功");

        redirectUri = String.format(redirectUri, user.getId());
        logger.info("重定向至“{}”", redirectUri);
        return "redirect:" + redirectUri;
    }

    /**
     * 删除用户
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public String delete(Long[] id, @ModelAttribute(Constant.VS_USER_ID) Long sessionId) {
        logger.info("删除用户");

        logger.info("检查是否包含当前用户");
        if (ArrayUtils.contains(id, sessionId)) {
            logger.debug("包含");
            return new JsonDto("不允许删除当前操作用户").toString();
        }
        logger.debug("不包含");

        userService.delete(id);

        JsonDto jsonDto = new JsonDto("删除成功");
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
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
    @RequestMapping(value = "/toAuthorizationPage.do", method = RequestMethod.GET)
    public String toAuthorizationPage(Long id, ModelMap model) {
        logger.info("转至授权页面");

        logger.info("存储表单初始化数据");
        model.addAttribute("allRoles", model.get(Constant.VS_ROLES));
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

        return "/system/user/authorization";
    }


    /**
     * 授权
     * 1.角色
     * 2.功能
     * 3.组件
     */
    @RequestMapping(value = "/authorization.do")
    public String authorization(Long id,
                                @RequestParam(value = "roleId", required = false) Long[] roleIds,
                                @RequestParam(value = "functionId", required = false) Long[] functionIds,
                                @RequestParam(value = "componentId", required = false) Long[] componentIds,
                                @RequestParam(defaultValue = "/system/user/toAuthorizationPage.do?id=%s") String redirectUri,
                                RedirectAttributes model) {
        logger.info("授权");
        userService.authorization(id, roleIds, functionIds, componentIds);

        logger.info("添加操作提示");
        model.addFlashAttribute(Constant.VM_BUSINESS, "授权成功");

        redirectUri = String.format(redirectUri, id);
        return "redirect:" + redirectUri;
    }

    /**
     * 重置密码
     */
    @ResponseBody
    @RequestMapping(value = "/resetPassword.do")
    public String resetPassword(Long[] id) {
        logger.info("重置密码");

        userService.resetPasswordByIds(id);

        JsonDto jsonDto = new JsonDto("重置密码成功");
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
    }

    /**
     * 启用用户
     */
    @ResponseBody
    @RequestMapping(value = "/enable.do")
    public String enable(Long[] id) {
        logger.info("启用用户");

        userService.modifyIsActiveByIds(id, true);

        JsonDto jsonDto = new JsonDto("启用成功");
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
    }

    /**
     * 禁用用户
     */
    @ResponseBody
    @RequestMapping(value = "/disable.do")
    public String disable(Long[] id) {
        logger.info("禁用用户");

        userService.modifyIsActiveByIds(id, false);

        JsonDto jsonDto = new JsonDto("禁用成功");
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
    }


    @RequestMapping(value = "/toImportPage.do")
    public String toImportPage(ModelMap model) throws NoSuchFieldException {
        model.addAttribute("templateName", "user.xls");
        return "/system/user/import";
    }

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
        Map<String, Map<String, String>> descNames = (Map<String, Map<String, String>>) servletContext.getAttribute(Constant.VC_DESCNAMES);

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

        userService.add(users);

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
     */
    @RequestMapping(value = "/toQueryPage.comp")
    public String toOwnerLstPage(
            @RequestParam(value = "pageNo", defaultValue = "1") int pageNumber,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "pageOrderBy", defaultValue = "createTime") String orderBy,
            @RequestParam(value = "order", defaultValue = "asc") String order,
            HttpServletRequest request, ModelMap model) throws NoSuchFieldException {
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        HibernatePage<User> page = new HibernatePage<User>(pageNumber, pageSize);
        page.setHibernateOrderBy(orderBy);
        page.setHibernateOrder(order);
        page = userService.findPage(searchParams, page, (Long) model.get(Constant.VS_ORG_ID));

        JsonDto jsonDto = new JsonDto();
        jsonDto.setResult(page);
        model.addAttribute("jsondata", jsonDto);

        return "/system/user/listcomp";
    }


    /**
     * toOwnerLst(跳转至所有者组件列表界面)
     */
    @RequestMapping(value = "/toQueryUser.comp")
    public String toOwnerLst(ModelMap model) throws NoSuchFieldException {
        List<Organization> orgList = organizationService.getOrgAndUsers();
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
                sb.append(String.format("{id:%s, name:\"%s\", pId:-%s, type:\"%s\"},", new Object[]{
                        user.getId(),
                        user.getName(),
                        org.getId(),
                        "user"
                }));
            }
            oldOrgId = org.getId();
        }
        sb.toString().substring(0, sb.toString().length() - 2);
        sb.append("]");
        model.addAttribute("json", sb.toString());
        return "/system/message/listcomp";
    }
}
