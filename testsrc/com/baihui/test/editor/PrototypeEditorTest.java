package com.baihui.test.editor;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import java.beans.PropertyEditorSupport;

public class PrototypeEditorTest {

    class TestPrototypeEditor extends PropertyEditorSupport {
        @Override
        public void setAsText(String text) throws IllegalArgumentException {
            super.setValue(text.split(","));
        }
    }

    @Test
    public void testLoginForm() throws Exception {
        TestPrototypeEditor editor = new TestPrototypeEditor();
        editor.setAsText("a,s,c");
        System.out.println(editor.getValue());
    }
}
