package com.spring.moyeo.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.security.core.userdetails.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.spring.Role;
import com.spring.moyeo.service.LoginService;
import com.spring.moyeo.service.MemberService;
import com.spring.moyeo.vo.MemberEntity;

@SessionAttributes("id")
@Controller
public class LoginCont {
	
	@Autowired
	LoginService service;
	@Autowired
	MemberService memberService;
	
	@RequestMapping("/login_page")
	public String loginPage() {
		return "account/loginPage";
	}
	@RequestMapping("/sign_up_page")
	public String signUpPage() {
		return "account/sign_up";
	}
	@RequestMapping("/get_temp_pw")
	public String getTempPw() {
		return "account/get_temp_pw";
	}
	
	@RequestMapping("/")
	public ModelAndView test2(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page","index");
		return mv;
	}
	
	@RequestMapping("/member/index.do")
	public ModelAndView indexPage(ModelAndView mv, HttpSession session) {
		mv.addObject("jsp_page","index");
		mv.setViewName("root/main");
		return mv;
	}
	@RequestMapping("/login_access.do")
	public ModelAndView getMember(@AuthenticationPrincipal User user,ModelAndView mv) {
		mv.addObject("id",user.getUsername());
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "index");
		return mv;
	}
	
	@RequestMapping("/member/my_page.do")
	public ModelAndView memberPage(ModelAndView mv) {
		mv.setViewName("main");
		mv.addObject("jsp_page", "../member/myPage");
		return mv;
	}
	@RequestMapping("/logout")
	public String logout() {
		return "redirect:/login_page";
	}
	@RequestMapping("/test")
	public String test() {
		MemberEntity m = new MemberEntity();
		m.setId("slsl");
		m.setPassword("1234");
		m.setName("김");
		m.setAuth("ROLE_USER");
		memberService.createUser(m);
		return "test";
	}
}
