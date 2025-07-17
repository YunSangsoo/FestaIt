package com.kh.festait.promotion.model.service;

import com.kh.festait.promotion.model.vo.PromotionVO;
import com.kh.festait.common.model.vo.PageInfo;
import java.util.List;
import java.util.Map;

public interface PromotionService {
    PageInfo getPromotionPageInfo(int currentPage);
    List<PromotionVO> getPromotionList(PageInfo pi, Map<String, Object> paramMap);
    PageInfo getSearchedPromotionPageInfo(int currentPage, Map<String, Object> searchParams);
    List<PromotionVO> searchPromotions(Map<String, Object> searchParams, PageInfo pi);
}