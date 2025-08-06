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


    @Override
    public int selectListCount(Map<String, Object> paramMap) {
        return sqlSession.selectOne("mypromoMapper.selectListCount", paramMap);
    }

    @Override
    public List<MyPromoVo> selectMyPromoList(Map<String, Object> paramMap, RowBounds rowBounds) {
        return sqlSession.selectList("mypromoMapper.selectMyPromoList", paramMap, rowBounds);
    }
}
