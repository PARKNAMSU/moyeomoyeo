package com.spring.moyeo.dao.blame;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.BlameUserEntity;

public interface BlameUserDao extends CrudRepository<BlameUserEntity, Integer>{

	@Query(value = "select count(blame_seq) as num ,blamed_user from blame_user group by blamed_user order by num desc", nativeQuery = true)
	ArrayList<Map<String, Object>> getAllBlameUser();
}
