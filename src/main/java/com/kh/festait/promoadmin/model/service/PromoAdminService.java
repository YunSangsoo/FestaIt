package com.kh.festait.promoadmin.model.service;

import java.util.List;
import java.util.Map; // Map 임포트 추가

import com.kh.festait.promoadmin.model.vo.PromoAdminVo;

public interface PromoAdminService {

	// 검색어에 따른 전체 홍보 게시글 수 조회
	int getTotalPromoPostsCount(Map<String, Object> paramMap);

	// 검색어 및 페이징 조건에 따른 홍보 게시글 목록 조회
	List<PromoAdminVo> selectPromoPostsList(Map<String, Object> paramMap);

	// 특정 홍보 게시글 삭제
	void deletePromoPost(int promoId);

	// 특정 홍보 게시글 상세 조회
	PromoAdminVo selectPromoDetail(int promoId);
}