package com.spring.moyeo.service.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.moyeo.dao.blame.BlameContentDao;
import com.spring.moyeo.dao.blame.BlameUserDao;
import com.spring.moyeo.dao.board.BoardDao;
import com.spring.moyeo.dao.board.OftenQuestionDao;
import com.spring.moyeo.dao.board.OtoQuestionDao;
import com.spring.moyeo.dao.login.LoginDao;
import com.spring.moyeo.dao.meeting.CommentsDao;
import com.spring.moyeo.dao.meeting.MeetingDao;
import com.spring.moyeo.dao.meeting.MeetingMemberDao;
import com.spring.moyeo.vo.BoardEntity;
import com.spring.moyeo.vo.OTOQuestionEntity;
import com.spring.moyeo.vo.OftenQuestionEntity;

@Service
public class adminService {
	
	@Autowired
	LoginDao login_dao;
	
	@Autowired
	MeetingDao meeting_dao;
	
	@Autowired
	MeetingMemberDao meeting_member_dao;
	
	@Autowired
	CommentsDao comments_dao;

	@Autowired
	BoardDao board_dao;
	
	@Autowired
	OftenQuestionDao often_question_dao;
	
	@Autowired
	OtoQuestionDao oto_question_dao;
	
	@Autowired
	BlameContentDao blame_content_dao;
	
	@Autowired
	BlameUserDao blame_user_dao;
	
	public ArrayList<ArrayList<Map<String, Object>>> getStatistics(String from_date,String to_date,String type){
		ArrayList<ArrayList<Map<String, Object>>> list_li = new ArrayList<ArrayList<Map<String,Object>>>();
		if(type.equals("sign_up")) {
			list_li.add(login_dao.getSignUpStatistics(from_date, to_date));
		}
		if(type.equals("meeting_member")) list_li.add(meeting_member_dao.getStatisticsMeetingMember(from_date, to_date));
		return list_li;
	}
	public ArrayList<ArrayList<Map<String, Object>>> getStatistics_dtype(String from_date,String to_date,String type,List<String> type2){
		ArrayList<ArrayList<Map<String, Object>>> list_li = new ArrayList<ArrayList<Map<String,Object>>>();
		if(type.equals("meeting")) { 
			for(int i=0;i<type2.size(); i++) list_li.add(meeting_dao.getStatisticsMeetingRoom(from_date, to_date,type2.get(i)));		
		}
		if(type.equals("blame")) {
			for(String t:type2) {
				list_li.add(blame_content_dao.getBlameContentStatistics(from_date, to_date, t));
			}
			list_li.add(blame_user_dao.getBlameUserStatistics(from_date, to_date));
		}
		return list_li;
	}
	
	public void manageBoard(BoardEntity board, String type) {
		System.out.println(type);
		if(type.equals("insert"))board_dao.save(board);
		if(type.equals("update")) {
			BoardEntity entity = board_dao.findById(board.getBoard_seq()).get();
			entity.setBoard_content(board.getBoard_content());
			entity.setBoard_title(board.getBoard_title());
			board_dao.save(entity);
		}
		if(type.equals("delete")) {
			board_dao.delete(board);
		}
	}
	public void manageOften(OftenQuestionEntity board, String type) {
		if(type.equals("insert"))often_question_dao.save(board);
		if(type.equals("update")) {
			OftenQuestionEntity entity = often_question_dao.findById(board.getOften_seq()).get();
			entity.setOften_content(board.getOften_content());
			entity.setOften_title(board.getOften_title());
			often_question_dao.save(entity);
		}
		if(type.equals("delete")) {
			often_question_dao.delete(board);
		}
	}
	
	@Transactional
	public void manageOto(OTOQuestionEntity board, String type) {
		if(type.equals("insert")) {
			if(board.getOto_qst_root_seq() != 0) {
				int max = oto_question_dao.getMaxDepthBySeq(board.getOto_qst_root_seq());
				board.setOto_qst_depth(max+1);
			}
			oto_question_dao.save(board);
		}
		if(type.equals("update")) {
			OTOQuestionEntity entity = oto_question_dao.findById(board.getOto_qst_seq()).get();
			entity.setOto_qst_content(board.getOto_qst_content());
			entity.setOto_qst_title(board.getOto_qst_title());
			oto_question_dao.save(entity);
		}
		if(type.equals("delete")) {
			OTOQuestionEntity entity = oto_question_dao.findById(board.getOto_qst_seq()).get();
			if(entity.getOto_qst_depth() == 0) oto_question_dao.deleteOtoUseRootSeq(entity.getOto_qst_seq());
			else oto_question_dao.delete(board);
		}
	}

	
	public ArrayList<Map<String, Object>> getAllBoard(){
		return board_dao.getAllBoardList();
	}
	public Map<String, Object> getBoard(int seq) {
		return board_dao.getOneBoard(seq);
	}
	public ArrayList<Map<String, Object>> getAllOften(){
		return often_question_dao.getAllOften();
	}
	public Map<String, Object> getOften(int seq) {
		return often_question_dao.getOneOften(seq);
	}
	public ArrayList<Map<String, Object>> getAllMyOto(String email){
		return oto_question_dao.getALLMyOto(email);
	}
	public ArrayList<Map<String, Object>> getAllOto(){
		return oto_question_dao.getALLOto();
	}
	public ArrayList<Map<String, Object>> getOtos(int seq){
		return oto_question_dao.getOtoQsts(seq);
	}

}
