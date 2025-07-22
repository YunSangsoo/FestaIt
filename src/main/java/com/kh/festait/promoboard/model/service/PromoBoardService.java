package com.kh.festait.promoboard.model.service;

import java.util.List;
import java.util.Map;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

public interface PromoBoardService {

    // 게시글 목록 조회 (페이징)
    PageInfo getPromoPageInfo(int currentPage);
    List<PromoBoardVo> getPromoList(PageInfo pi, Map<String, Object> paramMap);

    // 검색된 게시글 수 조회
    PageInfo getSearchPromoPageInfo(int currentPage, Map<String, Object> paramMap);
    List<PromoBoardVo> searchPromo(Map<String, Object> paramMap, PageInfo pi);

    // 게시글 상세 조회
    PromoBoardVo selectPromotionDetail(int promoId);

    // 조회수 증가
    int increasePromoViews(int promoId);

    // ⭐ 새로 추가: 홍보 게시글 작성 (이미지 및 URL 처리 포함) ⭐
    int insertPromoWithImageAndUrl(PromoBoardVo promo);

    // ⭐ 새로 추가: 홍보 게시글 수정 (이미지 및 URL 처리 포함) ⭐
    int updatePromoWithImageAndUrl(PromoBoardVo promo);

    // ⭐ 새로 추가: 홍보 게시글 삭제 (이미지 및 URL 처리 포함) ⭐
    int deletePromoWithImageAndUrl(int promoId, int imgNoToDelete); // 이미지 번호 함께 전달
}
