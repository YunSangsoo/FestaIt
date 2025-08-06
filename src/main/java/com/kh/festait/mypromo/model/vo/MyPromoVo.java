package com.kh.festait.mypromo.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter; // @Setter 임포트
import lombok.ToString;

@Getter
@Setter 
@NoArgsConstructor 
@AllArgsConstructor 
@ToString 
@Builder 
public class MyPromoVo {

    // 홍보 게시글 식별 번호
    private int promoId;

    // 행사 카테고리 코드 (이벤트 코드)
    private String eventId;

    // 행사 신청서 식별 번호 (APP_ID)
    private int appId;

    // 홍보 게시글 제목
    private String promoTitle;

    // 홍보 게시글 내용
    private String promoDetail;

    // 홍보 게시글 작성일
    private Date createDate;

    // 홍보 게시글 수정일
    private Date updateDate;

    // 홍보 게시글 조회수
    private int views;

    // --- 조인한 정보 ---

    // 행사 신청자의 사용자 번호
    private int userNo;

    // 행사 신청자의 닉네임
    private String promoWriter;

    // 행사 신청자의 계정 상태
    private String promoStatus;

    // 홍보 게시글에 첨부된 포스터 경로
    private String posterPath;

    // 행사 웹사이트 URL
    private String promotionPageUrl;

    // 행사 신청 상태 코드
    private String isPromoted;

    // 행사 제목
    private String eventAppName; 
}
