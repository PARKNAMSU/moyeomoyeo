package com.spring.moyeo.dao.board;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.OftenQuestionEntity;

public interface OftenQuestionDao extends CrudRepository<OftenQuestionEntity, Integer>{

	@Query(value = "SELECT "
			+ "often_seq as seq, often_writer as writer, often_content as content, "
			+ "to_char(often_reg_date,'yyyy-mm-dd') as reg_date, often_title as title"
			+ " FROM often_question",nativeQuery = true)
	ArrayList<Map<String, Object>> getAllOften();
}
