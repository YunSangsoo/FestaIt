package com.kh.festait.promotion.model.dao; // 실제 패키지 경로에 따라 수정하세요

import com.kh.festait.promotion.model.vo.PromotionVO;
import com.kh.festait.common.model.vo.PageInfo;
import java.util.List;
import java.util.Map;

/**
 * PromotionDAO 인터페이스
 * <p>
 * 프로모션 게시글과 관련된 데이터베이스 접근 메서드를 정의합니다.
 */
public interface PromotionDAO {

    /**
     * 전체 프로모션 게시글의 총 개수를 조회합니다.
     * 
     * @return 전체 게시글 수
     */
    int selectPromotionCount();

    /**
     * 페이징 정보와 조건에 따라 프로모션 게시글 목록을 조회합니다.
     *
     * @param pi       페이징 정보 (PageInfo 객체)
     * @param paramMap 검색 조건 또는 기타 쿼리 파라미터가 담긴 Map
     * @return 프로모션 게시글 목록
     */
    List<PromotionVO> selectPromotionList(PageInfo pi, Map<String, Object> paramMap);

    /**
     * 검색 조건에 맞는 프로모션 게시글의 총 개수를 조회합니다.
     *
     * @param searchParams 검색 조건이 담긴 Map
     * @return 조건에 맞는 게시글 수
     */
    int selectSearchedPromotionCount(Map<String, Object> searchParams);

    /**
     * 검색 조건과 페이징 정보에 따라 프로모션 게시글 목록을 조회합니다.
     *
     * @param searchParams 검색 조건이 담긴 Map
     * @param pi           페이징 정보 (PageInfo 객체)
     * @return 검색 조건에 해당하는 프로모션 게시글 목록
     */
    List<PromotionVO> selectSearchedPromotions(Map<String, Object> searchParams, PageInfo pi);
}
