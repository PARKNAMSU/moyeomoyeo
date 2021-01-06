package com.spring.moyeo.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Data;

@Entity
@Table(name = "friends")
@Data
public class FriendsEntity {
	
	@Id
	@GeneratedValue(generator = "friends_seq_gen")
	private int friends_seq;
	
	@Column(nullable = false,insertable = false, updatable = false)
	private String follow_email;
	
	@Column(nullable = false,insertable = false, updatable = false)
	private String follower_email;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date friends_reg_date;
	
	@ManyToOne
	@JoinColumns({
		@JoinColumn(name = "follow_email",referencedColumnName = "email"),
		@JoinColumn(name = "follower_email",referencedColumnName = "email")
	})
	private MemberEntity memberEntity;
	
	@PrePersist
	private void prePersist() {
		this.friends_reg_date = this.friends_reg_date == null ? new Date():this.friends_reg_date;
	}
	
}
