package com.kh.festait.user.model.vo;


import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@Data
@ToString
public class MyPageBookmark {
	
	private int userNo; 
	
	private String appId;
	
	private String createDate;
	
}
