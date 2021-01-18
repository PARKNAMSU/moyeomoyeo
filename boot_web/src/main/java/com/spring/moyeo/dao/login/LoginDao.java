package com.spring.moyeo.dao.login;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.MemberEntity;

public interface LoginDao extends CrudRepository<MemberEntity, String>{
	
	@Query(value = "SELECT * FROM member WHERE email = ?1", nativeQuery = true)
	MemberEntity getMemberById(String email);
	
	@Query(value = "with fw as ( "+ 
			"select follow_email from friends where follower_email = ?2" + 
			")SELECT email,name,nick_name,profile_url,"
			+ "case (select count(follow_email) from fw where follow_email = m.email) "
			+ "	when 0 then 'f' " + 
			  "else ?1 end as res " + 
			"FROM member m WHERE email like concat('%',?1,'%') and email != ?2 ", nativeQuery = true)
	ArrayList<Map<String, Object>>  getMemberBySearchEmail(String search,String email);
	
	@Query(value = "with fw as ( "+ 
			"select follow_email from friends where follower_email = ?2" + 
			")SELECT email,name,nick_name,profile_url,"
			+ "case (select count(follow_email) from fw where follow_email = m.email) "
			+ "	when 0 then 'f' " + 
			  "else ?1 end as res " + 
			"FROM member m WHERE name like concat('%',?1,'%') and email != ?2", nativeQuery = true)
	ArrayList<Map<String, Object>>  getMemberBySearchName(String name, String email);
	
	@Query(value = "with fw as ( "+ 
			"select follow_email from friends where follower_email = ?2" + 
			")SELECT email,name,nick_name,profile_url,"
			+ "case (select count(follow_email) from fw where follow_email = m.email) "
			+ "	when 0 then 'f' " + 
			  "else ?1 end as res " + 
			"FROM member m WHERE nick_name like concat('%',?1,'%') and email != ?2", nativeQuery = true)
	ArrayList<Map<String, Object>>  getMemberBySearchNickName(String name,String email);
	
	@Query(value = "select 'id' as unit,to_char(reg_date,'yyyy-mm-dd') as date,count(*) as num from member "
			+ "where to_char(reg_date,'yyyy-mm-dd') between ?1 and ?2 "
			+ "group by to_char(reg_date,'yyyy-mm-dd') order by to_char(reg_date,'yyyy-mm-dd') asc",nativeQuery = true)
	ArrayList<Map<String, Object>> getSignUpStatistics(String from_date, String to_date);
	
}
