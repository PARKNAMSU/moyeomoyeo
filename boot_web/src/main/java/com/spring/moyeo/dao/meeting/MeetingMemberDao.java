package com.spring.moyeo.dao.meeting;

import org.springframework.data.repository.CrudRepository;

import com.spring.moyeo.vo.MeetingMemberEntity;

public interface MeetingMemberDao extends CrudRepository<MeetingMemberEntity, Integer>{

}
