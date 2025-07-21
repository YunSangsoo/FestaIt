package com.kh.festait.mypromo.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.festait.mypromo.model.vo.MyPromoVo;

// MyPromoDao를 인터페이스로 선언
public interface MyPromoDao {

    /**
     * 내 홍보 게시글 목록을 페이징하여 조회합니다.
     * @param params userNo, offset, limit 정보를 담은 Map
     * @return 조회된 MyPromoVo 리스트
     */
    List<MyPromoVo> selectMyPromoList(Map<String, Object> params);

    /**
     * 특정 사용자의 전체 홍보 게시글 수를 조회합니다.
     * @param userNo 사용자 번호
     * @return 게시글 총 개수
     */
    int selectListCount(int userNo);

    // ⭐️ 홍보 게시글 상세 조회 메소드 제거됨.
    //    이제 내 홍보 리스트에서 게시글 클릭 시 바로 홍보 수정 페이지로 이동합니다.
    // MyPromoVo selectMyPromoById(int promoId);

    // ⭐️ 홍보 게시글 작성, 수정, 삭제, 조회수 증가 메소드들은 PromoBoardDao로 이관되었으므로 제거합니다.
    // int insertMyPromo(MyPromoVo promo);
    // int increaseViews(int promoNo);
    // int updateMyPromo(MyPromoVo promo);
    // int deleteMyPromo(Map<String, Object> params);
}
