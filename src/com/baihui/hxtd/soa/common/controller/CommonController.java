package com.baihui.hxtd.soa.common.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.ReflectionUtils;
import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.system.service.DataShift;
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
    public void exportSelected(HttpServletRequest request, Long[] id, HttpServletResponse response) throws NoSuchFieldException, IOException {
        logger.info("导出excel文件");
        logger.debug("id={}", StringUtils.join(id, ","));

        logger.info("获取对象集合");
        String name = StringUtils.uncapitalize(entityClass.getSimpleName());
        ServletContext servletContext = request.getSession().getServletContext();
        Map<String, String> export = (Map<String, String>) servletContext.getAttribute(Constant.VC_IMPORTEXPORTS);
        String fetch = export.get(name + ".export.hql.fetch");
        String[] fetchs = StringUtils.isBlank(fetch) ? null : fetch.split(",");
        List<?> entities = commonService.findById(entityClass, fetchs, id);
        logger.debug("列表信息数目“{}”", entities.size());

        logger.info("转换成excel文件并输出");
        Workbook workbook = ImportExport.exportExcel(response, servletContext, StringUtils.uncapitalize(entityClass.getSimpleName()), entities);
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("Content-Disposition", "attachment; filename=" + "user" + ".xls");
        workbook.write(response.getOutputStream());
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
                String join = String.format(" inner join fetch %s.", name);
                fetchHql = join + StringUtils.join(fetchNames.split(","), join);
            }
            fetchHql += dataShift.toHql(name);
            hql = String.format("select %s from %s %s", name, entityClass.getSimpleName(), name);
            hql += fetchHql;
        } else {
            hql += dataShift.toHql(name);
        }
        entities = commonService.findExport(hql);
        logger.debug("列表信息数目“{}”", entities.size());

        logger.info("转换成excel文件并输出");

        ImportExport.exportExcel(response, servletContext, name, entities).write(response.getOutputStream());
    }

    public Class<T> getEntityClass() {
        return entityClass;
    }

    public void setEntityClass(Class<T> entityClass) {
        this.entityClass = entityClass;
    }
}
