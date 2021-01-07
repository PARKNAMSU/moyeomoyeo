package com.spring.moyeo.dao.meeting;

import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.MeetingEntity;

public interface MeetingDao extends CrudRepository<MeetingEntity, Integer> {

}
