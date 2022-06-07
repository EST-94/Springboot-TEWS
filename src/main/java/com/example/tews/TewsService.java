package com.example.tews;

import org.springframework.stereotype.Component;
import com.example.VO.UserVO;

@Component
public interface TewsService {
	
	public boolean tewsCreateUser(UserVO userVO) throws Exception;
	
	public boolean tewsModifyUser(UserVO userVO) throws Exception;
	
	public boolean tewsDeleteUser(UserVO userVO) throws Exception;
	
}
