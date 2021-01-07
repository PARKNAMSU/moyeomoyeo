package com.spring.moyeo.service.login;

import java.util.Arrays;
import java.util.Collection;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.Role;
import com.spring.moyeo.dao.login.LoginDao;
import com.spring.moyeo.vo.MemberEntity;

@Service
public class LoginService implements UserDetailsService{

	@Autowired
	LoginDao dao;

	@Autowired
	PasswordEncoder passwordEncoder;
	
	public String emailCheck(String email,String passoward) {
		MemberEntity member = dao.getMemberById(email);
		if(member == null) return "id_false";
		else {
			if(passoward.equals("")) return "true";
			else {
				if(passwordEncoder.matches(passoward,member.getPassword())) return "true";
				else return "pass_false";
			}
		}
	}
	public void setActive(String email, String active_yn) {
		MemberEntity member = dao.findById(email)
				.orElseThrow(() -> new IllegalArgumentException("해당 사용자가 없습니다. id=" + email));
		member.setActivate_yn(active_yn);
		System.out.println(member.getActivate_yn());
		dao.save(member);
	}
	public MemberEntity getUser(String email) {
		MemberEntity member = dao.getMemberById(email);
		return member;
	}
	public void createUser(MemberEntity member) {
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		dao.save(member);
	}
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberEntity member = dao.findById(username)
				.orElseThrow(() -> new IllegalArgumentException("해당 사용자가 없습니다. id=" + username));
		if(member.getAuth().equals("ADMIN")) {
			return new User(member.getEmail(),member.getPassword(),getAuthorities(Role.ADMIN.getValue()));
		}else {
			return new User(member.getEmail(),member.getPassword(),getAuthorities(Role.USER.getValue()));
		}
		
	}
	public void updateUser(MemberEntity member) {
		MemberEntity get_member = dao.findById(member.getEmail())
				.orElseThrow(() -> new IllegalArgumentException("해당 사용자가 없습니다. id=" + member.getEmail()));
		get_member.setNick_name(member.getNick_name());
		get_member.setIntroduce(member.getIntroduce());
		get_member.setName(member.getName());
		dao.save(get_member);
	}
	public void updateUserPassword(String email,String password) {
		MemberEntity get_member = dao.findById(email)
				.orElseThrow(() -> new IllegalArgumentException("해당 사용자가 없습니다. id=" + email));
		get_member.setPassword(passwordEncoder.encode(password));
		dao.save(get_member);
	}
	public Collection<? extends GrantedAuthority> getAuthorities(String role) {
		// TODO Auto-generated method stub
		return Arrays.asList(new SimpleGrantedAuthority(role));
	}


}
