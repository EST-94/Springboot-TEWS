package com.example.tews;

import org.springframework.stereotype.Component;
import com.example.VO.TestVOforCreate;

@Component
public interface TewsService {
	
	public boolean tewsCreateUser(TestVOforCreate userVO) throws Exception;
	
	public boolean tewsModifyUser(TestVOforCreate userVO) throws Exception;
	
	public boolean tewsDeleteUser(TestVOforCreate userVO) throws Exception;
	
}
