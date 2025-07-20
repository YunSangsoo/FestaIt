package com.kh.festait.mypromo.model.service; // 패키지 이름 'service'로 변경

import java.util.List;
import java.util.Map;

import com.kh.festait.mypromo.model.vo.MyPromoVo; // 'Vo'로 클래스 이름 변경

public interface MyPromoService { // 클래스 이름 'MyPromoService'로 변경

    // 내 홍보 게시글 목록 조회 (페이징 적용)
    List<MyPromoVo> selectMyPromoList(Map<String, Object> params); // 메서드 이름 변경

    // 특정 사용자의 전체 홍보 게시글 수 조회
    int selectListCount(int userNo); // 메서드 이름 변경

    // 새 홍보 게시글 삽입
    int insertMyPromo(MyPromoVo promo);

    // 홍보 게시글 상세 조회 (조회수 증가 로직 포함)
    MyPromoVo selectMyPromoById(int promoNo);

    // 홍보 게시글 수정
    int updateMyPromo(MyPromoVo promo);

    // 홍보 게시글 삭제 (STATUS를 'N'으로 변경)
    int deleteMyPromo(Map<String, Object> params); // 파라미터 타입 변경
}