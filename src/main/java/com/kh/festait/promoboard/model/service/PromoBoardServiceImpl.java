package com.kh.festait.promoboard.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.dao.PromoBoardDao;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PromoBoardServiceImpl implements PromoBoardService {

    private final PromoBoardDao promoBoardDao;

    @Override
    public PageInfo getPromoPageInfo(int currentPage) {
        int listCount = promoBoardDao.selectPromoCount();
        log.info("총 게시글 수 (listCount): {}", listCount);
        return new PageInfo(listCount, currentPage, 10, 12);
    }

    @Override
    public List<PromoBoardVo> getPromoList(PageInfo pi, Map<String, Object> paramMap) {
        paramMap.put("pi", pi);
        log.info(String.format("getPromoList 호출 - current: %d, offset: %d, limit: %d",
                                pi.getCurrentPage(), pi.getOffset(), pi.getLimit()));
        return promoBoardDao.selectPromoList(pi, paramMap);
    }

    @Override
    public PageInfo getSearchPromoPageInfo(int currentPage, Map<String, Object> paramMap) {
        int listCount = promoBoardDao.selectSearchPromoCount(paramMap);
        log.info("검색된 총 게시글 수: {}", listCount);
        return new PageInfo(listCount, currentPage, 10, 12);
    }

    @Override
    public List<PromoBoardVo> searchPromo(Map<String, Object> paramMap, PageInfo pi) {
        paramMap.put("pi", pi);
        log.info(String.format("getPromoList 호출 - current: %d, offset: %d, limit: %d",
                                pi.getCurrentPage(), pi.getOffset(), pi.getLimit()));
        return promoBoardDao.selectSearchPromo(paramMap, pi);
    }

    @Override
    public PromoBoardVo selectPromotionDetail(int promoId) {
        return promoBoardDao.selectPromoDetail(promoId);
    }

    @Override
    public int increasePromoViews(int promoId) {
        return promoBoardDao.increasePromoViews(promoId);
    }

    @Override
    @Transactional
    public int insertPromoWithImageAndUrl(PromoBoardVo promo) {
        if (promo.getAppId() <= 0) { // appId가 0 또는 음수이면 유효하지 않다고 판단
            log.error("APP_ID가 유효하지 않습니다. 프로모션 게시글 작성을 중단합니다. 전달된 APP_ID: {}", promo.getAppId());
            return 0; // 0을 반환하여 트랜잭션 롤백을 유도할 수 있습니다.
        }
        log.info("사용될 APP_ID: {}", promo.getAppId());
        
        // 2. 프로모글 등록
        int result = promoBoardDao.insertPromo(promo);
        log.info("insertPromo 결과: {}", result);

        // 3. 이미지 처리
        if (result > 0 && promo.getPosterPath() != null && !promo.getPosterPath().isEmpty()) {
            int imgResult = promoBoardDao.insertImage(promo);
            log.info("insertImage 결과: {}, imgNo: {}", imgResult, promo.getImgNo());

            if (imgResult == 0) {
                throw new RuntimeException("IMAGE 삽입 실패");
            }
        }

        // 4. URL 업데이트
        if (promo.getPromotionPageUrl() != null && !promo.getPromotionPageUrl().isEmpty()) {
            int urlResult = promoBoardDao.updateEventApplicationWebsite(promo);
            log.info("updateEventApplicationWebsite 결과: {}", urlResult);
        }

        return result;
    }

    @Override
    @Transactional
    public int updatePromoWithImageAndUrl(PromoBoardVo promo) {
        // 1. 기본 정보 업데이트
        int result = promoBoardDao.updatePromo(promo);
        log.info("updatePromo 결과: {}", result);

        if (result > 0) {
            PromoBoardVo existing = promoBoardDao.selectPromoDetail(promo.getPromoId());
            int existingImgNo = existing != null ? (int) existing.getImgNo() : 0;
            String existingPath = existing != null ? existing.getPosterPath() : null;

            boolean replaceImage = (promo.getPosterPath() != null && !promo.getPosterPath().equals(existingPath));
            boolean deleteImage = (promo.getPosterPath() == null && existingPath != null && !existingPath.isEmpty());

            if (replaceImage || deleteImage) {
                // 기존 이미지가 있다면 삭제
                if (existingImgNo > 0) {
                    promoBoardDao.deleteImageByImgNo(existingImgNo); // 기존 이미지 한 개만 삭제
                }

                // 새로운 이미지가 있다면 삽입
                if (promo.getPosterPath() != null && !promo.getPosterPath().isEmpty()) {
                    int iRes = promoBoardDao.insertImage(promo);
                    log.info("update insertImage: {}, imgNo: {}", iRes, promo.getImgNo());
                }
            }
        }

        if (promo.getPromotionPageUrl() != null && promo.getAppId() > 0) {
            promoBoardDao.updateEventApplicationWebsite(promo);
        }

        return result;
    }

    @Override
    @Transactional
    // 매개변수에서 imgNoToDelete를 제거하고 promoId만 받도록 수정했습니다.
    public int deletePromoWithImageAndUrl(int promoId) { // ★★★ 이 줄을 수정했습니다 ★★★
        // promoId에 연결된 모든 프로모션 이미지 삭제
        promoBoardDao.deleteImageByPromoId(promoId); // ★★★ deleteImageByPromoId 호출 ★★★
        
        // 프로모션 게시글 삭제
        int result = promoBoardDao.deletePromo(promoId);
        log.info("deletePromo 결과: {}", result);
        return result;
    }
}