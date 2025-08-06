package com.kh.festait.eventdetail.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import com.kh.festait.common.model.vo.Image; 

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class EventDetailVo {
    
    private int appId;             // 행사 번호
    private int userNo;            // 사용자 번호
    private String eventCode;      // 행사 코드
    private String appTitle;       // 행사 제목
    private String appSubTitle;    // 행사 소제목
    private String appDetail;      // 행사 내용
    private String location;       // 행사 장소
    private String locationDetail; // 행사 상세 장소
    private String postCode;       // 행사 장소 우편번호
    private String website;        // 행사 사이트 URL
    private Date startDate;        // 행사 시작일
    private Date endDate;          // 행사 종료일
    private String startTime;      // 관람 시작 시간
    private String endTime;        // 관람 종료 시간
    private String appFee;         // 입장료
    private String appItem;        // 품목명
    private String appHost;        // 주최명
    private String appOrg;         // 주관처명
    private String appSponsor;     // 후원사명

    private String managerName;    // 담당자명
    private String email;          // 이메일
    private String tel;            // 전화번호
    private String fax;            // 팩스번호

    private String eventCategoryName; // 행사 카테고리명

    private boolean bookmarked;    // 북마크 여부

    private String eventAppName;   // 행사 신청명
    
    private Image posterImage;	// 이미지
}