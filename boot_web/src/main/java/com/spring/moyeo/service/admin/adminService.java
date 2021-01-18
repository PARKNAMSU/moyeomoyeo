package com.spring.moyeo.service.admin;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.moyeo.dao.login.LoginDao;
import com.spring.moyeo.dao.meeting.CommentsDao;
import com.spring.moyeo.dao.meeting.MeetingDao;
import com.spring.moyeo.dao.meeting.MeetingMemberDao;

@Service
public class adminService {
	
	@Autowired
	LoginDao login_dao;
	
	@Autowired
	MeetingDao meeting_dao;
	
	@Autowired
	MeetingMemberDao meeting_member_dao;
	
	@Autowired
	CommentsDao comments_dao;

	
	public ArrayList<Map<String, Object>> getStatistics(String from_date,String to_date,String type){
		if(type.equals("sign_up")) return login_dao.getSignUpStatistics(from_date, to_date);
		else return null;
	}
}
