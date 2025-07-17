package com.kh.festait.promotion.model.service; // 이 파일의 패키지가 정확한지 확인해 주세요.

import java.util.List;
import java.util.Map;

// PromotionDAO는 이 ServiceImpl에서 '사용'할 인터페이스입니다.
import com.kh.festait.promotion.model.dao.PromotionDAO; // PromotionDAO 인터페이스를 임포트합니다.
import com.kh.festait.promotion.model.vo.PromotionVO;
import com.kh.festait.common.model.vo.PageInfo; // PageInfo 임포트 경로 다시 확인!
import com.kh.festait.common.template.Pagination; // Pagination 클래스 임포트

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; // @Service 어노테이션 임포트

// 이 파일은 '클래스'여야 하며, 'PromotionService' 인터페이스를 '구현(implements)'합니다.
@Service("promotionService") // 이 클래스를 스프링 서비스 빈으로 등록합니다.
public class PromotionServiceImpl implements PromotionService { // 이 부분이 올바르게 수정되었습니다.

    // PromotionDAO 인터페이스를 주입받아 DAO 계층의 메서드를 호출합니다.
    @Autowired
    private PromotionDAO promotionDAO; 

    // 상수로 페이지 제한 및 게시글 제한을 정의합니다.
    private static final int BOARD_LIMIT = 12;
    private static final int PAGE_LIMIT = 10;

    @Override
    public PageInfo getPromotionPageInfo(int currentPage) {
        // DAO의 selectPromotionCount() 메서드를 호출하여 전체 게시글 수를 가져옵니다.
        int listCount = promotionDAO.selectPromotionCount(); 
        // Pagination 유틸리티를 사용하여 페이지 정보를 계산합니다.
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, PAGE_LIMIT, BOARD_LIMIT);
        return pi;
    }

    @Override
    // 서비스 인터페이스(PromotionService)의 메서드 시그니처와 일치해야 합니다.
    public List<PromotionVO> getPromotionList(PageInfo pi, Map<String, Object> paramMap) {
        // DAO의 selectPromotionList() 메서드를 호출하여 게시글 목록을 가져옵니다.
        // DAO에서 RowBounds 등을 사용하여 offset, limit을 처리할 수 있습니다.
        return promotionDAO.selectPromotionList(pi, paramMap); 
    }

    @Override
    public PageInfo getSearchedPromotionPageInfo(int currentPage, Map<String, Object> searchParams) {
        // DAO의 selectSearchedPromotionCount() 메서드를 호출하여 검색된 게시글 수를 가져옵니다.
        int listCount = promotionDAO.selectSearchedPromotionCount(searchParams);
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, PAGE_LIMIT, BOARD_LIMIT);
        return pi;
    }

    @Override
    // 서비스 인터페이스(PromotionService)의 메서드 시그니처와 일치해야 합니다.
    public List<PromotionVO> searchPromotions(Map<String, Object> searchParams, PageInfo pi) {
        // DAO의 selectSearchedPromotions() 메서드를 호출하여 검색된 게시글 목록을 가져옵니다.
        return promotionDAO.selectSearchedPromotions(searchParams, pi);
    }
}