package com.kh.festait.promoadmin.model.vo;

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
public class PromoAdminVo {
    // EVENT_PROMOTION 테이블
    private int promoId;             // PROM_ID (홍보 식별 번호)
    private int appId;               // APP_ID (행사 신청서 식별 번호)
    private String promoTitle;       // PROM_TITLE (홍보 제목)
    private String promoDetail;      // PROM_DETAIL (홍보 내용)
    private Date createDate;         // CREATE_DATE (홍보 작성일)
    private Date updateDate;         // UPDATE_DATE (홍보 수정일)
    private int views;               // VIEWS (조회수)

    // USERS 테이블 (작성자 정보)
    private String promoWriter;      // NICKNAME (작성자 닉네임)
    private int writerUserNo;        // 작성자의 USER_NO (사용자 번호)
    private String userStatus;       // USERS 테이블의 STATUS

    // IMAGE 테이블 (포스터 이미지 정보)
    private long imgNo;              // IMG_NO (IMAGE 기본키)
    private String posterPath;       // CHANGE_NAME (파일명)
    private String originalFilename; // ORIGIN_NAME (원본 파일명)

    // EVENT_APPLICATION 테이블 (연결된 행사 신청서 정보)
    private String promotionPageUrl; // WEBSITE (행사 사이트 URL)
    private String isPromoted;       // STAT_CODE (신청서 상태 코드, 홍보 상태)
    private Date startDate;          // START_DATE (행사 시작일)
    private Date endDate;            // END_DATE (행사 종료일)
    private String appTitle;         // APP_NAME (행사 신청명)
}