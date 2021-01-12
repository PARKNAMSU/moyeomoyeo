package com.spring.moyeo.controller.meeting;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.Utils;
import com.spring.moyeo.service.meeting.MeetingService;
import com.spring.moyeo.vo.MeetingEntity;

@Controller
public class MeetingCont {
	
	@Autowired
	MeetingService service;
	
	@Autowired
	Utils utils;
	
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
	@RequestMapping("/member/my_meeting")
	public ModelAndView myMeeting(ModelAndView mv) {
		mv.setViewName("root/main");
		mv.addObject("jsp_page", "../member/my/my_meeting");
		return mv;
	}
	@RequestMapping(value = "/member/create_meeting", produces = "application/text; charset=utf8")
	public @ResponseBody Object createMeetingAjax(
			MeetingEntity entity,
			HttpSession session
	) throws ParseException {
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		entity.setEnd_date(transFormat.parse(entity.getEnd_date_str()));
		service.createMeetingRoom(entity, (String)session.getAttribute("user_id"));
		return "";
	}
}
