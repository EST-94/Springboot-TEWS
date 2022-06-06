package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.example.commons.CommandMap;


public interface TestUserCreateService {

	public String createInit() throws Exception;
	
	public Map<String, String> createUser(CommandMap Commandmap) throws Exception;
	
}
