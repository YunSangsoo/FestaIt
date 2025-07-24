package com.kh.festait.eventdetail.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.Data; 

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class EventDetailVo {
    // 김현주 : 행사 정보 데이터 (EVENT_APPLICATION 테이블 기반)
    private int appId; // APP_ID (행사 번호 - 상세 조회 시 식별자로 사용)
    private int userNo; // USER_NO (사용자 번호)
    private String eventCode; // EVENT_CODE (행사 코드)
    private String appTitle; // APP_TITLE (행사 제목)
    private String appSubTitle; // APP_SUB_TITLE (행사 소제목) 
    private String appDetail; // APP_DETAIL (행사 내용)
    private String location; // LOCATION (행사 장소)
    private String locationDetail; // LOCATION_DETAIL (행사 상세 장소) 
    private String postCode; // POST_CODE (행사 장소 우편번호) 
    private String website; // WEBSITE (행사 사이트 URL)
    private Date startDate; // START_DATE (행사 시작일)
    private Date endDate; // END_DATE (행사 종료일)
    private String startTime; // START_TIME (관람 시작 시간)
    private String endTime; // END_TIME (관람 종료 시간)
    private String appFee; // APP_FEE (입장료)
    private String appItem; // APP_ITEM (품목명)
    private String appHost; // APP_HOST (주최명)
    private String appOrg; // APP_ORG (주관처명)
    private String appSponser; // APP_SPONSER (후원사명) --- 일단 Sponser로 진행(추후 Sponsor)

    // ⭐⭐ APP_MANAGER 테이블에서 조인하여 가져올 필드 ⭐⭐
    private String managerName; // MANAGER_NAME (행사 담당자)
    private String email; // EMAIL (담당자 이메일)
    private String tel; // TEL (담당자 전화번호)
    private String fax; // fax (담당자 FAX)

    // ⭐⭐ EVENT_CATEGORY 테이블에서 조인하여 가져올 필드 ⭐⭐
    private String eventCategoryName; // EVENT_CATEGORY_NAME (EVENT_CATEGORY.EVENT_NAME에 해당)

    // ⭐⭐ BOOKMARK 테이블에서 북마크 여부를 판단할 필드 ⭐⭐
    private boolean bookmarked;
}
