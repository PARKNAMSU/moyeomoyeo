package com.spring.moyeo.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.spring.common.Utils;
import com.spring.moyeo.service.admin.adminService;
import com.spring.moyeo.vo.BoardEntity;
import com.spring.moyeo.vo.OTOQuestionEntity;
import com.spring.moyeo.vo.OftenQuestionEntity;

@Controller
public class adminCont {

	@Autowired
	adminService service;
	
	@Autowired
	Utils utils;
	
	
	@RequestMapping(value = "/admin/index")
	public ModelAndView adminIndex(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../admin/statistics");
		return mv;
	}
	@RequestMapping(value = "/admin/board_main")
	public ModelAndView adminBoard(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../admin/board_manage");
		return mv;
	}
	@RequestMapping(value = "/admin/blame_main")
	public ModelAndView adminblame(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../admin/blame_manage");
		return mv;
	}	
	@RequestMapping(value = "/admin/board_manage_pop")
	public ModelAndView adminBoardCreatePop(
			ModelAndView mv,
			@RequestParam(value = "seq",required = false,defaultValue = "0") int board_seq
		) {
		mv.setViewName("root/main");
		if(board_seq == 0 ) {
			mv.addObject("type","insert");
			mv.addObject("seq",board_seq);
		}else {
			mv.addObject("type","update");
			mv.addObject("seq",board_seq);
		}
		mv.addObject("jsp_page", "../admin/board_create_pop");
		return mv;
	}
	@RequestMapping(value = "/admin/often_manage_pop")
	public ModelAndView adminOftenCreatePop(
			ModelAndView mv,
			@RequestParam(value = "seq",required = false,defaultValue = "0") int often_seq
		) {
		mv.setViewName("root/main");
		if(often_seq == 0 ) {
			mv.addObject("type","insert");
			mv.addObject("seq",often_seq);
		}else {
			mv.addObject("type","update");
			mv.addObject("seq",often_seq);
		}
		mv.addObject("jsp_page", "../admin/often_create_pop");
		return mv;
	}
	
	@RequestMapping(value = "/admin/statistics",produces = "application/text; charset=utf8")
	public @ResponseBody String getStatisticsDateAjax(
			@RequestParam("from_date") String from_date,
			@RequestParam("to_date") String to_date,
			@RequestParam("type") String type,
			@RequestParam(value = "m_type[]",required = false) List<String> m_type
	) throws JsonProcessingException {
		if(type.equals("meeting")) {
			System.out.println("mtype: "+m_type.get(0));
		}
		ArrayList<ArrayList<Map<String, Object>>> list = new ArrayList<ArrayList<Map<String, Object>>>();
		if(type.equals("meeting")) {
			list = service.getStatistics_dtype(from_date, to_date, type, m_type);
		}else {
			list = service.getStatistics(from_date, to_date, type);
		}
		if(list.size() == 0) return "na";
		return utils.jsonParse(list);
	}
	
	@RequestMapping(value = "/admin/manage_board",produces = "application/text; charset=utf8")
	public @ResponseBody String manageBoard(
			BoardEntity board,
			OftenQuestionEntity often,
			@RequestParam("type") String type,
			@RequestParam("table_type") String table_type
	) {
		if(table_type.equals("board")) service.manageBoard(board, type);
		if(table_type.equals("often")) service.manageOften(often, type);
		return "";
	}


}
