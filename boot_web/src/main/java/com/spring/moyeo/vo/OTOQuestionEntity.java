package com.spring.moyeo.vo;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "oto_qst")
@Data
public class OTOQuestionEntity {
	
	@Id
	@GeneratedValue(generator = "oto_qst_seq_gen")
	private int oto_qst_seq;
	
	private String oto_qst_title;
	
	private String oto_qst_writer;
	
	private String oto_qst_content;
	
	private int oto_qst_depth;
	
	private int oto_qst_root_seq;
	
	private Date oto_qst_reg_date;
	
	@PrePersist
	public void prePersist() {
		this.oto_qst_reg_date = this.oto_qst_reg_date == null ? new Date():this.oto_qst_reg_date;
		this.oto_qst_writer = this.oto_qst_writer == null ? "admin":this.oto_qst_writer;
	}
}
