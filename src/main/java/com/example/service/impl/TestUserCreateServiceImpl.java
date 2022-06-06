package com.example.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Service;

import com.example.VO.TestVOforCreate;
import com.example.commons.CommandMap;
import com.example.service.TestUserCreateService;
import com.example.tews.TewsService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@ComponentScan(basePackages = {"com.example.tews"})
public class TestUserCreateServiceImpl implements TestUserCreateService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	TewsService tewsService;
	
	//@Autowired
	public Map<String, String> createUser(CommandMap Commandmap) throws Exception {
		
		TestVOforCreate userVO = new TestVOforCreate();
		Map<String, String> resultMap = new HashMap<String, String>();
		
		userVO.setUserid((String) Commandmap.get("userid"));
		userVO.setFullname((String) Commandmap.get("fullname"));
		userVO.setFirstname((String) Commandmap.get("firstname"));
		userVO.setLastname((String) Commandmap.get("lastname"));
		
		// tewsService에서 생성된 VO정보 넣고 돌린 후 결과값 리턴해주면 됨
		
		try {
		
			if (tewsService.tewsCreateUser(userVO)) {
				logger.debug("from TestUserCreateService : tewsService.tewsCreateUser success.");
				resultMap.put("result", "success");
				
			} else {
				logger.debug("from TestUserCreateService : tewsService.tewsCreateUser failed.");
				resultMap.put("result", "failed");
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return resultMap;
		
	}

	//@Autowired
	@SuppressWarnings("null")
	public String createInit() throws Exception {
		CommandMap commandmap = new CommandMap();
		
		// set commandMap's value
		// should contain parameters of request
		
		commandmap.put("userid", "TEWStester0603");
		commandmap.put("fullname", "FULLNAME");
		commandmap.put("firstname", "FIRSTNAME");
		commandmap.put("lastname", "LASTNAME");
		
		logger.info("commandMap has set : " + (String) commandmap.get("userid"));
		
		String result = createUser(commandmap).get("result");
		
		return result;
	}
	
//	public Map<String, String> rootSec() throws Exception {
//		
//		TestVOforCreate userVO = new TestVOforCreate();
//		Map<String, String> resultMap = new HashMap<String, String>();
//		
//		userVO.setUserid((String) ("TEWStester0603"));
//		userVO.setFullname((String) ("FULLNAME"));
//		userVO.setFirstname((String) ("FIRSTNAME"));
//		userVO.setLastname((String) ("LASTNAME"));
//		
//		// tewsService에서 생성된 VO정보 넣고 돌린 후 결과값 리턴해주면 됨
//		
//		try {
//		
//			if (tewsService.tewsCreateUser(userVO)) {
//				logger.debug("from TestUserCreateService : tewsService.tewsCreateUser success.");
//				resultMap.put("result", "success");
//				
//			} else {
//				logger.debug("from TestUserCreateService : tewsService.tewsCreateUser failed.");
//				resultMap.put("result", "failed");
//			}
//			
//		} catch (Exception e) {
//			System.out.println(e.toString());
//		}
//		
//		return resultMap;
//		
//	}
}
