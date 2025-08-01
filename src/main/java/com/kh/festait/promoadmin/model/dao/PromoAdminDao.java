package com.kh.festait.promoadmin.model.dao;

import java.util.List;
import java.util.Map; // Map 임포트 추가

import org.apache.ibatis.annotations.Mapper;
// import org.apache.ibatis.session.RowBounds; // RowBounds는 DAOImpl에서 사용하므로 인터페이스에서는 필요 없음

import com.kh.festait.promoadmin.model.vo.PromoAdminVo;


@Mapper
public interface PromoAdminDao {

	// 검색어에 따른 전체 홍보 게시글 수 조회
	// 변경 전: int getTotalPromoPostsCount(String keyword);
	int getTotalPromoPostsCount(Map<String, Object> paramMap); // ⭐ Map으로 변경 ⭐

	// 검색어 및 페이징 조건에 따른 홍보 게시글 목록 조회
	List<PromoAdminVo> selectPromoPostsList(Map<String, Object> paramMap);

	// 특정 홍보 게시글 삭제 (int 반환으로 변경, 성공/실패 여부 확인 위함)
	int deletePromoPost(int promoId);

	// 특정 홍보 게시글 상세 조회
	PromoAdminVo selectPromoDetail(int promoId);

}