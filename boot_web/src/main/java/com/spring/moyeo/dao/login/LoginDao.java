package com.spring.moyeo.dao.login;


import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.MemberEntity;

public interface LoginDao extends CrudRepository<MemberEntity, String>{
	
	@Query(value = "SELECT * FROM member WHERE email = ?1", nativeQuery = true)
	MemberEntity getMemberById(String email);
}
