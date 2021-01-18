package com.spring.moyeo.controller.admin;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.spring.common.Utils;
import com.spring.moyeo.service.admin.adminService;

@Controller
public class adminCont {

	@Autowired
	adminService service;
	
	@Autowired
	Utils utils;
	
	@RequestMapping(value = "/admin/index")
	public ModelAndView adminIndex(ModelAndView mv) {
		System.out.println("admin");
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../admin/statistics");
		return mv;
	}	
	
	@RequestMapping(value = "/admin/statistics",produces = "application/text; charset=utf8")
	public @ResponseBody String getStatisticsDateAjax(
			@RequestParam("from_date") String from_date,
			@RequestParam("to_date") String to_date,
			@RequestParam("type") String type
	) throws JsonProcessingException {
		ArrayList<Map<String, Object>> list = service.getStatistics(from_date, to_date, type);
		if(list.size() == 0) return "na";
		return utils.jsonParse(list);
	}
}
