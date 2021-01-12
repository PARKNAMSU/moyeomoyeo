package com.spring.moyeo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.spring.moyeo.service.login.LoginService;


@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Autowired
	LoginService service;


    @Override
    public void configure(WebSecurity web) throws Exception
    {
        // static 디렉터리의 하위 파일 목록은 인증 무시 ( = 항상통과 )
        web.ignoring().antMatchers("/resource/**");
        web.ignoring().antMatchers("/favicon.ico");
    }
	
	@Override
	protected void configure(HttpSecurity security) throws Exception{
        security.authorizeRequests()
        // 페이지 권한 설정
        .antMatchers("/").permitAll()
        .antMatchers("/member/**").authenticated()
        .antMatchers("/admin/**").hasRole("ADMIN")
        
    .and() // 로그인 설정
                        .formLogin()
        .loginPage("/login_page").failureUrl("/login_page?error=login_fail")
        .defaultSuccessUrl("/login_access.do").usernameParameter("email")  // 로그인 요청시 id용 파라미터 (메소드 이름이 usernameParameter로 무조건 써야하지만, 파라미터는 email이든 id이든 name이든 상관없다.)
        .passwordParameter("password")
        .permitAll()
    .and() // 로그아웃 설정
                       .logout()
        .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
        .logoutSuccessUrl("/login_page")
        .invalidateHttpSession(true)
    .and()
        // 403 예외처리 핸들링
                       .exceptionHandling().accessDeniedPage("/denied");
	}
	
	  @Bean
	  public PasswordEncoder passwordEncoder() {
	    return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	  }
	
}
