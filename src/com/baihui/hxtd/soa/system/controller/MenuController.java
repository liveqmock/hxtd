package com.baihui.hxtd.soa.system.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.base.utils.mapper.JsonMapper;
import com.baihui.hxtd.soa.base.utils.ztree.TreeNodeConverter;
import com.baihui.hxtd.soa.common.controller.model.ListModel;
import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Menu;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.system.service.FunctionService;
import com.baihui.hxtd.soa.system.service.MenuService;
import com.baihui.hxtd.soa.util.Constants;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

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
        Constant.VS_ORG_ID, Constant.VS_DATASHIFT, Constant.VS_ORG,
        Constant.VS_MENUS, Constant.VS_MENUBAR_FIRST_MENUS, Constant.VS_MENUBAR_SECOUND_MENUS, Constant.VS_SETPAGE_MENUS, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
@SuppressWarnings("unchecked")
public class MenuController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());//日志

    @Resource
    private MenuService menuService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private FunctionService functionService;

    @Resource
    private CommonService commonService;

    /**
     * 转至查询页面
     */
    @RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(HibernatePage<Menu> page, Long defaultSelected, ModelMap modelMap) {
        logger.info("转至查询页面");

        logger.info("存储查询条件表单初始化数据");
        List<Menu> menus = (List<Menu>) modelMap.get(Constant.VS_MENUS);
        menus = new ArrayList<Menu>(menus);
        menus.add(0, Menu.ROOT);
        String menuTree = JsonMapper.nonEmptyMapper().toJson(TreeNodeConverter.convert(menus));
        modelMap.addAttribute("menuTree", menuTree);
        if (defaultSelected == null) {
            defaultSelected = Menu.ROOT.getId();
        }
        modelMap.addAttribute("parentId", defaultSelected);

        logger.info("存储分页数据");
        modelMap.addAttribute("page", page);

        return "/system/menu/list";
    }

    /**
     * 查询分页数据
     */
    @ResponseBody
    @RequestMapping(value = "/query.do")
    public String query(Long id, ModelMap modelMap) throws NoSuchFieldException, IOException {
        logger.info("查询信息");
        logger.debug("id={}", id);

        List<Menu> menus = (List<Menu>) modelMap.get(Constant.VS_MENUS);
        //查找子节点
        List<Menu> findMenus = menuService.findChildrenById(menus, Menu.ROOT.getId().equals(id) ? null : id);
        //没有子节点，查找自己
        if (findMenus.size() == 0) {
            Menu self = menuService.findById(menus, id);
            if (self != null) {
                findMenus.add(self);
            }
        }

        logger.info("以DTO格式返回");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        ListModel<Menu> result = new ListModel<Menu>();
        result.setList(findMenus);
        jsonDto.setResult(result);

        return HibernateAwareObjectMapper.DEFAULT.writeValueAsString(jsonDto);
    }

    /**
     * 存储表单初始化数据
     */
    public void detail(ModelMap model) {
        logger.info("存储表单初始化数据");

        List<Dictionary> showLocations = dictionaryService.findChildren("010202");
        model.addAttribute("showLocations", showLocations);
        logger.debug("显示位置长度“{}”", showLocations.size());

        List<Menu> menus = (List<Menu>) model.get(Constant.VS_MENUS);
        String menuTree = JsonMapper.nonEmptyMapper().toJson(TreeNodeConverter.convert(menus));
        model.addAttribute("menuTree", menuTree);

        model.addAttribute("functions", functionService.findBase());
    }

    /**
     * 转至新增页面
     */
    @RequestMapping(value = "/toAddPage.do", method = RequestMethod.GET)
    public String toAddPage(Long parentId, ModelMap model) {
        logger.info("转至新增页面");

        detail(model);

        logger.info("存储表单默认值");
        Menu menu = new Menu();
        menu.setIsActive(true);
        menu.setDefaultShow(false);
        menu.setIsLeaf(true);
//        if (parentId != null) {
//            menu.setParent(menuService.get(parentId));
//            menu.setLevel(menu.getParent().getLevel() + 1);
//        }
        model.addAttribute("menu", menu);

        return "/system/menu/edit";
    }

    /**
     * 新增
     * 1.新增菜单
     * 2.仅限下级菜单
     * 3.下级菜单溢出处理
     */
    @ResponseBody
    @RequestMapping(value = "/add.do", method = RequestMethod.POST)
    public String add(Menu menu, @ModelAttribute(Constant.VS_USER_ID) Long userId) {
        logger.info("新增");
        logger.debug("名称“{}”", menu.getName());

        logger.info("添加服务端属性值");
        User user=new User(userId);
        menu.setCreator(user);
        logger.debug("创建用户为当前用户“{}”", userId);
        menu.setModifier(menu.getCreator());
        logger.debug("修改用户为当前用户“{}”", userId);

        /************ 新增 *****************************/
		AuditLog auditLog = new AuditLog(EnumModule.MENU.getModuleName(), 
				menu.getId(), menu.getName(), EnumOperationType.ADD.getOperationType(), user,"增加菜单");
        menuService.add(menu,auditLog);

        return JsonDto.add(menu.getId()).toString();
    }

    /**
     * 转至查看页面
     */
    @RequestMapping(value = "/toViewPage.do")
    public String toViewPage(Long id, ModelMap model) {
        logger.info("转至查看页面");

        List<Menu> menus = (List<Menu>) model.get(Constant.VS_MENUS);
        String menuTree = JsonMapper.nonEmptyMapper().toJson(TreeNodeConverter.convert(menus));
        model.addAttribute("menuTree", menuTree);

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
    @ResponseBody
    @RequestMapping(value = "/modify.do")
    public String modify(Menu menu, ModelMap modelMap) {
        logger.info("修改");

        if (commonService.isInitialized(Menu.class, menu.getId())) {
            return new JsonDto("系统初始化数据不允许修改！").toString();
        }

        logger.info("添加服务端属性值");
        User user = (User) modelMap.get(Constant.VS_USER);
        menu.setModifier(new User(user.getId()));
        logger.debug("修改用户为当前用户“{}”", user.getName());

        AuditLog auditLog = new AuditLog(EnumModule.MENU.getModuleName(), 
        		menu.getId(), menu.getName(), EnumOperationType.MODIFY.getOperationType(), user,"菜单修改");
        menuService.modify(menu,auditLog);

        return JsonDto.modify(menu.getId()).toString();
    }

    /**
     * 删除菜单
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public String delete(Long[] id,ModelMap modelMap) {
        logger.info("删除菜单");

        if (commonService.isInitialized(Menu.class, id)) {
            return new JsonDto("系统初始化数据不允许删除！").toString();
        }

        User user = (User)modelMap.get(Constant.VS_USER);
        AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.MENU.getModuleName(), 
					id[i], menuService.getNameById(id[i]), EnumOperationType.DELETE.getOperationType(), user,"菜单删除");
		}
        menuService.delete(id,auditLogArr);

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
    public JsonDto move(ModelMap modelMap, Long sourceId, Long targetId, String moveType) {
        logger.info("移动");

        Long sourceOrder = commonService.getOrderById(Menu.class, sourceId);
        Long targetOrder = commonService.getOrderById(Menu.class, targetId);

        commonService.move("Menu", sourceId, targetId, moveType);
        commonService.moveSynSession((List<Menu>) modelMap.get(Constant.VS_MENUS), sourceId, targetId);

        Menu menu = menuService.get(sourceId);
        //同步菜单栏菜单
        if (menu.getShowLocationType().equals(Constants.SHOW_LOCATION_TYPE_MENUBAR)) {
            //同步一级菜单
            if (menu.getLevel().equals(1)) {
                Collections.sort((List<Menu>) modelMap.get(Constant.VS_MENUBAR_FIRST_MENUS));
            }
            //同步二级菜单
            else if (menu.getLevel().equals(2)) {
                Map<Long, List<Menu>> secoundMenus = (Map<Long, List<Menu>>) modelMap.get(Constant.VS_MENUBAR_SECOUND_MENUS);
                Collections.sort(secoundMenus.get(menu.getParent().getId()));
            }
        }
        //同步设置页菜单
        else if (menu.getShowLocationType().equals(Constants.SHOW_LOCATION_TYPE_MENUBAR)) {
            Collections.sort((List<Menu>) modelMap.get(Constant.VS_SETPAGE_MENUS));
        }

        JsonDto jsonDto = new JsonDto((sourceOrder < targetOrder ? "下移" : "上移") + "成功！");
        jsonDto.setSuccessFlag(true);
        return jsonDto;
    }

}
