package com.kh.festait.mypromo.model.vo;

import java.util.Date; // java.sql.Date 대신 java.util.Date를 사용 (일관성 유지 및 유연성)

// Lombok 어노테이션 추가 (pom.xml에 Lombok 의존성 필요)
import lombok.AllArgsConstructor;
import lombok.Builder; // @Builder 추가 (이전 VO들과 일관성 유지)
import lombok.Getter; // @Data 대신 Getter, Setter 명시 (이전 VO들과 일관성 유지)
import lombok.NoArgsConstructor;
import lombok.Setter; // @Data 대신 Getter, Setter 명시
import lombok.ToString; // @Data 대신 ToString 명시

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder // @Builder 추가
public class MyPromoVo {
    private int promoId; // PROM_ID (이전 promoNo)
    private int userNo; // USER_NO (작성자 회원 번호) - EVENT_PROMOTION 테이블에 추가 권장

    private String promoTitle; // PROM_TITLE
    private String promoDetail; // PROM_DETAIL (이전 promoContent)
    private Date createDate; // CREATE_DATE
    private Date updateDate; // UPDATE_DATE
    private int views; // VIEWS (이전 promoViews)

    // highlight (HIGHLIGHT) - DB 테이블에 없으므로 제거
    // promoStatus (STATUS) - DB 테이블에 없으므로 제거

    // ⭐ 파생된 정보: 매퍼에서 여러 테이블을 조인하여 가져와야 합니다. ⭐
    private String promoWriter; // NICKNAME (사용자 닉네임, USER 테이블 조인)
    private String posterPath; // IMAGE.CHANGE_NAME 또는 IMAGE.ORIGIN_NAME (PROM_IMAGE 조인 필요)
    private String promotionPageUrl; // EVENT_APPLICATION.WEBSITE (EVENT 조인 필요)
    private String isPromoted; // EVENT_APPLICATION.STAT_CODE (프로모션 여부 상태 코드, 조인 필요)

    private int eventId; // EVENT_ID (연관된 이벤트 ID, EVENT_PROMOTION 테이블에 존재)
    private int appId; // APP_ID (연관된 행사 신청 ID, EVENT_PROMOTION -> EVENT -> EVENT_APPLICATION 조인 필요)
}
