package com.kh.festait.reviewboard.model.vo;

import java.util.Date;

import com.kh.festait.common.model.vo.Image;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class ReviewBoard {
	private int userNo;
	private int appId;
	private String comment;
	private int rating;
	private Date createDate;
	private Date updateDate;
	
	private String userId;
	private String userName;
	private String nickname;
	
	private String appTitle;
	

	private Image profileImage;
}
