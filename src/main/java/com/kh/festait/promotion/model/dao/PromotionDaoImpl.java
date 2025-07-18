package com.kh.festait.promotion.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.promotion.model.vo.PromotionVO;
import com.kh.festait.common.model.vo.PageInfo;

/**
 * 프로모션 관련 DAO 구현체
 * <p>
 * PromotionDAO 인터페이스를 구현하여 MyBatis를 통해 DB에 접근합니다.
 */
@Repository("promotionDAO")
public class PromotionDaoImpl implements PromotionDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 전체 프로모션 게시글 수 조회
     */
    @Override
    public int selectPromotionCount() {
        return sqlSessionTemplate.selectOne("promotionDAO.selectPromotionCount");
    }

    /**
     * 페이징 처리된 프로모션 목록 조회
     *
     * @param pi       페이징 정보
     * @param paramMap 검색 조건 등 (현재 구현에서는 사용되지 않음)
     * @return 프로모션 게시글 목록
     */
    @Override
    public List<PromotionVO> selectPromotionList(PageInfo pi, Map<String, Object> paramMap) {
        int offset = pi.getBoardLimit() * (pi.getCurrentPage() - 1);
        int limit = pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, limit);

        return sqlSessionTemplate.selectList("promotionDAO.selectPromotionList", null, rowBounds);
    }

    /**
     * 검색 조건에 따른 프로모션 게시글 수 조회
     *
     * @param searchParams 검색 조건
     * @return 검색된 게시글 수
     */
    @Override
    public int selectSearchedPromotionCount(Map<String, Object> searchParams) {
        return sqlSessionTemplate.selectOne("promotionDAO.selectSearchedPromotionCount", searchParams);
    }

    /**
     * 검색 조건 및 페이징 처리된 프로모션 목록 조회
     *
     * @param searchParams 검색 조건
     * @param pi           페이징 정보
     * @return 검색된 프로모션 게시글 목록
     */
    @Override
    public List<PromotionVO> selectSearchedPromotions(Map<String, Object> searchParams, PageInfo pi) {
        int offset = pi.getBoardLimit() * (pi.getCurrentPage() - 1);
        int limit = pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, limit);

        return sqlSessionTemplate.selectList("promotionDAO.selectSearchedPromotions", searchParams, rowBounds);
    }

}
