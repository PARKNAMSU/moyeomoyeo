package com.spring.moyeo.controller.meeting;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.spring.common.Utils;
import com.spring.moyeo.service.meeting.MeetingService;
import com.spring.moyeo.vo.CommentsEntity;
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
		if(entity.getMeeting_type().equals("secret"))entity.setEnd_date(transFormat.parse(entity.getEnd_date_str()));
		service.createMeetingRoom(entity, (String)session.getAttribute("user_id"));
		return "";
	}
	@RequestMapping(value = "/member/my_room", produces = "application/text; charset=utf8")
	public @ResponseBody Object getMyMeetingRoom(
			HttpSession session,
			@RequestParam("type") String type,
			@RequestParam("accept_type") String type2
		) throws JsonProcessingException {
		ArrayList<Map<String, Object>> rooms = service.getMyMeetingRoom((String)session.getAttribute("user_id"),type,type2);
		if(rooms.size() == 0)return "na";
		return utils.jsonParse(rooms);
	}
	@RequestMapping("/member/meeting_page")
	public ModelAndView meetingPage(ModelAndView mv,@RequestParam("meeting_code") String code) {
		mv.setViewName("root/main");
		mv.addObject("code",code);

		mv.addObject("jsp_page", "../member/meeting/meeting_page");
		return mv;
	}
	@RequestMapping("/member/meeting_invite")
	public ModelAndView meetingInvitePage(ModelAndView mv,@RequestParam("code") String code) {
		mv.setViewName("root/main");
		mv.addObject("code",code);
		mv.addObject("jsp_page", "../member/meeting/meeting_invite");
		return mv;
	}
	
	@RequestMapping(value = "/member/room_info", produces = "application/text; charset=utf8")
	public @ResponseBody String getMeetingRoomAllInfo(@RequestParam("code") String code,
			HttpSession session
		) throws JsonProcessingException {
		return utils.jsonParse(service.getMeetingRoomAllInfo(code,(String)session.getAttribute("user_id")));
	}
	@RequestMapping(value = "/member/set_meeting_member", produces = "application/text; charset=utf8")
	public @ResponseBody String setMeetingMember(
			@RequestParam("type") String type,
			@RequestParam(value = "yn",required = false) String yn,
			@RequestParam("code") String code,
			HttpSession session
	) {
		service.setMeetingMemberInfo((String)session.getAttribute("user_id"), code, type, yn);
		return "";
	}
	@RequestMapping(value = "/member/add_comment", produces = "application/text; charset=utf8")
	public @ResponseBody String addComment(
			CommentsEntity entity,
			HttpSession session
	) {
		service.setCommentsInfo((String)session.getAttribute("user_id"), entity);
		return "";
	}
	@RequestMapping(value = "/member/get_comments", produces = "application/text; charset=utf8")
	public @ResponseBody String getComments(
			@RequestParam("code") String code
	) throws JsonProcessingException{
		ArrayList<Map<String, Object>> list = service.getCommentsByCode(code);
		if(list.size() == 0) return "na";
		else return utils.jsonParse(list);
	}
	@RequestMapping(value = "/member/invite_member_ajax", produces = "application/text; charset=utf8")
	public @ResponseBody String inviteMemberAjax(
			@RequestParam("member_list[]") List<String> email_list,
			@RequestParam("code") String code
	) {
		
		if(service.inviteMeetingMember(code, email_list)) {
			return "s";
		}else {
			return "f";
		}
		
	}
	@RequestMapping(value = "/member/set_comment", produces = "application/text; charset=utf8")
	public @ResponseBody String setComment(
			@RequestParam("type") String type,
			@RequestParam("seq") int seq,
			@RequestParam(value = "content", required = false) String content
	) {
		service.setComment(seq, type, content);
		return "";
	}
	
}
