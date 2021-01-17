package com.spring.moyeo.service.meeting;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.moyeo.dao.meeting.CommentsDao;
import com.spring.moyeo.dao.meeting.MeetingDao;
import com.spring.moyeo.dao.meeting.MeetingMemberDao;
import com.spring.moyeo.vo.CommentsEntity;
import com.spring.moyeo.vo.MeetingEntity;
import com.spring.moyeo.vo.MeetingMemberEntity;

@Service
public class MeetingService {

	@Autowired
	MeetingDao meeting_dao;
	
	@Autowired
	MeetingMemberDao meeting_member_dao;
	
	@Autowired
	CommentsDao comments_dao;
	
	@Transactional
	public void createMeetingRoom(MeetingEntity meeting,String email) {
		meeting.setAdmin_email(email);
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
		member.setAccept_yn("y");
		member.setMeeting_code(uuid.toString());
		member.setMeeting_member_email(email);
		member.setMeeting_member_role("admin");
		meeting_member_dao.save(member);
	}
	@Transactional
	public boolean inviteMeetingMember(String code, List<String> email_list) {
		MeetingEntity meeting = meeting_dao.findById(code).get();
		int now_num = meeting_member_dao.getMemberNumByCode(code);
		System.out.println(meeting.getMeeting_num());
		System.out.println(email_list.size());
		System.out.println(now_num);
		if(meeting.getMeeting_num() < email_list.size()+now_num) return false;

		for(String item: email_list) {
			MeetingMemberEntity entity = new MeetingMemberEntity();
			entity.setMeeting_code(code);
			entity.setMeeting_member_email(item);
			meeting_member_dao.save(entity);
		}
		return true;
	}
	
	public ArrayList<Map<String, Object>> getMyMeetingRoom(String email, String type, String type2){
		return meeting_dao.getMyMeetingRoom(email,type,type2);
	}
	
	public ArrayList<Object> getMeetingRoomAllInfo(String code,String email){
		ArrayList<Object> list = new ArrayList<Object>();
		list.add(meeting_dao.getMeetingUseCode(code));
		list.add(meeting_member_dao.getMemberByMeetingCode(code,email));
		return list;
	}
	public void setMeetingMemberInfo(String email, String code, String type, String yn) {
		if(type.equals("accept"))meeting_member_dao.setAcceptYn(email, code, yn);
		else if(type.equals("pay"))meeting_member_dao.setPayYn(email, code, yn);
		else if(type.equals("delete")) {
			MeetingMemberEntity entity = meeting_member_dao.getMemberByEmailAndCode(email, code);
			meeting_member_dao.delete(entity);
		}
	}
	public void setCommentsInfo(String email, CommentsEntity entity) {
		entity.setEmail(email);
		comments_dao.save(entity);
	}
	public ArrayList<Map<String, Object>> getCommentsByCode(String code){
		return comments_dao.getCommentsByCode(code);
	}
	
	public ArrayList<String> getMemberEmails(String code){
		return meeting_member_dao.getMemberEmailByCode(code);
	}
	
	public void setComment(int seq, String type, String content) {
		CommentsEntity entity = comments_dao.findById(seq).get();
		if(type.equals("delete")) comments_dao.delete(entity);
		else {
			entity.setComments_content(content);
			comments_dao.save(entity);
		}
	}
	public void setMeetingRoom(MeetingEntity entity) {
		MeetingEntity entity_get = meeting_dao.findById(entity.getMeeting_code()).get();
		entity_get.setEnd_date(entity.getEnd_date());
		entity_get.setMeeting_goal(entity.getMeeting_goal());
		entity_get.setMeeting_info(entity.getMeeting_info());
		entity_get.setMeeting_name(entity.getMeeting_name());
		meeting_dao.save(entity_get);
	}
	
	public ArrayList<Map<String, Object>> getMeetingRoomForSearch(String search, String email, String type){
		if(type.equals("name")) return meeting_dao.getMeetingForSearchName(search, email);
		return meeting_dao.getMeetingForSearchGoal(search, email);
	}
	
	@Transactional
	public boolean attendRoom(String code, String email) {
		int now_num = meeting_member_dao.getMemberNumByCode(code);
		MeetingEntity room = meeting_dao.findById(code).get();
		if(now_num >= room.getMeeting_num()) return false;
		MeetingMemberEntity entity = new MeetingMemberEntity();
		entity.setMeeting_code(code);
		entity.setMeeting_member_email(email);
		entity.setAccept_yn("y");
		meeting_member_dao.save(entity);
		return true;
	}
	public void exitRoom(String code, String email) {
		MeetingMemberEntity entity = meeting_member_dao.getMemberByEmailAndCode(email, code);
		meeting_member_dao.delete(entity);
	}
}
