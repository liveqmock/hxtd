package com.baihui.hxtd.soa.system.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.base.utils.mapper.JsonMapper;
import com.baihui.hxtd.soa.base.utils.ztree.TreeNodeConverter;
import com.baihui.hxtd.soa.common.controller.model.ListModel;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Menu;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.system.service.FunctionService;
import com.baihui.hxtd.soa.system.service.MenuService;
import com.baihui.hxtd.soa.util.JsonDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.List;

/**
 * 功能描述： 菜单管理控制器
 *
 * @author lihua
 * @version (版本) V1.0
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.system.controller.MenuController.java
 * @date 2014-5-6 下午04:06:55
 * @since (该版本支持的 JDK 版本) ：1.6
 */
@Controller
@RequestMapping(value = "/system/menu")
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_ORG_ORDER_MIN, Constant.VS_ORG_ORDER_MAX, Constant.VS_ORG,
        Constant.VS_MENUS,  Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
@SuppressWarnings("unchecked")
public class MenuController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());//日志

    @Resource
    private MenuService menuService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private FunctionService functionService;

    /**
     * 转至查询页面
     */
    @RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(HibernatePage<Menu> page, ModelMap modelMap) {
        logger.info("转至查询页面");

        logger.info("存储查询条件表单初始化数据");
        List<Menu> menus = (List<Menu>) modelMap.get(Constant.VS_MENUS);
        String menuTree = JsonMapper.nonEmptyMapper().toJson(TreeNodeConverter.convert(menus));
        modelMap.addAttribute("menuTree", menuTree);
        modelMap.addAttribute("parentId", menus.get(0).getId());

        logger.info("存储分页数据");
        modelMap.addAttribute("page", page);

        return "/system/menu/list";
    }

    /**
     * 查询分页数据
     */
    @ResponseBody
    @RequestMapping(value = "/query.do")
    public String query(@RequestParam(required = false) Long id, ModelMap modelMap) throws NoSuchFieldException, IOException {
        logger.info("查询信息");

        List<Menu> menus = (List<Menu>) modelMap.get(Constant.VS_MENUS);
        menus = menuService.findSelfChildrenById(menus, id);

        logger.info("以DTO格式返回");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setMessage("请求数据成功！");
        ListModel<Menu> result = new ListModel<Menu>();
        result.setList(menus);
        jsonDto.setResult(result);

        return HibernateAwareObjectMapper.DEFAULT.writeValueAsString(jsonDto);
    }


    /**
     * 存储表单初始化数据
     */
    public void detail(ModelMap model) {
        logger.info("存储表单初始化数据");

        List<Dictionary> openTypes = dictionaryService.findChildren("010201");
        model.addAttribute("openTypes", openTypes);
        logger.debug("打开类型长度“{}”", openTypes.size());

        List<Dictionary> showLocations = dictionaryService.findChildren("010202");
        model.addAttribute("showLocations", showLocations);
        logger.debug("显示位置长度“{}”", showLocations.size());

        model.addAttribute("functions", functionService.findBase());
    }

    /**
     * 转至新增页面
     */
    @RequestMapping(value = "/toAddPage.do", method = RequestMethod.GET)
    public String toAddPage(@RequestParam(required = false) Long parentId, ModelMap model) {
        logger.info("转至新增页面");

        detail(model);

        logger.info("存储表单默认值");
        Menu menu = new Menu();
        menu.setIsLeaf(true);
        if (parentId != null) {
            menu.setParent(menuService.get(parentId));
            menu.setLevel(menu.getParent().getLevel() + 1);
        }
        model.addAttribute("menu", menu);

        return "/system/menu/edit";
    }

    /**
     * 新增
     * 1.新增菜单
     * 2.仅限下级菜单
     * 3.下级菜单溢出处理
     */
    @RequestMapping(value = "/add.do", method = RequestMethod.POST)
    public String add(Menu menu,
                      @RequestParam(defaultValue = "/system/menu/toModifyPage.do?id=%s") String redirectUri,
                      @ModelAttribute(Constant.VS_USER_ID) Long userId,
                      RedirectAttributes model) {
        logger.info("新增");
        logger.debug("名称“{}”", menu.getName());

        logger.info("添加服务端属性值");
        menu.setCreator(new User(userId));
        logger.debug("创建用户为当前用户“{}”", userId);
        menu.setModifier(menu.getCreator());
        logger.debug("修改用户为当前用户“{}”", userId);

        menuService.add(menu);

        logger.info("添加操作提示");
        model.addFlashAttribute(Constant.VM_ALL, "新增成功");

        redirectUri = String.format(redirectUri, menu.getId());
        logger.info("重定向至“{}”", redirectUri);
        return "redirect:" + redirectUri;
    }

    /**
     * 转至查看页面
     */
    @RequestMapping(value = "/toViewPage.do")
    public String toViewPage(Long id, ModelMap model) {
        logger.info("转至查看页面");

        logger.info("存储表单默认值");
        Menu menu = menuService.get(id);
        model.addAttribute("menu", menu);
        logger.debug("名称“{}”", menu.getName());

        return "/system/menu/view";
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
        Menu menu = menuService.get(id);

        model.addAttribute("menu", menu);
        logger.debug("名称“{}”", menu.getName());

        return "/system/menu/edit";
    }

    /**
     * 修改
     * 1.当前菜单信息
     * 2.父节点
     */
    @RequestMapping(value = "/modify.do")
    public String modify(Menu menu,
                         @RequestParam(defaultValue = "/system/menu/toModifyPage.do?id=%s") String redirectUri,
                         @ModelAttribute(Constant.VS_USER_ID) Long userId,
                         @ModelAttribute(Constant.VS_USER_NAME) String userName,
                         RedirectAttributes model) {
        logger.info("修改");

        logger.info("添加服务端属性值");
        menu.setModifier(new User(userId));
        logger.debug("修改用户为当前用户“{}”", userName);

        menuService.modify(menu);

        logger.info("添加操作提示");
        model.addFlashAttribute(Constant.VM_ALL, "修改成功");

        redirectUri = String.format(redirectUri, menu.getId());
        logger.info("重定向至“{}”", redirectUri);
        return "redirect:" + redirectUri;
    }

    /**
     * 删除菜单
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public String delete(Long[] id) {
        logger.info("删除菜单");

        menuService.delete(id);

        JsonDto jsonDto = new JsonDto("删除成功");
        jsonDto.setSuccessFlag(true);
        return jsonDto.toString();
    }
}
