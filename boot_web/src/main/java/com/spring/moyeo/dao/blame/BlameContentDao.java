package com.spring.moyeo.dao.blame;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.BlameContentEntity;

public interface BlameContentDao extends CrudRepository<BlameContentEntity, Integer>{

	
	@Query(value = "select count(blame_seq) as num ,blamed_content_seq, "
			+ "(select email from comments where comments_seq = blamed_content_seq) as email, "
			+ "(select comments_content from comments where comments_seq = blamed_content_seq) as content " + 
			"from blame_content where content_type = 'comment' group by blamed_content_seq order by num desc", nativeQuery = true)
	ArrayList<Map<String, Object>> getAllBlameComment();
	
	
	@Query(value = "select count(blame_seq) as num ,blamed_content_code, "
			+ "(select admin_email from meeting where meeting_code = blamed_content_code) as email, "
			+ "(select meeting_name from meeting where meeting_code = blamed_content_code) as name " + 
			"from blame_content where content_type = 'meeting' group by blamed_content_code order by num desc", nativeQuery = true)	
	ArrayList<Map<String, Object>> getAllBlameMeeting();
	
	@Query(value = "select *, to_char(blame_reg_date,'yyyy-mm-dd') as date from blame_content where blamed_content_code = ?1 order by blame_seq desc", nativeQuery = true)
	ArrayList<Map<String, Object>> getBlameForCode(String code);
	
	@Query(value = "select *, to_char(blame_reg_date,'yyyy-mm-dd') as date from blame_content where blamed_content_seq = ?1 order by blame_seq desc", nativeQuery = true)
	ArrayList<Map<String, Object>> getBlameForSeq(int seq);
	
	@Query(value = "with m_date as (" + 
			"    select to_char(cast(d as date),'yyyy-mm-dd') as date" + 
			"    from generate_series(cast(?1 as timestamp),cast(?2 as timestamp),'1 day') d" + 
			"), m_data as (" + 
			"select to_char(blame_reg_date,'yyyy-mm-dd') as m_date,count(*) as num " + 
			"from blame_content where content_type = ?3" + 
			"	group by to_char(blame_reg_date,'yyyy-mm-dd') order by to_char(blame_reg_date,'yyyy-mm-dd') asc" + 
			") select dte.date as date, ?3 as unit,"
			+ "case when dta.num is null then 0 else dta.num end as num from m_date dte left outer join m_data dta on dte.date = dta.m_date",nativeQuery = true)
	ArrayList<Map<String, Object>> getBlameContentStatistics(String from_date, String to_date,String type);
}
