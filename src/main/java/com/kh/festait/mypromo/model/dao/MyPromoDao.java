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

    /**
     * 새 홍보 게시글을 삽입합니다.
     * @param promo 삽입할 MyPromoVo 객체
     * @return 처리된 행의 개수
     */
    int insertMyPromo(MyPromoVo promo);

    /**
     * 특정 홍보 게시글을 ID로 상세 조회합니다.
     * @param promoNo 홍보 게시글 번호
     * @return 조회된 MyPromoVo 객체
     */
    MyPromoVo selectMyPromoById(int promoNo);

    /**
     * 특정 홍보 게시글의 조회수를 증가시킵니다.
     * @param promoNo 홍보 게시글 번호
     * @return 처리된 행의 개수
     */
    int increaseViews(int promoNo);

    /**
     * 홍보 게시글을 수정합니다.
     * @param promo 수정할 MyPromoVo 객체
     * @return 처리된 행의 개수
     */
    int updateMyPromo(MyPromoVo promo);

    /**
     * 홍보 게시글의 상태를 'N'으로 변경하여 삭제 처리합니다.
     * @param params promoNo, userNo 정보를 담은 Map
     * @return 처리된 행의 개수
     */
    int deleteMyPromo(Map<String, Object> params);
}