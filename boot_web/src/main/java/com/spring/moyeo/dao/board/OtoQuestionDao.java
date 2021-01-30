package com.spring.moyeo.dao.board;

import java.util.ArrayList;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.OTOQuestionEntity;

public interface OtoQuestionDao extends CrudRepository<OTOQuestionEntity, Integer>{

	@Query(value = "SELECT max(oto_qst_depth) FROM oto_qst"
			+ " WHERE oto_seq = ?1",nativeQuery = true)
	int getMaxDepthBySeq(int seq);
	
	@Query(value = "SELECT "
			+ "oto_qst_seq,oto_qst_title,oto_qst_writer,"
			+ "oto_qst_content,oto_qst_depth,oto_qst_root_seq,to_char(oto_qst_reg_date,'yyyy-mm-dd') as oto_qst_reg_date "
			+ "FROM oto_qst WHERE oto_qst_root_seq = ?1 ORDER BY oto_qst_depth ASC",nativeQuery = true)
	ArrayList<Map<String, Object>> getOtoQsts(int seq);
	
	@Query(value = "update oto_qst set oto_qst_root_seq = oto_qst_seq WHERE oto_qst_seq = ?1", nativeQuery = true)
	@Transactional
	@Modifying
	void setRootRootPath(int seq);
	
	@Query(value = "SELECT "
			+ "oto_qst_seq,oto_qst_title,oto_qst_writer,"
			+ "oto_qst_content,to_char(oto_qst_reg_date,'yyyy-mm-dd') as oto_qst_reg_date "
			+ "FROM oto_qst WHERE oto_qst_depth = 0 ORDER BY oto_qst_reg_date DESC",nativeQuery = true)
	ArrayList<Map<String, Object>> getALLOto();
	
	@Query(value = "DELETE FROM oto_qst WHERE oto_qst_root_seq = ?1",nativeQuery = true)
	@Transactional
	@Modifying
	void deleteOtoUseRootSeq(int seq);
}
