package com.baihui.hxtd.soa.common.entity;

import com.baihui.hxtd.soa.system.entity.Dictionary;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 模块类型实体类
 *
 * @author huizijing
 * @date 2014/7/7
 */
@Entity
@Table(name = "SM_MODULE_TYPE", uniqueConstraints = @UniqueConstraint(columnNames = {"TYPE_ID", "MODULE_ID"}))
public class ModuleType implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TYPE_ID")
    private Dictionary type;

    @Column(name = "MODULE_ID")
    private Long moduleId;

    public ModuleType() {
    }

    public ModuleType(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Dictionary getType() {
        return type;
    }

    public void setType(Dictionary type) {
        this.type = type;
    }

    public Long getModuleId() {
        return moduleId;
    }

    public void setModuleId(Long moduleId) {
        this.moduleId = moduleId;
    }
}
