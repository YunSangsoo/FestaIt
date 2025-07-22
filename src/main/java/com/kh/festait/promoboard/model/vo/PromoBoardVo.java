package com.kh.festait.promoboard.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// 홍보 게시물 정보 VO (Value Object)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class PromoBoardVo {
    // 게시물 번호 (PROM_ID)
    private int promoId;
    // 행사 번호 (EVENT_ID)
    private int eventId;

    // 제목 (PROM_TITLE)
    private String promoTitle;
    // 내용 (PROM_DETAIL)
    private String promoDetail;
    // 작성일 (CREATE_DATE)
    private Date createDate;
    // 수정일 (UPDATE_DATE)
    private Date updateDate;
    // 조회수 (VIEWS)
    private int views;

    // --- 조인을 통해 가져오는 파생 정보 ---
    // 작성자 (USER 테이블 NICKNAME)
    private String promoWriter;

    // 포스터 이미지 경로 (IMAGE.CHANGE_NAME) - 실제 파일명 (웹 경로 포함)
    private String posterPath;
    // ⭐ 추가: 이미지 원본 파일명 (IMAGE.ORIGIN_NAME) ⭐
    private String originalFilename;
    // ⭐ 추가: 이미지 번호 (IMAGE.IMG_NO) ⭐
    private int imgNo;
    // ⭐⭐ 새로 추가: PROM_IMAGE 테이블의 기본 키 (PROM_IMG_NO) ⭐⭐
    private int promImgNo;

    // 포스터 클릭 시 이동할 URL (EVENT_APPLICATION.WEBSITE)
    private String promotionPageUrl;
    // 포스터 클릭 기능 활성화 여부 ('Y' 또는 'N')
    private String isPromoted;

    // APP_ID (연관된 행사 신청 ID) - EVENT_APPLICATION 테이블과 연동 시 필요
    private int appId;

    // ⭐ 추가: 이벤트 시작일 (EVENT 테이블에서 가져옴)
    private Date startDate;
    // ⭐ 추가: 이벤트 종료일 (EVENT 테이블에서 가져옴)
    private Date endDate;
    
    // userNo는 현재 Controller/Service에서 사용되지 않지만, 필요시 추가 가능
    // private int userNo; 
}
