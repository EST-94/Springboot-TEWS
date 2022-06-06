package com.example.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.VO.TestVOforCreate;
import com.example.service.TestUserCreateService;
import com.example.tews.TewsServiceImpl;

import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Controller
@ComponentScan(basePackages = {"com.example.service"})
public class WebController {
	
	@Autowired
	//private final TestUserCreateService testUserCreateService;
	private TestUserCreateService testUserCreateService;
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@GetMapping("/call")
	public String tewsCaller() throws Exception {
		
		String res;
		
		//CommandMap commandMap = new CommandMap();
		
		logger.info("just called '/call'.");
		
		res = testUserCreateService.createInit();
		logger.info("ended '/call'.");

		if (res == null) {
			res = "failed cuz result is null.";
		} 
		
		return res;
	}
	
	@GetMapping("/directcall")
	public String tewsCaller2() throws Exception {
		
		String res = "idle";
		logger.info("just called '/directcall'.");
		
		
		TestVOforCreate userVO = new TestVOforCreate();
		TewsServiceImpl tews = new TewsServiceImpl();
		
		userVO.setUserid((String) ("TEWStester1111"));
		userVO.setFullname((String) ("FULLNAME"));
		userVO.setFirstname((String) ("FIRSTNAME"));
		userVO.setLastname((String) ("LASTNAME"));
		
		//tews.tewsCreateUser(userVO);
		logger.info("ended '/directcall'.");

		if (tews.tewsCreateUser(userVO) == false) {
			res = "sending with tews failed.";
		} else {
			res = "sending with tews success.";
		}
		
		logger.info(res);
		
		
		return res;
	}
	
	
}

