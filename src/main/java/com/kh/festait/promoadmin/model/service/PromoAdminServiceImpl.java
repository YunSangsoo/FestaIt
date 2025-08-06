package com.kh.festait.promoadmin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.festait.promoadmin.model.dao.PromoAdminDao;
import com.kh.festait.promoadmin.model.vo.PromoAdminVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PromoAdminServiceImpl implements PromoAdminService {

    private final PromoAdminDao promoAdminDao;

    @Override
    public int getTotalPromoPostsCount(Map<String, Object> paramMap) {
        return promoAdminDao.getTotalPromoPostsCount(paramMap);
    }

    @Override
    public List<PromoAdminVo> selectPromoPostsList(Map<String, Object> paramMap) {
        return promoAdminDao.selectPromoPostsList(paramMap);
    }

    @Override
    @Transactional
    public void deletePromoPost(int promoId) {
        int result = promoAdminDao.deletePromoPost(promoId);
        if (result == 0) {
            throw new RuntimeException("홍보 게시글 삭제에 실패했습니다. promoId: " + promoId);
        }
    }

    @Override
    public PromoAdminVo selectPromoDetail(int promoId) {
        return promoAdminDao.selectPromoDetail(promoId);
    }
}