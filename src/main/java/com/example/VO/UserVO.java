package com.example.VO;

import java.io.Serializable;

import lombok.Data;

@Data
//@ToString(includeFieldNames=true)
//@Alias("testUserTmpVo")
//@AllArgsConstructor
public class UserVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8792048720897222565L;
	
	private String userid;
	private String firstname;
	private String lastname;
	private String fullname;
	
}
