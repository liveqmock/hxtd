package com.baihui.hxtd.soa.system.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Function;
import com.baihui.hxtd.soa.system.entity.Role;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.*;
import com.baihui.hxtd.soa.util.JsonDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.PrintWriter;
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
        Constant.VS_ORG_ID, Constant.VS_ORG_ORDER_MIN, Constant.VS_ORG_ORDER_MAX, Constant.VS_ORG,
        Constant.VS_MENUS,Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
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
    private DictionaryService dictionaryService;
    @Resource
    private UserService userService;
    @Resource
    private MenuService menuService;
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

    @RequestMapping(value = "/query.do")
    public void query(HttpServletRequest request, HibernatePage<Role> page, ModelMap model, PrintWriter out) throws NoSuchFieldException, IOException {
        logger.info("查询信息");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        logger.debug("查询条件数目“{}”", searchParams.size());

        logger.info("添加默认的查询条件");
        Long orderMin = (Long) model.get(Constant.VS_ORG_ORDER_MIN);
        Long orderMax = (Long) model.get(Constant.VS_ORG_ORDER_MAX);
        Search.addRange(searchParams, "creator.organization.order", orderMin, orderMax);
        logger.debug("组织序号区间值“[{},{}]”", orderMin, orderMax);

        logger.info("获取分页数据");
        page = roleService.findPage(searchParams, page);

        logger.info("以DTO格式返回");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setMessage("请求数据成功！");
        jsonDto.setResult(page);

        HibernateAwareObjectMapper.DEFAULT.writeValue(out, jsonDto);
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
    @RequestMapping(value = "/add.do", method = RequestMethod.POST)
    public String add(Role role,
                      @RequestParam(defaultValue = "/system/role/toModifyPage.do?id=%s") String redirectUri,
                      @ModelAttribute(Constant.VS_USER_ID) Long userId,
                      @ModelAttribute(Constant.VS_USER_NAME) String userName,
                      RedirectAttributes model) {
        logger.info("新增");
        logger.debug("名称“{}”", role.getName());
        role.setId(null);

        logger.info("添加服务端属性值");
        role.setCreator(new User(userId));
        logger.debug("创建用户为当前用户“{}”", userId);
        role.setModifier(role.getCreator());
        logger.debug("修改用户为当前用户“{}”", userId);

        roleService.add(role);

        logger.info("添加操作提示");
        model.addFlashAttribute(Constant.VM_ALL, "新增成功");

        redirectUri = String.format(redirectUri, role.getId());
        logger.info("重定向至“{}”", redirectUri);
        return "redirect:" + redirectUri;
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
    @RequestMapping(value = "/modify.do")
    public String modify(Role role,
                         @RequestParam(defaultValue = "/system/role/toModifyPage.do?id=%s") String redirectUri,
                         @ModelAttribute(Constant.VS_USER_ID) Long userId,
                         @ModelAttribute(Constant.VS_USER_NAME) String userName,
                         RedirectAttributes model) {
        logger.info("修改");

        logger.info("添加服务端属性值");
        role.setModifiedTime(new Date());
        logger.debug("修改时间为当前时间“{}”", role.getModifiedTime());
        role.setModifier(new User(userId));
        logger.debug("修改用户为当前用户“{}”", userName);

        roleService.modify(role);

        logger.info("添加操作提示");
        model.addFlashAttribute(Constant.VM_ALL, "修改成功");

        redirectUri = String.format(redirectUri, role.getId());
        logger.info("重定向至“{}”", redirectUri);
        return "redirect:" + redirectUri;
    }

    /**
     * 删除
     * //TODO 关于删除后，跳转回列表页面，保留原查询条件和分页数据
     * //TODO 关于删除的批量操作
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public String delete(Long[] id) {
        logger.info("删除");
        roleService.delete(id);
        JsonDto jsonDto = new JsonDto("删除成功");
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
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
        model.addAttribute("allFunctions", functionService.groupByMenuId((List<Function>) model.get(Constant.VS_FUNCTIONS)));
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
    @RequestMapping(value = "/authorization.do")
    public String authorization(Long id,
                                @RequestParam(value = "functionId", required = false) Long[] functionIds,
                                @RequestParam(value = "componentId", required = false) Long[] componentIds,
                                @RequestParam(defaultValue = "/system/role/toAuthorizationPage.do?id=%s") String redirectUri,
                                RedirectAttributes model) {
        logger.info("授权");
        roleService.authorization(id, functionIds, componentIds);

        logger.info("添加操作提示");
        model.addFlashAttribute(Constant.VM_ALL, "授权成功");

        redirectUri = String.format(redirectUri, id);
        return "redirect:" + redirectUri;
    }


}
