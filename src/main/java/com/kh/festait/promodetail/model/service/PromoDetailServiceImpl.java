package com.kh.festait.promodetail.model.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // 트랜잭션 처리를 위해 추가

import com.kh.festait.promodetail.model.dao.PromoDetailDao;
import com.kh.festait.promodetail.model.vo.PromoDetailVo;

import lombok.RequiredArgsConstructor;

@Service("promoDetailService") // 스프링 빈 이름 지정
@RequiredArgsConstructor // final 필드 (PromoDetailDAO)를 위한 생성자 자동 주입
public class PromoDetailServiceImpl implements PromoDetailService {

    private final PromoDetailDao promoDetailDAO; // DAO 계층 의존성 주입

    @Override
    @Transactional // 조회수 증가와 상세 조회를 하나의 트랜잭션으로 묶어 데이터 일관성 보장
    public PromoDetailVo selectPromoDetail(int promoNo) {
        // 1. 해당 게시글의 조회수 증가
        int result = promoDetailDAO.increasePromoView(promoNo);

        PromoDetailVo promo = null;
        if (result > 0) { // 조회수 증가 성공 시에만 게시글 상세 정보 조회
            // 2. 게시글 상세 정보 조회
            promo = promoDetailDAO.selectPromoDetail(promoNo);
        }
        return promo;
    }
}