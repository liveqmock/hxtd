package com.baihui.hxtd.soa.base;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.support.WebBindingInitializer;
import org.springframework.web.context.request.WebRequest;

import java.util.Date;

/**
 * 自定义数据绑定初始化器
 * //TODO 为什么每次请求都需要注册
 */
public class CustomWebBindingInitializer implements WebBindingInitializer {

    //    private Logger logger = LoggerFactory.getLogger(this.getClass());
    private AutoLengthDateEditor autoLengthDateEditor = new AutoLengthDateEditor();

    @Override
    public void initBinder(WebDataBinder binder, WebRequest request) {
//        logger.info("注册自定义的属性编辑器");
        binder.registerCustomEditor(Date.class, autoLengthDateEditor);
    }

}
