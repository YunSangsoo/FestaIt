package com.kh.festait.promoboard.model.vo;

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
public class PromoBoardVo {
    // 김현주 : 홍보 게시물 정보 데이터

    private int promoId;      // 게시물 번호 (PROM_ID)
    private int eventId;      // 행사 번호 (EVENT_ID) - EVENT_PROMOTION 테이블에 존재

    private String promoTitle; // 제목 (PROM_TITLE)
    private String promoDetail; // 내용 (PROM_DETAIL)
    private Date createDate;   // 작성일 (CREATE_DATE)
    private Date updateDate;   // 수정일 (UPDATE_DATE)
    private int views;        // 조회수 (VIEWS)

    // promoStatus는 EVENT_PROMOTION 테이블에 직접적인 컬럼이 없으므로 제거.
    // 필요 시 다른 테이블의 상태값을 조합하여 사용하거나, 테이블에 컬럼 추가 고려.

    // ⭐ 파생된 정보: 매퍼에서 여러 테이블을 조인하여 가져와야 합니다. ⭐
    // 이 필드들은 '행사 신청자'의 정보를 나타냅니다.
    private String promoWriter;      // 작성자 (USER 테이블의 NICKNAME, EVENT_PROMOTION -> EVENT -> EVENT_APPLICATION -> USER 조인)

    private String posterPath;       // 포스터 이미지 경로 (IMAGE.CHANGE_NAME, PROM_IMAGE, IMAGE 조인)
    private String promotionPageUrl; // 포스터 클릭 시 이동할 URL (EVENT_APPLICATION.WEBSITE, EVENT, EVENT_APPLICATION 조인)
    private String isPromoted;       // 포스터 클릭 기능 활성화 여부 ('Y' 또는 'N', EVENT_APPLICATION.STAT_CODE 기반, EVENT, EVENT_APPLICATION 조인)

    private int appId;               // ⭐️ 추가: APP_ID (연관된 행사 신청 ID, EVENT_PROMOTION -> EVENT -> EVENT_APPLICATION 조인)
}
