package com.baihui.hxtd.soa.common.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.ReflectionUtils;
import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.AuditLogService;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.util.EnumOperationType;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 基础公用的控制器
 *
 * @author xiayouxue
 */
@Controller
@RequestMapping("/common/common")
public class CommonController<T> {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    protected Class<T> entityClass;

    public CommonController() {
        this.entityClass = ReflectionUtils.getSuperClassGenricType(getClass());
    }

    @Resource
    private CommonService commonService;

    @Resource
    private AuditLogService auditLogService;

    /**
     * 唯一性验证
     */
    @ResponseBody
    @RequestMapping("/unique.docomp")
    public Boolean checkUnique(String entityName, String fieldName, String fieldValue) {
        logger.info("唯一性验证");
        fieldValue = fieldValue.trim();
        logger.debug("实体“{}”字段“{}”值“{}”", entityName, fieldName, fieldValue);
        return commonService.checkUnique(entityName, fieldName, fieldValue);
    }

    /**
     * 选中导出
     * 1.在分页列表上导出选中的数据行
     */
    @RequestMapping(value = "/export.do", params = "TYPE=selected")
    public void exportSelected(HttpServletRequest request, Long[] id, 
    		HttpServletResponse response, ModelMap modelMap) throws NoSuchFieldException, IOException {
        logger.info("导出excel文件");
        logger.debug("id={}", StringUtils.join(id, ","));

        logger.info("获取对象集合");
        String name = StringUtils.uncapitalize(entityClass.getSimpleName());
        ServletContext servletContext = request.getSession().getServletContext();
        Map<String, String> export = (Map<String, String>) servletContext.getAttribute(Constant.VC_IMPORTEXPORTS);
        String fetch = export.get(name + ".export.hql.fetch");
        String[] fetchs = StringUtils.isBlank(fetch) ? null : fetch.split(",");
        List<?> entities = commonService.findById(entityClass, fetchs, id);
        int size = entities.size();
        logger.debug("列表信息数目“{}”", size);

        logger.info("转换成excel文件并输出");
//        try {
        Workbook workbook = ImportExport.exportExcel(response, servletContext, name, entities);
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("Content-Disposition", "attachment; filename=" + name + ".xls");
        workbook.write(response.getOutputStream());

        User user = (User)modelMap.get(Constant.VS_USER);
        saveAuditlog(name, user, size);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }

    /**
     * 限制数据条数导出
     * 1.配置hql语句(1)或者hql的级联抓取字段(2)，优先使用(1)，未配置(1)使用(2)，并根据(2)生成(1)，(1)、(2)都未配置系统自动生成
     * 2.级联抓取的owner字段，如果导出时需要做数据筛选，筛选时会级联抓取owner字段，此时不要再配置owner字段
     * 3.通用的导出写在CommonController，需要定制的，在子类中覆盖
     */
    @RequestMapping(value = "/export.do", params = "TYPE=limit")
    public void exportLimit(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        logger.info("导出excel文件");

        DataShift dataShift = (DataShift) modelMap.get(Constant.VS_DATASHIFT);

        String name = StringUtils.uncapitalize(entityClass.getSimpleName());
        ServletContext servletContext = request.getSession().getServletContext();
        Map<String, String> export = (Map<String, String>) servletContext.getAttribute(Constant.VC_IMPORTEXPORTS);
        String hql = export.get(name + ".export.hql");
        List<T> entities;
        if (StringUtils.isBlank(hql)) {
            String fetchNames = export.get(name + ".export.hql.fetch");
            String fetchHql = "";
            if (StringUtils.isNotBlank(fetchNames)) {
                String join = String.format(" left join fetch %s.", name);
                fetchHql = join + StringUtils.join(fetchNames.split(","), join);
            }
            fetchHql += dataShift.toHql(name);
            hql = String.format("select %s from %s %s", name, entityClass.getSimpleName(), name);
            hql += fetchHql;
        } else {
            hql += dataShift.toHql(name);
        }
        entities = commonService.findExport(hql);
        int size = entities.size();
        logger.debug("列表信息数目“{}”", size);

        logger.info("转换成excel文件并输出");
//        try {
        Workbook workbook = ImportExport.exportExcel(response, servletContext, name, entities);
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("Content-Disposition", "attachment; filename=" + name + ".xls");
        workbook.write(response.getOutputStream());
        User user = (User)modelMap.get(Constant.VS_USER);
        saveAuditlog(name, user, size);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }


    /**
     * 保存审计日志
     * 1.EnumModule的moduleName必须和实体类类名首字母小写相匹配，暂时没有建立相关映射
     */
    private void saveAuditlog(String name, User user, int size) {
        AuditLog auditLog = new AuditLog();
        auditLog.setModuleName(name);
        auditLog.setRecordId(null);
        auditLog.setRecordName("导出列表选中的数据");
        auditLog.setType(EnumOperationType.EXPORT.getOperationType());
        auditLog.setCreator(user);
        auditLog.setCreatedTime(new Date());
        auditLog.setRemark(String.format("共导出%s条数据", size));
        auditLogService.save(auditLog);
    }

    public Class<T> getEntityClass() {
        return entityClass;
    }

    public void setEntityClass(Class<T> entityClass) {
        this.entityClass = entityClass;
    }
}
