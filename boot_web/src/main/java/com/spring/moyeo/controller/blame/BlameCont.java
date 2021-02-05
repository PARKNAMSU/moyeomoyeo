package com.spring.moyeo.controller.blame;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.spring.common.Utils;
import com.spring.moyeo.service.blame.BlameService;
import com.spring.moyeo.vo.BlameContentEntity;
import com.spring.moyeo.vo.BlameUserEntity;

@Controller
public class BlameCont {

	@Autowired
	BlameService blame_service;
	
	@Autowired
	Utils utils;
	
	@RequestMapping(value = "/member/add_blame", produces = "application/text; charset=utf8")
	public @ResponseBody String insertBlame(
			BlameUserEntity user,
			BlameContentEntity content,
			HttpSession session,
			@RequestParam("type") String type
	) {
		user.setBlaming_user((String)session.getAttribute("user_id"));
		content.setBlaming_user((String)session.getAttribute("user_id"));
		if(type.equals("user")) blame_service.insertBlame(user, type);
		else blame_service.insertBlame(content, type);
		return "";
	}
	
	@RequestMapping(value = "/admin/all_blame", produces = "application/text; charset=utf8")
	public @ResponseBody String getAllBlames(
			@RequestParam("type") String type
	) throws JsonProcessingException {
		return utils.jsonParse(blame_service.getAllBlame(type));
	}
	
	@RequestMapping(value = "/admin/get_blame", produces = "application/text; charset=utf8")
	public @ResponseBody String getBlameById(
			@RequestParam("type") String type,
			@RequestParam("id") Object id
	) throws JsonProcessingException {
		return utils.jsonParse(blame_service.getBlameForId(id, type));
	}
	
	
	
}
