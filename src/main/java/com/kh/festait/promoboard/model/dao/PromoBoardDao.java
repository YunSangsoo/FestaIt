package com.kh.festait.promoboard.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

public interface PromoBoardDao {

    int selectPromoCount();
    List<PromoBoardVo> selectPromoList(PageInfo pi, Map<String, Object> paramMap);
    int selectSearchPromoCount(Map<String, Object> paramMap);
    List<PromoBoardVo> selectSearchPromo(Map<String, Object> paramMap, PageInfo pi);
    PromoBoardVo selectPromoDetail(int promoId);
    int increasePromoViews(int promoId);
    int insertPromo(PromoBoardVo promo);
    int insertImage(PromoBoardVo promo);
    int insertPromImage(PromoBoardVo promo);
    int updateEventApplicationWebsite(PromoBoardVo promo);
    int updatePromo(PromoBoardVo promo);
    int updateImage(PromoBoardVo promo);
    int deletePromImageByPromoId(int promoId);
    int deleteImageByImgNo(int imgNo);
    int deletePromo(int promoId);
    
    PromoBoardVo selectEventIdAndAppIdByEventTitle(String eventTitle);
}
