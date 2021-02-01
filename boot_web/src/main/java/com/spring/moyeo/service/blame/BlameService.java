package com.spring.moyeo.service.blame;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.moyeo.dao.blame.BlameContentDao;
import com.spring.moyeo.dao.blame.BlameUserDao;
import com.spring.moyeo.vo.BlameContentEntity;
import com.spring.moyeo.vo.BlameUserEntity;

@Service
public class BlameService {

	@Autowired
	BlameUserDao blame_user_dao;
	
	@Autowired
	BlameContentDao blame_content_dao;
	
	public void insertBlame(Object blame, String type) {
		if(type.equals("user")) blame_user_dao.save((BlameUserEntity)blame);
		else blame_content_dao.save((BlameContentEntity)blame);
	}
}
