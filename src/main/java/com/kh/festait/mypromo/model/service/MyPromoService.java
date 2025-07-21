package com.kh.festait.mypromo.model.service; // 패키지 이름 'service'로 변경

import java.util.List;
import java.util.Map;

import com.kh.festait.mypromo.model.vo.MyPromoVo; // 'Vo'로 클래스 이름 변경

public interface MyPromoService { // 클래스 이름 'MyPromoService'로 변경

    // 내 홍보 게시글 목록 조회 (페이징 적용)
    List<MyPromoVo> selectMyPromoList(Map<String, Object> params); // 메서드 이름 변경

    // 특정 사용자의 전체 홍보 게시글 수 조회
    int selectListCount(int userNo); // 메서드 이름 변경

    // ⭐️ 홍보 게시글 상세 조회 메소드 제거됨.
    //    이제 내 홍보 리스트에서 게시글 클릭 시 바로 홍보 수정 페이지로 이동합니다.
    // MyPromoVo selectMyPromoById(int promoId);

    // ⭐️ 새 홍보 게시글 삽입 메소드 제거 (PromoBoardService로 이관)
    // int insertMyPromo(MyPromoVo promo);

    // ⭐️ 홍보 게시글 수정 메소드 제거 (PromoBoardService로 이관)
    // int updateMyPromo(MyPromoVo promo);

    // ⭐️ 홍보 게시글 삭제 메소드 제거 (PromoBoardService로 이관)
    // int deleteMyPromo(Map<String, Object> params);
}
