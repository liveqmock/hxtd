package com.baihui.test.json;

import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.fasterxml.jackson.databind.util.TokenBuffer;
import org.apache.poi.util.Internal;
import org.junit.Assert;
import org.junit.Test;

import java.io.IOException;
import java.util.Date;

@SuppressWarnings("unchecked")
public class JsonTest {

//
//    public class BeanSerializer extends JsonSerializer<Bean> {
//        @Override
//        public void serialize(Bean value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
//            jgen.writeString(value.toString());
//        }
//    }
//
//    @Test
//    public void testLoginForm() throws Exception {
//        ObjectMapper objectMapper = new ObjectMapper();
//        Bean bean = new Bean();
//        bean.name = "name";
//        bean.address = "address";
//        bean.ssn = "ssn";
//        bean.date = new Date();
//
//        ObjectMapper mapper = new ObjectMapper();
//        objectMapper.getSerializationConfig().mixInCount();
//        String json = objectMapper.writerWithView(Internal.class).writeValueAsString(bean);
//        System.out.println(json);
//
//        mapper = new ObjectMapper();
//        SimpleModule module = new SimpleModule("EnhancedDatesModule", new Version(0, 1, 0, "alpha"));
//        module.addSerializer(Bean.class, new BeanSerializer());
//        mapper.registerModule(module);
//        System.out.println(mapper.writeValueAsString(bean));
//    }
//
//    @Test
//    public void testStreaming() throws Exception {
//        String jsonUser = "{\"name\":\"name\"}";
//        ObjectMapper objectMapper = new ObjectMapper();
//        JsonNode jsonNode = objectMapper.readTree(jsonUser);
//        Assert.assertTrue(jsonNode.has("name"));
//
//        JsonFactory jsonFactory = new JsonFactory(new ObjectMapper());
//        JsonParser jp = jsonFactory.createParser(jsonUser);
//        Bean bean = jp.readValueAs(Bean.class);
//        Assert.assertEquals("name", bean.name);
//
////        JsonFactory jsonFactory = new JsonFactory(); // or, for data binding, org.codehaus.jackson.mapper.MappingJsonFactory
////        JsonGenerator jg = jsonFactory.createJsonGenerator(file, JsonEncoding.UTF8); // or Stream, Reader
//
//        TokenBuffer buffer = new TokenBuffer(jp);
//        // serialize object as JSON tokens (but don't serialize as JSON text!)
//        objectMapper.writeValue(buffer, bean);
//        // read back as tree
//        JsonNode root = objectMapper.readTree(buffer.asParser());
//        ((ObjectNode) root).put("name", "name_");
//        // modify some more, write out
//        // ...
//        String jsonText = objectMapper.writeValueAsString(root);
//        Assert.assertEquals(jsonUser, jsonText);
//
//
//    }

}