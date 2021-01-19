package com.spring.moyeo.dao.meeting;

import java.util.ArrayList;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Modifying;
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
			"	WHERE email in(select meeting_member_email from am) and m2.accept_yn = 'y' "
			+ "ORDER BY m2.meeting_member_role ASC, m.name ASC ",nativeQuery = true)
	ArrayList<Map<String, Object>> getMemberByMeetingCode(String code, String email);
	
	@Transactional
	@Modifying
	@Query(value = "update meeting_member set pay_yn = ?3 where meeting_code = ?2 and meeting_member_email = ?1", nativeQuery = true)
	void setPayYn(String email, String code, String pay_yn);
	
	@Transactional
	@Modifying
	@Query(value = "update meeting_member set accept_yn = ?3 where meeting_code = ?2 and meeting_member_email = ?1", nativeQuery = true)
	void setAcceptYn(String email, String code, String accept_yn);
	
	@Query(value = "select * from meeting_member where meeting_member_email = ?1 and meeting_code = ?2",nativeQuery = true)
	MeetingMemberEntity getMemberByEmailAndCode(String email, String code);
	
	@Query(value = "SELECT count(*) FROM meeting_member where meeting_code = ?1", nativeQuery = true)
	int getMemberNumByCode(String code);
	
	@Query(value = "SELECT meeting_member_email FROM meeting_member WHERE meeting_code = ?1",nativeQuery = true)
	ArrayList<String>  getMemberEmailByCode(String code);
	
	@Transactional
	@Modifying
	@Query(value = "delete from meeting_member where meeting_code = ?1", nativeQuery = true)
	void deleteMeetingMemberByCode(String code);
	
	@Query(value = "select 'number' as unit,to_char(meeting_member_reg_date,'yyyy-mm-dd') as date,count(*) as num from meeting_member "
			+ "where to_char(meeting_member_reg_date,'yyyy-mm-dd') between ?1 and ?2 "
			+ "group by to_char(meeting_member_reg_date,'yyyy-mm-dd') order by to_char(meeting_member_reg_date,'yyyy-mm-dd') asc",nativeQuery = true)
	ArrayList<Map<String, Object>> getStatisticsMeetingMember(String from,String to);

}
