package com.spring.moyeo.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Data;

@Entity
@Table(name = "meeting")
@Data
public class MeetingEntity {
	
	@Id
	@Column(name = "meeting_seq")
	@GeneratedValue(generator = "meeting_seq_gen")
	private int meeting_seq;
	
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
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date end_date;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date reg_date;
	
	@OneToMany(mappedBy = "meetingEntity",fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	private List<MeetingMembrEntity> meetingMemberEntity = new ArrayList<MeetingMembrEntity>();
	
	@PrePersist
	public void prePersist() {
		this.reg_date = this.reg_date == null ? new Date():this.reg_date;
		this.finish_yn = this.finish_yn == null ? "n":this.finish_yn;
		this.end_date_yn = this.end_date_yn == null ? "n":this.end_date_yn;
	}
	
}
