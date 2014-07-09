package com.baihui.hxtd.soa.base;

import com.baihui.hxtd.soa.common.controller.model.ListModel;
import com.baihui.hxtd.soa.common.entity.Module;
import com.baihui.hxtd.soa.common.entity.PCAS;
import com.baihui.hxtd.soa.common.service.ModuleService;
import com.baihui.hxtd.soa.common.service.PCASService;
import com.baihui.hxtd.soa.system.entity.Component;
import com.baihui.hxtd.soa.system.entity.Function;
import com.baihui.hxtd.soa.system.entity.Menu;
import com.baihui.hxtd.soa.system.service.ComponentService;
import com.baihui.hxtd.soa.system.service.FunctionService;
import com.baihui.hxtd.soa.system.service.MenuService;
import com.baihui.hxtd.soa.util.JsonDto;
import org.apache.commons.collections.BidiMap;
import org.apache.commons.collections.bidimap.DualHashBidiMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.*;

/**
 * 初始化Application中常量
 * //TODO 关于在application中初始化字典、菜单、功能、组件、角色等常量
 *
 * @author xiayouxue
 * @date 2014/5/30
 */
@org.springframework.stereotype.Component
public class InitApplicationConstant implements StartupListener {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * 系统菜单
     */
    public final static List<Menu> MENUS = new ArrayList<Menu>();
    /**
     * 系统功能
     */
    public final static List<Function> FUNCTIONS = new ArrayList<Function>();
    /**
     * 系统组件
     */
    public final static List<Component> COMPONENTS = new ArrayList<Component>();

    /**
     * 系统模块
     */
    public final static List<Module> MODULES = new ArrayList<Module>();

    @Resource
    private PCASService pcasService;

    @Resource
    private MenuService menuService;

    @Resource
    private FunctionService functionService;

    @Resource
    private ComponentService componentService;

    @Resource
    private ModuleService moduleService;


    @Override
    public void onStartup(ServletContextEvent event) {
        logger.info("应用启动完成后，初始化Application中常量");
        ServletContext servletContext = event.getServletContext();
        loadFunctionCode(servletContext);
        loadComponentCode(servletContext);
        loadNameDesc(servletContext);
        loadImportExport(servletContext);
        loadSystemPrivi();
        loadPCAS(servletContext);
        loadModules();
        loadFields();
    }

    /**
     * 加载功能编码配置
     */
    private void loadFunctionCode(ServletContext servletContext) {
        logger.info("加载功能编码配置");
        Properties properties = new Properties();
        try {
            properties.load(getClass().getResourceAsStream("/application.function.code.properties"));
            BidiMap functionCodes = new DualHashBidiMap(properties);
            logger.debug("功能编码数目“{}”", properties.entrySet().size());
            servletContext.setAttribute(Constant.VC_FUNCTION_CODES, functionCodes);
        } catch (IOException e) {
            throw new RuntimeException("加载功能编码配置文件异常", e);
        }
    }

    /**
     * 加载组件编码配置
     */
    private void loadComponentCode(ServletContext servletContext) {
        logger.info("加载组件编码配置");
        Properties properties = new Properties();
        try {
            properties.load(getClass().getResourceAsStream("/application.component.code.properties"));
            BidiMap componentCodes = new DualHashBidiMap(properties);
            logger.debug("组件编码数目“{}”", properties.entrySet().size());
            servletContext.setAttribute(Constant.VC_COMPONENT_CODES, componentCodes);
        } catch (IOException e) {
            throw new RuntimeException("加载组件编码配置文件异常", e);
        }
    }

    /**
     * 加载名称描述配置
     */
    private void loadNameDesc(ServletContext servletContext) {
        logger.info("加载名称描述配置");
        Properties properties = new Properties();
        try {
            properties.load(getClass().getResourceAsStream("/application.namedesc.properties"));
            Map<String, BidiMap> nameDescs = new HashMap<String, BidiMap>();
            for (String key : properties.stringPropertyNames()) {
                int index = key.indexOf(".");
                String entityName = key.substring(0, index);
                String filedName = key.substring(index + 1);
                String value = properties.getProperty(key);
                if (!nameDescs.containsKey(entityName)) {
                    nameDescs.put(entityName, new DualHashBidiMap());
                }
                nameDescs.get(entityName).put(filedName, value);
            }
            logger.debug("名称描述数目“{}”", properties.entrySet().size());
            servletContext.setAttribute(Constant.VC_NAMEDESCS, nameDescs);
        } catch (IOException e) {
            throw new RuntimeException("加载名称描述配置文件异常", e);
        }
    }

    /**
     * 加载导入导出配置
     */
    private void loadImportExport(ServletContext servletContext) {
        logger.info("加载导入导出配置");
        Properties properties = new Properties();
        try {
            properties.load(getClass().getResourceAsStream("/application.export.properties"));
        } catch (IOException e) {
            throw new RuntimeException("加载导入导出配置文件异常", e);
        }
        logger.debug("导入导出数目“{}”", properties.entrySet().size());
        servletContext.setAttribute(Constant.VC_IMPORTEXPORTS, properties);
    }

    /**
     * 加载系统管理权限数据
     */
    private void loadSystemPrivi() {
        logger.info("加载系统管理权限数据");
        List<Menu> menus = menuService.findInit();
        menuService.fullParent(menus);
        MENUS.addAll(menus);
        menuService.toTriggerUrl(MENUS);
        logger.debug("菜单数目“{}”", MENUS.size());
        FUNCTIONS.addAll(functionService.findInit());
        logger.debug("功能数目“{}”", FUNCTIONS.size());
        COMPONENTS.addAll(componentService.findInit());
        logger.debug("组件数目“{}”", COMPONENTS.size());
    }

    /**
     * 加载省份信息
     */
    @SuppressWarnings("unchecked")
    private void loadPCAS(ServletContext servletContext) {
        List<PCAS> pcas = pcasService.getRoot();
        JsonDto json = new JsonDto();
        json.setResult(new ListModel(pcas));
        servletContext.setAttribute(Constant.VC_PCAS, "var pcasJson=" + json.toString());
    }

    /**
     * 加载系统模块
     */
    private void loadModules() {
        logger.info("加载系统模块");
        MODULES.addAll(moduleService.findAll());
        logger.debug("系统模块数目“{}”", MODULES.size());

    }

    public final static Map<Class, Field[]> FIELDS = new HashMap<Class, Field[]>();

    /**
     * 加载系统字段
     */
    private void loadFields() {
        logger.info("加载系统字段");
        String entityClass = null;
        try {
            for (int i = 0; i < MODULES.size(); i++) {
                entityClass = MODULES.get(i).getEntityClass();
                Class clazz = Class.forName(entityClass);
                FIELDS.put(clazz, clazz.getDeclaredFields());
                logger.debug("{}字段数目“{}”", entityClass, FIELDS.get(clazz).length);
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(String.format("加载系统字段异常，未找到对应的类%s！", entityClass), e);
        }
    }
}
