package com.spring.moyeo.dao.board;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.BoardEntity;

public interface BoardDao extends CrudRepository<BoardEntity, Integer>{

	
	@Query(value = "SELECT "
			+ "board_seq as seq, board_title as title, board_writer as writer, to_char(board_reg_date,'yyyy-mm-dd') as reg_date, board_content as content "
			+ "FROM board ORDER BY board_seq DESC", nativeQuery = true)
	ArrayList<Map<String, Object>> getAllBoardList();
	
	@Query(value = "SELECT "
			+ "board_seq,board_title,board_writer, to_char(board_reg_date,'yyyy-mm-dd') as board_reg_date, board_content"
			+ " FROM board WHERE board_seq = ?1", nativeQuery = true)
	Map<String, Object> getOneBoard(int seq);
}
