package com.spring.moyeo.controller.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardCont {
	
	@RequestMapping("/board_page")
	public ModelAndView boardPage(ModelAndView mv){
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../info/infomation");
		return mv;
	}
}
