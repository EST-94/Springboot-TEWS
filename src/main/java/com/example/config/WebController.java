package com.example.config;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.VO.UserVO;
import com.example.commons.CommandMap;
import com.example.service.TestWebService;
import com.example.tews.TewsServiceImpl;

@Controller
@ComponentScan(basePackages = {"com.example.service"})
public class WebController {
	
	private TestWebService testWebService;
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@ResponseBody
	@GetMapping("/")
	public String mainPageFromWeb() {
		
		return "index";
	}
	
	@ResponseBody
	@GetMapping("/create")
	public String createUserFromWeb(Model model,
			@RequestParam("") String userId,
			@RequestParam("") String firstName,
			@RequestParam("") String lastName,
			@RequestParam("") String fullName) throws Exception {
		
		Map<String, String> res;
		String message;
		CommandMap commandMap = new CommandMap();
				
		logger.info("just called '/create'.");
		
		// need to make setter from web - of commandmap
		// if not so, it will remain as 'null' and make exception
		
		commandMap.put("userid", userId);
		commandMap.put("fullname", fullName);
		commandMap.put("firstname", firstName);
		commandMap.put("lastname", lastName);
		
		res = testWebService.createUser(commandMap);
		logger.info("ended '/create'.");

		if (res == null) {
			res.put("result", "failed cuz result is null.");
		} else {
			res.put("result", "create request ended.");
			model.addAttribute("resultBox", res.get("result"));
		}
		
		message = res.get("result");
		
		return message;
	}
	
	@ResponseBody
	@GetMapping("/modify")
	public String modifyUserFromWeb(Model model) throws Exception {
		
		Map<String, String> res;
		String message;
		CommandMap commandMap = new CommandMap();
				
		logger.info("just called '/modify'.");
		
		// need to make setter from web - of commandmap
		// if not so, it will remain as 'null' and make exception
		
		res = testWebService.modifyUser(commandMap);
		logger.info("ended '/create'.");

		if (res == null) {
			res.put("result", "failed cuz result is null.");
		} else {
			res.put("result", "modify request ended.");
			model.addAttribute("resultBox", res.get("result"));
		}
		
		message = res.get("result");
		
		return message;
		
	}
	
	@ResponseBody
	@GetMapping("/delete")
	public String deleteUserFromWeb(Model model) throws Exception {
		
		Map<String, String> res;
		String message;
		CommandMap commandMap = new CommandMap();
				
		logger.info("just called '/delete'.");
		
		// need to make setter from web - of commandmap
		// if not so, it will remain as 'null' and make exception
		
		res = testWebService.deleteUser(commandMap);
		logger.info("ended '/create'.");

		if (res == null) {
			res.put("result", "failed cuz result is null.");
		} else {
			res.put("result", "delete request ended.");
			model.addAttribute("resultBox", res.get("result"));
		}
		
		message = res.get("result");
		
		return message;
	}
	
	
	@ResponseBody
	@GetMapping("/directcall")
	public String directCaller() throws Exception {
		
		String res = "idle";
		logger.info("just called '/directcall'. this is for create method.");
		
		
		UserVO userVO = new UserVO();
		TewsServiceImpl tews = new TewsServiceImpl();
		
		userVO.setUserid("TEWStester1111");
		userVO.setFullname("FULLNAME");
		userVO.setFirstname("FIRSTNAME");
		userVO.setLastname("LASTNAME");
		
		logger.info("sample values are set from '/directcall'.");

		if (tews.tewsCreateUser(userVO) == false) {
			res = "sending with tews failed.";
		} else {
			res = "sending with tews success.";
		}
		
		logger.info(res);
		
		
		return res;
	}
	
	
}

