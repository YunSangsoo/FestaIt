package com.kh.festait.promoboard.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // 트랜잭션 처리를 위해 import

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.dao.PromoBoardDao; // DAO 인터페이스 import
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PromoBoardServiceImpl implements PromoBoardService {

    private final PromoBoardDao promoBoardDao; // PromoBoardDao 인터페이스 의존성 주입

    @Override
    public PageInfo getPromoPageInfo(int currentPage) {
        int listCount = promoBoardDao.selectPromoCount();
        log.info("총 게시글 수 (listCount): {}", listCount);
        return new PageInfo(listCount, currentPage, 10, 12); // boardLimit 12 유지
    }

    @Override
    public List<PromoBoardVo> getPromoList(PageInfo pi, Map<String, Object> paramMap) {
        paramMap.put("pi", pi);
        log.info("getPromoList 호출 - PageInfo: currentPage={}, offset={}, limit={}",
                 new Object[]{pi.getCurrentPage(), pi.getOffset(), pi.getLimit()});
        return promoBoardDao.selectPromoList(pi, paramMap);
    }

    @Override
    public PageInfo getSearchPromoPageInfo(int currentPage, Map<String, Object> paramMap) {
        int listCount = promoBoardDao.selectSearchPromoCount(paramMap);
        log.info("검색된 총 게시글 수 (listCount): {}", listCount);
        return new PageInfo(listCount, currentPage, 10, 12); // boardLimit 12 유지
    }

    @Override
    public List<PromoBoardVo> searchPromo(Map<String, Object> paramMap, PageInfo pi) {
        paramMap.put("pi", pi);
        log.info("searchPromo 호출 - PageInfo: currentPage={}, offset={}, limit={}",
                 new Object[]{pi.getCurrentPage(), pi.getOffset(), pi.getLimit()});
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

    // 홍보 게시글 작성 (이미지 및 URL 처리 포함)
    @Override
    @Transactional
    public int insertPromoWithImageAndUrl(PromoBoardVo promo) {
        int result = 0;

        PromoBoardVo eventInfo = promoBoardDao.selectEventIdAndAppIdByEventTitle("서울 밤도깨비 야시장");
        if (eventInfo != null) {
            promo.setEventId(eventInfo.getEventId());
            promo.setAppId(eventInfo.getAppId());
            log.info("이벤트 정보 설정됨 - EventId: {}, AppId: {}", promo.getEventId(), promo.getAppId());
        } else {
            log.error("유효한 이벤트 정보를 찾을 수 없습니다. 홍보 게시글 작성을 중단합니다.");
            return 0;
        }

        // 1. EVENT_PROMOTION 테이블에 게시글 정보 삽입 (내용 포함)
        log.info("EVENT_PROMOTION 삽입 전 promo 객체 - promoId: {}, promoTitle: {}, promoDetail: {}",
                 new Object[]{promo.getPromoId(), promo.getPromoTitle(), promo.getPromoDetail()});
        result = promoBoardDao.insertPromo(promo);
        log.info("EVENT_PROMOTION 삽입 후 promo 객체 (PROM_ID 확인) - promoId: {}, promoTitle: {}, promoDetail: {}",
                 new Object[]{promo.getPromoId(), promo.getPromoTitle(), promo.getPromoDetail()});


        // 2. 이미지 정보 삽입 (IMAGE, PROM_IMAGE 테이블)
        if (result > 0 && promo.getPosterPath() != null && !promo.getPosterPath().isEmpty()) {
            log.info("이미지 삽입 시작 - posterPath: {}, originalFilename: {}", promo.getPosterPath(), promo.getOriginalFilename());

            // IMAGE 테이블에 이미지 정보 삽입 (imgNo가 promo 객체에 채워짐)
            log.info("IMAGE 삽입 전 promo 객체 (imgNo는 0일 것) - posterPath: {}, originalFilename: {}, imgNo: {}",
                     new Object[]{promo.getPosterPath(), promo.getOriginalFilename(), promo.getImgNo()});
            int imageResult = promoBoardDao.insertImage(promo); // IMAGE 테이블에 삽입
            log.info("IMAGE 삽입 후 promo 객체 (imgNo 확인): {}", promo);

            if (imageResult > 0) {
                // PROM_IMAGE 테이블에 PROM_ID와 IMG_NO 연결 정보 삽입
                log.info("PROM_IMAGE 삽입 전 promo 객체 (promImgNo는 0일 것) - promoId: {}, imgNo: {}, promImgNo: {}",
                         new Object[]{promo.getPromoId(), promo.getImgNo(), promo.getPromImgNo()});
                int promImageResult = promoBoardDao.insertPromImage(promo); // PROM_IMAGE 테이블에 삽입
                log.info("PROM_IMAGE 삽입 후 promo 객체 (promImgNo 확인): {}", promo);

                if (promImageResult == 0) {
                    log.error("PROM_IMAGE 삽입 실패 (promImageResult: {})", promImageResult);
                    throw new RuntimeException("PROM_IMAGE 삽입 실패");
                }
            } else {
                log.error("IMAGE 삽입 실패 (imageResult: {})", imageResult);
                throw new RuntimeException("IMAGE 삽입 실패");
            }
        } else {
            log.info("포스터 이미지가 없거나 경로가 비어있으므로 이미지 관련 DB 작업 건너뜀. posterPath: {}", promo.getPosterPath());
        }


        // 3. PROMOTION_PAGE_URL 정보 업데이트 (EVENT_APPLICATION 테이블)
        if (promo.getPromotionPageUrl() != null && !promo.getPromotionPageUrl().isEmpty()) {
            if (promo.getAppId() > 0) {
                 int urlResult = promoBoardDao.updateEventApplicationWebsite(promo);
                 if (urlResult > 0) {
                     log.info("EVENT_APPLICATION URL 업데이트 성공: APP_ID {}, URL {}", promo.getAppId(), promo.getPromotionPageUrl());
                 } else {
                     log.warn("EVENT_APPLICATION URL 업데이트 실패: APP_ID {}", promo.getAppId());
                 }
            } else {
                log.warn("PROMOTION_PAGE_URL을 저장하려면 유효한 APP_ID가 필요합니다. 현재 APP_ID: {}", promo.getAppId());
            }
        } else {
            log.info("프로모션 페이지 URL이 없으므로 EVENT_APPLICATION URL 업데이트 건너뜀.");
        }

        return result;
    }

    // 홍보 게시글 수정 (이미지 및 URL 처리 포함)
    @Override
    @Transactional
    public int updatePromoWithImageAndUrl(PromoBoardVo promo) {
        int result = 0;

        // 1. EVENT_PROMOTION 테이블의 기본 정보 업데이트 (내용 포함)
        log.info("EVENT_PROMOTION 업데이트 전 promo 객체 - promoId: {}, promoTitle: {}, promoDetail: {}, posterPath: {}, originalFilename: {}",
                 new Object[]{promo.getPromoId(), promo.getPromoTitle(), promo.getPromoDetail(), promo.getPosterPath(), promo.getOriginalFilename()});
        result = promoBoardDao.updatePromo(promo);
        log.info("EVENT_PROMOTION 업데이트 결과: {}", result);

        // 2. 이미지 정보 업데이트 (PROM_IMAGE, IMAGE 테이블)
        if (result > 0) {
            // 기존 이미지 정보 조회 (IMG_NO와 posterPath를 얻기 위해)
            PromoBoardVo existingPromo = promoBoardDao.selectPromoDetail(promo.getPromoId());
            int existingImgNo = existingPromo != null ? existingPromo.getImgNo() : 0;
            String existingPosterPath = existingPromo != null ? existingPromo.getPosterPath() : null;
            log.info("기존 이미지 정보 조회 - existingImgNo: {}, existingPosterPath: {}", existingImgNo, existingPosterPath);

            // 새 파일이 업로드되었거나 기존 이미지를 삭제하는 경우
            if ((promo.getPosterPath() != null && !promo.getPosterPath().equals(existingPosterPath)) ||
                (promo.getPosterPath() == null && existingPosterPath != null && !existingPosterPath.isEmpty())) {

                log.info("이미지 변경 감지. 새 posterPath: {}, 기존 posterPath: {}", promo.getPosterPath(), existingPosterPath);

                // 기존 이미지 관련 DB 레코드 삭제 (PROM_IMAGE, IMAGE)
                if (existingImgNo > 0) {
                    log.info("기존 이미지 삭제 시작 - promoId: {}, imgNo: {}", promo.getPromoId(), existingImgNo);
                    int deletePromImageResult = promoBoardDao.deletePromImageByPromoId(promo.getPromoId());
                    if (deletePromImageResult > 0) {
                        log.info("PROM_IMAGE 연결 삭제 성공 (update): {}", promo.getPromoId());
                        int deleteImageResult = promoBoardDao.deleteImageByImgNo(existingImgNo);
                        if (deleteImageResult > 0) {
                            log.info("기존 IMAGE 레코드 삭제 성공 (imgNo: {})", existingImgNo);
                        } else {
                            log.warn("기존 IMAGE 레코드 삭제 실패 (imgNo: {})", existingImgNo);
                        }
                    } else {
                        log.warn("PROM_IMAGE 연결 삭제 실패 (update): {}", promo.getPromoId());
                    }
                } else {
                    log.info("기존 이미지 정보가 없으므로 삭제 건너뜀 (IMG_NO: {})", existingImgNo);
                }

                // 새 이미지가 있다면 삽입
                if (promo.getPosterPath() != null && !promo.getPosterPath().isEmpty()) {
                    log.info("새 이미지 삽입 시작 - posterPath: {}, originalFilename: {}", promo.getPosterPath(), promo.getOriginalFilename());
                    log.info("IMAGE 삽입 전 (수정) promo 객체 (imgNo는 0일 것): {}", promo);
                    int insertImageResult = promoBoardDao.insertImage(promo);
                    log.info("IMAGE 삽입 후 (수정) promo 객체 (imgNo 확인): {}", promo);

                    if (insertImageResult > 0) {
                        log.info("PROM_IMAGE 삽입 전 (수정) promo 객체 (promImgNo는 0일 것): {}", promo);
                        int insertPromImageResult = promoBoardDao.insertPromImage(promo);
                        log.info("PROM_IMAGE 삽입 후 (수정) promo 객체 (promImgNo 확인): {}", promo);
                        if (insertPromImageResult == 0) {
                            log.error("PROM_IMAGE 삽입 실패 (수정)");
                            throw new RuntimeException("PROM_IMAGE 삽입 실패 (수정)");
                        }
                    } else {
                        log.error("IMAGE 삽입 실패 (수정)");
                        throw new RuntimeException("IMAGE 삽입 실패 (수정)");
                    }
                } else {
                    log.info("새 포스터 이미지가 없으므로 이미지 삽입 건너뜀 (수정).");
                }
            } else {
                log.info("이미지 변경 없음. 기존 이미지 유지.");
            }
        }

        // 3. PROMOTION_PAGE_URL 정보 업데이트 (EVENT_APPLICATION 테이블)
        if (promo.getPromotionPageUrl() != null) {
            if (promo.getAppId() > 0) {
                int urlResult = promoBoardDao.updateEventApplicationWebsite(promo);
                if (urlResult > 0) {
                    log.info("EVENT_APPLICATION URL 업데이트 성공 (수정): APP_ID {}, URL {}", promo.getAppId(), promo.getPromotionPageUrl());
                } else {
                    log.warn("EVENT_APPLICATION URL 업데이트 실패 (수정): APP_ID {}", promo.getAppId());
                }
            } else {
                log.warn("PROMOTION_PAGE_URL을 업데이트하려면 유효한 APP_ID가 필요합니다. 현재 APP_ID: {}", promo.getAppId());
            }
        } else {
            log.info("프로모션 페이지 URL이 없으므로 EVENT_APPLICATION URL 업데이트 건너뜀 (수정).");
        }

        return result;
    }

    // 홍보 게시글 삭제 (이미지 및 URL 처리 포함)
    @Override
    @Transactional
    public int deletePromoWithImageAndUrl(int promoId, int imgNoToDelete) {
        int result = 0;

        // 1. PROM_IMAGE 테이블에서 연결 정보 삭제
        log.info("PROM_IMAGE 연결 정보 삭제 시도: promoId {}", promoId);
        int deletePromImageResult = promoBoardDao.deletePromImageByPromoId(promoId);
        if (deletePromImageResult > 0) {
            log.info("PROM_IMAGE 연결 정보 삭제 성공: {}", promoId);
        } else {
            log.warn("PROM_IMAGE 연결 정보 삭제 실패 또는 연결 없음: {}", promoId);
        }

        // 2. IMAGE 테이블에서 이미지 레코드 삭제 (imgNoToDelete를 사용하여)
        if (imgNoToDelete > 0) {
            log.info("IMAGE 레코드 삭제 시도: imgNo {}", imgNoToDelete);
            int deleteImageResult = promoBoardDao.deleteImageByImgNo(imgNoToDelete);
            if (deleteImageResult > 0) {
                log.info("IMAGE 레코드 삭제 성공: {}", imgNoToDelete);
            } else {
                log.warn("IMAGE 레코드 삭제 실패: {}", imgNoToDelete);
            }
        } else {
            log.info("삭제할 이미지 번호가 없으므로 IMAGE 레코드 삭제 건너뜀.");
        }

        // 3. EVENT_PROMOTION 테이블에서 게시글 하드 삭제 (STATUS 컬럼 없으므로)
        log.info("EVENT_PROMOTION 게시글 삭제 시도: promoId {}", promoId);
        result = promoBoardDao.deletePromo(promoId);
        log.info("EVENT_PROMOTION 게시글 삭제 결과: {}", result);

        return result;
    }
}
