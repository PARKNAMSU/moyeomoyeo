package com.spring.moyeo.service.meeting;

import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.moyeo.dao.meeting.MeetingDao;
import com.spring.moyeo.dao.meeting.MeetingMemberDao;
import com.spring.moyeo.vo.MeetingEntity;
import com.spring.moyeo.vo.MeetingMemberEntity;

@Service
public class MeetingService {

	@Autowired
	MeetingDao meeting_dao;
	
	@Autowired
	MeetingMemberDao meeting_member_dao;
	
	@Transactional
	public void createMeetingRoom(MeetingEntity meeting,String email) {
		MeetingMemberEntity member = new MeetingMemberEntity();
		UUID uuid = null;
		while(true) {
			uuid = UUID.randomUUID();
			ArrayList<Map<String, Object>> list = meeting_dao.getMeetingUseMeetingCode(uuid.toString());
			if(list.size() == 0) {
				meeting.setMeeting_code(uuid.toString());
				meeting_dao.save(meeting);
				break;
			}	
		}
		member.setMeeting_code(uuid.toString());
		member.setMeeting_member_email(email);
		member.setMeeting_member_role("admin");
		meeting_member_dao.save(member);
	}
	
}
