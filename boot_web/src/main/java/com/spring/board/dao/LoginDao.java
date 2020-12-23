package com.spring.board.dao;


import org.springframework.data.repository.CrudRepository;

import com.spring.board.vo.MemberEntity;

public interface LoginDao extends CrudRepository<MemberEntity, String>{
	
}
