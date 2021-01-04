package com.spring.moyeo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class testCont {
	@RequestMapping("/secret_meeting")
	public ModelAndView secretMeeting(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/meeting/secret_meeting");
		return mv;
	}
	@RequestMapping("/secret_meeting_create")
	public ModelAndView secretMeetingCreate(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/meeting/secret_meeting_create");
		return mv;
	}
	@RequestMapping("/my_meeting")
	public ModelAndView myMeeting(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/my/my_meeting");
		return mv;
	}
	@RequestMapping("/my_info")
	public ModelAndView myInfo(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/my/my_info");
		return mv;
	}
	@RequestMapping("/my_profile_img_pop")
	public ModelAndView myProfile_img_pop(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/my/my_profile_img_pop");
		return mv;
	}
	@RequestMapping("/my_password_chg_pop")
	public ModelAndView my_password_chg_pop(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/my/my_password_chg_pop");
		return mv;
	}
	@RequestMapping("/my_inval_account_pop")
	public ModelAndView my_inval_account_pop(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/my/my_inval_account_pop");
		return mv;
	}
	@RequestMapping("/test1")
	public ModelAndView my_friends(ModelAndView mv) {
		mv.setViewName("root/main");
		//mv.addObject("jsp_page", "../member/my/my_friends");
		//mv.addObject("jsp_page", "../member/meeting/meeting_page");
		//mv.addObject("jsp_page", "../member/meeting/find_friends");
		mv.addObject("jsp_page", "../member/open/open_meeting_create");
		
		return mv;
	}
	@RequestMapping("/test2")
	public ModelAndView test2(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/open/find_open_meeting");
		
		return mv;
	}	
	@RequestMapping("/invite_pop")
	public ModelAndView invite_pop(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/my/invite_pop");
		return mv;
	}
}
