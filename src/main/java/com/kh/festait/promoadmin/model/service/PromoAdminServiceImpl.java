package com.kh.festait.promoadmin.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

// RowBounds는 Service 구현체에서는 직접 사용하지 않으므로 제거합니다.
// import org.apache.ibatis.session.RowBounds; 
import org.springframework.beans.factory.annotation.Autowired;
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
    // ⭐ 시그니처 변경: String keyword -> Map<String, Object> paramMap ⭐
    public int getTotalPromoPostsCount(Map<String, Object> paramMap) {
        log.info("Service: getTotalPromoPostsCount 호출 - paramMap: {}", paramMap);
        return promoAdminDao.getTotalPromoPostsCount(paramMap);
    }

    @Override
    // ⭐ 시그니처 변경: String keyword, int startRow, int endRow -> Map<String, Object> paramMap ⭐
    public List<PromoAdminVo> selectPromoPostsList(Map<String, Object> paramMap) {
        log.info("Service: selectPromoPostsList 호출 - paramMap: {}", paramMap);
        // Controller에서 이미 paramMap에 keyword, startRow, endRow (또는 offset, limit)를 담아 전달하므로,
        // 여기서는 별도의 paramMap 생성 없이 그대로 DAO로 전달합니다.
        return promoAdminDao.selectPromoPostsList(paramMap);
    }

    @Override
    @Transactional
    public void deletePromoPost(int promoId) {
        log.info("Service: 홍보 게시글 삭제 서비스 요청 - promoId: {}", promoId);
        int result = promoAdminDao.deletePromoPost(promoId);
        if (result == 0) {
            throw new RuntimeException("홍보 게시글 삭제에 실패했습니다. promoId: " + promoId);
        }
    }

    @Override
    public PromoAdminVo selectPromoDetail(int promoId) {
        log.info("Service: selectPromoDetail 호출 - promoId: {}", promoId);
        return promoAdminDao.selectPromoDetail(promoId);
    }
}