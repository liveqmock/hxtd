package com.baihui.hxtd.soa.common.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.User;

/**
 * 功能描述：导入控制器
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author xiaoli.luo
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.controller.ImportController.java
 * @version (版本) 1
 * @date 2014-7-6 上午10:17:53
 *
 */
@Controller
@RequestMapping("common/import")
@SessionAttributes(value={Constant.VS_USER})
public class ImportController {
	
	/**
	 * 跳转到import页面
	 * @param modelMap
	 * @return
	 * @throws NoSuchFieldException
	 */
	@RequestMapping(value = "/toImportPage.do")
	public String toImportPage(ModelMap modelMap) throws NoSuchFieldException{
		modelMap.addAttribute("userTemplement", "user.xls");
		return "/common/import/import";
	}
	
	@RequestMapping(value = "/import.do", headers = "content-type=multipart/*", method = RequestMethod.POST)
	public String imports(MultipartFile file, HttpSession session,
            @RequestParam(defaultValue = "/system/user/toQueryPage.do") String redirectUri,
            @ModelAttribute(Constant.VS_USER) User sessionUser,
            @ModelAttribute(Constant.VS_ORG) Organization organization,
            ModelMap modelMap,
            RedirectAttributes model) throws IOException, InvalidFormatException {

		
		return null;
	}
	
	

}
