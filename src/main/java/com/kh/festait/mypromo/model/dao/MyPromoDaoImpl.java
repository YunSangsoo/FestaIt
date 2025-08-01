package com.kh.festait.mypromo.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.mypromo.model.vo.MyPromoVo;

@Repository("myPromoDao")
public class MyPromoDaoImpl implements MyPromoDao {

    @Autowired
    private SqlSessionTemplate sqlSession;


    // 전체 홍보 게시글 수 조회
    @Override
    public int selectListCount(Map<String, Object> paramMap) {
        return sqlSession.selectOne("mypromoMapper.selectListCount", paramMap);
    }

    // 로그인 사용자의 홍보 게시글 목록 조회 (페이징 포함)
    @Override
    public List<MyPromoVo> selectMyPromoList(Map<String, Object> paramMap, RowBounds rowBounds) {
        return sqlSession.selectList("mypromoMapper.selectMyPromoList", paramMap, rowBounds);
    }
}
