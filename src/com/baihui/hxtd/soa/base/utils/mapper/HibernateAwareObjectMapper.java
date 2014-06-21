package com.baihui.hxtd.soa.base.utils.mapper;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.hibernate4.Hibernate4Module;

public class HibernateAwareObjectMapper extends ObjectMapper {

    public final static ObjectMapper DEFAULT = new HibernateAwareObjectMapper();

    static {
//        DEFAULT.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);
        DEFAULT.setSerializationInclusion(JsonInclude.Include.NON_NULL);
    }

    public HibernateAwareObjectMapper() {
        Hibernate4Module module = new Hibernate4Module();
        registerModule(module);
    }
}