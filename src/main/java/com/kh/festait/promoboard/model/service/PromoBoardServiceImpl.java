package com.kh.festait.promoboard.model.service;

import java.util.List;
import java.util.Map;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.common.template.Pagination;
import com.kh.festait.promoboard.model.dao.PromoBoardDao;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // 트랜잭션 처리를 위해 임포트

// 홍보 게시글 서비스 구현체
@Service("promoService") // Spring Bean으로 등록 (빈 이름: promoService)
public class PromoBoardServiceImpl implements PromoBoardService {

    @Autowired // PromoBoardDao 의존성 자동 주입
    private PromoBoardDao promoDAO;

    // 한 페이지에 보여줄 게시글 수
    private static final int BOARD_LIMIT = 12;
    // 한 번에 보여줄 페이지 번호 개수
    private static final int PAGE_LIMIT = 10;

    @Override
    public PageInfo getPromoPageInfo(int currentPage) {
        // 전체 프로모 게시글 수 조회.
        int listCount = promoDAO.selectPromoCount();
        // 페이지 정보 계산 및 반환.
        return Pagination.getPageInfo(listCount, currentPage, PAGE_LIMIT, BOARD_LIMIT);
    }

    @Override
    public List<PromoBoardVo> getPromoList(PageInfo pi, Map<String, Object> paramMap) {
        // Mapper에서 PageInfo 객체의 OFFSET/LIMIT에 접근할 수 있도록 Map에 추가.
        paramMap.put("pi", pi);
        // 프로모 게시글 목록 조회 및 반환.
        return promoDAO.selectPromoList(paramMap);
    }

    @Override
    public PageInfo getSearchPromoPageInfo(int currentPage, Map<String, Object> searchParam) {
        // 검색된 프로모 게시글 수 조회.
        int listCount = promoDAO.selectSearchPromoCount(searchParam);
        // 검색된 페이지 정보 계산 및 반환.
        return Pagination.getPageInfo(listCount, currentPage, PAGE_LIMIT, BOARD_LIMIT);
    }

    @Override
    public List<PromoBoardVo> searchPromo(Map<String, Object> searchParam, PageInfo pi) {
        // Mapper에서 PageInfo 객체의 OFFSET/LIMIT에 접근할 수 있도록 Map에 추가.
        searchParam.put("pi", pi);
        // 검색된 프로모 게시글 목록 조회 및 반환.
        return promoDAO.selectSearchPromo(searchParam);
    }

    @Override
    @Transactional // 조회수 증가와 상세 조회는 하나의 트랜잭션으로 묶음.
    public PromoBoardVo selectPromotionDetail(int promoId) {
        // 1. 조회수 증가.
        int result = promoDAO.increasePromoViews(promoId);

        PromoBoardVo promo = null;
        if (result > 0) { // 조회수 증가 성공 시에만 상세 조회 진행.
            // 2. 상세 정보 조회.
            promo = promoDAO.selectPromoDetail(promoId);
        }
        return promo; // 상세 정보 반환.
    }

    @Override
    public int increasePromoViews(int promoId) {
        // 조회수 증가 (selectPromotionDetail 내에서 처리됨).
        return promoDAO.increasePromoViews(promoId);
    }

    @Override
    @Transactional // 게시글 등록은 트랜잭션으로 처리 (파일 업로드 등 추가될 경우를 대비)
    public int insertPromo(PromoBoardVo promo) {
        // DAO를 통해 게시글 등록.
        // ⭐ 이 부분에서 예외가 발생하는지 로그를 통해 확인해야 합니다. ⭐
        return promoDAO.insertPromo(promo);
    }

    @Override
    @Transactional // 게시글 수정은 트랜잭션으로 처리
    public int updatePromo(PromoBoardVo promo) {
        // DAO를 통해 게시글 수정.
        return promoDAO.updatePromo(promo);
    }

    @Override
    @Transactional // 게시글 삭제는 트랜잭션으로 처리
    public int deletePromo(Map<String, Object> params) {
        // DAO를 통해 게시글 삭제.
        return promoDAO.deletePromo(params);
    }
}
