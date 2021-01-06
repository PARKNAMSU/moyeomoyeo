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

import lombok.Data;

@Entity
@Table(name = "comments")
@Data
public class CommentsEntity {
	
	@Id
	@GeneratedValue(generator = "comments_seq_gen")
	private int comments_seq;
	
	private int meeting_seq;
	
	private String email;
	
	@Column(nullable = false)
	private String comments_content;
	
	private Date comments_reg_date;
	
	@ManyToOne
	@JoinColumn(name = "meeting_seq",referencedColumnName = "meeting_seq", insertable = false,updatable = false)
	private MeetingEntity meetingEntity;
	
	@ManyToOne
	@JoinColumn(name = "email", referencedColumnName = "email" , insertable = false,updatable = false)
	private MemberEntity memberEntity;
	
	@PrePersist
	public void prePersist() {
		this.comments_reg_date = this.comments_reg_date == null ? new Date():this.comments_reg_date;
	}
}
