package com.spring.moyeo.dao.blame;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.BlameUserEntity;

public interface BlameUserDao extends CrudRepository<BlameUserEntity, Integer>{

	@Query(value = "select count(blame_seq) as num ,blamed_user from blame_user group by blamed_user order by num desc", nativeQuery = true)
	ArrayList<Map<String, Object>> getAllBlameUser();
	
	
	@Query(value = "select *,to_char(blame_reg_date,'yyyy-mm-dd') as date from blame_user where blamed_user = ?1 order by blame_seq desc", nativeQuery = true)
	ArrayList<Map<String, Object>> getBlameForBlamedUser(String email);
	
	
	@Query(value = "with m_date as (" + 
			"    select to_char(cast(d as date),'yyyy-mm-dd') as date" + 
			"    from generate_series(cast(?1 as timestamp),cast(?2 as timestamp),'1 day') d" + 
			"), m_data as (" + 
			"select to_char(blame_reg_date,'yyyy-mm-dd') as m_date,count(*) as num " + 
			"from blame_user" + 
			"	group by to_char(blame_reg_date,'yyyy-mm-dd') order by to_char(blame_reg_date,'yyyy-mm-dd') asc" + 
			") select dte.date as date,'user' as unit,"
			+ "case when dta.num is null then 0 else dta.num end as num from m_date dte left outer join m_data dta on dte.date = dta.m_date",nativeQuery = true)
	ArrayList<Map<String, Object>> getBlameUserStatistics(String from_date, String to_date);
}
