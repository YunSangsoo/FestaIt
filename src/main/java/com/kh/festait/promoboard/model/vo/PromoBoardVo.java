package com.kh.festait.promoboard.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder; // @Builder 추가 (이전 VO에 있었으므로 일관성 유지)
import lombok.Getter; // @Data 대신 Getter, Setter 명시 (이전 VO에 있었으므로 일관성 유지)
import lombok.NoArgsConstructor;
import lombok.Setter; // @Data 대신 Getter, Setter 명시
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder // @Builder 추가
public class PromoBoardVo {
    // 김현주 : 홍보 게시물 정보 데이터

    private int promoId; // 게시물 번호 (PROM_ID) - promoNo 대신 promoId로 변경하여 DB 컬럼명과 일관성 유지
    private int eventId; // 행사 번호 (EVENT_ID) - EVENT_PROMOTION 테이블에 존재, 필수 추가
    private String promoTitle; // 제목 (PROM_TITLE)
    private String promoDetail; // 내용 (PROM_DETAIL) - promoContent 대신 promoDetail로 변경하여 DB 컬럼명과 일관성 유지
    private String promoWriter; // 작성자 (USER 테이블의 NICKNAME, 조인 필요)
    private Date createDate; // 작성일 (CREATE_DATE) - promoDate 대신 createDate로 변경하여 DB 컬럼명과 일관성 유지
    private Date updateDate; // 수정일 (UPDATE_DATE) - EVENT_PROMOTION 테이블에 존재, 필수 추가
    private int views; // 조회수 (VIEWS) - promoViews 대신 views로 변경하여 DB 컬럼명과 일관성 유지

    // promoStatus는 EVENT_PROMOTION 테이블에 직접적인 컬럼이 없으므로 제거.
    // 필요 시 다른 테이블의 상태값을 조합하여 사용하거나, 테이블에 컬럼 추가 고려.

    // ⭐ 추가/수정: 아래 필드들은 매퍼와 JSP에 맞춰 변경되거나 추가되었습니다. ⭐
    // 이 필드들은 여러 테이블을 조인하여 가져와야 하는 파생된 정보입니다.
    private String posterPath; // 포스터 이미지 경로 (IMAGE.CHANGE_NAME 또는 IMAGE.ORIGIN_NAME, PROM_IMAGE 조인 필요)
    private String promotionPageUrl; // 포스터 클릭 시 이동할 URL (EVENT_APPLICATION.WEBSITE, EVENT 조인 필요)
    private String isPromoted; // 포스터 클릭 기능 활성화 여부 ('Y' 또는 'N', EVENT_APPLICATION.STAT_CODE 기반, 조인 필요)
}
