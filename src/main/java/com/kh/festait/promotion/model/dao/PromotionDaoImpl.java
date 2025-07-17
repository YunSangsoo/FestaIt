package com.kh.festait.promotion.model.dao; // 이 패키지 경로가 정확한지 다시 한번 확인해주세요.

import java.util.List;
import java.util.Map; // selectPromotionList나 searchPromotions 메서드의 Map 파라미터를 위해 필요

import org.apache.ibatis.session.RowBounds; // 페이징 처리를 위한 RowBounds 임포트
import org.mybatis.spring.SqlSessionTemplate; // MyBatis의 SqlSessionTemplate 임포트
import org.springframework.beans.factory.annotation.Autowired; // 의존성 주입을 위한 Autowired 임포트
import org.springframework.stereotype.Repository; // 스프링 빈으로 등록하기 위한 Repository 어노테이션 임포트

import com.kh.festait.promotion.model.vo.PromotionVO; // PromotionVO의 실제 경로에 맞게 수정
import com.kh.festait.common.model.vo.PageInfo; // PageInfo 클래스 임포트 (DAO 메서드 파라미터로 PageInfo를 받는다면)

// 이 클래스는 DAO 구현체이며, 'PromotionDAO' 인터페이스를 구현해야 합니다.
@Repository("promotionDAO") // 스프링 빈으로 등록하기 위한 어노테이션입니다. 빈 이름은 소문자로 시작하는 게 일반적입니다.
public class PromotionDaoImpl implements PromotionDAO { // PromotionService가 아닌 PromotionDAO를 구현해야 합니다.

    @Autowired // SqlSessionTemplate을 주입받아 MyBatis 쿼리를 실행합니다.
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public int selectPromotionCount() {
        // promotionDAO.selectPromotionCount 쿼리를 실행하여 전체 프로모션 수를 반환합니다.
        return sqlSessionTemplate.selectOne("promotionDAO.selectPromotionCount");
    }

    @Override
    // PromotionDAO 인터페이스의 selectPromotionList 메서드 시그니처와 일치해야 합니다.
    // PageInfo와 Map을 파라미터로 받으며, List<PromotionVO>를 반환합니다.
    public List<PromotionVO> selectPromotionList(PageInfo pi, Map<String, Object> paramMap) {
        // PageInfo 객체에서 페이징에 필요한 offset과 limit 값을 추출합니다.
        int offset = pi.getBoardLimit() * (pi.getCurrentPage() - 1);
        int limit = pi.getBoardLimit();

        // MyBatis 쿼리에 offset과 limit을 적용하기 위해 RowBounds 객체를 사용합니다.
        // sqlSessionTemplate.selectList()의 세 번째 파라미터로 RowBounds를 전달합니다.
        // 두 번째 파라미터는 SQL에 전달할 데이터인데, 여기서는 PageInfo와 Map을 통해 이미 offset/limit을 처리하고 있으므로 null을 전달합니다.
        return sqlSessionTemplate.selectList("promotionDAO.selectPromotionList", null, new RowBounds(offset, limit));
    }

    @Override
    public int selectSearchedPromotionCount(Map<String, Object> searchParams) {
        // 검색 조건에 맞는 프로모션 게시글의 총 개수를 조회합니다.
        return sqlSessionTemplate.selectOne("promotionDAO.selectSearchedPromotionCount", searchParams);
    }

    @Override
    public List<PromotionVO> selectSearchedPromotions(Map<String, Object> searchParams, PageInfo pi) {
        // 검색 조건과 페이징 정보를 사용하여 프로모션 게시글 목록을 조회합니다.
        int offset = pi.getBoardLimit() * (pi.getCurrentPage() - 1);
        int limit = pi.getBoardLimit();
        return sqlSessionTemplate.selectList("promotionDAO.selectSearchedPromotions", searchParams, new RowBounds(offset, limit));
    }

    // PromotionDAO 인터페이스에 선언된 다른 DAO 메서드들도 여기에 구현해야 합니다.
}