package com.baihui.hxtd.soa.financial.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.InitApplicationConstant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.common.entity.FlowInstance;
import com.baihui.hxtd.soa.common.service.FlowInstanceService;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 财务审批控制器
 *
 * @author xiayouxue
 * @date 2014/7/25
 */
@Controller
@RequestMapping("/financial/approve")
@SessionAttributes(value = {Constant.VS_USER, Constant.VS_USER_ID, Constant.VS_ORG})
public class ApproveController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private FlowInstanceService flowInstanceService;
    @Resource
    private DictionaryService dictionaryService;

    /**
     * 跳转至列表页
     * --存储模块列表
     * --存储流程
     * --创建时间
     */
    @RequestMapping("/toQueryPage")
    public String toQueryPage(HibernatePage<FlowInstance> page, ModelMap modelMap) {
        page.setHibernateOrderBy("modifiedTime");
        page.setHibernateOrder(HibernatePage.DESC);
        modelMap.addAttribute("page", page);

        modelMap.addAttribute("modules", InitApplicationConstant.MODULES);
        modelMap.addAttribute("flows", dictionaryService.findChildren(DictionaryConstant.NODE_TYPE));

        return "/financial/approve/list";
    }

    /**
     * 查询
     * 1.从流程实例表中查出行进至财务审批环节的数据
     * 2.按列表展示数据封装成业务实体类列表
     * 3.列表展示 流程、模块名称、记录ID、记录描述、金额、创建者、创建时间
     */
    @ResponseBody
    @RequestMapping(value = "/query.do")
    public String query(HttpServletRequest request, HibernatePage<FlowInstance> page, ModelMap modelMap) throws NoSuchFieldException, JsonProcessingException {

        String type = request.getParameter("type");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        searchParams.put("user", modelMap.get(Constant.VS_USER));
        if ("approving".equals(type)) {
            searchParams.put("roleCode", Constant.ROLE_FINANCER);
            page = flowInstanceService.findExecutablePagination(page, searchParams);
        } else if ("approved".equals(type)) {
            page = flowInstanceService.findParticipantPagination(page, searchParams);
        }
        flowInstanceService.fullFlowBusiness(page.getResult());

        logger.info("转换为TDO格式");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setResult(page);

        return jsonDto.toString();
    }


    /**
     * 跳转至列表页
     * --存储模块列表
     * --存储流程
     * --创建时间
     */
    @RequestMapping("/toApprovePage")
    public String toApprovePage(Long id) {


        return "/financial/approve/list";
    }
}
