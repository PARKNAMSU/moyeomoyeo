package com.spring.moyeo.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.spring.common.Utils;
import com.spring.moyeo.service.admin.adminService;

import ch.qos.logback.core.rolling.helper.IntegerTokenConverter;

@Controller
public class BoardCont {
	
	@Autowired
	adminService service;
	
	@Autowired
	Utils utils;
	
	@RequestMapping("/board_page")
	public ModelAndView boardPage(ModelAndView mv){
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../info/infomation");
		return mv;
	}
	@RequestMapping("/board_info_page")
	public ModelAndView boardInfoPage(
			ModelAndView mv, @RequestParam("seq") String seq
	) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../info/info_content");
		mv.addObject("seq",Integer.parseInt(seq));
		return mv;
	}
	@RequestMapping("/oto_page")
	public ModelAndView otoPage(ModelAndView mv){
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../info/oto_question");
		return mv;
	}
	@RequestMapping("/oto_info_page")
	public ModelAndView otoInfoPage(
			ModelAndView mv, @RequestParam("seq") String seq
	) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../info/oto_content");
		mv.addObject("seq",Integer.parseInt(seq));
		return mv;
	}
	@RequestMapping("/often_page")
	public ModelAndView oftenPage(ModelAndView mv){
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../info/often_question");
		return mv;
	}
	@RequestMapping("/often_info_page")
	public ModelAndView oftenInfoPage(
			ModelAndView mv, @RequestParam("seq") String seq
	) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../info/often_content");
		mv.addObject("seq",Integer.parseInt(seq));
		return mv;
	}
	
	
	@RequestMapping(value = "/get_all_board",produces = "application/text; charset=utf8")
	public @ResponseBody String getAllBoard() throws JsonProcessingException {
		return utils.jsonParse(service.getAllBoard());
	}
	@RequestMapping(value = "/get_board",produces = "application/text; charset=utf8")
	public @ResponseBody String getBoard(@RequestParam("seq") String seq) throws JsonProcessingException {
		
		return utils.jsonParse(service.getBoard(Integer.parseInt(seq)));
	}
	@RequestMapping(value = "/get_all_often",produces = "application/text; charset=utf8")
	public @ResponseBody String getAllOften() throws JsonProcessingException {
		return utils.jsonParse(service.getAllOften());
	}
	@RequestMapping(value = "/get_often",produces = "application/text; charset=utf8")
	public @ResponseBody String getOften(@RequestParam("seq") String seq) throws JsonProcessingException {
		
		return utils.jsonParse(service.getOften(Integer.parseInt(seq)));
	}
	@RequestMapping(value = "/get_all_oto",produces = "application/text; charset=utf8")
	public @ResponseBody String getAllOto() throws JsonProcessingException {
		return utils.jsonParse(service.getAllOto());
	}
	@RequestMapping(value = "/get_oto",produces = "application/text; charset=utf8")
	public @ResponseBody String getOtos(@RequestParam("seq") String seq) throws JsonProcessingException {
		
		return utils.jsonParse(service.getOtos(Integer.parseInt(seq)));
	}
}
