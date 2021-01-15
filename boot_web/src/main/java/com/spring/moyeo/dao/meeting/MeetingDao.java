package com.spring.moyeo.dao.meeting;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.MeetingEntity;

public interface MeetingDao extends CrudRepository<MeetingEntity, String> {
	
	@Query(value = "SELECT * FROM meeting WHERE meeting_code = ?1", nativeQuery = true)
	ArrayList<Map<String, Object>> getMeetingUseMeetingCode(String code);
	
	@Query(value = "with m_member as (\r\n" + 
			"	select meeting_code,meeting_member_role from meeting_member " + 
			"	where meeting_member_email = ?1" + 
			")select m.meeting_name,m.meeting_code,m.meeting_goal,m.meeting_fee," + 
			"	m.end_date_yn,m.finish_yn,m.meeting_num,m.meeting_type," + 
			"	to_char(m.end_date,'yyyy-mm-dd') as end_date," + 
			"	to_char(m.reg_date,'yyyy-mm-dd') as reg_date, m.admin_email," + 
			"	m2.meeting_member_role from meeting m "
			+ "inner join m_member m2 on m.meeting_code = m2.meeting_code " + 
			"where m.meeting_code in(select meeting_code from m_member) and m.finish_yn = ?2"
			+ " and (select accept_yn from meeting_member "
			+ "where meeting_member_email = ?1 and meeting_code = m.meeting_code) = ?3", nativeQuery = true)
	ArrayList<Map<String, Object>> getMyMeetingRoom(String email,String type, String type2);
	
	@Query(value = "SELECT meeting_name, meeting_code, meeting_goal, meeting_fee, " + 
			"  end_date_yn, finish_yn, meeting_num, meeting_type, " + 
			" to_char(end_date,'yyyy-mm-dd') as end_date, " + 
			" to_char(reg_date,'yyyy-mm-dd') as reg_date, admin_email, meeting_info " +
			" FROM meeting WHERE meeting_code = ?1",nativeQuery = true)
	ArrayList<Map<String, Object>> getMeetingUseCode(String code);
	
	
}
