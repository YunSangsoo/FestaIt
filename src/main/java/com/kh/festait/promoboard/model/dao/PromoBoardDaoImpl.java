package com.kh.festait.promoboard.model.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.mybatis.spring.SqlSessionTemplate;

import com.kh.festait.promoboard.model.vo.PromoBoardVo;

/*
 * 프로모 관련 DAO 구현체
 * PromoBoardDAO 인터페이스를 구현하여 MyBatis를 통해 DB에 접근
 */
@Repository("promoBoardDAO") // 빈 이름은 "promoBoard" 대신 "promoBoardDAO"와 같이 명확하게 지정하는 것이 좋습니다.
public class PromoBoardDaoImpl implements PromoBoardDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    /*
     * 전체 프로모 게시글 수 조회
     */
    @Override
    public int selectPromoCount() {
        return sqlSession.selectOne("promoBoard.selectPromoCount");
    }

    /*
     * 페이징 처리된 프로모 목록 조회
     * 매퍼에서 OFFSET/LIMIT를 파라미터 맵의 "pi" 객체에서 가져오므로, Map으로 PageInfo가 포함된 파라미터를 그대로 넘깁니다.
     */
    @Override
    public List<PromoBoardVo> selectPromoList(Map<String, Object> paramMap) {
        return sqlSession.selectList("promoBoard.selectPromoList", paramMap);
    }

    /*
     * 검색 조건에 따른 프로모 게시글 수 조회
     */
    @Override
    public int selectSearchPromoCount(Map<String, Object> searchParam) {
        return sqlSession.selectOne("promoBoard.selectSearchPromoCount", searchParam);
    }

    /*
     * 검색 조건 및 페이징 처리된 프로모 목록 조회
     * 매퍼에서 OFFSET/LIMIT를 파라미터 맵의 "pi" 객체에서 가져오므로, Map으로 PageInfo가 포함된 파라미터를 그대로 넘깁니다.
     */
    @Override
    public List<PromoBoardVo> selectSearchPromo(Map<String, Object> searchParam) {
        return sqlSession.selectList("promoBoard.selectSearchPromo", searchParam);
    }

    /*
     * 특정 프로모 게시글 상세 정보 조회
     * @param promoId 조회할 프로모션 ID
     */
    @Override
    public PromoBoardVo selectPromoDetail(int promoId) {
        return sqlSession.selectOne("promoBoard.selectPromoDetail", promoId);
    }

    /*
     * 프로모 게시글 조회수 증가
     * @param promoId 조회수를 증가시킬 프로모션 ID
     */
    @Override
    public int increasePromoViews(int promoId) {
        return sqlSession.update("promoBoard.increasePromoViews", promoId);
    }

    /*
     * ⭐️ 추가: 홍보 게시글 등록 구현
     */
    @Override
    public int insertPromo(PromoBoardVo promo) {
        return sqlSession.insert("promoBoard.insertPromo", promo);
    }

    /*
     * ⭐️ 추가: 홍보 게시글 수정 구현
     */
    @Override
    public int updatePromo(PromoBoardVo promo) {
        return sqlSession.update("promoBoard.updatePromo", promo);
    }

    /*
     * ⭐️ 추가: 홍보 게시글 삭제 구현
     */
    @Override
    public int deletePromo(Map<String, Object> params) {
        return sqlSession.delete("promoBoard.deletePromo", params);
    }
}
