package com.spring.moyeo.dao.meeting;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.MeetingMemberEntity;

public interface MeetingMemberDao extends CrudRepository<MeetingMemberEntity, Integer>{
	
	@Query(value = "with am as (" + 
			"	select * from meeting_member where meeting_code = ?1" + 
			") SELECT m.email,m.name,m.nick_name,m.profile_url,m.phone_number,m2.meeting_member_role,m2.pay_yn, "
			+"	case (select count(*) from friends where follower_email = ?2 and follow_email = m.email) " + 
			"	when 0 then 'n' " + 
			"	else 'y' end follow_yn"
			+ " FROM member m INNER JOIN am m2 on m.email = m2.meeting_member_email " + 
			"	WHERE email in(select meeting_member_email from am) "
			+ "ORDER BY m2.meeting_member_role ASC, m.name ASC ",nativeQuery = true)
	ArrayList<Map<String, Object>> getMemberByMeetingCode(String code, String email);
}
