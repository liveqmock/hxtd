package com.baihui.hxtd.soa.common.entity;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * 模块字段实体类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
public class ModuleField implements Serializable, Idable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "NAME", length = 62, nullable = false, unique = true, updatable = false)
    private String name;

    @Column(name = "DESC", length = 32, nullable = false)
    private String desc;

    public ModuleField() {
    }

    public ModuleField(Long id) {
        this.id = id;
    }

    public ModuleField(String name, String desc) {
        this.name = name;
        this.desc = desc;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
