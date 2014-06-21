package com.baihui.test.regexp;

import org.apache.commons.lang3.StringUtils;
import org.junit.Test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexpTest {
    @Test
    public void testLoginForm() throws Exception {
        String uri = "/system/user/toAddPage.do";
        String funcUrl = uri;
        Pattern pattern = Pattern.compile("(to([a-zA-Z]+))Page");
        Matcher matcher = pattern.matcher(uri);
        if (matcher.find()) {
            StringBuffer funcUrlBuffer = new StringBuffer();
            matcher.appendReplacement(funcUrlBuffer, StringUtils.uncapitalize(matcher.group(2)));
            matcher.appendTail(funcUrlBuffer);
            funcUrl = funcUrlBuffer.toString();
        }
        System.out.println(funcUrl);
    }
}
