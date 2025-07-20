package com.kh.festait.promoboard.model.service;

import java.util.List;
import java.util.Map;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.common.template.Pagination;
import com.kh.festait.promoboard.model.dao.PromoBoardDao;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // ⭐ 트랜잭션 처리를 위해 추가

@Service("promoService")
public class PromoBoardServiceImpl implements PromoBoardService {

    @Autowired
    private PromoBoardDao promoDAO;

    private static final int BOARD_LIMIT = 12;
    private static final int PAGE_LIMIT = 10;

    @Override
    public PageInfo getPromoPageInfo(int currentPage) {
        // 전체 프로모 게시글 수 조회
        int listCount = promoDAO.selectPromoCount();
        // 페이지 정보 계산
        return Pagination.getPageInfo(listCount, currentPage, PAGE_LIMIT, BOARD_LIMIT);
    }

    @Override
    public List<PromoBoardVo> getPromoList(PageInfo pi, Map<String, Object> paramMap) {
        // 프로모 게시글 목록 조회
        // DAO 메소드 호출 시 pi를 paramMap에 추가하여 전달하도록 수정 필요 (DAO 또는 Mapper에서 offset/limit 사용)
        paramMap.put("pi", pi); // Mapper에서 #{pi.offset} 처럼 접근 가능하도록
        return promoDAO.selectPromoList(paramMap);
    }

    @Override
    public PageInfo getSearchPromoPageInfo(int currentPage, Map<String, Object> searchParam) {
        // 검색된 프로모 게시글 수 조회
        int listCount = promoDAO.selectSearchPromoCount(searchParam);
        // 검색된 페이지 정보 계산
        return Pagination.getPageInfo(listCount, currentPage, PAGE_LIMIT, BOARD_LIMIT);
    }

    @Override
    public List<PromoBoardVo> searchPromo(Map<String, Object> searchParam, PageInfo pi) {
        // 검색된 프로모 게시글 목록 조회
        // DAO 메소드 호출 시 pi를 searchParam에 추가하여 전달하도록 수정 필요
        searchParam.put("pi", pi); // Mapper에서 #{pi.offset} 처럼 접근 가능하도록
        return promoDAO.selectSearchPromo(searchParam);
    }

    // ⭐ 추가: 홍보 게시글 상세 조회
    @Override
    @Transactional // ⭐ 조회수 증가와 상세 조회는 하나의 트랜잭션으로 묶는 것이 일반적
    public PromoBoardVo selectPromotionDetail(int promoNo) {
        // 1. 조회수 증가
        int result = promoDAO.increasePromoViews(promoNo);

        // 2. 상세 정보 조회
        PromoBoardVo promo = null;
        if (result > 0) { // 조회수 증가 성공 시에만 상세 조회 진행
            promo = promoDAO.selectPromoDetail(promoNo);
        }
        return promo;
    }

    // ⭐ 추가: 조회수 증가 (selectPromotionDetail 내에서 처리되므로 여기서는 단순히 DAO 호출)
    // 이 메서드는 일반적으로 selectPromotionDetail 내에서 처리되기 때문에,
    // 외부에서 직접 호출할 필요가 없다면 private으로 두거나 제거할 수도 있습니다.
    // 여기서는 Service 인터페이스에 정의되어 있으므로 일단 구현합니다.
    @Override
    public int increasePromoViews(int promoNo) {
        return promoDAO.increasePromoViews(promoNo);
    }
}