package com.spring;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class BootWebApplication extends SpringBootServletInitializer{

	  @Override
	  protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
	    return builder.sources(BootWebApplication.class);
	  }

	public static void main(String[] args) {
		SpringApplication.run(BootWebApplication.class, args);
	}

}
