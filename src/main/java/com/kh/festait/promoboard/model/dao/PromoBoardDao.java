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
    int insertImage(PromoBoardVo promo); // 이 메서드를 사용하세요.
    // int insertPromImage(PromoBoardVo promo); // ★★★ 이 줄은 이미 없어야 함 (확인) ★★★
    int updateEventApplicationWebsite(PromoBoardVo promo);
    int updatePromo(PromoBoardVo promo);
    int updateImage(PromoBoardVo promo);
    // int deletePromImageByPromoId(int promoId); // ★★★ 이 줄을 삭제하세요 ★★★
    int deleteImageByPromoId(int promoId); // ★★★ 이 줄을 추가하세요 ★★★
    int deleteImageByImgNo(int imgNo);
    int deletePromo(int promoId);
    
    PromoBoardVo selectEventIdAndAppIdByEventTitle(String eventTitle);
}