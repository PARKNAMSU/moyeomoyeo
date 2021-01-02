package com.spring.moyeo.vo;

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
	@Column(name = "email")
	private String email;
	@Column(nullable = false)
	private String password;
	@Column(nullable = false)
	private String name;
	@Column(nullable = false)
	private String nick_name;
	private String stop_yn;
	@Temporal(TemporalType.TIMESTAMP)
	private Date stop_date;
	@Temporal(TemporalType.TIMESTAMP)
	private Date regDate;
	private String auth;
	
	@PrePersist
	public void prePersist() {
		this.regDate = this.regDate == null ? new Date():this.regDate;
		this.auth = this.auth == null ? "USER":this.auth;
		this.stop_yn = this.stop_yn == null ? "n":this.stop_yn;
	}
}
