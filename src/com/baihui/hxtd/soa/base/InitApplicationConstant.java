package com.baihui.hxtd.soa.base;

import org.apache.commons.collections.BidiMap;
import org.apache.commons.collections.bidimap.DualHashBidiMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * 初始化Application中常量
 * //TODO 关于在application中初始化字典、菜单、功能、组件、角色等常量
 *
 * @author xiayouxue
 * @date 2014/5/30
 */
@Component
public class InitApplicationConstant implements StartupListener {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public void onStartup(ServletContextEvent event) {
        logger.info("应用启动完成后，初始化Application中常量");
        ServletContext servletContext = event.getServletContext();
        loadFunctionCode(servletContext);
        loadNameDesc(servletContext);
        loadImportExport(servletContext);
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
     * 加载名称描述配置
     */
    private void loadNameDesc(ServletContext servletContext) {
        logger.info("加载名称描述配置");
        Properties properties = new Properties();
        try {
            properties.load(getClass().getResourceAsStream("/application.namedesc.properties"));
            Map<String, Map<String, String>> nameDescs = new HashMap<String, Map<String, String>>();
            Map<String, Map<String, String>> descNames = new HashMap<String, Map<String, String>>();
            for (String key : properties.stringPropertyNames()) {
                int index = key.indexOf(".");
                String entityName = key.substring(0, index);
                String filedName = key.substring(index + 1);
                String value = properties.getProperty(key);
                value = new String(value.getBytes("ISO-8859-1"), "UTF-8");
                if (!nameDescs.containsKey(entityName)) {
                    nameDescs.put(entityName, new HashMap<String, String>());
                }
                nameDescs.get(entityName).put(filedName, value);

                if (!descNames.containsKey(entityName)) {
                    descNames.put(entityName, new HashMap<String, String>());
                }
                descNames.get(entityName).put(value, filedName);
            }
            logger.debug("名称描述数目“{}”", properties.entrySet().size());
            servletContext.setAttribute(Constant.VC_NAMEDESCS, nameDescs);
            servletContext.setAttribute(Constant.VC_DESCNAMES, descNames);
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


}
