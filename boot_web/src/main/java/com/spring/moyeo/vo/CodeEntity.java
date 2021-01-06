package com.spring.moyeo.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Data;

@Entity
@Table(name = "code")
@Data
public class CodeEntity {
	
	@Id
	@GeneratedValue(generator = "code_seq_gen")
	private int code_seq;
	
	@Column(nullable = false)
	private String code_name;
	
	@Column(nullable = false)
	private String code_type;
	
	private int code_val_int;
	
	private String code_val_str;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date code_val_date;
}
