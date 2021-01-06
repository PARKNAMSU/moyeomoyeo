package com.spring.moyeo.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


import lombok.Data;

@Entity
@Table(name = "meeting_member")
@Data
public class MeetingMembrEntity {
	
	@Id
	@GeneratedValue(generator = "meeting_member_seq")
	private int meeting_member_seq;
	
	@Column(insertable = false, updatable = false)
	private int meeting_seq;
	
	private String meeting_member_email;
	
	private String meeting_member_role;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date meeting_member_reg_date;
	
	@ManyToOne
	@JoinColumn(name = "meeting_seq", referencedColumnName = "meeting_seq")
	private MeetingEntity meetingEntity;
	
	@ManyToOne
	@JoinColumn(name = "meeting_member_email",referencedColumnName = "email",insertable = false, updatable = false)
	private MemberEntity memberEntity;
	
	@PrePersist
	private void prePersist() {
		this.meeting_member_reg_date = this.meeting_member_reg_date == null ? new Date():this.meeting_member_reg_date;
	}
}
