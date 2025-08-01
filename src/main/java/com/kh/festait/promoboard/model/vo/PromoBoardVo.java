package com.kh.festait.promoboard.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import com.kh.festait.common.model.vo.Image; // Image VO import 추가

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class PromoBoardVo {
    // EVENT_PROMOTION 테이블
    private int promoId;
    private Integer appId;
    private String promoTitle;
    private String promoDetail;
    private Date createDate;
    private Date updateDate;
    private int views;

    // USER 테이블 (작성자 정보)
    private String promoWriter;
    private int writerUserNo;

    // IMAGE 테이블 (이미지 정보)
    private Image posterImage;

    // EVENT_APPLICATION 테이블 (행사 신청서 정보)
    private String promotionPageUrl;
    private String isPromoted;

    // EVENT_APPLICATION 테이블의 행사 기간
    private Date startDate;
    private Date endDate;

    // 행사 신청명 (홍보 게시글 작성 시 행사 선택)
    private String eventAppName;
}