package com.kh.festait.mypromo.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate; // SqlSessionTemplate 사용
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.mypromo.model.vo.MyPromoVo;

@Repository("myPromoDao") // 이 구현체가 "myPromoDao"라는 이름의 스프링 빈으로 등록
public class MyPromoDaoImpl implements MyPromoDao { // MyPromoDao 인터페이스를 구현

    @Autowired
    private SqlSessionTemplate sqlSession; // SqlSessionTemplate 주입 (root-context.xml에서 설정된 sqlSession 빈)

    @Override
    public List<MyPromoVo> selectMyPromoList(Map<String, Object> params) {
        return sqlSession.selectList("myPromoMapper.selectMyPromoList", params);
    }

    @Override
    public int selectListCount(int userNo) {
        return sqlSession.selectOne("myPromoMapper.selectListCount", userNo);
    }
}
