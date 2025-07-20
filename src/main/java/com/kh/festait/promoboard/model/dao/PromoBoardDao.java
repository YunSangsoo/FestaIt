package com.kh.festait.promoboard.model.dao;

import com.kh.festait.promoboard.model.vo.PromoBoardVo;

import java.util.List;
import java.util.Map;

/*
 * PromoBoardDAO 인터페이스
 *
 * 프로모 게시글 관련 DB 작업 정의
 */
public interface PromoBoardDao {

    /*
     * 전체 프로모 게시글 수 가져오기
     * @return 게시글 수
     */
    int selectPromoCount();

    /*
     * 페이징 정보와 조건에 따라 게시글 목록 조회
     * @param paramMap 검색 조건 (PageInfo 객체 포함)
     * @return 게시글 목록
     */
    List<PromoBoardVo> selectPromoList(Map<String, Object> paramMap); // ⭐ 파라미터 변경: PageInfo를 Map에 포함

    /*
     * 검색 조건에 맞는 게시글 수 조회
     * @param searchParam 검색 조건
     * @return 게시글 수
     */
    int selectSearchPromoCount(Map<String, Object> searchParam);

    /*
     * 검색 조건과 페이징 정보에 따라 게시글 목록 조회
     * @param searchParam 검색 조건 (PageInfo 객체 포함)
     * @return 게시글 목록
     */
    List<PromoBoardVo> selectSearchPromo(Map<String, Object> searchParam); // ⭐ 파라미터 변경: PageInfo를 Map에 포함

    /*
     * ⭐ 추가: 특정 프로모 게시글 상세 정보 조회 ⭐
     * @param promoNo 조회할 게시글 번호
     * @return 프로모 게시글 VO
     */
    PromoBoardVo selectPromoDetail(int promoNo);

    /*
     * ⭐ 추가: 프로모 게시글 조회수 증가 ⭐
     * @param promoNo 조회수를 증가시킬 게시글 번호
     * @return 처리된 행의 수 (보통 1)
     */
    int increasePromoViews(int promoNo);
}