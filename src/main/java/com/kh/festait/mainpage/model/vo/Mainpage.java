package com.kh.festait.mainpage.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class Mainpage {
	// 행사
	
	// 리뷰
	
	// 공지
	private int noticeId;
	private String noticeTitle;
	private String noticeDetail;
	private Date createDate;
	private Date updateDate;
	private String highlight;	
}
