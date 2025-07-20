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
     * ⭐ 추가: 홍보 게시글 상세 조회 ⭐
     */
    PromoBoardVo selectPromotionDetail(int promoNo);

    /*
     * ⭐ 추가: 조회수 증가 ⭐
     */
    int increasePromoViews(int promoNo);
}