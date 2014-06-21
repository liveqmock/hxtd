package com.baihui.hxtd.soa.base;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.beans.PropertyEditorSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 自动长度的日期属性编辑器
 *
 * @author xiayouxue
 * @date 2014/6/8
 */
@Component
public class AutoLengthDateEditor extends PropertyEditorSupport {

    private String pattern = "yyyy-MM-dd HH:mm:ss SSS";
    private SimpleDateFormat format = new SimpleDateFormat();

    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        if (StringUtils.isBlank(text)) {
            setValue(null);
        } else {
            format.applyPattern(pattern.substring(0, text.length()));
            try {
                setValue(format.parse(text));
            } catch (ParseException e) {
                throw new IllegalArgumentException(e);
            }
        }
    }

    @Override
    public String getAsText() {
        Date value = (Date) getValue();
        return (value != null ? format.format(value) : "");
    }
}
