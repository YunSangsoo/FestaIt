package com.kh.festait.promotion.model.dao;

import com.kh.festait.promotion.model.vo.PromotionVO;
import com.kh.festait.common.model.vo.PageInfo;
import java.util.List;
import java.util.Map;

/*
 * PromotionDAO 인터페이스
 * 
 * 프로모션 게시글 관련 DB 작업 정의
 */
public interface PromotionDAO {

    /*
     * 전체 프로모션 게시글 수 가져오기
     * @return 게시글 수
     */
    int selectPromotionCount();

    /*
     * 페이징 정보와 조건에 따라 게시글 목록 조회
     * @param pi       페이징 정보
     * @param paramMap 검색 조건
     * @return 게시글 목록
     */
    List<PromotionVO> selectPromotionList(PageInfo pi, Map<String, Object> paramMap);

    /*
     * 검색 조건에 맞는 게시글 수 조회
     * @param searchParams 검색 조건
     * @return 게시글 수
     */
    int selectSearchedPromotionCount(Map<String, Object> searchParams);

    /*
     * 검색 조건과 페이징 정보에 따라 게시글 목록 조회
     * @param searchParams 검색 조건
     * @param pi           페이징 정보
     * @return 게시글 목록
     */
    List<PromotionVO> selectSearchedPromotions(Map<String, Object> searchParams, PageInfo pi);
}
