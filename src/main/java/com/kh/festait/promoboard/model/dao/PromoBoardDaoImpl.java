package com.kh.festait.promoboard.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession; // RowBounds가 더 이상 사용되지 않으므로 제거 가능하지만, 다른 곳에서 사용될 가능성을 열어둡니다.
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.common.model.vo.PageInfo; // 사용되지 않으므로 제거 가능하지만, 설명 상으로 남겨둘 수 있습니다.
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

/*
 * 프로모 관련 DAO 구현체
 * PromoBoardDAO 인터페이스를 구현하여 MyBatis를 통해 DB에 접근
 */
@Repository("promoBoardDAO") // 빈 이름은 "promoBoard" 대신 "promoBoardDAO"와 같이 명확하게 지정하는 것이 좋습니다.
public class PromoBoardDaoImpl implements PromoBoardDao {

    @Autowired
    private SqlSession sqlSession;

    /*
     * 전체 프로모 게시글 수 조회
     */
    @Override
    public int selectPromoCount() {
        return sqlSession.selectOne("promoBoard.selectPromoCount");
    }

    /*
     * 페이징 처리된 프로모 목록 조회
     * 매퍼에서 OFFSET/LIMIT를 파라미터 맵의 "pi" 객체에서 가져오므로, RowBounds 사용 방식을 변경합니다.
     */
    @Override
    public List<PromoBoardVo> selectPromoList(Map<String, Object> paramMap) {
        // 매퍼에서 이미 #{pi.offset}과 #{pi.limit}을 사용하므로,
        // 여기서는 Map으로 PageInfo가 포함된 파라미터를 그대로 넘깁니다.
        // RowBounds를 사용하지 않는 방식으로 매퍼를 작성했기 때문에, 이 코드를 수정합니다.
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
     * 매퍼에서 OFFSET/LIMIT를 파라미터 맵의 "pi" 객체에서 가져오므로, RowBounds 사용 방식을 변경합니다.
     */
    @Override
    public List<PromoBoardVo> selectSearchPromo(Map<String, Object> searchParam) {
        // 매퍼에서 이미 #{pi.offset}과 #{pi.limit}을 사용하므로,
        // 여기서는 Map으로 PageInfo가 포함된 파라미터를 그대로 넘깁니다.
        // RowBounds를 사용하지 않는 방식으로 매퍼를 작성했기 때문에, 이 코드를 수정합니다.
        return sqlSession.selectList("promoBoard.selectSearchPromo", searchParam);
    }

    /*
     * 특정 프로모 게시글 상세 정보 조회
     */
    @Override
    public PromoBoardVo selectPromoDetail(int promoNo) {
        return sqlSession.selectOne("promoBoard.selectPromoDetail", promoNo);
    }

    /*
     * 프로모 게시글 조회수 증가
     */
    @Override
    public int increasePromoViews(int promoNo) {
        return sqlSession.update("promoBoard.increasePromoViews", promoNo);
    }
}