package com.spring.moyeo.controller.login;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.TempKey;
import com.spring.moyeo.config.MailConfig;
import com.spring.moyeo.service.login.LoginService;
import com.spring.moyeo.vo.MemberEntity;

@SessionAttributes("user_id")
@Controller
public class LoginCont {
	
	@Autowired
	LoginService loginService;
	
	@Autowired
	MailConfig mailConfig;

	@RequestMapping("/login_page")
	public ModelAndView loginPage(String error,ModelAndView mv) {
		if(error != null) {
			mv.addObject("error",error);
		}
		mv.setViewName("account/loginPage");
		return mv;
	}
	@RequestMapping("/active_setting")
	public String activeSetting() {
		return "account/active_setting";
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
	public ModelAndView index(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page","index");
		return mv;
	}	

	@RequestMapping("/login_access.do")
	public ModelAndView getMember(@AuthenticationPrincipal User user,ModelAndView mv) {
		MemberEntity member = loginService.getUser(user.getUsername());
		if(member.getActivate_yn().equals("n")) {
			mv.setViewName("account/loginPage");
			mv.addObject("error", "deactive");
			return mv;
		}
		if(member.getStop_yn().equals("y")) {
			mv.setViewName("account/loginPage");
			mv.addObject("error", "stop");
			return mv;
		}
		mv.addObject("user_id",user.getUsername());
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "index");
		return mv;
	}
	
	@RequestMapping(value = "/email_ck",produces = "application/text; charset=utf8")
	public @ResponseBody String email_ckAjax(@RequestParam("email") String email) {
		System.out.println("email: "+email);
		String ck = loginService.emailCheck(email,"");
		
		if(ck.equals("true")) return "fail";
		else return "sucess";
	}
	@RequestMapping(value = "/email_identify",produces = "application/text; charset=utf8")
	public @ResponseBody String signupProcessController(@RequestParam String email) {
		String authCode = new TempKey().generateKey(8);
		String subject = "모여모여 회원가입 인증코드 발급 안내";
		String text = "귀하의 인증코드는 "+authCode+"입니다.\n모여모여를 이용해주셔서 감사합니다.";
		mailConfig.send(subject, text, "skatn7979@gmail.com", email, null);
		return authCode;
	}
	@RequestMapping(value = "/create_user",produces = "application/text; charset=utf8")
	public @ResponseBody String createUser(MemberEntity member) {
		loginService.createUser(member);
		return "sucess";
	}
	@RequestMapping(value = "/active_account",produces = "application/text; charset=utf8")
	public @ResponseBody String activeAccount(
			@RequestParam("email") String email,
			@RequestParam("password") String password,
			@RequestParam("active_yn") String yn
		) {
		String ck = loginService.emailCheck(email, password);
		if(ck.equals("true")) {
			loginService.setActive(email,yn);
		}
		return ck;
	}
	@RequestMapping("/member/my_info")
	public ModelAndView memberPage(ModelAndView mv, HttpSession session) {
		MemberEntity member = loginService.getUser((String)session.getAttribute("user_id"));
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/my/my_info");
		mv.addObject("member",member);
		return mv;
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login_page";
	}
	@RequestMapping("/test")
	public String test() {
		MemberEntity m = new MemberEntity();
		m.setEmail("skatn7979@naver.com");
		m.setPassword("1234");
		m.setName("홍길동");
		m.setNick_name("slsl");
		loginService.createUser(m);
		return "test";
	}
}
