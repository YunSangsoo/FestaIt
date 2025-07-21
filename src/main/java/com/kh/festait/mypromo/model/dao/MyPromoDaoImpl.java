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

    // ⭐️ 홍보 게시글 상세 조회 메소드 제거됨.
    //    이제 내 홍보 리스트에서 게시글 클릭 시 바로 홍보 수정 페이지로 이동합니다.
    // @Override
    // public MyPromoVo selectMyPromoById(int promoId) {
    //     return sqlSession.selectOne("myPromoMapper.selectMyPromoById", promoId);
    // }

    // ⭐️ 홍보 게시글 작성, 수정, 삭제, 조회수 증가 메소드들은 PromoBoardDao로 이관되었으므로 제거합니다.
    // @Override
    // public int insertMyPromo(MyPromoVo promo) {
    //     return sqlSession.insert("myPromoMapper.insertMyPromo", promo);
    // }

    // @Override
    // public int increaseViews(int promoNo) {
    //     return sqlSession.update("myPromoMapper.increaseViews", promoNo);
    // }

    // @Override
    // public int updateMyPromo(MyPromoVo promo) {
    //     return sqlSession.update("myPromoMapper.updateMyPromo", promo);
    // }

    // @Override
    // public int deleteMyPromo(Map<String, Object> params) {
    //     return sqlSession.update("myPromoMapper.deleteMyPromo", params);
    // }
}
