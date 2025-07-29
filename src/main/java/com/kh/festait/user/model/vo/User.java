package com.kh.festait.user.model.vo;


import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@Data
@ToString
public class User {
		
	private int userNo;    //회원번호
	
	private String userId; //회원 아이디
	
	private int compId; //?
	
	private String nickname; //닏네임 
	
	private String userPwd; //비밀번호
	
	private String userName; //회원이름
	
	private String email; //이메일
	
	private String phone; //휴대전화번호
	
	private String userBrth; //회원생년월일
	
	private String address1; //기본주소
	
	private String address2; //상세주소
	
	private String addr; //전체주소
	
	private String enrollDate; //가입일자
	
    private String modifyDate; //회원수정일자
    
    private String status; //회원상태
    
    private String userType; //회원타입(개인/사업자)
    
    private String profileImg; //프로필사진
    
    private String profileName; //프로필파일 이름 
    
    private String profileSize; //프로필파일 사이즈
    
    private String profileImpType; //프로필파일 타입
    
    private String role; //권한
    
    private String bsGrgiNum; //사업자번호 이거는 새로 만들기
}
