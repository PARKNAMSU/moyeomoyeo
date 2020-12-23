package com.spring.moyeo.service;

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
import com.spring.moyeo.dao.LoginDao;
import com.spring.moyeo.vo.MemberEntity;

@Service
public class MemberService implements UserDetailsService{

	@Autowired
	LoginDao dao;

	@Autowired
	PasswordEncoder passwordEncoder;
	
	public void createUser(MemberEntity member) {
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		dao.save(member);
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberEntity member = dao.findById(username)
				.orElseThrow(() -> new IllegalArgumentException("해당 사용자가 없습니다. id=" + username));
		if(member.getAuth().equals("ADMIN")) {
			return new User(member.getId(),member.getPassword(),getAuthorities(Role.ADMIN.getValue()));
		}else {
			return new User(member.getId(),member.getPassword(),getAuthorities(Role.USER.getValue()));
		}
		
	}
	public Collection<? extends GrantedAuthority> getAuthorities(String role) {
		// TODO Auto-generated method stub
		return Arrays.asList(new SimpleGrantedAuthority(role));
	}


}
