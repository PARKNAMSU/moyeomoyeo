package com.spring.common;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class Utils {

	public void mkDir(String path) {
		
		File Folder = new File(path);
		if (!Folder.exists()) {
			try {
				Folder.mkdirs();
			} catch (Exception e) {
				e.getStackTrace();
			}
		} else {
			System.out.println("생성x");
		}
	}
	
	public String jsonParse(Object object) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(object);
		return jsonStr;
	}
	public Object getSessionAttr(HttpSession session, String key) {
		return session.getAttribute(key);
	}
}
