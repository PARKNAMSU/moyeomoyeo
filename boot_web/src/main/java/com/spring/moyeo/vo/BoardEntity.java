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
@Table(name = "board")
@Data
public class BoardEntity {
	
	@Id
	@GeneratedValue(generator = "board_seq_gen")
	private int board_seq;
	
	private String board_title;
	
	private String board_writer;
	
	private String board_content;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date board_reg_date;
	
	@PrePersist
	public void prePersist() {
		this.board_writer = this.board_writer == null ? "admin":this.board_writer;
		this.board_reg_date = this.board_reg_date == null ? new Date():this.board_reg_date;
	}
	
	
}
