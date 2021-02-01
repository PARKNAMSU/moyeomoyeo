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
@Table(name = "blame_user")
@Data
public class BlameUserEntity {

	@Id
	@GeneratedValue(generator = "blame_user_gen")
	private int blame_seq;
	
	private String blamed_user;
	
	private String blaming_user;
	
	private String blame_reason;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date blame_reg_date;
	
	@PrePersist
	protected void prePersist() {
		this.blame_reg_date = this.blame_reg_date == null? new Date():this.blame_reg_date;
	}
	
}
