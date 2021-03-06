package com.baihui.hxtd.soa.system.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.DBDateServiceInjecter;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.base.utils.mapper.JsonMapper;
import com.baihui.hxtd.soa.base.utils.serial.TierSerial;
import com.baihui.hxtd.soa.base.utils.serial.TierSerials;
import com.baihui.hxtd.soa.base.utils.ztree.TreeNodeConverter;
import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.system.service.OrganizationService;
import com.baihui.hxtd.soa.system.service.RoleService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springside.modules.web.Servlets;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 组织控制器
 *
 * @author xiayouxue
 * @date 2014/5/7
 */
@Controller
@RequestMapping(value = "/system/organization")
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_DATASHIFT, Constant.VS_ORG,
        Constant.VS_MENUS, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
public class OrganizationController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());


    //        @Value(value = "${system.organization.type}")
    private String typeValue = "010301";


    @Resource
    private OrganizationService organizationService;

    @Resource
    private CommonService commonService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private RoleService roleService;

    /**
     * 转至查询页面
     */
    @RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(HibernatePage<Organization> page, ModelMap model) {
        logger.info("转至查询页面");

        Organization organization = (Organization) model.get(Constant.VS_ORG);
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
        User user = (User) model.get(Constant.VS_USER);

        //如果是系统管理员、系统数据管理员、管理员可以查看所有组织
        if (dataShift.getIsSysManager() || dataShift.getIsSysDataManager() || user.getIsManager()) {
            organization = organizationService.findRoot();
        }
        logger.info("存储查询条件表单初始化数据");
        List<Organization> organizations = organizationService.findChildrenById(organization.getId());
        organizations.add(0, organization);
        model.addAttribute("organizationTree", JsonMapper.nonEmptyMapper().toJson(TreeNodeConverter.convert(organizations)));

        logger.info("存储查询条件表单默认值");
        model.addAttribute("id", organization.getId());
        model.addAttribute("userId", user.getId()); //当期登录用户ID

        logger.info("存储分页数据");
        HibernatePage<User> userPage = new HibernatePage<User>();
        userPage.setHibernateOrderBy("createdTime");
        userPage.setHibernateOrder(HibernatePage.DESC);
        model.addAttribute("userPage", userPage);

        page.setHibernateOrderBy("order");
        page.setHibernateOrder(HibernatePage.ASC);
        model.addAttribute("orgPage", page);


        return "/system/organization/list";
    }

    /**
     * 查询分页数据
     */
    @ResponseBody
    @RequestMapping(value = "/query.do")
    public String query(HttpServletRequest request, Long id, HibernatePage<Organization> page) throws NoSuchFieldException, IOException {
        logger.info("查询信息");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.trimValue(searchParams);
        logger.debug("查询条件数目“{}”", searchParams.size());

        logger.info("添加默认的查询条件");
        Long order = organizationService.getOrderById(id);
        TierSerial tierSerial = TierSerials.parse(order, Constant.ORG_ORDER_TIER_LENGTH);
        Long orderMin = order;
        Long orderMax = order + tierSerial.getIncrease() - 1;
        Search.addRange(searchParams, "order", orderMin, orderMax);
        logger.debug("组织序号区间值“[{},{}]”", orderMin, orderMax);

        logger.info("获取分页数据");
        page.setHibernateOrderBy("order");
        page.setHibernateOrder(HibernatePage.ASC);
        page = organizationService.findPage(searchParams, page);
        logger.debug("数目“{}”", page.getResult().size());

        logger.info("以DTO格式返回");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setResult(page);

        return HibernateAwareObjectMapper.DEFAULT.writeValueAsString(jsonDto);
    }

    /**
     * 查询子组织
     * //TODO 关于权限控制
     */
    @ResponseBody
    @RequestMapping(value = "/query.do", params = {"TYPE=children"})
    public String queryChildren(Long id, ModelMap model) throws JsonProcessingException {
        logger.info("查询子组织");
        logger.debug("主键编号“{}”", id);

        List<Organization> organizations = new ArrayList<Organization>();
        if (id == null) {
            logger.debug("主键编号为null，直接返回session中当前组织");
            organizations.add((Organization) model.get(Constant.VS_ORG));
        } else {
            logger.debug("主键编号不为null，返回其子组织");
            organizations = organizationService.findChildrenById(id);
        }
        logger.debug("数目“{}”", organizations.size());
        String result = JsonMapper.nonEmptyMapper().toJson(TreeNodeConverter.convert(organizations));
        logger.debug("result:{}", result);
        return result;
    }

    /**
     * 存储表单初始化数据
     */
    public void detail(ModelMap model) {
        logger.info("存储表单初始化数据");

        List<Dictionary> typeValues = dictionaryService.findChildren(typeValue);
        model.addAttribute("typeValues", typeValues);
        logger.debug("类型列表长度“{}”", typeValues.size());
    }

    /**
     * 转至新增页面
     */
    @RequestMapping(value = "/toAddPage.do", method = RequestMethod.GET)
    public String toAddPage(ModelMap model, String index) {
        logger.info("转至新增页面");

        detail(model);

        logger.info("存储表单默认值");
        Organization organization = new Organization();
        organization.setIsLeaf(true);
        organization.setParent(organization);
        model.addAttribute("organization", organization);
        model.addAttribute("index", index);
        return "/system/organization/edit";
    }

    /**
     * 新增
     * 1.新增组织
     * 2.仅限下级组织 //TODO 服务端检查
     * 3.下级组织溢出处理
     */
    @ResponseBody
    @RequestMapping(value = "/add.do", method = RequestMethod.POST)
    public String add(Organization organization, ModelMap modelMap) {
        logger.info("新增");
        logger.debug("名称“{}”", organization.getName());

        logger.info("添加服务端属性值");
        User user = (User) modelMap.get(Constant.VS_USER);
        organization.setCreator(user);
        logger.debug("创建用户为当前用户“{}”", user.getName());
        organization.setModifier(organization.getCreator());
        logger.debug("修改用户为当前用户“{}”", user.getName());

        AuditLog auditLog = new AuditLog(EnumModule.ORGANIZATION.getModuleName(),
                organization.getId(), organization.getName(), EnumOperationType.ADD.getOperationType(), user, "组织增加");
        organizationService.add(organization, auditLog);

        return JsonDto.add(organization.getId()).toString();
    }

    /**
     * 转至查看页面
     */
    @RequestMapping(value = "/toViewPage.do", method = RequestMethod.GET)
    public String toViewPage(Long id, ModelMap model, String index) {
        logger.info("转至查看页面");

        logger.info("存储表单默认值");
        Organization organization = organizationService.getById(id);
        model.addAttribute("organization", organization);
        model.addAttribute("index", index);
        logger.debug("名称“{}”", organization.getName());

        return "/system/organization/view";
    }

    /**
     * 转至修改页面
     */
    @RequestMapping(value = "/toModifyPage.do", method = RequestMethod.GET)
    public String toModifyPage(Long id, ModelMap model, String index) {
        logger.info("转至修改页面");
        logger.debug("主键编号“{}”", id);

        detail(model);

        logger.info("存储表单默认值");
        Organization organization = organizationService.getById(id);
        model.addAttribute("organization", organization);
        logger.debug("名称“{}”", organization.getName());
        model.addAttribute("index", index);
        return "/system/organization/edit";
    }

    /**
     * 修改
     * 1.当前组织信息
     * 2.父节点
     */
    @ResponseBody
    @RequestMapping(value = "/modify.do")
    public String modify(Organization organization, ModelMap modelMap) {
        logger.info("修改");

        if (commonService.isInitialized(Organization.class, organization.getId())) {
            return new JsonDto("系统初始化数据不允许修改！").toString();
        }

        logger.info("添加服务端属性值");
        User user = (User) modelMap.get(Constant.VS_USER);
        organization.setModifiedTime(DBDateServiceInjecter.nowTime());
        logger.debug("修改时间为当前时间“{}”", organization.getModifiedTime());
        organization.setModifier(user);
        logger.debug("修改用户为当前用户“{}”", user.getName());

        AuditLog auditLog = new AuditLog(EnumModule.ORGANIZATION.getModuleName(),
                organization.getId(), organization.getName(), EnumOperationType.MODIFY.getOperationType(), user, "组织修改");
        organizationService.modify(organization, auditLog);

        return JsonDto.modify(organization.getId()).toString();
    }

    /**
     * 删除
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public String delete(ModelMap modelMap, Long[] id) {
        logger.info("删除");
        if (commonService.isInitialized(Organization.class, id)) {
            return new JsonDto("系统初始化数据不允许修改！").toString();
        }
        User user = (User) modelMap.get(Constant.VS_USER);
        AuditLog[] auditLogArr = new AuditLog[id.length];
        for (int i = 0; i < id.length; i++) {
            auditLogArr[i] = new AuditLog(EnumModule.ORGANIZATION.getModuleName(),
                    id[i], organizationService.getNameById(id[i]), EnumOperationType.DELETE.getOperationType(), user, "组织删除");
        }
        organizationService.delete(id, auditLogArr);
        return JsonDto.delete(id).toString();
    }

    /**
     * 移动
     * A移动到B，即取代B的位置
     * 1.兄弟节点间移动
     * 1.1.上移
     * 1.2.下移
     * 2.跨父节点移动
     */
    @ResponseBody
    @RequestMapping("/move.doself")
    public JsonDto move(Long sourceId, Long targetId) {
        logger.info("移动");
        organizationService.move(sourceId, targetId);
        JsonDto jsonDto = new JsonDto("成功");
        jsonDto.setSuccessFlag(true);
        return jsonDto;
    }

    /**
     * 转至授权页面
     * 仅能分配个人权限范围内的角色、功能和组件
     * 1.角色
     * 1.1.已授权
     * 1.2.未授权
     */
    @RequestMapping(value = "/toAuthorizationPage.do", method = RequestMethod.GET)
    public String toAuthorizationPage(Long id, ModelMap model, String index) {
        logger.info("转至授权页面");

        logger.info("存储表单初始化数据");
        User user = (User) model.get(Constant.VS_USER);
        model.addAttribute("allRoles", roleService.findValid(user));

        logger.info("存储表单默认值");
        model.addAttribute("authorizationRoles", roleService.findOrganization(id));
        model.addAttribute("index", index);
        return "/system/organization/authorization";
    }

    /**
     * 授权
     * 1.角色
     */
    @ResponseBody
    @RequestMapping(value = "/authorization.do")
    public String authorization(Long id, @RequestParam(value = "roleId", required = false) Long[] roleIds, HttpServletRequest request, ModelMap modelMap) {
        logger.info("授权");
        User user = (User)modelMap.get(Constant.VS_USER);

        /**组织授权*/
        AuditLog auditLog = new AuditLog(EnumModule.ORGANIZATION.getModuleName(),
                id, organizationService.getById(id).getName(), EnumOperationType.AUTHORIZATION.getOperationType(), user, "组织授权");
        organizationService.authorization(id, roleIds, auditLog);
        return new JsonDto(id, "授权成功").toString();
    }


}
