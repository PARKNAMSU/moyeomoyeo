package com.spring.board.service;

import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.LoginDao;
import com.spring.board.vo.MemberEntity;

@Service
public class LoginService {
	
	@Autowired
	private LoginDao dao;
	
	public String getId(String id, String password) {	
		MemberEntity member; 
		try{
			member = dao.findById(id).get();
			if(member != null) {
				if(password.equals(member.getPassword())) {
					return "success";
				}else {
					return "p_fail";
				}	
			}
		}catch (NoSuchElementException e) {
			return "i_fail";
		}
		return "i_fail";
	}
}
