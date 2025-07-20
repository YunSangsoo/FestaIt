package com.kh.festait.promodetail.model.service;

import com.kh.festait.promodetail.model.vo.PromoDetailVo;

public interface PromoDetailService {

    /**
     * 홍보 게시글 상세 정보를 조회하고, 조회수를 1 증가시키는 비즈니스 로직을 수행합니다.
     * @param promoNo 조회할 홍보 게시글 번호
     * @return 조회된 PromoDetailVO 객체 (게시글이 없거나 조회수 증가 실패 시 null)
     */
    PromoDetailVo selectPromoDetail(int promoNo);
}