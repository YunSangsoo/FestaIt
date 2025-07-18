package com.kh.festait.event.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class EventVO {
	// 김현주 : 행사 정보 데이터

	 private int appId;
	    private int userNo;
	    private String eventCode;
	    private String statCode;
	    private String appTitle;
	    private String appDetail;
	    private String location;
	    private String website;
	    private Date startDate;
	    private Date endDate;
	    private String startTime;
	    private String endTime;
	    private Date createDate;
	    private Date submittedDate;
	    private Date approvedDate;
	    private String appFee;
	    private String appItem;
	    private String appHost;
	    private String appOrg;
	    private String appSponser;

	    // 담당자 정보
	    private String managerName;
	    private String email;
	    private String tel;
	    private String fax;

	    private String adminComment;
	}
