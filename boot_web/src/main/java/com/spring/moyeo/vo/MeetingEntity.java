package com.spring.moyeo.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import lombok.Data;

@Entity
@Table(name = "meeting")
@Data
public class MeetingEntity {
	
	@Id
	@Column(name = "meeting_code")
	private String meeting_code;
	
	@Column(nullable = false)
	private String meeting_type;
	
	@Column(nullable = false)
	private String meeting_name;
	
	@Column(nullable = false)
	private int meeting_fee;
	
	@Column(nullable = false)
	private int meeting_num;
	
	@Column(nullable = false)
	private String meeting_goal;
	
	private String meeting_info;
	
	@Column(nullable = false)
	private String end_date_yn;
	
	@Column(nullable = false)
	private String finish_yn;
	
	private Date end_date;
	
	@Transient
	private String end_date_str;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date reg_date;
	
	
	@PrePersist
	public void prePersist() {
		this.reg_date = this.reg_date == null ? new Date():this.reg_date;
		this.finish_yn = this.finish_yn == null ? "n":this.finish_yn;
		this.end_date_yn = this.end_date_yn == null ? "n":this.end_date_yn;
	}
	
}
