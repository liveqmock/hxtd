package com.baihui.hxtd.soa.system.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.system.entity.Menu;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import java.util.List;

/**
 * 首页控制器
 *
 * @author xiayouxue
 * @date 2014/4/25
 */
@Controller
@RequestMapping(value = "")
@SessionAttributes(value = {Constant.VS_USER_NAME,Constant.VS_MENUBAR_FIRST_MENUS})
public class IndexController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @RequestMapping(value = "/toViewPage.do")
    public String index(ModelMap model, @ModelAttribute(Constant.VS_MENUBAR_FIRST_MENUS) List<Menu> menus) {
        logger.info("初始化系统首页");
        String url = menus.get(0).getUrl();
        if (url == null) {
            url = menus.get(0).getChildren().iterator().next().getUrl();
        }
        logger.info("默认按父子菜单URL规则（父菜单URL有值则取父菜单，否则取子菜单）重定向至第一个菜单“{}”", url);
        model.clear();
        return "redirect:" + url;
    }

    @RequestMapping(value = "/system/toViewPage.do")
    public String systemIndex(Model model) {
//        model.addAttribute("menus", menuService.findByShowlocation(user.getId()));
        return "/system/index";
    }

    @RequestMapping(value = "/workbanch/toViewPage.do")
    public String workbanchIndex(Model model) {
//        model.addAttribute(Constant.VS_MENUBAR_FIRST_MENUS, menuService.findByShowlocation(user.getName()));
        return "/workbanch";
    }

}
