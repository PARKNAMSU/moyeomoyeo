package com.spring.moyeo.dao.meeting;

import java.util.ArrayList;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Modifying;
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
	
	@Query(value = "with mm as(" + 
			"	select meeting_code from meeting_member where meeting_member_email = ?2" + 
			") select meeting_name, meeting_code, meeting_goal, meeting_fee," + 
			" end_date_yn, finish_yn, meeting_num, meeting_type," + 
			" to_char(end_date,'yyyy-mm-dd') as end_date," + 
			" to_char(reg_date,'yyyy-mm-dd') as reg_date, admin_email, meeting_info "
			+ "from meeting where meeting_code not in (select meeting_code from mm) and meeting_name like concat('%',?1,'%')"
			+ " and finish_yn = 'n' and meeting_type = 'open'", nativeQuery = true)
	ArrayList<Map<String, Object>> getMeetingForSearchName(String search,String email);
	
	@Query(value = "with mm as(" + 
			"	select meeting_code from meeting_member where meeting_member_email = ?2" + 
			") select meeting_name, meeting_code, meeting_goal, meeting_fee," + 
			" end_date_yn, finish_yn, meeting_num, meeting_type," + 
			" to_char(end_date,'yyyy-mm-dd') as end_date," + 
			" to_char(reg_date,'yyyy-mm-dd') as reg_date, admin_email, meeting_info "
			+ "from meeting where meeting_code not in (select meeting_code from mm) and meeting_goal like concat('%',?1,'%')"
			+ " and finish_yn = 'n' and meeting_type = 'open'", nativeQuery = true)
	ArrayList<Map<String, Object>> getMeetingForSearchGoal(String search,String email);
	
	@Transactional
	@Modifying
	@Query(value = "update meeting set finish_yn = 'y' "
			+ "where end_date_yn = 'y' and end_date <= now() + '-1days';",nativeQuery = true)
	void finishDateCk();
	
	@Query(value = "select meeting_type as unit,to_char(reg_date,'yyyy-mm-dd') as date,count(*) as num from meeting "
			+ "where to_char(reg_date,'yyyy-mm-dd') between ?1 and ?2 "
			+ "group by meeting_type, to_char(reg_date,'yyyy-mm-dd') order by meeting_type asc, to_char(reg_date,'yyyy-mm-dd') asc",nativeQuery = true)
	ArrayList<Map<String, Object>> getStatisticsMeetingRoom(String from,String to);
}
