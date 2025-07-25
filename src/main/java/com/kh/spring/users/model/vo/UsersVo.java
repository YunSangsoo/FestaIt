package com.kh.spring.users.model.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor 
@Data
public class UsersVo {	
	private int userNo; // USER_NO
	private int compId; // COMP_ID
	private String userId; // USER_ID
	private String userName; // USER_NAME
	private String userPwd; // USER_PWD
	private String email; // EMAIL
	private String nickname; // NICKNAME
	private String birth; // BIRTH
	private String addr; // ADDR
	private String phone; // PHONE
	private String gender; // GENDER
	private Date enrollDate; // ENROLL_DATE
	private Date updateDate; // UPDATE_DATE
	private String status; // STATUS
	private Date lastLoginAt; // LAST_LOGIN_AT
    
    // 이 필드는 AUTHORITIES 테이블에서 조회하여 채워질 것입니다.
    private List<String> authorities; // UsersVo는 UserDetails를 구현하지 않지만, 종합적인 데이터를 위해 포함
}