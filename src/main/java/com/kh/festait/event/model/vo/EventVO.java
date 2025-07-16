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
@Builder // 빌더 패턴. 혹시 몰라서.
public class EventVO {
	// 김현주 : 행사 정보 데이터

	private int appId; // APP_ID (숫자)
    private int userNo; // USER_NO (숫자)
    private String eventCode; // EVENT_CODE (문자)
    private String statCode; // STAT_CODE (문자)
    private String appTitle; // APP_TITLE (문자)
    private String appSubTitle; // APP_SUB_TITLE (문자)
    private String appDetail; // APP_DETAIL (CLOB 타입은 Java에서 String으로 처리)
    private String location; // LOCATION (문자)
    private String locationDetail; // LOCATION_DETAIL (문자)
    private String postCode; // POST_CODE (문자)
    private String website; // WEBSITE (문자)
    private Date startDate; // START_DATE (날짜)
    private Date endDate; // END_DATE (날짜)
    private String startTime; // START_TIME (문자)
    private String endTime; // END_TIME (문자)
    private Date createDate; // CREATE_DATE (날짜)
    private Date updateDate; // UPDATE_DATE (날짜)
    private Date submittedDate; // SUBMITTED_DATE (날짜)
    private Date approvedDate; // APPROVED_DATE (날짜)
    private String appFee; // APP_FEE (문자)
    private String appItem; // APP_ITEM (문자)
    private String appHost; // APP_HOST (문자)
    private String appOrg; // APP_ORG (문자)
    private String appSponser; // APP_SPONSER (문자)
    private String adminComment; // ADMIN_COMMENT (CLOB 타입은 Java에서 String으로 처리)

	// getter & setter (자동 생성)
	
}

