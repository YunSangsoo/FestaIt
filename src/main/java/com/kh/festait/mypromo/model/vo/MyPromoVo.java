package com.kh.festait.mypromo.model.vo;

import java.util.Date; // java.util.Date 사용

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
    // PROM_ID
    private int promoId;
    // EVENT_ID
    private int eventId;

    // PROM_TITLE
    private String promoTitle;
    // PROM_DETAIL
    private String promoDetail;
    // CREATE_DATE
    private Date createDate;
    // UPDATE_DATE
    private Date updateDate;
    // VIEWS
    private int views;

    // --- 조인을 통해 가져오는 파생 정보 (다른 테이블과 연관) ---
    // 현재 DB 스키마에서 EVENT_PROMOTION -> EVENT -> EVENT_APPLICATION -> USER 조인 경로를 통해 가져오기
    
    // 행사 신청자 USER_NO
    private int userNo;
    // 행사 신청자 닉네임
    private String promoWriter;
    // 행사 신청자 계정 상태
    private String promoStatus;

    // 포스터 이미지 경로
    private String posterPath;
    // 행사 웹사이트 URL
    private String promotionPageUrl;
    // 행사 신청 상태 코드
    private String isPromoted;
    // 행사 신청 ID
    private int appId;
}
