package com.kh.festait.promodetail.model.dao;

import com.kh.festait.promodetail.model.vo.PromoDetailVo;

public interface PromoDetailDao {

    /**
     * 특정 홍보 게시글의 상세 정보를 DB에서 조회합니다.
     * @param promoNo 조회할 홍보 게시글 번호
     * @return 조회된 PromoDetailVO 객체
     */
    PromoDetailVo selectPromoDetail(int promoNo);

    /**
     * 특정 홍보 게시글의 조회수를 1 증가시킵니다.
     * @param promoNo 조회수를 증가시킬 게시글 번호
     * @return 업데이트된 행의 수 (보통 1)
     */
    int increasePromoView(int promoNo);
}