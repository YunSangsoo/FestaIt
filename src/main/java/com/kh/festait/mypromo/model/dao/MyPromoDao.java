package com.kh.festait.mypromo.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.festait.mypromo.model.vo.MyPromoVo;

public interface MyPromoDao {

    /*
     * 내 홍보 게시글 목록을 페이징하여 조회합니다.
     * @param params userNo, offset, limit 정보를 담은 Map
     * @return 조회된 MyPromoVo 리스트
     */
    List<MyPromoVo> selectMyPromoList(Map<String, Object> params);

    /*
     * 특정 사용자의 전체 홍보 게시글 수를 조회합니다.
     * @param userNo 사용자 번호
     * @return 게시글 총 개수
     */
    int selectListCount(int userNo);

}
