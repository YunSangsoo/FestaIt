package com.kh.festait.promoboard.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

@Repository
public class PromoBoardDaoImpl implements PromoBoardDao {

    @Autowired
    private SqlSessionTemplate sqlSession; // SqlSessionTemplate을 DaoImpl에서 주입받음

    private static final String NAMESPACE = "promoBoardMapper"; // MyBatis 매퍼 네임스페이스

    @Override
    public int selectPromoCount() {
        return sqlSession.selectOne(NAMESPACE + ".selectPromoCount");
    }

    @Override
    public List<PromoBoardVo> selectPromoList(PageInfo pi) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return sqlSession.selectList(NAMESPACE + ".selectPromoList", null, rowBounds);
    }

    @Override
    public int selectSearchPromoCount(String searchKeyword) {
        return sqlSession.selectOne(NAMESPACE + ".selectSearchPromoCount", searchKeyword);
    }

    @Override
    public List<PromoBoardVo> selectSearchPromo(String searchKeyword, PageInfo pi) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return sqlSession.selectList(NAMESPACE + ".selectSearchPromo", searchKeyword, rowBounds);
    }

    @Override
    public int insertPromo(PromoBoardVo promo) {
        return sqlSession.insert(NAMESPACE + ".insertPromo", promo);
    }

    @Override
    public PromoBoardVo selectPromoDetail(int promoId) {
        return sqlSession.selectOne(NAMESPACE + ".selectPromoDetail", promoId);
    }

    @Override
    public int increasePromoViews(int promoId) {
        return sqlSession.update(NAMESPACE + ".increasePromoViews", promoId);
    }

    @Override
    public Integer selectWriterUserNoByPromoId(int promoId) {
        return sqlSession.selectOne(NAMESPACE + ".selectWriterUserNoByPromoId", promoId);
    }

    @Override
    public List<PromoBoardVo> selectUserEventApplications(int userNo) {
        return sqlSession.selectList(NAMESPACE + ".selectUserEventApplications", userNo);
    }

    @Override
    public int updatePromo(PromoBoardVo promo) {
        return sqlSession.update(NAMESPACE + ".updatePromo", promo);
    }

    @Override
    public int deletePromo(int promoId) {
        return sqlSession.delete(NAMESPACE + ".deletePromo", promoId);
    }
}