package com.example.VO;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
//@ToString(includeFieldNames=true)
//@Alias("testUserTmpVo")
//@AllArgsConstructor
public class TestVOforCreate implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8792048720897222565L;
	
//	private String org;
	private String userid;
	private String firstname;
	private String lastname;
	private String fullname;
	
//	public void setOrg(String string) {
//		this.org = string;
//	}
	
//	public void setUserid(String string) {
//		this.userid = string;
//	}
//
//	public void setFullname(String string) {
//		this.fullname = string;
//	}
//
//	public void setFirstname(String string) {
//		this.firstname = string;
//	}
//
//	public void setLastname(String string) {
//		this.lastname = string;
//	}
//	
//	
////	public String getOrg() {
////		
////		return this.org;
////	}
//	public String getUserid() {
//		
//		return this.userid;
//	}
//	public String getFullname() {
//		
//		return this.fullname;
//	}
//	public String getFirstName() {
//		
//		return this.firstname;
//	}
//	public String getLastname() {
//		
//		return this.lastname;
//	}
}
