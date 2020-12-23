package com.spring.board.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.sun.istack.Nullable;

import lombok.Data;

@Data
@Entity
@Table(name = "member")
public class MemberEntity {
	
	@Id
	@Column(name = "id")
	private String id;
	@Column(nullable = false)
	private String password;
	@Column(nullable = false)
	private String name;
	@Temporal(TemporalType.TIMESTAMP)
	private Date regDate;
	private String auth;
	
	@PrePersist
	public void setRegDate() {
		this.regDate = this.regDate == null ? new Date():this.regDate;
	}
}
