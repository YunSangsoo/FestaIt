package com.kh.festait.eventdetail.model.vo;

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
public class EventDetailVo {
    // 김현주 : 행사 정보 데이터

    private int appId;
    private int userNo;
    private String eventCode;
    private String statCode;
    private String appTitle;
    private String appSubTitle; 
    private String appDetail;
    private String location;
    private String locationDetail; 
    private String postCode; 
    private String website;
    private Date startDate;
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

    // 담당자 정보 (현재는 VO에 포함, 필요 시 별도 VO로 분리 고려)
    private String managerName;
    private String email;
    private String tel;
    private String fax;
    private String adminComment;
}
