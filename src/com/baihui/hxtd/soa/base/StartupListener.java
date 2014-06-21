package com.baihui.hxtd.soa.base;

import javax.servlet.ServletContextEvent;

/**
 * bean容器启动监听器。该类的所有实现将在bean容器启动后自动被激活。
 * 注意：所有实现必须标注@Component。
 * 该类的所有实现建议放在com.baihui.soa.service.event.listener.startup包下。
 */
public interface StartupListener {

    public void onStartup(ServletContextEvent event);
}
