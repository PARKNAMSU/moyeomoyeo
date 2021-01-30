package com.spring.moyeo.vo;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "often_question")
@Data
public class OftenQuestionEntity {
	@Id
	@GeneratedValue(generator = "often_question_gen")
	private int often_seq;
	
	private String often_title;
	
	private String often_writer;
	
	private String often_content;
	
	private Date often_reg_date;
	
	@PrePersist
	public void perPersist() {
		this.often_reg_date = this.often_reg_date == null ? new Date():this.often_reg_date;
		this.often_writer = this.often_writer == null ? "admin":this.often_writer;
	}
}
