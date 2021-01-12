package com.spring.moyeo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.spring.PATH;


@Configuration
public class WebConfig implements WebMvcConfigurer{
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
	    registry.addResourceHandler("/img/**")
        .addResourceLocations(PATH.PATH.getValue());
    }

}
