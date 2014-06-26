package com.baihui.hxtd.soa.base.propertyeditors;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.util.StringUtils;

import java.beans.PropertyEditorSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 多格式的日期转换器
 */
public class MultiPatternDateEditor extends PropertyEditorSupport {

    private String[] patterns;
    private SimpleDateFormat dateFormat = new SimpleDateFormat();

    public MultiPatternDateEditor(String... patterns) {
        if (patterns == null || patterns.length == 0) {
            throw new IllegalArgumentException("至少输入一个日期格式！");
        }
        this.patterns = patterns;
        this.dateFormat.applyPattern(patterns[0]);
    }

    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        if (!StringUtils.hasText(text)) {
            setValue(null);
        } else {
            try {
                setValue(DateUtils.parseDate(text, patterns));
            } catch (ParseException ex) {
                throw new IllegalArgumentException("Could not parse date: " + ex.getMessage(), ex);
            }
        }
    }

    @Override
    public String getAsText() {
        Date value = (Date) getValue();
        return (value != null ? this.dateFormat.format(value) : "");
    }

}
