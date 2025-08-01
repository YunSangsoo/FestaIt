package com.kh.festait.promoboard.model.service;

import java.util.List;
import com.kh.festait.common.model.vo.Image;
import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

public interface PromoBoardService {

    // 전체 게시글 수 조회
    int selectPromoCount();

    // 페이징된 게시글 목록 조회
    List<PromoBoardVo> selectPromoList(PageInfo pi);

    // 검색된 게시글 수 조회
    int selectSearchPromoCount(String searchKeyword);

    // 검색된 게시글 목록 조회
    List<PromoBoardVo> selectSearchPromo(String searchKeyword, PageInfo pi);

    // 게시글 등록 (포스터 이미지 포함)
    int insertPromo(PromoBoardVo promo, Image posterImage);

    // 게시글 상세 조회
    PromoBoardVo selectPromoDetail(int promoId);

    // 조회수 증가
    int increasePromoViews(int promoId);

    // 게시글 수정 (포스터 변경 및 삭제 옵션 포함)
    int updatePromo(PromoBoardVo promo, Image posterImage);

    // 게시글 삭제 (이미지 포함 삭제)
    int deletePromo(int promoId, String boardCode);

    // 작성자 userNo 조회 (권한 확인용)
    Integer selectWriterUserNoByPromoId(int promoId);

    // 사용자 이벤트 신청 내역 조회
    List<PromoBoardVo> selectUserEventApplications(int userNo);
}
