package com.kh.festait.promoboard.model.dao;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate; // 이 import는 필요 없을 수도 있음
import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

public interface PromoBoardDao {
    int selectPromoCount();
    List<PromoBoardVo> selectPromoList(PageInfo pi); 
    int selectSearchPromoCount(String searchKeyword);
    List<PromoBoardVo> selectSearchPromo(String searchKeyword, PageInfo pi);

    int insertPromo(PromoBoardVo promo);
    PromoBoardVo selectPromoDetail(int promoId);
    int increasePromoViews(int promoId);
    Integer selectWriterUserNoByPromoId(int promoId); 
    List<PromoBoardVo> selectUserEventApplications(int userNo);
    int updatePromo(PromoBoardVo promo); 
    int updateEventApplicationWebsite(PromoBoardVo promo);
    int deletePromo(int promoId); 
}