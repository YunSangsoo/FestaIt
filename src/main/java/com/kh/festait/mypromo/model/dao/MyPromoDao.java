package com.kh.festait.mypromo.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.kh.festait.mypromo.model.vo.MyPromoVo;

// MyPromoDao 인터페이스 정의
public interface MyPromoDao {

    // 내 홍보 게시글 전체 수 조회 (검색 조건 포함)
    int selectListCount(Map<String, Object> paramMap);

    // 내 홍보 게시글 목록 조회 (페이징 및 검색 조건 포함)
    List<MyPromoVo> selectMyPromoList(Map<String, Object> paramMap, RowBounds rowBounds);

}
