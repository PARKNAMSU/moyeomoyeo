package com.spring.moyeo.vo;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Data;

@Entity
@Table(name = "blame_content")
@Data
public class BlameContentEntity {

	@Id
	@GeneratedValue(generator = "blame_content_gen")
	private int blame_seq;
	
	private int blamed_content_seq;
	private String blamed_content_code;
	
	private String blaming_user;
	
	private String blame_reason;
	
	private String content_type;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date blame_reg_date;
	
	@PrePersist
	protected void prePersist() {
		this.blame_reg_date = this.blame_reg_date == null? new Date():this.blame_reg_date;
	}
}
