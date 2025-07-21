package com.kh.festait.promoboard.model.dao;

import com.kh.festait.promoboard.model.vo.PromoBoardVo;

import java.util.List;
import java.util.Map;

// 홍보 게시글 데이터 접근 인터페이스
public interface PromoBoardDao {

    // 전체 홍보 게시글 수 조회.
    int selectPromoCount();

    // 페이징 정보와 조건에 따라 게시글 목록 조회.
    // paramMap: PageInfo 객체 포함.
    List<PromoBoardVo> selectPromoList(Map<String, Object> paramMap);

    // 검색 조건에 맞는 게시글 수 조회.
    // searchParam: 검색 조건.
    int selectSearchPromoCount(Map<String, Object> searchParam);

    // 검색 조건과 페이징 정보에 따라 게시글 목록 조회.
    // searchParam: 검색 조건 (PageInfo 객체 포함).
    List<PromoBoardVo> selectSearchPromo(Map<String, Object> searchParam);

    // 특정 프로모 게시글 상세 정보 조회.
    // promoId: 조회할 게시글 번호.
    PromoBoardVo selectPromoDetail(int promoId);

    // 프로모 게시글 조회수 증가.
    // promoId: 조회수를 증가시킬 게시글 번호.
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
