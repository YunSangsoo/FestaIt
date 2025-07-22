package com.kh.festait.mypromo.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.festait.mypromo.model.vo.MyPromoVo;

import lombok.RequiredArgsConstructor;

// MyPromoDao 인터페이스의 구현체
@Repository // Spring Bean으로 등록
@RequiredArgsConstructor // final 필드에 대한 생성자 자동 생성 (SqlSessionTemplate 주입)
public class MyPromoDaoImpl implements MyPromoDao { // MyPromoDao 인터페이스 구현

    private final SqlSessionTemplate sqlSession; // MyBatis SqlSessionTemplate 주입

    @Override
    public int selectListCount(Map<String, Object> paramMap) {
        // myPromoMapper 네임스페이스의 selectListCount 쿼리 실행
        return sqlSession.selectOne("myPromoMapper.selectListCount", paramMap);
    }

    @Override
    public List<MyPromoVo> selectMyPromoList(Map<String, Object> paramMap, RowBounds rowBounds) {
        // myPromoMapper 네임스페이스의 selectMyPromoList 쿼리 실행 (RowBounds 적용)
        return sqlSession.selectList("myPromoMapper.selectMyPromoList", paramMap, rowBounds);
    }

}
