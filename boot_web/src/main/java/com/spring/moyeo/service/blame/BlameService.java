package com.spring.moyeo.service.blame;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.moyeo.dao.blame.BlameContentDao;
import com.spring.moyeo.dao.blame.BlameUserDao;
import com.spring.moyeo.dao.login.LoginDao;
import com.spring.moyeo.vo.BlameContentEntity;
import com.spring.moyeo.vo.BlameUserEntity;

@Service
public class BlameService {

	@Autowired
	BlameUserDao blame_user_dao;
	
	@Autowired
	BlameContentDao blame_content_dao;
	
	@Autowired
	LoginDao login_dao;
	
	public void insertBlame(Object blame, String type) {
		if(type.equals("user")) blame_user_dao.save((BlameUserEntity)blame);
		else blame_content_dao.save((BlameContentEntity)blame);
	}
	
	public ArrayList<Map<String, Object>> getAllBlame(String type){
		if(type.equals("user")) return blame_user_dao.getAllBlameUser();
		if(type.equals("meeting")) return blame_content_dao.getAllBlameMeeting();
		else return blame_content_dao.getAllBlameComment();
	}
	
	public ArrayList<Map<String, Object>> getBlameForId(Object id, String type){
		if(type.equals("user")) return blame_user_dao.getBlameForBlamedUser((String)id);
		if(type.equals("meeting")) return blame_content_dao.getBlameForCode((String)id);
		else return blame_content_dao.getBlameForSeq(Integer.parseInt((String) id));
	}
	public void blockUser(String email, String date) {
		login_dao.blockUser(email, date);
	}
}
