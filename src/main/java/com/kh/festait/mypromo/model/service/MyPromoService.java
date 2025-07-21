package com.kh.festait.mypromo.model.service; 

import java.util.List;
import java.util.Map;

import com.kh.festait.mypromo.model.vo.MyPromoVo; // 'Vo'로 클래스 이름 변경

public interface MyPromoService {

    // 내 홍보 게시글 목록 조회 (페이징 적용)
    List<MyPromoVo> selectMyPromoList(Map<String, Object> params);

    // 특정 사용자의 전체 홍보 게시글 수 조회
    int selectListCount(int userNo);

}
