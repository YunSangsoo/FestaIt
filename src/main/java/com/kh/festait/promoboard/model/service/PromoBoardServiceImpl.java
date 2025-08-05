package com.kh.festait.promoboard.model.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j; // SLF4J 로거 사용

import com.kh.festait.common.model.vo.Image;
import com.kh.festait.common.model.dao.ImageDao;
import com.kh.festait.promoboard.model.dao.PromoBoardDao;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;
import com.kh.festait.common.Pagination;
import com.kh.festait.common.model.vo.PageInfo;

import java.util.List;
import java.util.Map;


@Service
@RequiredArgsConstructor
@Slf4j 
public class PromoBoardServiceImpl implements PromoBoardService {

    private final PromoBoardDao promoDao;
    private final ImageDao imageDao;

    @Override
    public int selectPromoCount() {
        return promoDao.selectPromoCount();
    }

    @Override
    public List<PromoBoardVo> selectPromoList(PageInfo pi) {
        return promoDao.selectPromoList(pi);
    }

    @Override
    public PromoBoardVo selectPromoDetail(int promoId) {
        return promoDao.selectPromoDetail(promoId);
    }

    @Override
    public int increasePromoViews(int promoId) {
        return promoDao.increasePromoViews(promoId);
    }

    @Override
    @Transactional
    public int insertPromo(PromoBoardVo promo, Image posterImage) {
        int result = promoDao.insertPromo(promo);
        if (result > 0 && posterImage != null) {
            posterImage.setRefNo(promo.getPromoId());
            result = imageDao.insertImage(posterImage);
            if (result == 0) {
                log.error("Service: 새로운 이미지 DB 삽입 실패 (promoId: {})", promo.getPromoId()); 
                throw new RuntimeException("새로운 이미지 DB 삽입 실패");
            }
        }
        return result;
    }

    @Override
    @Transactional
    public int updatePromo(PromoBoardVo promo, Image newOrExistingPosterImage) {
        // EVENT_PROMOTION 테이블 게시글 업데이트
        int promoUpdateResult = promoDao.updatePromo(promo);

        if (promoUpdateResult == 0) {
            log.error("Service: 게시글 DB 정보 업데이트 실패 (promoId: {})", promo.getPromoId());
            throw new RuntimeException("게시글 업데이트 실패: promoId=" + promo.getPromoId());
        }

        // EVENT_APPLICATION 테이블 URL 업데이트 추가
        int urlUpdateResult = promoDao.updateEventApplicationWebsite(promo);

        if (urlUpdateResult == 0) {
            log.error("Service: 이벤트 URL 업데이트 실패 (appId: {})", promo.getAppId());
            throw new RuntimeException("이벤트 URL 업데이트 실패: appId=" + promo.getAppId());
        }

        // 이미지 처리 기존 코드 유지
        if (newOrExistingPosterImage != null) {
            int deleteCount = imageDao.deleteImageByRefNoAndType(promo.getPromoId(), newOrExistingPosterImage.getImgType());
            if (deleteCount > 0) {
                log.debug("Service: 기존 이미지 DB에서 " + deleteCount + "개 삭제 완료 (refNo: " + promo.getPromoId() + ", type: " + newOrExistingPosterImage.getImgType() + ")");
            } else {
                log.debug("Service: 기존 이미지 DB에서 삭제할 항목이 없거나 이미 삭제됨 (refNo: " + promo.getPromoId() + ", type: " + newOrExistingPosterImage.getImgType() + ")");
            }

            if (newOrExistingPosterImage.getImgNo() != -1) {
                log.debug("Service: DB에 새로운 이미지 삽입 (refNo: " + promo.getPromoId() + ")");
                newOrExistingPosterImage.setRefNo(promo.getPromoId());
                int insertResult = imageDao.insertImage(newOrExistingPosterImage);
                if (insertResult == 0) {
                    log.error("Service: 새로운 이미지 DB 삽입 실패 (refNo: {})", promo.getPromoId());
                    throw new RuntimeException("새로운 이미지 DB 삽입 실패");
                }
            }
        }

        return promoUpdateResult;
    }

    @Override
    @Transactional
    public int deletePromo(int promoId, String boardCode) {
        int result = 0;

        int imageDeleteResult = imageDao.deleteImageByRefNoAndType(promoId, boardCode);
        if (imageDeleteResult > 0) {
            log.debug("Service: 이미지 DB 정보 삭제 성공 (refNo: " + promoId + ", type: " + boardCode + ")"); 
        } else {
            log.warn("Service: 이미지 DB 정보 삭제 실패 또는 연결된 이미지가 없었습니다 (refNo: " + promoId + ", type: " + boardCode + ")"); 
        }

        result = promoDao.deletePromo(promoId);
        if (result == 0) {
            log.error("Service: 게시글 DB 정보 삭제 실패 (promoId: {})", promoId); 
            throw new RuntimeException("게시글 삭제 실패: promoId=" + promoId);
        }
        log.debug("Service: 게시글 DB 정보 삭제 성공 (promoId: " + promoId + ")"); 

        return result;
    }

    @Override
    public int selectSearchPromoCount(String searchKeyword) {
        return promoDao.selectSearchPromoCount(searchKeyword);
    }

    @Override
    public List<PromoBoardVo> selectSearchPromo(String searchKeyword, PageInfo pi) {
        return promoDao.selectSearchPromo(searchKeyword, pi);
    }

    @Override
    public List<PromoBoardVo> selectUserEventApplications(int userNo) {
        return promoDao.selectUserEventApplications(userNo);
    }

    @Override
    public Integer selectWriterUserNoByPromoId(int promoId) {
        return promoDao.selectWriterUserNoByPromoId(promoId);
    }
}