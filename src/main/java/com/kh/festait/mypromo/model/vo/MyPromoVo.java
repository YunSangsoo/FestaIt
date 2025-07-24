package com.kh.festait.mypromo.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// 내 홍보 게시글 정보를 담는 VO (Value Object)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class MyPromoVo {
    // PROM_ID (홍보 식별 번호)
    private int promoId;
    
    // APP_ID (행사 신청서 식별 번호)
    private int appId;

    // PROM_TITLE (홍보 제목)
    private String promoTitle;
    
    // PROM_DETAIL (홍보 내용)
    private String promoDetail;
    
    // CREATE_DATE (작성일)
    private Date createDate;
    
    // UPDATE_DATE (수정일)
    private Date updateDate;
    
    // 조회수
    private int views;

    // --- 조인한 정보 ---
    // 행사 신청자 USER_NO
    private int userNo;
    
    // 행사 신청자 닉네임
    private String promoWriter;
    
    // 행사 신청자 계정 상태 (USER.STATUS)
    private String promoStatus;

    // 포스터 이미지 경로 (IMAGE.CHANGE_NAME or ORIGIN_NAME)
    private String posterPath;

    // 행사 웹사이트 URL (EVENT_APPLICATION.WEBSITE)
    private String promotionPageUrl;

    // 행사 신청 상태 코드 (APP_STATUS.STAT_CODE 등)
    private String isPromoted;
}
