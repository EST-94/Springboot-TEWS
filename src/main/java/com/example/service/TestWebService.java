package com.example.service;

import java.util.Map;

import com.example.commons.CommandMap;


public interface TestWebService {

	public String createInit() throws Exception;
	
	public Map<String, String> createUser(CommandMap Commandmap) throws Exception;
	public Map<String, String> modifyUser(CommandMap Commandmap) throws Exception;
	public Map<String, String> deleteUser(CommandMap Commandmap) throws Exception;
	
}
