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
    // EVENT_PROMOTION 테이블의 실제 컬럼에 매핑되는 필드
    private int promoId;      // PROM_ID (이전 promoNo)
    private int eventId;      // EVENT_ID (EVENT 테이블의 외래키)

    private String promoTitle; // PROM_TITLE
    private String promoDetail; // PROM_DETAIL (이전 promoContent)
    private Date createDate;   // CREATE_DATE
    private Date updateDate;   // UPDATE_DATE
    private int views;        // VIEWS (이전 promoViews)

    // ⭐ 중요: 아래 필드들은 EVENT_PROMOTION 테이블에 직접 존재하지 않습니다. ⭐
    // 이 필드들은 다른 테이블과의 조인을 통해 가져와야 하는 파생된 정보입니다.
    // 현재 DB 스키마에서 EVENT_PROMOTION -> EVENT -> EVENT_APPLICATION -> USER 조인 경로를 통해 가져옵니다.
    // 따라서 이 userNo와 promoStatus는 '행사 신청자'의 정보이며, '홍보글 작성자'나 '홍보글 자체의 상태'가 아님을 유의해야 합니다.
    // DB 컬럼 추가는 하지 않는다는 사용자님의 지시에 따라 이 방식으로 유지됩니다.
    private int userNo;              // USER.USER_NO (행사 신청자의 USER_NO)
    private String promoWriter;      // USER.NICKNAME (행사 신청자의 닉네임)
    private String promoStatus;      // USER.STATUS (행사 신청자의 계정 상태)

    private String posterPath;       // IMAGE.CHANGE_NAME 또는 IMAGE.ORIGIN_NAME (PROM_IMAGE, IMAGE 테이블 조인 필요)
    private String promotionPageUrl; // EVENT_APPLICATION.WEBSITE (EVENT, EVENT_APPLICATION 테이블 조인 필요)
    private String isPromoted;       // EVENT_APPLICATION.STAT_CODE (EVENT, EVENT_APPLICATION, APP_STATUS 테이블 조인 필요)
    private int appId;               // EVENT_APPLICATION.APP_ID (EVENT, EVENT_APPLICATION 테이블 조인 필요)

}
