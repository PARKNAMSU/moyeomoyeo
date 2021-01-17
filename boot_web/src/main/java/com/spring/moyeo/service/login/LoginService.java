package com.spring.moyeo.service.login;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Map;

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
import com.spring.moyeo.dao.login.FriendsDao;
import com.spring.moyeo.dao.login.LoginDao;
import com.spring.moyeo.vo.FriendsEntity;
import com.spring.moyeo.vo.MemberEntity;

@Service
public class LoginService implements UserDetailsService{

	@Autowired
	LoginDao dao;

	@Autowired
	FriendsDao friends_dao;
	
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
	
	public int getFollowYn(String my_email,String email) {
		return friends_dao.getFollowYn(my_email, email);
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
		get_member.setIntroduce(member.getIntroduce());
		get_member.setName(member.getName());
		get_member.setPhone_corp(member.getPhone_corp());
		get_member.setPhone_number(member.getPhone_number());
		dao.save(get_member);
	}
	public void updateUserPassword(String email,String password) {
		MemberEntity get_member = dao.getMemberById(email);
		get_member.setPassword(passwordEncoder.encode(password));
		dao.save(get_member);
	}
	public Collection<? extends GrantedAuthority> getAuthorities(String role) {
		// TODO Auto-generated method stub
		return Arrays.asList(new SimpleGrantedAuthority(role));
	}
	public void updateProfileUrl(String img_url,String email) {
		MemberEntity member = dao.getMemberById(email);
		member.setProfile_url(img_url);
		dao.save(member);
	}
	
	public ArrayList<Map<String, Object>> searchMember(String search, String opt,String email) {
		if(opt.equals("email")) return dao.getMemberBySearchEmail(search,email);
		if(opt.equals("name")) return dao.getMemberBySearchName(search,email);
		else return dao.getMemberBySearchNickName(search,email);
	}
	
	public ArrayList<Map<String, Object>> recommendMember(String email){
		return friends_dao.getRecommendFriends(email);
	}
	public void setFollowMember(FriendsEntity entity, String follow_yn) {
		System.out.println(entity.getFollow_email());
		if(follow_yn.equals("y")) friends_dao.save(entity);
		else friends_dao.unfollowMember(entity.getFollower_email(), entity.getFollow_email());
	}
	
	public ArrayList<Map<String, Object>> getFollowMember(String email, String followOrFollower) {
		if(followOrFollower.equals("follow")) return friends_dao.getMyFollow(email);
		else return friends_dao.getMyFollower(email);
	}

}
