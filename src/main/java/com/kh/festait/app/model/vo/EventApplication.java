package com.kh.festait.app.model.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class EventApplication {
	
	private int appId;
	private int userNo;
	private String eventCode;
	private String statCode;
	private String appTitle;
	private String appSubTitle;
	private String appDetail;
	private String location;
	private String locationDetail;
	private String postcode;
	private String website;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private String startTime;
	private String endTime;

	private Date createDate;
	private Date updateDate;
	private Date submittedDate;
	private Date approvedDate;
	private String appFee;
	private String appItem;
	private String appHost;
	private String appOrg;
	private String appSponser;
	private String adminComment;
	
	private AppManager appManager;
	
	private String imgsource;
	
}
