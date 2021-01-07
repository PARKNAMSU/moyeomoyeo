package com.spring.common;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class JsonParse {
	
	public String jsonParse(Object object) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(object);
		return jsonStr;
	}
}
