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
    List<PromoBoardVo> selectPromoList(Map<String, Object> paramMap);

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
    List<PromoBoardVo> selectSearchPromo(Map<String, Object> searchParam);

    /*
     * 특정 프로모 게시글 상세 정보 조회
     * @param promoId 조회할 게시글 번호
     * @return 프로모 게시글 VO
     */
    PromoBoardVo selectPromoDetail(int promoId); // ⭐️ promoNo -> promoId로 변경

    /*
     * 프로모 게시글 조회수 증가
     * @param promoId 조회수를 증가시킬 게시글 번호
     * @return 처리된 행의 수 (보통 1)
     */
    int increasePromoViews(int promoId); // ⭐️ promoNo -> promoId로 변경

    /*
     * ⭐️ 추가: 홍보 게시글 등록
     * @param promo 등록할 홍보 게시글 정보
     * @return 처리된 행의 수
     */
    int insertPromo(PromoBoardVo promo); // ⭐️ MyPromoController에서 이동된 기능

    /*
     * ⭐️ 추가: 홍보 게시글 수정
     * @param promo 수정할 홍보 게시글 정보
     * @return 처리된 행의 수
     */
    int updatePromo(PromoBoardVo promo); // ⭐️ MyPromoController에서 이동된 기능

    /*
     * ⭐️ 추가: 홍보 게시글 삭제
     * @param params 삭제할 홍보 게시글 ID를 담은 Map (promoId 키 사용)
     * @return 처리된 행의 수
     */
    int deletePromo(Map<String, Object> params); // ⭐️ MyPromoController에서 이동된 기능
}
