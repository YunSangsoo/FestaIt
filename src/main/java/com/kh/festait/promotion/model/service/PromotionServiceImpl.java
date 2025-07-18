package com.kh.festait.promotion.model.service;

import java.util.List;
import java.util.Map;

import com.kh.festait.promotion.model.dao.PromotionDAO;
import com.kh.festait.promotion.model.vo.PromotionVO;
import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.common.template.Pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("promotionService")
public class PromotionServiceImpl implements PromotionService {

    @Autowired
    private PromotionDAO promotionDAO;

    private static final int BOARD_LIMIT = 12;
    private static final int PAGE_LIMIT = 10;

    @Override
    public PageInfo getPromotionPageInfo(int currentPage) {
        // 전체 게시글 수 조회용
        int listCount = promotionDAO.selectPromotionCount(); 
        // 페이지 정보 계산용
        return Pagination.getPageInfo(listCount, currentPage, PAGE_LIMIT, BOARD_LIMIT);
    }

    @Override
    public List<PromotionVO> getPromotionList(PageInfo pi, Map<String, Object> paramMap) {
        // 게시글 목록 조회용
        return promotionDAO.selectPromotionList(pi, paramMap); 
    }

    @Override
    public PageInfo getSearchedPromotionPageInfo(int currentPage, Map<String, Object> searchParams) {
        // 검색 결과 수 조회용
        int listCount = promotionDAO.selectSearchedPromotionCount(searchParams);
        // 검색 결과 페이지 정보 계산용
        return Pagination.getPageInfo(listCount, currentPage, PAGE_LIMIT, BOARD_LIMIT);
    }

    @Override
    public List<PromotionVO> searchPromotions(Map<String, Object> searchParams, PageInfo pi) {
        // 검색된 게시글 목록 조회용
        return promotionDAO.selectSearchedPromotions(searchParams, pi);
    }
}
