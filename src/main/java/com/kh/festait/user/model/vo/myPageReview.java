package com.kh.festait.user.model.vo;


import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@Data
@ToString
public class myPageReview {

	private int userNo; 
	
	private String appId;
	
	private String comment;
	
	private String rating;
	
	private String createDate;
	
	private String updateDate;
	
}
