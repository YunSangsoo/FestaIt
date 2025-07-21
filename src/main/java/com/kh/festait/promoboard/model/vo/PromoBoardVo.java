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

    // promoStatus는 EVENT_PROMOTION 테이블에 직접 컬럼이 없으므로 제거.
    // 필요 시 다른 테이블의 상태값을 조합하여 사용하거나, 테이블에 컬럼 추가 고려.

    // --- 조인을 통해 가져오는 파생 정보 ---
    // 작성자 (USER 테이블 NICKNAME)
    private String promoWriter;

    // 포스터 이미지 경로 (IMAGE.CHANGE_NAME)
    private String posterPath;
    // 포스터 클릭 시 이동할 URL (EVENT_APPLICATION.WEBSITE)
    private String promotionPageUrl;
    // 포스터 클릭 기능 활성화 여부 ('Y' 또는 'N')
    private String isPromoted;

    // APP_ID (연관된 행사 신청 ID)
    private int appId;

    // ⭐ 추가: 이벤트 시작일 (EVENT 테이블에서 가져옴)
    private Date startDate;
    // ⭐ 추가: 이벤트 종료일 (EVENT 테이블에서 가져옴)
    private Date endDate;
}
