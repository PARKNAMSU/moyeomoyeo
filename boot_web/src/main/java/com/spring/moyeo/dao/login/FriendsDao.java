package com.spring.moyeo.dao.login;

import java.util.ArrayList;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.FriendsEntity;

public interface FriendsDao extends CrudRepository<FriendsEntity, Integer>{
	
	@Transactional
	@Modifying
	@Query(value = "delete from friends where follower_email = ?1 and follow_email = ?2", nativeQuery = true)
	void unfollowMember(String my_email, String member_email);
	
	@Query(value = "with fw as ( "+ 
			"select follow_email from friends where follower_email = ?1" + 
			")SELECT email,name,nick_name,profile_url "
			+ "FROM member m WHERE (select count(follow_email) from fw where follow_email = m.email) = 0 "
			+ "AND email != ?1 AND auth != 'ADMIN' ORDER BY name asc LIMIT 8", nativeQuery = true)
	ArrayList<Map<String, Object>> getRecommendFriends(String email);
	
	@Query(value = "SELECT email,name,nick_name,profile_url FROM member "
			+ "WHERE email in(select follow_email from friends where follower_email = ?1) ORDER BY name", nativeQuery = true)
	ArrayList<Map<String, Object>> getMyFollower(String email);
	
	@Query(value = "with fw as("
			+ "select follow_email,follower_email from friends"
			+ ")SELECT email,name,nick_name,profile_url,"
			+ "CASE (select count(*) from fw where follow_email = m.email and follower_email = ?1)"
			+ " WHEN 0 then 'n'"
			+ "ELSE 'y' END as res"
			+ " FROM member m "
			+ "WHERE email in(select follower_email from friends where follow_email = ?1) ORDER BY name", nativeQuery = true)
	ArrayList<Map<String, Object>> getMyFollow(String email);
	
	@Query(value = "select count(*) "
			+ "from friends where follower_email = ?1 and follow_email = ?2",nativeQuery = true)
	int getFollowYn(String my_email, String email);
}
