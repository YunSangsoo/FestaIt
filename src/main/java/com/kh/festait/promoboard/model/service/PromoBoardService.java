package com.kh.festait.promoboard.model.service;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

import java.util.List;
import java.util.Map;

public interface PromoBoardService {

    /*
     * 전체 프로모 게시글의 페이지 정보 반환
     */
    PageInfo getPromoPageInfo(int currentPage);

    /*
     * 전체 프로모 게시글 목록 조회
     */
    List<PromoBoardVo> getPromoList(PageInfo pi, Map<String, Object> paramMap);

    /*
     * 검색된 프로모 게시글의 페이지 정보 반환
     */
    PageInfo getSearchPromoPageInfo(int currentPage, Map<String, Object> searchParam);

    /*
     * 검색 조건에 맞는 프로모 게시글 목록 조회
     */
    List<PromoBoardVo> searchPromo(Map<String, Object> searchParam, PageInfo pi);

    /*
     * 홍보 게시글 상세 조회
     * @param promoId 조회할 프로모션 ID
     */
    PromoBoardVo selectPromotionDetail(int promoId);

    /*
     * 조회수 증가
     * @param promoId 조회수를 증가시킬 프로모션 ID
     */
    int increasePromoViews(int promoId);

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
