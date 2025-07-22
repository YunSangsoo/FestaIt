package com.kh.festait.promoboard.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor // final 필드를 사용하는 생성자를 자동으로 생성하여 의존성 주입
public class PromoBoardDaoImpl implements PromoBoardDao {

    private final SqlSessionTemplate sqlSession; // SqlSessionTemplate 의존성 주입

    @Override
    public int selectPromoCount() {
        return sqlSession.selectOne("promoBoard.selectPromoCount");
    }

    @Override
    public List<PromoBoardVo> selectPromoList(PageInfo pi, Map<String, Object> paramMap) {
        // paramMap에 PageInfo 객체가 "pi" 키로 이미 포함되어 있으므로, paramMap만 전달합니다.
        return sqlSession.selectList("promoBoard.selectPromoList", paramMap);
    }

    @Override
    public int selectSearchPromoCount(Map<String, Object> paramMap) {
        return sqlSession.selectOne("promoBoard.selectSearchPromoCount", paramMap);
    }

    @Override
    public List<PromoBoardVo> selectSearchPromo(Map<String, Object> paramMap, PageInfo pi) {
        // paramMap에 PageInfo 객체가 "pi" 키로 이미 포함되어 있으므로, paramMap만 전달합니다.
        return sqlSession.selectList("promoBoard.selectSearchPromo", paramMap);
    }

    @Override
    public PromoBoardVo selectPromoDetail(int promoId) {
        return sqlSession.selectOne("promoBoard.selectPromoDetail", promoId);
    }

    @Override
    public int increasePromoViews(int promoId) {
        return sqlSession.update("promoBoard.increasePromoViews", promoId);
    }

    @Override
    public int insertPromo(PromoBoardVo promo) {
        return sqlSession.insert("promoBoard.insertPromo", promo);
    }

    @Override
    public int insertImage(PromoBoardVo promo) {
        return sqlSession.insert("promoBoard.insertImage", promo);
    }

    @Override
    public int insertPromImage(PromoBoardVo promo) {
        return sqlSession.insert("promoBoard.insertPromImage", promo);
    }

    @Override
    public int updateEventApplicationWebsite(PromoBoardVo promo) {
        return sqlSession.update("promoBoard.updateEventApplicationWebsite", promo);
    }

    @Override
    public int updatePromo(PromoBoardVo promo) {
        return sqlSession.update("promoBoard.updatePromo", promo);
    }

    @Override
    public int updateImage(PromoBoardVo promo) {
        return sqlSession.update("promoBoard.updateImage", promo);
    }

    @Override
    public int deletePromImageByPromoId(int promoId) {
        return sqlSession.delete("promoBoard.deletePromImageByPromoId", promoId);
    }

    @Override
    public int deleteImageByImgNo(int imgNo) {
        return sqlSession.delete("promoBoard.deleteImageByImgNo", imgNo);
    }

    @Override
    public int deletePromo(int promoId) {
        return sqlSession.delete("promoBoard.deletePromo", promoId);
    }

    @Override
    public PromoBoardVo selectEventIdAndAppIdByEventTitle(String eventTitle) {
        return sqlSession.selectOne("promoBoard.selectEventIdAndAppIdByEventTitle", eventTitle);
    }
}
