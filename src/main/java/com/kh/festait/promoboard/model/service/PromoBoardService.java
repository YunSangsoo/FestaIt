package com.kh.festait.promoboard.model.service;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

import java.util.List;
import java.util.Map;

// 홍보 게시글 서비스 인터페이스
public interface PromoBoardService {

    // 전체 홍보 게시글의 페이지 정보 반환.
    PageInfo getPromoPageInfo(int currentPage);

    // 전체 홍보 게시글 목록 조회.
    List<PromoBoardVo> getPromoList(PageInfo pi, Map<String, Object> paramMap);

    // 검색된 프로모 게시글의 페이지 정보 반환.
    PageInfo getSearchPromoPageInfo(int currentPage, Map<String, Object> searchParam);

    // 검색 조건에 맞는 프로모 게시글 목록 조회.
    List<PromoBoardVo> searchPromo(Map<String, Object> searchParam, PageInfo pi);

    // 홍보 게시글 상세 조회.
    // promoId: 조회할 프로모션 ID.
    PromoBoardVo selectPromotionDetail(int promoId);

    // 조회수 증가.
    // promoId: 조회수를 증가시킬 프로모션 ID.
    int increasePromoViews(int promoId);

    // 홍보 게시글 등록.
    // promo: 등록할 홍보 게시글 정보.
    int insertPromo(PromoBoardVo promo);

    // 홍보 게시글 수정.
    // promo: 수정할 홍보 게시글 정보.
    int updatePromo(PromoBoardVo promo);

    // 홍보 게시글 삭제.
    // params: 삭제할 홍보 게시글 ID를 담은 Map (promoId 키 사용).
    int deletePromo(Map<String, Object> params);
}
