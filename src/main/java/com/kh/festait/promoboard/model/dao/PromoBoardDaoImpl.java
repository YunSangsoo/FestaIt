package com.kh.festait.promoboard.model.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.mybatis.spring.SqlSessionTemplate;

import com.kh.festait.promoboard.model.vo.PromoBoardVo;

// 프로모 게시글 DAO 구현체 (MyBatis를 통해 DB 접근)
@Repository("promoBoardDAO") // Spring Bean으로 등록 (빈 이름: promoBoardDAO)
public class PromoBoardDaoImpl implements PromoBoardDao {

    @Autowired // SqlSessionTemplate 의존성 자동 주입
    private SqlSessionTemplate sqlSession;

    @Override
    public int selectPromoCount() {
        // 전체 프로모 게시글 수 조회
        return sqlSession.selectOne("promoBoard.selectPromoCount");
    }

    @Override
    public List<PromoBoardVo> selectPromoList(Map<String, Object> paramMap) {
        // 페이징 처리된 프로모 목록 조회
        // paramMap에는 PageInfo 객체가 포함되어 OFFSET/LIMIT를 매퍼에서 사용.
        return sqlSession.selectList("promoBoard.selectPromoList", paramMap);
    }

    @Override
    public int selectSearchPromoCount(Map<String, Object> searchParam) {
        // 검색 조건에 따른 프로모 게시글 수 조회
        return sqlSession.selectOne("promoBoard.selectSearchPromoCount", searchParam);
    }

    @Override
    public List<PromoBoardVo> selectSearchPromo(Map<String, Object> searchParam) {
        // 검색 조건 및 페이징 처리된 프로모 목록 조회
        // searchParam에는 PageInfo 객체가 포함되어 OFFSET/LIMIT를 매퍼에서 사용.
        return sqlSession.selectList("promoBoard.selectSearchPromo", searchParam);
    }

    @Override
    public PromoBoardVo selectPromoDetail(int promoId) {
        // 특정 프로모 게시글 상세 정보 조회
        return sqlSession.selectOne("promoBoard.selectPromoDetail", promoId);
    }

    @Override
    public int increasePromoViews(int promoId) {
        // 프로모 게시글 조회수 증가
        return sqlSession.update("promoBoard.increasePromoViews", promoId);
    }

    @Override
    public int insertPromo(PromoBoardVo promo) {
        // 홍보 게시글 등록
        // ⭐ 이 부분에서 SQLSessionTemplate의 insert 메서드가 호출됩니다. ⭐
        // ⭐ 매퍼의 namespace.id("promoBoard.insertPromo")와 파라미터(promo)가 정확한지 확인해야 합니다. ⭐
        return sqlSession.insert("promoBoard.insertPromo", promo);
    }

    @Override
    public int updatePromo(PromoBoardVo promo) {
        // 홍보 게시글 수정
        return sqlSession.update("promoBoard.updatePromo", promo);
    }

    @Override
    public int deletePromo(Map<String, Object> params) {
        // 홍보 게시글 삭제
        return sqlSession.delete("promoBoard.deletePromo", params);
    }
}
