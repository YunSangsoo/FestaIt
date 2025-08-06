package com.kh.festait.promoboard.model.dao;

import java.util.List;
import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

public interface PromoBoardDao {
    int selectPromoCount();
    List<PromoBoardVo> selectPromoList(PageInfo pi); 
    int selectSearchPromoCount(String searchKeyword);
    List<PromoBoardVo> selectSearchPromo(String searchKeyword, PageInfo pi);

    int insertPromo(PromoBoardVo promo);
    PromoBoardVo selectPromoDetail(int promoId);
    
    // 추가: 비활성 포함 상세 조회
    PromoBoardVo selectPromoDetailIncludingInactive(int promoId);
    
    int increasePromoViews(int promoId);
    Integer selectWriterUserNoByPromoId(int promoId); 
    List<PromoBoardVo> selectUserEventApplications(int userNo);
    int updatePromo(PromoBoardVo promo); 
    int updateEventApplicationWebsite(PromoBoardVo promo);
    int deletePromo(int promoId); 
}
