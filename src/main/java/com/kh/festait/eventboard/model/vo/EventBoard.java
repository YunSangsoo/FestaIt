package com.kh.festait.eventboard.model.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.kh.festait.common.model.vo.Image;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class EventBoard {
	private int appId;
	private int userNo;
	private String eventCode;
	private String eventName;
	private String statCode;
	private String appTitle;
	private String appSubTitle;
	private String region;
	private String location;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private String startTime;
	private String endTime;

	private String appOrg;
	
	private Image posterImage;
	
	private String bookmarkCheck; // on, off로 내가 북마크한 게시글인지 확인
	


	
}
