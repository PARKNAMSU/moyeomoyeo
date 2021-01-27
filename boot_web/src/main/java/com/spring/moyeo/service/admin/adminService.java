package com.spring.moyeo.service.admin;

import java.util.ArrayList;
import java.util.List;
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

	
	public ArrayList<ArrayList<Map<String, Object>>> getStatistics(String from_date,String to_date,String type){
		ArrayList<ArrayList<Map<String, Object>>> list_li = new ArrayList<ArrayList<Map<String,Object>>>();
		if(type.equals("sign_up")) {
			list_li.add(login_dao.getSignUpStatistics(from_date, to_date));
		}
		if(type.equals("meeting_member")) list_li.add(meeting_member_dao.getStatisticsMeetingMember(from_date, to_date));
		return list_li;
	}
	public ArrayList<ArrayList<Map<String, Object>>> getStatistics_dtype(String from_date,String to_date,String type,List<String> type2){
		ArrayList<ArrayList<Map<String, Object>>> list_li = new ArrayList<ArrayList<Map<String,Object>>>();
		if(type.equals("meeting")) { 
			for(int i=0;i<type2.size(); i++) list_li.add(meeting_dao.getStatisticsMeetingRoom(from_date, to_date,type2.get(i)));		
		}
		return list_li;
	}
}
