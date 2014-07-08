package com.baihui.hxtd.soa.common.entity;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 模块实体类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
@Entity
@Table(name = "SM_MODULE")
public class Module implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "NAME", length = 62, nullable = false, unique = true, updatable = false)
    private String name;

    @Column(name = "DESC", length = 32, nullable = false)
    private String desc;

    @Column(name = "ENTITY_CLASS", length = 255, nullable = false)
    private String entityClass;

    public Module() {
    }

    public Module(Long id) {
        this.id = id;
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

    public String getEntityClass() {
        return entityClass;
    }

    public void setEntityClass(String entityClass) {
        this.entityClass = entityClass;
    }
}
