package com.kh.festait.login.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Member {
	
	private int userNo;    //회원번호
	
	private String userId; //회원 아이디
	
	private String compId;
	
	private String nickName; 
	
	private String userPwd;
	
	private String userName;
	
	private String email;
	
	private String phone;
	
	private String userBrth;
	
	private String address1;
	
	private String address2;
	
	private String addr;
	
	private Date enrollDate;
	
    private Date modifyDate;
    
    private String profileImg;
    
    private String status;
}
