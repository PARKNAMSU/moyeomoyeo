package com.spring.moyeo.dao.meeting;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.MeetingEntity;

public interface MeetingDao extends CrudRepository<MeetingEntity, String> {
	
	@Query(value = "SELECT * FROM meeting WHERE meeting_code = ?1", nativeQuery = true)
	ArrayList<Map<String, Object>> getMeetingUseMeetingCode(String code);
}
