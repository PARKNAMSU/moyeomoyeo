package com.spring.moyeo.controller.meeting;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MeetingCont {
	@RequestMapping("/member/secret_meeting")
	public ModelAndView secretMeeting(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/meeting/secret_meeting");
		return mv;
	}
	@RequestMapping("/member/open_meeting")
	public ModelAndView openMeeting(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/open/open_meeting");
		return mv;
	}
	@RequestMapping("/member/find_friends")
	public ModelAndView findFriends(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/meeting/find_friends");
		return mv;
	}
}
