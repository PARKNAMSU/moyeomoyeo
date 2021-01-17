package com.spring.moyeo.dao.meeting;

import java.util.ArrayList;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.CommentsEntity;

public interface CommentsDao extends CrudRepository<CommentsEntity, Integer> {
	
	@Query(value = "SELECT "
			+ "c.comments_seq, c.comments_content, to_char(c.comments_reg_date,'yyyy-mm-dd') as reg_date,"
			+ "c.email, m.name, m.profile_url "
		 + "FROM comments c inner join member m on c.email = m.email "
		 + "WHERE meeting_code = ?1 ORDER BY c.comments_reg_date DESC", nativeQuery = true)
	ArrayList<Map<String, Object>> getCommentsByCode(String code);
	
	@Transactional
	@Modifying
	@Query(value = "delete from comments where meeting_code = ?1", nativeQuery = true)
	void deleteCommentsByCode(String code);
}
