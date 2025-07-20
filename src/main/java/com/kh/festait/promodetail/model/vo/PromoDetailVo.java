package com.kh.festait.promodetail.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder; // @Builder 추가 (일관성 유지)
import lombok.Getter; // @Data 대신 Getter, Setter 명시 (일관성 유지)
import lombok.NoArgsConstructor;
import lombok.Setter; // @Data 대신 Getter, Setter 명시
import lombok.ToString; // @Data 대신 ToString 명시

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder // @Builder 추가
public class PromoDetailVo {
    // 홍보 게시글 고유 번호
    private int promoId; // PROM_ID

    // 연관된 행사의 고유 번호 (EVENT_PROMOTION 테이블의 EVENT_ID)
    private int eventId; // EVENT_ID

    // 게시글 제목
    private String promoTitle; // PROM_TITLE

    // 게시글 상세 내용
    private String promoDetail; // PROM_DETAIL (이전 promoContent)

    // 게시글 작성자 닉네임 (USER 테이블의 NICKNAME, 조인 필요)
    private String promoWriter; // USER.NICKNAME

    // 게시글 작성일
    private Date createDate; // CREATE_DATE (이전 promoDate)

    // 게시글 수정일
    private Date updateDate; // UPDATE_DATE

    // 게시글 조회수
    private int views; // VIEWS (이전 promoViews)

    // promoStatus는 EVENT_PROMOTION 테이블에 직접적인 컬럼이 없으므로 제거.
    // 필요 시 다른 테이블의 상태값을 조합하여 사용하거나, 테이블에 컬럼 추가 고려.

    // ⭐ 파생된 정보: 매퍼에서 여러 테이블을 조인하여 가져와야 합니다. ⭐
    // 연관된 행사의 포스터 이미지 경로 (IMAGE.CHANGE_NAME 또는 IMAGE.ORIGIN_NAME, PROM_IMAGE 조인 필요)
    private String posterPath;

    // 연관된 행사의 상세 페이지 URL (EVENT_APPLICATION.WEBSITE, EVENT 조인 필요)
    private String promotionPageUrl;

    // 포스터 클릭 기능 활성화 여부 ('Y' 또는 'N' - EVENT_APPLICATION.STAT_CODE가 'A'일 경우 'Y', 조인 필요)
    private String isPromoted;
}
