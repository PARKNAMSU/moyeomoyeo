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
public class MeetingMemberEntity {
	
	@Id
	@GeneratedValue(generator = "meeting_member_seq")
	private int meeting_member_seq;
	
	@Column(updatable = false)
	private String meeting_code;
	
	private String meeting_member_email;
	
	private String meeting_member_role;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date meeting_member_reg_date;
	
	@PrePersist
	private void prePersist() {
		this.meeting_member_reg_date = this.meeting_member_reg_date == null ? new Date():this.meeting_member_reg_date;
		this.meeting_member_role = this.meeting_member_role == null ? "member":this.meeting_member_role;
	}
}
