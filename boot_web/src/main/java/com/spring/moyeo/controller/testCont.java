package com.spring.moyeo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.moyeo.service.login.LoginService;
import com.spring.moyeo.vo.MemberEntity;

@Controller
public class testCont {

	@Autowired
	LoginService loginService;
	



	@RequestMapping("/test3")
	public ModelAndView test3(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../info/oto_content");
		return mv;
	}	
	@RequestMapping("/invite_pop")
	public ModelAndView invite_pop(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/my/invite_pop");
		return mv;
	}
	@RequestMapping("/profile_pop")
	public ModelAndView profile_pop(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/my/my_profile_img_pop");
		return mv;
	}
	
	@RequestMapping("/test")
	public String test() {
		String [] nm = {"박지성","호날두","아자르","풀리식","캉테"};
		String [] em = {"park@naver.com","ronal@naver.com","hzr@google.com","puli@naver.com","kang@naver.com"};
		String [] nnm = {"park","ronal","hzr","puli","kang"};
		for(int i=0; i<nm.length;i++) {
			MemberEntity m = new MemberEntity();
			m.setEmail(em[i]);
			m.setPassword("1234");
			m.setName(nm[i]);
			m.setNick_name(nnm[i]);
			loginService.createUser(m);
		}
		return "test";
	}
}
