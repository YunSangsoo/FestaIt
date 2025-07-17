package com.kh.festait.promotion.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@NoArgsConstructor
@AllArgsConstructor
public class PromotionVO {
	// 김현주 : 홍보 게시물 정보 데이터
	
    private int promoNo;
    private String promoTitle;
    private String promoContent;
    private String promoWriter;
    private Date promoDate;
    private int promoViews;
    private String promoPosterPath;
    private String promoStatus;
}
