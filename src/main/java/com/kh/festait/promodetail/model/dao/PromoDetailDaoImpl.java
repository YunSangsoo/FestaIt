package com.kh.festait.promodetail.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.promodetail.model.vo.PromoDetailVo;

@Repository("promoDetailDAO") // 스프링 빈 이름 지정
public class PromoDetailDaoImpl implements PromoDetailDao {

    @Autowired // SqlSession 의존성 주입
    private SqlSession sqlSession;

    @Override
    public PromoDetailVo selectPromoDetail(int promoNo) {
        // "promoDetail" 네임스페이스의 "selectPromoDetail" ID를 가진 쿼리 실행
        return sqlSession.selectOne("promoDetail.selectPromoDetail", promoNo);
    }

    @Override
    public int increasePromoView(int promoNo) {
        // "promoDetail" 네임스페이스의 "increasePromoViews" ID를 가진 쿼리 실행
        return sqlSession.update("promoDetail.increasePromoView", promoNo);
    }
}