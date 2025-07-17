package com.kh.festait.promotion.model.dao; // 이 파일의 실제 패키지 경로를 확인하여 수정해주세요.

import com.kh.festait.promotion.model.vo.PromotionVO; // PromotionVO 클래스 임포트
import com.kh.festait.common.model.vo.PageInfo; // PageInfo 클래스 임포트
import java.util.List;
import java.util.Map;

// 이 인터페이스는 'PromotionDAO'입니다.
// 데이터베이스 접근과 관련된 메서드들을 정의합니다.
public interface PromotionDAO { 

    /**
     * 전체 프로모션 게시글의 총 개수를 조회합니다.
     * ServiceImpl에서 promotionDAO.selectPromotionCount()로 호출될 메서드입니다.
     * @return 전체 게시글 수
     */
    int selectPromotionCount();

    /**
     * 페이징 정보에 따라 프로모션 게시글 목록을 조회합니다.
     * ServiceImpl에서 promotionDAO.selectPromotionList(pi, paramMap)으로 호출될 메서드입니다.
     * @param pi 페이징 정보 (offset, limit 계산에 사용)
     * @param paramMap 추가적인 검색 조건이나 쿼리 파라미터 (필요시)
     * @return 프로모션 게시글 목록
     */
    List<PromotionVO> selectPromotionList(PageInfo pi, Map<String, Object> paramMap);

    /**
     * 검색 조건에 맞는 프로모션 게시글의 총 개수를 조회합니다.
     * ServiceImpl에서 promotionDAO.selectSearchedPromotionCount(searchParams)로 호출될 메서드입니다.
     * @param searchParams 검색 조건이 담긴 Map
     * @return 검색된 게시글 수
     */
    int selectSearchedPromotionCount(Map<String, Object> searchParams);

    /**
     * 검색 조건과 페이징 정보에 따라 프로모션 게시글 목록을 조회합니다.
     * ServiceImpl에서 promotionDAO.selectSearchedPromotions(searchParams, pi)로 호출될 메서드입니다.
     * @param searchParams 검색 조건이 담긴 Map
     * @param pi 페이징 정보
     * @return 검색된 프로모션 게시글 목록
     */
    List<PromotionVO> selectSearchedPromotions(Map<String, Object> searchParams, PageInfo pi);
}