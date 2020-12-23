package com.spring;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum Role {

	ADMIN("ADMIN"), USER("ROLE_USER");

	private String value;

}
