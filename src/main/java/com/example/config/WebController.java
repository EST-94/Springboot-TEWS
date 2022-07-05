package com.example.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.VO.UserVO;
import com.example.service.TestWebService;
import com.example.tews.TewsServiceImpl;

@Controller
@ComponentScan(basePackages = {"com.example.service"})
public class WebController {
	
	private TestWebService testWebService;
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	final String DEBUG_MOD = "Y";
	
	@GetMapping("/")
	public String mainPageFromWeb() {
		
		logger.info("a User accessed to '/'.");
		
		return "index.html";
	}
	
	//@PostMapping(value = "/receiver")
	@RequestMapping(value = "/receiver", method = RequestMethod.POST)
	public String receiver(
			@RequestParam(value = "method", required = false) String method,
			@RequestParam(value = "Userid", required = false) String userid,
			@RequestParam(value = "Fullname", required = false) String fullname,
			@RequestParam(value = "Firstname", required = false) String firstname,
			@RequestParam(value = "Lastname", required = false) String lastname) throws Exception {
		
		logger.info("a User accessed to '/receiver'. selected mod : ", method);
		
		UserVO userVO = new UserVO();
		TewsServiceImpl tews = new TewsServiceImpl();
		
		if (DEBUG_MOD.equals("Y")) {
			logger.debug("POSTED : ", 
					method, " / ", userid, " / ", fullname, " / ", firstname, " / ", lastname);
		} else {
			if(method.equals("Create")) {
				tews.tewsCreateUser(userVO);
			} else if (method.equals("Modify")) {
				tews.tewsModifyUser(userVO);
			} else if (method.equals("Delete")) {
				tews.tewsDeleteUser(userVO);
			}	
		}
		
		return "result.html";
	}
	
	
	
//	@ResponseBody
//	@GetMapping("/directcall")
//	public String directCaller() throws Exception {
//		
//		String res = "idle";
//		logger.info("just called '/directcall'. this is for create method.");
//		
//		
//		UserVO userVO = new UserVO();
//		TewsServiceImpl tews = new TewsServiceImpl();
//		
//		if (DEBUG_MOD.equals("Y")) {
//			userVO.setUserid("TEWStester1111");
//			userVO.setFullname("FULLNAME");
//			userVO.setFirstname("FIRSTNAME");
//			userVO.setLastname("LASTNAME");
//		} else {
//			
//		}
//		
//		logger.info("sample values are set from '/directcall'.");
//
//		if (tews.tewsCreateUser(userVO) == false) {
//			res = "sending with tews failed.";
//		} else {
//			res = "sending with tews success.";
//		}
//		
//		logger.info(res);
//		
//		
//		return res;
//	}
	
	
}

