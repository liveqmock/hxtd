package com.baihui.hxtd.soa.base;

import org.springframework.web.context.ContextLoaderListener;

import javax.servlet.ServletContextEvent;

/**
 * 包装后启动类，需要在web.xml中调用。
 * spring的WebApplicationContext加载完成后，调用所有实现了StartupListener的监听类。
 *
 * @see com.lifecarenetworks.soa.base.StartupListener
 */
public class ContextLoaderListenerAware extends ContextLoaderListener {

    public void contextInitialized(ServletContextEvent event) {
        super.contextInitialized(event);
        String[] beanNames = getCurrentWebApplicationContext().getBeanNamesForType(StartupListener.class);
        if (beanNames == null || beanNames.length == 0)
            return;
        for (String startupBeanName : beanNames) {
            StartupListener startupListener = getCurrentWebApplicationContext().getBean(startupBeanName, StartupListener.class);
            startupListener.onStartup(event);
        }
    }
}
