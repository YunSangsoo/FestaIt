package com.kh.festait.memberboard.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class MemberBoardList {

	private int userNo;
    private String userId;
    private String userName;
    private String nickname;
    private Date enrollDate;
    private Date lastLoginAt;
    private String email;
    private String phone;
    private String addr;        
    private String userType;    // 권한 (AUTHORITIES 테이블 LEFT JOIN)

}