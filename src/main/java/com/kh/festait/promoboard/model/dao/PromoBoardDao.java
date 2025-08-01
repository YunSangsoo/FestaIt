package com.kh.festait.promoboard.model.dao;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate; // 이 import는 필요 없을 수도 있음
import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

public interface PromoBoardDao {
    int selectPromoCount(); // SqlSessionTemplate 파라미터 제거
    List<PromoBoardVo> selectPromoList(PageInfo pi); // SqlSessionTemplate 파라미터 제거
    int selectSearchPromoCount(String searchKeyword); // SqlSessionTemplate 파라미터 제거
    List<PromoBoardVo> selectSearchPromo(String searchKeyword, PageInfo pi); // SqlSessionTemplate 파라미터 제거

    int insertPromo(PromoBoardVo promo); // SqlSessionTemplate 파라미터 제거
    PromoBoardVo selectPromoDetail(int promoId); // SqlSessionTemplate 파라미터 제거
    int increasePromoViews(int promoId); // SqlSessionTemplate 파라미터 제거
    Integer selectWriterUserNoByPromoId(int promoId); // SqlSessionTemplate 파라미터 제거
    List<PromoBoardVo> selectUserEventApplications(int userNo); // SqlSessionTemplate 파라미터 제거
    int updatePromo(PromoBoardVo promo); // SqlSessionTemplate 파라미터 제거
    int deletePromo(int promoId); // SqlSessionTemplate 파라미터 제거
}