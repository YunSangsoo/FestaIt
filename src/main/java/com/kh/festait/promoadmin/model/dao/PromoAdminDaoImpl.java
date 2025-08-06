package com.kh.festait.promoadmin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds; // RowBounds 임포트 추가
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.promoadmin.model.vo.PromoAdminVo;

import lombok.extern.slf4j.Slf4j; // Slf4j 임포트 추가

@Repository
@Slf4j
public class PromoAdminDaoImpl implements PromoAdminDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

    private static final String MAPPER_NAMESPACE = "promoAdminMapper";


	 // 전체 프로모션 게시글 개수
	@Override
	public int getTotalPromoPostsCount(Map<String, Object> paramMap) { 
		return sqlSession.selectOne(MAPPER_NAMESPACE + ".getTotalPromoPostsCount", paramMap); 
	}

	 // 프로모션 게시글 목록 페이지별
	@Override
	public List<PromoAdminVo> selectPromoPostsList(Map<String, Object> paramMap) {
        int offset = (int) paramMap.get("offset");
        int limit = (int) paramMap.get("limit");
        RowBounds rowBounds = new RowBounds(offset, limit);
		return sqlSession.selectList(MAPPER_NAMESPACE + ".selectPromoPostsList", paramMap, rowBounds);
	}

	 // 특정 프로모션 게시글 삭제 처리
	@Override
	public int deletePromoPost(int promoId) {
		return sqlSession.delete(MAPPER_NAMESPACE + ".deletePromoPost", promoId);
	}

	 // 특정 프로모션 게시글의 자세한 정보
	@Override
	public PromoAdminVo selectPromoDetail(int promoId) {
		return sqlSession.selectOne(MAPPER_NAMESPACE + ".selectPromoDetail", promoId);
	}

}